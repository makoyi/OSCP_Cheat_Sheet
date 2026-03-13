#!/bin/bash

# IDOR Hunter - Automated Insecure Direct Object Reference Scanner
# Usage: ./idor_hunter.sh <base_url> <resource_type> [wordlist]
# Example: ./idor_hunter.sh "https://target.com/api/user/" "user" /usr/share/wordlists/dirb/common.txt

set -euo pipefail

BASE_URL="${1:?Missing base_url parameter}"
RESOURCE="${2:?Missing resource_type parameter (user,order,invoice,etc)}"
WORDLIST="${3:-/usr/share/wordlists/dirb/common.txt}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test IDs to check (sequential + common jumps)
TEST_IDS=(1 2 3 4 5 6 7 8 9 10 20 50 100 500 1000 9999)
ID_JUMP_TEST=(1 2 5 10 20 50 100 200 500 1000)

echo -e "${BLUE}IDOR Hunter Starting...${NC}"
echo -e "${YELLOW}Target: ${BASE_URL}${RESOURCE}/${NC}"
echo -e "${YELLOW}Testing sequential IDs + common jumps${NC}\n"

# Function to make request and check response
check_idor() {
    local id="$1"
    local endpoint="${BASE_URL}${RESOURCE}/${id}"
    
    echo -e "${BLUE}Testing ID: ${id} -> ${endpoint}${NC}"
    
    # Make request (use curl with timing to detect differences)
    response=$(curl -s -w "\n%{http_code}:%{time_total}" \
        -H "User-Agent: Mozilla/5.0 (IDOR-Hunter)" \
        -H "Accept: application/json, text/plain, */*" \
        --max-time 10 \
        "$endpoint" 2>/dev/null || echo "000:0")
    
    http_code=$(echo "$response" | tail -n1 | cut -d':' -f1)
    response_time=$(echo "$response" | tail -n1 | cut -d':' -f2)
    body=$(echo "$response" | sed '$d')
    
    # Potential IDOR indicators
    unauthorized_patterns=("unauthorized" "forbidden" "permission denied" "access denied")
    notfound_patterns=("not found" "404" "does not exist")
    
    # Check for successful responses or data leaks
    if [[ "$http_code" == "200" ]] || [[ "$http_code" == "302" ]]; then
        echo -e "${GREEN}[POTENTIAL IDOR] ${id} -> HTTP ${http_code} (${response_time}s)${NC}"
        
        # Check if response contains sensitive data patterns
        if echo "$body" | grep -qiE "(email|phone|address|ssn|credit|password|secret|token|key)"; then
            echo -e "${RED}[HIGH CONFIDENCE IDOR] Sensitive data leak in ID ${id}!${NC}"
        fi
        
        # Save response for manual review
        mkdir -p idor_responses
        echo "=== ID ${id} ===" > "idor_responses/id_${id}.txt"
        echo "$body" >> "idor_responses/id_${id}.txt"
        echo -e "${YELLOW}Response saved: idor_responses/id_${id}.txt${NC}"
        
        return 0
    fi
    
    # Check for inconsistent error responses (IDOR indicator)
    is_unauth=false
    for pattern in "${unauthorized_patterns[@]}"; do
        if echo "$body" | grep -qi "$pattern"; then
            is_unauth=true
            break
        fi
    done
    
    is_notfound=false
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
    check_idor "$id"
done

# Test ID jumps (common in paginated systems)
echo -e "\n${BLUE}=== Phase 2: ID Jump Testing ===${NC}"
for jump in "${ID_JUMP_TEST[@]}"; do
    check_idor "$jump"
done

# Parameter fuzzing - common IDOR vectors
echo -e "\n${BLUE}=== Phase 3: Parameter Fuzzing ===${NC}"
PARAM_VECTORS=(
    "${BASE_URL}?id="
    "${BASE_URL}/profile?id="
    "${BASE_URL}/view?id="
    "${BASE_URL}/edit?id="
    "${BASE_URL}?user_id="
    "${BASE_URL}?order_id="
    "${BASE_URL}?invoice_id="
)

for param_url in "${PARAM_VECTORS[@]}"; do
    if [[ "$param_url" == *"idor_hunter.sh"* ]]; then continue; fi
    echo -e "\n${YELLOW}Testing parameter: ${param_url}${NC}"
    check_idor "1" "$param_url"
done

# Directory/ID fuzzing if wordlist provided
if [[ -f "$WORDLIST" ]]; then
    echo -e "\n${BLUE}=== Phase 4: Directory/ID Fuzzing ===${NC}"
    while IFS= read -r id; do
        # Skip comments and empty lines
        [[ -z "$id" || "$id" =~ ^# ]] && continue
        
        # Test as both path and parameter
        check_idor "$id"
        check_idor "?id=$id"
    done < "$WORDLIST" | head -20  # Limit to first 20 for speed
fi

echo -e "\n${GREEN}=== IDOR Scan Complete ===${NC}"
echo -e "${YELLOW}Check 'idor_responses/' directory for saved responses${NC}"
echo -e "${BLUE}Manual verification recommended for all hits${NC}"
