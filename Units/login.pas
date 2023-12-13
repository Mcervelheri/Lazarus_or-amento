unit Login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, DM, TelaInicial;

type

  { TLoginF }

  TLoginF = class(TForm)
    cbMostrarSenha: TCheckBox;
    edtLogin: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pnLogin: TPanel;
    btnLogin: TSpeedButton;
    btnCancelarLogin: TSpeedButton;
    procedure btnCancelarLoginClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure cbMostrarSenhaClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    function ValidaUsuario(pUsusario: string; pSenha: string): boolean;
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
  Close;
end;

procedure TLoginF.btnLoginClick(Sender: TObject);
var
  usuario, senha, xUsuario: string;
begin
  xUsuario := edtLogin.Text;
  usuario := edtLogin.Text;
  senha := edtSenha.Text;
  if ValidaUsuario(usuario, senha) = True then
  begin
    TelaInicialF := TTelaInicialF.Create(self);
    DMF.qryGenerica.Close;
    DMF.qryGenerica.SQL.Clear;
    DMF.qryGenerica.SQL.Add(
      'select id, usuario, ' +
      'nome_completo, ' + 'senha ' +
      'from usuarios where usuario = ' + QuotedStr(usuario));
    DMF.qryGenerica.Open;
    xUsuario :=
      DMF.qryGenerica.FieldByName('nome_completo').AsString;


    TelaInicialF.Show;
    TelaInicialF.DBText1.Caption:='Bem-Vindo '+xUsuario;
    edtLogin.Text := '';
    edtSenha.Text := '';
  end;
end;

procedure TLoginF.cbMostrarSenhaClick(Sender: TObject);
begin
  if cbMostrarSenha.Checked = True then
  begin
    edtSenha.PasswordChar := #0;
  end
  else
  begin
    edtSenha.PasswordChar := '*';
  end;
end;

procedure TLoginF.edtSenhaKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  xUsuario: string;
begin
  if Ord(Key) = 13 then
  begin
    btnLoginClick(Sender);
  end;
end;

function TLoginF.ValidaUsuario(pUsusario: string; pSenha: string): boolean;
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
  DMF.qryGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER ' +
    'FROM USUARIOS ' +
    'WHERE USUARIO = ' + QuotedStr(pUsusario) +
    ' ' + 'AND SENHA = ' + QuotedStr(pSenha));
  DMF.qryGenerica.Open;

  if DMF.qryGenerica.FieldByName('NUMBER').AsInteger = 0 then
  begin
    ShowMessage('Senha ou Usuário incorretos!');
    edtLogin.SetFocus;
    Result := False;
  end
  else
    Result := True;

end;

procedure TLoginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.
