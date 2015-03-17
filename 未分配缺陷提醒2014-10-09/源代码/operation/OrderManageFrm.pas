unit OrderManageFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls;

type
  TOrderManageForm = class(TForm)
    CoolBar: TCoolBar;
    ToolBar: TToolBar;
    tbtnZy: TToolButton;
    tbtnEdit: TToolButton;
    tbtnDel: TToolButton;
    tbtnSepFirst: TToolButton;
    tbtnClose: TToolButton;
    lvOrder: TListView;
    Panel1: TPanel;
    Label1: TLabel;
    edtMobileNumber: TEdit;
    cbMyInt: TCheckBox;
    cbMyLittle: TCheckBox;
    tbtnQuery: TToolButton;
    rgMyInt: TRadioGroup;
    rgMyLittle: TRadioGroup;
    tbtnExport: TToolButton;
    Label2: TLabel;
    edtPinPai: TEdit;
    cbWriteTime: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    dtpBeginWriteTime: TDateTimePicker;
    dtpEndWriteTime: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnQueryClick(Sender: TObject);
    procedure tbtnExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrderManageForm: TOrderManageForm;

implementation
uses
  CommonDM, PubFun, ListViewCompare, PubOtherFun, OrderFrm;
{$R *.dfm}
//关闭窗口
procedure TOrderManageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  OrderManageForm := nil;
end;

//关闭窗口
procedure TOrderManageForm.tbtnCloseClick(Sender: TObject);
begin
  OrderManageForm.Close;
end;

//初始化
procedure TOrderManageForm.FormShow(Sender: TObject);
begin
  ShowOrder(lvOrder);
  dtpBeginWriteTime.DateTime := Now;
  dtpEndWriteTime.DateTime := Now;
end;

//修改
procedure TOrderManageForm.tbtnEditClick(Sender: TObject);
var
  UListItem: TListItem;
begin
  UListItem := lvOrder.Selected;
  if UListItem=nil then
    Exit;
  OrderForm := TOrderForm.Create(nil);
  with OrderForm do
  begin
    InitEditOrder;
    HelpKeyword := 'Edit';
    ShowModal;
    Free;
  end;
  OrderForm := nil;
end;

//删除
procedure TOrderManageForm.tbtnDelClick(Sender: TObject);
var
  UListItem: TListItem;
  i,HbDxId: Integer;
begin
  if lvOrder.SelCount=0 then
    Exit;
  if MessageBox(Self.Handle,'您确定要删除所选信息吗？','询问',
    mb_OkCancel+mb_IconQuestion)=Id_Cancel then
    Exit;
  for i := lvOrder.Items.Count-1 downto 0 do
  begin
    UListItem := lvOrder.Items[i];
    if not UListItem.Selected then
      Continue;
    with UListItem do
      HbDxId := Integer(Data);
    if DeleteOrder(HbDxId) then
        UListItem.Delete
    else
    begin
      MessageBox(Self.Handle,'删除订制信息失败!','警告',mb_Ok+mb_IconWarning);
      Exit;
    end;
  end;
end;

//设置
procedure TOrderManageForm.FormCreate(Sender: TObject);
begin
  TListViewCompare.Create(lvOrder);
end;

//查询
procedure TOrderManageForm.tbtnQueryClick(Sender: TObject);
var
  SqlString,QueryMobileNumber,QueryPinPai,BeginWriteTime,EndWriteTime: string;
  QueryMyInt,QueryMyLittle: Integer;
begin
  SqlString := 'select Id,MobileNumber,RingName,PinPai,WriteTime,IsRead,IsDeal '
      +'from zhenchang_info ';
  QueryMobileNumber := '%'+edtMobileNumber.Text+'%';
  QueryPinPai := '%'+edtPinPai.Text+'%';
  SqlString := SqlString + 'where MobileNumber like ''' + QueryMobileNumber + ''' ';
  if edtPinPai.Text<>'' then
    SqlString := SqlString + 'and PinPai like ''' + QueryPinPai + ''' ';
  if cbWriteTime.Checked then
  begin
    BeginWriteTime := DateToStr(dtpBeginWriteTime.Date);
    EndWriteTime := DateToStr(dtpEndWriteTime.Date) + ' 23:59:59';
    SqlString := SqlString + 'and WriteTime>=''' + BeginWriteTime
      + ''' and WriteTime<=''' + EndWriteTime + ''' ';
  end;
  if cbMyInt.Checked then
  begin
    QueryMyInt := rgMyInt.ItemIndex;
    SqlString := SqlString + 'and IsRead=' + IntToStr(QueryMyInt) + ' ';
  end;
  if cbMyLittle.Checked then
  begin
    QueryMyLittle := rgMyLittle.ItemIndex;
    SqlString := SqlString + 'and IsDeal=' + IntToStr(QueryMyLittle) + ' ';
  end;
  SqlString := SqlString + 'order by Id desc';
  QueryOrder(lvOrder,SqlString);
end;

//导出数据
procedure TOrderManageForm.tbtnExportClick(Sender: TObject);
begin
  ListViewToExcel(lvOrder);
end;

end.
