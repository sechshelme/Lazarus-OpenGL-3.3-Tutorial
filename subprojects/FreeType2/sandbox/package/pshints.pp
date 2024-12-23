unit pshints;

interface

uses
fttypes, t1tables,  ftsystem,ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****               INTERNAL REPRESENTATION OF GLOBALS              **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
type
  PPSH_GlobalsRec_=Pointer;
  PPSH_Globals = ^TPSH_Globals;
  TPSH_Globals = PPSH_GlobalsRec_;

  TPSH_Globals_NewFunc = function (memory:TFT_Memory; private_dict:PT1_Private; aglobals:PPSH_Globals):TFT_Error;cdecl;

  TPSH_Globals_SetScaleFunc = procedure (globals:TPSH_Globals; x_scale:TFT_Fixed; y_scale:TFT_Fixed; x_delta:TFT_Fixed; y_delta:TFT_Fixed);cdecl;

  TPSH_Globals_DestroyFunc = procedure (globals:TPSH_Globals);cdecl;

  PPSH_Globals_FuncsRec_ = ^TPSH_Globals_FuncsRec_;
  TPSH_Globals_FuncsRec_ = record
      create : TPSH_Globals_NewFunc;
      set_scale : TPSH_Globals_SetScaleFunc;
      destroy : TPSH_Globals_DestroyFunc;
    end;
  TPSH_Globals_FuncsRec = TPSH_Globals_FuncsRec_;
  PPSH_Globals_FuncsRec = ^TPSH_Globals_FuncsRec;
  TPSH_Globals_Funcs = PPSH_Globals_FuncsRec_;
  PPSH_Globals_Funcs = ^TPSH_Globals_Funcs;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                  PUBLIC TYPE 1 HINTS RECORDER                 **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @type:
   *   T1_Hints
   *
   * @description:
   *   This is a handle to an opaque structure used to record glyph hints
   *   from a Type 1 character glyph character string.
   *
   *   The methods used to operate on this object are defined by the
   *   @T1_Hints_FuncsRec structure.  Recording glyph hints is normally
   *   achieved through the following scheme:
   *
   *   - Open a new hint recording session by calling the 'open' method.
   *     This rewinds the recorder and prepare it for new input.
   *
   *   - For each hint found in the glyph charstring, call the corresponding
   *     method ('stem', 'stem3', or 'reset').  Note that these functions do
   *     not return an error code.
   *
   *   - Close the recording session by calling the 'close' method.  It
   *     returns an error code if the hints were invalid or something strange
   *     happened (e.g., memory shortage).
   *
   *   The hints accumulated in the object can later be used by the
   *   PostScript hinter.
   *
    }

    PT1_HintsRec_=Pointer;
  PT1_Hints = ^TT1_Hints;
  TT1_Hints = PT1_HintsRec_;
{*************************************************************************
   *
   * @type:
   *   T1_Hints_Funcs
   *
   * @description:
   *   A pointer to the @T1_Hints_FuncsRec structure that defines the API of
   *   a given @T1_Hints object.
   *
    }
(* Const before type ignored *)

