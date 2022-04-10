<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>70 - Textur Array einzel Bitmap</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch in jedem Layer einzeln die Texturen laden.<br>
Der einzige Unterschied zum kompletten laden ist, man ladet die Texturen einzeln mit SubImage hoch.<br>
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.<br>
<hr><br>
Mit <b>glTexImage3D(...</b> wird nur der Speicher für die Texturen reserviert. Dabei muss man von Anfang an wissen, wie gross die Texturen sind.<br>
Mit <b>glTexSubImage3D(...</b> werden dann die Texturen Layer für Layer hochgeladen.<br>
Die sechs einzelnen Bitmap heisen 1.xpm - 6.xpm .<br>
<pre><code>procedure TForm1.InitScene;
const
  size = 8;      // Grösse der Texturen</font>
  anzLayer = 6;</font>
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
      LoadFromFile(IntToStr(i + 1) + '.xpm');   // Die Images laden.</font>

      // Texturen hoch laden
      glTexSubImage3D(GL_TEXTURE_2D_ARRAY, 0, 0, 0, i, Width, Height, 1, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    end;
    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);</font>
    Free; // Picture frei geben.
  end;</pre></code>
<hr><br>
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten</font>

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2DArray Sampler;
uniform int            Layer;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV0, Layer));
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
