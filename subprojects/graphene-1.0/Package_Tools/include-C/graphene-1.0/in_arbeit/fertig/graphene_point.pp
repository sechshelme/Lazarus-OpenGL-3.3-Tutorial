
unit graphene_point;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_point.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_point.h
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
Pgraphene_vec2_t  = ^graphene_vec2_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-point.h: Point and Size
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
 * GRAPHENE_POINT_INIT:
 * @_x: the X coordinate
 * @_y: the Y coordinate
 *
 * Initializes a #graphene_point_t with the given coordinates
 * when declaring it, e.g:
 *
 * |[<!-- language="C" -->
 *   graphene_point_t p = GRAPHENE_POINT_INIT (10.f, 10.f);
 * ]|
 *
 * Since: 1.0
  }
{ xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx }
{#define GRAPHENE_POINT_INIT(_x,_y)      (graphene_point_t)  .x = (_x), .y = (_y)  }
{*
 * GRAPHENE_POINT_INIT_ZERO:
 *
 * Initializes a #graphene_point_t to (0, 0) when declaring it.
 *
 * Since: 1.0
  }

{ was #define dname def_expr }
function GRAPHENE_POINT_INIT_ZERO : longint; { return type might be wrong }

{*
 * graphene_point_t:
 * @x: the X coordinate of the point
 * @y: the Y coordinate of the point
 *
 * A point with two coordinates.
 *
 * Since: 1.0
  }
type
  Pgraphene_point_t = ^Tgraphene_point_t;
  Tgraphene_point_t = record
      x : single;
      y : single;
    end;


function graphene_point_alloc:Pgraphene_point_t;cdecl;external;
procedure graphene_point_free(p:Pgraphene_point_t);cdecl;external;
function graphene_point_init(p:Pgraphene_point_t; x:single; y:single):Pgraphene_point_t;cdecl;external;
(* Const before type ignored *)
function graphene_point_init_from_point(p:Pgraphene_point_t; src:Pgraphene_point_t):Pgraphene_point_t;cdecl;external;
(* Const before type ignored *)
function graphene_point_init_from_vec2(p:Pgraphene_point_t; src:Pgraphene_vec2_t):Pgraphene_point_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point_equal(a:Pgraphene_point_t; b:Pgraphene_point_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point_distance(a:Pgraphene_point_t; b:Pgraphene_point_t; d_x:Psingle; d_y:Psingle):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point_near(a:Pgraphene_point_t; b:Pgraphene_point_t; epsilon:single):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_point_interpolate(a:Pgraphene_point_t; b:Pgraphene_point_t; factor:Tdouble; res:Pgraphene_point_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_point_to_vec2(p:Pgraphene_point_t; v:Pgraphene_vec2_t);cdecl;external;
(* Const before type ignored *)
function graphene_point_zero:Pgraphene_point_t;cdecl;external;

implementation

{ was #define dname def_expr }
function GRAPHENE_POINT_INIT_ZERO : longint; { return type might be wrong }
  begin
    GRAPHENE_POINT_INIT_ZERO:=GRAPHENE_POINT_INIT(0.f,0.f);
  end;


end.
