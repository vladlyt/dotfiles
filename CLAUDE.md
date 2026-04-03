# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Files are symlinked from this repo into `$HOME` using `stow . --adopt && git reset --hard`.

## Structure

- `.zshrc` — entry point; sources everything in `.zsh/` in order
- `.zsh/setup.zsh` — zsh completion, key bindings, history config
- `.zsh/env.zsh` — PATH, environment variables, machine-type detection (`~/.machine`, `~/.machine-type`)
- `.zsh/functions.zsh` — shell functions (`iterm_tab_color`/`tc`, `rtmux`, `claude_setup`)
- `.zsh/aliases.zsh` — aliases including git shortcuts (registered via `git config --global alias.*`)
- `.zsh/python.zsh` — pyenv setup (lazy, only activates if pyenv binary exists but isn't in PATH)
- `.zsh/starship.zsh` — detects OS/distro and sets `$STARSHIP_DISTRO` icon
- `.config/starship-{local,devpod,prod,minimal}.toml` — per-environment Starship prompt configs
- `.vimrc` — vim config (spaces over tabs, 4-space indent, persistent undo, system clipboard)
- `.tmux.conf` — tmux config (prefix `C-a`, vi keys, `|`/`-` splits, TPM plugins)
- `.devpod/personal.devpod.yaml` — devpod workspace definition (`.devpod/envoy.devpod.yaml` is gitignored)
- `.claude/agents/` — Claude Code custom agent definitions
- `.claude/skills/ltv_commit/` — custom `/ltv_commit` skill for structured commits with Jira linking

## Machine-Type Detection

The shell adapts behavior based on two files in `$HOME`:
- `~/.machine` — one of `local`, `devpod`, `prod`; controls iTerm tab color and Starship config
- `~/.machine-type` — arbitrary string (e.g. `envoy`, `default`); controls PATH additions (e.g. LLVM for envoy machines)

## Deploying Changes

To apply dotfile changes on any machine:
```bash
cd ~/dotfiles && stow . --adopt && git reset --hard
```

The `--adopt` flag lets stow take ownership of existing files; `git reset --hard` restores them from the repo, overwriting any local drift.

## Devpod Setup

The `personal.devpod.yaml` workspace:
- Installs tools via packages: `stow`, `fzf`, `bat`, `kubectl`, etc.
- Clones this repo to `/home/user/dotfiles` and zsh plugin repos into `~/.zsh/`
- Runs stow on every create/restart
- Installs Rust, then builds `starship`, `lsd`, and `git-branchless` from source
- Installs Claude via `aifx agent install claude`

## Custom Skill: `/ltv_commit`

Use `/ltv_commit` to create a structured commit message that:
1. Inspects `git status` / `git diff HEAD`
2. Searches Jira for matching open tickets (assigned to current user)
3. Composes a message in the format: `service: description\n\nSummary:\n...\n\nTest Plan:\n...\n\nJIRA Issues: PROJ-123`
4. Stages specific files and commits (never uses `git add -A`)

Never add `Co-Authored-By` trailers to commit messages in this repo.
