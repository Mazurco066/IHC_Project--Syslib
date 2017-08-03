unit Form_Dados;

interface

uses
  Winapi.Messages, Winapi.Windows, System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB,
  Datasnap.DBClient;

type
  TModulo_Dados = class(TDataModule)
    Conexao: TADOConnection;
    Query_User: TADOQuery;
    Query_UserNome: TWideStringField;
    Query_UserHash: TWideStringField;
    Query_Cat: TADOQuery;
    DataSource: TDataSource;
    Query_Catid: TAutoIncField;
    Query_Catdescricao: TStringField;
    Query_livros: TADOQuery;
    Query_livrosid: TAutoIncField;
    Query_livrosnome: TStringField;
    Query_livrosautor: TStringField;
    Query_livrosedicao: TStringField;
    Query_livroseditora: TStringField;
    Query_livrossessao: TStringField;
    Query_livrosquantidade: TIntegerField;
    Query_livrosexemplares: TIntegerField;
    Query_livroscategoria_id: TIntegerField;
    DataSourceCat: TDataSource;
    DataSourceLiv: TDataSource;
    Query_Aluno: TADOQuery;
    DataSourceA: TDataSource;
    Query_Alunoid: TAutoIncField;
    Query_Alunonome: TStringField;
    Query_Alunora: TStringField;
    Query_Alunorg: TStringField;
    Query_Alunoendereco: TStringField;
    Query_Alunotelefone: TStringField;
    Query_Alunocurso: TStringField;
    Query_Alunoid_categoria: TIntegerField;
    //funções cadastro usuário
    procedure NovoUsuario(UserPr:string; HashPr:string); //pronto
    procedure AtualizarUsuario(IDPr:string; UserPr:string; senhaPr:string); //pronto
    procedure ExcluirUsuario(UserPr:string); //pronto
    //funções cadastro categorias
    procedure NovaCategoria(CatPr:string); //pronto
    procedure AtualizarCategoria(IdPr:integer; CatPr:string); //pronto
    procedure ExluirCategoria(IdPr:integer); //pronto
    //funções cadastro livros
    procedure Novolivro(nomePr:string; autorPr:string; edicaoPr:string; //em teste
    editoraPr:string; sessaoPr:string; exemplarPr:integer; quantidadePr:integer;
    id_categoria:integer);
    procedure AtualizarLivro(idPr:integer; nomePr:string; autorPr:string; edicaoPr:string;
    editoraPr:string; sessaoPr:string; exemplarPr:integer; quantidadePr:integer;
    id_categoria:integer);
    procedure ExcluirLivro(IdPr:integer); //em teste
    //funções cadastro aluno
    procedure NovoAluno(nomePr:string; RA:string; RG:string; enderecoPr:string;
    telefonepr:string; cursoPr:string; categoria_id:integer);
    procedure AtualizarAluno(idPr:integer; nomePr:string; RA:string; RG:string; enderecoPr:string;
    telefonepr:string; cursoPr:string; categoria_id:integer);
    procedure ExcluirAluno(idPr:integer);
    //funções gerais
    function Hash(const Input: string):string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Modulo_Dados: TModulo_Dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Wcrypt2;

{$R *.dfm}

//Novo usuário
procedure TModulo_Dados.NovoUsuario(UserPr: string; HashPr: string);
begin

  with Query_User do begin
    Close;
    SQL.Clear;
    SQL.Add('insert into usuarios (Nome, hash) values (:userPr, :hashPr)');
    Parameters.ParamByName('userPr').Value := userPr;
    Parameters.ParamByName('hashPr').Value := HashPr;
    ExecSQl;

    Close;
    SQL.Clear;
    SQL.Add('select * from usuarios');
    Open;
  end;

end;

//Atualizar usuário
procedure TModulo_Dados.AtualizarUsuario(IDPr: string; UserPr: string; senhaPr: string);
begin

  //exemplo de uso do with com o objeto queryP
  with Query_User do begin

    Close;
    SQL.Clear;
    SQL.Add('UPDATE usuarios SET Nome = :UserPr,Hash = :senhaPr where Nome = :IDPr');
    Parameters.ParamByName('IDPr').Value := IDPr;
    Parameters.ParamByName('UserPR').Value := UserPr;
    Parameters.ParamByName('senhaPr').Value := senhaPr;

    ExecSQL;

  end;

  //Resetando para Visualização
  Query_user.Close;
  Query_user.SQL.Clear;
  query_user.SQL.Add('select * from usuarios');
  Query_user.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos


end;

