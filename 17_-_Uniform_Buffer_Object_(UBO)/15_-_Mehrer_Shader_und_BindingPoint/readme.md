<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>17 - Uniform Buffer Object (UBO)</h1></b>
    <b><h2>15 - Mehrer Shader und BindingPoint</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In diesem Beispiel wird gezeigt, was der <b>BindingPoint</b> für einen Einfluss hat.<br>
Es werden 3 Shader erzeugt, das es einfacher ist, habe ich 3mal die gleichen Shader-Sourcen genommen.<br>
Bei 2 Shadern werden die UBO-Daten mit dem <b>BindingPoint 0</b> verbunden, der einzelne Shader mit <b>BindingPoint</b> 1.<br>
<hr><br>
Es werden drei UNOs angelegt.<br>
Die Uniform IDs werden füür jeden Shader einzeln ID gebraucht.<br>
Daher habe ich es in einem Record zusammengefasst.<br>
<br>
Man sieht auch, das 2 BindingPoints verwendet werden.<br>
<pre><code>var
  UBO: record
    Rubin, Jade, Smaragdgruen: GLuint;        // Puffer-Zeiger
  end;

  ShaderData: array[0..2] of record</font>
    Shader: TShader;
    Material_ID,
    ModelMatrix_ID,
    Matrix_ID: GLint;
  end;

  bindingPoint0: gluint = 0;</font>
  bindingPoint1: gluint = 1;</font></pre></code>
Es werden 3 Shader geladen in die Uniform-IDs ausgelesen.<br>
<pre><code>procedure TForm1.CreateScene;
var
  i: integer;
begin
  for i := 0 to 2 do begin</font>
    with ShaderData[i] do begin
      Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
      with Shader do begin
        UseProgram;
        Matrix_ID := UniformLocation('Matrix');</font>
        ModelMatrix_ID := UniformLocation('ModelMatrix');</font>

        Material_ID := UniformBlockIndex('Material'); // ID aus dem Shader holen.</font>
      end;
    end;
  end;</pre></code>
Material-Daten in den UBO-Puffer laden und binden.<br>
<br>
Man sieht, das beim Shader[2] ein anderer BindingPoint verwendet wird.<br>
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
  with ShaderData[0] do begin</font>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[1] do begin</font>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[2] do begin</font>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint1);
  end;

  // Die Puffer das erste mal binden.
  // Das sieht man, das der Shader[2] mit Jade gebunden wird.
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint1, UBO.Jade);
</pre></code>
Die Scene wird drei mal mit unterschiedlichen Shadern gezeichnet.<br>
Um die UBO muss man da sich nicht kümmern, das diese mit dem BindingPoint gebunden sind.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(VBCube.VAO);

  d := 6.0;</font>
  scal := 10;</font>

  // --- Zeichne Kugeln

  with ShaderData[0] do begin</font>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  // --- Zeichne Kugeln

  with ShaderData[1] do begin</font>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d + 30, d, d);</font>
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  // --- Zeichne Kugeln

  with ShaderData[2] do begin</font>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d - 30, d, d);</font>
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  ogc.SwapBuffers;
end;</pre></code>
Es wird nur der BindingPoint 0 geändert.<br>
Somit sit man beim <b>Shader[2]</b> der mit <b>BindingPoint 1</b> gebunden ist keine Änderung.<br>
<pre><code>procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;</font>
begin
  case m of
    0: begin</font>
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
    end;
    1: begin</font>
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Smaragdgruen);
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
