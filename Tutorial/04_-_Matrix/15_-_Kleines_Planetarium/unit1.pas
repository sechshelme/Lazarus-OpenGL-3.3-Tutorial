unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

type
  { TPlanet }

  TPlanet = class(TObject)
  private
    type
    TFaceArray = array of TFace3D;

    TMesh = record
      Vector, Color: TFaceArray;
      size: integer;
    end;

  var
    VAO,
    VBOvert, VBOcol: GLuint;
    Mesh: TMesh;
    fPlanetScale,
    fPlanetSpeed, FMondSpeed, FUmlaufSpeed: GLfloat;

    TempMatrix,
    PlanetRotMatrix, UmlaufTransMatrix, MondRotMatrix, MondTransMatrix, UmlaufRotMatrix: TMatrix;

    procedure SetMondR(AValue: GLfloat);
    procedure SetUmlaufR(AValue: GLfloat);
  public
    property PlanetScale: GLfloat write fPlanetScale;
    property PlanetSpeed: GLfloat write fPlanetSpeed;
    property MondSpeed: GLfloat write fMondSpeed;
    property UmlaufSpeed: GLfloat write fUmlaufSpeed;
    property MondR: GLfloat write SetMondR;
    property UmlaufR: GLfloat write SetUmlaufR;

    constructor Create(col: TVector3f);
    destructor Destroy; override;

    procedure Draw;
  end;


  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    Sonne, Venus, Erde, Mond, Mars: TPlanet;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Kleines Planetarium, welches die Handhabung von Matrixen demonstriert.
Das es übersichtlicher wird, habe ich die Sonne und die Planeten in eine Klasse gepackt.

Am Shader wird nur eine Matrix übergeben, welche von der CPU berechnet wird.
Diese Matrix wird aus verschiedene Transformen berechnet.
*)
//lineal

(*
Es gibt nur eine ID, da die ganzen Matrixen-Berechnung mit der CPU ausgeführt werden.
*)
//code+
var
  Matrix_ID: GLint;  // ID für Matrix.
//code-

{ TPlanet }

(*
Rendern der Sonne und der Paneten.
Dies sind nur farbige Kreise. Der Rest wird später über Matrizen brechnet.
*)
//code+
constructor TPlanet.Create(col: TVector3f);
const
  maxSektor = 17;  // Anzahl Sektoren der Kreise.
var
  i, j: integer;
begin
  inherited Create;

  with Mesh do begin
    size := maxSektor;
    SetLength(Vector, size);
    SetLength(Color, size);
    for i := 0 to size - 1 do begin
      for j := 0 to 2 do begin
        Color[i, j] := vec3(col[0] + (Random / 4), col[1] + (Random / 4), col[2] + (Random / 4));
      end;

      Vector[i, 0] := vec3(0.0, 0.0, 0.0);
      Vector[i, 1] := vec3(sin(Pi * 2 / size * i), cos(Pi * 2 / size * i), 0.0);
      Vector[i, 2] := vec3(sin(Pi * 2 / size * (i + 1)), cos(Pi * 2 / size * (i + 1)), 0.0);
      //      Vector[i, 1] := vec3(sin(Pi * 2 / size * i) * PlanetR, cos(Pi * 2 / size * i) * PlanetR, 0.0);
      //      Vector[i, 2] := vec3(sin(Pi * 2 / size * (i + 1)) * PlanetR, cos(Pi * 2 / size * (i + 1)) * PlanetR, 0.0);
    end;
  end;
  //code-

  TempMatrix := TMatrix.Create;

  PlanetRotMatrix := TMatrix.Create;

  MondRotMatrix := TMatrix.Create;
  MondTransMatrix := TMatrix.Create;

  UmlaufRotMatrix := TMatrix.Create;
  UmlaufTransMatrix := TMatrix.Create;

  glGenVertexArrays(1, @VAO);
  glGenBuffers(1, @VBOvert);
  glGenBuffers(1, @VBOcol);

  glBindVertexArray(VAO);

  with Mesh do begin
    // Vektor
    glBindBuffer(GL_ARRAY_BUFFER, VBOvert);
    glBufferData(GL_ARRAY_BUFFER, sizeof(TFace3D) * size, Pointer(Vector), GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

    // Farbe
    glBindBuffer(GL_ARRAY_BUFFER, VBOcol);
    glBufferData(GL_ARRAY_BUFFER, sizeof(TFace3D) * size, Pointer(Color), GL_STATIC_DRAW);
    glEnableVertexAttribArray(11);
    glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);
  end;
