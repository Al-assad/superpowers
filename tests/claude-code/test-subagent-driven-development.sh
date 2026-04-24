#!/usr/bin/env bash
# Test: subagent-driven-development skill
# Verifies the default fast-by-default workflow behavior
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: subagent-driven-development skill ==="
echo ""

echo "Test 1: Skill loading..."
output=$(run_claude "What is the subagent-driven-development skill? Describe its key steps briefly." 30)
assert_contains "$output" "subagent-driven-development\|Subagent-Driven Development\|Subagent Driven" "Skill is recognized" || exit 1
assert_contains "$output" "read.*plan\|extract.*tasks\|load.*plan" "Mentions loading the plan" || exit 1
echo ""

echo "Test 2: Fast workflow defaults..."
output=$(run_claude "In subagent-driven-development, does every task automatically get both spec compliance review and code quality review?" 30)
assert_contains "$output" "no\|not every\|conditional\|only when\|risk" "Reviews are conditional" || exit 1
echo ""

echo "Test 3: Self-review requirement..."
output=$(run_claude "Does the subagent-driven-development skill require implementers to do self-review? What should they check?" 30)
assert_contains "$output" "self-review\|self review" "Mentions self-review" || exit 1
assert_contains "$output" "Completeness\|Quality\|Testing\|scope\|Discipline" "Describes self-review checks" || exit 1
echo ""

echo "Test 4: Reviewer escalation triggers..."
output=$(run_claude "When should subagent-driven-development escalate to a reviewer instead of accepting an implementer result directly?" 30)
assert_contains "$output" "DONE_WITH_CONCERNS\|public interface\|compatibility\|scope\|risk\|unstable" "Mentions escalation triggers" || exit 1
assert_contains "$output" "spec reviewer\|code quality reviewer" "Mentions reviewer choice" || exit 1
echo ""

echo "Test 5: Plan reading efficiency..."
output=$(run_claude "In subagent-driven-development, how many times should the controller read the plan file? When does this happen?" 30)
assert_contains "$output" "once\|one time\|single" "Read plan once" || exit 1
assert_contains "$output" "start\|beginning\|Step 1\|load plan" "Read at beginning" || exit 1
echo ""

echo "Test 6: Task context provision..."
output=$(run_claude "In subagent-driven-development, how does the controller provide task information to the implementer subagent? Does it make them read a file or provide it directly?" 30)
assert_contains "$output" "provide.*directly\|full.*text\|paste\|include.*prompt" "Provides text directly" || exit 1
assert_not_contains "$output" "read.*file\|open.*file" "Doesn't make subagent read file" || exit 1
echo ""

echo "Test 7: Worktree requirement..."
output=$(run_claude "What workflow skills are required before using subagent-driven-development? List any prerequisites or required skills." 30)
assert_contains "$output" "using-git-worktrees\|worktree" "Mentions worktree requirement" || exit 1
echo ""

echo "Test 8: Main branch red flag..."
output=$(run_claude "In subagent-driven-development, is it okay to start implementation directly on the main branch?" 30)
assert_contains "$output" "worktree\|feature.*branch\|not.*main\|never.*main\|avoid.*main\|don't.*main\|consent\|permission" "Warns against main branch" || exit 1
echo ""

echo "Test 9: Plan checkbox sync..."
output=$(run_claude "After a task is completed in subagent-driven-development, should the controller update the executed plan file checkboxes automatically?" 30)
assert_contains "$output" "yes\|must\|required\|checkbox\|plan file\|plan path\|\\[x\\]" "Mentions required plan checkbox sync" || exit 1
echo ""

echo "=== All subagent-driven-development skill tests passed ==="
