unit psaux;

interface

uses
integer_types,t1types, t1tables, cfftypes ,cffotypes, fthash,ftgloadr, ftsystem, fttypes,ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

const
  T1_MAX_SUBRS_CALLS = 8;
  T1_MAX_CHARSTRINGS_OPERANDS = 32;


  const
    CFF_MAX_OPERANDS = 48;
    CFF_MAX_SUBRS_CALLS = 16;
    CFF_MAX_TRANS_ELEMENTS = 32;

type
PT1_TokenType_ = ^TT1_TokenType_;
TT1_TokenType_ =  Longint;
Const
  T1_TOKEN_TYPE_NONE = 0;
  T1_TOKEN_TYPE_ANY = 1;
  T1_TOKEN_TYPE_STRING = 2;
  T1_TOKEN_TYPE_ARRAY = 3;
  T1_TOKEN_TYPE_KEY = 4;
  T1_TOKEN_TYPE_MAX = 5;

  type
TT1_TokenType = TT1_TokenType_;
PT1_TokenType = ^TT1_TokenType;

PT1_FieldType_ = ^TT1_FieldType_;
TT1_FieldType_ =  Longint;
Const
  T1_FIELD_TYPE_NONE = 0;
  T1_FIELD_TYPE_BOOL = 1;
  T1_FIELD_TYPE_INTEGER = 2;
  T1_FIELD_TYPE_FIXED = 3;
  T1_FIELD_TYPE_FIXED_1000 = 4;
  T1_FIELD_TYPE_STRING = 5;
  T1_FIELD_TYPE_KEY = 6;
  T1_FIELD_TYPE_BBOX = 7;
  T1_FIELD_TYPE_MM_BBOX = 8;
  T1_FIELD_TYPE_INTEGER_ARRAY = 9;
  T1_FIELD_TYPE_FIXED_ARRAY = 10;
  T1_FIELD_TYPE_CALLBACK = 11;
  T1_FIELD_TYPE_MAX = 12;
                              type
TT1_FieldType = TT1_FieldType_;
PT1_FieldType = ^TT1_FieldType;
{ do not remove  }
type
PT1_FieldLocation_ = ^TT1_FieldLocation_;
TT1_FieldLocation_ =  Longint;
Const
  T1_FIELD_LOCATION_CID_INFO = 0;
  T1_FIELD_LOCATION_FONT_DICT = 1;
  T1_FIELD_LOCATION_FONT_EXTRA = 2;
  T1_FIELD_LOCATION_FONT_INFO = 3;
  T1_FIELD_LOCATION_PRIVATE = 4;
  T1_FIELD_LOCATION_BBOX = 5;
  T1_FIELD_LOCATION_LOADER = 6;
  T1_FIELD_LOCATION_FACE = 7;
  T1_FIELD_LOCATION_BLEND = 8;
  T1_FIELD_LOCATION_MAX = 9;
type
TT1_FieldLocation = TT1_FieldLocation_;
PT1_FieldLocation = ^TT1_FieldLocation;



type
  PPS_DriverRec_ = ^TPS_DriverRec_;
  TPS_DriverRec_ = record
      root : Pointer;
//      root : TFT_DriverRec;
      hinting_engine : TFT_UInt;
      no_stem_darkening : TFT_Bool;
      darken_params : array[0..7] of TFT_Int;
      random_seed : TFT_Int32;
    end;
  TPS_DriverRec = TPS_DriverRec_;
  PPS_DriverRec = ^TPS_DriverRec;
  TPS_Driver = PPS_DriverRec_;
  PPS_Driver = ^TPS_Driver;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                             T1_TABLE                          **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }

  PPS_Table = ^TPS_Table;
  TPS_Table = ^TPS_TableRec_;
(* Const before type ignored *)

  PPS_Table_Funcs = ^TPS_Table_Funcs;
  TPS_Table_Funcs = ^TPS_Table_FuncsRec_;

  PPS_Table_FuncsRec_ = ^TPS_Table_FuncsRec_;
  TPS_Table_FuncsRec_ = record
      init : function (table:TPS_Table; count:TFT_Int; memory:TFT_Memory):TFT_Error;cdecl;
      done : procedure (table:TPS_Table);cdecl;
      add : function (table:TPS_Table; idx:TFT_Int; object_:pointer; length:TFT_UInt):TFT_Error;cdecl;
      release : procedure (table:TPS_Table);cdecl;
    end;
  TPS_Table_FuncsRec = TPS_Table_FuncsRec_;
  PPS_Table_FuncsRec = ^TPS_Table_FuncsRec;

  PPS_TableRec_ = ^TPS_TableRec_;
  TPS_TableRec_ = record
      block : PFT_Byte;
      cursor : TFT_Offset;
      capacity : TFT_Offset;
      init : TFT_ULong;
      max_elems : TFT_Int;
      elements : ^PFT_Byte;
      lengths : PFT_UInt;
      memory : TFT_Memory;
      funcs : TPS_Table_FuncsRec;
    end;
  TPS_TableRec = TPS_TableRec_;
  PPS_TableRec = ^TPS_TableRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                       T1 FIELDS & TOKENS                      **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }


  PT1_Token = ^TT1_Token;
  TT1_Token = ^TT1_TokenRec_;

