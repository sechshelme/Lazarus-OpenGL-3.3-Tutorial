
unit graphene_vec2;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_vec2.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_vec2.h
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
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-vec2.h: 2-coords vector
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
 * graphene_vec2_t:
 *
 * A structure capable of holding a vector with two dimensions, x and y.
 *
 * The contents of the #graphene_vec2_t structure are private and should
 * never be accessed directly.
  }
{struct _graphene_vec2_t }
{ }
{< private > }
{  GRAPHENE_ALIGNED_DECL (GRAPHENE_PRIVATE_FIELD (graphene_simd4f_t, value), 16); }
{; }

function graphene_vec2_alloc:Pgraphene_vec2_t;cdecl;external;
procedure graphene_vec2_free(v:Pgraphene_vec2_t);cdecl;external;
function graphene_vec2_init(v:Pgraphene_vec2_t; x:single; y:single):Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_init_from_vec2(v:Pgraphene_vec2_t; src:Pgraphene_vec2_t):Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_init_from_float(v:Pgraphene_vec2_t; src:Psingle):Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_vec2_to_float(v:Pgraphene_vec2_t; dest:Psingle);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_add(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_subtract(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_multiply(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_divide(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec2_dot(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_length(v:Pgraphene_vec2_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_vec2_normalize(v:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec2_scale(v:Pgraphene_vec2_t; factor:single; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_vec2_negate(v:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec2_near(v1:Pgraphene_vec2_t; v2:Pgraphene_vec2_t; epsilon:single):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_vec2_equal(v1:Pgraphene_vec2_t; v2:Pgraphene_vec2_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_min(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_max(a:Pgraphene_vec2_t; b:Pgraphene_vec2_t; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_vec2_interpolate(v1:Pgraphene_vec2_t; v2:Pgraphene_vec2_t; factor:Tdouble; res:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
function graphene_vec2_get_x(v:Pgraphene_vec2_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_get_y(v:Pgraphene_vec2_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_zero:Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_one:Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_x_axis:Pgraphene_vec2_t;cdecl;external;
(* Const before type ignored *)
function graphene_vec2_y_axis:Pgraphene_vec2_t;cdecl;external;

implementation


end.
