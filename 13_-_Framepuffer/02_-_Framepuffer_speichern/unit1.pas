unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ButtonScreenSave: TButton;
    ButtonTexturSave: TButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure ButtonScreenSaveClick(Sender: TObject);
    procedure ButtonTexturSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    ogc: TContext;

    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public        { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Wen man in eine Textur rendert, hat man die Möglichkeit, den Inhalt der Textur in eine Datei zu speichern.
*)
//lineal
const

  // --- Vectoren
  QuadVertex: array[0..1] of Tmat3x3 =
    (((-0.3, 0.3, 0.0), (-0.3, -0.3, 0.0), (0.3, -0.3, 0.0)), ((-0.3, 0.3, 0.0), (0.3, -0.3, 0.0), (0.3, 0.3, 0.0)));

  // --- Farben
  QuadColor: array[0..1] of Tmat3x3 =
    (((0.0, 2.0, 0.5), (0.0, 0.0, 0.5), (2.0, 0.0, 0.5)), ((0.0, 2.0, 0.5), (2.0, 0.0, 0.5), (2.0, 2.0, 0.5)));

  // --- Vectoren
  CubeVertex: array[0..11] of Tmat3x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

  // --- Texturkoordinaten
  CubeTextureVertex: array[0..11] of Tmat3x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));

  TexturSize = 1024;

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad, VBCube: TVB;

  // Puffer für Quadrat.
  Quad_Shader: record
    Shader: TShader;
    WorldMatrix_id: GLint;
  end;

  // Puffer für Würfel.
  Cube_Shader: record
    Shader: TShader;
    WorldMatrix_id: GLint;
  end;

  // Je eine Matrix für das Rechteck und Würfel.
  QuadWorldMatrix, CubeWorldMatrix: TMatrix;

  // ID der Textur.
  textureID: GLuint;

  // Render Puffer
  FramebufferName, depthrenderbuffer: GLuint;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := True;
end;

(*
Die Textur, in dem die Scene gerendert wurde, kann man auch abspeichern.
Hinweis: Das Bild kann evtl. fehlerhaft abgespeichert werden, da dies OS abhängig ist.
Dieser Code wurde unter Linux 64Bit getestet.
*)
//code+
procedure TForm1.ButtonTexturSaveClick(Sender: TObject);
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  with Picture do begin
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := TexturSize;
    Bitmap.Height := TexturSize;
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glReadPixels(0, 0, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    SaveToFile('textur.png');
  end;
  Picture.Free;
end;
//code-

(*
Es ist auch möglich, die komplett gerenderte Scene zu speichern.
Leider steht das Bild auf dem Kopf. Die Ursache ist, bei einer Bitmap ist der Nullpunkt links-oben, bei OpenGL links/unten.
Dies kann man aber umgehen, wen man Zeile für Zeile einliest.
<b>glBindFramebuffer(GL_FRAMEBUFFER, 0);</b> ist nur notwendig, wen man mehrere Framebuffer verwendet.
*)
//code+
procedure TForm1.ButtonScreenSaveClick(Sender: TObject);
var
  Picture: TPicture;
  i: integer;
begin
  Picture := TPicture.Create;
  with Picture.Bitmap do begin
    PixelFormat := pf32bit;
    Width := ogc.Width;
    Height := ogc.Height;
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    for i := 0 to Height - 1 do begin
      glReadPixels(0, Height - i - 1, Width, Height - i, GL_RGBA, GL_UNSIGNED_BYTE, ScanLine[i]);
    end;

    SaveToFile('screen.png');
  end;
  Picture.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Picture: TPicture;
  i: integer;
begin
  Picture := TPicture.Create;
  with Picture.Bitmap do begin
    Width := ogc.Width;
    Height := ogc.Height;
    PixelFormat := pf24bit;
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    for i := 0 to Height - 1 do begin
      glReadPixels(0, Height - i - 1, Width, Height - i, GL_RGB8, GL_UNSIGNED_BYTE, ScanLine[i]);
//      glReadPixels(0, Height - i - 1, Width, Height - i, GL_DEPTH_COMPONENT, GL_UNSIGNED_INT_24_8, ScanLine[i]);
    end;

    Caption:=IntToStr(RawImage.Description.BitsPerPixel);

//    SaveToFile('screen.png');
    SaveToFile('screen.bmp');
  end;
  Picture.Free;
end;

//code-

procedure TForm1.CreateScene;
begin

  // Vertex Puffer erzeugen.
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOVertex);
  glGenBuffers(1, @VBCube.VBOTex);

  // Shader des Quadrates
  with Quad_Shader do begin
    Shader := TShader.Create([FileToStr('quad.vert'), FileToStr('quad.frag')]);
    with Shader do begin
      UseProgram;

      WorldMatrix_id := UniformLocation('Matrix');
    end;
  end;

  // Shader des Würfels.
  with Cube_Shader do begin
    Shader := TShader.Create([FileToStr('cube.vert'), FileToStr('cube.frag')]);
    with Shader do begin
      UseProgram;
      glUniform1i(UniformLocation('Sampler0'), 0);

      WorldMatrix_id := UniformLocation('Matrix');
    end;
  end;

  CubeWorldMatrix.Identity;
  QuadWorldMatrix.Identity;
