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
    btnRemoverItem: TButton;
    DBText1: TDBText;
    edtDataOrc: TDBDateEdit;
    edtDataVal: TDBDateEdit;
    edtValorTotalOrc: TDBEdit;
    edtCliente: TDBEdit;
    dsOrcamentoItem: TDataSource;
    DBGrid2: TDBGrid;
    edtOrcId: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  AbreOrcItens(DMF.qryOrcamentoorcamentoid.AsInteger);
end;

procedure TOrcamentoF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TOrcamentoF.btnRemoverItemClick(Sender: TObject);
begin
  if DMF.qryOrcamento.state in [dsInsert, dsEdit] then
  begin
    DMF.qryOrcamentoItem.Delete;
  end
  else
  begin
    DMF.qryOrcamento.edit;
    DMF.qryOrcamentoItem.Delete;
  end;
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


procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TOrcamentoF.FormCreate(Sender: TObject);
begin
  inherited;
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
  edtCliente.Text := BuscaClienteF.Label2.Caption;
  btnAdicionarItem.Enabled:=True;
end;


end.
