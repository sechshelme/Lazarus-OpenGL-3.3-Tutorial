//code+

unit Unit1;

{$mode objfpc}{$H+}

interface
 interface
  interface
   interface
    interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    class function test(const c: char): string;
  public
    type
      t = array of array of boolean;
    procedure hi;
  end;

var
  Form1: TForm1;

  a: array[0..4] of int64;
  a1: array of boolean;
  a2: array of array of boolean;

implementation

{$R *.lfm}

{ TForm1 }

// Kommentar if if then else and or 'Hallo' World.

function then2: integer; inline;
begin
  Result := 123;
end;

Writeln('Hello');

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin
or
for or
else or
else of
  for i := 100 downto 3 do Write ('Hello World');
  for i := 10 to 30 do Write ('Hello World');// Kommentar
  if 1 = 1 then begin  // Hallo and und or.
    if (1 = 1) or (2 = 2) and (3 = 3) and (4 = 4) or (5 = 5) then begin

    end;
  end;
end;

class function TForm1.test(const c: char): string;
begin

end;

procedure TForm1.hi;
begin

end;

end.
//code-
