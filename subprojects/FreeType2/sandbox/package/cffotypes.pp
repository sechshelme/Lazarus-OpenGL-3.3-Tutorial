unit cffotypes;

interface

uses
cfftypes, pshints,  fttypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  TTT_Face=Pointer;
  PCFF_Face = ^TCFF_Face;
  TCFF_Face = TTT_Face;
{*************************************************************************
   *
   * @type:
   *   CFF_Size
   *
   * @description:
   *   A handle to an OpenType size object.
    }
{ 0xFFFFFFFF to indicate invalid  }

  PCFF_SizeRec_ = ^TCFF_SizeRec_;
  TCFF_SizeRec_ = record
      root : Pointer;
//      root : TFT_SizeRec;
      strike_index : TFT_ULong;
    end;
  TCFF_SizeRec = TCFF_SizeRec_;
  PCFF_SizeRec = ^TCFF_SizeRec;
  TCFF_Size = PCFF_SizeRec_;
  PCFF_Size = ^TCFF_Size;
{*************************************************************************
   *
   * @type:
   *   CFF_GlyphSlot
   *
   * @description:
   *   A handle to an OpenType glyph slot object.
    }

  PCFF_GlyphSlotRec_ = ^TCFF_GlyphSlotRec_;
  TCFF_GlyphSlotRec_ = record
//      root : TFT_GlyphSlotRec;
      root : Pointer;
      hint : TFT_Bool;
      scaled : TFT_Bool;
      x_scale : TFT_Fixed;
      y_scale : TFT_Fixed;
    end;
  TCFF_GlyphSlotRec = TCFF_GlyphSlotRec_;
  PCFF_GlyphSlotRec = ^TCFF_GlyphSlotRec;
  TCFF_GlyphSlot = PCFF_GlyphSlotRec_;
  PCFF_GlyphSlot = ^TCFF_GlyphSlot;
{*************************************************************************
   *
   * @type:
   *   CFF_Internal
   *
   * @description:
   *   The interface to the 'internal' field of `FT_Size`.
    }

  PCFF_InternalRec_ = ^TCFF_InternalRec_;
  TCFF_InternalRec_ = record
      topfont : TPSH_Globals;
      subfonts : array[0..(CFF_MAX_CID_FONTS)-1] of TPSH_Globals;
    end;
  TCFF_InternalRec = TCFF_InternalRec_;
  PCFF_InternalRec = ^TCFF_InternalRec;
  TCFF_Internal = PCFF_InternalRec_;
  PCFF_Internal = ^TCFF_Internal;
{*************************************************************************
   *
   * Subglyph transformation record.
    }
{ transformation matrix coefficients  }
{ offsets                             }

  PCFF_Transform_ = ^TCFF_Transform_;
  TCFF_Transform_ = record
      xx : TFT_Fixed;
      xy : TFT_Fixed;
      yx : TFT_Fixed;
      yy : TFT_Fixed;
      ox : TFT_F26Dot6;
      oy : TFT_F26Dot6;
    end;
  TCFF_Transform = TCFF_Transform_;
  PCFF_Transform = ^TCFF_Transform;

implementation

end.
