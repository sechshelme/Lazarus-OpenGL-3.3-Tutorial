unit freetype;

interface

uses
  ftobjs,
  integer_types, ftsystem, ftgloadr, fttypes, ftimage;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

  const
  {$IFDEF Linux}
  libfreetype = 'libfreetype';
  {$ENDIF}

  {$IFDEF Windows}
  libfreetype = 'libfreetype-6.dll';
  {$ENDIF}


const
  FT_FACE_FLAG_SCALABLE = 1 shl 0;
  FT_FACE_FLAG_FIXED_SIZES = 1 shl 1;
  FT_FACE_FLAG_FIXED_WIDTH = 1 shl 2;
  FT_FACE_FLAG_SFNT = 1 shl 3;
  FT_FACE_FLAG_HORIZONTAL = 1 shl 4;
  FT_FACE_FLAG_VERTICAL = 1 shl 5;
  FT_FACE_FLAG_KERNING = 1 shl 6;
  FT_FACE_FLAG_FAST_GLYPHS = 1 shl 7;
  FT_FACE_FLAG_MULTIPLE_MASTERS = 1 shl 8;
  FT_FACE_FLAG_GLYPH_NAMES = 1 shl 9;
  FT_FACE_FLAG_EXTERNAL_STREAM = 1 shl 10;
  FT_FACE_FLAG_HINTER = 1 shl 11;
  FT_FACE_FLAG_CID_KEYED = 1 shl 12;
  FT_FACE_FLAG_TRICKY = 1 shl 13;
  FT_FACE_FLAG_COLOR = 1 shl 14;
  FT_FACE_FLAG_VARIATION = 1 shl 15;
  FT_FACE_FLAG_SVG = 1 shl 16;
  FT_FACE_FLAG_SBIX = 1 shl 17;
  FT_FACE_FLAG_SBIX_OVERLAY = 1 shl 18;

function FT_HAS_HORIZONTAL(face: longint): longint;
function FT_HAS_VERTICAL(face: longint): longint;
function FT_HAS_KERNING(face: longint): longint;
function FT_IS_SCALABLE(face: longint): longint;
function FT_IS_SFNT(face: longint): longint;
function FT_IS_FIXED_WIDTH(face: longint): longint;
function FT_HAS_FIXED_SIZES(face: longint): longint;
function FT_HAS_FAST_GLYPHS(face: longint): longint;
function FT_HAS_GLYPH_NAMES(face: longint): longint;
function FT_HAS_MULTIPLE_MASTERS(face: longint): longint;
function FT_IS_NAMED_INSTANCE(face: longint): longint;
function FT_IS_VARIATION(face: longint): longint;
function FT_IS_CID_KEYED(face: longint): longint;
function FT_IS_TRICKY(face: longint): longint;
function FT_HAS_COLOR(face: longint): longint;
function FT_HAS_SVG(face: longint): longint;
function FT_HAS_SBIX(face: longint): longint;
function FT_HAS_SBIX_OVERLAY(face: longint): longint;

const
  FT_OPEN_MEMORY = $1;
  FT_OPEN_STREAM = $2;
  FT_OPEN_PATHNAME = $4;
  FT_OPEN_DRIVER = $8;
  FT_OPEN_PARAMS = $10;

