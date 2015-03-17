unit PubFun;

interface
uses
  ShellApi, Windows, DB, ADODB, Dialogs, ComCtrls, SysUtils, Forms, StdCtrls,
  Controls, Classes, StrUtils, Graphics, ExtCtrls, IniFiles,
  Buttons, IdGlobal, Clipbrd, ComObj, Printers, Ora;

type

  //Ȩ�޽ṹ
  TPrivilege = packed record
    PNo: string[40];
  end;
  PPrivilege = ^TPrivilege;

  {���ݿ�}
  //������������
    function SetConnection(ServerName,SaName,SaPassword: string;
    OraSession: TOraSession): Boolean; overload;
  //ȡ��Ado����״̬
  procedure CancelTransaction(AdoConnection: TAdoConnection);
  //ʹAdoQueryִ�з��ؽ������Sql���
  function Open_Sql(SqlString: string; var Query: TAdoQuery): Integer; overload
  function Open_Sql(SqlString: string; var Query: TAdoQuery;
    RowOfPage: Integer): Integer; overload;
  function Open_Sql(SqlString: string; var Query: TOraQuery): Integer; overload;
  //ִ��Sql���
  function Exec_Sql(SqlString: string; var Query: TAdoQuery): Boolean;
  //����ִ��Sql���
  function BatchExec_Sql(SqlString: TStrings; var Query: TAdoQuery): Boolean;
  //����ִ��Sql����ļ�
  function BatchExecSqlFile(FileName: string): Boolean;

  //���ý����ʾ
  procedure SetJeShow(Field: TField; var Text: String; ShowZero: Boolean=True);
  //��ȡ��������
  procedure GetSqlServerName(cbServerName: TComboBox);
  //��ȡ���ݿ���
  procedure GetDBName(cbDBName: TComboBox; UserName,Password,ServerName: string);
  //����SqlServer���ݿ�
  function BackupDataBase(DBName,BackupFileName: string): Boolean;
  //��ԭSqlServer���ݿ�
  function RestoreDataBase(DBName,BackupFileName: string): Boolean;
  //�����־
  function ClearLog(DBName: string): Boolean;
  //�������ݿ�
  function CreateDB(DBName: string): Boolean;

  //*********************************��ʱ�����*******************//
  //�õ������ʱ��
  function GetMaxTempNo(TableName, ColumnName: string): Integer;
  //ɾ����ʱ������
  function DelTempData(TableName: string; TempNo: Integer): Boolean;

  {�ؼ�����}
  //*********************************ListView*******************//
  //��ListView���������ΪExcel�ļ�
  function ListViewToExcel(ListView: TListView): Boolean;
  //ɾ��ListView����ѡ��
  procedure DelListItem(ListView: TListView);
  //ɾ��ListView��Check��
  procedure DelCheckedListItem(ListView: TListView);
  //ѡȡ�����б�
  procedure SelectAllListItem(ListView: TListView; IsCheck: Boolean);
  //��ʾ������Ϣ
  procedure ShowItemCount(ListView: TListView);
  //�����
  procedure AddListItem(ListView: TListView; StrList: array of string;
    ItemData: Integer=0; ItemChecked: Boolean=False);
  //�����
  procedure AddListHead(ListView: TListView; StrList: array of string);

  //*********************************Form*******************//
  //���ô�����Ӧ�ֱ���
  procedure FormScale(Form: TForm);
  //���ô�������ͼ
  procedure MiniatureForm(Form: TForm; Image: TImage);
  //�ر������Ӵ���
  procedure CloseAllChildForm(Form: TForm);

  //*********************************Edit*******************//  
  //����ʵ�������ַ�
  procedure RealKeyPress(var Key: Char);

  //*********************************DBGrid*******************//
  //���س����������¼�,�Ƶ���һ����¼
  procedure EnterNextRecord(var Key: Word);
  
  //*********************************��*******************//

  //ȡ���ڵ���
  function GetAllNo(TreeNode: TTreeNode): string;
  //�ж���ӽڵ���Ч��
  function JudgeAddTreeNode(TreeView: TTreeView): Boolean;
  //������ͼ��
  procedure SetTreeImage(TreeView: TTreeView); overload;

  //���������ͼ��
  procedure SetTreeNodeImage(TreeNode: TTreeNode); overload;


  {ͨ�ú���}
  //*********************************����*******************//
  //�õ�����ϵͳ�汾
  function GetSystemInfo: Integer;
  //��ʾ������Ϣ
  procedure ShowAboutInfo(Handle: hWnd; NTTitle,Caption,WinTitle: string);
  //String��Case���
  function StringIndex(SearchStr: string; StrList: array of string;
    IsSensitive: Boolean=True): Integer;
  //��Booleanת����Integer
  function BoolToInt(BoolVal: Boolean): Integer;
  //��ȡ��ӡƱ��ƾ֤ʱ�ķ���
  function GetPrintOrientation: TPrinterOrientation;
  //�õ�ĳ��ĳ�µ����һ��
  function GetMonthEndDate(Year,Month: string): string;
  //�õ�ĳ��ĳ�µĵ�һ��
  function GetMonthBeginDate(Year,Month: string): string;
  //�ж������Ч��
  function JudgeKind(KNo, KName: string): Boolean;
  //�жϱ��������Ч��
  function JudgeNoName(No, Name: string): Boolean;
  //�õ�Ӳ�����кų�ʼ����
  function GetIdePre: Boolean;
  //�õ�Ӳ�����к�
  function GetIdeSerialNumber: PChar;
  //��ȡ�û�ע����
  function GetRegisterStr: string;
  //��д�û�ע����
  function SetRegisterStr(RegisterStr: string): string;
  //�ж��û��Ƿ����
  function JudgeRegister: Boolean;
  //�õ��ļ�ǰ׺
  function GetFilePre(FileName: string): string;
  //�õ�ϵͳ�ļ�Ŀ¼
  function GetSystemDir: string;

  //*********************************����*******************//
  //��Сд����ɴ�д
  function NumToChinese(MoneyNum: Currency): string;
  //��Format���Ľ���ʽ��
  function UnFormatCurr(CurrStr: string): string;

  //*********************************�ַ���*******************//
  //ȡ���ո�ָ���ַ���
  function GetNoName(BlankStr: string; var No: string): string;
  //�õ��á�-���ָ����ַ�����ǰ����
  function Get_BStr(_Str: string): string;
  //�õ��á�-���ָ����ַ����ĺ󲿷�
  function Get_AStr(_Str: string): string;
  //�õ��á�_���ָ����ַ�����ǰ����
  function Get_TStr(_Str: string): string;
  //��OrgStr��ɾ���ظ���RepStr
  function DelRepStr(OrgStr, RepStr: string): string;
  //ȡ�����ŷָ���ַ���
  function GetCommaStr(var CommaStr: string): string;
  //ɾ���ַ����е�ĳ���ַ�
  function DelChar(OrgStr, CharStr: string): string;
  //�õ��ظ��ַ�
  function GetRepChar(RepChar: Char; RepCount: Integer): string;
  //��ÿ����������
  function NewLine(OrgStr: string; WordNum: Integer): string;
  //�ж��ж��ٸ������ֽ�
  function ChsCount(OrgStr: string): Integer;
  //ɾ���ַ����а�������ַ�
  function DelHalfChs(OrgStr: string): string;
  //�س����з�
  function EnterStr: string;
  //ɾ���ַ���
  function CutStr(OrgStr: string; WordNum: Integer): string;
  //�滻�ַ���
  function ReplaceStr(OrgStr,FindStr,RepStr: string): string;
  //���ܽ����ַ���
  function EncryptionEngine(Src: string; Encrypt:Boolean; Key:string=''): string;
  //url����
  function UrlEncode(Src: string): string;

