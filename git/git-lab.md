# Git Lab
 
Create a new directory and initialize it as a Git repository:
 
```bash
mkdir git-workshop
cd git-workshop
ls -al 
git init
```
Explore the hidden `.git` directory that Git created:
 
```bash
ls -al .git
``` 
## Git Config 
Let's start with .git/config file:
 
```bash
cat .git/config
```
This file contains the Local configuration for this repository. 
You can also get local config using:
```
git config --local --list
``` 
Git also has Global,  System  and Worktree configurations.
For this workshop, we will focus on Local and Global configurations.
To list Global configuration, use:
```
git config --global --list
```
To update the username locally for this repository, use:
```bash
git config --local user.name "myusermame"
```
You can get the config origin using:
```bash
git config --show-origin --list
```
## Git Objects 

Git stores all its data in the `.git/objects` directory. Let's explore it:
```bash
find  .git/objects
```
It's empty now. Let's create a new file.
```bash
echo "Hello world" > A.txt
find  .git/objects
```
Still empty! Git doesn't track files automatically. We need to tell Git to track this file using:
```bash
git status
git add A.txt
find  .git/objects
.git/objects/80/2992c4220de19a90767f3000a79a31b98d0df7
```
Now you can see some files in the `.git/objects` directory. let's open it
```bash
cat .git/objects/80/2992c4220de19a90767f3000a79a31b98d0df7
```
it shows some binary data. Git stores files in a compressed format.
``` bash
file .git/objects/80/2992c4220de19a90767f3000a79a31b98d0df7
.git/objects/80/2992c4220de19a90767f3000a79a31b98d0df7: zlib compressed data
```
To see the content of the file, we can use `git cat-file` command:
```bash
git cat-file -p 802992c4220de19a90767f3000a79a31b98d0df7
Hello world
```
The hash `802992c4220de19a90767f3000a79a31b98d0df7` is the SHA-1 checksum of the file content.
You can also use `git hash-object` command to get the SHA-1 checksum of a file:
```bash
git hash-object A.txt
802992c4220de19a90767f3000a79a31b98d0df7
```

Now, let's commit the file to the repository:
```bash
git commit -m "A: Add A.txt file"
```
After committing, let's check the objects again:
```bash
find  .git/objects
```
You will see more objects created in the `.git/objects` directory. 
To see the details of the commit object, use:
```bash
git cat-file -p HEAD
tree b1b5bf1eb5e7de1ad35ab92258a519a69c805860
author username <email> 1763584174 +0100
committer username <email> 1763584174 +0100

A: Add A.txt file
```
The `tree` line shows the SHA-1 checksum of the tree object representing the state of the repository at that commit.
To see the tree object, use:
```bash
git cat-file -p b1b5bf1eb5e7de1ad35
100644 blob 802992c4220de19a90767f3000a79a31b98d0df7	A.txt
```
The tree object contains a list of files and their corresponding blob objects. It's a directory listing of the repository at that commit.

Now let's add another file and commit it:
```bash
echo "This is file B" > B.txt
git status
git add B.txt
git status
git commit -m "B: Add B.txt file"
```
Now, let's check the commit history:
```bash
git log 
git log --oneline
git --no-pager log --graph --oneline --all
```
You can see the two commits we made. Each commit points to its parent commit, forming a tree of commits.
To see the details of the second commit, use:
```bash
git cat-file -p HEAD
tree 509cb71bb34266f4b56da4942081761acd216d34
parent bd9108070ae400db194c465f9fae49ba29e72208
author username <email> 1763584410 +0100
committer username <email> 1763584410 +0100

B: Add B.txt file
```
The `parent` line shows the SHA-1 checksum of the parent commit.

Task1: Explore the second commit tree object and try to answer How does git store the files in the commit? is it a full snapshot or a delta?

Task2: Try to create a new file `echo "Hello world" > C.txt` then run `git add C.txt`. How many new objects are created in the `.git/objects` directory? Why?

Commit your changes.
```bash
git status
git commit -m "C: Add C.txt file"
```

## Git Ignore 
Create a `.gitignore` file to ignore certain files:
```bash
echo "secrets.json" > .gitignore
git add .gitignore
git commit -m "Add .gitignore file"
```
Now, create a file named `secrets.json`:
```bash
echo '{"password": "mysecret"}' > secrets.json
git status
```
You will see that `secrets.json` is not listed in the untracked files because it's ignored by Git.

Task: How to define a global .gitignore file for all your repositories?

## Git Branches

Let's explore branches in Git. By default, Git creates a branch named `master` or `main` when you initialize a repository.
To see the current branch, use:
```bash
git branch
* main
```
To create a new branch, use:
```bash
git branch feature-a
git branch
  feature-a
* main
```
To switch to the new branch, use:
```bash
git checkout feature-a
git switch feature-a
```  
You can switch and create a new branch in one command:
```bash
git checkout -b feature-b
git switch -c feature-b
```

## Git Stash
Git stash allows you to save your uncommitted changes temporarily and revert to a clean working directory.
Let's create a new file and make some changes:
```bash
echo "Temporary changes" > temp.txt
git add temp.txt
git status
```
Now, let's stash the changes:
```bash
git stash save "WIP"
git status
```
The working directory is clean now. To see the list of stashed changes, use:
```bash
git stash list
stash@{0}: WIP
```
To apply the stashed changes back to the working directory, use:
```bash
git stash apply stash@{0}
git status
```
## Git Undo changes
Update A.txt file then check the status:
```bash
echo "New changes" >> A.txt
git status
modified:   A.txt
```
To undo the changes in A.txt and revert it to the last committed state, use:
```bash
git checkout A.txt
Updated 1 path from the index
git status 
On branch main
nothing to commit, working tree clean
```

Task1: Try to add A.txt to the staging area how to undo the changes in the staging area?
Task2: How to undo the last commit but keep the changes in the working directory?


## Git Merge
Use create-no-conflict.sh script to create a merge scenario without conflicts:
Make sure to run it a new directory.
```bash
chmod +x create-no-conflict.sh
source create-no-conflict.sh
```
Read the script to understand what it does.

```
A - B - C (main)
     \
      D  (feature-a)
```

Now, let's merge the `main` branch into the `feature-a` branch
Make sure you are in the `feature-a` branch:
```bash
   git merge main
```

Now try same with create-conflict.sh script to create a merge scenario with conflicts.

## Git Rebase

Same as above use create-conflict.sh and create-no-conflict.sh scripts to create rebase scenarios with and without conflicts.

## Git Hooks
Git hooks are scripts that run automatically on certain Git events, such as committing or merging.
Explore the `.git/hooks` directory:
```bash
ls -al .git/hooks
```
You will see several sample hook scripts with a `.sample` extension.
Use `commit-msg` script and create a new hook that prevents committing msg that doesn't respect semantic commit format.

```bash
  cp commit-msg  YOUR_DIR/.git/hooks/commit-msg
  chmod +x YOUR_DIR/.git/hooks/commit-msg
```
try to commit with an invalid commit message:
```bash
echo "Some changes" >> A.txt
git add A.txt
git commit -m "invalid message"
```
You should see an error message preventing the commit.

You can skip the hook by using `--no-verify` option:
```bash
git commit -m "invalid message" --no-verify
```
Task: Create a pre-commit hook that prevents committing files with .log extension.


## Further Reading
- [Git Cheat Sheet](https://git-scm.com/cheat-sheet)
- [Git Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book/en/v2) 
