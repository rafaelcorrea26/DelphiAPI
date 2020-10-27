program Backend;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.JSON,
  System.sysUtils,
  Backend.Model.Conexao.Factory in 'Model\Backend.Model.Conexao.Factory.pas',
  Backend.Model.Conexao.Interfaces in 'Model\Backend.Model.Conexao.Interfaces.pas',
  Backend.Model.Firedac.Conexao in 'Model\Backend.Model.Firedac.Conexao.pas',
  Backend.Model.Firedac.Query in 'Model\Backend.Model.Firedac.Query.pas',
  uController.Produtos in 'Controller\uController.Produtos.pas';

var
  App: THorse;

begin

  try
    App := THorse.Create;
    App.use(Jhonson);

    TModelFiredacConexao.Create;

    App.Get('/ping',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: Tproc)
      var
        lProdutos: TJSONArray;
      begin
        lProdutos :=  TJSONArray.Create;
        //lProdutos.Add(TJSONObject.Create.AddPair('id',Req.Query['id']));
       // lProdutos.Add(TJSONObject.Create.AddPair('name',Req.Query['name']));
        Res.Send(lProdutos).Status(200);
      end);


    App.Post('/ping',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: Tproc)
      var
        lProduto: TJSONObject;
      begin
        lProduto := Req.Body<TJSONObject>;
        Res.Send(lProduto).Status(201);
      end);

    App.Listen(9000);

  except
    on E: Exception do
    begin
      Writeln('Erro: ' + E.message);
      Readln;
    end;
  end;

end.
