unit RelProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet;

type

  { TRelProdutosF }

  TRelProdutosF = class(TForm)
    btnGerarRel: TBitBtn;
    frDBdsProduto: TfrDBDataSet;
    frReport1: TfrReport;
    procedure btnGerarRelClick(Sender: TObject);
  private

  public

  end;

var
  RelProdutosF: TRelProdutosF;

implementation

{$R *.lfm}

{ TRelProdutosF }

procedure TRelProdutosF.btnGerarRelClick(Sender: TObject);
begin
  frReport1.LoadFromFile('\Relatórios\RelProdutos.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

end.
