program SGOS;

uses
  Vcl.Forms,
  UFMain in 'Forms\UFMain.pas' {FormMain},
  UDMMain in 'DataModules\UDMMain.pas' {DMMain: TDataModule},
  UFGrid in 'Forms\UFGrid.pas' {FormGrid},
  UCliente in 'Busines\UCliente.pas',
  UClienteMapper in 'Busines\UClienteMapper.pas',
  UOS in 'Busines\UOS.pas',
  UOSMapper in 'Busines\UOSMapper.pas',
  UItemOS in 'Busines\UItemOS.pas',
  UItemOSMapper in 'Busines\UItemOSMapper.pas',
  UFEdit in 'Forms\UFEdit.pas' {FormEdit},
  UFGridClientes in 'Forms\UFGridClientes.pas' {FormGridClientes},
  UStringHelper in 'Utils\UStringHelper.pas',
  UMapper in 'Busines\UMapper.pas',
  UEntity in 'Busines\UEntity.pas',
  UFEditCliente in 'Forms\UFEditCliente.pas' {FormEditCliente},
  UFEditItemOS in 'Forms\UFEditItemOS.pas' {FormEditItemOS},
  UFEditOS in 'Forms\UFEditOS.pas' {FormEditOS},
  UFGridOS in 'Forms\UFGridOS.pas' {FormGridOS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDMMain, DMMain);
  Application.CreateForm(TFormEdit, FormEdit);
  Application.CreateForm(TFormGridClientes, FormGridClientes);
  Application.CreateForm(TFormEditCliente, FormEditCliente);
  Application.CreateForm(TFormEditItemOS, FormEditItemOS);
  Application.CreateForm(TFormEditOS, FormEditOS);
  Application.CreateForm(TFormGridOS, FormGridOS);
  Application.Run;
end.
