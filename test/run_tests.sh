#!/bin/bash
# Integration tests for lint-install
# This script verifies that each linter catches intentional issues in test files

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Running lint-install integration tests..."
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

test_count=0
pass_count=0
fail_count=0

# Helper function to run a test
run_test() {
    local linter_name=$1
    local command=$2
    local expected_failure=$3  # "should_fail" or "should_pass"

    test_count=$((test_count + 1))
    echo -n "Testing ${linter_name}... "

    if eval "$command" > /dev/null 2>&1; then
        # Command succeeded
        if [ "$expected_failure" = "should_fail" ]; then
            echo -e "${RED}FAIL${NC} (expected to catch issues but passed)"
            fail_count=$((fail_count + 1))
            return 1
        else
            echo -e "${GREEN}PASS${NC}"
            pass_count=$((pass_count + 1))
            return 0
        fi
    else
        # Command failed
        if [ "$expected_failure" = "should_fail" ]; then
            echo -e "${GREEN}PASS${NC} (correctly caught issues)"
            pass_count=$((pass_count + 1))
            return 0
        else
            echo -e "${RED}FAIL${NC} (unexpected failure)"
            fail_count=$((fail_count + 1))
            return 1
        fi
    fi
}

# Build the lint-install binary if needed
cd "$ROOT_DIR"
if [ ! -f "./lint-install" ]; then
    echo "Building lint-install..."
    go build -o lint-install .
    echo ""
fi

# Test 1: Shellcheck should catch issues in test.sh
run_test "shellcheck" "make shellcheck-lint" "should_fail"

# Test 2: Hadolint should catch issues in test.Dockerfile
run_test "hadolint" "make hadolint-lint" "should_fail"

# Test 3: Biome should catch issues in test.js
run_test "biome" "make biome-lint" "should_fail"

# Test 4: Yamllint should catch issues in test.yaml
run_test "yamllint" "make yamllint-lint" "should_fail"

# Test 5: Golangci-lint should catch issues in test/test_main.go
run_test "golangci-lint" "cd test && make golangci-lint-lint" "should_fail"

echo ""
echo "=========================================="
echo "Test Results:"
echo -e "  ${GREEN}Passed: ${pass_count}${NC}"
echo -e "  ${RED}Failed: ${fail_count}${NC}"
echo -e "  Total:  ${test_count}"
echo ""

if [ $fail_count -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