//Deletar usuário
procedure TModulo_Dados.ExcluirUsuario(UserPr: string);
begin

  Query_User.Close;
  Query_User.SQL.Clear;
  Query_User.SQL.Add('delete from usuarios where Nome = :UserPr');
  Query_User.Parameters.ParamByName('UserPr').Value := UserPr;
  Query_User.ExecSQL;

  //Resetando para Visualização
  Query_User.Close;
  Query_User.SQL.Clear;
  Query_User.SQL.add('select * from usuarios');
  Query_User.Open;

end;

//Nova categoria
procedure TModulo_Dados.NovaCategoria(CatPr: string);
begin

  with Query_Cat do begin
    Close;
    SQL.Clear;
    SQL.Add('insert into categorias (descricao) values (:CatPr)');
    Parameters.ParamByName('CatPr').Value := CatPr;
    ExecSQl;

    Close;
    SQL.Clear;
    SQL.Add('select * from categorias');
    Open;
  end;

end;

//Atualizar categoria
procedure TModulo_Dados.AtualizarCategoria(IdPr: Integer; CatPr: string);
begin

  //exemplo de uso do with com o objeto queryP
  with Query_cat do begin

    Close;
    SQL.Clear;
    SQL.Add('UPDATE categorias SET descricao = :CatPr where id = :IDPr');
    Parameters.ParamByName('IDPr').Value := IDPr;
    Parameters.ParamByName('Catpr').Value := CatPr;

    ExecSQL;

  end;

  //Resetando para Visualização
  Query_cat.Close;
  Query_cat.SQL.Clear;
  Query_cat.SQL.Add('select * from categorias');
  Query_cat.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos

end;

//Deletar categoria
procedure TModulo_Dados.ExluirCategoria(IdPr: Integer);
begin

  Query_cat.Close;
  Query_cat.SQL.Clear;
  Query_cat.SQL.Add('delete from categorias where id = :IdPr');
  Query_cat.Parameters.ParamByName('IdPr').Value := IdPr;
  Query_cat.ExecSQL;

  //Resetando para Visualização
  Query_cat.Close;
  Query_cat.SQL.Clear;
  Query_cat.SQL.add('select * from categorias');
  Query_cat.Open;

end;

//Novo livro
procedure TModulo_dados.Novolivro(nomePr: string; autorPr: string; edicaoPr: string; editoraPr: string; sessaoPr: string; exemplarPr: Integer; quantidadePr: Integer; id_categoria: Integer);
begin

  with Query_livros do begin
    Close;
    SQL.Clear;
    SQL.Add('insert into livros (nome,autor,edicao,editora,sessao,quantidade,exemplares,categoria_id)' +
    ' values (:nomepr,:autorPr,:edicaoPr,:editorapr,:sessaoPr,:quantidadePr,:exemplarPr,:id_categoria)');
    Parameters.ParamByName('nomePr').Value := nomePr;
    Parameters.ParamByName('autorPr').Value := autorPr;
    Parameters.ParamByName('edicaoPr').Value := edicaoPr;
    Parameters.ParamByName('editoraPr').Value := editoraPr;
    Parameters.ParamByName('sessaoPr').Value := sessaoPr;
    Parameters.ParamByName('quantidadePr').Value := quantidadePr;
    Parameters.ParamByName('exemplarPr').Value := exemplarPr;
    Parameters.ParamByName('id_categoria').Value := id_categoria;
    ExecSQl;

    Close;
    SQL.Clear;
    SQL.Add('select * from livros');
    Open;
  end;

end;

//Atualizar livro
procedure TModulo_dados.AtualizarLivro(idPr: Integer; nomePr: string; autorPr: string; edicaoPr: string; editoraPr: string; sessaoPr: string; exemplarPr: Integer; quantidadePr: Integer; id_categoria: Integer);
begin

  //exemplo de uso do with com o objeto queryP
  with Query_livros do begin

    Close;
    SQL.Clear;
    SQL.Add('UPDATE livros SET nome = :nomePr, autor = :autorPr' +
    ', edicao = :edicaoPr, editora = :editoraPr, sessao = :sessaoPr' +
    ', exemplares = :exemplarPr, quantidade = :quantidadePr, categoria_id = :IDCat' +
    ' where id = :IDPr');
    Parameters.ParamByName('IDPr').Value := IDPr;
    Parameters.ParamByName('nomePr').Value := nomePr;
    Parameters.ParamByName('autorPr').Value := autorPr;
    Parameters.ParamByName('edicaoPr').Value := edicaoPr;
    Parameters.ParamByName('editoraPr').Value := editoraPr;
    Parameters.ParamByName('sessaoPr').Value := sessaoPr;
    Parameters.ParamByName('exemplarPr').Value := exemplarPr;
    Parameters.ParamByName('quantidadePr').Value := quantidadePr;
    Parameters.ParamByName('IDCat').Value := id_categoria;

    ExecSQL;

  end;

  //Resetando para Visualização
  Query_livros.Close;
  Query_livros.SQL.Clear;
  Query_livros.SQL.Add('select * from livros');
  Query_livros.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos

