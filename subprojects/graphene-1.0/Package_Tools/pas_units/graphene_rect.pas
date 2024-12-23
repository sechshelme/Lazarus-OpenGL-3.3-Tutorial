unit graphene_rect;

interface

uses
  ctypes, graphene, graphene_types, graphene_size, graphene_point;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_rect_t = record
    origin: Tgraphene_point_t;
    size: Tgraphene_size_t;
  end;
  Pgraphene_rect_t = ^Tgraphene_rect_t;

function graphene_rect_alloc: Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_free(r: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_rect_init(r: Pgraphene_rect_t; x: single; y: single; Width: single; Height: single): Pgraphene_rect_t; cdecl; external libgraphene;
function graphene_rect_init_from_rect(r: Pgraphene_rect_t; src: Pgraphene_rect_t): Pgraphene_rect_t; cdecl; external libgraphene;
function graphene_rect_equal(a: Pgraphene_rect_t; b: Pgraphene_rect_t): boolean; cdecl; external libgraphene;
function graphene_rect_normalize(r: Pgraphene_rect_t): Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_normalize_r(r: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_rect_get_center(r: Pgraphene_rect_t; p: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_rect_get_top_left(r: Pgraphene_rect_t; p: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_rect_get_top_right(r: Pgraphene_rect_t; p: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_rect_get_bottom_right(r: Pgraphene_rect_t; p: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_rect_get_bottom_left(r: Pgraphene_rect_t; p: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_rect_get_vertices(r: Pgraphene_rect_t; vertices: Pgraphene_vec2_t); cdecl; external libgraphene;
function graphene_rect_get_x(r: Pgraphene_rect_t): single; cdecl; external libgraphene;
function graphene_rect_get_y(r: Pgraphene_rect_t): single; cdecl; external libgraphene;
function graphene_rect_get_width(r: Pgraphene_rect_t): single; cdecl; external libgraphene;
function graphene_rect_get_height(r: Pgraphene_rect_t): single; cdecl; external libgraphene;
function graphene_rect_get_area(r: Pgraphene_rect_t): single; cdecl; external libgraphene;
procedure graphene_rect_union(a: Pgraphene_rect_t; b: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_rect_intersection(a: Pgraphene_rect_t; b: Pgraphene_rect_t; res: Pgraphene_rect_t): boolean; cdecl; external libgraphene;
function graphene_rect_contains_point(r: Pgraphene_rect_t; p: Pgraphene_point_t): boolean; cdecl; external libgraphene;
function graphene_rect_contains_rect(a: Pgraphene_rect_t; b: Pgraphene_rect_t): boolean; cdecl; external libgraphene;
function graphene_rect_offset(r: Pgraphene_rect_t; d_x: single; d_y: single): Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_offset_r(r: Pgraphene_rect_t; d_x: single; d_y: single; res: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_rect_inset(r: Pgraphene_rect_t; d_x: single; d_y: single): Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_inset_r(r: Pgraphene_rect_t; d_x: single; d_y: single; res: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_rect_round_to_pixel(r: Pgraphene_rect_t): Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_round(r: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_rect_round_extents(r: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_rect_interpolate(a: Pgraphene_rect_t; b: Pgraphene_rect_t; factor: double; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_rect_expand(r: Pgraphene_rect_t; p: Pgraphene_point_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
function graphene_rect_zero: Pgraphene_rect_t; cdecl; external libgraphene;
procedure graphene_rect_scale(r: Pgraphene_rect_t; s_h: single; s_v: single; res: Pgraphene_rect_t); cdecl; external libgraphene;

function GRAPHENE_RECT_INIT(x, y, w, h: single): Tgraphene_rect_t;
function GRAPHENE_RECT_INIT_ZERO: Tgraphene_rect_t;

implementation

function GRAPHENE_RECT_INIT(x, y, w, h: single): Tgraphene_rect_t;
begin
  Result.origin.x := x;
  Result.origin.y := y;
  Result.size.Width := w;
  Result.size.Height := h;
end;

function GRAPHENE_RECT_INIT_ZERO: Tgraphene_rect_t;
begin
  GRAPHENE_RECT_INIT_ZERO := GRAPHENE_RECT_INIT(0.0, 0.0, 0.0, 0.0);
end;


end.
