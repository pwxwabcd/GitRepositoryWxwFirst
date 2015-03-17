{����ListView}
unit ListViewCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TListViewCompare = class(TComponent)
  private
    { Private declarations }
    ListView: TListView;
    SortType: Boolean;
    ColumnToSort: Integer;
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(CustomListView: TListView); reintroduce;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TListViewCompare]);
end;

//��ʼ���ؼ�����
constructor TListViewCompare.Create(CustomListView: TListView);
begin
  ListView := CustomListView;
  ListView.OnColumnClick := ListViewColumnClick;
  ListView.OnCompare := ListViewCompare;
end;

//�ͷſؼ���Դ
destructor TListViewCompare.Destroy;
begin
  inherited;
end;

//������
procedure TListViewCompare.ListViewColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  SortType := not SortType;
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

//������Ƚ�
procedure TListViewCompare.ListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else
  begin
   ix := ColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
  end;
  if not SortType then
    Compare := -Compare;
end;

end.

