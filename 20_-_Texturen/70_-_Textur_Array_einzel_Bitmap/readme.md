# 20 - Texturen
## 70 - Textur Array einzel Bitmap

<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch in jedem Layer einzeln die Texturen laden.
Der einzige Unterschied zum kompletten laden ist, man ladet die Texturen einzeln mit SubImage hoch.
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.
<hr><br>
Mit <b>glTexImage3D(...</b> wird nur der Speicher für die Texturen reserviert. Dabei muss man von Anfang an wissen, wie gross die Texturen sind.
Mit <b>glTexSubImage3D(...</b> werden dann die Texturen Layer für Layer hochgeladen.
Die sechs einzelnen Bitmap heisen 1.xpm - 6.xpm .

```pascal
procedure TForm1.InitScene;
const
  size = 8;      // Grösse der Texturen
  anzLayer = 6;
var
  i: integer;
  bit: TPicture; // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin

    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    // Speicher reservieren
    glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGB, size, size, anzLayer, 0, GL_BGR, GL_UNSIGNED_BYTE, nil);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    for i := 0 to anzLayer - 1 do begin

      // Bitmap von HD laden.
      LoadFromFile(IntToStr(i + 1) + '.xpm');   // Die Images laden.

      // Texturen hoch laden
      glTexSubImage3D(GL_TEXTURE_2D_ARRAY, 0, 0, 0, i, Width, Height, 1, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    end;
    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
    Free; // Picture frei geben.
  end;
```

<hr><br>
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}

```

<hr><br>
<b>Fragment-Shader:</b>

```glsl
#version 330

in vec2 UV0;

uniform sampler2DArray Sampler;
uniform int            Layer;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV0, Layer));
}

```


