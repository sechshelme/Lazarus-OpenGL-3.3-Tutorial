unit oglFontTextur;

{$mode objfpc}{$H+}

interface

{$include opts.inc}
uses
{$IFDEF COREGL}
glcorearb,
{$ELSE}
dglOpenGL,
{$ENDIF}
  Classes,
  SysUtils, TypInfo, LCLType, LazUTF8,LConvEncoding,
  Graphics, IntfGraphics, GraphType,
  Dialogs,
  oglVAO,
  BGRABitmap, BGRABitmapTypes, BGRAGradientScanner,
  oglShader, oglLightingShader,
  oglMatrix, oglVBO, oglTextur;

type

  { TFontTextur }

  TFontTextur = class(TBasisTriangleVAO)
  private
    TexturBuffer: TTexturBuffer;

    Color: record
      Front, Back, Gradient1, Gradient2: TBGRAPixel;
    end;

    CharTab: record
      min, max: integer
    end;

    anzChar: integer;
    CharPos: array of record
      QuadVec: record
        Scale: single;
      end;
      TexVec: record
        Scale, Translate: GLfloat;
      end;
    end;

    UniformID: record
      Transforms, ObjectMatrix, CameraMatrix: GLint;
    end;
    TexturFace: TVBO_Triangles2D;
  protected
  public
    Font: TFont;
    gradient: boolean;
    constructor Create(light: boolean = True);
    destructor Destroy; override;
    procedure WriteVertex;
    procedure Draw(Text: string); overload;

    procedure SetFontColor(AColor: TBGRAPixel);
    procedure SetBKColor(AColor: TBGRAPixel);
    procedure SetGradientColor(AColor1, AColor2: TBGRAPixel);
  end;

implementation

constructor TFontTextur.Create(light: boolean = True);
const
  Vert_Shader =
    '  #version 330' + LineEnding +

    '  layout (location = 0) in vec3 inPos;' + LineEnding +
    '  layout (location = 1) in vec3 inNormal;' + LineEnding +
    '  layout (location = 10) in vec2 inVertexUV;' + LineEnding +

    '  out Data {' + LineEnding +
    '    vec3 Position;' + LineEnding +
    '    vec3 Normal;' + LineEnding +
    '    vec2 UV;' + LineEnding +
    '  } DataOut;' + LineEnding +

    '  uniform mat4 ObjectMatrix;' + LineEnding +
    '  uniform mat4 CameraMatrix;' + LineEnding +
    '  uniform vec4 Transforms;' + LineEnding +

    '  void main()' + LineEnding +
    '  {' + LineEnding +
    '    vec4 p = vec4(inPos, 1.0);' + LineEnding +

    '    p.x = p.x * Transforms[0] + Transforms[1];' + LineEnding +

    '    gl_Position = CameraMatrix * p;' + LineEnding +
    '    DataOut.UV = inVertexUV;' + LineEnding +
    '    DataOut.UV.x = DataOut.UV.x * Transforms[2] + Transforms[3];' + LineEnding +

    '    DataOut.Position = vec3(ObjectMatrix * vec4(inPos, 1.0));' + LineEnding +
    '    DataOut.Normal = normalize(mat3(ObjectMatrix) * inNormal);' + LineEnding +
    '  }';

  Frag_Shader =
    '  #version 330' + LineEnding +

    '  in Data {' + LineEnding +
    '    vec3 Position;' + LineEnding +
    '    vec3 Normal;' + LineEnding +
    '    vec2 UV;' + LineEnding +
    '  } DataIn;' + LineEnding +

    '  out vec4 OutColor;' + LineEnding +
    '  uniform sampler2D myTextureSampler;' + LineEnding +

    '  $light.glsl' + LineEnding +

    '  void main() {' + LineEnding +
    '    OutColor = texture( myTextureSampler, DataIn.UV );' + LineEnding +
    '    float cdummy = OutColor.a;' + LineEnding +
    '    OutColor = OutColor * Light(DataIn.Normal, DataIn.Position);' + LineEnding +
    '    OutColor.a = cdummy;' + LineEnding +
    '  }';

begin
  inherited Create;
  LightingShader := TLightingShader.Create([Vert_Shader, Frag_Shader], light);

  TexturFace := TVBO_Triangles2D.Create;

  with LightingShader, UniformID do begin
    UseProgram;
    ObjectMatrix := UniformLocation('ObjectMatrix');
    CameraMatrix := UniformLocation('CameraMatrix');
    Transforms := UniformLocation('Transforms');
  end;

  with CharTab do begin
    min := 32;
    max := 127;
    min := 0;
    max := 255;
  end;
  anzChar := CharTab.max - CharTab.min + 1;

  gradient := False;

  Font := TFont.Create;
  with Font do begin
    //Charset := OEM_CHARSET;
    //Color := $000000;
    //Height := 0;
    //Name := 'Terminal';
    //Pitch := fpDefault;
    //Size := 8;
    //Style := [];
  end;

  with Color do begin
    Front := BGRA($FF, $FF, $FF);
    Back := BGRA($00, $00, $00, $00);
    Gradient1 := BGRA(255, 255, 0);
    Gradient2 := BGRA(255, 0, 0);
  end;

  TexturBuffer := TTexturBuffer.Create;
end;

