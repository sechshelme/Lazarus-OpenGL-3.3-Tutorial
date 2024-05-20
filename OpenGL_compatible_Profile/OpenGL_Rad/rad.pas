unit Rad;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, gl, Mesh;

type

  { TTreibRad }

  TTreibRad = class(TObject)
  private
    fRadius,
    fGegenKurbelZapfen_R, fTreibZapfen_R: single;
    Mesh: TMesh;
    ListIndex: GLuint;
  public
    constructor Create(ARadius, TreibZapfen_R, GegenKurbelZapfen_R: single; Speichen: cardinal = 15);
    destructor Destroy; override;
    procedure Draw(startwinkel: single);

    function getRadius: single;
    function getTreibZapfen_R: single;
    function getGetGengenKurbel_R: single;

    function getAufkeil_W: single;
  end;

implementation

{ TTreibRad }

constructor TTreibRad.Create(ARadius, TreibZapfen_R, GegenKurbelZapfen_R: single;
  Speichen: cardinal);
const
  segWinkelGegengewicht = 90.0;
var
  i: integer;
  l: single;
begin
  inherited Create;
  fTreibZapfen_R := TreibZapfen_R;
  fGegenKurbelZapfen_R := GegenKurbelZapfen_R;

  Mesh := TMesh.Create;
  Speichen := 15;
  fRadius := ARadius;
  ListIndex := glGenLists(1);

  glNewList(ListIndex, GL_COMPILE);

  l := fRadius / 20;
  for i := 0 to speichen - 1 do begin
    glRotatef(360 / speichen, 0, 0, 1);

    glBegin(GL_QUADS);
    glColor3f(0.5, 0.1, 0.1);
    glVertex3f(-l, fRadius - l, 0);
    glVertex3f(-l, 0, 0);
    glColor3f(0.7, 0.2, 0.2);
    glVertex3f(l, 0, 0);
    glVertex3f(l, fRadius - l, 0);
    glEnd();
  end;

  glTranslatef(0, 0, -0.01); // Nabe/Spurkranz vor Speichen
  Mesh.col1 := vec3(0.1, 0.0, 0.0);
  Mesh.col2 := vec3(0.9, 0.0, 0.1);
  Mesh.Disk(fRadius / 1.15, fRadius);

  Mesh.col1 := vec3(0.1, 0.0, 0.0);
  Mesh.col2 := vec3(0.9, 0.0, 0.1);
  Mesh.Disk(0.0, fRadius / 4);

  Mesh.col1 := vec3(0.7, 0.7, 0.7);
  Mesh.col2 := vec3(0.5, 0.5, 0.5);
  Mesh.Disk(fRadius, fRadius * 1.05);

  glTranslatef(0, 0, -0.01); // Schraube vor Nabe
  Mesh.col1 := vec3(0.0, 0.0, 0.0);
  Mesh.col2 := vec3(0.2, 0.2, 0.2);
  Mesh.Sektoren := 6;
  Mesh.Disk(0.0, fRadius / 10);
  Mesh.Sektoren := 36;

  glRotatef(-segWinkelGegengewicht / 2 + 180, 0, 0, 1); // Gegengewicht
  Mesh.col1 := vec3(0.8, 0.3, 0.3);
  Mesh.col2 := vec3(0.4, 0.2, 0.2);
  Mesh.Kreissegment(fRadius / 1.05, segWinkelGegengewicht);

  glEndList;
end;

destructor TTreibRad.Destroy;
begin
  Mesh.Free;
  glDeleteLists(ListIndex, 1);
  inherited Destroy;
end;

procedure TTreibRad.Draw(startwinkel: single);
begin
  glPushMatrix;
  glRotatef(startwinkel, 0, 0, 1);
  glCallList(ListIndex);
  glPopMatrix;
end;

function TTreibRad.getRadius: single;
begin
  Result := fRadius;
end;

function TTreibRad.getTreibZapfen_R: single;
begin
  Result := fTreibZapfen_R;
end;

function TTreibRad.getGetGengenKurbel_R: single;
begin
  Result := fGegenKurbelZapfen_R;
end;

function TTreibRad.getAufkeil_W: single;
begin
  Result := -90.0;
end;


end.
