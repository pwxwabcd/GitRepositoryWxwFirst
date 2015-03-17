program mh;

uses
  Forms,
  CommonDM in 'public\CommonDM.pas' {CommonDataModule: TDataModule},
  ListViewCompare in 'public\ListViewCompare.pas',
  PubFun in 'public\PubFun.pas',
  TreeViewImage in 'public\TreeViewImage.pas',
  WaitFrm in 'public\WaitFrm.pas' {WaitForm},
  LoginFrm in 'other\LoginFrm.pas' {LoginForm},
  LogoFrm in 'other\LogoFrm.pas' {LogoForm},
  PubOtherFun in 'public\PubOtherFun.pas',
  MainFrm in 'other\MainFrm.pas' {MainForm},
  RingManageFrm in 'operation\RingManageFrm.pas' {RingManageForm},
  OrderFrm in 'operation\OrderFrm.pas' {OrderForm},
  OrderManageFrm in 'operation\OrderManageFrm.pas' {OrderManageForm},
  RingFrm in 'operation\RingFrm.pas' {RingForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Œ¥∑÷≈‰»±œ›Ã·–—';
  LogoForm := TLogoForm.Create(nil);
  LogoForm.Show;
  LogoForm.Update;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCommonDataModule, CommonDataModule);
  Application.CreateForm(TWaitForm, WaitForm);
  Application.CreateForm(TRingForm, RingForm);
  Application.Run;
end.
