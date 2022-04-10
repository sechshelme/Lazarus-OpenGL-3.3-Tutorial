<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>22 - Cubemap Texturen</h1></b>
    <b><h2>10 - Kugel</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>Textur Cube Map</b> hat man die Möglichkeit die Texturen auf einer Würfel-Fläche abzubilden.<br>
Ausser für den einfachen Würfel kann man dies auch für folgendes gebrauchen.<br>
* Hintergrund in einer 360° Optik.<br>
* Reflektionen auf einer Mesh.<br>
Man kann auch eine Kugel oder sonst eine komplizierte Mesh nehmen.<br>
<br>
Die Textur-Koordinaten sind 3D-Vektoren, welche auf die Position des Würfels zeigen,<br>
dabei ist nur die Richtung des Vektores wichtig, die Länge ist egal.<br>
<br>
Meistens sind Vertex und Texturkoordinaten gleich. Hier im Beispiel ein Würfel.<br>
<hr><br>
Die 6 Flächen des Würfels werden einzeln in VRAM geladen.<br>
Dies geschieht ähnlich, wie bei einer Textur-Array.<br>
<br>
Die sechs einelnen Bitmap heisen 1.xpm - 6.xpm .<br>
<pre><code>procedure TForm1.InitScene;
var
  bit: TPicture; // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin
    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    LoadFromFile('1.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('2.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('3.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('4.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('5.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('6.xpm');</font>
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);</font>
    Free; // Picture frei geben.
  end;</pre></code>
<hr><br>
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.<br>
<br>
<b>Vertex-Shader:</b><br>
Hier sieht man, das für die Textur und Vertex-Koordinaten die gleichen Werte genommen werden.<br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten</font>

uniform mat4 mat;

out vec3 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inPos;                           // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
Einzig Unterschied zu einer normalen Textur, das die Textur-Koordinaten 3D sind.<br>
<pre><code>#version 330</font>

in vec3 UV0;

uniform samplerCube Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture(Sampler, UV0);
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
