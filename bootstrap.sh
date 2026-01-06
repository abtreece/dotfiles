#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE}")";

BACKUP_DIR="${HOME}/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
FORCE=false

usage() {
	echo "Usage: $(basename "$0") [OPTIONS]"
	echo ""
	echo "Options:"
	echo "  -f, --force     Skip confirmation prompt"
	echo "  -n, --dry-run   Show what would be done without making changes"
	echo "  -h, --help      Show this help message"
	echo ""
	echo "This script syncs dotfiles to your home directory."
	echo "A backup of existing files will be created before overwriting."
}

# Parse arguments
while [[ $# -gt 0 ]]; do
	case $1 in
		-f|--force)
			FORCE=true
			shift
			;;
		-n|--dry-run)
			DRY_RUN=true
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			echo "Unknown option: $1"
			usage
			exit 1
			;;
	esac
done

# Files/directories to exclude from sync
EXCLUDES=(
	".git/"
	".DS_Store"
	".osx"
	"bootstrap.sh"
	"brew.sh"
	"README.md"
	"LICENSE-MIT.txt"
	"Makefile"
)

# Build rsync exclude arguments
RSYNC_EXCLUDES=""
for exclude in "${EXCLUDES[@]}"; do
	RSYNC_EXCLUDES="${RSYNC_EXCLUDES} --exclude ${exclude}"
done

# Get list of files that would be synced
get_sync_files() {
	rsync --dry-run -avh --no-perms ${RSYNC_EXCLUDES} . ~ 2>/dev/null | \
		grep -E "^\." | \
		grep -v "^\./$" || true
}

# Create backup of existing files
create_backup() {
	local files_to_backup
	files_to_backup=$(get_sync_files)

	if [[ -z "$files_to_backup" ]]; then
		echo "No files to backup."
		return
	fi

	echo "Creating backup in ${BACKUP_DIR}..."
	mkdir -p "${BACKUP_DIR}"

	while IFS= read -r file; do
		# Remove trailing slash for directories
		file="${file%/}"
		local src="${HOME}/${file}"
		local dest="${BACKUP_DIR}/${file}"

		if [[ -e "$src" ]]; then
			mkdir -p "$(dirname "$dest")"
			cp -R "$src" "$dest" 2>/dev/null || true
		fi
	done <<< "$files_to_backup"

	echo "Backup created at ${BACKUP_DIR}"
}

doIt() {
	git pull origin main;

	if [[ "$DRY_RUN" == true ]]; then
		echo ""
		echo "=== DRY RUN - No changes will be made ==="
		echo ""
		echo "Files that would be synced:"
		rsync --dry-run -avh --no-perms ${RSYNC_EXCLUDES} . ~
		echo ""
		echo "=== End of dry run ==="
		return
	fi

	# Create backup before syncing
	create_backup

	# Perform the actual sync
	rsync ${RSYNC_EXCLUDES} -avh --no-perms . ~;

	echo ""
	echo "Dotfiles synced successfully!"
	echo "Run 'source ~/.bash_profile' to reload your shell configuration."
}

if [[ "$FORCE" == true ]] || [[ "$DRY_RUN" == true ]]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
