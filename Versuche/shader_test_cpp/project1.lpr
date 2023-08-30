program project1;

uses
  BaseUnix,
  dglOpenGL,
//  gl,
//  glu,
  glut,
//  GLext,
  oglVector,
  oglMatrix;

const
  NATOMS = 1000;
  RAND_MAX = 32767;
  camera: TVector3f = (0.6, 0, 1);
  light0_position: TVector4f = (1, 1, 1, 0);
  SCREEN_WIDTH = 1024;
  SCREEN_HEIGHT = 1024;

  RENDER_SPHERES_INSTEAD_OF_VERTICES: boolean = False;
var
  atoms: array of TVector5f = nil;
  angle: TGLfloat = 0.72;
  cur_camera: TVector3f = (0, 0, 0);
  prog_hdlr: TGLuint;
  location_attribute_0, location_viewport: TGLint;


  function rand_minus_one_one: TGLfloat;
  var
    i: integer;
  begin
    i := Random(2) * 2 - 1;
    Result := Random / RAND_MAX * i;
/////G/G(/7    WriteLn(Result: 10: 5);
  end;

  function rand_zero_one: TGLfloat;
  begin
    Result := Random / RAND_MAX;
  end;

  procedure render_scene; cdecl;
  var
    i: integer;
  begin
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    cur_camera[0] := cos(angle) * camera[0] + sin(angle) * camera[2];
    cur_camera[1] := camera[1];
    cur_camera[2] := cos(angle) * camera[2] - sin(angle) * camera[0];

    //    angle+=0.01;

    gluLookAt(cur_camera[0], cur_camera[1], cur_camera[2], 0, 0, 0, 0, 1, 0);


    if RENDER_SPHERES_INSTEAD_OF_VERTICES then  begin
      for  i := 0 to NATOMS - 1 do begin
        glColor3f(atoms[i][4], atoms[i][5], atoms[i][6]);
        glPushMatrix();
        glTranslatef(atoms[i][0], atoms[i][1], atoms[i][2]);
        glutSolidSphere(atoms[i][3], 16, 16);
        glPopMatrix();
      end;
    end else begin
      //
      //       glUseProgram(prog_hdlr);
      //    GLfloat viewport[4];
      //    glGetFloatv(GL_VIEWPORT, viewport);
      //    glUniform4fv(location_viewport, 1, viewport);
      //    glBegin(GL_POINTS);
      //    for  i := 0 to NATOMS - 1 do begin
      //      glColor3f(atoms[i][4], atoms[i][5], atoms[i][6]);
      //      glVertexAttrib1f(location_attribute_0, atoms[i][3]);
      //      glVertex3f(atoms[i][0], atoms[i][1], atoms[i][2]);
      //      end;
      //    glEnd();
      //    glUseProgram(0);
    end;

    glutSwapBuffers();
  end;

  procedure process_keys(c: byte; v1, v2: integer); cdecl;
  begin
    if c = 27 then begin
      Halt(0);
    end;
  end;

  procedure change_size(w, h: integer); cdecl;
  var
    ratio: GLfloat;
    r: integer;
  begin
    if h = 0 then begin
      r := 1;
    end else begin
      r := h;
    end;
    //    ratio := (1.0*w)/(!h?1:h);
    ratio := (1.0 * w) / r;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(90, ratio, 0.1, 100);
    //    glOrtho(-1,1,-1,1,-2,2);
    glMatrixMode(GL_MODELVIEW);
    glViewport(0, 0, w, h);
  end;

  function read_n_compile_shader(filename: PChar; var hdlr: TGLuint; shaderType: TGLenum): boolean;
  var
    fin: file;
    buf: array[0..10000] of AnsiChar;
//    buf: AnsiString;
    NumRead: int64 = 0;
    i: integer;
    FD: cint;
    ac:AnsiString;
    log_size:TGLint;
  begin
    //std::ifstream is(filename, std::ios::in|std::ios::binary|std::ios::ate);
    //if (!is.is_open()) {
    //  std::cerr << "Unable to open file " << filename << std::endl;
    //  return false;
    //}
    //long size = is.tellg();
    //char *buffer = new char[size+1];
    //is.seekg(0, std::ios::beg);
    //is.read (buffer, size);
    //is.close();
    //buffer[size] = 0;

