
unit graphene_size;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_size.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_size.h
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
Pgraphene_size_t  = ^graphene_size_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ graphene-size.h: Size
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
 * GRAPHENE_SIZE_INIT:
 * @_w: the width
 * @_h: the height
 *
 * Initializes a #graphene_size_t with the given sizes when
 * declaring it, e.g.:
 *
 * |[<!-- language="C" -->
 *   graphene_size_t size = GRAPHENE_SIZE_INIT (100.f, 100.f);
 * ]|
 *
 * Since: 1.0
 *xxxxxxxxxxxxxxxxxxxxxxxx/
//#define GRAPHENE_SIZE_INIT(_w,_h)       (graphene_size_t)  .width = (_w), .height = (_h) 

/**
 * GRAPHENE_SIZE_INIT_ZERO:
 *
 * Initializes a #graphene_size_t to (0, 0) when declaring it.
 *
 * Since: 1.0
  }

{ was #define dname def_expr }
function GRAPHENE_SIZE_INIT_ZERO : longint; { return type might be wrong }

{*
 * graphene_size_t:
 * @width: the width
 * @height: the height
 *
 * A size.
 *
 * Since: 1.0
  }
type
  Pgraphene_size_t = ^Tgraphene_size_t;
  Tgraphene_size_t = record
      width : single;
      height : single;
    end;


function graphene_size_alloc:Pgraphene_size_t;cdecl;external;
procedure graphene_size_free(s:Pgraphene_size_t);cdecl;external;
function graphene_size_init(s:Pgraphene_size_t; width:single; height:single):Pgraphene_size_t;cdecl;external;
(* Const before type ignored *)
function graphene_size_init_from_size(s:Pgraphene_size_t; src:Pgraphene_size_t):Pgraphene_size_t;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function graphene_size_equal(a:Pgraphene_size_t; b:Pgraphene_size_t):Tbool;cdecl;external;
(* Const before type ignored *)
procedure graphene_size_scale(s:Pgraphene_size_t; factor:single; res:Pgraphene_size_t);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure graphene_size_interpolate(a:Pgraphene_size_t; b:Pgraphene_size_t; factor:Tdouble; res:Pgraphene_size_t);cdecl;external;
(* Const before type ignored *)
function graphene_size_zero:Pgraphene_size_t;cdecl;external;

implementation

{ was #define dname def_expr }
function GRAPHENE_SIZE_INIT_ZERO : longint; { return type might be wrong }
  begin
    GRAPHENE_SIZE_INIT_ZERO:=GRAPHENE_SIZE_INIT(0.f,0.f);
  end;


end.
