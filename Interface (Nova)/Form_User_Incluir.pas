unit Form_User_Incluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg;

type
  Tfrm_incluiruser = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CB_user: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    txt_usuario: TLabeledEdit;
    txt_senha: TLabeledEdit;
    txt_conf: TLabeledEdit;
    lbl_id: TLabel;
    Image1: TImage;
    //funções locais
    procedure LimpaCampos();
    function ValidaCampos():boolean;
    procedure AlimentaCB();
    procedure AutoPreenchimento(NomePr : string);
    //funções locais
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CB_userChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_incluiruser: Tfrm_incluiruser;

implementation

uses Form_Dados;

{$R *.dfm}

//Novo Usuário
procedure Tfrm_incluiruser.Button1Click(Sender: TObject);
begin

  if(ValidaCampos = false) then begin
    exit;
  end else begin

    if(txt_senha.Text = txt_conf.Text) then begin
      Form_Dados.Modulo_Dados.NovoUsuario(txt_usuario.Text, Form_Dados.Modulo_Dados.Hash(txt_senha.text));
      showmessage('Cadastrado com Sucesso!');
      AlimentaCB();
      LimpaCampos();
    end else begin
      showmessage('Senha e confirmação de senha n equivalem!');
    end;

  end;

end;

procedure Tfrm_incluiruser.Button2Click(Sender: TObject);
begin

  if(ValidaCampos = false) or (lbl_id.Caption = '?') then begin
    exit;
  end else begin
    if(txt_senha.Text = txt_conf.Text) then begin
      Form_Dados.Modulo_Dados.AtualizarUsuario(lbl_id.Caption, txt_usuario.Text, Form_dados.Modulo_Dados.Hash(txt_senha.Text));
      showmessage('Atualizado com Sucesso!');
      AlimentaCB();
      LimpaCampos();
    end else begin
      showmessage('Senha e confirmação de senha n equivalem!');
    end;

  end;

end;

procedure Tfrm_incluiruser.Button3Click(Sender: TObject);
begin
  if(lbl_id.Caption = '?') then begin
    showmessage('Necessário selecionar ussuário ara Excluir!');
  end else begin
    Form_Dados.Modulo_Dados.ExcluirUsuario(lbl_id.Caption);
    showmessage('Excluido com Sucesso!');
    AlimentaCB();
    LimpaCampos();
  end;

end;

procedure Tfrm_incluiruser.Button4Click(Sender: TObject);
begin

  self.Close;

end;

procedure Tfrm_incluiruser.CB_userChange(Sender: TObject);
begin

    AutoPreenchimento(Cb_user.Text);

end;

procedure Tfrm_incluiruser.FormActivate(Sender: TObject);
begin
  Form_Dados.Modulo_Dados.Query_User.Active := true;
  Form_Dados.Modulo_Dados.Query_User.Close;
  Form_Dados.Modulo_Dados.Query_User.sql.Clear;
  Form_Dados.Modulo_Dados.Query_User.sql.Add('select * from usuarios');
  Form_Dados.Modulo_Dados.Query_User.Open;
  AlimentaCB();

end;

procedure Tfrm_incluiruser.LimpaCampos;
begin
  txt_usuario.Text := '';
  txt_senha.Text := '';
  txt_conf.Text := '';
  lbl_id.Caption := '?';
end;

function Tfrm_incluiruser.ValidaCampos;
begin

  if(txt_usuario.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_usuario.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_senha.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_senha.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_conf.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_conf.SetFocus;
    Result := false;
    Exit;
  end;

  Result := true;

end;

procedure Tfrm_incluiruser.AlimentaCB();
begin

  //para alimentar o CBProdutos
    CB_user.Items.Clear;

    while not Form_dados.Modulo_Dados.DataSource.DataSet.Eof do begin

      CB_user.Items.AddObject(Form_dados.Modulo_Dados.DataSource.DataSet.FieldByName('Nome').asString,
      TObject(Form_dados.Modulo_Dados.DataSource.DataSet.FieldByName('Nome').asString));
      Form_dados.Modulo_Dados.DataSource.DataSet.Next;

    end;

    CB_user.ItemIndex := 0;
    //Combobox Alimentada com sucesso!!

end;

procedure Tfrm_incluiruser.AutoPreenchimento(NomePr: string);
var
txt1:string;
txt2:string;
begin

  //ESSE PARTE ESTÁ EM CONSTRUÇÃO... EM HIPOTESE ALGUMA OUSE TIRAR ELA DO COMENTÁRIO
  with Form_Dados.Modulo_Dados.Query_User do begin
    Close;
    SQL.Clear;
    SQL.Add('select * from usuarios where Nome = :NomePr');
    Parameters.ParamByName('NomePr').Value := NomePr;
    Open;

    //Parameters.ParamByName('ProdutoPr').Value := ProdutoPr;

  end;

  txt1 := Form_Dados.Modulo_Dados.Query_UserNome.Value;
  txt2 := Form_Dados.Modulo_Dados.Query_UserHash.Value;


  //Váriaveis sendo depositadas nas textboxes
  txt_usuario.Text := txt1;
  lbl_id.Caption := txt1;
  //txt_senha.Text := txt2;
  //txt_conf.Text := txt2;

  //Resetando para Visualização
  Form_Dados.Modulo_Dados.Query_User.Close;
  Form_Dados.Modulo_Dados.Query_User.SQL.Clear;
  Form_Dados.Modulo_Dados.Query_User.SQL.Add('select * from usuarios');
  Form_Dados.Modulo_Dados.Query_User.Open;
  //Isso Reseta o codigo sql da query para selecionar todos os produtos

end;

end.
