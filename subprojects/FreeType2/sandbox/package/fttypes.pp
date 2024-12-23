unit fttypes;

interface

uses
 ctypes, integer_types;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


//{$ifndef FTTYPES_H_}
//{$define FTTYPES_H_}
//{$include <ft2build.h>}
//{$include FT_CONFIG_CONFIG_H}
//{$include <freetype/ftsystem.h>}
//{$include <freetype/ftimage.h>}
//{$include <stddef.h>}
{*************************************************************************
   *
   * @section:
   *   basic_types
   *
   * @title:
   *   Basic Data Types
   *
   * @abstract:
   *   The basic data types defined by the library.
   *
   * @description:
   *   This section contains the basic data types defined by FreeType~2,
   *   ranging from simple scalar types to bitmap descriptors.  More
   *   font-specific structures are defined in a different section.  Note
   *   that FreeType does not use floating-point data types.  Fractional
   *   values are represented by fixed-point integers, with lower bits
   *   storing the fractional part.
   *
   * @order:
   *   FT_Byte
   *   FT_Bytes
   *   FT_Char
   *   FT_Int
   *   FT_UInt
   *   FT_Int16
   *   FT_UInt16
   *   FT_Int32
   *   FT_UInt32
   *   FT_Int64
   *   FT_UInt64
   *   FT_Short
   *   FT_UShort
   *   FT_Long
   *   FT_ULong
   *   FT_Bool
   *   FT_Offset
   *   FT_PtrDist
   *   FT_String
   *   FT_Tag
   *   FT_Error
   *   FT_Fixed
   *   FT_Pointer
   *   FT_Pos
   *   FT_Vector
   *   FT_BBox
   *   FT_Matrix
   *   FT_FWord
   *   FT_UFWord
   *   FT_F2Dot14
   *   FT_UnitVector
   *   FT_F26Dot6
   *   FT_Data
   *
   *   FT_MAKE_TAG
   *
   *   FT_Generic
   *   FT_Generic_Finalizer
   *
   *   FT_Bitmap
   *   FT_Pixel_Mode
   *   FT_Palette_Mode
   *   FT_Glyph_Format
   *   FT_IMAGE_TAG
   *
    }
{*************************************************************************
   *
   * @type:
   *   FT_Bool
   *
   * @description:
   *   A typedef of unsigned char, used for simple booleans.  As usual,
   *   values 1 and~0 represent true and false, respectively.
    }
type
  PFT_Bool = ^TFT_Bool;
  TFT_Bool = Boolean8;
{*************************************************************************
   *
   * @type:
   *   FT_FWord
   *
   * @description:
   *   A signed 16-bit integer used to store a distance in original font
   *   units.
    }

  PFT_FWord = ^TFT_FWord;
  TFT_FWord = csshort;
{ distance in FUnits  }
{*************************************************************************
   *
   * @type:
   *   FT_UFWord
   *
   * @description:
   *   An unsigned 16-bit integer used to store a distance in original font
   *   units.
    }

  PFT_UFWord = ^TFT_UFWord;
  TFT_UFWord = cushort;
{ unsigned distance  }
{*************************************************************************
   *
   * @type:
   *   FT_Char
   *
   * @description:
   *   A simple typedef for the _signed_ char type.
    }

  PFT_Char = ^TFT_Char;
  TFT_Char = cschar;
{*************************************************************************
   *
   * @type:
   *   FT_Byte
   *
   * @description:
   *   A simple typedef for the _unsigned_ char type.
    }

  PPFT_Byte = ^PFT_Byte;
  PFT_Byte = ^TFT_Byte;
  TFT_Byte = cuchar;
{*************************************************************************
   *
   * @type:
   *   FT_Bytes
   *
   * @description:
   *   A typedef for constant memory areas.
    }
