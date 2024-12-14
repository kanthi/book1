# Git Commands

## 1. Stashing Changes

Stashing allows you to save your current changes temporarily so you can work on something else and come back to them later.

- `git stash` -> Temporarily saves your uncommitted changes.
- `git stash list` -> Lists all stashed changes.
- `git stash apply stash@{0}` -> Applies the specified stash without removing it.
- `git stash pop` -> Applies the most recent stash and removes it from the stash list.
- `git stash drop stash@{0}` -> Deletes a specific stash.

## 2. Working with Tags

Tags are used to mark specific points in the repository's history as being important, typically for releases.

- `git tag` -> Lists all tags in the repository.
- `git tag -a v1.0 -m "Version 1.0"` -> Creates an annotated tag with a message.
- `git push origin v1.0` -> Pushes a specific tag to the remote repository.
- `git push --tags` -> Pushes all tags to the remote repository.
- `git tag -d v1.0` -> Deletes a tag locally.
- `git push origin --delete v1.0` -> Deletes a tag from the remote repository.

## 3. Interactive Rebase

Interactive rebase allows you to modify the commit history by reordering, editing, or squashing commits.

- `git rebase -i HEAD~3` -> Opens an interactive rebase for the last 3 commits.

### Actions during interactive rebase:
- `pick`: Keep the commit as is.
- `squash`: Combine this commit with the previous one.
- `reword`: Modify the commit message.
- `edit`: Modify the commit.

- `git rebase --abort` -> Aborts the rebase process and restores the original branch.
- `git rebase --continue` -> Continues the rebase process after resolving conflicts.

## 4. Cherry-Picking

Cherry-picking allows you to apply specific commits from one branch to another.

- `git cherry-pick commit-hash` -> Applies a specific commit from another branch.
- `git cherry-pick --continue` -> Continues the cherry-pick process after resolving conflicts.
- `git cherry-pick --abort` -> Aborts the cherry-pick process.

## 5. Working with Remotes

Managing remote repositories involves adding, removing, fetching from, and pushing to remote repositories.

- `git remote -v` -> Lists all remote repositories and their URLs.
- `git remote add origin https://github.com/user/repo.git` -> Adds a new remote repository.
- `git remote remove origin` -> Removes a remote repository.
- `git fetch origin` -> Fetches all branches and updates from the remote.
- `git pull origin branch-name --rebase` -> Rebases the local branch with the remote branch.

## 6. Git Aliases

Aliases are shortcuts for longer Git commands, making it easier to use frequently used commands.

- `git config --global alias.st status` -> Creates an alias for 'git status'.
- `git config --global alias.co checkout` -> Creates an alias for 'git checkout'.
- `git config --global alias.br branch` -> Creates an alias for 'git branch'.

## 7. Bisecting to Find Bugs

Bisecting is a process to find the commit that introduced a bug by performing a binary search through the commit history.

- `git bisect start` -> Starts the bisect process.
- `git bisect bad` -> Marks the current commit as bad.
- `git bisect good commit-hash` -> Marks a specific commit as good.
- `git bisect reset` -> Ends the bisect session and returns to the original branch.

## 8. Cleaning Untracked Files

Cleaning removes untracked files and directories from your working directory, which can be useful for removing build artifacts or temporary files.

- `git clean -n` -> Displays the untracked files and directories that would be removed.
- `git clean -f` -> Removes untracked files.
- `git clean -fd` -> Removes untracked files and directories.
