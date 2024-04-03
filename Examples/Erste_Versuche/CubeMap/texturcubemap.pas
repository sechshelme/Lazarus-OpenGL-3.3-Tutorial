unit TexturCubeMap;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, GraphType, Graphics, types,
  oglglad_gl,
oglVector,  oglMatrix, oglShader, oglVBO, oglVAO, oglTextur, oglTexturVAO, oglTexturKoerper,oglLightingShader;

type

  { TCubeTexturBuffer }

  TCubeTexturBuffer = class(TObject)
  private
    FID: GLuint;
  public
    TexParameter: TTexParameter;
    property ID: GLuint read FID;
    constructor Create;
    destructor Destroy; override;
    procedure LoadTextures(RawImage: TRawImage); overload;
    procedure LoadTextures(RawI: array of TRawImage); overload;
    procedure LoadTextures(Bitmap: TBitmap); overload;
    procedure ActiveAndBind(Nr: integer);
    procedure ActiveAndBind;
  end;


  { TCubeMapMultiTexturVAO }

  TCubeMapMultiTexturVAO = class(TBasisTriangleVAO)
  private
    UniformID: record
      ObjectMatrix: GLint;
      CameraMatrix: GLint;

      VecColor: GLint;
    end;

    FColor: TVector4f;
    procedure SetColor(AValue: TVector4f);
  protected
    Textur: record
      TexCoord: TVBO_Triangles;
    end;
  public

    property Color: TVector4f read FColor write SetColor;

    constructor Create(anzTextures: integer; Lighting: boolean = True);
    destructor Destroy; override;

    procedure Draw(TextBuffer: array of TCubeTexturBuffer); overload;
    procedure Draw; overload;

  end;

  { TSphereCubeMapMultiTexturVAO }

  TSphereCubeMapMultiTexturVAO = class(TCubeMapMultiTexturVAO)
  public
    constructor Create(anzTextures: integer; Lighting: boolean = True);
    procedure WriteVertex;
  end;


  { TBoxCubeMapMultiTexturVAO }

  TBoxCubeMapMultiTexturVAO = class(TCubeMapMultiTexturVAO)
  public
    procedure WriteVertex;
  end;


implementation

