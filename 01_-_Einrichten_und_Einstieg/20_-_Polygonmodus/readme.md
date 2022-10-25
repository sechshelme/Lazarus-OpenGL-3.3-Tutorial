# 01 - Einrichten und Einstieg
## 20 - Polygonmodus

<img src="image.png" alt="Selfhtml"><br><br>
Standartmässig stellt OpenGL Polygone flächenfüllend dar.
Man kann aber die Polygone auch als Drahtgitter, oder nur die Eckpunkte als Punkte darstellen.

Dies kann man mit <b>glPolygonMode(...</b> einstellen.
Der Modus <b>GL_LINE</b> ist recht praktisch, wen man eine Mesh in der Entwicklungphase rendert, so kann man recht gut Renderfehler erkennen.

Hinweis: Hier wird die TShader-Klasse verwendet, näheres dazu im Kapitel Shader.
<hr><br>
Hier werden die verschiedenen Polygone-Modis eingestellt.
Mit <b>glPolygonMode(...</b> und dem zweiten Parameter werden die verschiedenen Modis eingestellt.
Dabei muss der erste Paramter immer <b>GL_FRONT_AND_BACK</b> sein, die beiden Parameter <b>GL_FRONT</b> und <b>GL_BACK</b> gehen mit OpenGL >= 3.3 nicht mehr.
<b>glPolygonMode(...</b> kann auch bei DrawScene aufgerufen werden. ZB. wen man zwei Meshes hat, kann man die einte Fächenfüllend und die andere als Drahtgitter darstellen.

```pascal
procedure TForm1.MenuItemClick(Sender: TObject);
begin
  case TMainMenu(Sender).Tag of
    1: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);  // Punkte
    end;
    2: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
    end;
    3: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);   // Flächenfüllend
    end;
  end;
  ogc.Invalidate;   // Manuelle Aufruf von DrawScene.
end;
```

<hr><br>
Die Shader haben keinen Einfluss auf die Polygonmodis.
<b>Vertex-Shader:</b>

```glsl
#version 330
layout (location = 0) in vec3 inPos;  // Vertex-Koordinaten

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```

<hr><br>
<b>Fragment-Shader:</b>

```glsl
#version 330

out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 1.0, 0.0, 1.0); // Gelb
}

```


