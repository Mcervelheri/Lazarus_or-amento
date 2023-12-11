unit RelOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet;

type

  { TRelOrcamentoF }

  TRelOrcamentoF = class(TForm)
    btnGerarRel: TBitBtn;
    frDBdsOrcamento: TfrDBDataSet;
    frReport1: TfrReport;
    procedure btnGerarRelClick(Sender: TObject);
  private

  public

  end;

var
  RelOrcamentoF: TRelOrcamentoF;

implementation

{$R *.lfm}

{ TRelOrcamentoF }

procedure TRelOrcamentoF.btnGerarRelClick(Sender: TObject);
begin
     frReport1.LoadFromFile('Relatórios\RelOrcamentos.lrf');
   frReport1.PrepareReport;
   frReport1.ShowReport;
end;

end.

