<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>17 - Uniform Buffer Object (UBO)</h1></b>
    <b><h2>10 - Mehrer UBO</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch von Anfang an, mehrere UBOs anlegen und somit kann man sehr schnell zwischen den Datenblöcken umschalten.<br>
<hr><br>
Es werden drei UBOs angelegt.<br>
ID im Shader wird nur eine gebraucht.<br>
<pre><code>var
  UBO: record
    Rubin, Jade, Smaragdgruen: GLuint;        // Puffer-Zeiger
  end;
  Material_ID: GLint; // ID im Shader</pre></code>
Der BindingPoint muss global deklariert werden, da er fürs Binden im Timer auch gebraucht wird.<br>
<pre><code>var
  bindingPoint: gluint = 0;</font></pre></code>
ID und Puffer generieren.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');</font>
    ModelMatrix_ID := UniformLocation('ModelMatrix');</font>

    Material_ID := UniformBlockIndex('Material'); // ID aus dem Shader holen.</font>
  end;

  glGenVertexArrays(1, @VBCube.VAO);</font>

  glGenBuffers(1, @VBCube.VBOvert);</font>
  glGenBuffers(1, @VBCube.VBONormal);</font>

  glGenBuffers(3, @UBO);          // Die 3 UB0-Puffer generieren.</font></pre></code>
Material-Daten in den UBO-Puffer laden und binden.<br>
Da die UBO-Daten im VRAM abgelegt sind, kann man gut für die verschiedenen Puffer einfach die Material-Daten überschreiben.<br>
Dies ist gleich wie bei den Vertex-Pufferen.<br>
<pre><code>procedure TForm1.InitScene;
begin
  // Puffer für Rubin anlegen.
  with Material do begin
    ambient := vec3(0.17, 0.01, 0.01);</font>
    diffuse := vec3(0.61, 0.04, 0.04);</font>
    specular := vec3(0.73, 0.63, 0.63);</font>
    shininess := 76.8;</font>
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Rubin);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Jade anlegen.
  with Material do begin
    ambient := vec3(0.14, 0.22, 0.16);</font>
    diffuse := vec3(0.54, 0.89, 0.63);</font>
    specular := vec3(0.32, 0.32, 0.32);</font>
    shininess := 12.8;</font>
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Jade);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Smaragdgruen anlegen.
  with Material do begin
    ambient := vec3(0.02, 0.17, 0.02);</font>
    diffuse := vec3(0.08, 0.81, 0.08);</font>
    specular := vec3(0.63, 0.73, 0.63);</font>
    shininess := 76.8;</font>
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Smaragdgruen);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Verbindung mit dem Shader aufbauen.
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);

  // Timer manuell aufrufen, so das die ersten Daten in den UBO-kopiert werden.
  Timer2Timer(nil);</pre></code>
Für die verscheidenen Materialien, wir einfach nur ein anderer UBO über den Bindingpoint mit dem Shader verbunden.<br>
<pre><code>procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;</font>
begin
    case m of
      0: begin</font>
        glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO.Rubin);
      end;
      1: begin</font>
        glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO.Jade);
      end;
      2: begin</font>
        glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO.Smaragdgruen);
      end;
    end;

  Inc(m);
  if m > 2 then begin</font>
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
