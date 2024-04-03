unit Sprite;

{$mode objfpc}{$H+}
{$asmmode intel}

interface

uses
  Classes, SysUtils, Types, Graphics,
  oglglad_gl,
  oglMatrix, oglShader, oglColorKoerper, oglUnit,
  oglSteuerung, oglTextur, oglTexturKoerper, oglKoerper, oglBackGround;

type
  TMaske = array[0..15] of word;

  { TSprite }

  TSprite = class(TObject)
  private
    Mesh: TTexturRectangle;
    TexturBuffer: array of TTexturBuffer;
  public
    pos: TPointF;

    constructor Create(Maske: array of TMaske; col: cardinal);
    destructor Destroy; override;
  end;

  { TPacman }

  TPacman = class(TSprite)
  public
    constructor Create;

    procedure Draw;
  end;


  { TMampfer }

  TMampfer = class(TSprite)
  public
    constructor Create(col: cardinal);

    procedure Draw;
  end;

  { TLabyrintSprite }

  TLabyrintSprite = class(TSprite)
  public
    constructor Create(col: cardinal);
    procedure Draw(Element: integer);
  end;


implementation

function Spiegeln(q: word): word;
var
  x: word;
  i: integer;
begin
  Result := 0;
  for i := 0 to 15 do begin
    if (1 shl i) and q <> 0 then begin
      Result := Result or (1 shl (15 - i));
    end;
  end;
end;


{ TSprite }

constructor TSprite.Create(Maske: array of TMaske; col: cardinal);
var
  SpriteTextur: array[0..255] of GLenum;
  SpriteTextur8: array[0..255] of GLbyte;
  i, l, il: integer;
  b: word;

begin
  Mesh := TTexturRectangle.Create(1, False);
  Mesh.WriteVertex;

  l := Length(Maske);
  SetLength(TexturBuffer, l);
  for il := 0 to l - 1 do begin
    TexturBuffer[il] := TTexturBuffer.Create;

    with TexturBuffer[il] do begin
      for i := 0 to 255 do begin
        b := Maske[il][15 - i div 16];

        if b and ($1 shl (15 - (i mod 16))) > 0 then begin
          SpriteTextur[i] := $FF000000 or col;
          SpriteTextur8[i] := $07 shl 2;
        end else begin
          SpriteTextur[i] := $00000000;
          SpriteTextur8[i] := $00000000;
        end;
      end;
      TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_NEAREST);
      TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_NEAREST);

            LoadTextures(16, 16, SpriteTextur);
//      LoadTextures8Bit(16, 16, SpriteTextur8);
    end;
  end;

end;

destructor TSprite.Destroy;
var
  i: integer;
begin
  Mesh.Free;
  for i := 0 to Length(TexturBuffer) - 1 do begin
    TexturBuffer[i].Free;
  end;
  SetLength(TexturBuffer, 0);
  inherited Destroy;
end;

{ TPacman }

constructor TPacman.Create;
const
  PacmanMonoText: array[0..1] of TMaske = ((
    %0000001111000000,
    %0000111111110000,
    %0001111111111000,
    %0011111111111100,
    %0111111111111110,
    %0111111111111110,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %0111111111111110,
    %0111111111111110,
    %0011111111111100,
    %0001111111111000,
    %0000111111110000,
    %0000001111000000), (

    %0000001111000000,
    %0000111111110000,
    %0001111111111000,
    %0011111111110000,
    %0111111111100000,
    %0111111111000000,
    %1111111110000000,
    %1111111100000000,
    %1111111100000000,
    %1111111110000000,
    %0111111111000000,
    %0111111111100000,
    %0011111111110000,
    %0001111111111000,
    %0000111111110000,
    %0000001111000000));

begin
  inherited Create(PacmanMonoText, $00FFFF);
end;

procedure TPacman.Draw;
const
  posf = 55;
begin
  Mesh.Draw(TexturBuffer[abs(round(pos.x * posf)) mod Length(TexturBuffer)]);
end;


{ TMampfer }

constructor TMampfer.Create(col: cardinal);
const
  MapferMonoText: array[0..1] of TMaske = ((
    %0000111111110000,
    %0001111111111000,
    %0011111111111100,
    %0111100111001110,
    %1111100111001111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %0011001100110011,
    %0011001100110011), (

    %0000111111110000,
    %0001111111111000,
    %0011111111111100,
    %0111001110011110,
    %1111001110011111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1111111111111111,
    %1100110011001100,
    %1100110011001100));

begin
  inherited Create(MapferMonoText, col);
end;

procedure TMampfer.Draw;
const
  posf = 55;
begin
  Mesh.Draw(TexturBuffer[abs(round(pos.x * posf)) mod Length(TexturBuffer)]);
end;

{ TLabyrintSprite }

constructor TLabyrintSprite.Create(col: cardinal);
var
  LabyText: array[0..7] of TMaske;
  x, y: integer;
  w1, w2: word;
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  bit.SetSize(16, 16);
  bit.Canvas.Pen.Color := clRed;
  bit.Canvas.Pen.Width := 4;
  bit.Canvas.Ellipse(-13, -13, 13, 13);
  bit.Canvas.Ellipse(-5, -5, 5, 5);

  for y := 0 to 15 do begin
    w1 := 0;
    w2 := 0;
    for x := 0 to 15 do begin
      if (bit.Canvas.Pixels[x, y]) = clRed then begin
        w1 := w1 or (1 shl x);
        w2 := w2 or (1 shl (15 - x));
      end;
    end;
    LabyText[0, 15 - y] := w1;
    LabyText[1, 15 - y] := w2;
    LabyText[2, y] := w2;
    LabyText[3, y] := w1;
  end;

  bit.SetSize(0, 0);
  bit.SetSize(16, 16);
  bit.Canvas.Ellipse(-5, -5, 5, 5);
  bit.Canvas.Ellipse(-5, -5 + 16, 5, 5 + 16);
  bit.Canvas.Line(12, 0, 12, 15);


  for y := 0 to 15 do begin
    w1 := 0;
    w2 := 0;
    for x := 0 to 15 do begin
      if (bit.Canvas.Pixels[y, x]) = clRed then begin
        w1 := w1 or (1 shl x);
        w2 := w2 or (1 shl (15 - x));
      end;
    end;
    LabyText[4, 15 - y] := w1;
    //    LabyText[5, 15 - y] := w2;
    LabyText[6, y] := w2;
    //    LabyText[7, y] := w1;
  end;

  for y := 0 to 15 do begin
    w1 := 0;
    w2 := 0;
    for x := 0 to 15 do begin
      if (bit.Canvas.Pixels[x, y]) = clRed then begin
        w1 := w1 or (1 shl x);
        w2 := w2 or (1 shl (15 - x));
      end;
    end;
    //    LabyText[4, 15 - y] := w1;
    LabyText[5, 15 - y] := w2;
    //    LabyText[6, y] := w2;
    LabyText[7, y] := w1;
  end;

  bit.Free;

  inherited Create(LabyText, col);
end;

procedure TLabyrintSprite.Draw(Element: integer);
begin
  Mesh.Draw(TexturBuffer[Element]);
end;


end.
