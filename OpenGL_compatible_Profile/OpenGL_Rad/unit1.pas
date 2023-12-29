unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, OpenGLContext, LCLType, StdCtrls, ComCtrls, Types, Math,

  {$ifdef arm}
  dglOpenGLSE,
  {$else}
  dglOpenGL,
  {$endif}

  Mesh, MyMath, Rad,
  Zylinder, Stange, Schwinge, TreibGestaenge, SchieberStangen, HaengeGestaenge;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CoolBar1: TCoolBar;
    OpenGLControl1: TOpenGLControl;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    Timer1: TTimer;
    ToggleBoxTimer: TToggleBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonWinkelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: integer);
    procedure OpenGLControl1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure OpenGLControl1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure OpenGLControl1Paint(Sender: TObject);
    procedure OpenGLControl1Resize(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  public
    BildPara: record
      zoom, x, y, xalt, yalt: single;
    end;

    Mesh: TMesh;

    TreibGestaenge: TTreibGestaenge;

    Richtung: (fwd, rwd);
    TreibRad: TTreibRad;

    SchiebeZylinder: record
      Top: single;
      Kolben: TKolben;
      ZylinderStange: TStange;
    end;

    SchwingenGestaenge: record
      SchieberSchubstange,
      SchieberSchubstangeAnsatz: TStange;
      Schwinge: TSchwinge;
    end;

    HaengeGestaenge: THaengeGestaenge;

    SchieberStangen: record
      Normal, Virtuall: TSchieberstangen;
    end;

    RadAbstand, speed, winkel: single;
    procedure BackGround;
  end;

var
  Form1: TForm1;

implementation

const
  m = 108.0;


{ TForm1 }

procedure TForm1.BackGround;
begin
  glMatrixMode(GL_PROJECTION);
  glPushMatrix;
  glLoadIdentity();

  glBegin(GL_QUADS);
  glColor3f(0.4, 0.2, 0.3);
  glVertex3f(-1.0, -1.0, 0.999);
  glColor3f(0.45, 0.25, 0.3);
  glVertex3f(+1.0, -1.0, 0.999);
  glColor3f(0.4, 0.25, 0.53);
  glVertex3f(+1.0, +1.0, 0.999);
  glColor3f(0.45, 0.2, 0.35);
  glVertex3f(-1.0, +1.0, 0.999);
  glEnd();

  glPopMatrix;
  glMatrixMode(GL_MODELVIEW);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if ToggleBoxTimer.Checked then begin
    if Richtung = rwd then begin
      winkel += speed;
      if winkel > 360 then begin
        winkel -= 360;
      end;
    end else begin
      winkel -= speed;
      if winkel < 0 then begin
        winkel += 360;
      end;
    end;
  end;

  OpenGLControl1.Repaint;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  with  HaengeGestaenge do begin
    HaengeGestaenge.SetPosition(getmax, ScrollBar1.Position);
    Caption := FloatToStr(ScrollBar1.Position);

    setHubPos(ScrollBar1.Position);
    if ScrollBar1.Position > 0 then begin
      Richtung := rwd;
    end else begin
      Richtung := fwd;
    end;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  caption:=paramstr(0);
  InitOpenGL;
  ReadExtensions;
//  ReadOpenGLCore;
  ReadImplementationProperties;
  OpenGLControl1.MakeCurrent;

  with BildPara do begin
    zoom := 0.0007;
  end;

  TreibRad := TTreibRad.Create(600, 340, 340 / 2);

  RadAbstand := 1400.0;
  SchiebeZylinder.Top := 500.0;

  TreibGestaenge := TTreibGestaenge.Create(RadAbstand, 2850, TreibRad.getTreibZapfen_R);
  HaengeGestaenge := THaengeGestaenge.Create(PointF(2050, 965));

  with SchwingenGestaenge do begin

    SchieberSchubstange := TStange.Create(600 / 12, 1400, vec3(1.0, 0.2, 0.2));
    Schwinge := TSchwinge.Create(SchieberSchubstange.L, TreibRad.getAufkeil_W, TreibRad.getGetGengenKurbel_R, PointF(1890, 570));

    SchieberSchubstangeAnsatz := TStange.Create(600 / 12, 200, vec3(1.0, 0.2, 0.2));

    with SchiebeZylinder do begin
//      SchieberStangen.Normal := TSchieberstangen.Create(Top, 725, 441, m, vec3(1.0, 0.2, 0.2));
  //    SchieberStangen.Virtuall := TSchieberstangen.Create(Top - m, 725 - m, 441, m, vec3(0.5, 0.5, 0.5));
      SchieberStangen.Normal := TSchieberstangen.Create(Top+m, 725+m, 441, -m, vec3(1.0, 0.2, 0.2));
      SchieberStangen.Virtuall := TSchieberstangen.Create(Top + m, 725 + m, 441, -m, vec3(0.5, 0.5, 0.5));

      Kolben := TKolben.Create(TreibRad.getGetGengenKurbel_R * 2, 100);
      ZylinderStange := TStange.Create(600 / 12, TreibRad.getGetGengenKurbel_R * 2, vec3(1.0, 0.2, 0.2));
    end;

    with HaengeGestaenge do begin
      ScrollBar1.Min := round(-getmax);
      ScrollBar1.Max := round(getmax);
      ScrollBar1.Position := 0;
    end;
  end;

  Mesh := TMesh.Create;

  speed := 3.10344;

  Trigo.Grad := True;
  Timer1.Enabled := True;
end;

procedure TForm1.OpenGLControl1Paint(Sender: TObject);
var
  f, KKopfSchieber: single;
  KSchwingeVoreil: TKurbelSchwinge;

  p: TPointf;

  Virtuall: record
    //    SchwingeSchubKurbel: TSchubKurbel;
  end;

begin
  glClearColor(0.4, 0.2, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
  BackGround;


  // --- Treibrad

  with TreibRad do begin
    Draw(winkel);
    glTranslatef(-RadAbstand, 0.0, 0.0);
    Draw(winkel);
    glTranslatef(-RadAbstand, 0.0, 0.0);
    Draw(winkel);

    glLoadIdentity();
  end;


  // --- Treib - Gestänge

  with TreibGestaenge do begin
    Calc_and_Draw(winkel);
  end;


  // --- Schwinge ---

  with SchwingenGestaenge do begin
    Schwinge.Draw(winkel);
  end;

  // -------------------------
  // --- Virtuelle Stangen ---
  // -------------------------

  // SchieberSchubStange

  with SchwingenGestaenge do begin

    with HaengeGestaenge do begin
      KKopfSchieber := Schwinge.getKreuzKopf_x_and_Draw_SS_Stange(SchieberSchubstange.L, -getmax / getHubPos);
    end;

    // --- VoreilStangen

    SchieberStangen.Virtuall.CalcAndDraw(TreibGestaenge.getKreuzKopf_x, KKopfSchieber, True);
    p := Trigo.Alpha_c_To_xy(SchieberStangen.Virtuall.getVoreilStange_W, m);
    KKopfSchieber := KKopfSchieber + p.x;

  end;

  // ------------------------------
  // --- Ende Virtuelle Stangen ---
  // ------------------------------


  // Kolben Schieber

  glTranslatef(TreibGestaenge.getTreibStange_L + TreibRad.getTreibZapfen_R * 2.5, SchiebeZylinder.Top, 0.0);

  SchiebeZylinder.Kolben.Draw(KKopfSchieber - 2850 - SchiebeZylinder.ZylinderStange.L);
  glLoadIdentity();

  // --- VoreilStangen

  SchieberStangen.Normal.CalcAndDraw(TreibGestaenge.getKreuzKopf_x, KKopfSchieber, False);


  // --- SchwingenGestaenge ---

  with SchwingenGestaenge do begin

    with SchieberStangen.Normal do begin
      KSchwingeVoreil.SetParam(getVoreilStange_W + 180, -getVoreilHebelTop,
        HaengeGestaenge.get_xy.Add(PointF(-KKopfSchieber, -SchiebeZylinder.Top)),
        SchieberSchubstange.L + SchieberSchubstangeAnsatz.L, HaengeGestaenge.get_L);
    end;


    // SchieberSchubStange

    glTranslatef(KSchwingeVoreil.A_xy.x + KKopfSchieber, KSchwingeVoreil.A_xy.y + SchiebeZylinder.Top, -0.2);
    glRotatef(KSchwingeVoreil.Pleuel_W, 0.0, 0.0, 1.0);
    SchieberSchubstange.Draw;
    glTranslatef(SchieberSchubstange.L, 0.0, 0.0);
    SchieberSchubstangeAnsatz.Draw();
    glLoadIdentity();


    // Hänge-Eisen

    HaengeGestaenge.Draw(KSchwingeVoreil.Schwinge_W);

  end;

  // --- SchiebeZylinder


  glTranslatef(KKopfSchieber, SchiebeZylinder.Top, -0.2);
  SchiebeZylinder.ZylinderStange.Draw;
  glLoadIdentity();

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  TreibRad.Free;

  with  SchiebeZylinder do begin
    Kolben.Free;
    ZylinderStange.Free;
  end;

  TreibGestaenge.Free;
  HaengeGestaenge.Free;

  with SchwingenGestaenge do begin
    SchieberSchubstange.Free;
    SchieberSchubstangeAnsatz.Free;
    Schwinge.Free;
  end;

  with SchieberStangen do begin
    Virtuall.Free;
    Normal.Free;
  end;

  Mesh.Free;
end;

procedure TForm1.OpenGLControl1Resize(Sender: TObject);
begin
  with OpenGLControl1 do begin
    glViewport(0, 0, Width, Height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glScalef(Height / Width, 1.0, 1.0);

    with BildPara do begin
      glTranslatef(x, y, 0.0);
      glScalef(zoom, zoom, zoom);
    end;
  end;
end;

procedure TForm1.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
const
  Step = 0.0050;
begin
  if Shift = [ssLeft] then begin
    BildPara.x += (X - BildPara.xalt) * Step;
    BildPara.y += -(Y - BildPara.yalt) * Step;
    OpenGLControl1Resize(Sender);
  end;

  BildPara.xalt := x;
  BildPara.yalt := y;
end;

procedure TForm1.OpenGLControl1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
begin
  BildPara.zoom *= 1.05;
  OpenGLControl1Resize(Sender);
end;

procedure TForm1.OpenGLControl1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
begin
  BildPara.zoom /= 1.05;
  OpenGLControl1Resize(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  speed *= 1.1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  speed /= 1.1;
    Button1.Font.Color := clRed;
  Button1.Caption := 'Hello' + LineEnding + 'World';
end;

procedure TForm1.ButtonWinkelClick(Sender: TObject);
begin
  case TButton(Sender).Tag of
    0: begin
      winkel := 0;
    end;
    90: begin
      winkel := 90;
    end;
    180: begin
      winkel := 180;
    end;
    270: begin
      winkel := 270;
    end;
  end;

end;

initialization

  {$I unit1.lrs}

end.
