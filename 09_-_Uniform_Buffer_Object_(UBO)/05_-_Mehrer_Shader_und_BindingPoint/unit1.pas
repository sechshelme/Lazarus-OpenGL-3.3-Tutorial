unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

//image image.png
(*
In diesem Beispiel wird gezeigt, was der <b>BindingPoint</b> für einen Einfluss hat.
Es werden 3 Shader erzeugt, das es einfacher ist, habe ich 3mal die gleichen Shader-Sourcen genommen.
Bei 2 Shadern werden die UBO-Daten mit dem <b>BindingPoint 0</b> verbunden, der einzelne Shader mit <b>BindingPoint</b> 1.
*)
//lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem2: TMenuItem;
    MenuItemRotateCube: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    ogc: TContext;
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcResize(Sender: TObject);

    procedure CalcSphere;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TMaterial = record
    ambient: TVector3f;      // Umgebungslicht
    pad0: GLfloat;           // padding 4Byte
    diffuse: TVector3f;      // Farbe
    pad1: GLfloat;           // padding 4Byte
    specular: TVector3f;     // Spiegelnd
    shininess: GLfloat;      // Glanz
  end;

  TVB = record
    VAO,
    VBOvert,            // VBO für Vektor.
    VBONormal: GLuint;  // VBO für Normale.
  end;

var
  Material: TMaterial;

  SphereVertex, SphereNormal: array of Tmat3x3;

(*
Es werden drei UNOs angelegt.
Die Uniform IDs werden füür jeden Shader einzeln ID gebraucht.
Daher habe ich es in einem Record zusammengefasst.

Man sieht auch, das 2 BindingPoints verwendet werden.
*)
//code+
var
  UBO: record
    Rubin, Jade, Smaragdgruen: GLuint;        // Puffer-Zeiger
  end;

  ShaderData: array[0..2] of record
    Shader: TShader;
    Material_ID,
    ModelMatrix_ID,
    Matrix_ID: GLint;
  end;

  bindingPoint0: gluint = 0;
  bindingPoint1: gluint = 1;
  //code-

  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss

  CreateScene;
  InitScene;
end;

procedure TForm1.CalcSphere;

  procedure Triangles(Vector0, Vector1, Vector2: TVector3f);
  var
    l: integer;
  begin
    l := Length(SphereVertex);
    SetLength(SphereVertex, l + 1);
    SetLength(SphereNormal, l + 1);

    SphereVertex[l, 0] := Vector0;
    SphereVertex[l, 1] := Vector1;
    SphereVertex[l, 2] := Vector2;

    Vector0.NormalCut;
    Vector1.NormalCut;
    Vector2.NormalCut;

    SphereNormal[l, 0] := Vector0;
    SphereNormal[l, 1] := Vector1;
    SphereNormal[l, 2] := Vector2;
  end;

  procedure Quads(Vector0, Vector1, Vector2, Vector3: TVector3f); inline;
  begin
    Triangles(Vector0, Vector1, Vector2);
    Triangles(Vector0, Vector2, Vector3);
  end;

const
  Sektoren = 32;
var
  i, j: integer;
  t, rk: single;

  Tab: array of array of record
    a, b, c: single;
  end;

begin
  t := 2 * pi / Sektoren;
  SetLength(Tab, Sektoren + 1, Sektoren div 2 + 1);
  for j := 0 to Sektoren div 2 do begin
    rk := sin(t * j);
    for i := 0 to Sektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;

  for j := 0 to Sektoren div 2 - 1 do begin
    for i := 0 to Sektoren - 1 do begin
      Quads(
        vec3(Tab[i + 0, j + 1].a, Tab[i + 0, j + 1].c, Tab[i + 0, j + 1].b),
        vec3(Tab[i + 1, j + 1].a, Tab[i + 1, j + 1].c, Tab[i + 1, j + 1].b),
        vec3(Tab[i + 1, j + 0].a, Tab[i + 1, j + 0].c, Tab[i + 1, j + 0].b),
        vec3(Tab[i + 0, j + 0].a, Tab[i + 0, j + 0].c, Tab[i + 0, j + 0].b));

    end;
  end;
  SetLength(Tab, 0, 0);
