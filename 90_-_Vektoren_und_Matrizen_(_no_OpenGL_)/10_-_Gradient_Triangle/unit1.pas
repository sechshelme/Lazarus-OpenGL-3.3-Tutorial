unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  dglOpenGL, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    procedure LineX(x0, x1, y: single; col0, col1: TVector3f);
    procedure Triangle(v0, v1, v2: TVector2f; col0, col1, col2: TVector3f);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  Randomize;
  Color := clBlack;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 3 do begin
    Triangle(
      vec2(Random * ClientWidth, Random * ClientHeight),
      vec2(Random * ClientWidth, Random * ClientHeight),
      vec2(Random * ClientWidth, Random * ClientHeight),
      vec3(Random, Random, Random),
      vec3(Random, Random, Random),
      vec3(Random, Random, Random));
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Invalidate;
end;


procedure TForm1.LineX(x0, x1, y: single; col0, col1: TVector3f);
var
  i: integer;
  addc, c: TVector3f;

begin
  if x0 > x1 then begin
    SwapglFloat(x0, x1);
    SwapVertex3f(col0, col1);
  end;

  addc := (col1 - col0) / (x1 - x0);
  c := col0;

  for i := trunc(x0) to trunc(x1) do begin
    Canvas.Pixels[i, trunc(y)] := c.ToInt;
    c := c + addc;
  end;
end;

procedure TForm1.Triangle(v0, v1, v2: TVector2f; col0, col1, col2: TVector3f);
var
  y: integer;
  dif,

  addx_0, addx_1, addx_2,
  x0, x1, x2: single;

  addc_0, addc_1, addc_2,
  c0, c1, c2: TVector3f;

begin
  if (v0.y > v1.y) then begin
    SwapVertex2f(v0, v1);
    SwapVertex3f(col0, col1);
  end;
  if (v1.y > v2.y) then begin
    SwapVertex2f(v1, v2);
    SwapVertex3f(col1, col2);
  end;
  if (v0.y > v1.y) then begin
    SwapVertex2f(v0, v1);
    SwapVertex3f(col0, col1);
  end;

  dif := v1.y - v0.y;
  addx_0 := (v1.x - v0.x) / dif;
  x0 := v0.x;
  addc_0 := (col1 - col0) / dif;
  c0 := col0;

  dif := v1.y - v2.y;
  addx_1 := (v1.x - v2.x) / dif;
  x1 := v1.x;
  addc_1 := (col1 - col2) / dif;
  c1 := col1;

  dif := v2.y - v0.y;
  addx_2 := (v2.x - v0.x) / dif;
  x2 := v0.x;
  addc_2 := (col2 - col0) / dif;
  c2 := col0;

  // erstes Teildreieck
  for y := trunc(v0.y) to trunc(v1.y) - 1 do begin
    LineX(x0, x2, y, c0, c2);
    x0 += addx_0;
    x2 += addx_2;

    c0 += addc_0;
    c2 += addc_2;
  end;

  // zweites Teildreieck
  for y := trunc(v1.y) to trunc(v2.y) - 1 do begin
    LineX(x1, x2, y, c1, c2);
    x1 += addx_1;
    x2 += addx_2;

    c1 += addc_1;
    c2 += addc_2;
  end;
end;


end.
