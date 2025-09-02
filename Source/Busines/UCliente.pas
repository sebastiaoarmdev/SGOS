unit UCliente;

interface

uses
  System.SysUtils, UEntity;

type
  TCliente = class(TEntity)
  private
    FNome: string;
    FDocumento: string;
    FEmail: string;
    FTelefone: string;
    FDataCadastro: TDateTime;
  public
    constructor Create;
    property Nome: string read FNome write FNome;
    property Documento: string read FDocumento write FDocumento;
    property Email: string read FEmail write FEmail;
    property Telefone: string read FTelefone write FTelefone;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited;
  FDataCadastro := Now;
end;

end.
