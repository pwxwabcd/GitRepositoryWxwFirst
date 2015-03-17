unit PubFun;

interface
uses
  ShellApi, Windows, DB, ADODB, Dialogs, ComCtrls, SysUtils, Forms, StdCtrls,
  Controls, Classes, StrUtils, Graphics, ExtCtrls, IniFiles,
  Buttons, IdGlobal, Clipbrd, ComObj, Printers, Ora;

type

  //权限结构
  TPrivilege = packed record
    PNo: string[40];
  end;
  PPrivilege = ^TPrivilege;

  {数据库}
  //设置连接属性
    function SetConnection(ServerName,SaName,SaPassword: string;
    OraSession: TOraSession): Boolean; overload;
  //取消Ado事物状态
  procedure CancelTransaction(AdoConnection: TAdoConnection);
  //使AdoQuery执行返回结果集的Sql语句
  function Open_Sql(SqlString: string; var Query: TAdoQuery): Integer; overload
  function Open_Sql(SqlString: string; var Query: TAdoQuery;
    RowOfPage: Integer): Integer; overload;
  function Open_Sql(SqlString: string; var Query: TOraQuery): Integer; overload;
  //执行Sql语句
  function Exec_Sql(SqlString: string; var Query: TAdoQuery): Boolean;
  //批量执行Sql语句
  function BatchExec_Sql(SqlString: TStrings; var Query: TAdoQuery): Boolean;
  //批量执行Sql语句文件
  function BatchExecSqlFile(FileName: string): Boolean;

  //设置金额显示
  procedure SetJeShow(Field: TField; var Text: String; ShowZero: Boolean=True);
  //读取服务器名
  procedure GetSqlServerName(cbServerName: TComboBox);
  //读取数据库名
  procedure GetDBName(cbDBName: TComboBox; UserName,Password,ServerName: string);
  //备份SqlServer数据库
  function BackupDataBase(DBName,BackupFileName: string): Boolean;
  //还原SqlServer数据库
  function RestoreDataBase(DBName,BackupFileName: string): Boolean;
  //清除日志
  function ClearLog(DBName: string): Boolean;
  //建立数据库
  function CreateDB(DBName: string): Boolean;

  //*********************************临时表操作*******************//
  //得到最大临时号
  function GetMaxTempNo(TableName, ColumnName: string): Integer;
  //删除临时表数据
  function DelTempData(TableName: string; TempNo: Integer): Boolean;

  {控件函数}
  //*********************************ListView*******************//
  //将ListView的内容输出为Excel文件
  function ListViewToExcel(ListView: TListView): Boolean;
  //删除ListView的所选项
  procedure DelListItem(ListView: TListView);
  //删除ListView的Check项
  procedure DelCheckedListItem(ListView: TListView);
  //选取所有列表
  procedure SelectAllListItem(ListView: TListView; IsCheck: Boolean);
  //显示行数信息
  procedure ShowItemCount(ListView: TListView);
  //添加行
  procedure AddListItem(ListView: TListView; StrList: array of string;
    ItemData: Integer=0; ItemChecked: Boolean=False);
  //添加列
  procedure AddListHead(ListView: TListView; StrList: array of string);

  //*********************************Form*******************//
  //设置窗体适应分辨率
  procedure FormScale(Form: TForm);
  //设置窗体缩略图
  procedure MiniatureForm(Form: TForm; Image: TImage);
  //关闭所有子窗体
  procedure CloseAllChildForm(Form: TForm);

  //*********************************Edit*******************//  
  //限制实数输入字符
  procedure RealKeyPress(var Key: Char);

  //*********************************DBGrid*******************//
  //将回车键换成向下键,移到下一条记录
  procedure EnterNextRecord(var Key: Word);
  
  //*********************************树*******************//

  //取出节点编号
  function GetAllNo(TreeNode: TTreeNode): string;
  //判断添加节点有效性
  function JudgeAddTreeNode(TreeView: TTreeView): Boolean;
  //设置树图标
  procedure SetTreeImage(TreeView: TTreeView); overload;

  //设置树结点图标
  procedure SetTreeNodeImage(TreeNode: TTreeNode); overload;


  {通用函数}
  //*********************************其他*******************//
  //得到操作系统版本
  function GetSystemInfo: Integer;
  //显示关于信息
  procedure ShowAboutInfo(Handle: hWnd; NTTitle,Caption,WinTitle: string);
  //String用Case语句
  function StringIndex(SearchStr: string; StrList: array of string;
    IsSensitive: Boolean=True): Integer;
  //将Boolean转换成Integer
  function BoolToInt(BoolVal: Boolean): Integer;
  //读取打印票据凭证时的方向
  function GetPrintOrientation: TPrinterOrientation;
  //得到某年某月的最后一天
  function GetMonthEndDate(Year,Month: string): string;
  //得到某年某月的第一天
  function GetMonthBeginDate(Year,Month: string): string;
  //判断类别有效性
  function JudgeKind(KNo, KName: string): Boolean;
  //判断编号名称有效性
  function JudgeNoName(No, Name: string): Boolean;
  //得到硬盘序列号初始操作
  function GetIdePre: Boolean;
  //得到硬盘序列号
  function GetIdeSerialNumber: PChar;
  //获取用户注册码
  function GetRegisterStr: string;
  //填写用户注册码
  function SetRegisterStr(RegisterStr: string): string;
  //判断用户是否加密
  function JudgeRegister: Boolean;
  //得到文件前缀
  function GetFilePre(FileName: string): string;
  //得到系统文件目录
  function GetSystemDir: string;

  //*********************************货币*******************//
  //将小写金额变成大写
  function NumToChinese(MoneyNum: Currency): string;
  //将Format过的金额反格式化
  function UnFormatCurr(CurrStr: string): string;

  //*********************************字符串*******************//
  //取出空格分割的字符串
  function GetNoName(BlankStr: string; var No: string): string;
  //得到用‘-‘分隔的字符串的前部分
  function Get_BStr(_Str: string): string;
  //得到用‘-‘分隔的字符串的后部分
  function Get_AStr(_Str: string): string;
  //得到用‘_’分隔的字符串的前部分
  function Get_TStr(_Str: string): string;
  //从OrgStr中删除重复的RepStr
  function DelRepStr(OrgStr, RepStr: string): string;
  //取出逗号分割的字符串
  function GetCommaStr(var CommaStr: string): string;
  //删除字符串中的某个字符
  function DelChar(OrgStr, CharStr: string): string;
  //得到重复字符
  function GetRepChar(RepChar: Char; RepCount: Integer): string;
  //按每行字数换行
  function NewLine(OrgStr: string; WordNum: Integer): string;
  //判断有多少个汉字字节
  function ChsCount(OrgStr: string): Integer;
  //删除字符串中半个汉字字符
  function DelHalfChs(OrgStr: string): string;
  //回车换行符
  function EnterStr: string;
  //删除字符串
  function CutStr(OrgStr: string; WordNum: Integer): string;
  //替换字符串
  function ReplaceStr(OrgStr,FindStr,RepStr: string): string;
  //加密解密字符串
  function EncryptionEngine(Src: string; Encrypt:Boolean; Key:string=''): string;
  //url编码
  function UrlEncode(Src: string): string;

