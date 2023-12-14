unit CadOrcamentoItem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls,
  StdCtrls, BucaProduto, DM,
  Buttons, MaskEdit, ExtCtrls;

type

  { TCadOrcamentoItemF }

  TCadOrcamentoItemF = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dbEdtProdDesc: TDBEdit;
    dbEdtQtdProd: TDBEdit;
    dbEdtValorUn: TDBEdit;
    dbEdtValorTot: TDBEdit;
    dsOrcamentoItem: TDataSource;
    edtProdId: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    btnBuscarProd: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarItemOrcClick(Sender: TObject);
    procedure dbEdtQtdProdChange(Sender: TObject);
    procedure dbEdtQtdProdEditingDone(Sender: TObject);
    procedure dbEdtQtdProdExit(Sender: TObject);
    procedure edtQtdProdChange(Sender: TObject);
    procedure btnGravarItemOrcamentoClick(Sender: TObject);
    procedure btnBuscarProdClick(Sender: TObject);
  private

  public

  end;

var
  CadOrcamentoItemF: TCadOrcamentoItemF;

implementation

{$R *.lfm}

{ TCadOrcamentoItemF }

procedure TCadOrcamentoItemF.btnBuscarProdClick(Sender: TObject);
begin
  BuscaProdutoF := TBuscaProdutoF.Create(self);
  BuscaProdutoF.ShowModal;
  edtProdId.Field.AsString := DMF.qryProdutoid.AsString;
  dbEdtValorUn.Field.Value:=StrToFloat(BuscaProdutoF.lblValorProd.Caption);
  DMF.qryCliente.Open;
  dbEdtQtdProd.SetFocus;
end;

procedure TCadOrcamentoItemF.edtQtdProdChange(Sender: TObject);
begin

end;

procedure TCadOrcamentoItemF.btnGravarItemOrcamentoClick(Sender: TObject);
begin
    DMF.qryOrcamentoItemqt_produto.AsFloat := dbEdtQtdProd.Field.AsFloat;
  DMF.qryOrcamentoItemvl_unitario.AsFloat := dbEdtValorUn.Field.AsFloat;
  DMF.qryOrcamentoItemvl_total.AsFloat := dbEdtValorTot.Field.AsFloat;

  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamento.Post;
  end;
  DMF.qryOrcamentoItem.Post;
  CadOrcamentoItemF.Close;
end;

procedure TCadOrcamentoItemF.btnGravarItemOrcClick(Sender: TObject);
begin

end;

procedure TCadOrcamentoItemF.btnCancelarClick(Sender: TObject);
begin

end;

procedure TCadOrcamentoItemF.BitBtn1Click(Sender: TObject);
begin
    DMF.qryOrcamentoItemqt_produto.AsFloat := dbEdtQtdProd.Field.AsFloat;
  DMF.qryOrcamentoItemvl_unitario.AsFloat := dbEdtValorUn.Field.AsFloat;
  DMF.qryOrcamentoItemvl_total.AsFloat := dbEdtValorTot.Field.AsFloat;

  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamento.Post;
  end;
  DMF.qryOrcamentoItem.Post;
  CadOrcamentoItemF.Close;
end;

procedure TCadOrcamentoItemF.BitBtn2Click(Sender: TObject);
begin
  DMF.qryOrcamentoItem.Cancel;
  close;
end;

procedure TCadOrcamentoItemF.dbEdtQtdProdChange(Sender: TObject);
begin

end;


procedure TCadOrcamentoItemF.dbEdtQtdProdEditingDone(Sender: TObject);
begin

end;

procedure TCadOrcamentoItemF.dbEdtQtdProdExit(Sender: TObject);
begin
  dbEdtValorTot.Field.AsFloat:=dbEdtQtdProd.Field.AsFloat * dbEdtValorUn.Field.AsFloat;

end;


end.
