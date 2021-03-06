unit u_dicionarioDados;

interface
uses
    System.SysUtils;
const
   //Valores Default
    cs_string_branco = '''''';
    cs_valor_id_defalt = 0;

    cs_produtos_sql               = ' select * from produtos ';
    cs_pedido_itens               = ' select pi.*, pr.descricao as descricao_produto from pedidos_itens pi '+
                                    ' join produtos pr on pr.codigo = pi.produtos_codigo ';
    cs_produto_valor_unitario_sql = 'select valor_unitario from produtos ';

type
  TResultArray = array [1..5] of string;
  function DadosFormulario(p_tag: integer): TResultArray;

implementation

function DadosFormulario(p_tag: integer): TResultArray;
var
  Vet : TResultArray;
begin
  case p_tag of
    1 :
      begin
        Vet[1]:= 'CLIENTES';
        Vet[2]:= 'NOME';
        Vet[3]:= 'CODIGO';
        Vet[4]:= 'true';
        vet[5]:= 'CADASTRO DE CLIENTES';
      end;
    2 :
      begin
        Vet[1]:= 'PRODUTOS';
        Vet[2]:= 'DESCRICAO';
        Vet[3]:= 'CODIGO';
        Vet[4]:= 'true';
        vet[5]:= 'CADASTRO DE PRODUTOS';
      end;
    3 :
      begin
        Vet[1]:= 'PEDIDOS';
        Vet[2]:= 'DESCRICAO';
        Vet[3]:= 'CODIGO';
        Vet[4]:= 'true';
        vet[5]:= 'PEDIDOS';
      end;
    4 :
      begin
        Vet[1]:= 'PEDIDOS_ITENS';
        Vet[2]:= 'DESCRICAO';
        Vet[3]:= 'CODIGO';
        Vet[4]:= 'true';
        vet[5]:= 'ITENS DO PEDIDO';
      end;
  end;
  result:= Vet;
end;

end.