end;

destructor TPlanet.Destroy;
begin
  TempMatrix.Free;
  PlanetRotMatrix.Free;
  UmlaufTransMatrix.Free;
  UmlaufRotMatrix.Free;
  MondRotMatrix.Free;
  MondTransMatrix.Free;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBOvert);
  glDeleteBuffers(1, @VBOcol);

  inherited Destroy;
end;

(*
Legt die Matrix für die Umlaufbahnen fest.
*)
//code+
procedure TPlanet.SetMondR(AValue: GLfloat);
begin
  MondTransMatrix.Translate(AValue, 0.0, 0.0);  // Distanz Erde - Mond. ( Erde Mond ist ein Doppelplanet )
end;

procedure TPlanet.SetUmlaufR(AValue: GLfloat);
begin
  UmlaufTransMatrix.Translate(AValue, 0.0, 0.0); // Distanz Sonne - Panet.
end;
//code-

(*
Hier werden die Bahnen der Planeten berechnet und anschliessend gezeichnet.
*)
//code+
procedure TPlanet.Draw;
begin
  UmlaufRotMatrix.RotateC(FUmlaufSpeed);
  PlanetRotMatrix.RotateC(fPlanetSpeed);
  MondRotMatrix.RotateC(FMondSpeed);

  // TempMatrix = UmlaufRotMatrix * UmlaufTransMatrix * MondRotMatrix * MondTransMatrix * PlanetRotMatrix;

  TempMatrix.Assign(PlanetRotMatrix);
  TempMatrix.Scale(fPlanetScale);

  TempMatrix.Multiply(MondTransMatrix, TempMatrix);
  TempMatrix.Multiply(MondRotMatrix, TempMatrix);

  TempMatrix.Multiply(UmlaufTransMatrix, TempMatrix);
  TempMatrix.Multiply(UmlaufRotMatrix, TempMatrix);

  TempMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, Mesh.size * 3);
end;
//code-

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
  Timer1.Enabled := True;
end;

(*
Die Parameter für die Sonne und Planeten.
*)
//code+
procedure TForm1.CreateScene;
begin
  Sonne := TPlanet.Create(vec3(0.8, 0.8, 0.0));
  with Sonne do begin
    PlanetSpeed := 0.06;
    PlanetScale := 0.1;
  end;

  Venus := TPlanet.Create(vec3(0.5, 0.5, 0.2));
  with Venus do begin
    PlanetScale := 0.035;
    PlanetSpeed := 0.2;
    UmlaufSpeed := 0.01;
    UmlaufR := 0.2;
  end;

  Erde := TPlanet.Create(vec3(0.0, 0.2, 1.0));
  with Erde do begin
    PlanetScale := 0.04;
    PlanetSpeed := 0.2;
    MondSpeed := 0.04;
    UmlaufSpeed := 0.008;
    MondR := 0.04;
    UmlaufR := 0.4;
  end;

  Mond := TPlanet.Create(vec3(0.5, 0.5, 0.5));
  with Mond do begin
    PlanetScale := 0.02;
    MondSpeed := 0.04;
    UmlaufSpeed := 0.008;
    MondR := -0.04;
    UmlaufR := 0.4;
  end;

  Mars := TPlanet.Create(vec3(0.8, 0.2, 0.2));
  with Mars do begin
    PlanetScale := 0.025;
    PlanetSpeed := 0.3;
    UmlaufSpeed := 0.006;
    UmlaufR := 0.6;
  end;
  //code-

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
  end;
  glClearColor(0.0, 0.0, 0.2, 1.0); // Hintergrundfarbe
end;

(*
Sonne und Planeten zeichnen
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Sonne und Planeten
  Sonne.Draw;
  Venus.Draw;
  Erde.Draw;
  Mond.Draw;
  Mars.Draw;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  Venus.Free;
  Erde.Free;
  Mond.Free;
  Mars.Free;
  Sonne.Free;
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
