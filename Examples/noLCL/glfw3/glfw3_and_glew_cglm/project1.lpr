program project1;

uses
  fp_cglm,
  fp_glew,
  fp_glfw3,
  fp_GL_Tools;

{$CODEALIGN LOCALMIN=16}
//{$CODEALIGN VARMIN=16}


const
  vertex_shader_text =
    '#version 330 core' + #10 +
    '' + #10 +
    'layout (location = 0) in vec4 vPosition;' + #10 +
    '' + #10 +
    'uniform mat4x4 m;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  gl_Position = m * vPosition;' + #10 +
    '}';

  fragment_shader_text =
    '#version 330 core' + #10 +
    '' + #10 +
    'uniform vec3 col;' + #10 +
    '' + #10 +
    'out vec4 fColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  fColor = vec4(vec3(col), 1.0);' + #10 +
    '}';

var
  shader: PShader;

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

  procedure Char_callBack(window: PGLFWwindow; codepoint: dword); cdecl;
  begin
    WriteLn('press Char');
  end;

  procedure Mouse_Callback(window: PGLFWwindow; button: longint; action: longint; mods: longint); cdecl;
  begin
    WriteLn('click    button: ', button, '  action: ', action, '  mods: ', mods);
  end;

const
  Triangle: array of Tvec3 =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  Quad: array of Tvec3 =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));

  procedure printMatrix(const m: Tmat4);
  var
    x, y: integer;
  begin
    for x := 0 to 3 do begin
      Write('[ ');
      for y := 0 to 3 do begin
        Write(m[x, y]: 4: 2, ' ');
      end;
      WriteLn(']');
    end;
    WriteLn();
  end;


  procedure main;
  var
    window: PGLFWwindow;
    Width, Height: longint;

  type
    TVB = record
    VAOs: array [(vaMesh)] of TGLuint;
    Mesh_Buffers: array [(mbVBOVektor)] of TGLuint;
  end;

  var
    VBTriangle, VBQuad: TVB;
    mat_ID: TGLint;
    mat: Tmat4;
    mat2: Tmat4;
    counter: int64 = 0;
  const
    s: string = '';

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
      WriteLn('glewInit Fehler');
      Halt(1);
    end;

    glClearColor(0.3, 0.3, 0.2, 1.0);

    // Daten für Dreieck
    glGenVertexArrays(Length(VBTriangle.VAOs), VBTriangle.VAOs);

    glGenBuffers(Length(VBTriangle.Mesh_Buffers), VBTriangle.Mesh_Buffers);

    glBindVertexArray(VBTriangle.VAOs[vaMesh]);
    glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.Mesh_Buffers[mbVBOVektor]);
    glBufferData(GL_ARRAY_BUFFER, Length(Triangle) * SizeOf(Tvec3), Pvec3(Triangle), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

    // Daten für Quadrat
    glGenVertexArrays(Length(VBQuad.VAOs), VBQuad.VAOs);
    glGenBuffers(Length(VBQuad.Mesh_Buffers), VBQuad.Mesh_Buffers);

    glBindVertexArray(VBQuad.VAOs[vaMesh]);
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.Mesh_Buffers[mbVBOVektor]);
    glBufferData(GL_ARRAY_BUFFER, Length(Quad) * SizeOf(Tvec3), Pvec3(Quad), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);


    // Shader
    shader := shader_new;
    if not shader_load_shaderobject(shader, GL_VERTEX_SHADER, pchar(vertex_shader_text)) then begin
      WriteLn('Fehler im Vertex-Shader:');
      WriteLn(shader_get_errortext(shader));
    end;
    if not shader_load_shaderobject(shader, GL_FRAGMENT_SHADER, fragment_shader_text) then begin
      WriteLn('Fehler im Fragment-Shader:');
      WriteLn(shader_get_errortext(shader));
    end;
    if not shader_link_program(shader) then begin
      WriteLn('Fehler beim Linken der Shader:');
      WriteLn(shader_get_errortext(shader));
    end;
    shader_use_program(shader);

    glmc_mat4_identity(mat2);
    glmc_mat4_identity(mat);

    while glfwWindowShouldClose(window) = 0 do begin
      glfwGetFramebufferSize(window, @Width, @Height);

      glViewport(0, 0, Width, Height);
      glClear(GL_COLOR_BUFFER_BIT);

      inc(counter);
      glmc_mat4_copy(mat, mat2);
      glmc_rotate_z(mat, counter / 40, mat2);
      glmc_scale_uni(mat2, sin(counter / 10) * 0.7 + 1.0);

      shader_use_program(shader);
      mat_ID := shader_uniform_location(shader, 'm');
      glUniformMatrix4fv(mat_ID, 1, GL_FALSE, @mat2);

      // Zeichne Dreieck
      glUniform3f(shader_uniform_location(shader, 'col'), 1.0, 0.0, 0.0);
      glBindVertexArray(VBTriangle.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

      // Zeichne Quadrat
      glUniform3f(shader_uniform_location(shader, 'col'), 0.0, 1.0, 1.0);
      glBindVertexArray(VBQuad.VAOs[vaMesh]);
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

      glfwSwapBuffers(window);
      glfwPollEvents;
    end;

    shader_unref(shader);

    glfwDestroyWindow(window);
    glfwTerminate;
  end;

begin
  main;
end.
