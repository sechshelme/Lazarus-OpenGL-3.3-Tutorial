<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>10 - VAO - Daten laden</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier werden zum ersten Mal Vertex-Daten ins VRAM geladen.<br>
<b>Hinweis:</b> Je nach Grafiktreiber kann es sein, dass man keine Ausgabe sieht, weil noch kein Shader geladen ist. Mehr dazu im nächsten Tutorial.<br>
Mit dem original NVidia- und Intel-Treiber sollten die Mesh unter Linux und Windows sichtbar sein.<br>
Mit dem Mesa-Treiber unter Linux mit einer NVidia-Karte ist nichts sichtbar.<br>
<hr><br>
Typen-Deklaration für die Face-Daten.<br>
<pre><code>type
  TVertex3f = array[0..2] of GLfloat;</font>
  TFace = array[0..2] of TVertex3f;</font></pre></code>
Koordinaten für das Mesh, hier ein Dreieck und ein Quadrat, welches wir später in das VRAM (Video-Ram) rendern.<br>
<pre><code>const
  Triangle: array[0..0] of TFace =</font>
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));</font>
  Quad: array[0..1] of TFace =</font>
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));</font></pre></code>
Für den Contexterzeugung und sonstige OpenGL-Inizialisationen, übernimmt der grösste Teil, die Klasse <b>TContext</b>, der Unit <b>oglContext</b>.<br>
Anstelle von <b>Self</b>, kann auch ein anderes <b>TWinControl</b> angegeben werden, zB. ein <b>TPanel</b>.<br>
<br>
Am Ende müssen noch diese beiden Prozeduren aufgerufen werden, welche die Puffer für die Mesh erzeugen und die Vertexkoordinaten in den Puffer laden.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);  // Den Context erzeugen und OpenGL inizialisieren.
  ogc.OnPaint := @ogcDrawScene;  // OnPaint-Ereigniss von dem Contextfenster.

  CreateScene;                   // Puffer anlegen.
  InitScene;                     // Vertex-Daten in den Buffer schreiben.
end;</pre></code>
Buffer für Vertex-Daten anlegen.<br>
<br>
Mit <b>glGenVertexArrays(...</b> wird ein <b>Vertex Array Object</b> für jedes Mesh erzeugt.<br>
Mit <b>glGenBuffers(...</b> wird ein <b>Vertex Buffer Object</b> für die Vertex-Daten des Meshes erzeugt.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  glGenVertexArrays(1, @VBTriangle.VAO);</font>
  glGenVertexArrays(1, @VBQuad.VAO);</font>

  glGenBuffers(1, @VBTriangle.VBO);</font>
  glGenBuffers(1, @VBQuad.VBO);</font>
end;</pre></code>
Die folgenden Anweisungen laden die Vertex-Daten in das VRAM.<br>
<br>
Mit <b>glBindVertexArray(...</b> wird das gewünschte Mesh gebunden, so das man mit <b>glBufferData(...</b> die Vertex-Daten in das VRAM schreiben kann.<br>
Mit <b>glEnableVertexAttribArray(...</b> gibt man an, welches Layout man im Shader will.<br>
Mit <b>glVertexAttribPointer(...</b> gibt man an, in welchem Format man die Vertex-Daten übergeben hat.<br>
Der erste Parameter (<b>Index</b>) muss mit den Wert bei <b>location</b> im Shader übereinstimmen, dies ist momentan aber nicht relevant, da (noch) gar kein Shader geladen ist.<br>
<br>
<b>InitScene</b> kann zur Laufzeit mit anderen Daten geladen werden.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // Daten für das Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Daten für das Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;</pre></code>
Jetzt wird das gerenderte Objekt im VRAM auf dem Bildschirm ausgegeben.<br>
<br>
Da kommt ein grosser Vorteil von OpenGL 3.3 zu Geltung.<br>
<br>
Man muss nur noch mit <b>glBindVertexArray(...</b> das Mesh wählen, das man ausgeben will.<br>
Gezeichnet wird dann mit <b>glDrawArrays(...</b>, meistens werden mit <b>GL_TRIANGLES</b> Dreiecke ausgegeben.<br>
Quadrate und Polygone gehen NICHT mehr, so wie man es noch mit <b>glBegin(...</b> konnte !<br>
<br>
Shapes, welche funktionieren:<br>
* GL_POINTS<br>
* GL_LINES<br>
* GL_LINE_STRIP<br>
* GL_LINE_LOOP<br>
* GL_TRIANGLES<br>
* GL_TRIANGLE_STRIP<br>
* GL_TRIANGLE_FAN<br>
<br>
Da gibt es noch spezial-Versionen, diese sind aber nur mit einem Geometrie-Shader sinnvoll.<br>
Den Geometrie-Shader werde ich später erwähnen.<br>
<br>
* GL_LINES_ADJACENCY<br>
* GL_LINE_STRIP_ADJACENCY<br>
* GL_TRIANGLES_ADJACENCY<br>
* GL_TRIANGLE_STRIP_ADJACENCY<br>
<br>
Zum Schluss muss noch der Frame-Puffer auf den Bildschirm kopiert werden.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);</font>

  ogc.SwapBuffers;
end;</pre></code>
Am Ende muss man die angelegten <b>Vertex Array Objects</b> und <b>Vertex Buffer Objects</b> wieder freigeben.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteVertexArrays(1, @VBTriangle.VAO);</font>
  glDeleteVertexArrays(1, @VBQuad.VAO);</font>

  glDeleteBuffers(1, @VBTriangle.VBO);</font>
  glDeleteBuffers(1, @VBQuad.VBO);</font>
end;
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
