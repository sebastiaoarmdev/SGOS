object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Gest'#227'o de Ordem de Servi'#231'o'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object PanelTopMenu: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonClientes: TButton
      Left = 8
      Top = 16
      Width = 120
      Height = 30
      Caption = 'Clientes'
      TabOrder = 0
    end
    object ButtonOrdens: TButton
      Left = 144
      Top = 16
      Width = 120
      Height = 30
      Caption = 'Ordens de Servi'#231'o'
      TabOrder = 1
    end
    object ButtonRelatorios: TButton
      Left = 280
      Top = 16
      Width = 120
      Height = 30
      Caption = 'Relat'#243'rios'
      TabOrder = 2
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 579
    Width = 800
    Height = 21
    Panels = <>
    SimplePanel = True
    SimpleText = 'Pronto'
  end
end
