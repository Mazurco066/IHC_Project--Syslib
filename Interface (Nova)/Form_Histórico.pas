unit Form_Histórico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg;

type
  Thistorico_locacao = class(TForm)
    Image1: TImage;
    GridLivros: TDBGrid;
    txt_livro: TLabeledEdit;
    txt_ra: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  historico_locacao: Thistorico_locacao;

implementation

{$R *.dfm}

procedure Thistorico_locacao.BitBtn3Click(Sender: TObject);
begin

  self.Close;

end;

end.
