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
Es ist auch möglich, mehrere Unifom-Blöcke im Shader anzulegen.
Ein Uniform-Block wurde verwendet für die Matrizen.
Der andere für die Lichtparameter.

Hier sieht man auch gut wie einfach es ist, alle Parameter für die 3 Lampen in einem Rutsch dem Shader zu übergeben.
glUniform müsste man dazu zig mal aufrufen und wen man mehrere Shader verwendet, müsste man dies sogar bei jeden Shader einzeln machen.
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
  CubeSize: integer;

type
  TVB = record
    VAO,
    VBOvert: GLuint;
  end;

(*
Die Deklaration der Lichtparameter und der Matrizen für den UBO.
*)
//code+
type
  TLight = record
    Uniform_ID,
    UBO: GLuint;
    bindingPoint: gluint;
    Data: array[0..2] of record
      On: boolean;
      CutOff: GLfloat;
      pad0: TVector2f;
      Pos: TVector3f;
      pad1: GLfloat;
      Color: TVector3f;
      pad2: GLfloat;
    end;
  end;

  TMatrixRec = record
    Uniform_ID,
    UBO: GLuint;
    bindingPoint: gluint;
    Data: record
      Model,
      World: TMatrix;
    end;
  end;

var
  Light: TLight;
  MatrixRec: TMatrixRec;
//code-


var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix: TMatrix;

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
Die Lichtparameter mit Anfangswerten laden.
*)
//code+
procedure TForm1.CreateScene;
const
  LichtPositionRadius = 50.0;
var
  i: integer;
begin
  with Light do begin
    bindingPoint := 0;
    for i := 0 to 2 do begin
      with Data[i] do begin
        On := True;
        CutOff := cos(pi / 2 / 16);
        Color.FromInt($FF0000 shr (i * 8));
      end;
    end;

    with Data[0] do begin
      Pos := vec3(-1.0, 0.0, 0.0);
      Pos.Scale(LichtPositionRadius);
    end;

    with Data[1] do begin
      Pos := vec3(0.0, 1.0, 0.0);
      Pos.Scale(LichtPositionRadius);
    end;

    with Data[2] do begin
      Pos := vec3(1.0, 1.0, -1.0);
      Pos.Scale(LichtPositionRadius);
    end;
  end;
  //code-

  CubeSize := 4;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;

    MatrixRec.Uniform_ID := UniformBlockIndex('Matrix');
    Light.Uniform_ID := UniformBlockIndex('light0');
  end;

  glGenBuffers(1, @Light.UBO);                          // UB0-Puffer generieren.

  glGenBuffers(1, @MatrixRec.UBO);

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOvert);

  Timer1.Enabled := True;
end;

(*
Für die beiden UBOs Speicher reservieren.
*)
//code+
procedure TForm1.InitScene;
begin
  with Light do begin
    // Speicher für UBO reservieren
    glBindBuffer(GL_UNIFORM_BUFFER, UBO);
    glBufferData(GL_UNIFORM_BUFFER, sizeof(Data), nil, GL_DYNAMIC_DRAW);

    // UBO mit dem Shader verbinden
    glUniformBlockBinding(Shader.ID, Uniform_ID, bindingPoint);
    glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);
  end;

  with MatrixRec do begin
    bindingPoint := 3;

    // Speicher für UBO reservieren
    glBindBuffer(GL_UNIFORM_BUFFER, UBO);
    glBufferData(GL_UNIFORM_BUFFER, sizeof(Data), nil, GL_DYNAMIC_DRAW);

    // UBO mit dem Shader verbinden
    glUniformBlockBinding(Shader.ID, Uniform_ID, bindingPoint);
    glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);
  end;
  //code-

  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeVertex) * SizeOf(Tmat3x3), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

(*
Hier sieht man gut, wie die UBO-Daten neu in den Puffer geladen werden.
Die Lichtparamter, werden über das Menü und dem Timer verändert.
Die Matrizen werden hier berechnet.
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

  // --- Lichtparameter in UBO laden.
  with Light do begin
    glBindBuffer(GL_UNIFORM_BUFFER, UBO);
    glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(Data), @Data);
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
        with MatrixRec do begin
          // --- Matrixzen berechnen.
          with Data do begin
            Model.Identity;
            Model.Translate(x * d, y * d, z * d);
            Model.Scale(scal);
            Model := ModelMatrix * Model;

            World := Model;

            World := FrustumMatrix * WorldMatrix * World;
          end;

          // --- Matrixzen in UBO laden.
          glBindBuffer(GL_UNIFORM_BUFFER, UBO);
          glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(Data), @Data);
        end;

        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);

  glDeleteBuffers(1, @Light.UBO);        // UB0-Puffer löschen

  glDeleteBuffers(1, @MatrixRec.UBO);
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
    with Light do begin
      Data[0].On := MenuItemRedOn.Checked;
    end;

  end else if Sender = MenuItemGreenOn then begin
    with Light do begin
      Data[1].On := MenuItemGreenOn.Checked;
    end;

  end else if Sender = MenuItemBlueOn then begin
    with Light do begin
      Data[2].On := MenuItemBlueOn.Checked;
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
    with Light.Data[0] do begin
      Pos.RotateA(0.031);
      Pos.RotateB(0.11);
    end;
  end;

  if MenuItemRotateGreen.Checked then begin
    with Light.Data[1] do begin
      Pos.RotateB(-0.021);
      Pos.RotateC(-0.15);
    end;
  end;

  if MenuItemRotateBlue.Checked then begin
    with Light.Data[2] do begin
      Pos.RotateA(0.021);
      Pos.RotateC(-0.23);
    end;
  end;

  ogc.Invalidate;
end;

//lineal

(*
Im Shader sieht man die beiden Uniform-Blöcke.
Für die Matrizen im Vertex-Shader, und für die Lichtparameter im Fragment-Shader.
Es dürfen auch mehrere Blöcke in einem Shader vorhanden sein.
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
