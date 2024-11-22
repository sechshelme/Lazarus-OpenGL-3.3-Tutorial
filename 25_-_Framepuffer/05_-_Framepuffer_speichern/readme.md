# 25 - Framepuffer
## 05 - Framepuffer speichern

![image.png](image.png)

Wen man in eine Textur rendert, hat man die Möglichkeit, den Inhalt der Textur in eine Datei zu speichern.

---
Die Textur, in dem die Scene gerendert wurde, kann man auch abspeichern.
Hinweis: Das Bild kann evtl. fehlerhaft abgespeichert werden, da dies OS abhängig ist.
Dieser Code wurde unter Linux 64Bit getestet.
Die **TBitmap** muss 32Bit sein, 24Bit wird nicht unterstützt.

```pascal
procedure TForm1.ButtonTexturSaveClick(Sender: TObject);
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  with Picture.Bitmap do begin
    PixelFormat := pf32bit;  // 32-Bit erzwingen
    Width := TexturSize;
    Height := TexturSize;
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glReadPixels(0, 0, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, RawImage.Data);
  end;
  Picture.SaveToFile('textur.png');
  Picture.Free;
end;
```

Es ist auch möglich, die komplett gerenderte Scene zu speichern.
Leider steht das Bild auf dem Kopf. Die Ursache ist, bei einer Bitmap ist der Nullpunkt links-oben, bei OpenGL links/unten.
Dies kann man aber umgehen, wen man Zeile für Zeile einliest.
**glBindFramebuffer(GL_FRAMEBUFFER, 0);** ist nur notwendig, wen man mehrere Framebuffer verwendet.

```pascal
procedure TForm1.ButtonScreenSaveClick(Sender: TObject);
var
  Picture: TPicture;
  i: integer;
begin
  Picture := TPicture.Create;
  with Picture.Bitmap do begin
    PixelFormat := pf32bit;               // 32-Bit erzwingen
    Width := ogc.Width;
    Height := ogc.Height;
    glBindFramebuffer(GL_FRAMEBUFFER, 0); // Screen

    for i := 0 to Height - 1 do begin
      glReadPixels(0, Height - i - 1, Width, Height - i, GL_RGBA, GL_UNSIGNED_BYTE, ScanLine[i]);
    end;
  end;
  Picture.SaveToFile('screen.png');
  Picture.Free;
end;
```


---
Die Shader sind sehr einfach, der Shader des Quadrates muss nur ein farbige Polygone ausgeben.
Der Shader des Würfels, gibt Texturen aus.

**Vertex-Shader Quadrat:**


```glsl
#version 330

layout (location =  0) in vec3 inPos;
layout (location = 10) in vec2 vertexUV0;

uniform mat4 Matrix;

out vec2 UV0;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0 = vertexUV0;
}


```


---
**Fragment-Shader Quadrat:**


```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler0;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler0, UV0 );
}

```


---
**Vertex-Shader Würfel:**


```glsl
#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;

uniform mat4 Matrix;

out vec3 Col;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Col = inCol;
}

```


---
**Fragment-Shader Würfel:**


```glsl
#version 330

in vec3 Col;
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Col, 1.0);
}

```


