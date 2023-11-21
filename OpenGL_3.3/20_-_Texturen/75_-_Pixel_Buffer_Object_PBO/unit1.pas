unit Unit1;

{$mode objfpc}{$H+}

interface

//image image.png
//lineal

(*
Pixel Buffer Object (PBO)
*)

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglDebug,
  oglContext, oglShader, oglVector, oglMatrix;

const
  TexturSize = 16;

type
  TTexture32 = packed array[0..TexturSize - 1, 0..TexturSize - 1, 0..3] of byte;

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    function GenTexture(is_tex0: boolean): TTexture32;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    PBO0, PBO1,
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;

var
  textureID0, textureID1: GLuint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
  InitOpenGLDebug;
end;

function TForm1.GenTexture(is_tex0: boolean): TTexture32;
var
  x, y: integer;
begin
  for x := 0 to TexturSize - 1 do begin
    for y := 0 to TexturSize - 1 do begin
      if is_tex0 then begin
        Result[x, y, 0] := Random($FF);
        Result[x, y, 1] := $00;
        Result[x, y, 2] := $00;
      end else begin
        Result[x, y, 0] := $00;
        Result[x, y, 1] := Random($FF);
        Result[x, y, 2] := $00;
      end;
    end;
  end;
end;

// code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;
  with Shader do begin
    glUniform1i(UniformLocation('Sampler0'), 0);
    glUniform1i(UniformLocation('Sampler1'), 1);
  end;
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // === Vertex Buffer
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  // === Texture 0
  glGenBuffers(1, @VBQuad.PBO0);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO0);
  glBufferData(GL_PIXEL_UNPACK_BUFFER, TexturSize * TexturSize * 4, nil, GL_DYNAMIC_DRAW);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 0);

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  glBindTexture(GL_TEXTURE_2D, 0);

  // === Texture 1
  glGenBuffers(1, @VBQuad.PBO1);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO1);
  glBufferData(GL_PIXEL_UNPACK_BUFFER, TexturSize * TexturSize * 4, nil, GL_DYNAMIC_DRAW);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 0);

  glGenTextures(1, @textureID1);
  glBindTexture(GL_TEXTURE_2D, textureID1);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  glBindTexture(GL_TEXTURE_2D, 0);
end;
// code-

// code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  buf: TTexture32;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // === Texture 0
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO0);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  buf := GenTexture(True);
  glBufferSubData(GL_PIXEL_UNPACK_BUFFER, 0, TexturSize * TexturSize * 4, @buf);

  // === Texture 1
  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, textureID1);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO1);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  buf := GenTexture(False);
  glBufferSubData(GL_PIXEL_UNPACK_BUFFER, 0, TexturSize * TexturSize * 4, @buf);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  glBindTexture(GL_TEXTURE_2D, 0);

  ogc.SwapBuffers;
end;
// code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID0);
  glDeleteTextures(1, @textureID1);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
  glDeleteBuffers(1, @VBQuad.PBO0);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
