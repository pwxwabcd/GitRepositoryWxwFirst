unit WaitFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TWaitForm = class(TForm)
    pnlCenter: TPanel;
    anmtWait: TAnimate;
    lblInfo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ShowInfo(InfoStr: string; HostForm: TForm=nil);
  end;

var
  WaitForm: TWaitForm;

implementation
{$R *.dfm}
//开启动画
procedure TWaitForm.FormShow(Sender: TObject);
begin
  anmtWait.Active := True;
end;

//关闭动画
procedure TWaitForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  anmtWait.Active := False;
end;

//设置提示信息
procedure TWaitForm.ShowInfo(InfoStr: string; HostForm: TForm=nil);
begin
  if HostForm<>nil then
    HostForm.Update;
  if not WaitForm.Visible then
    WaitForm.Show;
  lblInfo.Width := 224;
  lblInfo.Caption := InfoStr+'...';
  WaitForm.Update;
end;

//分辨率调节
procedure TWaitForm.FormCreate(Sender: TObject);
begin
  //FormScale(self);
end;

end.
