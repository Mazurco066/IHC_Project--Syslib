unit Form_Devolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_devolucao = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    txt_livro: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GridLivros: TDBGrid;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_devolucao: Tfrm_devolucao;

implementation

{$R *.dfm}

procedure Tfrm_devolucao.Button2Click(Sender: TObject);
begin

  ShowMessage('Devolu��o feita com sucesso!');

end;

procedure Tfrm_devolucao.Button3Click(Sender: TObject);
begin

  Self.Close;

end;

end.
