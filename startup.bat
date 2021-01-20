@ECHO OFF

REM steamcmd returns non 0 success results
powershell $(steamcmd.exe +login anonymous +force_install_dir c:/astroneer/ +app_update  728470 +quit; powershell exit 0)


REM Until Azure supports the container instance volume mounts, UNC Azure Files and symbolic link it

IF "%AzContainerInstance%" == "" GOTO DEFAULT
:Azure
SET 
ECHO Do azure setup
cmdkey /add:"%AzTarget%" /user:"%AzUser%" /pass:"%AzPass%"
REM RMDIR /Q/S c:\astroneer\Astro\Saved
mklink /d c:\astroneer\Astro\Saved "\\%AzTarget%\%AzShareName%"
GOTO END
:DEFAULT
GOTO END
:END

AstroLauncher.exe
EXIT /B