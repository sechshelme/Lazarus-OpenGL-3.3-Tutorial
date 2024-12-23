unit Unit1;

interface

uses
  {$IFDEF Windows}
  Windows,
  {$ENDIF}
  ctypes, dynlibs,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  OpenGLContext, gl,
  freetype, freetypehdyn;

type
  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    imageWidht, imageHeight: integer;
    library_: PFT_Library;
    face: PFT_Face;

    image: array of byte;
    procedure draw_bitmap(var bit: FT_Bitmap; x: FT_Int; y: FT_Int);
    procedure Face_To_Image(angle: single);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function UTF8toUniStr(const s: string): unicodestring;
type
  TXChar2b = array[0..1] of byte;
var
  StrLen: IntPtr;
  StrPtr: pbyte;
  C2BPtr: ^TXChar2b;
  c: byte;
begin
  StrLen := Length(s);
  SetLength(Result, StrLen);
  StrPtr := @s[1];
  C2BPtr := @Result[1];
  while ((PtrUInt(StrPtr) - PtrUInt(@s[1])) < StrLen) do begin
    c := StrPtr^;
    if c < 128 then  begin
      C2BPtr^[1] := 0;
      C2BPtr^[0] := c;
      Inc(C2BPtr);
    end else if StrPtr^ < $C0 then begin
      Continue;
    end else begin
      case StrPtr^ and $F0 of
        $C0, $D0: begin
          C2BPtr^[1] := (c and $1C) shr 2;
          Inc(StrPtr);
          C2BPtr^[0] := ((c and $03) shl 6) + (StrPtr^ and $3F);
          Inc(C2BPtr);
        end;
        $E0: begin
          Inc(StrPtr);
          C2BPtr^[1] := ((c and $0F) shl 4) + ((StrPtr^ and $3C) shr 2);
          c := StrPtr^;
          Inc(StrPtr);
          C2BPtr^[0] := ((c and $03) shl 6) + (StrPtr^ and $3F);
          Inc(C2BPtr);
        end;
        $FF: begin
          Continue;
        end;
      end;
    end;
    Inc(StrPtr);
  end;
  SetLength(Result, (PtrUInt(C2BPtr) - PtrUInt(@Result[1])) div 2);
end;



procedure TForm1.FormCreate(Sender: TObject);
const
  //  fileName = '/usr/share/fonts/truetype/freefont/FreeMono.ttf';
  //  fileName = '/usr/share/fonts/truetype/noto/NotoSansMono-Bold.ttf';
  fileName = '/usr/share/fonts/truetype/ubuntu/Ubuntu-MI.ttf';
var
  error: FT_Error;
begin
  {$ifdef windows}
  InitializeFreetype('libfreetype-6.dll');
  {$else}
  InitializeFreetype('');
  {$endif}
  Timer1.Enabled := False;
  Timer1.Interval := 100;
  ClientWidth := 1600;
  ClientHeight := 1200;

  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := False;
  OpenGLControl1.MakeCurrent();
  glClearColor(0, 0, 0, 0);

  error := FT_Init_FreeType(library_);
  if error <> 0 then begin
    WriteLn('Fehler: ', error);
  end;

  error := FT_New_Face(library_, fileName, 0, face);
  if error <> 0 then begin
    WriteLn('Fehler: ', error);
  end;

  error := FT_Set_Char_Size(face, 5000, 00, 0, 350);
  if error <> 0 then begin
    WriteLn('Fehler: Set_Char_Size   ', error);
  end;

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FT_Done_Face(face);
  FT_Done_FreeType(library_);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  imageWidht := ClientWidth and not %11;
  imageHeight := ClientHeight;
  SetLength(image, imageWidht * imageHeight);
  FillDWord(image[0], Length(image) div 4, 0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  angle: single = 0.0;
begin
  angle += 0.0;
  Face_To_Image(angle);

  glDrawPixels(imageWidht, imageHeight, GL_LUMINANCE, GL_UNSIGNED_BYTE, Pointer(image));
  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.draw_bitmap(var bit: FT_Bitmap; x: FT_Int; y: FT_Int);
var
  x_max, y_max, ofs, i, j, p, q: FT_Int;
  buf: pbyte;
begin
  x_max := x + bit.Width;
  y_max := y + bit.rows;

  i := x;
  p := 0;
  while (i < x_max) do begin

    j := y;
    q := 0;
    while (j < y_max) do begin

      if (i >= 0) and (j >= 0) and (i < imageWidht) and (j < imageHeight) then begin
        ofs := j * imageWidht + i;
        buf := bit.buffer;
        image[ofs] := image[ofs] or buf[q * bit.Width + p];
      end;

      Inc(j);
      Inc(q);
    end;
    Inc(i);
    Inc(p);
  end;
end;

// https://onlinetools.com/utf8/convert-utf8-to-utf32

procedure TForm1.Face_To_Image(angle: single);
const
 // HelloText: PChar = 'Hello world !  öäü ÄÖÜ ÿï ŸÏ!';
  //  HelloText: PChar = 'Computer sind dumm';
   HelloText: PChar = 'ABCÄÖÜŸ';
  //  HelloText:PChar='AäÄ';
  //  HelloText:PChar=#$41#$C3#$A4#$C3#$84;
var
  error: FT_Error;
  pen: FT_Vector;
  matrix: FT_Matrix;
  slot: PFT_GlyphSlot;
  i: integer;

  UniStr: unicodestring = '';

  glyph_index: FT_UInt;

begin
  for i := 0 to Length(HelloText)-1 do begin
    Write(byte(HelloText[i]), ' - ');
  end;



  Timer1.Enabled := False;

  slot := face^.glyph;

  matrix.xx := Round(Cos(angle) * 10000);
  matrix.xy := -Round(-Sin(angle) * 10000);
  matrix.yx := Round(Sin(angle) * 10000);
  matrix.yy := -Round(Cos(angle) * 10000);

  UniStr := UTF8toUniStr(HelloText);

  pen.x := 20000;
  pen.y := 50000;

  for i := 1 to Length(UniStr) do begin
    FT_Set_Transform(face, @matrix, @pen);

    glyph_index := FT_Get_Char_Index(face, FT_ULong(UniStr[i]));
    error := FT_Load_Glyph(face, glyph_index, FT_LOAD_RENDER);

    //    error := FT_Load_Char(face, FT_ULong(UniStr[i]), FT_LOAD_RENDER);
    if error <> 0 then begin
      WriteLn('Fehler: Load_Char   ', error);
    end;
    draw_bitmap(slot^.bitmap, slot^.bitmap_left, OpenGLControl1.Height - slot^.bitmap_top);

    pen.x += slot^.advance.x;
    pen.y += slot^.advance.y;
  end;
end;

end.
