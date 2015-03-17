object LoginForm: TLoginForm
  Left = 216
  Top = 182
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26410#20998#37197#32570#38519#25552#37266
  ClientHeight = 174
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label3: TLabel
    Left = 31
    Top = 47
    Width = 54
    Height = 12
    Caption = #36134'    '#21495':'
  end
  object pcLogin: TPageControl
    Left = 0
    Top = 0
    Width = 312
    Height = 174
    ActivePage = tsSecond
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    object tsSecond: TTabSheet
      Caption = 'tsSecond'
      TabVisible = False
      object lblNo: TLabel
        Left = 31
        Top = 62
        Width = 54
        Height = 12
        Caption = #36134'    '#21495':'
      end
      object lblPassword: TLabel
        Left = 31
        Top = 96
        Width = 54
        Height = 12
        Caption = #23494'    '#30721':'
        Visible = False
      end
      object bvlFirst: TBevel
        Left = 4
        Top = 131
        Width = 293
        Height = 2
      end
      object edtUserNo: TEdit
        Left = 129
        Top = 58
        Width = 121
        Height = 20
        MaxLength = 40
        TabOrder = 0
      end
      object edtPassword: TEdit
        Left = 129
        Top = 92
        Width = 121
        Height = 20
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 1
        Visible = False
      end
      object btnOver: TButton
        Left = 167
        Top = 141
        Width = 60
        Height = 20
        Caption = #23436#25104
        Default = True
        TabOrder = 2
        OnClick = btnOverClick
      end
      object btnSecondCancel: TButton
        Left = 227
        Top = 141
        Width = 60
        Height = 20
        Cancel = True
        Caption = #21462#28040
        ModalResult = 2
        TabOrder = 4
      end
      object pnlFirst: TPanel
        Left = 0
        Top = 0
        Width = 304
        Height = 41
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 3
        object lblFirstInfo: TLabel
          Left = 3
          Top = 8
          Width = 102
          Height = 12
          Caption = #36755#20837'CQ'#20013#25991#29992#25143#21517':'
        end
      end
    end
    object tsSetup: TTabSheet
      ImageIndex = 2
      TabVisible = False
      object lblServer: TLabel
        Left = 27
        Top = 48
        Width = 54
        Height = 12
        Caption = #26381#21153#22120'IP:'
      end
      object lblSaPassword: TLabel
        Left = 27
        Top = 118
        Width = 54
        Height = 12
        Caption = #23494'    '#30721':'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object bvlSetup: TBevel
        Left = 4
        Top = 138
        Width = 295
        Height = 2
      end
      object lblSaName: TLabel
        Left = 27
        Top = 94
        Width = 54
        Height = 12
        Caption = #29992'    '#25143':'
      end
      object Label1: TLabel
        Left = 27
        Top = 71
        Width = 54
        Height = 12
        Caption = #25968#25454#24211#21517':'
      end
      object pnlSetup: TPanel
        Left = 0
        Top = 0
        Width = 304
        Height = 41
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 5
        object Label2: TLabel
          Left = 3
          Top = 15
          Width = 198
          Height = 12
          Caption = #36755#20837#26381#21153#22120'IP,'#25968#25454#24211#21517','#29992#25143#21644#23494#30721':'
        end
      end
      object edtSaPassword: TEdit
        Left = 125
        Top = 114
        Width = 121
        Height = 20
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 1
      end
      object btnSave: TButton
        Left = 163
        Top = 143
        Width = 60
        Height = 20
        Caption = #20445#23384
        Default = True
        TabOrder = 3
        OnClick = btnSaveClick
      end
      object btnSetupCancel: TButton
        Left = 226
        Top = 143
        Width = 60
        Height = 20
        Cancel = True
        Caption = #21462#28040
        TabOrder = 4
        OnClick = btnSetupCancelClick
      end
      object btnTest: TButton
        Left = 101
        Top = 143
        Width = 60
        Height = 20
        Caption = #27979#35797
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnTestClick
      end
      object edtSaName: TEdit
        Left = 125
        Top = 90
        Width = 121
        Height = 20
        MaxLength = 40
        TabOrder = 0
      end
      object edtServerName: TEdit
        Left = 125
        Top = 44
        Width = 121
        Height = 20
        MaxLength = 40
        TabOrder = 6
      end
      object edtDBName: TEdit
        Left = 125
        Top = 67
        Width = 121
        Height = 20
        MaxLength = 40
        TabOrder = 7
      end
    end
  end
end
