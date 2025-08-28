unit UFBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormBase = class(TForm)
    PanelGrid: TPanel;
    PanelTop: TPanel;
    DBGrid: TDBGrid;
    ButtonIncluir: TButton;
    ButtonSalvar: TButton;
    ButtonCancelar: TButton;
    ButtonExcluir: TButton;
    ButtonLocalizar: TButton;
    ButtonAtualizar: TButton;
    DataSource: TDataSource;
  private
    { Private declarations }
    procedure SetEditMode(const AState: Boolean);
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

{ TFormBase }

procedure TFormBase.SetEditMode(const AState: Boolean);
begin
  ButtonIncluir.Enabled := not AState;
  ButtonSalvar.Enabled := AState;
  ButtonCancelar.Enabled := AState;
  ButtonExcluir.Enabled := not AState;
  ButtonLocalizar.Enabled := not AState;
end;

end.
