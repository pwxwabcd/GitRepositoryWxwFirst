{����TreeViewͼ��}
unit TreeViewImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, QuickRpt, QRCtrls;

type
  TTreeViewImage = class(TComponent)
  private
    { Private declarations }
    TreeView: TTreeView;
    procedure TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(CustomTreeView: TTreeView); reintroduce;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TTreeViewImage]);
end;

//��ʼ���ؼ�����
constructor TTreeViewImage.Create(CustomTreeView: TTreeView);
begin
  if CustomTreeView<>nil then
  begin
    TreeView := CustomTreeView;
    TreeView.OnCollapsed := TreeViewCollapsed;
    TreeView.OnExpanded := TreeViewExpanded;
  end;
end;

//�ͷſؼ���Դ
destructor TTreeViewImage.Destroy;
begin
  inherited;
end;

//�����պ�ͼ��
procedure TTreeViewImage.TreeViewCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 0;
end;

//����չ��ͼ��
procedure TTreeViewImage.TreeViewExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 1;
end;

end.

 