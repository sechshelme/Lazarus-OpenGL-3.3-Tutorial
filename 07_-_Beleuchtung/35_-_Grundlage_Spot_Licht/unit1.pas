unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormPaint(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Dieses Beispiel zeigt, wie ein Spotlicht berechnet wird.
Zum besseren Verständnis, wird das ganze ohne OpenGL als 2D auf einem Canvas gezeigt.
*)

//lineal

(*
Deklarationen der benütigenten Variablen.
*)
//code+
type
  TVec2 = array[0..1] of single;

var
  LichtOefffnung: single;
  LichtPos, LichtRichtung: TVec2;
//code-

(*
Entspricht dem <b>vec2</b> von <b>GLSL</b>.
*)
//code+
function vec2(x, y: single): TVec2; inline;
begin
  Result[0] := x;
  Result[1] := y;
end;
//code-

(*
Entspricht dem <b>normalize(vec2)</b> von <b>GLSL</b>.
Dies normalisiert den 2D-Vektor.
*)
//code+
function normalize(v: TVec2): TVec2;
var
  i: integer;
  l: single;
begin
  l := Sqrt(Sqr(v[0]) + Sqr(v[1]));
  if l = 0 then begin
    l := 1.0;
  end;
  for i := 0 to 1 do begin
    Result[i] := v[i] / l;
  end;
end;
//code-

(*
Entspricht dem <b>dot(vec2)</b> von <b>GLSL</b>.
Hier wird das Skalarprodukt aus 2 Vektoren berechnent.
<b>arccos(Result)</b>, gibt den Winkel der beiden Vektoren im Bogenmass aus.
*)
//code+
function dot(v1, v2: TVec2): single;
begin
  Result := ((v1[0] * v2[0] + v1[1] * v2[1]) / (sqrt(v1[0] * v1[0] + v1[1] * v1[1]) * sqrt(v2[0] * v2[0] + v2[1] * v2[1])));
end;
//code-

(*
Startwerte für die Lichtparameter.
*)
//code+
procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  LichtOefffnung := 8; // Ausstrahl-Winkel 45°  ( PI / 8 )
  LichtPos := vec2(200, 100);
  LichtRichtung := vec2(2, 2);
end;
//code-

(*
Die Maustasten ändern die Licht und Austrahl-Position.
*)
//code+
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  case Button of
    mbLeft: begin
      LichtRichtung[0] := x - LichtPos[0];
      LichtRichtung[1] := y - LichtPos[1];
    end;
    mbRight: begin
      LichtPos[0] := x;
      LichtPos[1] := y;
    end;
  end;
  Invalidate;
end;
//code-

(*
Das Mausrad ändert den Austrahlwinkel.
*)
//code+
procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  if WheelDelta > 0 then begin
    LichtOefffnung *= 1.05;
    if LichtOefffnung > 500.0 then begin // Kleiner macht keinen Sinn.
      LichtOefffnung := 500.0;
    end;
  end else begin
    LichtOefffnung /= 1.05;
    if LichtOefffnung < 1.0 then begin   // Bei 360° Öffnung begrenzen.
      LichtOefffnung := 1.0;
    end;
  end;
  Invalidate;
end;
//code.

(*
Hier wird gepüft, ob sich der Pixel im Lichtstrahl befindet.
*)
//code+
function isCone(x, y: integer): boolean;
var
  winkel: single;
  lr, lp: TVec2;
begin
  // Lichtrichtung Normalisieren.
  lr := normalize(LichtRichtung);

  // Lichtposition inkremebtal berechnen.
  lp :=vec2(x - LichtPos[0], y - LichtPos[1]);

  // Lichtposition Normlisieren.
  lp := normalize(lp);

  // Skalarprodukt berechen.
  winkel := dot(lr, lp);

  // Prüfen, ob sicher der Pixel im Lichtstrahl befindet.
  Result := (winkel > cos(pi / LichtOefffnung));
end;
//code-

(*
Zeichen der ganzen Scene.
*)
//code+
procedure TForm1.FormPaint(Sender: TObject);
var
  x, y: integer;
begin
  for x := 0 to ClientWidth - 1 do begin
    for y := 0 to ClientHeight - 1 do begin
      if isCone(x, y) then begin
        Canvas.Pixels[x, y] := clYellow;
      end else begin
        Canvas.Pixels[x, y] := clBlack;
      end;
    end;
  end;
end;
//code-

end.