const
  FT_STYLE_FLAG_ITALIC = 1 shl 0;
  FT_STYLE_FLAG_BOLD = 1 shl 1;

  {#define FT_ENC_TAG( value, a, b, c, d )                             \ }
  {          value = ( ( FT_STATIC_BYTE_CAST( FT_UInt32, a ) << 24 ) | \ }
  {                    ( FT_STATIC_BYTE_CAST( FT_UInt32, b ) << 16 ) | \ }
  {                    ( FT_STATIC_BYTE_CAST( FT_UInt32, c ) <<  8 ) | \ }
  {                      FT_STATIC_BYTE_CAST( FT_UInt32, d )         ) }
  {  typedef enum  FT_Encoding_ }
  {    }
  {     FT_ENC_TAG( FT_ENCODING_NONE, 0, 0, 0, 0 ), }
  {     FT_ENC_TAG( FT_ENCODING_MS_SYMBOL, 's', 'y', 'm', 'b' ), }
  {     FT_ENC_TAG( FT_ENCODING_UNICODE,   'u', 'n', 'i', 'c' ), }
  {     FT_ENC_TAG( FT_ENCODING_SJIS,    's', 'j', 'i', 's' ), }
  {     FT_ENC_TAG( FT_ENCODING_PRC,     'g', 'b', ' ', ' ' ), }
  {     FT_ENC_TAG( FT_ENCODING_BIG5,    'b', 'i', 'g', '5' ), }
  {     FT_ENC_TAG( FT_ENCODING_WANSUNG, 'w', 'a', 'n', 's' ), }
  {     FT_ENC_TAG( FT_ENCODING_JOHAB,   'j', 'o', 'h', 'a' ), }
  { for backward compatibility  }
  {     FT_ENCODING_GB2312     = FT_ENCODING_PRC, }
  {     FT_ENCODING_MS_SJIS    = FT_ENCODING_SJIS, }
  {     FT_ENCODING_MS_GB2312  = FT_ENCODING_PRC, }
  {     FT_ENCODING_MS_BIG5    = FT_ENCODING_BIG5, }
  {     FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG, }
  {     FT_ENCODING_MS_JOHAB   = FT_ENCODING_JOHAB, }
  {     FT_ENC_TAG( FT_ENCODING_ADOBE_STANDARD, 'A', 'D', 'O', 'B' ), }
  {     FT_ENC_TAG( FT_ENCODING_ADOBE_EXPERT,   'A', 'D', 'B', 'E' ), }
  {     FT_ENC_TAG( FT_ENCODING_ADOBE_CUSTOM,   'A', 'D', 'B', 'C' ), }
  {     FT_ENC_TAG( FT_ENCODING_ADOBE_LATIN_1,  'l', 'a', 't', '1' ), }
  {     FT_ENC_TAG( FT_ENCODING_OLD_LATIN_2, 'l', 'a', 't', '2' ), }
  {  }
  {     FT_ENC_TAG( FT_ENCODING_APPLE_ROMAN, 'a', 'r', 'm', 'n' ) }
  {    FT_Encoding; }
  { these constants are deprecated; use the corresponding `FT_Encoding`  }
  { values instead                                                       }


type
  PFT_Glyph_Metrics = ^TFT_Glyph_Metrics;

  TFT_Glyph_Metrics = record
    Width: TFT_Pos;
    Height: TFT_Pos;
    horiBearingX: TFT_Pos;
    horiBearingY: TFT_Pos;
    horiAdvance: TFT_Pos;
    vertBearingX: TFT_Pos;
    vertBearingY: TFT_Pos;
    vertAdvance: TFT_Pos;
  end;
  //  TFT_Glyph_Metrics = TFT_Glyph_Metrics_;
  //  PFT_Glyph_Metrics = ^TFT_Glyph_Metrics;

  PFT_Bitmap_Size = ^TFT_Bitmap_Size;

  TFT_Bitmap_Size = record
    Height: TFT_Short;
    Width: TFT_Short;
    size: TFT_Pos;
    x_ppem: TFT_Pos;
    y_ppem: TFT_Pos;
  end;

  PFT_Library = ^TFT_Library;
  TFT_Library = PFT_LibraryRec;

  PFT_Module = ^TFT_Module;
  TFT_Module = PFT_ModuleRec;

  PFT_Driver = ^TFT_Driver;
  TFT_Driver = PFT_DriverRec;

  PFT_Renderer = ^TFT_Renderer;
  TFT_Renderer = PFT_RendererRec;

  PFT_Encoding = ^TFT_Encoding;
  TFT_Encoding = longint;



  TFT_FaceRec = record
    num_faces: TFT_Long;
    face_index: TFT_Long;
    face_flags: TFT_Long;
    style_flags: TFT_Long;
    num_glyphs: TFT_Long;
    family_name: PFT_String;
    style_name: PFT_String;
    num_fixed_sizes: TFT_Int;
    available_sizes: PFT_Bitmap_Size;
    num_charmaps: TFT_Int;
    charmaps: ^TFT_CharMap;
    generic_: TFT_Generic;
    bbox: TFT_BBox;
    units_per_EM: TFT_UShort;
    ascender: TFT_Short;
    descender: TFT_Short;
    Height: TFT_Short;
    max_advance_width: TFT_Short;
    max_advance_height: TFT_Short;
    underline_position: TFT_Short;
    underline_thickness: TFT_Short;
    glyph: ^TFT_GlyphSlotRec;
    size: ^TFT_SizeRec;
    charmap: ^TFT_CharMapRec;
    driver: TFT_Driver;
    memory: TFT_Memory;
    stream: TFT_Stream;
    sizes_list: TFT_ListRec;
    autohint: TFT_Generic;
    extensions: pointer;
    internal: ^TFT_Face_InternalRec;
  end;
  PFT_FaceRec = ^TFT_FaceRec;

  PFT_Face = ^TFT_Face;
  TFT_Face = ^TFT_FaceRec;

  TFT_CharMapRec = record
    face: ^TFT_FaceRec;
    encoding: TFT_Encoding;
    platform_id: TFT_UShort;
    encoding_id: TFT_UShort;
  end;

  PFT_CharMap = ^TFT_CharMap;
  TFT_CharMap = ^TFT_CharMapRec;


  PFT_Face_Internal = ^TFT_Face_Internal;
  TFT_Face_Internal = PFT_Face_InternalRec;

  PFT_Size_Internal = ^TFT_Size_Internal;
  TFT_Size_Internal = PFT_Size_InternalRec;


  TFT_Size_Metrics = record
    x_ppem: TFT_UShort;
    y_ppem: TFT_UShort;
    x_scale: TFT_Fixed;
    y_scale: TFT_Fixed;
    ascender: TFT_Pos;
    descender: TFT_Pos;
    Height: TFT_Pos;
    max_advance: TFT_Pos;
  end;
  PFT_Size_Metrics = ^TFT_Size_Metrics;


  TFT_SizeRec = record
    face: TFT_Face;
    generic_: TFT_Generic;
    metrics: TFT_Size_Metrics;
    internal: TFT_Size_Internal;
  end;
  PFT_SizeRec = ^TFT_SizeRec;

  PFT_Size = ^TFT_Size;
  TFT_Size = ^TFT_SizeRec;


  PFT_SubGlyph = ^TFT_SubGlyph;
  TFT_SubGlyph = ^TFT_SubGlyphRec;

  PFT_Slot_Internal = ^TFT_Slot_Internal;
  TFT_Slot_Internal = PFT_Slot_InternalRec;


  TFT_GlyphSlotRec = record
    library_: TFT_Library;
    face: TFT_Face;
    Next: ^TFT_GlyphSlotRec;
    glyph_index: TFT_UInt;
    generic_: TFT_Generic;
    metrics: TFT_Glyph_Metrics;
    linearHoriAdvance: TFT_Fixed;
    linearVertAdvance: TFT_Fixed;
    advance: TFT_Vector;
    format: TFT_Glyph_Format;
    bitmap: TFT_Bitmap;
    bitmap_left: TFT_Int;
    bitmap_top: TFT_Int;
    outline: TFT_Outline;
    num_subglyphs: TFT_UInt;
    subglyphs: TFT_SubGlyph;
    control_data: pointer;
    control_len: longint;
    lsb_delta: TFT_Pos;
    rsb_delta: TFT_Pos;
    other: pointer;
    internal: TFT_Slot_Internal;
  end;
  PFT_GlyphSlotRec = ^TFT_GlyphSlotRec;

  PFT_GlyphSlot = ^TFT_GlyphSlot;
  TFT_GlyphSlot = ^TFT_GlyphSlotRec;

  TFT_Parameter = record
    tag: TFT_ULong;
    Data: TFT_Pointer;
  end;
  PFT_Parameter = ^TFT_Parameter;

  TFT_Open_Args = record
    flags: TFT_UInt;
    memory_base: PFT_Byte;
    memory_size: TFT_Long;
    pathname: PFT_String;
    stream: TFT_Stream;
    driver: TFT_Module;
    num_params: TFT_Int;
    params: PFT_Parameter;
  end;
  PFT_Open_Args = ^TFT_Open_Args;

function FT_Init_FreeType(alibrary: PFT_Library): TFT_Error; cdecl; external libfreetype;
function FT_Done_FreeType(library_: TFT_Library): TFT_Error; cdecl; external libfreetype;


function FT_New_Face(library_: TFT_Library; filepathname: PChar; face_index: TFT_Long; aface: PFT_Face): TFT_Error; cdecl; external libfreetype;
function FT_New_Memory_Face(library_: TFT_Library; file_base: PFT_Byte; file_size: TFT_Long; face_index: TFT_Long; aface: PFT_Face): TFT_Error; cdecl; external libfreetype;
function FT_Open_Face(library_: TFT_Library; args: PFT_Open_Args; face_index: TFT_Long; aface: PFT_Face): TFT_Error; cdecl; external libfreetype;
function FT_Attach_File(face: TFT_Face; filepathname: PChar): TFT_Error; cdecl; external libfreetype;
function FT_Attach_Stream(face: TFT_Face; parameters: PFT_Open_Args): TFT_Error; cdecl; external libfreetype;
function FT_Reference_Face(face: TFT_Face): TFT_Error; cdecl; external libfreetype;
function FT_Done_Face(face: TFT_Face): TFT_Error; cdecl; external libfreetype;
function FT_Select_Size(face: TFT_Face; strike_index: TFT_Int): TFT_Error; cdecl; external libfreetype;

type
  PFT_Size_Request_Type_ = ^TFT_Size_Request_Type_;
  TFT_Size_Request_Type_ = longint;

const
  FT_SIZE_REQUEST_TYPE_NOMINAL = 0;
  FT_SIZE_REQUEST_TYPE_REAL_DIM = 1;
  FT_SIZE_REQUEST_TYPE_BBOX = 2;
  FT_SIZE_REQUEST_TYPE_CELL = 3;
  FT_SIZE_REQUEST_TYPE_SCALES = 4;
  FT_SIZE_REQUEST_TYPE_MAX = 5;

type
  TFT_Size_Request_Type = TFT_Size_Request_Type_;
  PFT_Size_Request_Type = ^TFT_Size_Request_Type;

type
  PFT_Size_RequestRec_ = ^TFT_Size_RequestRec_;

  TFT_Size_RequestRec_ = record
    _type: TFT_Size_Request_Type;
    Width: TFT_Long;
    Height: TFT_Long;
    horiResolution: TFT_UInt;
    vertResolution: TFT_UInt;
  end;
  TFT_Size_RequestRec = TFT_Size_RequestRec_;
  PFT_Size_RequestRec = ^TFT_Size_RequestRec;

  PFT_Size_Request = ^TFT_Size_Request;
  TFT_Size_Request = PFT_Size_RequestRec_;

function FT_Request_Size(face: TFT_Face; req: TFT_Size_Request): TFT_Error; cdecl; external libfreetype;
function FT_Set_Char_Size(face: TFT_Face; char_width: TFT_F26Dot6; char_height: TFT_F26Dot6; horz_resolution: TFT_UInt; vert_resolution: TFT_UInt): TFT_Error; cdecl; external libfreetype;
function FT_Set_Pixel_Sizes(face: TFT_Face; pixel_width: TFT_UInt; pixel_height: TFT_UInt): TFT_Error; cdecl; external libfreetype;
function FT_Load_Glyph(face: TFT_Face; glyph_index: TFT_UInt; load_flags: TFT_Int32): TFT_Error; cdecl; external libfreetype;
function FT_Load_Char(face: TFT_Face; char_code: TFT_ULong; load_flags: TFT_Int32): TFT_Error; cdecl; external libfreetype;

const
  FT_LOAD_DEFAULT = $0;
  FT_LOAD_NO_SCALE = 1 shl 0;
  FT_LOAD_NO_HINTING = 1 shl 1;
  FT_LOAD_RENDER = 1 shl 2;
  FT_LOAD_NO_BITMAP = 1 shl 3;
  FT_LOAD_VERTICAL_LAYOUT = 1 shl 4;
  FT_LOAD_FORCE_AUTOHINT = 1 shl 5;
  FT_LOAD_CROP_BITMAP = 1 shl 6;
  FT_LOAD_PEDANTIC = 1 shl 7;
  FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH = 1 shl 9;
  FT_LOAD_NO_RECURSE = 1 shl 10;
  FT_LOAD_IGNORE_TRANSFORM = 1 shl 11;
  FT_LOAD_MONOCHROME = 1 shl 12;
  FT_LOAD_LINEAR_DESIGN = 1 shl 13;
  FT_LOAD_SBITS_ONLY = 1 shl 14;
  FT_LOAD_NO_AUTOHINT = 1 shl 15;
  FT_LOAD_COLOR = 1 shl 20;
  FT_LOAD_COMPUTE_METRICS = 1 shl 21;
  FT_LOAD_BITMAP_METRICS_ONLY = 1 shl 22;
  FT_LOAD_NO_SVG = 1 shl 24;
  FT_LOAD_ADVANCE_ONLY = 1 shl 8;
  FT_LOAD_SVG_ONLY = 1 shl 23;

function FT_LOAD_TARGET_(x: longint): longint;
function FT_LOAD_TARGET_NORMAL: longint; { return type might be wrong }
function FT_LOAD_TARGET_LIGHT: longint; { return type might be wrong }
function FT_LOAD_TARGET_MONO: longint; { return type might be wrong }
function FT_LOAD_TARGET_LCD: longint; { return type might be wrong }
function FT_LOAD_TARGET_LCD_V: longint; { return type might be wrong }
function FT_LOAD_TARGET_MODE(x: longint): longint;
procedure FT_Set_Transform(face: TFT_Face; matrix: PFT_Matrix; delta: PFT_Vector); cdecl; external libfreetype;
procedure FT_Get_Transform(face: TFT_Face; matrix: PFT_Matrix; delta: PFT_Vector); cdecl; external libfreetype;

type
  PFT_Render_Mode_ = ^TFT_Render_Mode_;
  TFT_Render_Mode_ = longint;

const
  FT_RENDER_MODE_NORMAL = 0;
  FT_RENDER_MODE_LIGHT = 1;
  FT_RENDER_MODE_MONO = 2;
  FT_RENDER_MODE_LCD = 3;
  FT_RENDER_MODE_LCD_V = 4;
  FT_RENDER_MODE_SDF = 5;
  FT_RENDER_MODE_MAX = 6;

type
  TFT_Render_Mode = TFT_Render_Mode_;
  PFT_Render_Mode = ^TFT_Render_Mode;

function FT_Render_Glyph(slot: TFT_GlyphSlot; render_mode: TFT_Render_Mode): TFT_Error; cdecl; external libfreetype;

type
  PFT_Kerning_Mode_ = ^TFT_Kerning_Mode_;
  TFT_Kerning_Mode_ = longint;

const
  FT_KERNING_DEFAULT = 0;
  FT_KERNING_UNFITTED = 1;
  FT_KERNING_UNSCALED = 2;

type
  TFT_Kerning_Mode = TFT_Kerning_Mode_;
  PFT_Kerning_Mode = ^TFT_Kerning_Mode;

function FT_Get_Kerning(face: TFT_Face; left_glyph: TFT_UInt; right_glyph: TFT_UInt; kern_mode: TFT_UInt; akerning: PFT_Vector): TFT_Error; cdecl; external libfreetype;
function FT_Get_Track_Kerning(face: TFT_Face; point_size: TFT_Fixed; degree: TFT_Int; akerning: PFT_Fixed): TFT_Error; cdecl; external libfreetype;
function FT_Select_Charmap(face: TFT_Face; encoding: TFT_Encoding): TFT_Error; cdecl; external libfreetype;
function FT_Set_Charmap(face: TFT_Face; charmap: TFT_CharMap): TFT_Error; cdecl; external libfreetype;
function FT_Get_Charmap_Index(charmap: TFT_CharMap): TFT_Int; cdecl; external libfreetype;
function FT_Get_Char_Index(face: TFT_Face; charcode: TFT_ULong): TFT_UInt; cdecl; external libfreetype;
function FT_Get_First_Char(face: TFT_Face; agindex: PFT_UInt): TFT_ULong; cdecl; external libfreetype;
function FT_Get_Next_Char(face: TFT_Face; char_code: TFT_ULong; agindex: PFT_UInt): TFT_ULong; cdecl; external libfreetype;
function FT_Face_Properties(face: TFT_Face; num_properties: TFT_UInt; properties: PFT_Parameter): TFT_Error; cdecl; external libfreetype;
function FT_Get_Name_Index(face: TFT_Face; glyph_name: PFT_String): TFT_UInt; cdecl; external libfreetype;
function FT_Get_Glyph_Name(face: TFT_Face; glyph_index: TFT_UInt; buffer: TFT_Pointer; buffer_max: TFT_UInt): TFT_Error; cdecl; external libfreetype;
function FT_Get_Postscript_Name(face: TFT_Face): PChar; cdecl; external libfreetype;

const
  FT_SUBGLYPH_FLAG_ARGS_ARE_WORDS = 1;
  FT_SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES = 2;
  FT_SUBGLYPH_FLAG_ROUND_XY_TO_GRID = 4;
  FT_SUBGLYPH_FLAG_SCALE = 8;
  FT_SUBGLYPH_FLAG_XY_SCALE = $40;
  FT_SUBGLYPH_FLAG_2X2 = $80;
  FT_SUBGLYPH_FLAG_USE_MY_METRICS = $200;

function FT_Get_SubGlyph_Info(glyph: TFT_GlyphSlot; sub_index: TFT_UInt; p_index: PFT_Int; p_flags: PFT_UInt; p_arg1: PFT_Int;
  p_arg2: PFT_Int; p_transform: PFT_Matrix): TFT_Error; cdecl; external libfreetype;

const
  FT_FSTYPE_INSTALLABLE_EMBEDDING = $0000;
  FT_FSTYPE_RESTRICTED_LICENSE_EMBEDDING = $0002;
  FT_FSTYPE_PREVIEW_AND_PRINT_EMBEDDING = $0004;
  FT_FSTYPE_EDITABLE_EMBEDDING = $0008;
  FT_FSTYPE_NO_SUBSETTING = $0100;
  FT_FSTYPE_BITMAP_EMBEDDING_ONLY = $0200;

function FT_Get_FSType_Flags(face: TFT_Face): TFT_UShort; cdecl; external libfreetype;
function FT_Face_GetCharVariantIndex(face: TFT_Face; charcode: TFT_ULong; variantSelector: TFT_ULong): TFT_UInt; cdecl; external libfreetype;
function FT_Face_GetCharVariantIsDefault(face: TFT_Face; charcode: TFT_ULong; variantSelector: TFT_ULong): TFT_Int; cdecl; external libfreetype;
function FT_Face_GetVariantSelectors(face: TFT_Face): PFT_UInt32; cdecl; external libfreetype;
function FT_Face_GetVariantsOfChar(face: TFT_Face; charcode: TFT_ULong): PFT_UInt32; cdecl; external libfreetype;
function FT_Face_GetCharsOfVariant(face: TFT_Face; variantSelector: TFT_ULong): PFT_UInt32; cdecl; external libfreetype;
function FT_MulDiv(a: TFT_Long; b: TFT_Long; c: TFT_Long): TFT_Long; cdecl; external libfreetype;
function FT_MulFix(a: TFT_Long; b: TFT_Long): TFT_Long; cdecl; external libfreetype;
function FT_DivFix(a: TFT_Long; b: TFT_Long): TFT_Long; cdecl; external libfreetype;
function FT_RoundFix(a: TFT_Fixed): TFT_Fixed; cdecl; external libfreetype;
function FT_CeilFix(a: TFT_Fixed): TFT_Fixed; cdecl; external libfreetype;
function FT_FloorFix(a: TFT_Fixed): TFT_Fixed; cdecl; external libfreetype;
procedure FT_Vector_Transform(vector: PFT_Vector; matrix: PFT_Matrix); cdecl; external libfreetype;

const
  FREETYPE_MAJOR = 2;
  FREETYPE_MINOR = 13;
  FREETYPE_PATCH = 2;

procedure FT_Library_Version(_library: TFT_Library; amajor: PFT_Int; aminor: PFT_Int; apatch: PFT_Int); cdecl; external libfreetype;
function FT_Face_CheckTrueTypePatents(face: TFT_Face): TFT_Bool; cdecl; external libfreetype;
function FT_Face_SetUnpatentedHinting(face: TFT_Face; Value: TFT_Bool): TFT_Bool; cdecl; external libfreetype;

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_HORIZONTAL(face: longint): longint;
begin
  //  FT_HAS_HORIZONTAL:= not ( not ((face^.face_flags) and FT_FACE_FLAG_HORIZONTAL));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_VERTICAL(face: longint): longint;
begin
  //  FT_HAS_VERTICAL:= not ( not ((face^.face_flags) and FT_FACE_FLAG_VERTICAL));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_KERNING(face: longint): longint;
begin
  //  FT_HAS_KERNING:= not ( not ((face^.face_flags) and FT_FACE_FLAG_KERNING));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_SCALABLE(face: longint): longint;
begin
  //  FT_IS_SCALABLE:= not ( not ((face^.face_flags) and FT_FACE_FLAG_SCALABLE));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_SFNT(face: longint): longint;
begin
  //  FT_IS_SFNT:= not ( not ((face^.face_flags) and FT_FACE_FLAG_SFNT));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_FIXED_WIDTH(face: longint): longint;
begin
  //  FT_IS_FIXED_WIDTH:= not ( not ((face^.face_flags) and FT_FACE_FLAG_FIXED_WIDTH));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_FIXED_SIZES(face: longint): longint;
begin
  //  FT_HAS_FIXED_SIZES:= not ( not ((face^.face_flags) and FT_FACE_FLAG_FIXED_SIZES));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_FAST_GLYPHS(face: longint): longint;
begin
  FT_HAS_FAST_GLYPHS := 0;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_GLYPH_NAMES(face: longint): longint;
begin
  //  FT_HAS_GLYPH_NAMES:= not ( not ((face^.face_flags) and FT_FACE_FLAG_GLYPH_NAMES));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_MULTIPLE_MASTERS(face: longint): longint;
begin
  //  FT_HAS_MULTIPLE_MASTERS:= not ( not ((face^.face_flags) and FT_FACE_FLAG_MULTIPLE_MASTERS));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_NAMED_INSTANCE(face: longint): longint;
begin
  //  FT_IS_NAMED_INSTANCE:= not ( not ((face^.face_index) and $7FFF0000));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_VARIATION(face: longint): longint;
begin
  //  FT_IS_VARIATION:= not ( not ((face^.face_flags) and FT_FACE_FLAG_VARIATION));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_CID_KEYED(face: longint): longint;
begin
  //  FT_IS_CID_KEYED:= not ( not ((face^.face_flags) and FT_FACE_FLAG_CID_KEYED));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_IS_TRICKY(face: longint): longint;
begin
  //  FT_IS_TRICKY:= not ( not ((face^.face_flags) and FT_FACE_FLAG_TRICKY));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_COLOR(face: longint): longint;
begin
  //  FT_HAS_COLOR:= not ( not ((face^.face_flags) and FT_FACE_FLAG_COLOR));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_SVG(face: longint): longint;
begin
  //  FT_HAS_SVG:= not ( not ((face^.face_flags) and FT_FACE_FLAG_SVG));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_SBIX(face: longint): longint;
begin
  //  FT_HAS_SBIX:= not ( not ((face^.face_flags) and FT_FACE_FLAG_SBIX));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_HAS_SBIX_OVERLAY(face: longint): longint;
begin
  //  FT_HAS_SBIX_OVERLAY:= not ( not ((face^.face_flags) and FT_FACE_FLAG_SBIX_OVERLAY));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_LOAD_TARGET_(x: longint): longint;
begin
  //  FT_LOAD_TARGET_:=(FT_STATIC_CAST(FT_Int32,Tx(@(15)))) shl 16;
end;

{ was #define dname def_expr }
function FT_LOAD_TARGET_NORMAL: longint; { return type might be wrong }
begin
  FT_LOAD_TARGET_NORMAL := FT_LOAD_TARGET_(FT_RENDER_MODE_NORMAL);
end;

{ was #define dname def_expr }
function FT_LOAD_TARGET_LIGHT: longint; { return type might be wrong }
begin
  FT_LOAD_TARGET_LIGHT := FT_LOAD_TARGET_(FT_RENDER_MODE_LIGHT);
end;

{ was #define dname def_expr }
function FT_LOAD_TARGET_MONO: longint; { return type might be wrong }
begin
  FT_LOAD_TARGET_MONO := FT_LOAD_TARGET_(FT_RENDER_MODE_MONO);
end;

{ was #define dname def_expr }
function FT_LOAD_TARGET_LCD: longint; { return type might be wrong }
begin
  FT_LOAD_TARGET_LCD := FT_LOAD_TARGET_(FT_RENDER_MODE_LCD);
end;

{ was #define dname def_expr }
function FT_LOAD_TARGET_LCD_V: longint; { return type might be wrong }
begin
  FT_LOAD_TARGET_LCD_V := FT_LOAD_TARGET_(FT_RENDER_MODE_LCD_V);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function FT_LOAD_TARGET_MODE(x: longint): longint;
begin
  //  FT_LOAD_TARGET_MODE:=FT_STATIC_CAST(FT_Render_Mode,(x shr 16) and 15);
end;


end.
