@echo off
REM ====================================================================
REM Robust Git Synchronization Script (Add, Commit, Pull, Push)
REM This script now PAUSES upon encountering an error to allow inspection.
REM ====================================================================

echo --- Starting Robust Git Push Sequence ---
echo.


REM === STEP 1: ADD (Stage All Changes) ==
echo 1/4: Staging all changes (git add .)...
git add .
if %errorlevel% neq 0 (
    echo ADD FAILED. Please review the output above.
    pause

)
echo Staging complete.

REM === STEP 2: COMMIT (with fixed message) ===
echo.
echo 2/4: Committing changes with message 'initial commit'...
git commit -m "initial commit"

REM Check for non-zero error level (excluding "nothing to commit" scenarios)
if %errorlevel% neq 0 (
    set LAST_OUTPUT=
    FOR /F "tokens=*" %%g IN ('git status --porcelain') DO (
        set LAST_OUTPUT=%%g
    )
    if defined LAST_OUTPUT (
        echo COMMIT FAILED. Aborting sequence.
        pause
   
    ) else (
        echo WARNING: Nothing new was committed. Moving to pull step.
    )
)
echo Commit step complete.

REM === STEP 3: PULL (Fetch and Merge remote changes) ===
echo.
echo 3/4: Pulling latest updates from origin main non-interactively...
git pull origin main --no-edit

if %errorlevel% neq 0 (
    echo.
    echo PULL FAILED! A manual merge is required (likely conflicts).
    echo FIX THE CONFLICTS and then run this script again.
    pause

)
echo Pull successful.
pause
REM === STEP 4: PUSH (to origin main) ===
echo.
echo 4/4: Pushing committed and merged changes to origin main...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: All changes have been synchronized with origin main!
) else (
    echo.
    echo PUSH FAILED: Could not push changes. Check connection or authentication.
    pause
)

echo.
pause
