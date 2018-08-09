unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure LoadAmeise;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Man kann auch in jedem Layer einzeln die Texturn laden.
Der einzige Unterschied zum kompletten laden ist, man ladetdie Texturen einzeln mit SubImage hoch.
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.
*)
//lineal
const
  QuadVertex: array[0..5] of TVector2f =       // Koordinaten der Polygone.
    ((-1.0, -1.0), (1.0, 1.0), (-1.0, 1.0),
    (-1.0, -1.0), (1.0, -1.0), (1.0, 1.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex,
      Tex,
      Instance: GLuint;
    end;
  end;

  TInstance = record
    Layer: GLfloat;
    Angle: GLfloat;
    Trans: TVector2f;
  end;

  TInstances = array[0..5] of TInstance;

var
  VBQuad: TVB;
  ScaleMatrix: TMatrix;
  Layer_ID, Matrix_ID,
  textureID: GLuint;

  Instances: TInstances;

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

procedure TForm1.CreateScene;
const
  tr = 3.0;
  scale = 0.8;
var
  i: integer;
begin
  for i := 0 to Length(Instances) do begin
    with Instances[i] do begin
      Layer := i;
      Trans := vec2(0.0, 0.0);
      Trans.Translate(-tr + tr * (i mod 3), -tr / 2 + tr * (i div 3));
      Angle := Random * 2 * Pi;
    end;
  end;

  glGenTextures(1, @textureID);                 // Erzeugen des Textur-Puffer.

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(3, @VBQuad.VBO);

  ScaleMatrix.Identity;
  ScaleMatrix.Scale(scale, -scale, 1.0);

  Timer1.Enabled := True;
end;

(*
Mit <b>glTexImage3D(...</b> wird nur der Speicher für die Texturen reserviert. Dabei muss man von Anfang an wissen, wie gross die Texturen sind.
Mit <b>glTexSubImage3D(...</b> werden dann die Texturn Layer für Layer hochgeladen.
Die sechs einelnen Bitmap heisen 1.xpm - 6.xpm .
*)
//code+
procedure TForm1.InitScene;
var
  i, ofs: integer;
begin
  LoadAmeise;
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Tex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);


  // --- Instance
  ofs := 0;
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instances), @Instances, GL_STATIC_DRAW);

  // Layer
  glEnableVertexAttribArray(5);
  glVertexAttribPointer(5, 1, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(5, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Angele
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 1, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(6, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Translate
  glEnableVertexAttribArray(7);
  glVertexAttribPointer(7, 2, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(7, 1);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y: integer;
  Matrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);  // Textur binden.
  glBindVertexArray(VBQuad.VAO);

  Matrix.Identity;
  Matrix.Scale(0.2);

  Matrix := ScaleMatrix * Matrix;
  Matrix.Uniform(Matrix_ID);

  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(QuadVertex), Length(Instances));

  ogc.SwapBuffers;
end;

procedure TForm1.LoadAmeise;
const
  anzLayer = 6;
type
  TBuffer = array of UInt32;

  procedure LoadTexture(bit: TBitmap; Layer: integer; col: UInt32);
  var
    Buffer: TBuffer;
    i: integer;
  begin
    SetLength(Buffer, bit.Width * bit.Height);
    for i := 0 to Length(Buffer) - 1 do begin
      if bit.Canvas.Pixels[i mod bit.Width, i div bit.Width] = 0 then begin
        Buffer[i] := col or $FF000000;
      end else begin
        Buffer[i] := 0;
      end;
      ;

    end;

    glTexSubImage3D(GL_TEXTURE_2D_ARRAY, 0, 0, 0, Layer, bit.Width, bit.Height, 1, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(Buffer));
  end;

var
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  bit.LoadFromFile('Ameise0.bmp');

  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

  glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA8, bit.Width, bit.Height, anzLayer, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

  LoadTexture(bit, 0, $FF);     // Rot
  LoadTexture(bit, 1, $FF00);   // Grün
  LoadTexture(bit, 2, $FF0000); // Blau
  LoadTexture(bit, 3, $FFFF);
  LoadTexture(bit, 4, $FFFF00);
  LoadTexture(bit, 5, $FF00FF);

  glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
  bit.Free;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(3, @VBQuad.VBO);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  a = 0.1;
  m = 7.0;
var
  i: integer;
  t: TVector2f;
begin

  for i := 0 to Length(Instances) do begin
    with Instances[i] do begin

      Angle += -a + Random * a * 2;
      t := vec2(0.0, 0.1);
      t.Rotate(-Angle);
      Trans -= t;

      if Trans.x > m then begin
        Trans.x := -m;
      end;
      if Trans.y > m then begin
        Trans.y := -m;
      end;
      if Trans.x < -m then begin
        Trans.x := m;
      end;
      if Trans.y < -m then begin
        Trans.y := m;
      end;
    end;
  end;


  glBindVertexArray(VBQuad.VAO);

  // Instance
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(TInstances), @Instances);


  ogc.Invalidate;
end;

//lineal

(*
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
