<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>17 - Uniform Buffer Object (UBO)</h1></b>
    <b><h2>05 - UBO Zur Laufzeit aktualisieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
UBO-Daten können auch zur Laufzeit geändert/neu geladen werden, so wie es beim Vertex-Puffer auch geht.<br>
Auf diese Art, werden die Uniform-Daten aktualisiert. Dies ersetzt die Aktualisierung mit <b>glUniformxxx</b>.<br>
<br>
In diesem Beispiel wird das Material der Kugeln gewechselt, abwechslungsweise Rubin oder Jade.<br>
Dazu wird alle 1s die UBO-Daten aktualisiert.<br>
<hr><br>
Es werden zwei Materialien gebraucht, welche abwechslungsweise neu geladen werden.<br>
<pre><code>type
  TMaterial = record
    ambient: TVector3f;      // Umgebungslicht
    pad0: GLfloat;           // padding 4Byte
    diffuse: TVector3f;      // Farbe
    pad1: GLfloat;           // padding 4Byte
    specular: TVector3f;     // Spiegelnd
    shininess: GLfloat;      // Glanz
  end;

var
  mRubin, mJade: TMaterial;</pre></code>
Material-Daten in den UBO-Puffer laden und binden<br>
<pre><code>procedure TForm1.InitScene;
var
  bindingPoint: gluint = 0;</font>
begin
  // Material-Werte inizialisieren
  with mRubin do begin
    ambient := vec3(0.17, 0.01, 0.01);</font>
    diffuse := vec3(0.61, 0.04, 0.04);</font>
    specular := vec3(0.73, 0.63, 0.63);</font>
    shininess := 76.8;</font>
  end;

  with mJade do begin
    ambient := vec3(0.14, 0.22, 0.16);</font>
    diffuse := vec3(0.54, 0.89, 0.63);</font>
    specular := vec3(0.32, 0.32, 0.32);</font>
    shininess := 12.8;</font>
  end;

  // Speicher für UBO reservieren
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);

  // Timer manuell aufrufen, so das die ersten Daten in den UBO-kopiert werden.
  Timer2Timer(nil);</pre></code>
Hier sieht man gut, wie die UBO-Daten aktualisiert werden.<br>
Der Timer wird alle 1s aufgerufen.<br>
<pre><code>procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;</font>
begin
  case m of
    0: begin</font>
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TMaterial), @mRubin);
    end;
    1: begin</font>
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TMaterial), @mJade);
    end;
  end;

  Inc(m);
  if m > 1 then begin</font>
    m := 0;</font>
  end;
end;</pre></code>
<hr><br>
Der Shader ist der selbe wie im ersten Beispiel.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

// Licht
#define Lposition  vec3(35.0, 17.5, 35.0)</font>
#define Lambient   vec3(1.8, 1.8, 1.8)</font>
#define Ldiffuse   vec3(1.5, 1.5, 1.5)</font>

// Daten vom Vertex-Shader
in Data {
  vec3 Pos;
  vec3 Normal;
} DataIn;

layout (std140) uniform Material {
  vec3  Mambient;   // Umgebungslicht
  vec3  Mdiffuse;   // Farbe
  vec3  Mspecular;  // Spiegelnd
  float Mshininess; // Glanz
};

out vec4 outColor;

vec3 Light(in vec3 p, in vec3 n) {
  vec3 nn = normalize(n);
  vec3 np = normalize(p);
  vec3 diffuse;   // Licht
  vec3 specular;  // Reflektion
  float angele = max(dot(nn, np), 0.0);</font>
  if (angele > 0.0) {</font>
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));</font>
    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);</font>
    diffuse  = vec3(0.0);</font>
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void)
{
  outColor = vec4(Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);</font>
}

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
