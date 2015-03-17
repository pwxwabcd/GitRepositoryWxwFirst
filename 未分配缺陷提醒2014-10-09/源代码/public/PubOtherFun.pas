unit PubOtherFun;

interface
uses
  ShellApi, Windows, DB, ADODB, Dialogs, ComCtrls, SysUtils, Forms, StdCtrls,
  Controls, Classes, StrUtils, Graphics, ExtCtrls, IniFiles,
  Buttons, IdGlobal, Clipbrd, ComObj, Printers;
  //********ϵͳ����********//
  //��ȡϵͳ����
  function GetSystemConfig(Param: string): string;
  //����ϵͳ����
  function UpdateSystemConfig(Param,CurValue: string): Boolean;


  //********�û�********//
  //�õ��û���Ϣ
  function GetUserInfo(UNo: string; var UserName,Password: string): Boolean;
  //�õ��û���
  function GetUserName(UNo: string): string;
  //�����û���Ϣ
  function SetUserInfo(UNo,UName,Password: string): Boolean;
  //��ʾ�û�
  procedure ShowUser(lvUser: TListView);
  //�����û�
  function InsertUser(UNo,UName,Password: string): Boolean;
  //ɾ���û�
  function DelUser(UNo: string): Boolean;
  //�û��Ƿ����
  function ExistUser(UNo: string): Boolean;

  //********������Ϣ********//
  //���뺽����Ϣ
  function InsertHbxx(HbName,HbBeginStation,HbEndStation,HbItem,HbWeek,HbLeave,HbReturn: string): Boolean;
  //���º�����Ϣ
  function UpdateHbxx(HbName,HbBeginStation,HbEndStation,HbItem,HbWeek,HbLeave,HbReturn: string): Boolean;
  //ɾ��������Ϣ
  function DeleteHbxx(HbName: string): Boolean;
  //������Ϣ�Ƿ����
  function ExistHbxx(HbName: string): Boolean;
  //��ʾ������Ϣ
  procedure ShowHbxx(lvHbxx: TListView);

  //********Ʊ����Ϣ********//
  //�õ�Ʊ����Ϣ
  function GetPriceInfo(HbName: string; var HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,A06,
      A07,A08,A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,B09,
      B10,B11,B12,B13,B14,B15: string): Boolean;
  //����Ʊ����Ϣ
  function UpdatePrice(HbName,HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,A06,
      A07,A08,A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,B09,
      B10,B11,B12,B13,B14,B15: string): Boolean;

  //********��Ʊ��Ϣ********//
  //��ʾ��Ʊ��Ϣ
  procedure ShowOrder(lvOrder: TListView);
  //�����Ķ���־
  function UpdateReadOrder(HbDxId: Integer): Boolean;
  //���´����־
  function UpdateDealWithOrder(HbDxId: Integer): Boolean;
  //ɾ����Ʊ��Ϣ
  function DeleteOrder(HbDxId: Integer): Boolean;
  //��ʾ��Ʊ��ʾ
  procedure ShowOrderHint();
  //������ʾ��Ϣ
  procedure setHintInfo(defect_count, MyBugCount: Integer);
  //δ����Bug��ͳ��
  function CountAssignBug(): Integer;
  //����û��Ƿ���Ч
  function IsUserValid(UserNo: String): Boolean;
  //�ҵ�Bug��ͳ��
  function CountMyBug(UserNo: String): Integer;
  //��ʾ��Ʊ��Ϣ
  procedure ShowOrderInfo();
  //��ѯ��Ʊ��Ϣ
  procedure QueryOrder(lvOrder: TListView; SqlString: string);

  //********������Ϣ********//
  //��ѯ������Ϣ
  procedure QueryRing(lvRing: TListView; SqlString: string);
  //��������
  function SendRing(RingId: Integer; MobileNumber,Content: string): Boolean;

implementation
uses
  WaitFrm, CommonDM, PubFun, OrderFrm, MainFrm;

  //********ϵͳ����********//
