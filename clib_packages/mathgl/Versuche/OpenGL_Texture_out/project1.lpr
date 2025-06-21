program project1;

uses
  Math,
  gl,
  glut,
  mgl_pas;

const
  Width = 1600;
  Height = 1200;

var
  rgb: pbyte;

  procedure display; cdecl;
  begin
    glClear(GL_COLOR_BUFFER_BIT);
    glDrawPixels(Width, Height, GL_RGBA, GL_UNSIGNED_BYTE, rgb);
    glutSwapBuffers;
  end;

  procedure key_press(c: byte; v1, v2: integer); cdecl;
  begin
    WriteLn('press');
    if c = 27 then begin
      halt;
    end;
  end;

  // https://mathgl.sourceforge.net/doc_en/OpenGL-output.html#OpenGL-output


// https://mathgl.sourceforge.net/doc_en/indirect-sample.html
procedure plot2(gr: HMGL);
begin
  mgl_subplot(gr,1,1,0,'');
  mgl_title(gr,'SubData vs Evaluate','',-1);


  mgl_finish(gr);
  end;

  procedure plot(gr: HMGL);
  begin

    mgl_subplot(gr, 1, 1, 0, '');
    mgl_rotate(gr, 40, 60, 0);
    mgl_set_light(gr, 1);
    mgl_add_light(gr, 0, 0, 0, 10);
    mgl_add_light(gr, 0, 0, 0, -1);
    mgl_axis(gr, '', '', '');
    mgl_box(gr);
    mgl_fplot(gr, 'sin(pi*x)', 'i2', '');
    mgl_fplot(gr, 'cos(pi*x)', '|', '');
    mgl_fsurf(gr, 'cos(2*pi*(x^2+y^2))', '', '');
    mgl_finish(gr);
  end;

  procedure main;
  var
    gr: HMGL;
  begin
//    gr := mgl_create_graph(Width, Height);

//    gr:=    mgl_create_graph_fltk(nil, 'Titel',nil);
//    gr:=    mgl_create_graph_glut(nil, 'Titel',nil);
    gr:=    mgl_create_graph_qt(nil, 'Titel',nil);
    plot(gr);
//    plot2(gr);
    rgb := mgl_get_rgba(gr);

    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE);
    glutInitWindowSize(Width, Height);
    glutInitWindowPosition(100, 100);
    glutCreateWindow('Math GL Example');

    glClearColor(Random, 0.5, 0.3, 1.0);
    glutDisplayFunc(@display);
    glutKeyboardFunc(@key_press);

    glutMainLoop();

    mgl_delete_graph(gr);
    WriteLn('Ende');
  end;

begin
  SetExceptionMask([exDenormalized, exInvalidOp, exOverflow, exPrecision, exUnderflow, exZeroDivide]);
  main;
end.
