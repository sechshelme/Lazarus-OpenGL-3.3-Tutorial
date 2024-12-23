unit ftimage;

interface

uses
  ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

const
 SHRT_MIN=	(-32768);
 SHRT_MAX=	32767    ;

type
  PFT_Pos = ^TFT_Pos;
//  TFT_Pos = longint;
  TFT_Pos = cslong;
{*************************************************************************
   *
   * @struct:
   *   FT_Vector
   *
   * @description:
   *   A simple structure used to store a 2D vector; coordinates are of the
   *   FT_Pos type.
   *
   * @fields:
   *   x ::
   *     The horizontal coordinate.
   *   y ::
   *     The vertical coordinate.
    }

  PFT_Vector_ = ^TFT_Vector_;
  TFT_Vector_ = record
      x : TFT_Pos;
      y : TFT_Pos;
    end;
  TFT_Vector = TFT_Vector_;
  PFT_Vector = ^TFT_Vector;
{*************************************************************************
   *
   * @struct:
   *   FT_BBox
   *
   * @description:
   *   A structure used to hold an outline's bounding box, i.e., the
   *   coordinates of its extrema in the horizontal and vertical directions.
   *
   * @fields:
   *   xMin ::
   *     The horizontal minimum (left-most).
   *
   *   yMin ::
   *     The vertical minimum (bottom-most).
   *
   *   xMax ::
   *     The horizontal maximum (right-most).
   *
   *   yMax ::
   *     The vertical maximum (top-most).
   *
   * @note:
   *   The bounding box is specified with the coordinates of the lower left
   *   and the upper right corner.  In PostScript, those values are often
   *   called (llx,lly) and (urx,ury), respectively.
   *
   *   If `yMin` is negative, this value gives the glyph's descender.
   *   Otherwise, the glyph doesn't descend below the baseline.  Similarly,
   *   if `ymax` is positive, this value gives the glyph's ascender.
   *
   *   `xMin` gives the horizontal distance from the glyph's origin to the
   *   left edge of the glyph's bounding box.  If `xMin` is negative, the
   *   glyph extends to the left of the origin.
    }

  PFT_BBox_ = ^TFT_BBox_;
  TFT_BBox_ = record
      xMin : TFT_Pos;
      yMin : TFT_Pos;
      xMax : TFT_Pos;
      yMax : TFT_Pos;
    end;
  TFT_BBox = TFT_BBox_;
  PFT_BBox = ^TFT_BBox;
{*************************************************************************
   *
   * @enum:
   *   FT_Pixel_Mode
   *
   * @description:
   *   An enumeration type used to describe the format of pixels in a given
   *   bitmap.  Note that additional formats may be added in the future.
   *
   * @values:
   *   FT_PIXEL_MODE_NONE ::
   *     Value~0 is reserved.
   *
   *   FT_PIXEL_MODE_MONO ::
   *     A monochrome bitmap, using 1~bit per pixel.  Note that pixels are
   *     stored in most-significant order (MSB), which means that the
   *     left-most pixel in a byte has value 128.
   *
   *   FT_PIXEL_MODE_GRAY ::
   *     An 8-bit bitmap, generally used to represent anti-aliased glyph
   *     images.  Each pixel is stored in one byte.  Note that the number of
   *     'gray' levels is stored in the `num_grays` field of the @FT_Bitmap
   *     structure (it generally is 256).
   *
   *   FT_PIXEL_MODE_GRAY2 ::
   *     A 2-bit per pixel bitmap, used to represent embedded anti-aliased
   *     bitmaps in font files according to the OpenType specification.  We
   *     haven't found a single font using this format, however.
   *
   *   FT_PIXEL_MODE_GRAY4 ::
   *     A 4-bit per pixel bitmap, representing embedded anti-aliased bitmaps
   *     in font files according to the OpenType specification.  We haven't
   *     found a single font using this format, however.
   *
   *   FT_PIXEL_MODE_LCD ::
   *     An 8-bit bitmap, representing RGB or BGR decimated glyph images used
   *     for display on LCD displays; the bitmap is three times wider than
   *     the original glyph image.  See also @FT_RENDER_MODE_LCD.
   *
   *   FT_PIXEL_MODE_LCD_V ::
   *     An 8-bit bitmap, representing RGB or BGR decimated glyph images used
   *     for display on rotated LCD displays; the bitmap is three times
   *     taller than the original glyph image.  See also
   *     @FT_RENDER_MODE_LCD_V.
   *
   *   FT_PIXEL_MODE_BGRA ::
   *     [Since 2.5] An image with four 8-bit channels per pixel,
   *     representing a color image (such as emoticons) with alpha channel.
   *     For each pixel, the format is BGRA, which means, the blue channel
   *     comes first in memory.  The color channels are pre-multiplied and in
   *     the sRGB colorspace.  For example, full red at half-translucent
   *     opacity will be represented as '00,00,80,80', not '00,00,FF,80'.
   *     See also @FT_LOAD_COLOR.
    }
{ do not remove  }

  PFT_Pixel_Mode_ = ^TFT_Pixel_Mode_;
  TFT_Pixel_Mode_ =  Longint;
  Const
    FT_PIXEL_MODE_NONE = 0;
    FT_PIXEL_MODE_MONO = 1;
    FT_PIXEL_MODE_GRAY = 2;
    FT_PIXEL_MODE_GRAY2 = 3;
    FT_PIXEL_MODE_GRAY4 = 4;
    FT_PIXEL_MODE_LCD = 5;
    FT_PIXEL_MODE_LCD_V = 6;
    FT_PIXEL_MODE_BGRA = 7;
    FT_PIXEL_MODE_MAX = 8;
        type
  TFT_Pixel_Mode = TFT_Pixel_Mode_;
  PFT_Pixel_Mode = ^TFT_Pixel_Mode;
{ these constants are deprecated; use the corresponding `FT_Pixel_Mode`  }
{ values instead.                                                        }
//  ft_pixel_mode_none = FT_PIXEL_MODE_NONE;
//  ft_pixel_mode_mono = FT_PIXEL_MODE_MONO;  
//  ft_pixel_mode_grays = FT_PIXEL_MODE_GRAY;
//  ft_pixel_mode_pal2 = FT_PIXEL_MODE_GRAY2;  
//  ft_pixel_mode_pal4 = FT_PIXEL_MODE_GRAY4;  
{  }
{ For debugging, the @FT_Pixel_Mode enumeration must stay in sync  }
{ with the `pixel_modes` array in file `ftobjs.c`.                 }
{*************************************************************************
   *
   * @struct:
   *   FT_Bitmap
   *
   * @description:
   *   A structure used to describe a bitmap or pixmap to the raster.  Note
   *   that we now manage pixmaps of various depths through the `pixel_mode`
   *   field.
   *
   * @fields:
   *   rows ::
   *     The number of bitmap rows.
   *
   *   width ::
   *     The number of pixels in bitmap row.
   *
   *   pitch ::
   *     The pitch's absolute value is the number of bytes taken by one
   *     bitmap row, including padding.  However, the pitch is positive when
   *     the bitmap has a 'down' flow, and negative when it has an 'up' flow.
   *     In all cases, the pitch is an offset to add to a bitmap pointer in
   *     order to go down one row.
   *
   *     Note that 'padding' means the alignment of a bitmap to a byte
   *     border, and FreeType functions normally align to the smallest
   *     possible integer value.
   *
   *     For the B/W rasterizer, `pitch` is always an even number.
   *
   *     To change the pitch of a bitmap (say, to make it a multiple of 4),
   *     use @FT_Bitmap_Convert.  Alternatively, you might use callback
   *     functions to directly render to the application's surface; see the
   *     file `example2.cpp` in the tutorial for a demonstration.
   *
   *   buffer ::
   *     A typeless pointer to the bitmap buffer.  This value should be
   *     aligned on 32-bit boundaries in most cases.
   *
   *   num_grays ::
   *     This field is only used with @FT_PIXEL_MODE_GRAY; it gives the
   *     number of gray levels used in the bitmap.
   *
   *   pixel_mode ::
   *     The pixel mode, i.e., how pixel bits are stored.  See @FT_Pixel_Mode
   *     for possible values.
   *
   *   palette_mode ::
   *     This field is intended for paletted pixel modes; it indicates how
   *     the palette is stored.  Not used currently.
   *
   *   palette ::
   *     A typeless pointer to the bitmap palette; this field is intended for
   *     paletted pixel modes.  Not used currently.
   *
   * @note:
   *   `width` and `rows` refer to the *physical* size of the bitmap, not the
   *   *logical* one.  For example, if @FT_Pixel_Mode is set to
   *   `FT_PIXEL_MODE_LCD`, the logical width is a just a third of the
   *   physical one.
    }
