
unit graphene_gobject;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_gobject.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_gobject.h
}

{ Pointers to basic pascal types, inserted by h2pas conversion program.}
Type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-gobject.h: Shared GObject types
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
{$include <glib-object.h>}
{$include <graphene.h>}

{ was #define dname def_expr }
function GRAPHENE_TYPE_POINT : longint; { return type might be wrong }

function graphene_point_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_POINT3D : longint; { return type might be wrong }

function graphene_point3d_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_SIZE : longint; { return type might be wrong }

function graphene_size_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_RECT : longint; { return type might be wrong }

function graphene_rect_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC2 : longint; { return type might be wrong }

function graphene_vec2_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC3 : longint; { return type might be wrong }

function graphene_vec3_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC4 : longint; { return type might be wrong }

function graphene_vec4_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_QUAD : longint; { return type might be wrong }

function graphene_quad_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_QUATERNION : longint; { return type might be wrong }

function graphene_quaternion_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_MATRIX : longint; { return type might be wrong }

function graphene_matrix_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_PLANE : longint; { return type might be wrong }

function graphene_plane_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_FRUSTUM : longint; { return type might be wrong }

function graphene_frustum_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_SPHERE : longint; { return type might be wrong }

function graphene_sphere_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_BOX : longint; { return type might be wrong }

function graphene_box_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_TRIANGLE : longint; { return type might be wrong }

function graphene_triangle_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_EULER : longint; { return type might be wrong }

function graphene_euler_get_type:TGType;cdecl;external;
{ was #define dname def_expr }
function GRAPHENE_TYPE_RAY : longint; { return type might be wrong }

function graphene_ray_get_type:TGType;cdecl;external;

implementation

{ was #define dname def_expr }
function GRAPHENE_TYPE_POINT : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_POINT:=graphene_point_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_POINT3D : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_POINT3D:=graphene_point3d_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_SIZE : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_SIZE:=graphene_size_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_RECT : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_RECT:=graphene_rect_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC2 : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_VEC2:=graphene_vec2_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC3 : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_VEC3:=graphene_vec3_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_VEC4 : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_VEC4:=graphene_vec4_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_QUAD : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_QUAD:=graphene_quad_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_QUATERNION : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_QUATERNION:=graphene_quaternion_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_MATRIX : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_MATRIX:=graphene_matrix_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_PLANE : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_PLANE:=graphene_plane_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_FRUSTUM : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_FRUSTUM:=graphene_frustum_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_SPHERE : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_SPHERE:=graphene_sphere_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_BOX : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_BOX:=graphene_box_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_TRIANGLE : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_TRIANGLE:=graphene_triangle_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_EULER : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_EULER:=graphene_euler_get_type;
  end;

{ was #define dname def_expr }
function GRAPHENE_TYPE_RAY : longint; { return type might be wrong }
  begin
    GRAPHENE_TYPE_RAY:=graphene_ray_get_type;
  end;


end.
