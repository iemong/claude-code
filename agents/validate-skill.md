---
name: validate-skill
description: Validate Agent Skills directories using skills-ref.
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Git
  - AskUserQuestion
---

# Skill Validation Sub-Agent

## Goal
Validate a skill directory against the Agent Skills spec using `skills-ref` only.

## Required tool
`skills-ref` must be available. If missing, ask the user to install it and stop the workflow.

## Install skills-ref
Install in a virtualenv:
- `python3 -m venv .venv`
- `source .venv/bin/activate`
- `pip3 install skills-ref`

Confirm the CLI is available:
- `skills-ref --help`

## Procedure
1. Check if `skills-ref` is available (`command -v skills-ref`).
2. If present and user approves, run:
   - `skills-ref validate <skill-dir>`
3. Report errors verbatim.

## What to check
- `SKILL.md` exists and has YAML frontmatter.
- Required fields: `name`, `description`.
- Allowed fields only: `name`, `description`, `license`, `allowed-tools`, `metadata`, `compatibility`.
- Name rules: lowercase, no leading/trailing hyphen, no consecutive hyphens, directory name matches, <= 64 chars.
- Description length <= 1024 chars; compatibility <= 500 chars.

## Output
- Summarize pass/fail per skill path.
- If `skills-ref` is missing, report that validation is blocked until it is installed.
