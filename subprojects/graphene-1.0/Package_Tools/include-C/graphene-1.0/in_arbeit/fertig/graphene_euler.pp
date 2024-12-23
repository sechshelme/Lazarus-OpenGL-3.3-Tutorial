
unit graphene_euler;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_euler.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_euler.h
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
Pgraphene_euler_order_t  = ^graphene_euler_order_t;
Pgraphene_euler_t  = ^graphene_euler_t;
Pgraphene_matrix_t  = ^graphene_matrix_t;
Pgraphene_quaternion_t  = ^graphene_quaternion_t;
Pgraphene_vec3_t  = ^graphene_vec3_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-euler.h: Euler angles
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
 * graphene_euler_order_t:
 * @GRAPHENE_EULER_ORDER_DEFAULT: Rotate in the default order; the
 *   default order is one of the following enumeration values
 * @GRAPHENE_EULER_ORDER_XYZ: Rotate in the X, Y, and Z order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SXYZ
 * @GRAPHENE_EULER_ORDER_YZX: Rotate in the Y, Z, and X order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SYZX
 * @GRAPHENE_EULER_ORDER_ZXY: Rotate in the Z, X, and Y order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SZXY
 * @GRAPHENE_EULER_ORDER_XZY: Rotate in the X, Z, and Y order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SXZY
 * @GRAPHENE_EULER_ORDER_YXZ: Rotate in the Y, X, and Z order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SYXZ
 * @GRAPHENE_EULER_ORDER_ZYX: Rotate in the Z, Y, and X order. Deprecated in
 *   Graphene 1.10, it's an alias for %GRAPHENE_EULER_ORDER_SZYX
 * @GRAPHENE_EULER_ORDER_SXYZ: Defines a static rotation along the X, Y, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SXYX: Defines a static rotation along the X, Y, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SXZY: Defines a static rotation along the X, Z, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SXZX: Defines a static rotation along the X, Z, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SYZX: Defines a static rotation along the Y, Z, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SYZY: Defines a static rotation along the Y, Z, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SYXZ: Defines a static rotation along the Y, X, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SYXY: Defines a static rotation along the Y, X, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SZXY: Defines a static rotation along the Z, X, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SZXZ: Defines a static rotation along the Z, X, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SZYX: Defines a static rotation along the Z, Y, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_SZYZ: Defines a static rotation along the Z, Y, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RZYX: Defines a relative rotation along the Z, Y, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RXYX: Defines a relative rotation along the X, Y, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RYZX: Defines a relative rotation along the Y, Z, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RXZX: Defines a relative rotation along the X, Z, and X axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RXZY: Defines a relative rotation along the X, Z, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RYZY: Defines a relative rotation along the Y, Z, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RZXY: Defines a relative rotation along the Z, X, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RYXY: Defines a relative rotation along the Y, X, and Y axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RYXZ: Defines a relative rotation along the Y, X, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RZXZ: Defines a relative rotation along the Z, X, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RXYZ: Defines a relative rotation along the X, Y, and Z axes (Since: 1.10)
 * @GRAPHENE_EULER_ORDER_RZYZ: Defines a relative rotation along the Z, Y, and Z axes (Since: 1.10)
 *
 * Specify the order of the rotations on each axis.
 *
 * The %GRAPHENE_EULER_ORDER_DEFAULT value is special, and is used
 * as an alias for one of the other orders.
 *
 * Since: 1.2
  }
{ Deprecated  }
{ Static (extrinsic) coordinate axes  }
{ Relative (intrinsic) coordinate axes  }
type
  Pgraphene_euler_order_t = ^Tgraphene_euler_order_t;
  Tgraphene_euler_order_t =  Longint;
  Const
    GRAPHENE_EULER_ORDER_DEFAULT = -(1);
    GRAPHENE_EULER_ORDER_XYZ = 0;
    GRAPHENE_EULER_ORDER_YZX = 1;
    GRAPHENE_EULER_ORDER_ZXY = 2;
    GRAPHENE_EULER_ORDER_XZY = 3;
    GRAPHENE_EULER_ORDER_YXZ = 4;
    GRAPHENE_EULER_ORDER_ZYX = 5;
    GRAPHENE_EULER_ORDER_SXYZ = 6;
    GRAPHENE_EULER_ORDER_SXYX = 7;
    GRAPHENE_EULER_ORDER_SXZY = 8;
    GRAPHENE_EULER_ORDER_SXZX = 9;
    GRAPHENE_EULER_ORDER_SYZX = 10;
    GRAPHENE_EULER_ORDER_SYZY = 11;
    GRAPHENE_EULER_ORDER_SYXZ = 12;
    GRAPHENE_EULER_ORDER_SYXY = 13;
    GRAPHENE_EULER_ORDER_SZXY = 14;
    GRAPHENE_EULER_ORDER_SZXZ = 15;
    GRAPHENE_EULER_ORDER_SZYX = 16;
    GRAPHENE_EULER_ORDER_SZYZ = 17;
    GRAPHENE_EULER_ORDER_RZYX = 18;
    GRAPHENE_EULER_ORDER_RXYX = 19;
    GRAPHENE_EULER_ORDER_RYZX = 20;
    GRAPHENE_EULER_ORDER_RXZX = 21;
    GRAPHENE_EULER_ORDER_RXZY = 22;
    GRAPHENE_EULER_ORDER_RYZY = 23;
    GRAPHENE_EULER_ORDER_RZXY = 24;
    GRAPHENE_EULER_ORDER_RYXY = 25;
    GRAPHENE_EULER_ORDER_RYXZ = 26;
    GRAPHENE_EULER_ORDER_RZXZ = 27;
    GRAPHENE_EULER_ORDER_RXYZ = 28;
    GRAPHENE_EULER_ORDER_RZYZ = 29;
