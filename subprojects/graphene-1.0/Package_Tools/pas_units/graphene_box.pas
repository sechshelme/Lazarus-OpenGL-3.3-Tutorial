unit graphene_box;

interface

uses
  ctypes, graphene, graphene_types, graphene_point3d;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


function graphene_box_alloc: Pgraphene_box_t; cdecl; external libgraphene;
procedure graphene_box_free(box: Pgraphene_box_t); cdecl; external libgraphene;
function graphene_box_init(box: Pgraphene_box_t; min: Pgraphene_point3d_t; max: Pgraphene_point3d_t): Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_init_from_points(box: Pgraphene_box_t; n_points: dword; points: Pgraphene_point3d_t): Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_init_from_vectors(box: Pgraphene_box_t; n_vectors: dword; vectors: Pgraphene_vec3_t): Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_init_from_box(box: Pgraphene_box_t; src: Pgraphene_box_t): Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_init_from_vec3(box: Pgraphene_box_t; min: Pgraphene_vec3_t; max: Pgraphene_vec3_t): Pgraphene_box_t; cdecl; external libgraphene;
procedure graphene_box_expand(box: Pgraphene_box_t; point: Pgraphene_point3d_t; res: Pgraphene_box_t); cdecl; external libgraphene;
procedure graphene_box_expand_vec3(box: Pgraphene_box_t; vec: Pgraphene_vec3_t; res: Pgraphene_box_t); cdecl; external libgraphene;
procedure graphene_box_expand_scalar(box: Pgraphene_box_t; scalar: single; res: Pgraphene_box_t); cdecl; external libgraphene;
procedure graphene_box_union(a: Pgraphene_box_t; b: Pgraphene_box_t; res: Pgraphene_box_t); cdecl; external libgraphene;
function graphene_box_intersection(a: Pgraphene_box_t; b: Pgraphene_box_t; res: Pgraphene_box_t): Boolean; cdecl; external libgraphene;
function graphene_box_get_width(box: Pgraphene_box_t): single; cdecl; external libgraphene;
function graphene_box_get_height(box: Pgraphene_box_t): single; cdecl; external libgraphene;
function graphene_box_get_depth(box: Pgraphene_box_t): single; cdecl; external libgraphene;
procedure graphene_box_get_size(box: Pgraphene_box_t; size: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_box_get_center(box: Pgraphene_box_t; center: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_box_get_min(box: Pgraphene_box_t; min: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_box_get_max(box: Pgraphene_box_t; max: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_box_get_vertices(box: Pgraphene_box_t; vertices: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_box_get_bounding_sphere(box: Pgraphene_box_t; sphere: Pgraphene_sphere_t); cdecl; external libgraphene;
function graphene_box_contains_point(box: Pgraphene_box_t; point: Pgraphene_point3d_t): Boolean; cdecl; external libgraphene;
function graphene_box_contains_box(a: Pgraphene_box_t; b: Pgraphene_box_t): Boolean; cdecl; external libgraphene;
function graphene_box_equal(a: Pgraphene_box_t; b: Pgraphene_box_t): Boolean; cdecl; external libgraphene;
function graphene_box_zero: Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_one: Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_minus_one: Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_one_minus_one: Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_infinite: Pgraphene_box_t; cdecl; external libgraphene;
function graphene_box_empty: Pgraphene_box_t; cdecl; external libgraphene;

implementation


end.
