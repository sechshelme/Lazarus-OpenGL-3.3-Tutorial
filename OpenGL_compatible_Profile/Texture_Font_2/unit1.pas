unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ComCtrls, OpenGLContext, gl, GLext;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl1: TOpenGLControl;

    FontData: array[0..127 - 32] of record
      TexturID, CharSize: GLuint;
      end;
  end;

var
  Form1: TForm1;

implementation

procedure TForm1.Timer1Timer(Sender: TObject);
const
  hello: PChar = 'Hello World !';

  procedure Draw(size: GLfloat);
  begin
    glBegin(GL_QUADS);
    glColor3f(1.0, 1.0, 1.0);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(-size, -size, 0);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-size, size, 0);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(size, size, 0);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(size, -size, 0);
    glEnd();
  end;

const
  winkel: GLfloat = 0;
var
  i: integer;
  ofs: integer = 0;
begin
  winkel += 1.1;

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glScalef(0.5, 0.5, 1.0);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glEnable(GL_TEXTURE_2D);

  for i := 0 to Length(hello) - 1 do begin
    glPushMatrix;
    glRotatef(winkel, 0.0, 0.0, 1.0);
    glBindTexture(GL_TEXTURE_2D, FontData[byte(hello[i]) - 32].TexturID);
    glTranslatef(ofs / 80-0.3, 0.0, 0.0);
    Inc(ofs, FontData[byte(hello[i]) - 32].CharSize);
    Draw(0.4);
    glPopMatrix;
  end;

  glDisable(GL_TEXTURE_2D);

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
const
  size = 64;
var
  bit: tbitmap;
  i, x, y: integer;
  RGBABuffer: array of record
    case byte of
    0:( r, g, b, a: byte);
    1:( rgba: DWord);
    end
  = nil;

begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
  OpenGLControl1.Parent := Self;
  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := True;
  OpenGLControl1.MakeCurrent;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  for i := 0 to Length(FontData) - 1 do begin
    glGenTextures(1, @FontData[i].TexturID);
  end;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LEQUAL);

  glClearColor(0.8, 0.5, 0.3, 1.0);

  bit := TBitmap.Create;
  //  bit.PixelFormat := pf32bit;

    bit.Transparent := True;
    bit.Canvas.Brush.Style := bsClear;
    bit.Canvas.Font.Color := clYellow;
    bit.Canvas.Font.Height:=32;
  for i := 0 to Length(FontData) - 1 do begin
    bit.Clear;
    bit.SetSize(size, size);
    //bit.Canvas.Brush.Color:=clBlack;
    //bit.Canvas.Pen.Color:=clBlack;
    //bit.Canvas.Rectangle(0,0,size,size);

    bit.Canvas.TextOut(0, 0, char(i + 32));
//    bit.Canvas.Font.Color:=clWhite;
//    bit.Canvas.Font.Size:=32;
    FontData[i].CharSize := bit.Canvas.TextWidth(char(i + 32));

    //SetLength(RGBABuffer, size * size);
    //for x := 0 to size - 1 do begin
    //  for y := 0 to size - 1 do begin
    //    if bit.Canvas.Pixels[x, y] = $000000 then begin
    //      RGBABuffer[x + y * size].rgba:=$00000000;
    //    end else begin
    //      RGBABuffer[x + y * size].rgba:=$FFFFFFFF;
    //    end;
    //  end;
    //end;

    glBindTexture(GL_TEXTURE_2D, FontData[i].TexturID);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

//    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, size, size, 0, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(RGBABuffer));


    {$IFDEF Linux}
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, bit.Width, bit.Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, bit.RawImage.Data);
    {$ENDIF}

    {$IFDEF Windows}
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, bit.Width, bit.Height, 0, GL_RGB, GL_UNSIGNED_BYTE, bit.RawImage.Data);
    {$ENDIF}
  end;
  bit.Free;

  Timer1.Enabled := True;
  Timer1.Interval := 40;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(FontData) - 1 do begin
    glDeleteTextures(1, @FontData[i].TexturID);
  end;
end;

initialization

  {$I unit1.lrs}

end.
