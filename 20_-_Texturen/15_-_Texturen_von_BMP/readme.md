<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>15 - Texturen von BMP</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In der Praxis liegen die Texturen meisten als Bitmap, auf der Festplatte.<br>
Hier wird gezeigt, wie man eine 24Bit BMP als Textur lädt.<br>
<hr><br>
Der Unterschied zur Konstante, das man die Bitmap noch laden muss, und anschliessend einen Zeiger darauf <b>glTexImage2D(...</b> mit gibt.<br>
Man kann auch eine Bitmap selbst über Canvas zeichnen.<br>
<br>
Das es sich hier um eine BMP-Datei handelt, kann man diese direkt mit <b>TBitmap</b> laden.<br>
<br>
Anstelle von TBitmap kann man auch TPicture verwenden. Was sehr wichtig ist, man muss wissen in welchen Format die Bitmap gespeichert ist.<br>
Je nach dem in welchen Format die Bitmap vorliegt, müssen die Parameter in <b>glTexImage2D(...</b> angepasst werden.<br>
In diesen Beispiel sind es die Konstanten <b>GL_RGB</b> und <b>GL_BGR</b>.<br>
<br>
Wen man eine Bitmap mit der Unit <b>oglTextur</b> lädt, werden diese Parameter automatisch angepasst.<br>
<br>
Unterumständen könnte es noch exotische Formate geben, welche (noch) nicht unterstützt werden.<br>
Bei einem Fehler bitte im DGL-Forum melden, evt. kann man es dann noch anpassen. ;-)<br>
<pre><code>procedure TForm1.InitScene;
var
  bit: TBitmap;                  // Bei anderen Formaten TPicture.
begin
  bit := TBitmap.Create;         // Bitmap erzeugen.
  with bit do begin
    LoadFromFile('mauer.bmp');   // BMP in Bitmap laden.</font>

    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, RawImage.Data); // Zeiger auf Bitmap übergeben.
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glBindTexture(GL_TEXTURE_2D, 0);</font>

    Free;                        // Bitmap frei geben.
  end;</pre></code>
<hr><br>
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

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
