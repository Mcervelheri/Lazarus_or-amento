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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
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
  frReport1.LoadFromFile('Relatórios\RelProdutos.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

procedure TRelProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TRelProdutosF.FormShow(Sender: TObject);
begin
   frReport1.LoadFromFile('Relatórios\RelProdutos.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
  close;
end;

end.
