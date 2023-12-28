unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

  //image image.png
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
    procedure LoadTextures;
    procedure CreateScene;
    procedure ogcClick(Sender: TObject);
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ogcResize(Sender: TObject);

    procedure CalcSphere;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TUBOBuffer = record
    Material: record
      ambient: TVector3f;      // Umgebungslicht
      pad0: GLfloat;           // padding 4Byte
      diffuse: TVector3f;      // Farbe
      pad1: GLfloat;           // padding 4Byte
      specular: TVector3f;     // Spiegelnd
      shininess: GLfloat;      // Glanz
      end;
    Matrix: record
      ModelMatrix: Tmat4x4;
      Matrix: Tmat4x4;
      end;
    size: TGLint;
  end;

var
  UBOBuffer: TUBOBuffer;

  DonutVertex, DonutNormal: TVectors3f;
  DonutTexCoors:TVectors2f;
  CubeSize: integer;

  VAOs: array [(vaMesh)] of TGLuint;
  Mesh_Buffers: array [(mbVBOVektor, mbVBOTexCoord, mbVBONormal, mbUBO)] of TGLuint;
    Textur_Buffers: array [(tbTexture)] of TGLuint;

  FrustumMatrix, WorldMatrix, ModelMatrix: TMatrix;

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
  ogc.OnMouseDown:=@ogcMouseDown;

  CreateScene;
end;

procedure TForm1.CalcSphere;
begin
//  SphereTab.SetSectors(16);

  DonutVertex := nil;
  DonutTexCoors := nil;
  DonutNormal := nil;
  DonutVertex.AddDonut(0.25);
  DonutTexCoors.AddDonutTexCoords;
  DonutTexCoors.scale(2);
  DonutNormal.AddDonutNormale;

  WriteLn(Length(DonutVertex));
  WriteLn(Length(DonutTexCoors));
  WriteLn(Length(DonutNormal));
end;

procedure TForm1.LoadTextures;
var
  pic: TPicture;
begin
  glGenTextures(Length(Textur_Buffers), Textur_Buffers);
    pic := TPicture.Create;
  pic.LoadFromFile('opengl.bmp');

  glBindTexture(GL_TEXTURE_2D, Textur_Buffers[tbTexture]);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,pic.Width, pic.Height, 0, GL_BGR, GL_UNSIGNED_BYTE, pic.Bitmap.RawImage.Data);

  pic.Free;
end;



procedure TForm1.CreateScene;
var
  UBOBuffer_ID: GLuint;
begin
  CalcSphere;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  glUniform1i(Shader.UniformLocation('Texture'), 0);
  UBOBuffer_ID := Shader.UniformBlockIndex('UBO');

  glGenVertexArrays(Length(VAOs), VAOs);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  Timer1.Enabled := True;

  // UBO
  with UBOBuffer.Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;
  UBOBuffer.size := 9;

  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, UBOBuffer_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  glClearColor(0.15, 0.15, 0.1, 1.0);

  LoadTextures;

  // --- Vertex-Daten für Kugel
  glBindVertexArray(VAOs[vaMesh]);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, DonutVertex.Size, DonutVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // TexturCoords
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOTexCoord]);
  glBufferData(GL_ARRAY_BUFFER, DonutTexCoors.Size, DonutTexCoors.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBONormal]);
  glBufferData(GL_ARRAY_BUFFER, DonutNormal.Size, DonutNormal.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcClick(Sender: TObject);
var
  x, y: LongInt;
begin
    X := Mouse.CursorPos.X - Form1.Left - (Form1.Width - Form1.ClientWidth);
  Y := Mouse.CursorPos.Y - Form1.Top - (Form1.Height - Form1.ClientHeight);
  WriteLn('x: ',x,'  y: ',y);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VAOs[vaMesh]);

  UBOBuffer.size := CubeSize;

  UBOBuffer.Matrix.ModelMatrix.Identity;
  UBOBuffer.Matrix.ModelMatrix.Scale(60);
  UBOBuffer.Matrix.ModelMatrix := ModelMatrix * UBOBuffer.Matrix.ModelMatrix;

  UBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * UBOBuffer.Matrix.ModelMatrix;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, DonutVertex.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.ogcMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
var
  col:array[0..3]of Byte;
  depth:TGLfloat;
  index:TGLint;
begin
  y:=ClientHeight-y;
  WriteLn('x: ',x,'  y: ',y);
  glReadPixels(x,y,1,1,GL_RGBA,GL_UNSIGNED_BYTE, @col);
  WriteLn('r: ',col[0],'  g: ',col[1],'  b: ',col[2],'  a: ',col[3]);

  glReadPixels(x,y,1,1,GL_BGRA,GL_UNSIGNED_BYTE, @col);
  WriteLn('r: ',col[0],'  g: ',col[1],'  b: ',col[2],'  a: ',col[3]);

  glReadPixels(x,y,1,1,GL_DEPTH_COMPONENT,GL_FLOAT, @depth);
  WriteLn('depth: ', depth:4:2);

  glReadPixels(x,y,1,1,GL_STENCIL_INDEX ,GL_UNSIGNED_INT, @index);
  WriteLn('stencil: ', index);

  WriteLn();
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(Length(VAOs), VAOs);
  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse

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
