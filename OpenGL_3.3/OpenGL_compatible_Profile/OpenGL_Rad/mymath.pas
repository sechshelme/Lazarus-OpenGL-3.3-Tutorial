unit MyMath;

{$mode objfpc}{$H+}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, Types, Math, Dialogs;

type

  //TPointf = record
  //  x, y: single;
  //end;

  { TGelenk }

  TGelenk = record
    Kurbel_W, Pleuel_W: single;
     A_xy:TPointF;
    procedure SetParam(A0_xy, B_xy: TPointF; Kurbel_R, Pleuel_L: single; reverse: boolean = False);
  end;

  { TSchubKurbel }

  TSchubKurbel = record
    Pleuel_W, B_x: single;
    A_xy: TPointF;
    procedure SetPara(Kurbel_W, Kurbel_R, Pleuel_L: single);
  end;

  { TKurbelSchwinge }

  TKurbelSchwinge = record
    Pleuel_W, Schwinge_W: single;
    A_xy: TPointF;
    procedure SetParam(Kurbel_W, Kurbel_R: single; B0_xy: TPointF; Pleuel_L, Schwinge_L: single; reverse: boolean = False);
  end;

  { TTrigo }

  TTrigo = record
    Grad: boolean;
    function a_b_c_To_Alpha(a, b, c: single): single;
    function a_b_c_To_Beta(a, b, c: single): single;
    function a_b_c_To_Gama(a, b, c: single): single;

    // Dreieck rechtwinklig

    function Alpha_c_To_xy(angle, len: single): TPointf;

    function a_c_To_Alpha(a, c: single): single;
    function a_c_To_Beta(a, c: single): single;
    function b_c_To_Alpha(b, c: single): single;
    function b_c_To_Beta(b, c: single): single;

    function a_b_To_Alpha(a, b: single): single;
    function a_b_To_Beta(a, b: single): single;

    function a_b_To_c(a, b: single): single;
  end;

var
  Trigo: TTrigo;

function PointF(x, y: single): TPointF;


implementation

function PointF(x, y: single): TPointF;
begin
  Result.x := x;
  Result.y := y;
end;

{ TTrigo }

function TTrigo.a_b_c_To_Alpha(a, b, c: single): single;
begin
  Result := arccos((-sqr(a) + sqr(b) + sqr(c)) / (2 * b * c));
  if Grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_b_c_To_Beta(a, b, c: single): single;
begin
  Result := arccos((-sqr(b) + sqr(a) + sqr(c)) / (2 * a * c));
  if Grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_b_c_To_Gama(a, b, c: single): single;
begin
  Result := arccos((-sqr(c) + sqr(a) + sqr(b)) / (2 * a * b));
  if Grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.Alpha_c_To_xy(angle, len: single): TPointf;
begin
  if Grad then begin
    angle := angle / 180.0 * Pi;
  end;
  Result.x := cos(angle) * len;
  Result.y := sin(angle) * len;
end;

function TTrigo.a_c_To_Alpha(a, c: single): single;
begin
  Result := arcsin(a / c);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_c_To_Beta(a, c: single): single;
begin
  Result := arccos(a / c);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.b_c_To_Alpha(b, c: single): single;
begin
  Result := arccos(b / c);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.b_c_To_Beta(b, c: single): single;
begin
  Result := arcsin(b / c);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_b_To_Alpha(a, b: single): single;
begin
  Result := arctan(a / b);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_b_To_Beta(a, b: single): single;
begin
  Result := arctan(b / a);
  if grad then begin
    Result := Result / pi * 180;
  end;
end;

function TTrigo.a_b_To_c(a, b: single): single;
begin
  Result := sqrt(sqr(a) + sqr(b));
end;


{ TGelenk }

procedure TGelenk.SetParam(A0_xy, B_xy: TPointF; Kurbel_R, Pleuel_L: single; reverse: boolean);
var
  c,             // Ist der Abstand zwischen dem Radexcenter und dem Zentrum der Schwinge_xy.
  w_c: single;   // Ist der Winkel von C   ( Ist der Winkel von c, wen die eine Linie wäre.)
begin
  //  c := Trigo.a_b_To_c(A0_xy.y - B_xy.y, B_xy.x - A0_xy.x);
  c := A0_xy.Distance(B_xy);  // Erst ab FPC 3.1.1

  if A0_xy.x < B_xy.x then begin
    w_c := Trigo.a_c_To_Alpha(B_xy.y - A0_xy.y, c);
  end else begin
    w_c := Trigo.a_c_To_Alpha(A0_xy.y - B_xy.y, c) - 180;
  end;

  if reverse then begin
    Kurbel_W := w_c - Trigo.a_b_c_To_Beta(Kurbel_R, Pleuel_L, c);
    Pleuel_W := w_c + Trigo.a_b_c_To_Alpha(Kurbel_R, Pleuel_L, c) + 180;
  end else begin
    Kurbel_W := w_c + Trigo.a_b_c_To_Alpha(Pleuel_L, Kurbel_R, c);
    Pleuel_W := w_c - Trigo.a_b_c_To_Beta(Pleuel_L, Kurbel_R, c) + 180;
  end;

end;

{ TSchubKurbel }

procedure TSchubKurbel.SetPara(Kurbel_W, Kurbel_R, Pleuel_L: single);
begin
  A_xy := Trigo.Alpha_c_To_xy(Kurbel_W, Kurbel_R);
  Pleuel_W := 180 - Trigo.a_c_To_Alpha(A_xy.y, Pleuel_L);

  B_x := sqrt(sqr(Pleuel_L) - sqr(A_xy.y)) + A_xy.x;
end;

{ TKurbelSchwinge }

procedure TKurbelSchwinge.SetParam(Kurbel_W, Kurbel_R: single; B0_xy: TPointF; Pleuel_L, Schwinge_L: single; reverse: boolean);
(*  @Rad_W:           Winkel, des Excenter, des Rades.
    @Rad_R:           Distanz, Rad-Zentrum bis Excenter.
    @Schwinge_x / y:  Drehpunkt der Schwinge.
    @Pleuel_L:        Länge des Pleuels, vom Rad-exenter bis Schwinge-Ende, im Beispiel Verbindung der blauen und grünen Stange.
    @Schwinge_L:      Distanz, Drehpunkt-Schwinge bis Pleuelbefestigung.
    @reverse:         Rechnet seitenverkehrt.
*)

var
  Gelenk: TGelenk;
begin
  A_xy := Trigo.Alpha_c_To_xy(Kurbel_W, Kurbel_R);

  Gelenk.SetParam(A_xy, B0_xy, Pleuel_L, Schwinge_L, reverse);
  Pleuel_W := Gelenk.Kurbel_W;
  Schwinge_W := Gelenk.Pleuel_W;
end;


end.
