<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>17 - Uniform Buffer Object (UBO)</h1></b>
    <b><h2>00 - Einfacher UBO</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurden alle Uniforms einzeln dem Shader übegeben.<br>
Wen man aber mehrer Werte übeergeben will, kann man die <b>Uniforms</b> zu einem <b>Block</b> zusammenfassen.<br>
Aus diesem Grund heisst dieser Puffer <b>Uniform</b> Buffer Object ( UBO ).<br>
<br>
Dies macht man mit einem Record. Dabei muss man auf eine <b>16Byte</b>-Ausrichtung achten.<br>
<br>
Die Material-Eigenschaften sind ein ideales Beispiel dafür.<br>
<br>
In diesem Beispiel sind die Kugeln aus Rubin.<br>
<hr><br>
Hier wird der Record für die Material-Eigenschaften deklariert.<br>
<br>
Da ein <b>TVector3f</b> nur <b>12Byte</b> hat, muss man zum Aufrunden auf <b>16Byte</b> noch ein Padding von 4Byte einfügen.<br>
Ein Float mit <b>4Byte</b> ist gut dafür gut geeignet.<br>
Im Shader-Code, muss dies bei den Uniform-Blöcken nicht beachtet werden.<br>
<br>
Bei Verwendung von einem <b>TVector4f</b>, braucht es kein Padding, da dieser 16Byte gross ist.<br>
<pre><code>type
  TMaterial = record
    ambient: TVector3f;      // Umgebungslicht
    pad0: GLfloat;           // padding 4Byte
    diffuse: TVector3f;      // Farbe
    pad1: GLfloat;           // padding 4Byte
    specular: TVector3f;     // Spiegelnd
    shininess: GLfloat;      // Glanz
  end;</pre></code>
So was geht leider <b>nicht</b>.<br>
Diffuse muss in den nächsten 16Byte-Block !<br>
<pre><code>type    // Unbrauchbare Deklaration !
  TMaterial = record
    ambient: TVector3f;      // 3Byte
    diffuse: TVector3f;      // 3Byte
    specular: TVector3f;     // 3Byte
    shininess: GLfloat;      // 3Byte
  end;</pre></code>
<br>
Generell wird für ein UBO ein Record empfohlen, mann könnte einen UBO-Buffer auch anders anlegen, zB. in eine Float-Array, dies macht aber wenig Sinn.<br>
Für einen <b>UBO</b> wird auch ein <b>Zeiger</b> auf den <b>Puffer</b> gebraucht, ähnlich eines Vertex-Puffers.<br>
Auch wird eine <b>ID</b> gebraucht, so wie es bei einfachen Uniforms der Fall ist.<br>
<pre><code>var
  UBO: GLuint;        // Puffer-Zeiger
  Material_ID: GLint; // ID im Shader</pre></code>
ID und Puffer generieren.<br>
Anstelle von <b>glUniformLocation(...</b>, muss man die ID mit <b>glUniformBlockIndex(...</b> auslesen.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');</font>
    ModelMatrix_ID := UniformLocation('ModelMatrix');</font>

    Material_ID := UniformBlockIndex('Material'); // UBO-Block ID aus dem Shader holen.</font>
  end;

  glGenVertexArrays(1, @VBCube.VAO);</font>

  glGenBuffers(1, @VBCube.VBOvert);</font>
  glGenBuffers(1, @VBCube.VBONormal);</font>

  glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.</pre></code>
Material-Daten in den UBO-Puffer laden und binden.<br>
Pro UBO-Block, wird ein BindingPoint gebraucht.<br>
Wobei, wen man in mehreren Shader die gleichen Daten laden will, kann man den gleichen BindingPoint verwenden, dazu später.<br>
<pre><code>procedure TForm1.InitScene;
var
  bindingPoint: gluint = 0; // Pro Verbindung wird ein BindingPoint gebraucht.</font>
begin
  // Material-Werte inizialisieren
  with mRubin do begin
    ambient := vec3(0.17, 0.01, 0.01);</font>
    diffuse := vec3(0.61, 0.04, 0.04);</font>
    specular := vec3(0.73, 0.63, 0.63);</font>
    shininess := 76.8;</font>
  end;


  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TMaterial), @mRubin, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);</pre></code>
Ein UBO muss am Ende wie andere Puffer auch frei gegeben werden.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);</font>
  glDeleteBuffers(1, @VBCube.VBOvert);</font>
  glDeleteBuffers(1, @VBCube.VBONormal);</font>
  glDeleteBuffers(1, @UBO);  // UBO löschen.</font></pre></code>
<hr><br>
Im Shader sind die Material-Daten zu einem Block zusammengefasst, ähnlich einem <b>struct</b> un <b>C++</b>.<br>
Im Shader wird kein Padding gebraucht.<br>
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