var
  SortType: Boolean;
  ColumnToSort,GlobalHbDxId: Integer;
  GlobalPath,GlobalReportPath,GlobalUserNo,GlobalUserName,LAST_DAY: string;
  GlobalIsAdmin: Boolean;
  GlobalCopyMobileName,GlobalCopyWriteTime,GlobalCopyRingName: string;
const
  CONFIG_FILE: string='mh.ini';
  HELP_FILE: string='民航短信信息系统使用说明.doc';
  INIT_FILE: string='JxcInit.sql';
  APP_VERSION: string='2014-10-09';
  ROW_OF_PAGE: Integer=7;
  //是否注册
  //{$DEFINE register}
  //********条件编译********//
  //{$ifdef register}
  //已注册信息
  //IDE_SERIAL_NUMBER: string='已注册';
  //LAST_DAY: string='3000-01-01';
  //{$else}
  //未注册信息
  //IDE_SERIAL_NUMBER: string='未注册';
  //LAST_DAY: string='2005-01-31';
  //{$endif}
  //报表
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


//设置连接属性
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

//取消Ado事物状态
procedure CancelTransaction(AdoConnection: TAdoConnection);
begin
  with AdoConnection do
    if InTransaction then
    begin
      Connected := False;
      Connected := True;
    end;
end;

//使AdoQuery执行返回结果集的Sql语句
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

//使AdoQuery执行返回结果集记录值为CountOfPage整数倍的Sql语句
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

//使AdoQuery执行返回结果集的Sql语句
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

//使AdoQuery执行不返回结果集的Sql语句
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

//批量执行Sql语句
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

//批量执行Sql语句文件
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

