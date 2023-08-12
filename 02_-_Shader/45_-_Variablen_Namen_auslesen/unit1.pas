unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

  //image image.png
(*
Es ist auch möglich aus dem <b>Shader auszulesen</b>, welche Variablen dort verwendet werden.
In diesem Beispiel werden <b>Attribut</b>, <b>Uniform</b> und <b>Uniform-Blöcke</b> ausgelesen.
Für was man <b>Uniform-Blöcke</b> verwendet, wird in einem späteren Kapitel behandelt.
Auch die Beleuchtung, etc. wird später behandelt.
*)
  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
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

var
  mRubin: TMaterial;

  SphereVertex, SphereNormal: array of Tmat3x3;
  CubeSize: integer;

type
  TVB = record
    VAO,
    VBOvert,            // VBO für Vektor.
    VBONormal: GLuint;  // VBO für Normale.
  end;

var
  UBO: GLuint;        // Puffer-Zeiger
  Material_ID: GLint; // ID im Shader

  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
  Matrix_ID: GLint;

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

    Vector0.Normalize;
    Vector1.Normalize;
    Vector2.Normalize;

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

procedure TForm1.CreateScene;
begin
  CalcSphere;

  CubeSize := 4;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    ModelMatrix_ID := UniformLocation('ModelMatrix');

    Material_ID := UniformBlockIndex('Material'); // UBO-Block ID aus dem Shader holen.
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
var
  bindingPoint: gluint = 0; // Pro Verbindung wird ein BindingPoint gebraucht.
begin
  // Material-Werte inizialisieren
  with mRubin do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;


  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TMaterial), @mRubin, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);

  glClearColor(0.15, 0.15, 0.1, 1.0);

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

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Kugeln

  d := (7 / (CubeSize * 2 + 1)) * 8;

  if CubeSize > 0 then begin
    scal := 20 / (CubeSize * 2 + 1);
  end else begin
    scal := 30;
  end;

  mRubin.ambient := vec3(1, 1, 1);
  glUniform1fv(Material_ID, SizeOf(mRubin), @mRubin);

  for x := -CubeSize to CubeSize do begin
    for y := -CubeSize to CubeSize do begin
      for z := -CubeSize to CubeSize do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                   // Matrix verschieben.
        Matrix.Scale(scal);
        Matrix := ModelMatrix * Matrix;

        Matrix.Uniform(ModelMatrix_ID);

        Matrix := WorldMatrix * Matrix;                          // Matrixen multiplizieren.
        Matrix := FrustumMatrix * Matrix;

        Matrix.Uniform(Matrix_ID);                               // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBONormal);
  glDeleteBuffers(1, @UBO);  // UBO löschen.
end;

(*
Mit <b>glGetProgramiv(...</b> wird ermittelt, wie viele Variablen dieses Typen hat.
Mit <b>glGetActiveAttrib(...</b> wird der Bezeichner der Variable ausgelesen. Typ gibt die Art der Variable an, zB. <b>vec3</b>, <b>mat4</b>, etc.
Der komplexe Beleuchtungs-Shader wird später beschrieben.
*)
//code+
procedure TForm1.MenuItem1Click(Sender: TObject);
var
  s: ansistring;
  i, Count, len, size, Typ: integer;
  sl: TStringList;

begin
  sl := TStringList.Create;

  sl.Add('Attribute:');
  SetLength(s, 255);
  glGetProgramiv(Shader.ID, GL_ACTIVE_ATTRIBUTES, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveAttrib(Shader.ID, i, 255, len, size, Typ, @s[1]);
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;
  sl.Add('');

  sl.Add('Uniform:');
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORMS, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveUniform(Shader.ID, i, 255, len, size, Typ, @s[1]);
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;
  sl.Add('');

  sl.Add('Uniform-Blöcke:');
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveUniformBlockName(Shader.ID, i, 255, @len, @s[1]);
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;

  ShowMessage(sl.Text);
  sl.Free;
end;

//code-

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
  ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

//lineal

(*
Hier wurde noch eine Variable <b>KeineVerwendung</b> deklariert, da diese von Compiler wegoptimiert wurde, wird so auch nicht aufgelistet.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
