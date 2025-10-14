@echo off
echo ==============================
echo   Git Auto Commit and Push
echo ==============================

:: Navigate to your repository folder (optional)
cd C:\Users\Kajo\Desktop\envelhope-beta

:: Add all changes
git add .
echo All files added.

:: Commit changes
git commit -m "initial commit"
echo Commit created.

:: Push to remote repository
git push
echo Push completed.

pause
