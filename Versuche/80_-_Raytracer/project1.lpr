program project1;

uses
  Math,
  BaseUnix,
  jpeglib,
  jmorecfg,
  xlib,
  xutil,
  keysym,
  x,
  oglVector;

type
  TMaterial = record
    refractive_index: single;
    albedo: TVector4f;
    diffuse_color: TVector3f;
    specular_exponent: single;
  end;

var
  defaultMaterial: TMaterial = (refractive_index: 1; albedo: (2, 0, 0, 0); diffuse_color: (0, 0, 0); specular_exponent: 0);

type
  Tscene_tuple = record
    b: boolean;
    v0, v1: TVector3f;
    Matrial: TMaterial;
  end;

  function reflect(const I,N:TVector3f):TVector3f;
  begin Result:=I-N*2*(I*N);
    end;

  function scene_intersect(const orig, dir: TVector3f): Tscene_tuple;
  begin
    ////////////
  end;

  function cast_ray(const orig, dir: TVector3f; depth: int = 0): TVector3f;
  var
    auto: Tscene_tuple;
    hit: boolean;
    point, N: TVector3f;
  begin
    auto := scene_intersect(orig, dir);
    hit := auto.b;
    point := auto.v0;
    N := auto.v0;
    if (depth > 4) or (not hit) then begin
      Result := vec3(0.2, 0.7, 0.8);
    end;

   ///////// reflect_dir:=

  end;

  function main: cint;
  const
    EventMask = KeyPressMask or ExposureMask or PointerMotionMask or ButtonPressMask;

  var
    dis: PDisplay;
    win, rootWin: TWindow;
    Event: TXEvent;
    scr: cint;
    gc: TGC;
    image: PXImage;
    visual: PVisual;

    Width: DWord = 1024;
    Height: DWord = 768;
    fov: single = 1.05;

    frambuffer: array of TVector3f = nil;
    imageBuffer: array of array[0..3] of byte = nil;
    i, j: integer;

    dir_x, dir_y, dir_z: single;
    v: TVector3f;

  begin
    // Buffer erzeugen

    SetLength(frambuffer, Width * Height);
    SetLength(imageBuffer, Length(frambuffer));

    for i := 0 to Length(frambuffer) - 1 do begin
      frambuffer[i] := vec3(Random, Random, Random);
    end;

    // X11

    dis := XOpenDisplay(nil);
    if dis = nil then begin
      WriteLn('Kann nicht das Display öffnen');
      Halt(1);
    end;
    scr := DefaultScreen(dis);
    gc := DefaultGC(dis, scr);
    rootWin := RootWindow(dis, scr);
    win := XCreateSimpleWindow(dis, rootWin, 10, 10, 640, 480, 1, BlackPixel(dis, scr), WhitePixel(dis, scr));
    XStoreName(dis, win, 'Webcam-Fenster');
    XSelectInput(dis, win, EventMask);
    XMapWindow(dis, win);

    gc := XCreateGC(dis, win, 0, nil);

    visual := DefaultVisual(dis, scr);
    image := XCreateImage(dis, visual, 24, ZPixmap, 0, nil, Width, Height, 32, 0);

    // Rendern

    for i := 0 to Length(frambuffer) - 1 do begin
      dir_x := (i mod Width + 0.5) - Width / 2;
      dir_y := -(i div Width + 0.5) + Height / 2;
      dir_z := -Height / (2 * tan(fov / 2));
      v := vec3(dir_x, dir_y, dir_z);
      v.Normalize;
      frambuffer[i] := cast_ray(vec3(0, 0, 0), v);
    end;

    // Framebuffer to ImageBuffer

    for i := 0 to Length(frambuffer) - 1 do begin
      for j := 0 to 2 do begin
        imageBuffer[i, j] := Round(frambuffer[i, j] * 255);
      end;
    end;

    while (True) do begin
      if XPending(dis) > 0 then begin
        XNextEvent(dis, @Event);
        case Event._type of
          Expose: begin
          end;
          ButtonPress: begin
            XRaiseWindow(dis, Event.xbutton.window);
          end;
          KeyPress: begin
            if XLookupKeysym(@Event.xkey, 0) = XK_Escape then begin
              Break;
            end;
          end;
        end;
      end else begin

        image^.Data := pansichar(imageBuffer);
        XPutImage(dis, win, gc, image, 0, 0, 0, 0, Width, Height);
      end;
    end;

    Result := 0;
  end;

begin
  main;
end.
