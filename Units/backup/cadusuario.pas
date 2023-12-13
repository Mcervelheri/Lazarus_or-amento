unit CadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,db ,
  CadModelo, DM;

type

  { TCadUsuarioF }

  TCadUsuarioF = class(TCadModeloF)
    cbMostrarSenha: TCheckBox;
    edtUsuario: TDBEdit;
    edtNome: TDBEdit;
    edtSenha: TDBEdit;
    txtId: TDBText;
    edtPesquisarUser: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cbMostrarSenhaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  CadUsuarioF: TCadUsuarioF;

implementation

{$R *.lfm}

{ TCadUsuarioF }

procedure TCadUsuarioF.btnPesquisaClick(Sender: TObject);
var
  colunaPesquisa: string;
  condPesquisa: string;
begin
  condPesquisa := '';
  colunaPesquisa := '';
  if edtPesquisarID.Text <> '' then
  begin
    colunaPesquisa := 'id';
    condPesquisa := 'where ' + colunaPesquisa + ' = ' + edtPesquisarID.Text;
  end
  else
  if edtPesquisarUser.Text <> '' then
  begin
    colunaPesquisa := 'Upper(usuario)';
    condPesquisa := 'where ' + colunaPesquisa + ' like ' + QuotedStr(
      '%' + UpperCase(edtPesquisarUser.Text) + '%');
  end;
  DMF.qryUsuario.Close;
  DMF.qryUsuario.SQL.Text :=
    'select id, usuario, nome_completo as nome, senha ' +
    'from usuario ' +
    condPesquisa + ' order by id desc';

  DMF.qryCategoria.Open;
  edtPesquisarUser.Text := '';
  edtPesquisarID.Text := '';
end;

procedure TCadUsuarioF.btnSalvarClick(Sender: TObject);
begin
    try
    if DMF.qryUsuario.State in [dsedit, dsInsert] then
    begin
      DMF.qryUsuario.Post;
    end
    else
    begin
      ShowMessage('Nenhuma operação de edição ou inserção em andamento.');
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao salvar: ' + E.Message);
      DMF.qryUsuario.Cancel;
    end;
  end;

  PageControl1.ActivePage := tsConsulta;
end;


procedure TCadUsuarioF.cbMostrarSenhaClick(Sender: TObject);
begin
  if cbMostrarSenha.Checked = true then
     begin
       edtSenha.PasswordChar:=#0;
     end
  else
      begin
        edtSenha.PasswordChar:='*';
      end;
end;

procedure TCadUsuarioF.DBGrid1DblClick(Sender: TObject);
begin
  btnSalvar.Enabled:=False;
  edtNome.Enabled:=False;
  edtUsuario.Enabled:=False;
  edtSenha.Enabled:=False;
  cbMostrarSenha.Enabled:=False;
  PageControl1.ActivePage:=tsCadastrar;

end;


procedure TCadUsuarioF.btnAdicionarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
  DMF.qryUsuario.Insert;
  edtUsuario.SetFocus;
end;

procedure TCadUsuarioF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryUsuario.Cancel;
  PageControl1.ActivePage:=tsConsulta;
end;

procedure TCadUsuarioF.btnEditarClick(Sender: TObject);
begin
  DMF.qryUsuario.Edit;
  btnSalvar.Enabled:=True;
  edtNome.Enabled:=True;
  edtUsuario.Enabled:=True;
  edtSenha.Enabled:=True;
  cbMostrarSenha.Enabled:=True;
end;

procedure TCadUsuarioF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro '+txtId.Field.AsString+' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryUsuario.Delete;
  end;
end;

procedure TCadUsuarioF.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.

