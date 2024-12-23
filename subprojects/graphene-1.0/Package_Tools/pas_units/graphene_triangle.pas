unit graphene_triangle;

interface

uses
  ctypes, graphene, graphene_point3d, graphene_plane;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_triangle_t = record
    a: Tgraphene_vec3_t;
    b: Tgraphene_vec3_t;
    c: Tgraphene_vec3_t;
  end;
  Pgraphene_triangle_t = ^Tgraphene_triangle_t;


function graphene_triangle_alloc: Pgraphene_triangle_t; cdecl; external libgraphene;
procedure graphene_triangle_free(t: Pgraphene_triangle_t); cdecl; external libgraphene;
function graphene_triangle_init_from_point3d(t: Pgraphene_triangle_t; a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; c: Pgraphene_point3d_t): Pgraphene_triangle_t; cdecl; external libgraphene;
function graphene_triangle_init_from_vec3(t: Pgraphene_triangle_t; a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; c: Pgraphene_vec3_t): Pgraphene_triangle_t; cdecl; external libgraphene;
function graphene_triangle_init_from_float(t: Pgraphene_triangle_t; a: Psingle; b: Psingle; c: Psingle): Pgraphene_triangle_t; cdecl; external libgraphene;
procedure graphene_triangle_get_points(t: Pgraphene_triangle_t; a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; c: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_triangle_get_vertices(t: Pgraphene_triangle_t; a: Pgraphene_vec3_t; b: Pgraphene_vec3_t; c: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_triangle_get_area(t: Pgraphene_triangle_t): single; cdecl; external libgraphene;
procedure graphene_triangle_get_midpoint(t: Pgraphene_triangle_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_triangle_get_normal(t: Pgraphene_triangle_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_triangle_get_plane(t: Pgraphene_triangle_t; res: Pgraphene_plane_t); cdecl; external libgraphene;
procedure graphene_triangle_get_bounding_box(t: Pgraphene_triangle_t; res: Pgraphene_box_t); cdecl; external libgraphene;
function graphene_triangle_get_barycoords(t: Pgraphene_triangle_t; p: Pgraphene_point3d_t; res: Pgraphene_vec2_t): boolean; cdecl; external libgraphene;
function graphene_triangle_get_uv(t: Pgraphene_triangle_t; p: Pgraphene_point3d_t; uv_a: Pgraphene_vec2_t; uv_b: Pgraphene_vec2_t; uv_c: Pgraphene_vec2_t;
  res: Pgraphene_vec2_t): boolean; cdecl; external libgraphene;
function graphene_triangle_contains_point(t: Pgraphene_triangle_t; p: Pgraphene_point3d_t): boolean; cdecl; external libgraphene;
function graphene_triangle_equal(a: Pgraphene_triangle_t; b: Pgraphene_triangle_t): boolean; cdecl; external libgraphene;

implementation


end.
