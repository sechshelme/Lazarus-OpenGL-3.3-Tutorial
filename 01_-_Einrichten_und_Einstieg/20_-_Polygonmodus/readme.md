<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>20 - Polygonmodus</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Standartmässig stellt OpenGL Polygone flächenfüllend dar.<br>
Man kann aber die Polygone auch als Drahtgitter, oder nur die Eckpunkte als Punkte darstellen.<br>
<br>
Dies kann man mit <b>glPolygonMode(...</b> einstellen.<br>
Der Modus <b>GL_LINE</b> ist recht praktisch, wen man eine Mesh in der Entwicklungphase rendert, so kann man recht gut Renderfehler erkennen.<br>
<br>
Hinweis: Hier wird die TShader-Klasse verwendet, näheres dazu im Kapitel Shader.<br>
<hr><br>
Hier werden die verschiedenen Polygone-Modis eingestellt.<br>
Mit <b>glPolygonMode(...</b> und dem zweiten Parameter werden die verschiedenen Modis eingestellt.<br>
Dabei muss der erste Paramter immer <b>GL_FRONT_AND_BACK</b> sein, die beiden Parameter <b>GL_FRONT</b> und <b>GL_BACK</b> gehen mit OpenGL >= 3.3 nicht mehr.<br>
<b>glPolygonMode(...</b> kann auch bei DrawScene aufgerufen werden. ZB. wen man zwei Meshes hat, kann man die einte Fächenfüllend und die andere als Drahtgitter darstellen.<br>
<pre><code>procedure TForm1.MenuItemClick(Sender: TObject);
begin
  case TMainMenu(Sender).Tag of
    1: begin</font>
      glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);  // Punkte
    end;
    2: begin</font>
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
    end;
    3: begin</font>
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);   // Flächenfüllend
    end;
  end;
  ogc.Invalidate;   // Manuelle Aufruf von DrawScene.
end;</pre></code>
<hr><br>
Die Shader haben keinen Einfluss auf die Polygonmodis.<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>
layout (location = 0) in vec3 inPos;  // Vertex-Koordinaten</font>

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 1.0, 0.0, 1.0); // Gelb</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
