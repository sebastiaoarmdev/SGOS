unit UStringHelper;

interface

uses
  System.SysUtils, System.RegularExpressions;

function Capitalize(const AString: string): string;
function IsValidEmail(const AEmail: string): Boolean;

implementation

function Capitalize(const AString: string): string;
var
  LTempString: string;
begin
  // 1. Verifica se a string n�o est� vazia. Se estiver, retorna uma string vazia.
  if AString.IsEmpty then
    Exit('');

  // 2. Converte toda a string para min�sculas.
  LTempString := AnsiLowerCase(AString);

  // 3. Converte o primeiro caractere para mai�sculo.
  LTempString[1] := AnsiUpperCase(LTempString[1])[1];

  // 4. Retorna a string modificada.
  Result := LTempString;
end;


function IsValidEmail(const AEmail: string): Boolean;
begin
  Result := TRegEx.IsMatch(AEmail.Trim, '^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
end;



end.
