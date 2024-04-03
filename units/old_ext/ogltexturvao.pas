unit oglTexturVAO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs,
  oglglad_gl,
  oglVector, oglMatrix, oglShader, oglLightingShader, oglTextur, oglVBO, oglVAO;

type

  { TMultiTexturVAO }

  TMultiTexturVAO = class(TBasisTriangleVAO)
  private
    UniformID: record
      CameraMatrix: GLint;
      ObjectMatrix: GLint;
      VecColor: GLint;
    end;

    FColor: TVector4f;
    procedure SetColor(AValue: TVector4f);
  protected
    Textur: record
      TexCoord: TVBO_Triangles2D;
    end;
  public

    property Color: TVector4f read FColor write SetColor;

    constructor Create(anzTextures: integer; Lighting: boolean = True);
    destructor Destroy; override;

    procedure WriteVertex;

    procedure Draw(TextBuffer: array of TTexturBuffer); overload;
    procedure Draw; overload;

    procedure SaveToStream(Stream: TFileStream);
  end;

  { TBumpmappingTexturVAO }

  TBumpmappingTexturVAO = class(TBasisTriangleVAO)
  private
    UniformID: record
      CameraMatrix: GLint;
      ObjectMatrix: GLint;
      VecColor: GLint;
    end;
  protected
    Textur: record
      TexCoord: TVBO_Triangles2D;
    end;
  public

    constructor Create(Lighting: boolean = True);
    destructor Destroy; override;

    procedure WriteVertex;

    procedure Draw(Text, Normal: TTexturBuffer);

    procedure SaveToStream(Stream: TFileStream);
  end;


implementation

{ TMultiTexturVAO }

constructor TMultiTexturVAO.Create(anzTextures: integer; Lighting: boolean);
const
  ia: array[0..3] of integer = (0, 1, 2, 3);

  Vert_Shader =
    '#version 330' + LineEnding +

    'layout (location = 0) in vec3 inPos;' + LineEnding +
    'layout (location = 1) in vec3 inNormal;' + LineEnding +

    'layout (location = 10) in vec2 inVertexUV;' + LineEnding +

    'out Data {' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec2 UV;' + LineEnding +
    '} DataOut;' + LineEnding +

    'uniform mat4 CameraMatrix;' + LineEnding +
    'uniform mat4 ObjectMatrix;' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  gl_Position = CameraMatrix * vec4(inPos, 1.0);' + LineEnding +

    '  DataOut.UV = inVertexUV;' + LineEnding +

    '  DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '  DataOut.Normal = normalize(mat3(ObjectMatrix) * inNormal);' + LineEnding +
    '}';

  Kopf_Frag =
    '#version 330' + LineEnding +
    'in Data {' + LineEnding +
    '  vec3 Position; ' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec2 UV;' + LineEnding +
    '} DataIn;' + LineEnding +

    'out vec4 OutColor;' + LineEnding +

    'uniform sampler2D myTextureSampler[4];' + LineEnding +

    '$light.glsl' + LineEnding +

    'void main() {' + LineEnding;

  Fuss_Frag =
    '  float cdummy = OutColor.a;' + LineEnding +

    '  if (cdummy > 0.5) {' + LineEnding +
    '    OutColor = OutColor * Light(DataIn.Normal, DataIn.Position);' + LineEnding +
    '    OutColor.a = cdummy;' + LineEnding +
    '  } else {' + LineEnding +
    '    discard; // Wen transparent, Pixel nicht ausgeben.' + LineEnding +
    '  }' + LineEnding +
    '}';
var
  Frag_Shader: string;
  i: integer;

begin
  inherited Create(Lighting);

  with Textur do begin
    TexCoord := TVBO_Triangles2D.Create;
  end;

  if AnzTextures = 0 then begin      // ohne Textur
    LightingShader := TLightingShader.Create([MonoColorShader], Lighting);
  end else begin                  // OutColor = (texture( myTextureSampler[0], DataIn.UV ) + texture( myTextureSampler[1], DataIn.UV )) / 2;
    Frag_Shader := Kopf_Frag + '  OutColor = (';
    for i := 0 to AnzTextures - 1 do begin
      Frag_Shader := Frag_Shader + 'texture( myTextureSampler[' + IntToStr(i) + '], DataIn.UV )';
      if i < AnzTextures - 1 then begin
        Frag_Shader := Frag_Shader + '+';
      end;
    end;
    if AnzTextures = 1 then begin
      Frag_Shader := Frag_Shader + ');' + LineEnding + Fuss_Frag;
    end else begin
      Frag_Shader := Frag_Shader + ') / ' + IntToStr(AnzTextures) + ';' + LineEnding + Fuss_Frag;
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

destructor TMultiTexturVAO.Destroy;
begin
  LightingShader.Free;

  Textur.TexCoord.Free;
  inherited Destroy;
