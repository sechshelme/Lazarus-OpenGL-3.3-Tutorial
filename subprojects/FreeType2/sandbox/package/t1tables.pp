unit t1tables;

interface

uses
  fttypes, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  PPS_FontInfoRec_ = ^TPS_FontInfoRec_;
  TPS_FontInfoRec_ = record
      version : PFT_String;
      notice : PFT_String;
      full_name : PFT_String;
      family_name : PFT_String;
      weight : PFT_String;
      italic_angle : TFT_Long;
      is_fixed_pitch : TFT_Bool;
      underline_position : TFT_Short;
      underline_thickness : TFT_UShort;
    end;
  TPS_FontInfoRec = TPS_FontInfoRec_;
  PPS_FontInfoRec = ^TPS_FontInfoRec;
{*************************************************************************
   *
   * @struct:
   *   PS_FontInfo
   *
   * @description:
   *   A handle to a @PS_FontInfoRec structure.
    }

  PPS_FontInfo = ^TPS_FontInfo;
  TPS_FontInfo = PPS_FontInfoRec_;
{*************************************************************************
   *
   * @struct:
   *   T1_FontInfo
   *
   * @description:
   *   This type is equivalent to @PS_FontInfoRec.  It is deprecated but kept
   *   to maintain source compatibility between various versions of FreeType.
    }

  PT1_FontInfo = ^TT1_FontInfo;
  TT1_FontInfo = TPS_FontInfoRec;
{*************************************************************************
   *
   * @struct:
   *   PS_PrivateRec
   *
   * @description:
   *   A structure used to model a Type~1 or Type~2 private dictionary.  Note
   *   that for Multiple Master fonts, each instance has its own Private
   *   dictionary.
    }
{ including std width   }
{ including std height  }

  PPS_PrivateRec_ = ^TPS_PrivateRec_;
  TPS_PrivateRec_ = record
      unique_id : TFT_Int;
      lenIV : TFT_Int;
      num_blue_values : TFT_Byte;
      num_other_blues : TFT_Byte;
      num_family_blues : TFT_Byte;
      num_family_other_blues : TFT_Byte;
      blue_values : array[0..13] of TFT_Short;
      other_blues : array[0..9] of TFT_Short;
      family_blues : array[0..13] of TFT_Short;
      family_other_blues : array[0..9] of TFT_Short;
      blue_scale : TFT_Fixed;
      blue_shift : TFT_Int;
      blue_fuzz : TFT_Int;
      standard_width : array[0..0] of TFT_UShort;
      standard_height : array[0..0] of TFT_UShort;
      num_snap_widths : TFT_Byte;
      num_snap_heights : TFT_Byte;
      force_bold : TFT_Bool;
      round_stem_up : TFT_Bool;
      snap_widths : array[0..12] of TFT_Short;
      snap_heights : array[0..12] of TFT_Short;
      expansion_factor : TFT_Fixed;
      language_group : TFT_Long;
      password : TFT_Long;
      min_feature : array[0..1] of TFT_Short;
    end;
  TPS_PrivateRec = TPS_PrivateRec_;
  PPS_PrivateRec = ^TPS_PrivateRec;
{*************************************************************************
   *
   * @struct:
   *   PS_Private
   *
   * @description:
   *   A handle to a @PS_PrivateRec structure.
    }

  PPS_Private = ^TPS_Private;
  TPS_Private = PPS_PrivateRec_;
{*************************************************************************
   *
   * @struct:
   *   T1_Private
   *
   * @description:
   *  This type is equivalent to @PS_PrivateRec.  It is deprecated but kept
   *  to maintain source compatibility between various versions of FreeType.
    }

  PT1_Private = ^TT1_Private;
  TT1_Private = TPS_PrivateRec;
{*************************************************************************
   *
   * @enum:
   *   T1_Blend_Flags
   *
   * @description:
   *   A set of flags used to indicate which fields are present in a given
   *   blend dictionary (font info or private).  Used to support Multiple
   *   Masters fonts.
   *
   * @values:
   *   T1_BLEND_UNDERLINE_POSITION ::
   *   T1_BLEND_UNDERLINE_THICKNESS ::
   *   T1_BLEND_ITALIC_ANGLE ::
   *   T1_BLEND_BLUE_VALUES ::
   *   T1_BLEND_OTHER_BLUES ::
   *   T1_BLEND_STANDARD_WIDTH ::
   *   T1_BLEND_STANDARD_HEIGHT ::
   *   T1_BLEND_STEM_SNAP_WIDTHS ::
   *   T1_BLEND_STEM_SNAP_HEIGHTS ::
   *   T1_BLEND_BLUE_SCALE ::
   *   T1_BLEND_BLUE_SHIFT ::
   *   T1_BLEND_FAMILY_BLUES ::
   *   T1_BLEND_FAMILY_OTHER_BLUES ::
   *   T1_BLEND_FORCE_BOLD ::
    }
{ required fields in a FontInfo blend dictionary  }
{ required fields in a Private blend dictionary  }
{ do not remove  }

  PT1_Blend_Flags_ = ^TT1_Blend_Flags_;
  TT1_Blend_Flags_ =  Longint;
  Const
    T1_BLEND_UNDERLINE_POSITION = 0;
    T1_BLEND_UNDERLINE_THICKNESS = 1;
    T1_BLEND_ITALIC_ANGLE = 2;
    T1_BLEND_BLUE_VALUES = 3;
    T1_BLEND_OTHER_BLUES = 4;
    T1_BLEND_STANDARD_WIDTH = 5;
    T1_BLEND_STANDARD_HEIGHT = 6;
    T1_BLEND_STEM_SNAP_WIDTHS = 7;
    T1_BLEND_STEM_SNAP_HEIGHTS = 8;
    T1_BLEND_BLUE_SCALE = 9;
    T1_BLEND_BLUE_SHIFT = 10;
    T1_BLEND_FAMILY_BLUES = 11;
    T1_BLEND_FAMILY_OTHER_BLUES = 12;
    T1_BLEND_FORCE_BOLD = 13;
    T1_BLEND_MAX = 14;

    type
  TT1_Blend_Flags = TT1_Blend_Flags_;
  PT1_Blend_Flags = ^TT1_Blend_Flags;
{ these constants are deprecated; use the corresponding  }
{ `T1_Blend_Flags` values instead                        }
{  }
const
{ maximum number of Multiple Masters designs, as defined in the spec  }
  T1_MAX_MM_DESIGNS = 16;  
{ maximum number of Multiple Masters axes, as defined in the spec  }
  T1_MAX_MM_AXIS = 4;  
{ maximum number of elements in a design map  }
  T1_MAX_MM_MAP_POINTS = 20;  
{ this structure is used to store the BlendDesignMap entry for an axis  }
type
  PPS_DesignMap_ = ^TPS_DesignMap_;
  TPS_DesignMap_ = record
      num_points : TFT_Byte;
      design_points : PFT_Long;
      blend_points : PFT_Fixed;
    end;
  TPS_DesignMapRec = TPS_DesignMap_;
  PPS_DesignMapRec = ^TPS_DesignMapRec;
  TPS_DesignMap = PPS_DesignMap_;
  PPS_DesignMap = ^TPS_DesignMap;
{ backward compatible definition  }

  PT1_DesignMap = ^TT1_DesignMap;
  TT1_DesignMap = TPS_DesignMapRec;
{ since 2.3.0  }
{ undocumented, optional: the default design instance;    }
{ corresponds to default_weight_vector --                 }
{ num_default_design_vector == 0 means it is not present  }
{ in the font and associated metrics files                }

  PPS_BlendRec_ = ^TPS_BlendRec_;
  TPS_BlendRec_ = record
      num_designs : TFT_UInt;
      num_axis : TFT_UInt;
      axis_names : array[0..(T1_MAX_MM_AXIS)-1] of PFT_String;
      design_pos : array[0..(T1_MAX_MM_DESIGNS)-1] of PFT_Fixed;
      design_map : array[0..(T1_MAX_MM_AXIS)-1] of TPS_DesignMapRec;
      weight_vector : PFT_Fixed;
      default_weight_vector : PFT_Fixed;
      font_infos : array[0..(T1_MAX_MM_DESIGNS+1)-1] of TPS_FontInfo;
      privates : array[0..(T1_MAX_MM_DESIGNS+1)-1] of TPS_Private;
      blend_bitflags : TFT_ULong;
      bboxes : array[0..(T1_MAX_MM_DESIGNS+1)-1] of PFT_BBox;
      default_design_vector : array[0..(T1_MAX_MM_DESIGNS)-1] of TFT_UInt;
      num_default_design_vector : TFT_UInt;
    end;
  TPS_BlendRec = TPS_BlendRec_;
  PPS_BlendRec = ^TPS_BlendRec;
  TPS_Blend = PPS_BlendRec_;
  PPS_Blend = ^TPS_Blend;
{ backward compatible definition  }

  PT1_Blend = ^TT1_Blend;
  TT1_Blend = TPS_BlendRec;
{*************************************************************************
   *
   * @struct:
   *   CID_FaceDictRec
   *
   * @description:
   *   A structure used to represent data in a CID top-level dictionary.  In
   *   most cases, they are part of the font's '/FDArray' array.  Within a
   *   CID font file, such (internal) subfont dictionaries are enclosed by
   *   '%ADOBeginFontDict' and '%ADOEndFontDict' comments.
   *
   *   Note that `CID_FaceDictRec` misses a field for the '/FontName'
   *   keyword, specifying the subfont's name (the top-level font name is
   *   given by the '/CIDFontName' keyword).  This is an oversight, but it
   *   doesn't limit the 'cid' font module's functionality because FreeType
   *   neither needs this entry nor gives access to CID subfonts.
    }
{ this is a duplicate of            }
{ `private_dict->expansion_factor'  }

  PCID_FaceDictRec_ = ^TCID_FaceDictRec_;
  TCID_FaceDictRec_ = record
      private_dict : TPS_PrivateRec;
      len_buildchar : TFT_UInt;
      forcebold_threshold : TFT_Fixed;
      stroke_width : TFT_Pos;
      expansion_factor : TFT_Fixed;
      paint_type : TFT_Byte;
      font_type : TFT_Byte;
      font_matrix : TFT_Matrix;
      font_offset : TFT_Vector;
      num_subrs : TFT_UInt;
      subrmap_offset : TFT_ULong;
      sd_bytes : TFT_UInt;
    end;
  TCID_FaceDictRec = TCID_FaceDictRec_;
  PCID_FaceDictRec = ^TCID_FaceDictRec;
{*************************************************************************
   *
   * @struct:
   *   CID_FaceDict
   *
   * @description:
   *   A handle to a @CID_FaceDictRec structure.
    }

  PCID_FaceDict = ^TCID_FaceDict;
  TCID_FaceDict = PCID_FaceDictRec_;
{*************************************************************************
   *
   * @struct:
   *   CID_FontDict
   *
   * @description:
   *   This type is equivalent to @CID_FaceDictRec.  It is deprecated but
   *   kept to maintain source compatibility between various versions of
   *   FreeType.
    }

  PCID_FontDict = ^TCID_FontDict;
  TCID_FontDict = TCID_FaceDictRec;
{*************************************************************************
   *
   * @struct:
   *   CID_FaceInfoRec
   *
   * @description:
   *   A structure used to represent CID Face information.
    }

  PCID_FaceInfoRec_ = ^TCID_FaceInfoRec_;
  TCID_FaceInfoRec_ = record
      cid_font_name : PFT_String;
      cid_version : TFT_Fixed;
      cid_font_type : TFT_Int;
      registry : PFT_String;
      ordering : PFT_String;
      supplement : TFT_Int;
      font_info : TPS_FontInfoRec;
      font_bbox : TFT_BBox;
      uid_base : TFT_ULong;
      num_xuid : TFT_Int;
      xuid : array[0..15] of TFT_ULong;
      cidmap_offset : TFT_ULong;
      fd_bytes : TFT_UInt;
      gd_bytes : TFT_UInt;
      cid_count : TFT_ULong;
      num_dicts : TFT_UInt;
      font_dicts : TCID_FaceDict;
      data_offset : TFT_ULong;
    end;
  TCID_FaceInfoRec = TCID_FaceInfoRec_;
  PCID_FaceInfoRec = ^TCID_FaceInfoRec;
{*************************************************************************
   *
   * @struct:
   *   CID_FaceInfo
   *
   * @description:
   *   A handle to a @CID_FaceInfoRec structure.
    }

  PCID_FaceInfo = ^TCID_FaceInfo;
  TCID_FaceInfo = PCID_FaceInfoRec_;
{*************************************************************************
   *
   * @struct:
   *   CID_Info
   *
   * @description:
   *  This type is equivalent to @CID_FaceInfoRec.  It is deprecated but kept
   *  to maintain source compatibility between various versions of FreeType.
    }

  PCID_Info = ^TCID_Info;
  TCID_Info = TCID_FaceInfoRec;
{*************************************************************************
   *
   * @function:
   *   FT_Has_PS_Glyph_Names
   *
   * @description:
   *   Return true if a given face provides reliable PostScript glyph names.
   *   This is similar to using the @FT_HAS_GLYPH_NAMES macro, except that
   *   certain fonts (mostly TrueType) contain incorrect glyph name tables.
   *
   *   When this function returns true, the caller is sure that the glyph
   *   names returned by @FT_Get_Glyph_Name are reliable.
   *
   * @input:
   *   face ::
   *     face handle
   *
   * @return:
   *   Boolean.  True if glyph names are reliable.
   *
    }

//    function FT_Has_PS_Glyph_Names(face:TFT_Face):TFT_Int;cdecl;external;
    function FT_Has_PS_Glyph_Names(face:Pointer):TFT_Int;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Get_PS_Font_Info
   *
   * @description:
   *   Retrieve the @PS_FontInfoRec structure corresponding to a given
   *   PostScript font.
   *
   * @input:
   *   face ::
   *     PostScript face handle.
   *
   * @output:
   *   afont_info ::
   *     A pointer to a @PS_FontInfoRec object.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   String pointers within the @PS_FontInfoRec structure are owned by the
   *   face and don't need to be freed by the caller.  Missing entries in the
   *   font's FontInfo dictionary are represented by `NULL` pointers.
   *
   *   The following font formats support this feature: 'Type~1', 'Type~42',
   *   'CFF', 'CID~Type~1'.  For other font formats this function returns the
   *   `FT_Err_Invalid_Argument` error code.
   *
   * @example:
   *   ```
   *     PS_FontInfoRec  font_info;
   *
   *
   *     error = FT_Get_PS_Font_Info( face, &font_info );
   *     ...
   *   ```
   *
    }
 //   function FT_Get_PS_Font_Info(face:TFT_Face; afont_info:TPS_FontInfo):TFT_Error;cdecl;external;
    function FT_Get_PS_Font_Info(face:Pointer; afont_info:TPS_FontInfo):TFT_Error;cdecl;external;
{*************************************************************************
   *
   * @function:
   *   FT_Get_PS_Font_Private
   *
   * @description:
   *   Retrieve the @PS_PrivateRec structure corresponding to a given
   *   PostScript font.
   *
   * @input:
   *   face ::
   *     PostScript face handle.
   *
   * @output:
   *   afont_private ::
   *     A pointer to a @PS_PrivateRec object.
   *
   * @return:
   *   FreeType error code.  0~means success.
   *
   * @note:
   *   The string pointers within the @PS_PrivateRec structure are owned by
   *   the face and don't need to be freed by the caller.
   *
   *   Only the 'Type~1' font format supports this feature.  For other font
   *   formats this function returns the `FT_Err_Invalid_Argument` error
   *   code.
   *
   * @example:
   *   ```
   *     PS_PrivateRec  font_private;
   *
   *
   *     error = FT_Get_PS_Font_Private( face, &font_private );
   *     ...
   *   ```
   *
    }
//    function FT_Get_PS_Font_Private(face:TFT_Face; afont_private:TPS_Private):TFT_Error;cdecl;external;
    function FT_Get_PS_Font_Private(face:Pointer; afont_private:TPS_Private):TFT_Error;cdecl;external;
{*************************************************************************
   *
   * @enum:
   *   T1_EncodingType
   *
   * @description:
   *   An enumeration describing the 'Encoding' entry in a Type 1 dictionary.
   *
   * @values:
   *   T1_ENCODING_TYPE_NONE ::
   *   T1_ENCODING_TYPE_ARRAY ::
   *   T1_ENCODING_TYPE_STANDARD ::
   *   T1_ENCODING_TYPE_ISOLATIN1 ::
   *   T1_ENCODING_TYPE_EXPERT ::
   *
   * @since:
   *   2.4.8
    }
type
  PT1_EncodingType_ = ^TT1_EncodingType_;
  TT1_EncodingType_ =  Longint;
  Const
    T1_ENCODING_TYPE_NONE = 0;
    T1_ENCODING_TYPE_ARRAY = 1;
    T1_ENCODING_TYPE_STANDARD = 2;
    T1_ENCODING_TYPE_ISOLATIN1 = 3;
    T1_ENCODING_TYPE_EXPERT = 4;
                                      type
  TT1_EncodingType = TT1_EncodingType_;
  PT1_EncodingType = ^TT1_EncodingType;
{*************************************************************************
   *
   * @enum:
   *   PS_Dict_Keys
   *
   * @description:
   *   An enumeration used in calls to @FT_Get_PS_Font_Value to identify the
   *   Type~1 dictionary entry to retrieve.
   *
   * @values:
   *   PS_DICT_FONT_TYPE ::
   *   PS_DICT_FONT_MATRIX ::
   *   PS_DICT_FONT_BBOX ::
   *   PS_DICT_PAINT_TYPE ::
   *   PS_DICT_FONT_NAME ::
   *   PS_DICT_UNIQUE_ID ::
   *   PS_DICT_NUM_CHAR_STRINGS ::
   *   PS_DICT_CHAR_STRING_KEY ::
   *   PS_DICT_CHAR_STRING ::
   *   PS_DICT_ENCODING_TYPE ::
   *   PS_DICT_ENCODING_ENTRY ::
   *   PS_DICT_NUM_SUBRS ::
   *   PS_DICT_SUBR ::
   *   PS_DICT_STD_HW ::
   *   PS_DICT_STD_VW ::
   *   PS_DICT_NUM_BLUE_VALUES ::
   *   PS_DICT_BLUE_VALUE ::
   *   PS_DICT_BLUE_FUZZ ::
   *   PS_DICT_NUM_OTHER_BLUES ::
   *   PS_DICT_OTHER_BLUE ::
   *   PS_DICT_NUM_FAMILY_BLUES ::
   *   PS_DICT_FAMILY_BLUE ::
   *   PS_DICT_NUM_FAMILY_OTHER_BLUES ::
   *   PS_DICT_FAMILY_OTHER_BLUE ::
   *   PS_DICT_BLUE_SCALE ::
   *   PS_DICT_BLUE_SHIFT ::
   *   PS_DICT_NUM_STEM_SNAP_H ::
   *   PS_DICT_STEM_SNAP_H ::
   *   PS_DICT_NUM_STEM_SNAP_V ::
   *   PS_DICT_STEM_SNAP_V ::
   *   PS_DICT_FORCE_BOLD ::
   *   PS_DICT_RND_STEM_UP ::
   *   PS_DICT_MIN_FEATURE ::
   *   PS_DICT_LEN_IV ::
   *   PS_DICT_PASSWORD ::
   *   PS_DICT_LANGUAGE_GROUP ::
   *   PS_DICT_VERSION ::
   *   PS_DICT_NOTICE ::
   *   PS_DICT_FULL_NAME ::
   *   PS_DICT_FAMILY_NAME ::
   *   PS_DICT_WEIGHT ::
   *   PS_DICT_IS_FIXED_PITCH ::
   *   PS_DICT_UNDERLINE_POSITION ::
   *   PS_DICT_UNDERLINE_THICKNESS ::
   *   PS_DICT_FS_TYPE ::
   *   PS_DICT_ITALIC_ANGLE ::
   *
   * @since:
   *   2.4.8
    }
{ conventionally in the font dictionary  }
{ FT_Byte          }
{ FT_Fixed         }
{ FT_Fixed         }
{ FT_Byte          }
{ FT_String*       }
{ FT_Int           }
{ FT_Int           }
{ FT_String*       }
{ FT_String*       }
{ T1_EncodingType  }
{ FT_String*       }
{ conventionally in the font Private dictionary  }
{ FT_Int      }
{ FT_String*  }
{ FT_UShort   }
{ FT_UShort   }
{ FT_Byte     }
{ FT_Short    }
{ FT_Int      }
{ FT_Byte     }
{ FT_Short    }
{ FT_Byte     }
{ FT_Short    }
{ FT_Byte     }
{ FT_Short    }
{ FT_Fixed    }
{ FT_Int      }
{ FT_Byte     }
{ FT_Short    }
{ FT_Byte     }
{ FT_Short    }
{ FT_Bool     }
{ FT_Bool     }
{ FT_Short    }
{ FT_Int      }
{ FT_Long     }
{ FT_Long     }
{ conventionally in the font FontInfo dictionary  }
{ FT_String*  }
{ FT_String*  }
{ FT_String*  }
{ FT_String*  }
{ FT_String*  }
{ FT_Bool     }
{ FT_Short    }
{ FT_UShort   }
{ FT_UShort   }
{ FT_Long     }
type
  PPS_Dict_Keys_ = ^TPS_Dict_Keys_;
  TPS_Dict_Keys_ =  Longint;
  Const
    PS_DICT_FONT_TYPE = 0;
    PS_DICT_FONT_MATRIX = 1;
    PS_DICT_FONT_BBOX = 2;
    PS_DICT_PAINT_TYPE = 3;
    PS_DICT_FONT_NAME = 4;
    PS_DICT_UNIQUE_ID = 5;
    PS_DICT_NUM_CHAR_STRINGS = 6;
    PS_DICT_CHAR_STRING_KEY = 7;
    PS_DICT_CHAR_STRING = 8;
    PS_DICT_ENCODING_TYPE = 9;
    PS_DICT_ENCODING_ENTRY = 10;
    PS_DICT_NUM_SUBRS = 11;
    PS_DICT_SUBR = 12;
    PS_DICT_STD_HW = 13;
    PS_DICT_STD_VW = 14;
    PS_DICT_NUM_BLUE_VALUES = 15;
    PS_DICT_BLUE_VALUE = 16;
    PS_DICT_BLUE_FUZZ = 17;
    PS_DICT_NUM_OTHER_BLUES = 18;
    PS_DICT_OTHER_BLUE = 19;
    PS_DICT_NUM_FAMILY_BLUES = 20;
    PS_DICT_FAMILY_BLUE = 21;
    PS_DICT_NUM_FAMILY_OTHER_BLUES = 22;
    PS_DICT_FAMILY_OTHER_BLUE = 23;
    PS_DICT_BLUE_SCALE = 24;
    PS_DICT_BLUE_SHIFT = 25;
    PS_DICT_NUM_STEM_SNAP_H = 26;
    PS_DICT_STEM_SNAP_H = 27;
    PS_DICT_NUM_STEM_SNAP_V = 28;
    PS_DICT_STEM_SNAP_V = 29;
    PS_DICT_FORCE_BOLD = 30;
    PS_DICT_RND_STEM_UP = 31;
    PS_DICT_MIN_FEATURE = 32;
    PS_DICT_LEN_IV = 33;
    PS_DICT_PASSWORD = 34;
    PS_DICT_LANGUAGE_GROUP = 35;
    PS_DICT_VERSION = 36;
    PS_DICT_NOTICE = 37;
    PS_DICT_FULL_NAME = 38;
    PS_DICT_FAMILY_NAME = 39;
    PS_DICT_WEIGHT = 40;
    PS_DICT_IS_FIXED_PITCH = 41;
    PS_DICT_UNDERLINE_POSITION = 42;
    PS_DICT_UNDERLINE_THICKNESS = 43;
    PS_DICT_FS_TYPE = 44;
    PS_DICT_ITALIC_ANGLE = 45;
    PS_DICT_MAX = PS_DICT_ITALIC_ANGLE;
                                type
  TPS_Dict_Keys = TPS_Dict_Keys_;
  PPS_Dict_Keys = ^TPS_Dict_Keys;
{*************************************************************************
   *
   * @function:
   *   FT_Get_PS_Font_Value
   *
   * @description:
   *   Retrieve the value for the supplied key from a PostScript font.
   *
   * @input:
   *   face ::
   *     PostScript face handle.
   *
   *   key ::
   *     An enumeration value representing the dictionary key to retrieve.
   *
   *   idx ::
   *     For array values, this specifies the index to be returned.
   *
   *   value ::
   *     A pointer to memory into which to write the value.
   *
   *   valen_len ::
   *     The size, in bytes, of the memory supplied for the value.
   *
   * @output:
   *   value ::
   *     The value matching the above key, if it exists.
   *
   * @return:
   *   The amount of memory (in bytes) required to hold the requested value
   *   (if it exists, -1 otherwise).
   *
   * @note:
   *   The values returned are not pointers into the internal structures of
   *   the face, but are 'fresh' copies, so that the memory containing them
   *   belongs to the calling application.  This also enforces the
   *   'read-only' nature of these values, i.e., this function cannot be
   *   used to manipulate the face.
   *
   *   `value` is a void pointer because the values returned can be of
   *   various types.
   *
   *   If either `value` is `NULL` or `value_len` is too small, just the
   *   required memory size for the requested entry is returned.
   *
   *   The `idx` parameter is used, not only to retrieve elements of, for
   *   example, the FontMatrix or FontBBox, but also to retrieve name keys
   *   from the CharStrings dictionary, and the charstrings themselves.  It
   *   is ignored for atomic values.
   *
   *   `PS_DICT_BLUE_SCALE` returns a value that is scaled up by 1000.  To
   *   get the value as in the font stream, you need to divide by 65536000.0
   *   (to remove the FT_Fixed scale, and the x1000 scale).
   *
   *   IMPORTANT: Only key/value pairs read by the FreeType interpreter can
   *   be retrieved.  So, for example, PostScript procedures such as NP, ND,
   *   and RD are not available.  Arbitrary keys are, obviously, not be
   *   available either.
   *
   *   If the font's format is not PostScript-based, this function returns
   *   the `FT_Err_Invalid_Argument` error code.
   *
   * @since:
   *   2.4.8
   *
    }

    function FT_Get_PS_Font_Value(face:Pointer; key:TPS_Dict_Keys; idx:TFT_UInt; value:pointer; value_len:TFT_Long):TFT_Long;cdecl;external;
//    function FT_Get_PS_Font_Value(face:TFT_Face; key:TPS_Dict_Keys; idx:TFT_UInt; value:pointer; value_len:TFT_Long):TFT_Long;cdecl;external;
{  }

implementation


end.
