unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

//image image.png
(*
Will man die Scene realistisch proportional darstellen, nimmt man eine Frustum-Matrix.
Dies hat den Einfluss, das Objekte kleiner erscheinen, je weiter die Scene von einem weg ist.
In der Realität ist dies auch so, das Objekte kleiner erscheinen, je weiter sie von einem weg sind.
*)
//lineal

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
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TCube = array[0..11] of Tmat3x3;

const
  CubeVertex: TCube =
    (((-0.1, 0.1, 0.1), (-0.1, -0.1, 0.1), (0.1, -0.1, 0.1)), ((-0.1, 0.1, 0.1), (0.1, -0.1, 0.1), (0.1, 0.1, 0.1)),
    ((0.1, 0.1, 0.1), (0.1, -0.1, 0.1), (0.1, -0.1, -0.1)), ((0.1, 0.1, 0.1), (0.1, -0.1, -0.1), (0.1, 0.1, -0.1)),
    ((0.1, 0.1, -0.1), (0.1, -0.1, -0.1), (-0.1, -0.1, -0.1)), ((0.1, 0.1, -0.1), (-0.1, -0.1, -0.1), (-0.1, 0.1, -0.1)),
    ((-0.1, 0.1, -0.1), (-0.1, -0.1, -0.1), (-0.1, -0.1, 0.1)), ((-0.1, 0.1, -0.1), (-0.1, -0.1, 0.1), (-0.1, 0.1, 0.1)),
    // oben
    ((0.1, 0.1, 0.1), (0.1, 0.1, -0.1), (-0.1, 0.1, -0.1)), ((0.1, 0.1, 0.1), (-0.1, 0.1, -0.1), (-0.1, 0.1, 0.1)),
    // unten
    ((-0.1, -0.1, 0.1), (-0.1, -0.1, -0.1), (0.1, -0.1, -0.1)), ((-0.1, -0.1, 0.1), (0.1, -0.1, -0.1), (0.1, -0.1, 0.1)));
  CubeColor: TCube =
    (((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)),
    ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)),
    ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)),
    ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)),
    // oben
    ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    // unten
    ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)));

type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;

var
  VBCube: TVB;
  ScaleMatrix,
  RotMatrix,
  Matrix: TMatrix;
  RotVectorID: GLint;

const
  RotVector: TVector4f = (1.0, 0.0, 0.0, 1.0);

  function VectorMultiplySSE(const mat: TMatrix; const vec: TVector4f): TVector4f; assembler;
  {$asmmode intel}
asm
         //           Mov     Rsi, vec // load input address
         //           Mov     Rdi, vectorOut // load output address
         // pointer to the first 4 elements of the array:
         //           Mov     Rdx, mat;
         // Move Unaligned Parallel Scalars
         // load the registers with matrix values:
         Movups  Xmm4, [rsi+$30] // xmm4 contains 1,5, 9,13
         Movups  Xmm5, [mat+$20] // +16 (4 bytes x 4 elements)
         // xmm5 contains 2,6,10,14
         Movups  Xmm6, [rsi+$10] // +32 (8 bytes x 4 elements)
         // xmm6 contains 3,7,11,15
         Movups  Xmm7, [mat+$00] // +48 (12 bytes x 4
         // esi contains the starting address of the vec array
         // [2, 3, 4, 5], so load this vector into xmm0:
         Movups  Xmm0, [vec] // xmm0 contains 2, 3, 4, 5
         // we'll store the final result in xmm2, initialize it to 0:
         Xorps   Xmm2, Xmm2 // xmm2 contains 4x32
         // bits with zeros
         // now we need to multiply first column (xmm4)
         // by the vector (xmm0) and add it to the total (xmm2)
         // copy content of xmm0 into xmm1:
         Movups  Xmm1, Xmm0 // xmm1 now contains
         // [2, 3, 4, 5]
         // each value in xmm1 has the following mask representation:
         // mask value: 11 10 01 00
         // register value: [ 2, 3, 4, 5 ]
         // Shuffle Parallel Scalars
         Shufps  Xmm1, Xmm1, $FF // FF mask is 11 11 11 11
         // xmm1 contains 2, 2, 2, 2
         // Multiply Parallel Scalars
         Mulps   Xmm1, Xmm4 // multiply xmm1 (2,2,2,2)
         // and xmm4 (1,5,9,13)
         // [ 2*1, 2*5, 2*9, 2*13 ]
         // save it in xmm1
         // Add Parallel Scalars
         Addps   Xmm2, Xmm1 // add xmm2 (0, 0, 0, 0)
         // and xmm1 (2, 10, 18, 26)
         // save it in xmm2
         // xmm2 contains [2,10,18,26]
         // we multiplied first column of the matrix by the vector,
         // now we need to repeat these operations for the remaining
         // columns of the matrix
         Movups  Xmm1, Xmm0 // 3, 3, 3, 3
         Shufps  Xmm1, Xmm1, $AA // AA -> 10 10 10 10
         Mulps   Xmm1, Xmm5 // xmm5: 2, 6, 10, 14
         Addps   Xmm2, Xmm1 // 2+6, 10+18, 18+30, 26+42
         Movups  Xmm1, Xmm0 // 4, 4, 4, 4
         Shufps  Xmm1, Xmm1, $55 // 55 -> 01 01 01 01
         Mulps   Xmm1, Xmm6 // xmm6: 3, 7, 11, 15
         Addps   Xmm2, Xmm1 // 8+12, 28+28, 48+44, 68+60
         Movups  Xmm1, Xmm0 // 5, 5, 5, 5
         Shufps  Xmm1, Xmm1, $00 // 00 -> 00 00 00 00
         Mulps   Xmm1, Xmm7 // xmm7: 4, 8, 12, 16
         Addps   Xmm2, Xmm1 // 20+20, 56+40, 92+60, 128+80
         // 40 , 96 , 152 , 208
         // write the results to vectorOut
         Movups  [result], Xmm2
