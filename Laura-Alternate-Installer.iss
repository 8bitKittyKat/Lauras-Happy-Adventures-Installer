;  Laura's Happy Adventures Alternate Installer V0.0.1
;  Created 2024 8bitKittyKat.
;  Adapted from Hype - The Time Quest Alternate Installer V0.0.5 by Suicide Machine.
;  Based on a code of Triangle717's Lego Racer Alternative Installer.
;  <http://triangle717.wordpress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, 
; this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define MyAppInstallerName "Laura's Happy Adventures"
#define MyAppInstallerVersion ""
#define MyAppName "Laura's Happy Adventures"
#define MyAppNameNoR "Laura's Happy Adventures"
#define MyAppVerName "Laura's Happy Adventures"
#define MyAppPublisher "Ubisoft"
#define MyAppExeName "Laura.exe"

[Setup]
AppID={#MyAppInstallerName}{#MyAppInstallerVersion}
AppName={#MyAppName}
AppVerName={#MyAppVerName}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1999 {#MyAppPublisher}
;LicenseFile=license.md
; Start menu/screen and Desktop shortcuts
DefaultDirName={sd}\Games\{#MyAppNameNoR}
DefaultGroupName=Ubisoft\{#MyAppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Laura.ico
WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=bin
OutputBaseFilename={#MyAppNameNoR} Alternate Installer
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Laura.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=393715712
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finish.
PrivilegesRequired=admin
ShowLanguageDialog=yes
ShowUndisplayableLanguages=yes
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName} {#MyAppInstallerVersion}
; WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
English.DiskSpaceMBLabel=At least 375 MB of free disk space is required.

[Types]
Name: "Full"; Description: "Full Installation"; Flags: iscustom  

[Components]
Name: "base"; Description: "Game assets (required)"; Types: Full; Flags: fixed; ExtraDiskSpaceRequired: 393715712 
Name: "language"; Description: "Language files"; Types: Full;  Flags: fixed
Name: "language\english"; Description: "English"; Types: Full; Flags: exclusive

[Files]
;Source: "back.bmp"; DestDir: "{tmp}"; Flags: deleteafterinstall dontcopy noencryption

; Root folder
Source: "{code:GetSourceDrive}DSETUP.DLL"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}DSETUP16.DLL"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}DSETUP32.DLL"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Laura.ico"; DestDir: "{app}"; Flags: external ignoreversion

; Game folders
Source: "{code:GetSourceDrive}DLL\*"; DestDir: "{app}\DLL\"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}GameData\*"; DestDir: "{app}\GameData\"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}GameData\World\Levels\*"; DestDir: "{app}\GameData\World\Levels"; Flags: external ignoreversion recursesubdirs
Source: "{code:GetSourceDrive}GameData\World\Sound\*"; DestDir: "{app}\GameData\World\Sound"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}InstData\*"; DestDir: "{app}\InstData\"; Flags: external ignoreversion

; Localization - English
Source: "{code:GetSourceDrive}LangData\Us\World\Sound_Memory\*"; DestDir: "{app}\GameData\World\Sound\"; Flags: external ignoreversion recursesubdirs; Components: language\english 
Source: "{code:GetSourceDrive}LangData\Us\World\Levels\*"; DestDir: "{app}\GameData\World\Levels\"; Flags: external ignoreversion recursesubdirs; Components: language\english

; EXE folder
Source: "{code:GetSourceDrive}EXE\GLI.ini"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}EXE\D3D\Laura.exe"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}EXE\UbiConfig\*"; DestDir: "{app}"; Flags: external ignoreversion

; Ubisoft files to Windows directory
Source: "{code:GetSourceDrive}DSETUP.DLL"; DestDir: "{win}\UbiSoft"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}DSETUP16.DLL"; DestDir: "{win}\UbiSoft"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}DSETUP32.DLL"; DestDir: "{win}\UbiSoft"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}SetupUbi.exe"; DestDir: "{win}\UbiSoft"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}InstData\strings.eng"; DestDir: "{win}\UbiSoft"; Flags: external ignoreversion; Components: language\english
 
; Install stuff
Source: "ubi.ini"; DestDir: "{win}\UbiSoft"; Flags: ignoreversion uninsneveruninstall


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Laura.ico";Comment: "Laura's Happy Adventures";
Name: "{group}\Configure the game"; Filename: "{app}\Ubiconfig.exe"; IconFilename: "{app}\Laura.ico"; Comment: "Configure the game";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Laura.ico";
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Laura.ico"; Comment: "Laura's Happy Adventures"; Tasks: desktopicon


[Tasks]
; Create a desktop icon, run with administrator rights
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}";

[INI]
Filename: "{win}\UbiSoft\ubi.ini"; Section: "LAURA"; Key: "Directory"; String: "{app}";


[UninstallDelete]
Type: files; Name: "{app}\{#MyAppExeName}"

[Dirs]
; Created to ensure the save games are not removed (which should never ever happen).
Name: "{app}\GameData\SaveGame"; Flags: uninsneveruninstall

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up 
// and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;

//Display warning
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectTasks then
  begin
      MsgBox('!!! WARNING !!!'+ #13#10 +
      'This installer replaces ubi.ini in C:\Windows\UbiSoft' + #13#10 +
      'If you have other games that use Ubisoft install system (e.g. Rayman 2)' + #13#10 +
      'make sure to back up your ubi.ini file, before continuing.', mbInformation, MB_OK)
  end;
end;