type
  PFT_Bitmap_ = ^TFT_Bitmap_;
  TFT_Bitmap_ = record
      rows : cuint;
      width : cuint;
      pitch : cint;
      buffer : pcuchar;
      num_grays : cushort;
      pixel_mode : cuchar;
      palette_mode : cuchar;
      palette : pointer;
    end;
  TFT_Bitmap = TFT_Bitmap_;
  PFT_Bitmap = ^TFT_Bitmap;
{*************************************************************************
   *
   * @section:
   *   outline_processing
   *
    }
{*************************************************************************
   *
   * @struct:
   *   FT_Outline
   *
   * @description:
   *   This structure is used to describe an outline to the scan-line
   *   converter.
   *
   * @fields:
   *   n_contours ::
   *     The number of contours in the outline.
   *
   *   n_points ::
   *     The number of points in the outline.
   *
   *   points ::
   *     A pointer to an array of `n_points` @FT_Vector elements, giving the
   *     outline's point coordinates.
   *
   *   tags ::
   *     A pointer to an array of `n_points` chars, giving each outline
   *     point's type.
   *
   *     If bit~0 is unset, the point is 'off' the curve, i.e., a Bezier
   *     control point, while it is 'on' if set.
   *
   *     Bit~1 is meaningful for 'off' points only.  If set, it indicates a
   *     third-order Bezier arc control point; and a second-order control
   *     point if unset.
   *
   *     If bit~2 is set, bits 5-7 contain the drop-out mode (as defined in
   *     the OpenType specification; the value is the same as the argument to
   *     the 'SCANTYPE' instruction).
   *
   *     Bits 3 and~4 are reserved for internal purposes.
   *
   *   contours ::
   *     An array of `n_contours` shorts, giving the end point of each
   *     contour within the outline.  For example, the first contour is
   *     defined by the points '0' to `contours[0]`, the second one is
   *     defined by the points `contours[0]+1` to `contours[1]`, etc.
   *
   *   flags ::
   *     A set of bit flags used to characterize the outline and give hints
   *     to the scan-converter and hinter on how to convert/grid-fit it.  See
   *     @FT_OUTLINE_XXX.
   *
   * @note:
   *   The B/W rasterizer only checks bit~2 in the `tags` array for the first
   *   point of each contour.  The drop-out mode as given with
   *   @FT_OUTLINE_IGNORE_DROPOUTS, @FT_OUTLINE_SMART_DROPOUTS, and
   *   @FT_OUTLINE_INCLUDE_STUBS in `flags` is then overridden.
    }
{ number of contours in glyph         }
{ number of points in the glyph       }
{ the outline's points                }
{ the points flags                    }
{ the contour end points              }
{ outline masks                       }

  PFT_Outline_ = ^TFT_Outline_;
  TFT_Outline_ = record
      n_contours : smallint;
      n_points : smallint;
      points : PFT_Vector;
      tags : Pchar;
      contours : Psmallint;
      flags : longint;
    end;
  TFT_Outline = TFT_Outline_;
  PFT_Outline = ^TFT_Outline;
{  }
{ Following limits must be consistent with  }
{ FT_Outline.n_contours,n_points          }

const
  FT_OUTLINE_CONTOURS_MAX = SHRT_MAX;  
  FT_OUTLINE_POINTS_MAX = SHRT_MAX;  
{*************************************************************************
   *
   * @enum:
   *   FT_OUTLINE_XXX
   *
   * @description:
   *   A list of bit-field constants used for the flags in an outline's
   *   `flags` field.
   *
   * @values:
   *   FT_OUTLINE_NONE ::
   *     Value~0 is reserved.
   *
   *   FT_OUTLINE_OWNER ::
   *     If set, this flag indicates that the outline's field arrays (i.e.,
   *     `points`, `flags`, and `contours`) are 'owned' by the outline
   *     object, and should thus be freed when it is destroyed.
   *
   *   FT_OUTLINE_EVEN_ODD_FILL ::
   *     By default, outlines are filled using the non-zero winding rule.  If
   *     set to 1, the outline will be filled using the even-odd fill rule
   *     (only works with the smooth rasterizer).
   *
   *   FT_OUTLINE_REVERSE_FILL ::
   *     By default, outside contours of an outline are oriented in
   *     clock-wise direction, as defined in the TrueType specification.
   *     This flag is set if the outline uses the opposite direction
   *     (typically for Type~1 fonts).  This flag is ignored by the scan
   *     converter.
   *
   *   FT_OUTLINE_IGNORE_DROPOUTS ::
   *     By default, the scan converter will try to detect drop-outs in an
   *     outline and correct the glyph bitmap to ensure consistent shape
   *     continuity.  If set, this flag hints the scan-line converter to
   *     ignore such cases.  See below for more information.
   *
   *   FT_OUTLINE_SMART_DROPOUTS ::
   *     Select smart dropout control.  If unset, use simple dropout control.
   *     Ignored if @FT_OUTLINE_IGNORE_DROPOUTS is set.  See below for more
   *     information.
   *
   *   FT_OUTLINE_INCLUDE_STUBS ::
   *     If set, turn pixels on for 'stubs', otherwise exclude them.  Ignored
   *     if @FT_OUTLINE_IGNORE_DROPOUTS is set.  See below for more
   *     information.
   *
   *   FT_OUTLINE_OVERLAP ::
   *     [Since 2.10.3] This flag indicates that this outline contains
   *     overlapping contours and the anti-aliased renderer should perform
   *     oversampling to mitigate possible artifacts.  This flag should _not_
   *     be set for well designed glyphs without overlaps because it quadruples
   *     the rendering time.
   *
   *   FT_OUTLINE_HIGH_PRECISION ::
   *     This flag indicates that the scan-line converter should try to
   *     convert this outline to bitmaps with the highest possible quality.
   *     It is typically set for small character sizes.  Note that this is
   *     only a hint that might be completely ignored by a given
   *     scan-converter.
   *
   *   FT_OUTLINE_SINGLE_PASS ::
   *     This flag is set to force a given scan-converter to only use a
   *     single pass over the outline to render a bitmap glyph image.
   *     Normally, it is set for very large character sizes.  It is only a
   *     hint that might be completely ignored by a given scan-converter.
   *
   * @note:
   *   The flags @FT_OUTLINE_IGNORE_DROPOUTS, @FT_OUTLINE_SMART_DROPOUTS, and
   *   @FT_OUTLINE_INCLUDE_STUBS are ignored by the smooth rasterizer.
   *
   *   There exists a second mechanism to pass the drop-out mode to the B/W
   *   rasterizer; see the `tags` field in @FT_Outline.
   *
   *   Please refer to the description of the 'SCANTYPE' instruction in the
   *   [OpenType specification](https://learn.microsoft.com/en-us/typography/opentype/spec/tt_instructions#scantype)
   *   how simple drop-outs, smart drop-outs, and stubs are defined.
    }
  FT_OUTLINE_NONE = $0;  
  FT_OUTLINE_OWNER = $1;  
  FT_OUTLINE_EVEN_ODD_FILL = $2;  
  FT_OUTLINE_REVERSE_FILL = $4;  
  FT_OUTLINE_IGNORE_DROPOUTS = $8;  
  FT_OUTLINE_SMART_DROPOUTS = $10;  
  FT_OUTLINE_INCLUDE_STUBS = $20;  
  FT_OUTLINE_OVERLAP = $40;  
  FT_OUTLINE_HIGH_PRECISION = $100;  
  FT_OUTLINE_SINGLE_PASS = $200;  
{ these constants are deprecated; use the corresponding  }
{ `FT_OUTLINE_XXX` values instead                        }
  //ft_outline_none = FT_OUTLINE_NONE;  
  //ft_outline_owner = FT_OUTLINE_OWNER;  
  //ft_outline_even_odd_fill = FT_OUTLINE_EVEN_ODD_FILL;  
  //ft_outline_reverse_fill = FT_OUTLINE_REVERSE_FILL;  
  //ft_outline_ignore_dropouts = FT_OUTLINE_IGNORE_DROPOUTS;  
  //ft_outline_high_precision = FT_OUTLINE_HIGH_PRECISION;  
  //ft_outline_single_pass = FT_OUTLINE_SINGLE_PASS;  
{  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function FT_CURVE_TAG(flag : longint) : longint;

{ see the `tags` field in `FT_Outline` for a description of the values  }
const
  FT_CURVE_TAG_ON = $01;  
  FT_CURVE_TAG_CONIC = $00;  
  FT_CURVE_TAG_CUBIC = $02;  
  FT_CURVE_TAG_HAS_SCANMODE = $04;  
{ reserved for TrueType hinter  }
  FT_CURVE_TAG_TOUCH_X = $08;  
{ reserved for TrueType hinter  }
  FT_CURVE_TAG_TOUCH_Y = $10;  
  FT_CURVE_TAG_TOUCH_BOTH = FT_CURVE_TAG_TOUCH_X or FT_CURVE_TAG_TOUCH_Y;  
{ values 0x20, 0x40, and 0x80 are reserved  }
{ these constants are deprecated; use the corresponding  }
{ `FT_CURVE_TAG_XXX` values instead                      }
  //FT_Curve_Tag_On = FT_CURVE_TAG_ON;  
  //FT_Curve_Tag_Conic = FT_CURVE_TAG_CONIC;  
  //FT_Curve_Tag_Cubic = FT_CURVE_TAG_CUBIC;  
  //FT_Curve_Tag_Touch_X = FT_CURVE_TAG_TOUCH_X;  
  //FT_Curve_Tag_Touch_Y = FT_CURVE_TAG_TOUCH_Y;  
{*************************************************************************
   *
   * @functype:
   *   FT_Outline_MoveToFunc
   *
   * @description:
   *   A function pointer type used to describe the signature of a 'move to'
   *   function during outline walking/decomposition.
   *
   *   A 'move to' is emitted to start a new contour in an outline.
   *
   * @input:
   *   to ::
   *     A pointer to the target point of the 'move to'.
   *
   *   user ::
   *     A typeless pointer, which is passed from the caller of the
   *     decomposition function.
   *
   * @return:
   *   Error code.  0~means success.
    }
(* Const before type ignored *)
type

  TFT_Outline_MoveToFunc = function (to_:PFT_Vector; user:pointer):longint;cdecl;

  TFT_Outline_MoveTo_Func = TFT_Outline_MoveToFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Outline_LineToFunc
   *
   * @description:
   *   A function pointer type used to describe the signature of a 'line to'
   *   function during outline walking/decomposition.
   *
   *   A 'line to' is emitted to indicate a segment in the outline.
   *
   * @input:
   *   to ::
   *     A pointer to the target point of the 'line to'.
   *
   *   user ::
   *     A typeless pointer, which is passed from the caller of the
   *     decomposition function.
   *
   * @return:
   *   Error code.  0~means success.
    }
(* Const before type ignored *)
type

  TFT_Outline_LineToFunc = function (to_:PFT_Vector; user:pointer):longint;cdecl;

  TFT_Outline_LineTo_Func = TFT_Outline_LineToFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Outline_ConicToFunc
   *
   * @description:
   *   A function pointer type used to describe the signature of a 'conic to'
   *   function during outline walking or decomposition.
   *
   *   A 'conic to' is emitted to indicate a second-order Bezier arc in the
   *   outline.
   *
   * @input:
   *   control ::
   *     An intermediate control point between the last position and the new
   *     target in `to`.
   *
   *   to ::
   *     A pointer to the target end point of the conic arc.
   *
   *   user ::
   *     A typeless pointer, which is passed from the caller of the
   *     decomposition function.
   *
   * @return:
   *   Error code.  0~means success.
    }
