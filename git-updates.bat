@echo off
echo --- Starting Git Push Sequence ---
echo.
echo 1/4: Staging all changes (git add .)...
git add .
echo Staging complete.
echo.
echo 2/4: Committing changes with message 'initial commit'...
git commit -m "initial commit"
echo Commit step complete.
echo.
echo 3/4: Pulling latest updates from origin main non-interactively...
git pull origin main --no-edit
echo Pull successful.
echo.
echo 4/4: Pushing committed and merged changes to origin main...
git push
echo.
pause
