<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>45 - Variablen Namen auslesen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Es ist auch möglich aus dem <b>Shader auszulesen</b>, welche Variablen dort verwendet werden.<br>
In diesem Beispiel werden <b>Attribut</b>, <b>Uniform</b> und <b>Uniform-Blöcke</b> ausgelesen.<br>
Für was man <b>Uniform-Blöcke</b> verwendet, wird in einem späteren Kapitel behandelt.<br>
Auch die Beleuchtung, etc. wird später behandelt.<br>
<hr><br>
Mit <b>glGetProgramiv(...</b> wird ermittelt, wie viele Variablen dieses Typen hat.<br>
Mit <b>glGetActiveAttrib(...</b> wird der Bezeichner der Variable ausgelesen. Typ gibt die Art der Variable an, zB. <b>vec3</b>, <b>mat4</b>, etc.<br>
Der komplexe Beleuchtungs-Shader wird später beschrieben.<br>
<pre><code>procedure TForm1.MenuItem1Click(Sender: TObject);
var
  s: ansistring;
  i, Count, len, size, Typ: integer;
  sl: TStringList;

begin
  sl := TStringList.Create;

  sl.Add('Attribute:');</font>
  SetLength(s, 255);</font>
  glGetProgramiv(Shader.ID, GL_ACTIVE_ATTRIBUTES, @Count);
  for i := 0 to Count - 1 do begin</font>
    glGetActiveAttrib(Shader.ID, i, 255, len, size, Typ, @s[1]);
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;
  sl.Add('');</font>

  sl.Add('Uniform:');</font>
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORMS, @Count);
  for i := 0 to Count - 1 do begin</font>
    glGetActiveUniform(Shader.ID, i, 255, len, size, Typ, @s[1]);
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;
  sl.Add('');</font>

  sl.Add('Uniform-Blöcke:');</font>
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @Count);
  for i := 0 to Count - 1 do begin</font>
    glGetActiveUniformBlockName(Shader.ID, i, 255, @len, @s[1]);</font>
    sl.Add(copy(s, 0, len) + '    ' + IntToStr(Typ));
  end;

  ShowMessage(sl.Text);
  sl.Free;
end;</pre></code>
<hr><br>
Hier wurde noch eine Variable <b>KeineVerwendung</b> deklariert, da diese von Compiler wegoptimiert wurde, wird so auch nicht aufgelistet.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

// Attribute
layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

// Uniform-Variablen
uniform mat4 ModelMatrix;
uniform mat4 Matrix;
uniform vec4 KeineVerwendung; // Wird nicht angezeigt, da nicht verwendet.

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

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

in Data {
  vec3 Pos;
  vec3 Normal;
} DataIn;

// Der Uniform-Block
layout(std140) uniform Material {
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
