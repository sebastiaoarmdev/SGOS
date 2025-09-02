unit UClienteMapper;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections, FireDAC.Stan.Param, UMapper, UDMMain, UCliente;

type
  TClienteMapper = class(TMapper<TCliente>)
  public
    function FindAll: TObjectList<TCliente>; override;
    function FindById(AId: Integer): TCliente; override;
    procedure Save(AEntity: TCliente); override;
    procedure Delete(AEntity: TCliente); override;
  end;

implementation

{ TClienteMapper }

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

    FConnection.Close;
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

    FConnection.Close;
  end;
end;

procedure TClienteMapper.Save(AEntity: TCliente);
var
  LQuery: TFDQuery;

  LCliente: TCliente;
begin
  LQuery := TFDQuery.Create(nil);

  LQuery.Connection := FConnection;

  LCliente := AEntity;
  try
    if LCliente.Id = 0 then // Novo registro (INSERT)
    begin
      LQuery.SQL.Text := 'INSERT INTO CLIENTE (NOME, DOCUMENTO, EMAIL, TELEFONE) VALUES (:NOME, :DOCUMENTO, :EMAIL, :TELEFONE)';
    end
    else // Registro existente (UPDATE)
    begin
      LQuery.SQL.Text := 'UPDATE CLIENTE SET NOME = :NOME, DOCUMENTO = :DOCUMENTO, EMAIL = :EMAIL, TELEFONE = :TELEFONE WHERE ID = :ID';
      LQuery.ParamByName('ID').AsInteger := LCliente.Id;
    end;

    LQuery.ParamByName('NOME').AsString := LCliente.Nome;
    LQuery.ParamByName('DOCUMENTO').AsString := LCliente.Documento;
    LQuery.ParamByName('EMAIL').AsString := LCliente.Email;
    LQuery.ParamByName('TELEFONE').AsString := LCliente.Telefone;

    LQuery.ExecSQL;
  finally
    LQuery.Free;

    FConnection.Close;
  end;
end;

procedure TClienteMapper.Delete(AEntity: TCliente);
var
  LQuery: TFDQuery;

  LCliente: TCliente;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;

  LCliente := AEntity;
  try
    LQuery.SQL.Text := 'DELETE FROM CLIENTE WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := LCliente.Id;
    LQuery.ExecSQL;
  finally
    LQuery.Free;

    FConnection.Close;
  end;
end;

end.
