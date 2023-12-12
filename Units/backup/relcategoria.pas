unit RelCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet;

type

  { TRelCategoriaF }

  TRelCategoriaF = class(TForm)
    btnGerarRel: TBitBtn;
    frDBdsCategoria: TfrDBDataSet;
    frReport1: TfrReport;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  RelCategoriaF: TRelCategoriaF;

implementation

{$R *.lfm}

{ TRelCategoriaF }



procedure TRelCategoriaF.FormShow(Sender: TObject);
begin
  frReport1.LoadFromFile('Relatórios\RelCategorias.lrf');
   frReport1.PrepareReport;
   frReport1.ShowReport;
   close;
end;

procedure TRelCategoriaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

