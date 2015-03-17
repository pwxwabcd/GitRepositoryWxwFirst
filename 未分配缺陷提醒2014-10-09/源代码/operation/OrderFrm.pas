unit OrderFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TOrderForm = class(TForm)
    pnlZy: TPanel;
    lblZy: TLabel;
    lblZNo: TLabel;
    lblZContent: TLabel;
    edtMobileNumber: TEdit;
    bvlDept: TBevel;
    btnSave: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edtIsRead: TEdit;
    edtWriteTime: TEdit;
    Label2: TLabel;
    edtIsDeal: TEdit;
    Label3: TLabel;
    edtRingName: TEdit;
    Label4: TLabel;
    edtPinPai: TEdit;
    btnCopy: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitEditOrder;
  end;

var
  OrderForm: TOrderForm;

implementation
uses
  CommonDM, PubFun, PubOtherFun, OrderManageFrm, MainFrm;
{$R *.dfm}

//已处理
procedure TOrderForm.btnSaveClick(Sender: TObject);
var
  HbDxId: Integer;
  UListItem: TListItem;
begin
  HbDxId := OrderForm.HelpContext;
  if UpdateDealWithOrder(HbDxId) then
  begin
    if (OrderManageForm<>nil) and (MainForm.Visible) then
    begin
      UListItem := OrderManageForm.lvOrder.Selected;
      if UListItem<>nil then
        with UListItem do
        begin
          SubItems[3] := '已阅读';
          SubItems[4] := '已处理';
        end;
    end;
  end
  else
  begin
    MessageBox(Self.Handle,'保存信息处理状态失败!','警告',mb_Ok+mb_IconWarning);
    Exit;
  end;
end;

//初始化
procedure TOrderForm.FormShow(Sender: TObject);
begin
  OrderForm.Caption := '定制信息';
end;

//初始化用户
procedure TOrderForm.InitEditOrder;
var
  UListItem: TListItem;
begin
  UListItem := OrderManageForm.lvOrder.Selected;
  with UListItem do
  begin
    edtMobileNumber.Text := Caption;
    edtWriteTime.Text := SubItems[2];
    edtIsRead.Text := SubItems[3];
    edtIsDeal.Text := SubItems[4];
    edtRingName.Text := SubItems[0];
    edtPinPai.Text := SubItems[1];
    OrderForm.HelpContext := Integer(Data);
  end;
end;

//稍后处理
procedure TOrderForm.btnCancelClick(Sender: TObject);
var
  HbDxId: Integer;
  UListItem: TListItem;
begin
  HbDxId := OrderForm.HelpContext;
  if UpdateReadOrder(HbDxId) then
  begin
    if (OrderManageForm<>nil) and (MainForm.Visible) then
    begin
      UListItem := OrderManageForm.lvOrder.Selected;
      if UListItem<>nil then
        with UListItem do
        begin
          SubItems[3] := '已阅读';
          SubItems[4] := '未处理';
        end;
    end;
  end
  else
  begin
    MessageBox(Self.Handle,'保存信息阅读状态失败!','警告',mb_Ok+mb_IconWarning);
    Exit;
  end;
end;

//复制信息
procedure TOrderForm.btnCopyClick(Sender: TObject);
begin
  GlobalHbDxId := OrderForm.HelpContext;
  GlobalCopyMobileName := edtMobileNumber.Text;
  GlobalCopyWriteTime := edtWriteTime.Text;
  GlobalCopyRingName := edtRingName.Text;
end;

end.
