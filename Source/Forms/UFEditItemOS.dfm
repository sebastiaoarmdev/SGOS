inherited FormEditItemOS: TFormEditItemOS
  Caption = 'Item da Ordem de Servi'#231'o'
  ClientHeight = 390
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 429
  TextHeight = 15
  inherited PanelMain: TPanel
    Height = 320
    StyleElements = [seFont, seClient, seBorder]
    object LabeledEditId: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 23
      Color = clLightgray
      EditLabel.Width = 10
      EditLabel.Height = 15
      EditLabel.Caption = 'Id'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object LabeledEditIdOS: TLabeledEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 23
      Color = clLightgray
      EditLabel.Width = 94
      EditLabel.Height = 15
      EditLabel.Caption = 'Ordem de Servi'#231'o'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object LabeledEditDescrição: TLabeledEdit
      Left = 16
      Top = 128
      Width = 438
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 51
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o'
      TabOrder = 2
      Text = ''
    end
    object LabeledEditQuantidade: TLabeledEdit
      Left = 16
      Top = 175
      Width = 121
      Height = 23
      EditLabel.Width = 62
      EditLabel.Height = 15
      EditLabel.Caption = 'Quantidade'
      TabOrder = 3
      Text = '1'
      OnChange = LabeledEditQuantidadeChange
    end
    object LabeledEditValorUnitário: TLabeledEdit
      Left = 16
      Top = 224
      Width = 121
      Height = 23
      EditLabel.Width = 71
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor Unit'#225'rio'
      TabOrder = 4
      Text = '0,00'
      OnChange = LabeledEditValorUnitárioChange
    end
    object LabeledEditValorTotal: TLabeledEdit
      Left = 16
      Top = 272
      Width = 121
      Height = 23
      Color = clLightgray
      EditLabel.Width = 55
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor Total'
      ReadOnly = True
      TabOrder = 5
      Text = ''
    end
  end
  inherited PanelBottom: TPanel
    Top = 320
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited StatusBar: TStatusBar
    Top = 371
  end
end
