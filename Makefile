.PHONY: help install update dry-run test brew clean

# Default target
help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    Sync dotfiles to home directory (with backup)"
	@echo "  update     Pull latest changes and sync"
	@echo "  dry-run    Show what would be synced without making changes"
	@echo "  test       Run shellcheck on shell scripts"
	@echo "  brew       Install Homebrew packages"
	@echo "  clean      Remove backup directories older than 30 days"
	@echo ""

# Install dotfiles with confirmation
install:
	./bootstrap.sh

# Force install without confirmation
install-force:
	./bootstrap.sh --force

# Pull and install
update:
	git pull origin main
	./bootstrap.sh --force

# Show what would be done
dry-run:
	./bootstrap.sh --dry-run

# Lint shell scripts
test:
	@echo "Running shellcheck on shell scripts..."
	@shellcheck bootstrap.sh brew.sh .bash_profile .bashrc .aliases .functions .exports 2>/dev/null || \
		echo "Note: Install shellcheck with 'brew install shellcheck' for linting"

# Install Homebrew packages
brew:
	./brew.sh

# Clean old backups (older than 30 days)
clean:
	@echo "Removing backup directories older than 30 days..."
	@find ~/.dotfiles_backup -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \; 2>/dev/null || true
	@echo "Done."

# Show diff between local and home directory
diff:
	@echo "Differences between repo and home directory:"
	@diff -rq --exclude='.git' --exclude='.DS_Store' --exclude='bootstrap.sh' --exclude='brew.sh' --exclude='README.md' --exclude='Makefile' . ~ 2>/dev/null || true
