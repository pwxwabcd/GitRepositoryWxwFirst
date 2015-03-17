unit LoginFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, ComCtrls, DateUtils, IniFiles, Buttons;

type
  TLoginForm = class(TForm)
    pcLogin: TPageControl;
    tsSecond: TTabSheet;
    lblNo: TLabel;
    lblPassword: TLabel;
    bvlFirst: TBevel;
    edtUserNo: TEdit;
    edtPassword: TEdit;
    btnOver: TButton;
    btnSecondCancel: TButton;
    pnlFirst: TPanel;
    lblFirstInfo: TLabel;
    tsSetup: TTabSheet;
    pnlSetup: TPanel;
    Label2: TLabel;
    lblServer: TLabel;
    lblSaPassword: TLabel;
    edtSaPassword: TEdit;
    btnSave: TButton;
    btnSetupCancel: TButton;
    bvlSetup: TBevel;
    Label3: TLabel;
    btnTest: TButton;
    lblSaName: TLabel;
    edtSaName: TEdit;
    edtServerName: TEdit;
    Label1: TLabel;
    edtDBName: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSetupCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOverClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AfirmUser: Boolean;
    procedure SaveUser;
    procedure FirstInit;
    function InitInterface: Boolean;
  end;

var
  LoginForm: TLoginForm;

implementation
uses
  CommonDM, PubFun, PubOtherFun, MainFrm;
{$R *.dfm}

//��¼��ʼ��
procedure TLoginForm.FormShow(Sender: TObject);
begin
  InitInterface;
end;

//Ĭ�ϰ�������
procedure TLoginForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Ctrl+S
  if (ssCtrl in Shift) and (Key=83)  then
    pcLogin.ActivePage := tsSetup;
end;

//ȡ������������
procedure TLoginForm.btnSetupCancelClick(Sender: TObject);
begin
  pcLogin.ActivePage := tsSecond;
end;

//�������������
procedure TLoginForm.btnSaveClick(Sender: TObject);
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
  begin
    WriteString('Config', 'ServerName', edtServerName.Text);
    WriteString('Config', 'DBName', edtDBName.Text);
    WriteString('Config', 'SaName', edtSaName.Text);
    WriteString('Config', 'SaPassword', edtSaPassword.Text);
  end;
  IniFile.Free;
  pcLogin.ActivePage := tsSecond;
end;

//��ʵ�û�
procedure TLoginForm.btnOverClick(Sender: TObject);
begin
  FirstInit;
  if AfirmUser then
  begin
    SaveUser;
    LoginForm.ModalResult := mrOk;
  end;
end;

//����
procedure TLoginForm.btnTestClick(Sender: TObject);
begin
  if SetConnection(edtServerName.Text, edtSaName.Text, edtSaPassword.Text,
    CommonDataModule.cntCw) then
    MessageBox(Self.Handle,'���ݿ����ӳɹ�!','��ʾ',mb_Ok+mb_IconInformation)
  else
    MessageBox(Self.Handle,'���ݿ�����ʧ��!','����',mb_Ok+mb_IconWarning);
end;

//ȷ���û�
function TLoginForm.AfirmUser: Boolean;
var
  UNo,Password: string;
begin
  UNo := edtUserNo.Text;
  Password := edtPassword.Text;
  if IsUserValid(UNo) then
  begin
    GlobalUserNo := UNo;
    Result := True;
  end
  else
  begin
    MessageBox(Self.Handle,'�û�������!','����',mb_Ok+mb_IconWarning);
    Result := False;
  end;
end;

//����Ĭ���û�
procedure TLoginForm.SaveUser;
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
    WriteString('Config', 'UserNo', edtUserNo.Text);
  IniFile.Free;
end;

//��ʼ��
procedure TLoginForm.FirstInit;
begin
  //�������ݿ�
  if SetConnection(edtServerName.Text, edtSaName.Text,
    edtSaPassword.Text, CommonDataModule.cntCw)=False then
  begin
    MessageBox(Self.Handle,'���ݿ�����ʧ��!','����',mb_Ok+mb_IconWarning);
    Exit;
  end;
end;

//��ȡ�����ļ������ý���
function TLoginForm.InitInterface: Boolean;
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  if not FileExists(IniFileName) then
  begin
    pcLogin.ActivePage := tsSetup;
    Result := False;
  end
  else
  begin
    with IniFile do
    begin
      edtServerName.Text := ReadString('Config', 'ServerName', '192.168.0.5');
      edtDBName.Text := ReadString('Config', 'DBName', 'cqicu');
      edtSaName.Text := ReadString('Config', 'SaName', 'cqicu');
      edtSaPassword.Text := ReadString('Config', 'SaPassword', 'cqicu');
      edtUserNo.Text := ReadString('Config', 'UserNo', 'boss');
    end;
    pcLogin.ActivePage := tsSecond;
    edtUserNo.SetFocus;
    Result := True;
  end;
  IniFile.Free;
end;

end.
