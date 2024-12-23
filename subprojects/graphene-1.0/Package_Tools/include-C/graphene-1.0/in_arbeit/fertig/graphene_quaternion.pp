
unit graphene_quaternion;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_quaternion.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_quaternion.h
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
Pgraphene_euler_t  = ^graphene_euler_t;
Pgraphene_matrix_t  = ^graphene_matrix_t;
Pgraphene_quaternion_t  = ^graphene_quaternion_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
Pgraphene_vec4_t  = ^graphene_vec4_t;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-quaternion.h: Quaternion
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
{$include "graphene-vec4.h"}
{*
 * graphene_quaternion_t:
 *
 * A quaternion.
 *
 * The contents of the #graphene_quaternion_t structure are private
 * and should never be accessed directly.
 *
 * Since: 1.0
  }
{< private > }
type
  Pgraphene_quaternion_t = ^Tgraphene_quaternion_t;
  Tgraphene_quaternion_t = record
      x : single;
      y : single;
      z : single;
      w : single;
    end;


function graphene_quaternion_alloc:Pgraphene_quaternion_t;cdecl;external;
procedure graphene_quaternion_free(q:Pgraphene_quaternion_t);cdecl;external;
function graphene_quaternion_init(q:Pgraphene_quaternion_t; x:single; y:single; z:single; w:single):Pgraphene_quaternion_t;cdecl;external;
function graphene_quaternion_init_identity(q:Pgraphene_quaternion_t):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
function graphene_quaternion_init_from_quaternion(q:Pgraphene_quaternion_t; src:Pgraphene_quaternion_t):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
function graphene_quaternion_init_from_vec4(q:Pgraphene_quaternion_t; src:Pgraphene_vec4_t):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
function graphene_quaternion_init_from_matrix(q:Pgraphene_quaternion_t; m:Pgraphene_matrix_t):Pgraphene_quaternion_t;cdecl;external;
function graphene_quaternion_init_from_angles(q:Pgraphene_quaternion_t; deg_x:single; deg_y:single; deg_z:single):Pgraphene_quaternion_t;cdecl;external;
function graphene_quaternion_init_from_radians(q:Pgraphene_quaternion_t; rad_x:single; rad_y:single; rad_z:single):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
function graphene_quaternion_init_from_angle_vec3(q:Pgraphene_quaternion_t; angle:single; axis:Pgraphene_vec3_t):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
function graphene_quaternion_init_from_euler(q:Pgraphene_quaternion_t; e:Pgraphene_euler_t):Pgraphene_quaternion_t;cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_to_vec4(q:Pgraphene_quaternion_t; res:Pgraphene_vec4_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_to_matrix(q:Pgraphene_quaternion_t; m:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_to_angles(q:Pgraphene_quaternion_t; deg_x:Psingle; deg_y:Psingle; deg_z:Psingle);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_to_radians(q:Pgraphene_quaternion_t; rad_x:Psingle; rad_y:Psingle; rad_z:Psingle);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_to_angle_vec3(q:Pgraphene_quaternion_t; angle:Psingle; axis:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_quaternion_equal(a:Pgraphene_quaternion_t; b:Pgraphene_quaternion_t):Tbool;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_quaternion_dot(a:Pgraphene_quaternion_t; b:Pgraphene_quaternion_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_invert(q:Pgraphene_quaternion_t; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_normalize(q:Pgraphene_quaternion_t; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_quaternion_slerp(a:Pgraphene_quaternion_t; b:Pgraphene_quaternion_t; factor:single; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_quaternion_multiply(a:Pgraphene_quaternion_t; b:Pgraphene_quaternion_t; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_quaternion_scale(q:Pgraphene_quaternion_t; factor:single; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_quaternion_add(a:Pgraphene_quaternion_t; b:Pgraphene_quaternion_t; res:Pgraphene_quaternion_t);cdecl;external;

implementation


end.
