unit view.Produto;

interface
Uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
     Data.DB, DBXJSON,System.Json, Datasnap.DSServer, Datasnap.DSAuth,
     Datasnap.DSProviderDataModuleAdapter, Controller.PersistentObject,
     Controller.Atributo, Controller.Connection,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
     FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
     FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;
type
  [Tablename('PRODUTOS')]
  TProduto = class(TPersintentObject)
    private
      FCodigo         : Integer;
      FDescricao      : String;
      FValor_Venda    : String;

      function Post: String;
      function valida: Boolean;
    public
      [FieldName('CODIGO','',true,true)]
      property CODIGO         : Integer read FCodigo write FCodigo;
      [FieldName('DESCRICAO')]
      property DESCRICAO      : String read FDescricao write FDescricao;
      [FieldName('VALOR_VENDA')]
      property VALOR_VENDA : String read FValor_Venda write FValor_Venda;

      class function RetornarRegistros(Acond: String = '')   : TDataSet;
      class function RetornarRegistroById(AId: Integer)      : TDataSet;
      class function RetornarProdutoValorUnitario(AId_Produto: Integer) : TJSONArray;

      function  Salvar: String;
      function  Excluir: Boolean;
      procedure Assign(json : TJSONObject; Atipo: Integer);
      procedure Load(const AValue: Integer; ACampoFK: String = ''); override;
  end;

  var
    Produto: TProduto;

implementation
  uses u_admPrincipal, u_dicionarioDados;
{ TProduto }

function TProduto.Post: String;
begin
  result:= Insert;
end;

class function TProduto.RetornarProdutoValorUnitario(AId_Produto: Integer) : TJSONArray;
Var
  _Query : TFDQuery;
begin
  _Query := TFDQuery.Create(TConnection.GetInstance.Conexao);
  try
    _Query.Connection := TConnection.GetInstance.Conexao;
    _Query.SQL.Clear;
    _Query.SQL.Add(' select row_to_json(t) AS RESULT           ');
    _Query.SQL.Add(' from (                                    ');
    _Query.SQL.Add(cs_produto_valor_unitario_sql                );
    _Query.SQL.Add(' where id_produto = '+ IntToStr(AId_Produto));
    _Query.SQL.Add(' ) AS t'                                    );
    _Query.Open;
  except on E: Exception do
  end;
  Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(UTF8ToString('['+_Query.FieldByName('RESULT').AsString)+']'), 0) as TJSONArray;
end;

procedure TProduto.Assign(json : TJSONObject; Atipo: Integer);
begin
  if Atipo <> 1 then
    CODIGO := json.GetValue('ID_PRODUTO').Value.ToInteger;

  DESCRICAO     := json.GetValue('DESCRICAO').ToString;
  VALOR_VENDA   := StringReplace(json.GetValue('VALOR_UNITARIO').ToString, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

function TProduto.Excluir: Boolean;
begin
  Result:= Delete;
end;

procedure TProduto.Load(const AValue: Integer; ACampoFK: String);
begin
  inherited load;
end;

class function TProduto.RetornarRegistroById(AId: Integer)      : TDataSet;
Var
  _Query : TFDQuery;
begin
  _Query := TFDQuery.Create(TConnection.GetInstance.Conexao);
  try
    _Query.Connection := TConnection.GetInstance.Conexao;
    _Query.SQL.Clear;
    _Query.SQL.Add(cs_produtos_sql);
    _Query.SQL.Add(' where id_produto = :id_produto  ');
    _Query.ParamByName('id_produto').AsInteger :=  AId;
    _Query.Open;
  except on E: Exception do
  end;
  Result := _Query;
end;

class function TProduto.RetornarRegistros(Acond: String = ''): TDataSet;
Var
  _Query : TFDQuery;
begin
  _Query := TFDQuery.Create(TConnection.GetInstance.Conexao);
  try
    _Query.Connection := TConnection.GetInstance.Conexao;
    _Query.SQL.Clear;
    _Query.SQL.Text := cs_produtos_sql + Acond;
    _Query.Open;
  except on E: Exception do
  end;
  Result := _Query;
end;

function TProduto.Salvar  : String;
begin
  if valida then
  begin
    if CODIGO > 0 then
      Result:= Update
    else
      Result:= Post();
  end;
end;

function TProduto.valida: Boolean;
begin
  result:= true;
  if DESCRICAO = '' then
  begin
    result:= false;
    exit;
  end;
end;

end.
