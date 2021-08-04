@echo off

rem Description:
rem WinHlp32 Legacy install script for Windows 10+ or Server 2016+ (Works so far on Win11 insider, Maybe ARM with emulation?)
rem By 29039 https://github.com/29039/WinHlp32-Legacy-install-script/ 2021-08-05

rem License:
rem This script itself is LGPL 2.1, WinHlp32 is Copyright by Microsoft

rem Version:
rem v1.00

rem Notes:
rem WinHlp32 is compatible with x86 & x64, the builds are actually identical between the two.
rem WinHlp32 is not supported by Microsoft anymore and may introduce vulnerabilities. 
rem For an more supported solution, try: https://github.com/otya128/winevdm
rem For more info on WinHlp32 including config options visit: https://go.microsoft.com/fwlink/?linkid=528881

rem Credits:
rem Microsoft for making WinHlp32 in the first place, and then trying to kill it off
rem Ramesh Srinivasan https://www.winhelponline.com/blog/view-winhelp-hlp-files-windows-10-with-winhlp32-exe/
rem BlueLife & Velociraptor https://www.sordum.org/8478/reg-converter-v1-2/
rem If this has saved you some work please consider donating to them or to the EFF or something

rem Uncomment out the following line to make this version hijack the built-in WinHlp32.exe
rem REG.EXE ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winhlp32.exe" /v "Debugger" /t REG_SZ /d "C:\Program Files\WinHlp32 Legacy\winhlp32_legacy.exe" /f

rem Please consider uncommenting the below lines to disassociate .HLP files for security, after that run winhlp32.exe C:\helpfile.hlp from a shortcut or cmd, otherwise a user might run a .HLP file from the internet which could have a virus:
rem powershell -ExecutionPolicy RemoteSigned -Command "New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR; rename-item HKCR:\.hlp -NewName ~.hlp"

echo Please wait, checking if running as Admin...
call :IsAdmin

IF NOT EXIST "C:\Program Files\WinHlp32 Legacy" mkdir "C:\Program Files\WinHlp32_Legacy"
ren "C:\Program Files\WinHlp32_Legacy" "WinHlp32 Legacy"

mkdir %temp%\WinHlp32_Legacy_Install
set wh-pf=C:\Program Files\WinHlp32 Legacy
set wh-temp-build=%temp%\WinHlp32_Legacy_Install\x86_microsoft-windows-winhstb.resources_31bf3856ad364e35_6.3.9600.20470
set wh-temp-main=%temp%\WinHlp32_Legacy_Install\x86_microsoft-windows-winhstb_31bf3856ad364e35_6.3.9600.20470_none_be363e6f3e19858c

IF NOT EXIST "%userprofile%\Downloads\Windows8.1-KB917607-x86.msu" powershell -ExecutionPolicy RemoteSigned -Command "Invoke-WebRequest -UseBasicParsing -Uri 'https://download.microsoft.com/download/3/8/C/38C68F7C-1769-4089-BF21-3F5D8A556CBC/Windows8.1-KB917607-x86.msu' -Outfile '%userprofile%\Downloads\Windows8.1-KB917607-x86.msu'"

rem Just in case the file gets lost to time...
rem Name: windows8.1-kb917607-x86.msu
rem Size: 740878 bytes (723 KiB)
rem SHA256: 38CB3D2F2F2896D6E86EDF6A07B4D65F6606B7085A00924831F83C9144BF2D27
rem SHA1: 88E3BB98E9E4C5A9EBA4611E90063768E72902E1
rem MD5: cc8aa18a42c31e25e0208be08482e94f

expand -f:Windows8.1-KB917607-x86.cab %userprofile%\Downloads\Windows8.1-KB917607-x86.msu %temp%\WinHlp32_Legacy_Install

expand %temp%\WinHlp32_Legacy_Install\Windows8.1-KB917607-x86.cab -F:ftlx041*.dll %temp%\WinHlp32_Legacy_Install
expand %temp%\WinHlp32_Legacy_Install\Windows8.1-KB917607-x86.cab -F:winhlp32.ex* %temp%\WinHlp32_Legacy_Install
expand %temp%\WinHlp32_Legacy_Install\Windows8.1-KB917607-x86.cab -F:ftsrch.dl* %temp%\WinHlp32_Legacy_Install

