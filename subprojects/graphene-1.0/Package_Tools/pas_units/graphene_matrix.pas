unit graphene_matrix;

interface

uses
  ctypes, graphene, graphene_point3d, graphene_point, graphene_rect, graphene_quad, graphene_ray, graphene_euler;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


function graphene_matrix_alloc: Pgraphene_matrix_t; cdecl; external libgraphene;
procedure graphene_matrix_free(m: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_init_identity(m: Pgraphene_matrix_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_from_float(m: Pgraphene_matrix_t; v: Psingle): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_from_vec4(m: Pgraphene_matrix_t; v0: Pgraphene_vec4_t; v1: Pgraphene_vec4_t; v2: Pgraphene_vec4_t; v3: Pgraphene_vec4_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_from_matrix(m: Pgraphene_matrix_t; src: Pgraphene_matrix_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_perspective(m: Pgraphene_matrix_t; fovy: single; aspect: single; z_near: single; z_far: single): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_ortho(m: Pgraphene_matrix_t; left: single; right: single; top: single; bottom: single;
  z_near: single; z_far: single): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_look_at(m: Pgraphene_matrix_t; eye: Pgraphene_vec3_t; center: Pgraphene_vec3_t; up: Pgraphene_vec3_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_frustum(m: Pgraphene_matrix_t; left: single; right: single; bottom: single; top: single;
  z_near: single; z_far: single): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_scale(m: Pgraphene_matrix_t; x: single; y: single; z: single): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_translate(m: Pgraphene_matrix_t; p: Pgraphene_point3d_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_rotate(m: Pgraphene_matrix_t; angle: single; axis: Pgraphene_vec3_t): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_skew(m: Pgraphene_matrix_t; x_skew: single; y_skew: single): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_init_from_2d(m: Pgraphene_matrix_t; xx: double; yx: double; xy: double; yy: double; x_0: double; y_0: double): Pgraphene_matrix_t; cdecl; external libgraphene;
function graphene_matrix_is_identity(m: Pgraphene_matrix_t): boolean; cdecl; external libgraphene;
function graphene_matrix_is_2d(m: Pgraphene_matrix_t): boolean; cdecl; external libgraphene;
function graphene_matrix_is_backface_visible(m: Pgraphene_matrix_t): boolean; cdecl; external libgraphene;
function graphene_matrix_is_singular(m: Pgraphene_matrix_t): boolean; cdecl; external libgraphene;
procedure graphene_matrix_to_float(m: Pgraphene_matrix_t; v: Psingle); cdecl; external libgraphene;
function graphene_matrix_to_2d(m: Pgraphene_matrix_t; xx: Pdouble; yx: Pdouble; xy: Pdouble; yy: Pdouble; x_0: Pdouble; y_0: Pdouble): boolean; cdecl; external libgraphene;
procedure graphene_matrix_get_row(m: Pgraphene_matrix_t; index_: dword; res: Pgraphene_vec4_t); cdecl; external libgraphene;
function graphene_matrix_get_value(m: Pgraphene_matrix_t; row: dword; col: dword): single; cdecl; external libgraphene;
procedure graphene_matrix_multiply(a: Pgraphene_matrix_t; b: Pgraphene_matrix_t; res: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_determinant(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
procedure graphene_matrix_transform_vec4(m: Pgraphene_matrix_t; v: Pgraphene_vec4_t; res: Pgraphene_vec4_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_vec3(m: Pgraphene_matrix_t; v: Pgraphene_vec3_t; res: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_point(m: Pgraphene_matrix_t; p: Pgraphene_point_t; res: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_point3d(m: Pgraphene_matrix_t; p: Pgraphene_point3d_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_rect(m: Pgraphene_matrix_t; r: Pgraphene_rect_t; res: Pgraphene_quad_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_bounds(m: Pgraphene_matrix_t; r: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_sphere(m: Pgraphene_matrix_t; s: Pgraphene_sphere_t; res: Pgraphene_sphere_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_box(m: Pgraphene_matrix_t; b: Pgraphene_box_t; res: Pgraphene_box_t); cdecl; external libgraphene;
procedure graphene_matrix_transform_ray(m: Pgraphene_matrix_t; r: Pgraphene_ray_t; res: Pgraphene_ray_t); cdecl; external libgraphene;
procedure graphene_matrix_project_point(m: Pgraphene_matrix_t; p: Pgraphene_point_t; res: Pgraphene_point_t); cdecl; external libgraphene;
procedure graphene_matrix_project_rect_bounds(m: Pgraphene_matrix_t; r: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_matrix_project_rect(m: Pgraphene_matrix_t; r: Pgraphene_rect_t; res: Pgraphene_quad_t); cdecl; external libgraphene;
function graphene_matrix_untransform_point(m: Pgraphene_matrix_t; p: Pgraphene_point_t; bounds: Pgraphene_rect_t; res: Pgraphene_point_t): boolean; cdecl; external libgraphene;
procedure graphene_matrix_untransform_bounds(m: Pgraphene_matrix_t; r: Pgraphene_rect_t; bounds: Pgraphene_rect_t; res: Pgraphene_rect_t); cdecl; external libgraphene;
procedure graphene_matrix_unproject_point3d(projection: Pgraphene_matrix_t; modelview: Pgraphene_matrix_t; point: Pgraphene_point3d_t; res: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_matrix_translate(m: Pgraphene_matrix_t; pos: Pgraphene_point3d_t); cdecl; external libgraphene;
procedure graphene_matrix_rotate(m: Pgraphene_matrix_t; angle: single; axis: Pgraphene_vec3_t); cdecl; external libgraphene;
procedure graphene_matrix_rotate_x(m: Pgraphene_matrix_t; angle: single); cdecl; external libgraphene;
procedure graphene_matrix_rotate_y(m: Pgraphene_matrix_t; angle: single); cdecl; external libgraphene;
procedure graphene_matrix_rotate_z(m: Pgraphene_matrix_t; angle: single); cdecl; external libgraphene;
procedure graphene_matrix_rotate_quaternion(m: Pgraphene_matrix_t; q: Pgraphene_quaternion_t); cdecl; external libgraphene;
procedure graphene_matrix_rotate_euler(m: Pgraphene_matrix_t; e: Pgraphene_euler_t); cdecl; external libgraphene;
procedure graphene_matrix_scale(m: Pgraphene_matrix_t; factor_x: single; factor_y: single; factor_z: single); cdecl; external libgraphene;
procedure graphene_matrix_skew_xy(m: Pgraphene_matrix_t; factor: single); cdecl; external libgraphene;
procedure graphene_matrix_skew_xz(m: Pgraphene_matrix_t; factor: single); cdecl; external libgraphene;
procedure graphene_matrix_skew_yz(m: Pgraphene_matrix_t; factor: single); cdecl; external libgraphene;
procedure graphene_matrix_transpose(m: Pgraphene_matrix_t; res: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_inverse(m: Pgraphene_matrix_t; res: Pgraphene_matrix_t): Boolean; cdecl; external libgraphene;
procedure graphene_matrix_perspective(m: Pgraphene_matrix_t; depth: single; res: Pgraphene_matrix_t); cdecl; external libgraphene;
procedure graphene_matrix_normalize(m: Pgraphene_matrix_t; res: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_get_x_translation(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
function graphene_matrix_get_y_translation(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
function graphene_matrix_get_z_translation(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
function graphene_matrix_get_x_scale(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
function graphene_matrix_get_y_scale(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
function graphene_matrix_get_z_scale(m: Pgraphene_matrix_t): single; cdecl; external libgraphene;
procedure graphene_matrix_interpolate(a: Pgraphene_matrix_t; b: Pgraphene_matrix_t; factor: double; res: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_near(a: Pgraphene_matrix_t; b: Pgraphene_matrix_t; epsilon: single): Boolean; cdecl; external libgraphene;
function graphene_matrix_equal(a: Pgraphene_matrix_t; b: Pgraphene_matrix_t): Boolean; cdecl; external libgraphene;
function graphene_matrix_equal_fast(a: Pgraphene_matrix_t; b: Pgraphene_matrix_t): Boolean; cdecl; external libgraphene;
procedure graphene_matrix_print(m: Pgraphene_matrix_t); cdecl; external libgraphene;
function graphene_matrix_decompose(m: Pgraphene_matrix_t; translate: Pgraphene_vec3_t; scale: Pgraphene_vec3_t; rotate: Pgraphene_quaternion_t; shear: Pgraphene_vec3_t;
  perspective: Pgraphene_vec4_t): Boolean; cdecl; external libgraphene;

implementation


end.