var
  SortType: Boolean;
  ColumnToSort,GlobalHbDxId: Integer;
  GlobalPath,GlobalReportPath,GlobalUserNo,GlobalUserName,LAST_DAY: string;
  GlobalIsAdmin: Boolean;
  GlobalCopyMobileName,GlobalCopyWriteTime,GlobalCopyRingName: string;
const
  CONFIG_FILE: string='mh.ini';
  HELP_FILE: string='�񺽶�����Ϣϵͳʹ��˵��.doc';
  INIT_FILE: string='JxcInit.sql';
  APP_VERSION: string='2014-10-09';
  ROW_OF_PAGE: Integer=7;
  //�Ƿ�ע��
  //{$DEFINE register}
  //********��������********//
  //{$ifdef register}
  //��ע����Ϣ
  //IDE_SERIAL_NUMBER: string='��ע��';
  //LAST_DAY: string='3000-01-01';
  //{$else}
  //δע����Ϣ
  //IDE_SERIAL_NUMBER: string='δע��';
  //LAST_DAY: string='2005-01-31';
  //{$endif}
  //����
  CGJH_BILL_Report: string='CgjhBill.rtm';
  CGTH_BILL_Report: string='CgthBill.rtm';
  XSFH_BILL_Report: string='XsfhBill.rtm';
  XSTH_BILL_Report: string='XsthBill.rtm';
  YK_BILL_Report: string='YkBill.rtm';
  PY_BILL_Report: string='PyBill.rtm';
  PK_BILL_Report: string='PkBill.rtm';
  TJ_BILL_Report: string='TjBill.rtm';
  CSRk_BILL_Report: string='CsrkBill.rtm';
  SK_BILL_Report: string='SkBill.rtm';
  FK_BILL_Report: string='FkBill.rtm';

implementation
uses
  WaitFrm, CommonDM;


//������������
function SetConnection(ServerName,SaName,SaPassword: string;
  OraSession: TOraSession): Boolean;
begin
  with OraSession do
  begin
    Connected := False;
    Server := ServerName;
    UserName := SaName;
    Password := saPassword;
    try
      Connected := True;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

//ȡ��Ado����״̬
procedure CancelTransaction(AdoConnection: TAdoConnection);
begin
  with AdoConnection do
    if InTransaction then
    begin
      Connected := False;
      Connected := True;
    end;
end;

//ʹAdoQueryִ�з��ؽ������Sql���
function Open_Sql(SqlString: string; var Query: TAdoQuery): Integer;
begin
  with Query do
  begin
    Close;
    LockType := ltOptimistic;
    SQL.Clear;
    SQL.Add(SqlString);
    ParamCheck := True;
    Prepared := True;
    try
      Open;
      if IsEmpty then
        Result := 2
      else
        Result := 1;
    except
      Result := 0;
    end;
  end;
end;

//ʹAdoQueryִ�з��ؽ������¼ֵΪCountOfPage��������Sql���
function Open_Sql(SqlString: string; var Query: TAdoQuery;
  RowOfPage: Integer): Integer; overload;
var
  LeaveRecordCount,i: Integer;