{*************************************************************************
   *
   * @functype:
   *   T1_Hints_OpenFunc
   *
   * @description:
   *   A method of the @T1_Hints class used to prepare it for a new Type 1
   *   hints recording session.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   * @note:
   *   You should always call the @T1_Hints_CloseFunc method in order to
   *   close an opened recording session.
   *
    }

  TT1_Hints_OpenFunc = procedure (hints:TT1_Hints);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T1_Hints_SetStemFunc
   *
   * @description:
   *   A method of the @T1_Hints class used to record a new horizontal or
   *   vertical stem.  This corresponds to the Type 1 'hstem' and 'vstem'
   *   operators.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   *   dimension ::
   *     0 for horizontal stems (hstem), 1 for vertical ones (vstem).
   *
   *   coords ::
   *     Array of 2 coordinates in 16.16 format, used as (position,length)
   *     stem descriptor.
   *
   * @note:
   *   Use vertical coordinates (y) for horizontal stems (dim=0).  Use
   *   horizontal coordinates (x) for vertical stems (dim=1).
   *
   *   'coords[0]' is the absolute stem position (lowest coordinate);
   *   'coords[1]' is the length.
   *
   *   The length can be negative, in which case it must be either -20 or
   *   -21.  It is interpreted as a 'ghost' stem, according to the Type 1
   *   specification.
   *
   *   If the length is -21 (corresponding to a bottom ghost stem), then the
   *   real stem position is 'coords[0]+coords[1]'.
   *
    }

  TT1_Hints_SetStemFunc = procedure (hints:TT1_Hints; dimension:TFT_UInt; coords:PFT_Fixed);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T1_Hints_SetStem3Func
   *
   * @description:
   *   A method of the @T1_Hints class used to record three
   *   counter-controlled horizontal or vertical stems at once.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   *   dimension ::
   *     0 for horizontal stems, 1 for vertical ones.
   *
   *   coords ::
   *     An array of 6 values in 16.16 format, holding 3 (position,length)
   *     pairs for the counter-controlled stems.
   *
   * @note:
   *   Use vertical coordinates (y) for horizontal stems (dim=0).  Use
   *   horizontal coordinates (x) for vertical stems (dim=1).
   *
   *   The lengths cannot be negative (ghost stems are never
   *   counter-controlled).
   *
    }

  TT1_Hints_SetStem3Func = procedure (hints:TT1_Hints; dimension:TFT_UInt; coords:PFT_Fixed);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T1_Hints_ResetFunc
   *
   * @description:
   *   A method of the @T1_Hints class used to reset the stems hints in a
   *   recording session.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   *   end_point ::
   *     The index of the last point in the input glyph in which the
   *     previously defined hints apply.
   *
    }

  TT1_Hints_ResetFunc = procedure (hints:TT1_Hints; end_point:TFT_UInt);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T1_Hints_CloseFunc
   *
   * @description:
   *   A method of the @T1_Hints class used to close a hint recording
   *   session.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   *   end_point ::
   *     The index of the last point in the input glyph.
   *
   * @return:
   *   FreeType error code.  0 means success.
   *
   * @note:
   *   The error code is set to indicate that an error occurred during the
   *   recording session.
   *
    }

  TT1_Hints_CloseFunc = function (hints:TT1_Hints; end_point:TFT_UInt):TFT_Error;cdecl;
{*************************************************************************
   *
   * @functype:
   *   T1_Hints_ApplyFunc
   *
   * @description:
   *   A method of the @T1_Hints class used to apply hints to the
   *   corresponding glyph outline.  Must be called once all hints have been
   *   recorded.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 1 hints recorder.
   *
   *   outline ::
   *     A pointer to the target outline descriptor.
   *
   *   globals ::
   *     The hinter globals for this font.
   *
   *   hint_mode ::
   *     Hinting information.
   *
   * @return:
   *   FreeType error code.  0 means success.
   *
   * @note:
   *   On input, all points within the outline are in font coordinates. On
   *   output, they are in 1/64 of pixels.
   *
   *   The scaling transformation is taken from the 'globals' object which
   *   must correspond to the same font as the glyph.
   *
    }

//    TT1_Hints_ApplyFunc = function (hints:TT1_Hints; outline:PFT_Outline; globals:TPSH_Globals; hint_mode:TFT_Render_Mode):TFT_Error;cdecl;
    TT1_Hints_ApplyFunc = function (hints:TT1_Hints; outline:PFT_Outline; globals:TPSH_Globals; hint_mode:LongInt):TFT_Error;cdecl;
{*************************************************************************
   *
   * @struct:
   *   T1_Hints_FuncsRec
   *
   * @description:
   *   The structure used to provide the API to @T1_Hints objects.
   *
   * @fields:
   *   hints ::
   *     A handle to the T1 Hints recorder.
   *
   *   open ::
   *     The function to open a recording session.
   *
   *   close ::
   *     The function to close a recording session.
   *
   *   stem ::
   *     The function to set a simple stem.
   *
   *   stem3 ::
   *     The function to set counter-controlled stems.
   *
   *   reset ::
   *     The function to reset stem hints.
   *
   *   apply ::
   *     The function to apply the hints to the corresponding glyph outline.
   *
    }

    PT1_Hints_Funcs = ^TT1_Hints_Funcs;
    TT1_Hints_Funcs = ^TT1_Hints_FuncsRec_;

  PT1_Hints_FuncsRec_ = ^TT1_Hints_FuncsRec_;
  TT1_Hints_FuncsRec_ = record
      hints : TT1_Hints;
      open : TT1_Hints_OpenFunc;
      close : TT1_Hints_CloseFunc;
      stem : TT1_Hints_SetStemFunc;
      stem3 : TT1_Hints_SetStem3Func;
      reset : TT1_Hints_ResetFunc;
      apply : TT1_Hints_ApplyFunc;
    end;
  TT1_Hints_FuncsRec = TT1_Hints_FuncsRec_;
  PT1_Hints_FuncsRec = ^TT1_Hints_FuncsRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                  PUBLIC TYPE 2 HINTS RECORDER                 **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @type:
   *   T2_Hints
   *
   * @description:
   *   This is a handle to an opaque structure used to record glyph hints
   *   from a Type 2 character glyph character string.
   *
   *   The methods used to operate on this object are defined by the
   *   @T2_Hints_FuncsRec structure.  Recording glyph hints is normally
   *   achieved through the following scheme:
   *
   *   - Open a new hint recording session by calling the 'open' method.
   *     This rewinds the recorder and prepare it for new input.
   *
   *   - For each hint found in the glyph charstring, call the corresponding
   *     method ('stems', 'hintmask', 'counters').  Note that these functions
   *     do not return an error code.
   *
   *   - Close the recording session by calling the 'close' method.  It
   *     returns an error code if the hints were invalid or something strange
   *     happened (e.g., memory shortage).
   *
   *   The hints accumulated in the object can later be used by the
   *   Postscript hinter.
   *
    }

    PT2_HintsRec_=Pointer;
  PT2_Hints = ^TT2_Hints;
  TT2_Hints = PT2_HintsRec_;
{*************************************************************************
   *
   * @type:
   *   T2_Hints_Funcs
   *
   * @description:
   *   A pointer to the @T2_Hints_FuncsRec structure that defines the API of
   *   a given @T2_Hints object.
   *
    }
