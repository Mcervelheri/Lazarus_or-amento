unit Orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DBCtrls, Buttons, DBExtCtrls, ComCtrls, ExtCtrls, DateTimePicker, CadModelo,
  DB, CadOrcamentoItem, BuscaCliente, BucaProduto, DM;

type

  { TOrcamentoF }

  TOrcamentoF = class(TCadModeloF)
    btnAdicionarItem: TButton;
    btnCancelar1: TSpeedButton;
    btnEditar1: TSpeedButton;
    btnExcluir1: TSpeedButton;
    btnRemoverItem: TButton;
    btnSalvar1: TSpeedButton;
    edtDataOrc: TDBDateEdit;
    edtDataVal: TDBDateEdit;
    edtOrcItemId: TDBEdit;
    edtProdId: TDBEdit;
    edtProdDesc: TDBEdit;
    edtQtdProd: TDBEdit;
    edtValorTotalOrc: TDBEdit;
    edtValorUn: TDBEdit;
    edtValorTot: TDBEdit;
    edtCliente1: TDBEdit;
    edtOrcId1: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblDescrCli: TDBText;
    edtCliente: TDBEdit;
    dsOrcamentoItem: TDataSource;
    DBGrid2: TDBGrid;
    edtOrcId: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    tsItem: TTabSheet;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtValorUnChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure AbreOrcItens(orcamentoid: integer);
    function calcValorOrc(): string;
  private

  public

  end;

var
  OrcamentoF: TOrcamentoF;
  OrcId: string;

implementation

{$R *.lfm}

{ TOrcamentoF }

function TOrcamentoF.calcValorOrc(): string;
var
  xSoma: string;
begin
  DMF.qryGenerica.Close;
  DMF.qryGenerica.SQL.Clear;
  DMF.qryGenerica.SQL.Add('SELECT SUM(vl_total) as total_soma ' +
    'FROM orcamento_item ' + 'WHERE ORCAMENTOID = ' +
    IntToStr(DMF.qryOrcamentoorcamentoid.AsInteger));
  DMF.qryGenerica.Open;
  xSoma := DMF.qryGenerica.FieldByName('total_soma').AsString;
  if xSoma = '' then
  begin
    Result := IntToStr(1);
  end
  else
  begin
    Result := xSoma;
  end;

end;

procedure TOrcamentoF.AbreOrcItens(orcamentoid: integer);
begin
  if orcamentoid <> 0 then
  begin
    DMF.qryOrcamentoItem.Close;
    DMF.qryOrcamentoItem.SQL.Clear;
    DMF.qryOrcamentoItem.SQL.Add(
      'SELECT ' + 'ORCAMENTOITEMID, ' + 'ORCAMENTOID, ' + 'PRODUTOID, ' +
      'QT_PRODUTO, ' + 'VL_UNITARIO, ' + 'VL_TOTAL ' + 'FROM ORCAMENTO_ITEM ' +
      'WHERE ORCAMENTOID = ' + IntToStr(orcamentoid) + ' ' + 'ORDER BY ORCAMENTOID');
    DMF.qryOrcamentoItem.Open;
  end;
end;

procedure TOrcamentoF.btnAdicionarClick(Sender: TObject);
begin
  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    dsModelo.DataSet.Post;
    dsModelo.DataSet.Insert;
    AbreOrcItens(DMF.qryOrcamentoorcamentoid.AsInteger);
  end
  else
  begin
    dsModelo.DataSet.Insert;
    AbreOrcItens(DMF.qryOrcamentoorcamentoid.AsInteger);
  end;
  PageControl1.ActivePage := tsCadastrar;

end;

procedure TOrcamentoF.btnAdicionarItemClick(Sender: TObject);
var
  xID: string;
