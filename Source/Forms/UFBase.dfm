object FormBase: TFormBase
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio Base de Cadastro'
  ClientHeight = 550
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PanelGrid: TPanel
    Left = 0
    Top = 41
    Width = 750
    Height = 509
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 416
    ExplicitTop = 368
    ExplicitWidth = 185
    ExplicitHeight = 41
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 748
      Height = 507
      Align = alClient
      DataSource = DataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 384
    ExplicitTop = 184
    ExplicitWidth = 185
    object ButtonIncluir: TButton
      Left = 8
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
    end
    object ButtonSalvar: TButton
      Left = 89
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Salvar'
      Enabled = False
      TabOrder = 1
    end
    object ButtonCancelar: TButton
      Left = 170
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 2
    end
    object ButtonExcluir: TButton
      Left = 251
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Excluir'
      Enabled = False
      TabOrder = 3
    end
    object ButtonLocalizar: TButton
      Left = 413
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Localizar'
      TabOrder = 4
    end
    object ButtonAtualizar: TButton
      Left = 332
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 5
    end
  end
  object DataSource: TDataSource
    Left = 56
    Top = 81
  end
end
