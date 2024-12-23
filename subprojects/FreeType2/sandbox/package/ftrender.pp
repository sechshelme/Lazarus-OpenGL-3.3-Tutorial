unit ftrender;

interface

uses
  fttypes, ftglyph,ftmodapi, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{***************************************************************************
 *
 * ftrender.h
 *
 *   FreeType renderer modules public interface (specification).
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
//{$ifndef FTRENDER_H_}
//{$define FTRENDER_H_}
//{$include <freetype/ftmodapi.h>}
//{$include <freetype/ftglyph.h>}
{*************************************************************************
   *
   * @section:
   *   module_management
   *
    }
{ create a new glyph object  }
type

//  TFT_Glyph_InitFunc = function (glyph:TFT_Glyph; slot:TFT_GlyphSlot):TFT_Error;cdecl;
  TFT_Glyph_InitFunc = function (glyph:TFT_Glyph; slot:Pointer):TFT_Error;cdecl;
{ destroys a given glyph object  }

  TFT_Glyph_DoneFunc = procedure (glyph:TFT_Glyph);cdecl;
(* Const before type ignored *)
(* Const before type ignored *)

  TFT_Glyph_TransformFunc = procedure (glyph:TFT_Glyph; matrix:PFT_Matrix; delta:PFT_Vector);cdecl;

  TFT_Glyph_GetBBoxFunc = procedure (glyph:TFT_Glyph; abbox:PFT_BBox);cdecl;

  TFT_Glyph_CopyFunc = function (source:TFT_Glyph; target:TFT_Glyph):TFT_Error;cdecl;

//  TFT_Glyph_PrepareFunc = function (glyph:TFT_Glyph; slot:TFT_GlyphSlot):TFT_Error;cdecl;
  TFT_Glyph_PrepareFunc = function (glyph:TFT_Glyph; slot:Pointer):TFT_Error;cdecl;
{ deprecated  }

type
  PFT_Glyph_Class_ = ^TFT_Glyph_Class_;
  TFT_Glyph_Class_ = record
      glyph_size : TFT_Long;
      glyph_format : TFT_Glyph_Format;
      glyph_init : TFT_Glyph_InitFunc;
      glyph_done : TFT_Glyph_DoneFunc;
      glyph_copy : TFT_Glyph_CopyFunc;
      glyph_transform : TFT_Glyph_TransformFunc;
      glyph_bbox : TFT_Glyph_GetBBoxFunc;
      glyph_prepare : TFT_Glyph_PrepareFunc;
    end;
//
//  TFT_Renderer_RenderFunc = function (renderer:TFT_Renderer; slot:TFT_GlyphSlot; mode:TFT_Render_Mode; origin:PFT_Vector):TFT_Error;cdecl;
//  TFT_Renderer_TransformFunc = function (renderer:TFT_Renderer; slot:TFT_GlyphSlot; matrix:PFT_Matrix; delta:PFT_Vector):TFT_Error;cdecl;
//  TFT_Renderer_GetCBoxFunc = procedure (renderer:TFT_Renderer; slot:TFT_GlyphSlot; cbox:PFT_BBox);cdecl;
//  TFT_Renderer_SetModeFunc = function (renderer:TFT_Renderer; mode_tag:TFT_ULong; mode_ptr:TFT_Pointer):TFT_Error;cdecl;
  TFT_Renderer_RenderFunc = function (renderer:Pointer; slot:Pointer; mode:Pointer; origin:PFT_Vector):TFT_Error;cdecl;
  TFT_Renderer_TransformFunc = function (renderer:Pointer; slot:Pointer; matrix:PFT_Matrix; delta:PFT_Vector):TFT_Error;cdecl;
  TFT_Renderer_GetCBoxFunc = procedure (renderer:Pointer; slot:Pointer; cbox:PFT_BBox);cdecl;
  TFT_Renderer_SetModeFunc = function (renderer:Pointer; mode_tag:TFT_ULong; mode_ptr:TFT_Pointer):TFT_Error;cdecl;
{*************************************************************************
   *
   * @struct:
   *   FT_Renderer_Class
   *
   * @description:
   *   The renderer module class descriptor.
   *
   * @fields:
   *   root ::
   *     The root @FT_Module_Class fields.
   *
   *   glyph_format ::
   *     The glyph image format this renderer handles.
   *
   *   render_glyph ::
   *     A method used to render the image that is in a given glyph slot into
   *     a bitmap.
   *
   *   transform_glyph ::
   *     A method used to transform the image that is in a given glyph slot.
   *
   *   get_glyph_cbox ::
   *     A method used to access the glyph's cbox.
   *
   *   set_mode ::
   *     A method used to pass additional parameters.
   *
   *   raster_class ::
   *     For @FT_GLYPH_FORMAT_OUTLINE renderers only.  This is a pointer to
   *     its raster's class.
    }
(* Const before type ignored *)
type
  PFT_Renderer_Class_ = ^TFT_Renderer_Class_;
  TFT_Renderer_Class_ = record
      root : TFT_Module_Class;
      glyph_format : TFT_Glyph_Format;
      render_glyph : TFT_Renderer_RenderFunc;
      transform_glyph : TFT_Renderer_TransformFunc;
      get_glyph_cbox : TFT_Renderer_GetCBoxFunc;
      set_mode : TFT_Renderer_SetModeFunc;
      raster_class : PFT_Raster_Funcs;
    end;
  TFT_Renderer_Class = TFT_Renderer_Class_;
  PFT_Renderer_Class = ^TFT_Renderer_Class;
{*************************************************************************
   *
   * @function:
   *   FT_Get_Renderer
   *
   * @description:
   *   Retrieve the current renderer for a given glyph format.
   *
   * @input:
   *   library ::
   *     A handle to the library object.
   *
   *   format ::
   *     The glyph format.
   *
   * @return:
   *   A renderer handle.  0~if none found.
   *
   * @note:
   *   An error will be returned if a module already exists by that name, or
   *   if the module requires a version of FreeType that is too great.
   *
   *   To add a new renderer, simply use @FT_Add_Module.  To retrieve a
   *   renderer by its name, use @FT_Get_Module.
    }

//    function FT_Get_Renderer(library:TFT_Library; format:TFT_Glyph_Format):TFT_Renderer;cdecl;external;
    function FT_Get_Renderer(library_:Pointer; format:TFT_Glyph_Format):Pointer;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Set_Renderer
   *
   * @description:
   *   Set the current renderer to use, and set additional mode.
   *
   * @inout:
   *   library ::
   *     A handle to the library object.
   *
   * @input:
   *   renderer ::
   *     A handle to the renderer object.
   *
   *   num_params ::
   *     The number of additional parameters.
   *
   *   parameters ::
   *     Additional parameters.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   In case of success, the renderer will be used to convert glyph images
   *   in the renderer's known format into bitmaps.
   *
   *   This doesn't change the current renderer for other formats.
   *
   *   Currently, no FreeType renderer module uses `parameters`; you should
   *   thus always pass `NULL` as the value.
    }
//    function FT_Set_Renderer(library_:TFT_Library; renderer:TFT_Renderer; num_params:TFT_UInt; parameters:PFT_Parameter):TFT_Error;cdecl;external;
    function FT_Set_Renderer(library_:Pointer; renderer:Pointer; num_params:TFT_UInt; parameters:Pointer):TFT_Error;cdecl;external;
{  }

implementation

end.
