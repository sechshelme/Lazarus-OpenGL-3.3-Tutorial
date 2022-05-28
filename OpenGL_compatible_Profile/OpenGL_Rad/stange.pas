unit Stange;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dglOpenGL, MyMath, Mesh, Zylinder;

type

  { TStange }

  TStange = class(TObject)
  private
    Mesh: TMesh;
    fLaenge, fd: single;
    fcol: TGLVector3f;
  public
    property L: single read fLaenge;
    constructor Create(d, ALaenge: single; col: TGLVector3f);
    destructor Destroy; override;
    procedure Draw(col: TGLVector3f);
    procedure Draw;
  end;


implementation

{ TStange }

constructor TStange.Create(d, ALaenge: single; col: TGLVector3f);
begin
  inherited Create;
  fd := d;
  fLaenge := ALaenge;
  fcol := col;
end;

destructor TStange.Destroy;
begin
  Mesh.Free;
  inherited Destroy;
end;

procedure TStange.Draw(col: TGLVector3f);
var
  d2: single;
  c1, c2: TGLVectorf3;
  i: integer;
begin
  glPushMatrix;

  c1 := col;
  c2 := col;
  for i := 0 to 2 do begin
    c2[i] := c2[i] / 1.3;
  end;
  Mesh := TMesh.Create;
  d2 := fd / 2;

  glBegin(GL_QUADS);
  glColor3fv(@c1);
  glVertex3f(d2, -d2, 0);
  glVertex3f(fLaenge - d2, -d2, 0);
  glColor3fv(@c2);
  glVertex3f(fLaenge - d2, d2, 0);
  glVertex3f(d2, d2, 0);
  glEnd();

  glTranslatef(0, 0, -0.01);
  Mesh.col1 := c1;
  Mesh.col2 := c2;
  Mesh.Disk(fd / 2, fd);

  glTranslatef(fLaenge, 0.0, 0.0);
  Mesh.Disk(fd / 2, fd);

  glPopMatrix;
end;

procedure TStange.Draw;
begin
  Draw(fcol);
end;

end.