(* Const before type ignored *)
(* Const before type ignored *)
type

  TFT_Outline_ConicToFunc = function (control:PFT_Vector; to_:PFT_Vector; user:pointer):longint;cdecl;

  TFT_Outline_ConicTo_Func = TFT_Outline_ConicToFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Outline_CubicToFunc
   *
   * @description:
   *   A function pointer type used to describe the signature of a 'cubic to'
   *   function during outline walking or decomposition.
   *
   *   A 'cubic to' is emitted to indicate a third-order Bezier arc.
   *
   * @input:
   *   control1 ::
   *     A pointer to the first Bezier control point.
   *
   *   control2 ::
   *     A pointer to the second Bezier control point.
   *
   *   to ::
   *     A pointer to the target end point.
   *
   *   user ::
   *     A typeless pointer, which is passed from the caller of the
   *     decomposition function.
   *
   * @return:
   *   Error code.  0~means success.
    }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
type

  TFT_Outline_CubicToFunc = function (control1:PFT_Vector; control2:PFT_Vector; to_:PFT_Vector; user:pointer):longint;cdecl;

  TFT_Outline_CubicTo_Func = TFT_Outline_CubicToFunc;
{*************************************************************************
   *
   * @struct:
   *   FT_Outline_Funcs
   *
   * @description:
   *   A structure to hold various function pointers used during outline
   *   decomposition in order to emit segments, conic, and cubic Beziers.
   *
   * @fields:
   *   move_to ::
   *     The 'move to' emitter.
   *
   *   line_to ::
   *     The segment emitter.
   *
   *   conic_to ::
   *     The second-order Bezier arc emitter.
   *
   *   cubic_to ::
   *     The third-order Bezier arc emitter.
   *
   *   shift ::
   *     The shift that is applied to coordinates before they are sent to the
   *     emitter.
   *
   *   delta ::
   *     The delta that is applied to coordinates before they are sent to the
   *     emitter, but after the shift.
   *
   * @note:
   *   The point coordinates sent to the emitters are the transformed version
   *   of the original coordinates (this is important for high accuracy
   *   during scan-conversion).  The transformation is simple:
   *
   *   ```
   *     x' = (x << shift) - delta
   *     y' = (y << shift) - delta
   *   ```
   *
   *   Set the values of `shift` and `delta` to~0 to get the original point
   *   coordinates.
    }
