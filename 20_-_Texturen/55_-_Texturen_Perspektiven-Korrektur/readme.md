<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>55 - Texturen Perspektiven-Korrektur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Stellt man eine Textur auf einem Trapez dar, gibt es unschöne Verzerrungen, das sieht man beim Trapez Links gut.<br>
Die beiden Trapeze Rechts sind korrigiert, auf 2 verschiedene Varianten. Der Unterschied sieht man im Shader.<br>
<hr><br>
Es hat eine 2. Variante für die Textur-Koordinaten gegeben, welche einen Wert für eine Perspektivenkorrektur hat.<br>
Diese enthält einen Korrekturwert für die Perspektive.<br>
<pre><code>const
  // Koordinaten für Trapez.
  TrapezeVertex: array[0..5] of TVector3f =</font>
    ((-1.2, -0.8, 0.0), (0.4, 0.8, 0.0), (-0.4, 0.8, 0.0),</font>
    (-1.2, -0.8, 0.0), (1.2, -0.8, 0.0), (0.4, 0.8, 0.0));</font>

  // Normale unkorrigierte Textur-Koordinaten.
  TextureNormalVertex: array[0..5] of TVector2f =</font>
    ((-1.0, -1.0), (1.0, 1.0), (-1.0, 1.0),</font>
    (-1.0, -1.0), (1.0, -1.0), (1.0, 1.0));</font>

  // Textur-Koordinaten mit Perspektivenkorrektur.
  TexturePerspVertex1: array[0..5] of TVector3f =</font>
    ((-1.2, -0.8, 1.2), (0.4, 0.8, 0.4), (-0.4, 0.8, 0.4),</font>
    (-1.2, -0.8, 1.2), (1.2, -0.8, 1.2), (0.4, 0.8, 0.4));</font></pre></code>
Vertex-Daten hochladen, dies ist nichts besonderes, ausser, das für die Perspektivenkorrigierte Variante auch ein Vec3 ist.<br>
<pre><code>procedure TForm1.InitScene;
var
  pic: TPicture;
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);</font>

  glBindVertexArray(VBO_Trapeze.VAO);

  // Vektoren Trapez
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TrapezeVertex), @TrapezeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Unkorrigierte Textur-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[0]);</font>
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureNormalVertex), @TextureNormalVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Perspektivenkorrigiert Variante
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[1]);</font>
  glBufferData(GL_ARRAY_BUFFER, sizeof(TexturePerspVertex1), @TexturePerspVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);</font>
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);</pre></code>
Zeichnen der 3 verschiedenne Varianten.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;  // Textur binden.

  // Zeichne Unkorrigiert (Links)
  Shader.UseProgram;
  glUniform1i(Variante_ID, 0);</font>
  TransMatrix.Identity;
  TransMatrix.Translate(-1.2, 0.0, 0.0);</font>
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBO_Trapeze.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  // Zeichne korrigiert Variante 1 (Rechts Oben)
  glUniform1i(Variante_ID, 1);</font>
  TransMatrix.Identity;
  TransMatrix.Translate(1.2, 1.0, 0.0);</font>
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  // Zeichne korrigiert Variante 2 (Rechts Unten)
  glUniform1i(Variante_ID, 2);</font>
  TransMatrix.Identity;
  TransMatrix.Translate(1.2, -1.0, 0.0);</font>
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV0;    // Textur-Koordinaten</font>
layout (location = 11) in vec3 inUV1;</font>

uniform mat4 mat;

out Data {
  vec2 UV0;
  vec3 UV1;
} DataOut;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  DataOut.UV0 = inUV0;
  DataOut.UV1 = inUV1;
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in Data {
  vec2 UV0;
  vec3 UV1;
} DataIn;

uniform sampler2D Sampler; // Textursampler
uniform int variante;      // Variante der Texturberechnung

out vec4 FragColor;

void main()
{
  switch (variante) {

    // Unkorrigiert
    case 0: FragColor = texture( Sampler, DataIn.UV0 );
            break;

    // Korrigiert Variante 1
    case 1: FragColor = texture( Sampler, DataIn.UV1.xy / DataIn.UV1.z );
            break;

    // Korrigiert Variante 2
    case 2: FragColor = texture2DProj( Sampler, DataIn.UV1 );
  }
}
</pre></code>
<hr><br>
<b>mauer.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "8 8 2 1",</font>
  "  c #882222",</font>
  "* c #442222",</font>
  "********",
  "*   *   ",
  "*   *   ",
  "*   *   ",
  "********",
  "  *   * ",
  "  *   * ",
  "  *   * "
};
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
