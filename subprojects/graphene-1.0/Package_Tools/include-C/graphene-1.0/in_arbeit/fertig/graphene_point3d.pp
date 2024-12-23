
unit graphene_point3d;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_point3d.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_point3d.h
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
Pgraphene_point3d_t  = ^graphene_point3d_t;
Pgraphene_rect_t  = ^graphene_rect_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-point3d.h: Point in 3D space
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
 * GRAPHENE_POINT3D_INIT:
 * @_x: the X coordinate
 * @_y: the Y coordinate
 * @_z: the Z coordinate
 *
 * Initializes a #graphene_point3d_t to the given coordinates when declaring it.
 *
 * Since: 1.0
 *
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//#define GRAPHENE_POINT3D_INIT(_x,_y,_z) (graphene_point3d_t)  .x = (_x), .y = (_y), .z = (_z) 

/**
 * GRAPHENE_POINT3D_INIT_ZERO:
 *
 * Initializes a #graphene_point3d_t to (0, 0, 0) when declaring it.
 *
 * Since: 1.0
  }

{ was #define dname def_expr }
function GRAPHENE_POINT3D_INIT_ZERO : longint; { return type might be wrong }

{*
 * graphene_point3d_t:
 * @x: the X coordinate
 * @y: the Y coordinate
 * @z: the Z coordinate
 *
 * A point with three components: X, Y, and Z.
 *
 * Since: 1.0
  }
type
  Pgraphene_point3d_t = ^Tgraphene_point3d_t;
  Tgraphene_point3d_t = record
      x : single;
      y : single;
      z : single;
    end;


function graphene_point3d_alloc:Pgraphene_point3d_t;cdecl;external;
procedure graphene_point3d_free(p:Pgraphene_point3d_t);cdecl;external;
function graphene_point3d_init(p:Pgraphene_point3d_t; x:single; y:single; z:single):Pgraphene_point3d_t;cdecl;external;
(* Const before type ignored *)
function graphene_point3d_init_from_point(p:Pgraphene_point3d_t; src:Pgraphene_point3d_t):Pgraphene_point3d_t;cdecl;external;
(* Const before type ignored *)
function graphene_point3d_init_from_vec3(p:Pgraphene_point3d_t; v:Pgraphene_vec3_t):Pgraphene_point3d_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_point3d_to_vec3(p:Pgraphene_point3d_t; v:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point3d_equal(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point3d_near(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; epsilon:single):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_point3d_scale(p:Pgraphene_point3d_t; factor:single; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_point3d_cross(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point3d_dot(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_point3d_length(p:Pgraphene_point3d_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_point3d_normalize(p:Pgraphene_point3d_t; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_point3d_distance(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; delta:Pgraphene_vec3_t):single;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_point3d_interpolate(a:Pgraphene_point3d_t; b:Pgraphene_point3d_t; factor:Tdouble; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_point3d_normalize_viewport(p:Pgraphene_point3d_t; viewport:Pgraphene_rect_t; z_near:single; z_far:single; res:Pgraphene_point3d_t);cdecl;external;
(* Const before type ignored *)
function graphene_point3d_zero:Pgraphene_point3d_t;cdecl;external;

implementation

{ was #define dname def_expr }
function GRAPHENE_POINT3D_INIT_ZERO : longint; { return type might be wrong }
  begin
    GRAPHENE_POINT3D_INIT_ZERO:=GRAPHENE_POINT3D_INIT(0.f,0.f,0.f);
  end;


end.
