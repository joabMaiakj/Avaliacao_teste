unit u_admPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, Controller.connection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TadmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Postos1: TMenuItem;
    N1: TMenuItem;
    Combustiveis1: TMenuItem;
    Movimentao1: TMenuItem;
    Abastecimento1: TMenuItem;
    Relatrios1: TMenuItem;
    Geralporperodo1: TMenuItem;
    Sobre1: TMenuItem;
    Verso101: TMenuItem;
    tm_DataHora: TTimer;
    ac_formularios: TActionList;
    ac_clientes: TAction;
    ac_produtos: TAction;
    ac_pedidos: TAction;
    pnl_menu: TPanel;
    btn_pedidos: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ac_gerar_banco: TAction;
    bancoDados_script: TFDQuery;
    pnl_base_dados: TPanel;
    sb_principal: TScrollBox;
    Label1: TLabel;
    btn_sim: TButton;
    btn_nao: TButton;
    lbl_fim_processo: TLabel;
    btn_fechar: TButton;
    clientes_script: TFDQuery;
    Panel1: TPanel;
    ck_01: TCheckBox;
    ck_02: TCheckBox;
    ck_03: TCheckBox;
    ck_04: TCheckBox;
    ck_05: TCheckBox;
    ck_06: TCheckBox;
    ck_07: TCheckBox;
    cliente_insert_script: TFDQuery;
    produtos_script: TFDQuery;
    produto_insert_script: TFDQuery;
    pedido_script: TFDQuery;
    pedido_itens_script: TFDQuery;
    Action1: TAction;
    procedure tm_DataHoraTimer(Sender: TObject);
    procedure ac_gerar_bancoExecute(Sender: TObject);
    procedure btn_simClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_naoClick(Sender: TObject);
    procedure ac_clientesExecute(Sender: TObject);
    procedure ac_produtosExecute(Sender: TObject);
    procedure ac_pedidosExecute(Sender: TObject);
  private
    { Private declarations }
    procedure fechar_comandos;
  public
    { Public declarations }
  end;

var
  admPrincipal: TadmPrincipal;

implementation
uses
  u_dicionarioDados, u_funcoes;

{$R *.dfm}

procedure TadmPrincipal.ac_clientesExecute(Sender: TObject);
begin
   AbriFormularios('cadClientes', 1);
end;

procedure TadmPrincipal.ac_gerar_bancoExecute(Sender: TObject);
begin
  try
    btn_pedidos.Enabled             := false;
    bancoDados_script.Connection    := TConnection.GetInstance.Conexao;
    clientes_script.Connection      := TConnection.GetInstance.Conexao;
    cliente_insert_script.Connection:= TConnection.GetInstance.Conexao;
    produtos_script.Connection      := TConnection.GetInstance.Conexao;
    produto_insert_script.Connection:= TConnection.GetInstance.Conexao;
    pedido_script.Connection        := TConnection.GetInstance.Conexao;
    pedido_itens_script.Connection  := TConnection.GetInstance.Conexao;
  finally
    pnl_base_dados.Visible:= true;
  end;

end;

procedure TadmPrincipal.ac_pedidosExecute(Sender: TObject);
begin
  AbriFormularios('cadPedidos', 1);
end;

procedure TadmPrincipal.ac_produtosExecute(Sender: TObject);
begin
  AbriFormularios('cadProdutos', 1);
end;

procedure TadmPrincipal.btn_fecharClick(Sender: TObject);
begin
  fechar_comandos;
end;

procedure TadmPrincipal.btn_naoClick(Sender: TObject);
begin
  fechar_comandos;
end;

procedure TadmPrincipal.btn_simClick(Sender: TObject);
begin
  try
    try
      try
        bancoDados_script.ExecSQL;
      finally
        ck_01.Checked:= true;
      end;
    except
      ck_01.Checked:= false;
    end;

    try
      try
        clientes_script.ExecSQL;
      finally
        ck_02.Checked:= true;
      end;
    except
      ck_02.Checked:= false;
    end;

    try
      try
        cliente_insert_script.ExecSQL;
      finally
        ck_03.Checked:= true;
      end;
    except
      ck_03.Checked:= false;
    end;

    try
      try
        produtos_script.ExecSQL;
      finally
        ck_04.Checked:= true;
      end;
    except
      ck_04.Checked:= false;
    end;

    try
      try
        produto_insert_script.ExecSQL;
      finally
        ck_05.Checked:= true;
      end;
    except
      ck_05.Checked:= false;
    end;

    try
      try
        pedido_script.ExecSQL;
      finally
        ck_06.Checked:= true;
      end;
    except
      ck_06.Checked:= false;
    end;

    try
      try
        pedido_itens_script.ExecSQL;
      finally
        ck_07.Checked:= true;
      end;
    except
      ck_07.Checked:= false;
    end;
  finally
    lbl_fim_processo.Visible:= true;
    btn_fechar.Visible      := true;
  end;
end;

procedure TadmPrincipal.fechar_comandos;
begin
  ac_pedidos.Enabled    := true;
  ac_produtos.Enabled   := true;
  ac_clientes.Enabled   := true;
  pnl_base_dados.Visible:= false;
end;

procedure TadmPrincipal.tm_DataHoraTimer(Sender: TObject);
begin
  Statusbar1.Panels [1].Text := ' '+FormatDateTime ('dddd", "dd" de "mmmm" de "yyyy',now);// para data
  statusbar1.Panels [3].Text := ' '+FormatDateTime ('hh:mm:ss',now);
end;

end.
