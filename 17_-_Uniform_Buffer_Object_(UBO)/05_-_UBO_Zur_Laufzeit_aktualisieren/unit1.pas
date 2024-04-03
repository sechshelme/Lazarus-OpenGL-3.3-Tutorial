unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix;

//image image.png
(*
UBO-Daten können auch zur Laufzeit geändert/neu geladen werden, so wie es beim Vertex-Puffer auch geht.
Auf diese Art, werden die Uniform-Daten aktualisiert. Dies ersetzt die Aktualisierung mit <b>glUniformxxx</b>.

In diesem Beispiel wird das Material der Kugeln gewechselt, abwechslungsweise Rubin oder Jade.
Dazu wird alle 1s die UBO-Daten aktualisiert.
*)
//lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemRotateCube: TMenuItem;
    MenuItemPlus: TMenuItem;
    MenuItemMinus: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
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

(*
Es werden zwei Materialien gebraucht, welche abwechslungsweise neu geladen werden.
*)
//code+
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
  mRubin, mJade: TMaterial;
//code-

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

    Material_ID := UniformBlockIndex('Material'); // ID aus dem Shader holen.
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.

  Timer1.Enabled := True;
  Timer2.Enabled := True;
end;

(*
Material-Daten in den UBO-Puffer laden und binden
*)
//code+
procedure TForm1.InitScene;
var
  bindingPoint: gluint = 0;
begin
  // Material-Werte inizialisieren
  with mRubin do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;

  with mJade do begin
    ambient := vec3(0.14, 0.22, 0.16);
    diffuse := vec3(0.54, 0.89, 0.63);
    specular := vec3(0.32, 0.32, 0.32);
    shininess := 12.8;
  end;

  // Speicher für UBO reservieren
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);

  // Timer manuell aufrufen, so das die ersten Daten in den UBO-kopiert werden.
  Timer2Timer(nil);
  //code-

  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Vertex-Daten für Kugel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereVertex) * SizeOf(Tmat3x3), Pointer(SphereVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereNormal) * SizeOf(Tmat3x3), Pointer(SphereNormal), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, nil);

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

  for x := -CubeSize to CubeSize do begin
    for y := -CubeSize to CubeSize do begin
      for z := -CubeSize to CubeSize do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                   // Matrix verschieben.
        Matrix.Scale(scal);
        Matrix := ModelMatrix * Matrix;

        Matrix.Uniform(ModelMatrix_ID);                          // Erste Übergabe an den Shader.

        Matrix := FrustumMatrix * WorldMatrix *  Matrix;         // Matrizen multiplizieren.

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
  glDeleteBuffers(1, @UBO);
end;

procedure TForm1.MenuItemClick(Sender: TObject);
begin
  if Sender = MenuItemPlus then begin
    if CubeSize < 7 then begin
      Inc(CubeSize);
    end;
  end else if Sender = MenuItemMinus then begin
    if CubeSize > 0 then begin
      Dec(CubeSize);
    end;
  end;
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
Hier sieht man gut, wie die UBO-Daten aktualisiert werden.
Der Timer wird alle 1s aufgerufen.
*)
//code+
procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;
begin
  case m of
    0: begin
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TMaterial), @mRubin);
    end;
    1: begin
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TMaterial), @mJade);
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
