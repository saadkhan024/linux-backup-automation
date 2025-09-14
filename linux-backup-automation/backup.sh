#!/bin/bash
# backup.sh - Automated Linux Backup with Git push

# Config
BACKUP_SRC="$HOME/mydata"
PROJECT_DIR="$HOME/linux-backup-automation"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="backup_$TIMESTAMP.tar.gz"

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Create compressed backup
tar -czf $BACKUP_DIR/$FILENAME $BACKUP_SRC

# Delete old backups (older than 7 days)
find $BACKUP_DIR -type f -mtime +7 -delete

# Git automation (run in project root, not in backups/)
cd $PROJECT_DIR
git add .
git commit -m "Backup on $TIMESTAMP" || echo "No changes to commit"
git push origin main