(* Const before type ignored *)

{*************************************************************************
   *
   * @functype:
   *   T2_Hints_OpenFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to prepare it for a new Type 2
   *   hints recording session.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   * @note:
   *   You should always call the @T2_Hints_CloseFunc method in order to
   *   close an opened recording session.
   *
    }

  TT2_Hints_OpenFunc = procedure (hints:TT2_Hints);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T2_Hints_StemsFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to set the table of stems in
   *   either the vertical or horizontal dimension.  Equivalent to the
   *   'hstem', 'vstem', 'hstemhm', and 'vstemhm' Type 2 operators.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   *   dimension ::
   *     0 for horizontal stems (hstem), 1 for vertical ones (vstem).
   *
   *   count ::
   *     The number of stems.
   *
   *   coords ::
   *     An array of 'count' (position,length) pairs in 16.16 format.
   *
   * @note:
   *   Use vertical coordinates (y) for horizontal stems (dim=0).  Use
   *   horizontal coordinates (x) for vertical stems (dim=1).
   *
   *   There are '2*count' elements in the 'coords' array.  Each even element
   *   is an absolute position in font units, each odd element is a length in
   *   font units.
   *
   *   A length can be negative, in which case it must be either -20 or -21.
   *   It is interpreted as a 'ghost' stem, according to the Type 1
   *   specification.
   *
    }

  TT2_Hints_StemsFunc = procedure (hints:TT2_Hints; dimension:TFT_UInt; count:TFT_Int; coordinates:PFT_Fixed);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T2_Hints_MaskFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to set a given hintmask (this
   *   corresponds to the 'hintmask' Type 2 operator).
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   *   end_point ::
   *     The glyph index of the last point to which the previously defined or
   *     activated hints apply.
   *
   *   bit_count ::
   *     The number of bits in the hint mask.
   *
   *   bytes ::
   *     An array of bytes modelling the hint mask.
   *
   * @note:
   *   If the hintmask starts the charstring (before any glyph point
   *   definition), the value of `end_point` should be 0.
   *
   *   `bit_count` is the number of meaningful bits in the 'bytes' array; it
   *   must be equal to the total number of hints defined so far (i.e.,
   *   horizontal+verticals).
   *
   *   The 'bytes' array can come directly from the Type 2 charstring and
   *   respects the same format.
   *
    }
(* Const before type ignored *)

  TT2_Hints_MaskFunc = procedure (hints:TT2_Hints; end_point:TFT_UInt; bit_count:TFT_UInt; bytes:PFT_Byte);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T2_Hints_CounterFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to set a given counter mask (this
   *   corresponds to the 'hintmask' Type 2 operator).
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   *   end_point ::
   *     A glyph index of the last point to which the previously defined or
   *     active hints apply.
   *
   *   bit_count ::
   *     The number of bits in the hint mask.
   *
   *   bytes ::
   *     An array of bytes modelling the hint mask.
   *
   * @note:
   *   If the hintmask starts the charstring (before any glyph point
   *   definition), the value of `end_point` should be 0.
   *
   *   `bit_count` is the number of meaningful bits in the 'bytes' array; it
   *   must be equal to the total number of hints defined so far (i.e.,
   *   horizontal+verticals).
   *
   *    The 'bytes' array can come directly from the Type 2 charstring and
   *    respects the same format.
   *
    }
