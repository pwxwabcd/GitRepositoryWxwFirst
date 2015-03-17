object WaitForm: TWaitForm
  Left = 288
  Top = 251
  BorderStyle = bsNone
  Caption = #31561#24453
  ClientHeight = 55
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnlCenter: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 55
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvSpace
    ParentBackground = False
    TabOrder = 0
    object lblInfo: TLabel
      Left = 66
      Top = 6
      Width = 224
      Height = 14
      Caption = #31243#24207#27491#22312#36827#34892#20013#65292#35831#31245#20505'...       '
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object anmtWait: TAnimate
      Left = 2
      Top = 2
      Width = 55
      Height = 51
      Align = alLeft
      AutoSize = False
      CommonAVI = aviFindFile
      StopFrame = 8
    end
  end
end
