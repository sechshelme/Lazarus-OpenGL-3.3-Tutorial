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
  StdCtrls,
  dglOpenGL,
  oglShader,
  oglMatrix;

type
  TTexturData = record
    Width, Height: integer;
    Data: array of GLuint;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;
    function GetData(Bit: TBitmap): TTexturData;
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TTRiangle = array[0..11] of Tmat3x3;

const
  Triangle: TTRiangle =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

  TriangleTextureVertex0: array[0..11] of Tmat3x2 =
    (((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)));

  TriangleTextureVertex1: array[0..11] of Tmat3x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));


var
  uiVBO: array[0..10] of glUINT;
  uiVAO: array[0..2] of glUINT;

  WorldMatrix_id, texture_id0, texture_id1, pos_id: GLint;

  textureID0, textureID1: GLuint;

  WorldMatrix: TMatrix;

  TexturData0, TexturData1: TTexturData;


function TForm1.GetData(Bit: TBitmap): TTexturData;
var
  x: integer;
  y: integer;
begin
  Result.Width := Bit.Width;
  Result.Height := Bit.Height;
  SetLength(Result.Data, Result.Width * Result.Height);
  for x := 0 to Result.Width - 1 do begin
    for y := 0 to Result.Height - 1 do begin
      Result.Data[y * Result.Width + x] := Bit.Canvas.Pixels[x, y];
    end;
  end;
end;

procedure TForm1.InitScene;
begin
  TexturData0 := GetData(Image1.Picture.Bitmap);
  TexturData1 := GetData(Image2.Picture.Bitmap);


  glClearColor(0.0, 0.5, 1.0, 1.0); //Hintergrundfarbe: Hier ein leichtes Blau

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create(FileToStr('shader.glsl'));
  with Shader do begin
    pos_id := AttribLocation('inPos');
    texture_id0 := AttribLocation('vertexUV0');
    texture_id1 := AttribLocation('vertexUV1');

    glUniform1i(UniformLocation('Sampler0'), 0);
    glUniform1i(UniformLocation('Sampler1'), 1);

    WorldMatrix_id := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, uiVAO);
  glGenBuffers(3, uiVBO);

  glBindVertexArray(uiVAO[0]); // Rechteck

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(pos_id);
  glVertexAttribPointer(pos_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex0), @TriangleTextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(texture_id0);
  glVertexAttribPointer(texture_id0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[2]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex1), @TriangleTextureVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(texture_id1);
  glVertexAttribPointer(texture_id1, 2, GL_FLOAT, False, 0, nil);


  // ------------ Texturen laden --------------

  with TexturData0 do begin
    glGenTextures(1, @textureID0);
    glBindTexture(GL_TEXTURE_2D, textureID0);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(Data));

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glGenerateMipmap(GL_TEXTURE_2D);
  end;

  with TexturData1 do begin
    glGenTextures(1, @textureID1);
    glBindTexture(GL_TEXTURE_2D, textureID1);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(Data));

    //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glGenerateMipmap(GL_TEXTURE_2D);

    WorldMatrix.Scale(0.5);
  end;
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, textureID1);


  glBindVertexArray(uiVAO[0]); // Dreieck

  WorldMatrix.Uniform(WorldMatrix_id);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  WorldMatrix := TMatrix.Create;

  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.Align := alClient;

  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(1, @uiVBO);
  glDeleteVertexArrays(1, @uiVAO);
  OpenGLControl.Free;
  Shader.Free;
  WorldMatrix.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  WorldMatrix.RotateB(Pi / 200);
  RenderScene;
end;

end.
