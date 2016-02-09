unit wProjExemplo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm44 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    procedure add(s: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form44: TForm44;

implementation

{$R *.dfm}

uses System.Threading;

procedure TForm44.add(s:String);
begin
      TThread.Queue(TThread.CurrentThread,
      procedure
       begin
         memo1.lines.add(s);
       end
     );

end;

procedure TForm44.FormCreate(Sender: TObject);
var
  tsk: array [0 .. 2] of ITask;
  i, n: integer;
begin
  tsk[0] := TTask.create(
    procedure
    begin
     TThread.Queue(nil, procedure
     begin
      caption := 'xxx';   // sincronizar a atualização da janela.
     end);
    end);
  tsk[0].Start;

  tsk[2] := TTask.create(
    procedure
    var
      k: integer;
    begin
      i := 1;
      sleep(1000);
      for k := 0 to 10000 do
        inc(i);
    end);

  tsk[1] := TTask.create(
    procedure
    var
      k: integer;
    begin
      n := n;
      for k := 0 to 1000 do
        inc(n);
      add( 'N');
    end);

  tsk[2].Start;
  tsk[1].Start;

  TTask.WaitforAll(tsk);

  memo1.lines.add('xxxxxxxx N: '+IntToStr(n)+' I: '+IntToStr(i));

  TParallel.For(
  100,105,procedure(i:integer)
  begin
    add(IntToStr(i));
  end)   ;

  memo1.lines.add(' N: '+IntToStr(n)+' I: '+IntToStr(i));

end;

end.
