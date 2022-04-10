    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>60 - Vertex-Puffer auslesen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann nicht nur die Vertex-Daten in das VRAM schreiben, man kann dies auch wieder auslesen.<br>
<hr><br>
Für diesen Zweck gibt es die Funktion <b>glGetBufferSubData(...</b>.<br>
<hr><br>
Diese Vertex-Daten sollen auch in der MessageBox erscheinen.<br>
<pre><code><b><font color="0000BB">const</font></b>
  TriangleVector: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace2D =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>)));
  TriangleColor: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TVertex3f = ((<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
  QuadVector: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace2D =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>)));
  QuadColor: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TVertex3f =
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));</pre></code>
Vertex-Daten auslesen.<br>
Wie üblich müssen die Puffer VAO und VBO gebunden werden.<br>
Mit <b>glGetBufferParameteriv(...</b> wird die Grösse des Puffer ermittelt.<br>
Anschliessend können dann die Daten mit <b>glGetBufferSubData(...</b> ausgelesen werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.MenuItem1Click(Sender: TObject);
<b><font color="0000BB">var</font></b>
  TempBuffer: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> <b><font color="0000BB">record</font></b>   <i><font color="#FFFF00">// Zum speichern der Daten</font></i>
    x, y: glFloat;
  <b><font color="0000BB">end</font></b>;
  sx, sy: <b><font color="0000BB">string</font></b>;               <i><font color="#FFFF00">// Für Formatierung</font></i>
  i: integer;
  BufSize: GLint;               <i><font color="#FFFF00">// Puffergrösse.</font></i>
  sl: TStringList;              <i><font color="#FFFF00">// Für Ausgabe.</font></i>
<b><font color="0000BB">begin</font></b>
  sl := TStringList.Create;

  <i><font color="#FFFF00">// Puffer binden.</font></i>
  <b><font color="0000BB">if</font></b> TMenuItem(Sender).Caption = <font color="#FF0000">'Dreieck'</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBTriangle.VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBQuad.VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// Die Grösse des Puffers ermitteln.</font></i>
  glGetBufferParameteriv(GL_ARRAY_BUFFER, GL_BUFFER_SIZE, @BufSize);

  <i><font color="#FFFF00">// Ram für den Puffer reservieren.</font></i>
  SetLength(TempBuffer, BufSize <b><font color="0000BB">div</font></b> <font color="#0077BB">8</font>);

  <i><font color="#FFFF00">// Puffer in den Ram kopieren.</font></i>
  glGetBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, BufSize, Pointer(TempBuffer));

  <i><font color="#FFFF00">// Puffer formatieren und ausgeben.</font></i>
  sl.Add(<font color="#FF0000">'Anzahl Vektoren: '</font> + IntToStr(BufSize <b><font color="0000BB">div</font></b> <font color="#0077BB">8</font>));
  sl.Add(<font color="#FF0000">''</font>);

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> BufSize <b><font color="0000BB">div</font></b> <font color="#0077BB">8</font> - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Str(TempBuffer[i].x: <font color="#0077BB">6</font>: <font color="#0077BB">3</font>, sx);
    Str(TempBuffer[i].y: <font color="#0077BB">6</font>: <font color="#0077BB">3</font>, sy);
    sl.Add(<font color="#FF0000">'X: '</font> + sx + <font color="#FF0000">' Y: '</font> + sy);
  <b><font color="0000BB">end</font></b>;

  ShowMessage(sl.Text);
  sl.Free;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;     <i><font color="#FFFF00">// Vertex-Koordinaten, nur XY.</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> inCol;    <i><font color="#FFFF00">// Farbe, es kommt nur Rot.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                           <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);    <i><font color="#FFFF00">// Z ist immer 0.0</font></i>
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);     <i><font color="#FFFF00">// Der Rot- und Grün - Teil, ist 0.0</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

