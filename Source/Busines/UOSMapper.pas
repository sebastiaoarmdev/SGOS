unit UOSMapper;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections, FireDAC.Stan.Param, UMapper, UDMMain, UOS,
  UItemOS, UItemOSMapper;

type
  TOSMapper = class(TMapper<TOS>)
  public
    function FindAll: TObjectList<TOS>; override;
    function FindById(AId: Integer): TOS; override;
    procedure Save(AOS: TOS); override;
    procedure Delete(AOS: TOS); override;
  end;

implementation

{ TOSMapper }

procedure TOSMapper.Save(AOS: TOS);
var
  LQuery: TFDQuery;
  LItem: TItemOS;
begin
  FTransaction.StartTransaction;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    try
      // 1. Salva o cabeçalho da Ordem de Serviço
      if AOS.Id = 0 then // Novo registro (INSERT)
      begin
        LQuery.SQL.Text := 'INSERT INTO ORDEM_SERVICO (CLIENTE_ID, DATA_ABERTURA, DATA_PREVISTA, DATA_FECHAMENTO, STATUS, DESCRICAO_PROBLEMA, VALOR_TOTAL) VALUES (:CLIENTE_ID, :DATA_ABERTURA, :DATA_PREVISTA, :DATA_FECHAMENTO, :STATUS, :DESCRICAO_PROBLEMA, :VALOR_TOTAL)';
      end
      else // Registro existente (UPDATE)
      begin
        LQuery.SQL.Text := 'UPDATE ORDEM_SERVICO SET CLIENTE_ID = :CLIENTE_ID, DATA_ABERTURA = :DATA_ABERTURA, DATA_PREVISTA = :DATA_PREVISTA, DATA_FECHAMENTO = :DATA_FECHAMENTO, STATUS = :STATUS, DESCRICAO_PROBLEMA = :DESCRICAO_PROBLEMA, VALOR_TOTAL = :VALOR_TOTAL WHERE ID = :ID';
        LQuery.ParamByName('ID').AsInteger := AOS.Id;
      end;

      LQuery.ParamByName('CLIENTE_ID').AsInteger := AOS.ClienteId;
      LQuery.ParamByName('DATA_ABERTURA').AsDateTime := AOS.DataAbertura;
      LQuery.ParamByName('DATA_PREVISTA').AsDateTime := AOS.DataPrevista;
      LQuery.ParamByName('DATA_FECHAMENTO').AsDateTime := AOS.DataFechamento;
      LQuery.ParamByName('STATUS').AsString := AOS.Status;
      LQuery.ParamByName('DESCRICAO_PROBLEMA').AsString := AOS.DescricaoProblema;
      LQuery.ParamByName('VALOR_TOTAL').AsCurrency := AOS.ValorTotal;

      LQuery.ExecSQL;

      // 2. Apaga todos os itens antigos para garantir consistência
      LQuery.SQL.Text := 'DELETE FROM ITEM_ORDEM WHERE ORDEM_ID = :ORDEM_ID';
      LQuery.ParamByName('ORDEM_ID').AsInteger := AOS.Id;
      LQuery.ExecSQL;

      // 3. Salva os novos itens da lista
      LQuery.SQL.Text := 'INSERT INTO ITEM_ORDEM (ORDEM_ID, DESCRICAO, QUANTIDADE, VALOR_UNITARIO) VALUES (:ORDEM_ID, :DESCRICAO, :QUANTIDADE, :VALOR_UNITARIO)';
      for LItem in AOS.Items do
      begin
        LQuery.ParamByName('ORDEM_ID').AsInteger := AOS.Id;
        LQuery.ParamByName('DESCRICAO').AsString := LItem.Descricao;
        LQuery.ParamByName('QUANTIDADE').AsCurrency := LItem.Quantidade;
        LQuery.ParamByName('VALOR_UNITARIO').AsCurrency := LItem.ValorUnitario;
        LQuery.ExecSQL;
      end;

      FTransaction.Commit;
    except
      on E: Exception do
      begin
        FTransaction.Rollback;
        raise Exception.CreateFmt('Erro ao salvar a Ordem de Serviço: %s', [E.Message]);
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

function TOSMapper.FindAll: TObjectList<TOS>;
var
  LQuery: TFDQuery;
  LItemQuery: TFDQuery;
  LOS: TOS;
  LItemOS: TItemOS;
