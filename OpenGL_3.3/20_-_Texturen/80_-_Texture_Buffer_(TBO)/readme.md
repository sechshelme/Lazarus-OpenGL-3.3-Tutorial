# 20 - Texturen
## 80 - Texture Buffer (TBO)

![e image.png](e image.png)

Dies könnte man auch mit einer Array in Uniform lösen,
nur dort ist die Array-Grenze recht limitiert.

---

```pascal
const
  TriangleVector: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

  QuadVector: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

  TBOData: array of TVector3f = ((1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 0, 1), (1, 1, 0), (0, 1, 1));
```


```pascal
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  TBO_tex_ID := Shader.UniformLocation('sb');
  glUniform1i(TBO_tex_ID, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // --- VAO für Dreieck
  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);

  glGenBuffers(1, @VBTriangle.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // --- VAO für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // --- TBO
  glGenBuffers(1, @TBO);
  glBindBuffer(GL_TEXTURE_BUFFER, TBO);
  glBufferData(GL_TEXTURE_BUFFER, Length(TBOData) * SizeOf(TVector3f), PGLvoid(TBOData), GL_STATIC_DRAW);
  glGenTextures(1, @Textur_ID);
end;
```


```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // --- TBO
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_BUFFER, Textur_ID);
  glTexBuffer(GL_TEXTURE_BUFFER, GL_RGB32F, TBO);

  // --- Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // --- Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);

  ogc.SwapBuffers;
end;

```


---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 0) in vec3 inPos;

uniform samplerBuffer sb;

out vec4 Color;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = texelFetch(sb, gl_VertexID % 6);
}

```


---
**Fragment-Shader**

```glsl
#version 330

in vec4 Color;

out vec4 outColor;

void main(void)
{
  outColor = Color;
}

```


