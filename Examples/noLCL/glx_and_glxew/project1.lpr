program project1;

uses
  x,
  xlib,
  xutil,
  fp_glew,
  fp_glxew,
  fp_glx;

const
  SIZE = 512;
  hello='Hello World';

  procedure main;
  var
    dpy: PDisplay;
    root, win: TWindow;
    exts: string;
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
    running: Boolean = True;
    xev: TXEvent;
    screen: integer;

  const
    fbAttribs: array of integer = (
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

    pixmapAttribs: array of integer = (
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
    if Pos('GLX_EXT_texture_from_pixmap', exts) = 0 then begin
      WriteLn('Extension GLX_EXT_texture_from_pixmap nicht unterstützt');
      XCloseDisplay(dpy);
      Exit;
      ;
    end;

    fbConfigs := glXChooseFBConfig(dpy, screen, PLongint(fbAttribs), @fbCount);
    if (fbConfigs = nil) or (fbCount = 0) then begin
      WriteLn('Keine passenden FBConfig gefunden');
      XCloseDisplay(dpy);
      Exit;
    end;

    fbConfig := fbConfigs[0];
    XFree(fbConfigs);

    vi := glXGetVisualFromFBConfig(dpy, fbConfig);
    if vi = nil then begin
      WriteLn('Kein passendes Visual gefunden');
      XCloseDisplay(dpy);
      Exit;
    end;

    cmap := XCreateColormap(dpy, root, vi^.visual, AllocNone);
    swa.colormap := cmap;
    swa.event_mask := ExposureMask or KeyPressMask;
    swa.border_pixel := 0;

    win := XCreateWindow(dpy, root, 0, 0, SIZE, SIZE, 0, vi^.depth, InputOutput, vi^.visual, CWBorderPixel or CWColormap or CWEventMask, @swa);
    if win = 0 then begin
      WriteLn('Fenster konnte nicht erstellt werden');
      XCloseDisplay(dpy);
      Exit;
    end;
    XMapWindow(dpy, win);
    XStoreName(dpy, win, 'GLX Texture From Pixmap');

    glc := glXCreateNewContext(dpy, fbConfig, GLX_RGBA_TYPE, nil, 1);
    if glc = nil then begin
      WriteLn('Kann GLX Kontext nicht erstellen');
      XDestroyWindow(dpy, win);
      XCloseDisplay(dpy);
      Exit;
    end;

    glXMakeCurrent(dpy, win, glc);

    if glxewInit <> GLEW_OK then begin
      WriteLn('glxewInit Fehler');
      Halt(1);
    end;

    pixmap := XCreatePixmap(dpy, root, SIZE, SIZE, vi^.depth);
    gc := XCreateGC(dpy, pixmap, 0, nil);

    XSetForeground(dpy, gc, $0000FF);
    XFillRectangle(dpy, pixmap, gc, 0, 0, SIZE, SIZE);

    glxPixmap := glXCreatePixmap(dpy, fbConfig, pixmap, PLongint(pixmapAttribs));
    if glxPixmap = 0 then begin
      WriteLn('Kann GLXPixmap nicht erzeugen');
      XDestroyWindow(dpy, win);
      XCloseDisplay(dpy);
      Exit;
    end;

    // === OpenGL

    if glewInit <> GLEW_OK then begin
      WriteLn('glewInit Fehler');
      Halt(1);
    end;

    glXSwapIntervalEXT(dpy, win, 10);

    glGenTextures(1, @tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glXBindTexImageEXT(dpy, glxPixmap, GLX_FRONT_LEFT_EXT, nil);

    glEnable(GL_TEXTURE_2D);
    glClearColor(0.2, 0.2, 0.2, 1.0);

    while running do begin
      XSetForeground(dpy, gc, Random($FFFFFF));
      XDrawLine(dpy, pixmap, gc, Random(SIZE), Random(SIZE), Random(SIZE), Random(SIZE));
      XSetForeground(dpy, gc, $FFFFFF);
      XDrawString(dpy, pixmap,gc, 10,10,hello, Length(hello));

      while XPending(dpy) > 0 do begin
        XNextEvent(dpy, @xev);
        case xev._type of
          KeyPress: begin
            running := False;
          end;
          Expose: begin
            glViewport(0, 0, xev.xexpose.width, xev.xexpose.height);
          end;
        end;
      end;
      glClear(GL_COLOR_BUFFER_BIT);
      glBindTexture(GL_TEXTURE_2D, tex);

      glRotatef(0.1, 0.0, 0.0, 1.0);

      glBegin(GL_QUADS);
      glTexCoord2f(0, 1);
      glVertex2f(-0.7, -0.7);
      glTexCoord2f(1, 1);
      glVertex2f(0.7, -0.7);
      glTexCoord2f(1, 0);
      glVertex2f(0.7, 0.7);
      glTexCoord2f(0, 0);
      glVertex2f(-0.7, 0.7);
      glEnd();

      glXSwapBuffers(dpy, win);
    end;

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

begin
  main;
end.
