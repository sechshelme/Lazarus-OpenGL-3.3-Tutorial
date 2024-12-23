unit graphene_quad;

interface

uses
  ctypes, graphene, graphene_point, graphene_rect;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_quad_t = record
    points: Tgraphene_point_t;
  end;
  Pgraphene_quad_t = ^Tgraphene_quad_t;

function graphene_quad_alloc: Pgraphene_quad_t; cdecl; external libgraphene;
procedure graphene_quad_free(q: Pgraphene_quad_t); cdecl; external libgraphene;
function graphene_quad_init(q: Pgraphene_quad_t; p1: Pgraphene_point_t; p2: Pgraphene_point_t; p3: Pgraphene_point_t; p4: Pgraphene_point_t): Pgraphene_quad_t; cdecl; external libgraphene;
function graphene_quad_init_from_rect(q: Pgraphene_quad_t; r: Pgraphene_rect_t): Pgraphene_quad_t; cdecl; external libgraphene;
function graphene_quad_init_from_points(q: Pgraphene_quad_t; points: Pgraphene_point_t): Pgraphene_quad_t; cdecl; external libgraphene;
function graphene_quad_contains(q: Pgraphene_quad_t; p: Pgraphene_point_t): boolean; cdecl; external libgraphene;
procedure graphene_quad_bounds(q: Pgraphene_quad_t; r: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_quad_get_point(q: Pgraphene_quad_t; index_: dword): Pgraphene_point_t; cdecl; external libgraphene;

implementation


end.
