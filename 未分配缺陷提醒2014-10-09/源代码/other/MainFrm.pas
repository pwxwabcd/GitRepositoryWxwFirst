unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, ToolWin, Menus, StdActns, ActnList, ShellApi,
  LMDCustomComponent, LMDWndProcComponent, LMDTrayIcon, lmdcont;

type
  TMainForm = class(TForm)
    sbInfo: TStatusBar;
    mmMain: TMainMenu;
    mmiSystem: TMenuItem;
    mmiLogin: TMenuItem;
    mmiSystemSep: TMenuItem;
    mmiExit: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    imgMain: TImage;
    ActionList: TActionList;
    WindowCascade: TWindowCascade;
    WindowTileHorizontal: TWindowTileHorizontal;
    WindowTileVertical: TWindowTileVertical;
    WindowMinimizeAll: TWindowMinimizeAll;
    mmiOperation: TMenuItem;
    LMDTrayIcon: TLMDTrayIcon;
    LMDImageList1: TLMDImageList;
    PopupMenu1: TPopupMenu;
    pmiShow: TMenuItem;
    N2: TMenuItem;
    pmiExit: TMenuItem;
    HintTimer: TTimer;
    mmiOrder: TMenuItem;
    mmiRing: TMenuItem;
    procedure mmiHelpDocClick(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
    procedure mmiCloseAllClick(Sender: TObject);
    procedure mmiLoginClick(Sender: TObject);
    procedure mmiExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LMDTrayIconDblClick(Sender: TObject);
    procedure mmiOrderClick(Sender: TObject);
    procedure HintTimerTimer(Sender: TObject);
    procedure mmiRingClick(Sender: TObject);
  private
    { Private declarations }
    IsClose: Boolean;
    IsActive: Boolean;
  public
    { Public declarations }
    function LoginUser: boolean;
    procedure DisconnectData;
    procedure DisplayHint(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation
uses
  PubFun, PubOtherFun, CommonDM, LoginFrm, LogoFrm, OrderManageFrm, RingManageFrm;
{$R *.dfm}
//打开帮助文档
procedure TMainForm.mmiHelpDocClick(Sender: TObject);
begin
  if not FileExists(GlobalPath+HELP_FILE) then
    MessageBox(Self.Handle,'帮助文档不存在!','警告',mb_Ok+mb_IconWarning)
  else
    ShellExecute(0,'Open',PChar(GlobalPath+HELP_FILE),nil,nil,sw_ShowNormal);
  LMDTrayIcon.Animated := not LMDTrayIcon.Animated;
end;

//显示关于信息
procedure TMainForm.mmiAboutClick(Sender: TObject);
var
  NTTitle,WinTitle: string;
begin
  NTTitle := '未分配缺陷提醒 版本'+APP_VERSION+'#大方软件';
  WinTitle := '未分配缺陷提醒 版本'+APP_VERSION;
  ShowAboutInfo(Self.Handle,NTTitle,
    ' 版权所有大方软件(http://www.dfsoft.com.cn)',
    WinTitle);
end;

//关闭所有子窗体
procedure TMainForm.mmiCloseAllClick(Sender: TObject);
begin
  CloseAllChildForm(MainForm);
end;

//注销用户
procedure TMainForm.mmiLoginClick(Sender: TObject);                                         
begin
  CloseAllChildForm(MainForm);
  if not LoginUser then
  begin
    DisconnectData;
    IsClose := True;
    Close;
  end;
end;

//用户登陆
function TMainForm.LoginUser: boolean;
begin
  Result := True;
  LoginForm := TLoginForm.Create(nil);
  with LoginForm do
  begin
    if ShowModal=mrCancel then
      Result := False;
    Free;
  end;
  LoginForm := nil;
  //关闭Logo窗体
  LogoForm.Free;
  LogoForm := nil;
end;

//退出系统
procedure TMainForm.mmiExitClick(Sender: TObject);
begin
  if MessageBox(Self.Handle,'您确定要退出系统吗？','询问',
    mb_OkCancel+mb_IconQuestion)=Id_Ok then
  begin
    DisconnectData;
    IsClose := True;
    Close;
  end;
end;

//初始化
procedure TMainForm.FormShow(Sender: TObject);
begin
  if not IsActive then
  begin
    Application.OnHint := DisplayHint;
    GlobalPath := ExtractFilePath(Application.ExeName);
    GlobalReportPath := GlobalPath+'report\';
    if not LoginUser then
    begin
      DisconnectData;
      IsClose := True;
      Close;
      Exit;
    end;
    HintTimer.Enabled := True;
    MainForm.Height := Screen.Height-40;
    MainForm.Left := Screen.Width-MainForm.Width;
    MainForm.Top := 0;
  end;
end;

//释放资源
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not IsClose then
  begin
    LMDTrayIcon.Active := True;
    MainForm.Visible := False;
    Action := caNone;
  end;
end;

//断开数据连接
procedure TMainForm.DisconnectData;
begin
  with CommonDataModule do
  begin
    qryMain.Close;
    qryTemp.Close;
    stpMain.Close;
    cntMain.Connected := False;
  end;
end;

//显示提示信息
procedure TMainForm.DisplayHint(Sender: TObject);
begin
  sbInfo.Panels[0].Text := GetLongHint(Application.Hint);
end;

//显示主窗体
procedure TMainForm.LMDTrayIconDblClick(Sender: TObject);
begin
  IsActive := True;
  LMDTrayIcon.Active := False;
  if LMDTrayIcon.Animated=True then
    ShowOrderInfo()
  else
    MainForm.Visible := True;
end;

//显示订票信息
procedure TMainForm.mmiOrderClick(Sender: TObject);
begin
  if not Assigned(OrderManageForm) then
  begin
    OrderManageForm := TOrderManageForm.Create(nil);
    OrderManageForm.Show;
  end
  else
    OrderManageForm.WindowState := wsMaximized;
end;

//显示新消息提示
procedure TMainForm.HintTimerTimer(Sender: TObject);
begin
  ShowOrderHint();
end;

//铃声管理
procedure TMainForm.mmiRingClick(Sender: TObject);
begin
  if not Assigned(RingManageForm) then
  begin
    RingManageForm := TRingManageForm.Create(nil);
    RingManageForm.Show;
  end
  else
    RingManageForm.WindowState := wsMaximized;
end;

end.
