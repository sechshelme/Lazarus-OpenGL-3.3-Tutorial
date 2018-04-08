unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Bei Polygonen, welche Alphablending enthalten, ist es wichtig, in welcher Reihenfolge sie gezeichnet werden.
Das blaue Quadrat ist in beiden Fällen über das Rote Qudrat gezeichnet.
Links wurde zuerst das rote Qudrat gezeichnet, Rechts ist es genau umgekehrt. Die Z-Position ist in beiden Fällen die gleiche.
Im rechten Beispiel ist die darstellung falsch, weil das rote Rechteck später gezeichnet wurde. Der Z-Puffer erkennt nicht ob es um transparente Polygone handelt.
Das man den Effekt noch stärker sieht, kann man den Alpha-Kanal auf <b>0.0</b> stellen.

Man sollte sich angewöhnen, zuerst immer die untransparenten Polygone zu zeichnen und die durchsichtigen erst später.
Auch sollte man berücksichtigen, das man zuerst die Elemente zeichnet, die von einem weiter weg sind.

Ich weis, dies tönt einfacher, als es in der Praxis ist.
Bei komplexen Szenen kommt man nicht um das sortieren der Meshes.
*)

//lineal

(*
Für den Vertex-Puffer wird nur ein einfaches Quadrat gebraucht.
Die Farbe und Alpha-Kanal werden per Uniform dem Shader übergeben.
*)
//code+
type
  TFace3f = array[0..2] of TVector3f;

const
  QuadVector: array[0..1] of TFace3f =
    (((-0.3, -0.4, 0.0), (-0.3, 0.4, 0.0), (0.3, 0.4, 0.0)),
    ((-0.3, -0.4, 0.0), (0.3, 0.4, 0.0), (0.3, -0.4, 0.0)));
//code-

type
  TVB = record
    VAO,
    VBOvert: GLuint;  // VBO für Farbe.
  end;

var
  MatrixTrans: TMatrix;     // Matrix
  MatrixRot_ID: GLint;    // ID für Matrix.
  Color_ID: GLint;        // ID für Color.

  VBQuad: TVB;


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
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  MatrixRot_ID := Shader.UniformLocation('mat');
  Color_ID := Shader.UniformLocation('Color');
  MatrixTrans.Identity;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOvert);
end;

(*
Bei einem einfachen Quadrat ist InitScene sehr einfach gehalten.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe

  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                     // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;
//code-

(*
Zeichnen der 4 Rechtecke.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  col: TVector4f;
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.
  Shader.UseProgram;
  MatrixTrans.Identity;

  glBindVertexArray(VBQuad.VAO);

  // --- Links ( Richtige Darstellung )
  // Rot
  col := vec4(1.0, 0.0, 0.0, 1.0);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-0.5, 0.2, 0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  // blau transparent
  col := vec4(0.0, 0.0, 1.0, 0.3);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-0.4, -0.2, -0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;


  // --- Rechts ( Falsche Darstellung )
  // blau transparent
  col := vec4(0.0, 0.0, 1.0, 0.3);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(0.4, -0.2, -0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  // Rot
  col := vec4(1.0, 0.0, 0.0, 1.0);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(0.5, 0.2, 0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOvert);
end;

//lineal

(*
Die Shader sind sehr einfach gehalten. Es hat nur zwei Uniform für die Matrix und dem Color mit Alpha.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
