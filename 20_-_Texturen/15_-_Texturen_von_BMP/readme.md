# 20 - Texturen
## 15 - Texturen von BMP

![image.png](image.png)

In der Praxis liegen die Texturen meisten als Bitmap, auf der Festplatte.
Hier wird gezeigt, wie man eine 24Bit BMP als Textur lädt.
---
Der Unterschied zur Konstante, das man die Bitmap noch laden muss, und anschliessend einen Zeiger darauf <b>glTexImage2D(...</b> mit gibt.
Man kann auch eine Bitmap selbst über Canvas zeichnen.

Das es sich hier um eine BMP-Datei handelt, kann man diese direkt mit <b>TBitmap</b> laden.

Anstelle von TBitmap kann man auch TPicture verwenden. Was sehr wichtig ist, man muss wissen in welchen Format die Bitmap gespeichert ist.
Je nach dem in welchen Format die Bitmap vorliegt, müssen die Parameter in <b>glTexImage2D(...</b> angepasst werden.
In diesen Beispiel sind es die Konstanten <b>GL_RGB</b> und <b>GL_BGR</b>.

Wen man eine Bitmap mit der Unit <b>oglTextur</b> lädt, werden diese Parameter automatisch angepasst.

Unterumständen könnte es noch exotische Formate geben, welche (noch) nicht unterstützt werden.
Bei einem Fehler bitte im DGL-Forum melden, evt. kann man es dann noch anpassen. ;-)

```pascal
procedure TForm1.InitScene;
var
  bit: TBitmap;                  // Bei anderen Formaten TPicture.
begin
  bit := TBitmap.Create;         // Bitmap erzeugen.
  with bit do begin
    LoadFromFile('mauer.bmp');   // BMP in Bitmap laden.

    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, RawImage.Data); // Zeiger auf Bitmap übergeben.
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glBindTexture(GL_TEXTURE_2D, 0);

    Free;                        // Bitmap frei geben.
  end;
```

---
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

---
<b>Fragment-Shader:</b>

```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}

```


