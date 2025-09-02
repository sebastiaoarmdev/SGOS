unit UFEditItemOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFEdit,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, UItemOS, UItemOSMapper;

type
  TFormEditItemOS = class(TFormEdit)
    LabeledEditId: TLabeledEdit;
    LabeledEditIdOS: TLabeledEdit;
    LabeledEditDescrição: TLabeledEdit;
    LabeledEditQuantidade: TLabeledEdit;
    LabeledEditValorUnitário: TLabeledEdit;
    LabeledEditValorTotal: TLabeledEdit;
    procedure LabeledEditQuantidadeChange(Sender: TObject);
    procedure LabeledEditValorUnitárioChange(Sender: TObject);
  private
    { Private declarations }
    FItemOS: TItemOS;
    FMapper: TItemOSMapper;
  protected
    function SaveDataFromForm: Boolean; override;
    procedure LoadDataToForm; override;
    procedure SetValorTotal;
  public
    class function CreateWithId(AId: Integer): TFormEditItemOS;
    class function CreateWithIdOS(AIdOS: Integer): TFormEditItemOS;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormEditItemOS: TFormEditItemOS;

implementation

uses
  UDMMain;

{$R *.dfm}

{ TFormEditItemOS }

constructor TFormEditItemOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMapper := TItemOSMapper.Create(DMMain.FDConnection, DMMain.FDTransaction);

  FItemOS := TItemOS.Create;
end;

class function TFormEditItemOS.CreateWithId(AId: Integer): TFormEditItemOS;
var
  LForm: TFormEditItemOS;
begin
  LForm := TFormEditItemOS.Create(Application);

  LForm.FItemOS := LForm.FMapper.FindById(AId);

  LForm.LoadDataToForm;

  Result := LForm;
end;

class function TFormEditItemOS.CreateWithIdOS(AIdOS: Integer): TFormEditItemOS;
var
  LForm: TFormEditItemOS;
begin
  LForm := TFormEditItemOS.Create(Application);

  LForm.FItemOS.OrdemId := AIdOS;

  LForm.LabeledEditIdOS.Text := IntToStr(AIdOS);

  Result := LForm;
end;

destructor TFormEditItemOS.Destroy;
begin
  FreeAndNil(FMapper);

  if Assigned(FItemOS) then FreeAndNil(FItemOS);

  inherited;
end;

procedure TFormEditItemOS.LabeledEditQuantidadeChange(Sender: TObject);
begin
  SetValorTotal;
end;

procedure TFormEditItemOS.LabeledEditValorUnitárioChange(Sender: TObject);
begin
  SetValorTotal;
end;

procedure TFormEditItemOS.LoadDataToForm;
begin
  inherited;
  LabeledEditId.Text := FItemOS.Id.ToString;
  LabeledEditIdOS.Text := FItemOS.OrdemId.ToString;
  LabeledEditDescrição.Text := FItemOS.Descricao;
  LabeledEditQuantidade.Text := FormatFloat('#,##0.00', FItemOS.Quantidade);
  LabeledEditValorUnitário.Text := FormatFloat('#,##0.00', FItemOS.ValorUnitario);
end;

function TFormEditItemOS.SaveDataFromForm: Boolean;
var
  LHasId,
  LDescriçãoIsFilled,
  LQuantidadeIsValid,
  LValorUnitárioIsValid: Boolean;

  LId,
  LIdOS: UInt64;

  LDescrição: string;

  LQuantidade,
  LValorUnitário: Double;
begin
  Result := False;

  LDescrição := Trim(LabeledEditDescrição.Text);

  LDescriçãoIsFilled := (LDescrição <> '');

  if not LDescriçãoIsFilled then raise Exception.Create('Descrição inválida.');

  if not TryStrToFloat(LabeledEditQuantidade.Text, LQuantidade) then raise Exception.Create('Quantidade inválida.');

  if not TryStrToFloat(LabeledEditValorUnitário.Text, LValorUnitário) then raise Exception.Create('Valor Unitário inválido.');

  LHasId := (Trim(LabeledEditId.Text) <> '');

  if LHasId then LId := StrToInt(LabeledEditId.Text) else LId := 0;

  LIdOS := StrToInt(LabeledEditIdOS.Text);

  FItemOS.Id := LId;
  FItemOS.OrdemId := LIdOS;
  FItemOS.Descricao := LDescrição;
  FItemOS.Quantidade := LQuantidade;
  FItemOS.ValorUnitario := LValorUnitário;

  try
    FMapper.Save(FItemOS);

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TFormEditItemOS.SetValorTotal;
var
  LAmount,
  LUnitValue,
  LTotalValue: Double;
begin
  if (TryStrToFloat(LabeledEditQuantidade.Text, LAmount) and TryStrToFloat(LabeledEditValorUnitário.Text, LUnitValue)) then
  begin
    LTotalValue := LAmount * LUnitValue;

    LabeledEditValorTotal.Text := FormatFloat('#,##0.00', LTotalValue);
  end;
end;

end.
