unit ftobjs;

interface

uses
  integer_types,psaux,ftdrv,ftoption, ftmodapi,ftrender,ftglyph,ftgloadr, ftserv, ftlcdfil, ftincrem, ftsystem, ftmemory, fttypes, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{***************************************************************************
 *
 * ftobjs.h
 *
 *   The FreeType private base classes (specification).
 *
 * Copyright (C) 1996-2024 by
 * David Turner, Robert Wilhelm, and Werner Lemberg.
 *
 * This file is part of the FreeType project, and may only be used,
 * modified, and distributed under the terms of the FreeType project
 * license, LICENSE.TXT.  By continuing to use, modify, or distribute
 * this file you indicate that you have read the license and
 * understand and accept it fully.
 *
  }
{*************************************************************************
   *
   * This file contains the definition of all internal FreeType classes.
   *
    }
//{$ifndef FTOBJS_H_}
//{$define FTOBJS_H_}
//{$include <freetype/ftrender.h>}
//{$include <freetype/ftsizes.h>}
//{$include <freetype/ftlcdfil.h>}
//{$include <freetype/internal/ftmemory.h>}
//{$include <freetype/internal/ftgloadr.h>}
//{$include <freetype/internal/ftdrv.h>}
//{$include <freetype/internal/autohint.h>}
//{$include <freetype/internal/ftserv.h>}
//{$include <freetype/internal/ftcalc.h>}
//{$ifdef FT_CONFIG_OPTION_INCREMENTAL}
//{$include <freetype/ftincrem.h>}
//{$endif}
//{$include "compiler-macros.h"}
{*************************************************************************
   *
   * Some generic definitions.
    }
{$ifndef TRUE}

const
  TRUE = 1;  
{$endif}
{$ifndef FALSE}

const
  FALSE = 0;  
{$endif}
{$ifndef NULL}