begin
  if DMF.qryOrcamentoItem.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamentoItem.post;
    DMF.qryOrcamentoItem.insert;
  end
  else
  begin
    DMF.qryOrcamentoItem.Insert;
  end;
  //Busca o ultimo código do orçamento atual
  DMF.qryGenerica.Close;
  DMF.qryGenerica.SQL.Clear;
  DMF.qryGenerica.SQL.Add('SELECT MAX(orcamentoitemid) + 1 PROXCODIGO ' +
    'FROM orcamento_item ' + 'WHERE ORCAMENTOID = ' +
    IntToStr(DMF.qryOrcamentoorcamentoid.AsInteger));
  DMF.qryGenerica.Open;

  xID := DMF.qryGenerica.FieldByName('PROXCODIGO').AsString;
  if xID = '' then
    DMF.qryOrcamentoItemorcamentoitemid.AsInteger := 1
  else
    DMF.qryOrcamentoItemorcamentoitemid.AsInteger := StrToInt(xID);
  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin

    DMF.qryOrcamentovl_total_orcamento.AsString := calcValorOrc();
  end
  else
  begin
    DMF.qryOrcamento.Edit;
  end;
  //Passando o código do orçamentoid
  DMF.qryOrcamentoItemorcamentoid.AsInteger :=
    DMF.qryOrcamentoorcamentoid.AsInteger;
  edtDataOrc.Date := Date;
  edtDataVal.Date := Date + 15;

  //abre a tela de que permita fazer a busca do produto
  CadOrcamentoItemF := TCadOrcamentoItemF.Create(Self);
  CadOrcamentoItemF.ShowModal;

  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamentovl_total_orcamento.AsString := calcValorOrc();
  end
  else
  begin
    DMF.qryOrcamento.Edit;
    DMF.qryOrcamentovl_total_orcamento.AsString := calcValorOrc();
    DMF.qryOrcamento.Post;
  end;
  btnRemoverItem.Enabled:=True;
end;

procedure TOrcamentoF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryOrcamento.Cancel;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TOrcamentoF.btnEditarClick(Sender: TObject);
begin
  DMF.qryOrcamento.edit;
end;

procedure TOrcamentoF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryOrcamento.Delete;
  end;
end;

procedure TOrcamentoF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TOrcamentoF.btnRemoverItemClick(Sender: TObject);
begin
  DMF.qryOrcamentoItem.Delete;
  DMF.qryOrcamentovl_total_orcamento.AsString := calcValorOrc();
end;

procedure TOrcamentoF.btnSalvarClick(Sender: TObject);
begin
  if DMF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamento.post;
  end;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  AbreOrcItens(DMF.qryOrcamentoorcamentoid.AsInteger);
  DMF.qryOrcamento.Edit;
  DMF.qryOrcamentoItem.Edit;
  btnAdicionarItem.Enabled:=True;
  btnRemoverItem.Enabled:=True;
  PageControl1.ActivePage := tsCadastrar;
end;

procedure TOrcamentoF.edtValorUnChange(Sender: TObject);
begin
  if DMF.qryOrcamentoItem.State in [dsInsert, dsEdit] then
  begin
    if (edtQtdProd.Text <> '') and (edtValorUn.Text <> '') then
  begin
    edtValorTot.Field.AsString :=
      FloatToStr(StrToFloat(edtQtdProd.Text) * StrToFloat(edtValorUn.Text));
  end
    else
    begin
      DMF.qryOrcamentoItem.Edit;
      if (edtQtdProd.Text <> '') and (edtValorUn.Text <> '') then
  begin
    edtValorTot.Field.AsString :=
      FloatToStr(StrToFloat(edtQtdProd.Text) * StrToFloat(edtValorUn.Text));
  end;
    end;
  end;
end;

procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TOrcamentoF.FormShow(Sender: TObject);
begin
  DMF.qryOrcamento.Open;
  DMF.qryOrcamentoItem.Open;
  PageControl1.ActivePage := tsConsulta;
end;


procedure TOrcamentoF.SpeedButton1Click(Sender: TObject);
begin
  BuscaClienteF := TBuscaClienteF.Create(self);
  BuscaClienteF.ShowModal;
  DMF.qryOrcamentodt_orcamento.AsString := edtDataOrc.Field.AsString;
  DMF.qryOrcamentoclienteid.AsString:=edtCliente.Field.AsString;

  btnAdicionarItem.Enabled:=True;
end;


end.
