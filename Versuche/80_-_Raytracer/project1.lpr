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

  TSphere = record
    center: TVector3f;
    radius: single;
    material: TMaterial;
  end;

const
  ivory: TMaterial =      (refractive_index: 1.0; albedo: (0.9,  0.5, 0.1, 0.0); diffuse_color: (0.4, 0.4, 0.3); specular_exponent: 50);
  glass: TMaterial =      (refractive_index: 1.5; albedo: (0.0,  0.9, 0.1, 0.8); diffuse_color: (0.6, 0.7, 0.8); specular_exponent: 125);
  red_rubber: TMaterial = (refractive_index: 1.0; albedo: (1.4,  0.3, 0.0, 0.0); diffuse_color: (0.3, 0.1, 0.1); specular_exponent: 10);
  mirror: TMaterial =     (refractive_index: 1.0; albedo: (0.0, 16.0, 0.8, 0.0); diffuse_color: (1.0, 1.0, 1.0); specular_exponent: 1425);

  spheres: array of TSphere = (
    (center: (-3, 0, -16); radius: 2),
    (center: (-1, -1.5, -12); radius: 2),
    (center: (1.5, -0.5, -18); radius: 3),
    (center: (-7, 5, -18); radius: 4),
    (center: (7, 5, -18); radius: 4));

  //  spheres: array of TSphere = ((center: (-3, 0, -16); radius: 2; material:ivory));

  procedure SetSpheresMaterial;
  begin
    spheres[0].material := ivory;
    spheres[1].material := glass;
    spheres[2].material := red_rubber;
    spheres[3].material := mirror;
    spheres[4].material := mirror;
  end;

var
  lights: array of TVector3f = (
    (-20, 20, 20),
    (30, 50, -25),
    (30, 20, 30));

  z: integer = 0;

var
  defaultMaterial: TMaterial = (refractive_index: 1; albedo: (2, 0, 0, 0); diffuse_color: (0, 0, 0); specular_exponent: 0);

