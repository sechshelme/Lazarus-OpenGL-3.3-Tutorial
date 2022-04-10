<!DOCTYPE html>
<html>
    <b><h1>25 - Framepuffer</h1></b>
    <b><h2>00 - In Textur rendern</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Eine Scene kann man auch in eine Textur rendern, anstelle des Bildschirmes.<br>
Man kann dies auch gebrauchen, wen man eine Scene bei einem Autorennen in einen Rückspiegel rendern will.<br>
<hr><br>
Deklaration der Vertexkonstanten des Quadrates, welches in die Textur gerendert wird.<br>
Es ist ein Quadrat mit 4 verschieden farbigen Ecken.<br>
<pre><code><b><font color="0000BB">const</font></b>

  <i><font color="#FFFF00">// --- Vectoren</font></i>
  QuadVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> Tmat3x3 =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));

  <i><font color="#FFFF00">// --- Farben</font></i>
  QuadColor: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> Tmat3x3 =
    (((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)));</pre></code>
Koordinanten des Würfels, auf dem die Texturen abgebidet werden, auf dem ein drehendes Rechteck abgebildet ist.<br>
Der Würfel braucht Texturkoordinaten.<br>
<pre><code><b><font color="0000BB">const</font></b>

  <i><font color="#FFFF00">// --- Vectoren</font></i>
  CubeVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">11</font>] <b><font color="0000BB">of</font></b> Tmat3x3 =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    <i><font color="#FFFF00">// oben</font></i>
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    <i><font color="#FFFF00">// unten</font></i>
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)));

  <i><font color="#FFFF00">// --- Texturkoordinaten</font></i>
  CubeTextureVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">11</font>] <b><font color="0000BB">of</font></b> Tmat3x2 =
    (((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)));</pre></code>
Grösse der Textur, auf welcher das Quadrat gerendert wird.<br>
<pre><code><b><font color="0000BB">const</font></b>
  TexturSize = <font color="#0077BB">2048</font>;</pre></code>
Das es 2 Scenen und Meshes gibt, werden die Vectorbuffer und die Matrix für die Bewegung doppelt gebraucht.<br>
Beim Quadrat wird der 2. VBO für die Farben gebraucht, beim Würfel für die Texturkoordinaten.<br>
<pre><code><b><font color="0000BB">var</font></b>
  <i><font color="#FFFF00">// ID der Textur.</font></i>
  textureID: GLuint;

  <i><font color="#FFFF00">// Renderpuffer</font></i>
  FramebufferName, depthrenderbuffer: GLuint;</pre></code>
Erzeugen der Puffer, Shader und Matrizen, eigentlich nichts besonderes.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>

  <i><font color="#FFFF00">// Vertex Puffer erzeugen.</font></i>
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex_Col);

  glGenVertexArrays(<font color="#0077BB">1</font>, @VBCube.VAO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBCube.VBOVertex);
  glGenBuffers(<font color="#0077BB">1</font>, @VBCube.VBOTex_Col);

  <i><font color="#FFFF00">// Shader des Quadrates</font></i>
  <b><font color="0000BB">with</font></b> Quad_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader := TShader.Create([FileToStr(<font color="#FF0000">'quad.vert'</font>), FileToStr(<font color="#FF0000">'quad.frag'</font>)]);
    <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      UseProgram;

      WorldMatrix_id := UniformLocation(<font color="#FF0000">'Matrix'</font>);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// Shader des Würfels.</font></i>
  <b><font color="0000BB">with</font></b> Cube_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader := TShader.Create([FileToStr(<font color="#FF0000">'cube.vert'</font>), FileToStr(<font color="#FF0000">'cube.frag'</font>)]);
    <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      UseProgram;
      glUniform1i(UniformLocation(<font color="#FF0000">'Sampler0'</font>), <font color="#0077BB">0</font>);

      WorldMatrix_id := UniformLocation(<font color="#FF0000">'Matrix'</font>);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;

  CubeWorldMatrix.Identity;
  QuadWorldMatrix.Identity;
<b><font color="0000BB">end</font></b>;</pre></code>
Die Vertexkoordinaten laden, auch nichts besonderes.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  QuadWorldMatrix.Scale(<font color="#0077BB">2</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// --- Quadrat</font></i>
  <b><font color="0000BB">with</font></b> Quad_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBQuad.VAO);

    <i><font color="#FFFF00">// Vertexkoordinaten</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(<font color="#0077BB">0</font>);
    glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

    <i><font color="#FFFF00">// Farben</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex_Col);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
    glEnableVertexAttribArray(<font color="#0077BB">1</font>);
    glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// --- Würfel</font></i>
  <b><font color="0000BB">with</font></b> Cube_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBCube.VAO);

    <i><font color="#FFFF00">// Vertexkoordinaten</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(<font color="#0077BB">0</font>);
    glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

    <i><font color="#FFFF00">// Texturkoordinaten</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTex_Col);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeTextureVertex), @CubeTextureVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(<font color="#0077BB">10</font>);
    glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  <b><font color="0000BB">end</font></b>;</pre></code>