mkdir "C:\Program Files\WinHlp32 Legacy\ar-SA"
mkdir "C:\Program Files\WinHlp32 Legacy\cs-CZ"
mkdir "C:\Program Files\WinHlp32 Legacy\da-DK"
mkdir "C:\Program Files\WinHlp32 Legacy\de-DE"
mkdir "C:\Program Files\WinHlp32 Legacy\el-GR"
mkdir "C:\Program Files\WinHlp32 Legacy\en-US"
mkdir "C:\Program Files\WinHlp32 Legacy\es-ES"
mkdir "C:\Program Files\WinHlp32 Legacy\fi-FI"
mkdir "C:\Program Files\WinHlp32 Legacy\fr-FR"
mkdir "C:\Program Files\WinHlp32 Legacy\he-IL"
mkdir "C:\Program Files\WinHlp32 Legacy\hu-HU"
mkdir "C:\Program Files\WinHlp32 Legacy\it-IT"
mkdir "C:\Program Files\WinHlp32 Legacy\ja-JP"
mkdir "C:\Program Files\WinHlp32 Legacy\ko-KR"
mkdir "C:\Program Files\WinHlp32 Legacy\nb-NO"
mkdir "C:\Program Files\WinHlp32 Legacy\nl-NL"
mkdir "C:\Program Files\WinHlp32 Legacy\pl-PL"
mkdir "C:\Program Files\WinHlp32 Legacy\pt-BR"
mkdir "C:\Program Files\WinHlp32 Legacy\pt-PT"
mkdir "C:\Program Files\WinHlp32 Legacy\ru-RU"
mkdir "C:\Program Files\WinHlp32 Legacy\sv-SE"
mkdir "C:\Program Files\WinHlp32 Legacy\tr-TR"
mkdir "C:\Program Files\WinHlp32 Legacy\zh-CN"
mkdir "C:\Program Files\WinHlp32 Legacy\zh-TW"

move /Y %wh-temp-build%_ar-sa_d2eb64369d8e397f\winhlp32.exe.mui "%wh-pf%\ar-SA"
move /Y %wh-temp-build%_ar-sa_d2eb64369d8e397f\ftsrch.dll.mui "%wh-pf%\ar-SA"
move /Y %wh-temp-build%_cs-cz_2434bc5a7b966701\winhlp32.exe.mui "%wh-pf%\cs-CZ"
move /Y %wh-temp-build%_cs-cz_2434bc5a7b966701\ftsrch.dll.mui  "%wh-pf%\cs-CZ"
move /Y %wh-temp-build%_da-dk_c16e9c8171dc6300\winhlp32.exe.mui "%wh-pf%\da-DK"
move /Y %wh-temp-build%_da-dk_c16e9c8171dc6300\ftsrch.dll.mui "%wh-pf%\da-DK"
move /Y %wh-temp-build%_de-de_be9a31bd73b2b79a\winhlp32.exe.mui "%wh-pf%\de-DE"
move /Y %wh-temp-build%_de-de_be9a31bd73b2b79a\ftsrch.dll.mui "%wh-pf%\de-DE"
move /Y %wh-temp-build%_el-gr_67305f5062c82028\winhlp32.exe.mui "%wh-pf%\el-GR"
move /Y %wh-temp-build%_el-gr_67305f5062c82028\ftsrch.dll.mui "%wh-pf%\el-GR"
move /Y %wh-temp-build%_en-us_678b07b66290c35f\winhlp32.exe.mui "%wh-pf%\en-US"
move /Y %wh-temp-build%_en-us_678b07b66290c35f\ftsrch.dll.mui "%wh-pf%\en-US"
move /Y %wh-temp-build%_es-es_6756649a62b7b504\winhlp32.exe.mui "%wh-pf%\es-ES"
move /Y %wh-temp-build%_es-es_6756649a62b7b504\ftsrch.dll.mui "%wh-pf%\es-ES"
move /Y %wh-temp-build%_fi-fi_0671694757d1a72e\winhlp32.exe.mui "%wh-pf%\fi-FI"
move /Y %wh-temp-build%_fi-fi_0671694757d1a72e\ftsrch.dll.mui "%wh-pf%\fi-FI"
move /Y %wh-temp-build%_fr-fr_0a0dda995589cb66\winhlp32.exe.mui "%wh-pf%\fr-FR"
move /Y %wh-temp-build%_fr-fr_0a0dda995589cb66\ftsrch.dll.mui "%wh-pf%\fr-FR"
move /Y %wh-temp-build%_he-il_4e2d823b3bf8cc54\winhlp32.exe.mui "%wh-pf%\he-IL"
move /Y %wh-temp-build%_he-il_4e2d823b3bf8cc54\ftsrch.dll.mui "%wh-pf%\he-IL"
move /Y %wh-temp-build%_hu-hu_517e5ae139e99a82\winhlp32.exe.mui "%wh-pf%\hu-HU"
move /Y %wh-temp-build%_hu-hu_517e5ae139e99a82\ftsrch.dll.mui "%wh-pf%\hu-HU"
move /Y %wh-temp-build%_it-it_f435d0e02cbbb0e4\winhlp32.exe.mui "%wh-pf%\it-IT"
move /Y %wh-temp-build%_it-it_f435d0e02cbbb0e4\ftsrch.dll.mui "%wh-pf%\it-IT"
move /Y %wh-temp-build%_ja-jp_965b4fed1fd6c2bf\winhlp32.exe.mui "%wh-pf%\ja-JP"
move /Y %wh-temp-build%_ja-jp_965b4fed1fd6c2bf\ftsrch.dll.mui "%wh-pf%\ja-JP"
move /Y %wh-temp-build%_ko-kr_39c52ca2124789d5\winhlp32.exe.mui "%wh-pf%\ko-KR"
move /Y %wh-temp-build%_ko-kr_39c52ca2124789d5\ftsrch.dll.mui "%wh-pf%\ko-KR"
move /Y %wh-temp-build%_nb-no_2257add6ea6cb591\winhlp32.exe.mui "%wh-pf%\nb-NO"
move /Y %wh-temp-build%_nb-no_2257add6ea6cb591\ftsrch.dll.mui "%wh-pf%\nb-NO"
move /Y %wh-temp-build%_nl-nl_2096f914eb98bf66\winhlp32.exe.mui "%wh-pf%\nl-NL"
move /Y %wh-temp-build%_nl-nl_2096f914eb98bf66\ftsrch.dll.mui "%wh-pf%\nl-NL"
move /Y %wh-temp-build%_pl-pl_66d35396d0bb2d1a\winhlp32.exe.mui "%wh-pf%\pl-PL"
move /Y %wh-temp-build%_pl-pl_66d35396d0bb2d1a\ftsrch.dll.mui "%wh-pf%\pl-PL"
move /Y %wh-temp-build%_pt-br_69273e3acf44c0fe\winhlp32.exe.mui "%wh-pf%\pt-BR"
move /Y %wh-temp-build%_pt-br_69273e3acf44c0fe\ftsrch.dll.mui "%wh-pf%\pt-BR"
move /Y %wh-temp-build%_pt-pt_6a090da6ceb430da\winhlp32.exe.mui "%wh-pf%\pt-PT"
move /Y %wh-temp-build%_pt-pt_6a090da6ceb430da\ftsrch.dll.mui "%wh-pf%\pt-PT"
move /Y %wh-temp-build%_ru-ru_b0ac1f6ab395bf06\winhlp32.exe.mui "%wh-pf%\ru-RU"
move /Y %wh-temp-build%_ru-ru_b0ac1f6ab395bf06\ftsrch.dll.mui "%wh-pf%\ru-RU"
move /Y %wh-temp-build%_sv-se_4ca709dfaabec961\winhlp32.exe.mui "%wh-pf%\sv-SE"
move /Y %wh-temp-build%_sv-se_4ca709dfaabec961\ftsrch.dll.mui "%wh-pf%\sv-SE"
move /Y %wh-temp-build%_tr-tr_f5b45426997acb52\winhlp32.exe.mui "%wh-pf%\tr-TR"
move /Y %wh-temp-build%_tr-tr_f5b45426997acb52\ftsrch.dll.mui "%wh-pf%\tr-TR"
move /Y %wh-temp-build%_zh-cn_c711722449b29d71\winhlp32.exe.mui "%wh-pf%\zh-CN"
move /Y %wh-temp-build%_zh-cn_c711722449b29d71\ftsrch.dll.mui "%wh-pf%\zh-CN"
move /Y %wh-temp-build%_zh-tw_cb0daf7a472379e1\winhlp32.exe.mui "%wh-pf%\zh-TW"
move /Y %wh-temp-build%_zh-tw_cb0daf7a472379e1\ftsrch.dll.mui "%wh-pf%\zh-TW"