begin
  with Query do
  begin
    Close;
    LockType := ltBatchOptimistic;
    SQL.Clear;
    SQL.Add(SqlString);
    ParamCheck := True;
    Prepared := True;
    try
      Open;
      if IsEmpty then
        Result := 2
      else
        Result := 1;
      LeaveRecordCount := RecordCount mod RowOfPage;
      if LeaveRecordCount<>0 then
        LeaveRecordCount := RowOfPage-LeaveRecordCount;
      for i := 1 to LeaveRecordCount do
      begin
        Insert;
        Post;
      end;
    except
      Result := 0;
    end;
  end;
end;

//ʹAdoQueryִ�з��ؽ������Sql���
function Open_Sql(SqlString: string; var Query: TOraQuery): Integer;
begin
  with Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add(SqlString);
    Prepared := True;
    try
      Open;
      if IsEmpty then
        Result := 2
      else
        Result := 1;
    except
      Result := 0;
    end;
  end;
end;

//ʹAdoQueryִ�в����ؽ������Sql���
function Exec_Sql(SqlString: string; var Query: TAdoQuery): Boolean;
begin
  with Query do
  begin
    Close;
    LockType := ltOptimistic;
    SQL.Clear;
    SQL.Add(SqlString);
    ParamCheck := True;
    Prepared := True;
    try
      ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

//����ִ��Sql���
function BatchExec_Sql(SqlString: TStrings; var Query: TAdoQuery): Boolean;
begin
  with Query do
  begin
    Close;
    LockType := ltOptimistic;
    Prepared := False;
    ParamCheck := False;
    Prepared := True;
    SQL.Assign(SqlString);
    try
      ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

//����ִ��Sql����ļ�
function BatchExecSqlFile(FileName: string): Boolean;
var
  SqlString: TStrings;
begin
  Result := False;
  if not FileExists(FileName) then
    Exit;
  SqlString := TStringList.Create;
  SqlString.LoadFromFile(FileName);
  with CommonDataModule do
    Result := BatchExec_Sql(SqlString, CommonDataModule.qryMain);
  SqlString.Free;
end;

//��ListView���������ΪExcel�ļ�
function ListViewToExcel(ListView: TListView): Boolean;
var
  i,j,ColCount,SubCount: Integer;
  TempStr, InfoStr: string;
  ExcelFile: TextFile;
  SaveDialog: TSaveDialog;
Begin
  Result := False;
  SaveDialog := TSaveDialog.Create(nil);
  try
    //�������Ի�������
    With SaveDialog do
    begin
      DefaultExt := '*.csv';
      Filter := 'Microsoft Excel ������(*.csv)|*.csv|�����ļ�(*.*)|*.*';
      Options := [ofOverwritePrompt,ofHideReadOnly,ofEnableSizing];
    end;
    if SaveDialog.Execute then
    begin
      WaitForm.ShowInfo('���ڵ���Excel�ļ�');
      //��ȡ����
      ColCount := ListView.Columns.Count;
      for i := 0 to ColCount-1 do
      begin
        InfoStr := DelChar(ListView.Columns[i].Caption, ',');
        if i<>ColCount-1 then
          TempStr := TempStr+InfoStr+','
        else
          TempStr := TempStr+InfoStr+EnterStr;
      end;
      //��ȡ����
      for i := 0 to ListView.Items.Count-1 do
      begin
        InfoStr := DelChar(ListView.Items[i].Caption, ',');
        TempStr := TempStr+InfoStr+',';
        if ColCount<ListView.Items[i].SubItems.Count+1 then
          SubCount := ColCount-1
        else
          SubCount := ListView.Items[i].SubItems.Count;
        for j := 0 to SubCount-1 do
        begin
          InfoStr := DelChar(ListView.Items[i].SubItems[j], ',');        
          if j<>SubCount-1 then
            TempStr := TempStr+InfoStr+','
          else
            TempStr := TempStr+InfoStr+EnterStr;
        end;
      end;
      //д���ļ�
      AssignFile(ExcelFile,SaveDialog.FileName);
      try
        ReWrite(ExcelFile);
        WriteLn(ExcelFile,TempStr);
        CloseFile(ExcelFile);
        Result := True;
        WaitForm.Close;
        MessageBox(Application.Handle,'Excel�ļ�����ɹ���','��ʾ',mb_IconInformation+mb_ok);
      Except
        WaitForm.Close;
        MessageBox(Application.Handle,'Excel�ļ�����ʧ�ܣ����Ժ����ԣ�','����',mb_Ok+mb_IconWarning);
      end;
    end;
  finally
    SaveDialog.Free;
  end;
end;

//ɾ��ListView����ѡ��
procedure DelListItem(ListView: TListView);
var
  i: Integer;
begin
  for i := ListView.Items.Count-1 downto 0 do
    if ListView.Items[i].Selected then
      ListView.Items[i].Delete;
end;

//�õ�����ϵͳ�汾
function GetSystemInfo: Integer;
var
  VI: TOSVersionInfo;
begin
  VI.dwOSVersionInfoSize := SizeOf(VI);
  GetVersionEx(VI);
  Result := VI.dwPlatformId;
end;

//��ʾ������Ϣ
procedure ShowAboutInfo(Handle: hWnd; NTTitle,Caption,WinTitle: string);
begin
  if GetSystemInfo=Ver_PlatForm_Win32_NT then
    ShellAbout(Handle,PChar(NTTitle),PChar(Caption),0)
  else
    ShellAbout(Handle,PChar(WinTitle),PChar(Caption),0);
end;

//ȡ���ո�ָ���ַ���
function GetNoName(BlankStr: string; var No: string): string;
var
  BlankPos: Integer;
begin
  BlankPos := Pos(' ', BlankStr);
  No := Copy(BlankStr, 1, BlankPos-1);
  Result := Copy(BlankStr, BlankPos+1, Length(BlankStr));
end;




