unit CadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, CadModelo, DB, Grids,
  DBGrids, Buttons, StdCtrls, DBCtrls, ExtCtrls, Menus, DateTimePicker,
  DBDateTimePicker, DM;

type

  { TCadProdutoF }

  TCadProdutoF = class(TCadModeloF)
    btnLimparData: TBitBtn;
    btnFechar1: TSpeedButton;
    btnPesqData: TButton;
    cbStatus: TDBComboBox;
    lcbCategoria: TDBLookupComboBox;
    dsCategoria: TDataSource;
    dtCadastro: TDBDateTimePicker;
    dtInicio: TDateTimePicker;
    dtFim: TDateTimePicker;
    edtDesc: TDBEdit;
    edtPesquisarValor: TEdit;
    edtValor: TDBEdit;
    edtObs: TDBEdit;
    edtPesquisarDesc: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    rgPesquisaValorVenda: TRadioGroup;
    rgPesquisarStatus: TRadioGroup;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    sbLimparTudo: TSpeedButton;
    txtID: TDBText;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFechar1Click(Sender: TObject);
    procedure btnLimparDataClick(Sender: TObject);
    procedure btnPesqDataClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure sbLimparTudoClick(Sender: TObject);

  private

  public
    function pesqPorDesc(): string;
    function pesqPorId(): string;
    function pesqPorStatus(): string;
    function pesqPorValor(): string;
    function pesqPorData(): string;
  end;

var
  CadProdutoF: TCadProdutoF;
  pesqID, pesqDesc, pesqStatus, pesqValor, pesqData: boolean;
  condicao: string;


implementation

{$R *.lfm}

{ TCadProdutoF }


procedure TCadProdutoF.btnFechar1Click(Sender: TObject);
begin
  Close;
end;


procedure TCadProdutoF.btnLimparDataClick(Sender: TObject);
begin
  dtFim.Date := Date;
  dtInicio.Date := dtInicio.MinDate;
  btnPesqData.Visible := True;
  Label7.Visible := False;
  Label8.Visible := False;
  dtInicio.Visible := False;
  dtFim.Visible := False;
  btnLimparData.Visible := False;
  pesqData := False;
end;

procedure TCadProdutoF.btnPesqDataClick(Sender: TObject);
begin
  btnPesqData.Visible := False;
  Label7.Visible := True;
  Label8.Visible := True;
  dtInicio.Visible := True;
  dtFim.Visible := True;
  btnLimparData.Visible := True;
  pesqData := True;

end;

function TCadProdutoF.pesqPorId(): string;
begin
  Result := 'produtoid = ' + edtPesquisarID.Text;
end;

function TCadProdutoF.pesqPorDesc(): string;
begin
  Result := 'ds_produto like ' + QuotedStr('%' +
    UpperCase(edtPesquisarDesc.Text) + '%');
end;

function TCadProdutoF.pesqPorStatus(): string;
begin
  Result := 'status_produto = ' + QuotedStr(
    rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]);
end;

function TCadProdutoF.pesqPorValor(): string;
var
  operador: string;
begin
  if rgPesquisaValorVenda.ItemIndex = 0 then
  begin
    operador := '>';
  end
  else if rgPesquisaValorVenda.ItemIndex = 1 then
  begin
    operador := '<';
  end
  else if rgPesquisaValorVenda.ItemIndex = 2 then
  begin
    operador := '=';
  end;
  Result := 'vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text;
end;

function TCadProdutoF.pesqPorData(): string;
begin
  Result := 'dt_cadastro_produto between ' + QuotedStr(
    DateToStr(dtInicio.Date)) + ' and ' + QuotedStr(DateToStr(dtFim.Date));
end;

procedure TCadProdutoF.btnPesquisaClick(Sender: TObject);
var
  select: string;