move /Y %wh-temp-main%\winhlp32.exe "%wh-pf%"
move /Y %wh-temp-main%\ftsrch.dll "%wh-pf%"

rem Wordbreakers for Japanese and Thai when doing search indexes? https://docs.microsoft.com/en-us/windows/win32/search/understanding-language-resource-components
move /Y %wh-temp-main%\ftlx041e.dll "%wh-pf%"
move /Y %wh-temp-main%\ftlx0411.dll "%wh-pf%"

ren "%wh-pf%\ar-SA\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\cs-CZ\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\da-DK\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\de-DE\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\el-GR\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\en-US\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\es-ES\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\fi-FI\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\fr-FR\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\he-IL\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\hu-HU\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\it-IT\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\ja-JP\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\ko-KR\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\nb-NO\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\nl-NL\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\pl-PL\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\pt-BR\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\pt-PT\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\ru-RU\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\sv-SE\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\tr-TR\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\zh-CN\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\zh-TW\winhlp32.exe.mui" winhlp32_legacy.exe.mui
ren "%wh-pf%\winhlp32.exe" winhlp32_legacy.exe

del %temp%\winhlp32_legacy_install\Windows8.1-KB917607-x86.cab
rmdir %temp%\winhlp32_legacy_install /Q /S

echo. & echo. & echo. & echo Completed!
pause

:IsAdmin
REG.EXE query "HKU\S-1-5-19\Environment"
IF NOT %ERRORLEVEL% EQU 0 (
 CLS & ECHO Please run with Admin rights
 PAUSE & EXIT
)
GOTO:EOF
