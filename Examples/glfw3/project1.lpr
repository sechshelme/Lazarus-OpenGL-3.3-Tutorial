program project1;

// https://www.glfw.org/docs/3.3/quick.html

uses
//  oglglad_gl,
  GL,  GLext,
  glfw3,
  oglShader;

type
    TVector3f = array[0..2] of TGLfloat;
    PVector3f = ^TVector3f;

  procedure error_callback(error_code: longint; description: PChar); cdecl;
  begin
    WriteLn('ErrorCallback: (', error_code, ')  ', description);
  end;

  procedure key_callback(window: PGLFWwindow; key: longint; scancode: longint; action: longint; mods: longint); cdecl;
  begin
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

  vertex_shader_text: string =
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

  procedure main;
  var
    window: PGLFWwindow;
    Width, Height: longint;
    Shader: TShader;

  type
    TVB = record
    VAOs: array [(vaMesh)] of TGLuint;
    Mesh_Buffers: array [(mbVBOVektor)] of TGLuint;
  end;

  var
    VBTriangle, VBQuad: TVB;

  begin
    glfwSetErrorCallback(@error_callback);

    if glfwInit = 0 then begin
      WriteLn('glfwInit Error !');
      Halt(1);
    end;

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);

    window := glfwCreateWindow(640, 480, 'GLFW-Demo', nil, nil);
    if window = nil then begin
      WriteLn('glfwCreateWindow Error !');
      Halt(1);
    end;

    glfwSetKeyCallback(window, @key_callback);
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1);

//    Load_GLADE;

    Load_GL_VERSION_3_3();

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
    Shader := TShader.Create;
    Shader.LoadShaderObject(GL_VERTEX_SHADER, vertex_shader_text);
    Shader.LoadShaderObject(GL_FRAGMENT_SHADER, fragment_shader_text);
    Shader.LinkProgram;
    Shader.UseProgram;

    while glfwWindowShouldClose(window) = 0 do begin
      glfwGetFramebufferSize(window, @Width, @Height);

      glViewport(0, 0, Width, Height);
      glClear(GL_COLOR_BUFFER_BIT);

      Shader.UseProgram;
      //code-

      // Zeichne Dreieck
      glBindVertexArray(VBTriangle.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

      // Zeichne Quadrat
      glBindVertexArray(VBQuad.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

      glfwSwapBuffers(window);
      glfwPollEvents;
    end;

    glDeleteVertexArrays(Length(VBTriangle.VAOs), VBTriangle.VAOs);
    glDeleteBuffers(Length(VBTriangle.Mesh_Buffers), VBTriangle.Mesh_Buffers);

    glfwDestroyWindow(window);
    glfwTerminate;
  end;

begin
  main;
  WriteLn('io');
end.