Das erzeugen der Textur ist sehr ähnlich einer normalen Textur, der grosse Unterschied, anstelle eines Pointer auf die Texturdaten,<br>
gibt man nur <b>nil</b> mit, da man nur einee leere Textur braucht.<br>
<pre><code>
  <i><font color="#FFFF00">// ------------ Texturen erzeugenn --------------</font></i>

  <i><font color="#FFFF00">// --- Textur</font></i>

  glGenTextures(<font color="#0077BB">1</font>, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGBA, TexturSize, TexturSize, <font color="#0077BB">0</font>, GL_RGBA, GL_UNSIGNED_BYTE, <b><font color="0000BB">nil</font></b>);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
</pre></code>
Hier wird die Textur mit dem Render/FrameBuffer gekoppelt.<br>
<pre><code>
  <i><font color="#FFFF00">// Frame Puffer erzeugen.</font></i>
  glGenFramebuffers(<font color="#0077BB">1</font>, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  <i><font color="#FFFF00">// Render Puffer erzeugen.</font></i>
  glGenRenderbuffers(<font color="#0077BB">1</font>, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  <i><font color="#FFFF00">// Die Textur mit dem Framebuffer koppeln</font></i>
  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID, <font color="#0077BB">0</font>);
<b><font color="0000BB">end</font></b>;</pre></code>
Hier sieht man wie zuerst in den Framebuffer gerendert wird, und anschiessend normal in den Bildschirmpuffer.<br>
Das Rendern läuft fast gleich ab, egal in welchen Puffer gerendert wird.<br>
Der einzige markante Unterschied, beim Bildschirmpuffer muss man am Ende <b>SwapBuffers</b> ausführen.<br>
Noch ein Hinweis, bei FramePuffer, ist der 4. Parameter von <b>glClearColor(...</b> relevant.<br>
Wen Alphablending aktiviert ist, kann der Hintergrund des Framepuffer auch transparent sein.<br>
Beim Bildschirmpuffer hat dieser keinen Einfluss.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>

  <i><font color="#FFFF00">// --- In den Texturpuffer render.</font></i>

  <b><font color="0000BB">with</font></b> Quad_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b> <i><font color="#FFFF00">// Quadrat</font></i>

    <i><font color="#FFFF00">// FramePuffer aktivieren.</font></i>
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

    glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
    glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);
    glViewport(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>, TexturSize, TexturSize);

    Shader.UseProgram;
    glBindVertexArray(VBQuad.VAO);

    QuadWorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex) * <font color="#0077BB">3</font>);
  <b><font color="0000BB">end</font></b>;


  <i><font color="#FFFF00">//  --- Normal auf den Bildschirm rendern.</font></i>

  <b><font color="0000BB">with</font></b> Cube_Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>  <i><font color="#FFFF00">// Würfel</font></i>

    <i><font color="#FFFF00">// BildschirmPuffer mit "0" aktivieren.</font></i>
    glBindFramebuffer(GL_FRAMEBUFFER, <font color="#0077BB">0</font>);

    glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
    glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);
    glViewport(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>, ClientWidth, ClientHeight);

    glBindTexture(GL_TEXTURE_2D, textureID);

    Shader.UseProgram;
    glBindVertexArray(VBCube.VAO);

    CubeWorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TriangleS, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>);

    ogc.SwapBuffers;
  <b><font color="0000BB">end</font></b>;

<b><font color="0000BB">end</font></b>;</pre></code>
Zum Schluss alle Puffer frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Timer1.Enabled := <b><font color="0000BB">False</font></b>;

  <i><font color="#FFFF00">// Frame Puffer und Textur frei geben.</font></i>
  glDeleteFramebuffers(<font color="#0077BB">1</font>, @FramebufferName);
  glDeleteRenderbuffers(<font color="#0077BB">1</font>, @depthrenderbuffer);
  glDeleteTextures(<font color="#0077BB">1</font>, @textureID);

  <i><font color="#FFFF00">// Vertex Puffer frei geben.</font></i>
  glDeleteVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex_Col);

  glDeleteVertexArrays(<font color="#0077BB">1</font>, @VBCube.VAO);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBCube.VBOVertex);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBCube.VBOTex_Col);

  <i><font color="#FFFF00">// Shader frei geben.</font></i>
  Quad_Shader.Shader.Free;
  Cube_Shader.Shader.Free;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Die Shader sind sehr einfach, der Shader des Quadrates muss nur ein farbige Polygone ausgeben.<br>
Der Shader des Würfels, gibt Texturen aus.<br>
<br>
<b>Vertex-Shader Quadrat:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> vertexUV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = vertexUV0;
}

</pre></code>
<hr><br>
<b>Fragment-Shader Quadrat:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler0;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler0, UV0 );
}
</pre></code>
<hr><br>
<b>Vertex-Shader Würfel:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> Col;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Col = inCol;
}
</pre></code>
<hr><br>
<b>Fragment-Shader Würfel:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Col;
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

</html>
