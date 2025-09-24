program project1;

uses
  fp_glew,
  fp_glut,
  fp_GL_Tools;

type
  TVector3f = array[0..2] of single;
  PVector3f = ^TVector3f;

const
  Triangle: array of TVector3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  Quad: array of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));

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
    'uniform vec3 col;' + #10 +
    '' + #10 +
    'out vec4 fColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  fColor = vec4(vec3(col), 1.0);' + #10 +
    '}';

type
  TVB = record
    VAOs: array [(vaMesh)] of TGLuint;
    Mesh_Buffers: array [(mbVBOVektor)] of TGLuint;
  end;

var
  VBTriangle, VBQuad: TVB;
  shader: PShader;

  procedure key_press(key: ansichar; x, y: integer); cdecl;
  begin
    WriteLn('press');
    glutInitWindowPosition(Random(300), Random(300));
    glutInitWindowSize(Random(300), Random(300));
    if key = #27 then begin
      glutLeaveMainLoop;
    end;
  end;

  procedure display; cdecl;
  begin
    glClear(GL_COLOR_BUFFER_BIT);

    shader_use_program(shader);

    glUniform3f(shader_uniform_location(shader, 'col'), 1.0, 0.0, 0.0);
    glBindVertexArray(VBTriangle.VAOs[vaMesh]);
    glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

    glUniform3f(shader_uniform_location(shader, 'col'), 0.0, 1.0, 1.0);
    glBindVertexArray(VBQuad.VAOs[vaMesh]);
    glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
    glutSwapBuffers;
  end;

  procedure main;
  begin
    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE);
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(100, 100);
    glutCreateWindow('GL Triangle');

    if glewInit <> GLEW_OK then begin
      WriteLn('glxewInit Fehler');
      Halt(1);
    end;

    glutDisplayFunc(@display);
    glutKeyboardFunc(@key_press);

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

    glutMainLoop;

    shader_unref(shader);
  end;

begin
  main;
  WriteLn('ende');
end.
