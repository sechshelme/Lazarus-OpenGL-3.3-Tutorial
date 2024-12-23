
unit graphene_types;
interface

{
  Automatically converted by H2Pas 1.0.0 from graphene_types.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    graphene_types.h
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


{ graphene-types.h: Shared types
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
{$include "graphene-config.h"}
{$include "graphene-macros.h"}
{$include "graphene-version-macros.h"}
{*
 * GRAPHENE_VEC2_LEN:
 *
 * Evaluates to the number of components of a #graphene_vec2_t.
 *
 * This symbol is useful when declaring a C array of floating
 * point values to be used with graphene_vec2_init_from_float() and
 * graphene_vec2_to_float(), e.g.
 *
 * |[
 *   float v[GRAPHENE_VEC2_LEN];
 *
 *   // vec is defined elsewhere
 *   graphene_vec2_to_float (&vec, v);
 *
 *   for (int i = 0; i < GRAPHENE_VEC2_LEN; i++)
 *     fprintf (stdout, "component %d: %g\n", i, v[i]);
 * ]|
 *
 * Since: 1.0
  }

const
  GRAPHENE_VEC2_LEN = 2;  
{*
 * GRAPHENE_VEC3_LEN:
 *
 * Evaluates to the number of components of a #graphene_vec3_t.
 *
 * This symbol is useful when declaring a C array of floating
 * point values to be used with graphene_vec3_init_from_float() and
 * graphene_vec3_to_float(), e.g.
 *
 * |[
 *   float v[GRAPHENE_VEC3_LEN];
 *
 *   // vec is defined elsewhere
 *   graphene_vec3_to_float (&vec, v);
 *
 *   for (int i = 0; i < GRAPHENE_VEC2_LEN; i++)
 *     fprintf (stdout, "component %d: %g\n", i, v[i]);
 * ]|
 *
 * Since: 1.0
  }
  GRAPHENE_VEC3_LEN = 3;  
{*
 * GRAPHENE_VEC4_LEN:
 *
 * Evaluates to the number of components of a #graphene_vec4_t.
 *
 * This symbol is useful when declaring a C array of floating
 * point values to be used with graphene_vec4_init_from_float() and
 * graphene_vec4_to_float(), e.g.
 *
 * |[
 *   float v[GRAPHENE_VEC4_LEN];
 *
 *   // vec is defined elsewhere
 *   graphene_vec4_to_float (&vec, v);
 *
 *   for (int i = 0; i < GRAPHENE_VEC4_LEN; i++)
 *     fprintf (stdout, "component %d: %g\n", i, v[i]);
 * ]|
 *
 * Since: 1.0
  }
  GRAPHENE_VEC4_LEN = 4;  
type

implementation


end.