end;

//Excluir livro
procedure TModulo_dados.ExcluirLivro(IdPr: Integer);
begin

  Query_livros.Close;
  Query_livros.SQL.Clear;
  Query_livros.SQL.Add('delete from livros where id = :IdPr');
  Query_livros.Parameters.ParamByName('IdPr').Value := IdPr;
  Query_livros.ExecSQL;

  //Resetando para Visualização
  Query_livros.Close;
  Query_livros.SQL.Clear;
  Query_livros.SQL.add('select * from livros');
  Query_livros.Open;

end;

//Novo aluno
procedure TModulo_Dados.NovoAluno(nomePr: string; RA: string; RG: string; enderecoPr: string; telefonepr: string; cursoPr: string; categoria_id: Integer);
begin

  with Query_aluno do begin
    Close;
    SQL.Clear;
    SQL.Add('insert into alunos (nome,ra,rg,endereco,telefone,curso,id_categoria)' +
    ' values (:nomepr,:RA,:RG,:enderecoPr,:telefonePr,:cursoPr,:id_categoria)');
    Parameters.ParamByName('nomePr').Value := nomePr;
    Parameters.ParamByName('RA').Value := RA;
    Parameters.ParamByName('RG').Value := RG;
    Parameters.ParamByName('enderecoPr').Value := enderecoPr;
    Parameters.ParamByName('telefonePr').Value := telefonePr;
    Parameters.ParamByName('cursoPr').Value := cursoPr;
    Parameters.ParamByName('id_categoria').Value := categoria_id;
    ExecSQl;

    Close;
    SQL.Clear;
    SQL.Add('select * from alunos');
    Open;
  end;

end;

//Atualizar aluno
procedure TModulo_Dados.AtualizarAluno(idPr: Integer; nomePr: string; RA: string; RG: string; enderecoPr: string; telefonepr: string; cursoPr: string; categoria_id: Integer);
begin

  with Query_livros do begin

    Close;
    SQL.Clear;
    SQL.Add('UPDATE alunos SET nome = :nomePr, ra = :RA' +
    ', rg = :RG, endereco = :endereco, telefone = :telefone' +
    ', curso = :curso, id_categoria = :IDCat' +
    ' where id = :IDPr');
    Parameters.ParamByName('IDPr').Value := IDPr;
    Parameters.ParamByName('nomePr').Value := nomePr;
    Parameters.ParamByName('RA').Value := RA;
    Parameters.ParamByName('RG').Value := RG;
    Parameters.ParamByName('endereco').Value := enderecoPr;
    Parameters.ParamByName('telefone').Value := telefonePr;
    Parameters.ParamByName('curso').Value := cursoPr;
    Parameters.ParamByName('IDCat').Value := categoria_id;

    ExecSQL;

  end;

  //Resetando para Visualização
  Query_aluno.Close;
  Query_aluno.SQL.Clear;
  Query_aluno.SQL.Add('select * from alunos');
  Query_aluno.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos

end;

//Excluir aluno
procedure TModulo_dados.ExcluirAluno(idPr: Integer);
begin

  Query_aluno.Close;
  Query_aluno.SQL.Clear;
  Query_aluno.SQL.Add('delete from alunos where id = :IdPr');
  Query_aluno.Parameters.ParamByName('IdPr').Value := IdPr;
  Query_aluno.ExecSQL;

  //Resetando para Visualização
  Query_aluno.Close;
  Query_aluno.SQL.Clear;
  Query_aluno.SQL.add('select * from alunos');
  Query_aluno.Open;

end;

//Hash de senhas
function TModulo_Dados.Hash(const Input: string):string;
var
  hCryptProvider: HCRYPTPROV;
  hHash: HCRYPTHASH;
  bHash: array[0..$7f] of Byte;
  dwHashLen: DWORD;
  pbContent: PByte;
  i: Integer;
begin

  dwHashLen := 16;
  pbContent := Pointer(PChar(Input));
  Result := '';

  if CryptAcquireContext(@hCryptProvider, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT or CRYPT_MACHINE_KEYSET) then
  begin
    if CryptCreateHash(hCryptProvider, CALG_MD5, 0, 0, @hHash) then
    begin
      if CryptHashData(hHash, pbContent, Length(Input), 0) then
      begin
        if CryptGetHashParam(hHash, HP_HASHVAL, @bHash[0], @dwHashLen, 0) then
        begin
          for i := 0 to dwHashLen - 1 do
          begin
            Result := Result + Format('%.2x', [bHash[i]]);
          end;
        end;
      end;
      CryptDestroyHash(hHash);
    end;
    CryptReleaseContext(hCryptProvider, 0);
  end;
  Result := AnsiLowerCase(Result);

end;

end.
