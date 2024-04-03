unit HaengeGestaenge;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Types,
  oglglad_gl,
  MyMath, Mesh, Stange;

type

  { THaengeGestaenge }

  THaengeGestaenge = class(TObject)
  private
    fpos, fG_xy: TPointF;
    HaengeEisen, Stange_g, Stange_h: TStange;
    fWinkel: single;
    HEPos: record
      maxHub, HubPos: single;
    end;
  public
    constructor Create(APos_xy: TPointF);
    destructor Destroy; override;

    procedure Draw(winkel: single);

    procedure SetPosition(maxHub, pos: single);
    function get_L: single;
    function get_xy: TPointF;

    function getmax: single;
    procedure setHubPos(p: single);
    function getHubPos:Single;
  end;

implementation

{ THaengeGestaenge }

constructor THaengeGestaenge.Create(APos_xy: TPointF);
begin
  fG_xy := APos_xy;
  HaengeEisen := TStange.Create(600 / 12, 500, vec3(1.0, 0.2, 0.2));

  Stange_g := TStange.Create(600 / 12, 440, vec3(1.0, 0.2, 0.2));
  Stange_h := TStange.Create(600 / 12, 468, vec3(1.0, 0.2, 0.2));

  with HEPos do begin
    maxHub := 300;
    HubPos := 0;
  end;
end;

destructor THaengeGestaenge.Destroy;
begin
  Stange_h.Free;
  Stange_g.Free;
  HaengeEisen.Free;
  inherited Destroy;
end;

const
  vor = 12.0; // muss noch berechnet werden

procedure THaengeGestaenge.Draw(winkel: single);
begin
  with fG_xy do begin
    glTranslatef(x, y, -0.2);
    glRotatef(90 + FWinkel - vor, 0, 0, 1);
    Stange_h.Draw;
    glLoadIdentity();
  end;

  with fG_xy do begin
    glTranslatef(x, y, -0.2);
    glRotatef(180 + FWinkel - vor, 0, 0, 1);
    Stange_g.Draw;
    glLoadIdentity();
  end;

  with fpos do begin
    glTranslatef(x, y, -0.2);
  end;

  glRotatef(winkel, 0.0, 0.0, 1.0);
  HaengeEisen.Draw;
  glLoadIdentity();
end;

procedure THaengeGestaenge.SetPosition(maxHub, pos: single);
begin
  fWinkel := 40 / -maxHub * pos;
end;

function THaengeGestaenge.get_L: single;
begin
  Result := HaengeEisen.L;
end;

function THaengeGestaenge.get_xy: TPointF;
begin
  fpos := Trigo.Alpha_c_To_xy(180 + FWinkel - vor, Stange_g.L) + fG_xy;
  Result := fpos;
end;

function THaengeGestaenge.getmax: single;
begin
  Result := HEPos.maxHub;
end;

procedure THaengeGestaenge.setHubPos(p: single);
begin
  HEPos.HubPos := p;
end;

function THaengeGestaenge.getHubPos: Single;
begin
  Result:=HEPos.HubPos;
end;

end.
