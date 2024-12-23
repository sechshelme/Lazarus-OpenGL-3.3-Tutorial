unit graphene_vec3;

interface

uses
  ctypes, graphene, graphene_types;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

function graphene_vec3_alloc: Pgraphene_vec3_t; cdecl; external libgraphene;
procedure graphene_vec3_free(v: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_vec3_init(v: Pgraphene_vec3_t; x: single; y: single; z: single): Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_init_from_vec3(v: Pgraphene_vec3_t; src: Pgraphene_vec3_t): Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_init_from_float(v: Pgraphene_vec3_t; src: Psingle): Pgraphene_vec3_t; cdecl; external libgraphene;
procedure graphene_vec3_to_float(v: Pgraphene_vec3_t; dest: Psingle); cdecl; external libgraphene;
procedure graphene_vec3_add(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_subtract(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_multiply(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_divide(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_cross(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_vec3_dot(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t): single; cdecl; external libgraphene;
function graphene_vec3_length(v: Pgraphene_vec3_t): single; cdecl; external libgraphene;
procedure graphene_vec3_normalize(v: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_scale(v: Pgraphene_vec3_t; factor: single; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_negate(v: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_vec3_equal(v1: Pgraphene_vec3_t; v2: Pgraphene_vec3_t): boolean; cdecl; external libgraphene;
function graphene_vec3_near(v1: Pgraphene_vec3_t; v2: Pgraphene_vec3_t; epsilon: single): boolean; cdecl; external libgraphene;
procedure graphene_vec3_min(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_max(a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_interpolate(v1: Pgraphene_vec3_t; v2: Pgraphene_vec3_t; factor: double; res: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_vec3_get_x(v: Pgraphene_vec3_t): single; cdecl; external libgraphene;
function graphene_vec3_get_y(v: Pgraphene_vec3_t): single; cdecl; external libgraphene;
function graphene_vec3_get_z(v: Pgraphene_vec3_t): single; cdecl; external libgraphene;
procedure graphene_vec3_get_xy(v: Pgraphene_vec3_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec3_get_xy0(v: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_vec3_get_xyz0(v: Pgraphene_vec3_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec3_get_xyz1(v: Pgraphene_vec3_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec3_get_xyzw(v: Pgraphene_vec3_t; w: single; res: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_vec3_zero: Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_one: Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_x_axis: Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_y_axis: Pgraphene_vec3_t; cdecl; external libgraphene;
function graphene_vec3_z_axis: Pgraphene_vec3_t; cdecl; external libgraphene;

implementation


end.
