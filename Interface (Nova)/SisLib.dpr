program SisLib;

uses
  Vcl.Forms,
  Form_Login in 'Form_Login.pas' {frm_login},
  Form_Dados in 'Form_Dados.pas' {Modulo_Dados: TDataModule},
  Form_Menu in 'Form_Menu.pas' {frm_menu},
  Form_User_Incluir in 'Form_User_Incluir.pas' {frm_incluiruser},
  Form_Livro_Incluir in 'Form_Livro_Incluir.pas' {frm_livros},
  Form_Aluno_Incluir in 'Form_Aluno_Incluir.pas' {frm_aluno},
  Form_Categorias in 'Form_Categorias.pas' {frm_categorias},
  Form_Alocar in 'Form_Alocar.pas' {frm_alocar},
  Form_Devolucao in 'Form_Devolucao.pas' {frm_devolucao},
  Form_Gerenciar in 'Form_Gerenciar.pas' {gerencia_acervo},
  Form_Histórico in 'Form_Histórico.pas' {historico_locacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_login, frm_login);
  Application.CreateForm(TModulo_Dados, Modulo_Dados);
  Application.CreateForm(TModulo_Dados, Modulo_Dados);
  Application.CreateForm(Tfrm_devolucao, frm_devolucao);
  Application.CreateForm(Tgerencia_acervo, gerencia_acervo);
  Application.CreateForm(Thistorico_locacao, historico_locacao);
  Application.Run;
end.
