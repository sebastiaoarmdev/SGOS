unit UClienteMapper;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections,
  UCliente,
  UDMPrincipal;

type
  TClienteMapper = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    // Métodos de persistência
    function FindAll: TObjectList<TCliente>;
    function FindById(AId: Integer): TCliente;
    procedure Save(ACliente: TCliente);
    procedure Delete(ACliente: TCliente);
  end;

implementation

{ TClienteMapper }

constructor TClienteMapper.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

destructor TClienteMapper.Destroy;
begin
  // O Destructor não deve liberar a conexão, pois ela é gerenciada pelo DataModule
  inherited;
end;

function TClienteMapper.FindAll: TObjectList<TCliente>;
var
  LQuery: TFDQuery;
  LCliente: TCliente;
begin
  Result := TObjectList<TCliente>.Create;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'SELECT * FROM CLIENTE';
    LQuery.Open;
    while not LQuery.Eof do
    begin
      LCliente := TCliente.Create;
      LCliente.Id := LQuery.FieldByName('ID').AsInteger;
      LCliente.Nome := LQuery.FieldByName('NOME').AsString;
      LCliente.Documento := LQuery.FieldByName('DOCUMENTO').AsString;
      LCliente.Email := LQuery.FieldByName('EMAIL').AsString;
      LCliente.Telefone := LQuery.FieldByName('TELEFONE').AsString;
      LCliente.DataCadastro := LQuery.FieldByName('DATA_CADASTRO').AsDateTime;
      Result.Add(LCliente);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TClienteMapper.FindById(AId: Integer): TCliente;
var
  LQuery: TFDQuery;
begin
  Result := nil;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'SELECT * FROM CLIENTE WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := AId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Id := LQuery.FieldByName('ID').AsInteger;
      Result.Nome := LQuery.FieldByName('NOME').AsString;
      Result.Documento := LQuery.FieldByName('DOCUMENTO').AsString;
      Result.Email := LQuery.FieldByName('EMAIL').AsString;
      Result.Telefone := LQuery.FieldByName('TELEFONE').AsString;
      Result.DataCadastro := LQuery.FieldByName('DATA_CADASTRO').AsDateTime;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TClienteMapper.Save(ACliente: TCliente);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    if ACliente.Id = 0 then // Novo registro (INSERT)
    begin
      LQuery.SQL.Text := 'INSERT INTO CLIENTE (NOME, DOCUMENTO, EMAIL, TELEFONE) VALUES (:NOME, :DOCUMENTO, :EMAIL, :TELEFONE)';
    end
    else // Registro existente (UPDATE)
    begin
      LQuery.SQL.Text := 'UPDATE CLIENTE SET NOME = :NOME, DOCUMENTO = :DOCUMENTO, EMAIL = :EMAIL, TELEFONE = :TELEFONE WHERE ID = :ID';
      LQuery.ParamByName('ID').AsInteger := ACliente.Id;
    end;

    LQuery.ParamByName('NOME').AsString := ACliente.Nome;
    LQuery.ParamByName('DOCUMENTO').AsString := ACliente.Documento;
    LQuery.ParamByName('EMAIL').AsString := ACliente.Email;
    LQuery.ParamByName('TELEFONE').AsString := ACliente.Telefone;

    LQuery.ExecSQL;

    // Se for um INSERT, recupera o novo ID
    if ACliente.Id = 0 then
    begin
      LQuery.SQL.Text := 'SELECT GEN_ID(GEN_CLIENTE_ID, 0) FROM RDB$DATABASE';
      LQuery.Open;
      ACliente.Id := LQuery.Fields[0].AsInteger;
    end;

  finally
    LQuery.Free;
  end;
end;

procedure TClienteMapper.Delete(ACliente: TCliente);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'DELETE FROM CLIENTE WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := ACliente.Id;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

end.
