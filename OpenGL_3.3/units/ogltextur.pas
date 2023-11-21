unit oglTextur;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  TypInfo,
  Graphics,
  IntfGraphics,
  GraphType,
  Dialogs,
  dglOpenGL;
//  MyLogForms;

type

  TGLTextureFormat = packed record
    InternalFormat: GLint;
    Format: GLenum;
    DataFormat: GLenum;
  end;

  { TTexParameter }

  TTexParameter = class(TObject)
  private
    Data: array of record
      pname: GLenum;
      params: GLint;
    end;
  public
    procedure Add(pname: GLenum; params: GLint);
    procedure Clear;
    procedure SetParameter;
  end;

  { TTexturBuffer }

  TTexturBuffer = class(TObject)
  private
    FID: GLuint;
    FIsMipMap: boolean;
  public
    TexParameter: TTexParameter;
    property IsMipMap: boolean read FIsMipMap write FIsMipMap;
    property ID: GLuint read FID;
    constructor Create;
    destructor Destroy; override;
    procedure LoadTextures(RawImage: TRawImage); overload;
    procedure LoadTextures(Datei: string); overload;
    procedure LoadTextures(w, h: integer; const Dat: array of GLenum); overload;
    procedure LoadTextures8Bit(w, h: integer; const Dat: array of GLbyte); overload;
    procedure LoadTextures(w, h: integer; Clear: boolean = False); overload;
    procedure ActiveAndBind(Nr: integer);
    procedure ActiveAndBind;
  end;

function getGLTexturFormat(RawImage: TRawImage): TGLTextureFormat;

implementation

function getGLTexturFormat(RawImage: TRawImage): TGLTextureFormat;
type
  TLookUpTableEntry = packed record
    Description: packed record
      Bits,
      RPrec, RShift,
      GPrec, GShift,
      BPrec, BShift,
      APrec, AShift: byte;
    end;
    GLformat: TGLTextureFormat;
  end;