(* Const before type ignored *)

  PFT_Bytes = ^TFT_Bytes;
  TFT_Bytes = PFT_Byte;
{*************************************************************************
   *
   * @type:
   *   FT_Tag
   *
   * @description:
   *   A typedef for 32-bit tags (as used in the SFNT format).
    }

  PFT_Tag = ^TFT_Tag;
  TFT_Tag = TFT_UInt32;
{*************************************************************************
   *
   * @type:
   *   FT_String
   *
   * @description:
   *   A simple typedef for the char type, usually used for strings.
    }

  PFT_String = ^TFT_String;
  TFT_String = char;
{*************************************************************************
   *
   * @type:
   *   FT_Short
   *
   * @description:
   *   A typedef for signed short.
    }

  PFT_Short = ^TFT_Short;
  TFT_Short = csshort;
{*************************************************************************
   *
   * @type:
   *   FT_UShort
   *
   * @description:
   *   A typedef for unsigned short.
    }

  PFT_UShort = ^TFT_UShort;
  TFT_UShort = cushort;
{*************************************************************************
   *
   * @type:
   *   FT_Int
   *
   * @description:
   *   A typedef for the int type.
    }

  PFT_Int = ^TFT_Int;
  TFT_Int = csint;
{*************************************************************************
   *
   * @type:
   *   FT_UInt
   *
   * @description:
   *   A typedef for the unsigned int type.
    }

  PFT_UInt = ^TFT_UInt;
  TFT_UInt = cuint;
{*************************************************************************
   *
   * @type:
   *   FT_Long
   *
   * @description:
   *   A typedef for signed long.
    }

  PFT_Long = ^TFT_Long;
  TFT_Long = cslong;
{*************************************************************************
   *
   * @type:
   *   FT_ULong
   *
   * @description:
   *   A typedef for unsigned long.
    }

  PFT_ULong = ^TFT_ULong;
  TFT_ULong = culong;
{*************************************************************************
   *
   * @type:
   *   FT_F2Dot14
   *
   * @description:
   *   A signed 2.14 fixed-point type used for unit vectors.
    }

  PFT_F2Dot14 = ^TFT_F2Dot14;
  TFT_F2Dot14 = csshort;
{*************************************************************************
   *
   * @type:
   *   FT_F26Dot6
   *
   * @description:
   *   A signed 26.6 fixed-point type used for vectorial pixel coordinates.
    }

  PFT_F26Dot6 = ^TFT_F26Dot6;
  TFT_F26Dot6 = cslong;
{*************************************************************************
   *
   * @type:
   *   FT_Fixed
   *
   * @description:
   *   This type is used to store 16.16 fixed-point values, like scaling
   *   values or matrix coefficients.
    }

  PFT_Fixed = ^TFT_Fixed;
  TFT_Fixed = cslong;
{*************************************************************************
   *
   * @type:
   *   FT_Error
   *
   * @description:
   *   The FreeType error code type.  A value of~0 is always interpreted as a
   *   successful operation.
    }

  PFT_Error = ^TFT_Error;
  TFT_Error = cint;
{*************************************************************************
   *
   * @type:
   *   FT_Pointer
   *
   * @description:
   *   A simple typedef for a typeless pointer.
    }

  PFT_Pointer = ^TFT_Pointer;
  TFT_Pointer = Pointer;
{*************************************************************************
   *
   * @type:
   *   FT_Offset
   *
   * @description:
   *   This is equivalent to the ANSI~C `size_t` type, i.e., the largest
   *   _unsigned_ integer type used to express a file size or position, or a
   *   memory block size.
    }

  PFT_Offset = ^TFT_Offset;
  TFT_Offset = csize_t;
{*************************************************************************
   *
   * @type:
   *   FT_PtrDist
   *
   * @description:
   *   This is equivalent to the ANSI~C `ptrdiff_t` type, i.e., the largest
   *   _signed_ integer type used to express the distance between two
   *   pointers.
    }

  PFT_PtrDist = ^TFT_PtrDist;
  TFT_PtrDist = SizeUInt;
{*************************************************************************
   *
   * @struct:
   *   FT_UnitVector
   *
   * @description:
   *   A simple structure used to store a 2D vector unit vector.  Uses
   *   FT_F2Dot14 types.
   *
   * @fields:
   *   x ::
   *     Horizontal coordinate.
   *
   *   y ::
   *     Vertical coordinate.
    }

  PFT_UnitVector_ = ^TFT_UnitVector_;
  TFT_UnitVector_ = record
      x : TFT_F2Dot14;
      y : TFT_F2Dot14;
    end;
  TFT_UnitVector = TFT_UnitVector_;
  PFT_UnitVector = ^TFT_UnitVector;
{*************************************************************************
   *
   * @struct:
   *   FT_Matrix
   *
   * @description:
   *   A simple structure used to store a 2x2 matrix.  Coefficients are in
   *   16.16 fixed-point format.  The computation performed is:
   *
   *   ```
   *     x' = x*xx + y*xy
   *     y' = x*yx + y*yy
   *   ```
   *
   * @fields:
   *   xx ::
   *     Matrix coefficient.
   *
   *   xy ::
   *     Matrix coefficient.
   *
   *   yx ::
   *     Matrix coefficient.
   *
   *   yy ::
   *     Matrix coefficient.
    }

  PFT_Matrix_ = ^TFT_Matrix_;
  TFT_Matrix_ = record
      xx : TFT_Fixed;
      xy : TFT_Fixed;
      yx : TFT_Fixed;
      yy : TFT_Fixed;
    end;
  TFT_Matrix = TFT_Matrix_;
  PFT_Matrix = ^TFT_Matrix;
{*************************************************************************
   *
   * @struct:
   *   FT_Data
   *
   * @description:
   *   Read-only binary data represented as a pointer and a length.
   *
   * @fields:
   *   pointer ::
   *     The data.
   *
   *   length ::
   *     The length of the data in bytes.
    }
