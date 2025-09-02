inherited FormEditCliente: TFormEditCliente
  Caption = 'Cliente'
  ClientHeight = 335
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 374
  TextHeight = 15
  inherited PanelMain: TPanel
    Height = 265
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 265
    object LabeledEditNome: TLabeledEdit
      Left = 16
      Top = 80
      Width = 438
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 33
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome'
      TabOrder = 0
      Text = ''
    end
    object LabeledEditDocumento: TLabeledEdit
      Left = 16
      Top = 128
      Width = 121
      Height = 23
      EditLabel.Width = 63
      EditLabel.Height = 15
      EditLabel.Caption = 'Documento'
      TabOrder = 1
      Text = ''
    end
    object LabeledEditEMail: TLabeledEdit
      Left = 16
      Top = 176
      Width = 438
      Height = 23
      EditLabel.Width = 34
      EditLabel.Height = 15
      EditLabel.Caption = 'E-Mail'
      TabOrder = 2
      Text = ''
    end
    object LabeledEditTelefone: TLabeledEdit
      Left = 16
      Top = 223
      Width = 119
      Height = 23
      EditLabel.Width = 45
      EditLabel.Height = 15
      EditLabel.Caption = 'Telefone'
      EditMask = '!+99 (99) 9 9999-9999;0;_'
      MaxLength = 20
      TabOrder = 3
      Text = ''
    end
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
  end
  inherited PanelBottom: TPanel
    Top = 265
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 265
  end
  inherited StatusBar: TStatusBar
    Top = 316
    ExplicitTop = 316
  end
end
