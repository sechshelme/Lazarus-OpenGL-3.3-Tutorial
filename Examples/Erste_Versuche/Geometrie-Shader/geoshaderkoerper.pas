unit Geoshaderkoerper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dglOpenGL, oglShader, oglVector, oglMatrix, oglVBO, oglTextur, oglVAO;

type  { TGeoShaderKoerper }

  TGeoShaderKoerper = class(TBasisTriangleVAO)
  private
    Shader: TShader;
    ShaderID_textur: record
      WorldMatrix_id: GLint;
    end;
  protected
    Textur: record
      Face: TVBO_Triangles2D;
      Scaling: TVector2f;
    end;
  public
    constructor Create(light: boolean = True);
    destructor Destroy; override;
    procedure SetTexCoord(x, y: single);
    procedure WriteVertex;
    procedure Draw(TextBuffer: array of TTexturBuffer); overload;
  end;

implementation

{ TGeoShaderKoerper }

constructor TGeoShaderKoerper.Create(light: boolean);
const
  ia: array[0..7] of integer = (0, 1, 2, 3, 4, 5, 6, 7);
begin
  inherited Create;
  with Textur do begin
    Face := TVBO_Triangles2D.Create;
    Scaling := vec2(1.0, 1.0);
  end;

  Shader := TShader.Create([FileToStr('shader.glsl')]);

  with Shader, ShaderID_textur do begin
    WorldMatrix_id := UniformLocation('WorldMatrix');
    glUniform1iv(UniformLocation('myTextureSampler'), 8, ia);
  end;

end;

destructor TGeoShaderKoerper.Destroy;
begin
  inherited Destroy;
  Textur.Face.Free;
end;

procedure TGeoShaderKoerper.SetTexCoord(x, y: single); inline;
begin
  Textur.Scaling := vec2(x, y);
end;

procedure TGeoShaderKoerper.WriteVertex;
const
  Quad: array[0..11] of Tmat3x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

  QuadTextureVertex: array[0..11] of Tmat3x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));

begin
  with Textur do begin
    Face.Add(QuadTextureVertex);
    Face.Scale(Scaling);
  end;
  with
    FVertexdata do begin
    Pos.Add(Quad);
    Normal.Add(Quad);
    Normal.Modif([normalize]);
  end;

  inherited WriteVertex;

  Textur.Face.LoadVertexBuffer(10);
end;


procedure TGeoShaderKoerper.Draw(TextBuffer: array of TTexturBuffer);
var
  m: TMatrix;
begin
  Shader.UseProgram;

  with Camera do begin
    m := ObjectMatrix;
    ObjectMatrix := WorldMatrix * ObjectMatrix;
    ObjectMatrix.Uniform(ShaderID_textur.WorldMatrix_id);
    ObjectMatrix := m;
  end;

  TextBuffer[0].ActiveAndBind();

  inherited Draw;
end;

end.
