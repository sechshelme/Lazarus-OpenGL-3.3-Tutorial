unit graphene_vec4;

interface

uses
  ctypes, graphene;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

function graphene_vec4_alloc: Pgraphene_vec4_t; cdecl; external libgraphene;
procedure graphene_vec4_free(v: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_vec4_init(v: Pgraphene_vec4_t; x: single; y: single; z: single; w: single): Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_init_from_vec4(v: Pgraphene_vec4_t; src: Pgraphene_vec4_t): Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_init_from_vec3(v: Pgraphene_vec4_t; src: Pgraphene_vec3_t; w: single): Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_init_from_vec2(v: Pgraphene_vec4_t; src: Pgraphene_vec2_t; z: single; w: single): Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_init_from_float(v: Pgraphene_vec4_t; src: Psingle): Pgraphene_vec4_t; cdecl; external libgraphene;
procedure graphene_vec4_to_float(v: Pgraphene_vec4_t; dest: Psingle); cdecl; external libgraphene;
procedure graphene_vec4_add(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_subtract(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_multiply(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_divide(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_vec4_dot(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t): single; cdecl; external libgraphene;
function graphene_vec4_length(v: Pgraphene_vec4_t): single; cdecl; external libgraphene;
procedure graphene_vec4_normalize(v: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_scale(v: Pgraphene_vec4_t; factor: single; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_negate(v: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_vec4_equal(v1: Pgraphene_vec4_t; v2: Pgraphene_vec4_t): boolean; cdecl; external libgraphene;
function graphene_vec4_near(v1: Pgraphene_vec4_t; v2: Pgraphene_vec4_t; epsilon: single): boolean; cdecl; external libgraphene;
procedure graphene_vec4_min(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_max(a: Pgraphene_vec4_t; b: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_vec4_interpolate(v1: Pgraphene_vec4_t; v2: Pgraphene_vec4_t; factor: double; res: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_vec4_get_x(v: Pgraphene_vec4_t): single; cdecl; external libgraphene;
function graphene_vec4_get_y(v: Pgraphene_vec4_t): single; cdecl; external libgraphene;
function graphene_vec4_get_z(v: Pgraphene_vec4_t): single; cdecl; external libgraphene;
function graphene_vec4_get_w(v: Pgraphene_vec4_t): single; cdecl; external libgraphene;
procedure graphene_vec4_get_xy(v: Pgraphene_vec4_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec4_get_xyz(v: Pgraphene_vec4_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_vec4_zero: Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_one: Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_x_axis: Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_y_axis: Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_z_axis: Pgraphene_vec4_t; cdecl; external libgraphene;
function graphene_vec4_w_axis: Pgraphene_vec4_t; cdecl; external libgraphene;

implementation


end.
