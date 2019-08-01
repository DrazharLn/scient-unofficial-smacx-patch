# TODO
# custom image on launch -> AdvSplash
# banner image

!include "MUI2.nsh"

!define APP_NAME "SMAC/X Unofficial Patch"
#!define WEB_SITE "http://www.civgaming.net/forums/"
!define VERSION "02.00.00.00"
!define VERSION_SHRT "2.00"
!define REG_ROOT "HKLM"
!define REG_APP_PATH "Software\Microsoft\DirectPlay\Applications"
#!define REG_GOG_PATH "Software\GOG.com"
!define PATCH_FILES_PATH "..\##current patch files"

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "CompanyName"  "scient"
VIAddVersionKey "LegalCopyright"  "scient © 2013"
VIAddVersionKey "FileDescription"  "${APP_NAME}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

CRCCheck on
XPStyle on
SetCompressor /SOLID /FINAL LZMA 
RequestExecutionLevel admin
Name "${APP_NAME}"
Caption "${APP_NAME} v${VERSION_SHRT} Installer"
OutFile "SMACX_UP_v${VERSION_SHRT}_Installer.exe"

######################################################################

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

#!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
#!insertmacro MUI_LANGUAGE "French"
#!insertmacro MUI_LANGUAGE "German"

!insertmacro MUI_RESERVEFILE_LANGDLL

######################################################################

Function .onInit
	!insertmacro MUI_LANGDLL_DISPLAY

	# try to obtain install path
	ReadRegStr $0 ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "UnofficialPath"
	StrCmp $0 "" 0 default_path
	ReadRegStr $0 ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Planetary Pack" "Path"
	StrCmp $0 "" 0 default_path
	ReadRegStr $0 ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "Path"
	StrCmp $0 "" 0 default_path
	ReadRegStr $0 ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alien Crossfire" "Path"
	StrCmp $0 "" 0 default_path
	#ReadRegStr $0 ${REG_ROOT} "${REG_GOG_PATH}\GOGSIDMEIERSALPHACENTAURI" "Path"
	#StrCmp $0 "" 0 default_path
	#ReadRegStr $0 ${REG_ROOT} "${REG_GOG_PATH}\GOGSIDMEIERSALIENCROSSFIRE" "Path"
	#StrCmp $0 "" 0 default_path
	StrCpy $0 "$PROGRAMFILES\Sid Meier's Alpha Centauri" ; default path if can't read from registry
	default_path:
	StrCpy $INSTDIR $0
FunctionEnd

######################################################################

!define BCKPATH "$INSTDIR\_backup_v${VERSION_SHRT}"

