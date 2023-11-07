# 02 - Shader
## 45 - Variablen Namen auslesen

![e image.png](e image.png)

Es ist auch möglich aus dem **Shader auszulesen**, welche Variablen dort verwendet werden.
In diesem Beispiel werden **Attribut**, **Uniform** und **Uniform-Blöcke** ausgelesen.
Für was man **Uniform-Blöcke** verwendet, wird in einem späteren Kapitel behandelt.
Auch die Beleuchtung, etc. wird später behandelt.

---
Mit **glGetProgramiv(...** wird ermittelt, wie viele Variablen dieses Typen hat.
Mit **glGetActiveAttrib(...** wird der Bezeichner der Variable ausgelesen. Typ gibt die Art der Variable an, zB. **vec3**, **mat4**, etc.
Der komplexe Beleuchtungs-Shader wird später beschrieben.

```pascal
procedure TForm1.MenuItem1Click(Sender: TObject);
var
  s: array of PChar = nil;
  i, Count: GLint;
  Typ: GLint = 0;
  len: GLint = 0;
  size: GLint = 0;
  sl: TStringList;

begin
  sl := TStringList.Create;

  sl.Add('Attribute:');
  SetLength(s, 255);
  glGetProgramiv(Shader.ID, GL_ACTIVE_ATTRIBUTES, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveAttrib(Shader.ID, i, Length(s), len, size, Typ, PChar(s));
    sl.Add('  ' + PChar(s) + '    ' + IntToStr(size));
  end;
  sl.Add('');

  sl.Add('Uniform:');
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORMS, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveUniform(Shader.ID, i, Length(s), len, size, Typ, PChar(s));
    sl.Add('  ' + PChar(s) + '    ' + IntToStr(size));
  end;
  sl.Add('');

  sl.Add('Uniform-Blöcke:');
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @Count);
  for i := 0 to Count - 1 do begin
    glGetActiveUniformBlockName(Shader.ID, i, Length(s), nil, PChar(s));
    sl.Add('  ' + PChar(s));
  end;

  ShowMessage(sl.Text);
  sl.Free;
end;
```

Details zum Uniform-Block

```pascal
procedure TForm1.MenuItem2Click(Sender: TObject);
var
  maxUniLength, activeUnif, dataSize, actualLen, BlockCount: TGLint;
  BlockName: array of char = nil;
  UniformName: array of char = nil;
  indices: array of TGLint = nil;
  indice: GLint;

  UniformInfo: record
    offset: TGLuint;
    size: TGLuint;
    type_: TGLuint;
    matrix_strides: TGLuint;
    array_strides: TGLuint;
      end;

  i, k: integer;
  s: string;

  SL: TStringList;

begin
  SL := TStringList.Create;

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  // --- Uniform-Blöcke auslesen
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_MAX_LENGTH, @maxUniLength);
  SetLength(UniformName, maxUniLength);
  SL.Add('Uniform Blöcke:');
  SL.Add('');

  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @BlockCount);
  SL.Add('Block Uniform Count: ' + BlockCount.ToString);

  for i := 0 to BlockCount - 1 do begin
    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_NAME_LENGTH, @actualLen);
    //    Write('len: ', actualLen);
    SetLength(BlockName, actualLen);
    glGetActiveUniformBlockName(Shader.ID, i, actualLen, nil, PChar(BlockName));
    SL.Add('  Block-Name: ' + PChar(BlockName));

    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_DATA_SIZE, @dataSize);
    SL.Add('    Data-Size: ' + dataSize.ToString);

    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS, @activeUnif);
    SL.Add('    Uniforms/Block: ' + activeUnif.ToString);

    SetLength(indices, activeUnif);
    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES, PGLint(indices));

    for k := 0 to activeUnif - 1 do begin
      indice := indices[k];
      glGetActiveUniformName(Shader.ID, indice, maxUniLength, @actualLen, PChar(UniformName));
      SL.Add('      Uniform-Name: ' + PChar(UniformName));

      with UniformInfo do begin
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_OFFSET, @offset);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_SIZE, @size);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_TYPE, @type_);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_ARRAY_STRIDE, @array_strides);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_MATRIX_STRIDE, @matrix_strides);

        WriteStr(s, '          indicie: ', indice: 4, ' ofs: ', offset: 4, ' Array_Size: ', size: 4, ' Size: ', size * TypeSize(type_): 4, ' type:', type_: 6, '  array_strides: ', array_strides: 4, ' mat_strides: ', matrix_strides: 4);
        SL.Add(s);
        SL.Add('');
      end;
    end;
  end;
  ShowMessage(SL.Text);
  SL.Free;
end;

```


---
Hier wurde noch eine Variable **KeineVerwendung** deklariert, da diese von Compiler wegoptimiert wurde, wird so auch nicht aufgelistet.

**Vertex-Shader:**

```glsl
#version 330

// Attribute
layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

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
  float test[8];
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


