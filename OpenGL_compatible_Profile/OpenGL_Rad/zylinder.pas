unit Zylinder;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dglOpenGL;

type

  { TKolben }

  TKolben = class(TObject)
  private
    fmaxHub,fRadius: single;
  public
    constructor Create(maxHub, Radius: single);
    procedure Draw(HubPos: single);
  end;

implementation

{ TKolben }

constructor TKolben.Create(maxHub, Radius: single);
begin
  inherited Create;
  fmaxHub := maxHub;
  fRadius:=Radius;
end;

procedure TKolben.Draw(HubPos: single);
var
  KolbenW,
  p: single;

begin
  KolbenW := fmaxHub / 30;

  // Gehäuse

  glBegin(GL_QUADS);
  glColor3f(0.1, 0.1, 0.1);
  glVertex3f(0, -fRadius, 0.1);
  glVertex3f(0, fRadius, 0.1);

  glColor3f(0.2, 0.2, 0.2);
  glVertex3f(fmaxHub, fRadius, 0.1);
  glVertex3f(fmaxHub, -fRadius, 0.1);
  glEnd();

  p := HubPos;

  // Zylinder

  glBegin(GL_QUADS);
  glColor3f(0.7, 0.7, 0.7);
  glVertex3f(-KolbenW + p, -fRadius, 0.0);
  glVertex3f(-KolbenW + p, fRadius, 0.0);

  glColor3f(0.8, 0.8, 0.8);
  glVertex3f(KolbenW + p, fRadius, 0.0);
  glVertex3f(KolbenW + p, -fRadius, 0.0);
  glEnd();
end;


end.