Section -MainProgram
	SetShellVarContext current

	# fix incorrectly named images
	Rename "$INSTDIR\fungalpayld_sm.pcx" "$INSTDIR\fungpayld_sm.pcx" ; used by "#FUNGALMISSILE", "#FUNGMOTIZED"
	Rename "$INSTDIR\humref_sm.pcx" "$INSTDIR\humanref_sm.pcx" ; used by "#HOMELESS", "#HOMELESSONE"
	Rename "$INSTDIR\sporelnch_sm.pcx" "$INSTDIR\sporlnch_sm.pcx" ; used in a number of locations having to do with Spore Launchers

	# ini -> make sure ForceOldVoxelAlgorithm is set/reset
	WriteINIStr "$INSTDIR\Alpha Centauri.ini" PREFERENCES ForceOldVoxelAlgorithm 0

	# registry
	IfFileExists "$INSTDIR\fx" 0 +2
		WriteRegStr ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "Complete" "Yes" ; supressing #CDNOTFOUND -> fx/movies/voices folders
	WriteRegStr ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "UnofficialVer" "${VERSION_SHRT}" ; version of unofficial patch
	WriteRegStr ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "UnofficialPath" "$INSTDIR"

	# create new dir
	CreateDirectory "${BCKPATH}\fx" ; new dirs
	
	# trashing SafeDisc and useless files
	Delete "$INSTDIR\*.016" ; 00000407.016, 00000409.016
	Delete "$INSTDIR\*.256" ; 00000407.256, 00000409.256
	Delete "$INSTDIR\*.icd" ; Terran.icd, Terranx.icd
	Delete "$INSTDIR\clcd*.dll" ; clcd16.dll, clcd32.dll
	Delete "$INSTDIR\clokspl.exe"
	Delete "$INSTDIR\dplayerx.dll"
	Delete "$INSTDIR\drvmgt.dll"
	Delete "$INSTDIR\secdrv.sys"
	Delete "$INSTDIR\logfile.txt" ; general clean up
	
	# SMAC base : back up original files
	CopyFiles /SILENT "$INSTDIR\fx\CPU nn already linked.wav" "${BCKPATH}\fx" ; original wav
	CopyFiles /SILENT "$INSTDIR\fx\wpn missile launcher.wav" "${BCKPATH}\fx" ; original wav
	CopyFiles /SILENT "$INSTDIR\fx\wpn singularity laser.wav" "${BCKPATH}\fx" ; original wav
	CopyFiles /SILENT "$INSTDIR\terran.exe" "${BCKPATH}" ; original exe
	CopyFiles /SILENT "$INSTDIR\alpha.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\basename.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\believe.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\blurbs.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\concepts.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\credits.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\facedit.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\faction.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\flavor.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\gaians.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\help.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\hive.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\Holobook.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\interlude.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\jackal.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\labels.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\menu.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\monument.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\morgan.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\movlist.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\peace.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\scenario.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\script.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\spartans.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\system.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\techlongs.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\techshorts.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\tutor.txt" "${BCKPATH}" ; original txt
	CopyFiles /SILENT "$INSTDIR\univ.txt" "${BCKPATH}" ; original txt
	
	# SMAC base : copy over new
	SetOutPath "$INSTDIR\fx"
	File "${PATCH_FILES_PATH}\ALL\CPU nn already linked.wav" ; updated wav -> add 0.015 of a second of silence to end of wav with Sony Sound Forge 10
	File "${PATCH_FILES_PATH}\ALL\wpn missile launcher.wav" ; updated wav -> remixed stereo to mono (chuft), workaround for bug in sound/x.dll
	File "${PATCH_FILES_PATH}\ALL\wpn singularity laser.wav" ; updated wav -> remixed stereo to mono (chuft), workaround for bug in sound/x.dll
	
	SetOutPath "$INSTDIR"
	WriteUninstaller "$INSTDIR\SMACX_UP_v${VERSION_SHRT}_Uninstaller.exe" ; new exe
	File "${PATCH_FILES_PATH}\ALL\terran.exe" ; updated exe
	File "${PATCH_FILES_PATH}\ALL\logo.pcx" ; original pcx -> missing from some installs (shown at launch)
	File "${PATCH_FILES_PATH}\ALL\netcr_sm.pcx" ; new pcx -> missing (#NETCRASH), modified pcx from AA folder to include scan lines (BU) 
	File "${PATCH_FILES_PATH}\ALL\rdminldp_sm.pcx" ; new pcx -> missing (#PETERSOUT), modified pcx from AA folder to include scan lines (BU)
	File "${PATCH_FILES_PATH}\EN\SMAC\*.txt" ; updated txt -> SMAC txt corrections (Guvner) with bug fixes (scient)
	File "${PATCH_FILES_PATH}\ALL\OP_2000_XP\*.*" ; applying SMAC 2000/XP official patch supplemental files
	
	IfFileExists "$INSTDIR\terranx.exe" 0 smacx_end
		# SMACX base : back up original files
		CopyFiles /SILENT "$INSTDIR\terranx.exe" "${BCKPATH}" ; original exe
		CopyFiles /SILENT "$INSTDIR\alienIscript.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\alienuscript.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\alphax.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\angels.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\blurbsx.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\brian.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\caretake.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\conceptsx.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\cyborg.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\drone.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\fungboy.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\helpx.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\interludea.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\interludex.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\pirates.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\sid.txt" "${BCKPATH}" ; original txt
		CopyFiles /SILENT "$INSTDIR\usurper.txt" "${BCKPATH}" ; original txt
		
		# SMACX base : copy over new
		File "${PATCH_FILES_PATH}\ALL\terranx.exe" ; updated exe
		File "${PATCH_FILES_PATH}\EN\SMACX\*.txt" ; updated txt -> SMACX txt corrections (Guvner) with bug fixes (scient)
		File "${PATCH_FILES_PATH}\ALL\OP_SMACX_20\*.*" ; applying SMACX 2.0 official patch supplemental files
	smacx_end:
/*
StrCmp $LANGUAGE ${LANG_ENGLISH} 0 DE_specific
#Goto end_lang
 DE_specific:
 StrCmp $LANGUAGE ${LANG_GERMAN} 0 FR_specific
	File "${PATCH_FILES_PATH}\DE\blurbs.txt" ; updated
	File "${PATCH_FILES_PATH}\DE\script.txt" ; updated
	IfFileExists "$INSTDIR\terranx.exe" 0 end_lang 
		File "${PATCH_FILES_PATH}\DE\blurbsx.txt" ; updated
		File "${PATCH_FILES_PATH}\DE\movlistx.txt" ; new 
	Goto end_lang
 FR_specific:
 StrCmp $LANGUAGE ${LANG_FRENCH} 0 end_lang 
	File "${PATCH_FILES_PATH}\FR\blurbs.txt" ; updated
	File "${PATCH_FILES_PATH}\FR\script.txt" ; updated
	IfFileExists "$INSTDIR\terranx.exe" 0 end_lang
		File "${PATCH_FILES_PATH}\FR\blurbsx.txt" ; updated
		File "${PATCH_FILES_PATH}\FR\movlistx.txt" ; new
end_lang:
*/
SectionEnd

######################################################################

Section InstallFont
	CopyFiles /SILENT "$INSTDIR\ARIAL*.ttf" "${BCKPATH}" ; back up original arial ttf
	Delete "$INSTDIR\ARIAL*.ttf"
	Delete "$INSTDIR\*.fot"
	SetOutPath "$INSTDIR"
	File "${PATCH_FILES_PATH}\ALL\FONT\*.ttf"
	ReadRegStr $0 HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Alpha Centauri (TrueType)"
	StrCmp $0 "ALPHC___.ttf" exit 0
		SetOutPath "$FONTS"
		File "${PATCH_FILES_PATH}\ALL\ALPHC___.ttf"
		
		System::Call "gdi32::AddFontResource(t 'ALPHC___.ttf')"
		WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Alpha Centauri (TrueType)" "ALPHC___.ttf"
	exit:
SectionEnd

######################################################################

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
FunctionEnd

Section "Uninstall"
 Delete "$INSTDIR\SMACX_UP_v${VERSION_SHRT}_Uninstaller.exe"
 
 CopyFiles /SILENT "${BCKPATH}\*.*" "$INSTDIR"
 
 Delete "$INSTDIR\netcr_sm.pcx"
 Delete "$INSTDIR\rdminldp_sm.pcx"
 Delete "$INSTDIR\movlistx.txt"
 RMDir /r "${BCKPATH}"
 DeleteRegValue ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "UnofficialVer"
 DeleteRegValue ${REG_ROOT} "${REG_APP_PATH}\Sid Meier's Alpha Centauri" "UnofficialPath"
 
SectionEnd

######################################################################
