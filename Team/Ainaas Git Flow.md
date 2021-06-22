Btw, this is my usual minimal git flow that I use from the Command Line Interface (CLI) when working with a team. I don’t usually touch stuff like rebase until I have to just cause I don’t understand how it works well enough. Going to try out Sublime Merge GUI for a few more times and see how it goes.
• git pull origin main (from main branch)
• git checkout -b branch_name_here (if there is no branch, it creates a new one automatically)
• add files, code, save
• once finished, do the normal flow
• git add . (stages all files for commit)
• git commit -m "branch message here e.g add create a new recipe feature"
• git push origin main
git checkout -b main  to get back to main branch
from github.com, create a pull request with the branch above (this is when code reviews normally happen)
resolve conflicts if any from github, merge when done.
delete branch above.
Then I’d repeat the process above for each new feature, bug fix, refactor, etc.
I think where it gets fairly complicated is when the main branch has changed while you’re coding in a branch.
Sometimes, you may have to pull everything first before being able to push the branch to be code reviewed. Sometimes not.
I’ve had to use git at work updating project documents in the past before but I still don’t get how rebase works tbh. But at the base level, being able to create a branch from main and commit that branch should be enough for us to do this project I think.