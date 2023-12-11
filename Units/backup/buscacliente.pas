unit BuscaCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  Buttons, StdCtrls, DM;

type

  { TBuscaClienteF }

  TBuscaClienteF = class(TForm)
    btnPesquisa: TSpeedButton;
    DBGrid1: TDBGrid;
    dsBuscaCliente: TDataSource;
    edtPesquisarDesc: TEdit;
    edtPesquisarID: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
  private

  public

  end;

var
  BuscaClienteF: TBuscaClienteF;

implementation

{$R *.lfm}

{ TBuscaClienteF }



end.

