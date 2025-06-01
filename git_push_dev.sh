#!/bin/bash

# Usage: ./git_push_dev.sh "<commit message>" [<repo path>]

# Default values
COMMIT_MSG="${1:-'Update from development branch'}"
REPO_PATH="${2:-.}"
DEV_BRANCH="development"

# Change to repo directory
cd "$REPO_PATH" || { echo "Repository path not found: $REPO_PATH"; exit 1; }

# Ensure on development branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "$DEV_BRANCH" ]; then
  echo "Switching to $DEV_BRANCH branch..."
  git checkout "$DEV_BRANCH" || { echo "Failed to checkout $DEV_BRANCH"; exit 1; }
fi

# Add all changes
echo "Staging all changes..."
git add . || { echo "Failed to stage changes"; exit 1; }

# Commit changes
echo "Committing with message: $COMMIT_MSG"
git commit -m "$COMMIT_MSG" || { echo "Nothing to commit or commit failed"; exit 1; }

# Push to origin
echo "Pushing to origin/$DEV_BRANCH..."
git push origin "$DEV_BRANCH" || { echo "Push failed"; exit 1; }

echo "✅ Changes pushed to origin/$DEV_BRANCH successfully."
