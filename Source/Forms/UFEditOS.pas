unit UFEditOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFEdit,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, UOS, UOSMapper;

type
  TFormEditOS = class(TFormEdit)
    LabeledEditId: TLabeledEdit;
    LabeledEditIdCliente: TLabeledEdit;
    LabeledEditDataAbertura: TLabeledEdit;
    LabeledEditDataPrevista: TLabeledEdit;
    LabeledEditDataFechamento: TLabeledEdit;
    LabeledEditStatus: TLabeledEdit;
    LabeledEditProblema: TLabeledEdit;
    LabeledEditValor: TLabeledEdit;
    ButtonAddCliente: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClienteClick(Sender: TObject);
  private
    FOS: TOS;
    FMapper: TOSMapper;
  protected
    function SaveDataFromForm: Boolean; override;
    procedure LoadDataToForm; override;
  public
    class function CreateWithId(AId: Integer): TFormEditOS;
    class function CreateWithIdCliente(AIdCliente: Integer): TFormEditOS;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormEditOS: TFormEditOS;

implementation

uses
  UDMMain;

{$R *.dfm}

{ TFormEditOS }

procedure TFormEditOS.ButtonAddClienteClick(Sender: TObject);
begin
  inherited;
  LabeledEditIdCliente.Text := InputBox('Clientes', 'Buscar Cliente...', '0');
end;

constructor TFormEditOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMapper := TOSMapper.Create(DMMain.FDConnection, DMMain.FDTransaction);

  FOS := TOS.Create;
end;

class function TFormEditOS.CreateWithId(AId: Integer): TFormEditOS;
var
  LForm: TFormEditOS;
begin
  LForm := TFormEditOS.Create(Application);

  LForm.FOS := LForm.FMapper.FindById(AId);

  LForm.LoadDataToForm;

  Result := LForm;
end;

class function TFormEditOS.CreateWithIdCliente(AIdCliente: Integer): TFormEditOS;
var
  LForm: TFormEditOS;
begin
  LForm := TFormEditOS.Create(Application);

  LForm.FOS.ClienteId := AIdCliente;

  LForm.LabeledEditIdCliente.Text := IntToStr(AIdCliente);

  Result := LForm;
end;

destructor TFormEditOS.Destroy;
begin
  FreeAndNil(FMapper);

  if Assigned(FOS) then FreeAndNil(FOS);

  inherited;
end;

procedure TFormEditOS.FormCreate(Sender: TObject);
begin
  inherited;
  LabeledEditDataAbertura.Text := FormatDateTime('dd/mm/yyyy', Now);
end;

procedure TFormEditOS.LoadDataToForm;
begin
  inherited;
  LabeledEditId.Text := FOS.Id.ToString;
  LabeledEditIdCliente.Text := FOS.ClienteId.ToString;
  LabeledEditDataAbertura.Text := FormatDateTime('dd/mm/yyyy', FOS.DataAbertura);
  LabeledEditDataPrevista.Text := FormatDateTime('dd/mm/yyyy', FOS.DataPrevista);
  LabeledEditDataFechamento.Text := FormatDateTime('dd/mm/yyyy', FOS.DataFechamento);
  LabeledEditStatus.Text := FOS.Status;
  LabeledEditProblema.Text := FOS.DescricaoProblema;
  LabeledEditValor.Text := FormatFloat('#,##0.00', FOS.ValorTotal);
end;

function TFormEditOS.SaveDataFromForm: Boolean;
var
  LHasId,
  LDataAberturaIsFilled,
  LStatusIsFilled,
  LStatusIsValid: Boolean;

  LId,
  LIdCliente: UInt64;

  LStatus: string;

  LValorTotal: Double;

  LDataAbertura,
  LDataPrevista,
  LDataFechamento: TDateTime;
begin
  Result := False;

  if not TryStrToDate(LabeledEditDataAbertura.Text, LDataAbertura) then raise Exception.Create('Data de Abertura inválida.');

  TryStrToDate(LabeledEditDataPrevista.Text, LDataPrevista);

  TryStrToDate(LabeledEditDataFechamento.Text, LDataFechamento);

  LStatus := Trim(LabeledEditStatus.Text);

  LStatusIsFilled := (LStatus <> '');

  LStatusIsValid := (
    (LStatus = 'Aberta') or
    (LStatus = 'Em Andamento') or
    (LStatus = 'Concluída') or
    (LStatus = 'Cancelada'));

  if not LStatusIsValid then raise Exception.Create('Status inválido.');

  if not TryStrToFloat(LabeledEditValor.Text, LValorTotal) then raise Exception.Create('Valor Total inválido.');

  LHasId := (Trim(LabeledEditId.Text) <> '');

  if LHasId then LId := StrToInt(LabeledEditId.Text) else LId := 0;

  LIdCliente := StrToInt(LabeledEditIdCliente.Text);

  FOS.Id := LId;
  FOS.ClienteId := LIdCliente;
  FOS.DataAbertura := LDataAbertura;
  FOS.DataPrevista := LDataPrevista;
  FOS.DataFechamento := LDataFechamento;
  FOS.Status := LStatus;
  FOS.DescricaoProblema := Trim(LabeledEditProblema.Text);
  FOS.ValorTotal := LValorTotal;

  try
    FMapper.Save(FOS);

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