//��ȡϵͳ����
function GetSystemConfig(Param: string): string;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select CurValue from t_SystemConfig where Param=''%s''';
    SqlString := Format(SqlString, [Param]);
    if Open_Sql(SqlString, qryTemp)=1 then
      with qryTemp do
        Result := FieldByName('CurValue').AsString
    else
      Result := '';
  end;
end;

//����ϵͳ����
function UpdateSystemConfig(Param,CurValue: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update t_SystemConfig set CurValue=''%s'' where Param=''%s''';
    SqlString := Format(SqlString, [CurValue,Param]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

  //********�û�********//
//�õ��û���Ϣ
function GetUserInfo(UNo: string; var UserName,Password: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select mamark,mancode from manage '
      +'where manname=''%s''';
    SqlString := Format(SqlString, [UNo]);
    if Open_Sql(SqlString, qryTemp)=1 then
    begin
      with qryTemp do
      begin
        UserName := FieldByName('mamark').AsString;
        Password := FieldByName('mancode').AsString;
      end;
      Result := True;
    end
    else
      Result := False;
  end;
end;

//�õ��û���
function GetUserName(UNo: string): string;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select mamark from manage where manname=''%s''';
    SqlString := Format(SqlString, [UNo]);
    if Open_Sql(SqlString, qryTemp)=1 then
      with qryTemp do
        Result := FieldByName('mamark').AsString
    else
      Result := '';
  end;
end;

//�����û���Ϣ
function SetUserInfo(UNo,UName,Password: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update manage set mamark=''%s'',mancode=''%s'' '
      +'where manname=''%s''';
    SqlString := Format(SqlString, [UName,Password,UNo]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//��ʾ�û�
procedure ShowUser(lvUser: TListView);
var
  SqlString,UNo,UName: string;
begin
  lvUser.Items.Clear;
  with CommonDataModule do
  begin
    SqlString := 'select manname,mamark '
      +'from manage '
      +'order by manname';
    if Open_Sql(SqlString, qryMain)=1 then
      while not qryMain.Eof do
      begin
        with qryMain do
        begin
          UNo := FieldByName('manname').AsString;
          UName := FieldByName('mamark').AsString;
        end;
        AddListItem(lvUser, [UNo,UName]);
        qryMain.Next;
      end;
  end;
  ShowItemCount(lvUser);
end;

//�����û�
function InsertUser(UNo,UName,Password: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'insert manage(manname,mamark,mancode) '
      +'values(''%s'',''%s'',''%s'')';
    SqlString := Format(SqlString, [UNo,UName,Password]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//ɾ���û�
function DelUser(UNo: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'delete manage where manname=''%s''';
    SqlString := Format(SqlString, [UNo]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//�û��Ƿ����
function ExistUser(UNo: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select manname from manage where manname=''%s''';
    SqlString := Format(SqlString, [UNo]);
    Result := Open_Sql(SqlString, qryTemp)=1;
  end;
end;

  //********������Ϣ********//
//���뺽����Ϣ
function InsertHbxx(HbName,HbBeginStation,HbEndStation,HbItem,HbWeek,HbLeave,HbReturn: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'insert Hb_Hbxxcx(HbName,HbBeginStation,HbEndStation,HbItem,'
      + 'HbWeek,HbLeave,HbReturn) '
      + 'values(''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')';
    SqlString := Format(SqlString, [HbName,HbBeginStation,HbEndStation,HbItem,
        HbWeek,HbLeave,HbReturn]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//���º�����Ϣ
function UpdateHbxx(HbName,HbBeginStation,HbEndStation,HbItem,HbWeek,HbLeave,HbReturn: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update Hb_Hbxxcx set HbName=''%s'',HbBeginStation=''%s'','
      + 'HbEndStation=''%s'',HbItem=''%s'',HbWeek=''%s'',HbLeave=''%s'','
      + 'HbReturn=''%s'' '
      + 'where HbName=''%s''';
    SqlString := Format(SqlString, [HbName,HbBeginStation,HbEndStation,HbItem,
        HbWeek,HbLeave,HbReturn,HbName]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//ɾ��������Ϣ
function DeleteHbxx(HbName: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'delete Hb_Hbxxcx where HbName=''%s''';
    SqlString := Format(SqlString, [HbName]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//������Ϣ�Ƿ����
function ExistHbxx(HbName: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select HbxxId from Hb_Hbxxcx where HbName=''%s''';
    SqlString := Format(SqlString, [HbName]);
    Result := Open_Sql(SqlString, qryTemp)=1;
  end;
end;

//��ʾ������Ϣ
procedure ShowHbxx(lvHbxx: TListView);
var
  SqlString,HbName,HbBeginStation,HbEndStation,HbItem,
      HbWeek,HbLeave,HbReturn: string;
begin
  lvHbxx.Items.Clear;
  with CommonDataModule do
  begin
    SqlString := 'select HbName,HbBeginStation,HbEndStation,HbItem,'
      + 'HbWeek,HbLeave,HbReturn '
      +'from Hb_Hbxxcx '
      +'order by HbName';
    if Open_Sql(SqlString, qryMain)=1 then
      while not qryMain.Eof do
      begin
        with qryMain do
        begin
          HbName := FieldByName('HbName').AsString;
          HbBeginStation := FieldByName('HbBeginStation').AsString;
          HbEndStation := FieldByName('HbEndStation').AsString;
          HbItem := FieldByName('HbItem').AsString;
          HbWeek := FieldByName('HbWeek').AsString;
          HbLeave := FieldByName('HbLeave').AsString;
          HbReturn := FieldByName('HbReturn').AsString;
        end;
        AddListItem(lvHbxx, [HbName,HbItem,HbBeginStation,HbEndStation,HbLeave,
            HbReturn,HbWeek]);
        qryMain.Next;
      end;
  end;
  ShowItemCount(lvHbxx);
end;

  //********Ʊ����Ϣ********//
//�õ�Ʊ����Ϣ
function GetPriceInfo(HbName: string; var HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,A06,
      A07,A08,A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,B09,
      B10,B11,B12,B13,B14,B15: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,A06,A07,A08,'
      +'A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,B09,B10,B11,'
      +'B12,B13,B14,B15 '
      +'from Hb_HbPrice '
      +'where HbName=''%s''';
    SqlString := Format(SqlString, [HbName]);
    if Open_Sql(SqlString, qryTemp)=1 then
    begin
      with qryTemp do
      begin
        HbHighPrice := FieldByName('HbHighPrice').AsString;
        HbCommonly := FieldByName('HbCommonly').AsString;
        A01 := FieldByName('A01').AsString;
        A02 := FieldByName('A02').AsString;
        A03 := FieldByName('A03').AsString;
        A04 := FieldByName('A04').AsString;
        A05 := FieldByName('A05').AsString;
        A06 := FieldByName('A06').AsString;
        A07 := FieldByName('A07').AsString;
        A08 := FieldByName('A08').AsString;
        A09 := FieldByName('A09').AsString;
        A10 := FieldByName('A10').AsString;
        A11 := FieldByName('A11').AsString;
        A12 := FieldByName('A12').AsString;
        A13 := FieldByName('A13').AsString;
        A14 := FieldByName('A14').AsString;
        A15 := FieldByName('A15').AsString;
        B01 := FieldByName('B01').AsString;
        B02 := FieldByName('B02').AsString;
        B03 := FieldByName('B03').AsString;
        B04 := FieldByName('B04').AsString;
        B05 := FieldByName('B05').AsString;
        B06 := FieldByName('B06').AsString;
        B07 := FieldByName('B07').AsString;
        B08 := FieldByName('B08').AsString;
        B09 := FieldByName('B09').AsString;
        B10 := FieldByName('B10').AsString;
        B11 := FieldByName('B11').AsString;
        B12 := FieldByName('B12').AsString;
        B13 := FieldByName('B13').AsString;
        B14 := FieldByName('B14').AsString;
        B15 := FieldByName('B15').AsString;        
      end;
      Result := True;
    end
    else
      Result := False;
  end;
end;

//����Ʊ����Ϣ
function UpdatePrice(HbName,HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,A06,
      A07,A08,A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,B09,
      B10,B11,B12,B13,B14,B15: string): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update Hb_HbPrice set HbHighPrice=''%s'',HbCommonly=''%s'','
      +'A01=''%s'',A02=''%s'',A03=''%s'',A04=''%s'',A05=''%s'',A06=''%s'','
      +'A07=''%s'',A08=''%s'',A09=''%s'',A10=''%s'',A11=''%s'',A12=''%s'','
      +'A13=''%s'',A14=''%s'',A15=''%s'',B01=''%s'',B02=''%s'',B03=''%s'','
      +'B04=''%s'',B05=''%s'',B06=''%s'',B07=''%s'',B08=''%s'',B09=''%s'','
      +'B10=''%s'',B11=''%s'',B12=''%s'',B13=''%s'',B14=''%s'',B15=''%s'' '
      +'where HbName=''%s''';
    SqlString := Format(SqlString, [HbHighPrice,HbCommonly,A01,A02,A03,A04,A05,
      A06,A07,A08,A09,A10,A11,A12,A13,A14,A15,B01,B02,B03,B04,B05,B06,B07,B08,
      B09,B10,B11,B12,B13,B14,B15,HbName]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//********��Ʊ��Ϣ********//
//��ʾ��Ʊ��Ϣ
procedure ShowOrder(lvOrder: TListView);
var
  SqlString,MobileNumber,RingName,PinPai,WriteTime,ReadStr,OrderStr: string;
  Id: Integer;
  IsRead,IsDeal: Boolean;
begin
  lvOrder.Items.Clear;
  with CommonDataModule do
  begin
    SqlString := 'select Id,MobileNumber,RingName,PinPai,WriteTime,IsRead,IsDeal '
      +'from zhenchang_info '
      +'order by WriteTime desc';
    if Open_Sql(SqlString, qryMain)=1 then
      while not qryMain.Eof do
      begin
        with qryMain do
        begin
          Id := FieldByName('Id').AsInteger;
          MobileNumber := FieldByName('MobileNumber').AsString;
          RingName := FieldByName('RingName').AsString;
          PinPai := FieldByName('PinPai').AsString;
          WriteTime := FieldByName('WriteTime').AsString;
          IsRead := FieldByName('IsRead').AsBoolean;
          IsDeal := FieldByName('IsDeal').AsBoolean;
        end;
        if not IsRead then
          ReadStr := 'δ�Ķ�'
        else
          ReadStr := '���Ķ�';
        if not IsDeal then
          OrderStr := 'δ����'
        else
          OrderStr := '�Ѵ���';
        AddListItem(lvOrder, [MobileNumber,RingName,PinPai,WriteTime,ReadStr,OrderStr], Id);
        qryMain.Next;
      end;
  end;
  ShowItemCount(lvOrder);
end;

//�����Ķ���־
function UpdateReadOrder(HbDxId: Integer): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update zhenchang_info set IsRead=1, IsDeal=0 '
      + 'where Id=%d';
    SqlString := Format(SqlString, [HbDxId]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//���´����־
function UpdateDealWithOrder(HbDxId: Integer): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'update zhenchang_info set IsRead=1, IsDeal=1 '
      + 'where Id=%d';
    SqlString := Format(SqlString, [HbDxId]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//ɾ����Ʊ��Ϣ
function DeleteOrder(HbDxId: Integer): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'delete zhenchang_info where Id=%d';
    SqlString := Format(SqlString, [HbDxId]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

//��ʾ��Ʊ��ʾ
procedure ShowOrderHint();
var
  defect_count, MyBugCount: Integer;
begin
  MyBugCount := CountMyBug(GlobalUserNo);
  defect_count := 0;
  setHintInfo(defect_count, MyBugCount)
end;

//������ʾ��Ϣ
procedure setHintInfo(defect_count, MyBugCount: Integer);
begin
  if GlobalUserNo='��Сΰ' then
  begin
    defect_count := CountAssignBug();
    MainForm.LMDTrayIcon.Hint := 'δ����Bug����' + IntToStr(defect_count) + #13#10 + 'δ���Bug����' + IntToStr(MyBugCount);
  end
  else
  begin
    MainForm.LMDTrayIcon.Hint := 'δ���Bug����' + IntToStr(MyBugCount);
  end;

    if (defect_count<>0) or (MyBugCount<>0) then
    begin
      MainForm.LMDTrayIcon.Animated := True;
    end
    else
    begin
      MainForm.LMDTrayIcon.Animated := False;
    end;
end;

//����û��Ƿ���Ч
function IsUserValid(UserNo: String): Boolean;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select 1 from USERS t where t.login_name=''' + UserNo + '''';
    if Open_Sql(SqlString, qryCw)=1 then
    begin
      Result := true;
    end
    else
    begin
      Result := false;
    end;
  end;
end;

//�ҵ�Bug��ͳ��
function CountMyBug(UserNo: String): Integer;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select count(distinct T1.dbid) BUG_COUNT' + #13#10 +
'  from Defect T1, statedef T4, users T5, users T2' + #13#10 +
' where T1.state = T4.id' + #13#10 +
'   and T1.submitter = T5.dbid' + #13#10 +
'   and T1.owner = T2.dbid' + #13#10 +
'   and (T1.dbid <> 0 and' + #13#10 +
'       ((T2.login_name = ''' + UserNo + ''' and' + #13#10 +
'       (T4.name in (''Assigned'', ''Opened'', ''Postponed'', ''Submitted'')) and' + #13#10 +
'       (T1.severity <> ''5 �� �д��Ľ�'' or T1.severity is NULL))))';
    if Open_Sql(SqlString, qryCw)=1 then
    begin
      with qryCW do
      begin
        Result := FieldByName('BUG_COUNT').AsInteger;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

//δ����Bug��ͳ��
function CountAssignBug(): Integer;
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'select count(distinct T1.dbid) defect_count' + #13#10 +
'  from Defect T1, users T2, statedef T4, users T5' + #13#10 +
' where T1.owner = T2.dbid' + #13#10 +
'   and T1.state = T4.id' + #13#10 +
'   and T1.submitter = T5.dbid' + #13#10 +
'   and (T1.dbid <> 0 and' + #13#10 +
'       (((T4.name in (''Submitted'')) and' + #13#10 +
'       (T1.severity <> ''5 �� �д��Ľ�'' or T1.severity is NULL))))';
    if Open_Sql(SqlString, qryCw)=1 then
    begin
      with qryCW do
      begin
        Result := FieldByName('DEFECT_COUNT').AsInteger;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

//��ʾ��Ʊ��Ϣ
procedure ShowOrderInfo();
var
  SqlString,MobileNumber,RingName,PinPai,WriteTime,ReadStr,OrderStr: string;
  Id: Integer;
  IsRead,IsDeal: Boolean;
begin
  with CommonDataModule do
  begin
    SqlString := 'select top 1 Id,MobileNumber,RingName,PinPai,WriteTime,IsRead,IsDeal '
      +'from zhenchang_info '
      +'where IsRead=0 '
      +'order by WriteTime';
    if Open_Sql(SqlString, qryMain)=1 then
    begin
      with qryMain do
      begin
        Id := FieldByName('Id').AsInteger;
        MobileNumber := FieldByName('MobileNumber').AsString;
        RingName := FieldByName('RingName').AsString;
        PinPai := FieldByName('PinPai').AsString;
        WriteTime := FieldByName('WriteTime').AsString;
        IsRead := FieldByName('IsRead').AsBoolean;
        IsDeal := FieldByName('IsDeal').AsBoolean;
      end;
      if not IsRead then
        ReadStr := 'δ�Ķ�'
      else
        ReadStr := '���Ķ�';
      if not IsDeal then
        OrderStr := 'δ����'
      else
        OrderStr := '�Ѵ���';
      OrderForm := TOrderForm.Create(nil);
      with OrderForm do
      begin
        edtMobileNumber.Text := MobileNumber;
        edtWriteTime.Text := WriteTime;
        edtIsRead.Text := ReadStr;
        edtIsDeal.Text := OrderStr;
        edtRingName.Text := RingName;
        edtPinPai.Text := PinPai;
        OrderForm.HelpContext := Id;
        HelpKeyword := 'Edit';
        ShowModal;
        Free;
      end;
      OrderForm := nil;
    end;
    MainForm.LMDTrayIcon.Animated := False;
    MainForm.LMDTrayIcon.Active := True;
  end;
end;

//��ѯ��Ʊ��Ϣ
procedure QueryOrder(lvOrder: TListView; SqlString: string);
var
  MobileNumber,RingName,PinPai,WriteTime,ReadStr,OrderStr: string;
  Id: Integer;
  IsRead,IsDeal: Boolean;
begin
  lvOrder.Items.Clear;
  with CommonDataModule do
  begin
    if Open_Sql(SqlString, qryMain)=1 then
      while not qryMain.Eof do
      begin
        with qryMain do
        begin
          Id := FieldByName('Id').AsInteger;
          MobileNumber := FieldByName('MobileNumber').AsString;
          RingName := FieldByName('RingName').AsString;
          PinPai := FieldByName('PinPai').AsString;
          WriteTime := FieldByName('WriteTime').AsString;
          IsRead := FieldByName('IsRead').AsBoolean;
          IsDeal := FieldByName('IsDeal').AsBoolean;
        end;
        if not IsRead then
          ReadStr := 'δ�Ķ�'
        else
          ReadStr := '���Ķ�';
        if not IsDeal then
          OrderStr := 'δ����'
        else
          OrderStr := '�Ѵ���';
        AddListItem(lvOrder, [MobileNumber,RingName,PinPai,WriteTime,ReadStr,OrderStr], Id);
        qryMain.Next;
      end;
  end;
  ShowItemCount(lvOrder);
end;

  //********������Ϣ********//
//��ѯ������Ϣ
procedure QueryRing(lvRing: TListView; SqlString: string);
var
  RingName,RingPathWWW,RingMobileType,RingType,RingTypesId,RingLeiName: string;
  RingId,Plus: Integer;
begin
  lvRing.Items.Clear;
  with CommonDataModule do
  begin
    if Open_Sql(SqlString, qryMain)=1 then
      while not qryMain.Eof do
      begin
        with qryMain do
        begin
          RingId := FieldByName('RingId').AsInteger;
          RingName := FieldByName('RingName').AsString;
          RingPathWWW := FieldByName('RingPathWWW').AsString;
          Plus := FieldByName('Plus').AsInteger;
          RingMobileType := FieldByName('RingMobileTypes').AsString;
          RingTypesId := FieldByName('RingTypesId').AsString;
          RingLeiName := FieldByName('RingLeiName').AsString;
        end;
        if Plus=0 then
          RingType := '��ͨ����'
        else
          RingType := '��Ч����';
        AddListItem(lvRing, [RingName,RingPathWWW,RingMobileType,RingType,RingTypesId,RingLeiName], RingId);
        qryMain.Next;
      end;
  end;
  ShowItemCount(lvRing);
end;

//��������
function SendRing(RingId: Integer; MobileNumber,Content: string): Boolean;
  {with CommonDataModule.stpMain do
  begin
    try
      Close;
      ProcedureName := 'NewMobile.dbo.mms_send_add';
      with Parameters do
      begin
        Refresh;
        ParamByName('@souraddr').Value := MobileNumber;
        ParamByName('@destaddr').Value := MobileNumber;
        ParamByName('@fileid').Value := RingId;
        ParamByName('@types').Value := 'ring';
        ParamByName('@linkID').Value := '';
      end;
      ExecProc;
      Result := True;
    except
      Result := False;
    end;
  end;}
var
  SqlString: string;
begin
  with CommonDataModule do
  begin
    SqlString := 'declare @Returninfo varchar(200) '
      + 'exec NewMobile.dbo.mms_send_add_push ''%s'',''%s'',%d,''%s'',''%s'',''%s'',@Returninfo';
    SqlString := Format(SqlString, [MobileNumber,MobileNumber,RingId,'ring','',Content]);
    Result := Exec_Sql(SqlString, qryTemp);
  end;
end;

end.
