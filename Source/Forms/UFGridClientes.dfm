inherited FormGridClientes: TFormGridClientes
  Caption = 'Clientes'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited PanelMain: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited PanelTop: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited SearchBox: TSearchBox
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end
