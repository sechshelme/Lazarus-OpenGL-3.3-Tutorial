unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch arrayoperators on}


interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader, oglDebug, oglVector, oglVectors;

  //image image.png

(*
Hier wird ein sehr einfacher Shader geladen, welcher nichts anderes macht, als die Dreiecke rot darzustellen.
*)

  //lineal

(*
Hier wird noch ein Objekt der Klasse TShader deklariert.
*)
  //code+
type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    //code-
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TVB = record
    VBO: GLuint;
  end;

var
  VBDataIn, VBDataOut: TVB;

  dataIn: TGlfloats = nil;
    dataOut: TGlfloats = nil;

  dataOutMap: PGLfloat;

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
end;

(*

https://web.engr.oregonstate.edu/~mjb/cs475/Handouts/compute.shader.1pp.pdf
https://arm-software.github.io/opengl-es-sdk-for-android/compute_intro.html
*)

//code+
procedure TForm1.CreateScene;
var
  i: integer;
begin
  InitOpenGLDebug;
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_COMPUTE_SHADER, 'compute.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;
  //code-

  for i := 0 to 19 do begin
    dataIn += [i * 3];
        dataOut += [0.0];
  end;
  WriteLn('Daten inizialisiert');

  // Data In
  glGenBuffers(1, @VBDataIn.VBO);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, VBDataIn.VBO);
  glBufferData(GL_SHADER_STORAGE_BUFFER, dataIn.Size, dataIn.Ptr, GL_STATIC_DRAW);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, 0);

  // Data Out
  glGenBuffers(1, @VBDataOut.VBO);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, VBDataOut.VBO);
  glBufferData(GL_SHADER_STORAGE_BUFFER, dataIn.Size, nil, GL_DYNAMIC_DRAW);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, 0);

  Shader.UseProgram;
  glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, VBDataIn.VBO);
  glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 1, VBDataOut.VBO);
  glDispatchCompute(Length(dataIn) , 1, 1);

 glMemoryBarrier(GL_ALL_BARRIER_BITS);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, VBDataOut.VBO);

  WriteLn('start 1');
  glGetBufferSubData(GL_SHADER_STORAGE_BUFFER,0,dataOut.Size,dataOut.Ptr);;
  WriteLn('ende1 ');
  for i := 0 to Length(dataIn) - 1 do begin
        WriteLn(dataOut[i]: 10: 5);
  end;
end;


//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
//  glClear(GL_COLOR_BUFFER_BIT);

//  Shader.UseProgram;
  //code-

  // Zeichne Dreieck
  //  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  //  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

//  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
  glDeleteBuffers(1, @VBDataIn.VBO);
  glDeleteBuffers(1, @VBDataOut.VBO);
end;

//lineal
(*
*)
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

//lineal
(*
So könnte ein optimierter Shader-Code aussehen, dafür ist er aber sehr schlecht leserlich.
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader_optimiert.glsl

end.
