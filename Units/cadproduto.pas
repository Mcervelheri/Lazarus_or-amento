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

  end;

var
  CadProdutoF: TCadProdutoF;
  pesqID, pesqDesc, pesqStatus, pesqValor, pesqData: boolean;


implementation

{$R *.lfm}

{ TCadProdutoF }



procedure TCadProdutoF.btnFechar1Click(Sender: TObject);
begin
  Close;
end;

procedure TCadProdutoF.btnLimparDataClick(Sender: TObject);
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

procedure TCadProdutoF.btnPesquisaClick(Sender: TObject);
var
  select, condicao, coluna, operador: string;
begin
  DMF.qryProduto.Close;
  select := 'select ' + 'produtoid as id, ' + 'categoriaprodutoid as categoria, ' +
    'ds_produto as descrição, ' + 'obs_produto as obeservação, ' +
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

procedure TCadProdutoF.btnSalvarClick(Sender: TObject);
begin
  DMF.qryProduto.FieldByName('categoria').AsInteger :=
    DMF.qryCategoria.FieldByName('id').AsInteger;
  DMF.qryProduto.Post;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
end;

procedure TCadProdutoF.btnAdicionarClick(Sender: TObject);
begin
  PageControl1.ActivePage:=tsCadastrar;
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
  DMF.qryCategoria.Edit;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadProdutoF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryCategoria.Delete;
  end;
end;

procedure TCadProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DMF.qryCategoria.Close;
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