end;


function MatrixMultiplySSE(const M1, M2: TMatrix): TMatrix; assembler;
asm
         // load M1 into xxm entirely as we will need it more than once
         Movups   Xmm4, [M1+$00] // movaps
         Movups   Xmm5, [M1+$10]
         Movups   Xmm6, [M1+$20]
         Movups   Xmm7, [M1+$30]
         // compute Result[0]
         Movss    Xmm0, [M2]
         Shufps   Xmm0, Xmm0, $00 //xmm0 = 4x M2[0,0]
         Mulps    Xmm0, Xmm4
         Movss    Xmm1, [M2+$04]
         Shufps   Xmm1, Xmm1, $00 //xmm1 = 4x M2[0,1]
         Mulps    Xmm1, Xmm5
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$08]
         Shufps   Xmm1, Xmm1, $00 //xmm1 = 4x M2[0,2]
         Mulps    Xmm1, Xmm6
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$0c]
         Shufps   Xmm1, Xmm1, $00 //xmm1 = 4x M2[0,3]
         Mulps    Xmm1, Xmm7
         Addps    Xmm0, Xmm1
         Movups   [Result+$00], Xmm0 // movntps
         // compute Result[1]
         Movss    Xmm0, [M2+$10]
         Shufps   Xmm0, Xmm0, $00
         Mulps    Xmm0, Xmm4
         Movss    Xmm1, [M2+$14]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm5
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$18]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm6
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$1c]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm7
         Addps    Xmm0, Xmm1
         Movups   [Result+$10], Xmm0
         // compute Result[2]
         Movss    Xmm0, [M2+$20]
         Shufps   Xmm0, Xmm0, $00
         Mulps    Xmm0, Xmm4
         Movss    Xmm1, [M2+$24]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm5
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$28]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm6
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$2c]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm7
         Addps    Xmm0, Xmm1
         Movups   [Result+$20], Xmm0
         // compute Result[3]
         Movss    Xmm0, [M2+$30]
         Shufps   Xmm0, Xmm0, $00
         Mulps    Xmm0, Xmm4
         Movss    Xmm1, [M2+$34]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm5
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$38]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm6
         Addps    Xmm0, Xmm1
         Movss    Xmm1, [M2+$3c]
         Shufps   Xmm1, Xmm1, $00
         Mulps    Xmm1, Xmm7
         Addps    Xmm0, Xmm1
         Movups   [Result+$30], Xmm0
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

  CreateScene;
  InitScene;
end;

(*
Der Frustum funktioniert ähnlich wie beim Ortho.
Nur die Parameter sind ein wenig anders.
Die Z-Werte müssen immer <b>positiv</b> sein.

Mit den zwei letzten Parametern von Frustum und der World-Matrix muss man ein bisschen probieren, zum Teil wird sonst das Bild verzehrt.

Alternativ kann man den Frustum auch mit <b>Perspective(...</b> einstellen.
Dabei ist der erste Parameter der Betrachtungs-Winkel.
Der zweite Parameter ist das Fensterverhältniss, mehr dazu und glViewPort.
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
begin
  Matrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.5);

  //   ScaleMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ

  RotMatrix.Identity;
  //  RotMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
//  RotMatrix.Scale(0.5);                  // Und der Grösse anpassen.
  //code-

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    //    Matrix_ID := UniformLocation('Matrix');
    RotVectorID := UniformLocation('Rot');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBOcol);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeColor), @CubeColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

end;

(*
Das Zeichnen ist das Selbe wie bei Ortho.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  rv: TVector4f = (0.9, 0.0, 0.0, 1.0);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  //code+
  // --- Zeichne Würfel

//  Matrix.Identity;

  //        Matrix := ScaleMatrix * RotMatrix * Matrix;        // Matrizen multiplizieren.

  RotVector := rv;

//  RotVector := RotMatrix * ScaleMatrix * RotVector;

  Matrix:=MatrixMultiplySSE(RotMatrix,ScaleMatrix);

  RotVector:=VectorMultiplySSE(Matrix,RotVector);

  RotVector.w := RotVector.z + 1.0;

  RotVector.Uniform(RotVectorID);

  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBOcol);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RotMatrix.RotateB(0.0734);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
