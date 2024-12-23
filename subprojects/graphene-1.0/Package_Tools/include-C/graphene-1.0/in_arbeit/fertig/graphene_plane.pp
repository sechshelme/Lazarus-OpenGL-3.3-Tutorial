
unit graphene_plane;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_plane.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_plane.h
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
Pgraphene_matrix_t  = ^graphene_matrix_t;
Pgraphene_plane_t  = ^graphene_plane_t;
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Pgraphene_vec4_t  = ^graphene_vec4_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-plane.h: A plane in 3D space
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
 * graphene_plane_t:
 *
 * A 2D plane that extends infinitely in a 3D volume.
 *
 * The contents of the `graphene_plane_t` are private, and should not be
 * modified directly.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_plane_t = ^Tgraphene_plane_t;
  Tgraphene_plane_t = record
      normal : Tgraphene_vec3_t;
      constant : single;
    end;


function graphene_plane_alloc:Pgraphene_plane_t;cdecl;external;
procedure graphene_plane_free(p:Pgraphene_plane_t);cdecl;external;
(* Const before type ignored *)
function graphene_plane_init(p:Pgraphene_plane_t; normal:Pgraphene_vec3_t; constant:single):Pgraphene_plane_t;cdecl;external;
(* Const before type ignored *)
function graphene_plane_init_from_vec4(p:Pgraphene_plane_t; src:Pgraphene_vec4_t):Pgraphene_plane_t;cdecl;external;
(* Const before type ignored *)
function graphene_plane_init_from_plane(p:Pgraphene_plane_t; src:Pgraphene_plane_t):Pgraphene_plane_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_plane_init_from_point(p:Pgraphene_plane_t; normal:Pgraphene_vec3_t; point:Pgraphene_point3d_t):Pgraphene_plane_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_plane_init_from_points(p:Pgraphene_plane_t; a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; c:Pgraphene_point3d_t):Pgraphene_plane_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_plane_normalize(p:Pgraphene_plane_t; res:Pgraphene_plane_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_plane_negate(p:Pgraphene_plane_t; res:Pgraphene_plane_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_plane_equal(a:Pgraphene_plane_t; b:Pgraphene_plane_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_plane_distance(p:Pgraphene_plane_t; point:Pgraphene_point3d_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_plane_get_normal(p:Pgraphene_plane_t; normal:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
function graphene_plane_get_constant(p:Pgraphene_plane_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_plane_transform(p:Pgraphene_plane_t; matrix:Pgraphene_matrix_t; normal_matrix:Pgraphene_matrix_t; res:Pgraphene_plane_t);cdecl;external;

implementation


end.
