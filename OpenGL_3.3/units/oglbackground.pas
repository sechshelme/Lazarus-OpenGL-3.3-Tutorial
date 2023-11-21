unit oglBackground;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dglOpenGL,
  oglVector, oglMatrix, oglVBO, oglTextur,oglTexturVAO;

type

  { TBackGround }

  TBackGround = class(TMultiTexturVAO)
  public
    constructor Create(anzTextures: integer; Lighting: boolean=False);
    procedure WriteVertex(Xscale: GLfloat=1.0; Yscale: GLfloat=1.0);
    procedure Draw(TexturBuffer: array of TTexturBuffer);
  end;


implementation

{ TBackGround }

constructor TBackGround.Create(anzTextures: integer; Lighting: boolean);
begin
  inherited Create(anzTextures, Lighting);
  Caption := 'BackGround';
  Color := vec4(0.1, 0.3, 0.1, 1.0);
end;

procedure TBackGround.WriteVertex(Xscale : GLfloat = 1.0; Yscale: GLfloat = 1.0);
const
  Rectangle: array [0..1] of Tmat3x3 = (
    ((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));
  Tex: array [0..1] of Tmat3x2 = (
    ((0.0, 1.0), (1.0, 0.0), (0.0, 0.0)),
    ((0.0, 1.0), (1.0, 1.0), (1.0, 0.0)));
begin
  with Textur do begin
    TexCoord.Add(Tex);
    TexCoord.Scale(Xscale, Yscale);
    //    TexCoord.Rotate(Pi/4);
  end;

  with FVertexdata do begin
    Pos.Add(Rectangle);
    Pos.Translate(vec3(0.0, 0.0, -0.9999));
  end;

  inherited WriteVertex;
end;

procedure TBackGround.Draw(TexturBuffer: array of TTexturBuffer);
var
  dummy: boolean;
  m: TMatrix;
begin
  dummy := Camera.Enabled;
  Camera.Enabled := False;
  with Camera do begin
    m := ObjectMatrix;
    ObjectMatrix.Identity;
    inherited Draw(TexturBuffer);
    ObjectMatrix := m;
  end;
  Camera.Enabled := dummy;
end;

end.
