<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>60 - Vertex-Puffer auslesen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann nicht nur die Vertex-Daten in das VRAM schreiben, man kann dies auch wieder auslesen.<br>
<hr><br>
Für diesen Zweck gibt es die Funktion <b>glGetBufferSubData(...</b>.<br>
<hr><br>
Diese Vertex-Daten sollen auch in der MessageBox erscheinen.<br>
<pre><code>const
  TriangleVector: array[0..0] of TFace2D =</font>
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));</font>
  TriangleColor: array[0..0] of TVertex3f = ((1.0, 0.5, 0.0));</font>
  QuadVector: array[0..1] of TFace2D =</font>
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),</font>
    ((-0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));</font>
  QuadColor: array[0..1] of TVertex3f =</font>
    ((0.5, 0.0, 1.0), (0.5, 1.0, 0.0));</pre></code>
Vertex-Daten auslesen.<br>
Wie üblich müssen die Puffer VAO und VBO gebunden werden.<br>
Mit <b>glGetBufferParameteriv(...</b> wird die Grösse des Puffer ermittelt.<br>
Anschliessend können dann die Daten mit <b>glGetBufferSubData(...</b> ausgelesen werden.<br>
<pre><code>procedure TForm1.MenuItem1Click(Sender: TObject);
var
  TempBuffer: array of record   // Zum speichern der Daten
    x, y: glFloat;
  end;
  sx, sy: string;               // Für Formatierung
  i: integer;
  BufSize: GLint;               // Puffergrösse.
  sl: TStringList;              // Für Ausgabe.
begin
  sl := TStringList.Create;

  // Puffer binden.
  if TMenuItem(Sender).Caption = 'Dreieck' then begin</font>
    glBindVertexArray(VBTriangle.VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  end else begin
    glBindVertexArray(VBQuad.VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  end;

  // Die Grösse des Puffers ermitteln.
  glGetBufferParameteriv(GL_ARRAY_BUFFER, GL_BUFFER_SIZE, @BufSize);

  // Ram für den Puffer reservieren.
  SetLength(TempBuffer, BufSize div 8);</font>

  // Puffer in den Ram kopieren.
  glGetBufferSubData(GL_ARRAY_BUFFER, 0, BufSize, Pointer(TempBuffer));

  // Puffer formatieren und ausgeben.
  sl.Add('Anzahl Vektoren: ' + IntToStr(BufSize div 8));</font>
  sl.Add('');</font>

  for i := 0 to BufSize div 8 - 1 do begin
    Str(TempBuffer[i].x: 6: 3, sx);</font>
    Str(TempBuffer[i].y: 6: 3, sy);</font>
    sl.Add('X: ' + sx + ' Y: ' + sy);</font>
  end;

  ShowMessage(sl.Text);
  sl.Free;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec2 inPos;     // Vertex-Koordinaten, nur XY.</font>
layout (location = 11) in float inCol;    // Farbe, es kommt nur Rot.</font>

out vec4 Color;                           // Farbe, an Fragment-Shader übergeben.

void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);    // Z ist immer 0.0</font>
  Color = vec4(inCol, 0.0, 0.0, 1.0);     // Der Rot- und Grün - Teil, ist 0.0</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
