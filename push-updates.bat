@echo off
echo --- Starting Git Push Sequence ---
git status
echo.
echo 1/3: Staging all changes (git add .)...
git add .
echo Staging complete.
echo.
echo 2/3: Committing changes with message 'map updates'...
git commit -m "map updates"
echo Commit step complete.
echo.
echo 3/3: Pushing committed and merged changes...
git push origin main
echo.
pause
