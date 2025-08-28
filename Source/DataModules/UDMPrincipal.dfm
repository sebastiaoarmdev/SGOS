object DMPrincipal: TDMPrincipal
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Projects\Delphi\SGOS\Database\SGOS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Transaction = FDTransaction
    Left = 64
    Top = 64
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 64
    Top = 128
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 64
    Top = 192
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 64
    Top = 256
  end
end
