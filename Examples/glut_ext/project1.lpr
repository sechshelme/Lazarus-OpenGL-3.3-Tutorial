program project1;

// https://www.glfw.org/docs/3.3/quick.html

//{$MACRO ON}
//{$DEFINE extdecl := stdcall}


uses
   dglOpenGL,
  freeglut_std,      freeglut_ext,
    oglGL,   oglGLext,
//    gl,  glext,
    glut,
    oglShader,

  SysUtils;


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

var
  Width, Height: longint;

type
  TVB = record
  VAOs: array [(vaMesh)] of TGLuint;
  Mesh_Buffers: array [(mbVBOVektor)] of TGLuint;
end;

var
  VBTriangle, VBQuad: TVB;

var          Shader: TShader;


  procedure display; cdecl;
  begin
    //glClearColor(0.5, 1.0, 0.0, 1.0);
    //glClear($00004000);
    //
    //
    //    glBegin(GL_TRIANGLES);
    //    glColor3f( 1, 0, 0 ); // red
    //    glVertex2f( -0.8, -0.8 );
    //    glColor3f( 0, 1, 0 ); // green
    //    glVertex2f( 0.8, -0.8 );
    //    glColor3f( 0, 0, 1 ); // blue
    //    glVertex2f( 0, 0.9 );
    //    glEnd();
    //
    //glutSwapBuffers;
    Write('xxxxxxx');



//          glfwGetFramebufferSize(window, @Width, @Height);

//          glViewport(0, 0, Width, Height);
          glClear(GL_COLOR_BUFFER_BIT);

          Shader.UseProgram;
          //code-

          // Zeichne Dreieck
          glBindVertexArray(VBTriangle.VAOs[vaMesh]);
          glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

          // Zeichne Quadrat
          glBindVertexArray(VBQuad.VAOs[vaMesh]);
          glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
          glutSwapBuffers;
    //
    //      glfwSwapBuffers(window);
    //      glfwPollEvents;
  end;

  procedure key_press(c: byte; v1, v2: integer); cdecl;
  begin
    WriteLn('press');
    glutInitWindowPosition(Random(300), Random(300));     // Location of window in screen coordinates.
    glutInitWindowSize(Random(300), Random(300));     // Location of window in screen coordinates.
    if c = 27 then begin
      halt;
    end;

  end;

  procedure main;
  begin
//        Load_GL_VERSION_4_3();
//    SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide,exOverflow, exUnderflow, exPrecision]);

    ///InitOpenGL;
    //ReadExtensions;
    //ReadOpenGLCore;
    //ReadImplementationProperties;

    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE);    // Use single color buffer and no depth buffer.
    glutInitWindowSize(500, 500);         // Size of display area, in pixels.
    glutInitWindowPosition(100, 100);     // Location of window in screen coordinates.
    glutCreateWindow('GL RGB Triangle'); // Parameter is window title.
    glutDisplayFunc(@display);            // Called when the window needs to be redrawn.
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

    glutMainLoop(); // Run the event loop!  This function does not return.
    // Program ends when user closes the window.
    WriteLn('ende');
  end;

begin
  //  WriteLn('OpenGL Demo');
  main;
  WriteLn('io');
end.