const
  Quad: array[0..11] of Tmat3x3 = (
    // Umfang
    ((-0.5, +0.5, +0.5), (-0.5, -0.5, +0.5), (+0.5, -0.5, +0.5)), ((-0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, +0.5, +0.5)),
    ((+0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, -0.5, -0.5)), ((+0.5, +0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, +0.5, -0.5)),
    ((+0.5, +0.5, -0.5), (+0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((+0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, +0.5, -0.5)),
    ((-0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, +0.5)), ((-0.5, +0.5, -0.5), (-0.5, -0.5, +0.5), (-0.5, +0.5, +0.5)),
    // oben
    ((+0.5, +0.5, +0.5), (+0.5, +0.5, -0.5), (-0.5, +0.5, -0.5)), ((+0.5, +0.5, +0.5), (-0.5, +0.5, -0.5), (-0.5, +0.5, +0.5)),
    // unten
    ((-0.5, -0.5, +0.5), (-0.5, -0.5, -0.5), (+0.5, -0.5, -0.5)), ((-0.5, -0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, -0.5, +0.5)));

  QuadMap: array[0..11] of Tmat3x3 = (
    // Umfang
    ((-1.0, +1.0, +1.0), (-1.0, -1.0, +1.0), (+1.0, -1.0, +1.0)), ((-1.0, +1.0, +1.0), (+1.0, -1.0, +1.0), (+1.0, +1.0, +1.0)),
    ((+1.0, +1.0, +1.0), (+1.0, -1.0, +1.0), (+1.0, -1.0, -1.0)), ((+1.0, +1.0, +1.0), (+1.0, -1.0, -1.0), (+1.0, +1.0, -1.0)),
    ((+1.0, +1.0, -1.0), (+1.0, -1.0, -1.0), (-1.0, -1.0, -1.0)), ((+1.0, +1.0, -1.0), (-1.0, -1.0, -1.0), (-1.0, +1.0, -1.0)),
    ((-1.0, +1.0, -1.0), (-1.0, -1.0, -1.0), (-1.0, -1.0, +1.0)), ((-1.0, +1.0, -1.0), (-1.0, -1.0, +1.0), (-1.0, +1.0, +1.0)),
    // oben
    ((+1.0, +1.0, +1.0), (+1.0, +1.0, -1.0), (-1.0, +1.0, -1.0)), ((+1.0, +1.0, +1.0), (-1.0, +1.0, -1.0), (-1.0, +1.0, +1.0)),
    // unten
    ((-1.0, -1.0, +1.0), (-1.0, -1.0, -1.0), (+1.0, -1.0, -1.0)), ((-1.0, -1.0, +1.0), (+1.0, -1.0, -1.0), (+1.0, -1.0, +1.0)));

{ TCubeTexturBuffer }

constructor TCubeTexturBuffer.Create;
begin
  inherited Create;
  TexParameter := TTexParameter.Create;
  FID := 0;
  glGenTextures(1, @FID);
end;

destructor TCubeTexturBuffer.Destroy;
begin
  glDeleteTextures(1, @FID);
  TexParameter.Free;
  inherited Destroy;
end;

procedure TCubeTexturBuffer.LoadTextures(RawImage: TRawImage);
var
  GLformat: TGLTextureFormat;
  len: integer;

  procedure TexImage(target, Left, Top: integer);
  begin
    glPixelStorei(GL_UNPACK_SKIP_PIXELS, Left * len);
    glPixelStorei(GL_UNPACK_SKIP_ROWS, Top * len);
    with RawImage.Description, GLformat do begin
      glTexImage2D(target, 0, InternalFormat, len, len, 0, Format, DataFormat, RawImage.Data);
    end;
  end;

begin
  GLformat := getGLTexturFormat(RawImage);
  len := RawImage.Description.Width div 4;

  if GLformat.Format <> 0 then begin
    glBindTexture(GL_TEXTURE_CUBE_MAP, FID);

    glPixelStorei(GL_UNPACK_ROW_LENGTH, RawImage.Description.Width);

    TexImage(GL_TEXTURE_CUBE_MAP_POSITIVE_X, 2, 1);
    TexImage(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, 0, 1);
    TexImage(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, 1, 0);
    TexImage(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, 1, 2);
    TexImage(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, 1, 1);
    TexImage(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 3, 1);

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_CUBE_MAP, 0);

    glPixelStorei(GL_UNPACK_SKIP_PIXELS, 0);
    glPixelStorei(GL_UNPACK_SKIP_ROWS, 0);
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0);
  end else begin
    FID := 0;
  end;
end;

procedure TCubeTexturBuffer.LoadTextures(RawI :array of  TRawImage);
var
  GLformat: TGLTextureFormat;
begin
  if Length(RawI)<>6 then Exit;

  GLformat := getGLTexturFormat(RawI[0]);

  if GLformat.Format <> 0 then begin
    glBindTexture(GL_TEXTURE_CUBE_MAP, FID);
    with RawI[0].Description, GLformat do begin
      glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[0].Data);
      glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[1].Data);
      glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[2].Data);
      glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[3].Data);
      glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[4].Data);
      glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 0, InternalFormat, Width, Height, 0, Format, DataFormat, RawI[5].Data);
    end;

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_CUBE_MAP, 0);
  end else begin
    FID := 0;
  end;
end;

procedure TCubeTexturBuffer.LoadTextures(Bitmap: TBitmap);
var
  BitmapArray: array [0..5] of TBitmap;
  w, h, i: integer;
  RawImageArray: array[0..5]of TRawImage;
  r: array[0..5] of types.TRect;

  function getRect(x, y: integer): types.TRect;
  begin
    Result := Rect(x * w, y * h, (x + 1) * w, (y + 1) * w);
  end;

begin
  w := Bitmap.Width div 4;
  h := Bitmap.Height div 3;
  for i := 0 to 5 do begin
    BitmapArray[i] := TBitmap.Create;
    BitmapArray[i].SetSize(w, h);
  end;

  r[0] := getRect(2, 1);
  r[1] := getRect(0, 1);
  r[2] := getRect(1, 0);
  r[3] := getRect(1, 2);
  r[4] := getRect(1, 1);
  r[5] := getRect(3, 1);

  for i := 0 to 5 do begin
    BitmapArray[i].Canvas.CopyRect(Rect(0, 0, w, h), Bitmap.Canvas, r[i]);
    RawImageArray[i] := BitmapArray[i].RawImage;
  end;

  LoadTextures(RawImageArray);

  for i := 0 to 5 do begin
    BitmapArray[i].Free;
  end;
