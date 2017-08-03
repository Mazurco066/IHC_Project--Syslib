unit Form_Alocar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg;

type
  Tfrm_alocar = class(TForm)
    Panel1: TPanel;
    GridLivros: TDBGrid;
    txt_livro: TLabeledEdit;
    txt_ra: TLabeledEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure txt_livroChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_alocar: Tfrm_alocar;

implementation

uses Form_Dados;

{$R *.dfm}

procedure Tfrm_alocar.BitBtn1Click(Sender: TObject);
var parametro:integer;
begin

  parametro := strtoint(txt_livro.Text);

  Form_dados.Modulo_Dados.Query_livros.Close;
  Form_dados.Modulo_Dados.Query_livros.sql.Clear;
  Form_dados.Modulo_Dados.Query_livros.sql.Add('select * from livros where id = :parametro');
  Form_dados.Modulo_Dados.Query_livros.Parameters.ParamByName('parametro').Value := parametro;
  Form_dados.Modulo_Dados.Query_livros.Open;

  //Form_dados.Modulo_Dados.DataSourceLiv

  GridLivros.Update;
  GridLivros.Refresh;

end;

procedure Tfrm_alocar.BitBtn3Click(Sender: TObject);
begin

  self.Close;

end;

procedure Tfrm_alocar.txt_livroChange(Sender: TObject);
begin

  Form_dados.Modulo_Dados.Query_livros.Active := true;
  Form_dados.Modulo_Dados.Query_livros.Close;
  Form_dados.Modulo_Dados.Query_livros.SQL.Clear;
  Form_dados.Modulo_Dados.Query_livros.SQL.Add('select * from livros');
  Form_dados.Modulo_Dados.Query_livros.Open;

end;

end.
