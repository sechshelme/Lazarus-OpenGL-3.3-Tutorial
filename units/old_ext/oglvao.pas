unit oglVAO;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Dialogs,
  oglglad_gl,
  oglVector, oglMatrix,
  oglShader, oglLightingShader,
  oglCamera, oglVBO;

const
  MonoColorShader =
    '$vertex' + LineEnding +
    '#version 330' + LineEnding +

    'layout (location = 0) in vec3 inPos;' + LineEnding +
    'layout (location = 1) in vec3 inNormal;' + LineEnding +

    'uniform mat4 CameraMatrix;' + LineEnding +
    'uniform mat4 ObjectMatrix;' + LineEnding +

    'out Data {' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '} DataOut;' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  gl_Position = CameraMatrix * vec4(inPos, 1.0);' + LineEnding +

    '  DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '  DataOut.Normal = normalize(mat3(ObjectMatrix) * inNormal);' + LineEnding +
    '}' + LineEnding +


    '$fragment' + LineEnding +
    '#version 330' + LineEnding +

    'in Data {' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '} DataIn;' + LineEnding +

    'out vec4 OutColor;' + LineEnding +

    'uniform vec4 VecColor = vec4(1.0, 1.0, 1.0, 1.0);' + LineEnding +

    '$light.glsl' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  OutColor = VecColor;' + LineEnding +

    '  float cdummy = OutColor.a;' + LineEnding +

    '  OutColor = OutColor * Light(DataIn.Normal, DataIn.Position);' + LineEnding +
    '  OutColor.a = cdummy;' + LineEnding +
    '}';

type

  { TVAO }

  TVAO = class(TObject)
  private
    VAO: glUINT;
    Draw_mode: GLenum;
  protected
    Vertex_Count: cardinal;
  public
    Caption: string;
    class var Camera: TCamera;     // Für World und Object-Matrix
    procedure SetVertexCount(Count: integer);
    constructor Create(ADraw_mode: GLenum = GL_TRIANGLES);
    destructor Destroy; override;
    procedure BindVertexArray;
    procedure Draw;
  end;

  { TTriangleVAO }

  TTriangleVAO = class(TVAO)
  protected
    IsLight: boolean;              // Ist Object beleuchtet ?
    FVertexData: record
      Pos,                         // Vertexkoordinaten
      Normal: TVBO_Triangles;      // Normale für Beleuchtungseffekte
    end;
  public
    LightingShader: TLightingShader;

    constructor Create(light: boolean = True);
    destructor Destroy; override;

    procedure WriteVertex;
  end;

  { TBasisTriangleVAO }

  TBasisTriangleVAO = class(TTriangleVAO)
  private
    procedure SetSektoren(AValue: integer);
  protected
    FSektoren: integer;            // anz. Sektoren für Kreise/Kugeln
    procedure Triangles(Vector0, Vector1, Vector2: TVector3f); overload;
    procedure Triangles(Vector0, Vector1, Vector2, NV0, NV1, NV2: TVector3f); overload;
    procedure Quads(Vector0, Vector1, Vector2, Vector3: TVector3f); overload;
    procedure Quads(Vector0, Vector1, Vector2, Vector3, NV0, NV1, NV2, NV3: TVector3f); overload;
    procedure Polygon(Vec: array of TVector3f);
    procedure Polygon(Vec, NV: array of TVector3f);

    procedure Ring(r1, r2, h1, h2: single);
  public
    Darstellung: (ganz, geschnitten, aus);  // Wird bei Schnittmodellen gebraucht, z.B. NA-Anzeiger
    constructor Create(light: boolean = True);
    property Sektoren: integer read FSektoren write SetSektoren;
  end;

  { TMonoColorVAO }

  TMonoColorVAO = class(TBasisTriangleVAO)
  private
    UniformID: record
      CameraMatrix, ObjectMatrix, VecColor: GLint;
    end;
  protected
    FColor: TVector4f;             // Farbe des Elementes
    procedure SetColor(AValue: TVector4f);
  public
    constructor Create(light: boolean = True);
    destructor Destroy; override;
    property Color: TVector4f read FColor write SetColor;
    procedure Draw;
  end;


implementation

{ TVAO }

procedure TVAO.SetVertexCount(Count: integer);
begin
  Vertex_Count := Count;
end;

constructor TVAO.Create(ADraw_mode: GLenum);
begin
  inherited Create;
  Draw_mode := ADraw_mode;
  glGenVertexArrays(1, @VAO);
  BindVertexArray;
end;

destructor TVAO.Destroy;
begin
  glDeleteVertexArrays(1, @VAO);
  inherited Destroy;
end;

procedure TVAO.BindVertexArray;
begin
  glBindVertexArray(VAO);
end;

procedure TVAO.Draw;
begin
  BindVertexArray;
  glDrawArrays(Draw_mode, 0, Vertex_Count);
end;

{ TTriangleVAO }

constructor TTriangleVAO.Create(light: boolean);
begin
  inherited Create(GL_TRIANGLES);
  IsLight := light;

  Caption := 'Koerper';

  FVertexData.Pos := TVBO_Triangles.Create;
  FVertexData.Normal := TVBO_Triangles.Create;
end;

