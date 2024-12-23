unit graphene_frustum;

interface

uses
  ctypes, graphene, graphene_types, graphene_plane, graphene_point3d;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_frustum_t = record
    planes: array[0..5] of Tgraphene_plane_t;
  end;
  Pgraphene_frustum_t = ^Tgraphene_frustum_t;

function graphene_frustum_alloc: Pgraphene_frustum_t; cdecl; external libgraphene;
procedure graphene_frustum_free(f: Pgraphene_frustum_t); cdecl; external libgraphene;
function graphene_frustum_init(f: Pgraphene_frustum_t; p0: Pgraphene_plane_t; p1: Pgraphene_plane_t; p2: Pgraphene_plane_t; p3: Pgraphene_plane_t;
  p4: Pgraphene_plane_t; p5: Pgraphene_plane_t): Pgraphene_frustum_t; cdecl; external libgraphene;
function graphene_frustum_init_from_frustum(f: Pgraphene_frustum_t; src: Pgraphene_frustum_t): Pgraphene_frustum_t; cdecl; external libgraphene;
function graphene_frustum_init_from_matrix(f: Pgraphene_frustum_t; matrix: Pgraphene_matrix_t): Pgraphene_frustum_t; cdecl; external libgraphene;
function graphene_frustum_contains_point(f: Pgraphene_frustum_t; point: Pgraphene_point3d_t): Boolean; cdecl; external libgraphene;
function graphene_frustum_intersects_sphere(f: Pgraphene_frustum_t; sphere: Pgraphene_sphere_t): Boolean; cdecl; external libgraphene;
function graphene_frustum_intersects_box(f: Pgraphene_frustum_t; box: Pgraphene_box_t): Boolean; cdecl; external libgraphene;
procedure graphene_frustum_get_planes(f: Pgraphene_frustum_t; planes: Pgraphene_plane_t); cdecl; external libgraphene;
function graphene_frustum_equal(a: Pgraphene_frustum_t; b: Pgraphene_frustum_t): Boolean; cdecl; external libgraphene;

implementation


end.
