# 22 - Cubemap Texturen
## 05 - Umgebung

![image.png](image.png)

Mit **Textur Cube Map** hat man die Möglichkeit die Texturen auf einer Würfel-Fläche abzubilden.
Ausser für den einfachen Würfel kann man dies auch für folgendes gebrauchen.
* Hintergrund in einer 360° Optik.
* Reflektionen auf einer Mesh.
Man kann auch eine Kugel oder sonst eine komplizierte Mesh nehmen.

Die Textur-Koordinaten sind 3D-Vektoren, welche auf die Position des Würfels zeigen,
dabei ist nur die Richtung des Vektores wichtig, die Länge ist egal.

Meistens sind Vertex und Texturkoordinaten gleich. Hier im Beispiel ein Würfel.

---
Die 6 Flächen des Würfels werden einzeln in VRAM geladen.
Dies geschieht ähnlich, wie bei einer Textur-Array.

Die sechs einelnen Bitmap heisen 1.xpm - 6.xpm .

```pascal
procedure TForm1.InitScene;
var
  bit: TPicture; // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin
    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    LoadFromFile('1.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('2.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('3.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('4.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('5.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('6.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
    Free; // Picture frei geben.
  end;
```


---
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

**Vertex-Shader:**
Hier sieht man, das für die Textur und Vertex-Koordinaten die gleichen Werte genommen werden.

```glsl
#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 mat;
uniform mat4 rotmat;

out vec3 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
//  UV0 = inPos;                           // Textur-Koordinaten weiterleiten.
//  gl_Position = vec4(inPos, 1.0);
  UV0 = (rotmat * vec4(inPos, 1.0)).xyz;
}

```


---
**Fragment-Shader:**
Einzig Unterschied zu einer normalen Textur, das die Textur-Koordinaten 3D sind.

```glsl
#version 330

in vec3 UV0;

uniform samplerCube Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture(Sampler, UV0);
}

```


