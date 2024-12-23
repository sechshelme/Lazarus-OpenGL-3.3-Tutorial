unit graphene_vec2;

interface

uses
  ctypes, graphene, graphene_types;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

function graphene_vec2_alloc: Pgraphene_vec2_t; cdecl; external libgraphene;
procedure graphene_vec2_free(v: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_vec2_init(v: Pgraphene_vec2_t; x: single; y: single): Pgraphene_vec2_t; cdecl; external libgraphene;
function graphene_vec2_init_from_vec2(v: Pgraphene_vec2_t; src: Pgraphene_vec2_t): Pgraphene_vec2_t; cdecl; external libgraphene;
function graphene_vec2_init_from_float(v: Pgraphene_vec2_t; src: Psingle): Pgraphene_vec2_t; cdecl; external libgraphene;
procedure graphene_vec2_to_float(v: Pgraphene_vec2_t; dest: Psingle); cdecl; external libgraphene;
procedure graphene_vec2_add(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_subtract(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_multiply(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_divide(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_vec2_dot(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t): single; cdecl; external libgraphene;
function graphene_vec2_length(v: Pgraphene_vec2_t): single; cdecl; external libgraphene;
procedure graphene_vec2_normalize(v: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_scale(v: Pgraphene_vec2_t; factor: single; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_negate(v: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_vec2_near(v1: Pgraphene_vec2_t; v2: Pgraphene_vec2_t; epsilon: single): boolean; cdecl; external libgraphene;
function graphene_vec2_equal(v1: Pgraphene_vec2_t; v2: Pgraphene_vec2_t): boolean; cdecl; external libgraphene;
procedure graphene_vec2_min(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_max(a: Pgraphene_vec2_t; b: Pgraphene_vec2_t; res: Pgraphene_vec2_t); cdecl; external libgraphene;
procedure graphene_vec2_interpolate(v1: Pgraphene_vec2_t; v2: Pgraphene_vec2_t; factor: double; res: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_vec2_get_x(v: Pgraphene_vec2_t): single; cdecl; external libgraphene;
function graphene_vec2_get_y(v: Pgraphene_vec2_t): single; cdecl; external libgraphene;
function graphene_vec2_zero: Pgraphene_vec2_t; cdecl; external libgraphene;
function graphene_vec2_one: Pgraphene_vec2_t; cdecl; external libgraphene;
function graphene_vec2_x_axis: Pgraphene_vec2_t; cdecl; external libgraphene;
function graphene_vec2_y_axis: Pgraphene_vec2_t; cdecl; external libgraphene;

implementation


end.
