{设置TreeView图标}
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

//初始化控件属性
constructor TTreeViewImage.Create(CustomTreeView: TTreeView);
begin
  if CustomTreeView<>nil then
  begin
    TreeView := CustomTreeView;
    TreeView.OnCollapsed := TreeViewCollapsed;
    TreeView.OnExpanded := TreeViewExpanded;
  end;
end;

//释放控件资源
destructor TTreeViewImage.Destroy;
begin
  inherited;
end;

//设置收合图像
procedure TTreeViewImage.TreeViewCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 0;
end;

//设置展开图像
procedure TTreeViewImage.TreeViewExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 1;
end;

end.

 