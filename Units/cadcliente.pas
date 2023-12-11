unit CadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  CadModelo, DM;

type

  { TCadClienteF }

  TCadClienteF = class(TCadModeloF)
    cbTipo: TDBComboBox;
    DBText1: TDBText;
    edtCPFCNPJ: TDBEdit;
    edtNome: TDBEdit;
    edtPesquisarDesc: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure miClienteClick(Sender: TObject);
  private

  public

  end;

var
  CadClienteF: TCadClienteF;

implementation

{$R *.lfm}

{ TCadClienteF }

procedure TCadClienteF.btnPesquisaClick(Sender: TObject);
var
    colunaPesquisa, condPesquisa:string;
  begin
    condPesquisa := '';
    colunaPesquisa := '';
    if edtPesquisarID.Text <> '' then
    begin
      colunaPesquisa := 'cliente';
      condPesquisa := 'where ' + colunaPesquisa + 'id = ' + edtPesquisarID.Text;
    end
    else
    if edtPesquisarDesc.Text <> '' then
    begin
      colunaPesquisa := 'Upper(nome_cliente)';
      condPesquisa := 'where ' + colunaPesquisa + ' like ' + QuotedStr(
        '%' + UpperCase(edtPesquisarDesc.Text) + '%');
    end;
    DMF.qryCliente.open;
    DMF.qryCliente.SQL.Text :=
      'select clienteid as id, tipo_cliente as tipo, cpf_cnpj_cliente as CPF_CNPJ, nome_cliente as nome from cliente '
      + condPesquisa +' order by id desc';

    ShowMessage(DMF.qryCliente.SQL.Text);
    DMF.qryCliente.Open;
    edtPesquisarDesc.Text := '';
    edtPesquisarID.Text := '';
  end;

procedure TCadClienteF.btnEditarClick(Sender: TObject);
begin
  DMF.qryCliente.Edit;
  PageControl1.ActivePage:=tsConsulta;
end;

procedure TCadClienteF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryCliente.Cancel;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadClienteF.btnAdicionarClick(Sender: TObject);
begin
  PageControl1.ActivePage:=tsCadastrar;
  DMF.qryCliente.Insert;
  cbTipo.SetFocus;
end;

procedure TCadClienteF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryCliente.Delete;
  end;
end;

procedure TCadClienteF.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TCadClienteF.btnSalvarClick(Sender: TObject);
begin
  DMF.qryCliente.Post;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadClienteF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.ActivePage:=tsCadastrar;
end;

procedure TCadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TCadClienteF.miClienteClick(Sender: TObject);
begin

end;



end.