;
{*
 * graphene_euler_t:
 *
 * Describe a rotation using Euler angles.
 *
 * The contents of the #graphene_euler_t structure are private
 * and should never be accessed directly.
 *
 * Since: 1.2
  }
{< private > }
type
  Pgraphene_euler_t = ^Tgraphene_euler_t;
  Tgraphene_euler_t = record
      angles : Tgraphene_vec3_t;
      order : Tgraphene_euler_order_t;
    end;


function graphene_euler_alloc:Pgraphene_euler_t;cdecl;external;
procedure graphene_euler_free(e:Pgraphene_euler_t);cdecl;external;
function graphene_euler_init(e:Pgraphene_euler_t; x:single; y:single; z:single):Pgraphene_euler_t;cdecl;external;
function graphene_euler_init_with_order(e:Pgraphene_euler_t; x:single; y:single; z:single; order:Tgraphene_euler_order_t):Pgraphene_euler_t;cdecl;external;
(* Const before type ignored *)
function graphene_euler_init_from_matrix(e:Pgraphene_euler_t; m:Pgraphene_matrix_t; order:Tgraphene_euler_order_t):Pgraphene_euler_t;cdecl;external;
(* Const before type ignored *)
function graphene_euler_init_from_quaternion(e:Pgraphene_euler_t; q:Pgraphene_quaternion_t; order:Tgraphene_euler_order_t):Pgraphene_euler_t;cdecl;external;
(* Const before type ignored *)
function graphene_euler_init_from_vec3(e:Pgraphene_euler_t; v:Pgraphene_vec3_t; order:Tgraphene_euler_order_t):Pgraphene_euler_t;cdecl;external;
(* Const before type ignored *)
function graphene_euler_init_from_euler(e:Pgraphene_euler_t; src:Pgraphene_euler_t):Pgraphene_euler_t;cdecl;external;
function graphene_euler_init_from_radians(e:Pgraphene_euler_t; x:single; y:single; z:single; order:Tgraphene_euler_order_t):Pgraphene_euler_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_euler_equal(a:Pgraphene_euler_t; b:Pgraphene_euler_t):Tbool;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_x(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_y(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_z(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_order(e:Pgraphene_euler_t):Tgraphene_euler_order_t;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_alpha(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_beta(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
function graphene_euler_get_gamma(e:Pgraphene_euler_t):single;cdecl;external;
(* Const before type ignored *)
procedure graphene_euler_to_vec3(e:Pgraphene_euler_t; res:Pgraphene_vec3_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_euler_to_matrix(e:Pgraphene_euler_t; res:Pgraphene_matrix_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_euler_to_quaternion(e:Pgraphene_euler_t; res:Pgraphene_quaternion_t);cdecl;external;
(* Const before type ignored *)
procedure graphene_euler_reorder(e:Pgraphene_euler_t; order:Tgraphene_euler_order_t; res:Pgraphene_euler_t);cdecl;external;

implementation


end.
