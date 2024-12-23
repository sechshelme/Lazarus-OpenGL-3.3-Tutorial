unit graphene_point3d;

interface

uses
  ctypes, graphene, graphene_rect;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_point3d_t = record
    x: single;
    y: single;
    z: single;
  end;
  Pgraphene_point3d_t = ^Tgraphene_point3d_t;

function graphene_point3d_alloc: Pgraphene_point3d_t; cdecl; external libgraphene;
procedure graphene_point3d_free(p: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_point3d_init(p: Pgraphene_point3d_t; x: single; y: single; z: single): Pgraphene_point3d_t; cdecl; external libgraphene;
function graphene_point3d_init_from_point(p: Pgraphene_point3d_t; src: Pgraphene_point3d_t): Pgraphene_point3d_t; cdecl; external libgraphene;
function graphene_point3d_init_from_vec3(p: Pgraphene_point3d_t; v: Pgraphene_vec3_t): Pgraphene_point3d_t; cdecl; external libgraphene;
procedure graphene_point3d_to_vec3(p: Pgraphene_point3d_t; v: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_point3d_equal(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t): boolean; cdecl; external libgraphene;
function graphene_point3d_near(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; epsilon: single): boolean; cdecl; external libgraphene;
procedure graphene_point3d_scale(p: Pgraphene_point3d_t; factor: single; res: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_point3d_cross(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_point3d_dot(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t): single; cdecl; external libgraphene;
function graphene_point3d_length(p: Pgraphene_point3d_t): single; cdecl; external libgraphene;
procedure graphene_point3d_normalize(p: Pgraphene_point3d_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_point3d_distance(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; delta: Pgraphene_vec3_t): single; cdecl; external libgraphene;
procedure graphene_point3d_interpolate(a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; factor: double; res: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_point3d_normalize_viewport(p: Pgraphene_point3d_t; viewport: Pgraphene_rect_t; z_near: single; z_far: single; res: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_point3d_zero: Pgraphene_point3d_t; cdecl; external libgraphene;

function GRAPHENE_POINT3D_INIT(x, y, z: single): Tgraphene_point3d_t;
function GRAPHENE_POINT3D_INIT_ZERO: Tgraphene_point3d_t;

implementation

function GRAPHENE_POINT3D_INIT(x, y, z: single): Tgraphene_point3d_t;
begin
  Result.x := x;
  Result.y := y;
  Result.z := z;
end;

function GRAPHENE_POINT3D_INIT_ZERO: Tgraphene_point3d_t;
begin
  GRAPHENE_POINT3D_INIT_ZERO := GRAPHENE_POINT3D_INIT(0.0, 0.0, 0.0);
end;


end.
