<html>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird zum ersten Mal ein Shader geladen, ohne solchen macht OpenGL >= 3.3 keinen Sinn.<br>
Nähere Details dazu im Kapitel Shader. Hier geht es in erster Linie mal darum, dass man etwas rendern kann.<br>
<br>
In diesem Beispiel wird ein sehr einfacher Shader verwendet. Dieser macht nichts anderes, als das Mesh rot darzustellen.<br>
<hr><br>
Die ID, welche auf den Shader zeigt.<br>
<pre><code><b><font color="0000BB">var</font></b>
  ProgramID: GLuint;</pre></code>
Lädt den Vertex- und Fragment-Shader in die Grafikkarte.<br>
In diesem Beispiel sind die beiden Shader in einer Textdatei.<br>
Natürlich kann man diese auch direkt als String-Konstante im Quellcode deklarieren.<br>
<pre><code><b><font color="0000BB">function</font></b> Initshader(VertexDatei, FragmentDatei: <b><font color="0000BB">string</font></b>): GLuint;
<b><font color="0000BB">var</font></b>
  sl: TStringList;
  s: <b><font color="0000BB">string</font></b>;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;
  FragmentShaderObject: GLhandle;

  ErrorStatus, InfoLogLength: integer;

<b><font color="0000BB">begin</font></b>
  sl := TStringList.Create;
  ProgramObject := glCreateProgram();

  <i><font color="#FFFF00">// Vertex - Shader</font></i>

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  sl.LoadFromFile(VertexDatei);
  s := sl.Text;
  glShaderSource(VertexShaderObject, <font color="#0077BB">1</font>, @s, <b><font color="0000BB">nil</font></b>);
  glCompileShader(VertexShaderObject);
  glAttachShader(ProgramObject, VertexShaderObject);

  <i><font color="#FFFF00">// Check Shader</font></i>

  glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  <b><font color="0000BB">if</font></b> ErrorStatus = <font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + <font color="#0077BB">1</font>);
    glGetShaderInfoLog(VertexShaderObject, InfoLogLength, <b><font color="0000BB">nil</font></b>, @s[<font color="#0077BB">1</font>]);
    Application.MessageBox(PChar(s), <font color="#FF0000">'OpenGL Vertex Fehler'</font>, <font color="#0077BB">48</font>);
    Halt;
  <b><font color="0000BB">end</font></b>;

  glDeleteShader(VertexShaderObject);

  <i><font color="#FFFF00">// Fragment - Shader</font></i>

  FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
  sl.LoadFromFile(FragmentDatei);
  s := sl.Text;
  glShaderSource(FragmentShaderObject, <font color="#0077BB">1</font>, @s, <b><font color="0000BB">nil</font></b>);
  glCompileShader(FragmentShaderObject);
  glAttachShader(ProgramObject, FragmentShaderObject);

  <i><font color="#FFFF00">// Check Shader</font></i>

  glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  <b><font color="0000BB">if</font></b> ErrorStatus = <font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + <font color="#0077BB">1</font>);
    glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, <b><font color="0000BB">nil</font></b>, @s[<font color="#0077BB">1</font>]);
    Application.MessageBox(PChar(s), <font color="#FF0000">'OpenGL Fragment Fehler'</font>, <font color="#0077BB">48</font>);
    Halt;
  <b><font color="0000BB">end</font></b>;

  glDeleteShader(FragmentShaderObject);
  glLinkProgram(ProgramObject);    <i><font color="#FFFF00">// Die beiden Shader zusammen linken</font></i>

  <i><font color="#FFFF00">// Check Link</font></i>
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  <b><font color="0000BB">if</font></b> ErrorStatus = <font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + <font color="#0077BB">1</font>);
    glGetProgramInfoLog(ProgramObject, InfoLogLength, <b><font color="0000BB">nil</font></b>, @s[<font color="#0077BB">1</font>]);
    Application.MessageBox(PChar(s), <font color="#FF0000">'OpenGL ShaderLink Fehler'</font>, <font color="#0077BB">48</font>);
    Halt;
  <b><font color="0000BB">end</font></b>;

  Result := ProgramObject;
  sl.Free;
<b><font color="0000BB">end</font></b>;</pre></code>
Dieser Code wurde um 2 Zeilen erweitert.<br>
<br>
In der ersten Zeile wird der Shader in die Grafikkarte geladen.<br>
Die zweite Zeile aktiviert den Shader.<br>
Dies wird spätestens dann interessant, wenn man mehrere Shader verwendet.<br>
Näheres im Kapitel Shader.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  ProgramID := InitShader(<font color="#FF0000">'Vertexshader.glsl'</font>, <font color="#FF0000">'Fragmentshader.glsl'</font>);
  glUseProgram(programID);</pre></code>
Beim Zeichnen muss man auch mit <b>glUseProgram(...</b> den Shader wählen, mit welchem das Mesh gezeichnet wird.<br>
Bei diesem Mini-Code könnte dies weggelassen werden, da nur ein Shader verwendet wird und dieser bereits in TForm1.CreateScene aktiviert wurde.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  glUseProgram(programID);</pre></code>
Am Ende noch mit <b>glDeleteShader(...</b> die Shader in der Grafikkarte wieder freigeben.<br>
In diesem Code ist dies nur einer.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glDeleteProgram(ProgramID);</pre></code>
<hr><br>
Die beiden verwendeten Shader, Details dazu im Kapitel Shader.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

</html>
