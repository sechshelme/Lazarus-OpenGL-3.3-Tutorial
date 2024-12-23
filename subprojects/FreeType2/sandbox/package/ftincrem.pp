unit ftincrem;

interface

uses
  fttypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

{*************************************************************************
   *
   * @section:
   *    incremental
   *
   * @title:
   *    Incremental Loading
   *
   * @abstract:
   *    Custom Glyph Loading.
   *
   * @description:
   *   This section contains various functions used to perform so-called
   *   'incremental' glyph loading.  This is a mode where all glyphs loaded
   *   from a given @FT_Face are provided by the client application.
   *
   *   Apart from that, all other tables are loaded normally from the font
   *   file.  This mode is useful when FreeType is used within another
   *   engine, e.g., a PostScript Imaging Processor.
   *
   *   To enable this mode, you must use @FT_Open_Face, passing an
   *   @FT_Parameter with the @FT_PARAM_TAG_INCREMENTAL tag and an
   *   @FT_Incremental_Interface value.  See the comments for
   *   @FT_Incremental_InterfaceRec for an example.
   *
    }
{*************************************************************************
   *
   * @type:
   *   FT_Incremental
   *
   * @description:
   *   An opaque type describing a user-provided object used to implement
   *   'incremental' glyph loading within FreeType.  This is used to support
   *   embedded fonts in certain environments (e.g., PostScript
   *   interpreters), where the glyph data isn't in the font file, or must be
   *   overridden by different values.
   *
   * @note:
   *   It is up to client applications to create and implement
   *   @FT_Incremental objects, as long as they provide implementations for
   *   the methods @FT_Incremental_GetGlyphDataFunc,
   *   @FT_Incremental_FreeGlyphDataFunc and
   *   @FT_Incremental_GetGlyphMetricsFunc.
   *
   *   See the description of @FT_Incremental_InterfaceRec to understand how
   *   to use incremental objects with FreeType.
   *
    }
