program project1;

// https://www.glfw.org/docs/3.3/quick.html

uses
  oglglad_gl,
  glew,
  fp_glfw3,
  fp_glfw3native;
//  oglGLFW3,
//  oglDebug,
//  oglShader;

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
           programID: GLuint;

    function Initshader(VertexDatei, FragmentDatei: string): GLuint;
    var
      s: string;

      ProgramObject: GLint;
      VertexShaderObject: GLint;
      FragmentShaderObject: GLint;

      ErrorStatus, InfoLogLength: integer;

    begin
      ProgramObject := glCreateProgram();

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
        WriteLn(PChar(s), 'OpenGL Vertex Fehler', 48);
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
        WriteLn(PChar(s), 'OpenGL Fragment Fehler', 48);
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
        WriteLn(PChar(s), 'OpenGL ShaderLink Fehler', 48);
        Halt;
      end;

      Result := ProgramObject;
    end;



  procedure error_callback(error_code: longint; description: PChar); cdecl;
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

  procedure Mouse_Callback(window: PGLFWwindow; button: longint;    action: longint; mods: longint); cdecl;
  begin
    WriteLn('click    button: ',button, '  action: ',action, '  mods: ',mods);
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
    s: String;

  begin
    glfwSetErrorCallback(@error_callback);

    if glfwInit = 0 then begin
      WriteLn('glfwInit Error !');
      Halt(1);
    end;

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
//    glfwWindowHint(GLFW_ACCUM_RED_BITS, 3909);

    s:=  {$I %FPCTARGETOS%};

    window := glfwCreateWindow(640, 480, PChar('GLFW-Demo   ( ' +s+' )') , nil, nil);
    if window = nil then begin
      WriteLn('glfwCreateWindow Error !');
      Halt(1);
    end;

    glfwSetKeyCallback(window, @Key_callback);
    glfwSetCharCallback(window,@Char_callBack);
    glfwSetMouseButtonCallback(window, @Mouse_Callback);
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1);

if    glewInit<>GLEW_OK then WriteLn('glfwInit Fehler');
    WriteLn(PtrUInt(__glewGenVertexArrays));



    Load_GLADE;

    glClearColor(0.3, 0.3, 0.2, 1.0); // Hintergrundfarbe

    // Daten für Dreieck
    __glewGenVertexArrays(Length(VBTriangle.VAOs), VBTriangle.VAOs);

    __glewGenBuffers(Length(VBTriangle.Mesh_Buffers), VBTriangle.Mesh_Buffers);

    __glewBindVertexArray(VBTriangle.VAOs[vaMesh]);
    __glewBindBuffer(GL_ARRAY_BUFFER, VBTriangle.Mesh_Buffers[mbVBOVektor]);
    __glewBufferData(GL_ARRAY_BUFFER, Length(Triangle) * SizeOf(TVector3f), PVector3f(Triangle), GL_STATIC_DRAW);
    __glewEnableVertexAttribArray(0);
    __glewVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

    // Daten für Quadrat
    __glewGenVertexArrays(Length(VBQuad.VAOs), VBQuad.VAOs);
    __glewGenBuffers(Length(VBQuad.Mesh_Buffers), VBQuad.Mesh_Buffers);

    __glewBindVertexArray(VBQuad.VAOs[vaMesh]);
    __glewBindBuffer(GL_ARRAY_BUFFER, VBQuad.Mesh_Buffers[mbVBOVektor]);
    __glewBufferData(GL_ARRAY_BUFFER, Length(Quad) * SizeOf(TVector3f), PVector3f(Quad), GL_STATIC_DRAW);
    __glewEnableVertexAttribArray(0);
    __glewVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);


    // Shader
    programID:=    Initshader(vertex_shader_text, fragment_shader_text);

    //Shader := TShader.Create;
    //Shader.LoadShaderObject(GL_VERTEX_SHADER, vertex_shader_text);
    //Shader.LoadShaderObject(GL_FRAGMENT_SHADER, fragment_shader_text);
    //Shader.LinkProgram;
    //Shader.UseProgram;


    while glfwWindowShouldClose(window) = 0 do begin
      glfwGetFramebufferSize(window, @Width, @Height);

      glViewport(0, 0, Width, Height);
      glClear(GL_COLOR_BUFFER_BIT);

//      Shader.UseProgram;
      glUseProgram(programID);

      // Zeichne Dreieck
      __glewBindVertexArray(VBTriangle.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

      // Zeichne Quadrat
      __glewBindVertexArray(VBQuad.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

      glfwSwapBuffers(window);
      glfwPollEvents;
    end;

    __glewDeleteVertexArrays(Length(VBTriangle.VAOs), VBTriangle.VAOs);
    __glewDeleteBuffers(Length(VBTriangle.Mesh_Buffers), VBTriangle.Mesh_Buffers);

      glDeleteProgram(ProgramID);

    glfwDestroyWindow(window);
    glfwTerminate;
  end;

begin
  main;
end.
