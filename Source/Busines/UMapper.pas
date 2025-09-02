unit UMapper;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  System.Generics.Collections, UEntity;

type
  TMapper<TEntity: class> = class(TObject)
  protected
    FConnection: TFDConnection;
    FTransaction: TFDTransaction;
  public
    constructor Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
    // Métodos abstratos que DEVEM ser implementados nas classes filhas:
    function FindAll: TObjectList<TEntity>; virtual; abstract;
    function FindById(AId: Integer): TEntity; virtual; abstract;
    procedure Save(AEntity: TEntity); virtual; abstract;
    procedure Delete(AEntity: TEntity); virtual; abstract;
  end;

implementation

{ TMapper }

constructor TMapper<TEntity>.Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
begin
  inherited Create;
  FConnection := AConnection;
  FTransaction := ATransaction;
end;

end.
