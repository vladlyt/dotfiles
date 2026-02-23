---
description: Create a git commit with Jira ticket linking and structured message format
user-invocable: true
---

# /ltv_commit — Structured Commit with Jira Linking

Create a well-structured git commit that links to relevant Jira tickets.

## Instructions

Follow these steps in order:

### Step 1: Gather Git Context

Collect the current state of the repository:

```
! git status
! git diff HEAD
! git branch --show-current
! git log --oneline -5
```

If there are no changes to commit, inform the user and stop.

### Step 2: Find Related Jira Tickets

Use the `mcp__t3__jira_search` tool with this JQL:

```
assignee = currentUser() AND status != Done AND status != Closed ORDER BY updated DESC
```

Set limit to 10 and fields to `summary,status,issuetype,labels,updated`.

Then match tickets to the current changes:
- Compare file paths, service/directory names, and diff content against ticket summaries
- If a single ticket clearly matches, use it
- If multiple tickets could match or none match, use `AskUserQuestion` to let the user pick from the found tickets (include an option for "None / skip Jira linking")

### Step 3: Compose the Commit Message

Use this format:

```
<service-or-dir>: lowercase commit message

Summary:
<description of what changed and why>

Test Plan:
<test plan>

JIRA Issues: PROJ-123
```

Rules for each section:

**First line:**
- Format: `service-name: short description`
- All lowercase
- Derive the service/dir name from the primary directory being changed
- Keep it concise (under 72 characters)

**Summary:**
- Describe the problem/solution, NOT a file-by-file enumeration
- Use markdown formatting (bold, italic) where it aids readability
- Scale detail to match commit size:
  - Small changes (1-3 files, <50 lines): 1-2 sentences
  - Medium changes (4-10 files, 50-200 lines): A short paragraph or couple of them
  - Large changes (10+ files, 200+ lines): Multiple paragraphs with optional sub-headers like **What changed**, **Test updates**, **Scope boundaries**, **Net effect**

**Test Plan:**
- Default to "Executed unit tests" if tests exist in the diff
- If no test changes, write "No test changes" or describe manual verification
- If tests were actually run during the session, mention the command and results

**JIRA Issues:**
- Include the matched ticket key (e.g., `PROJ-123`)
- Omit this section entirely if no ticket was matched


### Step 4: Stage and Commit

1. Stage the relevant changed files using `git add` with specific file paths — do NOT use `git add -A` or `git add .`
2. Do not stage files that look like they contain secrets (`.env`, credentials, etc.)
3. Create the commit using a heredoc for the message:

```bash
git commit -m "$(cat <<'EOF'
<composed message here>
EOF
)"
```

4. Run `git status` after committing to verify success
5. If a pre-commit hook fails, fix the issue, re-stage, and create a NEW commit (never amend)

**IMPORTANT:** NEVER add "Co-Authored-By" lines or any similar attribution trailers to the commit message.
