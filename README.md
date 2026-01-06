# dotfiles

Personal macOS dotfiles, forked from [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles).

## What's Included

**Shell Configuration**
- `.bash_profile` / `.bashrc` - Bash shell setup
- `.bash_prompt` - Custom prompt with Git status
- `.aliases` - Navigation, Git, Docker, Kubernetes shortcuts
- `.functions` - Utilities like `mkd`, `server`, `tre`, `getcertnames`
- `.exports` - Environment variables

**Tool Configs**
- `.vimrc` - Vim configuration with Solarized theme
- `.gitconfig` / `.gitmessage` - Git settings and commit template
- `.inputrc` - Readline settings
- `.editorconfig` - Editor consistency
- `.ripgreprc` / `.fdignore` - Modern CLI tool configs
- `.config/bat/config` - bat (better cat) settings
- `.curlrc` - curl defaults
- `.iterm2/` - iTerm2 profile and preferences

## Installation

```bash
# Clone the repo
git clone https://github.com/abtreece/dotfiles.git
cd dotfiles

# Preview what will change
make dry-run

# Install (creates backup of existing files)
make install

# Reload shell
source ~/.bash_profile
```

## Make Targets

| Target | Description |
|--------|-------------|
| `make install` | Sync dotfiles with confirmation |
| `make install-force` | Sync without confirmation |
| `make update` | Pull latest and sync |
| `make dry-run` | Preview changes |
| `make brew` | Install Homebrew packages |
| `make test` | Lint shell scripts with shellcheck |
| `make diff` | Show differences between repo and home |
| `make clean` | Remove backups older than 30 days |

## Homebrew Packages

Run `make brew` to install:

- **Core Utils**: coreutils, findutils, gnu-sed, moreutils
- **Shell**: bash, bash-completion
- **Dev Tools**: vim, git, git-lfs, gh, asdf, ripgrep
- **Network**: wget, openssh, nmap, socat
- **CTF Tools**: aircrack-ng, binwalk, john, hydra, sqlmap, and more
- **Utilities**: tree, imagemagick, p7zip, pigz, rename

## Key Aliases

```bash
# Navigation
..        # cd ..
p         # cd ~/projects
g         # git

# Modern replacements (if installed)
cat       # bat
ls        # eza
find      # fd

# Git
gst       # git status
gco       # git checkout
glog      # git log --oneline --graph -10

# Utilities
ip        # Show public IP
flush     # Flush DNS cache
cleanup   # Remove .DS_Store files
afk       # Lock screen
```

## Key Functions

```bash
mkd <dir>         # mkdir and cd into it
server [port]     # Start HTTP server (default: 8000)
tre               # tree with sensible defaults
getcertnames <domain>  # Show SSL cert names
fs [path]         # Show file/directory size
cdf               # cd to current Finder location
```

## Backups

Before syncing, existing dotfiles are backed up to `~/.dotfiles_backup/<timestamp>/`.

Clean old backups with `make clean`.
