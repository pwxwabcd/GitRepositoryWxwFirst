unit RingFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TRingForm = class(TForm)
    pnlZy: TPanel;
    lblZy: TLabel;
    lblZNo: TLabel;
    edtMobileNumber: TEdit;
    bvlDept: TBevel;
    btnSave: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edtRingName: TEdit;
    Label2: TLabel;
    edtRingPathWWW: TEdit;
    Label3: TLabel;
    edtRingMobileType: TEdit;
    Label4: TLabel;
    edtPlus: TEdit;
    Label5: TLabel;
    mmContent: TMemo;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    edtCopyMobileName: TEdit;
    lblZContent: TLabel;
    edtCopyWriteTime: TEdit;
    Label7: TLabel;
    edtCopyRingName: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitEditOrder;
  end;

var
  RingForm: TRingForm;

implementation
uses
  CommonDM, PubFun, PubOtherFun, RingManageFrm, MainFrm;
{$R *.dfm}

//������Ϣ
procedure TRingForm.btnSaveClick(Sender: TObject);
var
  RingId: Integer;
  MobileNumber: string;
  Content: string;
begin
  RingId := RingForm.HelpContext;
  MobileNumber := edtMobileNumber.Text;
  Content := UrlEncode(Utf8encode(mmContent.Text));
  if MobileNumber='' then
  begin
    MessageBox(Self.Handle,'�������ֻ���!','����',mb_Ok+mb_IconWarning);
    Exit;
  end;
  if SendRing(RingId,MobileNumber,Content) then
  begin
    MessageBox(Self.Handle,'��Ϣ���ͳɹ�!','��ʾ',mb_Ok+mb_IconInformation);
    RingForm.ModalResult := mrOk;
  end
  else
    MessageBox(Self.Handle,'��Ϣ����ʧ��!','����',mb_Ok+mb_IconWarning);
end;

//��ʼ��
procedure TRingForm.FormShow(Sender: TObject);
begin
  RingForm.Caption := '��������';
  edtCopyMobileName.Text := GlobalCopyMobileName;
  edtCopyWriteTime.Text := GlobalCopyWriteTime;
  edtCopyRingName.Text := GlobalCopyRingName;
end;

//��ʼ���û�
procedure TRingForm.InitEditOrder;
var
  UListItem: TListItem;
begin
  UListItem := RingManageForm.lvRing.Selected;
  with UListItem do
  begin
    edtRingName.Text := Caption;
    edtRingPathWWW.Text := SubItems[0];
    edtRingMobileType.Text := SubItems[1];
    edtPlus.Text := SubItems[2];
    mmContent.Text := '��㲥�ĸ���' + Caption;
    RingForm.HelpContext := Integer(Data);
  end;
end;

end.