end;


procedure TCubeTexturBuffer.ActiveAndBind(Nr: integer);
begin
  glActiveTexture(GL_TEXTURE0 + Nr);
  glBindTexture(GL_TEXTURE_CUBE_MAP, ID);
end;

procedure TCubeTexturBuffer.ActiveAndBind;
begin
  ActiveAndBind(0);
end;

{ TCubeMapMultiTexturVAO }

constructor TCubeMapMultiTexturVAO.Create(anzTextures: integer; Lighting: boolean);
const
  ia: array[0..3] of integer = (0, 1, 2, 3);

  Vert_Shader =
    '#version 330' + LineEnding +

    'layout (location = 0) in vec3 inPos;' + LineEnding +
    'layout (location = 1) in vec3 inNormal;' + LineEnding +

    'layout (location = 10) in vec3 inVertexUV;' + LineEnding +

    'out Data {' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec3 UV;' + LineEnding +
    '} DataOut;' + LineEnding +

    'uniform mat4 ObjectMatrix;' + LineEnding +
    'uniform mat4 CameraMatrix;' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  gl_Position = CameraMatrix * vec4(inPos, 1.0);' + LineEnding +

//    '  DataOut.UV = (vec4(inVertexUV, 1.0) * ObjectMatrix).xyz;' + LineEnding +
    '  DataOut.UV = inVertexUV;' + LineEnding +

    '  DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '  DataOut.Normal = mat3(inverse(ObjectMatrix)) * inNormal;' + LineEnding +
    '}';

  Kopf_Frag =
    '#version 330' + LineEnding +
    'in Data {' + LineEnding +
    '  vec3 Position; ' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec3 UV;' + LineEnding +
    '} DataIn;' + LineEnding +

    'out vec4 OutColor;' + LineEnding +

    'uniform samplerCube myTextureSampler[4];' + LineEnding +

    '$light.glsl' + LineEnding +

    'void main() {' + LineEnding;

  Fuss =
    '  float cdummy = OutColor.a;' + LineEnding +
    '  OutColor = OutColor * Light(DataIn.Normal, DataIn.Position);' + LineEnding +
    '  OutColor.a = cdummy;' + LineEnding +
    '}';
var
  Frag_Shader: string;
  i: integer;

begin
  inherited Create(Lighting);

  with Textur do begin
    TexCoord := TVBO_Triangles.Create;
  end;

  if AnzTextures = 0 then begin      // ohne Textur
    LightingShader := TLightingShader.Create([MonoColorShader], Lighting);
  end else begin
    Frag_Shader := Kopf_Frag + '  OutColor = (';
    for i := 0 to AnzTextures - 1 do begin
      Frag_Shader := Frag_Shader + 'texture( myTextureSampler[' + IntToStr(i) + '], DataIn.UV )';
      if i < AnzTextures - 1 then begin
        Frag_Shader := Frag_Shader + '+';
      end;
    end;
    if AnzTextures = 1 then begin
      Frag_Shader := Frag_Shader + ');' + LineEnding + Fuss;
    end else begin
      Frag_Shader := Frag_Shader + ') / ' + IntToStr(AnzTextures) + ';' + LineEnding + Fuss;
    end;

    LightingShader := TLightingShader.Create([Vert_Shader, Frag_Shader], Lighting);
  end;

  with LightingShader do begin
    UseProgram;
    UniformID.ObjectMatrix := UniformLocation('ObjectMatrix');
    UniformID.CameraMatrix := UniformLocation('CameraMatrix');
    if AnzTextures = 0 then begin
      UniformID.VecColor := UniformLocation('VecColor');
    end else begin
      glUniform1iv(UniformLocation('myTextureSampler'), AnzTextures, ia);
    end;
  end;

  Color := vec4(1.0, 1.0, 1.0, 1.0);
end;

destructor TCubeMapMultiTexturVAO.Destroy;
begin
  LightingShader.Free;
  Textur.TexCoord.Free;

  inherited Destroy;
