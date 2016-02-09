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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure msg(texto: string);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses System.Threading, uDebug;

var
  iConta: integer;

procedure TForm2.Button1Click(Sender: TObject);
var
  f: IFuture<boolean>;

begin
  f := TTask.Future<boolean>(
    function: boolean
    begin
      // faz alguma coisa
      result := true; // retorna um boolean
//      result := false;
    end);

  if f.value then // aguarda o retorno da thread (funcao);
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

  if f.value.ordem > 0 then // aguarda o retorno da thread (funcao);
    msg(f.value.nome+IntTostr(f.value.ordem))
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


  msg('Wait All ' + intToStr(iConta));

  // opcional
  TTask.WaitForAll([f1, f2, f3]); // aguarda que todas as threads sejam executadas
  msg('finished ' + intToStr(iConta));

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  TThread.Queue(TThread.CurrentThread, // poe na fila para executa��o posterior e usa syncronize
    procedure
    begin
      inc(iConta);
      Memo1.Lines.Add('I: ' + intToStr(iConta));
    end);
end;


Type
    TThreadTeste = class(TThread)
      public
        frm:TForm2;
        procedure execute;override;
    end;

procedure TForm2.Button5Click(Sender: TObject);
var
  f: TThread;
begin
  // Thread sem Syncronize
  f := TThread.CreateAnonymousThread(
    procedure
    begin
      msg('Anonimous '+intToStr(iConta));
    end);
  f.Start;

  TTask.run(procedure begin
      msg('Run '+intToStr(iConta));
  end);

  with TThreadTeste.create(true) do
  try
    FreeOnTerminate := true;
    frm := self;
    start;
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

  msg('Wait Any ' + intToStr(iConta));



  // opcional  --  nao disponivel no XE6
  {.$ifdef VER280}
    TTask.WaitForAny([F1,F2]);  // aguarda pelo menos 1 thread concluida.
  {.$endif}
  msg('finished ' + intToStr(iConta));

end;

procedure TForm2.Button7Click(Sender: TObject);
begin
 TParallel.For(
  100,105,procedure(i:integer)
  begin
    msg('Parallel: '+IntToStr(i));
  end)   ;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
   Button1.Click;
   button2.Click;
   button3.Click;
   button4.Click;
   button5.Click;
   button6.Click;
   button7.Click;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
 SetDebugOn(true);
 uDebug.DebugLog('Teste de Debug Parallel');
end;

procedure TForm2.msg(texto: string);
begin

  // syncronize GUI
  TThread.Queue(nil,
    procedure
    begin
      inc(iConta);
      Memo1.Lines.Add(texto);
    end);

end;

{ TThreadTeste }

procedure TThreadTeste.execute;
begin
 // inherited;
  frm.msg('Trhead antiga '+intToStr(iConta));

end;

end.
