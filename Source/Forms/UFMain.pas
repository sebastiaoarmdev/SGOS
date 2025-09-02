unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  System.DateUtils;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    ButtonCustomer: TButton;
    ButtonServiceOrder: TButton;
    ButtonReport: TButton;
    StatusBar: TStatusBar;
    Memo: TMemo;
    ImageList: TImageList;
    procedure ButtonCustomerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonServiceOrderClick(Sender: TObject);
  private
    { Private declarations }
    procedure MemoLog(AMessage: string);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  UFGridClientes,
  UFGridOS,
  UStringHelper,
  System.UITypes;

{$R *.dfm}

function GetWindowsUserName: string;
var
  LSize: Cardinal;

  LUserName: string;
begin
  LSize := 256;
  // Define o tamanho da string para o buffer
  SetLength(LUserName, LSize);

  if GetUserName(PChar(LUserName), LSize) then
  begin
    // Ajusta o tamanho da string para remover o caractere nulo
    SetLength(LUserName, LSize - 1);

    Result := LUserName;
  end
  else
  begin
    // Retorna string vazia se houver erro
    Result := '';
  end;
end;

procedure TFormMain.ButtonCustomerClick(Sender: TObject);
var
  LFormGridClientes: TFormGridClientes;

  LErrorMessage: string;
begin
  LFormGridClientes := TFormGridClientes.Create(Self);

  MemoLog('Abrindo formulário de Clientes...');

  try
    LFormGridClientes.ShowModal;
  finally
    LFormGridClientes.Free;
  end;

  MemoLog('Formulário de Clientes fechado.');
end;

procedure TFormMain.ButtonServiceOrderClick(Sender: TObject);
var
  LFormGridOS: TFormGridOS;

  LErrorMessage: string;
begin
  LFormGridOS := TFormGridOS.Create(Self);

  MemoLog('Abrindo formulário de Ordens de Serviços...');

  try
    LFormGridOS.ShowModal;
  finally
    LFormGridOS.Free;
  end;

  MemoLog('Formulário de Clientes fechado.');
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LGreeting: string;

  LCurrentHour: Byte;
begin
  LCurrentHour := HourOf(Now);

  if (LCurrentHour < 12) then LGreeting := 'Bom dia'
    else if (LCurrentHour < 18) then LGreeting := 'Boa tarde'
      else LGreeting := 'Boa noite';

  MemoLog(Format('%s, %s! :)', [LGreeting, Capitalize(GetWindowsUserName)]));
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    case Key of
      vkC: ButtonCustomer.Click;
      vkO: ButtonServiceOrder.Click;
      vkR: ButtonReport.Click;
    end;
  end;
end;

procedure TFormMain.MemoLog(AMessage: string);
var
  LMessage,
  LNowAsString: string;
begin
  LNowAsString := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now);

  LMessage := Format('%s - %s', [LNowAsString, AMessage]);

  Memo.Lines.Append(LMessage);
end;

end.
