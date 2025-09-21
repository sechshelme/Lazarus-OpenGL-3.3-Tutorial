program project1;

uses
  fp_glew,
  fp_glfw3;


type
  TVector3f = array[0..2] of TGLfloat;
  PVector3f = ^TVector3f;
const
  vertex_shader_text =
    '#version 330 core' + #10 +
    '' + #10 +
    'layout (location = 0) in vec4 vPosition;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  gl_Position = vPosition;' + #10 +
    '}';

  fragment_shader_text =
    '#version 330 core' + #10 +
    '' + #10 +
    'out vec4 fColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  fColor = vec4(0.5, 0.4, 0.8, 1.0);' + #10 +
    '}';

var
  programID: TGLuint;

  function Initshader(VertexDatei, FragmentDatei: string): TGLuint;
  var
    s: string;

    ProgramObject: TGLint;
    VertexShaderObject: TGLint;
    FragmentShaderObject: TGLint;

    ErrorStatus, InfoLogLength: integer;

  begin
    ProgramObject := glCreateProgram(nil);

    // Vertex - Shader

    VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
    s := VertexDatei;
    glShaderSource(VertexShaderObject, 1, @s, nil);
    glCompileShader(VertexShaderObject);
    glAttachShader(ProgramObject, VertexShaderObject);

    // Check Shader

    glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
    if ErrorStatus = 0 then begin
      glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
      SetLength(s, InfoLogLength + 1);
      glGetShaderInfoLog(VertexShaderObject, InfoLogLength, nil, @s[1]);
      WriteLn(pchar(s), 'OpenGL Vertex Fehler', 48);
      Halt;
    end;

    glDeleteShader(VertexShaderObject);

    // Fragment - Shader

    FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
    s := FragmentDatei;
    glShaderSource(FragmentShaderObject, 1, @s, nil);
    glCompileShader(FragmentShaderObject);
    glAttachShader(ProgramObject, FragmentShaderObject);

    // Check Shader

    glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
    if ErrorStatus = 0 then begin
      glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
      SetLength(s, InfoLogLength + 1);
      glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, nil, @s[1]);
      WriteLn(pchar(s), 'OpenGL Fragment Fehler', 48);
      Halt;
    end;

    glDeleteShader(FragmentShaderObject);
    glLinkProgram(ProgramObject);    // Die beiden Shader zusammen linken

    // Check Link
    glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
    if ErrorStatus = 0 then begin
      glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
      SetLength(s, InfoLogLength + 1);
      glGetProgramInfoLog(ProgramObject, InfoLogLength, nil, @s[1]);
      WriteLn(pchar(s), 'OpenGL ShaderLink Fehler', 48);
      Halt;
    end;

    Result := ProgramObject;
  end;



  procedure error_callback(error_code: longint; description: pchar); cdecl;
  begin
    WriteLn('ErrorCallback: (', error_code, ')  ', description);
  end;

  procedure Key_callback(window: PGLFWwindow; key: longint; scancode: longint; action: longint; mods: longint); cdecl;
  begin
    WriteLn('press Key');
    if (key = GLFW_KEY_ESCAPE) and (action = GLFW_PRESS) then begin
      glfwSetWindowShouldClose(window, GLFW_TRUE);
    end;
  end;

const
  Triangle: array of TVector3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  Quad: array of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));


  procedure Char_callBack(window: PGLFWwindow; codepoint: dword); cdecl;
  begin
    WriteLn('press Char');
  end;

  procedure Mouse_Callback(window: PGLFWwindow; button: longint; action: longint; mods: longint); cdecl;
  begin
    WriteLn('click    button: ', button, '  action: ', action, '  mods: ', mods);
  end;

  procedure main;
  var
    window: PGLFWwindow;
    Width, Height: longint;
    //    Shader: TShader;

  type
    TVB = record
    VAOs: array [(vaMesh)] of TGLuint;
    Mesh_Buffers: array [(mbVBOVektor)] of TGLuint;
  end;

  var
    VBTriangle, VBQuad: TVB;
    s: string;

  begin
    glfwSetErrorCallback(@error_callback);

    if glfwInit = 0 then begin
      WriteLn('glfwInit Error !');
      Halt(1);
    end;

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);

    s := {$I %FPCTARGETOS%};

    window := glfwCreateWindow(640, 480, pchar('GLFW-Demo   ( ' + s + ' )'), nil, nil);
    if window = nil then begin
      WriteLn('glfwCreateWindow Error !');
      Halt(1);
    end;

    glfwSetKeyCallback(window, @Key_callback);
    glfwSetCharCallback(window, @Char_callBack);
    glfwSetMouseButtonCallback(window, @Mouse_Callback);
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1);

    if glewInit <> GLEW_OK then begin
      WriteLn('glfwInit Fehler');
      Halt(1);
    end;

    glClearColor(0.3, 0.3, 0.2, 1.0); // Hintergrundfarbe

    // Daten für Dreieck
    glGenVertexArrays(Length(VBTriangle.VAOs), VBTriangle.VAOs);

    glGenBuffers(Length(VBTriangle.Mesh_Buffers), VBTriangle.Mesh_Buffers);

    glBindVertexArray(VBTriangle.VAOs[vaMesh]);
    glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.Mesh_Buffers[mbVBOVektor]);
    glBufferData(GL_ARRAY_BUFFER, Length(Triangle) * SizeOf(TVector3f), PVector3f(Triangle), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

    // Daten für Quadrat
    glGenVertexArrays(Length(VBQuad.VAOs), VBQuad.VAOs);
    glGenBuffers(Length(VBQuad.Mesh_Buffers), VBQuad.Mesh_Buffers);

    glBindVertexArray(VBQuad.VAOs[vaMesh]);
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.Mesh_Buffers[mbVBOVektor]);
    glBufferData(GL_ARRAY_BUFFER, Length(Quad) * SizeOf(TVector3f), PVector3f(Quad), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);


    // Shader
    programID := Initshader(vertex_shader_text, fragment_shader_text);

    while glfwWindowShouldClose(window) = 0 do begin
      glfwGetFramebufferSize(window, @Width, @Height);

      glViewport(0, 0, Width, Height);
      glClear(GL_COLOR_BUFFER_BIT);

      //      Shader.UseProgram;
      glUseProgram(programID);

      // Zeichne Dreieck
      glBindVertexArray(VBTriangle.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

      // Zeichne Quadrat
      glBindVertexArray(VBQuad.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

      glfwSwapBuffers(window);
      glfwPollEvents;
    end;

    glDeleteProgram(ProgramID);

    glfwDestroyWindow(window);
    glfwTerminate;
  end;

begin
  main;
end.
