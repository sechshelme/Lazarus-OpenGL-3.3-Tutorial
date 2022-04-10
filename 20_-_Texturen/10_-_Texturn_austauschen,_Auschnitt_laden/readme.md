<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>10 - Texturn austauschen, Auschnitt laden</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Es ist möglich sehr schnell die Daten des Texturpuffers auszutauschen.<br>
Dies ist auch mit einem <b>Texturauschnitt</b> möglich.<br>
Dies geschieht mit <b>glTexSubImage2D(...</b>.<br>
<hr><br>
Big ist die Totalgrösse der Texturdaten.<br>
Small ist ein Auschnitt.<br>
<pre><code>const
  TextursizeBig = 256;</font>
  TextursizeSmall = 64;</font></pre></code>
3 Datenpuffer, welche sehr mit sehr einfachen Werten geladen werden.<br>
<pre><code>var
  TexturBig: packed array [0..TextursizeBig*TextursizeBig-1] of UInt32 ;</font>
  TexturSmall0, TexturSmall1: packed array [0..TextursizeSmall*TextursizeSmall-1]of UInt32;</font>
  textureID: GLuint;</pre></code>
Es werden sehr einfache Datenbuffer mit Daten befüllt.<br>
In der Praxis werden die Puffer meistens mit Bitmaps gefüllt.<br>
Der grosse Texturbuffer füllt die ganze Textur auf.<br>
Die kleinen Datenbuffer werden später zur Laufzeit abwechslungsweise geladen.<br>
<pre><code>procedure TForm1.InitScene;
var
  i: integer;
begin
  // Einfache Datenbuffer erzeugen.
  for i := 0 to TextursizeBig * TextursizeBig - 1 do begin</font>
    TexturBig[i] := i or $FF000000;</font>
  end;

  for i := 0 to TextursizeSmall * TextursizeSmall - 1 do begin</font>
    TexturSmall0[i] := i or $FF000000;</font>
    TexturSmall1[i] := (not i) or $FF000000;</font>
  end;

  // --- Texturbuffer erzeugen und anschliessend mit Daten der grossen Textur befüllen.

  glGenTextures(1, @textureID);</font>
  glBindTexture(GL_TEXTURE_2D, textureID);

  // Nur Speicher reservieren
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TextursizeBig, TextursizeBig, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  // Texturbuffer mit dem grossen Datenbuffer befüllen.
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, TextursizeBig, TextursizeBig, GL_RGBA, GL_UNSIGNED_BYTE, @TexturBig);</pre></code>
Ein Auschnitt der Textur wird zur Laufzeit abwechslungsweise ausgtauscht<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  step = 0.01;</font>
  z: integer = 1;</font>
begin
  if z > 10 then begin</font>
    glTexSubImage2D(GL_TEXTURE_2D, 0, 64, 64, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall0);
  end else begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 64, 64, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall1);
  end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten</font>
uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0         = inUV;
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
