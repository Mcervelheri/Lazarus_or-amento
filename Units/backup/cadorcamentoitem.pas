unit CadOrcamentoItem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls,
  StdCtrls, BucaProduto,DM,
  Buttons;

type

  { TCadOrcamentoItemF }

  TCadOrcamentoItemF = class(TForm)
    btnGravarItemOrc: TButton;
    dsOrcamentoItem: TDataSource;
    edtProdDesc: TEdit;
    edtQtdProd: TEdit;
    edtValorUn: TEdit;
    edtValorTot: TEdit;
    edtProdId: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    SpeedButton3: TSpeedButton;
    procedure btnGravarItemOrcClick(Sender: TObject);
    procedure edtQtdProdChange(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private

  public

  end;

var
  CadOrcamentoItemF: TCadOrcamentoItemF;

implementation

{$R *.lfm}

{ TCadOrcamentoItemF }

procedure TCadOrcamentoItemF.SpeedButton3Click(Sender: TObject);
begin
  BucaProdutoF := TBucaProdutoF.Create(self);
  BucaProdutoF.ShowModal;
  edtProdId.Field.AsString := DMF.qryProdutoid.AsString;
  edtProdDesc.Text:= DMF.qryProdutodescrio.AsString;
  edtValorUn.Text:= DMF.qryProdutovalor_venda.AsString;

  edtQtdProd.SetFocus;
end;

procedure TCadOrcamentoItemF.edtQtdProdChange(Sender: TObject);
begin
  edtValorTot.Text:=FloatToStr(StrToFloat(edtQtdProd.text)*StrToFloat(edtValorUn.text));
end;

procedure TCadOrcamentoItemF.btnGravarItemOrcClick(Sender: TObject);
begin
  DMF.qryOrcamentoItemqt_produto.AsString:=edtQtdProd.Text;
  DMF.qryOrcamentoItemvl_unitario.AsString:=edtValorUn.Text;
  DMF.qryOrcamentoItemvl_total.AsString:=edtValorTot.Text;

  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamento.Post;
  end;
  DMF.qryOrcamentoItem.Post;
  CadOrcamentoItemF.Close;
end;


end.
