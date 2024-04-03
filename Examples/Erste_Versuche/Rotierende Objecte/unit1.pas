unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Forms,
  ExtCtrls,
  Buttons, ComCtrls,
  oglglad_gl,
  oglUnit, oglShader,
  oglVector, oglMatrix,
  oglColorKoerper, oglLighting,
  oglKoerper,
  VLIFluegeli;

type

  { TForm1 }

  TForm1 = class(TForm)
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    Matrix: TMatrix;

    OpenGL: TOpenGL;

    Wurfel: TCube;
    CylinderLinks, CylinderMitte, CylinderRechts: TCylinder;
    Fluegeli: TFluegeli;
    Donut: TDonut;
    Triangle: TColorTriangle;

    Lighting: TLighting;
    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.InitScene;
begin
  Triangle := TColorTriangle.Create;
  //  Triangle.Color := vec4(1.0, 1.0, 0.5, 1.0);
  Triangle.WriteVertex;

  Wurfel := TCube.Create;
  Wurfel.WriteVertex;

  Fluegeli := TFluegeli.Create(True);
  Fluegeli.WriteVertex;

  Donut := TDonut.Create;
  Donut.Sektoren := 5;
  Donut.Color := vec4(1, 0, 0, 1);
  Donut.WriteVertex;

  CylinderLinks := TCylinder.Create;
  CylinderLinks.Sektoren := 13;
  CylinderLinks.Color := vec4(1, 1, 0, 1);
  CylinderLinks.WriteVertex;

  CylinderMitte := TCylinder.Create;
  CylinderMitte.Sektoren := 13;
  CylinderMitte.Color := vec4(1, 0, 1, 1);
  CylinderMitte.WriteVertex;

  CylinderRechts := TCylinder.Create;
  CylinderRechts.Sektoren := 5;
  CylinderRechts.Color := vec4(0, 1, 1, 1);
  CylinderRechts.WriteVertex;

  Lighting := TLighting.Create;
  Lighting.Add(Triangle);
  Lighting.Add(Wurfel);
  Lighting.Add(Fluegeli);
  Lighting.Add(Donut);
  Lighting.Add(CylinderLinks);
  Lighting.Add(CylinderMitte);
  Lighting.Add(CylinderRechts);
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  m.Identity;

  OpenGL.Clear;
  with OpenGL.Camera do begin

    // Triangle

    ObjectMatrix := Matrix;
    ObjectMatrix.Scale(5);
    ObjectMatrix.Translate(2.0, 2.0, 0.0);
    Triangle.Draw;

    m.RotateB(Pi);
    ObjectMatrix := Matrix * m;
    Triangle.Draw;


    // Fluegeli;

    ObjectMatrix := Matrix;
    ObjectMatrix.Scale(0.2);
    ObjectMatrix.Translate(1, 0, 0);
    ObjectMatrix.RotateC(Pi / 10);

    Fluegeli.Color2 := vec4(0, 0, 1, 1);
    Fluegeli.Draw;

    // Würfel;

    ObjectMatrix := Matrix;
    ObjectMatrix.Translate(0.0, -2.0, 0.0);

    Wurfel.Color := vec4(1, 0, 0, 1);
    Wurfel.Draw;

    ObjectMatrix := Matrix;
    ObjectMatrix.Translate(0.0, -2.0, -2.0);
    ObjectMatrix.Scale(0.4);
    Wurfel.Color := vec4(0, 0, 1, 1);
    Wurfel.Draw;

    // Zylinder

    m := Matrix;
    Matrix.Translate(0.0, 2.0, 0.0);

    Donut.Draw;
    Matrix := m;

    ObjectMatrix := Matrix;
    ObjectMatrix.RotateC(Pi / 2);
    ObjectMatrix.Translate(3, 0, 0);
    CylinderMitte.Draw;

    ObjectMatrix := Matrix;
    ObjectMatrix.RotateC(-Pi / 2);
    ObjectMatrix.Translate(-3, 0, 0);
    CylinderRechts.Draw;

    OpenGL.SwapBuffers;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Matrix.Identity;

  OpenGL := TOpenGL.Create(Self);

  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;

  CylinderLinks.Free;
  CylinderMitte.Free;
  CylinderRechts.Free;
  Fluegeli.Free;
  Donut.Free;
  Triangle.Free;

  Lighting.Free;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.01, 700, -50.0, 2.2);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  Donut.Sektoren := Donut.Sektoren + 1;
  Donut.WriteVertex;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Donut.Sektoren := Donut.Sektoren - 1;
  Donut.WriteVertex;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Lighting.Setposition(vec4(-50 + Random(100), -50 + Random(100), -50 + Random(100), 0.0));
  Lighting.Update;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Matrix.RotateB(Pi / 200);
  Matrix.RotateC(Pi / 220);
  RenderScene;
end;

end.
