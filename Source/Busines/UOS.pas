unit UOS;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, UItemOS,
  UEntity;

type
  TOS = class(TEntity)
  private
    FClienteId: Integer;
    FDataAbertura: TDate;
    FDataPrevista: TDate;
    FDataFechamento: TDate;
    FStatus: string;
    FDescricaoProblema: string;
    FValorTotal: Currency;
    FItems: TObjectList<TItemOS>;
  public
    constructor Create;
    destructor Destroy; override;

    // Propriedades para acesso aos dados
    property ClienteId: Integer read FClienteId write FClienteId;
    property DataAbertura: TDate read FDataAbertura write FDataAbertura;
    property DataPrevista: TDate read FDataPrevista write FDataPrevista;
    property DataFechamento: TDate read FDataFechamento write FDataFechamento;
    property Status: string read FStatus write FStatus;
    property DescricaoProblema: string read FDescricaoProblema write FDescricaoProblema;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property Items: TObjectList<TItemOS> read FItems write FItems;
  end;

implementation

{ TOS }

constructor TOS.Create;
begin
  inherited;
  FDataAbertura := Date;
  FStatus := 'Aberta';
  FValorTotal := 0;
  FItems := TObjectList<TItemOS>.Create;
end;

destructor TOS.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

end.
