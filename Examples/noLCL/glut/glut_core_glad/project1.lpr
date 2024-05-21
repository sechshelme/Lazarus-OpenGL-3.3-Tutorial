program project1;

uses
  oglglad_gl,
  glut,
  oglShader;

type
  TVector3f = array[0..2] of single;
  PVector3f = ^TVector3f;

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

type
  TVB = record
    VAOs: array [(vaMesh)] of GLuint;
    Mesh_Buffers: array [(mbVBOVektor)] of GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;
  Shader: TShader;

  procedure key_press(c: byte; v1, v2: integer); cdecl;
  begin
    WriteLn('press');
    glutInitWindowPosition(Random(300), Random(300));     // Location of window in screen coordinates.
    glutInitWindowSize(Random(300), Random(300));     // Location of window in screen coordinates.
    if c = 27 then begin
      halt;
    end;
  end;

  procedure display; cdecl;
  begin
    glClear(GL_COLOR_BUFFER_BIT);

    Shader.UseProgram;
    glBindVertexArray(VBTriangle.VAOs[vaMesh]);
    glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

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
    glutCreateWindow('GL RGB Triangle');
    Load_GLADE;
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
    Shader := TShader.Create;
    Shader.LoadShaderObject(GL_VERTEX_SHADER, vertex_shader_text);
    Shader.LoadShaderObject(GL_FRAGMENT_SHADER, fragment_shader_text);
    Shader.LinkProgram;
    Shader.UseProgram;

    glutMainLoop();
  end;

begin
  main;
end.
