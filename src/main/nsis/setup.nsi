;--------------------------------
;Include Modern UI
  !include "MUI2.nsh"
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "logo.bmp"
  !define MUI_HEADERIMAGE_RIGHT
;--------------------------------
;General

  ;Name and file
  Name "${PROG_NAME} installer"
  OutFile "${OUTDIR}\..\${PROG_NAME}-setup-${VERSION}.exe"
  BrandingText "${PROG_NAME} setup ${VERSION}"
  Unicode True

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\Programs\${PROG_NAME}"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\${PROG_NAME}" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_LICENSE "license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"


Function .onInit
	${If} ${FileExists} `$INSTDIR\*.*`
		MessageBox MB_YESNO "Product is already installed. Do you want to uninstall it first?" IDYES true IDNO false
		true:
			ExecWait "$INSTDIR\uninstall.exe /S"
			Goto next
		false:
			Abort
		next:
	${EndIf}
FunctionEnd

;--------------------------------
;Installer Sections

Section "${PROG_NAME}" SecInstall

	SetOutPath "$INSTDIR\bin"
	File /nonfatal /a /r "${OUTDIR}\bin\"
	
	SetOutPath "$INSTDIR\lib"
	File /nonfatal /a /r "${OUTDIR}\lib\"
	
	SetOutPath "$INSTDIR\conf"
	File /nonfatal /a /r "${OUTDIR}\conf\"
  
	;Store installation folder
	WriteRegStr HKCU "Software\${PROG_NAME}" "" $INSTDIR
  
	;Create uninstaller
	WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Java" SecJavaInstall
	
	SetOutPath "$INSTDIR\jre"
	File /nonfatal /a /r "${OUTDIR}\jre\"
	
SectionEnd

;--------------------------------
;Descriptions

;Language strings
LangString DESC_SecInstall ${LANG_ENGLISH} "${PROG_NAME} install section"

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecInstall} $(DESC_SecInstall)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"
  Delete "$INSTDIR\Uninstall.exe"
  DeleteRegKey /ifempty HKCU "Software\${PROG_NAME}"
  RMDir /r "$INSTDIR"
SectionEnd