type
  PFT_Outline_Funcs_ = ^TFT_Outline_Funcs_;
  TFT_Outline_Funcs_ = record
      move_to : TFT_Outline_MoveToFunc;
      line_to : TFT_Outline_LineToFunc;
      conic_to : TFT_Outline_ConicToFunc;
      cubic_to : TFT_Outline_CubicToFunc;
      shift : longint;
      delta : TFT_Pos;
    end;
  TFT_Outline_Funcs = TFT_Outline_Funcs_;
  PFT_Outline_Funcs = ^TFT_Outline_Funcs;
{*************************************************************************
   *
   * @section:
   *   basic_types
   *
    }
{*************************************************************************
   *
   * @macro:
   *   FT_IMAGE_TAG
   *
   * @description:
   *   This macro converts four-letter tags to an unsigned long type.
   *
   * @note:
   *   Since many 16-bit compilers don't like 32-bit enumerations, you should
   *   redefine this macro in case of problems to something like this:
   *
   *   ```
   *     #define FT_IMAGE_TAG( value, _x1, _x2, _x3, _x4 )  value
   *   ```
   *
   *   to get a simple enumeration without assigning special numbers.
    }
{$ifndef FT_IMAGE_TAG}
{#define FT_IMAGE_TAG( value, _x1, _x2, _x3, _x4 )                         \ }
{          value = ( ( FT_STATIC_BYTE_CAST( unsigned long, _x1 ) << 24 ) | \ }
{                    ( FT_STATIC_BYTE_CAST( unsigned long, _x2 ) << 16 ) | \ }
{                    ( FT_STATIC_BYTE_CAST( unsigned long, _x3 ) << 8  ) | \ }
{                      FT_STATIC_BYTE_CAST( unsigned long, _x4 )         ) }
{$endif}
{ FT_IMAGE_TAG  }
{*************************************************************************
   *
   * @enum:
   *   FT_Glyph_Format
   *
   * @description:
   *   An enumeration type used to describe the format of a given glyph
   *   image.  Note that this version of FreeType only supports two image
   *   formats, even though future font drivers will be able to register
   *   their own format.
   *
   * @values:
   *   FT_GLYPH_FORMAT_NONE ::
   *     The value~0 is reserved.
   *
   *   FT_GLYPH_FORMAT_COMPOSITE ::
   *     The glyph image is a composite of several other images.  This format
   *     is _only_ used with @FT_LOAD_NO_RECURSE, and is used to report
   *     compound glyphs (like accented characters).
   *
   *   FT_GLYPH_FORMAT_BITMAP ::
   *     The glyph image is a bitmap, and can be described as an @FT_Bitmap.
   *     You generally need to access the `bitmap` field of the
   *     @FT_GlyphSlotRec structure to read it.
   *
   *   FT_GLYPH_FORMAT_OUTLINE ::
   *     The glyph image is a vectorial outline made of line segments and
   *     Bezier arcs; it can be described as an @FT_Outline; you generally
   *     want to access the `outline` field of the @FT_GlyphSlotRec structure
   *     to read it.
   *
   *   FT_GLYPH_FORMAT_PLOTTER ::
   *     The glyph image is a vectorial path with no inside and outside
   *     contours.  Some Type~1 fonts, like those in the Hershey family,
   *     contain glyphs in this format.  These are described as @FT_Outline,
   *     but FreeType isn't currently capable of rendering them correctly.
   *
   *   FT_GLYPH_FORMAT_SVG ::
   *     [Since 2.12] The glyph is represented by an SVG document in the
   *     'SVG~' table.
    }
{  typedef enum  FT_Glyph_Format_ }

type
  TFT_Glyph_Format=LongInt;
  PFT_Glyph_Format=^TFT_Glyph_Format;

const
 FT_GLYPH_FORMAT_NONE = 0;
 FT_GLYPH_FORMAT_COMPOSITE= (Byte('c')shl 24) or (Byte('o')shl 16) or (Byte('m')shl 8) or Byte('p');
 FT_GLYPH_FORMAT_BITMAP   = (Byte('b')shl 24) or (Byte('i')shl 16) or (Byte('t')shl 8) or Byte('s');
 FT_GLYPH_FORMAT_OUTLINE  = (Byte('o')shl 24) or (Byte('u')shl 16) or (Byte('t')shl 8) or Byte('l');
 FT_GLYPH_FORMAT_PLOTTER  = (Byte('p')shl 24) or (Byte('l')shl 16) or (Byte('o')shl 8) or Byte('t');
 FT_GLYPH_FORMAT_SVG      = (Byte('S')shl 24) or (Byte('V')shl 16) or (Byte('G')shl 8) or Byte(' ');



{   }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_NONE, 0, 0, 0, 0 ), }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_COMPOSITE, 'c', 'o', 'm', 'p' ), }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_BITMAP,    'b', 'i', 't', 's' ), }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_OUTLINE,   'o', 'u', 't', 'l' ), }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_PLOTTER,   'p', 'l', 'o', 't' ), }
{    FT_IMAGE_TAG( FT_GLYPH_FORMAT_SVG,       'S', 'V', 'G', ' ' ) }
{   FT_Glyph_Format; }
{ these constants are deprecated; use the corresponding  }
{ `FT_Glyph_Format` values instead.                      }

