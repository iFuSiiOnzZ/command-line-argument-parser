@ECHO OFF

:: Create folders if not exist
IF NOT EXIST ..\Bin MKDIR ..\Bin
IF NOT EXIST ..\Bin\App MKDIR ..\Bin\App
IF NOT EXIST ..\Bin\Intermediate MKDIR ..\Bin\Intermediate

:: Set paths
SET ExeName=CLITest
SET ExePath=..\Bin\App\%ExeName%

SET PDBFiles=..\Bin\App\
SET IntermediatePath=..\Bin\Intermediate\

:: Delete files from paths
DEL /Q /S %IntermediatePath%*.* 1>NUL
DEL /Q %PDBFiles%*.pdb 2>NUL

DEL /Q %PDBFiles%*.Exe 2>NUL
DEL /Q %PDBFiles%*.ilk 2>NUL

WHERE cl >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
)
:: Compiler flags
SET CommonCompilerFlags= /nologo /O2 /MT /Z7 /EHsc  /Fd%PDBFiles% /Fo%IntermediatePath% /Fe%ExePath%
SET CommonLinkerFlags= -incremental:no
SET Defines=-DX64

:: Compile
call cl %CommonCompilerFlags% %Defines% build.cpp /link %CommonLinkerFlags%