const
  FORMAT_LUT: array[0..5] of TLookUpTableEntry = (

    // 32Bit mit Alpha
    (Description: (Bits: 32; RPrec: 8; RShift: 16; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 8; AShift: 24);
    GLformat: (InternalFormat: GL_RGBA8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit mit Alpha ( Linux / Unit BGRABitmap )
    (Description: (Bits: 32; RPrec: 8; RShift: 0; GPrec: 8; GShift: 8; BPrec: 8; BShift: 16; APrec: 8; AShift: 24);
    GLformat: (InternalFormat: GL_RGBA8; Format: GL_RGBA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit ohne Alpha
    (Description: (Bits: 32; RPrec: 8; RShift: 16; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 24);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 32Bit ohne Alpha ( Linux JPG )
    (Description: (Bits: 32; RPrec: 8; RShift: 16; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 0);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGRA; DataFormat: GL_UNSIGNED_BYTE)),

    // 8Bit 256 Graustufen
    (Description: (Bits: 8; RPrec: 8; RShift: 0; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 24);
    GLformat: (InternalFormat: GL_Luminance; Format: GL_Luminance; DataFormat: GL_UNSIGNED_BYTE)),

    //// 1Bit Monochrom      geht nicht
    //(Description: (Bits: 1; RPrec: 1; RShift: 0; GPrec: 1; GShift: 0; BPrec: 1; BShift: 0; APrec: 0; AShift: 0);
    //GLformat: (InternalFormat: GL_RGB; Format: GL_COLOR_INDEX; DataFormat: GL_BITMAP)),

    //// 1Bit Monochrom PNG   geht nicht
    //(Description: (Bits: 1; RPrec: 1; RShift: 0; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 24);
    //GLformat: (InternalFormat: GL_RGB; Format: GL_COLOR_INDEX; DataFormat: GL_BITMAP)),

    // 24Bit
    (Description: (Bits: 24; RPrec: 8; RShift: 16; GPrec: 8; GShift: 8; BPrec: 8; BShift: 0; APrec: 0; AShift: 0);
    GLformat: (InternalFormat: GL_RGB8; Format: GL_BGR; DataFormat: GL_UNSIGNED_BYTE)));

var
  TabNr, i: integer;
begin

  TabNr := -1;
  for i := 0 to Length(FORMAT_LUT) - 1 do begin
    with RawImage.Description, FORMAT_LUT[i].Description do begin
      if (Bits = BitsPerPixel) and
        (RPrec = RedPrec) and (RShift = RedShift) and (GPrec = GreenPrec) and (GShift = GreenShift) and
        (BPrec = BluePrec) and (BShift = BlueShift) and (APrec = AlphaPrec) and (AShift = AlphaShift) then begin
        TabNr := i;
        Break;
      end;
    end;
  end;

  if TabNr <> -1 then begin
    Result := FORMAT_LUT[TabNr].GLformat;
  end else begin
    Result.InternalFormat := 0;
    Result.DataFormat := 0;
    Result.Format := 0;
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
  end;
end;


{ TTexParameter }

procedure TTexParameter.Add(pname: GLenum; params: GLint);
var
  l: integer;
begin
  l := Length(Data);
  SetLength(Data, l + 1);
  Data[l].pname := pname;
  Data[l].params := params;
end;

procedure TTexParameter.Clear;
begin
  SetLength(Data, 0);
end;

procedure TTexParameter.SetParameter;
var
  i: integer;
begin
  for i := 0 to Length(Data) - 1 do begin
    glTexParameteri(GL_TEXTURE_2D, Data[i].pname, Data[i].params);
  end;
  //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
  //  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);

end;

{ TTexturBuffer }


constructor TTexturBuffer.Create;
begin
  inherited Create;
  FIsMipMap := True;
  TexParameter := TTexParameter.Create;
  FID := 0;
  glGenTextures(1, @FID);
end;

destructor TTexturBuffer.Destroy;
begin
  glDeleteTextures(1, @FID);
  TexParameter.Free;
  inherited Destroy;
end;

procedure TTexturBuffer.LoadTextures(Datei: string);
var
  Picture: TPicture;

  procedure ug;
  begin
    //    LogForm.Add('TTexturBuffer, error format: ' + Datei);
    //    LogForm.Show;
    ShowMessage('Kann Datei: ' + Datei + ' nicht laden !');
  end;

begin
  if upcase(ExtractFileExt(Datei)) = '.TGA' then begin
    ug;
  end;
  Picture := TPicture.Create;
  try
    Picture.LoadFromFile(Datei);
    LoadTextures(Picture.Bitmap.RawImage);
  except
    ug;
  end;
  Picture.Free;
end;

procedure TTexturBuffer.LoadTextures(w, h: integer; const Dat: array of GLenum);
begin
  glBindTexture(GL_TEXTURE_2D, FID);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Dat);
  TexParameter.SetParameter;
  if FIsMipMap then begin
    glGenerateMipmap(GL_TEXTURE_2D);
  end;
  glBindTexture(GL_TEXTURE_2D, 0);
end;

procedure TTexturBuffer.LoadTextures8Bit(w, h: integer; const Dat: array of GLbyte);
begin
  glBindTexture(GL_TEXTURE_2D, FID);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, w, h, 0, GL_RGB, GL_UNSIGNED_BYTE_3_3_2, @Dat);
  TexParameter.SetParameter;
  if FIsMipMap then begin
    glGenerateMipmap(GL_TEXTURE_2D);
  end;
  glBindTexture(GL_TEXTURE_2D, 0);
end;

procedure TTexturBuffer.LoadTextures(w, h: integer; Clear: boolean);
var
  DataPointer: Pointer;
begin
  glBindTexture(GL_TEXTURE_2D, FID);
  if Clear then begin
    GetMem(DataPointer, w * h * 4);
    FillDWord(DataPointer^, w * h, $FF000000);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, DataPointer);
    Freemem(DataPointer);
  end else begin
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  end;

  TexParameter.SetParameter;
  if FIsMipMap then begin
    glGenerateMipmap(GL_TEXTURE_2D);
  end;
  glBindTexture(GL_TEXTURE_2D, 0);
end;

procedure TTexturBuffer.LoadTextures(RawImage: TRawImage);
var
  GLformat: TGLTextureFormat;
begin
  GLformat := getGLTexturFormat(RawImage);

  if GLformat.Format <> 0 then begin
    glBindTexture(GL_TEXTURE_2D, FID);

    with RawImage.Description, GLformat do begin
      glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawImage.Data);
    end;

    TexParameter.SetParameter;
    if FIsMipMap then begin
      glGenerateMipmap(GL_TEXTURE_2D);
    end;

    glBindTexture(GL_TEXTURE_2D, 0);
  end else begin
    FID := 0;
  end;
end;

procedure TTexturBuffer.ActiveAndBind(Nr: integer);
begin
  glActiveTexture(GL_TEXTURE0 + Nr);
  glBindTexture(GL_TEXTURE_2D, FID);
end;

procedure TTexturBuffer.ActiveAndBind;
begin
  ActiveAndBind(0);
end;

end.
