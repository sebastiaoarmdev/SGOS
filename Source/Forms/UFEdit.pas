unit UFEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList;

type
  TFormEdit = class(TForm)
    PanelMain: TPanel;
    PanelBottom: TPanel;
    StatusBar: TStatusBar;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ImageList: TImageList;
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function SaveDataFromForm: Boolean; virtual; abstract;
    procedure LoadDataToForm; virtual; abstract;
  public
    { Public declarations }
  end;

var
  FormEdit: TFormEdit;

implementation

{$R *.dfm}

procedure TFormEdit.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormEdit.ButtonSaveClick(Sender: TObject);
begin
  try
    if not SaveDataFromForm then Exit;

    ModalResult := mrOK;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao salvar os dados: ' + E.Message);
    end;
  end;
end;

procedure TFormEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ButtonSave.Click;
    VK_ESCAPE: ButtonCancel.Click;
  end;
end;

end.
