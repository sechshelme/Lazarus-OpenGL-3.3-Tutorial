unit Baum;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  oglMatrix, oglTextur, oglTexturVAO;

type

  { TBaum }

  TBaum = class(TMultiTexturVAO)
  public
    procedure WriteVertex;
  end;


implementation

{ TBaum }

procedure TBaum.WriteVertex;
const
  Rectangle: array [0..1] of Tmat3x3 =
    (((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));
  TextureVertex: array [0..1] of Tmat3x2 =
    (((0.0, 1.0), (1.0, 0.0), (0.0, 0.0)),
    ((0.0, 1.0), (1.0, 1.0), (1.0, 0.0)));
var
  i: integer;
begin
  for i := 0 to 3 do begin
    Textur.TexCoord.Add(TextureVertex);
  end;
  with FVertexdata do begin
    for i := 0 to 3 do begin
      Pos.Add(Rectangle);
      Pos.RotateB(Pi / 2);
    end;
  end;

  inherited WriteVertex;
end;

end.
