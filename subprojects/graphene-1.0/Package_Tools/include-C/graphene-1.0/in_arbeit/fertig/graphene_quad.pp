
unit graphene_quad;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_quad.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_quad.h
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
Pgraphene_quad_t  = ^graphene_quad_t;
Pgraphene_rect_t  = ^graphene_rect_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-quad.h: Quad
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
{$include "graphene-point.h"}
{*
 * graphene_quad_t:
 *
 * A 4 vertex quadrilateral, as represented by four #graphene_point_t.
 *
 * The contents of a #graphene_quad_t are private and should never be
 * accessed directly.
 *
 * Since: 1.0
  }
{< private > }
type
  Pgraphene_quad_t = ^Tgraphene_quad_t;
  Tgraphene_quad_t = record
      points : Tgraphene_point_t;
    end;


function graphene_quad_alloc:Pgraphene_quad_t;cdecl;external;
procedure graphene_quad_free(q:Pgraphene_quad_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_quad_init(q:Pgraphene_quad_t; p1:Pgraphene_point_t; p2:Pgraphene_point_t; p3:Pgraphene_point_t; p4:Pgraphene_point_t):Pgraphene_quad_t;cdecl;external;
(* Const before type ignored *)
function graphene_quad_init_from_rect(q:Pgraphene_quad_t; r:Pgraphene_rect_t):Pgraphene_quad_t;cdecl;external;
(* Const before type ignored *)
function graphene_quad_init_from_points(q:Pgraphene_quad_t; points:Pgraphene_point_t):Pgraphene_quad_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_quad_contains(q:Pgraphene_quad_t; p:Pgraphene_point_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_quad_bounds(q:Pgraphene_quad_t; r:Pgraphene_rect_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_quad_get_point(q:Pgraphene_quad_t; index_:dword):Pgraphene_point_t;cdecl;external;

implementation


end.
