# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal, company-agnostic dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Anything work/Uber-specific belongs in the companion repo `dotfiles-uber` (see below).

## Two-Repo Structure

| Repo | Location | Remote | Contains |
|------|----------|--------|----------|
| **dotfiles** (this) | `~/dotfiles` | `github.com:vladlyt/dotfiles.git` | Personal config: shell, vim, tmux, kitty, starship |
| **dotfiles-uber** | `~/dotfiles-uber` | `gitolite@code.uber.internal:personal/ltv/dotfiles` | Work config: devpod, claude skills/agents, Uber aliases/env |

Both repos use stow. On devpods, `dotfiles` is stowed first, then `dotfiles-uber` overlays on top. The overlay mechanism for shell config: `.zshrc` sources `~/.zsh/uber/*.zsh` if the directory exists (provided by dotfiles-uber via stow).

**Rule of thumb**: if it references `code.uber.internal`, Uber GCP projects, arc/phabricator, devpods, bazel targets, or Jira — it goes in `dotfiles-uber`.

## Structure

- `.zshrc` — entry point; sources everything in `.zsh/` then `~/.zsh/uber/*.zsh` if present
- `.zsh/setup.zsh` — zsh completion, key bindings, history config
- `.zsh/env.zsh` — PATH, locale, machine-type detection (`~/.machine`, `~/.machine-type`)
- `.zsh/functions.zsh` — shell functions (`iterm_tab_color`/`tc`, `rtmux`)
- `.zsh/aliases.zsh` — personal aliases, git shortcuts (registered via `git config --global alias.*`)
- `.zsh/python.zsh` — pyenv setup (lazy, only activates if pyenv binary exists but isn't in PATH)
- `.zsh/starship.zsh` — detects OS/distro and sets `$STARSHIP_DISTRO` icon
- `.config/starship-{local,devpod,prod,minimal}.toml` — per-environment Starship prompt configs
- `.config/kitty/kitty.conf` — kitty terminal config
- `.vimrc` — vim config (spaces over tabs, 4-space indent, persistent undo, system clipboard)
- `.tmux.conf` — tmux config (prefix `C-a`, vi keys, `|`/`-` splits, TPM plugins)

## Machine-Type Detection

The shell adapts behavior based on two files in `$HOME`:
- `~/.machine` — one of `local`, `devpod`, `prod`; controls iTerm tab color and Starship config
- `~/.machine-type` — arbitrary string (e.g. `envoy`, `default`); used by dotfiles-uber for conditional PATH additions

## Deploying Changes

```bash
cd ~/dotfiles && stow . --adopt && git reset --hard
cd ~/dotfiles-uber && stow . --adopt && git reset --hard   # if present
```
