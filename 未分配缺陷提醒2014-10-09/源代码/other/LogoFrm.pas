unit LogoFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls;

type
  TLogoForm = class(TForm)
    imgLogo: TImage;
    lblAppVersion: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogoForm: TLogoForm;

implementation
{$R *.dfm}
uses
  PubFun;

procedure TLogoForm.FormShow(Sender: TObject);
begin
  lblAppVersion.Caption := '程序版本: '+APP_VERSION;
end;

//分辨率调节
procedure TLogoForm.FormCreate(Sender: TObject);
begin
  //FormScale(self);
end;

end.
