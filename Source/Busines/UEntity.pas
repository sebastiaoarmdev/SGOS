unit UEntity;

interface

uses
  System.SysUtils, System.Classes;

type
  TEntity = class(TObject)
  private
    FId: Integer;
  public
    constructor Create;

    property Id: Integer read FId write FId;
  end;

implementation

{ TEntity }

constructor TEntity.Create;
begin
  inherited;
  FId := 0; // Inicializa o ID para 0. Um ID igual a zero indica um novo registro.
end;

end.
