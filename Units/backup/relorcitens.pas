unit RelOrcItens;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet;

type

  { TRelOrcItensF }

  TRelOrcItensF = class(TForm)
    btnGerarRel: TBitBtn;
    frDBdsOrcamentoItem: TfrDBDataSet;
    frReport1: TfrReport;
    procedure btnGerarRelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  RelOrcItensF: TRelOrcItensF;

implementation

{$R *.lfm}

{ TRelOrcItensF }


procedure TRelOrcItensF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TRelOrcItensF.FormShow(Sender: TObject);
begin
   frReport1.LoadFromFile('Relatórios\RelOrcamentoItens.lrf');
   frReport1.PrepareReport;
   frReport1.ShowReport;
end;

end.

