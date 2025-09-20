unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus, Spin, StdCtrls,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Spin0: TFloatSpinEdit;
    Panel1: TPanel;
    Spin1: TFloatSpinEdit;
    Spin2: TFloatSpinEdit;
    Spin3: TFloatSpinEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure CreateJoints;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png
//lineal

type
  TUBOBuffer = record
    proMatrix:Tmat4x4;
    modelMatrix: Tmat2x2;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f;
  QuadColor: TVectors3f;

  modelMatrix:Tmat2x2;

  VAO: GLuint;
  Mesh_Buffers: array [(mbVBOVektor, mbVBOColor, mbUBO)] of TGLuint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  //  Height := 480;
  Height := 640;
  //remove-
  Randomize;
  Timer1.Enabled := False;
  Timer1.Interval := 20;
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//  modelMatrix.Translate(0,0.5,0);
end;

// https://www.youtube.com/watch?app=desktop&v=lDaQ3a43x8A

procedure TForm1.CreateJoints;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
var
  tmpQuad: TVectors2f = nil;
  x, y: integer;
begin
  QuadVertex := nil;
  QuadColor := nil;

  for x := 0 to 2 do begin
    for y := 0 to 2 do    begin
      tmpQuad := nil;
    tmpQuad.addrectangle;
    tmpQuad.Scale(0.7);
    tmpQuad.Translate([x - 1, y - 1]);
    QuadVertex.Add(tmpQuad);

    QuadColor.AddRectangleColor(colors[(x + y * 3)mod Length(colors)]^);
    end;
  end;
end;

procedure TForm1.CreateScene;
var
  UBO_ID: GLuint;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  UBOBuffer.proMatrix.Identity;
  UBOBuffer.proMatrix.Scale(0.4);
  UBOBuffer.modelMatrix.Identity;

  modelMatrix.Identity;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

  CreateJoints;

  // Daten für Quadrat
  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, nil);

  // Color
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOColor]);
  glBufferData(GL_ARRAY_BUFFER, QuadColor.Size, QuadColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, nil);

  Timer1.Enabled := True;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VAO);

  UBOBuffer.modelMatrix.Identity;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);

//  modelMatrix.Identity;
//  modelMatrix.Rotate(pi/2+0.2);
  UBOBuffer.modelMatrix:=modelMatrix;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);

  ogc.SwapBuffers;

  Spin0.Value:=  modelMatrix[0,0];
  Spin1.Value:=  modelMatrix[0,1];
  Spin2.Value:=  modelMatrix[1,0];
  Spin3.Value:=  modelMatrix[1,1];
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
end;

procedure TForm1.SpinChange(Sender: TObject);
begin
  modelMatrix[0,0]:=Spin0.Value;
  modelMatrix[0,1]:=Spin1.Value;
  modelMatrix[1,0]:=Spin2.Value;
  modelMatrix[1,1]:=Spin3.Value;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ogcDrawScene(Sender);
end;

//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
