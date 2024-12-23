unit fthash;

interface

uses
  fttypes, ftsystem;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{***************************************************************************
 *
 * fthash.h
 *
 *   Hashing functions (specification).
 *
  }
{
 * Copyright 2000 Computing Research Labs, New Mexico State University
 * Copyright 2001-2015
 *   Francesco Zappa Nardelli
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COMPUTING RESEARCH LAB OR NEW MEXICO STATE UNIVERSITY BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
 * OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  }
{*************************************************************************
   *
   * This file is based on code from bdf.c,v 1.22 2000/03/16 20:08:50
   *
   * taken from Mark Leisher's xmbdfed package
   *
    }
type
  PFT_Hashkey_ = ^TFT_Hashkey_;
  TFT_Hashkey_ = record
      case longint of
        0 : ( num : TFT_Int );
        1 : ( str : Pchar );
      end;
  TFT_Hashkey = TFT_Hashkey_;
  PFT_Hashkey = ^TFT_Hashkey;

  PFT_HashnodeRec_ = ^TFT_HashnodeRec_;
  TFT_HashnodeRec_ = record
      key : TFT_Hashkey;
      data : SizeInt;
    end;
  TFT_HashnodeRec = TFT_HashnodeRec_;
  PFT_HashnodeRec = ^TFT_HashnodeRec;

  PFT_Hashnode = ^TFT_Hashnode;
  TFT_Hashnode = PFT_HashnodeRec_;

  TFT_Hash_LookupFunc = function (key:PFT_Hashkey):TFT_ULong;cdecl;

  TFT_Hash_CompareFunc = function (a:PFT_Hashkey; b:PFT_Hashkey):TFT_Bool;cdecl;

  PFT_HashRec_ = ^TFT_HashRec_;
  TFT_HashRec_ = record
      limit : TFT_UInt;
      size : TFT_UInt;
      used : TFT_UInt;
      lookup : TFT_Hash_LookupFunc;
      compare : TFT_Hash_CompareFunc;
      table : PFT_Hashnode;
    end;
  TFT_HashRec = TFT_HashRec_;
  PFT_HashRec = ^TFT_HashRec;

  PFT_Hash = ^TFT_Hash;
  TFT_Hash = PFT_HashRec_;

function ft_hash_str_init(hash:TFT_Hash; memory:TFT_Memory):TFT_Error;cdecl;external;
function ft_hash_num_init(hash:TFT_Hash; memory:TFT_Memory):TFT_Error;cdecl;external;
procedure ft_hash_str_free(hash:TFT_Hash; memory:TFT_Memory);cdecl;external;

//function IMG_SetError(fmt: PChar): longint; varargs; cdecl; external sdl3_lib Name 'SDL_SetError';
procedure ft_hash_num_free(hash:TFT_Hash; memory:TFT_Memory);cdecl;external 'freetype' name 'ft_hash_str_free';
//const
//  ft_hash_num_free = ft_hash_str_free;  
(* Const before type ignored *)

function ft_hash_str_insert(key:Pchar; data:SizeInt; hash:TFT_Hash; memory:TFT_Memory):TFT_Error;cdecl;external;
function ft_hash_num_insert(num:TFT_Int; data:SizeInt; hash:TFT_Hash; memory:TFT_Memory):TFT_Error;cdecl;external;
(* Const before type ignored *)
function ft_hash_str_lookup(key:Pchar; hash:TFT_Hash):PSizeInt;cdecl;external;
function ft_hash_num_lookup(num:TFT_Int; hash:TFT_Hash):PSizeInt;cdecl;external;

implementation


end.
