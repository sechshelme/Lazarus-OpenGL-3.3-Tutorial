unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

//image image.png
(*
Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.
*)
//lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    procedure CreateScene;
    procedure CreateTree;
    procedure CreateWand;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  QuadVertex: array[0..5] of TVector3f =
    ((0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 0.0),
    (0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 1.0, 0.0));

  CubeVertex: array[0..35] of TVector3f =
    ((0.0, 1.0, 1.0), (0.0, 0.0, 1.0), (1.0, 0.0, 1.0), (0.0, 1.0, 1.0), (1.0, 0.0, 1.0), (1.0, 1.0, 1.0),
    (1.0, 1.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 0.0), (1.0, 1.0, 1.0), (1.0, 0.0, 0.0), (1.0, 1.0, 0.0),
    (1.0, 1.0, 0.0), (1.0, 0.0, 0.0), (0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 0.0, 0.0), (0.0, 1.0, 0.0),
    (0.0, 1.0, 0.0), (0.0, 0.0, 0.0), (0.0, 0.0, 1.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (0.0, 1.0, 1.0),
    // oben
    (1.0, 1.0, 1.0), (1.0, 1.0, 0.0), (0.0, 1.0, 0.0), (1.0, 1.0, 1.0), (0.0, 1.0, 0.0), (0.0, 1.0, 1.0),
    // unten
    (0.0, 0.0, 1.0), (0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 0.0, 0.0), (1.0, 0.0, 1.0));

type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;

var
  Tree: record
    VB: TVB;
    Shader: TShader;
    ObjectMatrix: TMatrix;
    Matrix_ID: GLint;
    vec: array of record
      Pos: TVector3f;
      Color: TVector4f;
    end;
  end;

  Wall: record
    VB: TVB;
    Shader: TShader;
    Matrix_ID: GLint;
    Textur: TTexturBuffer;
    vec: array of record
      Pos: TVector3f;
      Tex: TVector2f;
    end;
  end;

  Shadow: record
    TexturSize: integer;
    FramebufferName, depthrenderbuffer: GLuint;
    Textur: TTexturBuffer;
  end;


type
  TCubePos = record
    pos: TVector3f;
  end;
  PCubePos = ^TCubePos; // Pointer für Cube


var
  FrustumMatrix,
  WorldMatrix: TMatrix;

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
end;

(*
Hier wird der Speicher für die Würfel angefordert.
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
var
  i: integer;
begin
  //code-

  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.RotateA(-Pi / 2);
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(40.0);                 // Und der Grösse anpassen.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  with Tree do begin
    ObjectMatrix.Identity;
    Shader := TShader.Create([FileToStr('tree.glsl')]);
    with Shader do begin
      UseProgram;
      Matrix_ID := UniformLocation('Matrix');
    end;

    glGenVertexArrays(1, @VB.VAO);
    glGenBuffers(1, @VB.VBOvert);
    glGenBuffers(1, @VB.VBOcol);
  end;

  with Wall do begin
    Shader := TShader.Create([FileToStr('wand.glsl')]);
    with Shader do begin
      UseProgram;
      Matrix_ID := UniformLocation('mat');
      glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
    end;

    glGenVertexArrays(1, @VB.VAO);
    glGenBuffers(1, @VB.VBOvert);
    glGenBuffers(1, @VB.VBOcol);

    Textur := TTexturBuffer.Create;
  end;

  with Shadow do begin
    TexturSize := 256;
    Textur := TTexturBuffer.Create;
    Textur.ActiveAndBind;
    Textur.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    Textur.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    Textur.LoadTextures(TexturSize, TexturSize);

    // Frame Puffer erzeugen.
    glGenFramebuffers(1, @FramebufferName);
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

    // Render Puffer erzeugen.
    glGenRenderbuffers(1, @depthrenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

    // Die Textur mit dem Framebuffer koppeln
    glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, Textur.ID, 0);

    // BildschirmPuffer mit "0" aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
  end;

  Timer1.Enabled := True;
end;


procedure TForm1.CreateTree;

  procedure AddCube(size, position: TVector3f; col: TVector4f);
  var
    i, l: integer;
  begin
    with Tree do begin
      l := Length(vec);
      SetLength(vec, l + 36);

      for i := 0 to 35 do begin
        with vec[i + l] do begin
          Pos.x := CubeVertex[i].x * size.x + position.x - 0.5;
          Pos.y := CubeVertex[i].y * size.y + position.y - 0.5;
          Pos.z := CubeVertex[i].z * size.z + position.z - 0.5;
          Color := col;
        end;
      end;
    end;
  end;

begin
  with Tree do begin
    SetLength(vec, 0);
    AddCube(vec3(0.2, 0.2, 1.0), vec3(0.4, 0.4, 0.0), vec4(0.5, 0.25, 0.07, 1.0));

    AddCube(vec3(0.4, 0.1, 0.1), vec3(0.0, 0.45, 0.8), vec4(0.0, 0.4, 0.0, 1.0));
    AddCube(vec3(0.2, 0.1, 0.1), vec3(0.6, 0.45, 0.4), vec4(0.4, 0.8, 0.2, 0.4));

    AddCube(vec3(0.1, 0.1, 0.1), vec3(0.45, 0.3, 0.2), vec4(0.5, 0.9, 0.2, 0.3));
    AddCube(vec3(0.1, 0.3, 0.1), vec3(0.45, 0.6, 0.6), vec4(0.4, 0.6, 0.4, 1.0));
  end;
end;

procedure TForm1.CreateWand;
var
  i: integer;
begin
  with Wall do begin
    SetLength(vec, 6);
    for i := 0 to Length(vec) - 1 do begin
      with vec[i] do begin
        pos := QuadVertex[i];
        Tex := Pos.xy;
        pos.x := (pos.x - 0.5) * 3;
        pos.y := pos.y * 3.0;
      end;
    end;
  end;
end;

(*
Startpositionen der einzelnen Würfel definieren.
*)
//code+
procedure TForm1.InitScene;
begin
  CreateTree;
  CreateWand;

  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  // --- Daten für Baum
  with Tree do begin
    glBindVertexArray(VB.VAO);

    // Vektor
    glBindBuffer(GL_ARRAY_BUFFER, VB.VBOvert);
    glBufferData(GL_ARRAY_BUFFER, Length(vec) * 7 * SizeOf(GLfloat), Pointer(vec), GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 3, GL_FLOAT, False, 28, nil);

    // Farbe
    glBindBuffer(GL_ARRAY_BUFFER, VB.VBOcol);
    glBufferData(GL_ARRAY_BUFFER, Length(vec) * 7 * SizeOf(GLfloat), Pointer(vec), GL_STATIC_DRAW);
    glEnableVertexAttribArray(11);
    glVertexAttribPointer(11, 3, GL_FLOAT, False, 28, Pointer(12));
  end;

  // --- Daten für Mauer
  with Wall do begin
    Textur.LoadTextures('project1.ico');
    glBindVertexArray(VB.VAO);

    // Vektor
    glBindBuffer(GL_ARRAY_BUFFER, VB.VBOvert);
    glBufferData(GL_ARRAY_BUFFER, Length(vec) * 5 * SizeOf(GLfloat), Pointer(vec), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);

    // Textur-Koordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VB.VBOcol);
    glBufferData(GL_ARRAY_BUFFER, Length(vec) * 5 * SizeOf(GLfloat), Pointer(vec), GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 2, GL_FLOAT, False, 20, Pointer(12));
  end;

end;

(*
Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  Matrix: TMatrix;
begin

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  // --- Zeichne Schatten
  glBindFramebuffer(GL_FRAMEBUFFER, Shadow.FramebufferName);
  glClearColor(0.8, 0.8, 0.8, 1.0);
  with Shadow do begin
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);
  end;

  with Tree do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

    Matrix.Identity;
    Matrix.Multiply(ObjectMatrix, Matrix);
    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glClearColor(0.3, 0.3, 1.0, 1.0);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, ClientWidth, ClientHeight);

  // --- Zeichne Baum
  with Tree do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

    Matrix.Identity;
    Matrix.Multiply(ObjectMatrix, Matrix);
    Matrix.Translate(0.5, 0.0, 0.0);
    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  // --- Zeichne Wall
  with Wall do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);
    //    Textur.ActiveAndBind;
    Shadow.Textur.ActiveAndBind;

    Matrix.Identity;

    Matrix.Translate(-1.5, 0.0, -0.3);
    Matrix.RotateB(-pi / 2);
    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  ogc.SwapBuffers;
end;
//code-
(*
Den Speicher von den CubePos wieder frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  //code-
  with Tree do begin
    glDeleteVertexArrays(1, @VB.VAO);
    glDeleteBuffers(1, @VB.VBOvert);
    glDeleteBuffers(1, @VB.VBOcol);
    Shader.Free;
  end;

  with Wall do begin
    glDeleteVertexArrays(1, @VB.VAO);
    glDeleteBuffers(1, @VB.VBOvert);
    glDeleteBuffers(1, @VB.VBOcol);
    Textur.Free;
    Shader.Free;
  end;

  with Shadow do begin
    Textur.Free;

    // Frame Puffer und Textur frei geben.
    glDeleteFramebuffers(1, @FramebufferName);
    glDeleteRenderbuffers(1, @depthrenderbuffer);
  end;
end;

(*
Gedreht wird nur der Baum.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //    WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  Tree.ObjectMatrix.RotateC(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

//code-

//lineal

(*
<b>Shader für Baum:</b>
*)
//includeglsl tree.glsl
//lineal

(*
<b>Shader für Wand</b>
*)
//includeglsl wand.glsl

end.
