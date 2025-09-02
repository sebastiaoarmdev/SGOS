unit UFGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, System.UITypes,
  Vcl.WinXCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, System.StrUtils,
  System.ImageList, Vcl.ImgList, Vcl.Mask, UMapper, UEntity;

type
  TFormGrid = class(TForm)
    PanelMain: TPanel;
    PanelTop: TPanel;
    DBGrid: TDBGrid;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    ButtonUpdate: TButton;
    DataSource: TDataSource;
    ButtonEdit: TButton;
    SearchBox: TSearchBox;
    StatusBar: TStatusBar;
    ImageList: TImageList;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FDataSet: TDataSet;
    FDataSetInMemory: TFDMemTable;
    procedure SetDataSet(const Value: TDataSet);
  protected
    { Protected declarations }
    function DataAdd: Boolean; virtual; abstract;
    function DataEdit: Boolean; virtual; abstract;
    procedure DataDelete; virtual; abstract;
    procedure DataLoad; virtual; abstract;
  public
    { Public declarations }
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property DataSetInMemory: TFDMemTable read FDataSetInMemory write FDataSetInMemory;
  end;

var
  FormGrid: TFormGrid;

implementation

uses
  UFEdit;

{$R *.dfm}

{ TFormBase }

procedure TFormGrid.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;

  if (Assigned(DataSource) and Assigned(FDataSet)) then
  begin
    DataSource.DataSet := FDataSet;
  end;
end;

procedure TFormGrid.ButtonAddClick(Sender: TObject);
var
  LErrorMessage,
  LStatusMessage: string;
begin
  if not Assigned(FDataSet) then Exit;

  StatusBar.SimpleText := 'Incluindo...';

  try
    if DataAdd then LStatusMessage := 'Dado incluído.'
      else LStatusMessage := 'Inclusão cancelada.';

    StatusBar.SimpleText := LStatusMessage;
  except
    on E: Exception do
    begin
      LErrorMessage := Format('Erro ao incluir dado: %s', [E.Message]);

      StatusBar.SimpleText := LErrorMessage;

      raise Exception.Create(LErrorMessage);
    end;
  end;
end;

procedure TFormGrid.ButtonEditClick(Sender: TObject);
var
  LErrorMessage,
  LStatusMessage: string;
begin
  if not Assigned(FDataSet) then Exit;

  StatusBar.SimpleText := 'Editando...';

  try
    if DataEdit then LStatusMessage := 'Dado editado.'
      else LStatusMessage := 'Edição cancelada.';

    StatusBar.SimpleText := LStatusMessage;
  except
    on E: Exception do
    begin
      LErrorMessage := Format('Erro ao editar dado: %s', [E.Message]);

      StatusBar.SimpleText := LErrorMessage;

      raise Exception.Create(LErrorMessage);
    end;
  end;
end;

procedure TFormGrid.ButtonUpdateClick(Sender: TObject);
var
  LErrorMessage: string;
begin
  if not Assigned(FDataSet) then Exit;

  StatusBar.SimpleText := 'Atualizando...';

  try
    DataLoad;

    StatusBar.SimpleText := 'Dados atualizados.';
  except
    on E: Exception do
    begin
      LErrorMessage := Format('Erro ao atualizar dados: %s', [E.Message]);

      StatusBar.SimpleText := LErrorMessage;

      raise Exception.Create(LErrorMessage);
    end;
  end;
end;

procedure TFormGrid.DBGridDblClick(Sender: TObject);
begin
  ButtonEdit.Click;
end;

procedure TFormGrid.FormCreate(Sender: TObject);
begin
  FDataSetInMemory := TFDMemTable.Create(nil);
end;

procedure TFormGrid.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDataSetInMemory);
end;

procedure TFormGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT: ButtonAdd.Click;
    VK_F2: ButtonEdit.Click;
    VK_DELETE: ButtonDelete.Click;
    VK_F5: ButtonUpdate.Click;
  end;
end;

procedure TFormGrid.ButtonDeleteClick(Sender: TObject);
var
  LErrorMessage: string;
begin
  if ((not Assigned(FDataSet)) or (FDataSet.IsEmpty)) then Exit;

  StatusBar.SimpleText := 'Excluindo...';

  if (MessageDlg('Deseja realmente excluir o dado?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
  begin
    StatusBar.SimpleText := 'Exclucão cancelada.';

    Exit;
  end;

  try
    DataDelete;

    StatusBar.SimpleText := 'Dado excluído.';
  except
    on E: Exception do
    begin
      LErrorMessage := Format('Erro ao excluir dado: %s', [E.Message]);

      StatusBar.SimpleText := LErrorMessage;

      raise Exception.Create(LErrorMessage);
    end;
  end;
end;

end.
