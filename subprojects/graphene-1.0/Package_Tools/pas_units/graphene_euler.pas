unit graphene_euler;

interface

uses
  ctypes, graphene, graphene_types;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Pgraphene_euler_order_t = ^Tgraphene_euler_order_t;
  Tgraphene_euler_order_t = longint;

const
  GRAPHENE_EULER_ORDER_DEFAULT = -(1);
  GRAPHENE_EULER_ORDER_XYZ = 0;
  GRAPHENE_EULER_ORDER_YZX = 1;
  GRAPHENE_EULER_ORDER_ZXY = 2;
  GRAPHENE_EULER_ORDER_XZY = 3;
  GRAPHENE_EULER_ORDER_YXZ = 4;
  GRAPHENE_EULER_ORDER_ZYX = 5;
  GRAPHENE_EULER_ORDER_SXYZ = 6;
  GRAPHENE_EULER_ORDER_SXYX = 7;
  GRAPHENE_EULER_ORDER_SXZY = 8;
  GRAPHENE_EULER_ORDER_SXZX = 9;
  GRAPHENE_EULER_ORDER_SYZX = 10;
  GRAPHENE_EULER_ORDER_SYZY = 11;
  GRAPHENE_EULER_ORDER_SYXZ = 12;
  GRAPHENE_EULER_ORDER_SYXY = 13;
  GRAPHENE_EULER_ORDER_SZXY = 14;
  GRAPHENE_EULER_ORDER_SZXZ = 15;
  GRAPHENE_EULER_ORDER_SZYX = 16;
  GRAPHENE_EULER_ORDER_SZYZ = 17;
  GRAPHENE_EULER_ORDER_RZYX = 18;
  GRAPHENE_EULER_ORDER_RXYX = 19;
  GRAPHENE_EULER_ORDER_RYZX = 20;
  GRAPHENE_EULER_ORDER_RXZX = 21;
  GRAPHENE_EULER_ORDER_RXZY = 22;
  GRAPHENE_EULER_ORDER_RYZY = 23;
  GRAPHENE_EULER_ORDER_RZXY = 24;
  GRAPHENE_EULER_ORDER_RYXY = 25;
  GRAPHENE_EULER_ORDER_RYXZ = 26;
  GRAPHENE_EULER_ORDER_RZXZ = 27;
  GRAPHENE_EULER_ORDER_RXYZ = 28;
  GRAPHENE_EULER_ORDER_RZYZ = 29;

type
  Tgraphene_euler_t = record
    angles: Tgraphene_vec3_t;
    order: Tgraphene_euler_order_t;
  end;
  Pgraphene_euler_t = ^Tgraphene_euler_t;

function graphene_euler_alloc: Pgraphene_euler_t; cdecl; external libgraphene;
procedure graphene_euler_free(e: Pgraphene_euler_t); cdecl; external libgraphene;
function graphene_euler_init(e: Pgraphene_euler_t; x: single; y: single; z: single): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_with_order(e: Pgraphene_euler_t; x: single; y: single; z: single; order: Tgraphene_euler_order_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_from_matrix(e: Pgraphene_euler_t; m: Pgraphene_matrix_t; order: Tgraphene_euler_order_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_from_quaternion(e: Pgraphene_euler_t; q: Pgraphene_quaternion_t; order: Tgraphene_euler_order_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_from_vec3(e: Pgraphene_euler_t; v: Pgraphene_vec3_t; order: Tgraphene_euler_order_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_from_euler(e: Pgraphene_euler_t; src: Pgraphene_euler_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_init_from_radians(e: Pgraphene_euler_t; x: single; y: single; z: single; order: Tgraphene_euler_order_t): Pgraphene_euler_t; cdecl; external libgraphene;
function graphene_euler_equal(a: Pgraphene_euler_t; b: Pgraphene_euler_t): Boolean; cdecl; external libgraphene;
function graphene_euler_get_x(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
function graphene_euler_get_y(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
function graphene_euler_get_z(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
function graphene_euler_get_order(e: Pgraphene_euler_t): Tgraphene_euler_order_t; cdecl; external libgraphene;
function graphene_euler_get_alpha(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
function graphene_euler_get_beta(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
function graphene_euler_get_gamma(e: Pgraphene_euler_t): single; cdecl; external libgraphene;
procedure graphene_euler_to_vec3(e: Pgraphene_euler_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_euler_to_matrix(e: Pgraphene_euler_t; res: Pgraphene_matrix_t); cdecl; external libgraphene;
procedure graphene_euler_to_quaternion(e: Pgraphene_euler_t; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_euler_reorder(e: Pgraphene_euler_t; order: Tgraphene_euler_order_t; res: Pgraphene_euler_t); cdecl; external libgraphene;

implementation


end.
