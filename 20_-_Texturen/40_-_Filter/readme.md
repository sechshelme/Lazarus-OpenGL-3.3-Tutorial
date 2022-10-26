# 20 - Texturen
## 40 - Filter

![image.png](image.png)

Hier wird gezeigt, wie man Filter für Texturen verwenden kann.
In diesem Beispiel wird nur eine Texturen geladen, aber es werden mehrere Filter verwendet.

Die Filter verstellt man mit <b>glTexParameter(...</b>.
---
Hier wird die Textur geladen und der Filter <b>MIN_FILTER</b> festgelegt, welcher für alle Ausgaben gültig ist.

```pascal
procedure TForm1.InitScene;
var
  pic: TPicture;

begin
  pic := TPicture.Create;
  with pic do begin
    LoadFromFile('bild.xpm');

    // Textur laden
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    // Globaler Filter
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glBindTexture(GL_TEXTURE_2D, 0);
    Free;
  end;
```

Bei dem Filter <b>GL_CLAMP_TO_BORDER</b> kann man noch eine Hintergrundfarbe festlegen.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
// Hintergrundfarbe für Clamp_to_Border, ein Dunkelgrün.
const
  border: array[0..3] of GLfloat = (0.0, 0.3, 0.0, 1.0);
var
  ProdMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);
  glBindTexture(GL_TEXTURE_2D, textureID);  // Textur binden.

  // Links-Oben
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-0.5, 0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Rechts-Oben
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_BORDER_COLOR, @border);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(0.5, 0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Links-Unten
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-0.5, -0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Rechts-Unten
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(0.5, -0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
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
  UV0 = inUV;                           // Texur-Koordinaten weiterleiten.
}

```

---
<b>Fragment-Shader:</b>


```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
    FragColor = texture( Sampler, UV0 );
}

```

---
<b>bild.xpm</b>


```glsl
/* XPM */
static char *XPM_mauer[] = {
  "8 8 6 1",
  "  c #882222",
  "* c #FFFFFF",
  "r c #FF0000",
  "g c #00FF00",
  "b c #0000FF",
  "y c #00FFFF",
  "r******g",
  "*rr**gg*",
  "*rr**gg*",
  "********",
  "********",
  "*bb**yy*",
  "*bb**yy*",
  "b******y"
};

```


