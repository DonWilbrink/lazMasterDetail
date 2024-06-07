unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  SQLite3Conn, SQLDB, DB;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    bedrGrid: TDBGrid;
    bedrNav: TDBNavigator;
    DBGrid1: TDBGrid;
    dsPers: TDataSource;
    persNav: TDBNavigator;
    dsBedrijf: TDataSource;
    qrBedrijf: TSQLQuery;
    qrPers: TSQLQuery;
    wnConn: TSQLite3Connection;
    wnTX: TSQLTransaction;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure qrBedrijfAfterPost(DataSet: TDataSet);
    procedure qrPersAfterInsert(DataSet: TDataSet);
    procedure qrPersAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.qrBedrijfAfterPost(DataSet: TDataSet);
begin
  qrBedrijf.ApplyUpdates();
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  wnTX.Commit;
  qrPers.Active := False;
  qrBedrijf.Active := False;
  wnConn.Connected := False;
  CloseAction := caFree;
end;

procedure TfrmMain.qrPersAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('bedrijfID').AsInteger := qrBedrijf.FieldByName('bedrijfID').AsInteger;
end;

procedure TfrmMain.qrPersAfterPost(DataSet: TDataSet);
begin
  qrPers.ApplyUpdates();
end;

end.