end;

(*
Es werden 3 Shader geladen in die Uniform-IDs ausgelesen.
*)
//code+
procedure TForm1.CreateScene;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    with ShaderData[i] do begin
      Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
      with Shader do begin
        UseProgram;
        Matrix_ID := UniformLocation('Matrix');
        ModelMatrix_ID := UniformLocation('ModelMatrix');

        Material_ID := UniformBlockIndex('Material'); // ID aus dem Shader holen.
      end;
    end;
  end;
  //code-

  CalcSphere;

  Matrix := TMatrix.Create;
  FrustumMatrix := TMatrix.Create;

  WorldMatrix := TMatrix.Create;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix := TMatrix.Create;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  glGenBuffers(3, @UBO);          // Die 3 UB0-Puffer generieren.

  Timer1.Enabled := True;
  Timer2.Enabled := True;
end;

(*
Material-Daten in den UBO-Puffer laden und binden.

Man sieht, das beim Shader[2] ein anderer BindingPoint verwendet wird.
*)
//code+
procedure TForm1.InitScene;
begin
  // Puffer für Rubin anlegen.
  with Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Rubin);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Jade anlegen.
  with Material do begin
    ambient := vec3(0.14, 0.22, 0.16);
    diffuse := vec3(0.54, 0.89, 0.63);
    specular := vec3(0.32, 0.32, 0.32);
    shininess := 12.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Jade);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Smaragdgruen anlegen.
  with Material do begin
    ambient := vec3(0.02, 0.17, 0.02);
    diffuse := vec3(0.08, 0.81, 0.08);
    specular := vec3(0.63, 0.73, 0.63);
    shininess := 76.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Smaragdgruen);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Verbindung mit dem Shader aufbauen.
  with ShaderData[0] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[1] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[2] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint1);
  end;

  // Die Puffer das erste mal binden.
  // Das sieht man, das der Shader[2] mit Jade gebunden wird.
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint1, UBO.Jade);

  //code-

  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Vertex-Daten für Kugel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereVertex) * SizeOf(Tmat3x3), Pointer(SphereVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereNormal) * SizeOf(Tmat3x3), Pointer(SphereNormal), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

end;

(*
Die Scene wird drei mal mit unterschiedlichen Shadern gezeichnet.
Um die UBO muss man da sich nicht kümmern, das diese mit dem BindingPoint gebunden sind.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(VBCube.VAO);

  d := 6.0;
  scal := 10;

  // --- Zeichne Kugeln

  with ShaderData[0] do begin
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d, d, d);
    Matrix.Scale(scal);
    Matrix.Multiply(ModelMatrix, Matrix);

    Matrix.Uniform(ModelMatrix_ID);

    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  // --- Zeichne Kugeln

  with ShaderData[1] do begin
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d + 30, d, d);
    Matrix.Scale(scal);
    Matrix.Multiply(ModelMatrix, Matrix);

    Matrix.Uniform(ModelMatrix_ID);

    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  // --- Zeichne Kugeln

  with ShaderData[2] do begin
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d - 30, d, d);
    Matrix.Scale(scal);
    Matrix.Multiply(ModelMatrix, Matrix);

    Matrix.Uniform(ModelMatrix_ID);

    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix.Multiply(FrustumMatrix, Matrix);

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    ShaderData[i].Shader.Free;
  end;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBONormal);
  glDeleteBuffers(3, @UBO);

  Matrix.Free;
  FrustumMatrix.Free;
  ModelMatrix.Free;
  WorldMatrix.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if MenuItemRotateCube.Checked then begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse
  end;

  ogc.Invalidate;
end;

(*
Es wird nur der BindingPoint 0 geändert.
Somit sit man beim <b>Shader[2]</b> der mit <b>BindingPoint 1</b> gebunden ist keine Änderung.
*)
//code+
procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;
begin
  case m of
    0: begin
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
    end;
    1: begin
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Smaragdgruen);
    end;
  end;

  Inc(m);
  if m > 1 then begin
    m := 0;
  end;
end;
//code-

//lineal

(*
Der Shader ist der selbe wie im ersten Beispiel.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
