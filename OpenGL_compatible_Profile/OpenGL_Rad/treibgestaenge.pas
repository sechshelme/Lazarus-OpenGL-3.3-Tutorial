unit TreibGestaenge;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, oglglad_gl, MyMath, Mesh, Stange,Zylinder;

type

  { TTreibGestaenge }

  TTreibGestaenge = class(TObject)
  private
    fKreuzKopf_x, fTreibZapfen_R: single;
    KuppelStange, Treibstange, KolbenStange: TStange;
    Kolben: TKolben;
  public
    SchubKurbel: TSchubKurbel;
    constructor Create(RadAbstand, TreibStange_L, TreibZapfen_R: single);
    destructor Destroy; override;

    procedure Calc_and_Draw(Winkel: single);

    function getZylinder_x: single;
    function getKreuzKopf_x: single;
    function getTreibStange_L: single;
  end;

implementation

{ TTreibGestaenge }

constructor TTreibGestaenge.Create(RadAbstand, TreibStange_L, TreibZapfen_R: single);
var
  b: single = 600 / 8;
begin
  inherited Create;
  fTreibZapfen_R := TreibZapfen_R;
  KuppelStange := TStange.Create(b, RadAbstand, vec3(1.0, 0.2, 0.2));
  Treibstange := TStange.Create(b, TreibStange_L, vec3(1.0, 0.2, 0.2));
  KolbenStange := TStange.Create(b, fTreibZapfen_R * 2, vec3(1.0, 0.2, 0.2));
  Kolben := TKolben.Create(fTreibZapfen_R * 2, 200);
end;

destructor TTreibGestaenge.Destroy;
begin
  KuppelStange.Free;
  Treibstange.Free;
  KolbenStange.Free;
  Kolben.Free;
  inherited Destroy;
end;

procedure TTreibGestaenge.Calc_and_Draw(Winkel: single);
var
  SchieberHubPos: single;
begin

  // --- Berechnen

  with SchubKurbel do begin
    SetPara(Winkel, fTreibZapfen_R, Treibstange.L);
    fKreuzKopf_x := B_x;

    // --- KuppelStange

    with A_xy do begin
      glTranslatef(x, y, 0);
      glTranslatef(-KuppelStange.L, 0.0, -0.03);
      KuppelStange.Draw;
      glTranslatef(-KuppelStange.L, 0.0, 0.0);
      KuppelStange.Draw;
      glLoadIdentity();
    end;


    // --- Treibstange

    glTranslatef(B_x, 0.0, -0.03);
    glRotatef(Pleuel_W, 0.0, 0.0, 1.0);
    Treibstange.Draw;
    glLoadIdentity();
  end;

  // --- Kolben

  glTranslatef(fKreuzKopf_x, 0.0, 0.0);
  KolbenStange.Draw;
  glLoadIdentity();

  glTranslatef(Treibstange.L + fTreibZapfen_R * 2, 0.0, 0.0);

  SchieberHubPos := fKreuzKopf_x - Treibstange.L + fTreibZapfen_R;
  Kolben.Draw(SchieberHubPos);
  glLoadIdentity();

end;

function TTreibGestaenge.getZylinder_x: single;
begin
  Result := Treibstange.L + KolbenStange.L;
end;

function TTreibGestaenge.getKreuzKopf_x: single;
begin
  Result := fKreuzKopf_x;
end;

function TTreibGestaenge.getTreibStange_L: single;
begin
  Result := Treibstange.L;
end;

end.