begin

  DMF.qryProduto.Close;
  select := 'select ' + 'produtoid as id, ' + 'categoriaprodutoid as categoria, ' +
    'ds_produto as descricao, ' + 'obs_produto as observacao, ' +
    'vl_venda_produto as valor_venda, ' + 'dt_cadastro_produto as data_cadastro, ' +
    'status_produto as status ' + 'from produto ';
  if edtPesquisarID.Text <> '' then
  begin
    pesqID := True;
  end;
  if edtPesquisarDesc.Text <> '' then
  begin
    pesqDesc := True;
  end;
  if rgPesquisarStatus.ItemIndex <> -1 then
  begin
    pesqStatus := True;
  end;
  if rgPesquisaValorVenda.ItemIndex <> -1 then
  begin
    pesqValor := True;
  end;
  if pesqId then
  begin
    select := select + pesqPorId();
  end;
  if pesqDesc and pesqStatus and pesqValor and pesqData then
  begin
    select := select + ' where ' + pesqPorDesc() + ' and ' + pesqPorStatus() +
      ' and ' + pesqPorValor() + ' and ' + pesqPorData() + ' order by ds_produto desc';
  end
  else if pesqDesc and pesqStatus and pesqValor then
  begin
    select := select + ' where ' + pesqPorDesc() + ' and ' + pesqPorStatus() +
      ' and ' + pesqPorValor() + ' order by ds_produto desc';
  end
  else if pesqDesc and pesqValor and pesqData then
  begin
    select := select + ' where ' + pesqPorDesc() + ' and ' +
      pesqPorValor() + ' and ' + pesqPorData() + ' order by ds_produto desc';
  end
  else if pesqDesc and pesqData then
  begin
    select := select + ' where ' + pesqPorDesc() + ' and ' + pesqPorData() +
      ' order by ds_produto desc';
  end
  else if pesqDesc and pesqStatus then
  begin
    select := select + ' where ' + pesqPorDesc() + ' and ' + pesqPorStatus() +
      ' order by ds_produto desc';
  end
  else if pesqDesc then
  begin
    select := select + ' where ' + pesqPorDesc() + ' order by ds_produto desc';
  end
  else if pesqStatus and pesqValor and pesqData then
  begin
    select := select + ' where ' + pesqPorStatus() + ' and ' +
      pesqPorValor() + ' and ' + pesqPorData() + ' order by ds_produto desc';
  end
  else if pesqStatus and pesqData then
  begin
    select := select + ' where ' + pesqPorStatus() + ' and ' +
      pesqPorData() + ' order by ds_produto desc';
  end
  else if pesqStatus and pesqValor then
  begin
    select := select + ' where ' + pesqPorStatus() + ' and ' +
      pesqPorValor() + ' order by ds_produto desc';
  end
  else if pesqStatus then
  begin
    select := select + ' where ' + pesqPorStatus() + ' order by ds_produto desc';
  end
  else if pesqValor and pesqData then
  begin
    select := select + ' where ' + pesqPorValor() + ' and ' +
      pesqPorData() + ' order by ds_produto desc';
  end
  else if pesqValor then
  begin
    select := select + ' where ' + pesqPorValor() + ' order by ds_produto desc';
  end
  else if pesqData then
  begin
    select := select + ' where ' + pesqPorData() + ' order by ds_produto desc';
  end
  else
  begin
    DMF.qryProduto.SQL.Text := select + ' order by id desc';
  end;
  DMF.qryProduto.SQL.Text := select;
  DMF.qryProduto.Open;
  ShowMessage(DMF.qryProduto.SQL.Text);
  sbLimparTudo.click;
end;


procedure TCadProdutoF.btnSalvarClick(Sender: TObject);
begin
  DMF.qryProduto.FieldByName('categoria').AsInteger :=
    DMF.qryCategoria.FieldByName('categoriaprodutoid').AsInteger;
  DMF.qryProduto.Post;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  edtDesc.Enabled := False;
  lcbCategoria.Enabled := False;
  cbStatus.Enabled := False;
  edtValor.Enabled := False;
  edtObs.Enabled := False;
  dtCadastro.Enabled := False;
  btnSalvar.Enabled := False;
  PageControl1.ActivePage := tsCadastrar;
end;

procedure TCadProdutoF.btnAdicionarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
  DMF.qryProduto.Insert;
  DMF.qryProduto.FieldByName('data_cadastro').AsDateTime := Date;
  edtDesc.SetFocus;
end;

procedure TCadProdutoF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryProduto.Cancel;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadProdutoF.btnEditarClick(Sender: TObject);
begin
  DMF.qryProduto.Edit;
  edtDesc.Enabled := True;
  lcbCategoria.Enabled := True;
  cbStatus.Enabled := True;
  edtValor.Enabled := True;
  edtObs.Enabled := True;
  dtCadastro.Enabled := True;
  btnSalvar.Enabled := True;
end;

procedure TCadProdutoF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro ' +
    txtID.Field.AsString + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryProduto.Delete;
  end;
end;

procedure TCadProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadProdutoF.FormShow(Sender: TObject);
begin
  dtFim.MaxDate := Date;
  dtFim.Date := Date;
  dtInicio.Date := dtInicio.MinDate;
  dmf.qryCategoria.Open;
  lcbCategoria.KeyValue := null;

end;

procedure TCadProdutoF.SpeedButton1Click(Sender: TObject);
begin
  rgPesquisarStatus.ItemIndex := -1;
end;

procedure TCadProdutoF.SpeedButton2Click(Sender: TObject);
begin
  rgPesquisaValorVenda.ItemIndex := -1;
  edtPesquisarValor.Text := '';
end;

procedure TCadProdutoF.sbLimparTudoClick(Sender: TObject);
begin
  edtPesquisarDesc.Text := '';
  edtPesquisarID.Text := '';
  edtPesquisarValor.Text := '';
  rgPesquisarStatus.ItemIndex := -1;
  rgPesquisaValorVenda.ItemIndex := -1;
  btnLimparData.Click;
  pesqID := False;
  pesqDesc := False;
  pesqStatus := False;
  pesqValor := False;
  pesqData := False;
end;


end.
