unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  OpenGLContext,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  StdCtrls, ComCtrls, Buttons,
  dglOpenGL,
  oglShader,
  oglVertex, oglMatrix, oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl: TOpenGLControl;
    procedure InitScene;
    procedure RenderScene;
  public
    Shader: TShader;

    Textur: array[0..1] of TTexturBuffer;
    Matrix: record
      World, Frustum, Camera: TMatrix;
    end;

    VBO: array[0..10] of glUINT;
    VAO: array[0..2] of glUINT;

    Mat_ID, WorldMatrix_id: GLint;
  const
    MatNr: integer = 0;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TMaterial = packed record
    Light: packed record
      Pos: TVector4f;
    end;
    Material: packed record
      diffuse: TVector4f;    // Farbe
      ambient: TVector4f;    // Umgebungslicht
      specular: TVector4f;   // Spiegelnd
      shininess: glFloat;    // Glanz
    end;
  end;

const
  Material: array[0..2] of TMaterial = (
    (Light: (
    Pos: (10.0, 10.0, 0.0, 0.0); );
    Material: (
    diffuse: (0.8, 0.8, 0.8, 1.0);
    ambient: (0.1, 0.1, 0.1, 1.0);
    specular: (1.0, 1.0, 1.0, 1.0);
    shininess: 0.1); ),

    (Light: (
    Pos: (10.0, 10.0, 1.0, 0.0);
    );
    Material: (
    diffuse: (0.25, 0.25, 0.25, 1.0);
    ambient: (0.1, 0.1, 0.1, 1.0);
    specular: (0.1, 0.1, 0.1, 1.0);
    shininess: 45.0); ),

    (Light: (
    Pos: (10.0, 10.0, 1.0, 0.0);
    );
    Material: (
    diffuse: (1.0, 1.0, 1.0, 1.0);
    ambient: (0.1, 0.1, 0.1, 1.0);
    specular: (1.0, 1.0, 1.0, 1.0);
    shininess: 45.0); ));

var
  Mat: TMaterial;

type
  TTRiangle = array[0..11] of Tmat3x3;

const
  Triangle: TTRiangle = (
    // Umfang
    ((-0.5, +0.5, +0.5), (-0.5, -0.5, +0.5), (+0.5, -0.5, +0.5)), ((-0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, +0.5, +0.5)),
    ((+0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, -0.5, -0.5)), ((+0.5, +0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, +0.5, -0.5)),
    ((+0.5, +0.5, -0.5), (+0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((+0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, +0.5, -0.5)),
    ((-0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, +0.5)), ((-0.5, +0.5, -0.5), (-0.5, -0.5, +0.5), (-0.5, +0.5, +0.5)),
    // oben
    ((+0.5, +0.5, +0.5), (+0.5, +0.5, -0.5), (-0.5, +0.5, -0.5)), ((+0.5, +0.5, +0.5), (-0.5, +0.5, -0.5), (-0.5, +0.5, +0.5)),
    // unten
    ((-0.5, -0.5, +0.5), (-0.5, -0.5, -0.5), (+0.5, -0.5, -0.5)), ((-0.5, -0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, -0.5, +0.5)));

  TriangleTextureVertex: array[0..11] of Tmat3x2 = (
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));


var
  TriangleNormal: TTRiangle;


procedure TForm1.InitScene;
const
  ia: array[0..1] of integer = (0, 1);
begin
  FaceToNormale(Triangle, TriangleNormal);

  with Shader do begin
    glUniform1iv(UniformLocation('Sampler'), 2, ia);
    WorldMatrix_id := UniformLocation('WorldMatrix');

    Mat := Material[MatNr];

    Mat_ID := UniformLocation('allUniforms.lights.l_dir');
    glUniform4fv(Mat_ID, 1, @Mat.Light.Pos);

    Mat_ID := UniformLocation('allUniforms.materials.diffuse');
    glUniform4fv(Mat_ID, 1, @Mat.Material.diffuse);

    Mat_ID := UniformLocation('allUniforms.materials.ambient');
    glUniform4fv(Mat_ID, 1, @Mat.Material.ambient);

    Mat_ID := UniformLocation('allUniforms.materials.specular');
    glUniform4fv(Mat_ID, 1, @Mat.Material.specular);

    Mat_ID := UniformLocation('allUniforms.materials.shininess');
    glUniform1f(Mat_ID, Mat.Material.shininess);
  end;


  glGenVertexArrays(Length(VAO), VAO);
  glGenBuffers(Length(VBO), VBO);

  glBindVertexArray(VAO[0]); // Würfel

  glBindBuffer(GL_ARRAY_BUFFER, VBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @TriangleNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBO[2]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex), @TriangleTextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, Textur[0].ID);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, Textur[1].ID);


  glBindVertexArray(VAO[0]); // Dreieck

  Matrix.World.Identity;
  Matrix.World.Multiply(Matrix.Camera, Matrix.World);

  Matrix.World.Multiply(Matrix.Frustum, Matrix.World);
  Matrix.World.Uniform(WorldMatrix_id);

  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin

  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.Align := alClient;
  OpenGLControl.AutoResizeViewport := True;
  OpenGLControl.OpenGLMajorVersion := 3;
  OpenGLControl.OpenGLMinorVersion := 3;

  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  Shader := TShader.Create(FileToStr('shader.glsl'));

  // ------------ Texturen laden --------------

  Textur[0] := TTexturBuffer.Create;
  Textur[1] := TTexturBuffer.Create;

  Textur[0].LoadTextures(Image1.Picture.Bitmap.RawImage);
  Textur[1].LoadTextures(Image2.Picture.Bitmap.RawImage);

  InitScene;
  Timer1.Enabled := True;

  Matrix.World.Identity;

  Matrix.Camera.Identity;
  Matrix.Camera.Translate(0, 0, -30);
  Matrix.Camera.Scale(2.5);

  Matrix.Frustum.Identity;
  Matrix.Frustum.Frustum(-1.0, 1.0, -1.0, 1.0, 10, 70.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;

begin
  glDeleteBuffers(Length(VBO), @VBO);
  glDeleteVertexArrays(Length(VAO), @VAO);

  OpenGLControl.Free;
  Shader.Free;
  for i := 0 to 1 do begin
    Textur[i].Free;
  end;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure TForm1.SpeedButtonClick(Sender: TObject);
begin
  MatNr := StrToInt(TSpeedButton(Sender).Caption);
  Mat := Material[MatNr];

  InitScene;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Matrix.Camera.RotateC(Pi / 222);
  Matrix.Camera.RotateB(Pi / 200);
  RenderScene;
end;

end.
