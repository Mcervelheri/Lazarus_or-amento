unit DM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Menus, ZConnection, ZDataset, DB;

type

  { TDMF }

  TDMF = class(TDataModule)
    qryCategoriadescricao: TStringField;
    qryCategoriadescrio: TStringField;
    qryCategoriaid: TLongintField;
    qryClientecpf_cnpj: TStringField;
    qryClienteid: TLongintField;
    qryClientenome: TStringField;
    qryClientetipo: TStringField;
    qryOrcamento: TZQuery;
    qryOrcamentoclienteid: TLongintField;
    qryOrcamentodt_orcamento: TDateTimeField;
    qryOrcamentodt_validade_orcamento: TDateTimeField;
    qryOrcamentoItem: TZQuery;
    qryOrcamentoItemorcamentoid: TLongintField;
    qryOrcamentoItemorcamentoitemid: TLongintField;
    qryOrcamentoItemprodutoid: TLongintField;
    qryOrcamentoItemqt_produto: TFloatField;
    qryOrcamentoItemvl_total: TFloatField;
    qryOrcamentoItemvl_unitario: TFloatField;
    qryOrcamentoorcamentoid: TLongintField;
    qryOrcamentovl_total_orcamento: TFloatField;
    qryProdutocategoria: TLongintField;
    qryProdutodata_cadastro: TDateTimeField;
    qryProdutodescricao: TStringField;
    qryProdutoid: TLongintField;
    qryProdutoobservacao: TStringField;
    qryProdutostatus: TStringField;
    qryProdutovalor_venda: TFloatField;
    qryUsuarioid: TLongintField;
    qryUsuarionome: TStringField;
    qryUsuariosenha: TStringField;
    qryUsuariousuario: TStringField;
    ZConnection1: TZConnection;
    qryCategoria: TZQuery;
    qryGenerica: TZQuery;
    qryProduto: TZQuery;
    qryCliente: TZQuery;
    qryUsuario: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryCategoriaAfterInsert(DataSet: TDataSet);
    procedure qryClienteAfterInsert(DataSet: TDataSet);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure qryProdutoAfterInsert(DataSet: TDataSet);
    procedure qryUsuarioAfterInsert(DataSet: TDataSet);
  private
    function getSequence(const pNomeSequence: String): String;
  public
  end;

var
  DMF: TDMF;
  qryCategoriacategoriaprodutoid: Integer;

implementation

{$R *.lfm}

{ TDMF }

procedure TDMF.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase  := 'postgres';
  ZConnection1.User           := 'postgres';
  ZConnection1.Password   := '123456';
  ZConnection1.Port            := 5432;
  ZConnection1.Protocol      := 'postgresql';
  ZConnection1.Connected  := True;
end;

procedure TDMF.qryCategoriaAfterInsert(DataSet: TDataSet);
begin
  qryCategoriaid.AsInteger := strtoint(getSequence('categoria'));

end;

procedure TDMF.qryClienteAfterInsert(DataSet: TDataSet);
begin
  qryClienteid.AsInteger:= StrToInt(getSequence('cliente'));
end;

procedure TDMF.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  qryOrcamentoorcamentoid.AsInteger:=StrToInt(getSequence('orcamento'));
end;



procedure TDMF.qryProdutoAfterInsert(DataSet: TDataSet);
begin
  qryProdutoid.AsInteger:= StrToInt(getSequence('produto'));
end;

procedure TDMF.qryUsuarioAfterInsert(DataSet: TDataSet);
begin
  qryUsuarioid.AsInteger:= StrToInt(getSequence('usuario_id'));
end;





function TDMF.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence + '_seq') + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;

 finally
   qryGenerica.Close;
 end;
end;


end.