type
  PFT_IncrementalRec_=Pointer;
  PFT_Incremental = ^TFT_Incremental;
  TFT_Incremental = PFT_IncrementalRec_;
{*************************************************************************
   *
   * @struct:
   *   FT_Incremental_MetricsRec
   *
   * @description:
   *   A small structure used to contain the basic glyph metrics returned by
   *   the @FT_Incremental_GetGlyphMetricsFunc method.
   *
   * @fields:
   *   bearing_x ::
   *     Left bearing, in font units.
   *
   *   bearing_y ::
   *     Top bearing, in font units.
   *
   *   advance ::
   *     Horizontal component of glyph advance, in font units.
   *
   *   advance_v ::
   *     Vertical component of glyph advance, in font units.
   *
   * @note:
   *   These correspond to horizontal or vertical metrics depending on the
   *   value of the `vertical` argument to the function
   *   @FT_Incremental_GetGlyphMetricsFunc.
   *
    }
{ since 2.3.12  }

  PFT_Incremental_MetricsRec_ = ^TFT_Incremental_MetricsRec_;
  TFT_Incremental_MetricsRec_ = record
      bearing_x : TFT_Long;
      bearing_y : TFT_Long;
      advance : TFT_Long;
      advance_v : TFT_Long;
    end;
  TFT_Incremental_MetricsRec = TFT_Incremental_MetricsRec_;
  PFT_Incremental_MetricsRec = ^TFT_Incremental_MetricsRec;
{*************************************************************************
   *
   * @struct:
   *   FT_Incremental_Metrics
   *
   * @description:
   *   A handle to an @FT_Incremental_MetricsRec structure.
   *
    }

  PFT_Incremental_Metrics = ^TFT_Incremental_Metrics;
  TFT_Incremental_Metrics = PFT_Incremental_MetricsRec_;
{*************************************************************************
   *
   * @type:
   *   FT_Incremental_GetGlyphDataFunc
   *
   * @description:
   *   A function called by FreeType to access a given glyph's data bytes
   *   during @FT_Load_Glyph or @FT_Load_Char if incremental loading is
   *   enabled.
   *
   *   Note that the format of the glyph's data bytes depends on the font
   *   file format.  For TrueType, it must correspond to the raw bytes within
   *   the 'glyf' table.  For PostScript formats, it must correspond to the
   *   **unencrypted** charstring bytes, without any `lenIV` header.  It is
   *   undefined for any other format.
   *
   * @input:
   *   incremental ::
   *     Handle to an opaque @FT_Incremental handle provided by the client
   *     application.
   *
   *   glyph_index ::
   *     Index of relevant glyph.
   *
   * @output:
   *   adata ::
   *     A structure describing the returned glyph data bytes (which will be
   *     accessed as a read-only byte block).
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   If this function returns successfully the method
   *   @FT_Incremental_FreeGlyphDataFunc will be called later to release the
   *   data bytes.
   *
   *   Nested calls to @FT_Incremental_GetGlyphDataFunc can happen for
   *   compound glyphs.
   *
    }

  TFT_Incremental_GetGlyphDataFunc = function (incremental:TFT_Incremental; glyph_index:TFT_UInt; adata:PFT_Data):TFT_Error;cdecl;
{*************************************************************************
   *
   * @type:
   *   FT_Incremental_FreeGlyphDataFunc
   *
   * @description:
   *   A function used to release the glyph data bytes returned by a
   *   successful call to @FT_Incremental_GetGlyphDataFunc.
   *
   * @input:
   *   incremental ::
   *     A handle to an opaque @FT_Incremental handle provided by the client
   *     application.
   *
   *   data ::
   *     A structure describing the glyph data bytes (which will be accessed
   *     as a read-only byte block).
   *
    }

  TFT_Incremental_FreeGlyphDataFunc = procedure (incremental:TFT_Incremental; data:PFT_Data);cdecl;
{*************************************************************************
   *
   * @type:
   *   FT_Incremental_GetGlyphMetricsFunc
   *
   * @description:
   *   A function used to retrieve the basic metrics of a given glyph index
   *   before accessing its data.  This allows for handling font types such
   *   as PCL~XL Format~1, Class~2 downloaded TrueType fonts, where the glyph
   *   metrics (`hmtx` and `vmtx` tables) are permitted to be omitted from
   *   the font, and the relevant metrics included in the header of the glyph
   *   outline data.  Importantly, this is not intended to allow custom glyph
   *   metrics (for example, Postscript Metrics dictionaries), because that
   *   conflicts with the requirements of outline hinting.  Such custom
   *   metrics must be handled separately, by the calling application.
   *
   * @input:
   *   incremental ::
   *     A handle to an opaque @FT_Incremental handle provided by the client
   *     application.
   *
   *   glyph_index ::
   *     Index of relevant glyph.
   *
   *   vertical ::
   *     If true, return vertical metrics.
   *
   *   ametrics ::
   *     This parameter is used for both input and output.  The original
   *     glyph metrics, if any, in font units.  If metrics are not available
   *     all the values must be set to zero.
   *
   * @output:
   *   ametrics ::
   *     The glyph metrics in font units.
   *
    }

  TFT_Incremental_GetGlyphMetricsFunc = function (incremental:TFT_Incremental; glyph_index:TFT_UInt; vertical:TFT_Bool; ametrics:PFT_Incremental_MetricsRec):TFT_Error;cdecl;
{*************************************************************************
   *
   * @struct:
   *   FT_Incremental_FuncsRec
   *
   * @description:
   *   A table of functions for accessing fonts that load data incrementally.
   *   Used in @FT_Incremental_InterfaceRec.
   *
   * @fields:
   *   get_glyph_data ::
   *     The function to get glyph data.  Must not be null.
   *
   *   free_glyph_data ::
   *     The function to release glyph data.  Must not be null.
   *
   *   get_glyph_metrics ::
   *     The function to get glyph metrics.  May be null if the font does not
   *     require it.
   *
    }

  PFT_Incremental_FuncsRec_ = ^TFT_Incremental_FuncsRec_;
  TFT_Incremental_FuncsRec_ = record
      get_glyph_data : TFT_Incremental_GetGlyphDataFunc;
      free_glyph_data : TFT_Incremental_FreeGlyphDataFunc;
      get_glyph_metrics : TFT_Incremental_GetGlyphMetricsFunc;
    end;
  TFT_Incremental_FuncsRec = TFT_Incremental_FuncsRec_;
  PFT_Incremental_FuncsRec = ^TFT_Incremental_FuncsRec;
{*************************************************************************
   *
   * @struct:
   *   FT_Incremental_InterfaceRec
   *
   * @description:
   *   A structure to be used with @FT_Open_Face to indicate that the user
   *   wants to support incremental glyph loading.  You should use it with
   *   @FT_PARAM_TAG_INCREMENTAL as in the following example:
   *
   *   ```
   *     FT_Incremental_InterfaceRec  inc_int;
   *     FT_Parameter                 parameter;
   *     FT_Open_Args                 open_args;
   *
   *
   *     // set up incremental descriptor
   *     inc_int.funcs  = my_funcs;
   *     inc_int.object = my_object;
   *
   *     // set up optional parameter
   *     parameter.tag  = FT_PARAM_TAG_INCREMENTAL;
   *     parameter.data = &inc_int;
   *
   *     // set up FT_Open_Args structure
   *     open_args.flags      = FT_OPEN_PATHNAME | FT_OPEN_PARAMS;
   *     open_args.pathname   = my_font_pathname;
   *     open_args.num_params = 1;
   *     open_args.params     = &parameter; // we use one optional argument
   *
   *     // open the font
   *     error = FT_Open_Face( library, &open_args, index, &face );
   *     ...
   *   ```
   *
    }
(* Const before type ignored *)

  PFT_Incremental_InterfaceRec_ = ^TFT_Incremental_InterfaceRec_;
  TFT_Incremental_InterfaceRec_ = record
      funcs : PFT_Incremental_FuncsRec;
      object_ : TFT_Incremental;
    end;
  TFT_Incremental_InterfaceRec = TFT_Incremental_InterfaceRec_;
  PFT_Incremental_InterfaceRec = ^TFT_Incremental_InterfaceRec;
{*************************************************************************
   *
   * @type:
   *   FT_Incremental_Interface
   *
   * @description:
   *   A pointer to an @FT_Incremental_InterfaceRec structure.
   *
    }

  PFT_Incremental_Interface = ^TFT_Incremental_Interface;
  TFT_Incremental_Interface = PFT_Incremental_InterfaceRec;
{  }
implementation

end.