(* Const before type ignored *)

  TT2_Hints_CounterFunc = procedure (hints:TT2_Hints; bit_count:TFT_UInt; bytes:PFT_Byte);cdecl;
{*************************************************************************
   *
   * @functype:
   *   T2_Hints_CloseFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to close a hint recording
   *   session.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   *   end_point ::
   *     The index of the last point in the input glyph.
   *
   * @return:
   *   FreeType error code.  0 means success.
   *
   * @note:
   *   The error code is set to indicate that an error occurred during the
   *   recording session.
   *
    }

  TT2_Hints_CloseFunc = function (hints:TT2_Hints; end_point:TFT_UInt):TFT_Error;cdecl;
{*************************************************************************
   *
   * @functype:
   *   T2_Hints_ApplyFunc
   *
   * @description:
   *   A method of the @T2_Hints class used to apply hints to the
   *   corresponding glyph outline.  Must be called after the 'close' method.
   *
   * @input:
   *   hints ::
   *     A handle to the Type 2 hints recorder.
   *
   *   outline ::
   *     A pointer to the target outline descriptor.
   *
   *   globals ::
   *     The hinter globals for this font.
   *
   *   hint_mode ::
   *     Hinting information.
   *
   * @return:
   *   FreeType error code.  0 means success.
   *
   * @note:
   *   On input, all points within the outline are in font coordinates. On
   *   output, they are in 1/64 of pixels.
   *
   *   The scaling transformation is taken from the 'globals' object which
   *   must correspond to the same font than the glyph.
   *
    }

//    TT2_Hints_ApplyFunc = function (hints:TT2_Hints; outline:PFT_Outline; globals:TPSH_Globals; hint_mode:TFT_Render_Mode):TFT_Error;cdecl;
    TT2_Hints_ApplyFunc = function (hints:TT2_Hints; outline:PFT_Outline; globals:TPSH_Globals; hint_mode:Integer):TFT_Error;cdecl;
{*************************************************************************
   *
   * @struct:
   *   T2_Hints_FuncsRec
   *
   * @description:
   *   The structure used to provide the API to @T2_Hints objects.
   *
   * @fields:
   *   hints ::
   *     A handle to the T2 hints recorder object.
   *
   *   open ::
   *     The function to open a recording session.
   *
   *   close ::
   *     The function to close a recording session.
   *
   *   stems ::
   *     The function to set the dimension's stems table.
   *
   *   hintmask ::
   *     The function to set hint masks.
   *
   *   counter ::
   *     The function to set counter masks.
   *
   *   apply ::
   *     The function to apply the hints on the corresponding glyph outline.
   *
    }

  PT2_Hints_Funcs = ^TT2_Hints_Funcs;
  TT2_Hints_Funcs = ^TT2_Hints_FuncsRec_;


  PT2_Hints_FuncsRec_ = ^TT2_Hints_FuncsRec_;
  TT2_Hints_FuncsRec_ = record
      hints : TT2_Hints;
      open : TT2_Hints_OpenFunc;
      close : TT2_Hints_CloseFunc;
      stems : TT2_Hints_StemsFunc;
      hintmask : TT2_Hints_MaskFunc;
      counter : TT2_Hints_CounterFunc;
      apply : TT2_Hints_ApplyFunc;
    end;
  TT2_Hints_FuncsRec = TT2_Hints_FuncsRec_;
  PT2_Hints_FuncsRec = ^TT2_Hints_FuncsRec;
{  }

  PPSHinter_Interface_ = ^TPSHinter_Interface_;
  TPSHinter_Interface_ = record
      get_globals_funcs : function (module:Pointer):TPSH_Globals_Funcs;cdecl;
      get_t1_funcs : function (module:Pointer):TT1_Hints_Funcs;cdecl;
      get_t2_funcs : function (module:Pointer):TT2_Hints_Funcs;cdecl;
//      get_globals_funcs : function (module:TFT_Module):TPSH_Globals_Funcs;cdecl;
//      get_t1_funcs : function (module:TFT_Module):TT1_Hints_Funcs;cdecl;
//      get_t2_funcs : function (module:TFT_Module):TT2_Hints_Funcs;cdecl;
    end;
  TPSHinter_Interface = TPSHinter_Interface_;
  PPSHinter_Interface = ^TPSHinter_Interface;

  PPSHinter_Service = ^TPSHinter_Service;
  TPSHinter_Service = PPSHinter_Interface;
{
#define FT_DEFINE_PSHINTER_INTERFACE(        \
          class_,                            \
          get_globals_funcs_,                \
          get_t1_funcs_,                     \
          get_t2_funcs_ )                    \
  static const PSHinter_Interface  class_ =  \
                                            \
    get_globals_funcs_,                      \
    get_t1_funcs_,                           \
    get_t2_funcs_                            \
  ;
 }

implementation

end.
