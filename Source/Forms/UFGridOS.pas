unit UFGridOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFGrid,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UOSMapper,
  FireDAC.Comp.Client, System.Generics.Collections;

type
  TFormGridOS = class(TFormGrid)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMapper: TOSMapper;
  protected
    function DataAdd: Boolean; override;
    function DataEdit: Boolean; override;
    procedure DataLoad; override;
    procedure DataDelete; override;
  end;

var
  FormGridOS: TFormGridOS;

implementation

uses
  UDMMain,
  UOS,
  UFEditOS;

{$R *.dfm}

{ TFormGridOS }

function TFormGridOS.DataAdd: Boolean;
var
  LForm: TFormEditOS;
begin
  Result := False;

  // Cria e exibe o formulário de cadastro em modo modal
  LForm := TFormEditOS.Create(Self);
  try
    if (LForm.ShowModal = mrOk) then
    begin
      Result := True;

      // Recarrega a grade após o salvamento
      DataLoad;
    end;
  finally
    LForm.Free;
  end;
end;

procedure TFormGridOS.DataDelete;
begin
  inherited;

end;

function TFormGridOS.DataEdit: Boolean;
begin

end;

procedure TFormGridOS.DataLoad;
begin
  inherited;

end;

procedure TFormGridOS.FormCreate(Sender: TObject);
begin
  inherited;

  FMapper := TOSMapper.Create(DMMain.FDConnection, DMMain.FDTransaction);

  DataSetInMemory.FieldDefs.Add('ID', ftInteger, 0, False);
  DataSetInMemory.FieldDefs.Add('CLIENTE_ID', ftInteger, 0, False);
  DataSetInMemory.FieldDefs.Add('DATA_ABERTURA', ftDate, 0, False);
  DataSetInMemory.FieldDefs.Add('DATA_PREVISTA', ftDate, 0, False);
  DataSetInMemory.FieldDefs.Add('DATA_FECHAMENTO', ftDate, 0, False);
  DataSetInMemory.FieldDefs.Add('STATUS', ftString, 15, False);
  DataSetInMemory.FieldDefs.Add('DESCRICAO_PROBLEMA', ftString, 120, False);
  DataSetInMemory.FieldDefs.Add('VALOR_TOTAL', ftCurrency, 0, False);

  DataSetInMemory.CreateDataSet;

  DataSet := DataSetInMemory;

  DBGrid.Columns[0].Title.Caption := 'Id';
  DBGrid.Columns[1].Title.Caption := 'Id do Cliente';
  DBGrid.Columns[2].Title.Caption := 'Data de Abertura';
  DBGrid.Columns[3].Title.Caption := 'Data Prevista';
  DBGrid.Columns[4].Title.Caption := 'Data de Fechamento';
  DBGrid.Columns[5].Title.Caption := 'Status';
  DBGrid.Columns[6].Title.Caption := 'Problema';
  DBGrid.Columns[7].Title.Caption := 'Valor Total';

  DataLoad;
end;

procedure TFormGridOS.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMapper);
  inherited;
end;

end.
