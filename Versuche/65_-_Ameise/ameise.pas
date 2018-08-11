unit Ameise;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;


{ TAmeise }

type
  TAmeise = class(TObject)
  private
  const
    AmeiseVertex: array[0..5] of TVector2f =       // Koordinaten der Polygone.
      ((-1.0, -1.0), (1.0, 1.0), (-1.0, 1.0),
      (-1.0, -1.0), (1.0, -1.0), (1.0, 1.0));

    AmeiseTextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
      ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
      (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

    Scale = 20;
    InstanceCount = 50;
    TexturSize = 1024;

    type
    TVB = record
      VAO: GLuint;
      VBO: record
        Vertex,
        Tex,
        Instance: GLuint;
      end;
    end;

    TInstance = record
      Layer: GLfloat;
      Angle: GLfloat;
      Trans: TVector2f;
    end;

    TInstances = array of TInstance;
  var
    VBAmeise: TVB;
    Matrix_ID,
    AmeiseTextureID: GLuint;

    // Renderpuffer
    fFrameTextureID: GLuint;
    FramebufferName, depthrenderbuffer: GLuint;

    Instances: TInstances;
    Shader: TShader; // Shader Klasse
    procedure CreateAmeise;
  public
    property FrameTexturID:GLuint read fFrameTextureID;

    constructor Create;
    procedure InitScene;
    procedure Calculate;
    procedure DrawScene;
    destructor Destroy; override;
  end;

implementation

{ TAmeise }

procedure TAmeise.CreateAmeise;
var
  Buffer: array of UInt32;
  i, j: integer;
  col: UInt32;
  pix: TColor;
  imageSize: integer;
  bit: TBitmap;

begin
  bit := TBitmap.Create;
  bit.LoadFromFile('Ameise.bmp');

  imageSize := bit.Width * bit.Height;
  SetLength(Buffer, InstanceCount * imageSize);
  for i := 0 to imageSize - 1 do begin
    pix := bit.Canvas.Pixels[i mod bit.Width, i div bit.Width];

    for j := 0 to InstanceCount - 1 do begin
      if pix = 0 then begin
        col := $FFFFFF div InstanceCount * j;
        Buffer[j * imageSize + i] := col or $FF000000;
      end else begin
        Buffer[j * imageSize + i] := 0;
      end;
    end;
  end;

  glBindTexture(GL_TEXTURE_2D_ARRAY, AmeiseTextureID);
  glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA8, bit.Width, bit.Height, InstanceCount, 0, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(Buffer));
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

  glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
  bit.Free;
end;

constructor TAmeise.Create;
var
  i: integer;
begin
  SetLength(Instances, InstanceCount);
  for i := 0 to Length(Instances) - 1 do begin
    with Instances[i] do begin
      Layer := i;
      Trans := vec2(0.0, 0.0);
      Angle := Random * 2 * Pi;
    end;
  end;

  glGenTextures(1, @AmeiseTextureID);                 // Erzeugen des Textur-Puffer.

  Shader := TShader.Create([FileToStr('Ameise.vert'), FileToStr('Ameise.frag')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  glGenVertexArrays(1, @VBAmeise.VAO);
  glGenBuffers(3, @VBAmeise.VBO);
end;

procedure TAmeise.InitScene;
var
  ofs: integer;
begin
  CreateAmeise;
  //code-

  glBindVertexArray(VBAmeise.VAO);

  // --- Koordinatem
  // Vertex
  glBindBuffer(GL_ARRAY_BUFFER, VBAmeise.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(AmeiseVertex), @AmeiseVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // TexturVertex
  glBindBuffer(GL_ARRAY_BUFFER, VBAmeise.VBO.Tex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(AmeiseTextureVertex), @AmeiseTextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);


  // --- Instance
  ofs := 0;
  glBindBuffer(GL_ARRAY_BUFFER, VBAmeise.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, Length(Instances) * SizeOf(TInstance), nil, GL_STATIC_DRAW);

  // Layer
  glEnableVertexAttribArray(5);
  glVertexAttribPointer(5, 1, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(5, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Angele
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 1, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(6, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Translate
  glEnableVertexAttribArray(7);
  glVertexAttribPointer(7, 2, GL_FLOAT, False, SizeOf(TInstance), Pointer(ofs));
  glVertexAttribDivisor(7, 1);


  // --- Frame Puffer
  glGenTextures(1, @fFrameTextureID);
  glBindTexture(GL_TEXTURE_2D, fFrameTextureID);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);


  // Frame Puffer erzeugen.
  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  // Render Puffer erzeugen.
  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  // Die Textur mit dem Framebuffer koppeln
  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, fFrameTextureID, 0);
end;

procedure TAmeise.Calculate;
const
  a = 0.1;
var
  i: integer;
  t: TVector2f;
  m: GLfloat;
begin
  m := Scale;

  for i := 0 to Length(Instances) - 1 do begin
    with Instances[i] do begin

      Angle += -a + Random * a * 2;
      t := vec2(0.0, 0.1);
      t.Rotate(-Angle);
      Trans -= t;

      if Trans.x > m then begin
        Trans.x := -m;
      end;
      if Trans.y > m then begin
        Trans.y := -m;
      end;
      if Trans.x < -m then begin
        Trans.x := m;
      end;
      if Trans.y < -m then begin
        Trans.y := m;
      end;
    end;
  end;
end;

procedure TAmeise.DrawScene;
var
  Matrix: TMatrix;
begin
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  glViewport(0, 0, TexturSize, TexturSize);

  glClearColor(1.0, 1.0, 1.0, 1.0);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;
  glBindVertexArray(VBAmeise.VAO);

  // Instance
  Calculate;
  glBindBuffer(GL_ARRAY_BUFFER, VBAmeise.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, 0, Length(Instances) * SizeOf(TInstance), Pointer(Instances));

  glBindTexture(GL_TEXTURE_2D_ARRAY, AmeiseTextureID);  // Ameise.Textur binden.

  Matrix.Identity;
  Matrix.Scale(1 / Scale);

  Matrix.Uniform(Matrix_ID);

  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(AmeiseVertex), Length(Instances));
  glBindFramebuffer(GL_FRAMEBUFFER, 0);
end;

destructor TAmeise.Destroy;
begin
  glDeleteTextures(1, @AmeiseTextureID);       // Textur-Puffer frei geben.
  glDeleteTextures(1, @fFrameTextureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBAmeise.VAO);
  glDeleteBuffers(3, @VBAmeise.VBO);

  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);
  Shader.Free;

  inherited Destroy;
end;

end.
