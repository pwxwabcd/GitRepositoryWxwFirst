unit RingManageFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls;

type
  TRingManageForm = class(TForm)
    CoolBar: TCoolBar;
    ToolBar: TToolBar;
    tbtnZy: TToolButton;
    tbtnEdit: TToolButton;
    tbtnSepFirst: TToolButton;
    tbtnClose: TToolButton;
    lvRing: TListView;
    Panel1: TPanel;
    Label1: TLabel;
    edtRingName: TEdit;
    cbPlus: TCheckBox;
    tbtnQuery: TToolButton;
    tbtnExport: TToolButton;
    Label2: TLabel;
    edtRingPathWWW: TEdit;
    rgPlus: TRadioGroup;
    Label3: TLabel;
    edtRingMobileType: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnQueryClick(Sender: TObject);
    procedure tbtnExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RingManageForm: TRingManageForm;

implementation
uses
  CommonDM, PubFun, ListViewCompare, PubOtherFun, RingFrm;
{$R *.dfm}
//�رմ���
procedure TRingManageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  RingManageForm := nil;
end;

//�رմ���
procedure TRingManageForm.tbtnCloseClick(Sender: TObject);
begin
  RingManageForm.Close;
end;

//��ʼ��
procedure TRingManageForm.FormShow(Sender: TObject);
var
  SqlString: string;
begin
  SqlString := 'select RingId,RingName,RingPathWWW,Plus,RingMobileTypes '
      +'from NewMobile.dbo.MMS_Ring '
      +'where RingLei=''L106'' '
      +'order by RingId';
  //QueryRing(lvRing, SqlString);
end;

//�޸�
procedure TRingManageForm.tbtnEditClick(Sender: TObject);
var
  UListItem: TListItem;
begin
  UListItem := lvRing.Selected;
  if UListItem=nil then
    Exit;
  RingForm := TRingForm.Create(nil);
  with RingForm do
  begin
    InitEditOrder;
    HelpKeyword := 'Edit';
    ShowModal;
    Free;
  end;
  RingForm := nil;
end;

//����
procedure TRingManageForm.FormCreate(Sender: TObject);
begin
  TListViewCompare.Create(lvRing);
end;

//��ѯ
procedure TRingManageForm.tbtnQueryClick(Sender: TObject);
var
  SqlString,QueryRingName,QueryRingPathWWW,QueryRingMobileType: string;
  QueryPlus: Integer;
begin
  SqlString := 'select RingId,RingName,RingPathWWW,Plus,RingMobileTypes,RingTypesId,RingLeiName '
      +'from NewMobile.dbo.MMS_Ring ';
  QueryRingName := '%'+edtRingName.Text+'%';
  QueryRingPathWWW := '%'+edtRingPathWWW.Text+'%';
  QueryRingMobileType := '%'+edtRingMobileType.Text+'%';
  SqlString := SqlString + 'where RingName like '''
    + QueryRingName + ''' and RingPathWWW like ''' + QueryRingPathWWW
    + ''' and RingMobileTypes like ''' + QueryRingMobileType + ''' ';
  if cbPlus.Checked then
  begin
    QueryPlus := rgPlus.ItemIndex;
    SqlString := SqlString + 'and Plus=' + IntToStr(QueryPlus) + ' ';
  end;
  SqlString := SqlString + 'order by RingId';
  QueryRing(lvRing,SqlString);
end;

//��������
procedure TRingManageForm.tbtnExportClick(Sender: TObject);
begin
  ListViewToExcel(lvRing);
end;

end.
