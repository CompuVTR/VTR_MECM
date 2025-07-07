@echo off

REM *****************************************************************************
REM *****************************************************************************
REM *** Company : CompuVTR              	                              ***
REM *** Author  : E.E. Victor Michael                                         ***
REM *** Date    : July 7, 2025                                                ***
REM *** Purpose : Repair SCCM 						      ***
REM *** Version : 1.0                                                         ***
REM *****************************************************************************
REM *****************************************************************************
TITLE -=Repair SCCM, Script written by E.E. Victor Michael=-


net stop /y CcmExec
net stop /y Winmgmt
certutil -delstore SMS SMS

del /f /q "C:\Windows\SMSCFG.ini"
rd /s /q "C:\Windows\System32\wbem\Repository"
rd /s /q "C:\Windows\SysWOW64\wbem\Repository"

start "Repair SCCM" /wait /d "C:\Windows\CCM" "C:\Windows\CCM\ccmrepair.exe"

net start /y Winmgmt
net start /y CcmExec