end;

procedure TMultiTexturVAO.WriteVertex;
begin
  inherited WriteVertex;

  with Textur.TexCoord do begin
    LoadVertexBuffer(10);
  end;
end;

procedure TMultiTexturVAO.SetColor(AValue: TVector4f);
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

  LightingShader.UseProgram;
  FColor := AValue;
  glUniform4fv(UniformID.VecColor, 1, @FColor);
end;

procedure TMultiTexturVAO.Draw(TextBuffer: array of TTexturBuffer);
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

    ObjectMatrix := CameraMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(UniformID.CameraMatrix);
    ObjectMatrix := m;

    for i := 0 to anzTextures - 1 do begin   // mit Textur
      TextBuffer[i].ActiveAndBind(i);
    end;

    inherited Draw;
  end;
end;

procedure TMultiTexturVAO.Draw;
begin
  Draw([]);
end;

procedure TMultiTexturVAO.SaveToStream(Stream: TFileStream);
begin
  stream.Write(FColor, SizeOf(FColor));
  FVertexData.Pos.SaveToStream(stream);
  FVertexData.Normal.SaveToStream(stream);
  Textur.TexCoord.SaveToStream(Stream);
end;

{ TBumpmappingTexturVAO }

constructor TBumpmappingTexturVAO.Create(Lighting: boolean);
const
  ia: array[0..1] of integer = (0, 1);

  Vert_Shader =
    '#version 330' + LineEnding +

    'layout (location = 0) in vec3 inPos;' + LineEnding +
    'layout (location = 1) in vec3 inNormal;' + LineEnding +

    'layout (location = 10) in vec2 inVertexUV;' + LineEnding +

    'out Data {' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec2 UV;' + LineEnding +
    '} DataOut;' + LineEnding +

    'uniform mat4 ObjectMatrix;' + LineEnding +
    'uniform mat4 CameraMatrix;' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  gl_Position = CameraMatrix * vec4(inPos, 1.0);' + LineEnding +

    '  DataOut.UV = inVertexUV;' + LineEnding +

    '  DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '  DataOut.Normal =  normalize(mat3(ObjectMatrix) * inNormal);' + LineEnding +
    '}';

  Frag_Shader =
    '#version 330' + LineEnding +

    'in Data {' + LineEnding +
    '  vec3 Position; ' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '  vec2 UV;' + LineEnding +
    '} DataIn;' + LineEnding +

    'out vec4 OutColor;' + LineEnding +

    'uniform sampler2D myTextureSampler[4];' + LineEnding +

    '$light.glsl' + LineEnding +

    'void main() {' + LineEnding +
    '  vec3 Normal = (texture2D(myTextureSampler[1], DataIn.UV.st).rgb * 2.0 - 1.0) + normalize(DataIn.Normal);' + LineEnding +
    '  OutColor = (texture( myTextureSampler[0], DataIn.UV ));' + LineEnding +
    '  float cdummy = OutColor.a;' + LineEnding +
    '  OutColor = OutColor * Light(Normal, DataIn.Position);' + LineEnding +
    '  OutColor.a = cdummy;' + LineEnding +
    '}';

begin
  inherited Create(Lighting);

  with Textur do begin
    TexCoord := TVBO_Triangles2D.Create;
  end;

  LightingShader := TLightingShader.Create([Vert_Shader, Frag_Shader], Lighting);

  with LightingShader do begin
    UseProgram;
    UniformID.CameraMatrix := UniformLocation('CameraMatrix');
    UniformID.ObjectMatrix := UniformLocation('ObjectMatrix');
    glUniform1iv(UniformLocation('myTextureSampler'), Length(ia), ia);
  end;

end;

destructor TBumpmappingTexturVAO.Destroy;
begin
  LightingShader.Free;

  Textur.TexCoord.Free;
  inherited Destroy;
end;

procedure TBumpmappingTexturVAO.WriteVertex;
begin
  inherited WriteVertex;

  with Textur.TexCoord do begin
    LoadVertexBuffer(10);
  end;
end;

procedure TBumpmappingTexturVAO.Draw(Text, Normal: TTexturBuffer);
var
  m: TMatrix;
begin
  LightingShader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;;
    ObjectMatrix := WorldMatrix * ObjectMatrix;

    ObjectMatrix.Uniform(UniformID.ObjectMatrix);

    ObjectMatrix := CameraMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(UniformID.CameraMatrix);
    ObjectMatrix := m;

    Text.ActiveAndBind(0);
    Normal.ActiveAndBind(1);

    inherited Draw;
  end;

end;

procedure TBumpmappingTexturVAO.SaveToStream(Stream: TFileStream);
begin
  FVertexData.Pos.SaveToStream(stream);
  FVertexData.Normal.SaveToStream(stream);
  Textur.TexCoord.SaveToStream(Stream);
end;

end.
