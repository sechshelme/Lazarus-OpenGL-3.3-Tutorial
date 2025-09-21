program project1;

uses
  x,
  xlib,
  xutil,
  ctypes,

  fp_glew,
  fp_glxew;

  procedure drawInPixmap(dpy: PDisplay; pixmap: TPixmap; gc: TGC; width, height: integer);
  begin
    XSetForeground(dpy, gc, $0000FF);
    XFillRectangle(dpy, pixmap, gc, 0, 0, width, height);
    XSetForeground(dpy, gc, $FFFFFF);
    XDrawLine(dpy, pixmap, gc, 10, 10, width - 10, height - 10);
    XDrawLine(dpy, pixmap, gc, width - 10, 10, 10, height - 10);
  end;


  procedure main;
  var
    dpy: PDisplay;
    screen: cint;
    root, win: TWindow;
    exts: pchar;
    fbConfigs: PGLXFBConfig;
    fbCount: integer;
    fbConfig: TGLXFBConfig;
    vi: PXVisualInfo;
    cmap: TColormap;
    swa: TXSetWindowAttributes;
    glc: TGLXContext;
    pixmap: TPixmap;
    gc: TGC;
    glxPixmap: TGLXPixmap;
    tex: TGLuint;
    running: integer = 1;
    xev: TXEvent;

  const
    fbAttribs: array[0..20] of integer = (
      GLX_X_RENDERABLE, 1,
      GLX_DRAWABLE_TYPE, GLX_WINDOW_BIT or GLX_PIXMAP_BIT,
      GLX_RENDER_TYPE, GLX_RGBA_BIT,
      GLX_BIND_TO_TEXTURE_RGBA_EXT, 1,
      GLX_DOUBLEBUFFER, 1,
      GLX_RED_SIZE, 8,
      GLX_GREEN_SIZE, 8,
      GLX_BLUE_SIZE, 8,
      GLX_ALPHA_SIZE, 8,
      GLX_DEPTH_SIZE, 24,
      0);

    pixmapAttribs: array [0..4] of integer = (
      GLX_TEXTURE_TARGET_EXT, GLX_TEXTURE_2D_EXT,
      GLX_TEXTURE_FORMAT_EXT, GLX_TEXTURE_FORMAT_RGBA_EXT,
      0);

  begin
    dpy := XOpenDisplay(nil);
    if dpy = nil then begin
      WriteLn('Kann X-Display nicht öffnen');
      Exit;
    end;

    screen := DefaultScreen(dpy);
    root := RootWindow(dpy, screen);

    exts := glXQueryExtensionsString(dpy, screen);
    //    if (!strstr(exts, "GLX_EXT_texture_from_pixmap")) {
    //        fprintf(stderr, "Extension GLX_EXT_texture_from_pixmap nicht unterstützt\n");
    //        XCloseDisplay(dpy);
    //        return 1;
    //    }

    WriteLn(1111111);
    WriteLn(PtrUInt(glXChooseFBConfig));
    fbConfigs := glXChooseFBConfig(dpy, screen, fbAttribs, @fbCount);
    WriteLn(1111111);
    if (fbConfigs = nil) or (fbCount = 0) then begin
      WriteLn('Keine passenden FBConfig gefunden');
      XCloseDisplay(dpy);
      Exit;
      ;
    end;

    fbConfig := fbConfigs[0];
    XFree(fbConfigs);

    // --- KORREKTUR 2: XVisualInfo aus FBConfig holen ---
    vi := glXGetVisualFromFBConfig(dpy, fbConfig);
    if vi = nil then begin
      WriteLn('Kein passendes Visual gefunden');
      XCloseDisplay(dpy);
      Exit;
    end;

    // --- KORREKTUR 3: Colormap und Fensterattribute erstellen ---
    cmap := XCreateColormap(dpy, root, vi^.visual, AllocNone);
    swa.colormap := cmap;
    swa.event_mask := ExposureMask or KeyPressMask;
    swa.border_pixel := 0;

    // --- KORREKTUR 4: Fenster mit XCreateWindow und dem korrekten Visual erstellen ---
    win := XCreateWindow(dpy, root, 10, 10, 400, 400, 0,
      vi^.depth, InputOutput, vi^.visual,
      CWBorderPixel or CWColormap or CWEventMask, @swa);
    if win = 0 then begin
      WriteLn('Fenster konnte nicht erstellt werden');
      XCloseDisplay(dpy);
      Exit;
    end;
    XMapWindow(dpy, win);
    XStoreName(dpy, win, 'GLX Texture From Pixmap');

    // OpenGL Kontext mit FBConfig erzeugen
    glc := glXCreateNewContext(dpy, fbConfig, GLX_RGBA_TYPE, nil, 1);
    if glc = nil then begin
      WriteLn('Kann GLX Kontext nicht erstellen');
      XDestroyWindow(dpy, win);
      XCloseDisplay(dpy);
      Exit;
    end;

    glXMakeCurrent(dpy, win, glc);

    // Pixmap erzeugen (Tiefe vom Visual nehmen)
    pixmap := XCreatePixmap(dpy, root, 400, 400, vi^.depth);
    gc := XCreateGC(dpy, pixmap, 0, nil);
    drawInPixmap(dpy, pixmap, gc, 400, 400);


    glxPixmap := glXCreatePixmap(dpy, fbConfig, pixmap, pixmapAttribs);
    if glxPixmap = 0 then begin
      WriteLn('Kann GLXPixmap nicht erzeugen');
      // ... (cleanup code)
      Exit;
    end;



    // Extension-Funktionen laden
    //    PFNGLXBINDTEXIMAGEEXTPROC glXBindTexImageEXT =
    //        (PFNGLXBINDTEXIMAGEEXTPROC)glXGetProcAddressARB((const GLubyte *)"glXBindTexImageEXT");
    //    PFNGLXRELEASETEXIMAGEEXTPROC glXReleaseTexImageEXT =
    //        (PFNGLXRELEASETEXIMAGEEXTPROC)glXGetProcAddressARB((const GLubyte *)"glXReleaseTexImageEXT");

    //    if (!glXBindTexImageEXT || !glXReleaseTexImageEXT) {
    //        fprintf(stderr, "glXBindTexImageEXT oder glXReleaseTexImageEXT nicht verfügbar\n");
    //        // ... (cleanup code)
    //        return 1;
    //    }

    // Textur erzeugen und binden
    //    GLuint tex;
    glGenTextures(1, @tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glXBindTexImageEXT(dpy, glxPixmap, GLX_FRONT_LEFT_EXT, nil);

    glEnable(GL_TEXTURE_2D);
    glClearColor(0.2, 0.2, 0.2, 1.0); // Hintergrund grau, falls Quad kleiner wäre

    // Event-Loop
    //    XEvent xev;
    while running = 1 do begin

      XDrawLine(dpy, pixmap, gc, Random(500), Random(500), Random(500), Random(500));

      //    XDrawLine(dpy, pixmap, gc, 10,10, 500, 200);


      XNextEvent(dpy, @xev);
      case xev._type of
        KeyPress: begin
          running := 0;
        end;
        Expose: begin
          glClear(GL_COLOR_BUFFER_BIT);
          glBindTexture(GL_TEXTURE_2D, tex); // Sicherstellen, dass die Textur gebunden ist

          // Zeichne ein Quadrat, das das ganze Fenster füllt
          glBegin(GL_QUADS);
          glTexCoord2f(0, 1);
          glVertex2f(-1, -1); // Texturkoordinaten müssen evtl. gespiegelt werden
          glTexCoord2f(1, 1);
          glVertex2f(1, -1); // Y-Achse ist bei X11/OpenGL oft umgekehrt
          glTexCoord2f(1, 0);
          glVertex2f(1, 1);
          glTexCoord2f(0, 0);
          glVertex2f(-1, 1);
          glEnd();

          glXSwapBuffers(dpy, win);
        end;

      end;

      // Aufräumen
      glXReleaseTexImageEXT(dpy, glxPixmap, GLX_FRONT_LEFT_EXT);
      glDeleteTextures(1, @tex);
      glXDestroyPixmap(dpy, glxPixmap);
      glXMakeCurrent(dpy, None, nil);
      glXDestroyContext(dpy, glc);
      XFreeGC(dpy, gc);
      XFreePixmap(dpy, pixmap);
      XDestroyWindow(dpy, win);
      XFreeColormap(dpy, cmap);
      XFree(vi);
      XCloseDisplay(dpy);
    end;
  end;

begin
  main;
end.
