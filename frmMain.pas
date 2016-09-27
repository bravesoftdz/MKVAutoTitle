unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IniFiles, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.ComCtrls;

type
  TformMain = class(TForm)
    edWorkDir: TJvDirectoryEdit;
    edMkvEditDir: TJvDirectoryEdit;
    lblWorkDir: TLabel;
    lblMkvEditPath: TLabel;
    btnStart: TButton;
    objStatusBar: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edWorkDirChange(Sender: TObject);
    procedure edMkvEditDirChange(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    szBasePath, szWorkPath, szMkvEditPath: String;
    iniSource: TIniFile;
    procedure ValidateMkvEdit;
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses ShellAPI;

{$R *.dfm}

procedure TformMain.ValidateMkvEdit;
begin
  if not FileExists(szMkvEditPath + '\mkvpropedit.exe')
    then
      begin
        btnStart.Enabled := false;
        edMkvEditDir.SetFocus();
        objStatusBar.SimpleText := 'mkvpropedit.exe not found'
      end
    else
      begin
        btnStart.Enabled := true;
        btnStart.SetFocus();
        objStatusBar.SimpleText := 'Ready'
      end;
end;

procedure TformMain.btnStartClick(Sender: TObject);
var
  listFiles: TStrings;
  SRec: TSearchRec;
  i, iErrors: Integer;
begin
  iErrors := 0;
  listFiles := TStringList.Create();
  try
    if FindFirst(szWorkPath + '\*.mkv', faNormal, SRec) = 0 then
      begin
        repeat
          listFiles.Add(SRec.Name);
        until FindNext(SRec) <> 0;
        FindClose(SRec);
      end;
    if listFiles.Count > 0
      then
        begin
          for i := 0 to listFiles.Count-1 do
            begin
              objStatusBar.SimpleText := 'Processing ' + listFiles[i];
              if ShellExecute(Handle, 'open', PChar(szMkvEditPath + '\mkvpropedit.exe'), PChar('"' + listFiles[i] + '"' + ' --edit info --set "title=' + Copy(listFiles[i], 0, LastDelimiter('.',listFiles[i]) - 1) + '"'), PChar(szWorkPath), SW_HIDE) < 33 then Inc(iErrors);
            end;
            objStatusBar.SimpleText := IntToStr(listFiles.Count) + ' file(s) processed - ' + IntToStr(iErrors) + ' error(s)';
        end
      else objStatusBar.SimpleText := 'No files found';
  finally
    listFiles.Free();
  end;
end;

procedure TformMain.edMkvEditDirChange(Sender: TObject);
begin
  szMkvEditPath := edMkvEditDir.Directory;
  iniSource.WriteString('Paths', 'mkvtoolnix', szMkvEditPath);
  ValidateMkvEdit();
end;

procedure TformMain.edWorkDirChange(Sender: TObject);
begin
  szWorkPath := edWorkDir.Directory;
  iniSource.WriteString('Paths', 'workdir', szWorkPath);
end;

procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  iniSource.UpdateFile();
  iniSource.Free();
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  szBasePath := ExtractFileDir(ParamStr(0));
  iniSource := TIniFile.Create(szBasePath + '\mkvtitle.ini');
  szWorkPath := iniSource.ReadString('Paths', 'workdir', szBasePath);
  szMkvEditPath := iniSource.ReadString('Paths', 'mkvtoolnix', '');
  edWorkDir.Directory := szWorkPath;
  edMkvEditDir.Directory := szMkvEditPath;
  ValidateMkvEdit();
end;

end.

