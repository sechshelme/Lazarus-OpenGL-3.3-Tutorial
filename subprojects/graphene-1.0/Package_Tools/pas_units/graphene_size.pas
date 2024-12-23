unit graphene_size;

interface

uses
  ctypes, graphene;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tgraphene_size_t = record
    Width: single;
    Height: single;
  end;
  Pgraphene_size_t = ^Tgraphene_size_t;

function graphene_size_alloc: Pgraphene_size_t; cdecl; external libgraphene;
procedure graphene_size_free(s: Pgraphene_size_t); cdecl; external libgraphene;
function graphene_size_init(s: Pgraphene_size_t; Width: single; Height: single): Pgraphene_size_t; cdecl; external libgraphene;
function graphene_size_init_from_size(s: Pgraphene_size_t; src: Pgraphene_size_t): Pgraphene_size_t; cdecl; external libgraphene;
function graphene_size_equal(a: Pgraphene_size_t; b: Pgraphene_size_t): boolean; cdecl; external libgraphene;
procedure graphene_size_scale(s: Pgraphene_size_t; factor: single; res: Pgraphene_size_t); cdecl; external libgraphene;
procedure graphene_size_interpolate(a: Pgraphene_size_t; b: Pgraphene_size_t; factor: double; res: Pgraphene_size_t); cdecl; external libgraphene;
function graphene_size_zero: Pgraphene_size_t; cdecl; external libgraphene;

function GRAPHENE_SIZE_INIT(w, h: single): Tgraphene_size_t;
function GRAPHENE_SIZE_INIT_ZERO: Tgraphene_size_t;

implementation

function GRAPHENE_SIZE_INIT(w, h: single): Tgraphene_size_t;
begin
  Result.Width := w;
  Result.Height := h;
end;

function GRAPHENE_SIZE_INIT_ZERO: Tgraphene_size_t;
begin
  GRAPHENE_SIZE_INIT_ZERO := GRAPHENE_SIZE_INIT(0.0, 0.0);
end;


end.
