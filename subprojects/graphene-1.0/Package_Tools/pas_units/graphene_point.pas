unit graphene_point;

interface

uses
  ctypes, graphene, graphene_types;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_point_t = record
    x: single;
    y: single;
  end;
  Pgraphene_point_t = ^Tgraphene_point_t;


function graphene_point_alloc: Pgraphene_point_t; cdecl; external libgraphene;
procedure graphene_point_free(p: Pgraphene_point_t); cdecl; external libgraphene;
function graphene_point_init(p: Pgraphene_point_t; x: single; y: single): Pgraphene_point_t; cdecl; external libgraphene;
function graphene_point_init_from_point(p: Pgraphene_point_t; src: Pgraphene_point_t): Pgraphene_point_t; cdecl; external libgraphene;
function graphene_point_init_from_vec2(p: Pgraphene_point_t; src: Pgraphene_vec2_t): Pgraphene_point_t; cdecl; external libgraphene;
function graphene_point_equal(a: Pgraphene_point_t; b: Pgraphene_point_t): boolean; cdecl; external libgraphene;
function graphene_point_distance(a: Pgraphene_point_t; b: Pgraphene_point_t; d_x: Psingle; d_y: Psingle): single; cdecl; external libgraphene;
function graphene_point_near(a: Pgraphene_point_t; b: Pgraphene_point_t; epsilon: single): boolean; cdecl; external libgraphene;
procedure graphene_point_interpolate(a: Pgraphene_point_t; b: Pgraphene_point_t; factor: double; res: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_point_to_vec2(p: Pgraphene_point_t; v: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_point_zero: Pgraphene_point_t; cdecl; external libgraphene;

function GRAPHENE_POINT_INIT(x, y: single): Tgraphene_point_t;
function GRAPHENE_POINT_INIT_ZERO: Tgraphene_point_t;

implementation

function GRAPHENE_POINT_INIT(x, y: single): Tgraphene_point_t;
begin
  Result.x := x;
  Result.y := y;
end;

function GRAPHENE_POINT_INIT_ZERO: Tgraphene_point_t;
begin
  GRAPHENE_POINT_INIT_ZERO := GRAPHENE_POINT_INIT(0.0, 0.0);
end;


end.