type
  Tscene_tuple = record
    b: boolean;
    v0, v1: TVector3f;
    Matrial: TMaterial;
  end;

  Tspere_tuple = record
    intersection: boolean;
    d: single;
  end;

  function reflect(const I, N: TVector3f): TVector3f;
  begin
    Result := I - N * 2.0 * (I * N);
  end;

  function refract(const I, N: TVector3f; const eta_t: single; const eta_i: single = 1): TVector3f;
  var
    cosi, eta, k: single;
  begin
    cosi := - max(-1.0, min(1.0, I * N));
    if cosi < 0 then begin
      Result:=refract(I, vec3(0, 0, 0) - N, eta_i, eta_t);
      Exit();
    end;
    eta := eta_i / eta_t;
    k := 1 - eta * eta * (1 - cosi * cosi);
    if k < 0 then begin
      Result := vec3(1, 0, 0);
    end else begin
      Result := I * eta + N * (eta * cosi - Sqrt(k));
    end;
  end;

  function ray_sphere_intersect(const orig, dir: TVector3f;const s: TSphere): Tspere_tuple;
  var
    L: TVector3f;
    thc, tca, d2, t0, t1: single;
  begin
    L := s.center - orig;
    tca := L * dir;
    d2 := L * L - tca * tca;
    if d2 > s.radius * s.radius then begin
      Result.intersection := False;
      Result.d := 0;
      exit;
    end;
    thc := Sqrt(s.radius * s.radius - d2);
    t0 := tca - thc;
    t1 := tca + thc;
    if t0 > 0.001 then begin
      Result.intersection := True;
      Result.d := t0;
      exit;
    end;
    if t1 > 0.001 then begin
      Result.intersection := True;
      Result.d := t1;
      exit;
    end;
    Result.intersection := False;
    Result.d := 0;
  end;

  function scene_intersect(const orig, dir: TVector3f): Tscene_tuple;
  var
    pt, N, p: TVector3f;
    material: TMaterial;
    d: single;
    dc: cint;
    auto: Tspere_tuple;
    s: TSphere;
    intersection: boolean;
    i: integer;
    nearest_dist: single=1e10;
  begin
    material := defaultMaterial;

    if abs(dir.y) > 0.001 then begin
      d := -(orig.y + 4) / dir.y;
      p := orig + dir * d;
      if (d > 0.001) and (d < nearest_dist) and (abs(p.x) < 10) and (p.z < -10) and (p.z > -30) then begin
        nearest_dist := d;
        pt := p;
        N := vec3(0, 1, 0);

        dc := Round(0.5 * pt.x + 1000) + Round(0.5 * pt.z);
        if (dc and 1) <> 0 then  begin
          material.diffuse_color := vec3(0.3, 0.3, 0.3);
        end else begin
          material.diffuse_color := vec3(0.3, 0.2, 0.1);
        end;
      end;
    end;

    for i := 0 to Length(spheres) - 1 do begin
      s := spheres[i];
      auto := ray_sphere_intersect(orig, dir, s);
      intersection := auto.intersection;
      d := auto.d;

      if (not intersection) or (d > nearest_dist) then begin
        Continue;
      end;
      nearest_dist := d;
      pt := orig + dir * nearest_dist;
      N := pt - s.center;
      N.Normalize;
      material := s.material;
    end;
    Result.b := nearest_dist < 1000;
    Result.v0 := pt;
    Result.v1 := N;
    Result.Matrial := material;
  end;

  function cast_ray(const orig, dir: TVector3f; depth: int = 0): TVector3f;
  var
    auto: Tscene_tuple;
    hit: boolean;
    point, N, reflect_dir, refract_dir, reflect_color, refract_color, light, light_dir, shadow_pt, trashnmr, r: TVector3f;
    material, trasmat: TMaterial;
    diffuse_light_intensity, specular_light_intensity: single;
    i: integer;
  begin
    auto := scene_intersect(orig, dir);
    hit := auto.b;
    point := auto.v0;
    N := auto.v0;
    material := auto.Matrial;

   //Write(depth, ' ');
    Inc(z);


    if (depth > 4) or (not hit) then begin
      Exit(vec3(0.2, 0.7, 0.8));
    end;


    reflect_dir := reflect(dir, N);
    reflect_dir.Normalize;

    refract_dir := refract(dir, N, material.refractive_index);
    refract_dir.Normalize;

    reflect_color := cast_ray(point, reflect_dir, depth + 1);
    refract_color := cast_ray(point, refract_dir, depth + 1);

    diffuse_light_intensity := 0.0;
    specular_light_intensity := 0.0;

    for i := 0 to Length(lights) - 1 do begin
      light := lights[i];

      light_dir := light - point;
      light_dir.Normalize;

      auto := scene_intersect(point, light_dir);
      hit := auto.b;
      shadow_pt := auto.v0;
      trashnmr := auto.v1;
      trasmat := auto.Matrial;

      if (hit) and ((shadow_pt - point).Length < (light - point).Length) then begin
        Continue;
      end;
      diffuse_light_intensity += max(0, light_dir * N);

      r := vec3(0, 0, 0) - reflect(vec3(0, 0, 0) - light_dir, N);
      specular_light_intensity += power(max(0, r * dir), material.specular_exponent);
    end;

    Result := material.diffuse_color * diffuse_light_intensity * material.albedo[0] +
       vec3(1, 1, 1) * specular_light_intensity * material.albedo[1] +
       reflect_color * material.albedo[2] +
       refract_color * material.albedo[3];
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

    dir_x, dir_y, dir_z, mx: single;
    v, color: TVector3f;

  begin
    SetSpheresMaterial; // Geht nicht anders.
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
    win := XCreateSimpleWindow(dis, rootWin, 10, 10, Width, Height, 1, BlackPixel(dis, scr), WhitePixel(dis, scr));
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
      color:=frambuffer[i];

      mx:=max(1,max(color[0],max(color[1],color[2])));
      for j := 0 to 2 do begin
//        imageBuffer[i, j] := Round(frambuffer[i, 2-j] * 255);
        imageBuffer[i, 2-j] := Round(255 * color[j]/mx);
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

    WriteLn('Ende: ', z);

    Result := 0;
  end;

begin
  main;
end.
