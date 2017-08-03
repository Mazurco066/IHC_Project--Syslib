object Modulo_Dados: TModulo_Dados
  OldCreateOrder = False
  Height = 296
  Width = 161
  object Conexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=BD_bibliotec;Data Source=DESKTOP-O464CL' +
      'S;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=40' +
      '96;Workstation ID=DESKTOP-O464CLS;Use Encryption for Data=False;' +
      'Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 8
  end
  object Query_User: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from usuarios;')
    Left = 24
    Top = 64
    object Query_UserNome: TWideStringField
      FieldName = 'Nome'
      Size = 50
    end
    object Query_UserHash: TWideStringField
      FieldName = 'Hash'
      Size = 90
    end
  end
  object Query_Cat: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from categorias')
    Left = 24
    Top = 120
    object Query_Catid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object Query_Catdescricao: TStringField
      FieldName = 'descricao'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query_User
    Left = 96
    Top = 64
  end
  object Query_livros: TADOQuery
    Active = True
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from livros')
    Left = 24
    Top = 176
    object Query_livrosid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object Query_livrosnome: TStringField
      FieldName = 'nome'
      Size = 45
    end
    object Query_livrosautor: TStringField
      FieldName = 'autor'
      Size = 50
    end
    object Query_livrosedicao: TStringField
      FieldName = 'edicao'
      Size = 10
    end
    object Query_livroseditora: TStringField
      FieldName = 'editora'
      Size = 25
    end
    object Query_livrossessao: TStringField
      FieldName = 'sessao'
      Size = 10
    end
    object Query_livrosquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Query_livrosexemplares: TIntegerField
      FieldName = 'exemplares'
    end
    object Query_livroscategoria_id: TIntegerField
      FieldName = 'categoria_id'
    end
  end
  object DataSourceCat: TDataSource
    DataSet = Query_Cat
    Left = 96
    Top = 120
  end
  object DataSourceLiv: TDataSource
    DataSet = Query_livros
    Left = 96
    Top = 176
  end
  object Query_Aluno: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from alunos')
    Left = 24
    Top = 232
    object Query_Alunoid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object Query_Alunonome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object Query_Alunora: TStringField
      FieldName = 'ra'
      Size = 11
    end
    object Query_Alunorg: TStringField
      FieldName = 'rg'
      Size = 11
    end
    object Query_Alunoendereco: TStringField
      FieldName = 'endereco'
      Size = 70
    end
    object Query_Alunotelefone: TStringField
      FieldName = 'telefone'
      Size = 12
    end
    object Query_Alunocurso: TStringField
      FieldName = 'curso'
      Size = 60
    end
    object Query_Alunoid_categoria: TIntegerField
      FieldName = 'id_categoria'
    end
  end
  object DataSourceA: TDataSource
    DataSet = Query_Aluno
    Left = 96
    Top = 232
  end
end
