unit CadModelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, ComCtrls, Menus, DM;

type
  { TCadModeloF }

  TCadModeloF = class(TForm)
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnFechar: TSpeedButton;
    dsModelo: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisarID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    miCadastro: TMenuItem;
    miCategoria: TMenuItem;
    miCliente: TMenuItem;
    miInicio: TMenuItem;
    miManutencao: TMenuItem;
    miOrcamento: TMenuItem;
    miProduto: TMenuItem;
    miSair: TMenuItem;
    miSobre: TMenuItem;
    miUsuario: TMenuItem;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    btnPesquisa: TSpeedButton;
    btnAdicionar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    tsConsulta: TTabSheet;
    tsCadastrar: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CadModeloF: TCadModeloF;

implementation

{$R *.lfm}

{ TCadModeloF }

procedure TCadModeloF.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := tsConsulta;
end;



end.

