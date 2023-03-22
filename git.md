# Git Tips & Tricks #

## Setup ##

### Git Prompt ###
[The leading git prompt project out there](https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh)

```bash
# get git-prompt.sh
$ curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
# add to .bashrc
source ~/.bash_git
# establish new session
```

## Branch ##

### Renaming ###

Renaming Git Branch

Follow the steps below to rename a Local and Remote Git Branch:

    Start by switching to the local branch which you want to rename:

    git checkout <old_name>

Rename the local branch by typing:

git branch -m <new_name>

At this point, you have renamed the local branch.

If you’ve already pushed the <old_name> branch to the remote repository , perform the next steps to rename the remote branch.

Push the <new_name> local branch and reset the upstream branch:

git push origin -u <new_name>

Delete the <old_name> remote branch:

git push origin --delete <old_name>

That’s it. You have successfully renamed the local and remote Git branch.

## Cleanup ##

### Moving Master To Main
(Moving Master to Main) [https://www.swyx.io/master_to_main]

### Removing sensitive data from a repository ###
[Straight From GitHub.com](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
