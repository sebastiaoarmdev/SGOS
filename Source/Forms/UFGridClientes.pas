unit UFGridClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFGrid,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UClienteMapper,
  FireDAC.Comp.Client, System.Generics.Collections;

type
  TFormGridClientes = class(TFormGrid)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMapper: TClienteMapper;
  protected
    function DataAdd: Boolean; override;
    function DataEdit: Boolean; override;
    procedure DataLoad; override;
    procedure DataDelete; override;
  public
    { Public declarations }
  end;

var
  FormGridClientes: TFormGridClientes;

implementation

uses
  UDMMain,
  UCliente,
  UFEditCliente;

{$R *.dfm}

function TFormGridClientes.DataAdd: Boolean;
var
  LForm: TFormEditCliente;
begin
  Result := False;

  // Cria e exibe o formulário de cadastro em modo modal
  LForm := TFormEditCliente.Create(Self);
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

procedure TFormGridClientes.DataDelete;
var
  LCliente: TCliente;
begin
  // Utiliza o método herdado que já faz a pergunta de confirmação
  inherited;

  // Pega o ID do registro selecionado para exclusão
  LCliente := TCliente.Create;
  try
    LCliente.Id := DataSetInMemory.FieldByName('ID').AsInteger;

    FMapper.Delete(LCliente);

    DataLoad;
  finally
    LCliente.Free;
  end;
end;

function TFormGridClientes.DataEdit: Boolean;
var
  LForm: TFormEditCliente;
begin
  Result := False;

  // Verifica se há um registro selecionado
  if not DataSetInMemory.IsEmpty then
  begin
    // Passa o ID do cliente selecionado para o formulário de cadastro
    LForm := TFormEditCliente.CreateWithId(DataSetInMemory.FieldByName('ID').AsInteger);
    try
      if( LForm.ShowModal = mrOK) then
      begin
        Result := True;

        // Recarrega a grade após a edição
        DataLoad;
      end;
    finally
      LForm.Free;
    end;
  end;
end;

procedure TFormGridClientes.DataLoad;
var
  LClientes: TObjectList<TCliente>;

  LCliente: TCliente;

  LErrorMessage: string;
begin
  StatusBar.SimpleText := 'Carregando dados...';

  DataSetInMemory.DisableControls;
  DataSetInMemory.EmptyDataSet;

  try
    try
      LClientes := FMapper.FindAll;

      for LCliente in LClientes do
      begin
        DataSetInMemory.Append;
        DataSetInMemory.FieldByName('ID').AsInteger := LCliente.Id;
        DataSetInMemory.FieldByName('NOME').AsString := LCliente.Nome;
        DataSetInMemory.FieldByName('DOCUMENTO').AsString := LCliente.Documento;
        DataSetInMemory.FieldByName('EMAIL').AsString := LCliente.Email;
        DataSetInMemory.FieldByName('TELEFONE').AsString := LCliente.Telefone;
        DataSetInMemory.FieldByName('DATA_CADASTRO').AsDateTime := LCliente.DataCadastro;
        DataSetInMemory.Post;
      end;

      DataSetInMemory.First;

      ButtonEdit.Enabled := (not DataSetInMemory.IsEmpty);

      ButtonDelete.Enabled := (not DataSetInMemory.IsEmpty);

      StatusBar.SimpleText := 'Dados carregados.';
    except
      on E: Exception do
      begin
        LErrorMessage := Format('Erro ao atualizar dados: %s', [E.Message]);

        StatusBar.SimpleText := LErrorMessage;

        raise Exception.Create(LErrorMessage);
      end;
    end;
  finally
    DataSetInMemory.EnableControls;

    LClientes.Free;
  end;
end;

procedure TFormGridClientes.FormCreate(Sender: TObject);
begin
  inherited;

  FMapper := TClienteMapper.Create(DMMain.FDConnection, DMMain.FDTransaction);

  DataSetInMemory.FieldDefs.Add('ID', ftInteger, 0, False);
  DataSetInMemory.FieldDefs.Add('NOME', ftString, 120, False);
  DataSetInMemory.FieldDefs.Add('DOCUMENTO', ftString, 20, False);
  DataSetInMemory.FieldDefs.Add('EMAIL', ftString, 120, False);
  DataSetInMemory.FieldDefs.Add('TELEFONE', ftString, 30, False);
  DataSetInMemory.FieldDefs.Add('DATA_CADASTRO', ftDateTime, 0, False);
  DataSetInMemory.CreateDataSet;

  DataSet := DataSetInMemory;

  DBGrid.Columns[0].Title.Caption := 'Id';
  DBGrid.Columns[1].Title.Caption := 'Nome';
  DBGrid.Columns[2].Title.Caption := 'Documento';
  DBGrid.Columns[3].Title.Caption := 'E-Mail';
  DBGrid.Columns[4].Title.Caption := 'Telefone';
  DBGrid.Columns[5].Title.Caption := 'Data de Cadastro';

  DataSetInMemory.FieldByName('TELEFONE').EditMask := '+00 (00) 0 0000-0000;0; ';

  DataLoad;
end;

procedure TFormGridClientes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMapper);
  inherited;
end;

end.
