
unit graphene_vec3;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_vec3.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_vec3.h
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
Pgraphene_vec2_t  = ^graphene_vec2_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Pgraphene_vec4_t  = ^graphene_vec4_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-vec3.h: 3-coords vector
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
{*
 * graphene_vec3_t:
 *
 * A structure capable of holding a vector with three dimensions: x, y, and z.
 *
 * The contents of the #graphene_vec3_t structure are private and should
 * never be accessed directly.
  }
{< private > }
{  GRAPHENE_ALIGNED_DECL (GRAPHENE_PRIVATE_FIELD (graphene_simd4f_t, value), 16); }
type
  Pgraphene_vec3_t = ^Tgraphene_vec3_t;
  Tgraphene_vec3_t = record
      value : Tgraphene_simd4f_t;
    end;


function graphene_vec3_alloc:Pgraphene_vec3_t;cdecl;external;
procedure graphene_vec3_free(v:Pgraphene_vec3_t);cdecl;external;
function graphene_vec3_init(v:Pgraphene_vec3_t; x:single; y:single; z:single):Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_init_from_vec3(v:Pgraphene_vec3_t; src:Pgraphene_vec3_t):Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_init_from_float(v:Pgraphene_vec3_t; src:Psingle):Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_to_float(v:Pgraphene_vec3_t; dest:Psingle);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_add(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_subtract(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_multiply(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_divide(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_cross(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec3_dot(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_length(v:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_normalize(v:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_scale(v:Pgraphene_vec3_t; factor:single; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_negate(v:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec3_equal(v1:Pgraphene_vec3_t; v2:Pgraphene_vec3_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec3_near(v1:Pgraphene_vec3_t; v2:Pgraphene_vec3_t; epsilon:single):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_min(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_max(a:Pgraphene_vec3_t; b:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec3_interpolate(v1:Pgraphene_vec3_t; v2:Pgraphene_vec3_t; factor:Tdouble; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
function graphene_vec3_get_x(v:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_get_y(v:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_get_z(v:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_get_xy(v:Pgraphene_vec3_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_get_xy0(v:Pgraphene_vec3_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_get_xyz0(v:Pgraphene_vec3_t; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_get_xyz1(v:Pgraphene_vec3_t; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec3_get_xyzw(v:Pgraphene_vec3_t; w:single; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
function graphene_vec3_zero:Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_one:Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_x_axis:Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_y_axis:Pgraphene_vec3_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec3_z_axis:Pgraphene_vec3_t;cdecl;external;

implementation


end.
