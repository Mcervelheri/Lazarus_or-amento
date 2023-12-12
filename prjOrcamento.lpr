program prjOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, CadModelo, DM, CadCategoria, Login,
  TelaInicial, CadProduto, CadCliente, CadUsuario, Orcamento, BuscaCliente,
  RelCategoria, BucaProduto, CadOrcamentoItem, relprodutos, RelClientes, 
RelOrcamento;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TLoginF, LoginF);
  Application.CreateForm(TDMF, DMF);
  Application.Run;
end.