{ was #define dname def_expr }
function NULL : pointer;  

{$endif}
{*************************************************************************
   *
   * The min and max functions missing in C.  As usual, be careful not to
   * write things like FT_MIN( a++, b++ ) to avoid side effects.
    }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function FT_MIN(a,b : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MAX(a,b : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ABS(a : longint) : longint;

{
   * Approximate sqrt(x*x+y*y) using the `alpha max plus beta min' algorithm.
   * We use alpha = 1, beta = 3/8, giving us results with a largest error
   * less than 7% compared to the exact value.
    }
{#define FT_HYPOT( x, y )                 \ }
{          ( x = FT_ABS( x ),             \ }
{            y = FT_ABS( y ),             \ }
{            x > y ? x + ( 3 * y >> 3 )   \ }
{                  : y + ( 3 * x >> 3 ) ) }
{ we use FT_TYPEOF to suppress signedness compilation warnings  }
{#define FT_PAD_FLOOR( x, n )  ( (x) & ~FT_TYPEOF( x )( (n) - 1 ) ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND(x,n : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL(x,n : longint) : longint;

{#define FT_PIX_FLOOR( x )     ( (x) & ~FT_TYPEOF( x )63 ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL(x : longint) : longint;

{ specialized versions (for signed values)                    }
{ that don't produce run-time errors due to integer overflow  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND_LONG(x,n : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL_LONG(x,n : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND_LONG(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL_LONG(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND_INT32(x,n : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL_INT32(x,n : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND_INT32(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL_INT32(x : longint) : longint;

{
   * character classification functions -- since these are used to parse font
   * files, we must not use those in <ctypes.h> which are locale-dependent
    }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isdigit(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isxdigit(x : longint) : longint;

{ the next two macros assume ASCII representation  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isupper(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_islower(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isalpha(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isalnum(x : longint) : longint;

{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                       C H A R M A P S                           *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{ handle to internal charmap object  }
type
  TPFT_CMapRec_=Pointer;
  PFT_CMap = ^TFT_CMap;
  TFT_CMap = ^TPFT_CMapRec_;
{ handle to charmap class structure  }
(* Const before type ignored *)

{ internal charmap object structure  }

  PFT_CMapRec_ = ^TFT_CMapRec_;
  TFT_CMapRec_ = record
      charmap : Pointer;
      //      charmap : TFT_CharMapRec;
      //      clazz : TFT_CMap_Class;
      clazz : Pointer;
    end;
  TFT_CMapRec = TFT_CMapRec_;
  PFT_CMapRec = ^TFT_CMapRec;
{ typecast any pointer to a charmap handle  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }

function FT_CMAP(x : longint) : TFT_CMap;

{ obvious macros  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_PLATFORM_ID(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_ENCODING_ID(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_ENCODING(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_FACE(x : longint) : longint;

{ class method definitions  }
type

  TFT_CMap_InitFunc = function (cmap:TFT_CMap; init_data:TFT_Pointer):TFT_Error;cdecl;

  TFT_CMap_DoneFunc = procedure (cmap:TFT_CMap);cdecl;

  TFT_CMap_CharIndexFunc = function (cmap:TFT_CMap; char_code:TFT_UInt32):TFT_UInt;cdecl;

  TFT_CMap_CharNextFunc = function (cmap:TFT_CMap; achar_code:PFT_UInt32):TFT_UInt;cdecl;

  TFT_CMap_CharVarIndexFunc = function (cmap:TFT_CMap; unicode_cmap:TFT_CMap; char_code:TFT_UInt32; variant_selector:TFT_UInt32):TFT_UInt;cdecl;

  TFT_CMap_CharVarIsDefaultFunc = function (cmap:TFT_CMap; char_code:TFT_UInt32; variant_selector:TFT_UInt32):TFT_Int;cdecl;

  PFT_CMap_VariantListFunc = ^TFT_CMap_VariantListFunc;
  TFT_CMap_VariantListFunc = function (cmap:TFT_CMap; mem:TFT_Memory):PFT_UInt32;cdecl;

  PFT_CMap_CharVariantListFunc = ^TFT_CMap_CharVariantListFunc;
  TFT_CMap_CharVariantListFunc = function (cmap:TFT_CMap; mem:TFT_Memory; char_code:TFT_UInt32):PFT_UInt32;cdecl;

  PFT_CMap_VariantCharListFunc = ^TFT_CMap_VariantCharListFunc;
  TFT_CMap_VariantCharListFunc = function (cmap:TFT_CMap; mem:TFT_Memory; variant_selector:TFT_UInt32):PFT_UInt32;cdecl;

PFT_CMap_Class = ^TFT_CMap_Class;
  TFT_CMap_Class = ^TFT_CMap_ClassRec_;


  PFT_CMap_ClassRec_ = ^TFT_CMap_ClassRec_;
  TFT_CMap_ClassRec_ = record
      size : TFT_ULong;
      init : TFT_CMap_InitFunc;
      done : TFT_CMap_DoneFunc;
      char_index : TFT_CMap_CharIndexFunc;
      char_next : TFT_CMap_CharNextFunc;
      char_var_index : TFT_CMap_CharVarIndexFunc;
      char_var_default : TFT_CMap_CharVarIsDefaultFunc;
      variant_list : TFT_CMap_VariantListFunc;
      charvariant_list : TFT_CMap_CharVariantListFunc;
      variantchar_list : TFT_CMap_VariantCharListFunc;
    end;
  TFT_CMap_ClassRec = TFT_CMap_ClassRec_;
  PFT_CMap_ClassRec = ^TFT_CMap_ClassRec;
{#define FT_DECLARE_CMAP_CLASS( class_ )            \ }
{  FT_CALLBACK_TABLE const FT_CMap_ClassRec  class_; }
{
#define FT_DEFINE_CMAP_CLASS(       \
          class_,                   \
          size_,                    \
          init_,                    \
          done_,                    \
          char_index_,              \
          char_next_,               \
          char_var_index_,          \
          char_var_default_,        \
          variant_list_,            \
          charvariant_list_,        \
          variantchar_list_ )       \
  FT_CALLBACK_TABLE_DEF             \
  const FT_CMap_ClassRec  class_ =  \
                                   \
    size_,                          \
    init_,                          \
    done_,                          \
    char_index_,                    \
    char_next_,                     \
    char_var_index_,                \
    char_var_default_,              \
    variant_list_,                  \
    charvariant_list_,              \
    variantchar_list_               \
  ;
 }
{ create a new charmap and add it to charmap->face  }

//function FT_CMap_New(clazz:TFT_CMap_Class; init_data:TFT_Pointer; charmap:TFT_CharMap; acmap:PFT_CMap):TFT_Error;cdecl;external;
function FT_CMap_New(clazz:Pointer; init_data:TFT_Pointer; charmap:Pointer; acmap:PFT_CMap):TFT_Error;cdecl;external;
{ destroy a charmap and remove it from face's list  }
procedure FT_CMap_Done(cmap:TFT_CMap);cdecl;external;
{ add LCD padding to CBox  }
procedure ft_lcd_padding(cbox:PFT_BBox; slot:Pointer; mode:LongInt);cdecl;external;
//procedure ft_lcd_padding(cbox:PFT_BBox; slot:TFT_GlyphSlot; mode:TFT_Render_Mode);cdecl;external;
type

  TFT_Bitmap_LcdFilterFunc = procedure (bitmap:PFT_Bitmap; weights:PFT_Byte);cdecl;
{ This is the default LCD filter, an in-place, 5-tap FIR filter.  }

procedure ft_lcd_filter_fir(bitmap:PFT_Bitmap; weights:TFT_LcdFiveTapFilter);cdecl;external;
{ FT_CONFIG_OPTION_SUBPIXEL_RENDERING  }
{*************************************************************************
   *
   * @struct:
   *   FT_Face_InternalRec
   *
   * @description:
   *   This structure contains the internal fields of each FT_Face object.
   *   These fields may change between different releases of FreeType.
   *
   * @fields:
   *   max_points ::
   *     The maximum number of points used to store the vectorial outline of
   *     any glyph in this face.  If this value cannot be known in advance,
   *     or if the face isn't scalable, this should be set to 0.  Only
   *     relevant for scalable formats.
   *
   *   max_contours ::
   *     The maximum number of contours used to store the vectorial outline
   *     of any glyph in this face.  If this value cannot be known in
   *     advance, or if the face isn't scalable, this should be set to 0.
   *     Only relevant for scalable formats.
   *
   *   transform_matrix ::
   *     A 2x2 matrix of 16.16 coefficients used to transform glyph outlines
   *     after they are loaded from the font.  Only used by the convenience
   *     functions.
   *
   *   transform_delta ::
   *     A translation vector used to transform glyph outlines after they are
   *     loaded from the font.  Only used by the convenience functions.
   *
   *   transform_flags ::
   *     Some flags used to classify the transform.  Only used by the
   *     convenience functions.
   *
   *   services ::
   *     A cache for frequently used services.  It should be only accessed
   *     with the macro `FT_FACE_LOOKUP_SERVICE`.
   *
   *   incremental_interface ::
   *     If non-null, the interface through which glyph data and metrics are
   *     loaded incrementally for faces that do not provide all of this data
   *     when first opened.  This field exists only if
   *     @FT_CONFIG_OPTION_INCREMENTAL is defined.
   *
   *   no_stem_darkening ::
   *     Overrides the module-level default, see @stem-darkening[cff], for
   *     example.  FALSE and TRUE toggle stem darkening on and off,
   *     respectively, value~-1 means to use the module/driver default.
   *
   *   random_seed ::
   *     If positive, override the seed value for the CFF 'random' operator.
   *     Value~0 means to use the font's value.  Value~-1 means to use the
   *     CFF driver's default.
   *
   *   lcd_weights ::
   *   lcd_filter_func ::
   *     These fields specify the LCD filtering weights and callback function
   *     for ClearType-style subpixel rendering.
   *
   *   refcount ::
   *     A counter initialized to~1 at the time an @FT_Face structure is
   *     created.  @FT_Reference_Face increments this counter, and
   *     @FT_Done_Face only destroys a face if the counter is~1, otherwise it
   *     simply decrements it.
    }
{$ifdef FT_CONFIG_OPTION_INCREMENTAL}
{$endif}
{$ifdef FT_CONFIG_OPTION_SUBPIXEL_RENDERING}
{ filter weights, if any  }
{ filtering callback      }
{$endif}
type
  PFT_Face_InternalRec_ = ^TFT_Face_InternalRec_;
  TFT_Face_InternalRec_ = record
      transform_matrix : TFT_Matrix;
      transform_delta : TFT_Vector;
      transform_flags : TFT_Int;
      services : TFT_ServiceCacheRec;
      incremental_interface : PFT_Incremental_InterfaceRec;
      no_stem_darkening : TFT_Char;
      random_seed : TFT_Int32;
      lcd_weights : TFT_LcdFiveTapFilter;
      lcd_filter_func : TFT_Bitmap_LcdFilterFunc;
      refcount : TFT_Int;
    end;
  TFT_Face_InternalRec = TFT_Face_InternalRec_;
  PFT_Face_InternalRec = ^TFT_Face_InternalRec;
{*************************************************************************
   *
   * @struct:
   *   FT_Slot_InternalRec
   *
   * @description:
   *   This structure contains the internal fields of each FT_GlyphSlot
   *   object.  These fields may change between different releases of
   *   FreeType.
   *
   * @fields:
   *   loader ::
   *     The glyph loader object used to load outlines into the glyph slot.
   *
   *   flags ::
   *     Possible values are zero or FT_GLYPH_OWN_BITMAP.  The latter
   *     indicates that the FT_GlyphSlot structure owns the bitmap buffer.
   *
   *   glyph_transformed ::
   *     Boolean.  Set to TRUE when the loaded glyph must be transformed
   *     through a specific font transformation.  This is _not_ the same as
   *     the face transform set through FT_Set_Transform().
   *
   *   glyph_matrix ::
   *     The 2x2 matrix corresponding to the glyph transformation, if
   *     necessary.
   *
   *   glyph_delta ::
   *     The 2d translation vector corresponding to the glyph transformation,
   *     if necessary.
   *
   *   glyph_hints ::
   *     Format-specific glyph hints management.
   *
   *   load_flags ::
   *     The load flags passed as an argument to @FT_Load_Glyph while
   *     initializing the glyph slot.
    }

const
  FT_GLYPH_OWN_BITMAP = $1;  
  FT_GLYPH_OWN_GZIP_SVG = $2;  
type
  PFT_Slot_InternalRec = ^TFT_Slot_InternalRec;
  TFT_Slot_InternalRec = record
//      loader : TFT_GlyphLoader;
      loader : Pointer;
      flags : TFT_UInt;
      glyph_transformed : TFT_Bool;
      glyph_matrix : TFT_Matrix;
      glyph_delta : TFT_Vector;
      glyph_hints : pointer;
      load_flags : TFT_Int32;
    end;
  TFT_GlyphSlot_InternalRec = TFT_Slot_InternalRec;
  PFT_GlyphSlot_InternalRec = ^TFT_GlyphSlot_InternalRec;
{*************************************************************************
   *
   * @struct:
   *   FT_Size_InternalRec
   *
   * @description:
   *   This structure contains the internal fields of each FT_Size object.
   *
   * @fields:
   *   module_data ::
   *     Data specific to a driver module.
   *
   *   autohint_mode ::
   *     The used auto-hinting mode.
   *
   *   autohint_metrics ::
   *     Metrics used by the auto-hinter.
   *
    }

  PFT_Size_InternalRec_ = ^TFT_Size_InternalRec_;
  TFT_Size_InternalRec_ = record
      module_data : pointer;
      //      autohint_mode : TFT_Render_Mode;
      //      autohint_metrics : TFT_Size_Metrics;
      autohint_mode : LongInt;
      autohint_metrics : Pointer;
    end;
  TFT_Size_InternalRec = TFT_Size_InternalRec_;
  PFT_Size_InternalRec = ^TFT_Size_InternalRec;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                         M O D U L E S                           *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @struct:
   *   FT_ModuleRec
   *
   * @description:
   *   A module object instance.
   *
   * @fields:
   *   clazz ::
   *     A pointer to the module's class.
   *
   *   library ::
   *     A handle to the parent library object.
   *
   *   memory ::
   *     A handle to the memory manager.
    }

  PFT_ModuleRec_ = ^TFT_ModuleRec_;
  TFT_ModuleRec_ = record
      clazz : PFT_Module_Class;
//      library_ : TFT_Library;
      library_ : Pointer;
      memory : TFT_Memory;
    end;
  TFT_ModuleRec = TFT_ModuleRec_;
  PFT_ModuleRec = ^TFT_ModuleRec;
{ typecast an object to an FT_Module  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }

//function FT_MODULE(x : longint) : TFT_Module;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_CLASS(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_LIBRARY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_MEMORY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_DRIVER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_RENDERER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_HINTER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_STYLER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_IS_SCALABLE(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_USES_OUTLINES(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_HAS_HINTER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_HINTS_LIGHTLY(x : longint) : longint;

{*************************************************************************
   *
   * @function:
   *   FT_Get_Module_Interface
   *
   * @description:
   *   Finds a module and returns its specific interface as a typeless
   *   pointer.
   *
   * @input:
   *   library ::
   *     A handle to the library object.
   *
   *   module_name ::
   *     The module's name (as an ASCII string).
   *
   * @return:
   *   A module-specific interface if available, 0 otherwise.
   *
   * @note:
   *   You should better be familiar with FreeType internals to know which
   *   module to look for, and what its interface is :-)
    }
//function FT_Get_Module_Interface(library:TFT_Library; mod_name:Pchar):pointer;cdecl;external;
function FT_Get_Module_Interface(library_:Pointer; mod_name:Pchar):pointer;cdecl;external;
//function ft_module_get_service(module:TFT_Module; service_id:Pchar; global:TFT_Bool):TFT_Pointer;cdecl;external;
function ft_module_get_service(module:Pointer; service_id:Pchar; global:TFT_Bool):TFT_Pointer;cdecl;external;
{$ifdef FT_CONFIG_OPTION_ENVIRONMENT_PROPERTIES}
(* Const before type ignored *)
(* Const before type ignored *)
function ft_property_string_set(library:TFT_Library; module_name:PFT_String; property_name:PFT_String; value:PFT_String):TFT_Error;cdecl;external;
{$endif}
{  }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***   F A C E,   S I Z E   &   G L Y P H   S L O T   O B J E C T S  *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{ a few macros used to perform easy typecasts with minimal brain damage  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }

//function FT_FACE(x : longint) : TFT_Face;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function FT_SIZE(x : longint) : TFT_Size;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function FT_SLOT(x : longint) : TFT_GlyphSlot;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_DRIVER(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_LIBRARY(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_MEMORY(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_STREAM(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_SIZE_FACE(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_SLOT_FACE(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_SLOT(x : longint) : longint;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function FT_FACE_SIZE(x : longint) : longint;

{*************************************************************************
   *
   * @function:
   *   FT_New_GlyphSlot
   *
   * @description:
   *   It is sometimes useful to have more than one glyph slot for a given
   *   face object.  This function is used to create additional slots.  All
   *   of them are automatically discarded when the face is destroyed.
   *
   * @input:
   *   face ::
   *     A handle to a parent face object.
   *
   * @output:
   *   aslot ::
   *     A handle to a new glyph slot object.
   *
   * @return:
   *   FreeType error code.  0 means success.
    }
//    function FT_New_GlyphSlot(face:TFT_Face; aslot:PFT_GlyphSlot):TFT_Error;cdecl;external;
    function FT_New_GlyphSlot(face:Pointer; aslot:Pointer):TFT_Error;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Done_GlyphSlot
   *
   * @description:
   *   Destroys a given glyph slot.  Remember however that all slots are
   *   automatically destroyed with its parent.  Using this function is not
   *   always mandatory.
   *
   * @input:
   *   slot ::
   *     A handle to a target glyph slot.
    }
//procedure FT_Done_GlyphSlot(slot:TFT_GlyphSlot);cdecl;external;
procedure FT_Done_GlyphSlot(slot:Pointer);cdecl;external;
{  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REQUEST_WIDTH(req : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REQUEST_HEIGHT(req : longint) : longint;

{ Set the metrics according to a bitmap strike.  }
//procedure FT_Select_Metrics(face:TFT_Face; strike_index:TFT_ULong);cdecl;external;
procedure FT_Select_Metrics(face:Pointer; strike_index:TFT_ULong);cdecl;external;
{ Set the metrics according to a size request.  }
//function FT_Request_Metrics(face:TFT_Face; req:TFT_Size_Request):TFT_Error;cdecl;external;
function FT_Request_Metrics(face:Pointer; req:Pointer):TFT_Error;cdecl;external;
{ Match a size request against `available_sizes'.  }
//function FT_Match_Size(face:TFT_Face; req:TFT_Size_Request; ignore_width:TFT_Bool; size_index:PFT_ULong):TFT_Error;cdecl;external;
//function FT_Match_Size(face:Pointer; req:TFT_Size_Request; ignore_width:TFT_Bool; size_index:PFT_ULong):TFT_Error;cdecl;external;
function FT_Match_Size(face:Pointer; req:Pointer; ignore_width:TFT_Bool; size_index:PFT_ULong):TFT_Error;cdecl;external;
{ Use the horizontal metrics to synthesize the vertical metrics.  }
{ If `advance' is zero, it is also synthesized.                   }
//procedure ft_synthesize_vertical_metrics(metrics:PFT_Glyph_Metrics; advance:TFT_Pos);cdecl;external;
procedure ft_synthesize_vertical_metrics(metrics:Pointer; advance:TFT_Pos);cdecl;external;
{ Free the bitmap of a given glyphslot when needed (i.e., only when it  }
{ was allocated with ft_glyphslot_alloc_bitmap).                        }
//procedure ft_glyphslot_free_bitmap(slot:TFT_GlyphSlot);cdecl;external;
procedure ft_glyphslot_free_bitmap(slot:Pointer);cdecl;external;
{ Preset bitmap metrics of an outline glyphslot prior to rendering  }
{ and check whether the truncated bbox is too large for rendering.  }
(* Const before type ignored *)
//function ft_glyphslot_preset_bitmap(slot:TFT_GlyphSlot; mode:TFT_Render_Mode; origin:PFT_Vector):TFT_Bool;cdecl;external;
function ft_glyphslot_preset_bitmap(slot:Pointer; mode:Pointer; origin:PFT_Vector):TFT_Bool;cdecl;external;
{ Allocate a new bitmap buffer in a glyph slot.  }
//function ft_glyphslot_alloc_bitmap(slot:TFT_GlyphSlot; size:TFT_ULong):TFT_Error;cdecl;external;
function ft_glyphslot_alloc_bitmap(slot:Pointer; size:TFT_ULong):TFT_Error;cdecl;external;
{ Set the bitmap buffer in a glyph slot to a given pointer.  The buffer  }
{ will not be freed by a later call to ft_glyphslot_free_bitmap.         }
//procedure ft_glyphslot_set_bitmap(slot:TFT_GlyphSlot; buffer:PFT_Byte);cdecl;external;
procedure ft_glyphslot_set_bitmap(slot:Pointer; buffer:PFT_Byte);cdecl;external;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                        R E N D E R E R S                        *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
//function FT_RENDERER(x : longint) : TFT_Renderer;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function FT_GLYPH(x : longint) : TFT_Glyph;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function FT_BITMAP_GLYPH(x : longint) : TFT_BitmapGlyph;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function FT_OUTLINE_GLYPH(x : longint) : TFT_OutlineGlyph;
//
type
  PFT_RendererRec_ = ^TFT_RendererRec_;
  TFT_RendererRec_ = record
      root : TFT_ModuleRec;
      clazz : PFT_Renderer_Class;
      glyph_format : TFT_Glyph_Format;
      glyph_class : TFT_Glyph_Class;
      raster : TFT_Raster;
      raster_render : TFT_Raster_Render_Func;
      render : TFT_Renderer_RenderFunc;
    end;
  TFT_RendererRec = TFT_RendererRec_;
  PFT_RendererRec = ^TFT_RendererRec;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                    F O N T   D R I V E R S                      *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{ typecast a module into a driver easily  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }

//function FT_DRIVER(x : longint) : TFT_Driver;

{ typecast a module as a driver, and get its driver class  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_CLASS(x : longint) : longint;

{*************************************************************************
   *
   * @struct:
   *   FT_DriverRec
   *
   * @description:
   *   The root font driver class.  A font driver is responsible for managing
   *   and loading font files of a given format.
   *
   * @fields:
   *   root ::
   *     Contains the fields of the root module class.
   *
   *   clazz ::
   *     A pointer to the font driver's class.  Note that this is NOT
   *     root.clazz.  'class' wasn't used as it is a reserved word in C++.
   *
   *   faces_list ::
   *     The list of faces currently opened by this driver.
   *
   *   glyph_loader ::
   *     Unused.  Used to be glyph loader for all faces managed by this
   *     driver.
    }
type
  PFT_DriverRec_ = ^TFT_DriverRec_;
  TFT_DriverRec_ = record
      root : TFT_ModuleRec;
      clazz : TFT_Driver_Class;
      faces_list : TFT_ListRec;
      glyph_loader : TFT_GlyphLoader;
    end;
  TFT_DriverRec = TFT_DriverRec_;
  PFT_DriverRec = ^TFT_DriverRec;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                       L I B R A R I E S                         *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @struct:
   *   FT_LibraryRec
   *
   * @description:
   *   The FreeType library class.  This is the root of all FreeType data.
   *   Use FT_New_Library() to create a library object, and FT_Done_Library()
   *   to discard it and all child objects.
   *
   * @fields:
   *   memory ::
   *     The library's memory object.  Manages memory allocation.
   *
   *   version_major ::
   *     The major version number of the library.
   *
   *   version_minor ::
   *     The minor version number of the library.
   *
   *   version_patch ::
   *     The current patch level of the library.
   *
   *   num_modules ::
   *     The number of modules currently registered within this library.
   *     This is set to 0 for new libraries.  New modules are added through
   *     the FT_Add_Module() API function.
   *
   *   modules ::
   *     A table used to store handles to the currently registered
   *     modules. Note that each font driver contains a list of its opened
   *     faces.
   *
   *   renderers ::
   *     The list of renderers currently registered within the library.
   *
   *   cur_renderer ::
   *     The current outline renderer.  This is a shortcut used to avoid
   *     parsing the list on each call to FT_Outline_Render().  It is a
   *     handle to the current renderer for the FT_GLYPH_FORMAT_OUTLINE
   *     format.
   *
   *   auto_hinter ::
   *     The auto-hinter module interface.
   *
   *   debug_hooks ::
   *     An array of four function pointers that allow debuggers to hook into
   *     a font format's interpreter.  Currently, only the TrueType bytecode
   *     debugger uses this.
   *
   *   lcd_weights ::
   *     The LCD filter weights for ClearType-style subpixel rendering.
   *
   *   lcd_filter_func ::
   *     The LCD filtering callback function for for ClearType-style subpixel
   *     rendering.
   *
   *   lcd_geometry ::
   *     This array specifies LCD subpixel geometry and controls Harmony LCD
   *     rendering technique, alternative to ClearType.
   *
   *   pic_container ::
   *     Contains global structs and tables, instead of defining them
   *     globally.
   *
   *   refcount ::
   *     A counter initialized to~1 at the time an @FT_Library structure is
   *     created.  @FT_Reference_Library increments this counter, and
   *     @FT_Done_Library only destroys a library if the counter is~1,
   *     otherwise it simply decrements it.
    }
{ library's memory manager  }
{ module objects   }
{ list of renderers         }
{ current outline renderer  }
{$ifdef FT_CONFIG_OPTION_SUBPIXEL_RENDERING}
{ filter weights, if any  }
{ filtering callback      }
{$else}
{ RGB subpixel positions  }
{$endif}
type
  PFT_LibraryRec_ = ^TFT_LibraryRec_;
  TFT_LibraryRec_ = record
      memory : TFT_Memory;
      version_major : TFT_Int;
      version_minor : TFT_Int;
      version_patch : TFT_Int;
      num_modules : TFT_UInt;
//      modules : array[0..(FT_MAX_MODULES)-1] of TFT_Module;
      modules : array[0..(FT_MAX_MODULES)-1] of Pointer;
      renderers : TFT_ListRec;
//      cur_renderer : TFT_Renderer;
//      auto_hinter : TFT_Module;
      cur_renderer : Pointer;
      auto_hinter : Pointer;
      debug_hooks : array[0..3] of TFT_DebugHook_Func;
      lcd_weights : TFT_LcdFiveTapFilter;
      lcd_filter_func : TFT_Bitmap_LcdFilterFunc;
      lcd_geometry : array[0..2] of TFT_Vector;
      refcount : TFT_Int;
    end;
  TFT_LibraryRec = TFT_LibraryRec_;
  PFT_LibraryRec = ^TFT_LibraryRec;

//  function FT_Lookup_Renderer(library_:TFT_Library; format:TFT_Glyph_Format; node:PFT_ListNode):TFT_Renderer;cdecl;external;
//  function FT_Render_Glyph_Internal(library_:TFT_Library; slot:TFT_GlyphSlot; render_mode:TFT_Render_Mode):TFT_Error;cdecl;external;
  function FT_Lookup_Renderer(library_:Pointer; format:TFT_Glyph_Format; node:PFT_ListNode):Pointer;cdecl;external;
  function FT_Render_Glyph_Internal(library_:Pointer; slot:Pointer; render_mode:Pointer):TFT_Error;cdecl;external;
(* Const before type ignored *)
type
  PFT_Face_GetPostscriptNameFunc = ^TFT_Face_GetPostscriptNameFunc;
//  TFT_Face_GetPostscriptNameFunc = function (face:TFT_Face):Pchar;cdecl;
  TFT_Face_GetPostscriptNameFunc = function (face:Pointer):Pchar;cdecl;

//  TFT_Face_GetGlyphNameFunc = function (face:TFT_Face; glyph_index:TFT_UInt; buffer:TFT_Pointer; buffer_max:TFT_UInt):TFT_Error;cdecl;
//  TFT_Face_GetGlyphNameIndexFunc = function (face:TFT_Face; glyph_name:PFT_String):TFT_UInt;cdecl;
  TFT_Face_GetGlyphNameFunc = function (face:Pointer; glyph_index:TFT_UInt; buffer:TFT_Pointer; buffer_max:TFT_UInt):TFT_Error;cdecl;
  TFT_Face_GetGlyphNameIndexFunc = function (face:Pointer; glyph_name:PFT_String):TFT_UInt;cdecl;
{$ifndef FT_CONFIG_OPTION_NO_DEFAULT_SYSTEM}
{*************************************************************************
   *
   * @function:
   *   FT_New_Memory
   *
   * @description:
   *   Creates a new memory object.
   *
   * @return:
   *   A pointer to the new memory object.  0 in case of error.
    }

function FT_New_Memory:TFT_Memory;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Done_Memory
   *
   * @description:
   *   Discards memory manager.
   *
   * @input:
   *   memory ::
   *     A handle to the memory manager.
    }
procedure FT_Done_Memory(memory:TFT_Memory);cdecl;external;
{$endif}
{ !FT_CONFIG_OPTION_NO_DEFAULT_SYSTEM  }
{ Define default raster's interface.  The default raster is located in   }
{ `src/base/ftraster.c'.                                                 }
{                                                                        }
{ Client applications can register new rasters through the               }
{ FT_Set_Raster() API.                                                   }
{$ifndef FT_NO_DEFAULT_RASTER}
  var
    ft_default_raster : TFT_Raster_Funcs;cvar;public;
{$endif}
{*************************************************************************
   *
   * @macro:
   *   FT_DEFINE_OUTLINE_FUNCS
   *
   * @description:
   *   Used to initialize an instance of FT_Outline_Funcs struct.  The struct
   *   will be allocated in the global scope (or the scope where the macro is
   *   used).
    }
{
#define FT_DEFINE_OUTLINE_FUNCS(           \
          class_,                          \
          move_to_,                        \
          line_to_,                        \
          conic_to_,                       \
          cubic_to_,                       \
          shift_,                          \
          delta_ )                         \
  static const  FT_Outline_Funcs class_ =  \
                                          \
    move_to_,                              \
    line_to_,                              \
    conic_to_,                             \
    cubic_to_,                             \
    shift_,                                \
    delta_                                 \
  ;
 }
{*************************************************************************
   *
   * @macro:
   *   FT_DEFINE_RASTER_FUNCS
   *
   * @description:
   *   Used to initialize an instance of FT_Raster_Funcs struct.  The struct
   *   will be allocated in the global scope (or the scope where the macro is
   *   used).
    }
{#define FT_DEFINE_RASTER_FUNCS(    \
          class_,                  \
          glyph_format_,           \
          raster_new_,             \
          raster_reset_,           \
          raster_set_mode_,        \
          raster_render_,          \
          raster_done_ )           \
  const FT_Raster_Funcs  class_ =  \
                                  \
    glyph_format_,                 \
    raster_new_,                   \
    raster_reset_,                 \
    raster_set_mode_,              \
    raster_render_,                \
    raster_done_                   \
  ; }
{*************************************************************************
   *
   * @macro:
   *   FT_DEFINE_GLYPH
   *
   * @description:
   *   The struct will be allocated in the global scope (or the scope where
   *   the macro is used).
    }
{#define FT_DECLARE_GLYPH( class_ )                \
  FT_CALLBACK_TABLE const FT_Glyph_Class  class_;

#define FT_DEFINE_GLYPH(          \
          class_,                 \
          size_,                  \
          format_,                \
          init_,                  \
          done_,                  \
          copy_,                  \
          transform_,             \
          bbox_,                  \
          prepare_ )              \
  FT_CALLBACK_TABLE_DEF           \
  const FT_Glyph_Class  class_ =  \
                                 \
    size_,                        \
    format_,                      \
    init_,                        \
    done_,                        \
    copy_,                        \
    transform_,                   \
    bbox_,                        \
    prepare_                      \
  ; }
{*************************************************************************
   *
   * @macro:
   *   FT_DECLARE_RENDERER
   *
   * @description:
   *   Used to create a forward declaration of a FT_Renderer_Class struct
   *   instance.
   *
   * @macro:
   *   FT_DEFINE_RENDERER
   *
   * @description:
   *   Used to initialize an instance of FT_Renderer_Class struct.
   *
   *   The struct will be allocated in the global scope (or the scope where
   *   the macro is used).
    }
{#define FT_DECLARE_RENDERER( class_ )               \
  FT_EXPORT_VAR( const FT_Renderer_Class ) class_;

#define FT_DEFINE_RENDERER(                  \
          class_,                            \
          flags_,                            \
          size_,                             \
          name_,                             \
          version_,                          \
          requires_,                         \
          interface_,                        \
          init_,                             \
          done_,                             \
          get_interface_,                    \
          glyph_format_,                     \
          render_glyph_,                     \
          transform_glyph_,                  \
          get_glyph_cbox_,                   \
          set_mode_,                         \
          raster_class_ )                    \
  FT_CALLBACK_TABLE_DEF                      \
  const FT_Renderer_Class  class_ =          \
                                            \
    FT_DEFINE_ROOT_MODULE( flags_,           \
                           size_,            \
                           name_,            \
                           version_,         \
                           requires_,        \
                           interface_,       \
                           init_,            \
                           done_,            \
                           get_interface_ )  \
    glyph_format_,                           \
                                             \
    render_glyph_,                           \
    transform_glyph_,                        \
    get_glyph_cbox_,                         \
    set_mode_,                               \
                                             \
    raster_class_                            \
  ; }
{*************************************************************************
   *
   * @macro:
   *   FT_DECLARE_MODULE
   *
   * @description:
   *   Used to create a forward declaration of a FT_Module_Class struct
   *   instance.
   *
   * @macro:
   *   FT_DEFINE_MODULE
   *
   * @description:
   *   Used to initialize an instance of an FT_Module_Class struct.
   *
   *   The struct will be allocated in the global scope (or the scope where
   *   the macro is used).
   *
   * @macro:
   *   FT_DEFINE_ROOT_MODULE
   *
   * @description:
   *   Used to initialize an instance of an FT_Module_Class struct inside
   *   another struct that contains it or in a function that initializes that
   *   containing struct.
    }
{#define FT_DECLARE_MODULE( class_ )  \ }
{  FT_CALLBACK_TABLE                  \ }
{  const FT_Module_Class  class_; }
{#define FT_DEFINE_ROOT_MODULE(  \
          flags_,               \
          size_,                \
          name_,                \
          version_,             \
          requires_,            \
          interface_,           \
          init_,                \
          done_,                \
          get_interface_ )      \
                               \
    flags_,                     \
    size_,                      \
                                \
    name_,                      \
    version_,                   \
    requires_,                  \
                                \
    interface_,                 \
                                \
    init_,                      \
    done_,                      \
    get_interface_,             \
  ,

#define FT_DEFINE_MODULE(         \
          class_,                 \
          flags_,                 \
          size_,                  \
          name_,                  \
          version_,               \
          requires_,              \
          interface_,             \
          init_,                  \
          done_,                  \
          get_interface_ )        \
  FT_CALLBACK_TABLE_DEF           \
  const FT_Module_Class class_ =  \
                                 \
    flags_,                       \
    size_,                        \
                                  \
    name_,                        \
    version_,                     \
    requires_,                    \
                                  \
    interface_,                   \
                                  \
    init_,                        \
    done_,                        \
    get_interface_,               \
  ; }

