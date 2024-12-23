
unit graphene_box;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_box.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_box.h
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
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_sphere_t  = ^graphene_sphere_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-box.h: An axis aligned bounding box
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
{$if !defined(GRAPHENE_H_INSIDE) && !defined(GRAPHENE_COMPILATION)}
{$error "Only graphene.h can be included directly."}
{$endif}
{$include "graphene-types.h"}
{$include "graphene-vec3.h"}
{*
 * graphene_box_t:
 *
 * A 3D box, described as the volume between a minimum and
 * a maximum vertices.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_box_t = ^Tgraphene_box_t;
  Tgraphene_box_t = record
      min : Tgraphene_vec3_t;
      max : Tgraphene_vec3_t;
    end;


function graphene_box_alloc:Pgraphene_box_t;cdecl;external;
procedure graphene_box_free(box:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_init(box:Pgraphene_box_t; min:Pgraphene_point3d_t; max:Pgraphene_point3d_t):Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_init_from_points(box:Pgraphene_box_t; n_points:dword; points:Pgraphene_point3d_t):Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_init_from_vectors(box:Pgraphene_box_t; n_vectors:dword; vectors:Pgraphene_vec3_t):Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_init_from_box(box:Pgraphene_box_t; src:Pgraphene_box_t):Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_init_from_vec3(box:Pgraphene_box_t; min:Pgraphene_vec3_t; max:Pgraphene_vec3_t):Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_box_expand(box:Pgraphene_box_t; point:Pgraphene_point3d_t; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_box_expand_vec3(box:Pgraphene_box_t; vec:Pgraphene_vec3_t; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_expand_scalar(box:Pgraphene_box_t; scalar:single; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_box_union(a:Pgraphene_box_t; b:Pgraphene_box_t; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_intersection(a:Pgraphene_box_t; b:Pgraphene_box_t; res:Pgraphene_box_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_box_get_width(box:Pgraphene_box_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_box_get_height(box:Pgraphene_box_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_box_get_depth(box:Pgraphene_box_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_size(box:Pgraphene_box_t; size:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_center(box:Pgraphene_box_t; center:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_min(box:Pgraphene_box_t; min:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_max(box:Pgraphene_box_t; max:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_vertices(box:Pgraphene_box_t; vertices:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_box_get_bounding_sphere(box:Pgraphene_box_t; sphere:Pgraphene_sphere_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_contains_point(box:Pgraphene_box_t; point:Pgraphene_point3d_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_contains_box(a:Pgraphene_box_t; b:Pgraphene_box_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_box_equal(a:Pgraphene_box_t; b:Pgraphene_box_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_box_zero:Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_one:Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_minus_one:Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_one_minus_one:Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_infinite:Pgraphene_box_t;cdecl;external;
(* Const before type ignored *)
function graphene_box_empty:Pgraphene_box_t;cdecl;external;

implementation


end.
