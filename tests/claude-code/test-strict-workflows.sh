#!/usr/bin/env bash
# Test: strict workflow variants
# Verifies that the original heavy-review workflows remain available under -strict names
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: strict workflow variants ==="
echo ""

echo "Test 1: writing-plans is fast by default..."
output=$(run_claude "Does writing-plans require a 'write the failing test' and 'verify it fails' step for every task?" 30)
assert_contains "$output" "no\|not required\|fast\|task-oriented" "Default writing-plans is fast" || exit 1
echo ""

echo "Test 2: writing-plans-strict keeps TDD micro-steps..."
output=$(run_claude "In writing-plans-strict, what are the first few steps inside a task?" 30)
assert_contains "$output" "failing test\|verify it fails\|minimal implementation\|commit" "Strict planning keeps micro-steps" || exit 1
echo ""

echo "Test 3: executing-plans-strict is the heavier option..."
output=$(run_claude "What is the difference between executing-plans and executing-plans-strict?" 30)
assert_contains "$output" "fast\|task-level verification\|fast-by-default" "Mentions fast default" || exit 1
assert_contains "$output" "strict\|heavier\|original\|checkpoint\|review-heavy" "Mentions strict workflow" || exit 1
echo ""

echo "Test 4: subagent-driven-development-strict keeps review ordering..."
output=$(run_claude "In subagent-driven-development-strict, what comes first: spec compliance review or code quality review?" 30)
assert_order "$output" "spec.*compliance" "code.*quality" "Spec compliance before code quality" || exit 1
echo ""

echo "Test 5: strict review loops remain..."
output=$(run_claude "In subagent-driven-development-strict, what happens if a reviewer finds issues? Is it a one-time review or a loop?" 30)
assert_contains "$output" "loop\|again\|repeat\|until.*approved\|until.*compliant" "Strict workflow keeps review loops" || exit 1
assert_contains "$output" "implementer.*fix\|fix.*issues" "Implementer fixes issues" || exit 1
echo ""

echo "Test 6: strict mode still syncs plan checkboxes..."
output=$(run_claude "In subagent-driven-development-strict and executing-plans-strict, after each completed task should the executed plan file checkboxes be updated automatically?" 30)
assert_contains "$output" "yes\|must\|required\|checkbox\|plan file\|plan path\|\\[x\\]" "Strict workflows mention required checkbox sync" || exit 1
echo ""

echo "=== All strict workflow tests passed ==="
