unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix;

//image image.png
(*
Da es für ein Spotlicht mehrere Schritte braucht, wird dies in mehreren Beispielen gezeigt.

In diesem Beispiel wird zuerst mal gezeigt, wie der Lichtkegen berechnet wird.
Die Beleuchtung berechnung mit den Normalen wird zuerst mal ingnoriert.
So sieht man gut, wie der Lichtkegel entsteht.
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
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TCube = array[0..11] of Tmat3x3;

const
  CubeVertex: TCube =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

var
  //LightPos: record
  //  Red, Green, Blue: TVector3f;
  //end;

  CubeSize: integer;


type
  TVB = record
    VAO,
    VBOvert: GLuint;
  end;

  TLight = record
    Uniform_ID,
    UBO: GLuint;
    bindingPoint: gluint;
    Data: record
      On: boolean;
      CutOff: GLfloat;
      pad0: TVector2f;
      Pos: TVector3f;
      pad1: GLfloat;
      Color: TVector3f;
    end;
  end;

var
  Light: array[0..2] of TLight;


var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
  Matrix_ID: GLint;

//LightPos_ID: record
//  Red, Green, Blue: GLint;
//end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;

  CreateScene;
  InitScene;
end;

(*
Bei einem Spotlicht, ist die Lichtposition kein Einheitsvektor mehr.
Die Licht-Position ist ist die effektive Position der Lichtquelle, so wie es bei einer Taschenlampe auch der Fall ist.

Da die <b>halbe</b> Seitenlänge der kompletten Meshes etwa 30.0 lang ist, wird das Licht in einem Radius von 25.0 positioniert.
Die Lichtquelle befindet sich somit in dem kompletten Würfel-Körper.

Als Versuch kann man den Radius mal auf 50.0 setzen, dann wird man sehen, das die Lichtquelle ausserhalb der Meshes ist.

Es werden Einheitsvektoren um den Faktor <b>LichtPositionRadius</b> skaliert.
*)
//code+
procedure TForm1.CreateScene;
const
  LichtPositionRadius = 25.0;
var
  i: integer;
begin
  with Light[0].Data do begin
    Pos := vec3(-1.0, 0.0, 0.0);
    Pos.Scale(LichtPositionRadius);
  end;

  with Light[1].Data do begin
    Pos := vec3(0.0, 1.0, 0.0);
    Pos.Scale(LichtPositionRadius);
  end;

  with Light[2].Data do begin
    Pos := vec3(1.0, 1.0, -1.0);
    Pos.Scale(LichtPositionRadius);
  end;
  //code-

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

    Light[0].Uniform_ID := UniformBlockIndex('light0');
    Light[1].Uniform_ID := UniformBlockIndex('light1');
    Light[2].Uniform_ID := UniformBlockIndex('light2');
  end;

  for i := 0 to 2 do begin
    with Light[i] do begin
      glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.
    end;
  end;

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOvert);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    with Light[i] do begin
      bindingPoint := i;
      Data.On := True;
      Data.Color.FromInt($FF shl (i * 8));

      // Speicher für UBO reservieren
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferData(GL_UNIFORM_BUFFER, sizeof(Data), nil, GL_DYNAMIC_DRAW);

      // UBO mit dem Shader verbinden
      glUniformBlockBinding(Shader.ID, Uniform_ID, bindingPoint);
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);

    end;
  end;

  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeVertex) * SizeOf(Tmat3x3), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i, x, y, z: integer;
  scal, d: single;
  a:TStringArray;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  for i := 0 to 2 do begin
    with Light[i] do begin
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(Data), @Data);
    end;
  end;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Würfel

  d := (7 / (CubeSize * 2 + 1)) * 8;

  if CubeSize > 0 then begin
    scal := 40 / (CubeSize * 2 + 1);
  end else begin
    scal := 60;
  end;
  scal /= 2;

  for x := -CubeSize to CubeSize do begin
    for y := -CubeSize to CubeSize do begin
      for z := -CubeSize to CubeSize do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.
        Matrix.Scale(scal);
        Matrix.Multiply(ModelMatrix, Matrix);

        Matrix.Uniform(ModelMatrix_ID);

        Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
        Matrix.Multiply(FrustumMatrix, Matrix);

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
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
var
  i: integer;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);

  for i := 0 to 2 do begin
    with Light[i] do begin
      glDeleteBuffers(1, @UBO);        // UB0-Puffer löschen
    end;
  end;
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
  end else if Sender = MenuItemRedOn then begin
    with Light[0] do begin
      Data.On := MenuItemRedOn.Checked;
    end;

  end else if Sender = MenuItemGreenOn then begin
    with Light[1] do begin
      Data.On := MenuItemGreenOn.Checked;
    end;

  end else if Sender = MenuItemBlueOn then begin
    with Light[2] do begin
      Data.On := MenuItemBlueOn.Checked;
    end;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if MenuItemRotateCube.Checked then begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0134);  // Drehe um Y-Achse
  end;

  if MenuItemRotateRed.Checked then begin
    with Light[0].Data do begin
      Pos.RotateA(0.031);
      Pos.RotateB(0.11);
    end;
  end;

  if MenuItemRotateGreen.Checked then begin
    with Light[1].Data do begin
      Pos.RotateB(0.021);
      Pos.RotateC(0.15);
    end;
  end;

  if MenuItemRotateBlue.Checked then begin
    with Light[2].Data do begin
      Pos.RotateA(0.021);
      Pos.RotateC(0.23);
    end;
  end;

  ogc.Invalidate;
end;

//lineal

(*
Hier wird die Kegelberechnung ausgeführt.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>

Der wichtigste Parameter ist der Ausstrahlwinkel der Lichtes.

Man muss beachten, das der Winkel doppelt so gross wird. Somit hat Pi/2 einen Austrahlwinkel von 180°.
1*Pi entpräche einem Ausstrahlwinkel von 380°, somit bekommt man ein Punkt-Licht.

Für die Berechnung des Kegels wird ein Skalarprodukt verwendet.
*)
//includeglsl Fragmentshader.glsl

end.