begin
  Result := TObjectList<TOS>.Create;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  LItemQuery := TFDQuery.Create(nil);
  LItemQuery.Connection := FConnection;
  try
    LQuery.SQL.Text := 'SELECT * FROM ORDEM_SERVICO';
    LQuery.Open;
    while not LQuery.Eof do
    begin
      LOS := TOS.Create;
      LOS.Id := LQuery.FieldByName('ID').AsInteger;
      LOS.ClienteId := LQuery.FieldByName('CLIENTE_ID').AsInteger;
      LOS.DataAbertura := LQuery.FieldByName('DATA_ABERTURA').AsDateTime;
      LOS.DataPrevista := LQuery.FieldByName('DATA_PREVISTA').AsDateTime;
      LOS.DataFechamento := LQuery.FieldByName('DATA_FECHAMENTO').AsDateTime;
      LOS.Status := LQuery.FieldByName('STATUS').AsString;
      LOS.DescricaoProblema := LQuery.FieldByName('DESCRICAO_PROBLEMA').AsString;
      LOS.ValorTotal := LQuery.FieldByName('VALOR_TOTAL').AsCurrency;

      // Carrega os itens da OS
      LItemQuery.SQL.Text := 'SELECT * FROM ITEM_ORDEM WHERE ORDEM_ID = :ORDEM_ID';
      LItemQuery.ParamByName('ORDEM_ID').AsInteger := LOS.Id;
      LItemQuery.Open;
      while not LItemQuery.Eof do
      begin
        LItemOS := TItemOS.Create;
        LItemOS.Id := LItemQuery.FieldByName('ID').AsInteger;
        LItemOS.OrdemId := LItemQuery.FieldByName('ORDEM_ID').AsInteger;
        LItemOS.Descricao := LItemQuery.FieldByName('DESCRICAO').AsString;
        LItemOS.Quantidade := LItemQuery.FieldByName('QUANTIDADE').AsCurrency;
        LItemOS.ValorUnitario := LItemQuery.FieldByName('VALOR_UNITARIO').AsCurrency;
        LOS.Items.Add(LItemOS);
        LItemQuery.Next;
      end;
      LItemQuery.Close;

      Result.Add(LOS);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
    LItemQuery.Free;
  end;
end;

function TOSMapper.FindById(AId: Integer): TOS;
var
  LQuery: TFDQuery;
  LItemQuery: TFDQuery;
  LItemOS: TItemOS;
begin
  Result := nil;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  LItemQuery := TFDQuery.Create(nil);
  LItemQuery.Connection := FConnection;
  try
    // Busca a OS
    LQuery.SQL.Text := 'SELECT * FROM ORDEM_SERVICO WHERE ID = :ID';
    LQuery.ParamByName('ID').AsInteger := AId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      Result := TOS.Create;
      Result.Id := LQuery.FieldByName('ID').AsInteger;
      Result.ClienteId := LQuery.FieldByName('CLIENTE_ID').AsInteger;
      Result.DataAbertura := LQuery.FieldByName('DATA_ABERTURA').AsDateTime;
      Result.DataPrevista := LQuery.FieldByName('DATA_PREVISTA').AsDateTime;
      Result.DataFechamento := LQuery.FieldByName('DATA_FECHAMENTO').AsDateTime;
      Result.Status := LQuery.FieldByName('STATUS').AsString;
      Result.DescricaoProblema := LQuery.FieldByName('DESCRICAO_PROBLEMA').AsString;
      Result.ValorTotal := LQuery.FieldByName('VALOR_TOTAL').AsCurrency;

      // Busca os itens da OS
      LItemQuery.SQL.Text := 'SELECT * FROM ITEM_ORDEM WHERE ORDEM_ID = :ORDEM_ID';
      LItemQuery.ParamByName('ORDEM_ID').AsInteger := Result.Id;
      LItemQuery.Open;
      while not LItemQuery.Eof do
      begin
        LItemOS := TItemOS.Create;
        LItemOS.Id := LItemQuery.FieldByName('ID').AsInteger;
        LItemOS.OrdemId := LItemQuery.FieldByName('ORDEM_ID').AsInteger;
        LItemOS.Descricao := LItemQuery.FieldByName('DESCRICAO').AsString;
        LItemOS.Quantidade := LItemQuery.FieldByName('QUANTIDADE').AsCurrency;
        LItemOS.ValorUnitario := LItemQuery.FieldByName('VALOR_UNITARIO').AsCurrency;
        Result.Items.Add(LItemOS);
        LItemQuery.Next;
      end;
      LItemQuery.Close;
    end;
  finally
    LQuery.Free;
    LItemQuery.Free;
  end;
end;

procedure TOSMapper.Delete(AOS: TOS);
var
  LQuery: TFDQuery;
begin
  FTransaction.StartTransaction;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    try
      // Apaga os itens primeiro para evitar erro de chave estrangeira
      LQuery.SQL.Text := 'DELETE FROM ITEM_ORDEM WHERE ORDEM_ID = :ID';
      LQuery.ParamByName('ID').AsInteger := AOS.Id;
      LQuery.ExecSQL;

      // Apaga o cabeçalho
      LQuery.SQL.Text := 'DELETE FROM ORDEM_SERVICO WHERE ID = :ID';
      LQuery.ParamByName('ID').AsInteger := AOS.Id;
      LQuery.ExecSQL;

      FTransaction.Commit;
    except
      on E: Exception do
      begin
        FTransaction.Rollback;
        raise Exception.CreateFmt('Erro ao excluir a Ordem de Serviço: %s', [E.Message]);
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

end.
