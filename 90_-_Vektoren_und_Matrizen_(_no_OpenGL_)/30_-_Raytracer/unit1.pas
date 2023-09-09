unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Math, ctypes, GraphType,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, dglOpenGL, oglVector, oglMatrix;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  PMaterial = ^TMaterial;

  TMaterial = record
    refractive_index: single;
    albedo: TVector4f;
    diffuse_color: TVector3f;
    specular_exponent: single;
  end;

  TSphere = record
    center: TVector3f;
    radius: single;
    material: PMaterial;
  end;

const
  defaultMaterial: TMaterial = (refractive_index: 1; albedo: (2, 0, 0, 0); diffuse_color: (0, 0, 0); specular_exponent: 0);

  ivory: TMaterial = (refractive_index: 1.0; albedo: (0.9, 0.5, 0.1, 0.0); diffuse_color: (0.4, 0.4, 0.3); specular_exponent: 50);
  glass: TMaterial = (refractive_index: 1.5; albedo: (0.0, 0.9, 0.1, 0.8); diffuse_color: (0.6, 0.7, 0.8); specular_exponent: 125);
  red_rubber: TMaterial = (refractive_index: 1.0; albedo: (1.4, 0.3, 0.0, 0.0); diffuse_color: (0.3, 0.1, 0.1); specular_exponent: 10);
  mirror: TMaterial = (refractive_index: 1.0; albedo: (0.0, 16.0, 0.8, 0.0); diffuse_color: (1.0, 1.0, 1.0); specular_exponent: 1425);

  spheres: array of TSphere = (
    (center: (-3, 0, -16); radius: 2; material: @ivory),
    (center: (-1, -1.5, -12); radius: 2; material: @glass),
    (center: (1.5, -0.5, -18); radius: 3; material: @red_rubber),
    (center: (-7, 5, -18); radius: 4; material: @mirror),
    (center: (7, 5, -18); radius: 4; material: @mirror));

var
  lights: array of TVector3f = (
    (-20, 20, 20),
    (30, 50, -25),
    (30, 20, 30));

function reflect(const I, N: TVector3f): TVector3f;
begin
  Result := I - N * 2.0 * (I * N);
end;

function refract(const I, N: TVector3f; const eta_t: single; const eta_i: single = 1): TVector3f;
var
  cosi, eta, k: single;
begin
  cosi := -clamp(-1.0, 1.0, I * N);
  if cosi < 0 then begin
    Exit(refract(I, vec3(0, 0, 0) - N, eta_i, eta_t));
  end;
  eta := eta_i / eta_t;
  k := 1 - eta * eta * (1 - cosi * cosi);
  if k < 0 then begin
    Exit(vec3(1, 0, 0));
  end else begin
    Exit(I * eta + N * (eta * cosi - Sqrt(k)));
  end;
end;

procedure ray_sphere_intersect(const orig, dir: TVector3f; const s: TSphere; out intersection: boolean; out d: single);
var
  L: TVector3f;
  thc, tca, d2, t0, t1: single;
begin
  L := s.center - orig;
  tca := L * dir;
  d2 := L * L - tca * tca;
  if d2 > s.radius * s.radius then begin
    intersection := False;
    d := 0;
    exit;
  end;
  thc := Sqrt(s.radius * s.radius - d2);
  t0 := tca - thc;
  t1 := tca + thc;
  if t0 > 0.001 then begin
    intersection := True;
    d := t0;
    exit;
  end;
  if t1 > 0.001 then begin
    intersection := True;
    d := t1;
    exit;
  end;
  intersection := False;
  d := 0;
end;

procedure scene_intersect(const orig, dir: TVector3f; out b: boolean; out v0, v1: TVector3f; out material: TMaterial);
var
  pt, N, p: TVector3f;
  mat: TMaterial;
  d: single;
  dc: cint;
  s: TSphere;
  intersection: boolean;
  i: integer;
  nearest_dist: single = 1e10;
begin
  mat := defaultMaterial;

  if abs(dir.y) > 0.001 then begin
    d := -(orig.y + 4) / dir.y;
    p := orig + dir * d;
    if (d > 0.001) and (d < nearest_dist) and (abs(p.x) < 10) and (p.z < -10) and (p.z > -30) then begin
      nearest_dist := d;
      pt := p;
      N := vec3(0, 1, 0);

      dc := Round(0.5 * pt.x + 1000) + Round(0.5 * pt.z);
      if (dc and 1) <> 0 then  begin
        mat.diffuse_color := vec3(0.3, 0.1, 0.1);
      end else begin
        mat.diffuse_color := vec3(0.1, 0.3, 0.1);
      end;
    end;
  end;

  for i := 0 to Length(spheres) - 1 do begin
    s := spheres[i];
    ray_sphere_intersect(orig, dir, s, intersection, d);

    if (not intersection) or (d > nearest_dist) then begin
      Continue;
    end;
    nearest_dist := d;
    pt := orig + dir * nearest_dist;
    N := pt - s.center;
    N.Normalize;
    mat := s.material^;
  end;
  b := nearest_dist < 1000;
  v0 := pt;
  v1 := N;
  material := mat;
end;

function cast_ray(const orig, dir: TVector3f; depth: integer = 0): TVector3f;
var
  hit: boolean;
  point, N, reflect_dir, refract_dir, reflect_color, refract_color, light_dir, shadow_pt, r, dummy0: TVector3f;
  material, dummy1: TMaterial;
  diffuse_light_intensity: single = 0;
  specular_light_intensity: single = 0;
  i: integer;
begin
  scene_intersect(orig, dir, hit, point, N, material);

  if (depth > 4) or (not hit) then begin
    Exit(vec3(0.2, 0.7, 0.8));
  end;

  reflect_dir := reflect(dir, N);
  reflect_dir.Normalize;

  refract_dir := refract(dir, N, material.refractive_index);
  refract_dir.Normalize;

  reflect_color := cast_ray(point, reflect_dir, depth + 1);
  refract_color := cast_ray(point, refract_dir, depth + 1);

  for i := 0 to Length(lights) - 1 do begin
    light_dir := lights[i] - point;
    light_dir.Normalize;

    scene_intersect(point, light_dir, hit, shadow_pt, dummy0, dummy1);

    if (hit) and ((shadow_pt - point).Length < (lights[i] - point).Length) then begin
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

function render(bit: TBitmap; Width, Height: DWord): cint;
var
  i, j: integer;
  fov: single = 1.05;
  dir_x, dir_y, dir_z, mx: single;
  v, color: TVector3f;

begin
  bit.Width := Width;
  bit.Height := Height;
  bit.pixelformat := pf32bit;

  for i := 0 to Width * Height - 1 do begin
    dir_x := (i mod Width + 0.5) - Width / 2;
    dir_y := -(i div Width + 0.5) + Height / 2;
    dir_z := -Height / (2 * tan(fov / 2));
    v := vec3(dir_x, dir_y, dir_z);
    v.Normalize;
    color := cast_ray(vec3(0, 0, 0), v);

    mx := max(1, max(color[0], max(color[1], color[2])));
    for j := 0 to 2 do begin
      bit.RawImage.Data[i * 4 + j] := Round(255 * color[j] / mx);
    end;
    bit.RawImage.Data[i * 4 + 3] := $FF;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 1024;
  Height := 768;
  //remove-
  Randomize;
  render(Image1.Picture.Bitmap, Width, Height);
end;

end.
