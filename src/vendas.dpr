program vendas;

uses
  Vcl.Forms,
  u_admPrincipal in '..\view\u_admPrincipal.pas' {admPrincipal},
  u_dicionarioDados in '..\funcoes e classes\u_dicionarioDados.pas',
  u_funcoes in '..\funcoes e classes\u_funcoes.pas',
  Controller.ConfigBanco in '..\controller\Controller.ConfigBanco.pas',
  Controller.Connection in '..\controller\Controller.Connection.pas',
  Controller.PersistentObject in '..\controller\Controller.PersistentObject.pas',
  Controller.Atributo in '..\controller\Controller.Atributo.pas',
  u_cadBasico in '..\view\u_cadBasico.pas' {cadBasico},
  u_cadProdutos in '..\view\u_cadProdutos.pas' {cadProdutos},
  u_cadClientes in '..\view\u_cadClientes.pas' {cadClientes},
  u_cadPedidos in '..\view\u_cadPedidos.pas' {cadPedidos},
  view.Produto in '..\view\view.Produto.pas',
  view.Pedido.Itens in '..\view\view.Pedido.Itens.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TadmPrincipal, admPrincipal);
  Application.Run;
end.