(* Const before type ignored *)

  PFT_Data_ = ^TFT_Data_;
  TFT_Data_ = record
      pointer : PFT_Byte;
      length : TFT_UInt;
    end;
  TFT_Data = TFT_Data_;
  PFT_Data = ^TFT_Data;
{*************************************************************************
   *
   * @functype:
   *   FT_Generic_Finalizer
   *
   * @description:
   *   Describe a function used to destroy the 'client' data of any FreeType
   *   object.  See the description of the @FT_Generic type for details of
   *   usage.
   *
   * @input:
   *   The address of the FreeType object that is under finalization.  Its
   *   client data is accessed through its `generic` field.
    }

  TFT_Generic_Finalizer = procedure (object_:pointer);cdecl;
{*************************************************************************
   *
   * @struct:
   *   FT_Generic
   *
   * @description:
   *   Client applications often need to associate their own data to a
   *   variety of FreeType core objects.  For example, a text layout API
   *   might want to associate a glyph cache to a given size object.
   *
   *   Some FreeType object contains a `generic` field, of type `FT_Generic`,
   *   which usage is left to client applications and font servers.
   *
   *   It can be used to store a pointer to client-specific data, as well as
   *   the address of a 'finalizer' function, which will be called by
   *   FreeType when the object is destroyed (for example, the previous
   *   client example would put the address of the glyph cache destructor in
   *   the `finalizer` field).
   *
   * @fields:
   *   data ::
   *     A typeless pointer to any client-specified data. This field is
   *     completely ignored by the FreeType library.
   *
   *   finalizer ::
   *     A pointer to a 'generic finalizer' function, which will be called
   *     when the object is destroyed.  If this field is set to `NULL`, no
   *     code will be called.
    }

  PFT_Generic_ = ^TFT_Generic_;
  TFT_Generic_ = record
      data : pointer;
      finalizer : TFT_Generic_Finalizer;
    end;
  TFT_Generic = TFT_Generic_;
  PFT_Generic = ^TFT_Generic;
{*************************************************************************
   *
   * @macro:
   *   FT_MAKE_TAG
   *
   * @description:
   *   This macro converts four-letter tags that are used to label TrueType
   *   tables into an `FT_Tag` type, to be used within FreeType.
   *
   * @note:
   *   The produced values **must** be 32-bit integers.  Don't redefine this
   *   macro.
    }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function FT_MAKE_TAG(_x1,_x2,_x3,_x4 : Byte) : longint;

