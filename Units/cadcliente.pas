unit CadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Menus, CadModelo, DM;

type

  { TCadClienteF }

  TCadClienteF = class(TCadModeloF)
    cbTipo: TDBComboBox;
    txtId: TDBText;
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
    procedure edtCPFCNPJEditingDone(Sender: TObject);
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
  colunaPesquisa, condPesquisa: string;
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
  DMF.qryCliente.Open;
  DMF.qryCliente.SQL.Text :=
    'select clienteid as id, tipo_cliente as tipo, cpf_cnpj_cliente as CPF_CNPJ, nome_cliente as nome from cliente '
    + condPesquisa + ' order by id desc';

  ShowMessage(DMF.qryCliente.SQL.Text);
  DMF.qryCliente.Open;
  edtPesquisarDesc.Text := '';
  edtPesquisarID.Text := '';
end;

procedure TCadClienteF.btnEditarClick(Sender: TObject);
begin
  DMF.qryCliente.Edit;
  btnSalvar.Enabled:=True;
  cbTipo.Enabled:=True;
  edtCPFCNPJ.Enabled:=True;
  edtNome.Enabled:=True;
end;

procedure TCadClienteF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryCliente.Cancel;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadClienteF.btnAdicionarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
  DMF.qryCliente.Insert;
  cbTipo.SetFocus;
end;

procedure TCadClienteF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro '+txtId.Field.AsString+' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryCliente.Delete;
  end;
end;

procedure TCadClienteF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TCadClienteF.btnSalvarClick(Sender: TObject);
begin
  DMF.qryCliente.Post;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadClienteF.DBGrid1DblClick(Sender: TObject);
begin
  btnSalvar.Enabled:=False;
  cbTipo.Enabled:=False;
  edtCPFCNPJ.Enabled:=False;
  edtNome.Enabled:=False;
  PageControl1.ActivePage := tsCadastrar;
end;

procedure TCadClienteF.edtCPFCNPJEditingDone(Sender: TObject);
var
  cpj, cnpj, original, slice1, slice2, slice3, slice4,documento: string;
  begin
    documento := edtCPFCNPJ.Text;
    documento := StringReplace(documento, '.', '', [rfReplaceAll]);
    documento := StringReplace(documento, '-', '', [rfReplaceAll]);
    documento := StringReplace(documento, '/', '', [rfReplaceAll]);

    if Length(documento) = 11 then
    begin
      documento := Format('%s.%s.%s-%s', [Copy(documento, 1, 3), Copy(documento, 4, 3), Copy(documento, 7, 3), Copy(documento, 10, 2)]);
    end
    else if Length(documento) = 14 then
    begin
      documento := Format('%s.%s.%s/%s-%s', [Copy(documento, 1, 2), Copy(documento, 3, 3), Copy(documento, 6, 3), Copy(documento, 9, 4), Copy(documento, 13, 2)]);
    end
    else
    begin
      ShowMessage('documento inválido');
    end;
    edtCPFCNPJ.Field.AsString:=documento;
  end;



procedure TCadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadClienteF.miClienteClick(Sender: TObject);
begin

end;



end.