{ simple enumeration type used to identify token types  }
{ aka `name'  }
{ do not remove  }

{ a simple structure used to identify tokens  }
{ first character of token in input stream  }
{ first character after the token           }
{ type of token                             }
  PT1_TokenRec_ = ^TT1_TokenRec_;
  TT1_TokenRec_ = record
      start : PFT_Byte;
      limit : PFT_Byte;
      _type : TT1_TokenType;
    end;
  TT1_TokenRec = TT1_TokenRec_;
  PT1_TokenRec = ^TT1_TokenRec;
{ enumeration type used to identify object fields  }
{ do not remove  }

type

//  TT1_Field_ParseFunc = procedure (face:TFT_Face; parser:TFT_Pointer);cdecl;
  TT1_Field_ParseFunc = procedure (face:Pointer; parser:TFT_Pointer);cdecl;
{ structure type used to model object fields  }
{ field identifier length         }
(* Const before type ignored *)
{ field identifier                }
{ type of field                   }
{ offset of field in object       }
{ size of field in bytes          }
{ maximum number of elements for  }
{ array                           }
{ offset of element count for     }
{ arrays; must not be zero if in  }
{ use -- in other words, a        }
{ `num_FOO' element must not      }
{ start the used structure if we  }
{ parse a `FOO' array             }
{ where we expect it              }

PT1_Field = ^TT1_Field;
TT1_Field = ^TT1_FieldRec_;

PT1_FieldRec_ = ^TT1_FieldRec_;
  TT1_FieldRec_ = record
      len : TFT_UInt;
      ident : Pchar;
      location : TT1_FieldLocation;
      _type : TT1_FieldType;
      reader : TT1_Field_ParseFunc;
      offset : TFT_UInt;
      size : TFT_Byte;
      array_max : TFT_UInt;
      count_offset : TFT_UInt;
      dict : TFT_UInt;
    end;
  TT1_FieldRec = TT1_FieldRec_;
  PT1_FieldRec = ^TT1_FieldRec;
{ also FontInfo and FDArray  }

const
  T1_FIELD_DICT_FONTDICT = 1 shl 0;  
  T1_FIELD_DICT_PRIVATE = 1 shl 1;  
{
#define T1_NEW_SIMPLE_FIELD( _ident, _type, _fname, _dict ) \
                                                           \
            sizeof ( _ident ) - 1,                          \
            _ident, T1CODE, _type,                          \
            NULL,                                           \
            FT_FIELD_OFFSET( _fname ),                      \
            FT_FIELD_SIZE( _fname ),                        \
            0, 0,                                           \
            _dict                                           \
          ,

#define T1_NEW_CALLBACK_FIELD( _ident, _reader, _dict ) \
                                                       \
            sizeof ( _ident ) - 1,                      \
            _ident, T1CODE, T1_FIELD_TYPE_CALLBACK,     \
            (T1_Field_ParseFunc)_reader,                \
            0, 0,                                       \
            0, 0,                                       \
            _dict                                       \
          ,

#define T1_NEW_TABLE_FIELD( _ident, _type, _fname, _max, _dict ) \
                                                                \
            sizeof ( _ident ) - 1,                               \
            _ident, T1CODE, _type,                               \
            NULL,                                                \
            FT_FIELD_OFFSET( _fname ),                           \
            FT_FIELD_SIZE_DELTA( _fname ),                       \
            _max,                                                \
            FT_FIELD_OFFSET( num_ ## _fname ),                   \
            _dict                                                \
          ,

#define T1_NEW_TABLE_FIELD2( _ident, _type, _fname, _max, _dict ) \
                                                                 \
            sizeof ( _ident ) - 1,                                \
            _ident, T1CODE, _type,                                \
            NULL,                                                 \
            FT_FIELD_OFFSET( _fname ),                            \
            FT_FIELD_SIZE_DELTA( _fname ),                        \
            _max, 0,                                              \
            _dict                                                 \
          ,

 }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function T1_FIELD_BOOL(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_1000(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_STRING(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_KEY(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_BBOX(_ident,_fname,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM_TABLE(_ident,_fname,_fmax,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_TABLE(_ident,_fname,_fmax,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM_TABLE2(_ident,_fname,_fmax,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_TABLE2(_ident,_fname,_fmax,_dict : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_CALLBACK(_ident,_name,_dict : longint) : longint;

{#define T1_FIELD_ZERO   0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0  }
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                            T1 PARSER                          **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
type
PT1_ParseState_ = ^TT1_ParseState_;
TT1_ParseState_ =  Longint;
Const
  T1_Parse_Start = 0;
  T1_Parse_Have_Width = 1;
  T1_Parse_Have_Moveto = 2;
  T1_Parse_Have_Path = 3;
const
  PS_MAX_OPERANDS = 48;
  PS_MAX_SUBRS_CALLS = 16;

type
  PPS_Parser_Funcs = ^TPS_Parser_Funcs;
  TPS_Parser_Funcs = ^TPS_Parser_FuncsRec_;

PPS_Parser = ^TPS_Parser;
TPS_Parser = ^TPS_ParserRec_;


  PPS_Parser_FuncsRec_ = ^TPS_Parser_FuncsRec_;
  TPS_Parser_FuncsRec_ = record
      init : procedure (parser:TPS_Parser; base:PFT_Byte; limit:PFT_Byte; memory:TFT_Memory);cdecl;
      done : procedure (parser:TPS_Parser);cdecl;
      skip_spaces : procedure (parser:TPS_Parser);cdecl;
      skip_PS_token : procedure (parser:TPS_Parser);cdecl;
      to_int : function (parser:TPS_Parser):TFT_Long;cdecl;
      to_fixed : function (parser:TPS_Parser; power_ten:TFT_Int):TFT_Fixed;cdecl;
      to_bytes : function (parser:TPS_Parser; bytes:PFT_Byte; max_bytes:TFT_Offset; pnum_bytes:PFT_ULong; delimiters:TFT_Bool):TFT_Error;cdecl;
      to_coord_array : function (parser:TPS_Parser; max_coords:TFT_Int; coords:PFT_Short):TFT_Int;cdecl;
      to_fixed_array : function (parser:TPS_Parser; max_values:TFT_Int; values:PFT_Fixed; power_ten:TFT_Int):TFT_Int;cdecl;
      to_token : procedure (parser:TPS_Parser; token:TT1_Token);cdecl;
      to_token_array : procedure (parser:TPS_Parser; tokens:TT1_Token; max_tokens:TFT_UInt; pnum_tokens:PFT_Int);cdecl;
      load_field : function (parser:TPS_Parser; field:TT1_Field; objects:Ppointer; max_objects:TFT_UInt; pflags:PFT_ULong):TFT_Error;cdecl;
      load_field_table : function (parser:TPS_Parser; field:TT1_Field; objects:Ppointer; max_objects:TFT_UInt; pflags:PFT_ULong):TFT_Error;cdecl;
    end;

  TPS_Parser_FuncsRec = TPS_Parser_FuncsRec_;
  PPS_Parser_FuncsRec = ^TPS_Parser_FuncsRec;

  PPS_ParserRec_ = ^TPS_ParserRec_;
  TPS_ParserRec_ = record
    cursor : PFT_Byte;
    base : PFT_Byte;
    limit : PFT_Byte;
    error : TFT_Error;
    memory : TFT_Memory;
    funcs : TPS_Parser_FuncsRec;
  end;
  TPS_ParserRec = TPS_ParserRec_;
  PPS_ParserRec = ^TPS_ParserRec;


  TS_Builder=Pointer;
  PPS_Builder=^TS_Builder;
(* Const before type ignored *)

  PPS_Builder_Funcs = ^TPS_Builder_Funcs;
  TPS_Builder_Funcs = ^TPS_Builder_FuncsRec_;

  PPS_Builder_FuncsRec_ = ^TPS_Builder_FuncsRec_;
  TPS_Builder_FuncsRec_ = record
      init : procedure (ps_builder:PPS_Builder; builder:pointer; is_t1:TFT_Bool);cdecl;
      done : procedure (builder:PPS_Builder);cdecl;
    end;


  TPS_Builder_FuncsRec = TPS_Builder_FuncsRec_;
  PPS_Builder_FuncsRec = ^TPS_Builder_FuncsRec;
  PPS_Builder_ = ^TPS_Builder;
  TPS_Builder = record
      memory : TFT_Memory;
      face : Pointer;
//      face : TFT_Face;
      glyph : TCFF_GlyphSlot;
      loader : TFT_GlyphLoader;
      base : PFT_Outline;
      current : PFT_Outline;
      pos_x : PFT_Pos;
      pos_y : PFT_Pos;
      left_bearing : PFT_Vector;
      advance : PFT_Vector;
      bbox : PFT_BBox;
      path_begun : TFT_Bool;
      load_points : TFT_Bool;
      no_recurse : TFT_Bool;
      metrics_only : TFT_Bool;
      is_t1 : TFT_Bool;
      funcs : TPS_Builder_FuncsRec;
    end;

{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                            PS DECODER                         **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }

  PPS_Decoder_Zone_ = ^TPS_Decoder_Zone_;
  TPS_Decoder_Zone_ = record
      base : PFT_Byte;
      limit : PFT_Byte;
      cursor : PFT_Byte;
    end;
  TPS_Decoder_Zone = TPS_Decoder_Zone_;
  PPS_Decoder_Zone = ^TPS_Decoder_Zone;

  TCFF_Decoder_Get_Glyph_Callback = function (face:TTT_Face; glyph_index:TFT_UInt; pointer:PPFT_Byte; length:PFT_ULong):TFT_Error;cdecl;

  TCFF_Decoder_Free_Glyph_Callback = procedure (face:TTT_Face; pointer:PPFT_Byte; length:TFT_ULong);cdecl;
{ for current glyph_index  }
{ for pure CFF fonts only   }
{ number of glyphs in font  }
{ Type 1 stuff  }
{ for seac  }
{ internal for sub routine calls    }
{ array of subrs length (optional)  }
{ used if `num_subrs' was massaged  }
{ for multiple master support  }

  PPS_Decoder_ = ^TPS_Decoder_;
  TPS_Decoder_ = record
      builder : TPS_Builder;
      stack : array[0..(PS_MAX_OPERANDS+1)-1] of TFT_Fixed;
      top : PFT_Fixed;
      zones : array[0..(PS_MAX_SUBRS_CALLS+1)-1] of TPS_Decoder_Zone;
      zone : PPS_Decoder_Zone;
      flex_state : TFT_Int;
      num_flex_vectors : TFT_Int;
      flex_vectors : array[0..6] of TFT_Vector;
      cff : TCFF_Font;
      current_subfont : TCFF_SubFont;
      cf2_instance : PFT_Generic;
      glyph_width : PFT_Pos;
      width_only : TFT_Bool;
      num_hints : TFT_Int;
      num_locals : TFT_UInt;
      num_globals : TFT_UInt;
      locals_bias : TFT_Int;
      globals_bias : TFT_Int;
      locals : ^PFT_Byte;
      globals : ^PFT_Byte;
      glyph_names : ^PFT_Byte;
      num_glyphs : TFT_UInt;
//      hint_mode : TFT_Render_Mode;
      hint_mode : LongInt;
      seac : TFT_Bool;
      get_glyph_callback : TCFF_Decoder_Get_Glyph_Callback;
      free_glyph_callback : TCFF_Decoder_Free_Glyph_Callback;
//      psnames : TFT_Service_PsCMaps;
      psnames : Pointer;
      lenIV : TFT_Int;
      locals_len : PFT_UInt;
      locals_hash : TFT_Hash;
      font_matrix : TFT_Matrix;
      font_offset : TFT_Vector;
      blend : TPS_Blend;
      buildchar : PFT_Long;
      len_buildchar : TFT_UInt;
    end;
  TPS_Decoder = TPS_Decoder_;
  PPS_Decoder = ^TPS_Decoder;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                         T1 BUILDER                            **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }

TT1_ParseState = TT1_ParseState_;
PT1_ParseState = ^TT1_ParseState;



  PT1_Builder = ^TT1_Builder;
  TT1_Builder = ^TT1_BuilderRec_;

  TT1_Builder_Check_Points_Func = function (builder:TT1_Builder; count:TFT_Int):TFT_Error;cdecl;

  TT1_Builder_Add_Point_Func = procedure (builder:TT1_Builder; x:TFT_Pos; y:TFT_Pos; flag:TFT_Byte);cdecl;

  TT1_Builder_Add_Point1_Func = function (builder:TT1_Builder; x:TFT_Pos; y:TFT_Pos):TFT_Error;cdecl;

  TT1_Builder_Add_Contour_Func = function (builder:TT1_Builder):TFT_Error;cdecl;

  TT1_Builder_Start_Point_Func = function (builder:TT1_Builder; x:TFT_Pos; y:TFT_Pos):TFT_Error;cdecl;

  TT1_Builder_Close_Contour_Func = procedure (builder:TT1_Builder);cdecl;
(* Const before type ignored *)

  PT1_Builder_Funcs = ^TT1_Builder_Funcs;
  TT1_Builder_Funcs = ^TT1_Builder_FuncsRec_;

  PT1_Builder_FuncsRec_ = ^TT1_Builder_FuncsRec_;
  TT1_Builder_FuncsRec_ = record
//      init : procedure (builder:TT1_Builder; face:TFT_Face; size:TFT_Size; slot:TFT_GlyphSlot; hinting:TFT_Bool);cdecl;
      init : procedure (builder:TT1_Builder; face:Pointer; size:Pointer; slot:Pointer; hinting:TFT_Bool);cdecl;
      done : procedure (builder:TT1_Builder);cdecl;
      check_points : TT1_Builder_Check_Points_Func;
      add_point : TT1_Builder_Add_Point_Func;
      add_point1 : TT1_Builder_Add_Point1_Func;
      add_contour : TT1_Builder_Add_Contour_Func;
      start_point : TT1_Builder_Start_Point_Func;
      close_contour : TT1_Builder_Close_Contour_Func;
    end;
  TT1_Builder_FuncsRec = TT1_Builder_FuncsRec_;
  PT1_Builder_FuncsRec = ^TT1_Builder_FuncsRec;



  PT1_BuilderRec_ = ^TT1_BuilderRec_;
  TT1_BuilderRec_ = record
      memory : TFT_Memory;
//      face : TFT_Face;
//      glyph : TFT_GlyphSlot;
      face : Pointer;
      glyph : Pointer;
      loader : TFT_GlyphLoader;
      base : PFT_Outline;
      current : PFT_Outline;
      pos_x : TFT_Pos;
      pos_y : TFT_Pos;
      left_bearing : TFT_Vector;
      advance : TFT_Vector;
      bbox : TFT_BBox;
      parse_state : TT1_ParseState;
      load_points : TFT_Bool;
      no_recurse : TFT_Bool;
      metrics_only : TFT_Bool;
      hints_funcs : pointer;
      hints_globals : pointer;
      funcs : TT1_Builder_FuncsRec;
    end;
  TT1_BuilderRec = TT1_BuilderRec_;
  PT1_BuilderRec = ^TT1_BuilderRec;


  PT1_Decoder_ZoneRec_ = ^TT1_Decoder_ZoneRec_;
  TT1_Decoder_ZoneRec_ = record
      cursor : PFT_Byte;
      base : PFT_Byte;
      limit : PFT_Byte;
    end;
  TT1_Decoder_ZoneRec = TT1_Decoder_ZoneRec_;
  PT1_Decoder_ZoneRec = ^TT1_Decoder_ZoneRec;
  TT1_Decoder_Zone = PT1_Decoder_ZoneRec_;
  PT1_Decoder_Zone = ^TT1_Decoder_Zone;

  PT1_Decoder = ^TT1_Decoder;
  TT1_Decoder = ^TT1_DecoderRec_;

  PT1_Decoder_Funcs = ^TT1_Decoder_Funcs;
  TT1_Decoder_Funcs = ^TT1_Decoder_FuncsRec_;

  TT1_Decoder_Callback = function (decoder:TT1_Decoder; glyph_index:TFT_UInt):TFT_Error;cdecl;

  PT1_Decoder_FuncsRec_ = ^TT1_Decoder_FuncsRec_;
  TT1_Decoder_FuncsRec_ = record
//      init : function (decoder:TT1_Decoder; face:TFT_Face; size:TFT_Size; slot:TFT_GlyphSlot; glyph_names:PPFT_Byte;
//                   blend:TPS_Blend; hinting:TFT_Bool; hint_mode:TFT_Render_Mode; callback:TT1_Decoder_Callback):TFT_Error;cdecl;
      init : function (decoder:TT1_Decoder; face:Pointer; size:Pointer; slot:Pointer; glyph_names:PPFT_Byte;
                   blend:TPS_Blend; hinting:TFT_Bool; hint_mode:Pointer; callback:TT1_Decoder_Callback):TFT_Error;cdecl;
      done : procedure (decoder:TT1_Decoder);cdecl;
      parse_charstrings_old : function (decoder:TT1_Decoder; base:PFT_Byte; len:TFT_UInt):TFT_Error;cdecl;
      parse_metrics : function (decoder:TT1_Decoder; base:PFT_Byte; len:TFT_UInt):TFT_Error;cdecl;
      parse_charstrings : function (decoder:PPS_Decoder; charstring_base:PFT_Byte; charstring_len:TFT_ULong):TFT_Error;cdecl;
    end;
  TT1_Decoder_FuncsRec = TT1_Decoder_FuncsRec_;
  PT1_Decoder_FuncsRec = ^TT1_Decoder_FuncsRec;
{ for seac  }
{ internal for sub routine calls  }
{ array of subrs length (optional)  }
{ used if `num_subrs' was massaged  }
{ for multiple master support  }

  PT1_DecoderRec_ = ^TT1_DecoderRec_;
  TT1_DecoderRec_ = record
      builder : TT1_BuilderRec;
      stack : array[0..(T1_MAX_CHARSTRINGS_OPERANDS)-1] of TFT_Long;
      top : PFT_Long;
      zones : array[0..(T1_MAX_SUBRS_CALLS+1)-1] of TT1_Decoder_ZoneRec;
      zone : TT1_Decoder_Zone;
//      psnames : TFT_Service_PsCMaps;
      psnames : Pointer;
      num_glyphs : TFT_UInt;
      glyph_names : ^PFT_Byte;
      lenIV : TFT_Int;
      num_subrs : TFT_Int;
      subrs : ^PFT_Byte;
      subrs_len : PFT_UInt;
      subrs_hash : TFT_Hash;
      font_matrix : TFT_Matrix;
      font_offset : TFT_Vector;
      flex_state : TFT_Int;
      num_flex_vectors : TFT_Int;
      flex_vectors : array[0..6] of TFT_Vector;
      blend : TPS_Blend;
//      hint_mode : TFT_Render_Mode;
      hint_mode : Pointer;
      parse_callback : TT1_Decoder_Callback;
      funcs : TT1_Decoder_FuncsRec;
      buildchar : PFT_Long;
      len_buildchar : TFT_UInt;
      seac : TFT_Bool;
      cf2_instance : TFT_Generic;
    end;
  TT1_DecoderRec = TT1_DecoderRec_;
  PT1_DecoderRec = ^TT1_DecoderRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                        CFF BUILDER                            **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }

TCFF_Builder_FuncsRec_=Pointer;
PCFF_Builder_Funcs = ^TCFF_Builder_Funcs;
TCFF_Builder_Funcs = ^TCFF_Builder_FuncsRec_;

PCFF_Builder = ^TCFF_Builder;

TCFF_Builder_Check_Points_Func = function (builder:PCFF_Builder; count:TFT_Int):TFT_Error;cdecl;
TCFF_Builder_Add_Point_Func = procedure (builder:PCFF_Builder; x:TFT_Pos; y:TFT_Pos; flag:TFT_Byte);cdecl;
TCFF_Builder_Add_Point1_Func = function (builder:PCFF_Builder; x:TFT_Pos; y:TFT_Pos):TFT_Error;cdecl;
TCFF_Builder_Start_Point_Func = function (builder:PCFF_Builder; x:TFT_Pos; y:TFT_Pos):TFT_Error;cdecl;
TCFF_Builder_Close_Contour_Func = procedure (builder:PCFF_Builder);cdecl;
TCFF_Builder_Add_Contour_Func = function (builder:PCFF_Builder):TFT_Error;cdecl;

PCFF_Builder_FuncsRec_ = ^TCFF_Builder_FuncsRec;
TCFF_Builder_FuncsRec = record
    init : procedure (builder:PCFF_Builder; face:TTT_Face; size:TCFF_Size; glyph:TCFF_GlyphSlot; hinting:TFT_Bool);cdecl;
    done : procedure (builder:PCFF_Builder);cdecl;
    check_points : TCFF_Builder_Check_Points_Func;
    add_point : TCFF_Builder_Add_Point_Func;
    add_point1 : TCFF_Builder_Add_Point1_Func;
    add_contour : TCFF_Builder_Add_Contour_Func;
    start_point : TCFF_Builder_Start_Point_Func;
    close_contour : TCFF_Builder_Close_Contour_Func;
  end;

TCFF_Builder = record
    memory : TFT_Memory;
    face : TTT_Face;
    glyph : TCFF_GlyphSlot;
    loader : TFT_GlyphLoader;
    base : PFT_Outline;
    current : PFT_Outline;
    pos_x : TFT_Pos;
    pos_y : TFT_Pos;
    left_bearing : TFT_Vector;
    advance : TFT_Vector;
    bbox : TFT_BBox;
    path_begun : TFT_Bool;
    load_points : TFT_Bool;
    no_recurse : TFT_Bool;
    metrics_only : TFT_Bool;
    hints_funcs : pointer;
    hints_globals : pointer;
    funcs : TCFF_Builder_FuncsRec;
  end;

PCFF_Builder_FuncsRec = ^TCFF_Builder_FuncsRec;




{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                        CFF DECODER                            **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
  PCFF_Decoder_Zone_ = ^TCFF_Decoder_Zone_;
  TCFF_Decoder_Zone_ = record
      base : PFT_Byte;
      limit : PFT_Byte;
      cursor : PFT_Byte;
    end;
  TCFF_Decoder_Zone = TCFF_Decoder_Zone_;
  PCFF_Decoder_Zone = ^TCFF_Decoder_Zone;
{ for pure CFF fonts only   }
{ number of glyphs in font  }
{ for current glyph_index  }

  PCFF_Decoder_ = ^TCFF_Decoder_;
  TCFF_Decoder_ = record
      builder : TCFF_Builder;
      cff : TCFF_Font;
      stack : array[0..(CFF_MAX_OPERANDS+1)-1] of TFT_Fixed;
      top : PFT_Fixed;
      zones : array[0..(CFF_MAX_SUBRS_CALLS+1)-1] of TCFF_Decoder_Zone;
      zone : PCFF_Decoder_Zone;
      flex_state : TFT_Int;
      num_flex_vectors : TFT_Int;
      flex_vectors : array[0..6] of TFT_Vector;
      glyph_width : TFT_Pos;
      nominal_width : TFT_Pos;
      read_width : TFT_Bool;
      width_only : TFT_Bool;
      num_hints : TFT_Int;
      buildchar : array[0..(CFF_MAX_TRANS_ELEMENTS)-1] of TFT_Fixed;
      num_locals : TFT_UInt;
      num_globals : TFT_UInt;
      locals_bias : TFT_Int;
      globals_bias : TFT_Int;
      locals : ^PFT_Byte;
      globals : ^PFT_Byte;
      glyph_names : ^PFT_Byte;
      num_glyphs : TFT_UInt;
//      hint_mode : TFT_Render_Mode;
      hint_mode : Pointer;
      seac : TFT_Bool;
      current_subfont : TCFF_SubFont;
      get_glyph_callback : TCFF_Decoder_Get_Glyph_Callback;
      free_glyph_callback : TCFF_Decoder_Free_Glyph_Callback;
    end;
  TCFF_Decoder = TCFF_Decoder_;
  PCFF_Decoder = ^TCFF_Decoder;
(* Const before type ignored *)

  PCFF_Decoder_Funcs = ^TCFF_Decoder_Funcs;
  TCFF_Decoder_Funcs = ^TCFF_Decoder_FuncsRec_;

  PCFF_Decoder_FuncsRec_ = ^TCFF_Decoder_FuncsRec_;
  TCFF_Decoder_FuncsRec_ = record
//      init : procedure (decoder:PCFF_Decoder; face:TTT_Face; size:TCFF_Size; slot:TCFF_GlyphSlot; hinting:TFT_Bool;
//                    hint_mode:TFT_Render_Mode; get_callback:TCFF_Decoder_Get_Glyph_Callback; free_callback:TCFF_Decoder_Free_Glyph_Callback);cdecl;
      init : procedure (decoder:PCFF_Decoder; face:TTT_Face; size:TCFF_Size; slot:TCFF_GlyphSlot; hinting:TFT_Bool;
                    hint_mode:Pointer; get_callback:TCFF_Decoder_Get_Glyph_Callback; free_callback:TCFF_Decoder_Free_Glyph_Callback);cdecl;
      prepare : function (decoder:PCFF_Decoder; size:TCFF_Size; glyph_index:TFT_UInt):TFT_Error;cdecl;
      parse_charstrings_old : function (decoder:PCFF_Decoder; charstring_base:PFT_Byte; charstring_len:TFT_ULong; in_dict:TFT_Bool):TFT_Error;cdecl;
      parse_charstrings : function (decoder:PPS_Decoder; charstring_base:PFT_Byte; charstring_len:TFT_ULong):TFT_Error;cdecl;
    end;
  TCFF_Decoder_FuncsRec = TCFF_Decoder_FuncsRec_;
  PCFF_Decoder_FuncsRec = ^TCFF_Decoder_FuncsRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                            AFM PARSER                         **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }

  PAFM_Parser = ^TAFM_Parser;
  TAFM_Parser = ^TAFM_ParserRec_;

  PAFM_Parser_FuncsRec_ = ^TAFM_Parser_FuncsRec_;
  TAFM_Parser_FuncsRec_ = record
      init : function (parser:TAFM_Parser; memory:TFT_Memory; base:PFT_Byte; limit:PFT_Byte):TFT_Error;cdecl;
      done : procedure (parser:TAFM_Parser);cdecl;
      parse : function (parser:TAFM_Parser):TFT_Error;cdecl;
    end;
  TAFM_Parser_FuncsRec = TAFM_Parser_FuncsRec_;
  PAFM_Parser_FuncsRec = ^TAFM_Parser_FuncsRec;

  PAFM_StreamRec_=Pointer;
  PAFM_Stream = ^TAFM_Stream;
  TAFM_Stream = PAFM_StreamRec_;
{*************************************************************************
   *
   * @struct:
   *   AFM_ParserRec
   *
   * @description:
   *   An AFM_Parser is a parser for the AFM files.
   *
   * @fields:
   *   memory ::
   *     The object used for memory operations (alloc and realloc).
   *
   *   stream ::
   *     This is an opaque object.
   *
   *   FontInfo ::
   *     The result will be stored here.
   *
   *   get_index ::
   *     A user provided function to get a glyph index by its name.
    }
(* Const before type ignored *)

  PAFM_ParserRec_ = ^TAFM_ParserRec_;
  TAFM_ParserRec_ = record
      memory : TFT_Memory;
      stream : TAFM_Stream;
      FontInfo : TAFM_FontInfo;
      get_index : function (name:Pchar; len:TFT_Offset; user_data:pointer):TFT_Int;cdecl;
      user_data : pointer;
    end;
  TAFM_ParserRec = TAFM_ParserRec_;
  PAFM_ParserRec = ^TAFM_ParserRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                     TYPE1 CHARMAPS                            **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
(* Const before type ignored *)

  PT1_CMap_Classes = ^TT1_CMap_Classes;
  TT1_CMap_Classes = ^TT1_CMap_ClassesRec_;

  PT1_CMap_ClassesRec_ = ^TT1_CMap_ClassesRec_;
  TT1_CMap_ClassesRec_ = record
      //standard : TFT_CMap_Class;
      //expert : TFT_CMap_Class;
      //custom : TFT_CMap_Class;
      //unicode : TFT_CMap_Class;
      standard : Pointer;
      expert : Pointer;
      custom : Pointer;
      unicode : Pointer;
    end;
  TT1_CMap_ClassesRec = TT1_CMap_ClassesRec_;
  PT1_CMap_ClassesRec = ^TT1_CMap_ClassesRec;

  PPSAux_ServiceRec_ = ^TPSAux_ServiceRec_;
  TPSAux_ServiceRec_ = record
      ps_table_funcs : PPS_Table_FuncsRec;
      ps_parser_funcs : PPS_Parser_FuncsRec;
      t1_builder_funcs : PT1_Builder_FuncsRec;
      t1_decoder_funcs : PT1_Decoder_FuncsRec;
      t1_decrypt : procedure (buffer:PFT_Byte; length:TFT_Offset; seed:TFT_UShort);cdecl;
      cff_random : function (r:TFT_UInt32):TFT_UInt32;cdecl;
      ps_decoder_init : procedure (ps_decoder:PPS_Decoder; decoder:pointer; is_t1:TFT_Bool);cdecl;
//      t1_make_subfont : procedure (face:TFT_Face; priv:TPS_Private; subfont:TCFF_SubFont);cdecl;
      t1_make_subfont : procedure (face:Pointer; priv:TPS_Private; subfont:TCFF_SubFont);cdecl;
      t1_cmap_classes : TT1_CMap_Classes;
      afm_parser_funcs : PAFM_Parser_FuncsRec;
      cff_decoder_funcs : PCFF_Decoder_FuncsRec;
    end;
  TPSAux_ServiceRec = TPSAux_ServiceRec_;
  PPSAux_ServiceRec = ^TPSAux_ServiceRec;
  TPSAux_Service = PPSAux_ServiceRec_;
  PPSAux_Service = ^TPSAux_Service;
{ backward compatible type definition  }

  PPSAux_Interface = ^TPSAux_Interface;
  TPSAux_Interface = TPSAux_ServiceRec;
{*********************************************************************** }
{*********************************************************************** }
{****                                                               **** }
{****                 Some convenience functions                    **** }
{****                                                               **** }
{*********************************************************************** }
{*********************************************************************** }
{
#define IS_PS_NEWLINE( ch ) \
  ( (ch) == '\r' ||         \
    (ch) == '\n' )

#define IS_PS_SPACE( ch )  \
  ( (ch) == ' '         || \
    IS_PS_NEWLINE( ch ) || \
    (ch) == '\t'        || \
    (ch) == '\f'        || \
    (ch) == '\0' )

#define IS_PS_SPECIAL( ch )       \
  ( (ch) == '/'                || \
    (ch) == '(' || (ch) == ')' || \
    (ch) == '<' || (ch) == '>' || \
    (ch) == '[' || (ch) == ']' || \
    (ch) == '' || (ch) == '' || \
    (ch) == '%'                )

#define IS_PS_DELIM( ch )  \
  ( IS_PS_SPACE( ch )   || \
    IS_PS_SPECIAL( ch ) )

#define IS_PS_DIGIT( ch )        \
  ( (ch) >= '0' && (ch) <= '9' )

#define IS_PS_XDIGIT( ch )            \
  ( IS_PS_DIGIT( ch )              || \
    ( (ch) >= 'A' && (ch) <= 'F' ) || \
    ( (ch) >= 'a' && (ch) <= 'f' ) )

#define IS_PS_BASE85( ch )       \
  ( (ch) >= '!' && (ch) <= 'u' )

#define IS_PS_TOKEN( cur, limit, token )                                \
  ( (char)(cur)[0] == (token)[0]                                     && \
    ( (cur) + sizeof ( (token) ) == (limit) ||                          \
      ( (cur) + sizeof( (token) ) < (limit)          &&                 \
        IS_PS_DELIM( (cur)[sizeof ( (token) ) - 1] ) ) )             && \
    ft_strncmp( (char*)(cur), (token), sizeof ( (token) ) - 1 ) == 0 )

 }

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_BOOL(_ident,_fname,_dict : longint) : longint;
begin
//  T1_FIELD_BOOL:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_BOOL,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_NUM:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_INTEGER,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_FIXED:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_FIXED,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_1000(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_FIXED_1000:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_FIXED_1000,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_STRING(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_STRING:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_STRING,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_KEY(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_KEY:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_KEY,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_BBOX(_ident,_fname,_dict : longint) : longint;
begin
  //  T1_FIELD_BBOX:=T1_NEW_SIMPLE_FIELD(_ident,T1_FIELD_TYPE_BBOX,_fname,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM_TABLE(_ident,_fname,_fmax,_dict : longint) : longint;
begin
  //  T1_FIELD_NUM_TABLE:=T1_NEW_TABLE_FIELD(_ident,T1_FIELD_TYPE_INTEGER_ARRAY,_fname,_fmax,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_TABLE(_ident,_fname,_fmax,_dict : longint) : longint;
begin
  //  T1_FIELD_FIXED_TABLE:=T1_NEW_TABLE_FIELD(_ident,T1_FIELD_TYPE_FIXED_ARRAY,_fname,_fmax,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_NUM_TABLE2(_ident,_fname,_fmax,_dict : longint) : longint;
begin
  //  T1_FIELD_NUM_TABLE2:=T1_NEW_TABLE_FIELD2(_ident,T1_FIELD_TYPE_INTEGER_ARRAY,_fname,_fmax,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_FIXED_TABLE2(_ident,_fname,_fmax,_dict : longint) : longint;
begin
  //  T1_FIELD_FIXED_TABLE2:=T1_NEW_TABLE_FIELD2(_ident,T1_FIELD_TYPE_FIXED_ARRAY,_fname,_fmax,_dict);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function T1_FIELD_CALLBACK(_ident,_name,_dict : longint) : longint;
begin
  //  T1_FIELD_CALLBACK:=T1_NEW_CALLBACK_FIELD(_ident,_name,_dict);
end;


end.
