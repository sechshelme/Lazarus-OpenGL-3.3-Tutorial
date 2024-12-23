
unit graphene_matrix;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_matrix.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_matrix.h
}

{ Pointers to basic pascal types, inserted by h2pas conversion program.}
Type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

Type
Pdouble  = ^double;
Pgraphene_box_t  = ^graphene_box_t;
Pgraphene_euler_t  = ^graphene_euler_t;
Pgraphene_matrix_t  = ^graphene_matrix_t;
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_point_t  = ^graphene_point_t;
Pgraphene_quad_t  = ^graphene_quad_t;
Pgraphene_quaternion_t  = ^graphene_quaternion_t;
Pgraphene_ray_t  = ^graphene_ray_t;
Pgraphene_rect_t  = ^graphene_rect_t;
Pgraphene_sphere_t  = ^graphene_sphere_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Pgraphene_vec4_t  = ^graphene_vec4_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-matrix.h: 4x4 matrix
 *
 * SPDX-License-Identifier: MIT
 *
 * Copyright 2014  Emmanuele Bassi
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
  }
(** unsupported pragma#pragma once*)
{$include "graphene-types.h"}
{*
 * graphene_matrix_t:
 *
 * A structure capable of holding a 4x4 matrix.
 *
 * The contents of the #graphene_matrix_t structure are private and
 * should never be accessed directly.
  }
{< private > }
{/  GRAPHENE_ALIGNED_DECL (GRAPHENE_PRIVATE_FIELD (graphene_simd4x4f_t, value), 16); }
type
  Pgraphene_matrix_t = ^Tgraphene_matrix_t;
  Tgraphene_matrix_t = record
      value : Tgraphene_simd4x4f_t;
    end;


function graphene_matrix_alloc:Pgraphene_matrix_t;cdecl;external;
procedure graphene_matrix_free(m:Pgraphene_matrix_t);cdecl;external;
function graphene_matrix_init_identity(m:Pgraphene_matrix_t):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_init_from_float(m:Pgraphene_matrix_t; v:Psingle):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_init_from_vec4(m:Pgraphene_matrix_t; v0:Pgraphene_vec4_t; v1:Pgraphene_vec4_t; v2:Pgraphene_vec4_t; v3:Pgraphene_vec4_t):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_init_from_matrix(m:Pgraphene_matrix_t; src:Pgraphene_matrix_t):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_perspective(m:Pgraphene_matrix_t; fovy:single; aspect:single; z_near:single; z_far:single):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_ortho(m:Pgraphene_matrix_t; left:single; right:single; top:single; bottom:single; 
           z_near:single; z_far:single):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_init_look_at(m:Pgraphene_matrix_t; eye:Pgraphene_vec3_t; center:Pgraphene_vec3_t; up:Pgraphene_vec3_t):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_frustum(m:Pgraphene_matrix_t; left:single; right:single; bottom:single; top:single; 
           z_near:single; z_far:single):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_scale(m:Pgraphene_matrix_t; x:single; y:single; z:single):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_init_translate(m:Pgraphene_matrix_t; p:Pgraphene_point3d_t):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_init_rotate(m:Pgraphene_matrix_t; angle:single; axis:Pgraphene_vec3_t):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_skew(m:Pgraphene_matrix_t; x_skew:single; y_skew:single):Pgraphene_matrix_t;cdecl;external;
function graphene_matrix_init_from_2d(m:Pgraphene_matrix_t; xx:Tdouble; yx:Tdouble; xy:Tdouble; yy:Tdouble; 
           x_0:Tdouble; y_0:Tdouble):Pgraphene_matrix_t;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_is_identity(m:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_is_2d(m:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_is_backface_visible(m:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_is_singular(m:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_to_float(m:Pgraphene_matrix_t; v:Psingle);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_to_2d(m:Pgraphene_matrix_t; xx:Pdouble; yx:Pdouble; xy:Pdouble; yy:Pdouble; 
           x_0:Pdouble; y_0:Pdouble):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_get_row(m:Pgraphene_matrix_t; index_:dword; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_value(m:Pgraphene_matrix_t; row:dword; col:dword):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_multiply(a:Pgraphene_matrix_t; b:Pgraphene_matrix_t; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_determinant(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_vec4(m:Pgraphene_matrix_t; v:Pgraphene_vec4_t; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_vec3(m:Pgraphene_matrix_t; v:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_point(m:Pgraphene_matrix_t; p:Pgraphene_point_t; res:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_point3d(m:Pgraphene_matrix_t; p:Pgraphene_point3d_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_rect(m:Pgraphene_matrix_t; r:Pgraphene_rect_t; res:Pgraphene_quad_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_bounds(m:Pgraphene_matrix_t; r:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_sphere(m:Pgraphene_matrix_t; s:Pgraphene_sphere_t; res:Pgraphene_sphere_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_box(m:Pgraphene_matrix_t; b:Pgraphene_box_t; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_transform_ray(m:Pgraphene_matrix_t; r:Pgraphene_ray_t; res:Pgraphene_ray_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_project_point(m:Pgraphene_matrix_t; p:Pgraphene_point_t; res:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_project_rect_bounds(m:Pgraphene_matrix_t; r:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_project_rect(m:Pgraphene_matrix_t; r:Pgraphene_rect_t; res:Pgraphene_quad_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_untransform_point(m:Pgraphene_matrix_t; p:Pgraphene_point_t; bounds:Pgraphene_rect_t; res:Pgraphene_point_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_untransform_bounds(m:Pgraphene_matrix_t; r:Pgraphene_rect_t; bounds:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_unproject_point3d(projection:Pgraphene_matrix_t; modelview:Pgraphene_matrix_t; point:Pgraphene_point3d_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_translate(m:Pgraphene_matrix_t; pos:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_rotate(m:Pgraphene_matrix_t; angle:single; axis:Pgraphene_vec3_t);cdecl;external;
procedure graphene_matrix_rotate_x(m:Pgraphene_matrix_t; angle:single);cdecl;external;
procedure graphene_matrix_rotate_y(m:Pgraphene_matrix_t; angle:single);cdecl;external;
procedure graphene_matrix_rotate_z(m:Pgraphene_matrix_t; angle:single);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_rotate_quaternion(m:Pgraphene_matrix_t; q:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_rotate_euler(m:Pgraphene_matrix_t; e:Pgraphene_euler_t);cdecl;external;
procedure graphene_matrix_scale(m:Pgraphene_matrix_t; factor_x:single; factor_y:single; factor_z:single);cdecl;external;
procedure graphene_matrix_skew_xy(m:Pgraphene_matrix_t; factor:single);cdecl;external;
procedure graphene_matrix_skew_xz(m:Pgraphene_matrix_t; factor:single);cdecl;external;
procedure graphene_matrix_skew_yz(m:Pgraphene_matrix_t; factor:single);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_transpose(m:Pgraphene_matrix_t; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_inverse(m:Pgraphene_matrix_t; res:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_perspective(m:Pgraphene_matrix_t; depth:single; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_normalize(m:Pgraphene_matrix_t; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_x_translation(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_y_translation(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_z_translation(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_x_scale(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_y_scale(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_matrix_get_z_scale(m:Pgraphene_matrix_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_matrix_interpolate(a:Pgraphene_matrix_t; b:Pgraphene_matrix_t; factor:Tdouble; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_near(a:Pgraphene_matrix_t; b:Pgraphene_matrix_t; epsilon:single):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_equal(a:Pgraphene_matrix_t; b:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_matrix_equal_fast(a:Pgraphene_matrix_t; b:Pgraphene_matrix_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_matrix_print(m:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
function graphene_matrix_decompose(m:Pgraphene_matrix_t; translate:Pgraphene_vec3_t; scale:Pgraphene_vec3_t; rotate:Pgraphene_quaternion_t; shear:Pgraphene_vec3_t; 
           perspective:Pgraphene_vec4_t):Tbool;cdecl;external;

implementation


end.
