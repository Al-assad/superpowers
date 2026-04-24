---
name: executing-plans
description: Use when you have a written implementation plan to execute quickly with task-level verification in a separate session
---

# Executing Plans

## Overview

Load plan, sanity-check it, execute tasks, and verify results. This is the fast-by-default execution workflow: it keeps the up-front plan review, but removes the old mandatory checkpoint-heavy cadence.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** If subagents are available and the tasks are mostly independent, prefer `superpowers:subagent-driven-development`. If the human wants the original heavier review workflow, use `superpowers:executing-plans-strict`.

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any missing context, contradictions, or risky assumptions
3. If the plan has critical gaps or would obviously send you down the wrong path, raise them before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Tasks

For each task:
1. Mark as in_progress
2. Implement the task as written
3. Run the verification commands from the task's `Verify` section
4. Note any meaningful deviation from the plan before moving on
5. Mark as completed in TodoWrite
6. Update the corresponding checkbox in the plan file loaded in Step 1

### Step 3: Complete Development

After all tasks complete and key verifications pass:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use superpowers:finishing-a-development-branch
- Follow that skill to verify the final state, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- The task turns out to require migrations, compatibility work, or architecture decisions the fast plan does not cover
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Plan Checkbox Sync (Required)

This skill must keep the Step 1 plan file progress synchronized as tasks complete.
Use the exact file path provided for execution (typically `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`, unless the human provided a different path).

After each completed task:

- Change the matching checkbox from `- [ ]` to `- [x]`
- If the task section has no checkbox, add one under that task heading and mark it complete
- Do not mark completion when verification is still failing
- Report which checkbox was updated before proceeding

## Remember
- Review plan critically first
- Follow the task intent exactly, even if the fast plan uses broader task units
- Don't skip verifications
- Report meaningful plan drift instead of silently improvising
- Keep plan checkbox state in sync with runtime task state
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent

## Integration

**Required workflow skills:**
- **superpowers:using-git-worktrees** - REQUIRED: Set up isolated workspace before starting
- **superpowers:writing-plans** - Creates the plan this skill executes
- **superpowers:finishing-a-development-branch** - Complete development after all tasks

**Strict alternative:**
- **superpowers:executing-plans-strict** - Use when the human explicitly wants the original checkpoint-heavy workflow