//const
//  ft_glyph_format_none = FT_GLYPH_FORMAT_NONE;  
//  ft_glyph_format_composite = FT_GLYPH_FORMAT_COMPOSITE;  
//  ft_glyph_format_bitmap = FT_GLYPH_FORMAT_BITMAP;  
//  ft_glyph_format_outline = FT_GLYPH_FORMAT_OUTLINE;  
//  ft_glyph_format_plotter = FT_GLYPH_FORMAT_PLOTTER;  
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****            R A S T E R   D E F I N I T I O N S                **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @section:
   *   raster
   *
   * @title:
   *   Scanline Converter
   *
   * @abstract:
   *   How vectorial outlines are converted into bitmaps and pixmaps.
   *
   * @description:
   *   A raster or a rasterizer is a scan converter in charge of producing a
   *   pixel coverage bitmap that can be used as an alpha channel when
   *   compositing a glyph with a background.  FreeType comes with two
   *   rasterizers: bilevel `raster1` and anti-aliased `smooth` are two
   *   separate modules.  They are usually called from the high-level
   *   @FT_Load_Glyph or @FT_Render_Glyph functions and produce the entire
   *   coverage bitmap at once, while staying largely invisible to users.
   *
   *   Instead of working with complete coverage bitmaps, it is also possible
   *   to intercept consecutive pixel runs on the same scanline with the same
   *   coverage, called _spans_, and process them individually.  Only the
   *   `smooth` rasterizer permits this when calling @FT_Outline_Render with
   *   @FT_Raster_Params as described below.
   *
   *   Working with either complete bitmaps or spans it is important to think
   *   of them as colorless coverage objects suitable as alpha channels to
   *   blend arbitrary colors with a background.  For best results, it is
   *   recommended to use gamma correction, too.
   *
   *   This section also describes the public API needed to set up alternative
   *   @FT_Renderer modules.
   *
   * @order:
   *   FT_Span
   *   FT_SpanFunc
   *   FT_Raster_Params
   *   FT_RASTER_FLAG_XXX
   *
   *   FT_Raster
   *   FT_Raster_NewFunc
   *   FT_Raster_DoneFunc
   *   FT_Raster_ResetFunc
   *   FT_Raster_SetModeFunc
   *   FT_Raster_RenderFunc
   *   FT_Raster_Funcs
   *
    }
{*************************************************************************
   *
   * @struct:
   *   FT_Span
   *
   * @description:
   *   A structure to model a single span of consecutive pixels when
   *   rendering an anti-aliased bitmap.
   *
   * @fields:
   *   x ::
   *     The span's horizontal start position.
   *
   *   len ::
   *     The span's length in pixels.
   *
   *   coverage ::
   *     The span color/coverage, ranging from 0 (background) to 255
   *     (foreground).
   *
   * @note:
   *   This structure is used by the span drawing callback type named
   *   @FT_SpanFunc that takes the y~coordinate of the span as a parameter.
   *
   *   The anti-aliased rasterizer produces coverage values from 0 to 255,
   *   that is, from completely transparent to completely opaque.
    }
