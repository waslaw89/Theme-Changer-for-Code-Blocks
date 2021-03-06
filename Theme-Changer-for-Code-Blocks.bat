@ECHO OFF
TITLE Theme Changer for Code::Blocks
REM
REM +++++++++++++++++++++++++++++++++++++++++++
REM + Theme Changer for Code::Blocks /ver 1.3 +
REM +++++++++++++++++++++++++++++++++++++++++++
REM + #THE BEER-WARE LICENSE# Script created  +
REM +  by Waclaw Groo. As long as you retain  +
REM +  this notice you can do whatever you    +
REM +  want with this stuff.                  +
REM +  If we meet some day, and you think     +
REM +  this stuff is worth it, you can buy    +
REM +  me a beer in return or to drink my     +
REM +  helth on other chance!                 +
REM +++++++++++++++++++++++++++++++++++++++++++
REM Creator: Waclaw Groo

:TaskCheck
CLS
ECHO 
ECHO +++++++++++++++++++++++++++++++++++++++++++
ECHO + Theme Changer for Code::Blocks /ver 1.2 +
ECHO +++++++++++++++++++++++++++++++++++++++++++
TASKLIST | FINDSTR codeblocks.exe
IF "%errorlevel%" NEQ "0" GOTO :Start
ECHO Image Name                     PID Session Name        Session#    Mem Usage
ECHO -------------------------------------------
ECHO Code::Blocks is running! 
ECHO You should close Code::Blocks before starting this program!
ECHO -------------------------------------------
PAUSE
CLS
GOTO :TaskCheck

:Start
CLS
ECHO 
ECHO +++++++++++++++++++++++++++++++++++++++++++
ECHO + Theme Changer for Code::Blocks /ver 1.2 +
ECHO +++++++++++++++++++++++++++++++++++++++++++
ECHO -------------------------------------------
ECHO 1. BackUp default theme configuration
ECHO 2. Change theme
ECHO 3. Resore from BackUp
ECHO 4. Exit
ECHO -------------------------------------------
SET /p a=What you want to do?[1,2,3 or 4]:
IF "%a%" EQU "1" GOTO :BackUp
IF "%a%" EQU "2" GOTO :FileCheck
IF "%a%" EQU "3" GOTO :Restore
If "%a%" EQU "4" GOTO :End
ECHO Wrong statment, please try again...
PAUSE
CLS
GOTO :Start

:FileCheck
IF EXIST %appdata%\CodeBlocks\default.conf_old GOTO :ChangingTheme
ECHO There is no BackUp file!!!
SET /P c=do you want to create BackUp of current configuration first?[y/n]:
IF /I "%c%" EQU "y" GOTO :BackUp
IF /I "%c%" EQU "n" GOTO :ChangingTheme
ECHO Wrong statment, please try again...
PAUSE
CLS
GOTO :Start

:BackUp
ECHO -------------------------------------------
ECHO BackUp of old confuguration:
MOVE %appdata%\CodeBlocks\default.conf %appdata%\CodeBlocks\default.conf_old
IF "%errorlevel%" NEQ "0" (ECHO %errorlevel% > tmp && SET /P err= < tmp && DEL tmp /q && GOTO :Error)
ECHO %DATE%;%TIME%;BackUp;Move;%err%; >> C:/Users/%USERNAME%/ThemeChangerErr.log
ECHO Done!
ECHO -------------------------------------------
PAUSE
GOTO :Start

:ChangingTheme
ECHO +++++++++++++++++++++++++++++++++++++++++++
ECHO Configuration available on website:
ECHO http://wiki.codeblocks.org/index.php/Syntax_highlighting_custom_colour_themes
ECHO +++++++++++++++++++++++++++++++++++++++++++
SET /P filePath="Please, provide local path to text file with configuraton(type or "grag nad drop"):"
ECHO Changing Themes:
TYPE "%filePath%" > %appdata%\CodeBlocks\default.conf
IF "%errorlevel%" NEQ "0" (ECHO %errorlevel% > tmp && SET /P err= < tmp && DEL tmp /q && GOTO :Error)
ECHO %DATE%;%TIME%;ChangingTheme;Type;%err%;%filePath% >> C:/Users/%USERNAME%/ThemeChangerErr.log
ECHO Done!
ECHO -------------------------------------------
PAUSE
GOTO :Start

:Restore
ECHO -------------------------------------------
ECHO Restoration of old theme configuration:
TYPE %appdata%\CodeBlocks\default.conf_old > %appdata%\CodeBlocks\default.conf
IF "%errorlevel%" NEQ "0" (ECHO %errorlevel% > tmp && SET /P err= < tmp && DEL tmp /q && GOTO :Error)
ECHO %DATE%;%TIME%;Restore;Type;%err%; >> ECHO C:/Users/%USERNAME%/ThemeChangerErr.log
ECHO Done!
ECHO -------------------------------------------
PAUSE
GOTO :Start

:Error
ECHO -------------------------------------------
ECHO Something goes wrong! Error code is %err%
ECHO Check result of last command!
ECHO -------------------------------------------
SET /P b=Do you want to see ThemeChangerErr.log file?[y/n]:
IF /I "%b%" EQU "y" C:/Users/%USERNAME%/ThemeChangerErr.log
PAUSE
GOTO :Exit

:End
ECHO -------------------------------------------
ECHO Run Code::Blocks again. 
ECHO To see avaliable themes goto:
ECHO "Settings->Editor...->Syntax highlighting"
ECHO and a have good time with Code::Blocks! 
ECHO -------------------------------------------
PAUSE

:Exit
ECHO End...
PING 127.0.0.1 -n 1 -w 200 > a
DEL a /q
EXIT