unit UItemOSMapper;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections,
  UItemOS,
  UDMPrincipal;

type
  TItemOSMapper = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    // Métodos de persistência (CRUD)
    function FindAllByOrdemId(AOrdemId: Integer): TObjectList<TItemOS>;
    function FindById(AId: Integer): TItemOS;
    procedure Save(AItemOS: TItemOS);
    procedure Delete(AItemOS: TItemOS);
  end;

implementation

{ TItemOSMapper }

constructor TItemOSMapper.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

destructor TItemOSMapper.Destroy;
begin
  inherited;
end;

function TItemOSMapper.FindAllByOrdemId(AOrdemId: Integer): TObjectList<TItemOS>;
var
  LQuery: TFDQuery;
  LItemOS: TItemOS;
begin
  Result := TObjectList<TItemOS>.Create;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'SELECT * FROM ITEM_ORDEM WHERE ORDEM_ID = :ORDEM_ID';
    LQuery.ParamByName('ORDEM_ID').AsInteger := AOrdemId;
    LQuery.Open;
    while not LQuery.Eof do
    begin
      LItemOS := TItemOS.Create;
      LItemOS.Id := LQuery.FieldByName('ID').AsInteger;
      LItemOS.OrdemId := LQuery.FieldByName('ORDEM_ID').AsInteger;
      LItemOS.Descricao := LQuery.FieldByName('DESCRICAO').AsString;
      LItemOS.Quantidade := LQuery.FieldByName('QUANTIDADE').AsCurrency;
      LItemOS.ValorUnitario := LQuery.FieldByName('VALOR_UNITARIO').AsCurrency;
      Result.Add(LItemOS);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TItemOSMapper.FindById(AId: Integer): TItemOS;
var
  LQuery: TFDQuery;
begin
  Result := nil;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'SELECT * FROM ITEM_ORDEM WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := AId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      Result := TItemOS.Create;
      Result.Id := LQuery.FieldByName('ID').AsInteger;
      Result.OrdemId := LQuery.FieldByName('ORDEM_ID').AsInteger;
      Result.Descricao := LQuery.FieldByName('DESCRICAO').AsString;
      Result.Quantidade := LQuery.FieldByName('QUANTIDADE').AsCurrency;
      Result.ValorUnitario := LQuery.FieldByName('VALOR_UNITARIO').AsCurrency;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TItemOSMapper.Save(AItemOS: TItemOS);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    if AItemOS.Id = 0 then // Novo registro (INSERT)
    begin
      LQuery.SQL.Text := 'INSERT INTO ITEM_ORDEM (ORDEM_ID, DESCRICAO, QUANTIDADE, VALOR_UNITARIO) VALUES (:ORDEM_ID, :DESCRICAO, :QUANTIDADE, :VALOR_UNITARIO)';
    end
    else // Registro existente (UPDATE)
    begin
      LQuery.SQL.Text := 'UPDATE ITEM_ORDEM SET ORDEM_ID = :ORDEM_ID, DESCRICAO = :DESCRICAO, QUANTIDADE = :QUANTIDADE, VALOR_UNITARIO = :VALOR_UNITARIO WHERE ID = :ID';
      LQuery.ParamByName('ID').AsInteger := AItemOS.Id;
    end;

    LQuery.ParamByName('ORDEM_ID').AsInteger := AItemOS.OrdemId;
    LQuery.ParamByName('DESCRICAO').AsString := AItemOS.Descricao;
    LQuery.ParamByName('QUANTIDADE').AsCurrency := AItemOS.Quantidade;
    LQuery.ParamByName('VALOR_UNITARIO').AsCurrency := AItemOS.ValorUnitario;

    LQuery.ExecSQL;

    // Se for um INSERT, recupera o novo ID
    if AItemOS.Id = 0 then
    begin
      LQuery.SQL.Text := 'SELECT GEN_ID(GEN_ITEM_ORDEM_ID, 0) FROM RDB$DATABASE';
      LQuery.Open;
      AItemOS.Id := LQuery.Fields[0].AsInteger;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TItemOSMapper.Delete(AItemOS: TItemOS);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'DELETE FROM ITEM_ORDEM WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := AItemOS.Id;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

end.
