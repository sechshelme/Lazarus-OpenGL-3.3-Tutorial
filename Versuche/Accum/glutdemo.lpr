
program glutdemo;

uses
  GL,
  GLU,
  GLUT;

  // http://www.sulaco.co.za/opengl_project_motion_blur.htm
  // https://www.opengl.org/archives/resources/code/samples/simple/accum.c

var
  thing1, thing2: GLuint;

  procedure Init;
  begin
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClearAccum(0.0, 0.0, 0.0, 0.0);

    thing1 := glGenLists(1);
    glNewList(thing1, GL_COMPILE);
    glColor3f(1.0, 0.0, 0.0);
    glRectf(-1.0, -1.0, 1.0, 0.0);
    glEndList;

    thing2 := glGenLists(1);
    glNewList(thing2, GL_COMPILE);
    glColor3f(0.0, 1.0, 0.0);
    glRectf(0.0, -1.0, 1.0, 1.0);
    glEndList;
  end;

  procedure Reshape(Width, Height: integer); cdecl;
  begin
    glViewport(0, 0, Width, Height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
  end;

  procedure Key(key: byte; x, y: integer); cdecl;
  begin
    case key of
      Ord('1'): begin
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        glutPostRedisplay;
      end;
      Ord('2'): begin
        glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        glutPostRedisplay;
      end;
      27: // ESC
      begin
        Halt(0);
      end;
    end;
  end;

  procedure DrawRectangle(x, y, r, g, b: single);
  const
    segment = 36;
    rad = 0.5;
  var
    i: integer;
    ang: single;
  begin
    glColor3f(r, g, b);
//    glRectf(x, y, x + 1.0, y + 1.0);

    glBegin(GL_TRIANGLE_STRIP);
    for i := 0 to segment do begin
      ang := 2 * pi * i/segment;
      glVertex2f(x+0, y+0);
      glVertex2f(x+rad * cos(ang), y+rad * sin(ang));
    end;
    glEnd;
  end;


  procedure Draw; cdecl;
  begin
  end;

  procedure idle; cdecl;
  const
    ofs: single = 0;
    max = 25;
  var
    i: integer;
  begin
    glPushMatrix;
    glScalef(0.6, 0.6, 1.0);

    glClear(GL_COLOR_BUFFER_BIT);
    glClear(GL_ACCUM_BUFFER_BIT);

    ofs += 0.05;

    for i := 0 to max - 1 do begin
      DrawRectangle(cos(ofs + (1 - i / max)), sin(ofs + 1 - (i / max)), 1 / max, 1 - 1 / max, 0);
      glAccum(GL_ACCUM, 1 / max);
    end;

    //for i := 0 to max-1 do begin
    //  glClear(GL_COLOR_BUFFER_BIT);
    //  DrawRectangle(-1 + i / max, -1 + i / max, 1, 0, 0);
    //  //    glCallList(thing1);
    //  if i = 0 then  begin
    //    glAccum(GL_LOAD, 0.1);
    //  end else begin
    //    glAccum(GL_ACCUM, 0.1);
    //  end;
    //end;

    //  glClear(GL_COLOR_BUFFER_BIT);
    //  DrawRectangle(-1,-1,1,0,0);
    ////    glCallList(thing1);
    //  glAccum(GL_LOAD, 0.5);
    //
    //  glClear(GL_COLOR_BUFFER_BIT);
    ////    glCallList(thing2);
    //  DrawRectangle(-0.5,-0.5,1,0,0);
    //  glAccum(GL_ACCUM, 0.5);

    glAccum(GL_RETURN, 1.0);
    glPopMatrix;

    glutSwapBuffers;
  end;

begin
  glutInit(@argc, argv);

  glutInitDisplayMode(GLUT_RGB or GLUT_ACCUM or GLUT_DOUBLE);
//    glutInitDisplayMode(GLUT_RGB or GLUT_DOUBLE);
  glutInitWindowSize(300, 300);
  glutCreateWindow('Accum Test');

  Init;

  glutReshapeFunc(@Reshape);
  glutKeyboardFunc(@Key);
  glutDisplayFunc(@Draw);
  glutIdleFunc(@idle);
  glutMainLoop;
end.