//将ListView的内容输出为Excel文件
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
    //设置另存对话框属性
    With SaveDialog do
    begin
      DefaultExt := '*.csv';
      Filter := 'Microsoft Excel 工作薄(*.csv)|*.csv|所有文件(*.*)|*.*';
      Options := [ofOverwritePrompt,ofHideReadOnly,ofEnableSizing];
    end;
    if SaveDialog.Execute then
    begin
      WaitForm.ShowInfo('正在导出Excel文件');
      //读取标题
      ColCount := ListView.Columns.Count;
      for i := 0 to ColCount-1 do
      begin
        InfoStr := DelChar(ListView.Columns[i].Caption, ',');
        if i<>ColCount-1 then
          TempStr := TempStr+InfoStr+','
        else
          TempStr := TempStr+InfoStr+EnterStr;
      end;
      //读取内容
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
      //写入文件
      AssignFile(ExcelFile,SaveDialog.FileName);
      try
        ReWrite(ExcelFile);
        WriteLn(ExcelFile,TempStr);
        CloseFile(ExcelFile);
        Result := True;
        WaitForm.Close;
        MessageBox(Application.Handle,'Excel文件保存成功！','提示',mb_IconInformation+mb_ok);
      Except
        WaitForm.Close;
        MessageBox(Application.Handle,'Excel文件保存失败，请稍后再试！','警告',mb_Ok+mb_IconWarning);
      end;
    end;
  finally
    SaveDialog.Free;
  end;
end;

//删除ListView的所选项
procedure DelListItem(ListView: TListView);
var
  i: Integer;
begin
  for i := ListView.Items.Count-1 downto 0 do
    if ListView.Items[i].Selected then
      ListView.Items[i].Delete;
end;

//得到操作系统版本
function GetSystemInfo: Integer;
var
  VI: TOSVersionInfo;
begin
  VI.dwOSVersionInfoSize := SizeOf(VI);
  GetVersionEx(VI);
  Result := VI.dwPlatformId;
end;

//显示关于信息
procedure ShowAboutInfo(Handle: hWnd; NTTitle,Caption,WinTitle: string);
begin
  if GetSystemInfo=Ver_PlatForm_Win32_NT then
    ShellAbout(Handle,PChar(NTTitle),PChar(Caption),0)
  else
    ShellAbout(Handle,PChar(WinTitle),PChar(Caption),0);
end;

//取出空格分割的字符串
function GetNoName(BlankStr: string; var No: string): string;
var
  BlankPos: Integer;
begin
  BlankPos := Pos(' ', BlankStr);
  No := Copy(BlankStr, 1, BlankPos-1);
  Result := Copy(BlankStr, BlankPos+1, Length(BlankStr));
end;




//取出节点编号
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

//判断添加节点有效性
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
    MessageBox(Application.Handle,'类别最多只能建3层!','警告',mb_Ok+mb_IconWarning);
    Exit;
  end;
  Result := True;
end;

//设置树结点图标
procedure SetTreeImage(TreeView: TTreeView);
var
  i: Integer;
begin
  for i := 0 to TreeView.Items.Count-1 do
    SetTreeNodeImage(TreeView.Items[i]);
end;

//设置树结点图标
procedure SetTreeNodeImage(TreeNode: TTreeNode);
begin
  with TreeNode do
  begin
    ImageIndex := 0;
    SelectedIndex := 2;
  end;
end;

//将小写金额变成大写
function NumToChinese(MoneyNum: Currency): string;
var
  Num: array[0..9] of string;
  Dep: array[1..8] of string;
  MoneyStr: string;
  i,EveryNum,PreNum: Integer;
