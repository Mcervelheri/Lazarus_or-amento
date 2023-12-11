unit BucaProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, DateTimePicker, DM;

type

  { TBucaProdutoF }

  TBucaProdutoF = class(TForm)
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
  private

  public

  end;

var
  BucaProdutoF: TBucaProdutoF;
  pesqID, pesqDesc, pesqStatus, pesqValor, pesqData: boolean;
implementation

{$R *.lfm}

{ TBucaProdutoF }

procedure TBucaProdutoF.btnPesquisaClick(Sender: TObject);
var
  select, condicao, coluna, operador: string;
begin
  DMF.qryProduto.Close;
  select := 'select ' + 'produtoid as id, ' + 'categoriaprodutoid as categoria, ' +
    'ds_produto as descrição, ' + 'obs_produto as observação, ' +
    'vl_venda_produto as valor_venda, ' + 'dt_cadastro_produto as data_cadastro, ' +
    'status_produto as status ' + 'from produto';
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

  if pesqID then
  begin
    condicao := 'where produtoid = ' + edtPesquisarID.Text + ' order by produtoid desc';
    select := select + ' ' + condicao;
    DMF.qryProduto.SQL.Text := select;
    ShowMessage('condição id');

  end
  else if pesqDesc then
  begin
    if pesqStatus then
    begin
      if pesqValor then
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
        if pesqData then
        begin

          condicao := 'where Upper(ds_produto) like ' + QuotedStr(
            '%' + UpperCase(edtPesquisarDesc.Text) + '%') +
            ' and status_produto = ' + QuotedStr(
            rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]) +
            ' and vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text +
            ' and dt_cadastro_produto between ' + QuotedStr(DateToStr(dtInicio.Date)) +
            ' and ' + QuotedStr(DateToStr(dtFim.Date)) + ' order by ds_produto asc';
          select := select + ' ' + condicao;
          DMF.qryProduto.SQL.Text := select;
        end
        else
        begin
          condicao := 'where Upper(ds_produto) like ' + QuotedStr(
            '%' + UpperCase(edtPesquisarDesc.Text) + '%') +
            ' and status_produto = ' + QuotedStr(
            rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]) +
            ' and vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text +
            ' order by ds_produto asc';
          select := select + ' ' + condicao;
          DMF.qryProduto.SQL.Text := select;
        end;
      end
      else

      begin
        condicao := 'where Upper(ds_produto) like ' + QuotedStr(
          '%' + UpperCase(edtPesquisarDesc.Text) + '%') +
          ' and status_produto = ' + QuotedStr(
          rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]) +
          ' order by ds_produto asc';
        select := select + ' ' + condicao;
        DMF.qryProduto.SQL.Text := select;
      end;
    end
    else if pesqValor then
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
      if pesqData then
      begin

        condicao := 'where Upper(ds_produto) like ' + QuotedStr(
          '%' + UpperCase(edtPesquisarDesc.Text) + '%') +
          ' and vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text +
          ' and dt_cadastro_produto between ' + QuotedStr(
          DateToStr(dtInicio.Date)) + ' and ' + QuotedStr(DateToStr(dtFim.Date)) +
          ' order by ds_produto asc';
        select := select + ' ' + condicao;
        DMF.qryProduto.SQL.Text := select;

      end
      else
      begin

        condicao := 'where Upper(ds_produto) like ' +
          QuotedStr('%' + UpperCase(edtPesquisarDesc.Text) + '%') +
          ' and vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text +
          ' order by ds_produto asc';
        select := select + ' ' + condicao;
        DMF.qryProduto.SQL.Text := select;
      end;

    end
    else if pesqData then
    begin
      condicao := 'where Upper(ds_produto) like ' + QuotedStr(
        '%' + UpperCase(edtPesquisarDesc.Text) + '%') +
        'and dt_cadastro_produto between ' + QuotedStr(DateToStr(dtInicio.Date)) +
        ' and ' + QuotedStr(DateToStr(dtFim.Date));
      select := select + ' ' + condicao;
      DMF.qryProduto.SQL.Text := select;
    end
    else
    begin
      condicao := 'where Upper(ds_produto) like ' + QuotedStr(
        '%' + UpperCase(edtPesquisarDesc.Text) + '%') + ' order by ds_produto asc';
      select := select + ' ' + condicao;
      DMF.qryProduto.SQL.Text := select;
    end;
  end
  else if pesqStatus then
  begin
    if pesqValor then
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
      if pesqData then
      begin
        condicao := 'where status_produto = ' + QuotedStr(
          rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]) +
          ' and vl_venda_produto ' + operador + edtPesquisarValor.Text +
          ' and dt_cadastro_produto between' + QuotedStr(DateToStr(dtInicio.Date)) +
          ' and ' + QuotedStr(DateToStr(dtFim.Date));
        select := select + ' ' + condicao;
        DMF.qryProduto.SQL.Text := select;
      end
      else
      begin
        condicao := 'where status_produto = ' + QuotedStr(
          rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]) +
          ' and vl_venda_produto ' + operador + edtPesquisarValor.Text;
        select := select + ' ' + condicao;
        DMF.qryProduto.SQL.Text := select;
      end;
    end
    else
    begin
      condicao := 'where status_produto = ' + QuotedStr(
        rgPesquisarStatus.Items[rgPesquisarStatus.ItemIndex]);
      select := select + ' ' + condicao;
      DMF.qryProduto.SQL.Text := select;
    end;
  end
  else if pesqValor then
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
    if pesqData then
    begin
      condicao := 'where vl_venda_produto ' + operador + ' ' +
        edtPesquisarValor.Text + ' and dt_cadastro_produto between ' +
        QuotedStr(DateToStr(dtInicio.Date)) + ' and ' +
        QuotedStr(DateToStr(dtFim.Date));
      select := select + ' ' + condicao;
      DMF.qryProduto.SQL.Text := select;
      ShowMessage(DMF.qryProduto.SQL.Text);
    end
    else
    begin
      condicao := 'where vl_venda_produto ' + operador + ' ' + edtPesquisarValor.Text;
      select := select + ' ' + condicao;
      DMF.qryProduto.SQL.Text := select;
    end;
  end
  else if pesqData then
  begin
    condicao := 'where dt_cadastro_produto between ' + QuotedStr(
      DateToStr(dtInicio.Date)) + ' and ' + QuotedStr(DateToStr(dtFim.Date));
    select := select + ' ' + condicao;
    DMF.qryProduto.SQL.Text := select;
  end
  else
  begin
    DMF.qryProduto.SQL.Text := select;
  end;
  DMF.qryProduto.Open;
  sbLimparTudo.click;
  ShowMessage(DMF.qryProduto.SQL.Text);
end;

procedure TBucaProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  close;
end;

procedure TBucaProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TBucaProdutoF.btnLimparDataClick(Sender: TObject);
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

procedure TBucaProdutoF.btnPesqDataClick(Sender: TObject);
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

