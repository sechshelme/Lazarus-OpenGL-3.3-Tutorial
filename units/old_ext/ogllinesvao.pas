unit oglLinesVAO;

{$mode objfpc}{$H+}{ TLinesVAO }

interface

uses
  Classes, SysUtils,
  {$ifdef GLES32}
  oglglad_GLES32,
  {$else}
  oglglad_gl,
  {$endif}
  oglShader,oglVector, oglMatrix, oglVBO, oglVAO;

type

  { TLinesVAO }

  TLinesVAO = class(TVAO)
  protected
    LineBuffer: TVBO_LineStrip;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const v: TVector3f);
    procedure WriteVertex;
  end;

  { TColorLinesVAO }

  TColorLinesVAO = class(TLinesVAO)
  private
    Shader: TShader;
    CameraMatrix_id: GLint;
  protected
    ColorBuffer: TVBO_LineStrip;
  public
    constructor Create(light: boolean = True);
    destructor Destroy; override;

    procedure Add(const v, c: TVector3f);
    procedure WriteVertex;

    procedure draw;
  end;


implementation

{ TLinesVAO }

constructor TLinesVAO.Create;
begin
  inherited Create(GL_LINE_STRIP);

  Caption := 'Lines_Strip';

  LineBuffer := TVBO_LineStrip.Create;
end;

destructor TLinesVAO.Destroy;
begin
  LineBuffer.Free;

  inherited Destroy;
end;

procedure TLinesVAO.Add(const v: TVector3f);
begin
  LineBuffer.Add(v);
end;

procedure TLinesVAO.WriteVertex;
begin
  BindVertexArray;

  Vertex_Count := LineBuffer.LoadVertexBuffer(0);
end;


{ TColorLinesVAO }

constructor TColorLinesVAO.Create(light: boolean);
const
  ColorShader =
    '$vertex' +  LineEnding +
    '#version 330' +  LineEnding +

    'layout (location = 0) in vec3 inPos;' +  LineEnding +
    'layout (location = 2) in vec4 inColor;' +  LineEnding +

    'uniform mat4 Matrix;' +  LineEnding +

    'out vec4 Color;' +  LineEnding +

    'void main(void)' +  LineEnding +
    '{' +  LineEnding +
    '  gl_Position = Matrix * vec4(inPos, 1.0);' +  LineEnding +
    '  Color = inColor;' +  LineEnding +
    '}' +  LineEnding +

    '$fragment' +  LineEnding +
    '#version 330' +  LineEnding +

    'in vec4 Color;' +  LineEnding +

    'out vec4 FragColor;' +  LineEnding +

    'void main()' +  LineEnding +
    '{' +  LineEnding +
    '  FragColor = Color;' +  LineEnding +
    '}';

begin
  inherited Create;

  ColorBuffer := TVBO_LineStrip.Create;

  Shader := TShader.Create([ColorShader]);
  with Shader do begin
    UseProgram;
    CameraMatrix_id := UniformLocation('Matrix');
  end;
end;

destructor TColorLinesVAO.Destroy;
begin
  Shader.Free;
  ColorBuffer.Free;

  inherited Destroy;
end;

procedure TColorLinesVAO.Add(const v, c: TVector3f);
begin
  inherited Add(v);
  ColorBuffer.Add(c);
end;

procedure TColorLinesVAO.WriteVertex;
begin
  inherited WriteVertex;
  ColorBuffer.LoadVertexBuffer(2);
end;

procedure TColorLinesVAO.draw;
var
  m: TMatrix;
begin
  Shader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;;
    ObjectMatrix := CameraMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(CameraMatrix_id);
    ObjectMatrix := m;
  end;

  inherited Draw;
end;


end.