destructor TFontTextur.Destroy;
begin
  TexturFace.Free;

  LightingShader.Free;
  TexturBuffer.Free;
  Font.Free;

  inherited Destroy;
end;

procedure TFontTextur.WriteVertex;
var
  BGRABitmap: TBGRABitmap;
  BGRAGradientScanner: TBGRAGradientScanner;

  sizey: integer;
  w, i: integer;
  c: String;
  maxWidth: integer;

  TexturPos: array of record
    Width, Left: integer;
  end;

const
  Rectangle: array [0..1] of Tmat3x3 = (
    ((0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 0.0)),
    ((0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 1.0, 0.0)));
  TextureVertex: array [0..1] of Tmat3x2 = (
    ((0.0, 1.0), (1.0, 0.0), (0.0, 0.0)),
    ((0.0, 1.0), (1.0, 1.0), (1.0, 0.0)));

begin

  anzChar := CharTab.max - CharTab.min + 1;
  SetLength(TexturPos, anzChar + 1);
  SetLength(CharPos, anzChar + 1);

  BGRABitmap := TBGRABitmap.Create;

  BGRABitmap.FontName := Font.Name;
  BGRABitmap.FontStyle := Font.Style;
  BGRABitmap.FontQuality := fqSystemClearType;
  BGRABitmap.FontHeight := -Font.Height;

  BGRABitmap.FontAntialias := False;

  TexturPos[0].Left := 0;
  maxWidth := 0;

  for i := 0 to anzChar - 1 do begin
    c := CP437ToUTF8(Char(i + CharTab.min));

    w := BGRABitmap.TextSize(c).cx;
    TexturPos[i].Width := w;
    if TexturPos[i].Width > maxWidth then begin
      maxWidth := TexturPos[i].Width;
    end;

    TexturPos[i + 1].Left := w + TexturPos[i].Left;
  end;

  sizey := BGRABitmap.FontFullHeight;

  BGRABitmap.SetSize(TexturPos[anzChar].Left, sizey);

  BGRABitmap.Fill(Color.Back);

  if gradient then begin
    BGRAGradientScanner := TBGRAGradientScanner.Create(Color.Gradient1, Color.Gradient2, gtLinear, PointF(0, 0), PointF(0, sizey), True, True);
  end;
  for i := 0 to anzChar - 1 do begin
    if gradient then begin
      BGRABitmap.TextOut(TexturPos[i].Left, 0, CP437ToUTF8(Char(i + CharTab.min)), BGRAGradientScanner);
    end else begin
      BGRABitmap.TextOut(TexturPos[i].Left, 0, CP437ToUTF8(Char(i + CharTab.min)), Font.Color);
    end;

    with CharPos[i] do begin
      with QuadVec do begin
        Scale := 1.0 / maxWidth * TexturPos[i].Width;
      end;
      with TexVec do begin
        Translate := TexturPos[i].Left / (TexturPos[Length(TexturPos) - 1].Left);
        Scale := 1 / BGRABitmap.Width * TexturPos[i].Width;
      end;
    end;

  end;
  if gradient then begin
    BGRAGradientScanner.Free;
  end;

  TexturBuffer.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  TexturBuffer.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_NEAREST);

//    BGRABitmap.SaveToFile('test.bmp');
  TexturBuffer.LoadTextures(BGRABitmap.Bitmap.RawImage);

  BGRABitmap.Free;

  with TexturFace do begin
    Add(TextureVertex);
  end;
  with FVertexdata do begin
    Pos.Add(Rectangle);
  end;

  inherited WriteVertex;

  TexturFace.LoadVertexBuffer(10);
end;


procedure TFontTextur.Draw(Text: string);
var
  i: integer;
  CharIndex: integer;
  cursor: single;

begin
  TexturBuffer.ActiveAndBind;

  LightingShader.UseProgram;

  Text := UTF8ToCP437(Text);

  cursor := 0.0;

  for i := 0 to Length(Text) - 1 do begin
    CharIndex := byte(Text[i + 1]) - CharTab.min;

    if byte(Text[i + 1]) in [CharTab.min..CharTab.max] then begin  // Ist Zeichen gültig ?
      with CharPos[CharIndex] do begin
        glUniform4f(UniformID.Transforms, QuadVec.Scale, cursor, TexVec.Scale, TexVec.Translate);
        cursor += QuadVec.Scale;
      end;

      with Camera do begin
        ObjectMatrix.Push;
        ObjectMatrix.Multiply(WorldMatrix, ObjectMatrix);

        ObjectMatrix.Uniform(UniformID.ObjectMatrix);

        ObjectMatrix.Multiply(CameraMatrix, ObjectMatrix);
        ObjectMatrix.Uniform(UniformID.CameraMatrix);
        ObjectMatrix.Pop;
      end;

      inherited Draw;
    end;
  end;
end;

procedure TFontTextur.SetFontColor(AColor: TBGRAPixel);
begin
  Color.Front := AColor;
end;

procedure TFontTextur.SetBKColor(AColor: TBGRAPixel);
begin
  Color.Back := AColor;
end;

procedure TFontTextur.SetGradientColor(AColor1, AColor2: TBGRAPixel);
begin
  Color.Gradient1 := AColor1;
  Color.Gradient2 := AColor2;
end;


end.
