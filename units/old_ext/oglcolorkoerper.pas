unit oglColorKoerper;

{$mode objfpc}{$H+}

interface

uses
  Dialogs, oglVAO, oglMatrix, oglglad_gl, oglShader,oglLightingShader, oglVBO;

type

  { TColorVAO }

  TColorVAO = class(TBasisTriangleVAO)
  private
    UniformID: record
      ObjectMatrix: GLint;
      CameraMatrix: GLint;
    end;
  protected
    ColorVetexData: TVBO_Triangles;                         // Wird bei mehrfarbigen Körper gebraucht
  public
    constructor Create(light: boolean = True);
    destructor Destroy; override;
    procedure WriteVertex;
    procedure Draw;
  protected
  end;

  { TColorTriangle }

  TColorTriangle = class(TColorVAO)
  public
    procedure WriteVertex;
  end;


implementation

{ TColorVAO }

constructor TColorVAO.Create(light: boolean);
const
  VertexShader =
    '#version 330' + LineEnding +

    'layout (location = 0) in vec3 inPos;' + LineEnding +
    'layout (location = 1) in vec3 inNormal;' + LineEnding +
    'layout (location = 2) in vec4 inColor;' + LineEnding +

    'uniform mat4 ObjectMatrix;' + LineEnding +
    'uniform mat4 CameraMatrix;' + LineEnding +

    'out Data{' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec4 Color;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '} DataOut;' + LineEnding +

    'out vec2 UV;' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  gl_Position = CameraMatrix * vec4(inPos, 1.0);' + LineEnding +

    '  DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '  DataOut.Normal = normalize(mat3(ObjectMatrix) * inNormal);' + LineEnding +

    '  DataOut.Color = inColor;' + LineEnding +
    '}';

  FragmentShader =
    '#version 330' + LineEnding +

    'in Data{' + LineEnding +
    '  vec3 Position;' + LineEnding +
    '  vec4 Color;' + LineEnding +
    '  vec3 Normal;' + LineEnding +
    '} DataIn;' + LineEnding +

    'out vec4 OutColor;' + LineEnding +

    '$light.glsl' + LineEnding +

    'void main()' + LineEnding +
    '{' + LineEnding +
    '  OutColor = DataIn.Color;' + LineEnding +

    '  float cdummy = OutColor.a;' + LineEnding +

    '  OutColor = OutColor * Light(DataIn.Normal, DataIn.Position);' + LineEnding +
    '  OutColor.a = cdummy;' + LineEnding +
    '}';

begin
  inherited Create;

  ColorVetexData := TVBO_Triangles.Create;

  LightingShader := TLightingShader.Create([VertexShader, FragmentShader],light);

  with LightingShader do begin
    UniformID.ObjectMatrix := UniformLocation('ObjectMatrix');
    UniformID.CameraMatrix := UniformLocation('CameraMatrix');
  end;
end;

destructor TColorVAO.Destroy;
begin
  ColorVetexData.Free;
  inherited Destroy;
end;


procedure TColorVAO.WriteVertex;
begin
  inherited WriteVertex;
  ColorVetexData.LoadVertexBuffer(2);
end;

procedure TColorVAO.Draw;
var
  m: TMatrix;
begin
  LightingShader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;;
//    ObjectMatrix.Push;
    ObjectMatrix := WorldMatrix * ObjectMatrix;

    ObjectMatrix.Uniform(UniformID.ObjectMatrix);

    ObjectMatrix := CameraMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(UniformID.CameraMatrix);
    ObjectMatrix := m;
//    ObjectMatrix.Pop;
  end;

  inherited Draw;
end;

{ TColorTriangle }

procedure TColorTriangle.WriteVertex;
const
  Triangle: Tmat3x3 = ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  ColorTriangle: Tmat3x3 = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0));
begin
  FVertexdata.Pos.Add(Triangle);
  ColorVetexData.Add(ColorTriangle);

  inherited WriteVertex;
end;

end.
