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
Wie schon beschrieben, sind auch mehrere Lichtquellen möglich.

In diesem Beispiel habe ich 3 Directionale Lichtquellen eingefügt, welche sich bewegen.
Das man die einzelnen Lichquellen besser sieht, habe ich sie in 3 Farben dargestellt.

Als Meshes habe ich Kugeln gewählt, so sieht man die Übergänge von hell nach dunkel besser.

Das man die Lichteffekte besser sieht, kann man sie über das Menü ein und aus schalten.
Auch kann man die Rotierung anhalten und die Anzahl der Kugeln verändern.

Wen man nur eine Kugel hat, sieht man die Bewegung des Lichtes sehr gut.
Wen man alle 3 Lichter ausschaltet, dann sieht man die Ambiente Hintergrund-Beleuchtung sehr gut.

Die Lichtposition ist nicht mehr im Shader als Konstante deklariert, sie wurde mit einer <b>Uniform-Variable</b> nach aussen verlagert.
*)
//lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItemRedOn: TMenuItem;
    MenuItemGreenOn: TMenuItem;
    MenuItemBlueOn: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemRotateRed: TMenuItem;
    MenuItemRotateGreen: TMenuItem;
    MenuItemRotateBlue: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemRotateCube: TMenuItem;
    MenuItemPlus: TMenuItem;
    MenuItemMinus: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
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
(*
Die Lichtpositionen als 3D-Vektorn definiert.
*)
//code+
var
  LightPos: record
    Red, Green, Blue: TVector3f;
  end;
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
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
  Matrix_ID: GLint;

  LightPos_ID: record
    Red, Green, Blue: GLint;
  end;

  ColorOn_ID: record
    Red, Green, Blue: GLint;
  end;

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

procedure TForm1.CreateScene;
begin
  CalcSphere;

  CubeSize := 4;

  with LightPos do begin
    Red := vec3(-1.0, 0.0, 0.0);
    Green := vec3(0.0, 1.0, 0.0);
    Blue := vec3(1.0, 1.0, 1.0);
  end;

  Matrix.Identity;

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
    with LightPos_ID do begin
      Red := UniformLocation('RedLightPos');
      Green := UniformLocation('GreenLightPos');
      Blue := UniformLocation('BlueLightPos');
    end;

    with ColorOn_ID do begin
      Red := UniformLocation('RedOn');
      Green := UniformLocation('GreenOn');
      Blue := UniformLocation('BlueOn');
    end;
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Daten für Kugel
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
Hier werden die verschiedenen Parameter für die Lichtparamter über Uniform am Shader übergeben.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  // Lichtpositionen
  with LightPos_ID do begin
    glUniform3fv(Red, 1, @LightPos.Red);
    glUniform3fv(Green, 1, @LightPos.Green);
    glUniform3fv(Blue, 1, @LightPos.Blue);
  end;

  // Licht Ein/Aus - Parameter
  with ColorOn_ID do begin
    glUniform1i(Red, GLint(MenuItemRedOn.Checked));
    glUniform1i(Green, GLint(MenuItemGreenOn.Checked));
    glUniform1i(Blue, GLint(MenuItemBlueOn.Checked));
  end;
//code-

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

        Matrix.Uniform(ModelMatrix_ID);

        Matrix := FrustumMatrix * WorldMatrix *  Matrix;         // Matrixen multiplizieren.

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

(*
Auf verlangen Würfel drehen und Lichtposition verändern.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if MenuItemRotateCube.Checked then begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse
  end;

  with LightPos do begin
    if MenuItemRotateRed.Checked then begin
      Red.RotateA(0.031);
      Red.RotateB(0.011);
    end;

    if MenuItemRotateGreen.Checked then begin
      Green.RotateB(0.021);
      Green.RotateC(0.015);
    end;

    if MenuItemRotateBlue.Checked then begin
      Blue.RotateA(0.021);
      Blue.RotateC(0.023);
    end;
  end;
//code-

  ogc.Invalidate;
end;

//lineal

(*
Wen man mehrere Lichtquellen hat, werden diese alle <b>addiert</b>.
Dies sieht man gut am Ende des Vertex-Shader, dort wo es die<b> += </b>hat.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
