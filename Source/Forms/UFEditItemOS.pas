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
    LabeledEditDescri��o: TLabeledEdit;
    LabeledEditQuantidade: TLabeledEdit;
    LabeledEditValorUnit�rio: TLabeledEdit;
    LabeledEditValorTotal: TLabeledEdit;
    procedure LabeledEditQuantidadeChange(Sender: TObject);
    procedure LabeledEditValorUnit�rioChange(Sender: TObject);
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

procedure TFormEditItemOS.LabeledEditValorUnit�rioChange(Sender: TObject);
begin
  SetValorTotal;
end;

procedure TFormEditItemOS.LoadDataToForm;
begin
  inherited;
  LabeledEditId.Text := FItemOS.Id.ToString;
  LabeledEditIdOS.Text := FItemOS.OrdemId.ToString;
  LabeledEditDescri��o.Text := FItemOS.Descricao;
  LabeledEditQuantidade.Text := FormatFloat('#,##0.00', FItemOS.Quantidade);
  LabeledEditValorUnit�rio.Text := FormatFloat('#,##0.00', FItemOS.ValorUnitario);
end;

function TFormEditItemOS.SaveDataFromForm: Boolean;
var
  LHasId,
  LDescri��oIsFilled,
  LQuantidadeIsValid,
  LValorUnit�rioIsValid: Boolean;

  LId,
  LIdOS: UInt64;

  LDescri��o: string;

  LQuantidade,
  LValorUnit�rio: Double;
begin
  Result := False;

  LDescri��o := Trim(LabeledEditDescri��o.Text);

  LDescri��oIsFilled := (LDescri��o <> '');

  if not LDescri��oIsFilled then raise Exception.Create('Descri��o inv�lida.');

  if not TryStrToFloat(LabeledEditQuantidade.Text, LQuantidade) then raise Exception.Create('Quantidade inv�lida.');

  if not TryStrToFloat(LabeledEditValorUnit�rio.Text, LValorUnit�rio) then raise Exception.Create('Valor Unit�rio inv�lido.');

  LHasId := (Trim(LabeledEditId.Text) <> '');

  if LHasId then LId := StrToInt(LabeledEditId.Text) else LId := 0;

  LIdOS := StrToInt(LabeledEditIdOS.Text);

  FItemOS.Id := LId;
  FItemOS.OrdemId := LIdOS;
  FItemOS.Descricao := LDescri��o;
  FItemOS.Quantidade := LQuantidade;
  FItemOS.ValorUnitario := LValorUnit�rio;

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
  if (TryStrToFloat(LabeledEditQuantidade.Text, LAmount) and TryStrToFloat(LabeledEditValorUnit�rio.Text, LUnitValue)) then
  begin
    LTotalValue := LAmount * LUnitValue;

    LabeledEditValorTotal.Text := FormatFloat('#,##0.00', LTotalValue);
  end;
end;

end.
