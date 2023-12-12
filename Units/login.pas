unit Login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, DM, TelaInicial;

type

  { TLoginF }

  TLoginF = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pnLogin: TPanel;
    btnLogin: TSpeedButton;
    btnCancelarLogin: TSpeedButton;
    procedure btnCancelarLoginClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    function ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
  private

  public

  end;

var
  LoginF: TLoginF;

implementation

{$R *.lfm}

{ TLoginF }

procedure TLoginF.btnCancelarLoginClick(Sender: TObject);
begin
  close;
end;

procedure TLoginF.btnLoginClick(Sender: TObject);
var
  usuario, senha: String;
begin
  usuario:=edtLogin.Text;
  senha:=edtSenha.Text;
  if ValidaUsuario(usuario, senha) = True then
  begin
    TelaInicialF:=TTelaInicialF.create(self);
    TelaInicialF.Show;
    edtLogin.Text:='';
    edtSenha.Text:='';
  end;
end;

procedure TLoginF.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(Key) = 13 then
  btnLoginClick(Sender);
end;

function TLoginF.ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
begin
   if (pUsusario = '') then
   begin
      ShowMessage('Favor Preencha o Usuário!');
      edtLogin.SetFocus;
      Exit;
   end;

   if (pSenha = '') then
   begin
      ShowMessage('Favor Preencha a Senha!');
      edtSenha.SetFocus;
      Exit;
   end;

   DMF.qryGenerica.Close;
   DMF.qryGenerica.SQL.Clear;
   DMF.qryGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                   'FROM USUARIOS '+
                                   'WHERE USUARIO = ' +  QuotedStr(pUsusario) + ' ' +
                                   'AND SENHA = ' + QuotedStr(pSenha));
   DMF.qryGenerica.Open;

   if DMF.qryGenerica.FieldByName('NUMBER').AsInteger = 0 then
   Begin
      ShowMessage('Senha ou Usuário incorretos!');
      edtLogin.SetFocus;
      Result := False
   end
   else
      Result := True;

end;

procedure TLoginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

