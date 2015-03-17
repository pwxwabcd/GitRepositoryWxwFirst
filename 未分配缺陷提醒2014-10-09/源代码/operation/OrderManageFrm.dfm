object OrderManageForm: TOrderManageForm
  Left = 234
  Top = 124
  Width = 468
  Height = 412
  Caption = #35746#21046#31649#29702
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object CoolBar: TCoolBar
    Left = 0
    Top = 0
    Width = 460
    Height = 41
    AutoSize = True
    Bands = <
      item
        Control = ToolBar
        ImageIndex = -1
        MinHeight = 37
        Width = 456
      end>
    Color = clBtnFace
    ParentColor = False
    object ToolBar: TToolBar
      Left = 9
      Top = 0
      Width = 443
      Height = 37
      AutoSize = True
      ButtonHeight = 35
      ButtonWidth = 55
      Caption = 'ToolBar'
      Flat = True
      Images = CommonDataModule.ImageList
      ShowCaptions = True
      TabOrder = 0
      object tbtnZy: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #23450#21046#31649#29702
        ImageIndex = 13
      end
      object tbtnQuery: TToolButton
        Left = 59
        Top = 0
        AutoSize = True
        Caption = #26597#35810
        ImageIndex = 7
        OnClick = tbtnQueryClick
      end
      object tbtnExport: TToolButton
        Left = 94
        Top = 0
        AutoSize = True
        Caption = #23548#20986' '
        ImageIndex = 36
        OnClick = tbtnExportClick
      end
      object tbtnEdit: TToolButton
        Left = 135
        Top = 0
        AutoSize = True
        Caption = #20462#25913
        ImageIndex = 11
        OnClick = tbtnEditClick
      end
      object tbtnDel: TToolButton
        Left = 170
        Top = 0
        AutoSize = True
        Caption = #21024#38500
        ImageIndex = 5
        OnClick = tbtnDelClick
      end
      object tbtnSepFirst: TToolButton
        Left = 205
        Top = 0
        Width = 45
        Caption = 'tbtnSepFirst'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbtnClose: TToolButton
        Left = 250
        Top = 0
        AutoSize = True
        Caption = #20851#38381
        ImageIndex = 9
        OnClick = tbtnCloseClick
      end
    end
  end
  object lvOrder: TListView
    Left = 0
    Top = 211
    Width = 460
    Height = 167
    Align = alClient
    Columns = <
      item
        Caption = #25163#26426#21495
        Width = 80
      end
      item
        Caption = #24425#38083#21517#31216
        Width = 100
      end
      item
        Caption = #25163#26426#22411#21495
        Width = 100
      end
      item
        Caption = #25509#25910#26102#38388
        Width = 120
      end
      item
        Caption = #26159#21542#38405#35835
        Width = 60
      end
      item
        Caption = #26159#21542#22788#29702
        Width = 60
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = tbtnEditClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 460
    Height = 170
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 25
      Top = 8
      Width = 42
      Height = 12
      Caption = #25163#26426#21495':'
    end
    object Label2: TLabel
      Left = 19
      Top = 32
      Width = 54
      Height = 12
      Caption = #25163#26426#22411#21495':'
    end
    object Label3: TLabel
      Left = 93
      Top = 58
      Width = 54
      Height = 12
      Caption = #24320#22987#26085#26399':'
    end
    object Label4: TLabel
      Left = 93
      Top = 83
      Width = 54
      Height = 12
      Caption = #32467#26463#26085#26399':'
    end
    object edtMobileNumber: TEdit
      Left = 95
      Top = 4
      Width = 150
      Height = 20
      TabOrder = 0
    end
    object cbMyInt: TCheckBox
      Left = 10
      Top = 107
      Width = 73
      Height = 17
      Caption = #26159#21542#38405#35835
      TabOrder = 1
    end
    object cbMyLittle: TCheckBox
      Left = 10
      Top = 137
      Width = 73
      Height = 17
      Caption = #26159#21542#22788#29702
      TabOrder = 2
    end
    object rgMyInt: TRadioGroup
      Left = 95
      Top = 100
      Width = 150
      Height = 30
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #26410#38405#35835
        #24050#38405#35835)
      TabOrder = 3
    end
    object rgMyLittle: TRadioGroup
      Left = 96
      Top = 132
      Width = 150
      Height = 30
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #26410#22788#29702
        #24050#22788#29702)
      TabOrder = 4
    end
    object edtPinPai: TEdit
      Left = 95
      Top = 28
      Width = 150
      Height = 20
      TabOrder = 5
    end
    object cbWriteTime: TCheckBox
      Left = 10
      Top = 56
      Width = 73
      Height = 17
      Caption = #25509#25910#26102#38388
      TabOrder = 6
    end
    object dtpBeginWriteTime: TDateTimePicker
      Left = 145
      Top = 54
      Width = 100
      Height = 20
      Date = 38562.376196284720000000
      Time = 38562.376196284720000000
      TabOrder = 7
    end
    object dtpEndWriteTime: TDateTimePicker
      Left = 145
      Top = 79
      Width = 100
      Height = 20
      Date = 38562.376260486110000000
      Time = 38562.376260486110000000
      TabOrder = 8
    end
  end
end
