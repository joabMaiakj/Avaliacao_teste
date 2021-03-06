unit view.Pedido.Itens;

interface
Uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
     Data.DB, DBXJSON,System.Json, Datasnap.DSServer, Datasnap.DSAuth,
     Datasnap.DSProviderDataModuleAdapter, Controller.PersistentObject,
     Controller.Atributo, Controller.Connection,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
     FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
     FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;
type
  [Tablename('PEDIDOS_ITENS')]
  TPedidos_Itens = class(TPersintentObject)
    private
      Fcodigo           : Integer;
      Fpedidos_codigo   : Integer;
      Fprodutos_codigo  : Integer;
      Fquantidade       : Integer;
      Fvalor_unitario   : String;
      Fvalor_total      : String;

      function Post: String;
      function valida: Boolean;
    public
      [FieldName('CODIGO','',true,true)]
      property CODIGO         : Integer read FCodigo write FCodigo;
      [FieldName('PEDIDOS_CODIGO','',false,false,true)]
      property PEDIDOS_CODIGO : Integer read Fpedidos_codigo write Fpedidos_codigo;
      [FieldName('PRODUTOS_CODIGO')]
      property PRODUTOS_CODIGO: Integer read Fprodutos_codigo write Fprodutos_codigo;
      [FieldName('QUANTIDADE')]
      property QUANTIDADE: Integer read Fquantidade write Fquantidade;
      [FieldName('VALOR_UNITARIO')]
      property VALOR_UNITARIO : String read Fvalor_unitario write Fvalor_unitario;
      [FieldName('VALOR_TOTAL')]
      property VALOR_TOTAL    : String read Fvalor_total write Fvalor_total;

      class function RetornarRegistros(Acond: String = '')   : TDataSet;
      class function RetornarRegistroById(AId: Integer)      : TDataSet;

      function  Salvar: String;
      function  Excluir: Boolean;
      procedure Assign(json : TJSONObject; Atipo: Integer);
      procedure AssignDelete(json : TJSONObject);
      procedure Load(const AValue: Integer; ACampoFK: String = ''); override;
  end;

  var
    Pedidos_Itens: TPedidos_Itens;

implementation
  uses u_admPrincipal, u_dicionarioDados;
{ TProduto }

function TPedidos_Itens.Post: String;
begin
  result:= Insert;
end;

procedure TPedidos_Itens.Assign(json : TJSONObject; Atipo: Integer);
begin
  if Atipo <> 1 then
    CODIGO := json.GetValue('CODIGO').Value.ToInteger;

  PEDIDOS_CODIGO := json.GetValue('PEDIDOS_CODIGO').Value.ToInteger;
  PRODUTOS_CODIGO:= json.GetValue('PRODUTOS_CODIGO').Value.ToInteger;
  QUANTIDADE     := json.GetValue('QUANTIDADE').Value.ToInteger;
  VALOR_UNITARIO := StringReplace(json.GetValue('VALOR_UNITARIO').ToString, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  VALOR_TOTAL    := StringReplace(json.GetValue('VALOR_TOTAL').ToString, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TPedidos_Itens.AssignDelete(json : TJSONObject);
begin
  PEDIDOS_CODIGO := json.GetValue('PEDIDOS_CODIGO').Value.ToInteger;
  CODIGO         := json.GetValue('CODIGO').Value.ToInteger;
end;

function TPedidos_Itens.Excluir: Boolean;
begin
  Result:= Delete;
end;

procedure TPedidos_Itens.Load(const AValue: Integer; ACampoFK: String);
begin
  inherited load;
end;

class function TPedidos_Itens.RetornarRegistroById(AId: Integer)      : TDataSet;
Var
  _Query : TFDQuery;
begin
  _Query := TFDQuery.Create(TConnection.GetInstance.Conexao);
  try
    _Query.Connection := TConnection.GetInstance.Conexao;
    _Query.SQL.Clear;
    _Query.SQL.Add(cs_pedido_itens);
    _Query.SQL.Add(' where codigo = :codigo  ');
    _Query.ParamByName('codigo').AsInteger :=  AId;
    _Query.Open;
  except on E: Exception do
  end;
  Result := _Query;
end;

class function TPedidos_Itens.RetornarRegistros(Acond: String = ''): TDataSet;
Var
  _Query : TFDQuery;
begin
  _Query := TFDQuery.Create(TConnection.GetInstance.Conexao);
  try
    _Query.Connection := TConnection.GetInstance.Conexao;
    _Query.SQL.Clear;
    _Query.SQL.Text := cs_pedido_itens + Acond;
    _Query.Open;
  except on E: Exception do
  end;
  Result := _Query;
end;

function TPedidos_Itens.Salvar  : String;
begin
  if valida then
  begin
    if CODIGO > 0 then
      Result:= Update
    else
      Result:= Post();
  end;
end;

function TPedidos_Itens.valida: Boolean;
begin
  result:= true;
end;

end.
