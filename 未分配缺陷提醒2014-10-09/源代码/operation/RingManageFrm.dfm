object RingManageForm: TRingManageForm
  Left = 234
  Top = 124
  Width = 468
  Height = 412
  Caption = #38083#22768#31649#29702
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
        Caption = #38083#22768#31649#29702
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
        Caption = #21457#36865
        ImageIndex = 16
        OnClick = tbtnEditClick
      end
      object tbtnSepFirst: TToolButton
        Left = 170
        Top = 0
        Width = 45
        Caption = 'tbtnSepFirst'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbtnClose: TToolButton
        Left = 215
        Top = 0
        AutoSize = True
        Caption = #20851#38381
        ImageIndex = 9
        OnClick = tbtnCloseClick
      end
    end
  end
  object lvRing: TListView
    Left = 0
    Top = 153
    Width = 460
    Height = 225
    Align = alClient
    Columns = <
      item
        Caption = #27468#21517
        Width = 150
      end
      item
        Caption = #27468#25163
        Width = 100
      end
      item
        Caption = #26684#24335
        Width = 60
      end
      item
        Caption = #31867#22411
        Width = 60
      end
      item
        Caption = #21644#24358
        Width = 40
      end
      item
        Caption = #38083#22768#20998#31867
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
    Height = 112
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 25
      Top = 8
      Width = 30
      Height = 12
      Caption = #27468#21517':'
    end
    object Label2: TLabel
      Left = 25
      Top = 32
      Width = 30
      Height = 12
      Caption = #27468#25163':'
    end
    object Label3: TLabel
      Left = 25
      Top = 56
      Width = 30
      Height = 12
      Caption = #26684#24335':'
    end
    object edtRingName: TEdit
      Left = 78
      Top = 4
      Width = 150
      Height = 20
      TabOrder = 0
    end
    object cbPlus: TCheckBox
      Left = 28
      Top = 83
      Width = 45
      Height = 17
      Caption = #31867#22411
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object edtRingPathWWW: TEdit
      Left = 78
      Top = 28
      Width = 150
      Height = 20
      TabOrder = 2
    end
    object rgPlus: TRadioGroup
      Left = 78
      Top = 76
      Width = 150
      Height = 30
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #26222#36890#38083#38899
        #29305#25928#38083#38899)
      TabOrder = 3
    end
    object edtRingMobileType: TEdit
      Left = 78
      Top = 52
      Width = 150
      Height = 20
      TabOrder = 4
    end
  end
end
