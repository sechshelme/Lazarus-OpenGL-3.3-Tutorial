unit graphene_quaternion;

interface

uses
  ctypes, graphene, graphene_types, graphene_euler;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


function graphene_quaternion_alloc: Pgraphene_quaternion_t; cdecl; external libgraphene;
procedure graphene_quaternion_free(q: Pgraphene_quaternion_t); cdecl; external libgraphene;
function graphene_quaternion_init(q: Pgraphene_quaternion_t; x: single; y: single; z: single; w: single): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_identity(q: Pgraphene_quaternion_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_quaternion(q: Pgraphene_quaternion_t; src: Pgraphene_quaternion_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_vec4(q: Pgraphene_quaternion_t; src: Pgraphene_vec4_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_matrix(q: Pgraphene_quaternion_t; m: Pgraphene_matrix_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_angles(q: Pgraphene_quaternion_t; deg_x: single; deg_y: single; deg_z: single): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_radians(q: Pgraphene_quaternion_t; rad_x: single; rad_y: single; rad_z: single): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_angle_vec3(q: Pgraphene_quaternion_t; angle: single; axis: Pgraphene_vec3_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
function graphene_quaternion_init_from_euler(q: Pgraphene_quaternion_t; e: Pgraphene_euler_t): Pgraphene_quaternion_t; cdecl; external libgraphene;
procedure graphene_quaternion_to_vec4(q: Pgraphene_quaternion_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_quaternion_to_matrix(q: Pgraphene_quaternion_t; m: Pgraphene_matrix_t); cdecl; external libgraphene;
procedure graphene_quaternion_to_angles(q: Pgraphene_quaternion_t; deg_x: Psingle; deg_y: Psingle; deg_z: Psingle); cdecl; external libgraphene;
procedure graphene_quaternion_to_radians(q: Pgraphene_quaternion_t; rad_x: Psingle; rad_y: Psingle; rad_z: Psingle); cdecl; external libgraphene;
procedure graphene_quaternion_to_angle_vec3(q: Pgraphene_quaternion_t; angle: Psingle; axis: Pgraphene_vec3_t); cdecl; external libgraphene;
function graphene_quaternion_equal(a: Pgraphene_quaternion_t; b: Pgraphene_quaternion_t): boolean; cdecl; external libgraphene;
function graphene_quaternion_dot(a: Pgraphene_quaternion_t; b: Pgraphene_quaternion_t): single; cdecl; external libgraphene;
procedure graphene_quaternion_invert(q: Pgraphene_quaternion_t; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_quaternion_normalize(q: Pgraphene_quaternion_t; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_quaternion_slerp(a: Pgraphene_quaternion_t; b: Pgraphene_quaternion_t; factor: single; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_quaternion_multiply(a: Pgraphene_quaternion_t; b: Pgraphene_quaternion_t; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_quaternion_scale(q: Pgraphene_quaternion_t; factor: single; res: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_quaternion_add(a: Pgraphene_quaternion_t; b: Pgraphene_quaternion_t; res: Pgraphene_quaternion_t); cdecl; external libgraphene;

implementation


end.