//ȡ���ڵ���
function GetAllNo(TreeNode: TTreeNode): string;
var
  TotalLevel: Integer;
  No: string;
begin
  Result := '';
  TotalLevel := TreeNode.Level;
  while TotalLevel>0 do
  begin
    GetNoName(TreeNode.Text, No);
    Result := No+Result;
    TreeNode := TreeNode.Parent;
    TotalLevel := TotalLevel-1;
  end;
end;

//�ж���ӽڵ���Ч��
function JudgeAddTreeNode(TreeView: TTreeView): Boolean;
var
  TreeNode: TTreeNode;
begin
  Result := False;
  TreeNode := TreeView.Selected;
  if TreeNode=nil then
    Exit;
  if TreeNode.Level=3 then
  begin
    MessageBox(Application.Handle,'������ֻ�ܽ�3��!','����',mb_Ok+mb_IconWarning);
    Exit;
  end;
  Result := True;
end;

//���������ͼ��
procedure SetTreeImage(TreeView: TTreeView);
var
  i: Integer;
begin
  for i := 0 to TreeView.Items.Count-1 do
    SetTreeNodeImage(TreeView.Items[i]);
end;

//���������ͼ��
procedure SetTreeNodeImage(TreeNode: TTreeNode);
begin
  with TreeNode do
  begin
    ImageIndex := 0;
    SelectedIndex := 2;
  end;
end;

//��Сд����ɴ�д
function NumToChinese(MoneyNum: Currency): string;
var
  Num: array[0..9] of string;
  Dep: array[1..8] of string;
  MoneyStr: string;
  i,EveryNum,PreNum: Integer;
begin
  //����
  Num[0] := '��';
  Num[1] := 'Ҽ';
  Num[2] := '��';
  Num[3] := '��';
  Num[4] := '��';
  Num[5] := '��';
  Num[6] := '½';
  Num[7] := '��';
  Num[8] := '��';
  Num[9] := '��';
  //��λ
  Dep[1] := '��';
  Dep[2] := '��';
  Dep[3] := 'Ԫ';
  Dep[4] := 'ʰ';
  Dep[5] := '��';
  Dep[6] := 'Ǫ';
  Dep[7] := '��';
  Dep[8] := '��';
  MoneyStr := ReverseString(FloatToStr(Abs(MoneyNum)*100));
  for i := 1 to Length(MoneyStr) do
  begin
    EveryNum := StrToInt(MoneyStr[i]);
    if i-1<>0 then
      PreNum := StrToInt(MoneyStr[i-1])  //��һλ
    else
      PreNum := 1;
    if EveryNum=0 then
    begin
      if PreNum=0 then
        case i of
          3 : Result := Dep[3]+Result;  //Ԫ
          7 : Result := Dep[7]+Result;  //��Ԫ
          11: begin
                if Copy(Result, 1, 2)=Dep[7] then  //��ֹ�ں�������
                  Delete(Result, 1, 2);
                Result := Dep[8]+Result;  //��Ԫ
              end;
        end
      else
        case i of
          1   : ;
          3   : Result := Dep[3]+Num[EveryNum]+Result;
          7   : Result := Dep[7]+Num[EveryNum]+Result;
          11  : Result := Dep[8]+Num[EveryNum]+Result;
          else
            Result := Num[EveryNum]+Result;
        end
    end
    else
      case i of
        1 : Result := Num[EveryNum]+Dep[1]+Result;   //��
        2 : Result := Num[EveryNum]+Dep[2]+Result;   //��
        3 : Result := Num[EveryNum]+Dep[3]+Result;   //Ԫ
        4 : Result := Num[EveryNum]+Dep[4]+Result;   //ʰԪ
        5 : Result := Num[EveryNum]+Dep[5]+Result;   //��Ԫ
        6 : Result := Num[EveryNum]+Dep[6]+Result;   //ǧԪ
        7 : Result := Num[EveryNum]+Dep[7]+Result;   //��Ԫ
        8 : Result := Num[EveryNum]+Dep[4]+Result;   //ʮ��Ԫ
        9 : Result := Num[EveryNum]+Dep[5]+Result;   //����Ԫ
        10: Result := Num[EveryNum]+Dep[6]+Result;   //ǧ��Ԫ
        11: begin
              if Copy(Result, 1, 2)=Dep[7] then  //��ֹ�ں�������
                Delete(Result, 1, 2);
              Result := Num[EveryNum]+Dep[8]+Result;   //��Ԫ
            end;
        12: Result := Num[EveryNum]+Dep[4]+Result;   //ʮ��Ԫ
        13: Result := Num[EveryNum]+Dep[5]+Result;   //����Ԫ
        14: Result := Num[EveryNum]+Dep[6]+Result;   //ǧ��Ԫ
      end;
  end;
  if Copy(Result,Length(Result)-1,Length(Result))='Ԫ' then
    Result := Result+'��';
end;

//�õ��á�-���ָ����ַ�����ǰ����
function Get_BStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('-', _Str);
  Result := Copy(_Str, 1, _Pos-1);
end;

//�õ��á�-���ָ����ַ����ĺ󲿷�
function Get_AStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('-', _Str);
  Result := Copy(_Str, _Pos+1, Length(_Str));
end;

//��OrgStr��ɾ���ظ���RepStr
function DelRepStr(OrgStr, RepStr: string): string;
var
  i,RepLen: Integer;
begin
  i := 1;
  RepLen := length (RepStr);
  while i<=length(OrgStr) do
    if copy(OrgStr,i,RepLen)<>RepStr then
      i := i+1
    else
    begin
      if copy(orgStr,i+RepLen,RepLen)<>RepStr then
        i := i+1
      else
        delete(OrgStr,i+RepLen,RepLen);
    end;
  result:=OrgStr;
