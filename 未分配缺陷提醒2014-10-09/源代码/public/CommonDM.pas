unit CommonDM;

interface

uses
  SysUtils, Classes, ADODB, DB, ImgList, Controls, Windows, Forms, 
  DBAccess, Ora, MemDS;

type
  TCommonDataModule = class(TDataModule)
    cntMain: TADOConnection;
    ImageList: TImageList;
    qryMain: TADOQuery;
    qryTemp: TADOQuery;
    stpMain: TADOStoredProc;
    DataSource: TDataSource;
    qryOrder: TADOQuery;
    cntCw: TOraSession;
    qryCw: TOraQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommonDataModule: TCommonDataModule;

implementation

{$R *.dfm}

{ TCommonDataModule }



end.
