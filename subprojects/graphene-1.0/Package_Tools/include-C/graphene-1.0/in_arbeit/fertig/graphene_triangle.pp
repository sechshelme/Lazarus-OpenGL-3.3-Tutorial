
unit graphene_triangle;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_triangle.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_triangle.h
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
Pgraphene_triangle_t  = ^graphene_triangle_t;
Pgraphene_vec2_t  = ^graphene_vec2_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-triangle.h: A triangle
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
 * graphene_triangle_t:
 *
 * A triangle.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_triangle_t = ^Tgraphene_triangle_t;
  Tgraphene_triangle_t = record
      a : Tgraphene_vec3_t;
      b : Tgraphene_vec3_t;
      c : Tgraphene_vec3_t;
    end;


function graphene_triangle_alloc:Pgraphene_triangle_t;cdecl;external;
procedure graphene_triangle_free(t:Pgraphene_triangle_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_init_from_point3d(t:Pgraphene_triangle_t; a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; c:Pgraphene_point3d_t):Pgraphene_triangle_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_init_from_vec3(t:Pgraphene_triangle_t; a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; c:Pgraphene_vec3_t):Pgraphene_triangle_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_init_from_float(t:Pgraphene_triangle_t; a:Psingle; b:Psingle; c:Psingle):Pgraphene_triangle_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_points(t:Pgraphene_triangle_t; a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; c:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_vertices(t:Pgraphene_triangle_t; a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; c:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
function graphene_triangle_get_area(t:Pgraphene_triangle_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_midpoint(t:Pgraphene_triangle_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_normal(t:Pgraphene_triangle_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_plane(t:Pgraphene_triangle_t; res:Pgraphene_plane_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_triangle_get_bounding_box(t:Pgraphene_triangle_t; res:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_get_barycoords(t:Pgraphene_triangle_t; p:Pgraphene_point3d_t; res:Pgraphene_vec2_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_get_uv(t:Pgraphene_triangle_t; p:Pgraphene_point3d_t; uv_a:Pgraphene_vec2_t; uv_b:Pgraphene_vec2_t; uv_c:Pgraphene_vec2_t; 
           res:Pgraphene_vec2_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_contains_point(t:Pgraphene_triangle_t; p:Pgraphene_point3d_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_triangle_equal(a:Pgraphene_triangle_t; b:Pgraphene_triangle_t):Tbool;cdecl;external;

implementation


end.
