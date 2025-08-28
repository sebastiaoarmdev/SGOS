unit UItemOS;

interface

uses
  System.SysUtils, System.Classes;

type
  TItemOS = class
  private
    FId: Integer;
    FOrdemId: Integer;
    FDescricao: string;
    FQuantidade: Currency;
    FValorUnitario: Currency;
  public
    // Construtor
    constructor Create;

    // Propriedades para acesso aos dados
    property Id: Integer read FId write FId;
    property OrdemId: Integer read FOrdemId write FOrdemId;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Currency read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;

    // Propriedade de leitura para o valor total do item
    function GetValorTotal: Currency;
    property ValorTotal: Currency read GetValorTotal;
  end;

implementation

{ TItemOS }

constructor TItemOS.Create;
begin
  inherited;
  FQuantidade := 0;
  FValorUnitario := 0;
end;

function TItemOS.GetValorTotal: Currency;
begin
  Result := FQuantidade * FValorUnitario;
end;

end.
