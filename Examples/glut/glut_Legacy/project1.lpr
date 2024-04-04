program project1;

uses
  Math,
  gl,
  glut;

  procedure display; cdecl;
  begin
    glClearColor(0.5, 1.0, 0.0, 1.0);
    glClear($00004000);


    glBegin(GL_TRIANGLES);
    glColor3f(1, 0, 0); // red
    glVertex2f(-0.8, -0.8);
    glColor3f(0, 1, 0); // green
    glVertex2f(0.8, -0.8);
    glColor3f(0, 0, 1); // blue
    glVertex2f(0, 0.9);
    glEnd();

    glutSwapBuffers;
  end;

  procedure key_press(c: byte; v1, v2: integer); cdecl;
  begin
    WriteLn('press');
    if c = 27 then begin
      halt;
    end;
  end;

  procedure main;
  begin
    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE);    // Use single color buffer and no depth buffer.
    glutInitWindowSize(500, 500);         // Size of display area, in pixels.
    glutInitWindowPosition(100, 100);     // Location of window in screen coordinates.
    glutCreateWindow('GL RGB Triangle'); // Parameter is window title.
    glutDisplayFunc(@display);            // Called when the window needs to be redrawn.
    glutKeyboardFunc(@key_press);

    glutMainLoop(); // Run the event loop!  This function does not return.
    // Program ends when user closes the window.
  end;

begin
  main;
end.