begin
  //数字
  Num[0] := '零';
  Num[1] := '壹';
  Num[2] := '贰';
  Num[3] := '叁';
  Num[4] := '肆';
  Num[5] := '伍';
  Num[6] := '陆';
  Num[7] := '柒';
  Num[8] := '捌';
  Num[9] := '玖';
  //单位
  Dep[1] := '分';
  Dep[2] := '角';
  Dep[3] := '元';
  Dep[4] := '拾';
  Dep[5] := '佰';
  Dep[6] := '仟';
  Dep[7] := '万';
  Dep[8] := '亿';
  MoneyStr := ReverseString(FloatToStr(Abs(MoneyNum)*100));
  for i := 1 to Length(MoneyStr) do
  begin
    EveryNum := StrToInt(MoneyStr[i]);
    if i-1<>0 then
      PreNum := StrToInt(MoneyStr[i-1])  //下一位
    else
      PreNum := 1;
    if EveryNum=0 then
    begin
      if PreNum=0 then
        case i of
          3 : Result := Dep[3]+Result;  //元
          7 : Result := Dep[7]+Result;  //万元
          11: begin
                if Copy(Result, 1, 2)=Dep[7] then  //防止亿和万相连
                  Delete(Result, 1, 2);
                Result := Dep[8]+Result;  //亿元
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
        1 : Result := Num[EveryNum]+Dep[1]+Result;   //分
        2 : Result := Num[EveryNum]+Dep[2]+Result;   //角
        3 : Result := Num[EveryNum]+Dep[3]+Result;   //元
        4 : Result := Num[EveryNum]+Dep[4]+Result;   //拾元
        5 : Result := Num[EveryNum]+Dep[5]+Result;   //百元
        6 : Result := Num[EveryNum]+Dep[6]+Result;   //千元
        7 : Result := Num[EveryNum]+Dep[7]+Result;   //万元
        8 : Result := Num[EveryNum]+Dep[4]+Result;   //十万元
        9 : Result := Num[EveryNum]+Dep[5]+Result;   //百万元
        10: Result := Num[EveryNum]+Dep[6]+Result;   //千万元
        11: begin
              if Copy(Result, 1, 2)=Dep[7] then  //防止亿和万相连
                Delete(Result, 1, 2);
              Result := Num[EveryNum]+Dep[8]+Result;   //亿元
            end;
        12: Result := Num[EveryNum]+Dep[4]+Result;   //十亿元
        13: Result := Num[EveryNum]+Dep[5]+Result;   //百亿元
        14: Result := Num[EveryNum]+Dep[6]+Result;   //千亿元
      end;
  end;
  if Copy(Result,Length(Result)-1,Length(Result))='元' then
    Result := Result+'整';
end;

//得到用‘-‘分隔的字符串的前部分
function Get_BStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('-', _Str);
  Result := Copy(_Str, 1, _Pos-1);
end;

//得到用‘-‘分隔的字符串的后部分
function Get_AStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('-', _Str);
  Result := Copy(_Str, _Pos+1, Length(_Str));
end;

//从OrgStr中删除重复的RepStr
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

//得到最大临时号
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

//删除临时表数据
function DelTempData(TableName: string; TempNo: Integer): Boolean;
var
  SqlString: string;
begin
  SqlString := 'delete '+Tablename+' where TempNo=%d';
  SqlString := Format(SqlString, [TempNo]);
  with CommonDataModule do
    Result := Exec_Sql(SqlString, qryMain);
end;

//设置金额显示
procedure SetJeShow(Field: TField; var Text: String; ShowZero: Boolean=True);
begin
  if (Field.AsCurrency=0) and (not ShowZero) then
    Text := ''
  else
    Text := Format('%m', [Field.AsCurrency]);
end;

//设置窗体适应分辨率
procedure FormScale(Form: TForm);
begin
  if Screen.Width<>800 then
  begin
    Form.Height:= Form.Height*Screen.Height div 600;
    Form.Width:= Form.Width*Screen.Width div 800;
    Form.ScaleBy(Screen.Width,800);
  end;
end;

//选取所有列表
procedure SelectAllListItem(ListView: TListView; IsCheck: Boolean);
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count-1 do
    ListView.Items[i].Checked := IsCheck;
end;

//显示行数信息
procedure ShowItemCount(ListView: TListView);
begin
  ListView.Hint := '共 '+IntToStr(ListView.Items.Count)+' 条记录';
end;

//添加行
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

//添加列
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

//删除ListView的Check项
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

//将Format过的金额反格式化
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

//取出逗号分割的字符串
function GetCommaStr(var CommaStr: string): string;
var
  CommaPos: Integer;
begin
  CommaPos := Pos(',', CommaStr);
  Result := Copy(CommaStr, 1, CommaPos-1);
  CommaStr := Copy(CommaStr, CommaPos+1, Length(CommaStr));
end;

//String用Case语句
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

//得到用‘_’分隔的字符串的前部分
function Get_TStr(_Str: string): string;
var
  _Pos: Integer;
begin
  _Pos := Pos('_', _Str);
  Result := Copy(_Str, 1, _Pos-1);
end;

