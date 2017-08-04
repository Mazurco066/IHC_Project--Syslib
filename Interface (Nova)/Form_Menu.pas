unit Form_Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_menu = class(TForm)
    painel_principal: TPanel;
    menu: TMainMenu;
    Arquivo1: TMenuItem;
    NovoLivro1: TMenuItem;
    Atualizarlivro1: TMenuItem;
    ExcluirLivro1: TMenuItem;
    Usurio1: TMenuItem;
    NovoUsurio1: TMenuItem;
    AtualizarUsurio1: TMenuItem;
    ExcluirUsurio1: TMenuItem;
    Aluno1: TMenuItem;
    Novoaluno1: TMenuItem;
    AtualizarAluno1: TMenuItem;
    ExcluirAluno1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Deslogar1: TMenuItem;
    Sair2: TMenuItem;
    Painel_inferior: TPanel;
    fundo: TImage;
    Label6: TLabel;
    Image2: TImage;
    Image3: TImage;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure Sair2Click(Sender: TObject);
    procedure Deslogar1Click(Sender: TObject);
    procedure NovoUsurio1Click(Sender: TObject);
    procedure CriarForm(NomeForm:TFormClass);
    procedure Atualizarlivro1Click(Sender: TObject);
    procedure ExcluirLivro1Click(Sender: TObject);
    procedure AtualizarUsurio1Click(Sender: TObject);
    procedure ExcluirUsurio1Click(Sender: TObject);
    procedure NovoLivro1Click(Sender: TObject);
    procedure Novoaluno1Click(Sender: TObject);
    procedure AtualizarAluno1Click(Sender: TObject);
    procedure ExcluirAluno1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_menu: Tfrm_menu;

implementation

uses Form_Login, Form_User_Incluir, Form_Livro_incluir, Form_Aluno_Incluir, form_Alocar, form_devolucao, Form_Histórico, Form_Gerenciar;

{$R *.dfm}


//Trocar Usuário
procedure Tfrm_menu.Deslogar1Click(Sender: TObject);
begin
  frm_login.Visible := true;
  self.Close;
end;

procedure Tfrm_menu.ExcluirAluno1Click(Sender: TObject);
begin
    CriarForm(Form_Aluno_Incluir.Tfrm_aluno);
end;

procedure Tfrm_menu.ExcluirLivro1Click(Sender: TObject);
begin
    CriarForm(Form_Livro_Incluir.Tfrm_livros);
end;

procedure Tfrm_menu.ExcluirUsurio1Click(Sender: TObject);
begin
    CriarForm(Form_User_Incluir.Tfrm_incluiruser);
end;

procedure Tfrm_menu.Image4Click(Sender: TObject);
begin

  CriarForm(Form_Alocar.Tfrm_alocar);

end;

procedure Tfrm_menu.Image5Click(Sender: TObject);
begin
    CriarForm(Form_Devolucao.Tfrm_devolucao);
end;

procedure Tfrm_menu.Image6Click(Sender: TObject);
begin
    CriarForm(Form_Gerenciar.Tgerencia_acervo);
end;

procedure Tfrm_menu.Image7Click(Sender: TObject);
begin
    CriarForm(Form_Histórico.Thistorico_locacao);
end;

procedure Tfrm_menu.Novoaluno1Click(Sender: TObject);
begin
     CriarForm(Form_Aluno_Incluir.Tfrm_aluno);
end;

procedure Tfrm_menu.NovoLivro1Click(Sender: TObject);
begin
     CriarForm(Form_Livro_Incluir.Tfrm_livros);
end;

procedure Tfrm_menu.NovoUsurio1Click(Sender: TObject);
begin
  CriarForm(Form_User_Incluir.Tfrm_incluiruser)
end;

procedure Tfrm_menu.Sair2Click(Sender: TObject);
begin
  frm_login.Close;
end;

procedure Tfrm_menu.AtualizarAluno1Click(Sender: TObject);
begin
     CriarForm(Form_Aluno_Incluir.Tfrm_aluno);
end;

procedure Tfrm_menu.Atualizarlivro1Click(Sender: TObject);
begin
     CriarForm(Form_Livro_Incluir.Tfrm_livros);
end;

procedure Tfrm_menu.AtualizarUsurio1Click(Sender: TObject);
begin
    CriarForm(Form_User_Incluir.Tfrm_incluiruser);
end;

procedure Tfrm_menu.BitBtn1Click(Sender: TObject);
begin

  CriarForm(Form_Alocar.Tfrm_alocar);

end;

procedure Tfrm_menu.BitBtn2Click(Sender: TObject);
begin

  //CriarForm(Form_Devolucao.frm_devolucao);

end;

procedure Tfrm_menu.CriarForm(NomeForm: TFormClass);
begin
  //Procedimento para criar formulario na memória e deixa-lo visivel
  //OBS PARA CHAMAR ESSA SUB (CriarForm(nomearquivo.Tnomedaform);)
  with NomeForm do begin

    Try begin

      TForm(NomeForm):=NomeForm.Create(Application);
      TForm(NomeForm).Showmodal;

    end;

    Finally

      FreeAndNil(NomeForm);

    End;

  end;
end;

end.
