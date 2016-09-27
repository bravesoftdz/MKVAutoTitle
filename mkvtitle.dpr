program mkvtitle;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {formMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