end;

procedure TForm1.InitScene;
begin
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  QuadWorldMatrix.Scale(2.0);
  QuadWorldMatrix.Translate(0, 0.5, 0);

  // --- Qaudrat
  with Quad_Shader do begin
    glBindVertexArray(VBQuad.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    // Farben
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
  end;

  // --- Würfel
  with Cube_Shader do begin
    glBindVertexArray(VBCube.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    // Texturkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeTextureVertex), @CubeTextureVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
  end;

  // ------------ Texturen laden --------------

  // --- Textur

  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);


  // Frame Puffer erzeugen.
  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  // Render Puffer erzeugen.
  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  // Die Textur mit dem Framebuffer koppeln
  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID, 0);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin

  // --- In den Texturpuffer render.

  with Quad_Shader do begin // Quadrat

    // FramePuffer aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

    glClearColor(0.3, 0.3, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);

    Shader.UseProgram;
    glBindVertexArray(VBQuad.VAO);

    QuadWorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex) * 3);
  end;


  //  --- Normal auf den Bildschirm rendern.

  with Cube_Shader do begin  // Würfel

    // BildschirmPuffer mit "0" aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    glClearColor(0.6, 0.6, 0.4, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, ClientWidth, ClientHeight);

    glBindTexture(GL_TEXTURE_2D, textureID);

    Shader.UseProgram;
    glBindVertexArray(VBCube.VAO);

    CubeWorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TriangleS, 0, Length(CubeVertex) * 3);

    ogc.SwapBuffers;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  // Frame Puffer und Textur frei geben.
  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);
  glDeleteTextures(1, @textureID);

  // Vertex Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOVertex);
  glDeleteBuffers(1, @VBCube.VBOTex);

  // Shader frei geben.
  Quad_Shader.Shader.Free;
  Cube_Shader.Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CubeWorldMatrix.RotateC(Pi / 200);
  CubeWorldMatrix.RotateA(Pi / 200);
  QuadWorldMatrix.RotateC(-Pi / 124);
  ogcDrawScene(Sender);
end;

//lineal

(*
Die Shader sind sehr einfach, der Shader des Quadrates muss nur ein farbige Polygone ausgeben.
Der Shader des Würfels, gibt Texturen aus.

<b>Vertex-Shader Quadrat:</b>

*)
//includeglsl cube.vert
//lineal

(*
<b>Fragment-Shader Quadrat:</b>

*)
//includeglsl cube.frag
//lineal

(*
<b>Vertex-Shader Würfel:</b>

*)
//includeglsl quad.vert
//lineal

(*
<b>Fragment-Shader Würfel:</b>

*)
//includeglsl quad.frag

end.
