
unit graphene_rect;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_rect.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_rect.h
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
Pgraphene_point_t  = ^graphene_point_t;
Pgraphene_rect_t  = ^graphene_rect_t;
Pgraphene_vec2_t  = ^graphene_vec2_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-rect.h: Rectangular type
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
{$include "graphene-point.h"}
{$include "graphene-size.h"}
{$include "graphene-vec2.h"}
{*
 * GRAPHENE_RECT_INIT:
 * @_x: the X coordinate of the origin
 * @_y: the Y coordinate of the origin
 * @_w: the width
 * @_h: the height
 *
 * Initializes a #graphene_rect_t when declaring it.
 *
 * Since: 1.0
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  }
{#define GRAPHENE_RECT_INIT(_x,_y,_w,_h) \ }
{  (graphene_rect_t)  .origin =  .x = (_x), .y = (_y) , .size =  .width = (_w), .height = (_h)   }
{*
 * GRAPHENE_RECT_INIT_ZERO:
 *
 * Initializes a #graphene_rect_t to a degenerate rectangle with an origin
 * in (0, 0) and a size of 0.
 *
 * Since: 1.10
  }

{ was #define dname def_expr }
function GRAPHENE_RECT_INIT_ZERO : longint; { return type might be wrong }

{*
 * graphene_rect_t:
 * @origin: the coordinates of the origin of the rectangle
 * @size: the size of the rectangle
 *
 * The location and size of a rectangle region.
 *
 * The width and height of a #graphene_rect_t can be negative; for instance,
 * a #graphene_rect_t with an origin of [ 0, 0 ] and a size of [ 10, 10 ] is
 * equivalent to a #graphene_rect_t with an origin of [ 10, 10 ] and a size
 * of [ -10, -10 ].
 *
 * Application code can normalize rectangles using graphene_rect_normalize();
 * this function will ensure that the width and height of a rectangle are
 * positive values. All functions taking a #graphene_rect_t as an argument
 * will internally operate on a normalized copy; all functions returning a
 * #graphene_rect_t will always return a normalized rectangle.
 *
 * Since: 1.0
  }
type
  Pgraphene_rect_t = ^Tgraphene_rect_t;
  Tgraphene_rect_t = record
      origin : Tgraphene_point_t;
      size : Tgraphene_size_t;
    end;


function graphene_rect_alloc:Pgraphene_rect_t;cdecl;external;
procedure graphene_rect_free(r:Pgraphene_rect_t);cdecl;external;
function graphene_rect_init(r:Pgraphene_rect_t; x:single; y:single; width:single; height:single):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
function graphene_rect_init_from_rect(r:Pgraphene_rect_t; src:Pgraphene_rect_t):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_rect_equal(a:Pgraphene_rect_t; b:Pgraphene_rect_t):Tbool;cdecl;external;
function graphene_rect_normalize(r:Pgraphene_rect_t):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_normalize_r(r:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_center(r:Pgraphene_rect_t; p:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_top_left(r:Pgraphene_rect_t; p:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_top_right(r:Pgraphene_rect_t; p:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_bottom_right(r:Pgraphene_rect_t; p:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_bottom_left(r:Pgraphene_rect_t; p:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_get_vertices(r:Pgraphene_rect_t; vertices:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
function graphene_rect_get_x(r:Pgraphene_rect_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_rect_get_y(r:Pgraphene_rect_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_rect_get_width(r:Pgraphene_rect_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_rect_get_height(r:Pgraphene_rect_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_rect_get_area(r:Pgraphene_rect_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_rect_union(a:Pgraphene_rect_t; b:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_rect_intersection(a:Pgraphene_rect_t; b:Pgraphene_rect_t; res:Pgraphene_rect_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_rect_contains_point(r:Pgraphene_rect_t; p:Pgraphene_point_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_rect_contains_rect(a:Pgraphene_rect_t; b:Pgraphene_rect_t):Tbool;cdecl;external;
function graphene_rect_offset(r:Pgraphene_rect_t; d_x:single; d_y:single):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_offset_r(r:Pgraphene_rect_t; d_x:single; d_y:single; res:Pgraphene_rect_t);cdecl;external;
function graphene_rect_inset(r:Pgraphene_rect_t; d_x:single; d_y:single):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_inset_r(r:Pgraphene_rect_t; d_x:single; d_y:single; res:Pgraphene_rect_t);cdecl;external;
function graphene_rect_round_to_pixel(r:Pgraphene_rect_t):Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_round(r:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_round_extents(r:Pgraphene_rect_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_rect_interpolate(a:Pgraphene_rect_t; b:Pgraphene_rect_t; factor:Tdouble; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_rect_expand(r:Pgraphene_rect_t; p:Pgraphene_point_t; res:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
function graphene_rect_zero:Pgraphene_rect_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_rect_scale(r:Pgraphene_rect_t; s_h:single; s_v:single; res:Pgraphene_rect_t);cdecl;external;

implementation

{ was #define dname def_expr }
function GRAPHENE_RECT_INIT_ZERO : longint; { return type might be wrong }
  begin
    GRAPHENE_RECT_INIT_ZERO:=GRAPHENE_RECT_INIT(0.f,0.f,0.f,0.f);
  end;


end.
