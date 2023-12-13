unit TelaInicial;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, EditBtn,
  ExtCtrls, CadCategoria, CadProduto, CadCliente, CadUsuario, Orcamento,
  RelCategoria, RelProdutos, RelClientes, RelOrcamento, RelOrcItens;

type

  { TTelaInicialF }

  TTelaInicialF = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    miOrcamentoItem: TMenuItem;
    miRelOrcamentos: TMenuItem;
    miRelClientes: TMenuItem;
    miRelProduto: TMenuItem;
    miRelCategoria: TMenuItem;
    miRelatorios: TMenuItem;
    miSobre: TMenuItem;
    miOrcamento: TMenuItem;
    miManutencao: TMenuItem;
    miSair: TMenuItem;
    miUsuario: TMenuItem;
    miCliente: TMenuItem;
    miProduto: TMenuItem;
    miCategoria: TMenuItem;
    miCadastro: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure miCategoriaClick(Sender: TObject);
    procedure miClienteClick(Sender: TObject);
    procedure miOrcamentoClick(Sender: TObject);
    procedure miOrcamentoItemClick(Sender: TObject);
    procedure miProdutoClick(Sender: TObject);
    procedure miRelCategoriaClick(Sender: TObject);
    procedure miRelClientesClick(Sender: TObject);
    procedure miRelOrcamentosClick(Sender: TObject);
    procedure miRelProdutoClick(Sender: TObject);
    procedure miSairClick(Sender: TObject);
    procedure miUsuarioClick(Sender: TObject);
  private

  public
    function obterMenuPrincipal: TMainMenu;
  end;

var
  TelaInicialF: TTelaInicialF;

implementation

{$R *.lfm}

{ TTelaInicialF }

procedure TTelaInicialF.miCategoriaClick(Sender: TObject);
begin

     CadCategoriaF:=TCadCategoriaF.create(self);
     CadCategoriaF.show;
end;

procedure TTelaInicialF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TTelaInicialF.miClienteClick(Sender: TObject);
begin
    CadClienteF:=TCadClienteF.create(self);
    CadClienteF.show;
end;

procedure TTelaInicialF.miOrcamentoClick(Sender: TObject);
begin
    OrcamentoF:=TOrcamentoF.create(self);
    OrcamentoF.show;
end;

procedure TTelaInicialF.miOrcamentoItemClick(Sender: TObject);
begin
  RelOrcItensF:=TRelOrcItensF.create(self);
  RelOrcItensF.ShowModal;
end;

procedure TTelaInicialF.miProdutoClick(Sender: TObject);
begin
     CadProdutoF:=TCadProdutoF.create(self);
     CadProdutoF.show;
end;

procedure TTelaInicialF.miRelCategoriaClick(Sender: TObject);
begin
    RelCategoriaF:=TRelCategoriaF.Create(self);
    RelCategoriaF.ShowModal;
end;

procedure TTelaInicialF.miRelClientesClick(Sender: TObject);
begin
  RelClientesF:=TRelClientesF.create(self);
  RelClientesF.ShowModal;
end;

procedure TTelaInicialF.miRelOrcamentosClick(Sender: TObject);
begin
  RelOrcamentoF:=TRelOrcamentoF.create(self);
  RelOrcamentoF.ShowModal;
end;

procedure TTelaInicialF.miRelProdutoClick(Sender: TObject);
begin
  RelProdutosF:=TRelProdutosF.Create(Self);
  RelProdutosF.ShowModal;
end;

procedure TTelaInicialF.miSairClick(Sender: TObject);
begin
  Close;
end;

procedure TTelaInicialF.miUsuarioClick(Sender: TObject);
begin
  CadUsuarioF:=TCadUsuarioF.create(self);
  CadUsuarioF.show;
end;

function TTelaInicialF.obterMenuPrincipal: TMainMenu;
begin
  result:=MainMenu1;
end;

end.

