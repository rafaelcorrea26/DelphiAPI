unit Backend.Model.Conexao.Factory;

interface

uses
  Backend.Model.Conexao.Interfaces;

Type
  TTypeConnection = (tpFiredac, tpRestDW);

  TModelConexaoFactory = class(TInterfacedObject, iModelConexaoFactory)
    private
      FTypeConnection : TTypeConnection;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelConexaoFactory;
      function Conexao : iModelConexao;
      function Query : iModelQuery;
  end;

implementation

uses
  Backend.Model.Firedac.Conexao, Backend.Model.Firedac.Query;

{ TModelConexaoFactory }

function TModelConexaoFactory.Conexao: iModelConexao;
begin
  case FTypeConnection of
    tpFiredac: Result := TModelFiredacConexao.New;
  end;
end;

constructor TModelConexaoFactory.Create;
begin 
  FTypeConnection := tpFiredac;
end;

destructor TModelConexaoFactory.Destroy;
begin
  inherited;
end;

function TModelConexaoFactory.Query: iModelQuery;
begin
  case FTypeConnection of
    tpFiredac: Result := TModelFiredacQuery.New(Self.Conexao);
  end;
end;

class function TModelConexaoFactory.New: iModelConexaoFactory;
begin
  Result := Self.Create;
end;

end.
