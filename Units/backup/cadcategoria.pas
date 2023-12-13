unit CadCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, Menus, CadModelo, DM, DB;

type

  { TCadCategoriaF }

  TCadCategoriaF = class(TCadModeloF)
    txtID: TDBText;
    edtDesc: TDBEdit;
    edtPesquisarDesc: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtDescKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private

  public

  end;

var
  CadCategoriaF: TCadCategoriaF;

implementation

{$R *.lfm}

{ TCadCategoriaF }

procedure TCadCategoriaF.SpeedButton1Click(Sender: TObject);
var
  colunaPesquisa: string;
  condPesquisa: string;
begin
  condPesquisa := '';
  colunaPesquisa := '';
  if edtPesquisarID.Text <> '' then
  begin
    colunaPesquisa := 'categoriaprodutoid';
    condPesquisa := 'where ' + colunaPesquisa + ' = ' + edtPesquisarID.Text;
  end
  else
  if edtPesquisarDesc.Text <> '' then
  begin
    colunaPesquisa := 'Upper(ds_categoria_produto)';
    condPesquisa := 'where ' + colunaPesquisa + ' like ' + QuotedStr(
      '%' + UpperCase(edtPesquisarDesc.Text) + '%');
  end;
  DMF.qryCategoria.Close;
  DMF.qryCategoria.SQL.Text :=
    'select categoriaprodutoid as id, ds_categoria_produto as descrição ' +
    'from categoria_produto ' +
    condPesquisa + ' order by id desc';

  DMF.qryCategoria.Open;
  edtPesquisarDesc.Text := '';
  edtPesquisarID.Text := '';
end;

procedure TCadCategoriaF.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage := tsConsulta;
  DMF.qryCategoria.Open;
end;


procedure TCadCategoriaF.btnSalvarClick(Sender: TObject);
begin
  try
    if DMF.qryCategoria.State in [dsedit, dsInsert] then
    begin
      DMF.qryCategoria.Post;
    end
    else
    begin
      ShowMessage('Nenhuma operação de edição ou inserção em andamento.');
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao salvar: ' + E.Message);
      DMF.qryCategoria.Cancel;
    end;
  end;

  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
  btnSalvar.Enabled:=False;
end;

procedure TCadCategoriaF.edtDescKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if chr(Key) = #13 then
  begin
    DMF.qryCategoria.Post;
    PageControl1.ActivePage := tsConsulta;
  end;
end;

procedure TCadCategoriaF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;


procedure TCadCategoriaF.btnExcluirClick(Sender: TObject);
begin

  if MessageDlg('Você tem certeza que deseja excluir o registro '+txtID.Field.AsString+ ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.qryCategoria.Delete;
  end;
end;

procedure TCadCategoriaF.btnCancelarClick(Sender: TObject);
begin
  DMF.qryCategoria.Cancel;
  PageControl1.ActivePage := tsConsulta;
end;

procedure TCadCategoriaF.btnEditarClick(Sender: TObject);
begin
  DMF.qryCategoria.Edit;
  btnSalvar.Enabled:=True;
end;

procedure TCadCategoriaF.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TCadCategoriaF.SpeedButton2Click(Sender: TObject);
begin
  PageControl1.ActivePage := tsCadastrar;
  DMF.qryCategoria.Insert;
  edtDesc.SetFocus;
end;



end.