end;

procedure TCubeMapMultiTexturVAO.SetColor(AValue: TVector4f);
var
  i: integer;
begin
  for i := 0 to 3 do begin
    if AValue[i] > 1.0 then begin
      AValue[i] := 1.0;
    end;
    if AValue[i] < 0.0 then begin
      AValue[i] := 0.0;
    end;
  end;
  FColor := AValue;
  glUniform4fv(UniformID.VecColor, 1, @FColor);
end;

procedure TCubeMapMultiTexturVAO.Draw(TextBuffer: array of TCubeTexturBuffer);
var
  anzTextures, i: integer;
  m: TMatrix;
begin
  anzTextures := Length(TextBuffer);
  if anzTextures > 4 then begin
    anzTextures := 4;
  end;

  LightingShader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;
    ObjectMatrix := WorldMatrix * ObjectMatrix;

    ObjectMatrix.Uniform(UniformID.ObjectMatrix);

    ObjectMatrix := CameraMatrix *  ObjectMatrix;
    ObjectMatrix.Uniform(UniformID.CameraMatrix);
    ObjectMatrix := m;

    for i := 0 to anzTextures - 1 do begin   // mit Textur
      TextBuffer[i].ActiveAndBind(i);
    end;

    inherited Draw;
  end;
end;

procedure TCubeMapMultiTexturVAO.Draw;
begin
  Draw([]);
end;

{ TBoxCubeMapMultiTexturVAO }

procedure TBoxCubeMapMultiTexturVAO.WriteVertex;
begin
  Textur.TexCoord.Add(QuadMap);
  FVertexdata.Pos.Add(Quad);

  inherited WriteVertex;

  with Textur.TexCoord do begin
    LoadVertexBuffer(10);
  end;
end;

{ TSphereCubeMapMultiTexturVAO }

constructor TSphereCubeMapMultiTexturVAO.Create(anzTextures: integer;
  Lighting: boolean);
begin
  inherited Create(anzTextures, Lighting);

  Sektoren := 64;
end;

procedure TSphereCubeMapMultiTexturVAO.WriteVertex;
const
  dm = 0.5;
  Stauchung = 1.0;
var
  i, j: integer;
  t, rk: single;

  Tab: array of array of record
    a, b, c: single;
  end;

begin
  t := 2 * pi / Sektoren;
  SetLength(Tab, FSektoren + 1, FSektoren div 2 + 1);
  for j := 0 to FSektoren div 2 do begin
    rk := sin(t * j);
    for i := 0 to FSektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;


  for i := 0 to FSektoren - 1 do begin
    for j := 0 to FSektoren div 2 - 1 do begin
      Quads(
        vec3(Tab[i + 0, j + 1].a * dm, Tab[i + 0, j + 1].c * dm * Stauchung, Tab[i + 0, j + 1].b * dm),
        vec3(Tab[i + 1, j + 1].a * dm, Tab[i + 1, j + 1].c * dm * Stauchung, Tab[i + 1, j + 1].b * dm),
        vec3(Tab[i + 1, j + 0].a * dm, Tab[i + 1, j + 0].c * dm * Stauchung, Tab[i + 1, j + 0].b * dm),
        vec3(Tab[i + 0, j + 0].a * dm, Tab[i + 0, j + 0].c * dm * Stauchung, Tab[i + 0, j + 0].b * dm),

        vec3(Tab[i + 0, j + 1].a, Tab[i + 0, j + 1].c / Stauchung, Tab[i + 0, j + 1].b),
        vec3(Tab[i + 1, j + 1].a, Tab[i + 1, j + 1].c / Stauchung, Tab[i + 1, j + 1].b),
        vec3(Tab[i + 1, j + 0].a, Tab[i + 1, j + 0].c / Stauchung, Tab[i + 1, j + 0].b),
        vec3(Tab[i + 0, j + 0].a, Tab[i + 0, j + 0].c / Stauchung, Tab[i + 0, j + 0].b));
    end;
  end;

  Textur.TexCoord.Append(FVertexData.Pos);

  inherited WriteVertex;

  with Textur.TexCoord do begin
    LoadVertexBuffer(10);
  end;
end;

end.