//    AssignFile(fin, filename);
//    Reset(Fin, 1);
//    BlockRead(fin, buf, NumRead);
  //  Close(fin);

    FillChar(buf, 10000,0);
    FD:=FpOpen(filename,O_RDONLY);
    if FD>0 then FpRead(FD, @buf[1], 10000);
    FpClose(FD);

    //      for i:=0 to Length(buf)-1 do Write(buf[i]);
    ac:=buf;
    WriteLn(ac);

    hdlr := glCreateShader(shaderType);

    WriteLn('xxxxxxxxxxxxxxxxxxxx', filename);
    glShaderSource(hdlr, 1, @ac, nil);
    WriteLn('xxxxxxxxxxxxxxxxxxxx', filename);
    glCompileShader(hdlr);
    //  std::cerr << "info log for " << filename << std::endl;

    glGetProgramiv(hdlr, GL_INFO_LOG_LENGTH, @log_size);
    WriteLn('...........'    , log_size);


    //  printInfoLog(hdlr);
    Result := True;
  end;

  procedure setShaders(var prog_hdlr: TGLuint; vsfile, fsfile: PChar);
  var
    vert_hdlr: GLuint = 0;
    frag_hdlr: GLuint = 0;
  begin
    read_n_compile_shader(vsfile, vert_hdlr, GL_VERTEX_SHADER);
    read_n_compile_shader(fsfile, frag_hdlr, GL_FRAGMENT_SHADER);

    prog_hdlr := glCreateProgram();
    glAttachShader(prog_hdlr, frag_hdlr);
    glAttachShader(prog_hdlr, vert_hdlr);

    glLinkProgram(prog_hdlr);
    //      std::cerr << "info log for the linked program" << std::endl;
    //      printInfoLog(prog_hdlr);
  end;

  procedure main;
  var
    i, c: integer;
    index: integer = 0;
    tmp: TVector5f;
  begin
    InitOpenGL();
    ReadOpenGLCore;
    ReadImplementationProperties;


    SetLength(atoms, NATOMS);
    for i := 0 to NATOMS - 1 do begin
      for c := 0 to 3 - 1 do begin
        tmp[c] := rand_minus_one_one / 2;
      end;
      tmp[3] := rand_zero_one / 8;
      for c := 0 to 3 - 1 do begin
        tmp[c + 4] := rand_zero_one;
      end;
      atoms[i] := tmp;
    end;
    glutInit(@argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE or GLUT_RGB or GLUT_DEPTH);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(SCREEN_WIDTH, SCREEN_HEIGHT);
    glutCreateWindow('GLSL tutorial');

    glutDisplayFunc(@render_scene);
    glutReshapeFunc(@change_size);
    glutKeyboardFunc(@process_keys);

    glClearColor(0.0, 0.0, 1.0, 1.0);
    //  glutIdleFunc(render_scene);

    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightfv(GL_LIGHT0, GL_POSITION, light0_position);

    if not RENDER_SPHERES_INSTEAD_OF_VERTICES then begin

      //glewInit();
      //if (GLEW_ARB_vertex_shader && GLEW_ARB_fragment_shader && GL_EXT_geometry_shader4)
      //  std::cout << "Ready for GLSL - vertex, fragment, and geometry units" << std::endl;
      //end
      //else {
      //  std::cout << "No GLSL support" << std::endl;
      //  exit(1);
      //}

      setShaders(prog_hdlr, 'vert.glsl', 'frag.glsl');

      location_attribute_0 := glGetAttribLocation(prog_hdlr, 'R' + '');          // radius
      location_viewport := glGetUniformLocation(prog_hdlr, 'viewport'); // viewport

      glEnable(GL_VERTEX_PROGRAM_POINT_SIZE);
    end;
    glutMainLoop();
  end;

begin
  main;
end.
