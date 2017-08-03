unit Form_Livro_Incluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg;

type
  Tfrm_livros = class(TForm)
    Panel1: TPanel;
    CB_livro: TComboBox;
    Label1: TLabel;
    txt_livro: TLabeledEdit;
    txt_autor: TLabeledEdit;
    txt_editora: TLabeledEdit;
    Label2: TLabel;
    lbl_id: TLabel;
    txt_edicao: TLabeledEdit;
    txt_setor: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CB_Categoria: TComboBox;
    Label3: TLabel;
    txt_exemplar: TLabeledEdit;
    txt_quantidade: TLabeledEdit;
    Image1: TImage;
    //Fu���es Locais
    function ValidaCampos():boolean;
    procedure LimpaCampos();
    procedure AlimentaCAT();
    procedure AlimentaLIVRO();
    procedure AutoPreenchimento(nomePr:string);
    //Fun��es Locais
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CB_livroChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_livros: Tfrm_livros;

implementation

uses Form_Categorias, Form_Login, Form_Dados;

{$R *.dfm}

procedure Tfrm_livros.Button1Click(Sender: TObject);
var
  id_cat : integer;
  Par : string;
begin

  if(ValidaCampos = false) then begin
    exit;
  end else begin

    Par := CB_categoria.Text;

    //para busscar o id da categoria selecionada
    with Form_dados.Modulo_Dados do begin

      Query_Cat.Active := true;
      Query_Cat.Close;
      Query_Cat.SQL.Clear;
      Query_Cat.SQL.add('select * from categorias where descricao = :Par');
      Query_Cat.Parameters.ParamByName('Par').Value := Par;
      Query_Cat.Open;

      id_cat := Query_Catid.Value;
      //showmessage(inttostr(id_cat));

      Query_Cat.Close;
      Query_Cat.SQL.Clear;
      Query_Cat.SQL.add('select * from categorias');
      Query_Cat.Open;

    end;

    Form_Dados.Modulo_Dados.Novolivro(txt_livro.Text, txt_autor.Text, txt_edicao.Text, txt_editora.Text, txt_setor.Text, strtoint(txt_exemplar.Text), strtoint(txt_quantidade.Text), id_cat);
    showmessage('Cadastrado com Sucesso!');
    AlimentaCAT();
    AlimentaLIVRO();
    LimpaCampos();
  end;

end;

procedure Tfrm_livros.Button2Click(Sender: TObject);
var Par:string;
    id_cat : integer;
begin

  if(ValidaCampos = false) or (lbl_id.Caption = '?') then begin
    exit;
  end else begin

    Par := CB_categoria.Text;

    //para busscar o id da categoria selecionada
    with Form_dados.Modulo_Dados do begin

      Query_Cat.Active := true;
      Query_Cat.Close;
      Query_Cat.SQL.Clear;
      Query_Cat.SQL.add('select * from categorias where descricao = :Par');
      Query_Cat.Parameters.ParamByName('Par').Value := Par;
      Query_Cat.Open;

      id_cat := Query_Catid.Value;
      //showmessage(inttostr(id_cat));

      Query_Cat.Close;
      Query_Cat.SQL.Clear;
      Query_Cat.SQL.add('select * from categorias');
      Query_Cat.Open;

    end;

    Form_Dados.Modulo_Dados.AtualizarLivro(strtoint(lbl_id.Caption),txt_livro.Text, txt_autor.Text, txt_edicao.Text, txt_editora.Text, txt_setor.Text, strtoint(txt_exemplar.Text), strtoint(txt_quantidade.Text), id_cat);
    showmessage('Atualizado com Sucesso!');
    AlimentaCAT();
    AlimentaLIVRO();
    LimpaCampos();

  end;

end;

procedure Tfrm_livros.Button3Click(Sender: TObject);
begin

  if(lbl_id.Caption = '?') then begin
    showmessage('Especifique a qual livro excluir!');
    exit;
  end else begin
    Form_Dados.Modulo_Dados.ExcluirLivro(strtoint(lbl_id.Caption));
    showmessage('Excluido com Sucesso!');
    AlimentaLIVRO();
    LimpaCampos();

  end;

end;

procedure Tfrm_livros.Button4Click(Sender: TObject);
begin

    Self.Close;

end;

procedure Tfrm_livros.Button5Click(Sender: TObject);
begin
   Form_Login.frm_login.CriarForm(Form_Categorias.Tfrm_categorias);
end;

procedure Tfrm_livros.CB_livroChange(Sender: TObject);
begin

  AutoPreenchimento(Cb_livro.Text);

end;

