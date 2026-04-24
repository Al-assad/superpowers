---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task and want a fast, task-oriented implementation plan before touching code
---

# Writing Plans

## Overview

Write implementation plans optimized for execution speed. Default Superpowers planning is now fast-by-default: produce task-level instructions with exact scope, verification, and completion criteria, but do not script every red/green TDD step unless the user explicitly wants the strict workflow.

Assume the implementer is capable but lacks local context. Give them enough detail to build the right thing quickly without over-specifying every keystroke.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** This should be run in a dedicated worktree (created by brainstorming skill).

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses large files, don't unilaterally restructure - but if a file you're modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce a meaningful slice of progress that can usually be completed in 10-30 minutes.

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. If the task is high-risk or the human asks for heavier review, switch to the corresponding `-strict` skill.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Scope**
- Modify: `exact/path/to/existing.py`
- Add: `exact/path/to/new_file.py`
- Related tests: `tests/exact/path/to/test.py`

**Implement**
- [specific behavior to add or change]
- [key constraints or interfaces to preserve]
- [existing pattern or reference to follow]

**Verify**
- Run: `exact command`
- Confirm: [observable result, test outcome, or user-facing behavior]

**Done When**
- [clear completion signal]
- [remaining acceptance condition]
````

## Remember
- Exact file paths always
- Give enough implementation detail to avoid ambiguity, but don't turn the plan into a transcript
- Every task needs a concrete verification path
- Add or update tests when the change warrants it, but do not require fail-first steps in the plan
- Reference relevant skills with @ syntax when they materially change execution
- Prefer a few focused tasks over dozens of tiny steps

## Plan Review Loop

Default fast planning does **not** require a reviewer pass.

Dispatch `plan-document-reviewer` **only if** one or more of these are true:

- The change spans multiple independent subsystems
- The plan includes migrations, compatibility work, or destructive changes
- Public interfaces are still ambiguous
- You believe an implementer could plausibly build the wrong thing from the current draft

If you dispatch the reviewer:

1. Provide: path to the plan document, path to spec document
2. If ❌ Issues Found: fix the issues, then re-dispatch reviewer for the whole plan
3. If ✅ Approved: proceed to execution handoff

## Execution Handoff

After saving the plan, offer execution choice:

**"Plan complete and saved to `docs/superpowers/plans/<filename>.md`. Two execution options:**

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, keep context tight, and only add reviewers when risk warrants it

**2. Inline Execution** - Execute tasks in this session using executing-plans, with task-level verification and variance reporting

**Which approach?"**

**If Subagent-Driven chosen:**
- **REQUIRED SUB-SKILL:** Use superpowers:subagent-driven-development
- Fresh subagent per task + conditional review on risk

**If Inline Execution chosen:**
- **REQUIRED SUB-SKILL:** Use superpowers:executing-plans
- Task-by-task execution with required verification

If the human asks for the original heavy-review workflow, use `superpowers:subagent-driven-development-strict` or `superpowers:executing-plans-strict` instead.
