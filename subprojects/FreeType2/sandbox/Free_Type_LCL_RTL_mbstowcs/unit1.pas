unit Unit1;

//{$mode objfpc}{$H+}

interface

uses
  {$IFDEF Windows}
  Windows,
  {$ENDIF}
  ctypes, dynlibs,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  OpenGLContext, gl,
  freetype, freetypehdyn,
  LazUTF8;

const
  {$IFDEF Linux}
  libc = 'c';
  {$ENDIF}

  {$IFDEF Windows}
  libc = 'msvcrt.dll';
  {$ENDIF}

// https://cplusplus.com/reference/cstdlib/mbstowcs/
//function mbstowcs(dest:PDWord; src:PChar; max :SizeInt): SizeInt; cdecl; external libc;
function mbstowcs(dest: Pointer; src: PChar; max: SizeInt): SizeInt; cdecl; external libc;
function mblen(pmb: PDWord; max: SizeInt): cint; cdecl; external libc;

function setlocale(catogory: cint; locale: PChar): PChar; cdecl; external libc;

// https://cplusplus.com/reference/cuchar/mbrtoc32/
// size_t mbrtoc32 ( char32_t * pc32, const char * pmb, size_t max, mbstate_t * ps);
function mbrtoc32(dest: PDWord; src: PChar; max: SizeInt; state: Pointer): SizeInt; cdecl; external libc;


type

  { TForm1 }

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

    procedure draw_bitmap(var bit: FT_Bitmap; x: FT_Int; y: FT_Int);
    procedure Face_To_Image(angle: single);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

var
  image: array of byte = nil;

const
  LC_CTYPE = 0;
  LC_NUMERIC = 1;
  LC_TIME = 2;
  LC_COLLATE = 3;
  LC_MONETARY = 4;
  LC_MESSAGES = 5;
  LC_ALL = 6;
  LC_PAPER = 7;
  LC_NAME = 8;
  LC_ADDRESS = 9;
  LC_TELEPHONE = 10;
  LC_MEASUREMENT = 11;
  LC_IDENTIFICATION = 12;


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
  //  setlocale(LC_ALL, 'en_US.utf8');
  //  setlocale(LC_ALL, 'de_DE.utf8');
  //  setlocale(LC_ALL, 'C' + '');
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
  //    HelloText: PChar = 'Hello world !  öäü ÄÖÜ ÿï ŸÏ!';
  //  HelloText: PChar = 'Computer sind dumm';
  HelloText: PChar = 'ŸAÄÖÜ';
  //  HelloText:PChar='AäÄ';
  //  HelloText:PChar=#$41#$C3#$A4#$C3#$84;


  TestText: array of DWord = ($00000178, $00000041, $000000C4, $000000D6, $000000DC);
type
  TChar2BString = type ansistring(CP_UTF16BE);

var
  error: FT_Error;
  pen: FT_Vector;
  matrix: FT_Matrix;
  slot: PFT_GlyphSlot;
  n, i: integer;

  str32: array of dword = nil;
  len: SizeInt = 0;

  //  Char2BString:TChar2BString;
  Char2BString: unicodestring;

  // https://gist.github.com/jiaoyk/c9ba7fed2a086c73aecb3edee83af0f6

begin
  Timer1.Enabled := False;

  slot := face^.glyph;

  matrix.xx := Round(Cos(angle) * 10000);
  matrix.xy := -Round(-Sin(angle) * 10000);
  matrix.yx := Round(Sin(angle) * 10000);
  matrix.yy := -Round(Cos(angle) * 10000);

  pen.x := 40000;
  pen.y := 40000;

  Char2BString := UTF8ToUTF16(HelloText);
  WriteLn(#10'Length Char2BString: ', Length(Char2BString));
  for n := 1 to Length(Char2BString) do begin
    FT_Set_Transform(face, @matrix, @pen);
    error := FT_Load_Char(face, FT_ULong(Char2BString[n]), FT_LOAD_RENDER);
    if error <> 0 then begin
      WriteLn('Fehler: Load_Char   ', error);
    end;
    draw_bitmap(slot^.bitmap, slot^.bitmap_left, OpenGLControl1.Height - slot^.bitmap_top);

    pen.x += slot^.advance.x;
    pen.y += slot^.advance.y;
  end;

  // =================


  len := mbstowcs(nil, HelloText, Length(str32));
  SetLength(str32, len);
  WriteLn('len_UTF8: ', Length(HelloText));
  WriteLn('len_UTF32: ', len);
  mbstowcs(PDWord(str32), HelloText, len);

  WriteLn('Input len: ', Length(HelloText));
  for i := 0 to Length(HelloText) - 1 do begin
    Write('0x', IntToHex(byte(HelloText[i]), 2), '    -    ');
  end;
  WriteLn();
  WriteLn('Output len: ', len);
  for i := 0 to len - 1 do begin
    Write('0x', IntToHex(DWORD(str32[i]), 8), ' - ');
  end;

  pen.x := 40000;
  pen.y := 50000;

  for n := 0 to Length(str32) - 1 do begin
    FT_Set_Transform(face, @matrix, @pen);
    error := FT_Load_Char(face, FT_ULong(str32[n]), FT_LOAD_RENDER);
    if error <> 0 then begin
      WriteLn('Fehler: Load_Char   ', error);
    end;
    draw_bitmap(slot^.bitmap, slot^.bitmap_left, OpenGLControl1.Height - slot^.bitmap_top);

    pen.x += slot^.advance.x;
    pen.y += slot^.advance.y;
  end;

end;

//Ja, in C gibt es die Funktionen `mbsrtowcs` und `mbsnrtowcs`, die verwendet werden können, um eine multibyte-Zeichenfolge in eine wide-character-Zeichenfolge umzuwandeln. Diese Funktionen können mit `wchar_t`, `char16_t` oder `char32_t` als Zieltyp verwendet werden, je nachdem, wie die Funktion deklariert ist.
//
//Hier ist ein Beispiel für die Verwendung von `mbsrtowcs` mit `char16_t`:
//
//```c
//#include
//
//#include
//#include
//
//int main() {
//setlocale(LC_ALL, "en_US.UTF-8");
//
//char mbstr[] = u8"Hello, こんにちは, नमस्ते";
//char16_t wcstr[100];
//
//mbsrtowcs((char16_t *)wcstr, &mbstr, 100, NULL);
//
//printf("Wide-character string: %ls\n", wcstr);
//
//return 0;
//}
//```
//
//In diesem Beispiel wird die multibyte-Zeichenfolge `mbstr` in eine wide-character-Zeichenfolge `wcstr` umgewandelt, wobei `char16_t` als Zieltyp verwendet wird.
//
end.