{*********************************************************************** }
{*********************************************************************** }
{                                                                        }
{                    L I S T   M A N A G E M E N T                       }
{                                                                        }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @section:
   *   list_processing
   *
    }
{*************************************************************************
   *
   * @type:
   *   FT_ListNode
   *
   * @description:
   *    Many elements and objects in FreeType are listed through an @FT_List
   *    record (see @FT_ListRec).  As its name suggests, an FT_ListNode is a
   *    handle to a single list element.
    }
type
  PFT_ListNodeRec = ^TFT_ListNodeRec;
  TFT_ListNodeRec = record
      prev : ^TFT_ListNode;
      next : ^TFT_ListNode;
      data : pointer;
    end;

  PFT_ListNode=^TFT_ListNode;
  TFT_ListNode=^TFT_ListNodeRec;


  PFT_ListRec = ^TFT_ListRec;
  TFT_ListRec = record
      head : TFT_ListNode;
      tail : TFT_ListNode;
    end;

  PFT_List=^TFT_List;
  TFT_List=^TFT_ListRec;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function FT_IS_EMPTY(list : TFT_List) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_BOOL(x : longint) : longint;

{ concatenate C tokens  }
(* error 
#define FT_ERR_XCAT( x, y )  x ## y
in define line 596 *)
    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_CAT(x,y : longint) : longint;    

    { see `ftmoderr.h` for descriptions of the following macros  }
    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR(e : longint) : longint;    

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    function FT_ERROR_BASE(x : longint) : LongInt;    

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    function FT_ERROR_MODULE(x : longint) : LongInt;    

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_EQ(x,e : longint) : longint;    

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_NEQ(x,e : longint) : longint;    


implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MAKE_TAG(_x1,_x2,_x3,_x4 : Byte) : longint;
begin
  FT_MAKE_TAG:=(_x1 shl 24 )or (_x2 shl 16) or (_x3 shl 8) or (_x4);
//  FT_MAKE_TAG:=((((FT_STATIC_BYTE_CAST(FT_Tag,_x1)) shl 24) or ((FT_STATIC_BYTE_CAST(FT_Tag,_x2)) shl 16)) or ((FT_STATIC_BYTE_CAST(FT_Tag,_x3)) shl 8)) or (FT_STATIC_BYTE_CAST(FT_Tag,_x4));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_IS_EMPTY(list : TFT_List) : longint;
begin
//  FT_IS_EMPTY:=(list.head)=nil;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_BOOL(x : longint) : longint;
begin
//  FT_BOOL:=FT_STATIC_CAST(FT_Bool,x<>0);
end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_CAT(x,y : longint) : longint;
    begin
//      FT_ERR_CAT:=FT_ERR_XCAT(x,y);
    end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR(e : longint) : longint;
    begin
//      FT_ERR:=FT_ERR_CAT(FT_ERR_PREFIX,e);
    end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    function FT_ERROR_BASE(x : longint) : LongInt;
    begin
//      FT_ERROR_BASE:=Tx(@($FF));
    end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    function FT_ERROR_MODULE(x : longint) : LongInt;
    begin
//      FT_ERROR_MODULE:=Tx(@($FF00));
    end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_EQ(x,e : longint) : longint;
    begin
  //    FT_ERR_EQ:=(FT_ERROR_BASE(x))=(FT_ERROR_BASE(FT_ERR(e)));
    end;

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function FT_ERR_NEQ(x,e : longint) : longint;
    begin
//      FT_ERR_NEQ:=(FT_ERROR_BASE(x))<>(FT_ERROR_BASE(FT_ERR(e)));
    end;


end.
