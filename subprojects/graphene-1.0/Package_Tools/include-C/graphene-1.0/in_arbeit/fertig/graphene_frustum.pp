
unit graphene_frustum;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_frustum.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_frustum.h
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
Pgraphene_frustum_t  = ^graphene_frustum_t;
Pgraphene_matrix_t  = ^graphene_matrix_t;
Pgraphene_plane_t  = ^graphene_plane_t;
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_sphere_t  = ^graphene_sphere_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-frustum.h: A 3D field of view
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
{$include "graphene-plane.h"}
{*
 * graphene_frustum_t:
 *
 * A 3D volume delimited by 2D clip planes.
 *
 * The contents of the `graphene_frustum_t` are private, and should not be
 * modified directly.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_frustum_t = ^Tgraphene_frustum_t;
  Tgraphene_frustum_t = record
      planes : array[0..5] of Tgraphene_plane_t;
    end;


function graphene_frustum_alloc:Pgraphene_frustum_t;cdecl;external;
procedure graphene_frustum_free(f:Pgraphene_frustum_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_frustum_init(f:Pgraphene_frustum_t; p0:Pgraphene_plane_t; p1:Pgraphene_plane_t; p2:Pgraphene_plane_t; p3:Pgraphene_plane_t; 
           p4:Pgraphene_plane_t; p5:Pgraphene_plane_t):Pgraphene_frustum_t;cdecl;external;
(* Const before type ignored *)
function graphene_frustum_init_from_frustum(f:Pgraphene_frustum_t; src:Pgraphene_frustum_t):Pgraphene_frustum_t;cdecl;external;
(* Const before type ignored *)
function graphene_frustum_init_from_matrix(f:Pgraphene_frustum_t; matrix:Pgraphene_matrix_t):Pgraphene_frustum_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_frustum_contains_point(f:Pgraphene_frustum_t; point:Pgraphene_point3d_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_frustum_intersects_sphere(f:Pgraphene_frustum_t; sphere:Pgraphene_sphere_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_frustum_intersects_box(f:Pgraphene_frustum_t; box:Pgraphene_box_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_frustum_get_planes(f:Pgraphene_frustum_t; planes:Pgraphene_plane_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_frustum_equal(a:Pgraphene_frustum_t; b:Pgraphene_frustum_t):Tbool;cdecl;external;

implementation


end.
