
unit graphene_ray;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_ray.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_ray.h
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
Pgraphene_box_t  = ^graphene_box_t;
Pgraphene_plane_t  = ^graphene_plane_t;
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_ray_intersection_kind_t  = ^graphene_ray_intersection_kind_t;
Pgraphene_ray_t  = ^graphene_ray_t;
Pgraphene_sphere_t  = ^graphene_sphere_t;
Pgraphene_triangle_t  = ^graphene_triangle_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-ray.h: A ray emitted from an origin in a given direction
 *
 * SPDX-License-Identifier: MIT
 *
 * Copyright 2015  Emmanuele Bassi
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
{$if !defined(GRAPHENE_H_INSIDE) && !defined(GRAPHENE_COMPILATION)}
{$error "Only graphene.h can be included directly."}
{$endif}
{$include "graphene-types.h"}
{$include "graphene-vec3.h"}
{*
 * graphene_ray_t:
 *
 * A ray emitted from an origin in a given direction.
 *
 * The contents of the `graphene_ray_t` structure are private, and should not
 * be modified directly.
 *
 * Since: 1.4
  }
{< private > }
type
  Pgraphene_ray_t = ^Tgraphene_ray_t;
  Tgraphene_ray_t = record
      origin : Tgraphene_vec3_t;
      direction : Tgraphene_vec3_t;
    end;

{*
 * graphene_ray_intersection_kind_t:
 * @GRAPHENE_RAY_INTERSECTION_KIND_NONE: No intersection
 * @GRAPHENE_RAY_INTERSECTION_KIND_ENTER: The ray is entering the intersected
 *   object
 * @GRAPHENE_RAY_INTERSECTION_KIND_LEAVE: The ray is leaving the intersected
 *   object
 *
 * The type of intersection.
 *
 * Since: 1.10
  }

  Pgraphene_ray_intersection_kind_t = ^Tgraphene_ray_intersection_kind_t;
  Tgraphene_ray_intersection_kind_t =  Longint;
  Const
    GRAPHENE_RAY_INTERSECTION_KIND_NONE = 0;
    GRAPHENE_RAY_INTERSECTION_KIND_ENTER = 1;
    GRAPHENE_RAY_INTERSECTION_KIND_LEAVE = 2;
;

function graphene_ray_alloc:Pgraphene_ray_t;cdecl;external;
procedure graphene_ray_free(r:Pgraphene_ray_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_init(r:Pgraphene_ray_t; origin:Pgraphene_point3d_t; direction:Pgraphene_vec3_t):Pgraphene_ray_t;cdecl;external;
(* Const before type ignored *)
function graphene_ray_init_from_ray(r:Pgraphene_ray_t; src:Pgraphene_ray_t):Pgraphene_ray_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_init_from_vec3(r:Pgraphene_ray_t; origin:Pgraphene_vec3_t; direction:Pgraphene_vec3_t):Pgraphene_ray_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_ray_get_origin(r:Pgraphene_ray_t; origin:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_ray_get_direction(r:Pgraphene_ray_t; direction:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_ray_get_position_at(r:Pgraphene_ray_t; t:single; position:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_get_distance_to_point(r:Pgraphene_ray_t; p:Pgraphene_point3d_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_get_distance_to_plane(r:Pgraphene_ray_t; p:Pgraphene_plane_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_equal(a:Pgraphene_ray_t; b:Pgraphene_ray_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_ray_get_closest_point_to_point(r:Pgraphene_ray_t; p:Pgraphene_point3d_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersect_sphere(r:Pgraphene_ray_t; s:Pgraphene_sphere_t; t_out:Psingle):Tgraphene_ray_intersection_kind_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersects_sphere(r:Pgraphene_ray_t; s:Pgraphene_sphere_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersect_box(r:Pgraphene_ray_t; b:Pgraphene_box_t; t_out:Psingle):Tgraphene_ray_intersection_kind_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersects_box(r:Pgraphene_ray_t; b:Pgraphene_box_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersect_triangle(r:Pgraphene_ray_t; t:Pgraphene_triangle_t; t_out:Psingle):Tgraphene_ray_intersection_kind_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_ray_intersects_triangle(r:Pgraphene_ray_t; t:Pgraphene_triangle_t):Tbool;cdecl;external;

implementation


end.
