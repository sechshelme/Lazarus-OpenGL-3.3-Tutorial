program project1;

uses
  x, xlib, xutil, ctypes,

  fp_glew,
  fp_glxew,
  fp_glfw3;

procedure drawInPixmap(dpy:PDisplay; pixmap: TPixmap;  gc:TGC; width, height:Integer);
begin
    XSetForeground(dpy, gc, $0000FF);
    XFillRectangle(dpy, pixmap, gc, 0, 0, width, height);
    XSetForeground(dpy, gc, $FFFFFF);
    XDrawLine(dpy, pixmap, gc, 10,10, width-10, height-10);
    XDrawLine(dpy, pixmap, gc, width-10,10, 10, height-10);
end;


procedure main;
var
  dpy: PDisplay;
  screen: cint;
  root: TWindow;
  exts: PChar;
  fbConfigs: PGLXFBConfig;
  fbCount:Integer;
  fbConfig: TGLXFBConfig;
  vi: PXVisualInfo;
const
  fbAttribs: array[0..20] of Integer = (
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
    0  );

begin
   dpy := XOpenDisplay(nil);
    if dpy=nil then begin
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


   fbConfigs := glXChooseFBConfig(dpy, screen, fbAttribs, @fbCount);
    if (fbConfigs=nil)or( fbCount = 0) then begin
        WriteLn('Keine passenden FBConfig gefunden');
        XCloseDisplay(dpy);
        Exit;;
    end;

    fbConfig := fbConfigs[0];
    XFree(fbConfigs);

    // --- KORREKTUR 2: XVisualInfo aus FBConfig holen ---
    vi := glXGetVisualFromFBConfig(dpy, fbConfig);
    if vi=nil then begin
        WriteLn('Kein passendes Visual gefunden');
        XCloseDisplay(dpy);
        Exit;;
    end;

    // --- KORREKTUR 3: Colormap und Fensterattribute erstellen ---
    Colormap cmap = XCreateColormap(dpy, root, vi->visual, AllocNone);
    XSetWindowAttributes swa;
    swa.colormap = cmap;
    swa.event_mask = ExposureMask | KeyPressMask;
    swa.border_pixel = 0;

    // --- KORREKTUR 4: Fenster mit XCreateWindow und dem korrekten Visual erstellen ---
    Window win = XCreateWindow(dpy, root, 10, 10, 400, 400, 0,
                               vi->depth, InputOutput, vi->visual,
                               CWBorderPixel | CWColormap | CWEventMask, &swa);
    if (!win) {
        fprintf(stderr, "Fenster konnte nicht erstellt werden\n");
        XCloseDisplay(dpy);
        return 1;
    }
    XMapWindow(dpy, win);
    XStoreName(dpy, win, "GLX Texture From Pixmap");

    // OpenGL Kontext mit FBConfig erzeugen
    GLXContext glc = glXCreateNewContext(dpy, fbConfig, GLX_RGBA_TYPE, NULL, True);
    if (!glc) {
        fprintf(stderr, "Kann GLX Kontext nicht erstellen\n");
        XDestroyWindow(dpy, win);
        XCloseDisplay(dpy);
        return 1;
    }
    glXMakeCurrent(dpy, win, glc);

    // Pixmap erzeugen (Tiefe vom Visual nehmen)
    Pixmap pixmap = XCreatePixmap(dpy, root, 400, 400, vi->depth);
    GC gc = XCreateGC(dpy, pixmap, 0, NULL);
    drawInPixmap(dpy, pixmap, gc, 400, 400);

    int pixmapAttribs[] = {
        GLX_TEXTURE_TARGET_EXT, GLX_TEXTURE_2D_EXT,
        GLX_TEXTURE_FORMAT_EXT, GLX_TEXTURE_FORMAT_RGBA_EXT,
        None
    };

    GLXPixmap glxPixmap = glXCreatePixmap(dpy, fbConfig, pixmap, pixmapAttribs);
    if (!glxPixmap) {
        fprintf(stderr, "Kann GLXPixmap nicht erzeugen\n");
        // ... (cleanup code)
        return 1;
    }

    // Extension-Funktionen laden
    PFNGLXBINDTEXIMAGEEXTPROC glXBindTexImageEXT =
        (PFNGLXBINDTEXIMAGEEXTPROC)glXGetProcAddressARB((const GLubyte *)"glXBindTexImageEXT");
    PFNGLXRELEASETEXIMAGEEXTPROC glXReleaseTexImageEXT =
        (PFNGLXRELEASETEXIMAGEEXTPROC)glXGetProcAddressARB((const GLubyte *)"glXReleaseTexImageEXT");

    if (!glXBindTexImageEXT || !glXReleaseTexImageEXT) {
        fprintf(stderr, "glXBindTexImageEXT oder glXReleaseTexImageEXT nicht verfügbar\n");
        // ... (cleanup code)
        return 1;
    }

    // Textur erzeugen und binden
    GLuint tex;
    glGenTextures(1, &tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glXBindTexImageEXT(dpy, glxPixmap, GLX_FRONT_LEFT_EXT, NULL);

    glEnable(GL_TEXTURE_2D);
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f); // Hintergrund grau, falls Quad kleiner wäre

    // Event-Loop
    XEvent xev;
    int running = 1;
    while (running) {

    int x1 = rand() % 100;
    int y1 = rand() % 100;
    int x2 = rand() % 100;
    int y2 = rand() % 100;

    XDrawLine(dpy, pixmap, gc, x1, y1, x2, y2);

//    XDrawLine(dpy, pixmap, gc, 10,10, 500, 200);


        XNextEvent(dpy, &xev);
        if (xev.type == KeyPress) {
            running = 0;
        } else if (xev.type == Expose) {
            glClear(GL_COLOR_BUFFER_BIT);
            glBindTexture(GL_TEXTURE_2D, tex); // Sicherstellen, dass die Textur gebunden ist

            // Zeichne ein Quadrat, das das ganze Fenster füllt
            glBegin(GL_QUADS);
                glTexCoord2f(0, 1); glVertex2f(-1, -1); // Texturkoordinaten müssen evtl. gespiegelt werden
                glTexCoord2f(1, 1); glVertex2f( 1, -1); // Y-Achse ist bei X11/OpenGL oft umgekehrt
                glTexCoord2f(1, 0); glVertex2f( 1,  1);
                glTexCoord2f(0, 0); glVertex2f(-1,  1);
            glEnd();

            glXSwapBuffers(dpy, win);
        }
    }

    // Aufräumen
    glXReleaseTexImageEXT(dpy, glxPixmap, GLX_FRONT_LEFT_EXT);
    glDeleteTextures(1, &tex);
    glXDestroyPixmap(dpy, glxPixmap);
    glXMakeCurrent(dpy, None, NULL);
    glXDestroyContext(dpy, glc);
    XFreeGC(dpy, gc);
    XFreePixmap(dpy, pixmap);
    XDestroyWindow(dpy, win);
    XFreeColormap(dpy, cmap);
    XFree(vi);
    XCloseDisplay(dpy);
  end;

begin
  glXReleaseTexImageEXT(nil,0,0);

  main;
end.
