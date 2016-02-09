unit uDictionary;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, system.Generics.Collections,
  RTTI, TypInfo, IDGlobal, IDCoderMime, Character,
  System.uJson,
  Vcl.StdCtrls, System.JSON;

type

  TCliente = Class(TInterfacedObject)
    codigo:integer;
    nome:string;
    function ToString:String;
    function Json:string;
  end;

  TForm25 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FLista:TDictionary<TCliente,string>;
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

{$R *.dfm}

procedure TForm25.Button1Click(Sender: TObject);
var i:integer;
    cli:TCliente;
    js:string;
    j:TJSONObject;
begin
   //for i := 1 to 100 do
   begin
     cli := TCliente.Create;
     try
       cli.codigo := 1;
       cli.nome := 'Cliente '+i.ToString();
       FLista.Add( cli,cli.nome   );
       js := cli.Json;
       memo1.Lines.Add( cli.Json );
     finally
       cli.free;
     end;
   end;

   j := TJsonObject.Parse(js);

   cli := j.asObject as TCliente;

   cli.nome := '********'+cli.nome;
   memo1.Lines.Add( cli.Json );


end;

procedure TForm25.FormCreate(Sender: TObject);
begin
  FLista := TDictionary<TCliente,string>.create();
end;


{ TCliente }

function TCliente.Json: string;
begin
  result :=  TJSONObject.FromObject(self).ToString;
end;

function TCliente.ToString: String;
begin
//   result := TJSONObject.construct(self).ToString;
end;

{ TJSONObjectHelper }

{ TObjectHelper }


end.
