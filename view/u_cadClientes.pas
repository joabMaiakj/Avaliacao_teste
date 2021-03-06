unit u_cadClientes;

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
  TcadClientes = class(TcadBasico)
    qy_dadoscodigo: TFDAutoIncField;
    qy_dadosnome: TStringField;
    qy_dadoscidade: TStringField;
    qy_dadosuf: TStringField;
    db_cidade: TDBEdit;
    Label8: TLabel;
    db_uf: TDBEdit;
    Label9: TLabel;
  function valida: Boolean; override;
  function pesq_complementar: String; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadClientes: TcadClientes;

implementation

{$R *.dfm}

{ TcadClientes }

function TcadClientes.pesq_complementar: String;
begin
  result:= '';
end;

function TcadClientes.valida: Boolean;
begin
  result:= true;
  if trim(db_nome.Text) = '' then
  begin
    Showmessage('Nome e obrigatório.');
    result:= False;
    db_nome.SetFocus;
    exit;
  end;
  if trim(db_cidade.Text) = '' then
  begin
    Showmessage('Cidade e obrigatório.');
    result:= False;
    db_cidade.SetFocus;
    exit;
  end;
  if trim(db_uf.Text) = '' then
  begin
    Showmessage('UF e obrigatório.');
    result:= False;
    db_uf.SetFocus;
    exit;
  end;

end;

initialization
    RegisterClass(TcadClientes);

end.
