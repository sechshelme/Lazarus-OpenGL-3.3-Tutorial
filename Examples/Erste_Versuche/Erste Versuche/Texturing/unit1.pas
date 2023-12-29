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
  StdCtrls, Menus, IntfGraphics,
  dglOpenGL,
  oglShader,
  oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;
    SLInfo: TStringList;
    function LoadTexture(RawImage: TRawImage): GLuint;
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

uses TexturInfo;

{$R *.lfm}

{ TForm1 }

const
  Quad: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  QuadTextureVertex0: array[0..5] of TVector2f =
    ((0.0, 0.0), (3.0, 3.0), (0.0, 3.0),
    (0.0, 0.0), (3.0, 0.0), (3.0, 3.0));


var
  uiVBO: array[0..10] of glUINT;
  uiVAO: array[0..2] of glUINT;

  WorldMatrix_id, texture_id0, pos_id: GLint;

  TexID: GLuint;

  WorldMatrix: TMatrix;

  procedure output(d:TRawImageDescription);
  begin
    with d do begin
      ShowMessage('Undefiniertes Format' + #13#10 + #13#10 +
        'BitsPerPixel:' + IntToStr(BitsPerPixel) + #13#10 + #13#10 +
        'RedPrec:     ' + IntToStr(RedPrec) + #13#10 +
        'RedShift:    ' + IntToStr(RedShift) + #13#10 + #13#10 +
        'GreenPrec:   ' + IntToStr(GreenPrec) + #13#10 +
        'GreenShift:  ' + IntToStr(GreenShift) + #13#10 + #13#10 +
        'BluePrec:    ' + IntToStr(BluePrec) + #13#10 +
        'BlueShift:   ' + IntToStr(BlueShift) + #13#10 + #13#10 + #13#10 +
        'AlphaPrec:   ' + IntToStr(AlphaPrec) + #13#10 +
        'AlphaShift:  ' + IntToStr(AlphaShift) + #13#10 + #13#10);
    end;
  end;

procedure output2(d: TRawImageDescription);
begin
  with d do begin
    WriteLn(

      'Format:      ', Format, #13#10 + #13#10 +
      'Width:       ' + IntToStr(Width) + #13#10 +
      'Height:      ' + IntToStr(Height) + #13#10 +
      'Depth:       ' + IntToStr(Depth) + #13#10 +
      'BitOrder:    ', BitOrder, #13#10 +
      'ByteOrder:   ', ByteOrder, #13#10 +
      'LineOrder:   ', LineOrder, #13#10 +
      'LineEnd:     ', LineEnd, #13#10 +

      'BitsPerPixel:' + IntToStr(BitsPerPixel) + #13#10 + #13#10 +
      'RedPrec:     ' + IntToStr(RedPrec) + #13#10 +
      'RedShift:    ' + IntToStr(RedShift) + #13#10 + #13#10 +
      'GreenPrec:   ' + IntToStr(GreenPrec) + #13#10 +
      'GreenShift:  ' + IntToStr(GreenShift) + #13#10 + #13#10 +
      'BluePrec:    ' + IntToStr(BluePrec) + #13#10 +
      'BlueShift:   ' + IntToStr(BlueShift) + #13#10 + #13#10 + #13#10 +
      'AlphaPrec:   ' + IntToStr(AlphaPrec) + #13#10 +
      'AlphaShift:  ' + IntToStr(AlphaShift) + #13#10 + #13#10);
  end;
end;



procedure AddAlpha(aBitmap: TBitmap; Alpha: byte);
type
  TColor32 = packed record
    case integer of
      0: (B, G, R, A: byte);
      1: (BGRA: UInt32);
  end;
  TColor32Array = array[0..0] of TColor32;
  PColor32Array = ^TColor32Array;
var
  x, y: integer;
  Line: PColor32Array;
begin
  for y := 0 to aBitmap.Height - 1 do begin
    Line := aBitmap.ScanLine[y];
    for x := 0 to aBitmap.Width - 1 do begin
      Line^[x].A := Alpha;
    end;
  end;
end;

function CreateBitmap2: TBitmap;
var
  IntfImg: TLazIntfImage;
begin
  Result := TBitmap.Create;
//  Result.RawImage.Description;
  IntfImg := TLazIntfImage.Create(16, 16);

//  IntfImg.getse;

//  IntfImg.DataDescription;

output(IntfImg.DataDescription);

  //     Result.LoadFromIntfImage(IntfImg);

  IntfImg.Free;
end;

function CreateBitmap: TBitmap;
var
  p: Pointer;
  Ra: TRawImage;
begin
  Result := TBitmap.Create;

  with Result do begin

    PixelFormat := pf32bit;
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

  AddAlpha(Result, $FF);

  //  ShowMessage(IntToStr(Result.Width) + '    ' + IntToStr(Result.Height));
end;


function TForm1.LoadTexture(RawImage: TRawImage): GLuint;
type
  TLookUpTableEntry = packed record
    Description: packed record
      Bits,
      RPrec, RShift,
      GPrec, GShift,
      BPrec, BShift,
      APrec, AShift: byte;
    end;
    GLformat: packed record
      InternalFormat: GLint;
      Format: GLenum;
      DataFormat: GLenum;
    end;
  end;

const
  FORMAT_LUT: array[0..5] of TLookUpTableEntry = (

    // 32Bit mit Alpha
    (Description: (Bits: 32;
    RPrec: 8; RShift: 16;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 0;
    APrec: 8; AShift: 24);
    GLformat: (InternalFormat: GL_RGBA8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit mit Alpha ( Linux / Unit BGRABitmap )
    (Description: (Bits: 32;
    RPrec: 8; RShift: 0;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 16;
    APrec: 8; AShift: 24);
    GLformat: (InternalFormat: GL_RGBA8; Format: GL_RGBA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit ohne Alpha
    (Description: (Bits: 32;
    RPrec: 8; RShift: 16;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 0;
    APrec: 0; AShift: 24);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit ohne Alpha ( Linux JPG )
    (Description: (Bits: 32;
    RPrec: 8; RShift: 16;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 0;
    APrec: 0; AShift: 0);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 24Bit
    (Description: (Bits: 24;
    RPrec: 8; RShift: 16;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 0;
    APrec: 0; AShift: 0);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGR; DataFormat: GL_UNSIGNED_BYTE)),

    // 8Bit 256 Graustufen
    (Description: (Bits: 8;
    RPrec: 8; RShift: 0;
    GPrec: 8; GShift: 8;
    BPrec: 8; BShift: 0;
    APrec: 0; AShift: 24);
    GLformat: (InternalFormat: GL_Luminance; Format: GL_Luminance;
    DataFormat: GL_UNSIGNED_BYTE)));

  //// 1Bit Monochrom      geht nicht
  //(Description: (Bits: 1; RPrec: 1; RShift: 0; GPrec: 1; GShift: 0; BPrec: 1; BShift: 0; APrec: 0; AShift: 0);
  //GLformat: (InternalFormat: GL_RGB; Format: GL_COLOR_INDEX; DataFormat: GL_BITMAP)),

  //// 1Bit Monochrom PNG   geht nicht
  //(Description: (Bits: 1; RPrec: 1; RShift: 0; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 24);
  //GLformat: (InternalFormat: GL_RGB; Format: GL_COLOR_INDEX; DataFormat: GL_BITMAP)),

var
  TabNr, i: integer;
begin
  with RawImage.Description do begin
    SLInfo.Text :=
      '  BitsPerPixel:' + IntToStr(BitsPerPixel) + LineEnding +
      '  RedPrec:     ' + IntToStr(RedPrec) + LineEnding +
      '  RedShift:    ' + IntToStr(RedShift) + LineEnding + LineEnding +
      '  GreenPrec:   ' + IntToStr(GreenPrec) + LineEnding +
      '  GreenShift:  ' + IntToStr(GreenShift) + LineEnding + LineEnding +
      '  BluePrec:    ' + IntToStr(BluePrec) + LineEnding +
      '  BlueShift:   ' + IntToStr(BlueShift) + LineEnding + LineEnding + LineEnding +
      '  AlphaPrec:   ' + IntToStr(AlphaPrec) + LineEnding +
      '  AlphaShift:  ' + IntToStr(AlphaShift) + LineEnding + LineEnding;
  end;

  TabNr := -1;
  for i := 0 to Length(FORMAT_LUT) - 1 do begin
    with RawImage.Description, FORMAT_LUT[i].Description do begin
      if (Bits = BitsPerPixel) and (RPrec = RedPrec) and
        (RShift = RedShift) and (GPrec = GreenPrec) and (GShift = GreenShift) and
        (BPrec = BluePrec) and (BShift = BlueShift) and (APrec = AlphaPrec) and
        (AShift = AlphaShift) then begin
        TabNr := i;
        Break;
      end;
    end;
  end;

  if TabNr <> -1 then begin
    glGenTextures(1, @Result);
    glBindTexture(GL_TEXTURE_2D, Result);
    with RawImage.Description, FORMAT_LUT[TabNr].GLformat do begin
      glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawImage.Data);
    end;
    glGenerateMipmap(GL_TEXTURE_2D);
  end else begin

    with RawImage.Description do begin
      ShowMessage('Undefiniertes Format' + #13#10 + #13#10 +
        'BitsPerPixel:' + IntToStr(BitsPerPixel) + #13#10 + #13#10 +
        'RedPrec:     ' + IntToStr(RedPrec) + #13#10 +
        'RedShift:    ' + IntToStr(RedShift) + #13#10 + #13#10 +
        'GreenPrec:   ' + IntToStr(GreenPrec) + #13#10 +
        'GreenShift:  ' + IntToStr(GreenShift) + #13#10 + #13#10 +
        'BluePrec:    ' + IntToStr(BluePrec) + #13#10 +
        'BlueShift:   ' + IntToStr(BlueShift) + #13#10 + #13#10 + #13#10 +
        'AlphaPrec:   ' + IntToStr(AlphaPrec) + #13#10 +
        'AlphaShift:  ' + IntToStr(AlphaShift) + #13#10 + #13#10);
    end;
    Result := 0;

  end;

  output(RawImage.Description);
//CreateBitmap2;
end;

procedure TForm1.InitScene;
const
  ia: array[0..7] of integer = (0, 1, 2, 3, 4, 5, 6, 7);
var
  pic: TPicture;
begin

  glClearColor(0.0, 0.5, 1.0, 1.0); //Hintergrundfarbe: Hier ein leichtes Blau

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  Shader := TShader.Create([FileToStr('shader.vert'), FileToStr('shader.frag')]);
  with Shader do begin
    pos_id := AttribLocation('inPos');
    texture_id0 := AttribLocation('vertexUV0');
    WorldMatrix_id := UniformLocation('Matrix');
  end;
  glUniform1iv(Shader.UniformLocation('Sampler0'), 8, ia);


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

  //  TexID := LoadTexture(Image1.Picture.Bitmap.RawImage);
  pic := TPicture.Create;
  pic.LoadFromFile('bild.xpm');
  pic.Bitmap.TransparentColor := clFuchsia;
  pic.Bitmap.Transparent := True;
  TexID := LoadTexture(pic.Bitmap.RawImage);

  pic.Free;

end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(uiVAO[0]);

  WorldMatrix.Uniform(WorldMatrix_id);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, TexID);

  glDrawArrays(GL_Triangles, 0, Length(Quad));

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  SLInfo := TStringList.Create;
  WorldMatrix := TMatrix.Create;

  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.Align := alClient;
  OpenGLControl.Enabled := False;
  OpenGLControl.OpenGLMajorVersion := 3;
  OpenGLControl.OpenGLMinorVersion := 3;

  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(1, @uiVBO);
  glDeleteVertexArrays(1, @uiVAO);
  OpenGLControl.Free;
  Shader.Free;
  WorldMatrix.Free;
  SLInfo.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  Pic: TPicture;
  PNG: TPortableNetworkGraphic;


  procedure Filter(Bitmap: TBitmap);
  var
    x, y: integer;
  begin
    for x := 0 to Bitmap.Width div 2 do begin
      for y := 0 to Bitmap.Height do begin
        Bitmap.Canvas.Pixels[x, y] := $FF;
      end;
    end;
  end;

begin
  if OpenDialog1.Execute then begin
    Pic := TPicture.Create;
    Pic.LoadFromFile(OpenDialog1.FileName);
    TexID := LoadTexture(Pic.Bitmap.RawImage);
    Pic.Free;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form2.Show;
  Form2.Memo1.Text := SLInfo.Text;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
var
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  bit := CreateBitmap;
  TexID := LoadTexture(bit.RawImage);
  bit.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  RenderScene;
end;

end.
