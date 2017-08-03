unit Form_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  Tfrm_login = class(TForm)
    txt_user: TLabeledEdit;
    txt_senha: TLabeledEdit;
    Image1: TImage;
    btn_logar: TButton;
    btn_sair: TButton;
    Image2: TImage;
    //Procedimentos e Funções Locais
    function ValidaCampos():boolean;
    function Hash(const Input: String):string;
    procedure CriarForm(NomeForm:Tformclass);
    procedure login(userPr : string; hashPr : string);
    procedure LimpaCampos();
    //Procedimentos e Funções Locais
    procedure btn_sairClick(Sender: TObject);
    procedure btn_logarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_login: Tfrm_login;

implementation

uses Form_Dados, Wcrypt2, Form_Menu, Form_Livro_Incluir;

{$R *.dfm}

//Logar
procedure Tfrm_login.btn_logarClick(Sender: TObject);
begin

  if(ValidaCampos = false) then begin
    exit;
  end else begin
    //showmessage(Hash(txt_senha.Text));
    login(txt_user.Text, hash(txt_senha.Text));
  end;

end;

//Sair
procedure Tfrm_login.btn_sairClick(Sender: TObject);
begin

  self.Close;

end;

//Valida Campos
function Tfrm_login.ValidaCampos():boolean;
begin

  if(txt_user.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_user.SetFocus;
    Result := false;
    Exit;
  end;

  if(txt_senha.Text = '') then begin
    ShowMessage('Campos devem ser preenchidos!');
    txt_senha.SetFocus;
    Result := false;
    Exit;
  end;

  Result := true;

end;

//Gerador de Hash
function Tfrm_login.Hash(const Input: string):string;
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

//Criar Form na Memória
procedure Tfrm_login.CriarForm(NomeForm: TFormClass);
begin

  //Procedimento para criar formulario na memória
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

//Logar no Sistema
procedure Tfrm_login.login(userPr: string; hashPr: string);
var user :string;
    pass :string;
begin

  user := userPr;
  pass := hashPr;

  with Form_Dados.Modulo_Dados.Query_User do begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Usuarios where Nome = :user and Hash = :pass');
    Parameters.ParamByName('user').Value := user;
    Parameters.ParamByName('pass').Value := pass;
    Open;
  end;

  if (Form_Dados.Modulo_Dados.Query_User.Eof) then begin

    showmessage('Usuário ou Senha Incompátiveis!');
    LimpaCampos();
    txt_user.SetFocus;
    exit;

  end;

  if (userPr = Form_Dados.Modulo_Dados.Query_UserNome.Value) and (hashPr = Form_Dados.Modulo_Dados.Query_Userhash.Value)then begin

    showmessage('Logado com Sucesso!');
    LimpaCampos();
    self.Hide;
    CriarForm(Form_Menu.Tfrm_menu);

  end;

  Form_Dados.Modulo_Dados.Query_User.Close;

end;

//limpar campos
procedure Tfrm_login.LimpaCampos;
begin
  txt_user.Text := '';
  txt_senha.Text := '';
end;

end.
