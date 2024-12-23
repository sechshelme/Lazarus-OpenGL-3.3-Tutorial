unit ftgloadr;

interface

uses
  fttypes,ftsystem, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


type
  PFT_SubGlyphRec_ = ^TFT_SubGlyphRec_;
  TFT_SubGlyphRec_ = record
      index : TFT_Int;
      flags : TFT_UShort;
      arg1 : TFT_Int;
      arg2 : TFT_Int;
      transform : TFT_Matrix;
    end;
  TFT_SubGlyphRec = TFT_SubGlyphRec_;
  PFT_SubGlyphRec = ^TFT_SubGlyphRec;
{ outline                    }
{ extra points table         }
{ second extra points table  }
{ number of subglyphs        }
{ subglyphs                  }

  PFT_GlyphLoadRec_ = ^TFT_GlyphLoadRec_;
  TFT_GlyphLoadRec_ = record
      outline : TFT_Outline;
      extra_points : PFT_Vector;
      extra_points2 : PFT_Vector;
      num_subglyphs : TFT_UInt;
//      subglyphs : TFT_SubGlyph;
      subglyphs : Pointer;
    end;
  TFT_GlyphLoadRec = TFT_GlyphLoadRec_;
  PFT_GlyphLoadRec = ^TFT_GlyphLoadRec;
  TFT_GlyphLoad = PFT_GlyphLoadRec_;
  PFT_GlyphLoad = ^TFT_GlyphLoad;
{ for possible future extension?  }

  PFT_GlyphLoaderRec_ = ^TFT_GlyphLoaderRec_;
  TFT_GlyphLoaderRec_ = record
      memory : TFT_Memory;
      max_points : TFT_UInt;
      max_contours : TFT_UInt;
      max_subglyphs : TFT_UInt;
      use_extra : TFT_Bool;
      base : TFT_GlyphLoadRec;
      current : TFT_GlyphLoadRec;
      other : pointer;
    end;
  TFT_GlyphLoaderRec = TFT_GlyphLoaderRec_;
  PFT_GlyphLoaderRec = ^TFT_GlyphLoaderRec;
  TFT_GlyphLoader = PFT_GlyphLoaderRec_;
  PFT_GlyphLoader = ^TFT_GlyphLoader;
{ create new empty glyph loader  }

function FT_GlyphLoader_New(memory:TFT_Memory; aloader:PFT_GlyphLoader):TFT_Error;cdecl;external;
{ add an extra points table to a glyph loader  }
function FT_GlyphLoader_CreateExtra(loader:TFT_GlyphLoader):TFT_Error;cdecl;external;
{ destroy a glyph loader  }
procedure FT_GlyphLoader_Done(loader:TFT_GlyphLoader);cdecl;external;
{ reset a glyph loader (frees everything int it)  }
procedure FT_GlyphLoader_Reset(loader:TFT_GlyphLoader);cdecl;external;
{ rewind a glyph loader  }
procedure FT_GlyphLoader_Rewind(loader:TFT_GlyphLoader);cdecl;external;
{ check that there is enough space to add `n_points' and `n_contours'  }
{ to the glyph loader                                                  }
function FT_GlyphLoader_CheckPoints(loader:TFT_GlyphLoader; n_points:TFT_UInt; n_contours:TFT_UInt):TFT_Error;cdecl;external;
{
#define FT_GLYPHLOADER_CHECK_P( _loader, _count )       \
  ( (_count) == 0                                    || \
    ( (FT_UInt)(_loader)->base.outline.n_points    +    \
      (FT_UInt)(_loader)->current.outline.n_points +    \
      (FT_UInt)(_count) ) <= (_loader)->max_points   )

#define FT_GLYPHLOADER_CHECK_C( _loader, _count )         \
  ( (_count) == 0                                      || \
    ( (FT_UInt)(_loader)->base.outline.n_contours    +    \
      (FT_UInt)(_loader)->current.outline.n_contours +    \
      (FT_UInt)(_count) ) <= (_loader)->max_contours   )
 }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_GLYPHLOADER_CHECK_POINTS(_loader,_points,_contours : longint) : longint;

{ check that there is enough space to add `n_subs' sub-glyphs to  }
{ a glyph loader                                                  }
function FT_GlyphLoader_CheckSubGlyphs(loader:TFT_GlyphLoader; n_subs:TFT_UInt):TFT_Error;cdecl;external;
{ prepare a glyph loader, i.e. empty the current glyph  }
procedure FT_GlyphLoader_Prepare(loader:TFT_GlyphLoader);cdecl;external;
{ add the current glyph to the base glyph  }
procedure FT_GlyphLoader_Add(loader:TFT_GlyphLoader);cdecl;external;

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_GLYPHLOADER_CHECK_POINTS(_loader,_points,_contours : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
  //if (FT_GLYPHLOADER_CHECK_P(_loader,_points)) and (@(FT_GLYPHLOADER_CHECK_C(_loader,_contours))) then
  //  if_local1:=0
  //else
  //  if_local1:=FT_GlyphLoader_CheckPoints(_loader,TFT_UInt(_points),TFT_UInt(_contours));
  //FT_GLYPHLOADER_CHECK_POINTS:=if_local1;
end;


end.
