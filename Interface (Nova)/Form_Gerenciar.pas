unit Form_Gerenciar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg;

type
  Tgerencia_acervo = class(TForm)
    Image1: TImage;
    GridLivros: TDBGrid;
    txt_livro: TLabeledEdit;
    txt_ra: TLabeledEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  gerencia_acervo: Tgerencia_acervo;

implementation

{$R *.dfm}

procedure Tgerencia_acervo.BitBtn3Click(Sender: TObject);
begin

  self.Close;

end;

end.