end;

//�õ������ʱ��
function GetMaxTempNo(TableName, ColumnName: string): Integer;
var
  SqlString: string;
begin
  SqlString := 'select IsNull(Max('+ColumnName+'),0)+1 as MaxTempNo from '
    +TableName;
  with CommonDataModule do
    if Open_Sql(SqlString, qryMain)=1 then
      Result := qryMain.FieldByName('MaxTempNo').AsInteger
    else
      Result := 0;
end;

//ɾ����ʱ������
function DelTempData(TableName: string; TempNo: Integer): Boolean;
var
  SqlString: string;
begin
  SqlString := 'delete '+Tablename+' where TempNo=%d';
  SqlString := Format(SqlString, [TempNo]);
  with CommonDataModule do
    Result := Exec_Sql(SqlString, qryMain);
end;

//���ý����ʾ
procedure SetJeShow(Field: TField; var Text: String; ShowZero: Boolean=True);
begin
  if (Field.AsCurrency=0) and (not ShowZero) then
    Text := ''
  else
    Text := Format('%m', [Field.AsCurrency]);
end;

//���ô�����Ӧ�ֱ���
procedure FormScale(Form: TForm);
begin
  if Screen.Width<>800 then
  begin
    Form.Height:= Form.Height*Screen.Height div 600;
    Form.Width:= Form.Width*Screen.Width div 800;
    Form.ScaleBy(Screen.Width,800);
  end;
end;

//ѡȡ�����б�
procedure SelectAllListItem(ListView: TListView; IsCheck: Boolean);
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count-1 do
    ListView.Items[i].Checked := IsCheck;
end;

//��ʾ������Ϣ
procedure ShowItemCount(ListView: TListView);
begin
  ListView.Hint := '�� '+IntToStr(ListView.Items.Count)+' ����¼';
end;

//�����
procedure AddListItem(ListView: TListView; StrList: array of string;
  ItemData: Integer=0; ItemChecked: Boolean=False);
var
  i: Integer;
begin
  with ListView.Items.Add do
  begin
    Caption := StrList[0];
    for i := 1 to High(StrList) do
      SubItems.Add(StrList[i]);
    Data := Pointer(ItemData);
    Checked := ItemChecked;
  end;
end;

//�����
procedure AddListHead(ListView: TListView; StrList: array of string);
var
  i: Integer;
begin
  with ListView do
  begin
    Items.Clear;
    Columns.Clear;
  end;
  for i := Low(StrList) to High(StrList) do
    with ListView.Columns.Add do
    begin
      Caption := StrList[i];
      Width := Min(20*Length(Caption),100);
    end;
end;

//ɾ��ListView��Check��
procedure DelCheckedListItem(ListView: TListView);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := ListView.Items.Count-1 downto 0 do
  begin
    ListItem := ListView.Items[i];
    if ListItem.Checked then
      ListItem.Delete
    else
      Continue;
  end;
end;

//��Format���Ľ���ʽ��
function UnFormatCurr(CurrStr: string): string;
var
  CommaPos: Integer;
begin
  Result := Copy(CurrStr,3,Length(CurrStr));
  CommaPos := Pos(',', Result);
  while CommaPos<>0 do
  begin
    delete(Result, CommaPos, 1);
    CommaPos := Pos(',', Result);
  end;
end;

//ȡ�����ŷָ���ַ���
function GetCommaStr(var CommaStr: string): string;
var
  CommaPos: Integer;
begin
  CommaPos := Pos(',', CommaStr);
  Result := Copy(CommaStr, 1, CommaPos-1);
  CommaStr := Copy(CommaStr, CommaPos+1, Length(CommaStr));
end;

//String��Case���
function StringIndex(SearchStr: string; StrList: array of string;
  IsSensitive: Boolean=True): Integer;
var
  i: Integer;
  IsEqual: Boolean;
begin
  Result := 0;
  for i := Low(StrList) to High(StrList) do
  begin
    if IsSensitive then
      IsEqual := CompareStr(SearchStr, StrList[i])=0
    else
      IsEqual := CompareText(SearchStr, StrList[i])=0;
    if IsEqual then
    begin
      Result := i+1;
      Break;
    end;
  end;
end;

//�õ��á�_���ָ����ַ�����ǰ����
function Get_TStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('_', _Str);
  Result := Copy(_Str, 1, _Pos-1);
end;

