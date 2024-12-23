unit graphene_plane;

interface

uses
  ctypes, graphene, graphene_point3d;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_plane_t = record
    normal: Tgraphene_vec3_t;
    constant: single;
  end;
  Pgraphene_plane_t = ^Tgraphene_plane_t;


function graphene_plane_alloc: Pgraphene_plane_t; cdecl; external libgraphene;
procedure graphene_plane_free(p: Pgraphene_plane_t); cdecl; external libgraphene;
function graphene_plane_init(p: Pgraphene_plane_t; normal: Pgraphene_vec3_t; constant: single): Pgraphene_plane_t; cdecl; external libgraphene;
function graphene_plane_init_from_vec4(p: Pgraphene_plane_t; src: Pgraphene_vec4_t): Pgraphene_plane_t; cdecl; external libgraphene;
function graphene_plane_init_from_plane(p: Pgraphene_plane_t; src: Pgraphene_plane_t): Pgraphene_plane_t; cdecl; external libgraphene;
function graphene_plane_init_from_point(p: Pgraphene_plane_t; normal: Pgraphene_vec3_t; point: Pgraphene_point3d_t): Pgraphene_plane_t; cdecl; external libgraphene;
function graphene_plane_init_from_points(p: Pgraphene_plane_t; a: Pgraphene_point3d_t; b: Pgraphene_point3d_t; c: Pgraphene_point3d_t): Pgraphene_plane_t; cdecl; external libgraphene;
procedure graphene_plane_normalize(p: Pgraphene_plane_t; res: Pgraphene_plane_t); cdecl; external libgraphene;
procedure graphene_plane_negate(p: Pgraphene_plane_t; res: Pgraphene_plane_t); cdecl; external libgraphene;
function graphene_plane_equal(a: Pgraphene_plane_t; b: Pgraphene_plane_t): Boolean; cdecl; external libgraphene;
function graphene_plane_distance(p: Pgraphene_plane_t; point: Pgraphene_point3d_t): single; cdecl; external libgraphene;
procedure graphene_plane_get_normal(p: Pgraphene_plane_t; normal: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_plane_get_constant(p: Pgraphene_plane_t): single; cdecl; external libgraphene;
procedure graphene_plane_transform(p: Pgraphene_plane_t; matrix: Pgraphene_matrix_t; normal_matrix: Pgraphene_matrix_t; res: Pgraphene_plane_t); cdecl; external libgraphene;

implementation


end.
