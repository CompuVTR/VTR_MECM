@echo off

REM *****************************************************************************
REM *****************************************************************************
REM *** Company : CompuVTR              	                              ***
REM *** Author  : E.E. Victor Michael                                         ***
REM *** Date    : July 7, 2025                                                ***
REM *** Purpose : Special wrapper for WUSA to install MSU or uninstall KB     ***
REM *** Version : 1.0                                                         ***
REM *****************************************************************************
REM *****************************************************************************
TITLE -=Install MSU or uninstall KB, Script written by E.E. Victor Michael=-



SETLOCAL ENABLEDELAYEDEXPANSION

if /i "%1" EQU "-i" (goto INST)
if /i "%1" EQU "/i" (goto INST)

if /i "%1" EQU "-u" (goto UINST)
if /i "%1" EQU "/u" (goto UINST)

echo [38;2;255;0;0;48;2;32;32;32mSyntax Error.[0m
echo.

if /i "%1" EQU "-?" (goto HLP)
if /i "%1" EQU "/?" (goto HLP)


:HLP
echo. 
echo^ Special wrapper for WUSA to install MSU or uninstall KB
echo. 
echo+ WUSAIU /i ^<filename.msu^> ^| /u KBNumber
echo. 
echo= /i     Install the MSU Package.
echo( /u     Uninstall package by using its KB number.
echo. 
echo[ Examples:
echo]    Install msu package:
echo\        WUSAIU /i "C:\Temp\WindowsTH-KB2693643-x64.msu"
echo/    Uninstall KB2693643:
echo,        WUSAIU /u KB2693643
echo:            or
echo;        WUSAIU /u 2693643
echo. 
goto END

:INST
echo [38;2;150;255;150mWaiting for the MSU package to be installed...[0m
start "WUSAIU" /b /wait "C:\Windows\System32\wusa.exe" "%~1" /quiet /norestart
goto END

:UINST
set KBN=%~2
echo %~2|findstr /i /r "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9]" > nul
if %errorlevel% == 0 (
    echo [38;2;255;255;0mWaiting for the KB%KBN% to be uninstalled...[0m
    start "WUSAIU" /b /wait "C:\Windows\System32\wusa.exe" /uninstall /kb:%KBN% /norestart
    goto END
)
echo %~2|findstr /i /r "^kb[0-9][0-9][0-9][0-9][0-9][0-9][0-9]" > nul
if %errorlevel% == 0 (
    set KBN=!KBN:~2!
    echo [38;2;255;255;0mWaiting for the %~2 to be uninstalled...[0m
    start "WUSAIU" /b /wait "C:\Windows\System32\wusa.exe" /uninstall /kb:!KBN! /norestart
    goto END
)
echo [38;2;255;140;0mInvalid KB Number.[0m
goto HLP


:END
exit /b