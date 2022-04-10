<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>45 - Alpha-Textur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Texturen werden erst richtig interessant, wen noch der Alpha-Kanal verwendet wird.<br>
Wie hier im Beispiel ein Baum.<br>
<b>Hinweis:</b> Das Z-Bufferproblem, wie bei einfachen Alphablending muss bei Alphatexturen auch beachtet werden. Siehe [[Lazarus_-_OpenGL_3.3_Tutorial#Alpha_Blending|Alphablending]].<br>
<hr><br>
Wichtig ist, das man OpenGL mitteilt, das man Alpha-Blending will.<br>
<pre><code>procedure TForm1.InitScene;
begin
  Textur.LoadTextures('baum.png');</font>
  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.</pre></code>
<hr><br>
Die Shader sehen gleich aus, wie bei einer einfachen Textur.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
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
