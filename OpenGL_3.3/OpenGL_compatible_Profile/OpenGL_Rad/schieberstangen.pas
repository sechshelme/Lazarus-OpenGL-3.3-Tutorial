unit SchieberStangen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Types,
  dglOpenGL,
  MyMath, Mesh, Stange;

type

  { TSchieberstangen }

  TSchieberstangen = class(TObject)
  private
    Lenkeransatz_Height: single;
    Lenkeransatz,
    Lenkstange, VoreilHebel, VoreilHebelTop: TStange;
    KnieHbl: TGelenk;
    KSchwingeVoreil: TKurbelSchwinge;

    fSchiebeZylinderTop, fm: single;

    fcol: TGLVector3f;
  public
    constructor Create(SchiebeZylinderTop, Voreil_L, LenkS_L, m: single;
      col: TGLVectorf3);
    destructor Destroy; override;

    procedure CalcAndDraw(KK, KKopfSchieber: single; IsVirtual: boolean);

    function getVoreilStange_W: single;
    function getVoreilHebelTop: single;
  end;

implementation

{ TSchieberstangen }

constructor TSchieberstangen.Create(SchiebeZylinderTop, Voreil_L, LenkS_L, m: single; col: TGLVectorf3);
begin
  inherited Create;

  fSchiebeZylinderTop := SchiebeZylinderTop;
  fm := m;
  fcol := col;

  Lenkeransatz_Height := 195;
  VoreilHebel := TStange.Create(600 / 12, Voreil_L, fcol);
  Lenkstange := TStange.Create(600 / 12, LenkS_L, fcol);
  Lenkeransatz := TStange.Create(600 / 12, Lenkeransatz_Height, fcol);
  VoreilHebelTop := TStange.Create(600 / 12, fm, fcol);
end;

destructor TSchieberstangen.Destroy;
begin
  Lenkeransatz.Free;
  Lenkstange.Free;
  VoreilHebel.Free;
  VoreilHebelTop.Free;

  inherited Destroy;
end;

procedure TSchieberstangen.CalcAndDraw(KK, KKopfSchieber: single; IsVirtual: boolean);
var
  p: TPointF;
begin
  KnieHbl.SetParam(PointF(KK, -Lenkeransatz_Height), PointF(KKopfSchieber, fSchiebeZylinderTop), Lenkstange.L, VoreilHebel.L, True);
  glTranslatef(KK, 0, 0);

  glPushMatrix;
  glRotatef(-90, 0.0, 0.0, 0.1);
  Lenkeransatz.Draw;
  glPopMatrix;

  glTranslatef(0.0, -Lenkeransatz_Height, 0.0);
  glRotatef(KnieHbl.Kurbel_W, 0.0, 0.0, 0.1);
  Lenkstange.Draw(fcol);
  glLoadIdentity();

  glTranslatef(KKopfSchieber, fSchiebeZylinderTop, 0);
  glRotatef(KnieHbl.Pleuel_W, 0.0, 0.0, 0.1);
  VoreilHebel.Draw(fcol);

  if IsVirtual then begin
    glTranslatef(-VoreilHebelTop.L, 0.0, 0.0);
    VoreilHebelTop.Draw(fcol);
    glLoadIdentity();

    p := Trigo.Alpha_c_To_xy(KnieHbl.Pleuel_W, fm);
    glTranslatef(KKopfSchieber - p.x, fSchiebeZylinderTop - p.y, 0.0);
    VoreilHebelTop.Draw(vec3(0.5, 1.0, 0.5));
  end;

  glLoadIdentity();
end;

function TSchieberstangen.getVoreilStange_W: single;
begin
  Result := KnieHbl.Pleuel_W;
end;

function TSchieberstangen.getVoreilHebelTop: single;
begin
  Result := VoreilHebelTop.L;
end;


end.
