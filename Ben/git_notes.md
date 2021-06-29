# From Ainaa
Btw, this is my usual minimal git flow that I use from the Command Line Interface (CLI) when working with a team. I don’t usually touch stuff like rebase until I have to just cause I don’t understand how it works well enough. Going to try out Sublime Merge GUI for a few more times and see how it goes.
 git pull origin main (from main branch)
 git checkout -b branch_name_here (if there is no branch, it creates a new one automatically)
 add files, code, save
 once finished, do the normal flow
 git add . (stages all files for commit)
 git commit -m "branch message here e.g add create a new recipe feature"
 git push origin main
git checkout -b main  to get back to main branch
from github.com, create a pull request with the branch above (this is when code reviews normally happen)
resolve conflicts if any from github, merge when done.
delete branch above.
Then I’d repeat the process above for each new feature, bug fix, refactor, etc.
I think where it gets fairly complicated is when the main branch has changed while you’re coding in a branch.
Sometimes, you may have to pull everything first before being able to push the branch to be code reviewed. Sometimes not.
I’ve had to use git at work updating project documents in the past before but I still don’t get how rebase works tbh. But at the base level, being able to create a branch from main and commit that branch should be enough for us to do this project I think.

https://fabisiakradoslaw.medium.com/understand-how-does-git-rebase-work-and-compare-with-git-merge-and-git-interactive-rebase-cce2c9775e43
https://www.mohammedasker.com/explaining-how-git-rebase-works-in-laymans-terms-%F0%9F%8D%95-%F0%9F%A5%91-%F0%9F%8D%96
I was reading these two article about git merge and git rebase which we’ll most likely use if our branch goes out of sync with main branch while coding. But it seems like between the two approaches, what really changes is how git commit history will look like.
I suppose if we always use a GUI like Sublime Merge and rebase each time we pull from master in a branch, it will create a more streamlined git history. But since I doubt we’re going to revert code based on commit history, it’s probably okay to choose whatever approach anyway. So long as when we merge into main, all the latest code are inside.


# From Ben
https://www.youtube.com/watch?v=MnUd31TvBoU

Git pull origin <main> 		# gets any new changes that have been made
Git checkout -b new-branch      # create a new branch to work on
make your changes
Git add <files> 				# add files for staging as normal
Git commit  				# Create a commit as normal (with message)
Git push origin new-branch	# Push to the new-branch remote repository, not the main branch
Go to GitHub repo
Create pull request
IF no conflicts and branch can be merged automatically, can do so
	Then you can delete the branch
ELSE (there are conflicts) ???

Notes
- changes can be made to the new-branch after a pull requests is started but hasn’t been merged yet. Just make sure whoever is making the change has git checkout <the right branch>
- You don’t have to delete branches after they have been merged if you want to refer to them later


https://www.youtube.com/watch?v=_wQdY_5Tb5Q
Rebase vs Merge - rebase is 
This video has a good visual for how merging vs rebasing works


https://www.youtube.com/watch?v=f1wnYdLEpgI
Great walkthrough of merge vs rebase visually