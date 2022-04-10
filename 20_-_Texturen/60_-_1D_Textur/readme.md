<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>60 - 1D Textur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die meisten Texturen sind eine Bitmap(Foto) welche im 2D-Format vorliegen.<br>
Es gibt aber noch 1D und 3D-Texturen. Dieses Beispiel zeigt die Anwendung einer 1D-Textur.<br>
Eine 1D-Textur kann man sich am besten als eine farbige Linie vorstellen.<br>
<hr><br>
Die Texturkoordinaten sind nun keine Vectorenarray mehr sondern nur eine einfache Float-Array.<br>
<pre><code>const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0), (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));</font>

  TextureVertex: array[0..5] of GLfloat =</font>
    (0.0, 3.0, 0.0, 0.0, 3.0, 3.0);</pre></code>
Eine Einfache 1D-Textur mit 5 Pixeln.<br>
<pre><code>const
  Textur24: packed array[0..4, 0..2] of byte =</font>
    (($FF, $00, $00), ($00, $FF, $00), ($00, $00, $FF), ($FF, $FF, $00), ($FF, $FF, $FF));</font></pre></code>
Generieren des Texturbuffers.<br>
Dies geschieht gleich wie bei der normalen 2D-Textur.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  glGenTextures(1, @textureID);  // Erzeugen des Textur-Puffer.</font></pre></code>
Beim laden muss man bei den Textur-Befehlen beachten, das man <b>GL_TEXTURE_1D</b> nimmt.<br>
Beim VertexAttribut wird für die Textur-Koordinaten nur eine Float-Array übergeben.<br>
<pre><code>procedure TForm1.InitScene;
begin
  // Textur binden.
  glBindTexture(GL_TEXTURE_1D, textureID);

  // Textur laden.
  glTexImage1D(GL_TEXTURE_1D, 0, GL_RGB, 5, 0, GL_RGB, GL_UNSIGNED_BYTE, @Textur24);

  // Ein minimalst Filter aktivieren, ansonsten bleibt die Ausgabe schwarz.
  glTexParameterf(GL_TEXTURE_1D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Textur entbinden.
  glBindTexture(GL_TEXTURE_1D, 0);</font>

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // Vektorkoordinaten
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Nur eine Float-Array
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 1, GL_FLOAT, False, 0, nil);
end;</pre></code>
Das Zeichnen ist nichts besonderes.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // Textur binden.
  glBindTexture(GL_TEXTURE_1D, textureID);

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));</font>

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Man beachte, das die UV-Koordinaten nur ein <b>Float</b> ist.<br>
<pre><code>#version 330</font>

layout (location =  0) in vec3  inPos;   // Vertex-Koordinaten</font>
layout (location = 10) in float inUV;    // Textur-Koordinaten als Float-Array</font>

uniform mat4 mat;

out float UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in float UV0;

uniform sampler1D Sampler;              // Ein 1D-Sampler

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // UV0 ist nur ein Float.
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
