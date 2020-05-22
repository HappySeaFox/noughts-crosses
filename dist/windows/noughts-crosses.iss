#define MyAppName "Noughts and Crosses"
#define MyAppPublisher "Dmitry Baryshev"
#define MyAppURL "https://github.com/smoked-herring/noughts-crosses"
#define MyAppVersion "1.0.0"

[Setup]
AppId={{67F0D2E6-84C7-4936-A992-1183A44831E9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}/releases
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=LICENSE.txt
OutputDir=.
OutputBaseFilename=noughts-crosses-setup-{#MyAppVersion}
SetupIconFile=noughts-crosses.ico
Compression=lzma
SolidCompression=yes
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\noughts-crosses.exe
MinVersion=0,6.0
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "AAAenglish"; MessagesFile: "compiler:Default.isl"
Name: "BrazilianPortuguesexisl"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "Catalanxisl"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "Corsicanxisl"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "Czechxisl"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "Danishxisl"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "Dutchxisl"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "Finnishxisl"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "Frenchxisl"; MessagesFile: "compiler:Languages\French.isl"
Name: "Germanxisl"; MessagesFile: "compiler:Languages\German.isl"
Name: "Hebrewxisl"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "Italianxisl"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "Japanesexisl"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "Norwegianxisl"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "Polishxisl"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "Portuguesexisl"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "Russianxisl"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "Slovenianxisl"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "Spanishxisl"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "Turkishxisl"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "Ukrainianxisl"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; OnlyBelowVersion: 0,6.1

[Files]
Source: "LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "noughts-crosses.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "platforms/*"; DestDir: "{app}/platforms"; Flags: ignoreversion recursesubdirs
Source: "QtQuick/*"; DestDir: "{app}/QtQuick"; Flags: ignoreversion recursesubdirs
Source: "QtQuick.2/*"; DestDir: "{app}/QtQuick.2"; Flags: ignoreversion recursesubdirs
Source: "scenegraph/*"; DestDir: "{app}/scenegraph"; Flags: ignoreversion recursesubdirs
Source: "D3Dcompiler_47.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "libEGL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "libGLESV2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "opengl32sw.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5Core.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5Gui.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5Network.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5Qml.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5Quick.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5QuickControls2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Qt5QuickTemplates2.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\noughts-crosses.exe"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\noughts-crosses.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\noughts-crosses.exe"; Tasks: quicklaunchicon

[Registry]

[Run]

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
  Uninstall: String;
  UninstallQuery : String;
begin
  UninstallQuery := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  if (CurStep = ssInstall) then begin
    if RegQueryStringValue(HKLM, UninstallQuery, 'UninstallString', Uninstall)
      or RegQueryStringValue(HKCU, UninstallQuery, 'UninstallString', Uninstall) then begin
    Uninstall := RemoveQuotes(Uninstall)
    if (FileExists(Uninstall)) AND (not Exec(RemoveQuotes(Uninstall), '/VERYSILENT', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode)) then begin
      MsgBox(SysErrorMessage(ResultCode), mbCriticalError, MB_OK);
      Abort();
    end;
  end;
end;
end;