type
  PFT_Span_ = ^TFT_Span_;
  TFT_Span_ = record
      x : smallint;
      len : word;
      coverage : byte;
    end;
  TFT_Span = TFT_Span_;
  PFT_Span = ^TFT_Span;
{*************************************************************************
   *
   * @functype:
   *   FT_SpanFunc
   *
   * @description:
   *   A function used as a call-back by the anti-aliased renderer in order
   *   to let client applications draw themselves the pixel spans on each
   *   scan line.
   *
   * @input:
   *   y ::
   *     The scanline's upward y~coordinate.
   *
   *   count ::
   *     The number of spans to draw on this scanline.
   *
   *   spans ::
   *     A table of `count` spans to draw on the scanline.
   *
   *   user ::
   *     User-supplied data that is passed to the callback.
   *
   * @note:
   *   This callback allows client applications to directly render the spans
   *   of the anti-aliased bitmap to any kind of surfaces.
   *
   *   This can be used to write anti-aliased outlines directly to a given
   *   background bitmap using alpha compositing.  It can also be used for
   *   oversampling and averaging.
    }
(* Const before type ignored *)

  TFT_SpanFunc = procedure (y:longint; count:longint; spans:PFT_Span; user:pointer);cdecl;

  TFT_Raster_Span_Func = TFT_SpanFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_BitTest_Func
   *
   * @description:
   *   Deprecated, unimplemented.
    }
