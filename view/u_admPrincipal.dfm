object admPrincipal: TadmPrincipal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o '
  ClientHeight = 448
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 425
    Width = 766
    Height = 23
    Panels = <
      item
        Text = ' Data: '
        Width = 35
      end
      item
        Width = 200
      end
      item
        Text = 'Hora: '
        Width = 40
      end
      item
        Width = 55
      end
      item
        Text = 'Usu'#225'rio : ADMINISTRADOR'
        Width = 300
      end
      item
        Text = 'Servidor: LOCAL'
        Width = 150
      end
      item
        Text = 'Banco de dados: POSTO'
        Width = 50
      end>
  end
  object pnl_menu: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 63
    Align = alTop
    TabOrder = 1
    object btn_pedidos: TSpeedButton
      Left = 343
      Top = 8
      Width = 138
      Height = 49
      Cursor = crHandPoint
      Action = ac_pedidos
    end
    object SpeedButton2: TSpeedButton
      Left = 6
      Top = 8
      Width = 331
      Height = 49
      Cursor = crHandPoint
      Action = ac_gerar_banco
    end
  end
  object pnl_base_dados: TPanel
    Left = 0
    Top = 63
    Width = 337
    Height = 362
    Align = alLeft
    TabOrder = 2
    Visible = False
    object sb_principal: TScrollBox
      Left = 1
      Top = 1
      Width = 335
      Height = 360
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 8
        Width = 306
        Height = 13
        Caption = 'Este processo lipara todo o banco. Deseja Prosseguir:  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_fim_processo: TLabel
        Left = 12
        Top = 248
        Width = 142
        Height = 19
        Caption = 'Fim do Processo: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object btn_sim: TButton
        Left = 12
        Top = 27
        Width = 58
        Height = 25
        Cursor = crHandPoint
        Caption = 'Sim'
        TabOrder = 0
        OnClick = btn_simClick
      end
      object btn_nao: TButton
        Left = 76
        Top = 27
        Width = 58
        Height = 25
        Cursor = crHandPoint
        Caption = 'N'#227'o'
        TabOrder = 1
        OnClick = btn_naoClick
      end
      object btn_fechar: TButton
        Left = 156
        Top = 242
        Width = 62
        Height = 25
        Cursor = crHandPoint
        Caption = 'Fechar'
        TabOrder = 2
        Visible = False
        OnClick = btn_fecharClick
      end
      object Panel1: TPanel
        Left = 5
        Top = 54
        Width = 329
        Height = 178
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 3
        object ck_01: TCheckBox
          Left = 9
          Top = 14
          Width = 219
          Height = 17
          Caption = 'Cliando Banco de Dados'
          TabOrder = 0
        end
        object ck_02: TCheckBox
          Left = 9
          Top = 37
          Width = 219
          Height = 17
          Caption = 'Cliando tabela de Clientes'
          TabOrder = 1
        end
        object ck_03: TCheckBox
          Left = 9
          Top = 60
          Width = 219
          Height = 17
          Caption = 'Inserindo 20 registros na tabela de Clientes'
          TabOrder = 2
        end
        object ck_04: TCheckBox
          Left = 9
          Top = 83
          Width = 219
          Height = 17
          Caption = 'Cliando tabela de Produtos'
          TabOrder = 3
        end
        object ck_05: TCheckBox
          Left = 9
          Top = 106
          Width = 253
          Height = 17
          Caption = 'Inserindo 20 registros na tabela de Produtos'
          TabOrder = 4
        end
        object ck_06: TCheckBox
          Left = 9
          Top = 129
          Width = 219
          Height = 17
          Caption = 'Cliando tabela de Pedidos'
          TabOrder = 5
        end
        object ck_07: TCheckBox
          Left = 9
          Top = 152
          Width = 219
          Height = 17
          Caption = 'Cliando tabela de Itens do Pedido'
          TabOrder = 6
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 536
    Top = 136
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Postos1: TMenuItem
        Action = ac_clientes
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Combustiveis1: TMenuItem
        Action = ac_produtos
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Abastecimento1: TMenuItem
        Action = ac_pedidos
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios '
      object Geralporperodo1: TMenuItem
        Caption = 'Abastecimento por per'#237'odo'
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
      object Verso101: TMenuItem
        Caption = 'Vers'#227'o 1.0'
      end
    end
  end
  object tm_DataHora: TTimer
    OnTimer = tm_DataHoraTimer
    Left = 544
    Top = 248
  end
  object ac_formularios: TActionList
    Left = 536
    Top = 192
    object ac_clientes: TAction
      Caption = 'Clientes'
      Enabled = False
      OnExecute = ac_clientesExecute
    end
    object ac_produtos: TAction
      Caption = 'Produtos'
      Enabled = False
      OnExecute = ac_produtosExecute
    end
    object ac_pedidos: TAction
      Caption = 'Pedidos'
      Enabled = False
      OnExecute = ac_pedidosExecute
    end
    object ac_gerar_banco: TAction
      Caption = 'Antes de come'#231'a clique aqui para gerar o Banco de Dados'
      OnExecute = ac_gerar_bancoExecute
    end
    object Action1: TAction
      Caption = 'Action1'
    end
  end
  object bancoDados_script: TFDQuery
    SQL.Strings = (
      'DROP database IF EXISTS vendas;'#10#10
      'create database vendas;')
    Left = 280
    Top = 104
  end
  object clientes_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      'DROP TABLE IF EXISTS clientes;'
      
        #10#10'CREATE TABLE clientes ('#10'    codigo int NOT NULL AUTO_INCREMENT' +
        ','#10'    nome   varchar(200) NOT NULL,'#10'    cidade varchar(100),'#10'   ' +
        ' uf     varchar(2),'#10'    PRIMARY KEY (codigo)'#10');'#10
      'CREATE INDEX idx_clientes_codigo ON clientes(codigo);')
    Left = 280
    Top = 160
  end
  object cliente_insert_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      
        #10'INSERT INTO clientes (nome,cidade, uf) VALUES ('#39'JO'#195'O MARIA JOS'#201 +
        #39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nome,cidade, uf) VAL' +
        'UES ('#39'FRANCISCO DA SILVA'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO client' +
        'es (nome,cidade, uf) VALUES ('#39'ELIAS MAIA '#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'I' +
        'NSERT INTO clientes (nome,cidade, uf) VALUES ('#39'JO'#195'O DA SILVA'#39','#39'F' +
        'ORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nome,cidade, uf) VALUES ' +
        '('#39'APARECIDA COSTA'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nom' +
        'e,cidade, uf) VALUES ('#39'DEBORA MAIA'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT I' +
        'NTO clientes (nome,cidade, uf) VALUES ('#39'FERNANDA DA SILVA COSTA'#39 +
        ','#39'S'#195'O PAULO'#39', '#39'SP'#39');'#10'INSERT INTO clientes (nome,cidade, uf) VALU' +
        'ES ('#39'FIRMINDO DA SILVA'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes' +
        ' (nome,cidade, uf) VALUES ('#39'LUCAS LIMA'#39','#39'RIO DE JANEIRO'#39', '#39'RJ'#39');' +
        #10'INSERT INTO clientes (nome,cidade, uf) VALUES ('#39'ROBERTO CARLOS'#39 +
        ','#39'S'#195'O PAULO'#39', '#39'SP'#39');'#10'INSERT INTO clientes (nome,cidade, uf) VALU' +
        'ES ('#39'ANA MARIA BRAGA'#39','#39'S'#195'O PAULO'#39', '#39'SP'#39');'#10'INSERT INTO clientes (' +
        'nome,cidade, uf) VALUES ('#39'FERNANDA VASCONCELOS'#39','#39'S'#195'O PAULO'#39', '#39'SP'
      
        #39');'#10'INSERT INTO clientes (nome,cidade, uf) VALUES ('#39'IVANILDE DA ' +
        'COSTA BARROS'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nome,cid' +
        'ade, uf) VALUES ('#39'DOUGLAS BASTOS'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INT' +
        'O clientes (nome,cidade, uf) VALUES ('#39'ESCARLETE DA FONSECA'#39','#39'FOR' +
        'TALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nome,cidade, uf) VALUES ('#39 +
        'KATIA CARVALHO'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO clientes (nome,c' +
        'idade, uf) VALUES ('#39'MARIA JOSE'#39','#39'FORTALEZA'#39', '#39'CE'#39');'#10'INSERT INTO ' +
        'clientes (nome,cidade, uf) VALUES ('#39'MARIA DAS GRA'#199'AS DA SILVA CO' +
        'STA'#39','#39'S'#195'O PAULO'#39', '#39'SP'#39');'#10'INSERT INTO clientes (nome,cidade, uf) ' +
        'VALUES ('#39'HENRI CASTELLLI'#39','#39'RIO DE JANEIRO'#39', '#39'SP'#39');'#10'INSERT INTO c' +
        'lientes (nome,cidade, uf) VALUES ('#39'JOS'#201' DA SILVA COSTA'#39','#39'FORTALE' +
        'ZA'#39', '#39'CE'#39');')
    Left = 280
    Top = 216
  end
  object produtos_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      'DROP TABLE IF EXISTS produtos;'#10#10
      
        'CREATE TABLE produtos ('#10'    codigo int NOT NULL AUTO_INCREMENT,'#10 +
        '    descricao   varchar(200) NOT NULL,'#10'    valor_venda numeric(1' +
        '0,2) default(0),'#10'    PRIMARY KEY (codigo)'#10');'#10'CREATE INDEX idx_pr' +
        'odutos_codigo ON produtos(codigo);'#10'CREATE INDEX idx_produtos_des' +
        'cricao ON produtos(descricao);')
    Left = 280
    Top = 272
  end
  object produto_insert_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SABONETE D' +
        'OVE'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DESODORANT' +
        'E DOVE'#39',7.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SHAMPO DOV' +
        'E'#39',9);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'ESCOVA DE ' +
        'DENTES INFANTIL DISNEY'#39',5.40);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DESIFETANT' +
        'E ALOUE JASMIN'#39',5.60);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DESIFETANT' +
        'E ALOUE PERSEGO'#39',5.60);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DESIFETANT' +
        'E ALOUE ALOI VERA'#39',5.60);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DESIFETANT' +
        'E ALOUE ALOI IGUATEMI'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'PAPEL HIGI' +
        'ENICO FOFO PLUS'#39',8);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SABONETE R' +
        'EXONA'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SABONETE A' +
        'LMA DE FLORES'#39',4.30);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'ESCOVA DE ' +
        'CABELO'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'PENTE'#39',2.5' +
        '0);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SAB'#195'O OMO ' +
        '2KG'#39',8.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'SAB'#195'O LIQU' +
        'IDO OMO'#39',10);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DETERGENTE' +
        ' IPY MA'#199#195#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DETERGENTE' +
        ' IPY LIM'#195'O'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'DETERGENTE' +
        ' IPY COCO'#39',2.50);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'PAPEL TOAL' +
        'HA'#39',5);'
      
        'INSERT INTO produtos (descricao,valor_venda) VALUES ('#39'LIMPADOR D' +
        'E VIDROS IPY'#39',7.50);')
    Left = 280
    Top = 328
  end
  object pedido_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      'DROP TABLE IF EXISTS pedidos cascade;'
      #10'CREATE TABLE pedidos ('#10'   '
      ' codigo int NOT NULL AUTO_INCREMENT,'#10'    '
      'cliente_codigo int NOT NULL,'#10'   '
      'data_emissao date NOT NULL, '
      'valor_total numeric(10,2) default(0),'#10'    '
      'PRIMARY KEY (codigo),'#10'    '
      
        'foreign key (cliente_codigo) references clientes(codigo)'#10');'#10'CREA' +
        'TE INDEX idx_pedidos_codigo ON pedidos(codigo);')
    Left = 368
    Top = 104
  end
  object pedido_itens_script: TFDQuery
    SQL.Strings = (
      'use vendas;'
      'DROP TABLE IF EXISTS pedidos_itens cascade;'
      #10#10'CREATE TABLE pedidos_itens ('#10'    '
      'codigo int NOT NULL AUTO_INCREMENT,'#10'   '
      ' pedidos_codigo int NOT NULL,'#10'   '
      ' produtos_codigo int NOT NULL,'#10'    '
      ' quantidade      int NOT NULL,'
      'valor_unitario numeric(10,2) NOT NULL,'#10'    '
      'valor_total    numeric(10,2) NOT NULL,'#10'    '
      'PRIMARY KEY (codigo),'#10'   '
      
        ' foreign key (produtos_codigo) references produtos(codigo),'#10'    ' +
        'foreign key (pedidos_codigo) references pedidos(codigo)'#10');'#10'CREAT' +
        'E INDEX idx_pedidos_itens_codigo ON pedidos_itens(codigo);'#10)
    Left = 368
    Top = 160
  end
end
