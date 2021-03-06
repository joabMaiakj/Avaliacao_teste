unit u_cadPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_cadBasico, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Controller.Connection,
  REST.Response.Adapter, System.JSON;

type
  TcadPedidos = class(TcadBasico)
    qy_dadoscodigo: TFDAutoIncField;
    qy_dadoscliente_codigo: TIntegerField;
    qy_dadosvalor_total: TBCDField;
    lock_clientes: TFDQuery;
    lock_clientescodigo: TFDAutoIncField;
    lock_clientesnome: TStringField;
    qy_dadosnome: TStringField;
    db_cliente: TDBLookupComboBox;
    Label8: TLabel;
    db_valor_total: TDBEdit;
    gb_pedido_itens: TGroupBox;
    gr_itens: TDBGrid;
    lbl_produto: TLabel;
    lbl_quantidade: TLabel;
    lbl_valorUnitario: TLabel;
    lbl_valorTotal: TLabel;
    btn_add: TButton;
    btn_del: TButton;
    pedido_itens: TFDMemTable;
    pedido_itenscodigo: TIntegerField;
    pedido_itenspedidos_codigo: TIntegerField;
    pedido_itensprodutos_codigo: TIntegerField;
    pedido_itensquantidade: TIntegerField;
    pedido_itensvalor_unitario: TCurrencyField;
    pedido_itensvalor_total: TFloatField;
    ds_pedido_itens: TDataSource;
    produtos: TFDMemTable;
    ds_produto: TDataSource;
    produtoscodigo: TIntegerField;
    produtosdescricao: TStringField;
    produtosvalor_venda: TCurrencyField;
    db_codigo_produto: TDBEdit;
    db_descricao_produto: TDBEdit;
    pedido_itensdescricao_produto: TStringField;
    btn_incluir: TButton;
    Label9: TLabel;
    edt_valorUnitario: TDBEdit;
    pedido_itensvalor_venda: TCurrencyField;
    db_quantidade: TDBEdit;
    db_pedido_item_valor_total: TDBEdit;
    qy_dadosdata_emissao: TDateField;
    dt_inicio: TDateTimePicker;
    Label10: TLabel;
    dt_fim: TDateTimePicker;
    Label11: TLabel;
    Label12: TLabel;
    edt_codigo: TEdit;
    procedure btn_pesquisarClick(Sender: TObject);
    procedure componente_foco; override;
    procedure FormCreate(Sender: TObject);
    procedure db_clienteExit(Sender: TObject);
    procedure btn_incluirClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure edt_valorUnitarioExit(Sender: TObject);
    procedure edt_quantidadeExit(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeletaRegistrosTabelasSecundarias; override;
    procedure SalvaTabelasSecundarias;override;
    procedure ac_novoExecute(Sender: TObject);
    procedure ac_SalvarNovoExecute(Sender: TObject);
    procedure gr_itensDblClick(Sender: TObject);
    procedure gr_itensKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    function pesq_complementar: String; override;
    function valida: Boolean; override;
    procedure ac_alterarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure PopulaProdutos;
    procedure PopulaPedidoItens;
    procedure JsonToDataset(Adataset: TDataSet; Ajson: string);
    procedure ValorTotalProduto;
    procedure DeletaItem;
    procedure EditaItem;
    procedure GravaPedidoItens;
    procedure PopulaCamposPedidoItens(var AObject: TJSONObject);
    procedure AcaoBotoesSalvarVoltar;
    function  DataSetToJSON(AdataSet: TDataset): TJSONArray;
    function  ValorTotalPedido: Currency;
    function  SalvaPedidoItens(var AObject: TJSONObject; Aid: Integer): Integer;
    function  DeletaPedidoItens(var AObject: TJSONObject): Boolean;
  public
    { Public declarations }
  end;

var
  cadPedidos: TcadPedidos;

implementation
uses u_funcoes, view.Produto, view.Pedido.Itens;

{$R *.dfm}

procedure TcadPedidos.AcaoBotoesSalvarVoltar;
begin
  pg_principal.ActivePageIndex:= 0;
  menu_cadastro.Enabled := true;
  btn_novo.Visible      := True;
  btn_excluir.Visible   := True;
  btn_alterar.Visible   := True;
  btn_imprimir.Visible  := True;
  btn_cancelar.Visible  := False;
  btn_SalvarNovo.Visible:= False;
  btn_SalvarSair.Visible:= False;
end;

procedure TcadPedidos.ac_alterarExecute(Sender: TObject);
begin
  PopulaPedidoItens;
  inherited;
end;

procedure TcadPedidos.ac_novoExecute(Sender: TObject);
begin
  inherited;
  qy_dados.FieldByName('DATA_EMISSAO').AsDateTime:= date;
  if pedido_itens.Active then
    pedido_itens.EmptyDataSet;
end;

procedure TcadPedidos.ac_SalvarNovoExecute(Sender: TObject);
begin
  inherited;
  if pedido_itens.Active then
    pedido_itens.EmptyDataSet;
end;

procedure TcadPedidos.btn_addClick(Sender: TObject);
begin
  inherited;
  if pedido_itens.State in [dsInsert, dsEdit] then
  begin
    pedido_itens.Post;
    qy_dados.FieldByName('valor_total').AsCurrency:=  ValorTotalPedido;
    btn_incluir.Enabled:= true;
    btn_add.Enabled           := false;
    db_codigo_produto.Enabled := false;
    db_quantidade.Enabled     := false;
    btn_incluir.SetFocus;
  end;
end;

procedure TcadPedidos.btn_delClick(Sender: TObject);
begin
  inherited;
  DeletaItem;
end;

procedure TcadPedidos.btn_pesquisarClick(Sender: TObject);
var
  wl_tipo: String;
  wl_cond1, wl_cond2: String;
  wl_campoDescr: String;
  wl_order: String;
begin
  wl_tipo := '';
  wl_order:= '';

  if cb_tipo.ItemIndex = 0 then wl_campoDescr:= 'p.codigo';
  if cb_tipo.ItemIndex = 1 then wl_campoDescr:= 'p.codigo';

  if cb_order.ItemIndex = 0 then
  begin
    wl_order:= ' ORDER BY '+ wl_campoDescr + ' ASC ';
  end
  else
  begin
      wl_order:= ' ORDER BY '+ wl_campoDescr + ' DESC ';
  end;

  if trim(edt_consulta.Text) = '' then
  begin
    try
      qy_Dados.Close;
      qy_Dados.SQL.Clear;
      qy_Dados.SQL.Add(' select p.codigo, cliente_codigo, valor_total, data_emissao from pedidos p ');
      qy_Dados.SQL.Add(' where '+wl_campoDescr +' = '+ wl_campoDescr + pesq_complementar+ wl_order);
      qy_Dados.open;

      if not qy_Dados.IsEmpty then
        gdr_principal.SetFocus;
    except
      Showmessage('Erro ao consultar a tabela no banco de dados.');
    end;
    exit;
  end
  else if cb_tipo.ItemIndex = 1 then
  begin
    try
      StrToInt(edt_consulta.Text);
    except
      Showmessage('Permitido apenas numeros.');
      edt_consulta.clear;
      edt_consulta.setfocus;
      exit;
    end;
  end
  else
  begin
    if cb_tipo.ItemIndex = 0 then
    begin
    if cb_consulta.ItemIndex = 0 then
    begin
      wl_cond1:= ' = ';
      wl_cond2:= ' ';
    end
    else if cb_consulta.ItemIndex = 1 then
    begin
      wl_cond1:= ' <> ';
      wl_cond2:= ' ';
    end
    else if cb_consulta.ItemIndex = 2 then
    begin
      wl_cond1:='';
      wl_cond2:='%';
    end
    else if cb_consulta.ItemIndex = 3 then
    begin
      wl_cond1:='%';
      wl_cond2:='';
    end
    else if cb_consulta.ItemIndex = 4 then
    begin
      wl_cond1:='%';
      wl_cond2:='%';
    end;

    if (cb_consulta.ItemIndex = 0) or (cb_consulta.ItemIndex = 1) then
      wl_tipo:= ' WHERE '+ wl_campoDescr + wl_cond1 + QuotedStr(edt_consulta.Text)
    else
      wl_tipo:= ' WHERE '+ wl_campoDescr +' LIKE ' + QuotedStr(wl_cond1 + edt_consulta.Text + wl_cond2);
    end
    else
    begin
      wl_tipo:= ' WHERE '+ wl_campoDescr + ' = ' + QuotedStr(edt_consulta.Text);
    end;
    try
      qy_Dados.Close;
      qy_Dados.SQL.Clear;
      qy_Dados.SQL.Add(' select p.codigo, cliente_codigo, valor_total, data_emissao from pedidos p ');
      qy_Dados.SQL.Add( wl_tipo + pesq_complementar+ wl_order);
      qy_Dados.open;
      if not qy_Dados.IsEmpty then
      gdr_principal.SetFocus;
    except
      Showmessage('Erro ao consultar a tabela no banco de dados.');
    end;
  end;
end;

procedure TcadPedidos.btn_incluirClick(Sender: TObject);
begin
  inherited;
  btn_incluir.Enabled       := false;
  btn_add.Enabled           := true;
  db_codigo_produto.Enabled := true;
  db_quantidade.Enabled     := true;
  if db_cliente.Text = '' then
  begin
    Showmessage('Selecione primeiro o cliente.');
    db_cliente.SetFocus;
    btn_incluir.Enabled       := true;
    btn_add.Enabled           := false;
    db_codigo_produto.Enabled := false;
    db_quantidade.Enabled     := false;
    exit;
  end;
  if not pedido_itens.Active then
    pedido_itens.Open;
  pedido_itens.Append;
  pedido_itens.FieldByName('CODIGO').AsInteger:= 0;
  pedido_itens.FieldByName('QUANTIDADE').AsInteger:= 1;
  db_codigo_produto.SetFocus;
end;

procedure TcadPedidos.componente_foco;
begin
  db_cliente.SetFocus;
end;

procedure TcadPedidos.db_clienteExit(Sender: TObject);
begin
  inherited;
  btn_incluir.SetFocus;
end;

procedure TcadPedidos.DeletaItem;
var
  AObject: TJSONObject;
begin
  if messagedlg('Deseja excluir este item ?', mtconfirmation,[mbyes,mbno],0)= idyes then
  Begin
    if pedido_itens.FieldByName('CODIGO').AsInteger > 0 then
    begin
      AObject:= TJSONObject.Create;
      AObject.AddPair(TJSONPair.Create('CODIGO', pedido_itens.FieldByName('CODIGO').AsString));
      AObject.AddPair(TJSONPair.Create('PEDIDOS_CODIGO',  qy_dados.FieldByName('CODIGO').AsString));
      DeletaPedidoItens(AObject);
    end;

    pedido_itens.Delete;
    qy_dados.FieldByName('valor_total').AsCurrency:=  ValorTotalPedido;
  End;
end;

function TcadPedidos.DeletaPedidoItens(var AObject: TJSONObject): Boolean;
Var
  _Class: TPedidos_Itens;
begin
  _Class:= TPedidos_Itens.Create();
  try
    _Class.AssignDelete(AObject);
    result:= _Class.Delete;
  finally
    _Class.Free;
  end;
end;

procedure TcadPedidos.DeletaRegistrosTabelasSecundarias;
var
  AObject: TJSONObject;
begin
  inherited;
  AObject:= TJSONObject.Create;
  AObject.AddPair(TJSONPair.Create('PEDIDOS_CODIGO'  , qy_dados.FieldByName('CODIGO').AsString));
  AObject.AddPair(TJSONPair.Create('CODIGO'          , '0'));
  DeletaPedidoItens(AObject);
end;

procedure TcadPedidos.EditaItem;
begin
  if not pedido_itens.IsEmpty then
  begin
    btn_incluir.Enabled       := false;
    btn_add.Enabled           := true;
    db_codigo_produto.Enabled := true;
    db_quantidade.Enabled     := true;
    pedido_itens.Edit;
    db_quantidade.SetFocus;
  end;
end;

procedure TcadPedidos.edt_quantidadeExit(Sender: TObject);
begin
  inherited;
  ValorTotalProduto;
end;

procedure TcadPedidos.edt_valorUnitarioExit(Sender: TObject);
begin
  inherited;
  ValorTotalProduto;
end;

procedure TcadPedidos.FormCreate(Sender: TObject);
begin
  lock_clientes.Connection := TConnection.GetInstance.Conexao;
  inherited;
  PopulaProdutos;
end;

procedure TcadPedidos.FormShow(Sender: TObject);
begin
  inherited;
  dt_inicio.Date:= date;
  dt_fim.Date   := date;
  btn_pesquisar.Click;
end;

procedure TcadPedidos.GravaPedidoItens;
var
  _AObject: TJSONObject;
begin
  if not pedido_itens.IsEmpty then
  begin
    pedido_itens.First;
    while not pedido_itens.eof do
    begin
      if pedido_itens.FieldByName('CODIGO').AsInteger = 0 then
      begin
        PopulaCamposPedidoItens(_AObject);
        pedido_itens.Edit;
        pedido_itens.FieldByName('CODIGO').AsInteger:= SalvaPedidoItens(_AObject,1);
        pedido_itens.Post;
      end
      else
      begin
        PopulaCamposPedidoItens(_AObject);
        SalvaPedidoItens(_AObject,0);
      end;
      pedido_itens.Next;
    end;
  end;
end;

procedure TcadPedidos.gr_itensDblClick(Sender: TObject);
begin
  inherited;
  EditaItem;
end;

procedure TcadPedidos.gr_itensKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  _naoEdita: Boolean;
begin
  inherited;
  if (Key = VK_DELETE) then
  begin
    DeletaItem;
    exit;
  end;
  if Key = VK_RETURN then
  begin
    EditaItem;
  end;
end;

function TcadPedidos.pesq_complementar: String;
begin
  result:= ' and data_emissao between ' + QuotedStr(FormatDateTime('yyyy/mm/dd',(dt_inicio.Date))) + ' and ' + QuotedStr(FormatDateTime('yyyy/mm/dd',(dt_fim.Date))+' 23:59:59');

  if Trim(edt_codigo.Text) <> '' then
  begin
    result:= result + ' and codigo = '+ edt_codigo.Text;
  end;

end;

procedure TcadPedidos.JsonToDataset(Adataset : TDataSet; Ajson : string);
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) or (aJSON = '[{"Result":0}]')  then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);

  finally
    vConv.Free;
    JObj.Free;
  end;
