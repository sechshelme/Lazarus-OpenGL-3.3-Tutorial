
unit graphene_sphere;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_sphere.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_sphere.h
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


{ graphene-sphere.h: A sphere
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
 * graphene_sphere_t:
 *
 * A sphere, represented by its center and radius.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_sphere_t = ^Tgraphene_sphere_t;
  Tgraphene_sphere_t = record
      center : Tgraphene_vec3_t;
      radius : single;
    end;


function graphene_sphere_alloc:Pgraphene_sphere_t;cdecl;external;
procedure graphene_sphere_free(s:Pgraphene_sphere_t);cdecl;external;
(* Const before type ignored *)
function graphene_sphere_init(s:Pgraphene_sphere_t; center:Pgraphene_point3d_t; radius:single):Pgraphene_sphere_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_sphere_init_from_points(s:Pgraphene_sphere_t; n_points:dword; points:Pgraphene_point3d_t; center:Pgraphene_point3d_t):Pgraphene_sphere_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_sphere_init_from_vectors(s:Pgraphene_sphere_t; n_vectors:dword; vectors:Pgraphene_vec3_t; center:Pgraphene_point3d_t):Pgraphene_sphere_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_sphere_get_center(s:Pgraphene_sphere_t; center:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
function graphene_sphere_get_radius(s:Pgraphene_sphere_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_sphere_is_empty(s:Pgraphene_sphere_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_sphere_equal(a:Pgraphene_sphere_t; b:Pgraphene_sphere_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_sphere_contains_point(s:Pgraphene_sphere_t; point:Pgraphene_point3d_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_sphere_distance(s:Pgraphene_sphere_t; point:Pgraphene_point3d_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_sphere_get_bounding_box(s:Pgraphene_sphere_t; box:Pgraphene_box_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_sphere_translate(s:Pgraphene_sphere_t; point:Pgraphene_point3d_t; res:Pgraphene_sphere_t);cdecl;external;

implementation


end.
