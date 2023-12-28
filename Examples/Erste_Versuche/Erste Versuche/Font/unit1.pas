unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  OpenGLContext,
  Forms,
  Controls,
  Graphics, GraphType,
  Dialogs,
  ExtCtrls,
  StdCtrls, Menus,
  dglOpenGL,
 oglShader,oglVector,oglMatrix,oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  Quad: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  QuadTextureVertex0: array[0..5] of TVector2f =
    ((0.0, 1.0), (0.1, 0.0), (0.0, 0.0),
    (0.0, 1.0), (0.1, 1.0), (0.1, 0.0));


var
  uiVBO: array[0..10] of glUINT;
  uiVAO: array[0..2] of glUINT;

  WorldMatrix_id, texture_id0, pos_id, offset_ID: GLint;

  WorldMatrix: TMatrix;

  Fonttex: TTexturBuffer;

  FontBitmap: TBitmap;


procedure TForm1.InitScene;
const
  ia: array[0..0] of integer = (0);
begin

  glClearColor(0.0, 0.5, 1.0, 1.0); //Hintergrundfarbe: Hier ein leichtes Blau

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  Shader := TShader.Create(FileToStr('shader.glsl'));
  with Shader do begin
    pos_id := AttribLocation('inPos');
    texture_id0 := AttribLocation('vertexUV0');
    WorldMatrix_id := UniformLocation('Matrix');
    offset_ID := UniformLocation('offset');
  end;
  glUniform1iv(Shader.UniformLocation('Sampler0'), 1, ia);


  glGenVertexArrays(1, uiVAO);
  glGenBuffers(3, uiVBO);

  glBindVertexArray(uiVAO[0]);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(pos_id);
  glVertexAttribPointer(pos_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadTextureVertex0), @QuadTextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(texture_id0);
  glVertexAttribPointer(texture_id0, 2, GL_FLOAT, False, 0, nil);

  // ------------ Texturen laden --------------

  Fonttex := TTexturBuffer.Create;
  //  Fonttex.LoadTextures(Image1.Picture.Bitmap.RawImage);
  Fonttex.LoadTextures(FontBitmap.RawImage);
end;

procedure TForm1.RenderScene;
const
  zahl = '12345678';
var
  i: integer;
  Matrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(uiVAO[0]);

  Fonttex.ActiveAndBind();

  Matrix.Identity;
  for i := 0 to Length(zahl) - 1 do begin
    Matrix.Identity;
    Matrix.Translate(i * 1.6, 0.0, 0.0);
    Matrix.Multiply(WorldMatrix, Matrix);

    Matrix.Uniform(WorldMatrix_id);
    glUniform1f(offset_ID, StrToInt(zahl[i + 1]) * 0.1);

    glDrawArrays(GL_Triangles, 0, Length(Quad));
  end;

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  sizex, sizey: integer;
  i: integer;
begin
  FontBitmap := TBitmap.Create;
  sizex := 8;
  sizey := FontBitmap.Canvas.TextHeight('1');
  Caption := IntToStr(sizey);
  FontBitmap.Width := sizex * 10;
  FontBitmap.Height := sizey;
  FontBitmap.Canvas.Brush.Color := $FF;
  FontBitmap.Canvas.Pen.Color := $FF;

  for i := 0 to 9 do begin
    FontBitmap.Canvas.TextOut(i * sizex, 0, IntToStr(i));
  end;

  WorldMatrix.Identity;
  WorldMatrix.Scale(0.1);

  InitOpenGL;

  OpenGLControl1.MakeCurrent();
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;

  Timer1.Enabled:=True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(1, @uiVBO);
  glDeleteVertexArrays(1, @uiVAO);
  Shader.Free;

  Fonttex.Free;
  FontBitmap.Free;
end;


procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Fonttex.LoadTextures(OpenDialog1.FileName);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  RenderScene;
end;

end.
