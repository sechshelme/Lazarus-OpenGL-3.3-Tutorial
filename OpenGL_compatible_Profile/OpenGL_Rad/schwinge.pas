unit Schwinge;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Types, oglglad_gl, MyMath,
  Mesh, Stange, Rad;

type

  { TSchwinge }

  TSchwinge = class(TObject)
  private
    KurbelSchwinge: TKurbelSchwinge;
    VirtuallSchieberSchubstange, // wird nur bei Virtuall gebraucht
    SchwingenStange, Schwinge: TStange;
    Mesh: TMesh;
    fSchubstangeLaenge, fAufkeilWinkel, fGegenKurbel_R: single;
    fLager_xy: TPointF;
    function getLaenge: single;
  public
    property Laenge: single read getLaenge;
    constructor Create(SchubstangeLaenge, AufkeilWinkel, GegenKurbel_R: single; Lager_xy: TPointF);
    destructor Destroy; override;
    procedure Draw(Winkel: single);
    function getLagerPos_xy: TPointF;
    function getSchwingen_W: single;

    function getKreuzKopf_x_and_Draw_SS_Stange(SchieberSchubstange_L, f: single): single;
  end;

implementation

{ TSchwinge }

constructor TSchwinge.Create(SchubstangeLaenge, AufkeilWinkel, GegenKurbel_R: single; Lager_xy: TPointF);
begin
  inherited Create;
  fAufkeilWinkel := AufkeilWinkel;
  fGegenKurbel_R := GegenKurbel_R;
  fLager_xy := Lager_xy;
  fSchubstangeLaenge := SchubstangeLaenge;

  Mesh := TMesh.Create;
//  SchwingenStange := TStange.Create(600 / 12, 1937.9, vec3(0.2, 1.0, 0.2));
  SchwingenStange := TStange.Create(600 / 12, 1886.410, vec3(0.2, 1.0, 0.2));
  Schwinge := TStange.Create(500 / 12, 405, vec3(0.2, 0.2, 1.0));
  VirtuallSchieberSchubstange := TStange.Create(600 / 12, SchubstangeLaenge, vec3(1.0, 0.2, 0.2));
end;

destructor TSchwinge.Destroy;
begin
  inherited Destroy;
  VirtuallSchieberSchubstange.Free;
  Schwinge.Free;
  SchwingenStange.Free;
  Mesh.Free;
end;

function TSchwinge.getLaenge: single;
begin
  Result := Schwinge.L;
end;

procedure TSchwinge.Draw(Winkel: single);
begin
  KurbelSchwinge.SetParam(winkel + fAufkeilWinkel, fGegenKurbel_R, fLager_xy, SchwingenStange.L, Schwinge.L, True);

  // Schwingenstange

  glTranslatef(KurbelSchwinge.A_xy.x, KurbelSchwinge.A_xy.y, -0.2);
  glRotatef(KurbelSchwinge.Pleuel_W, 0.0, 0.0, 1.0);
  SchwingenStange.Draw;
  glLoadIdentity();


  with fLager_xy do begin
    glTranslatef(x, y, -0.2);
  end;
  glRotatef(KurbelSchwinge.Schwinge_W, 0.0, 0.0, 1.0);
  Schwinge.Draw;
  glRotatef(-90, 0.0, 0.0, 1.0);
  glTranslatef(-fSchubstangeLaenge, 0, -0.0);
  Mesh.Arc2(fSchubstangeLaenge - 50, fSchubstangeLaenge + 50, -10, 10);
  glTranslatef(0, 0, -0.2);
  Mesh.Disk(10, 20);
  glLoadIdentity();
end;

function TSchwinge.getLagerPos_xy: TPointF;
begin
  Result := fLager_xy;
end;

function TSchwinge.getSchwingen_W: single;
begin
  Result := KurbelSchwinge.Schwinge_W;
end;

function TSchwinge.getKreuzKopf_x_and_Draw_SS_Stange(SchieberSchubstange_L, f: single): single;
var
  SchwingeSchubKurbel: TSchubKurbel;
begin
  f := f * 1.5;

  with SchwingeSchubKurbel do begin
    SetPara(KurbelSchwinge.Schwinge_W, Schwinge.L / f, SchieberSchubstange_L);

    with fLager_xy do begin
      Result := x + B_x;
      glTranslatef(x + B_x, y, -0.2);
    end;

    glRotatef(Pleuel_W, 0.0, 0.0, 1.0);
  end;
  VirtuallSchieberSchubstange.Draw(vec3(0.5, 0.5, 0.5));
  glLoadIdentity();

end;

end.