type

  TFT_Raster_BitTest_Func = function (y:longint; x:longint; user:pointer):longint;cdecl;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_BitSet_Func
   *
   * @description:
   *   Deprecated, unimplemented.
    }

  TFT_Raster_BitSet_Func = procedure (y:longint; x:longint; user:pointer);cdecl;
{*************************************************************************
   *
   * @enum:
   *   FT_RASTER_FLAG_XXX
   *
   * @description:
   *   A list of bit flag constants as used in the `flags` field of a
   *   @FT_Raster_Params structure.
   *
   * @values:
   *   FT_RASTER_FLAG_DEFAULT ::
   *     This value is 0.
   *
   *   FT_RASTER_FLAG_AA ::
   *     This flag is set to indicate that an anti-aliased glyph image should
   *     be generated.  Otherwise, it will be monochrome (1-bit).
   *
   *   FT_RASTER_FLAG_DIRECT ::
   *     This flag is set to indicate direct rendering.  In this mode, client
   *     applications must provide their own span callback.  This lets them
   *     directly draw or compose over an existing bitmap.  If this bit is
   *     _not_ set, the target pixmap's buffer _must_ be zeroed before
   *     rendering and the output will be clipped to its size.
   *
   *     Direct rendering is only possible with anti-aliased glyphs.
   *
   *   FT_RASTER_FLAG_CLIP ::
   *     This flag is only used in direct rendering mode.  If set, the output
   *     will be clipped to a box specified in the `clip_box` field of the
   *     @FT_Raster_Params structure.  Otherwise, the `clip_box` is
   *     effectively set to the bounding box and all spans are generated.
   *
   *   FT_RASTER_FLAG_SDF ::
   *     This flag is set to indicate that a signed distance field glyph
   *     image should be generated.  This is only used while rendering with
   *     the @FT_RENDER_MODE_SDF render mode.
    }

const
  FT_RASTER_FLAG_DEFAULT = $0;  
  FT_RASTER_FLAG_AA = $1;  
  FT_RASTER_FLAG_DIRECT = $2;  
  FT_RASTER_FLAG_CLIP = $4;  
  FT_RASTER_FLAG_SDF = $8;  
{ these constants are deprecated; use the corresponding  }
{ `FT_RASTER_FLAG_XXX` values instead                    }
  //ft_raster_flag_default = FT_RASTER_FLAG_DEFAULT;  
  //ft_raster_flag_aa = FT_RASTER_FLAG_AA;  
  //ft_raster_flag_direct = FT_RASTER_FLAG_DIRECT;  
  //ft_raster_flag_clip = FT_RASTER_FLAG_CLIP;  
{*************************************************************************
   *
   * @struct:
   *   FT_Raster_Params
   *
   * @description:
   *   A structure to hold the parameters used by a raster's render function,
   *   passed as an argument to @FT_Outline_Render.
   *
   * @fields:
   *   target ::
   *     The target bitmap.
   *
   *   source ::
   *     A pointer to the source glyph image (e.g., an @FT_Outline).
   *
   *   flags ::
   *     The rendering flags.
   *
   *   gray_spans ::
   *     The gray span drawing callback.
   *
   *   black_spans ::
   *     Unused.
   *
   *   bit_test ::
   *     Unused.
   *
   *   bit_set ::
   *     Unused.
   *
   *   user ::
   *     User-supplied data that is passed to each drawing callback.
   *
   *   clip_box ::
   *     An optional span clipping box expressed in _integer_ pixels
   *     (not in 26.6 fixed-point units).
   *
   * @note:
   *   The @FT_RASTER_FLAG_AA bit flag must be set in the `flags` to
   *   generate an anti-aliased glyph bitmap, otherwise a monochrome bitmap
   *   is generated.  The `target` should have appropriate pixel mode and its
   *   dimensions define the clipping region.
   *
   *   If both @FT_RASTER_FLAG_AA and @FT_RASTER_FLAG_DIRECT bit flags
   *   are set in `flags`, the raster calls an @FT_SpanFunc callback
   *   `gray_spans` with `user` data as an argument ignoring `target`.  This
   *   allows direct composition over a pre-existing user surface to perform
   *   the span drawing and composition.  To optionally clip the spans, set
   *   the @FT_RASTER_FLAG_CLIP flag and `clip_box`.  The monochrome raster
   *   does not support the direct mode.
   *
   *   The gray-level rasterizer always uses 256 gray levels.  If you want
   *   fewer gray levels, you have to use @FT_RASTER_FLAG_DIRECT and reduce
   *   the levels in the callback function.
    }