end;

function TcadPedidos.DataSetToJSON(AdataSet : TDataset) : TJSONArray;
Var
  JObject  : TJSONObject;
  i        : Integer;
begin
  Result   := TJSONArray.Create;
  AdataSet.First;
  while Not(AdataSet.Eof) do
  begin
    JObject := TJSONObject.Create;
    for i := 0 to AdataSet.FieldCount-1 do
      JObject.AddPair(AdataSet.Fields[i].FieldName, TJSONString.Create(AdataSet.Fields[i].AsString));

    Result.AddElement(JObject);
    AdataSet.Next;
  end;

  AdataSet.Free;
end;

procedure TcadPedidos.PopulaCamposPedidoItens(var AObject: TJSONObject);
begin
  AObject:= TJSONObject.Create;
  AObject.AddPair(TJSONPair.Create('CODIGO'          , pedido_itens.FieldByName('CODIGO').AsString));
  AObject.AddPair(TJSONPair.Create('PEDIDOS_CODIGO'  , qy_dados.FieldByName('CODIGO').AsString));
  AObject.AddPair(TJSONPair.Create('PRODUTOS_CODIGO' , pedido_itens.FieldByName('PRODUTOS_CODIGO').AsString));
  AObject.AddPair(TJSONPair.Create('QUANTIDADE'      , pedido_itens.FieldByName('QUANTIDADE').AsString));
  AObject.AddPair(TJSONPair.Create('VALOR_UNITARIO'  , pedido_itens.FieldByName('VALOR_UNITARIO').AsString));
  AObject.AddPair(TJSONPair.Create('VALOR_TOTAL'     , pedido_itens.FieldByName('VALOR_TOTAL').AsString));
