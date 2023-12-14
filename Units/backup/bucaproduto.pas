unit BucaProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, DateTimePicker, DM;

type

  { TBuscaProdutoF }

  TBuscaProdutoF = class(TForm)
    btnLimparData: TBitBtn;
    btnPesqData: TButton;
    btnPesquisa: TSpeedButton;
    DBGrid1: TDBGrid;
    dsBuscaProduto: TDataSource;
    dtFim: TDateTimePicker;
    dtInicio: TDateTimePicker;
    edtPesquisarDesc: TEdit;
    edtPesquisarID: TEdit;
    edtPesquisarValor: TEdit;
    Label1: TLabel;
    lblValorProd: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    rgPesquisarStatus: TRadioGroup;
    rgPesquisaValorVenda: TRadioGroup;
    sbLimparTudo: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btnLimparDataClick(Sender: TObject);
    procedure btnPesqDataClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    function pesqPorDesc(): string;
    function pesqPorId(): string;
    function pesqPorStatus(): string;
    function pesqPorValor(): string;
    function pesqPorData(): string;
  private

  public

  end;

var
  BuscaProdutoF: TBuscaProdutoF;
  pesqID, pesqDesc, pesqStatus, pesqValor, pesqData: boolean;
implementation

{$R *.lfm}

{ TBuscaProdutoF }

function TBuscaProdutoF.pesqPorId: string;
begin
  Result := 'produtoid = ' + edtPesquisarID.Text;
end;

function TBuscaProdutoF.pesqPorDesc(): string;
begin
  Result := 'ds_produto like ' + QuotedStr('%' +
    UpperCase(edtPesquisarDesc.Text) + '%');
end;

function TBuscaProdutoF.pesqPorStatus(): string;
begin
  Result := 'status_produto = ' + QuotedStr(
    rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]);
end;

function TBuscaProdutoF.pesqPorValor(): string;
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

function TBuscaProdutoF.pesqPorData(): string;
begin
  Result := 'dt_cadastro_produto between ' + QuotedStr(
    DateToStr(dtInicio.Date)) + ' and ' + QuotedStr(DateToStr(dtFim.Date));
end;

procedure TBuscaProdutoF.btnPesquisaClick(Sender: TObject);
var
  select, condicao, coluna, operador: string;
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

procedure TBuscaProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  lblValorProd.Caption:=DMF.qryProdutovalor_venda.AsString;
  close;
end;

procedure TBuscaProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin

end;

procedure TBuscaProdutoF.btnLimparDataClick(Sender: TObject);
begin
    dtFim.MaxDate := Date;
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

procedure TBuscaProdutoF.btnPesqDataClick(Sender: TObject);
begin
    btnPesqData.Visible := False;
  Label7.Visible := True;
  Label8.Visible := True;
  dtInicio.Visible := True;
  dtFim.Visible := True;
  btnLimparData.Visible := True;
  pesqData := True;
end;

end.

