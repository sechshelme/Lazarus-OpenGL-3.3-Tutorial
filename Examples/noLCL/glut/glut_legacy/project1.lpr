program project1;

uses
  fp_glew,
  fp_glut;

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

  procedure key_press(key: ansichar; x, y: integer); cdecl;
  begin
    WriteLn('press');
    if key = #27 then begin
      halt;
    end;
  end;

  procedure main;
  begin
    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE);
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(100, 100);
    glutCreateWindow('GL RGB Triangle');
    glutDisplayFunc(@display);
    glutKeyboardFunc(@key_press);

    glutMainLoop();
  end;

begin
  main;
end.
