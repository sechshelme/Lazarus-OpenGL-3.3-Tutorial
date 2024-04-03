unit Mesh;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, oglglad_gl, oglVector;

type

  { TMesh }

  TMesh = class(TObject)
  private
    Fcol1: TVector3f;
    Fcol2: TVector3f;
    FSektoren: cardinal;
    procedure SetSektoren(AValue: cardinal);
  public
    property col1: TVector3f write Fcol1;
    property col2: TVector3f write Fcol2;
    property Sektoren: cardinal read FSektoren write SetSektoren;
    constructor Create;
    procedure Disk(ri, ra: single);
    procedure Kreissegment(r, w: single);
    procedure Arc(x, y, ri, ra, wa, we: single);
    procedure Arc2(ri, ra, wa, we: single);
  end;

function vec3(v0, v1, v2: GLfloat): TVector3f;

implementation

function vec3(v0, v1, v2: GLfloat): TVector3f;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
end;


{ TMesh }

procedure TMesh.SetSektoren(AValue: cardinal);
begin
  if FSektoren = AValue then begin
    Exit;
  end;
  FSektoren := AValue;
end;

constructor TMesh.Create;
begin
  Fcol1 := vec3(1.0, 1.0, 1.0);
  Fcol2 := vec3(0.0, 0.0, 0.0);
  Sektoren := 36;
end;

procedure TMesh.Disk(ri, ra: single);
var
  w, seg: single;
  i: integer;
begin
  glbegin(GL_TRIANGLE_STRIP);
  seg := 360 / FSektoren;
  for i := 0 to FSektoren do begin
    w := i * seg / 180 * Pi;
    glColor3fv(@Fcol1);
    glVertex3f(cos(w) * ri, sin(w) * ri, 0);
    glColor3fv(@Fcol2);
    glVertex3f(cos(w) * ra, sin(w) * ra, 0);
  end;
  glEnd();
end;

procedure TMesh.Arc(x, y, ri, ra, wa, we: single);

  procedure CalcAndDraw(w: single);
  var
    c, s: single;
  begin
    c := cos(w / 180 * Pi);
    s := sin(w / 180 * Pi);
    glColor3fv(@Fcol1);
    glVertex3f(c * ri + x, s * ri + y, 0);
    glColor3fv(@Fcol2);
    glVertex3f(c * ra + x, s * ra + y, 0);
  end;

begin
  glBegin(GL_TRIANGLE_STRIP);
  repeat
    CalcAndDraw(wa);
    wa += 360 / FSektoren;
  until wa > we;
  CalcAndDraw(we);
  glEnd();
end;

procedure TMesh.Arc2(ri, ra, wa, we: single);
var
  dif: single;
begin
  dif := (ra - ri) / 3;
  Arc(0, 0, ri, ri + dif, wa, we);
  Arc(0, 0, ra, ra - dif, wa, we);
  //  Arc(0, (ri + ra) / 2, dif * 1.5, dif / 2, -90, 90);
  Arc(cos(wa / 180 * pi) * (ri + ra) / 2, sin(wa / 180 * pi) * (ri + ra) / 2, dif * 1.5, dif / 2,wa -180 ,wa+ 0);
  Arc(cos(we / 180 * pi) * (ri + ra) / 2, sin(we / 180 * pi) * (ri + ra) / 2, dif * 1.5, dif / 2,we-0,  we+180);

end;

procedure TMesh.Kreissegment(r, w: single);

  procedure CalcAndDraw(w: single);
  begin
    w := w / 180 * Pi;
    glVertex3f(cos(w) * r, sin(w) * r, 0);
  end;

var
  w2: single;

begin
  w2 := 0;

  glBegin(GL_POLYGON);
  glColor3fv(@Fcol1);
  glVertex3f(r, 0, 0);
  glColor3fv(@Fcol2);
  repeat
    w2 += 10;
    CalcAndDraw(w2);
  until w2 > w;
  w2 := w;
  CalcAndDraw(w2);
  glEnd();
end;


end.
