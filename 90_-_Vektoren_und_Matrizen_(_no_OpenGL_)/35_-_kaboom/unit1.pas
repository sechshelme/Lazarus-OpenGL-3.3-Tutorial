unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Math, ctypes, GraphType,
  MTProcs,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Menus, oglglad_gl, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    procedure MenuItem1Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  sphere_radius = 1.5;
  noise_amplitude = 1.0;

function lerp(const v0, v1: single; t: single): single; inline;
begin
  Result := mix(v0,v1, clamp(t, 0.0, 1.0));
end;

function lerp(const v0, v1: TVector3f; t: single): TVector3f; inline;
begin
  Result := mix(v0,v1, clamp(t, 0.0, 1.0));
end;

function hash(const n: single): single; inline;
var
  x: single;
begin
  x := sin(n) * 43758.5453;
  Result := x - Floor(x);
end;

function noise(const x: TVector3f): single;
var
  p, f: TVector3f;
  n: single;
begin
  p := vec3(Floor(x.x), Floor(x.y), Floor(x.z));
  f := vec3(x.x - p.x, x.y - p.y, x.z - p.z);
  f := f * (f * (vec3(3, 3, 3) - f * 2));
  n := p * vec3(1, 57, 113);
  Result := lerp(lerp(
    lerp(hash(n + 0), hash(n + 1), f.x),
    lerp(hash(n + 57), hash(n + 58), f.x), f.y),
    lerp(
    lerp(hash(n + 113), hash(n + 114), f.x),
    lerp(hash(n + 170), hash(n + 171), f.x), f.y), f.z);
end;

function rotate(const v: TVector3f): TVector3f; inline;
begin
  Result := vec3(vec3(0, 0.8, 0.6) * v, vec3(-0.8, 0.36, -0.48) * v, vec3(-0.6, -0.48, 0.64) * v);
end;

function fractal_brownian_moton(const x: TVector3f): single;
var
  p: TVector3f;
  f: single = 0.0;
begin
  p := rotate(x);
  f += 0.5 * noise(p);
  p := p * 2.32;
  f += 0.25 * noise(p);
  p := p * 3.03;
  f += 0.125 * noise(p);
  p := p * 2.61;
  f += 0.0625 * noise(p);
  Result := f / 0.9375;
end;

function palette_fire(const d: single): TVector3f;
const
  yellow: Tvector3f = (1.7, 1.3, 1.0);
  orange: Tvector3f = (1.0, 0.6, 0.0);
  red: Tvector3f = (1.0, 0.0, 0.0);
  darkgray: Tvector3f = (0.2, 0.2, 0.2);
  gray: Tvector3f = (0.4, 0.4, 0.4);
var
  x: single;
begin
  x := clamp(d, 0, 1);
  if x < 0.25 then begin
    Exit(lerp(gray, darkgray, x * 4));
  end;
  if x < 0.5 then begin
    Exit(lerp(darkgray, red, x * 4 - 1));
  end;
  if x < 0.75 then begin
    Exit(lerp(red, orange, x * 4 - 2));
  end;
  Exit(lerp(orange, yellow, x * 4 - 3));
end;

function signed_distance(p: TVector3f): single;
var
  displacement: single;
begin
  displacement := -fractal_brownian_moton(p * 3.4) * noise_amplitude;
  Result := p.Length - (sphere_radius + displacement);
end;

function sphere_trace(const orig, dir: TVector3f; var pos: TVector3f): boolean;
var
  i: integer;
  d: single;
begin
  if orig * orig - Power(orig * dir, 2) > Power(sphere_radius, 2) then begin
    Exit(False);
  end;
  pos := orig;
  for i := 0 to 127 do begin
    d := signed_distance(pos);
    if d < 0 then begin
      Exit(True);
    end;
    pos := pos + dir * max(d * 0.1, 0.01);
  end;
  Result := False;
end;

function distance_field_normal(const pos: TVector3f): TVector3f;
const
  eps: single = 0.1;
var
  d, nx, ny, nz: single;
begin
  d := signed_distance(pos);
  nx := signed_distance(pos + vec3(eps, 0, 0)) - d;
  ny := signed_distance(pos + vec3(0, eps, 0)) - d;
  nz := signed_distance(pos + vec3(0, 0, eps)) - d;
  Result := normalize(vec3(nx, ny, nz));
end;

procedure doParallel(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  bit: TBitmap;
var
  j: integer;
  fov: single = 1.05;
  light_intensity, dir_x, dir_y, dir_z: single;
  fb, hit, light_dir: TVector3f;
  noise_level: single;

begin
  bit := TBitmap(Data);

  dir_x := (Index mod bit.Width + 0.5) - bit.Width / 2;
  dir_y := -(Index div bit.Width + 0.5) + bit.Height / 2;
  dir_z := -bit.Height / (2 * tan(fov / 2));

  if sphere_trace(vec3(0, 0, 3), normalize(vec3(dir_x, dir_y, dir_z)), hit) then begin
    noise_level := (sphere_radius - hit.Length) / noise_amplitude;
    light_dir := normalize(vec3(10, 10, 10) - hit);
    light_intensity := max(0.4, light_dir * distance_field_normal(hit));
    fb := palette_fire((-0.2 + noise_level) * 2) * light_intensity;
  end else begin
    fb := vec3(0.2, 0.7, 0.8);
  end;

  for j := 0 to 2 do begin
    bit.RawImage.Data[Index * 4 + j] := round(clamp(255 * fb[j], 0, 255));
  end;
  bit.RawImage.Data[Index * 4 + 3] := $FF;
  //  Application.ProcessMessages;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  //remove+
  Width := 1024;
  Height := 768;
  //remove-
  Image1.Picture.Bitmap.Width := Width;
  Image1.Picture.Bitmap.Height := Height;
  Image1.Picture.Bitmap.pixelformat := pf32bit;

  ProcThreadPool.DoParallel(@doParallel, 0, Width * Height - 1, pointer(Image1.Picture.Bitmap));
end;

end.