procedure Tfrm_livros.FormActivate(Sender: TObject);
begin

  Form_Dados.Modulo_Dados.Query_cat.Active := true;
  Form_Dados.Modulo_Dados.Query_cat.Close;
  Form_Dados.Modulo_Dados.Query_cat.sql.Clear;
  Form_Dados.Modulo_Dados.Query_cat.sql.Add('select * from categorias');
  Form_Dados.Modulo_Dados.Query_cat.Open;
  AlimentaCAT();

  Form_Dados.Modulo_Dados.Query_livros.Active := true;
  Form_Dados.Modulo_Dados.Query_livros.Close;
  Form_Dados.Modulo_Dados.Query_livros.sql.Clear;
  Form_Dados.Modulo_Dados.Query_livros.sql.Add('select * from livros');
  Form_Dados.Modulo_Dados.Query_livros.Open;
  AlimentaLIVRO();

end;

function Tfrm_livros.ValidaCampos;
begin

  if(txt_livro.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_livro.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_edicao.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_edicao.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_editora.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_editora.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_autor.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_autor.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_setor.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_setor.SetFocus;
    Result := false;
    Exit;
  end;

  Result := true;

end;

procedure Tfrm_livros.LimpaCampos;
begin
  txt_livro.Text := '';
  txt_edicao.Text := '';
  txt_autor.Text := '';
  txt_editora.Text := '';
  txt_setor.Text := '';
  txt_quantidade.Text := '';
  txt_exemplar.Text := '';
  lbl_id.Caption := '?';
end;

procedure Tfrm_livros.AlimentaCAT();
begin

  //para alimentar o CBProdutos
    CB_categoria.Items.Clear;

    while not Form_dados.Modulo_Dados.DataSourceCat.DataSet.Eof do begin

      CB_categoria.Items.AddObject(Form_dados.Modulo_Dados.DataSourceCat.DataSet.FieldByName('descricao').asString,
      TObject(Form_dados.Modulo_Dados.DataSourceCat.DataSet.FieldByName('descricao').asString));
      Form_dados.Modulo_Dados.DataSourceCat.DataSet.Next;

    end;

    CB_categoria.ItemIndex := 0;
    //Combobox Alimentada com sucesso!!

end;

procedure Tfrm_livros.AlimentaLIVRO();
begin

    //para alimentar o CBProdutos
    CB_livro.Items.Clear;

    while not Form_dados.Modulo_Dados.DataSourceLiv.DataSet.Eof do begin

      CB_livro.Items.AddObject(Form_dados.Modulo_Dados.DataSourceLiv.DataSet.FieldByName('nome').asString,
      TObject(Form_dados.Modulo_Dados.DataSourceLiv.DataSet.FieldByName('nome').asString));
      Form_dados.Modulo_Dados.DataSourceLiv.DataSet.Next;

    end;

    CB_livro.ItemIndex := 0;
    //Combobox Alimentada com sucesso!!

end;

procedure Tfrm_livros.AutoPreenchimento(nomePr: string);
var txt1:string;
    txt2:integer;
    txt3:integer;
    txt4:integer;
    txt5:string;
    txt6:string;
    txt7:string;
    txt8:integer;
    txt9:string;
begin

  //ESSE PARTE EST� EM CONSTRU��O... EM HIPOTESE ALGUMA OUSE TIRAR ELA DO COMENT�RIO
  with Form_Dados.Modulo_Dados.Query_livros do begin
    Close;
    SQL.Clear;
    SQL.Add('select * from livros where nome = :nomePr');
    Parameters.ParamByName('nomePr').Value := nomePr;
    Open;

  end;

  txt1 := Form_Dados.Modulo_Dados.Query_livrosnome.Value;
  txt2 := Form_Dados.Modulo_Dados.Query_livrosid.Value;
  txt3 := Form_Dados.Modulo_Dados.Query_livrosexemplares.Value;
  txt4 := Form_Dados.Modulo_Dados.Query_livrosquantidade.Value;
  txt5 := Form_Dados.Modulo_Dados.Query_livrosautor.Value;
  txt6 := Form_Dados.Modulo_Dados.Query_livrosedicao.Value;
  txt7 := Form_Dados.Modulo_Dados.Query_livroseditora.Value;
  txt8 := Form_Dados.Modulo_Dados.Query_livroscategoria_id.Value;
  txt9 := Form_Dados.Modulo_Dados.Query_livrossessao.Value;


  //V�riaveis sendo depositadas nas textboxes
  txt_livro.Text := txt1;
  txt_exemplar.Text := inttostr(txt3);
  txt_quantidade.Text := inttostr(txt4);
  lbl_id.Caption := inttostr(txt2);
  txt_autor.Text := txt5;
  txt_edicao.Text := txt6;
  txt_editora.text := txt7;
  txt_setor.Text := txt9;

  //Resetando para Visualiza��o
  Form_Dados.Modulo_Dados.Query_livros.Close;
  Form_Dados.Modulo_Dados.Query_livros.SQL.Clear;
  Form_Dados.Modulo_Dados.Query_livros.SQL.Add('select * from livros');
  Form_Dados.Modulo_Dados.Query_livros.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos

end;

end.