destructor TTriangleVAO.Destroy;
begin
  FVertexData.Pos.Free;
  FVertexData.Normal.Free;

  inherited Destroy;
end;

procedure TTriangleVAO.WriteVertex;
begin
  BindVertexArray;

  if IsLight then begin   // ohne Licht, Normale überflüssig
    if FVertexData.Normal.Count = 0 then begin   // Wenn keine Normale, dann berechnen
      FVertexData.Normal.Append(FVertexData.Pos);
      FVertexdata.Normal.Modif([normalize]);
    end;

    FVertexData.Normal.LoadVertexBuffer(1);
  end;

  Vertex_Count := FVertexData.Pos.LoadVertexBuffer(0);
end;

{ TBasisTriangleVAO }

constructor TBasisTriangleVAO.Create(light: boolean);
begin
  inherited Create(light);

  FSektoren := 0;
end;

procedure TBasisTriangleVAO.SetSektoren(AValue: integer);
begin
  if AValue < 3 then begin
    AValue := 3;
  end;
  FSektoren := AValue;
end;

procedure TBasisTriangleVAO.Triangles(Vector0, Vector1, Vector2: TVector3f);
var
  m: Tmat3x3;
begin
  m := mat3(Vector0, Vector1, Vector2);

  FVertexData.Pos.Add(m);
  FaceToNormale(m, m);
  FVertexData.Normal.Add(m);
end;

procedure TBasisTriangleVAO.Triangles(Vector0, Vector1, Vector2, NV0, NV1, NV2: TVector3f);
begin
  NV0.Normalize;
  NV1.Normalize;
  NV2.Normalize;

  FVertexData.Pos.Add(Vector0, Vector1, Vector2);
  FVertexData.Normal.Add(NV0, NV1, NV2);
end;

procedure TBasisTriangleVAO.Quads(Vector0, Vector1, Vector2, Vector3: TVector3f); inline;
begin
  Polygon([Vector0, Vector1, Vector2, Vector3]);
end;

procedure TBasisTriangleVAO.Quads(Vector0, Vector1, Vector2, Vector3, NV0, NV1, NV2, NV3: TVector3f); inline;
begin
  Polygon([Vector0, Vector1, Vector2, Vector3], [NV0, NV1, NV2, NV3]);
end;

procedure TBasisTriangleVAO.Polygon(Vec: array of TVector3f);
var
  i: integer;
begin
  for i := 1 to Length(Vec) - 2 do begin
    Triangles(Vec[0], Vec[i], Vec[i + 1]);
  end;
end;

procedure TBasisTriangleVAO.Polygon(Vec, NV: array of TVector3f);
var
  i: integer;
begin
  if Length(Vec) <> Length(NV) then begin
    Exit;
  end;
  for i := 1 to Length(Vec) - 2 do begin
    Triangles(Vec[0], Vec[i], Vec[i + 1], NV[0], NV[i], NV[i + 1]);
  end;
end;

procedure TBasisTriangleVAO.Ring(r1, r2, h1, h2: single);
var
  i: integer;
  h: single = 0.0;
  r: single = 0.0;
  t: single;

  function norm(a, b: single): TVector3f; inline;
  begin
    Result := vec3(h * a, r, h * b);
  end;

begin
  t := 2 * pi / Sektoren;
  r := r1 - r2;
  h := h2 - h1;
  for i := 0 to FSektoren - 1 do begin
    Quads(
      vec3(sin((i + 1) * t) * r1, h1, cos((i + 1) * t) * r1),
      vec3(sin((i + 1) * t) * r2, h2, cos((i + 1) * t) * r2),
      vec3(sin((i + 0) * t) * r2, h2, cos((i + 0) * t) * r2),
      vec3(sin((i + 0) * t) * r1, h1, cos((i + 0) * t) * r1),

      norm(sin((i + 1) * t), cos((i + 1) * t)),
      norm(sin((i + 1) * t), cos((i + 1) * t)),
      norm(sin((i + 0) * t), cos((i + 0) * t)),
      norm(sin((i + 0) * t), cos((i + 0) * t)));
  end;
end;

{ TMonoColorVAO }

constructor TMonoColorVAO.Create(light: boolean);
begin
  inherited Create;

  LightingShader := TLightingShader.Create([MonoColorShader], light);

  with LightingShader, UniformID do begin
    UseProgram;
    ObjectMatrix := UniformLocation('ObjectMatrix');
    CameraMatrix := UniformLocation('CameraMatrix');
    VecColor := UniformLocation('VecColor');
  end;

  Color := vec4(1.0, 1.0, 1.0, 1.0);
end;

destructor TMonoColorVAO.Destroy;
begin
  LightingShader.Free;
  inherited Destroy;
end;

procedure TMonoColorVAO.Draw;
var
  m : TMatrix;
begin
  LightingShader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;
    ObjectMatrix := WorldMatrix * ObjectMatrix;

    ObjectMatrix.Uniform(UniformID.ObjectMatrix);

    ObjectMatrix := CameraMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(UniformID.CameraMatrix);
    ObjectMatrix := m;

    glUniform4fv(UniformID.VecColor, 1, @Color);
  end;

  inherited Draw;
end;

procedure TMonoColorVAO.SetColor(AValue: TVector4f);
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
end;

end.
