unit Backend.Model.Firedac.Conexao;

interface

uses
  Backend.Model.Conexao.Interfaces, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs,Vcl.Forms;

Type
  TModelFiredacConexao = class(TInterfacedObject, iModelConexao)
    private
      FConexao : TFDConnection;
      function DevolveCaminhoBanco:string;
      function Diretorio: string;

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelConexao;
      function Connection : TCustomConnection;
  end;

implementation

uses
  System.SysUtils;

{ TModelFiredacConexao }

function TModelFiredacConexao.Connection: TCustomConnection;
begin
  Result := FConexao;
end;

constructor TModelFiredacConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  FConexao.Params.DriverID := 'FB';
  FConexao.Params.Database := DevolveCaminhoBanco;
  FConexao.Params.UserName := 'SYSDBA';
  FConexao.Params.Password := 'masterkey';
  FConexao.Connected := true;
  Writeln('Banco conectou!.');
end;

destructor TModelFiredacConexao.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

function TModelFiredacConexao.DevolveCaminhoBanco: string;
var
  sArquivo: TextFile;
  cHost: string;
  cLocal: string;
  cLocal2: String;
  cCaminho, cTipo: string;
  ARQUIVO_INI: string;
  chora, cdata: string;
  cGHost: string;

begin
  cGHost := '';

  ARQUIVO_INI := Diretorio + 'McBancoFB.ini';

 if FileExists(ARQUIVO_INI) then
  begin
    AssignFile(sArquivo, ARQUIVO_INI);
    Reset(sArquivo);
    Readln(sArquivo, cHost);
    Readln(sArquivo, cLocal);
    Readln(sArquivo, cTipo);
    cHost := trim(Copy(cHost, 6, 100));
    cLocal := trim(Copy(cLocal, 7, 150));
    cTipo := trim(Copy(cTipo, 6, 15));

    CloseFile(sArquivo);

    cGHost := cHost;


    cCaminho := cHost + ':' + cLocal;
   // ShowMessage(cCaminho);
    result:= cCaminho;

  end;
end;

function TModelFiredacConexao.Diretorio: string;
var
  cDir: string;

begin
  cDir := ExtractFilePath(Application.exeName);
  if Copy(cDir, Length(cDir), 1) <> '\' then
    cDir := cDir + '\';
  Result := cDir;
end;

class function TModelFiredacConexao.New: iModelConexao;
begin
  Result := Self.Create;
end;

end.
