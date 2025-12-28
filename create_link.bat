@echo off
title Auto Create Folder Junctions
echo ==============================
echo  AUTO LINK VLBS FOLDERS
echo ==============================

:: ====== CAU HINH PATH ======
set SRC_ROOT=E:\VLBS_Ric\VLBS19
set DST_ROOT=D:\AutoVLBS19_Datau\VLBS19

:: ====== DANH SACH FOLDER ======
set FOLDERS=MAPS Profiles Scripts UserData

:: ====== TAO ROOT DICH ======
if not exist "%DST_ROOT%" (
    mkdir "%DST_ROOT%"
)

:: ====== VONG LAP TAO LINK ======
for %%F in (%FOLDERS%) do (
    echo.
    echo Processing folder: %%F

    if exist "%DST_ROOT%\%%F" (
        echo  - Removing old folder...
        rmdir "%DST_ROOT%\%%F" /s /q
    )

    if exist "%SRC_ROOT%\%%F" (
        echo  - Creating junction...
        mklink /J "%DST_ROOT%\%%F" "%SRC_ROOT%\%%F"
    ) else (
        echo  - WARNING: Source not found!
    )
)

echo.
echo ===== DONE =====
pause