unit MenuInicial;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Menus;

type
  TMenuInicial = class(TMainMenu)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard',[TMenuInicial]);
end;

end.
