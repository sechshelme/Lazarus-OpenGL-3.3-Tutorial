# 20 - Texturen
## 85 - Float Textur

![image.png](image.png)

Es ist auch möglich eine Textur als Float-Array zu übergeben.

---

```pascal

```

Textur als Float

```pascal
const
  Textur32_0: array of TVector4f = ((1.0, 0.0, 0.0, 1.0), (0.0, 1.0, 0.0, 1.0), (0.0, 0.0, 1.0, 1.0), (1.0, 0.0, 0.0, 1.0));
```

Bei **glTexImage2D(...** muss **GL_FLOAT** angegeben werden.

```pascal
procedure TForm1.InitScene;
begin
  // Textur binden.
  glBindTexture(GL_TEXTURE_2D, textureID);

  // Textur laden.
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_FLOAT, PVector4f(Textur32_0));

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glBindTexture(GL_TEXTURE_2D, 0);
```


---
**Vertex-Shader:**

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
**Fragment-Shader:**

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