end;

procedure TcadPedidos.PopulaPedidoItens;
begin
  if not pedido_itens.Active then
  begin
    pedido_itens.Open;
    pedido_itens.EmptyDataSet;
  end;
  JsonToDataset(pedido_itens, DataSetToJSON(TPedidos_Itens.RetornarRegistros(' where pedidos_codigo = '+ qy_dados.FieldByName('CODIGO').AsString)).ToString);
end;

procedure TcadPedidos.PopulaProdutos;
begin
  JsonToDataset(produtos, DataSetToJSON(TProduto.RetornarRegistros).ToString);
end;

function TcadPedidos.SalvaPedidoItens(var AObject: TJSONObject; Aid: Integer): Integer;
Var
  _Class: TPedidos_Itens;
begin
  _Class:= TPedidos_Itens.Create();
  try
    _Class.Assign(AObject, Aid);
    result:= StrToInt(_Class.Salvar);
  finally
    _Class.Free;
  end;
end;

procedure TcadPedidos.SalvaTabelasSecundarias;
begin
  inherited;
  GravaPedidoItens;
end;

function TcadPedidos.valida: Boolean;
begin
  result:= true;
  if trim(db_cliente.Text) = '' then
  begin
    Showmessage('Cliente e obrigat?rio.');
    result:= False;
    db_nome.SetFocus;
    exit;
  end;
end;

function TcadPedidos.ValorTotalPedido: Currency;
begin
  result  := 0;
  pedido_itens.First;
  pedido_itens.DisableControls;
    while not pedido_itens.Eof do
    begin
      result := result + pedido_itens.FieldByName('VALOR_TOTAL').AsFloat;
      pedido_itens.Next;
    end;
  pedido_itens.EnableControls;
end;

procedure TcadPedidos.ValorTotalProduto;
begin
  pedido_itens.FieldByName('VALOR_UNITARIO').AsCurrency := pedido_itens.FieldByName('VALOR_VENDA').AsCurrency;
  pedido_itens.FieldByName('VALOR_TOTAL').AsCurrency    := pedido_itens.FieldByName('QUANTIDADE').AsCurrency * pedido_itens.FieldByName('VALOR_VENDA').AsCurrency;
end;

initialization
    RegisterClass(TcadPedidos);

end.
