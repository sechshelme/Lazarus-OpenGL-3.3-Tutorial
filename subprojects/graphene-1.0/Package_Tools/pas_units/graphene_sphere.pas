unit graphene_sphere;

interface

uses
  ctypes, graphene, graphene_types, graphene_point3d;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

function graphene_sphere_alloc: Pgraphene_sphere_t; cdecl; external libgraphene;
procedure graphene_sphere_free(s: Pgraphene_sphere_t); cdecl; external libgraphene;
function graphene_sphere_init(s: Pgraphene_sphere_t; center: Pgraphene_point3d_t; radius: single): Pgraphene_sphere_t; cdecl; external libgraphene;
function graphene_sphere_init_from_points(s: Pgraphene_sphere_t; n_points: dword; points: Pgraphene_point3d_t; center: Pgraphene_point3d_t): Pgraphene_sphere_t; cdecl; external libgraphene;
function graphene_sphere_init_from_vectors(s: Pgraphene_sphere_t; n_vectors: dword; vectors: Pgraphene_vec3_t; center: Pgraphene_point3d_t): Pgraphene_sphere_t; cdecl; external libgraphene;
procedure graphene_sphere_get_center(s: Pgraphene_sphere_t; center: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_sphere_get_radius(s: Pgraphene_sphere_t): single; cdecl; external libgraphene;
function graphene_sphere_is_empty(s: Pgraphene_sphere_t): boolean; cdecl; external libgraphene;
function graphene_sphere_equal(a: Pgraphene_sphere_t; b: Pgraphene_sphere_t): boolean; cdecl; external libgraphene;
function graphene_sphere_contains_point(s: Pgraphene_sphere_t; point: Pgraphene_point3d_t): boolean; cdecl; external libgraphene;
function graphene_sphere_distance(s: Pgraphene_sphere_t; point: Pgraphene_point3d_t): single; cdecl; external libgraphene;
procedure graphene_sphere_get_bounding_box(s: Pgraphene_sphere_t; box: Pgraphene_box_t); cdecl; external libgraphene;
procedure graphene_sphere_translate(s: Pgraphene_sphere_t; point: Pgraphene_point3d_t; res: Pgraphene_sphere_t); cdecl; external libgraphene;

implementation


end.
