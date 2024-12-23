unit t1types;

interface

uses
  t1tables,ftsystem, fttypes, fthash,ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{**                                                                   ** }
{**                                                                   ** }
{**              REQUIRED TYPE1/TYPE2 TABLES DEFINITIONS              ** }
{**                                                                   ** }
{**                                                                   ** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{*************************************************************************
   *
   * @struct:
   *   T1_EncodingRec
   *
   * @description:
   *   A structure modeling a custom encoding.
   *
   * @fields:
   *   num_chars ::
   *     The number of character codes in the encoding.  Usually 256.
   *
   *   code_first ::
   *     The lowest valid character code in the encoding.
   *
   *   code_last ::
   *     The highest valid character code in the encoding + 1. When equal to
   *     code_first there are no valid character codes.
   *
   *   char_index ::
   *     An array of corresponding glyph indices.
   *
   *   char_name ::
   *     An array of corresponding glyph names.
    }
(* Const before type ignored *)
type
  PT1_EncodingRecRec_ = ^TT1_EncodingRecRec_;
  TT1_EncodingRecRec_ = record
      num_chars : TFT_Int;
      code_first : TFT_Int;
      code_last : TFT_Int;
      char_index : PFT_UShort;
      char_name : ^PFT_String;
    end;
  TT1_EncodingRec = TT1_EncodingRecRec_;
  PT1_EncodingRec = ^TT1_EncodingRec;
  TT1_Encoding = PT1_EncodingRecRec_;
  PT1_Encoding = ^TT1_Encoding;
{ used to hold extra data of PS_FontInfoRec that
   * cannot be stored in the publicly defined structure.
   *
   * Note these can't be blended with multiple-masters.
    }

  PPS_FontExtraRec_ = ^TPS_FontExtraRec_;
  TPS_FontExtraRec_ = record
      fs_type : TFT_UShort;
    end;
  TPS_FontExtraRec = TPS_FontExtraRec_;
  PPS_FontExtraRec = ^TPS_FontExtraRec;
{ font info dictionary    }
{ font info extra fields  }
{ private dictionary      }
{ top-level dictionary    }
{ array of glyph names        }
{ array of glyph charstrings  }

  PT1_FontRec_ = ^TT1_FontRec_;
  TT1_FontRec_ = record
      font_info : TPS_FontInfoRec;
      font_extra : TPS_FontExtraRec;
      private_dict : TPS_PrivateRec;
      font_name : PFT_String;
      encoding_type : TT1_EncodingType;
      encoding : TT1_EncodingRec;
      subrs_block : PFT_Byte;
      charstrings_block : PFT_Byte;
      glyph_names_block : PFT_Byte;
      num_subrs : TFT_Int;
      subrs : ^PFT_Byte;
      subrs_len : PFT_UInt;
      subrs_hash : TFT_Hash;
      num_glyphs : TFT_Int;
      glyph_names : ^PFT_String;
      charstrings : ^PFT_Byte;
      charstrings_len : PFT_UInt;
      paint_type : TFT_Byte;
      font_type : TFT_Byte;
      font_matrix : TFT_Matrix;
      font_offset : TFT_Vector;
      font_bbox : TFT_BBox;
      font_id : TFT_Long;
      stroke_width : TFT_Fixed;
    end;
  TT1_FontRec = TT1_FontRec_;
  PT1_FontRec = ^TT1_FontRec;
  TT1_Font = PT1_FontRec_;
  PT1_Font = ^TT1_Font;

  PCID_SubrsRec_ = ^TCID_SubrsRec_;
  TCID_SubrsRec_ = record
      num_subrs : TFT_Int;
      code : ^PFT_Byte;
    end;
  TCID_SubrsRec = TCID_SubrsRec_;
  PCID_SubrsRec = ^TCID_SubrsRec;
  TCID_Subrs = PCID_SubrsRec_;
  PCID_Subrs = ^TCID_Subrs;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{**                                                                   ** }
{**                                                                   ** }
{**                AFM FONT INFORMATION STRUCTURES                    ** }
{**                                                                   ** }
{**                                                                   ** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }

  PAFM_TrackKernRec_ = ^TAFM_TrackKernRec_;
  TAFM_TrackKernRec_ = record
      degree : TFT_Int;
      min_ptsize : TFT_Fixed;
      min_kern : TFT_Fixed;
      max_ptsize : TFT_Fixed;
      max_kern : TFT_Fixed;
    end;
  TAFM_TrackKernRec = TAFM_TrackKernRec_;
  PAFM_TrackKernRec = ^TAFM_TrackKernRec;
  TAFM_TrackKern = PAFM_TrackKernRec_;
  PAFM_TrackKern = ^TAFM_TrackKern;

  PAFM_KernPairRec_ = ^TAFM_KernPairRec_;
  TAFM_KernPairRec_ = record
      index1 : TFT_UInt;
      index2 : TFT_UInt;
      x : TFT_Int;
      y : TFT_Int;
    end;
  TAFM_KernPairRec = TAFM_KernPairRec_;
  PAFM_KernPairRec = ^TAFM_KernPairRec;
  TAFM_KernPair = PAFM_KernPairRec_;
  PAFM_KernPair = ^TAFM_KernPair;
{ optional, mind the zero  }
{ optional, mind the zero  }
{ free if non-NULL  }
{ free if non-NULL  }

  PAFM_FontInfoRec_ = ^TAFM_FontInfoRec_;
  TAFM_FontInfoRec_ = record
      IsCIDFont : TFT_Bool;
      FontBBox : TFT_BBox;
      Ascender : TFT_Fixed;
      Descender : TFT_Fixed;
      TrackKerns : TAFM_TrackKern;
      NumTrackKern : TFT_UInt;
      KernPairs : TAFM_KernPair;
      NumKernPair : TFT_UInt;
    end;
  TAFM_FontInfoRec = TAFM_FontInfoRec_;
  PAFM_FontInfoRec = ^TAFM_FontInfoRec;
  TAFM_FontInfo = PAFM_FontInfoRec_;
  PAFM_FontInfo = ^TAFM_FontInfo;
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{**                                                                   ** }
{**                                                                   ** }
{**                ORIGINAL T1_FACE CLASS DEFINITION                  ** }
{**                                                                   ** }
{**                                                                   ** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }

  PT1_Face = ^TT1_Face;
  TT1_Face = ^TT1_FaceRec_;

  PCID_Face = ^TCID_Face;
  TCID_Face = ^TCID_FaceRec_;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
{ support for Multiple Masters fonts  }
{ undocumented, optional: indices of subroutines that express       }
{ the NormalizeDesignVector and the ConvertDesignVector procedure,  }
{ respectively, as Type 2 charstrings; -1 if keywords not present   }
{ undocumented, optional: has the same meaning as len_buildchar  }
{ for Type 2 fonts; manipulated by othersubrs 19, 24, and 25     }
{ since version 2.1 - interface to PostScript hinter  }
(* Const before type ignored *)

  PT1_FaceRec_ = ^TT1_FaceRec_;
  TT1_FaceRec_ = record
//      root : TFT_FaceRec;
      root : Pointer;
      type1 : TT1_FontRec;
      psnames : pointer;
      psaux : pointer;
      afm_data : pointer;
//      charmaprecs : array[0..1] of TFT_CharMapRec;
//      charmaps : array[0..1] of TFT_CharMap;
      charmaprecs : array[0..1] of Pointer;
      charmaps : array[0..1] of Pointer;
      blend : TPS_Blend;
      ndv_idx : TFT_Int;
      cdv_idx : TFT_Int;
      len_buildchar : TFT_UInt;
      buildchar : PFT_Long;
      pshinter : pointer;
    end;
  TT1_FaceRec = TT1_FaceRec_;
  PT1_FaceRec = ^TT1_FaceRec;

  PCID_FaceRec_ = ^TCID_FaceRec_;
  TCID_FaceRec_ = record
//      root : TFT_FaceRec;
      root : Pointer;
      psnames : pointer;
      psaux : pointer;
      cid : TCID_FaceInfoRec;
      font_extra : TPS_FontExtraRec;
      afm_data : pointer;
      subrs : TCID_Subrs;
      pshinter : pointer;
      binary_data : PFT_Byte;
      cid_stream : TFT_Stream;
    end;
  TCID_FaceRec = TCID_FaceRec_;
  PCID_FaceRec = ^TCID_FaceRec;

implementation

end.
