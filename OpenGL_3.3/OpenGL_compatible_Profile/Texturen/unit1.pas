unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl: TOpenGLControl;
    procedure Kreis;
  public
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

var
  textureID0: GLuint;
  winkel: single;


procedure gl(x, y: single);
const
  Faktor = 5;
begin
  glTexCoord2f(x * Faktor, y * Faktor);
  glVertex3f(x, y, 0);
end;

procedure Arc(x, y, ri, ra, wa, we: single);
const
  Sektoren = 36;

  procedure CalcAndDraw(w: single);
  var
    c, s: single;
  begin
    c := cos(w / 180 * Pi);
    s := sin(w / 180 * Pi);
    //    glColor3fv(@Fcol1);
    gl(c * ri + x, s * ri + y);
    //    glColor3fv(@Fcol2);
    gl(c * ra + x, s * ra + y);
  end;

begin
  glBegin(GL_TRIANGLE_STRIP);
  //  glColor3f(1.0, 0.5, 0.7);
  repeat
    CalcAndDraw(wa);
    wa += 360 / Sektoren;
  until wa > we;
  CalcAndDraw(we);
  glEnd();
end;

procedure Arc2(ri, ra, wa, we: single);
var
  dif: single;
begin
  dif := (ra - ri) / 3;
  Arc(0, 0, ri, ri + dif, wa, we);
  Arc(0, 0, ra, ra - dif, wa, we);
  Arc(cos(wa / 180 * pi) * (ri + ra) / 2, sin(wa / 180 * pi) * (ri + ra) / 2, dif * 1.5, dif / 2, wa - 180, wa + 0);
  Arc(cos(we / 180 * pi) * (ri + ra) / 2, sin(we / 180 * pi) * (ri + ra) / 2, dif * 1.5, dif / 2, we - 0, we + 180);
end;


procedure TForm1.Kreis;
begin
  Arc2(0.2, 0.8, 10, 250);
end;

function CreateBitmap: TBitmap;
begin
  Result := TBitmap.Create;
  with  Result do begin
    Width := 16;
    Height := 16;
    with Canvas do begin
      Pen.Color := clWhite;
      Brush.Color := clWhite;
      Rectangle(0, 0, Result.Width, Result.Height);
      Pen.Color := clBlack;
      Line(0, 0, Result.Width, Result.Height);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if ToggleBox2.Checked then begin
    winkel := winkel + 1;
    if winkel > 360 then begin
      winkel := winkel - 360;
    end;
  end;

  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  // --- Textur Aktivieren

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glRotatef(winkel, 0.0, 0.0, 1.0);

  glEnable(GL_TEXTURE_2D);

  if ToggleBox1.Checked then begin
    glBegin(GL_QUADS);
    //    glColor3f(1.0,0.0,0.0);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-0.8, -0.8, 0);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(-0.8, 0.8, 0);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(0.8, 0.8, 0);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(0.8, -0.8, 0);
    glEnd();
  end else begin
    Kreis;
  end;

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  bit: TBitmap;
begin
  OpenGLControl := TOpenGLControl.Create(Self);
  with OpenGLControl do begin
    Parent := Self;
    Align:=alClient;
    AutoResizeViewport:=True;
  end;
  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);


  // ------------ Texturen laden --------------

  with Image1.Picture.Bitmap do begin
    glGenTextures(1, @textureID0);
    glBindTexture(GL_TEXTURE_2D, textureID0);

    //    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Width, Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, RawImage.Data);
    bit := CreateBitmap;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, bit.Width, bit.Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, bit.RawImage.Data);
    //    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, bit.Width, bit.Height, 0, GL_BGR, GL_UNSIGNED_BYTE, bit.RawImage.Data);
    //    bit.SaveToFile('test.bmp');
    bit.Free;

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);

    //    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    //    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glGenerateMipmap(GL_TEXTURE_2D);
  end;

  glMatrixMode(GL_TEXTURE);  // Textur Scalieren
  glLoadIdentity();
  //  glScalef(0.02, 0.02, 1.0);
  glScalef(10, 10, 10.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID0);
end;

initialization

  {$I unit1.lrs}

end.
