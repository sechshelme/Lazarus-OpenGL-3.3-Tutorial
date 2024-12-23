unit ftlcdfil;

interface

uses
  fttypes, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


type
  PFT_LcdFilter_ = ^TFT_LcdFilter_;
  TFT_LcdFilter_ =  Longint;
  Const
    FT_LCD_FILTER_NONE = 0;
    FT_LCD_FILTER_DEFAULT = 1;
    FT_LCD_FILTER_LIGHT = 2;
    FT_LCD_FILTER_LEGACY1 = 3;
    FT_LCD_FILTER_LEGACY = 16;
    FT_LCD_FILTER_MAX = 17;
type
  TFT_LcdFilter = TFT_LcdFilter_;
  PFT_LcdFilter = ^TFT_LcdFilter;
{*************************************************************************
   *
   * @function:
   *   FT_Library_SetLcdFilter
   *
   * @description:
   *   This function is used to change filter applied to LCD decimated
   *   bitmaps, like the ones used when calling @FT_Render_Glyph with
   *   @FT_RENDER_MODE_LCD or @FT_RENDER_MODE_LCD_V.
   *
   * @input:
   *   library ::
   *     A handle to the target library instance.
   *
   *   filter ::
   *     The filter type.
   *
   *     You can use @FT_LCD_FILTER_NONE here to disable this feature, or
   *     @FT_LCD_FILTER_DEFAULT to use a default filter that should work well
   *     on most LCD screens.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   Since 2.10.3 the LCD filtering is enabled with @FT_LCD_FILTER_DEFAULT.
   *   It is no longer necessary to call this function explicitly except
   *   to choose a different filter or disable filtering altogether with
   *   @FT_LCD_FILTER_NONE.
   *
   *   This function does nothing but returns `FT_Err_Unimplemented_Feature`
   *   if the configuration macro `FT_CONFIG_OPTION_SUBPIXEL_RENDERING` is
   *   not defined in your build of the library.
   *
   * @since:
   *   2.3.0
    }

//    function FT_Library_SetLcdFilter(library_:TFT_Library; filter:TFT_LcdFilter):TFT_Error;cdecl;external;
    function FT_Library_SetLcdFilter(library_:Pointer; filter:TFT_LcdFilter):TFT_Error;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Library_SetLcdFilterWeights
   *
   * @description:
   *   This function can be used to enable LCD filter with custom weights,
   *   instead of using presets in @FT_Library_SetLcdFilter.
   *
   * @input:
   *   library ::
   *     A handle to the target library instance.
   *
   *   weights ::
   *     A pointer to an array; the function copies the first five bytes and
   *     uses them to specify the filter weights in 1/256 units.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   This function does nothing but returns `FT_Err_Unimplemented_Feature`
   *   if the configuration macro `FT_CONFIG_OPTION_SUBPIXEL_RENDERING` is
   *   not defined in your build of the library.
   *
   *   LCD filter weights can also be set per face using @FT_Face_Properties
   *   with @FT_PARAM_TAG_LCD_FILTER_WEIGHTS.
   *
   * @since:
   *   2.4.0
    }
//    function FT_Library_SetLcdFilterWeights(library_:TFT_Library; weights:Pbyte):TFT_Error;cdecl;external;
    function FT_Library_SetLcdFilterWeights(library_:Pointer; weights:Pbyte):TFT_Error;cdecl;external;
{*************************************************************************
   *
   * @type:
   *   FT_LcdFiveTapFilter
   *
   * @description:
   *   A typedef for passing the five LCD filter weights to
   *   @FT_Face_Properties within an @FT_Parameter structure.
   *
   * @since:
   *   2.8
   *
    }
const
  FT_LCD_FILTER_FIVE_TAPS = 5;  
type
  PFT_LcdFiveTapFilter = ^TFT_LcdFiveTapFilter;
  TFT_LcdFiveTapFilter = array[0..(FT_LCD_FILTER_FIVE_TAPS)-1] of TFT_Byte;
{*************************************************************************
   *
   * @function:
   *   FT_Library_SetLcdGeometry
   *
   * @description:
   *   This function can be used to modify default positions of color
   *   subpixels, which controls Harmony LCD rendering.
   *
   * @input:
   *   library ::
   *     A handle to the target library instance.
   *
   *   sub ::
   *     A pointer to an array of 3 vectors in 26.6 fractional pixel format;
   *     the function modifies the default values, see the note below.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   Subpixel geometry examples:
   *
   *   - -21, 0, 0, 0, 21, 0 is the default, corresponding to 3 color
   *   stripes shifted by a third of a pixel. This could be an RGB panel.
   *
   *   - 21, 0, 0, 0, -21, 0 looks the same as the default but can
   *   specify a BGR panel instead, while keeping the bitmap in the same
   *   RGB888 format.
   *
   *   - 0, 21, 0, 0, 0, -21 is the vertical RGB, but the bitmap
   *   stays RGB888 as a result.
   *
   *   - -11, 16, -11, -16, 22, 0 is a certain PenTile arrangement.
   *
   *   This function does nothing and returns `FT_Err_Unimplemented_Feature`
   *   in the context of ClearType-style subpixel rendering when
   *   `FT_CONFIG_OPTION_SUBPIXEL_RENDERING` is defined in your build of the
   *   library.
   *
   * @since:
   *   2.10.0
    }
    type
      TsubTFT_Vector=array[0..2] of TFT_Vector;


//  function FT_Library_SetLcdGeometry(library_:TFT_Library; sub:array[0..2] of TFT_Vector):TFT_Error;cdecl;external;
    function FT_Library_SetLcdGeometry(library_:Pointer;sub: TsubTFT_Vector):TFT_Error;cdecl;external;

implementation

end.