(* Const before type ignored *)
(* Const before type ignored *)
{ unused  }
{ unused  }
{ unused  }
type
  PFT_Raster_Params_ = ^TFT_Raster_Params_;
  TFT_Raster_Params_ = record
      target : PFT_Bitmap;
      source : pointer;
      flags : longint;
      gray_spans : TFT_SpanFunc;
      black_spans : TFT_SpanFunc;
      bit_test : TFT_Raster_BitTest_Func;
      bit_set : TFT_Raster_BitSet_Func;
      user : pointer;
      clip_box : TFT_BBox;
    end;
  TFT_Raster_Params = TFT_Raster_Params_;
  PFT_Raster_Params = ^TFT_Raster_Params;
{*************************************************************************
   *
   * @type:
   *   FT_Raster
   *
   * @description:
   *   An opaque handle (pointer) to a raster object.  Each object can be
   *   used independently to convert an outline into a bitmap or pixmap.
   *
   * @note:
   *   In FreeType 2, all rasters are now encapsulated within specific
   *   @FT_Renderer modules and only used in their context.
   *
    }

  PFT_Raster = ^TFT_Raster;
  TFT_Raster = record
  end;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_NewFunc
   *
   * @description:
   *   A function used to create a new raster object.
   *
   * @input:
   *   memory ::
   *     A handle to the memory allocator.
   *
   * @output:
   *   raster ::
   *     A handle to the new raster object.
   *
   * @return:
   *   Error code.  0~means success.
   *
   * @note:
   *   The `memory` parameter is a typeless pointer in order to avoid
   *   un-wanted dependencies on the rest of the FreeType code.  In practice,
   *   it is an @FT_Memory object, i.e., a handle to the standard FreeType
   *   memory allocator.  However, this field can be completely ignored by a
   *   given raster implementation.
    }

  TFT_Raster_NewFunc = function (memory:pointer; raster:PFT_Raster):longint;cdecl;

  TFT_Raster_New_Func = TFT_Raster_NewFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_DoneFunc
   *
   * @description:
   *   A function used to destroy a given raster object.
   *
   * @input:
   *   raster ::
   *     A handle to the raster object.
    }
type

  TFT_Raster_DoneFunc = procedure (raster:TFT_Raster);cdecl;

  TFT_Raster_Done_Func = TFT_Raster_DoneFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_ResetFunc
   *
   * @description:
   *   FreeType used to provide an area of memory called the 'render pool'
   *   available to all registered rasterizers.  This was not thread safe,
   *   however, and now FreeType never allocates this pool.
   *
   *   This function is called after a new raster object is created.
   *
   * @input:
   *   raster ::
   *     A handle to the new raster object.
   *
   *   pool_base ::
   *     Previously, the address in memory of the render pool.  Set this to
   *     `NULL`.
   *
   *   pool_size ::
   *     Previously, the size in bytes of the render pool.  Set this to 0.
   *
   * @note:
   *   Rasterizers should rely on dynamic or stack allocation if they want to
   *   (a handle to the memory allocator is passed to the rasterizer
   *   constructor).
    }
type

  TFT_Raster_ResetFunc = procedure (raster:TFT_Raster; pool_base:Pbyte; pool_size:dword);cdecl;

  TFT_Raster_Reset_Func = TFT_Raster_ResetFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_SetModeFunc
   *
   * @description:
   *   This function is a generic facility to change modes or attributes in a
   *   given raster.  This can be used for debugging purposes, or simply to
   *   allow implementation-specific 'features' in a given raster module.
   *
   * @input:
   *   raster ::
   *     A handle to the new raster object.
   *
   *   mode ::
   *     A 4-byte tag used to name the mode or property.
   *
   *   args ::
   *     A pointer to the new mode/property to use.
    }
type

  TFT_Raster_SetModeFunc = function (raster:TFT_Raster; mode:dword; args:pointer):longint;cdecl;

  TFT_Raster_Set_Mode_Func = TFT_Raster_SetModeFunc;
{*************************************************************************
   *
   * @functype:
   *   FT_Raster_RenderFunc
   *
   * @description:
   *   Invoke a given raster to scan-convert a given glyph image into a
   *   target bitmap.
   *
   * @input:
   *   raster ::
   *     A handle to the raster object.
   *
   *   params ::
   *     A pointer to an @FT_Raster_Params structure used to store the
   *     rendering parameters.
   *
   * @return:
   *   Error code.  0~means success.
   *
   * @note:
   *   The exact format of the source image depends on the raster's glyph
   *   format defined in its @FT_Raster_Funcs structure.  It can be an
   *   @FT_Outline or anything else in order to support a large array of
   *   glyph formats.
   *
   *   Note also that the render function can fail and return a
   *   `FT_Err_Unimplemented_Feature` error code if the raster used does not
   *   support direct composition.
    }
(* Const before type ignored *)
type

  TFT_Raster_RenderFunc = function (raster:TFT_Raster; params:PFT_Raster_Params):longint;cdecl;

  TFT_Raster_Render_Func = TFT_Raster_RenderFunc;
{*************************************************************************
   *
   * @struct:
   *   FT_Raster_Funcs
   *
   * @description:
   *  A structure used to describe a given raster class to the library.
   *
   * @fields:
   *   glyph_format ::
   *     The supported glyph format for this raster.
   *
   *   raster_new ::
   *     The raster constructor.
   *
   *   raster_reset ::
   *     Used to reset the render pool within the raster.
   *
   *   raster_render ::
   *     A function to render a glyph into a given bitmap.
   *
   *   raster_done ::
   *     The raster destructor.
    }
type
  PFT_Raster_Funcs_ = ^TFT_Raster_Funcs_;
  TFT_Raster_Funcs_ = record
      glyph_format : TFT_Glyph_Format;
      raster_new : TFT_Raster_NewFunc;
      raster_reset : TFT_Raster_ResetFunc;
      raster_set_mode : TFT_Raster_SetModeFunc;
      raster_render : TFT_Raster_RenderFunc;
      raster_done : TFT_Raster_DoneFunc;
    end;
  TFT_Raster_Funcs = TFT_Raster_Funcs_;
  PFT_Raster_Funcs = ^TFT_Raster_Funcs;
{  }

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_CURVE_TAG(flag : longint) : longint;
begin
  FT_CURVE_TAG:=flag and $03;
end;


end.
