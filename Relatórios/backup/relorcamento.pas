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
  private

  public

  end;

var
  RelOrcamentoF: TRelOrcamentoF;

implementation

{$R *.lfm}

end.

