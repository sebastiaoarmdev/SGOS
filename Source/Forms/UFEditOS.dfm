inherited FormEditOS: TFormEditOS
  Caption = 'Ordem de Servi'#231'o'
  ClientHeight = 481
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitHeight = 520
  TextHeight = 15
  inherited PanelMain: TPanel
    Height = 411
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 411
    object LabeledEditId: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 23
      TabStop = False
      Color = clLightgray
      EditLabel.Width = 10
      EditLabel.Height = 15
      EditLabel.Caption = 'Id'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object LabeledEditIdCliente: TLabeledEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 23
      TabStop = False
      Color = clLightgray
      EditLabel.Width = 67
      EditLabel.Height = 15
      EditLabel.Caption = 'Id do Cliente'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object LabeledEditDataAbertura: TLabeledEdit
      Left = 16
      Top = 128
      Width = 121
      Height = 23
      EditLabel.Width = 89
      EditLabel.Height = 15
      EditLabel.Caption = 'Data de Abertura'
      TabOrder = 2
      Text = ''
    end
    object LabeledEditDataPrevista: TLabeledEdit
      Left = 16
      Top = 175
      Width = 121
      Height = 23
      EditLabel.Width = 68
      EditLabel.Height = 15
      EditLabel.Caption = 'Data Prevista'
      TabOrder = 3
      Text = ''
    end
    object LabeledEditDataFechamento: TLabeledEdit
      Left = 16
      Top = 224
      Width = 121
      Height = 23
      EditLabel.Width = 109
      EditLabel.Height = 15
      EditLabel.Caption = 'Data de Fechamento'
      TabOrder = 4
      Text = ''
    end
    object LabeledEditStatus: TLabeledEdit
      Left = 16
      Top = 272
      Width = 121
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Status'
      TabOrder = 5
      Text = ''
    end
    object LabeledEditProblema: TLabeledEdit
      Left = 16
      Top = 320
      Width = 438
      Height = 23
      EditLabel.Width = 122
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o do Problema'
      TabOrder = 6
      Text = ''
    end
    object LabeledEditValor: TLabeledEdit
      Left = 16
      Top = 368
      Width = 121
      Height = 23
      Color = clLightgray
      EditLabel.Width = 55
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor Total'
      ReadOnly = True
      TabOrder = 7
      Text = '0,00'
    end
    object ButtonAddCliente: TButton
      Left = 143
      Top = 79
      Width = 26
      Height = 25
      Caption = '...'
      TabOrder = 8
      TabStop = False
      OnClick = ButtonAddClienteClick
    end
  end
  inherited PanelBottom: TPanel
    Top = 411
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 411
  end
  inherited StatusBar: TStatusBar
    Top = 462
    ExplicitTop = 462
  end
end
