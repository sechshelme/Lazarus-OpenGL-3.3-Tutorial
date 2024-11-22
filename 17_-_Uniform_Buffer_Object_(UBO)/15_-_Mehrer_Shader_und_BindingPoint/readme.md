# 17 - Uniform Buffer Object (UBO)
## 15 - Mehrer Shader und BindingPoint

![image.png](image.png)

In diesem Beispiel wird gezeigt, was der **BindingPoint** für einen Einfluss hat.
Es werden 3 Shader erzeugt, das es einfacher ist, habe ich 3mal die gleichen Shader-Sourcen genommen.
Bei 2 Shadern werden die UBO-Daten mit dem **BindingPoint 0** verbunden, der einzelne Shader mit **BindingPoint** 1.

---
Es werden drei UNOs angelegt.
Die Uniform IDs werden füür jeden Shader einzeln ID gebraucht.
Daher habe ich es in einem Record zusammengefasst.

Man sieht auch, das 2 BindingPoints verwendet werden.

```pascal
var
  UBO: record
    Rubin, Jade, Smaragdgruen: GLuint;        // Puffer-Zeiger
  end;

  ShaderData: array[0..2] of record
    Shader: TShader;
    Material_ID,
    ModelMatrix_ID,
    Matrix_ID: GLint;
  end;

  bindingPoint0: gluint = 0;
  bindingPoint1: gluint = 1;
```

Es werden 3 Shader geladen in die Uniform-IDs ausgelesen.

```pascal
procedure TForm1.CreateScene;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    with ShaderData[i] do begin
      Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
      with Shader do begin
        UseProgram;
        Matrix_ID := UniformLocation('Matrix');
        ModelMatrix_ID := UniformLocation('ModelMatrix');

        Material_ID := UniformBlockIndex('Material'); // ID aus dem Shader holen.
      end;
    end;
  end;
```

Material-Daten in den UBO-Puffer laden und binden.

Man sieht, das beim Shader[2] ein anderer BindingPoint verwendet wird.

```pascal
procedure TForm1.InitScene;
begin
  // Puffer für Rubin anlegen.
  with Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Rubin);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Jade anlegen.
  with Material do begin
    ambient := vec3(0.14, 0.22, 0.16);
    diffuse := vec3(0.54, 0.89, 0.63);
    specular := vec3(0.32, 0.32, 0.32);
    shininess := 12.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Jade);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Puffer für Smaragdgruen anlegen.
  with Material do begin
    ambient := vec3(0.02, 0.17, 0.02);
    diffuse := vec3(0.08, 0.81, 0.08);
    specular := vec3(0.63, 0.73, 0.63);
    shininess := 76.8;
  end;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Smaragdgruen);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  // Verbindung mit dem Shader aufbauen.
  with ShaderData[0] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[1] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  end;

  with ShaderData[2] do begin
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint1);
  end;

  // Die Puffer das erste mal binden.
  // Das sieht man, das der Shader[2] mit Jade gebunden wird.
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint1, UBO.Jade);

```

Die Scene wird drei mal mit unterschiedlichen Shadern gezeichnet.
Um die UBO muss man da sich nicht kümmern, das diese mit dem BindingPoint gebunden sind.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(VBCube.VAO);

  d := 6.0;
  scal := 10;

  // --- Zeichne Kugeln

  with ShaderData[0] do begin
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

  with ShaderData[1] do begin
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d + 30, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  // --- Zeichne Kugeln

  with ShaderData[2] do begin
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d - 30, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
  end;

  ogc.SwapBuffers;
end;
```

Es wird nur der BindingPoint 0 geändert.
Somit sit man beim **Shader[2]** der mit **BindingPoint 1** gebunden ist keine Änderung.

```pascal
procedure TForm1.Timer2Timer(Sender: TObject);
const
  m: integer = 0;
begin
  case m of
    0: begin
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
    end;
    1: begin
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Smaragdgruen);
    end;
  end;

  Inc(m);
  if m > 1 then begin
    m := 0;
  end;
end;
```


---
Der Shader ist der selbe wie im ersten Beispiel.

**Vertex-Shader:**

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

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
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}

```


---
**Fragment-Shader**

```glsl
#version 330

// Licht
#define Lposition  vec3(35.0, 17.5, 35.0)
#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

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
  float angele = max(dot(nn, np), 0.0);
  if (angele > 0.0) {
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));
    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);
    diffuse  = vec3(0.0);
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void)
{
  outColor = vec4(Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);
}


```


