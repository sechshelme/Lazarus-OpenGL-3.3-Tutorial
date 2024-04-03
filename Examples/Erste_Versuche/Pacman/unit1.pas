unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,  Forms,  Dialogs,  ExtCtrls, Graphics, SysUtils,
  Buttons, StdCtrls, OpenGLContext,
  oglglad_gl,
  oglVector, oglMatrix, oglShader, oglColorKoerper, oglUnit, oglSteuerung, oglTextur,
  oglTexturKoerper, oglKoerper, oglBackGround, Sprite;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGL: TOpenGL;

    Pacman: TPacman;
    Mampfer: array[0..3] of TMampfer;

    BackGround: record
      Mesh: TBackGround;
      TexturBuffer: TTexturBuffer;
    end;

    Laby: TLabyrintSprite;

    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.InitScene;
var
  i, j: integer;
  col: array[0..3] of cardinal = ($0000FF, $FFFF00, $00AAFF, $8888FF);
begin

  for i := 0 to Length(Mampfer) - 1 do begin
    Mampfer[i] := TMampfer.Create(col[i]);
    with Mampfer[i] do begin
      pos.x := 4 - i * 4;
      pos.y := 0.0;
    end;
  end;

  Pacman := TPacman.Create;
  with Pacman do begin
    pos.x := 4 - 3.5 * 4;
    pos.y := 0.0;
  end;

  Laby := TLabyrintSprite.Create($FF00FF);
  with Laby do begin
    pos.x := 0.0;
    pos.y := 5.0;
  end;

  with BackGround do begin
    TexturBuffer := TTexturBuffer.Create;
    TexturBuffer.LoadTextures('Wald.jpg');

    Mesh := TBackGround.Create(1);
    Mesh.WriteVertex;
  end;


  OpenGL.Camera.Scale(0.1);
end;

procedure TForm1.RenderScene;
var
  i: integer;
  m: TMatrix;
begin
  OpenGL.Clear;

  with OpenGL.Camera do begin

    m := ObjectMatrix;

    // BackGround;

    with BackGround do begin
      Mesh.Draw(TexturBuffer);
    end;

    // Mampfer

    for i := 0 to Length(Mampfer) - 1 do begin
      ObjectMatrix := m;
      with Mampfer[i] do begin
        ObjectMatrix.Translate(pos.x, pos.y, 0);
        pos.x += 0.04;
        if pos.x > 10.0 then begin
          pos.x := -10.0;
        end;
        Draw;
      end;
    end;

    // Pacman

    with Pacman do begin
      ObjectMatrix := m;
      ObjectMatrix.Translate(pos.x, pos.y, 0);
      pos.x += 0.04;
      if pos.x > 10.0 then begin
        pos.x := -10.0;
      end;
      Draw;
    end;

    // Labyrinth

    with Laby do begin
      ObjectMatrix := m;
      ObjectMatrix.Translate(pos.x, pos.y, 0);
      Draw(0);
      ObjectMatrix.Translate(2, 0, 0);
      Draw(1);
      ObjectMatrix.Translate(0, -2, 0);
      Draw(2);
      ObjectMatrix.Translate(-2, 0, 0);
      Draw(3);

      ObjectMatrix := m;
      ObjectMatrix.Translate(pos.x+4, pos.y, 0);
      Draw(4);
      ObjectMatrix.Translate(2, 0, 0);
      Draw(5);
      ObjectMatrix.Translate(0, -2, 0);
      Draw(6);
      ObjectMatrix.Translate(-2, 0, 0);
      Draw(7);
    end;

    ObjectMatrix := m;
  end;

  OpenGL.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Color := clred;
  OpenGL := TOpenGL.Create(Self);
  OpenGL.AlphaBlending(True);
  OpenGL.Camera.SetCameraMatrixTransform(False);
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Pacman.Free;
  Laby.Free;

  for i := 0 to Length(Mampfer) - 1 do begin
    Mampfer[i].Free;
  end;

  with BackGround do begin
    Mesh.Free;
    TexturBuffer.Free;
  end;

  OpenGL.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
