@echo off
REM ====================================================================
REM Robust Git Synchronization Script (Add, Commit, Pull, Push)
REM 1. Stages all changes (git add .).
REM 2. Commits changes with a fixed message.
REM 3. Pulls remote updates non-interactively (git pull --no-edit).
REM 4. Pushes local committed changes to 'origin main'.
REM ====================================================================

echo --- Starting Robust Git Push Sequence ---
echo.

REM Verify that this is a Git repository
if not exist .git (
    echo ERROR: Current directory is not a Git repository.
    goto :eof
)

REM === STEP 1: ADD (Stage All Changes) ===
echo 1/4: Staging all changes (git add .)...
git add .
if %errorlevel% neq 0 (
    echo ADD FAILED. Aborting sequence.
    goto :eof
)
echo Staging complete.

REM === STEP 2: COMMIT (with fixed message) ===
echo.
echo 2/4: Committing changes with message 'initial commit'...
git commit -m "initial commit"

REM Git returns non-zero if there's "nothing to commit," which we allow to pass.
if %errorlevel% neq 0 (
    REM Simple check to avoid stopping the script if nothing was committed (but was staged)
    set LAST_OUTPUT=
    FOR /F "tokens=*" %%g IN ('git status --porcelain') DO (
        set LAST_OUTPUT=%%g
    )
    if defined LAST_OUTPUT (
        echo COMMIT FAILED. Aborting sequence.
        goto :eof
    ) else (
        echo WARNING: Nothing new was committed. Moving to pull step.
    )
)
echo Commit step complete.

REM === STEP 3: PULL (Fetch and Merge remote changes) ===
echo.
echo 3/4: Pulling latest updates from origin main non-interactively...
REM The '--no-edit' flag bypasses the editor (Vim).
git pull origin main --no-edit

if %errorlevel% neq 0 (
    echo.
    echo PULL FAILED! A manual merge is required (likely conflicts).
    echo FIX THE CONFLICTS and then run this script again.
    goto :eof
)
echo Pull successful.

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
)

echo.
pause