//ɾ���ַ����е�ĳ���ַ�
function DelChar(OrgStr, CharStr: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(OrgStr) do
    if OrgStr[i]<>CharStr then
      Result := Result+OrgStr[i];
end;

//��Booleanת����Integer
function BoolToInt(BoolVal: Boolean): Integer;
begin
  if BoolVal then
    Result := 1
  else
    Result := 0;
end;

//����ʵ�������ַ�
procedure RealKeyPress(var Key: Char);
begin
  //���ֻ�BackSpace,Delete,С����
  if (not IsNumeric(Key)) and (Key<>Char(8)) and (Key<>Char(46))
    and (Key<>'.') then
    Key := Char(0);
end;

//���ô�������ͼ
procedure MiniatureForm(Form: TForm; Image: TImage);
var
  FormImage: TBitmap;
begin
  FormImage := Form.GetFormImage;
  try
    Clipboard.Assign(FormImage);
    Image.Picture.Assign(Clipboard);
  finally
    FormImage.Free;
  end;
end;

//�ر������Ӵ���
procedure CloseAllChildForm(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.MDIChildCount-1 do
    if Assigned(Form.MDIChildren[i]) then
      Form.MDIChildren[i].Close;
end;

//�õ��ظ��ַ�
function GetRepChar(RepChar: Char; RepCount: Integer): string;
begin
  Result := '';
  while RepCount>0 do
  begin
    Result := Result+RepChar;
    Dec(RepCount);
  end;
end;

//��ȡ��������
procedure GetSqlServerName(cbServerName: TComboBox);
var
  SQLServer,ServerList: Variant;
  i: Integer;
Begin
  cbServerName.Items.Clear;
  SQLServer := CreateOleObject('SQLDMO.Application');
  ServerList:= SQLServer.ListAvailableSQLServers;
  for i:=1 to serverlist.count do
    cbServerName.Items.Add(serverlist.item(i));
end;

//��ȡ���ݿ���
procedure GetDBName(cbDBName: TComboBox; UserName,Password,ServerName: string);
var
  Query: TAdoQuery;
  SqlString: string;
begin
  cbDBName.Items.Clear;
  Query := TAdoQuery.Create(nil);
  Query.ConnectionString := 'Provider=SQLOLEDB.1;'+'password='+password
    +';Persist Security Info=True;User ID='+UserName+';Data Source='+ServerName;
  SqlString := 'select Name from master.dbo.sysdatabases';
  if Open_Sql(SqlString, Query)=1 then
    while not Query.Eof do
    begin
      cbDBName.Items.Add(Query.FieldByName('Name').AsString);
      Query.Next;
    end;
  Query.Free;
  Query := nil;
end;

//����SqlServer���ݿ�
function BackupDataBase(DBName,BackupFileName: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'backup database %s to disk =''%s''';
    SqlString := Format(SqlString, [DBName,BackupFileName]);
    Result := Exec_Sql(SqlString, qryMain);
  end;
end;

//��ԭSqlServer���ݿ�
function RestoreDataBase(DBName,BackupFileName: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'ALTER DATABASE %s SET OFFLINE WITH ROLLBACK IMMEDIATE';
    SqlString := Format(SqlString, [DBName]);
    Result := Exec_Sql(SqlString, qryMain);
    if not Result then
      Exit;
    SqlString := 'restore database %s from disk =''%s'' with replace';
    SqlString := Format(SqlString, [DBName,BackupFileName]);
    Result := Exec_Sql(SqlString, qryMain);
    if not Result then
      Exit;    
    SqlString := 'ALTER DATABASE %s SET ONLINE WITH ROLLBACK IMMEDIATE';
    SqlString := Format(SqlString, [DBName]);
    Result := Exec_Sql(SqlString, qryMain);
  end;
end;

//�����־
function ClearLog(DBName: string): Boolean;
var
  SqlString: string;
begin
  Result := False;
  with CommonDataModule do
  begin
    SqlString := 'Dump Transaction '+DBName+' With No_log';
    if not Exec_Sql(SqlString, qryMain) then
      Exit;
    SqlString := 'DBCC ShrinkDatabase(''%s'')';
    SqlString := Format(SqlString, [DBName]);
    if not Exec_Sql(SqlString, qryMain) then
      Exit;
  end;
  Result := True;
end;

//�������ݿ�
function CreateDB(DBName: string): Boolean;
var
  SqlString: string;
begin
  Result := False;
  with CommonDataModule do
  begin
    SqlString := 'Create Database %s';
    SqlString := Format(SqlString, [DBName]);
    if not Exec_Sql(SqlString, qryMain) then
      Exit;
  end;
  Result := True;
end;

//��ÿ����������
function NewLine(OrgStr: string; WordNum: Integer): string;
var
  i: Integer;
  LineStr,TempStr: string;
begin
  Result := '';
  LineStr := '';
  for i := 1 to Length(OrgStr) do
  begin
    LineStr := LineStr+OrgStr[i];
    if i mod WordNum = 0 then
    begin
      TempStr := DelHalfChs(LineStr);
      Result := Result+TempStr+EnterStr;
      if Length(TempStr)<Length(LineStr) then
        LineStr := OrgStr[i]
      else
        LineStr := '';
    end;
  end;
  if LineStr<>'' then
    Result := Result+LineStr;
end;

//�ж��ж��ٸ������ֽ�
function ChsCount(OrgStr: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(OrgStr) do
    if ord(OrgStr[i])>127 then
      Result := Result+1;
end;

//ɾ���ַ����а�������ַ�
function DelHalfChs(OrgStr: string): string;
var
  ChsSum: Integer;
begin
  Result := OrgStr;
  ChsSum := ChsCount(OrgStr);
  if (ChsSum=0) or (ChsSum mod 2 = 0) then
    Exit
  else
    Result := Copy(OrgStr, 1, Length(OrgStr)-1);
end;

//��ȡ��ӡƱ��ƾ֤ʱ�ķ���
function GetPrintOrientation: TPrinterOrientation;
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
    if ReadInteger('Config', 'Orientation', 1)=0 then
      Result := poPortrait
    else
      Result := poLandscape;
  IniFile.Free;
end;

//�س����з�
function EnterStr: string;
Begin
  Result := Chr(13)+Chr(10);
end;

//ɾ���ַ���
function CutStr(OrgStr: string; WordNum: Integer): string;
begin
  Result := Copy(OrgStr,1,WordNum);
  Result := DelHalfChs(Result);
end;

//���س����������¼�,�Ƶ���һ����¼
procedure EnterNextRecord(var Key: Word);
begin
  if Key=13 then
    Key := 40;
end;

//�õ�ѡ�����������
{function GetCheckCount(TreeView: TfcTreeView): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to TreeView.Items.Count - 1 do
    if (TreeView.Items[i].Level<>0) and (TreeView.Items[i].Checked) then
      Inc(Result);
end;}

//�滻�ַ���
function ReplaceStr(OrgStr,FindStr,RepStr: string): string;
var
  FindPos: Integer;
begin
  Result := OrgStr;
  FindPos := Pos(FindStr, OrgStr);
  if FindPos=0 then
    Exit;
  Result := Copy(OrgStr, 1, FindPos-1)+RepStr
    +Copy(OrgStr, FindPos+Length(FindStr), Length(OrgStr));
end;

//�õ�ĳ��ĳ�µ����һ��
function GetMonthEndDate(Year,Month: string): string;
var
  iYear,iMonth,iDate: Integer;
begin
  iYear := StrToInt(Year);
  iMonth := StrToInt(Month);
  case iMonth of
    1,3,5,7,8,10,12: iDate := 31;
    2: if IsLeapYear(iYear) then
         iDate := 29
       else
         iDate := 28;
    else iDate := 30;
  end;
  Result := DateToStr(EncodeDate(iYear,iMonth,iDate));
end;

//�õ�ĳ��ĳ�µĵ�һ��
function GetMonthBeginDate(Year,Month: string): string;
var
  iYear,iMonth,iDate: Integer;
begin
  iYear := StrToInt(Year);
  iMonth := StrToInt(Month);
  iDate := 1;
  Result := DateToStr(EncodeDate(iYear,iMonth,iDate));
end;

//�ж������Ч��
function JudgeKind(KNo, KName: string): Boolean;
begin
  Result := True;
  if Length(KNo)<>2 then
  begin
    MessageBox(Application.Handle,'���ӦΪ2λ�ַ�!','����',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
  if Length(KName)=0 then
  begin
    MessageBox(Application.Handle,'���Ʋ�ӦΪ��!','����',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
end;

//�жϱ��������Ч��
function JudgeNoName(No, Name: string): Boolean;
begin
  Result := True;
  if Length(No)=0 then
  begin
    MessageBox(Application.Handle,'��Ų�ӦΪ��!','����',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
  if Length(Name)=0 then
  begin
    MessageBox(Application.Handle,'���Ʋ�ӦΪ��!','����',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
end;

//�õ�Ӳ�����кų�ʼ����
function GetIdePre: Boolean;
var
  SystemDir,NewFileName,ExistFileName: string;
begin
  Result := True;
  if GetSystemInfo=Ver_PlatForm_Win32_NT then
    Exit;
  SystemDir := GetSystemDir;
  NewFileName := SystemDir+'\iosubsys\SMARTVSD.VXD';
  ExistFileName := GlobalPath+'SMARTVSD.VXD';
  if not FileExists(NewFileName) then
  begin
    Result := False;
    CopyFile(PChar(ExistFileName),PChar(NewFileName),False);
  end;
end;

{ ע��:
  WinNT/Win2000:
    ����ӵ�ж�Ӳ�̵Ķ�/д����Ȩ��
  Win98:
    ��\windows\system\SMARTVSD.VXD ���뿽���� \windows\system\iosubsys\��,
    ��Ҫ�����ڸ��ƺ���������ϵͳ}
//�õ�Ӳ�����к�
function GetIdeSerialNumber: PChar;
const
  IDENTIFY_BUFFER_SIZE=512;

type
  TIDERegs = packed record
    bFeaturesReg: BYTE; //Used for specifying SMART "commands".
    bSectorCountReg: BYTE; //IDE sector count register
    bSectorNumberReg: BYTE; //IDE sector number register
    bCylLowReg: BYTE; //IDE low order cylinder value
    bCylHighReg: BYTE; //IDE high order cylinder value
    bDriveHeadReg: BYTE; //IDE drive/head register
    bCommandReg: BYTE; //Actual IDE command.
    bReserved: BYTE; //reserved for future use.  Must be zero.
  end;

  TSendCmdInParams = packed record
    cBufferSize: DWORD; //Buffer size in bytes\
    irDriveRegs: TIDERegs; //Structure with drive register values.
    bDriveNumber: BYTE; // Physical drive number to send command to (0,1,2,3).
    bReserved: Array[0..2] of Byte;
    dwReserved: Array[0..3] of DWORD;
    bBuffer: Array[0..0] of Byte;  //Input buffer.
  end;

  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: Array[0..2] of Word;
    sSerialNumber: Array[0..19] of CHAR;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: Array[0..7] of Char;
    sModelNumber: Array[0..39] of Char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity: DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: Array[0..127] of BYTE;
  end;
  PIdSector = ^TIdSector;

  TDriverStatus = packed record
    bDriverError: Byte; // ���������صĴ�����룬�޴��򷵻�0
    bIDEStatus: Byte; // IDE����Ĵ��������ݣ�ֻ�е�bDriverError Ϊ SMART_IDE_ERROR ʱ��Ч
    bReserved: Array[0..1] of Byte;
    dwReserved: Array[0..1] of DWORD;
  end;

  TSendCmdOutParams = packed record
    cBufferSize: DWORD; // bBuffer�Ĵ�С
    DriverStatus: TDriverStatus; // ������״̬
    bBuffer: Array[0..0] of BYTE; // ���ڱ�������������������ݵĻ�������ʵ�ʳ�����cBufferSize����
  end;

var
  hDevice: THandle;
  cbBytesReturned: DWORD;
  //ptr: PChar;
  SCIP: TSendCmdInParams;
  aIdOutCmd: Array [0..(SizeOf(TSendCmdOutParams)+IDENTIFY_BUFFER_SIZE-1)-1] of Byte;
  IdOutCmd: TSendCmdOutParams absolute aIdOutCmd;

  procedure ChangeByteOrder( var Data; Size : Integer );
  var
    ptr: PChar;
    i: Integer;
    c: Char;
  begin
    ptr := @Data;
    for i := 0 to (Size shr 1)-1 do
    begin
      c:= ptr^;
      ptr^:= (ptr+1)^;
      (ptr+1)^:= c;
      Inc(ptr,2);
    end;
  end;

begin
  Result := ''; // ��������򷵻ؿմ�
  // Windows NT, Windows 2000
  if SysUtils.Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    // ��ʾ! �ı����ƿ���������������������ڶ����������� '\\.\PhysicalDrive1\'
    hDevice := CreateFile( '\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
  end
  else
    //Version Windows 95 OSR2, Windows 98
    hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );
  if hDevice=INVALID_HANDLE_VALUE then
    Exit;
  try
    FillChar(SCIP,SizeOf(TSendCmdInParams)-1,#0);
    FillChar(aIdOutCmd,SizeOf(aIdOutCmd),#0);
    cbBytesReturned := 0;
    //Set up data structures for IDENTIFY command.
    with SCIP do
    begin
      cBufferSize  := IDENTIFY_BUFFER_SIZE;
      //bDriveNumber := 0;
      with irDriveRegs do
      begin
        bSectorCountReg  := 1;
        bSectorNumberReg := 1;
        //if Win32Platform=VER_PLATFORM_WIN32_NT then bDriveHeadReg := $A0
        //else bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
        bDriveHeadReg    := $A0;
        bCommandReg      := $EC;
      end;
    end;
    if not DeviceIoControl( hDevice, $0007c088, @SCIP, SizeOf(TSendCmdInParams)-1,
      @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil ) then
      Exit;
  finally
    CloseHandle(hDevice);
  end;
  with PIdSector(@IdOutCmd.bBuffer)^ do
  begin
    ChangeByteOrder( sSerialNumber, SizeOf(sSerialNumber) );
    (PChar(@sSerialNumber)+SizeOf(sSerialNumber))^ := #0;
    Result := PChar(@sSerialNumber);
  end;
end;

//��ȡ�û�ע����
function GetRegisterStr: string;
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
    Result := ReadString('Config', 'Register', '');
  IniFile.Free;
end;

//��д�û�ע����
function SetRegisterStr(RegisterStr: string): string;
var
  IniFileName: string;
  IniFile: TIniFile;
begin
  IniFileName := GlobalPath+CONFIG_FILE;
  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
    WriteString('Config', 'Register', RegisterStr);
  IniFile.Free;
end;

//�ж��û��Ƿ����
function JudgeRegister: Boolean;
var
  RegisterStr, EncryptIdeSerialNumber: string;
begin
  RegisterStr := EncryptionEngine(GetRegisterStr,False);
  EncryptIdeSerialNumber := Trim(StrPas(GetIdeSerialNumber));
  Result := RegisterStr=EncryptIdeSerialNumber;
end;

//�õ��ļ�ǰ׺
function GetFilePre(FileName: string): string;
var
  DotPos: Integer;
begin
  DotPos := Pos('.', FileName);
  if DotPos=0 then
    Result := FileName
  else
    Result := Copy(FileName, 1, DotPos-1);
end;

//�õ�ϵͳ�ļ�Ŀ¼
function GetSystemDir: string;
var
  SystemDir: PChar;
begin
  GetMem(SystemDir,MAX_PATH);
  GetSystemDirectory(SystemDir, MAX_PATH);
  Result := strpas(SystemDir);
  FreeMem(SystemDir);
end;

//���ܽ����ַ���
function EncryptionEngine(Src: string; Encrypt:Boolean; Key:string=''): string;
var
  dest: string;
  KeyLen,KeyPos,offset: Integer;
  SrcPos,SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  Result := '';
  if Trim(Src)='' then Exit;
  if Key='' then key :='Mr Wang';
  KeyLen := Length(Key);
  KeyPos:=0;
  Range := 256;
  if Encrypt then
  begin
    Randomize;
    offset := Random(Range);
    dest := Format('%1.2x',[offset]);
    for SrcPos := 1 to Length(Src) do
    begin
      SrcAsc := (Ord(Src[SrcPos]) + offset) MOD 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      dest := dest + format('%1.2x',[SrcAsc]);
      offset := SrcAsc;
    end;
  end
  else
  begin
    try
      offset := StrToInt('$'+ copy(src,1,2));
    except
      offset := 69;
    end;
    SrcPos := 3;
    repeat
      try
        SrcAsc := StrToInt('$'+ copy(src,SrcPos,2));
      except
        SrcAsc := 69;
      end;
      if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= offset then
        TmpSrcAsc := 255 + TmpSrcAsc - offset
      else
        TmpSrcAsc := TmpSrcAsc - offset;
      dest := dest + chr(TmpSrcAsc);
      offset := srcAsc;
      SrcPos := SrcPos + 2;
    until SrcPos >= Length(Src);
  end;
  Result := Dest;
end;

//url����
function UrlEncode(Src: string): string;
var
  I : Integer;
begin
  Result := '';
  for I := 1 to Length(Src) do begin
    if Src[I] = ' ' then
        Result := Result + '+'
    else if Src[I] in ['a'..'z', 'A'..'Z', '0'..'9'] then
        Result := Result + Src[I]
    else
        Result := Result + '%' + IntToHex(ord(Src[I]), 2);
  end;

end;

end.