implementation

{ was #define dname def_expr }
function NULL : pointer;
  begin
    NULL:=pointer(0);
  end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MIN(a,b : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  //if b then
  //  if_local1:=a
  //else
  //  if_local1:=b;
  //FT_MIN:=a<(if_local1);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MAX(a,b : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  //if b then
  //  if_local1:=a
  //else
  //  if_local1:=b;
  //FT_MAX:=a>(if_local1);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ABS(a : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  Result:=Abs(a);
  //if 0 then
  //  if_local1:=-(a)
  //else
  //  if_local1:=a;
  //FT_ABS:=a<(if_local1);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND(x,n : longint) : longint;
begin
//  FT_PAD_ROUND:=FT_PAD_FLOOR((Tx(+(n)))/2,n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL(x,n : longint) : longint;
begin
//  FT_PAD_CEIL:=FT_PAD_FLOOR(Tx(+(Tn(-(1)))),n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND(x : longint) : longint;
begin
//  FT_PIX_ROUND:=FT_PIX_FLOOR(Tx(+(32)));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL(x : longint) : longint;
begin
//  FT_PIX_CEIL:=FT_PIX_FLOOR(Tx(+(63)));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND_LONG(x,n : longint) : longint;
begin
//  FT_PAD_ROUND_LONG:=FT_PAD_FLOOR(ADD_LONG(x,n/2),n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL_LONG(x,n : longint) : longint;
begin
//  FT_PAD_CEIL_LONG:=FT_PAD_FLOOR(ADD_LONG(x,Tn(-(1))),n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND_LONG(x : longint) : longint;
begin
//  FT_PIX_ROUND_LONG:=FT_PIX_FLOOR(ADD_LONG(x,32));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL_LONG(x : longint) : longint;
begin
//  FT_PIX_CEIL_LONG:=FT_PIX_FLOOR(ADD_LONG(x,63));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_ROUND_INT32(x,n : longint) : longint;
begin
//  FT_PAD_ROUND_INT32:=FT_PAD_FLOOR(ADD_INT32(x,n/2),n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PAD_CEIL_INT32(x,n : longint) : longint;
begin
  //FT_PAD_CEIL_INT32:=FT_PAD_FLOOR(ADD_INT32(x,Tn(-(1))),n);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_ROUND_INT32(x : longint) : longint;
begin
//  FT_PIX_ROUND_INT32:=FT_PIX_FLOOR(ADD_INT32(x,32));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_PIX_CEIL_INT32(x : longint) : longint;
begin
//  FT_PIX_CEIL_INT32:=FT_PIX_FLOOR(ADD_INT32(x,63));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isdigit(x : longint) : longint;
begin
//  ft_isdigit:=(dword(Tx(-('0'))))<10;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isxdigit(x : longint) : longint;
begin
//  ft_isxdigit:=(((dword(Tx(-('0'))))<(10 or (dword(Tx(-('a'))))))<(6 or (dword(Tx(-('A'))))))<6;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isupper(x : longint) : longint;
begin
//  ft_isupper:=(dword(Tx(-('A'))))<26;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_islower(x : longint) : longint;
begin
//  ft_islower:=(dword(Tx(-('a'))))<26;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isalpha(x : longint) : longint;
begin
  ft_isalpha:=(ft_isupper(x)) or (ft_islower(x));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function ft_isalnum(x : longint) : longint;
begin
  ft_isalnum:=(ft_isdigit(x)) or (ft_isalpha(x));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_CMAP(x : longint) : TFT_CMap;
begin
  FT_CMAP:=TFT_CMap(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_PLATFORM_ID(x : longint) : longint;
begin
//  FT_CMAP_PLATFORM_ID:=(FT_CMAP(x))^.(charmap.platform_id);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_ENCODING_ID(x : longint) : longint;
begin
//  FT_CMAP_ENCODING_ID:=(FT_CMAP(x))^.(charmap.encoding_id);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_ENCODING(x : longint) : longint;
begin
//  FT_CMAP_ENCODING:=(FT_CMAP(x))^.(charmap.encoding);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CMAP_FACE(x : longint) : longint;
begin
//  FT_CMAP_FACE:=(FT_CMAP(x))^.(charmap.face);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
//nction FT_MODULE(x : longint) : TFT_Module;
function FT_MODULE(x : longint) : Pointer;
begin
//  FT_MODULE:=TFT_Module(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_CLASS(x : longint) : longint;
begin
//  FT_MODULE_CLASS:=(FT_MODULE(x))^.clazz;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_LIBRARY(x : longint) : longint;
begin
//  FT_MODULE_LIBRARY:=(FT_MODULE(x))^.library;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_MEMORY(x : longint) : longint;
begin
//  FT_MODULE_MEMORY:=(FT_MODULE(x))^.memory;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_DRIVER(x : longint) : longint;
begin
//  FT_MODULE_IS_DRIVER:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_FONT_DRIVER;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_RENDERER(x : longint) : longint;
begin
//  FT_MODULE_IS_RENDERER:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_RENDERER;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_HINTER(x : longint) : longint;
begin
//  FT_MODULE_IS_HINTER:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_HINTER;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_MODULE_IS_STYLER(x : longint) : longint;
begin
//  FT_MODULE_IS_STYLER:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_STYLER;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_IS_SCALABLE(x : longint) : longint;
begin
//  FT_DRIVER_IS_SCALABLE:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_DRIVER_SCALABLE;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_USES_OUTLINES(x : longint) : longint;
begin
//  FT_DRIVER_USES_OUTLINES:= not (((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_DRIVER_NO_OUTLINES);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_HAS_HINTER(x : longint) : longint;
begin
//  FT_DRIVER_HAS_HINTER:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_DRIVER_HAS_HINTER;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_HINTS_LIGHTLY(x : longint) : longint;
begin
//  FT_DRIVER_HINTS_LIGHTLY:=((FT_MODULE_CLASS(x))^.module_flags) and FT_MODULE_DRIVER_HINTS_LIGHTLY;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_FACE(x : longint) : Pointer;
begin
//  FT_FACE:=TFT_Face(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_SIZE(x : longint) : Pointer;
begin
//  FT_SIZE:=TFT_Size(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_SLOT(x : longint) : Pointer;
begin
//  FT_SLOT:=TFT_GlyphSlot(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_DRIVER(x : longint) : longint;
begin
//  FT_FACE_DRIVER:=(FT_FACE(x))^.driver;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_LIBRARY(x : longint) : longint;
begin
//  FT_FACE_LIBRARY:=(FT_FACE_DRIVER(x))^.(root.library);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_MEMORY(x : longint) : longint;
begin
///  FT_FACE_MEMORY:=(FT_FACE(x))^.memory;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_STREAM(x : longint) : longint;
begin
//  FT_FACE_STREAM:=(FT_FACE(x))^.stream;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_SIZE_FACE(x : longint) : longint;
begin
//  FT_SIZE_FACE:=(FT_SIZE(x))^.face;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_SLOT_FACE(x : longint) : longint;
begin
//  FT_SLOT_FACE:=(FT_SLOT(x))^.face;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_SLOT(x : longint) : longint;
begin
//  FT_FACE_SLOT:=(FT_FACE(x))^.glyph;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FACE_SIZE(x : longint) : longint;
begin
//  FT_FACE_SIZE:=(FT_FACE(x))^.size;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REQUEST_WIDTH(req : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  //if req^.horiResolution then
  //  if_local1:=(((req^.width)*(TFT_Pos(req^.horiResolution)))+36)/72
  //else
  //  if_local1:=req^.width;
  //FT_REQUEST_WIDTH:=if_local1;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REQUEST_HEIGHT(req : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  //if req^.vertResolution then
  //  if_local1:=(((req^.height)*(TFT_Pos(req^.vertResolution)))+36)/72
  //else
  //  if_local1:=req^.height;
  //FT_REQUEST_HEIGHT:=if_local1;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_RENDERER(x : longint) : Pointer;
begin
//  FT_RENDERER:=TFT_Renderer(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_GLYPH(x : longint) : TFT_Glyph;
begin
  FT_GLYPH:=TFT_Glyph(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_BITMAP_GLYPH(x : longint) : TFT_BitmapGlyph;
begin
  FT_BITMAP_GLYPH:=TFT_BitmapGlyph(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_OUTLINE_GLYPH(x : longint) : TFT_OutlineGlyph;
begin
  FT_OUTLINE_GLYPH:=TFT_OutlineGlyph(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
function FT_DRIVER(x : longint) : Pointer;
begin
//  FT_DRIVER:=TFT_Driver(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DRIVER_CLASS(x : longint) : longint;
begin
//  FT_DRIVER_CLASS:=(FT_DRIVER(x))^.clazz;
end;


end.
