unit uFutureTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
    FLock: TObject;
  public
    { Public declarations }
    procedure msg(texto: string);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses DB, System.Threading;

var
  iConta: integer;


procedure TForm2.Button1Click(Sender: TObject);
var
  f: IFuture<boolean>;

  f1: IFuture<string>;

begin

  f1 := TTask.Future<string>(
    function: string
    var
      i: integer;
    begin
      for i := 0 to 100 do
      begin
        sleep(100);
        // msg('Loop '+i.toString);
      end;
      // faz alguma coisa
      result := '-ok-'; // retorna um boolean
      // result := false;
    end);

  msg(f1.Value);

  f := TTask.Future<boolean>(
    function: boolean
    var
      i: integer;
    begin
      for i := 0 to 100 do
      begin
        sleep(100);
        // msg('Loop '+i.toString);
      end;
      // faz alguma coisa
      result := true; // retorna um boolean
      // result := false;
    end);

  if f.Value then // aguarda o retorno da thread (funcao);
    msg('ok')
  else
    msg('falhou');

end;

type
  TAttributo = record
    nome: string;
    ordem: integer;
  end;

procedure TForm2.Button2Click(Sender: TObject);
var
  f: IFuture<TAttributo>;

begin

  f := TTask.Future<TAttributo>(
    function: TAttributo
    begin
      // faz alguma coisa
      result.nome := 'Retornou'; // retorna um atributo
      result.ordem := 9999;
    end);

  if f.Value.ordem > 0 then // aguarda o retorno da thread (funcao);
    msg(f.Value.nome + IntTostr(f.Value.ordem))
  else
    msg('falhou');

end;

procedure TForm2.Button3Click(Sender: TObject);
var
  f1, f2, f3: ITask;
begin
  f1 := TTask.Create(
    procedure
    begin
      // executa alguma coisa em paralelo
      msg('Teste F1');
    end);
  f1.Start; // inicia a execu��o da thread F1

  f2 := TTask.Create(
    procedure
    begin
      // executa alguma coisa em paralelo
      msg('Teste F2');
    end);
  f2.Start; // inicia a execu��o da thread F2

  f3 := TTask.run(
    procedure
    begin
      // executa alguma coisa em paralelo
      msg('Teste F3');
    end);

  msg('Wait All ' + IntTostr(iConta));

  // opcional
  TTask.WaitForAll([f1, f2, f3], 60000);
  // aguarda que todas as threads sejam executadas
  msg('finished ' + IntTostr(iConta));

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  TThread.Queue(TThread.CurrentThread,
  // poe na fila para executa��o posterior e usa syncronize
    procedure
    begin
      inc(iConta);
      Memo1.Lines.Add('I: ' + IntTostr(iConta));
    end);
end;

Type
  TThreadTeste = class(TThread)
  public
    frm: TForm2;
    procedure execute; override;
  end;

procedure TForm2.Button5Click(Sender: TObject);
var
  f: TThread;
begin
  // Thread sem Syncronize
  f := TThread.CreateAnonymousThread(
    procedure
    begin
      msg('Anonimous ' + IntTostr(iConta));
    end);
  f.Start;

  TTask.run(
    procedure
    begin
      msg('Run ' + IntTostr(iConta));
    end);

  with TThreadTeste.Create(true) do
    try
      FreeOnTerminate := true;
      frm := self;
      Start;
    finally

    end;

end;

procedure TForm2.Button6Click(Sender: TObject);
var
  f1, f2: ITask;
begin
  f1 := TTask.Create(
    procedure
    begin
      // executa alguma coisa em paralelo
      msg('Teste F1');
    end);
  f1.Start; // inicia a execu��o da thread F1

  f2 := TTask.Create(
    procedure
    begin
      // executa alguma coisa em paralelo
      sleep(1000);
      msg('Teste F2');
    end);
  f2.Start; // inicia a execu��o da thread F2

  msg('Wait Any ' + IntTostr(iConta));

  // opcional  --  nao disponivel no XE6
  { .$ifdef VER280 }
  TTask.WaitForAny([f1, f2]); // aguarda pelo menos 1 thread concluida.
  { .$endif }
  msg('finished ' + IntTostr(iConta));

end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  TParallel.For(100, 105,
    procedure(i: integer)
    begin
      msg('Parallel: ' + IntTostr(i));
    end);
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  Button1.Click;
  Button2.Click;
  Button3.Click;
  Button4.Click;
  Button5.Click;
  Button6.Click;
  Button7.Click;
end;

Type
  TDatasetHelper = class helper for TDataset
  public
    procedure DoLoop(proc: TProc);
    function FuncDoLoop<T>(  func:TFunc<T>  ):T;
  end;

function TDatasetHelper.FuncDoLoop<T>(  func:TFunc<T>  ):T;
begin
    result :=   func;
end;


procedure TDatasetHelper.DoLoop(proc: TProc);
var book:TBookmark;
begin
    book := GetBookmark;
    try
       first;
       while not eof do
       begin
           proc;
           next;
       end;

    finally
       GotoBookmark(book);
       FreeBookmark(book);
    end;
end;



procedure TForm2.Button10Click(Sender: TObject);
var  func:TFunc<boolean>;
    ds:TDataset;
begin
    func := ds.FuncDoLoop<boolean>(
    function :boolean begin
    end );
end;
{var qry:TDataset;
   i:integer;
begin
    qry.doLoop(
    procedure begin
       inc(i);

    end );
end;
}

procedure TForm2.Button9Click(Sender: TObject);
begin
  // SetDebugOn(true);
  // uDebug.DebugLog('Teste de Debug Parallel');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FLock := TObject.Create;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FLock.Free;
end;

procedure TForm2.msg(texto: string);
begin

  System.TMonitor.enter(FLock);
  try
    // syncronize GUI
    TThread.Queue(nil,
    // TThread.Synchronize(nil,
      procedure
      begin
        inc(iConta);
        Memo1.Lines.Add(texto);
      end);

  finally
    System.TMonitor.exit(FLock);
  end;
end;

{ TThreadTeste }

procedure TThreadTeste.execute;
begin
  // inherited;
  frm.msg('Trhead antiga ' + IntTostr(iConta));

end;

end.
