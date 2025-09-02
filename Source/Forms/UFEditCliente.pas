unit UFEditCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFEdit,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask, UCliente, UClienteMapper;

type
  TFormEditCliente = class(TFormEdit)
    LabeledEditNome: TLabeledEdit;
    LabeledEditDocumento: TLabeledEdit;
    LabeledEditEMail: TLabeledEdit;
    LabeledEditTelefone: TLabeledEdit;
    LabeledEditId: TLabeledEdit;
  private
    { Private declarations }
    FCliente: TCliente;
    FMapper: TClienteMapper;
  protected
    function SaveDataFromForm: Boolean; override;
    procedure LoadDataToForm; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function CreateWithId(AId: Integer): TFormEditCliente;
    destructor Destroy; override;
  end;

var
  FormEditCliente: TFormEditCliente;

implementation

uses
  UDMMain,
  UStringHelper;

{$R *.dfm}

{ TFormEditCliente }

constructor TFormEditCliente.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMapper := TClienteMapper.Create(DMMain.FDConnection, DMMain.FDTransaction);

  FCliente := TCliente.Create;
end;

class function TFormEditCliente.CreateWithId(AId: Integer): TFormEditCliente;
var
  LForm: TFormEditCliente;
begin
  LForm := TFormEditCliente.Create(Application);

  LForm.FCliente := LForm.FMapper.FindById(AId);

  LForm.LoadDataToForm;

  Result := LForm;
end;

destructor TFormEditCliente.Destroy;
begin
  FreeAndNil(FMapper);
  if Assigned(FCliente) then FreeAndNil(FCliente);
  inherited;
end;

procedure TFormEditCliente.LoadDataToForm;
begin
  LabeledEditId.Text := FCliente.Id.ToString;
  LabeledEditNome.Text := FCliente.Nome;
  LabeledEditDocumento.Text := FCliente.Documento;
  LabeledEditEMail.Text := FCliente.Email;
  LabeledEditTelefone.Text := FCliente.Telefone;
end;

function TFormEditCliente.SaveDataFromForm: Boolean;
var
  LHasId,
  LNomeIsFilled,
  LEMailIsValid,
  LEMailIsFilled: Boolean;

  LId: UInt64;

  LNome,
  LEMail,
  LDocumento,
  LTelefone: string;
begin
  Result := False;

  LNome := Trim(LabeledEditNome.Text);

  LNomeIsFilled := (LNome <> '');

  if not LNomeIsFilled then raise Exception.Create('Nome inválido.');

  LEMail := Trim(LabeledEditEmail.Text);

  LEMailIsFilled := (LEMail <> '');

  if LEMailIsFilled then
  begin
    LEMailIsValid := IsValidEmail(LEMail);

    if not LEMailIsValid then raise Exception.Create('E-mail inválido.');
  end;

  LHasId := (Trim(LabeledEditId.Text) <> '');

  if LHasId then LId := StrToInt(LabeledEditId.Text) else LId := 0;

  LDocumento := Trim(LabeledEditDocumento.Text);

  LTelefone := Trim(LabeledEditTelefone.Text);

  FCliente.Id := LId;
  FCliente.Nome := LNome;
  FCliente.Documento := LDocumento;
  FCliente.Email := LEMail;
  FCliente.Telefone := LTelefone;

  try
    FMapper.Save(FCliente);

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
