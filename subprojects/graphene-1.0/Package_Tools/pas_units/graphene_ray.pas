unit graphene_ray;

interface

uses
  ctypes, graphene, graphene_point3d, graphene_plane, graphene_triangle;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_ray_t = record
    origin: Tgraphene_vec3_t;
    direction: Tgraphene_vec3_t;
  end;
  Pgraphene_ray_t = ^Tgraphene_ray_t;

  Pgraphene_ray_intersection_kind_t = ^Tgraphene_ray_intersection_kind_t;
  Tgraphene_ray_intersection_kind_t = longint;

const
  GRAPHENE_RAY_INTERSECTION_KIND_NONE = 0;
  GRAPHENE_RAY_INTERSECTION_KIND_ENTER = 1;
  GRAPHENE_RAY_INTERSECTION_KIND_LEAVE = 2;

function graphene_ray_alloc: Pgraphene_ray_t; cdecl; external libgraphene;
procedure graphene_ray_free(r: Pgraphene_ray_t); cdecl; external libgraphene;
function graphene_ray_init(r: Pgraphene_ray_t; origin: Pgraphene_point3d_t; direction: Pgraphene_vec3_t): Pgraphene_ray_t; cdecl; external libgraphene;
function graphene_ray_init_from_ray(r: Pgraphene_ray_t; src: Pgraphene_ray_t): Pgraphene_ray_t; cdecl; external libgraphene;
function graphene_ray_init_from_vec3(r: Pgraphene_ray_t; origin: Pgraphene_vec3_t; direction: Pgraphene_vec3_t): Pgraphene_ray_t; cdecl; external libgraphene;
procedure graphene_ray_get_origin(r: Pgraphene_ray_t; origin: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_ray_get_direction(r: Pgraphene_ray_t; direction: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_ray_get_position_at(r: Pgraphene_ray_t; t: single; position: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_ray_get_distance_to_point(r: Pgraphene_ray_t; p: Pgraphene_point3d_t): single; cdecl; external libgraphene;
function graphene_ray_get_distance_to_plane(r: Pgraphene_ray_t; p: Pgraphene_plane_t): single; cdecl; external libgraphene;
function graphene_ray_equal(a: Pgraphene_ray_t; b: Pgraphene_ray_t): Boolean; cdecl; external libgraphene;
procedure graphene_ray_get_closest_point_to_point(r: Pgraphene_ray_t; p: Pgraphene_point3d_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
function graphene_ray_intersect_sphere(r: Pgraphene_ray_t; s: Pgraphene_sphere_t; t_out: Psingle): Tgraphene_ray_intersection_kind_t; cdecl; external libgraphene;
function graphene_ray_intersects_sphere(r: Pgraphene_ray_t; s: Pgraphene_sphere_t): Boolean; cdecl; external libgraphene;
function graphene_ray_intersect_box(r: Pgraphene_ray_t; b: Pgraphene_box_t; t_out: Psingle): Tgraphene_ray_intersection_kind_t; cdecl; external libgraphene;
function graphene_ray_intersects_box(r: Pgraphene_ray_t; b: Pgraphene_box_t): Boolean; cdecl; external libgraphene;
function graphene_ray_intersect_triangle(r: Pgraphene_ray_t; t: Pgraphene_triangle_t; t_out: Psingle): Tgraphene_ray_intersection_kind_t; cdecl; external libgraphene;
function graphene_ray_intersects_triangle(r: Pgraphene_ray_t; t: Pgraphene_triangle_t): Boolean; cdecl; external libgraphene;

implementation


end.
