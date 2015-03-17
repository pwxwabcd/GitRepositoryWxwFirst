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
//��������
procedure TWaitForm.FormShow(Sender: TObject);
begin
  anmtWait.Active := True;
end;

//�رն���
procedure TWaitForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  anmtWait.Active := False;
end;

//������ʾ��Ϣ
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

//�ֱ��ʵ���
procedure TWaitForm.FormCreate(Sender: TObject);
begin
  //FormScale(self);
end;

end.
