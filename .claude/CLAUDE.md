# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
make install       # Sync dotfiles to ~ (creates backup, prompts for confirmation)
make install-force # Sync without confirmation
make dry-run       # Preview what would change
make update        # Pull latest and sync
make brew          # Install Homebrew packages
make test          # Lint shell scripts with shellcheck
make diff          # Show differences between repo and home
make clean         # Remove backups older than 30 days
```

After syncing: `source ~/.bash_profile`

## Repository Structure

- **bootstrap.sh** - Main sync script using rsync to copy dotfiles to home directory
- **brew.sh** - Homebrew package installation script
- **Makefile** - Task runner wrapping bootstrap.sh and brew.sh

Dotfiles synced to home:
- Shell: `.bash_profile`, `.bashrc`, `.bash_prompt`, `.aliases`, `.functions`, `.exports`
- Git: `.gitconfig`, `.gitmessage`, `.gitignore`
- Vim: `.vimrc`, `.vim/` (colors, syntax, backup dirs)
- CLI tools: `.ripgreprc`, `.fdignore`, `.curlrc`, `.editorconfig`, `.inputrc`
- App configs: `.config/bat/config`, `.iterm2/`

Files excluded from sync: `.git/`, `bootstrap.sh`, `brew.sh`, `README.md`, `Makefile`

## Shell Script Conventions

- Use Bash, not zsh
- Include `set -e` at the top
- Use `[[` for conditionals (not `[`)
- Quote variables: `"${var}"` not `$var`
- 2-space indentation

## Git Commits

Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
