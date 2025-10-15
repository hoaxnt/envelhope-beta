@echo off
echo --- Starting Git Push Sequence ---
echo.
echo 1/3: Staging all changes (git add .)...
git add .
echo Staging complete.
echo.
echo 2/3: Committing changes with message 'initial commit'...
git commit -m "island updates"
echo Commit step complete.
echo.
echo 3/3: Pushing committed and merged changes to origin dev...
git push
echo.
pause
