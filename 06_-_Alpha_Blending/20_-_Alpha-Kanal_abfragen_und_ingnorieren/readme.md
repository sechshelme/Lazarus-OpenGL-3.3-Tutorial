<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>06 - Alpha Blending</h1></b>
    <b><h2>20 - Alpha-Kanal abfragen und ingnorieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bei Texturen mit Alphablending gibt es noch eine einfacher Variante als sortieren.<br>
Voraus gesetzt der Alphakanal ist voll transparent.<br>
<br>
Wen es transparent ist, wird einfach kein Pixel gezeichnet und dadurch wird auch der Z-Buffer nicht aktualisiert.<br>
Dies spielt sich im FragmentShader ab.<br>
<hr><br>
Es empfieht sich trotzdem immer die Objecte mit Alpha-Blending zum Schluss zu zeichnen.<br>
Aber es muss nicht mehr sortiert werden.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);

var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);        // Frame und Tiefen-Puffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  // --- Zeichne Boden
  SandTextur.ActiveAndBind;                                   // Boden-Textur binden
  Matrix.Identity;
  Matrix.Translate(0.0, 1.0, 0.0);</font>
  Matrix.Scale(10.0);</font>
  Matrix.RotateA(Pi / 2);</font>

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                                  // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));          // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]);                        // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));</font>
  end;

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten</font>

out vec2 UV0;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  UV0         = inUV;                 // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
Hier wird abgefragt, ob der Pixel transparent ist, wen ja wird er nicht ausgegeben und<br>
dadurch wird der Z-Buffer nicht aktualisiert. Dadurch werden Objecte hinter der transparent Textur trozdem gezeichnet.<br>
<br>
Da die Kanten der Baume nicht voll transparent sind, habe ich einen Mittelwert von 0.5 genommen.<br>
Da muss man abschätzen, wie streng die Prüfung sein soll.<br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  vec4 c = texture( Sampler, UV0 );
  if (c.a > 0.5) {</font>
    FragColor =  c;
  } else {
    discard; // Wen transparent, Pixel nicht ausgeben.
  }
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
