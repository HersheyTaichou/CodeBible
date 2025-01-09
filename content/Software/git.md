# Git for Windows

Git for Windows brings the power of Git to Windows. It allows you to work with Git repositories from the Windows command line

## How to Install

You can download the installer from the [Git for Windows](https://gitforwindows.org/) website.

It can also be installed with Chocolatey:

```PowerShell
choco install git
```

## How to Configure

Once it is installed, you will need to set your identity, as it is needed for every commit. To set your identity globally, use the following commands:

```PowerShell
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

To set your identity for just one specific repo, browse to the local repo folder in PowerShell and use the --local switch. This can be useful, for instance, if you have some repositories for work and some for personal use. You can set the work repositories to use a work email address, and the personal repositories to use a personal address.

```PowerShell
cd c:\git\repo
git config --local user.name "John Doe"
git config --local user.email johndoe@domain.com
```

The default branch name is `master`. If you want to set the default to something else, run the following:

```PowerShell
git config --global init.defaultBranch main
```

See the git documentation for more configuration options

## How to Use

Git has a lot of commands, here are some of the ones I commonly use, with their definition and a link to the documentation:

| Command      | Definition                                                      | Link                                    |
|--------------|-----------------------------------------------------------------|-----------------------------------------|
| git init     | Create an empty Git repository or reinitialize an existing one. | <https://git-scm.com/docs/git-init>     |
| git add      | Add file contents to the index                                  | <https://git-scm.com/docs/git-add>      |
| git commit   | Record changes to the repository                                | <https://git-scm.com/docs/git-commit>   |
| git status   | Show the working tree status                                    | <https://git-scm.com/docs/git-status>   |
| git branch   | List, create, or delete branches                                | <https://git-scm.com/docs/git-branch>   |
| git switch   | Switch branches                                                 | <https://git-scm.com/docs/git-switch>   |
| git restore  | Restore working tree files                                      | <https://git-scm.com/docs/git-restore>  |
| git checkout | Switch branches or restore working tree files                   | <https://git-scm.com/docs/git-checkout> |
| git merge    | Join two or more development histories together                 | <https://git-scm.com/docs/git-merge>    |
| git revert   | Revert some existing commits                                    | <https://git-scm.com/docs/git-revert>   |
| git rebase   | Reapply commits on top of another base tip                      | <https://git-scm.com/docs/git-rebase>   |

### Initialize a New Local Repository

To create a new local repository, browse to the root location for the repo, then run this command

```PowerShell
git init 
```

### Stage Changes for Commit

When working with files, when you are ready to save the changes you have made so far, you want to stage those changes, which tells Git what changed files you want to commit to the repository. You can either stage just some of the changes so far, by specifying the files you want to commit or stage all the files.

To stage just one file, add it to the staging area by name:

```PowerShell
git add filename
```

To add all changed files to the staging area, place a period after add:

```PowerShell
git add .
```

### To Commit Staged Changes

Once you have the files you want to commit staged, you then commit them to the repository. When you commit your changes, you add a commit message, which should explain, in the present tense, what this commit does.

Commits can be easily rolled back, so you can think of a commit kind of like taking a backup of the repository, that you can easily revert to if issues arise.

To commit the changes with just a short message you can add -m to the commit command

```PowerShell
git commit -m "Adds some files"
```

If you want to do a longer commit message, run the command without -m and it should open your default text editor. You can then add a longer commit message, then save and close it to use that message.  
**Note:** The first line of the commit should still be a short overview of the changes, with more details on the following lines.

```PowerShell
git commit
```
