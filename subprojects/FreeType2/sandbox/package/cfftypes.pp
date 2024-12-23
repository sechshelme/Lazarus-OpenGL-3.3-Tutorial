unit cfftypes;

interface

uses
  t1types,t1tables, pshints, integer_types, fttypes,  ftsystem,ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

{*************************************************************************
   *
   * @struct:
   *   CFF_IndexRec
   *
   * @description:
   *   A structure used to model a CFF Index table.
   *
   * @fields:
   *   stream ::
   *     The source input stream.
   *
   *   start ::
   *     The position of the first index byte in the input stream.
   *
   *   count ::
   *     The number of elements in the index.
   *
   *   off_size ::
   *     The size in bytes of object offsets in index.
   *
   *   data_offset ::
   *     The position of first data byte in the index's bytes.
   *
   *   data_size ::
   *     The size of the data table in this index.
   *
   *   offsets ::
   *     A table of element offsets in the index.  Must be loaded explicitly.
   *
   *   bytes ::
   *     If the index is loaded in memory, its bytes.
    }
type
  PCFF_IndexRec_ = ^TCFF_IndexRec_;
  TCFF_IndexRec_ = record
      stream : TFT_Stream;
      start : TFT_ULong;
      hdr_size : TFT_UInt;
      count : TFT_UInt;
      off_size : TFT_Byte;
      data_offset : TFT_ULong;
      data_size : TFT_ULong;
      offsets : PFT_ULong;
      bytes : PFT_Byte;
    end;
  TCFF_IndexRec = TCFF_IndexRec_;
  PCFF_IndexRec = ^TCFF_IndexRec;
  TCFF_Index = PCFF_IndexRec_;
  PCFF_Index = ^TCFF_Index;
{ avoid dynamic allocations  }

  PCFF_EncodingRec_ = ^TCFF_EncodingRec_;
  TCFF_EncodingRec_ = record
      format : TFT_UInt;
      offset : TFT_ULong;
      count : TFT_UInt;
      sids : array[0..255] of TFT_UShort;
      codes : array[0..255] of TFT_UShort;
    end;
  TCFF_EncodingRec = TCFF_EncodingRec_;
  PCFF_EncodingRec = ^TCFF_EncodingRec;
  TCFF_Encoding = PCFF_EncodingRec_;
  PCFF_Encoding = ^TCFF_Encoding;
{ the inverse mapping of `sids'; only needed  }
{ for CID-keyed fonts                         }

  PCFF_CharsetRec_ = ^TCFF_CharsetRec_;
  TCFF_CharsetRec_ = record
      format : TFT_UInt;
      offset : TFT_ULong;
      sids : PFT_UShort;
      cids : PFT_UShort;
      max_cid : TFT_UInt;
      num_glyphs : TFT_UInt;
    end;
  TCFF_CharsetRec = TCFF_CharsetRec_;
  PCFF_CharsetRec = ^TCFF_CharsetRec;
  TCFF_Charset = PCFF_CharsetRec_;
  PCFF_Charset = ^TCFF_Charset;
{ cf. similar fields in file `ttgxvar.h' from the `truetype' module  }
{$if 0}
{ not used; always zero  }
{ not used; always zero  }
{$endif}
{ number of region indexes            }
{ array of `regionIdxCount' indices;  }
{ these index `varRegionList'         }
const
  CFF_MAX_CID_FONTS = 256;
type
  PCFF_VarData_ = ^TCFF_VarData_;
  TCFF_VarData_ = record
      itemCount : TFT_UInt;
      shortDeltaCount : TFT_UInt;
      regionIdxCount : TFT_UInt;
      regionIndices : PFT_UInt;
    end;
  TCFF_VarData = TCFF_VarData_;
  PCFF_VarData = ^TCFF_VarData;
{ contribution of one axis to a region  }
{ zero peak means no effect (factor = 1)  }

  PCFF_AxisCoords_ = ^TCFF_AxisCoords_;
  TCFF_AxisCoords_ = record
      startCoord : TFT_Fixed;
      peakCoord : TFT_Fixed;
      endCoord : TFT_Fixed;
    end;
  TCFF_AxisCoords = TCFF_AxisCoords_;
  PCFF_AxisCoords = ^TCFF_AxisCoords;
{ array of axisCount records  }

  PCFF_VarRegion_ = ^TCFF_VarRegion_;
  TCFF_VarRegion_ = record
      axisList : PCFF_AxisCoords;
    end;
  TCFF_VarRegion = TCFF_VarRegion_;
  PCFF_VarRegion = ^TCFF_VarRegion;
{ array of dataCount records       }
{ vsindex indexes this array       }
{ total number of regions defined  }

  PCFF_VStoreRec_ = ^TCFF_VStoreRec_;
  TCFF_VStoreRec_ = record
      dataCount : TFT_UInt;
      varData : PCFF_VarData;
      axisCount : TFT_UShort;
      regionCount : TFT_UInt;
      varRegionList : PCFF_VarRegion;
    end;
  TCFF_VStoreRec = TCFF_VStoreRec_;
  PCFF_VStoreRec = ^TCFF_VStoreRec;
  TCFF_VStore = PCFF_VStoreRec_;
  PCFF_VStore = ^TCFF_VStore;
{ forward reference  }

{ This object manages one cached blend vector.                   }
{                                                                }
{ There is a BlendRec for Private DICT parsing in each subfont   }
{ and a BlendRec for charstrings in CF2_Font instance data.      }
{ A cached BV may be used across DICTs or Charstrings if inputs  }
{ have not changed.                                              }
{                                                                }
{ `usedBV' is reset at the start of each parse or charstring.    }
{ vsindex cannot be changed after a BV is used.                  }
{                                                                }
{ Note: NDV is long (32/64 bit), while BV is 16.16 (FT_Int32).   }
{ blendV has been built            }
{ blendV has been used             }
{ top level font struct            }
{ last vsindex used                }
{ normDV length (aka numAxes)      }
{ last NDV used                    }
{ BlendV length (aka numMasters)   }
{ current blendV (per DICT/glyph)  }
{ temporarily used as scaling value also  }
{ these should only be used for the top-level font dictionary  }
{ the next fields come from the data of the deprecated           }
{ `MultipleMaster' operator; they are needed to parse the (also  }
{ deprecated) `blend' operator in Type 2 charstrings             }
{ fields for CFF2  }

  PCFF_FontRecDictRec_ = ^TCFF_FontRecDictRec_;
  TCFF_FontRecDictRec_ = record
      version : TFT_UInt;
      notice : TFT_UInt;
      copyright : TFT_UInt;
      full_name : TFT_UInt;
      family_name : TFT_UInt;
      weight : TFT_UInt;
      is_fixed_pitch : TFT_Bool;
      italic_angle : TFT_Fixed;
      underline_position : TFT_Fixed;
      underline_thickness : TFT_Fixed;
      paint_type : TFT_Int;
      charstring_type : TFT_Int;
      font_matrix : TFT_Matrix;
      has_font_matrix : TFT_Bool;
      units_per_em : TFT_ULong;
      font_offset : TFT_Vector;
      unique_id : TFT_ULong;
      font_bbox : TFT_BBox;
      stroke_width : TFT_Pos;
      charset_offset : TFT_ULong;
      encoding_offset : TFT_ULong;
      charstrings_offset : TFT_ULong;
      private_offset : TFT_ULong;
      private_size : TFT_ULong;
      synthetic_base : TFT_Long;
      embedded_postscript : TFT_UInt;
      cid_registry : TFT_UInt;
      cid_ordering : TFT_UInt;
      cid_supplement : TFT_Long;
      cid_font_version : TFT_Long;
      cid_font_revision : TFT_Long;
      cid_font_type : TFT_Long;
      cid_count : TFT_ULong;
      cid_uid_base : TFT_ULong;
      cid_fd_array_offset : TFT_ULong;
      cid_fd_select_offset : TFT_ULong;
      cid_font_name : TFT_UInt;
      num_designs : TFT_UShort;
      num_axes : TFT_UShort;
      vstore_offset : TFT_ULong;
      maxstack : TFT_UInt;
    end;
  TCFF_FontRecDictRec = TCFF_FontRecDictRec_;
  PCFF_FontRecDictRec = ^TCFF_FontRecDictRec;
  TCFF_FontRecDict = PCFF_FontRecDictRec_;
  PCFF_FontRecDict = ^TCFF_FontRecDict;
{ forward reference  }

PCFF_SubFont = ^TCFF_SubFont;
TCFF_SubFont = ^TCFF_SubFontRec_;

{ fields for CFF2  }

  PCFF_PrivateRec_ = ^TCFF_PrivateRec_;
  TCFF_PrivateRec_ = record
      num_blue_values : TFT_Byte;
      num_other_blues : TFT_Byte;
      num_family_blues : TFT_Byte;
      num_family_other_blues : TFT_Byte;
      blue_values : array[0..13] of TFT_Fixed;
      other_blues : array[0..9] of TFT_Fixed;
      family_blues : array[0..13] of TFT_Fixed;
      family_other_blues : array[0..9] of TFT_Fixed;
      blue_scale : TFT_Fixed;
      blue_shift : TFT_Pos;
      blue_fuzz : TFT_Pos;
      standard_width : TFT_Pos;
      standard_height : TFT_Pos;
      num_snap_widths : TFT_Byte;
      num_snap_heights : TFT_Byte;
      snap_widths : array[0..12] of TFT_Pos;
      snap_heights : array[0..12] of TFT_Pos;
      force_bold : TFT_Bool;
      force_bold_threshold : TFT_Fixed;
      lenIV : TFT_Int;
      language_group : TFT_Int;
      expansion_factor : TFT_Fixed;
      initial_random_seed : TFT_Long;
      local_subrs_offset : TFT_ULong;
      default_width : TFT_Pos;
      nominal_width : TFT_Pos;
      vsindex : TFT_UInt;
      subfont : TCFF_SubFont;
    end;
  TCFF_PrivateRec = TCFF_PrivateRec_;
  PCFF_PrivateRec = ^TCFF_PrivateRec;
  TCFF_Private = PCFF_PrivateRec_;
  PCFF_Private = ^TCFF_Private;
{ that's the table, taken from the file `as is'  }
{ small cache for format 3 only  }

  PCFF_FDSelectRec_ = ^TCFF_FDSelectRec_;
  TCFF_FDSelectRec_ = record
      format : TFT_Byte;
      range_count : TFT_UInt;
      data : PFT_Byte;
      data_size : TFT_UInt;
      cache_first : TFT_UInt;
      cache_count : TFT_UInt;
      cache_fd : TFT_Byte;
    end;
  TCFF_FDSelectRec = TCFF_FDSelectRec_;
  PCFF_FDSelectRec = ^TCFF_FDSelectRec;
  TCFF_FDSelect = PCFF_FDSelectRec_;
  PCFF_FDSelect = ^TCFF_FDSelect;
{ A SubFont packs a font dict and a private dict together.  They are  }
{ needed to support CID-keyed CFF fonts.                              }
{ fields for CFF2  }
{ current blend vector        }
{ current length NDV or zero  }
{ ptr to current NDV or NULL  }
{ `blend_stack' is a writable buffer to hold blend results.           }
{ This buffer is to the side of the normal cff parser stack;          }
{ `cff_parse_blend' and `cff_blend_doBlend' push blend results here.  }
{ The normal stack then points to these values instead of the DICT    }
{ because all other operators in Private DICT clear the stack.        }
{ `blend_stack' could be cleared at each operator other than blend.   }
{ Blended values are stored as 5-byte fixed-point values.             }
{ base of stack allocation      }
{ first empty slot              }
{ number of bytes in use        }
{ number of bytes allocated     }
{ array of pointers            }
{ into Local Subrs INDEX data  }

PCFF_Font = ^TCFF_Font;
TCFF_Font = ^TCFF_FontRec_;

PCFF_BlendRec_ = ^TCFF_BlendRec_;
TCFF_BlendRec_ = record
    builtBV : TFT_Bool;
    usedBV : TFT_Bool;
    font : TCFF_Font;
    lastVsindex : TFT_UInt;
    lenNDV : TFT_UInt;
    lastNDV : PFT_Fixed;
    lenBV : TFT_UInt;
    BV : PFT_Int32;
  end;

TCFF_BlendRec = TCFF_BlendRec_;
PCFF_BlendRec = ^TCFF_BlendRec;


  PCFF_SubFontRec_ = ^TCFF_SubFontRec_;
  TCFF_SubFontRec_ = record
      font_dict : TCFF_FontRecDictRec;
      private_dict : TCFF_PrivateRec;
      blend : TCFF_BlendRec;
      lenNDV : TFT_UInt;
      NDV : PFT_Fixed;
      blend_stack : PFT_Byte;
      blend_top : PFT_Byte;
      blend_used : TFT_UInt;
      blend_alloc : TFT_UInt;
      local_subrs_index : TCFF_IndexRec;
      local_subrs : ^PFT_Byte;
      random : TFT_UInt32;
    end;
  TCFF_SubFontRec = TCFF_SubFontRec_;
  PCFF_SubFontRec = ^TCFF_SubFontRec;

{ TODO: take this from stream->memory?  }
{ offset to start of CFF  }
{ cff2 only  }
{ array of pointers into Global Subrs INDEX data  }
{ array of pointers into String INDEX data stored at string_pool  }
{ interface to PostScript hinter  }
{ interface to Postscript Names service  }
{ interface to CFFLoad service  }
(* Const before type ignored *)
{ since version 2.3.0  }
{ font info dictionary  }
{ since version 2.3.6  }
{ since version 2.4.12  }
{ since version 2.7.1  }
{ parsed vstore structure  }
{ since version 2.9  }


  PCFF_FontRec_ = ^TCFF_FontRec_;
  TCFF_FontRec_ = record
//      library_ : TFT_Library;
      library_ : Pointer;
      stream : TFT_Stream;
      memory : TFT_Memory;
      base_offset : TFT_ULong;
      num_faces : TFT_UInt;
      num_glyphs : TFT_UInt;
      version_major : TFT_Byte;
      version_minor : TFT_Byte;
      header_size : TFT_Byte;
      top_dict_length : TFT_UInt;
      cff2 : TFT_Bool;
      name_index : TCFF_IndexRec;
      top_dict_index : TCFF_IndexRec;
      global_subrs_index : TCFF_IndexRec;
      encoding : TCFF_EncodingRec;
      charset : TCFF_CharsetRec;
      charstrings_index : TCFF_IndexRec;
      font_dict_index : TCFF_IndexRec;
      private_index : TCFF_IndexRec;
      local_subrs_index : TCFF_IndexRec;
      font_name : PFT_String;
      global_subrs : ^PFT_Byte;
      num_strings : TFT_UInt;
      strings : ^PFT_Byte;
      string_pool : PFT_Byte;
      string_pool_size : TFT_ULong;
      top_font : TCFF_SubFontRec;
      num_subfonts : TFT_UInt;
      subfonts : array[0..(CFF_MAX_CID_FONTS)-1] of TCFF_SubFont;
      fd_select : TCFF_FDSelectRec;
      pshinter : TPSHinter_Service;
//      psnames : TFT_Service_PsCMaps;
      psnames : Pointer;
      cffload : pointer;
      font_info : PPS_FontInfoRec;
      registry : PFT_String;
      ordering : PFT_String;
      cf2_instance : TFT_Generic;
      vstore : TCFF_VStoreRec;
      font_extra : PPS_FontExtraRec;
    end;
  TCFF_FontRec = TCFF_FontRec_;
  PCFF_FontRec = ^TCFF_FontRec;


    TCFF_Blend = PCFF_BlendRec_;
    PCFF_Blend = ^TCFF_Blend;


implementation


end.
