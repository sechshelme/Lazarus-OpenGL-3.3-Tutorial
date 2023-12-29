unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  oglVector, oglMatrix, oglKoerper, oglUnit, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



var
  OpenGL: TOpenGL;

  Cylinder: TCylinder;

  ProMatrix: TMatrix;


procedure TForm1.InitScene;
begin

  Cylinder := TCylinder.Create;
  Cylinder.Sektoren := 3;
  Cylinder.WriteVertex;

  OpenGL.Camera.Scale(0.2);
  //  OpenGL.LightPosition(0, -10, 10);

  Color := OpenGL.BkColorRGB;
end;

procedure TForm1.RenderScene;
begin
  OpenGL.Clear;
  with OpenGL.Camera do
  begin

    // Zylnder

    ObjectMatrix := ProMatrix;
    ObjectMatrix.RotateA(-Pi / 4);
    ObjectMatrix.Translate(0, 0, 0);
    Cylinder.Color := vec4(1, 1, 0, 1);
    Cylinder.Draw;
    ObjectMatrix.Translate(4, 0, 0);
    ObjectMatrix.Scale(1.5);
    ObjectMatrix.RotateA(Pi / 4);
    Cylinder.Color := vec4(0, 1, 1, 1);
    Cylinder.Draw;

    OpenGL.SwapBuffers;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  ProMatrix.Identity;;

  OpenGL := TOpenGL.Create(Self);
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;
  Cylinder.Free;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  RenderScene;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  Cylinder.Sektoren := Cylinder.Sektoren + 1;
  Cylinder.WriteVertex;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Cylinder.Sektoren := Cylinder.Sektoren - 1;
  Cylinder.WriteVertex;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
//  TMyShader.LightParams.position := vec4(Random(5), Random(5), Random(5), 1.0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //  MatrixModif.RotateX(ProMatrix, Pi / 200);
  ProMatrix.RotateB(Pi / 220);
  FormPaint(Sender);
end;

end.
