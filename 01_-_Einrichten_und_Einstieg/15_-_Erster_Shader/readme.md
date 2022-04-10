<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>15 - Erster Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird zum ersten Mal ein Shader geladen, ohne solchen macht OpenGL >= 3.3 keinen Sinn.<br>
Nähere Details dazu im Kapitel Shader. Hier geht es in erster Linie mal darum, dass man etwas rendern kann.<br>
<br>
In diesem Beispiel wird ein sehr einfacher Shader verwendet. Dieser macht nichts anderes, als das Mesh rot darzustellen.<br>
<hr><br>
Die ID, welche auf den Shader zeigt.<br>
<pre><code>var
  ProgramID: GLuint;</pre></code>
Lädt den Vertex- und Fragment-Shader in die Grafikkarte.<br>
In diesem Beispiel sind die beiden Shader in einer Textdatei.<br>
Natürlich kann man diese auch direkt als String-Konstante im Quellcode deklarieren.<br>
<pre><code>function Initshader(VertexDatei, FragmentDatei: string): GLuint;
var
  sl: TStringList;
  s: string;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;
  FragmentShaderObject: GLhandle;

  ErrorStatus, InfoLogLength: integer;

begin
  sl := TStringList.Create;
  ProgramObject := glCreateProgram();

  // Vertex - Shader

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  sl.LoadFromFile(VertexDatei);
  s := sl.Text;
  glShaderSource(VertexShaderObject, 1, @s, nil);</font>
  glCompileShader(VertexShaderObject);
  glAttachShader(ProgramObject, VertexShaderObject);

  // Check Shader

  glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin</font>
    glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);</font>
    glGetShaderInfoLog(VertexShaderObject, InfoLogLength, nil, @s[1]);</font>
    Application.MessageBox(PChar(s), 'OpenGL Vertex Fehler', 48);</font>
    Halt;
  end;

  glDeleteShader(VertexShaderObject);

  // Fragment - Shader

  FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
  sl.LoadFromFile(FragmentDatei);
  s := sl.Text;
  glShaderSource(FragmentShaderObject, 1, @s, nil);</font>
  glCompileShader(FragmentShaderObject);
  glAttachShader(ProgramObject, FragmentShaderObject);

  // Check Shader

  glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin</font>
    glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);</font>
    glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, nil, @s[1]);</font>
    Application.MessageBox(PChar(s), 'OpenGL Fragment Fehler', 48);
    Halt;
  end;

  glDeleteShader(FragmentShaderObject);
  glLinkProgram(ProgramObject);    // Die beiden Shader zusammen linken

  // Check Link
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin</font>
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);</font>
    glGetProgramInfoLog(ProgramObject, InfoLogLength, nil, @s[1]);</font>
    Application.MessageBox(PChar(s), 'OpenGL ShaderLink Fehler', 48);
    Halt;
  end;

  Result := ProgramObject;
  sl.Free;
end;</pre></code>
Dieser Code wurde um 2 Zeilen erweitert.<br>
<br>
In der ersten Zeile wird der Shader in die Grafikkarte geladen.<br>
Die zweite Zeile aktiviert den Shader.<br>
Dies wird spätestens dann interessant, wenn man mehrere Shader verwendet.<br>
Näheres im Kapitel Shader.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  ProgramID := InitShader('Vertexshader.glsl', 'Fragmentshader.glsl');
  glUseProgram(programID);</pre></code>
Beim Zeichnen muss man auch mit <b>glUseProgram(...</b> den Shader wählen, mit welchem das Mesh gezeichnet wird.<br>
Bei diesem Mini-Code könnte dies weggelassen werden, da nur ein Shader verwendet wird und dieser bereits in TForm1.CreateScene aktiviert wurde.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glUseProgram(programID);</pre></code>
Am Ende noch mit <b>glDeleteShader(...</b> die Shader in der Grafikkarte wieder freigeben.<br>
In diesem Code ist dies nur einer.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);</pre></code>
<hr><br>
Die beiden verwendeten Shader, Details dazu im Kapitel Shader.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;</font>

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 0.0, 0.0, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