//删除字符串中的某个字符
function DelChar(OrgStr, CharStr: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(OrgStr) do
    if OrgStr[i]<>CharStr then
      Result := Result+OrgStr[i];
end;

//将Boolean转换成Integer
function BoolToInt(BoolVal: Boolean): Integer;
begin
  if BoolVal then
    Result := 1
  else
    Result := 0;
end;

//限制实数输入字符
procedure RealKeyPress(var Key: Char);
begin
  //数字或BackSpace,Delete,小数点
  if (not IsNumeric(Key)) and (Key<>Char(8)) and (Key<>Char(46))
    and (Key<>'.') then
    Key := Char(0);
end;

//设置窗体缩略图
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

//关闭所有子窗体
procedure CloseAllChildForm(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.MDIChildCount-1 do
    if Assigned(Form.MDIChildren[i]) then
      Form.MDIChildren[i].Close;
end;

//得到重复字符
function GetRepChar(RepChar: Char; RepCount: Integer): string;
begin
  Result := '';
  while RepCount>0 do
  begin
    Result := Result+RepChar;
    Dec(RepCount);
  end;
end;

//读取服务器名
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

//读取数据库名
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

//备份SqlServer数据库
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

//还原SqlServer数据库
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

//清除日志
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

//建立数据库
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

//按每行字数换行
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

//判断有多少个汉字字节
function ChsCount(OrgStr: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(OrgStr) do
    if ord(OrgStr[i])>127 then
      Result := Result+1;
end;

//删除字符串中半个汉字字符
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

//读取打印票据凭证时的方向
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

//回车换行符
function EnterStr: string;
Begin
  Result := Chr(13)+Chr(10);
end;

//删除字符串
function CutStr(OrgStr: string; WordNum: Integer): string;
begin
  Result := Copy(OrgStr,1,WordNum);
  Result := DelHalfChs(Result);
end;

//将回车键换成向下键,移到下一条记录
procedure EnterNextRecord(var Key: Word);
begin
  if Key=13 then
    Key := 40;
end;

//得到选择的树结点个数
{function GetCheckCount(TreeView: TfcTreeView): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to TreeView.Items.Count - 1 do
    if (TreeView.Items[i].Level<>0) and (TreeView.Items[i].Checked) then
      Inc(Result);
end;}

//替换字符串
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

//得到某年某月的最后一天
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

//得到某年某月的第一天
function GetMonthBeginDate(Year,Month: string): string;
var
  iYear,iMonth,iDate: Integer;
begin
  iYear := StrToInt(Year);
  iMonth := StrToInt(Month);
  iDate := 1;
  Result := DateToStr(EncodeDate(iYear,iMonth,iDate));
end;

//判断类别有效性
function JudgeKind(KNo, KName: string): Boolean;
begin
  Result := True;
  if Length(KNo)<>2 then
  begin
    MessageBox(Application.Handle,'编号应为2位字符!','警告',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
  if Length(KName)=0 then
  begin
    MessageBox(Application.Handle,'名称不应为空!','警告',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
end;

//判断编号名称有效性
function JudgeNoName(No, Name: string): Boolean;
begin
  Result := True;
  if Length(No)=0 then
  begin
    MessageBox(Application.Handle,'编号不应为空!','警告',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
  if Length(Name)=0 then
  begin
    MessageBox(Application.Handle,'名称不应为空!','警告',mb_Ok+mb_IconWarning);
    Result := False;
    Exit;
  end;
end;

//得到硬盘序列号初始操作
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

{ 注意:
  WinNT/Win2000:
    必须拥有对硬盘的读/写访问权限
  Win98:
    将\windows\system\SMARTVSD.VXD 必须拷贝到 \windows\system\iosubsys\下,
    不要忘记在复制后重新启动系统}
//得到硬盘序列号
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
    bDriverError: Byte; // 驱动器返回的错误代码，无错则返回0
    bIDEStatus: Byte; // IDE出错寄存器的内容，只有当bDriverError 为 SMART_IDE_ERROR 时有效
    bReserved: Array[0..1] of Byte;
    dwReserved: Array[0..1] of DWORD;
  end;

  TSendCmdOutParams = packed record
    cBufferSize: DWORD; // bBuffer的大小
    DriverStatus: TDriverStatus; // 驱动器状态
    bBuffer: Array[0..0] of BYTE; // 用于保存从驱动器读出的数据的缓冲区，实际长度由cBufferSize决定
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
  Result := ''; // 如果出错则返回空串
  // Windows NT, Windows 2000
  if SysUtils.Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    // 提示! 改变名称可适用于其它驱动器，如第二个驱动器： '\\.\PhysicalDrive1\'
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

//获取用户注册码
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

//填写用户注册码
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

//判断用户是否加密
function JudgeRegister: Boolean;
var
  RegisterStr, EncryptIdeSerialNumber: string;
begin
  RegisterStr := EncryptionEngine(GetRegisterStr,False);
  EncryptIdeSerialNumber := Trim(StrPas(GetIdeSerialNumber));
  Result := RegisterStr=EncryptIdeSerialNumber;
end;

//得到文件前缀
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

//得到系统文件目录
function GetSystemDir: string;
var
  SystemDir: PChar;
begin
  GetMem(SystemDir,MAX_PATH);
  GetSystemDirectory(SystemDir, MAX_PATH);
  Result := strpas(SystemDir);
  FreeMem(SystemDir);
end;

//加密解密字符串
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

//url编码
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
