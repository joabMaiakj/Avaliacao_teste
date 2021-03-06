unit u_cadProdutos;

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
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait;

type
  TcadProdutos = class(TcadBasico)
    qy_dadoscodigo: TFDAutoIncField;
    qy_dadosdescricao: TStringField;
    qy_dadosvalor_venda: TBCDField;
    db_valor_venda: TDBEdit;
    Label8: TLabel;
  function valida: Boolean; override;
  function pesq_complementar: String; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadProdutos: TcadProdutos;

implementation

{$R *.dfm}

{ TcadProdutos }

function TcadProdutos.pesq_complementar: String;
begin
  result:= '';
end;

function TcadProdutos.valida: Boolean;
begin
  result:= true;
  if trim(db_nome.Text) = '' then
  begin
    Showmessage('Nome e obrigatório.');
    result:= False;
    db_nome.SetFocus;
    exit;
  end;
  if trim(db_valor_venda.Text) = '' then
  begin
    Showmessage('Valor Venda e obrigatório.');
    result:= False;
    db_valor_venda.SetFocus;
    exit;
  end;
end;

initialization
    RegisterClass(TcadProdutos);

end.
