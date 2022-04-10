<html>
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>10 - VAO - Daten laden</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier werden zum ersten Mal Vertex-Daten ins VRAM geladen.<br>
<b>Hinweis:</b> Je nach Grafiktreiber kann es sein, dass man keine Ausgabe sieht, weil noch kein Shader geladen ist. Mehr dazu im nächsten Tutorial.<br>
Mit dem original NVidia- und Intel-Treiber sollten die Mesh unter Linux und Windows sichtbar sein.<br>
Mit dem Mesa-Treiber unter Linux mit einer NVidia-Karte ist nichts sichtbar.<br>
<hr><br>
Typen-Deklaration für die Face-Daten.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVertex3f = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> GLfloat;
  TFace = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> TVertex3f;</code></pre>
Koordinaten für das Mesh, hier ein Dreieck und ein Quadrat, welches wir später in das VRAM (Video-Ram) rendern.<br>
<pre><code><b><font color="0000BB">const</font></b>
  Triangle: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));</code></pre>
Für den Contexterzeugung und sonstige OpenGL-Inizialisationen, übernimmt der grösste Teil, die Klasse <b>TContext</b>, der Unit <b>oglContext</b>.<br>
Anstelle von <b>Self</b>, kann auch ein anderes <b>TWinControl</b> angegeben werden, zB. ein <b>TPanel</b>.<br>
<br>
Am Ende müssen noch diese beiden Prozeduren aufgerufen werden, welche die Puffer für die Mesh erzeugen und die Vertexkoordinaten in den Puffer laden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  ogc := TContext.Create(<b><font color="0000BB">Self</font></b>);  <i><font color="#FFFF00">// Den Context erzeugen und OpenGL inizialisieren.</font></i>
  ogc.OnPaint := @ogcDrawScene;  <i><font color="#FFFF00">// OnPaint-Ereigniss von dem Contextfenster.</font></i>

  CreateScene;                   <i><font color="#FFFF00">// Puffer anlegen.</font></i>
  InitScene;                     <i><font color="#FFFF00">// Vertex-Daten in den Buffer schreiben.</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
Buffer für Vertex-Daten anlegen.<br>
<br>
Mit <b>glGenVertexArrays(...</b> wird ein <b>Vertex Array Object</b> für jedes Mesh erzeugt.<br>
Mit <b>glGenBuffers(...</b> wird ein <b>Vertex Buffer Object</b> für die Vertex-Daten des Meshes erzeugt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBTriangle.VAO);
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);

  glGenBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBO);
<b><font color="0000BB">end</font></b>;</code></pre>
Die folgenden Anweisungen laden die Vertex-Daten in das VRAM.<br>
<br>
Mit <b>glBindVertexArray(...</b> wird das gewünschte Mesh gebunden, so das man mit <b>glBufferData(...</b> die Vertex-Daten in das VRAM schreiben kann.<br>
Mit <b>glEnableVertexAttribArray(...</b> gibt man an, welches Layout man im Shader will.<br>
Mit <b>glVertexAttribPointer(...</b> gibt man an, in welchem Format man die Vertex-Daten übergeben hat.<br>
Der erste Parameter (<b>Index</b>) muss mit den Wert bei <b>location</b> im Shader übereinstimmen, dies ist momentan aber nicht relevant, da (noch) gar kein Shader geladen ist.<br>
<br>
<b>InitScene</b> kann zur Laufzeit mit anderen Daten geladen werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// Daten für das Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Daten für das Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
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
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Am Ende muss man die angelegten <b>Vertex Array Objects</b> und <b>Vertex Buffer Objects</b> wieder freigeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glDeleteVertexArrays(<font color="#0077BB">1</font>, @VBTriangle.VAO);
  glDeleteVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);

  glDeleteBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBO);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBO);
<b><font color="0000BB">end</font></b>;
</code></pre>

</html>
