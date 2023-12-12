unit RelClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet;

type

  { TRelClientesF }

  TRelClientesF = class(TForm)
    frDBdsClientes: TfrDBDataSet;
    frReport1: TfrReport;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  RelClientesF: TRelClientesF;

implementation

{$R *.lfm}

{ TRelClientesF }


procedure TRelClientesF.FormShow(Sender: TObject);
begin
  frReport1.LoadFromFile('Relatórios\RelClientes.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
  close;
end;

procedure TRelClientesF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

end.
