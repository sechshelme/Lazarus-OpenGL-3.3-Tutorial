unit glew;

interface

uses
  ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


const
  {$ifdef linux}
  libGLEW = 'libGLEW';
  {$endif}

  {$ifdef windows}
  libGLEW = 'libGLEW.dll';
  {$endif}

  {$ifdef darwin}
  libGLEW = 'libGLEW'; // ??????????'
  {$endif}


type
P_GLsync=Pointer;
Tptrdiff_t =SizeUInt;


{ ----------------------------- GL_VERSION_1_1 ----------------------------  }

const
  GL_VERSION_1_1 = 1;  
type
  PGLenum = ^TGLenum;
  TGLenum = dword;

  PGLbitfield = ^TGLbitfield;
  TGLbitfield = dword;

  PGLuint = ^TGLuint;
  TGLuint = dword;

  PGLint = ^TGLint;
  TGLint = longint;

  PGLsizei = ^TGLsizei;
  TGLsizei = longint;

  PPGLboolean = ^PGLboolean;
  PGLboolean = ^TGLboolean;
//  TGLboolean = byte;
  TGLboolean = Boolean;

  PGLbyte = ^TGLbyte;
  TGLbyte = char;

  PGLshort = ^TGLshort;
  TGLshort = smallint;

  PGLubyte = ^TGLubyte;
  TGLubyte = byte;

  PGLushort = ^TGLushort;
  TGLushort = word;

  PGLulong = ^TGLulong;
  TGLulong = dword;

  PGLfloat = ^TGLfloat;
  TGLfloat = single;

  PGLclampf = ^TGLclampf;
  TGLclampf = single;

  PGLdouble = ^TGLdouble;
  TGLdouble = double;

  PGLclampd = ^TGLclampd;
  TGLclampd = double;

  PGLvoid = ^TGLvoid;
  TGLvoid = pointer;

type
  PGLint64EXT = ^TGLint64EXT;
  TGLint64EXT = int64;

  PGLuint64EXT = ^TGLuint64EXT;
  TGLuint64EXT = UInt64;

type
  PGLint64 = ^TGLint64;
  TGLint64 = TGLint64EXT;

  PGLuint64 = ^TGLuint64;
  TGLuint64 = TGLuint64EXT;

  PGLsync = ^TGLsync;
  TGLsync = P_GLsync;

  PPGLchar = ^PGLchar;
  PGLchar = ^TGLchar;
  TGLchar = char;

  PGLeglImageOES = ^TGLeglImageOES;
  TGLeglImageOES = pointer;

// === Eigenes
TdMatrix4x4=array[0..15] of TGLdouble;
TfMatrix4x4=array[0..15] of TGLfloat;

TiVec2= array[0..1] of TGLuint;

TfVec4= array[0..3] of TGLfloat;
tfiVec4=array[0..3] of LongInt;// TGLfixed;
  // ==========


const
  GL_ZERO = 0;  
  GL_FALSE = 0;  
  GL_LOGIC_OP = $0BF1;  
  GL_NONE = 0;  
  GL_TEXTURE_COMPONENTS = $1003;  
  GL_NO_ERROR = 0;  
  GL_POINTS = $0000;  
  GL_CURRENT_BIT = $00000001;  
  GL_TRUE = 1;  
  GL_ONE = 1;  
  GL_CLIENT_PIXEL_STORE_BIT = $00000001;  
  GL_LINES = $0001;  
  GL_LINE_LOOP = $0002;  
  GL_POINT_BIT = $00000002;  
  GL_CLIENT_VERTEX_ARRAY_BIT = $00000002;  
  GL_LINE_STRIP = $0003;  
  GL_LINE_BIT = $00000004;  
  GL_TRIANGLES = $0004;  
  GL_TRIANGLE_STRIP = $0005;  
  GL_TRIANGLE_FAN = $0006;  
  GL_QUADS = $0007;  
  GL_QUAD_STRIP = $0008;  
  GL_POLYGON_BIT = $00000008;  
  GL_POLYGON = $0009;  
  GL_POLYGON_STIPPLE_BIT = $00000010;  
  GL_PIXEL_MODE_BIT = $00000020;  
  GL_LIGHTING_BIT = $00000040;  
  GL_FOG_BIT = $00000080;  
  GL_DEPTH_BUFFER_BIT = $00000100;  
  GL_ACCUM = $0100;  
  GL_LOAD = $0101;  
  GL_RETURN = $0102;  
  GL_MULT = $0103;  
  GL_ADD = $0104;  
  GL_NEVER = $0200;  
  GL_ACCUM_BUFFER_BIT = $00000200;  
  GL_LESS = $0201;  
  GL_EQUAL = $0202;  
  GL_LEQUAL = $0203;  
  GL_GREATER = $0204;  
  GL_NOTEQUAL = $0205;  
  GL_GEQUAL = $0206;  
  GL_ALWAYS = $0207;  
  GL_SRC_COLOR = $0300;  
  GL_ONE_MINUS_SRC_COLOR = $0301;  
  GL_SRC_ALPHA = $0302;  
  GL_ONE_MINUS_SRC_ALPHA = $0303;  
  GL_DST_ALPHA = $0304;  
  GL_ONE_MINUS_DST_ALPHA = $0305;  
  GL_DST_COLOR = $0306;  
  GL_ONE_MINUS_DST_COLOR = $0307;  
  GL_SRC_ALPHA_SATURATE = $0308;  
  GL_STENCIL_BUFFER_BIT = $00000400;  
  GL_FRONT_LEFT = $0400;  
  GL_FRONT_RIGHT = $0401;  
  GL_BACK_LEFT = $0402;  
  GL_BACK_RIGHT = $0403;  
  GL_FRONT = $0404;  
  GL_BACK = $0405;  
  GL_LEFT = $0406;  
  GL_RIGHT = $0407;  
  GL_FRONT_AND_BACK = $0408;  
  GL_AUX0 = $0409;  
  GL_AUX1 = $040A;  
  GL_AUX2 = $040B;  
  GL_AUX3 = $040C;  
  GL_INVALID_ENUM = $0500;  
  GL_INVALID_VALUE = $0501;  
  GL_INVALID_OPERATION = $0502;  
  GL_STACK_OVERFLOW = $0503;  
  GL_STACK_UNDERFLOW = $0504;  
  GL_OUT_OF_MEMORY = $0505;  
  GL_2D = $0600;  
  GL_3D = $0601;  
  GL_3D_COLOR = $0602;  
  GL_3D_COLOR_TEXTURE = $0603;  
  GL_4D_COLOR_TEXTURE = $0604;  
  GL_PASS_THROUGH_TOKEN = $0700;  
  GL_POINT_TOKEN = $0701;  
  GL_LINE_TOKEN = $0702;  
  GL_POLYGON_TOKEN = $0703;  
  GL_BITMAP_TOKEN = $0704;  
  GL_DRAW_PIXEL_TOKEN = $0705;  
  GL_COPY_PIXEL_TOKEN = $0706;  
  GL_LINE_RESET_TOKEN = $0707;  
  GL_EXP = $0800;  
  GL_VIEWPORT_BIT = $00000800;  
  GL_EXP2 = $0801;  
  GL_CW = $0900;  
  GL_CCW = $0901;  
  GL_COEFF = $0A00;  
  GL_ORDER = $0A01;  
  GL_DOMAIN = $0A02;  
  GL_CURRENT_COLOR = $0B00;  
  GL_CURRENT_INDEX = $0B01;  
  GL_CURRENT_NORMAL = $0B02;  
  GL_CURRENT_TEXTURE_COORDS = $0B03;  
  GL_CURRENT_RASTER_COLOR = $0B04;  
  GL_CURRENT_RASTER_INDEX = $0B05;  
  GL_CURRENT_RASTER_TEXTURE_COORDS = $0B06;  
  GL_CURRENT_RASTER_POSITION = $0B07;  
  GL_CURRENT_RASTER_POSITION_VALID = $0B08;  
  GL_CURRENT_RASTER_DISTANCE = $0B09;  
  GL_POINT_SMOOTH = $0B10;  
  GL_POINT_SIZE = $0B11;  
  GL_POINT_SIZE_RANGE = $0B12;  
  GL_POINT_SIZE_GRANULARITY = $0B13;  
  GL_LINE_SMOOTH = $0B20;  
  GL_LINE_WIDTH = $0B21;  
  GL_LINE_WIDTH_RANGE = $0B22;  
  GL_LINE_WIDTH_GRANULARITY = $0B23;  
  GL_LINE_STIPPLE = $0B24;  
  GL_LINE_STIPPLE_PATTERN = $0B25;  
  GL_LINE_STIPPLE_REPEAT = $0B26;  
  GL_LIST_MODE = $0B30;  
  GL_MAX_LIST_NESTING = $0B31;  
  GL_LIST_BASE = $0B32;  
  GL_LIST_INDEX = $0B33;  
  GL_POLYGON_MODE = $0B40;  
  GL_POLYGON_SMOOTH = $0B41;  
  GL_POLYGON_STIPPLE = $0B42;  
  GL_EDGE_FLAG = $0B43;  
  GL_CULL_FACE = $0B44;  
  GL_CULL_FACE_MODE = $0B45;  
  GL_FRONT_FACE = $0B46;  
  GL_LIGHTING = $0B50;  
  GL_LIGHT_MODEL_LOCAL_VIEWER = $0B51;  
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;  
  GL_LIGHT_MODEL_AMBIENT = $0B53;  
  GL_SHADE_MODEL = $0B54;  
  GL_COLOR_MATERIAL_FACE = $0B55;  
  GL_COLOR_MATERIAL_PARAMETER = $0B56;  
  GL_COLOR_MATERIAL = $0B57;  
  GL_FOG = $0B60;  
  GL_FOG_INDEX = $0B61;  
  GL_FOG_DENSITY = $0B62;  
  GL_FOG_START = $0B63;  
  GL_FOG_END = $0B64;  
  GL_FOG_MODE = $0B65;  
  GL_FOG_COLOR = $0B66;  
  GL_DEPTH_RANGE = $0B70;  
  GL_DEPTH_TEST = $0B71;  
  GL_DEPTH_WRITEMASK = $0B72;  
  GL_DEPTH_CLEAR_VALUE = $0B73;  
  GL_DEPTH_FUNC = $0B74;  
  GL_ACCUM_CLEAR_VALUE = $0B80;  
  GL_STENCIL_TEST = $0B90;  
  GL_STENCIL_CLEAR_VALUE = $0B91;  
  GL_STENCIL_FUNC = $0B92;  
  GL_STENCIL_VALUE_MASK = $0B93;  
  GL_STENCIL_FAIL = $0B94;  
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;  
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;  
  GL_STENCIL_REF = $0B97;  
  GL_STENCIL_WRITEMASK = $0B98;  
  GL_MATRIX_MODE = $0BA0;  
  GL_NORMALIZE = $0BA1;  
  GL_VIEWPORT = $0BA2;  
  GL_MODELVIEW_STACK_DEPTH = $0BA3;  
  GL_PROJECTION_STACK_DEPTH = $0BA4;  
  GL_TEXTURE_STACK_DEPTH = $0BA5;  
  GL_MODELVIEW_MATRIX = $0BA6;  
  GL_PROJECTION_MATRIX = $0BA7;  
  GL_TEXTURE_MATRIX = $0BA8;  
  GL_ATTRIB_STACK_DEPTH = $0BB0;  
  GL_CLIENT_ATTRIB_STACK_DEPTH = $0BB1;  
  GL_ALPHA_TEST = $0BC0;  
  GL_ALPHA_TEST_FUNC = $0BC1;  
  GL_ALPHA_TEST_REF = $0BC2;  
  GL_DITHER = $0BD0;  
  GL_BLEND_DST = $0BE0;  
  GL_BLEND_SRC = $0BE1;  
  GL_BLEND = $0BE2;  
  GL_LOGIC_OP_MODE = $0BF0;  
  GL_INDEX_LOGIC_OP = $0BF1;  
  GL_COLOR_LOGIC_OP = $0BF2;  
  GL_AUX_BUFFERS = $0C00;  
  GL_DRAW_BUFFER = $0C01;  
  GL_READ_BUFFER = $0C02;  
  GL_SCISSOR_BOX = $0C10;  
  GL_SCISSOR_TEST = $0C11;  
  GL_INDEX_CLEAR_VALUE = $0C20;  
  GL_INDEX_WRITEMASK = $0C21;  
  GL_COLOR_CLEAR_VALUE = $0C22;  
  GL_COLOR_WRITEMASK = $0C23;  
  GL_INDEX_MODE = $0C30;  
  GL_RGBA_MODE = $0C31;  
  GL_DOUBLEBUFFER = $0C32;  
  GL_STEREO = $0C33;  
  GL_RENDER_MODE = $0C40;  
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;  
  GL_POINT_SMOOTH_HINT = $0C51;  
  GL_LINE_SMOOTH_HINT = $0C52;  
  GL_POLYGON_SMOOTH_HINT = $0C53;  
  GL_FOG_HINT = $0C54;  
  GL_TEXTURE_GEN_S = $0C60;  
  GL_TEXTURE_GEN_T = $0C61;  
  GL_TEXTURE_GEN_R = $0C62;  
  GL_TEXTURE_GEN_Q = $0C63;  
  GL_PIXEL_MAP_I_TO_I = $0C70;  
  GL_PIXEL_MAP_S_TO_S = $0C71;  
  GL_PIXEL_MAP_I_TO_R = $0C72;  
  GL_PIXEL_MAP_I_TO_G = $0C73;  
  GL_PIXEL_MAP_I_TO_B = $0C74;  
  GL_PIXEL_MAP_I_TO_A = $0C75;  
  GL_PIXEL_MAP_R_TO_R = $0C76;  
  GL_PIXEL_MAP_G_TO_G = $0C77;  
  GL_PIXEL_MAP_B_TO_B = $0C78;  
  GL_PIXEL_MAP_A_TO_A = $0C79;  
  GL_PIXEL_MAP_I_TO_I_SIZE = $0CB0;  
  GL_PIXEL_MAP_S_TO_S_SIZE = $0CB1;  
  GL_PIXEL_MAP_I_TO_R_SIZE = $0CB2;  
  GL_PIXEL_MAP_I_TO_G_SIZE = $0CB3;  
  GL_PIXEL_MAP_I_TO_B_SIZE = $0CB4;  
  GL_PIXEL_MAP_I_TO_A_SIZE = $0CB5;  
  GL_PIXEL_MAP_R_TO_R_SIZE = $0CB6;  
  GL_PIXEL_MAP_G_TO_G_SIZE = $0CB7;  
  GL_PIXEL_MAP_B_TO_B_SIZE = $0CB8;  
  GL_PIXEL_MAP_A_TO_A_SIZE = $0CB9;  
  GL_UNPACK_SWAP_BYTES = $0CF0;  
  GL_UNPACK_LSB_FIRST = $0CF1;  
  GL_UNPACK_ROW_LENGTH = $0CF2;  
  GL_UNPACK_SKIP_ROWS = $0CF3;  
  GL_UNPACK_SKIP_PIXELS = $0CF4;  
  GL_UNPACK_ALIGNMENT = $0CF5;  
  GL_PACK_SWAP_BYTES = $0D00;  
  GL_PACK_LSB_FIRST = $0D01;  
  GL_PACK_ROW_LENGTH = $0D02;  
  GL_PACK_SKIP_ROWS = $0D03;  
  GL_PACK_SKIP_PIXELS = $0D04;  
  GL_PACK_ALIGNMENT = $0D05;  
  GL_MAP_COLOR = $0D10;  
  GL_MAP_STENCIL = $0D11;  
  GL_INDEX_SHIFT = $0D12;  
  GL_INDEX_OFFSET = $0D13;  
  GL_RED_SCALE = $0D14;  
  GL_RED_BIAS = $0D15;  
  GL_ZOOM_X = $0D16;  
  GL_ZOOM_Y = $0D17;  
  GL_GREEN_SCALE = $0D18;  
  GL_GREEN_BIAS = $0D19;  
  GL_BLUE_SCALE = $0D1A;  
  GL_BLUE_BIAS = $0D1B;  
  GL_ALPHA_SCALE = $0D1C;  
  GL_ALPHA_BIAS = $0D1D;  
  GL_DEPTH_SCALE = $0D1E;  
  GL_DEPTH_BIAS = $0D1F;  
  GL_MAX_EVAL_ORDER = $0D30;  
  GL_MAX_LIGHTS = $0D31;  
  GL_MAX_CLIP_PLANES = $0D32;  
  GL_MAX_TEXTURE_SIZE = $0D33;  
  GL_MAX_PIXEL_MAP_TABLE = $0D34;  
  GL_MAX_ATTRIB_STACK_DEPTH = $0D35;  
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;  
  GL_MAX_NAME_STACK_DEPTH = $0D37;  
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;  
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;  
  GL_MAX_VIEWPORT_DIMS = $0D3A;  
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = $0D3B;  
  GL_SUBPIXEL_BITS = $0D50;  
  GL_INDEX_BITS = $0D51;  
  GL_RED_BITS = $0D52;  
  GL_GREEN_BITS = $0D53;  
  GL_BLUE_BITS = $0D54;  
  GL_ALPHA_BITS = $0D55;  
  GL_DEPTH_BITS = $0D56;  
  GL_STENCIL_BITS = $0D57;  
  GL_ACCUM_RED_BITS = $0D58;  
  GL_ACCUM_GREEN_BITS = $0D59;  
  GL_ACCUM_BLUE_BITS = $0D5A;  
  GL_ACCUM_ALPHA_BITS = $0D5B;  
  GL_NAME_STACK_DEPTH = $0D70;  
  GL_AUTO_NORMAL = $0D80;  
  GL_MAP1_COLOR_4 = $0D90;  
  GL_MAP1_INDEX = $0D91;  
  GL_MAP1_NORMAL = $0D92;  
  GL_MAP1_TEXTURE_COORD_1 = $0D93;  
  GL_MAP1_TEXTURE_COORD_2 = $0D94;  
  GL_MAP1_TEXTURE_COORD_3 = $0D95;  
  GL_MAP1_TEXTURE_COORD_4 = $0D96;  
  GL_MAP1_VERTEX_3 = $0D97;  
  GL_MAP1_VERTEX_4 = $0D98;  
  GL_MAP2_COLOR_4 = $0DB0;  
  GL_MAP2_INDEX = $0DB1;  
  GL_MAP2_NORMAL = $0DB2;  
  GL_MAP2_TEXTURE_COORD_1 = $0DB3;  
  GL_MAP2_TEXTURE_COORD_2 = $0DB4;  
  GL_MAP2_TEXTURE_COORD_3 = $0DB5;  
  GL_MAP2_TEXTURE_COORD_4 = $0DB6;  
  GL_MAP2_VERTEX_3 = $0DB7;  
  GL_MAP2_VERTEX_4 = $0DB8;  
  GL_MAP1_GRID_DOMAIN = $0DD0;  
  GL_MAP1_GRID_SEGMENTS = $0DD1;  
  GL_MAP2_GRID_DOMAIN = $0DD2;  
  GL_MAP2_GRID_SEGMENTS = $0DD3;  
  GL_TEXTURE_1D = $0DE0;  
  GL_TEXTURE_2D = $0DE1;  
  GL_FEEDBACK_BUFFER_POINTER = $0DF0;  
  GL_FEEDBACK_BUFFER_SIZE = $0DF1;  
  GL_FEEDBACK_BUFFER_TYPE = $0DF2;  
  GL_SELECTION_BUFFER_POINTER = $0DF3;  
  GL_SELECTION_BUFFER_SIZE = $0DF4;  
  GL_TEXTURE_WIDTH = $1000;  
  GL_TRANSFORM_BIT = $00001000;  
  GL_TEXTURE_HEIGHT = $1001;  
  GL_TEXTURE_INTERNAL_FORMAT = $1003;  
  GL_TEXTURE_BORDER_COLOR = $1004;  
  GL_TEXTURE_BORDER = $1005;  
  GL_DONT_CARE = $1100;  
  GL_FASTEST = $1101;  
  GL_NICEST = $1102;  
  GL_AMBIENT = $1200;  
  GL_DIFFUSE = $1201;  
  GL_SPECULAR = $1202;  
  GL_POSITION = $1203;  
  GL_SPOT_DIRECTION = $1204;  
  GL_SPOT_EXPONENT = $1205;  
  GL_SPOT_CUTOFF = $1206;  
  GL_CONSTANT_ATTENUATION = $1207;  
  GL_LINEAR_ATTENUATION = $1208;  
  GL_QUADRATIC_ATTENUATION = $1209;  
  GL_COMPILE = $1300;  
  GL_COMPILE_AND_EXECUTE = $1301;  
  GL_BYTE = $1400;  
  GL_UNSIGNED_BYTE = $1401;  
  GL_SHORT = $1402;  
  GL_UNSIGNED_SHORT = $1403;  
  GL_INT = $1404;  
  GL_UNSIGNED_INT = $1405;  
  GL_FLOAT = $1406;  
  GL_2_BYTES = $1407;  
  GL_3_BYTES = $1408;  
  GL_4_BYTES = $1409;  
  GL_DOUBLE = $140A;  
  GL_CLEAR = $1500;  
  GL_AND = $1501;  
  GL_AND_REVERSE = $1502;  
  GL_COPY = $1503;  
  GL_AND_INVERTED = $1504;  
  GL_NOOP = $1505;  
  GL_XOR = $1506;  
  GL_OR = $1507;  
  GL_NOR = $1508;  
  GL_EQUIV = $1509;  
  GL_INVERT = $150A;  
  GL_OR_REVERSE = $150B;  
  GL_COPY_INVERTED = $150C;  
  GL_OR_INVERTED = $150D;  
  GL_NAND = $150E;  
  GL_SET = $150F;  
  GL_EMISSION = $1600;  
  GL_SHININESS = $1601;  
  GL_AMBIENT_AND_DIFFUSE = $1602;  
  GL_COLOR_INDEXES = $1603;  
  GL_MODELVIEW = $1700;  
  GL_PROJECTION = $1701;  
  GL_TEXTURE = $1702;  
  GL_COLOR = $1800;  
  GL_DEPTH = $1801;  
  GL_STENCIL = $1802;  
  GL_COLOR_INDEX = $1900;  
  GL_STENCIL_INDEX = $1901;  
  GL_DEPTH_COMPONENT = $1902;  
  GL_RED = $1903;  
  GL_GREEN = $1904;  
  GL_BLUE = $1905;  
  GL_ALPHA = $1906;  
  GL_RGB = $1907;  
  GL_RGBA = $1908;  
  GL_LUMINANCE = $1909;  
  GL_LUMINANCE_ALPHA = $190A;  
  GL_BITMAP = $1A00;  
  GL_POINT = $1B00;  
  GL_LINE = $1B01;  
  GL_FILL = $1B02;  
  GL_RENDER = $1C00;  
  GL_FEEDBACK = $1C01;  
  GL_SELECT = $1C02;  
  GL_FLAT = $1D00;  
  GL_SMOOTH = $1D01;  
  GL_KEEP = $1E00;  
  GL_REPLACE = $1E01;  
  GL_INCR = $1E02;  
  GL_DECR = $1E03;  
  GL_VENDOR = $1F00;  
  GL_RENDERER = $1F01;  
  GL_VERSION = $1F02;  
  GL_EXTENSIONS = $1F03;  
  GL_S = $2000;  
  GL_ENABLE_BIT = $00002000;  
  GL_T = $2001;  
  GL_R = $2002;  
  GL_Q = $2003;  
  GL_MODULATE = $2100;  
  GL_DECAL = $2101;  
  GL_TEXTURE_ENV_MODE = $2200;  
  GL_TEXTURE_ENV_COLOR = $2201;  
  GL_TEXTURE_ENV = $2300;  
  GL_EYE_LINEAR = $2400;  
  GL_OBJECT_LINEAR = $2401;  
  GL_SPHERE_MAP = $2402;  
  GL_TEXTURE_GEN_MODE = $2500;  
  GL_OBJECT_PLANE = $2501;  
  GL_EYE_PLANE = $2502;  
  GL_NEAREST = $2600;  
  GL_LINEAR = $2601;  
  GL_NEAREST_MIPMAP_NEAREST = $2700;  
  GL_LINEAR_MIPMAP_NEAREST = $2701;  
  GL_NEAREST_MIPMAP_LINEAR = $2702;  
  GL_LINEAR_MIPMAP_LINEAR = $2703;  
  GL_TEXTURE_MAG_FILTER = $2800;  
  GL_TEXTURE_MIN_FILTER = $2801;  
  GL_TEXTURE_WRAP_S = $2802;  
  GL_TEXTURE_WRAP_T = $2803;  
  GL_CLAMP = $2900;  
  GL_REPEAT = $2901;  
  GL_POLYGON_OFFSET_UNITS = $2A00;  
  GL_POLYGON_OFFSET_POINT = $2A01;  
  GL_POLYGON_OFFSET_LINE = $2A02;  
  GL_R3_G3_B2 = $2A10;  
  GL_V2F = $2A20;  
  GL_V3F = $2A21;  
  GL_C4UB_V2F = $2A22;  
  GL_C4UB_V3F = $2A23;  
  GL_C3F_V3F = $2A24;  
  GL_N3F_V3F = $2A25;  
  GL_C4F_N3F_V3F = $2A26;  
  GL_T2F_V3F = $2A27;  
  GL_T4F_V4F = $2A28;  
  GL_T2F_C4UB_V3F = $2A29;  
  GL_T2F_C3F_V3F = $2A2A;  
  GL_T2F_N3F_V3F = $2A2B;  
  GL_T2F_C4F_N3F_V3F = $2A2C;  
  GL_T4F_C4F_N3F_V4F = $2A2D;  
  GL_CLIP_PLANE0 = $3000;  
  GL_CLIP_PLANE1 = $3001;  
  GL_CLIP_PLANE2 = $3002;  
  GL_CLIP_PLANE3 = $3003;  
  GL_CLIP_PLANE4 = $3004;  
  GL_CLIP_PLANE5 = $3005;  
  GL_LIGHT0 = $4000;  
  GL_COLOR_BUFFER_BIT = $00004000;  
  GL_LIGHT1 = $4001;  
  GL_LIGHT2 = $4002;  
  GL_LIGHT3 = $4003;  
  GL_LIGHT4 = $4004;  
  GL_LIGHT5 = $4005;  
  GL_LIGHT6 = $4006;  
  GL_LIGHT7 = $4007;  
  GL_HINT_BIT = $00008000;  
  GL_POLYGON_OFFSET_FILL = $8037;  
  GL_POLYGON_OFFSET_FACTOR = $8038;  
  GL_ALPHA4 = $803B;  
  GL_ALPHA8 = $803C;  
  GL_ALPHA12 = $803D;  
  GL_ALPHA16 = $803E;  
  GL_LUMINANCE4 = $803F;  
  GL_LUMINANCE8 = $8040;  
  GL_LUMINANCE12 = $8041;  
  GL_LUMINANCE16 = $8042;  
  GL_LUMINANCE4_ALPHA4 = $8043;  
  GL_LUMINANCE6_ALPHA2 = $8044;  
  GL_LUMINANCE8_ALPHA8 = $8045;  
  GL_LUMINANCE12_ALPHA4 = $8046;  
  GL_LUMINANCE12_ALPHA12 = $8047;  
  GL_LUMINANCE16_ALPHA16 = $8048;  
  GL_INTENSITY = $8049;  
  GL_INTENSITY4 = $804A;  
  GL_INTENSITY8 = $804B;  
  GL_INTENSITY12 = $804C;  
  GL_INTENSITY16 = $804D;  
  GL_RGB4 = $804F;  
  GL_RGB5 = $8050;  
  GL_RGB8 = $8051;  
  GL_RGB10 = $8052;  
  GL_RGB12 = $8053;  
  GL_RGB16 = $8054;  
  GL_RGBA2 = $8055;  
  GL_RGBA4 = $8056;  
  GL_RGB5_A1 = $8057;  
  GL_RGBA8 = $8058;  
  GL_RGB10_A2 = $8059;  
  GL_RGBA12 = $805A;  
  GL_RGBA16 = $805B;  
  GL_TEXTURE_RED_SIZE = $805C;  
  GL_TEXTURE_GREEN_SIZE = $805D;  
  GL_TEXTURE_BLUE_SIZE = $805E;  
  GL_TEXTURE_ALPHA_SIZE = $805F;  
  GL_TEXTURE_LUMINANCE_SIZE = $8060;  
  GL_TEXTURE_INTENSITY_SIZE = $8061;  
  GL_PROXY_TEXTURE_1D = $8063;  
  GL_PROXY_TEXTURE_2D = $8064;  
  GL_TEXTURE_PRIORITY = $8066;  
  GL_TEXTURE_RESIDENT = $8067;  
  GL_TEXTURE_BINDING_1D = $8068;  
  GL_TEXTURE_BINDING_2D = $8069;  
  GL_VERTEX_ARRAY = $8074;  
  GL_NORMAL_ARRAY = $8075;  
  GL_COLOR_ARRAY = $8076;  
  GL_INDEX_ARRAY = $8077;  
  GL_TEXTURE_COORD_ARRAY = $8078;  
  GL_EDGE_FLAG_ARRAY = $8079;  
  GL_VERTEX_ARRAY_SIZE = $807A;  
  GL_VERTEX_ARRAY_TYPE = $807B;  
  GL_VERTEX_ARRAY_STRIDE = $807C;  
  GL_NORMAL_ARRAY_TYPE = $807E;  
  GL_NORMAL_ARRAY_STRIDE = $807F;  
  GL_COLOR_ARRAY_SIZE = $8081;  
  GL_COLOR_ARRAY_TYPE = $8082;  
  GL_COLOR_ARRAY_STRIDE = $8083;  
  GL_INDEX_ARRAY_TYPE = $8085;  
  GL_INDEX_ARRAY_STRIDE = $8086;  
  GL_TEXTURE_COORD_ARRAY_SIZE = $8088;  
  GL_TEXTURE_COORD_ARRAY_TYPE = $8089;  
  GL_TEXTURE_COORD_ARRAY_STRIDE = $808A;  
  GL_EDGE_FLAG_ARRAY_STRIDE = $808C;  
  GL_VERTEX_ARRAY_POINTER = $808E;  
  GL_NORMAL_ARRAY_POINTER = $808F;  
  GL_COLOR_ARRAY_POINTER = $8090;  
  GL_INDEX_ARRAY_POINTER = $8091;  
  GL_TEXTURE_COORD_ARRAY_POINTER = $8092;  
  GL_EDGE_FLAG_ARRAY_POINTER = $8093;  
  GL_COLOR_INDEX1_EXT = $80E2;  
  GL_COLOR_INDEX2_EXT = $80E3;  
  GL_COLOR_INDEX4_EXT = $80E4;  
  GL_COLOR_INDEX8_EXT = $80E5;  
  GL_COLOR_INDEX12_EXT = $80E6;  
  GL_COLOR_INDEX16_EXT = $80E7;  
  GL_EVAL_BIT = $00010000;  
  GL_LIST_BIT = $00020000;  
  GL_TEXTURE_BIT = $00040000;  
  GL_SCISSOR_BIT = $00080000;  
  GL_ALL_ATTRIB_BITS = $000fffff;  
  GL_CLIENT_ALL_ATTRIB_BITS = $ffffffff;  

procedure glAccum(op:TGLenum; value:TGLfloat);cdecl;external libGLEW;
procedure glAlphaFunc(func:TGLenum; ref:TGLclampf);cdecl;external libGLEW;
function glAreTexturesResident(n:TGLsizei; textures:PGLuint; residences:PGLboolean):TGLboolean;cdecl;external libGLEW;
procedure glArrayElement(i:TGLint);cdecl;external libGLEW;
procedure glBegin(mode:TGLenum);cdecl;external libGLEW;
procedure glBindTexture(target:TGLenum; texture:TGLuint);cdecl;external libGLEW;
procedure glBitmap(width:TGLsizei; height:TGLsizei; xorig:TGLfloat; yorig:TGLfloat; xmove:TGLfloat; 
            ymove:TGLfloat; bitmap:PGLubyte);cdecl;external libGLEW;
procedure glBlendFunc(sfactor:TGLenum; dfactor:TGLenum);cdecl;external libGLEW;
procedure glCallList(list:TGLuint);cdecl;external libGLEW;
procedure glCallLists(n:TGLsizei; _type:TGLenum; lists:pointer);cdecl;external libGLEW;
procedure glClear(mask:TGLbitfield);cdecl;external libGLEW;
procedure glClearAccum(red:TGLfloat; green:TGLfloat; blue:TGLfloat; alpha:TGLfloat);cdecl;external libGLEW;
procedure glClearColor(red:TGLclampf; green:TGLclampf; blue:TGLclampf; alpha:TGLclampf);cdecl;external libGLEW;
procedure glClearDepth(depth:TGLclampd);cdecl;external libGLEW;
procedure glClearIndex(c:TGLfloat);cdecl;external libGLEW;
procedure glClearStencil(s:TGLint);cdecl;external libGLEW;
procedure glClipPlane(plane:TGLenum; equation:PGLdouble);cdecl;external libGLEW;
procedure glColor3b(red:TGLbyte; green:TGLbyte; blue:TGLbyte);cdecl;external libGLEW;
procedure glColor3bv(v:PGLbyte);cdecl;external libGLEW;
procedure glColor3d(red:TGLdouble; green:TGLdouble; blue:TGLdouble);cdecl;external libGLEW;
procedure glColor3dv(v:PGLdouble);cdecl;external libGLEW;
procedure glColor3f(red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external libGLEW;
procedure glColor3fv(v:PGLfloat);cdecl;external libGLEW;
procedure glColor3i(red:TGLint; green:TGLint; blue:TGLint);cdecl;external libGLEW;
procedure glColor3iv(v:PGLint);cdecl;external libGLEW;
procedure glColor3s(red:TGLshort; green:TGLshort; blue:TGLshort);cdecl;external libGLEW;
procedure glColor3sv(v:PGLshort);cdecl;external libGLEW;
procedure glColor3ub(red:TGLubyte; green:TGLubyte; blue:TGLubyte);cdecl;external libGLEW;
procedure glColor3ubv(v:PGLubyte);cdecl;external libGLEW;
procedure glColor3ui(red:TGLuint; green:TGLuint; blue:TGLuint);cdecl;external libGLEW;
procedure glColor3uiv(v:PGLuint);cdecl;external libGLEW;
procedure glColor3us(red:TGLushort; green:TGLushort; blue:TGLushort);cdecl;external libGLEW;
procedure glColor3usv(v:PGLushort);cdecl;external libGLEW;
procedure glColor4b(red:TGLbyte; green:TGLbyte; blue:TGLbyte; alpha:TGLbyte);cdecl;external libGLEW;
procedure glColor4bv(v:PGLbyte);cdecl;external libGLEW;
procedure glColor4d(red:TGLdouble; green:TGLdouble; blue:TGLdouble; alpha:TGLdouble);cdecl;external libGLEW;
procedure glColor4dv(v:PGLdouble);cdecl;external libGLEW;
procedure glColor4f(red:TGLfloat; green:TGLfloat; blue:TGLfloat; alpha:TGLfloat);cdecl;external libGLEW;
procedure glColor4fv(v:PGLfloat);cdecl;external libGLEW;
procedure glColor4i(red:TGLint; green:TGLint; blue:TGLint; alpha:TGLint);cdecl;external libGLEW;
procedure glColor4iv(v:PGLint);cdecl;external libGLEW;
procedure glColor4s(red:TGLshort; green:TGLshort; blue:TGLshort; alpha:TGLshort);cdecl;external libGLEW;
procedure glColor4sv(v:PGLshort);cdecl;external libGLEW;
procedure glColor4ub(red:TGLubyte; green:TGLubyte; blue:TGLubyte; alpha:TGLubyte);cdecl;external libGLEW;
procedure glColor4ubv(v:PGLubyte);cdecl;external libGLEW;
procedure glColor4ui(red:TGLuint; green:TGLuint; blue:TGLuint; alpha:TGLuint);cdecl;external libGLEW;
procedure glColor4uiv(v:PGLuint);cdecl;external libGLEW;
procedure glColor4us(red:TGLushort; green:TGLushort; blue:TGLushort; alpha:TGLushort);cdecl;external libGLEW;
procedure glColor4usv(v:PGLushort);cdecl;external libGLEW;
procedure glColorMask(red:TGLboolean; green:TGLboolean; blue:TGLboolean; alpha:TGLboolean);cdecl;external libGLEW;
procedure glColorMaterial(face:TGLenum; mode:TGLenum);cdecl;external libGLEW;
procedure glColorPointer(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glCopyPixels(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; _type:TGLenum);cdecl;external libGLEW;
procedure glCopyTexImage1D(target:TGLenum; level:TGLint; internalFormat:TGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; border:TGLint);cdecl;external libGLEW;
procedure glCopyTexImage2D(target:TGLenum; level:TGLint; internalFormat:TGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;external libGLEW;
procedure glCopyTexSubImage1D(target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint; y:TGLint; 
            width:TGLsizei);cdecl;external libGLEW;
procedure glCopyTexSubImage2D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; x:TGLint; 
            y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external libGLEW;
procedure glCullFace(mode:TGLenum);cdecl;external libGLEW;
procedure glDeleteLists(list:TGLuint; range:TGLsizei);cdecl;external libGLEW;
procedure glDeleteTextures(n:TGLsizei; textures:PGLuint);cdecl;external libGLEW;
procedure glDepthFunc(func:TGLenum);cdecl;external libGLEW;
procedure glDepthMask(flag:TGLboolean);cdecl;external libGLEW;
procedure glDepthRange(zNear:TGLclampd; zFar:TGLclampd);cdecl;external libGLEW;
procedure glDisable(cap:TGLenum);cdecl;external libGLEW;
procedure glDisableClientState(arr:TGLenum);cdecl;external libGLEW;
procedure glDrawArrays(mode:TGLenum; first:TGLint; count:TGLsizei);cdecl;external libGLEW;
procedure glDrawBuffer(mode:TGLenum);cdecl;external libGLEW;
procedure glDrawElements(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer);cdecl;external libGLEW;
procedure glDrawPixels(width:TGLsizei; height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glEdgeFlag(flag:TGLboolean);cdecl;external libGLEW;
procedure glEdgeFlagPointer(stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glEdgeFlagv(flag:PGLboolean);cdecl;external libGLEW;
procedure glEnable(cap:TGLenum);cdecl;external libGLEW;
procedure glEnableClientState(arr:TGLenum);cdecl;external libGLEW;
procedure glEnd;cdecl;external libGLEW;
procedure glEndList;cdecl;external libGLEW;
procedure glEvalCoord1d(u:TGLdouble);cdecl;external libGLEW;
procedure glEvalCoord1dv(u:PGLdouble);cdecl;external libGLEW;
procedure glEvalCoord1f(u:TGLfloat);cdecl;external libGLEW;
procedure glEvalCoord1fv(u:PGLfloat);cdecl;external libGLEW;
procedure glEvalCoord2d(u:TGLdouble; v:TGLdouble);cdecl;external libGLEW;
procedure glEvalCoord2dv(u:PGLdouble);cdecl;external libGLEW;
procedure glEvalCoord2f(u:TGLfloat; v:TGLfloat);cdecl;external libGLEW;
procedure glEvalCoord2fv(u:PGLfloat);cdecl;external libGLEW;
procedure glEvalMesh1(mode:TGLenum; i1:TGLint; i2:TGLint);cdecl;external libGLEW;
procedure glEvalMesh2(mode:TGLenum; i1:TGLint; i2:TGLint; j1:TGLint; j2:TGLint);cdecl;external libGLEW;
procedure glEvalPoint1(i:TGLint);cdecl;external libGLEW;
procedure glEvalPoint2(i:TGLint; j:TGLint);cdecl;external libGLEW;
procedure glFeedbackBuffer(size:TGLsizei; _type:TGLenum; buffer:PGLfloat);cdecl;external libGLEW;
procedure glFinish;cdecl;external libGLEW;
procedure glFlush;cdecl;external libGLEW;
procedure glFogf(pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glFogfv(pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glFogi(pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glFogiv(pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glFrontFace(mode:TGLenum);cdecl;external libGLEW;
procedure glFrustum(left:TGLdouble; right:TGLdouble; bottom:TGLdouble; top:TGLdouble; zNear:TGLdouble; 
            zFar:TGLdouble);cdecl;external libGLEW;
function glGenLists(range:TGLsizei):TGLuint;cdecl;external libGLEW;
procedure glGenTextures(n:TGLsizei; textures:PGLuint);cdecl;external libGLEW;
procedure glGetBooleanv(pname:TGLenum; params:PGLboolean);cdecl;external libGLEW;
procedure glGetClipPlane(plane:TGLenum; equation:PGLdouble);cdecl;external libGLEW;
procedure glGetDoublev(pname:TGLenum; params:PGLdouble);cdecl;external libGLEW;
function glGetError:TGLenum;cdecl;external libGLEW;
procedure glGetFloatv(pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetIntegerv(pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetLightfv(light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetLightiv(light:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetMapdv(target:TGLenum; query:TGLenum; v:PGLdouble);cdecl;external libGLEW;
procedure glGetMapfv(target:TGLenum; query:TGLenum; v:PGLfloat);cdecl;external libGLEW;
procedure glGetMapiv(target:TGLenum; query:TGLenum; v:PGLint);cdecl;external libGLEW;
procedure glGetMaterialfv(face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetMaterialiv(face:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetPixelMapfv(map:TGLenum; values:PGLfloat);cdecl;external libGLEW;
procedure glGetPixelMapuiv(map:TGLenum; values:PGLuint);cdecl;external libGLEW;
procedure glGetPixelMapusv(map:TGLenum; values:PGLushort);cdecl;external libGLEW;
procedure glGetPointerv(pname:TGLenum; params:Ppointer);cdecl;external libGLEW;
procedure glGetPolygonStipple(mask:PGLubyte);cdecl;external libGLEW;
function glGetString(name:TGLenum):PGLubyte;cdecl;external libGLEW;
procedure glGetTexEnvfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetTexEnviv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetTexGendv(coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;external libGLEW;
procedure glGetTexGenfv(coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetTexGeniv(coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetTexImage(target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glGetTexLevelParameterfv(target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetTexLevelParameteriv(target:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glGetTexParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glGetTexParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glHint(target:TGLenum; mode:TGLenum);cdecl;external libGLEW;
procedure glIndexMask(mask:TGLuint);cdecl;external libGLEW;
procedure glIndexPointer(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glIndexd(c:TGLdouble);cdecl;external libGLEW;
procedure glIndexdv(c:PGLdouble);cdecl;external libGLEW;
procedure glIndexf(c:TGLfloat);cdecl;external libGLEW;
procedure glIndexfv(c:PGLfloat);cdecl;external libGLEW;
procedure glIndexi(c:TGLint);cdecl;external libGLEW;
procedure glIndexiv(c:PGLint);cdecl;external libGLEW;
procedure glIndexs(c:TGLshort);cdecl;external libGLEW;
procedure glIndexsv(c:PGLshort);cdecl;external libGLEW;
procedure glIndexub(c:TGLubyte);cdecl;external libGLEW;
procedure glIndexubv(c:PGLubyte);cdecl;external libGLEW;
procedure glInitNames;cdecl;external libGLEW;
procedure glInterleavedArrays(format:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
function glIsEnabled(cap:TGLenum):TGLboolean;cdecl;external libGLEW;
function glIsList(list:TGLuint):TGLboolean;cdecl;external libGLEW;
function glIsTexture(texture:TGLuint):TGLboolean;cdecl;external libGLEW;
procedure glLightModelf(pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glLightModelfv(pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glLightModeli(pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glLightModeliv(pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glLightf(light:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glLightfv(light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glLighti(light:TGLenum; pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glLightiv(light:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glLineStipple(factor:TGLint; pattern:TGLushort);cdecl;external libGLEW;
procedure glLineWidth(width:TGLfloat);cdecl;external libGLEW;
procedure glListBase(base:TGLuint);cdecl;external libGLEW;
procedure glLoadIdentity;cdecl;external libGLEW;
procedure glLoadMatrixd(m:PGLdouble);cdecl;external libGLEW;
procedure glLoadMatrixf(m:PGLfloat);cdecl;external libGLEW;
procedure glLoadName(name:TGLuint);cdecl;external libGLEW;
procedure glLogicOp(opcode:TGLenum);cdecl;external libGLEW;
procedure glMap1d(target:TGLenum; u1:TGLdouble; u2:TGLdouble; stride:TGLint; order:TGLint; 
            points:PGLdouble);cdecl;external libGLEW;
procedure glMap1f(target:TGLenum; u1:TGLfloat; u2:TGLfloat; stride:TGLint; order:TGLint; 
            points:PGLfloat);cdecl;external libGLEW;
procedure glMap2d(target:TGLenum; u1:TGLdouble; u2:TGLdouble; ustride:TGLint; uorder:TGLint; 
            v1:TGLdouble; v2:TGLdouble; vstride:TGLint; vorder:TGLint; points:PGLdouble);cdecl;external libGLEW;
procedure glMap2f(target:TGLenum; u1:TGLfloat; u2:TGLfloat; ustride:TGLint; uorder:TGLint; 
            v1:TGLfloat; v2:TGLfloat; vstride:TGLint; vorder:TGLint; points:PGLfloat);cdecl;external libGLEW;
procedure glMapGrid1d(un:TGLint; u1:TGLdouble; u2:TGLdouble);cdecl;external libGLEW;
procedure glMapGrid1f(un:TGLint; u1:TGLfloat; u2:TGLfloat);cdecl;external libGLEW;
procedure glMapGrid2d(un:TGLint; u1:TGLdouble; u2:TGLdouble; vn:TGLint; v1:TGLdouble; 
            v2:TGLdouble);cdecl;external libGLEW;
procedure glMapGrid2f(un:TGLint; u1:TGLfloat; u2:TGLfloat; vn:TGLint; v1:TGLfloat; 
            v2:TGLfloat);cdecl;external libGLEW;
procedure glMaterialf(face:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glMaterialfv(face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glMateriali(face:TGLenum; pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glMaterialiv(face:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glMatrixMode(mode:TGLenum);cdecl;external libGLEW;
procedure glMultMatrixd(m:PGLdouble);cdecl;external libGLEW;
procedure glMultMatrixf(m:PGLfloat);cdecl;external libGLEW;
procedure glNewList(list:TGLuint; mode:TGLenum);cdecl;external libGLEW;
procedure glNormal3b(nx:TGLbyte; ny:TGLbyte; nz:TGLbyte);cdecl;external libGLEW;
procedure glNormal3bv(v:PGLbyte);cdecl;external libGLEW;
procedure glNormal3d(nx:TGLdouble; ny:TGLdouble; nz:TGLdouble);cdecl;external libGLEW;
procedure glNormal3dv(v:PGLdouble);cdecl;external libGLEW;
procedure glNormal3f(nx:TGLfloat; ny:TGLfloat; nz:TGLfloat);cdecl;external libGLEW;
procedure glNormal3fv(v:PGLfloat);cdecl;external libGLEW;
procedure glNormal3i(nx:TGLint; ny:TGLint; nz:TGLint);cdecl;external libGLEW;
procedure glNormal3iv(v:PGLint);cdecl;external libGLEW;
procedure glNormal3s(nx:TGLshort; ny:TGLshort; nz:TGLshort);cdecl;external libGLEW;
procedure glNormal3sv(v:PGLshort);cdecl;external libGLEW;
procedure glNormalPointer(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glOrtho(left:TGLdouble; right:TGLdouble; bottom:TGLdouble; top:TGLdouble; zNear:TGLdouble; 
            zFar:TGLdouble);cdecl;external libGLEW;
procedure glPassThrough(token:TGLfloat);cdecl;external libGLEW;
procedure glPixelMapfv(map:TGLenum; mapsize:TGLsizei; values:PGLfloat);cdecl;external libGLEW;
procedure glPixelMapuiv(map:TGLenum; mapsize:TGLsizei; values:PGLuint);cdecl;external libGLEW;
procedure glPixelMapusv(map:TGLenum; mapsize:TGLsizei; values:PGLushort);cdecl;external libGLEW;
procedure glPixelStoref(pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glPixelStorei(pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glPixelTransferf(pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glPixelTransferi(pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glPixelZoom(xfactor:TGLfloat; yfactor:TGLfloat);cdecl;external libGLEW;
procedure glPointSize(size:TGLfloat);cdecl;external libGLEW;
procedure glPolygonMode(face:TGLenum; mode:TGLenum);cdecl;external libGLEW;
procedure glPolygonOffset(factor:TGLfloat; units:TGLfloat);cdecl;external libGLEW;
procedure glPolygonStipple(mask:PGLubyte);cdecl;external libGLEW;
procedure glPopAttrib;cdecl;external libGLEW;
procedure glPopClientAttrib;cdecl;external libGLEW;
procedure glPopMatrix;cdecl;external libGLEW;
procedure glPopName;cdecl;external libGLEW;
procedure glPrioritizeTextures(n:TGLsizei; textures:PGLuint; priorities:PGLclampf);cdecl;external libGLEW;
procedure glPushAttrib(mask:TGLbitfield);cdecl;external libGLEW;
procedure glPushClientAttrib(mask:TGLbitfield);cdecl;external libGLEW;
procedure glPushMatrix;cdecl;external libGLEW;
procedure glPushName(name:TGLuint);cdecl;external libGLEW;
procedure glRasterPos2d(x:TGLdouble; y:TGLdouble);cdecl;external libGLEW;
procedure glRasterPos2dv(v:PGLdouble);cdecl;external libGLEW;
procedure glRasterPos2f(x:TGLfloat; y:TGLfloat);cdecl;external libGLEW;
procedure glRasterPos2fv(v:PGLfloat);cdecl;external libGLEW;
procedure glRasterPos2i(x:TGLint; y:TGLint);cdecl;external libGLEW;
procedure glRasterPos2iv(v:PGLint);cdecl;external libGLEW;
procedure glRasterPos2s(x:TGLshort; y:TGLshort);cdecl;external libGLEW;
procedure glRasterPos2sv(v:PGLshort);cdecl;external libGLEW;
procedure glRasterPos3d(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external libGLEW;
procedure glRasterPos3dv(v:PGLdouble);cdecl;external libGLEW;
procedure glRasterPos3f(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external libGLEW;
procedure glRasterPos3fv(v:PGLfloat);cdecl;external libGLEW;
procedure glRasterPos3i(x:TGLint; y:TGLint; z:TGLint);cdecl;external libGLEW;
procedure glRasterPos3iv(v:PGLint);cdecl;external libGLEW;
procedure glRasterPos3s(x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external libGLEW;
procedure glRasterPos3sv(v:PGLshort);cdecl;external libGLEW;
procedure glRasterPos4d(x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external libGLEW;
procedure glRasterPos4dv(v:PGLdouble);cdecl;external libGLEW;
procedure glRasterPos4f(x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external libGLEW;
procedure glRasterPos4fv(v:PGLfloat);cdecl;external libGLEW;
procedure glRasterPos4i(x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external libGLEW;
procedure glRasterPos4iv(v:PGLint);cdecl;external libGLEW;
procedure glRasterPos4s(x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external libGLEW;
procedure glRasterPos4sv(v:PGLshort);cdecl;external libGLEW;
procedure glReadBuffer(mode:TGLenum);cdecl;external libGLEW;
procedure glReadPixels(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glRectd(x1:TGLdouble; y1:TGLdouble; x2:TGLdouble; y2:TGLdouble);cdecl;external libGLEW;
procedure glRectdv(v1:PGLdouble; v2:PGLdouble);cdecl;external libGLEW;
procedure glRectf(x1:TGLfloat; y1:TGLfloat; x2:TGLfloat; y2:TGLfloat);cdecl;external libGLEW;
procedure glRectfv(v1:PGLfloat; v2:PGLfloat);cdecl;external libGLEW;
procedure glRecti(x1:TGLint; y1:TGLint; x2:TGLint; y2:TGLint);cdecl;external libGLEW;
procedure glRectiv(v1:PGLint; v2:PGLint);cdecl;external libGLEW;
procedure glRects(x1:TGLshort; y1:TGLshort; x2:TGLshort; y2:TGLshort);cdecl;external libGLEW;
procedure glRectsv(v1:PGLshort; v2:PGLshort);cdecl;external libGLEW;
function glRenderMode(mode:TGLenum):TGLint;cdecl;external libGLEW;
procedure glRotated(angle:TGLdouble; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external libGLEW;
procedure glRotatef(angle:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external libGLEW;
procedure glScaled(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external libGLEW;
procedure glScalef(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external libGLEW;
procedure glScissor(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external libGLEW;
procedure glSelectBuffer(size:TGLsizei; buffer:PGLuint);cdecl;external libGLEW;
procedure glShadeModel(mode:TGLenum);cdecl;external libGLEW;
procedure glStencilFunc(func:TGLenum; ref:TGLint; mask:TGLuint);cdecl;external libGLEW;
procedure glStencilMask(mask:TGLuint);cdecl;external libGLEW;
procedure glStencilOp(fail:TGLenum; zfail:TGLenum; zpass:TGLenum);cdecl;external libGLEW;
procedure glTexCoord1d(s:TGLdouble);cdecl;external libGLEW;
procedure glTexCoord1dv(v:PGLdouble);cdecl;external libGLEW;
procedure glTexCoord1f(s:TGLfloat);cdecl;external libGLEW;
procedure glTexCoord1fv(v:PGLfloat);cdecl;external libGLEW;
procedure glTexCoord1i(s:TGLint);cdecl;external libGLEW;
procedure glTexCoord1iv(v:PGLint);cdecl;external libGLEW;
procedure glTexCoord1s(s:TGLshort);cdecl;external libGLEW;
procedure glTexCoord1sv(v:PGLshort);cdecl;external libGLEW;
procedure glTexCoord2d(s:TGLdouble; t:TGLdouble);cdecl;external libGLEW;
procedure glTexCoord2dv(v:PGLdouble);cdecl;external libGLEW;
procedure glTexCoord2f(s:TGLfloat; t:TGLfloat);cdecl;external libGLEW;
procedure glTexCoord2fv(v:PGLfloat);cdecl;external libGLEW;
procedure glTexCoord2i(s:TGLint; t:TGLint);cdecl;external libGLEW;
procedure glTexCoord2iv(v:PGLint);cdecl;external libGLEW;
procedure glTexCoord2s(s:TGLshort; t:TGLshort);cdecl;external libGLEW;
procedure glTexCoord2sv(v:PGLshort);cdecl;external libGLEW;
procedure glTexCoord3d(s:TGLdouble; t:TGLdouble; r:TGLdouble);cdecl;external libGLEW;
procedure glTexCoord3dv(v:PGLdouble);cdecl;external libGLEW;
procedure glTexCoord3f(s:TGLfloat; t:TGLfloat; r:TGLfloat);cdecl;external libGLEW;
procedure glTexCoord3fv(v:PGLfloat);cdecl;external libGLEW;
procedure glTexCoord3i(s:TGLint; t:TGLint; r:TGLint);cdecl;external libGLEW;
procedure glTexCoord3iv(v:PGLint);cdecl;external libGLEW;
procedure glTexCoord3s(s:TGLshort; t:TGLshort; r:TGLshort);cdecl;external libGLEW;
procedure glTexCoord3sv(v:PGLshort);cdecl;external libGLEW;
procedure glTexCoord4d(s:TGLdouble; t:TGLdouble; r:TGLdouble; q:TGLdouble);cdecl;external libGLEW;
procedure glTexCoord4dv(v:PGLdouble);cdecl;external libGLEW;
procedure glTexCoord4f(s:TGLfloat; t:TGLfloat; r:TGLfloat; q:TGLfloat);cdecl;external libGLEW;
procedure glTexCoord4fv(v:PGLfloat);cdecl;external libGLEW;
procedure glTexCoord4i(s:TGLint; t:TGLint; r:TGLint; q:TGLint);cdecl;external libGLEW;
procedure glTexCoord4iv(v:PGLint);cdecl;external libGLEW;
procedure glTexCoord4s(s:TGLshort; t:TGLshort; r:TGLshort; q:TGLshort);cdecl;external libGLEW;
procedure glTexCoord4sv(v:PGLshort);cdecl;external libGLEW;
procedure glTexCoordPointer(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glTexEnvf(target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glTexEnvfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glTexEnvi(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glTexEnviv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glTexGend(coord:TGLenum; pname:TGLenum; param:TGLdouble);cdecl;external libGLEW;
procedure glTexGendv(coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;external libGLEW;
procedure glTexGenf(coord:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glTexGenfv(coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glTexGeni(coord:TGLenum; pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glTexGeniv(coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glTexImage1D(target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; border:TGLint; 
            format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glTexImage2D(target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; height:TGLsizei; 
            border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glTexParameterf(target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external libGLEW;
procedure glTexParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external libGLEW;
procedure glTexParameteri(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external libGLEW;
procedure glTexParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external libGLEW;
procedure glTexSubImage1D(target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glTexSubImage2D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external libGLEW;
procedure glTranslated(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external libGLEW;
procedure glTranslatef(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external libGLEW;
procedure glVertex2d(x:TGLdouble; y:TGLdouble);cdecl;external libGLEW;
procedure glVertex2dv(v:PGLdouble);cdecl;external libGLEW;
procedure glVertex2f(x:TGLfloat; y:TGLfloat);cdecl;external libGLEW;
procedure glVertex2fv(v:PGLfloat);cdecl;external libGLEW;
procedure glVertex2i(x:TGLint; y:TGLint);cdecl;external libGLEW;
procedure glVertex2iv(v:PGLint);cdecl;external libGLEW;
procedure glVertex2s(x:TGLshort; y:TGLshort);cdecl;external libGLEW;
procedure glVertex2sv(v:PGLshort);cdecl;external libGLEW;
procedure glVertex3d(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external libGLEW;
procedure glVertex3dv(v:PGLdouble);cdecl;external libGLEW;
procedure glVertex3f(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external libGLEW;
procedure glVertex3fv(v:PGLfloat);cdecl;external libGLEW;
procedure glVertex3i(x:TGLint; y:TGLint; z:TGLint);cdecl;external libGLEW;
procedure glVertex3iv(v:PGLint);cdecl;external libGLEW;
procedure glVertex3s(x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external libGLEW;
procedure glVertex3sv(v:PGLshort);cdecl;external libGLEW;
procedure glVertex4d(x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external libGLEW;
procedure glVertex4dv(v:PGLdouble);cdecl;external libGLEW;
procedure glVertex4f(x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external libGLEW;
procedure glVertex4fv(v:PGLfloat);cdecl;external libGLEW;
procedure glVertex4i(x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external libGLEW;
procedure glVertex4iv(v:PGLint);cdecl;external libGLEW;
procedure glVertex4s(x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external libGLEW;
procedure glVertex4sv(v:PGLshort);cdecl;external libGLEW;
procedure glVertexPointer(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external libGLEW;
procedure glViewport(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external libGLEW;


{ ---------------------------------- GLU ----------------------------------  }

{ ----------------------------- GL_VERSION_1_2 ----------------------------  }

const
  GL_VERSION_1_2 = 1;  
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;  
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;  
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;  
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;  
  GL_UNSIGNED_BYTE_3_3_2 = $8032;  
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;  
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;  
  GL_UNSIGNED_INT_8_8_8_8 = $8035;  
  GL_UNSIGNED_INT_10_10_10_2 = $8036;  
  GL_RESCALE_NORMAL = $803A;  
  GL_TEXTURE_BINDING_3D = $806A;  
  GL_PACK_SKIP_IMAGES = $806B;  
  GL_PACK_IMAGE_HEIGHT = $806C;  
  GL_UNPACK_SKIP_IMAGES = $806D;  
  GL_UNPACK_IMAGE_HEIGHT = $806E;  
  GL_TEXTURE_3D = $806F;  
  GL_PROXY_TEXTURE_3D = $8070;  
  GL_TEXTURE_DEPTH = $8071;  
  GL_TEXTURE_WRAP_R = $8072;  
  GL_MAX_3D_TEXTURE_SIZE = $8073;  
  GL_BGR = $80E0;  
  GL_BGRA = $80E1;  
  GL_MAX_ELEMENTS_VERTICES = $80E8;  
  GL_MAX_ELEMENTS_INDICES = $80E9;  
  GL_CLAMP_TO_EDGE = $812F;  
  GL_TEXTURE_MIN_LOD = $813A;  
  GL_TEXTURE_MAX_LOD = $813B;  
  GL_TEXTURE_BASE_LEVEL = $813C;  
  GL_TEXTURE_MAX_LEVEL = $813D;  
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;  
  GL_SINGLE_COLOR = $81F9;  
  GL_SEPARATE_SPECULAR_COLOR = $81FA;  
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;  
  GL_UNSIGNED_SHORT_5_6_5 = $8363;  
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;  
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;  
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;  
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;  
  GL_ALIASED_POINT_SIZE_RANGE = $846D;  
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;  
type
  TPFNGLCOPYTEXSUBIMAGE3DPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLDRAWRANGEELEMENTSPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum;
                indices:pointer);cdecl;
  TPFNGLTEXIMAGE3DPROC = procedure (target:TGLenum; level:TGLint; internalFormat:TGLint; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE3DPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;


{ ---------------------------- GL_VERSION_1_2_1 ---------------------------  }

const
  GL_VERSION_1_2_1 = 1;


{ ----------------------------- GL_VERSION_1_3 ----------------------------  }

const
  GL_VERSION_1_3 = 1;  
  GL_MULTISAMPLE = $809D;  
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;  
  GL_SAMPLE_ALPHA_TO_ONE = $809F;  
  GL_SAMPLE_COVERAGE = $80A0;  
  GL_SAMPLE_BUFFERS = $80A8;  
  GL_SAMPLES = $80A9;  
  GL_SAMPLE_COVERAGE_VALUE = $80AA;  
  GL_SAMPLE_COVERAGE_INVERT = $80AB;  
  GL_CLAMP_TO_BORDER = $812D;  
  GL_TEXTURE0 = $84C0;  
  GL_TEXTURE1 = $84C1;  
  GL_TEXTURE2 = $84C2;  
  GL_TEXTURE3 = $84C3;  
  GL_TEXTURE4 = $84C4;  
  GL_TEXTURE5 = $84C5;  
  GL_TEXTURE6 = $84C6;  
  GL_TEXTURE7 = $84C7;  
  GL_TEXTURE8 = $84C8;  
  GL_TEXTURE9 = $84C9;  
  GL_TEXTURE10 = $84CA;  
  GL_TEXTURE11 = $84CB;  
  GL_TEXTURE12 = $84CC;  
  GL_TEXTURE13 = $84CD;  
  GL_TEXTURE14 = $84CE;  
  GL_TEXTURE15 = $84CF;  
  GL_TEXTURE16 = $84D0;  
  GL_TEXTURE17 = $84D1;  
  GL_TEXTURE18 = $84D2;  
  GL_TEXTURE19 = $84D3;  
  GL_TEXTURE20 = $84D4;  
  GL_TEXTURE21 = $84D5;  
  GL_TEXTURE22 = $84D6;  
  GL_TEXTURE23 = $84D7;  
  GL_TEXTURE24 = $84D8;  
  GL_TEXTURE25 = $84D9;  
  GL_TEXTURE26 = $84DA;  
  GL_TEXTURE27 = $84DB;  
  GL_TEXTURE28 = $84DC;  
  GL_TEXTURE29 = $84DD;  
  GL_TEXTURE30 = $84DE;  
  GL_TEXTURE31 = $84DF;  
  GL_ACTIVE_TEXTURE = $84E0;  
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;  
  GL_MAX_TEXTURE_UNITS = $84E2;  
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;  
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;  
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;  
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;  
  GL_SUBTRACT = $84E7;  
  GL_COMPRESSED_ALPHA = $84E9;  
  GL_COMPRESSED_LUMINANCE = $84EA;  
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;  
  GL_COMPRESSED_INTENSITY = $84EC;  
  GL_COMPRESSED_RGB = $84ED;  
  GL_COMPRESSED_RGBA = $84EE;  
  GL_TEXTURE_COMPRESSION_HINT = $84EF;  
  GL_NORMAL_MAP = $8511;  
  GL_REFLECTION_MAP = $8512;  
  GL_TEXTURE_CUBE_MAP = $8513;  
  GL_TEXTURE_BINDING_CUBE_MAP = $8514;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A;  
  GL_PROXY_TEXTURE_CUBE_MAP = $851B;  
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C;  
  GL_COMBINE = $8570;  
  GL_COMBINE_RGB = $8571;  
  GL_COMBINE_ALPHA = $8572;  
  GL_RGB_SCALE = $8573;  
  GL_ADD_SIGNED = $8574;  
  GL_INTERPOLATE = $8575;  
  GL_CONSTANT = $8576;  
  GL_PRIMARY_COLOR = $8577;  
  GL_PREVIOUS = $8578;  
  GL_SOURCE0_RGB = $8580;  
  GL_SOURCE1_RGB = $8581;  
  GL_SOURCE2_RGB = $8582;  
  GL_SOURCE0_ALPHA = $8588;  
  GL_SOURCE1_ALPHA = $8589;  
  GL_SOURCE2_ALPHA = $858A;  
  GL_OPERAND0_RGB = $8590;  
  GL_OPERAND1_RGB = $8591;  
  GL_OPERAND2_RGB = $8592;  
  GL_OPERAND0_ALPHA = $8598;  
  GL_OPERAND1_ALPHA = $8599;  
  GL_OPERAND2_ALPHA = $859A;  
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;  
  GL_TEXTURE_COMPRESSED = $86A1;  
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;  
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;  
  GL_DOT3_RGB = $86AE;  
  GL_DOT3_RGBA = $86AF;  
  GL_MULTISAMPLE_BIT = $20000000;  
type
  TPFNGLACTIVETEXTUREPROC = procedure (texture:TGLenum);cdecl;
  TPFNGLCLIENTACTIVETEXTUREPROC = procedure (texture:TGLenum);cdecl;
  TPFNGLCOMPRESSEDTEXIMAGE1DPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; border:TGLint;
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXIMAGE2DPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXIMAGE3DPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE1DPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum;
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE2DPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei;
                height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE3DPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
                data:pointer);cdecl;
  TPFNGLGETCOMPRESSEDTEXIMAGEPROC = procedure (target:TGLenum; lod:TGLint; img:pointer);cdecl;
  TPFNGLLOADTRANSPOSEMATRIXDPROC = procedure (m:TdMatrix4x4);cdecl;
  TPFNGLLOADTRANSPOSEMATRIXFPROC = procedure (m:TfMatrix4x4);cdecl;
  TPFNGLMULTTRANSPOSEMATRIXDPROC = procedure (m:TdMatrix4x4);cdecl;
  TPFNGLMULTTRANSPOSEMATRIXFPROC = procedure (m:TfMatrix4x4);cdecl;
  TPFNGLMULTITEXCOORD1DPROC = procedure (target:TGLenum; s:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD1DVPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD1FPROC = procedure (target:TGLenum; s:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD1FVPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD1IPROC = procedure (target:TGLenum; s:TGLint);cdecl;
  TPFNGLMULTITEXCOORD1IVPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD1SPROC = procedure (target:TGLenum; s:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD1SVPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD2DPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD2DVPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD2FPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD2FVPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD2IPROC = procedure (target:TGLenum; s:TGLint; t:TGLint);cdecl;
  TPFNGLMULTITEXCOORD2IVPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD2SPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD2SVPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD3DPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD3DVPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD3FPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD3FVPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD3IPROC = procedure (target:TGLenum; s:TGLint; t:TGLint; r:TGLint);cdecl;
  TPFNGLMULTITEXCOORD3IVPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD3SPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD3SVPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD4DPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble; q:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD4DVPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD4FPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat; q:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD4FVPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD4IPROC = procedure (target:TGLenum; s:TGLint; t:TGLint; r:TGLint; q:TGLint);cdecl;
  TPFNGLMULTITEXCOORD4IVPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD4SPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort; q:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD4SVPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLSAMPLECOVERAGEPROC = procedure (value:TGLclampf; invert:TGLboolean);cdecl;


{ ----------------------------- GL_VERSION_1_4 ----------------------------  }

const
  GL_VERSION_1_4 = 1;  
  GL_BLEND_DST_RGB = $80C8;  
  GL_BLEND_SRC_RGB = $80C9;  
  GL_BLEND_DST_ALPHA = $80CA;  
  GL_BLEND_SRC_ALPHA = $80CB;  
  GL_POINT_SIZE_MIN = $8126;  
  GL_POINT_SIZE_MAX = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;  
  GL_POINT_DISTANCE_ATTENUATION = $8129;  
  GL_GENERATE_MIPMAP = $8191;  
  GL_GENERATE_MIPMAP_HINT = $8192;  
  GL_DEPTH_COMPONENT16 = $81A5;  
  GL_DEPTH_COMPONENT24 = $81A6;  
  GL_DEPTH_COMPONENT32 = $81A7;  
  GL_MIRRORED_REPEAT = $8370;  
  GL_FOG_COORDINATE_SOURCE = $8450;  
  GL_FOG_COORDINATE = $8451;  
  GL_FRAGMENT_DEPTH = $8452;  
  GL_CURRENT_FOG_COORDINATE = $8453;  
  GL_FOG_COORDINATE_ARRAY_TYPE = $8454;  
  GL_FOG_COORDINATE_ARRAY_STRIDE = $8455;  
  GL_FOG_COORDINATE_ARRAY_POINTER = $8456;  
  GL_FOG_COORDINATE_ARRAY = $8457;  
  GL_COLOR_SUM = $8458;  
  GL_CURRENT_SECONDARY_COLOR = $8459;  
  GL_SECONDARY_COLOR_ARRAY_SIZE = $845A;  
  GL_SECONDARY_COLOR_ARRAY_TYPE = $845B;  
  GL_SECONDARY_COLOR_ARRAY_STRIDE = $845C;  
  GL_SECONDARY_COLOR_ARRAY_POINTER = $845D;  
  GL_SECONDARY_COLOR_ARRAY = $845E;  
  GL_MAX_TEXTURE_LOD_BIAS = $84FD;  
  GL_TEXTURE_FILTER_CONTROL = $8500;  
  GL_TEXTURE_LOD_BIAS = $8501;  
  GL_INCR_WRAP = $8507;  
  GL_DECR_WRAP = $8508;  
  GL_TEXTURE_DEPTH_SIZE = $884A;  
  GL_DEPTH_TEXTURE_MODE = $884B;  
  GL_TEXTURE_COMPARE_MODE = $884C;  
  GL_TEXTURE_COMPARE_FUNC = $884D;  
  GL_COMPARE_R_TO_TEXTURE = $884E;  
type
  TPFNGLBLENDCOLORPROC = procedure (red:TGLclampf; green:TGLclampf; blue:TGLclampf; alpha:TGLclampf);cdecl;
  TPFNGLBLENDEQUATIONPROC = procedure (mode:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEPROC = procedure (sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;
  TPFNGLFOGCOORDPOINTERPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLFOGCOORDDPROC = procedure (coord:TGLdouble);cdecl;
  TPFNGLFOGCOORDDVPROC = procedure (coord:PGLdouble);cdecl;
  TPFNGLFOGCOORDFPROC = procedure (coord:TGLfloat);cdecl;
  TPFNGLFOGCOORDFVPROC = procedure (coord:PGLfloat);cdecl;
  TPFNGLMULTIDRAWARRAYSPROC = procedure (mode:TGLenum; first:PGLint; count:PGLsizei; drawcount:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSPROC = procedure (mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; drawcount:TGLsizei);cdecl;
  TPFNGLPOINTPARAMETERFPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPOINTPARAMETERFVPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLPOINTPARAMETERIPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLPOINTPARAMETERIVPROC = procedure (pname:TGLenum; params:PGLint);cdecl;
  TPFNGLSECONDARYCOLOR3BPROC = procedure (red:TGLbyte; green:TGLbyte; blue:TGLbyte);cdecl;
  TPFNGLSECONDARYCOLOR3BVPROC = procedure (v:PGLbyte);cdecl;
  TPFNGLSECONDARYCOLOR3DPROC = procedure (red:TGLdouble; green:TGLdouble; blue:TGLdouble);cdecl;
  TPFNGLSECONDARYCOLOR3DVPROC = procedure (v:PGLdouble);cdecl;
  TPFNGLSECONDARYCOLOR3FPROC = procedure (red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;
  TPFNGLSECONDARYCOLOR3FVPROC = procedure (v:PGLfloat);cdecl;
  TPFNGLSECONDARYCOLOR3IPROC = procedure (red:TGLint; green:TGLint; blue:TGLint);cdecl;
  TPFNGLSECONDARYCOLOR3IVPROC = procedure (v:PGLint);cdecl;
  TPFNGLSECONDARYCOLOR3SPROC = procedure (red:TGLshort; green:TGLshort; blue:TGLshort);cdecl;
  TPFNGLSECONDARYCOLOR3SVPROC = procedure (v:PGLshort);cdecl;
  TPFNGLSECONDARYCOLOR3UBPROC = procedure (red:TGLubyte; green:TGLubyte; blue:TGLubyte);cdecl;
  TPFNGLSECONDARYCOLOR3UBVPROC = procedure (v:PGLubyte);cdecl;
  TPFNGLSECONDARYCOLOR3UIPROC = procedure (red:TGLuint; green:TGLuint; blue:TGLuint);cdecl;
  TPFNGLSECONDARYCOLOR3UIVPROC = procedure (v:PGLuint);cdecl;
  TPFNGLSECONDARYCOLOR3USPROC = procedure (red:TGLushort; green:TGLushort; blue:TGLushort);cdecl;
  TPFNGLSECONDARYCOLOR3USVPROC = procedure (v:PGLushort);cdecl;
  TPFNGLSECONDARYCOLORPOINTERPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLWINDOWPOS2DPROC = procedure (x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLWINDOWPOS2DVPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS2FPROC = procedure (x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLWINDOWPOS2FVPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS2IPROC = procedure (x:TGLint; y:TGLint);cdecl;
  TPFNGLWINDOWPOS2IVPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS2SPROC = procedure (x:TGLshort; y:TGLshort);cdecl;
  TPFNGLWINDOWPOS2SVPROC = procedure (p:PGLshort);cdecl;
  TPFNGLWINDOWPOS3DPROC = procedure (x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLWINDOWPOS3DVPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS3FPROC = procedure (x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLWINDOWPOS3FVPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS3IPROC = procedure (x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLWINDOWPOS3IVPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS3SPROC = procedure (x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLWINDOWPOS3SVPROC = procedure (p:PGLshort);cdecl;


{ ----------------------------- GL_VERSION_1_5 ----------------------------  }

const
  GL_VERSION_1_5 = 1;  
  GL_CURRENT_FOG_COORD = GL_CURRENT_FOG_COORDINATE;  
  GL_FOG_COORD = GL_FOG_COORDINATE;  
  GL_FOG_COORD_ARRAY = GL_FOG_COORDINATE_ARRAY;  
  GL_FOG_COORD_ARRAY_BUFFER_BINDING = $889D; // = GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING;
  GL_FOG_COORD_ARRAY_POINTER = GL_FOG_COORDINATE_ARRAY_POINTER;  
  GL_FOG_COORD_ARRAY_STRIDE = GL_FOG_COORDINATE_ARRAY_STRIDE;  
  GL_FOG_COORD_ARRAY_TYPE = GL_FOG_COORDINATE_ARRAY_TYPE;  
  GL_FOG_COORD_SRC = GL_FOG_COORDINATE_SOURCE;  
  GL_SRC0_ALPHA = GL_SOURCE0_ALPHA;  
  GL_SRC0_RGB = GL_SOURCE0_RGB;  
  GL_SRC1_ALPHA = GL_SOURCE1_ALPHA;  
  GL_SRC1_RGB = GL_SOURCE1_RGB;  
  GL_SRC2_ALPHA = GL_SOURCE2_ALPHA;  
  GL_SRC2_RGB = GL_SOURCE2_RGB;  
  GL_BUFFER_SIZE = $8764;  
  GL_BUFFER_USAGE = $8765;  
  GL_QUERY_COUNTER_BITS = $8864;  
  GL_CURRENT_QUERY = $8865;  
  GL_QUERY_RESULT = $8866;  
  GL_QUERY_RESULT_AVAILABLE = $8867;  
  GL_ARRAY_BUFFER = $8892;  
  GL_ELEMENT_ARRAY_BUFFER = $8893;  
  GL_ARRAY_BUFFER_BINDING = $8894;  
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895;  
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;  
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;  
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;  
  GL_INDEX_ARRAY_BUFFER_BINDING = $8899;  
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;  
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B;  
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C;  
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D;  
  GL_WEIGHT_ARRAY_BUFFER_BINDING = $889E;  
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F;  
  GL_READ_ONLY = $88B8;  
  GL_WRITE_ONLY = $88B9;  
  GL_READ_WRITE = $88BA;  
  GL_BUFFER_ACCESS = $88BB;  
  GL_BUFFER_MAPPED = $88BC;  
  GL_BUFFER_MAP_POINTER = $88BD;  
  GL_STREAM_DRAW = $88E0;  
  GL_STREAM_READ = $88E1;  
  GL_STREAM_COPY = $88E2;  
  GL_STATIC_DRAW = $88E4;  
  GL_STATIC_READ = $88E5;  
  GL_STATIC_COPY = $88E6;  
  GL_DYNAMIC_DRAW = $88E8;  
  GL_DYNAMIC_READ = $88E9;  
  GL_DYNAMIC_COPY = $88EA;  
  GL_SAMPLES_PASSED = $8914;  
type
  PGLintptr = ^TGLintptr;
  TGLintptr = Tptrdiff_t;

  PGLsizeiptr = ^TGLsizeiptr;
  TGLsizeiptr = Tptrdiff_t;

  TPFNGLBEGINQUERYPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLBINDBUFFERPROC = procedure (target:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLBUFFERDATAPROC = procedure (target:TGLenum; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;
 TPFNGLBUFFERSUBDATAPROC = procedure (target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLDELETEBUFFERSPROC = procedure (n:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLDELETEQUERIESPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLENDQUERYPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGENBUFFERSPROC = procedure (n:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLGENQUERIESPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETBUFFERPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETBUFFERPOINTERVPROC = procedure (target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLGETBUFFERSUBDATAPROC = procedure (target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLGETQUERYOBJECTIVPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETQUERYOBJECTUIVPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETQUERYIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISBUFFERPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLISQUERYPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLMAPBUFFERPROC = function (target:TGLenum; access:TGLenum):pointer;cdecl;
  TPFNGLUNMAPBUFFERPROC = function (target:TGLenum):TGLboolean;cdecl;


{ ----------------------------- GL_VERSION_2_0 ----------------------------  }

const
  GL_VERSION_2_0 = 1;  
  GL_BLEND_EQUATION_RGB = $8009; // = GL_BLEND_EQUATION;
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622;  
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623;  
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624;  
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625;  
  GL_CURRENT_VERTEX_ATTRIB = $8626;  
  GL_VERTEX_PROGRAM_POINT_SIZE = $8642;  
  GL_VERTEX_PROGRAM_TWO_SIDE = $8643;  
  GL_VERTEX_ATTRIB_ARRAY_POINTER = $8645;  
  GL_STENCIL_BACK_FUNC = $8800;  
  GL_STENCIL_BACK_FAIL = $8801;  
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = $8802;  
  GL_STENCIL_BACK_PASS_DEPTH_PASS = $8803;  
  GL_MAX_DRAW_BUFFERS = $8824;  
  GL_DRAW_BUFFER0 = $8825;  
  GL_DRAW_BUFFER1 = $8826;  
  GL_DRAW_BUFFER2 = $8827;  
  GL_DRAW_BUFFER3 = $8828;  
  GL_DRAW_BUFFER4 = $8829;  
  GL_DRAW_BUFFER5 = $882A;  
  GL_DRAW_BUFFER6 = $882B;  
  GL_DRAW_BUFFER7 = $882C;  
  GL_DRAW_BUFFER8 = $882D;  
  GL_DRAW_BUFFER9 = $882E;  
  GL_DRAW_BUFFER10 = $882F;  
  GL_DRAW_BUFFER11 = $8830;  
  GL_DRAW_BUFFER12 = $8831;  
  GL_DRAW_BUFFER13 = $8832;  
  GL_DRAW_BUFFER14 = $8833;  
  GL_DRAW_BUFFER15 = $8834;  
  GL_BLEND_EQUATION_ALPHA = $883D;  
  GL_POINT_SPRITE = $8861;  
  GL_COORD_REPLACE = $8862;  
  GL_MAX_VERTEX_ATTRIBS = $8869;  
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A;  
  GL_MAX_TEXTURE_COORDS = $8871;  
  GL_MAX_TEXTURE_IMAGE_UNITS = $8872;  
  GL_FRAGMENT_SHADER = $8B30;  
  GL_VERTEX_SHADER = $8B31;  
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = $8B49;  
  GL_MAX_VERTEX_UNIFORM_COMPONENTS = $8B4A;  
  GL_MAX_VARYING_FLOATS = $8B4B;  
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C;  
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D;  
  GL_SHADER_TYPE = $8B4F;  
  GL_FLOAT_VEC2 = $8B50;  
  GL_FLOAT_VEC3 = $8B51;  
  GL_FLOAT_VEC4 = $8B52;  
  GL_INT_VEC2 = $8B53;  
  GL_INT_VEC3 = $8B54;  
  GL_INT_VEC4 = $8B55;  
  GL_BOOL = $8B56;  
  GL_BOOL_VEC2 = $8B57;  
  GL_BOOL_VEC3 = $8B58;  
  GL_BOOL_VEC4 = $8B59;  
  GL_FLOAT_MAT2 = $8B5A;  
  GL_FLOAT_MAT3 = $8B5B;  
  GL_FLOAT_MAT4 = $8B5C;  
  GL_SAMPLER_1D = $8B5D;  
  GL_SAMPLER_2D = $8B5E;  
  GL_SAMPLER_3D = $8B5F;  
  GL_SAMPLER_CUBE = $8B60;  
  GL_SAMPLER_1D_SHADOW = $8B61;  
  GL_SAMPLER_2D_SHADOW = $8B62;  
  GL_DELETE_STATUS = $8B80;  
  GL_COMPILE_STATUS = $8B81;  
  GL_LINK_STATUS = $8B82;  
  GL_VALIDATE_STATUS = $8B83;  
  GL_INFO_LOG_LENGTH = $8B84;  
  GL_ATTACHED_SHADERS = $8B85;  
  GL_ACTIVE_UNIFORMS = $8B86;  
  GL_ACTIVE_UNIFORM_MAX_LENGTH = $8B87;  
  GL_SHADER_SOURCE_LENGTH = $8B88;  
  GL_ACTIVE_ATTRIBUTES = $8B89;  
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A;  
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT = $8B8B;  
  GL_SHADING_LANGUAGE_VERSION = $8B8C;  
  GL_CURRENT_PROGRAM = $8B8D;  
  GL_POINT_SPRITE_COORD_ORIGIN = $8CA0;  
  GL_LOWER_LEFT = $8CA1;  
  GL_UPPER_LEFT = $8CA2;  
  GL_STENCIL_BACK_REF = $8CA3;  
  GL_STENCIL_BACK_VALUE_MASK = $8CA4;  
  GL_STENCIL_BACK_WRITEMASK = $8CA5;  
type
  TPFNGLATTACHSHADERPROC = procedure (prog:TGLuint; shader:TGLuint);cdecl;
  TPFNGLBINDATTRIBLOCATIONPROC = procedure (progr:TGLuint; index:TGLuint; name:PGLchar);cdecl;
  TPFNGLBLENDEQUATIONSEPARATEPROC = procedure (modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLCOMPILESHADERPROC = procedure (shader:TGLuint);cdecl;
  TPFNGLCREATEPROGRAMPROC = function (para1:pointer):TGLuint;cdecl;
  TPFNGLCREATESHADERPROC = function (_type:TGLenum):TGLuint;cdecl;
  TPFNGLDELETEPROGRAMPROC = procedure (prog:TGLuint);cdecl;
  TPFNGLDELETESHADERPROC = procedure (shader:TGLuint);cdecl;
  TPFNGLDETACHSHADERPROC = procedure (prog:TGLuint; shader:TGLuint);cdecl;
  TPFNGLDISABLEVERTEXATTRIBARRAYPROC = procedure (index:TGLuint);cdecl;
  TPFNGLDRAWBUFFERSPROC = procedure (n:TGLsizei; bufs:PGLenum);cdecl;
  TPFNGLENABLEVERTEXATTRIBARRAYPROC = procedure (index:TGLuint);cdecl;
  TPFNGLGETACTIVEATTRIBPROC = procedure (prog:TGLuint; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint;
                _type:PGLenum; name:PGLchar);cdecl;
  TPFNGLGETACTIVEUNIFORMPROC = procedure (prog:TGLuint; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint;
                _type:PGLenum; name:PGLchar);cdecl;
  TPFNGLGETATTACHEDSHADERSPROC = procedure (prog:TGLuint; maxCount:TGLsizei; count:PGLsizei; shaders:PGLuint);cdecl;
  TPFNGLGETATTRIBLOCATIONPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLGETPROGRAMINFOLOGPROC = procedure (prog:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;
  TPFNGLGETPROGRAMIVPROC = procedure (prog:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETSHADERINFOLOGPROC = procedure (shader:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;
  TPFNGLGETSHADERSOURCEPROC = procedure (obj:TGLuint; maxLength:TGLsizei; length:PGLsizei; source:PGLchar);cdecl;
  TPFNGLGETSHADERIVPROC = procedure (shader:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETUNIFORMLOCATIONPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLGETUNIFORMFVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLfloat);cdecl;
  TPFNGLGETUNIFORMIVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLint);cdecl;
  TPFNGLGETVERTEXATTRIBPOINTERVPROC = procedure (index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLGETVERTEXATTRIBDVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETVERTEXATTRIBFVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVERTEXATTRIBIVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISPROGRAMPROC = function (prog:TGLuint):TGLboolean;cdecl;
  TPFNGLISSHADERPROC = function (shader:TGLuint):TGLboolean;cdecl;
  TPFNGLLINKPROGRAMPROC = procedure (prog:TGLuint);cdecl;
  TPFNGLSHADERSOURCEPROC = procedure (shader:TGLuint; count:TGLsizei; _string:PPGLchar; length:PGLint);cdecl;
  TPFNGLSTENCILFUNCSEPARATEPROC = procedure (face:TGLenum; func:TGLenum; ref:TGLint; mask:TGLuint);cdecl;
  TPFNGLSTENCILMASKSEPARATEPROC = procedure (face:TGLenum; mask:TGLuint);cdecl;
  TPFNGLSTENCILOPSEPARATEPROC = procedure (face:TGLenum; sfail:TGLenum; dpfail:TGLenum; dppass:TGLenum);cdecl;
  TPFNGLUNIFORM1FPROC = procedure (location:TGLint; v0:TGLfloat);cdecl;
  TPFNGLUNIFORM1FVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM1IPROC = procedure (location:TGLint; v0:TGLint);cdecl;
  TPFNGLUNIFORM1IVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM2FPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;
  TPFNGLUNIFORM2FVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM2IPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint);cdecl;
  TPFNGLUNIFORM2IVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM3FPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;
  TPFNGLUNIFORM3FVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM3IPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;
  TPFNGLUNIFORM3IVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM4FPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; v3:TGLfloat);cdecl;
  TPFNGLUNIFORM4FVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM4IPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; v3:TGLint);cdecl;
  TPFNGLUNIFORM4IVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORMMATRIX2FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUSEPROGRAMPROC = procedure (prog:TGLuint);cdecl;
  TPFNGLVALIDATEPROGRAMPROC = procedure (prog:TGLuint);cdecl;
  TPFNGLVERTEXATTRIB1DPROC = procedure (index:TGLuint; x:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1FPROC = procedure (index:TGLuint; x:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1FVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1SPROC = procedure (index:TGLuint; x:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB1SVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB2DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2FPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2FVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2SPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB2SVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB3DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3FPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3FVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3SPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB3SVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4NBVPROC = procedure (index:TGLuint; v:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIB4NIVPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIB4NSVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4NUBPROC = procedure (index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4NUBVPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4NUIVPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIB4NUSVPROC = procedure (index:TGLuint; v:PGLushort);cdecl;
  TPFNGLVERTEXATTRIB4BVPROC = procedure (index:TGLuint; v:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIB4DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4FPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4FVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4IVPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIB4SPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB4SVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4UBVPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4UIVPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIB4USVPROC = procedure (index:TGLuint; v:PGLushort);cdecl;
  TPFNGLVERTEXATTRIBPOINTERPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei;                pointer:pointer);cdecl;


{ ----------------------------- GL_VERSION_2_1 ----------------------------  }

const
  GL_VERSION_2_1 = 1;  
  GL_CURRENT_RASTER_SECONDARY_COLOR = $845F;  
  GL_PIXEL_PACK_BUFFER = $88EB;  
  GL_PIXEL_UNPACK_BUFFER = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING = $88EF;  
  GL_FLOAT_MAT2x3 = $8B65;  
  GL_FLOAT_MAT2x4 = $8B66;  
  GL_FLOAT_MAT3x2 = $8B67;  
  GL_FLOAT_MAT3x4 = $8B68;  
  GL_FLOAT_MAT4x2 = $8B69;  
  GL_FLOAT_MAT4x3 = $8B6A;  
  GL_SRGB = $8C40;  
  GL_SRGB8 = $8C41;  
  GL_SRGB_ALPHA = $8C42;  
  GL_SRGB8_ALPHA8 = $8C43;  
  GL_SLUMINANCE_ALPHA = $8C44;  
  GL_SLUMINANCE8_ALPHA8 = $8C45;  
  GL_SLUMINANCE = $8C46;  
  GL_SLUMINANCE8 = $8C47;  
  GL_COMPRESSED_SRGB = $8C48;  
  GL_COMPRESSED_SRGB_ALPHA = $8C49;  
  GL_COMPRESSED_SLUMINANCE = $8C4A;  
  GL_COMPRESSED_SLUMINANCE_ALPHA = $8C4B;  
type
  TPFNGLUNIFORMMATRIX2X3FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX2X4FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3X2FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3X4FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4X2FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4X3FVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;


{ ----------------------------- GL_VERSION_3_0 ----------------------------  }

const
  GL_VERSION_3_0 = 1;  
  GL_CLIP_DISTANCE0 = GL_CLIP_PLANE0;  
  GL_CLIP_DISTANCE1 = GL_CLIP_PLANE1;  
  GL_CLIP_DISTANCE2 = GL_CLIP_PLANE2;  
  GL_CLIP_DISTANCE3 = GL_CLIP_PLANE3;  
  GL_CLIP_DISTANCE4 = GL_CLIP_PLANE4;  
  GL_CLIP_DISTANCE5 = GL_CLIP_PLANE5;  
  GL_COMPARE_REF_TO_TEXTURE = $884E; // = GL_COMPARE_R_TO_TEXTURE_ARB;
  GL_MAX_CLIP_DISTANCES = GL_MAX_CLIP_PLANES;  
  GL_MAX_VARYING_COMPONENTS = GL_MAX_VARYING_FLOATS;  
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = $0001;  
  GL_MAJOR_VERSION = $821B;  
  GL_MINOR_VERSION = $821C;  
  GL_NUM_EXTENSIONS = $821D;  
  GL_CONTEXT_FLAGS = $821E;  
  GL_DEPTH_BUFFER = $8223;  
  GL_STENCIL_BUFFER = $8224;  
  GL_RGBA32F = $8814;  
  GL_RGB32F = $8815;  
  GL_RGBA16F = $881A;  
  GL_RGB16F = $881B;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER = $88FD;  
  GL_MAX_ARRAY_TEXTURE_LAYERS = $88FF;  
  GL_MIN_PROGRAM_TEXEL_OFFSET = $8904;  
  GL_MAX_PROGRAM_TEXEL_OFFSET = $8905;  
  GL_CLAMP_VERTEX_COLOR = $891A;  
  GL_CLAMP_FRAGMENT_COLOR = $891B;  
  GL_CLAMP_READ_COLOR = $891C;  
  GL_FIXED_ONLY = $891D;  
  GL_TEXTURE_RED_TYPE = $8C10;  
  GL_TEXTURE_GREEN_TYPE = $8C11;  
  GL_TEXTURE_BLUE_TYPE = $8C12;  
  GL_TEXTURE_ALPHA_TYPE = $8C13;  
  GL_TEXTURE_LUMINANCE_TYPE = $8C14;  
  GL_TEXTURE_INTENSITY_TYPE = $8C15;  
  GL_TEXTURE_DEPTH_TYPE = $8C16;  
  GL_TEXTURE_1D_ARRAY = $8C18;  
  GL_PROXY_TEXTURE_1D_ARRAY = $8C19;  
  GL_TEXTURE_2D_ARRAY = $8C1A;  
  GL_PROXY_TEXTURE_2D_ARRAY = $8C1B;  
  GL_TEXTURE_BINDING_1D_ARRAY = $8C1C;  
  GL_TEXTURE_BINDING_2D_ARRAY = $8C1D;  
  GL_R11F_G11F_B10F = $8C3A;  
  GL_UNSIGNED_INT_10F_11F_11F_REV = $8C3B;  
  GL_RGB9_E5 = $8C3D;  
  GL_UNSIGNED_INT_5_9_9_9_REV = $8C3E;  
  GL_TEXTURE_SHARED_SIZE = $8C3F;  
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = $8C76;  
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE = $8C7F;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = $8C80;  
  GL_TRANSFORM_FEEDBACK_VARYINGS = $8C83;  
  GL_TRANSFORM_FEEDBACK_BUFFER_START = $8C84;  
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = $8C85;  
  GL_PRIMITIVES_GENERATED = $8C87;  
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = $8C88;  
  GL_RASTERIZER_DISCARD = $8C89;  
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = $8C8A;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = $8C8B;  
  GL_INTERLEAVED_ATTRIBS = $8C8C;  
  GL_SEPARATE_ATTRIBS = $8C8D;  
  GL_TRANSFORM_FEEDBACK_BUFFER = $8C8E;  
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = $8C8F;  
  GL_RGBA32UI = $8D70;  
  GL_RGB32UI = $8D71;  
  GL_RGBA16UI = $8D76;  
  GL_RGB16UI = $8D77;  
  GL_RGBA8UI = $8D7C;  
  GL_RGB8UI = $8D7D;  
  GL_RGBA32I = $8D82;  
  GL_RGB32I = $8D83;  
  GL_RGBA16I = $8D88;  
  GL_RGB16I = $8D89;  
  GL_RGBA8I = $8D8E;  
  GL_RGB8I = $8D8F;  
  GL_RED_INTEGER = $8D94;  
  GL_GREEN_INTEGER = $8D95;  
  GL_BLUE_INTEGER = $8D96;  
  GL_ALPHA_INTEGER = $8D97;  
  GL_RGB_INTEGER = $8D98;  
  GL_RGBA_INTEGER = $8D99;  
  GL_BGR_INTEGER = $8D9A;  
  GL_BGRA_INTEGER = $8D9B;  
  GL_SAMPLER_1D_ARRAY = $8DC0;  
  GL_SAMPLER_2D_ARRAY = $8DC1;  
  GL_SAMPLER_1D_ARRAY_SHADOW = $8DC3;  
  GL_SAMPLER_2D_ARRAY_SHADOW = $8DC4;  
  GL_SAMPLER_CUBE_SHADOW = $8DC5;  
  GL_UNSIGNED_INT_VEC2 = $8DC6;  
  GL_UNSIGNED_INT_VEC3 = $8DC7;  
  GL_UNSIGNED_INT_VEC4 = $8DC8;  
  GL_INT_SAMPLER_1D = $8DC9;  
  GL_INT_SAMPLER_2D = $8DCA;  
  GL_INT_SAMPLER_3D = $8DCB;  
  GL_INT_SAMPLER_CUBE = $8DCC;  
  GL_INT_SAMPLER_1D_ARRAY = $8DCE;  
  GL_INT_SAMPLER_2D_ARRAY = $8DCF;  
  GL_UNSIGNED_INT_SAMPLER_1D = $8DD1;  
  GL_UNSIGNED_INT_SAMPLER_2D = $8DD2;  
  GL_UNSIGNED_INT_SAMPLER_3D = $8DD3;  
  GL_UNSIGNED_INT_SAMPLER_CUBE = $8DD4;  
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = $8DD6;  
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = $8DD7;  
  GL_QUERY_WAIT = $8E13;  
  GL_QUERY_NO_WAIT = $8E14;  
  GL_QUERY_BY_REGION_WAIT = $8E15;  
  GL_QUERY_BY_REGION_NO_WAIT = $8E16;  
type
  TPFNGLBEGINCONDITIONALRENDERPROC = procedure (id:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBEGINTRANSFORMFEEDBACKPROC = procedure (primitiveMode:TGLenum);cdecl;
  TPFNGLBINDFRAGDATALOCATIONPROC = procedure (prog:TGLuint; colorNumber:TGLuint; name:PGLchar);cdecl;
  TPFNGLCLAMPCOLORPROC = procedure (target:TGLenum; clamp:TGLenum);cdecl;
  TPFNGLCLEARBUFFERFIPROC = procedure (buffer:TGLenum; drawBuffer:TGLint; depth:TGLfloat; stencil:TGLint);cdecl;
  TPFNGLCLEARBUFFERFVPROC = procedure (buffer:TGLenum; drawBuffer:TGLint; value:PGLfloat);cdecl;
  TPFNGLCLEARBUFFERIVPROC = procedure (buffer:TGLenum; drawBuffer:TGLint; value:PGLint);cdecl;
  TPFNGLCLEARBUFFERUIVPROC = procedure (buffer:TGLenum; drawBuffer:TGLint; value:PGLuint);cdecl;
  TPFNGLCOLORMASKIPROC = procedure (buf:TGLuint; red:TGLboolean; green:TGLboolean; blue:TGLboolean; alpha:TGLboolean);cdecl;
  TPFNGLDISABLEIPROC = procedure (cap:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEIPROC = procedure (cap:TGLenum; index:TGLuint);cdecl;
  TPFNGLENDCONDITIONALRENDERPROC = procedure (para1:pointer);cdecl;
  TPFNGLENDTRANSFORMFEEDBACKPROC = procedure (para1:pointer);cdecl;
  TPFNGLGETBOOLEANI_VPROC = procedure (pname:TGLenum; index:TGLuint; data:PGLboolean);cdecl;
  TPFNGLGETFRAGDATALOCATIONPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLGETSTRINGIPROC = function (name:TGLenum; index:TGLuint):PGLubyte;cdecl;
  TPFNGLGETTEXPARAMETERIIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXPARAMETERIUIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKVARYINGPROC = procedure (prog:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei;
                _type:PGLenum; name:PGLchar);cdecl;
  TPFNGLGETUNIFORMUIVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLuint);cdecl;
  TPFNGLGETVERTEXATTRIBIIVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVERTEXATTRIBIUIVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLISENABLEDIPROC = function (cap:TGLenum; index:TGLuint):TGLboolean;cdecl;
  TPFNGLTEXPARAMETERIIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXPARAMETERIUIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLTRANSFORMFEEDBACKVARYINGSPROC = procedure (prog:TGLuint; count:TGLsizei; varyings:PPGLchar; bufferMode:TGLenum);cdecl;
  TPFNGLUNIFORM1UIPROC = procedure (location:TGLint; v0:TGLuint);cdecl;
  TPFNGLUNIFORM1UIVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM2UIPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;
  TPFNGLUNIFORM2UIVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM3UIPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;
  TPFNGLUNIFORM3UIVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM4UIPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; v3:TGLuint);cdecl;
  TPFNGLUNIFORM4UIVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI1IPROC = procedure (index:TGLuint; v0:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI1IVPROC = procedure (index:TGLuint; v0:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI1UIPROC = procedure (index:TGLuint; v0:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI1UIVPROC = procedure (index:TGLuint; v0:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI2IPROC = procedure (index:TGLuint; v0:TGLint; v1:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI2IVPROC = procedure (index:TGLuint; v0:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI2UIPROC = procedure (index:TGLuint; v0:TGLuint; v1:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI2UIVPROC = procedure (index:TGLuint; v0:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI3IPROC = procedure (index:TGLuint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI3IVPROC = procedure (index:TGLuint; v0:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI3UIPROC = procedure (index:TGLuint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI3UIVPROC = procedure (index:TGLuint; v0:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4BVPROC = procedure (index:TGLuint; v0:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIBI4IPROC = procedure (index:TGLuint; v0:TGLint; v1:TGLint; v2:TGLint; v3:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI4IVPROC = procedure (index:TGLuint; v0:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI4SVPROC = procedure (index:TGLuint; v0:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBI4UBVPROC = procedure (index:TGLuint; v0:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIBI4UIPROC = procedure (index:TGLuint; v0:TGLuint; v1:TGLuint; v2:TGLuint; v3:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4UIVPROC = procedure (index:TGLuint; v0:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4USVPROC = procedure (index:TGLuint; v0:PGLushort);cdecl;
  TPFNGLVERTEXATTRIBIPOINTERPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ ----------------------------- GL_VERSION_3_1 ----------------------------  }

const
  GL_VERSION_3_1 = 1;  
  GL_TEXTURE_RECTANGLE = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE = $84F8;  
  GL_SAMPLER_2D_RECT = $8B63;  
  GL_SAMPLER_2D_RECT_SHADOW = $8B64;  
  GL_TEXTURE_BUFFER = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING = $8C2D;  
  GL_TEXTURE_BUFFER_FORMAT = $8C2E;  
  GL_SAMPLER_BUFFER = $8DC2;  
  GL_INT_SAMPLER_2D_RECT = $8DCD;  
  GL_INT_SAMPLER_BUFFER = $8DD0;  
  GL_UNSIGNED_INT_SAMPLER_2D_RECT = $8DD5;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER = $8DD8;  
  GL_RED_SNORM = $8F90;  
  GL_RG_SNORM = $8F91;  
  GL_RGB_SNORM = $8F92;  
  GL_RGBA_SNORM = $8F93;  
  GL_R8_SNORM = $8F94;  
  GL_RG8_SNORM = $8F95;  
  GL_RGB8_SNORM = $8F96;  
  GL_RGBA8_SNORM = $8F97;  
  GL_R16_SNORM = $8F98;  
  GL_RG16_SNORM = $8F99;  
  GL_RGB16_SNORM = $8F9A;  
  GL_RGBA16_SNORM = $8F9B;  
  GL_SIGNED_NORMALIZED = $8F9C;  
  GL_PRIMITIVE_RESTART = $8F9D;  
  GL_PRIMITIVE_RESTART_INDEX = $8F9E;  
  GL_BUFFER_ACCESS_FLAGS = $911F;  
  GL_BUFFER_MAP_LENGTH = $9120;  
  GL_BUFFER_MAP_OFFSET = $9121;  
type
  TPFNGLDRAWARRAYSINSTANCEDPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;
  TPFNGLPRIMITIVERESTARTINDEXPROC = procedure (buffer:TGLuint);cdecl;
  TPFNGLTEXBUFFERPROC = procedure (target:TGLenum; internalFormat:TGLenum; buffer:TGLuint);cdecl;


{ ----------------------------- GL_VERSION_3_2 ----------------------------  }

const
  GL_VERSION_3_2 = 1;  
  GL_CONTEXT_CORE_PROFILE_BIT = $00000001;  
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = $00000002;  
  GL_LINES_ADJACENCY = $000A;  
  GL_LINE_STRIP_ADJACENCY = $000B;  
  GL_TRIANGLES_ADJACENCY = $000C;  
  GL_TRIANGLE_STRIP_ADJACENCY = $000D;  
  GL_PROGRAM_POINT_SIZE = $8642;  
  GL_GEOMETRY_VERTICES_OUT = $8916;  
  GL_GEOMETRY_INPUT_TYPE = $8917;  
  GL_GEOMETRY_OUTPUT_TYPE = $8918;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = $8C29;  
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED = $8DA7;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = $8DA8;  
  GL_GEOMETRY_SHADER = $8DD9;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = $8DE1;  
  GL_MAX_VERTEX_OUTPUT_COMPONENTS = $9122;  
  GL_MAX_GEOMETRY_INPUT_COMPONENTS = $9123;  
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = $9124;  
  GL_MAX_FRAGMENT_INPUT_COMPONENTS = $9125;  
  GL_CONTEXT_PROFILE_MASK = $9126;  
type
  TPFNGLFRAMEBUFFERTEXTUREPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLGETBUFFERPARAMETERI64VPROC = procedure (target:TGLenum; value:TGLenum; data:PGLint64);cdecl;
  TPFNGLGETINTEGER64I_VPROC = procedure (pname:TGLenum; index:TGLuint; data:PGLint64);cdecl;


{ ----------------------------- GL_VERSION_3_3 ----------------------------  }

const
  GL_VERSION_3_3 = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR = $88FE;  
  GL_RGB10_A2UI = $906F;  
type
  TPFNGLVERTEXATTRIBDIVISORPROC = procedure (index:TGLuint; divisor:TGLuint);cdecl;


{ ----------------------------- GL_VERSION_4_0 ----------------------------  }

const
  GL_VERSION_4_0 = 1;  
  GL_SAMPLE_SHADING = $8C36;  
  GL_MIN_SAMPLE_SHADING_VALUE = $8C37;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5F;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS = $8F9F;  
  GL_TEXTURE_CUBE_MAP_ARRAY = $9009;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = $900A;  
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = $900B;  
  GL_SAMPLER_CUBE_MAP_ARRAY = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = $900F;  
type
  TPFNGLBLENDEQUATIONSEPARATEIPROC = procedure (buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLBLENDEQUATIONIPROC = procedure (buf:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEIPROC = procedure (buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;
  TPFNGLBLENDFUNCIPROC = procedure (buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;
  TPFNGLMINSAMPLESHADINGPROC = procedure (value:TGLclampf);cdecl;


{ ----------------------------- GL_VERSION_4_1 ----------------------------  }

const
  GL_VERSION_4_1 = 1;  


{ ----------------------------- GL_VERSION_4_2 ----------------------------  }

const
  GL_VERSION_4_2 = 1;  
  GL_TRANSFORM_FEEDBACK_PAUSED = $8E23;  
  GL_TRANSFORM_FEEDBACK_ACTIVE = $8E24;  
  GL_COMPRESSED_RGBA_BPTC_UNORM = $8E8C;  
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = $8E8D;  
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = $8E8E;  
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = $8E8F;  
  GL_COPY_READ_BUFFER_BINDING = $8F36;  
  GL_COPY_WRITE_BUFFER_BINDING = $8F37;  


{ ----------------------------- GL_VERSION_4_3 ----------------------------  }

const
  GL_VERSION_4_3 = 1;  
  GL_NUM_SHADING_LANGUAGE_VERSIONS = $82E9;  
  GL_VERTEX_ATTRIB_ARRAY_LONG = $874E;  


{ ----------------------------- GL_VERSION_4_4 ----------------------------  }

const
  GL_VERSION_4_4 = 1;  
  GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221;  
  GL_MAX_VERTEX_ATTRIB_STRIDE = $82E5;  
  GL_TEXTURE_BUFFER_BINDING = $8C2A;  


{ ----------------------------- GL_VERSION_4_5 ----------------------------  }

const
  GL_VERSION_4_5 = 1;  
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = $00000004;  
type
  TPFNGLGETGRAPHICSRESETSTATUSPROC = function (para1:pointer):TGLenum;cdecl;
  TPFNGLGETNCOMPRESSEDTEXIMAGEPROC = procedure (target:TGLenum; lod:TGLint; bufSize:TGLsizei; pixels:PGLvoid);cdecl;
  TPFNGLGETNTEXIMAGEPROC = procedure (tex:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei;                pixels:PGLvoid);cdecl;
  TPFNGLGETNUNIFORMDVPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLdouble);cdecl;


{ ----------------------------- GL_VERSION_4_6 ----------------------------  }

const
  GL_VERSION_4_6 = 1;  
  GL_CONTEXT_FLAG_NO_ERROR_BIT = $00000008;  
  GL_PARAMETER_BUFFER = $80EE;  
  GL_PARAMETER_BUFFER_BINDING = $80EF;  
  GL_TRANSFORM_FEEDBACK_OVERFLOW = $82EC;  
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW = $82ED;  
  GL_VERTICES_SUBMITTED = $82EE;  
  GL_PRIMITIVES_SUBMITTED = $82EF;  
  GL_VERTEX_SHADER_INVOCATIONS = $82F0;  
  GL_TESS_CONTROL_SHADER_PATCHES = $82F1;  
  GL_TESS_EVALUATION_SHADER_INVOCATIONS = $82F2;  
  GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED = $82F3;  
  GL_FRAGMENT_SHADER_INVOCATIONS = $82F4;  
  GL_COMPUTE_SHADER_INVOCATIONS = $82F5;  
  GL_CLIPPING_INPUT_PRIMITIVES = $82F6;  
  GL_CLIPPING_OUTPUT_PRIMITIVES = $82F7;  
  GL_TEXTURE_MAX_ANISOTROPY = $84FE;  
  GL_MAX_TEXTURE_MAX_ANISOTROPY = $84FF;  
  GL_POLYGON_OFFSET_CLAMP = $8E1B;  
  GL_SHADER_BINARY_FORMAT_SPIR_V = $9551;  
  GL_SPIR_V_BINARY = $9552;  
  GL_SPIR_V_EXTENSIONS = $9553;  
  GL_NUM_SPIR_V_EXTENSIONS = $9554;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC = procedure (mode:TGLenum; indirect:PGLvoid; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:PGLvoid; drawcount:TGLintptr; maxdrawcount:TGLsizei;                stride:TGLsizei);cdecl;
  TPFNGLSPECIALIZESHADERPROC = procedure (shader:TGLuint; pEntryPoint:PGLchar; numSpecializationConstants:TGLuint; pConstantIndex:PGLuint; pConstantValue:PGLuint);cdecl;


{ -------------------------- GL_3DFX_multisample --------------------------  }

const
  GL_3DFX_multisample = 1;  
  GL_MULTISAMPLE_3DFX = $86B2;  
  GL_SAMPLE_BUFFERS_3DFX = $86B3;  
  GL_SAMPLES_3DFX = $86B4;  
  GL_MULTISAMPLE_BIT_3DFX = $20000000;  


{ ---------------------------- GL_3DFX_tbuffer ----------------------------  }

const
  GL_3DFX_tbuffer = 1;  
type
  TPFNGLTBUFFERMASK3DFXPROC = procedure (mask:TGLuint);cdecl;


{ -------------------- GL_3DFX_texture_compression_FXT1 -------------------  }

const
  GL_3DFX_texture_compression_FXT1 = 1;  
  GL_COMPRESSED_RGB_FXT1_3DFX = $86B0;  
  GL_COMPRESSED_RGBA_FXT1_3DFX = $86B1;  


{ ----------------------- GL_AMD_blend_minmax_factor ----------------------  }

const
  GL_AMD_blend_minmax_factor = 1;  
  GL_FACTOR_MIN_AMD = $901C;  
  GL_FACTOR_MAX_AMD = $901D;  


{ --------------------- GL_AMD_compressed_3DC_texture ---------------------  }

const
  GL_AMD_compressed_3DC_texture = 1;  
  GL_3DC_X_AMD = $87F9;  
  GL_3DC_XY_AMD = $87FA;  


{ --------------------- GL_AMD_compressed_ATC_texture ---------------------  }

const
  GL_AMD_compressed_ATC_texture = 1;  
  GL_ATC_RGBA_INTERPOLATED_ALPHA_AMD = $87EE;  
  GL_ATC_RGB_AMD = $8C92;  
  GL_ATC_RGBA_EXPLICIT_ALPHA_AMD = $8C93;  


{ ----------------------- GL_AMD_conservative_depth -----------------------  }

const
  GL_AMD_conservative_depth = 1;  


{ -------------------------- GL_AMD_debug_output --------------------------  }

const
  GL_AMD_debug_output = 1;  
  GL_MAX_DEBUG_MESSAGE_LENGTH_AMD = $9143;  
  GL_MAX_DEBUG_LOGGED_MESSAGES_AMD = $9144;  
  GL_DEBUG_LOGGED_MESSAGES_AMD = $9145;  
  GL_DEBUG_SEVERITY_HIGH_AMD = $9146;  
  GL_DEBUG_SEVERITY_MEDIUM_AMD = $9147;  
  GL_DEBUG_SEVERITY_LOW_AMD = $9148;  
  GL_DEBUG_CATEGORY_API_ERROR_AMD = $9149;  
  GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = $914A;  
  GL_DEBUG_CATEGORY_DEPRECATION_AMD = $914B;  
  GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = $914C;  
  GL_DEBUG_CATEGORY_PERFORMANCE_AMD = $914D;  
  GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD = $914E;  
  GL_DEBUG_CATEGORY_APPLICATION_AMD = $914F;  
  GL_DEBUG_CATEGORY_OTHER_AMD = $9150;  
type
  TGLDEBUGPROCAMD = procedure (id:TGLuint; category:TGLenum; severity:TGLenum; length:TGLsizei; message:PGLchar;                userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGECALLBACKAMDPROC = procedure (callback:TGLDEBUGPROCAMD; userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGEENABLEAMDPROC = procedure (category:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint; enabled:TGLboolean);cdecl;
  TPFNGLDEBUGMESSAGEINSERTAMDPROC = procedure (category:TGLenum; severity:TGLenum; id:TGLuint; length:TGLsizei; buf:PGLchar);cdecl;
  TPFNGLGETDEBUGMESSAGELOGAMDPROC = function (count:TGLuint; bufsize:TGLsizei; categories:PGLenum; severities:PGLuint; ids:PGLuint;               lengths:PGLsizei; message:PGLchar):TGLuint;cdecl;


{ ---------------------- GL_AMD_depth_clamp_separate ----------------------  }

const
  GL_AMD_depth_clamp_separate = 1;  
  GL_DEPTH_CLAMP_NEAR_AMD = $901E;  
  GL_DEPTH_CLAMP_FAR_AMD = $901F;  


{ ----------------------- GL_AMD_draw_buffers_blend -----------------------  }

const
  GL_AMD_draw_buffers_blend = 1;  
type
  TPFNGLBLENDEQUATIONINDEXEDAMDPROC = procedure (buf:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC = procedure (buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLBLENDFUNCINDEXEDAMDPROC = procedure (buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC = procedure (buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;


{ ---------------- GL_AMD_framebuffer_multisample_advanced ----------------  }

const
  GL_AMD_framebuffer_multisample_advanced = 1;  
  GL_RENDERBUFFER_STORAGE_SAMPLES_AMD = $91B2;  
  GL_MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = $91B3;  
  GL_MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = $91B4;  
  GL_MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = $91B5;  
  GL_NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B6;  
  GL_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B7;  
type
  TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC = procedure (renderbuffer:TGLuint; samples:TGLsizei; storageSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei;                height:TGLsizei);cdecl;
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC = procedure (target:TGLenum; samples:TGLsizei; storageSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei;                height:TGLsizei);cdecl;


{ ------------------ GL_AMD_framebuffer_sample_positions ------------------  }

const
  GL_AMD_framebuffer_sample_positions = 1;  
  GL_SUBSAMPLE_DISTANCE_AMD = $883F;  
  GL_PIXELS_PER_SAMPLE_PATTERN_X_AMD = $91AE;  
  GL_PIXELS_PER_SAMPLE_PATTERN_Y_AMD = $91AF;  
  GL_ALL_PIXELS_AMD = $FFFFFFFF;  
type
  TPFNGLFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC = procedure (target:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; values:PGLfloat);cdecl;
  TPFNGLGETFRAMEBUFFERPARAMETERFVAMDPROC = procedure (target:TGLenum; pname:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; size:TGLsizei;                values:PGLfloat);cdecl;
  TPFNGLGETNAMEDFRAMEBUFFERPARAMETERFVAMDPROC = procedure (framebuffer:TGLuint; pname:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; size:TGLsizei;                values:PGLfloat);cdecl;
  TPFNGLNAMEDFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC = procedure (framebuffer:TGLuint; numsamples:TGLuint; pixelindex:TGLuint; values:PGLfloat);cdecl;


{ --------------------------- GL_AMD_gcn_shader ---------------------------  }

const
  GL_AMD_gcn_shader = 1;  


{ ---------------------- GL_AMD_gpu_shader_half_float ---------------------  }

const
  GL_AMD_gpu_shader_half_float = 1;  
  GL_FLOAT16_NV = $8FF8;  
  GL_FLOAT16_VEC2_NV = $8FF9;  
  GL_FLOAT16_VEC3_NV = $8FFA;  
  GL_FLOAT16_VEC4_NV = $8FFB;  
  GL_FLOAT16_MAT2_AMD = $91C5;  
  GL_FLOAT16_MAT3_AMD = $91C6;  
  GL_FLOAT16_MAT4_AMD = $91C7;  
  GL_FLOAT16_MAT2x3_AMD = $91C8;  
  GL_FLOAT16_MAT2x4_AMD = $91C9;  
  GL_FLOAT16_MAT3x2_AMD = $91CA;  
  GL_FLOAT16_MAT3x4_AMD = $91CB;  
  GL_FLOAT16_MAT4x2_AMD = $91CC;  
  GL_FLOAT16_MAT4x3_AMD = $91CD;  


{ ------------------- GL_AMD_gpu_shader_half_float_fetch ------------------  }

const
  GL_AMD_gpu_shader_half_float_fetch = 1;  
  GL_FLOAT16_SAMPLER_1D_AMD = $91CE;  
  GL_FLOAT16_SAMPLER_2D_AMD = $91CF;  
  GL_FLOAT16_SAMPLER_3D_AMD = $91D0;  
  GL_FLOAT16_SAMPLER_CUBE_AMD = $91D1;  
  GL_FLOAT16_SAMPLER_2D_RECT_AMD = $91D2;  
  GL_FLOAT16_SAMPLER_1D_ARRAY_AMD = $91D3;  
  GL_FLOAT16_SAMPLER_2D_ARRAY_AMD = $91D4;  
  GL_FLOAT16_SAMPLER_CUBE_MAP_ARRAY_AMD = $91D5;  
  GL_FLOAT16_SAMPLER_BUFFER_AMD = $91D6;  
  GL_FLOAT16_SAMPLER_2D_MULTISAMPLE_AMD = $91D7;  
  GL_FLOAT16_SAMPLER_2D_MULTISAMPLE_ARRAY_AMD = $91D8;  
  GL_FLOAT16_SAMPLER_1D_SHADOW_AMD = $91D9;  
  GL_FLOAT16_SAMPLER_2D_SHADOW_AMD = $91DA;  
  GL_FLOAT16_SAMPLER_2D_RECT_SHADOW_AMD = $91DB;  
  GL_FLOAT16_SAMPLER_1D_ARRAY_SHADOW_AMD = $91DC;  
  GL_FLOAT16_SAMPLER_2D_ARRAY_SHADOW_AMD = $91DD;  
  GL_FLOAT16_SAMPLER_CUBE_SHADOW_AMD = $91DE;  
  GL_FLOAT16_SAMPLER_CUBE_MAP_ARRAY_SHADOW_AMD = $91DF;  
  GL_FLOAT16_IMAGE_1D_AMD = $91E0;  
  GL_FLOAT16_IMAGE_2D_AMD = $91E1;  
  GL_FLOAT16_IMAGE_3D_AMD = $91E2;  
  GL_FLOAT16_IMAGE_2D_RECT_AMD = $91E3;  
  GL_FLOAT16_IMAGE_CUBE_AMD = $91E4;  
  GL_FLOAT16_IMAGE_1D_ARRAY_AMD = $91E5;  
  GL_FLOAT16_IMAGE_2D_ARRAY_AMD = $91E6;  
  GL_FLOAT16_IMAGE_CUBE_MAP_ARRAY_AMD = $91E7;  
  GL_FLOAT16_IMAGE_BUFFER_AMD = $91E8;  
  GL_FLOAT16_IMAGE_2D_MULTISAMPLE_AMD = $91E9;  
  GL_FLOAT16_IMAGE_2D_MULTISAMPLE_ARRAY_AMD = $91EA;  


{ ------------------------ GL_AMD_gpu_shader_int16 ------------------------  }

const
  GL_AMD_gpu_shader_int16 = 1;  


{ ------------------------ GL_AMD_gpu_shader_int64 ------------------------  }

const
  GL_AMD_gpu_shader_int64 = 1;  


{ ---------------------- GL_AMD_interleaved_elements ----------------------  }
const
  GL_AMD_interleaved_elements = 1;  
//  GL_RED = $1903;   Doppelt
//  GL_GREEN = $1904; Doppelt 
//  GL_BLUE = $1905;  Doppelt
//  GL_ALPHA = $1906; Doppelt 
  GL_RG8UI = $8238;  
  GL_RG16UI = $823A;  
//  GL_RGBA8UI = $8D7C; Doppelt 
  GL_VERTEX_ELEMENT_SWIZZLE_AMD = $91A4;  
  GL_VERTEX_ID_SWIZZLE_AMD = $91A5;  
type
  TPFNGLVERTEXATTRIBPARAMETERIAMDPROC = procedure (index:TGLuint; pname:TGLenum; param:TGLint);cdecl;


{ ----------------------- GL_AMD_multi_draw_indirect ----------------------  }

const
  GL_AMD_multi_draw_indirect = 1;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTAMDPROC = procedure (mode:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;


{ ------------------------- GL_AMD_name_gen_delete ------------------------  }

const
  GL_AMD_name_gen_delete = 1;  
  GL_DATA_BUFFER_AMD = $9151;  
  GL_PERFORMANCE_MONITOR_AMD = $9152;  
  GL_QUERY_OBJECT_AMD = $9153;  
  GL_VERTEX_ARRAY_OBJECT_AMD = $9154;  
  GL_SAMPLER_OBJECT_AMD = $9155;  
type
  TPFNGLDELETENAMESAMDPROC = procedure (identifier:TGLenum; num:TGLuint; names:PGLuint);cdecl;
  TPFNGLGENNAMESAMDPROC = procedure (identifier:TGLenum; num:TGLuint; names:PGLuint);cdecl;
  TPFNGLISNAMEAMDPROC = function (identifier:TGLenum; name:TGLuint):TGLboolean;cdecl;


{ ---------------------- GL_AMD_occlusion_query_event ---------------------  }

const
  GL_AMD_occlusion_query_event = 1;  
  GL_QUERY_DEPTH_PASS_EVENT_BIT_AMD = $00000001;  
  GL_QUERY_DEPTH_FAIL_EVENT_BIT_AMD = $00000002;  
  GL_QUERY_STENCIL_FAIL_EVENT_BIT_AMD = $00000004;  
  GL_QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = $00000008;  
  GL_OCCLUSION_QUERY_EVENT_MASK_AMD = $874F;  
  GL_QUERY_ALL_EVENT_BITS_AMD = $FFFFFFFF;  
type
  TPFNGLQUERYOBJECTPARAMETERUIAMDPROC = procedure (target:TGLenum; id:TGLuint; pname:TGLenum; param:TGLuint);cdecl;


{ ----------------------- GL_AMD_performance_monitor ----------------------  }

const
  GL_AMD_performance_monitor = 1;  
  GL_COUNTER_TYPE_AMD = $8BC0;  
  GL_COUNTER_RANGE_AMD = $8BC1;  
  GL_UNSIGNED_INT64_AMD = $8BC2;  
  GL_PERCENTAGE_AMD = $8BC3;  
  GL_PERFMON_RESULT_AVAILABLE_AMD = $8BC4;  
  GL_PERFMON_RESULT_SIZE_AMD = $8BC5;  
  GL_PERFMON_RESULT_AMD = $8BC6;  
type
  TPFNGLBEGINPERFMONITORAMDPROC = procedure (monitor:TGLuint);cdecl;
  TPFNGLDELETEPERFMONITORSAMDPROC = procedure (n:TGLsizei; monitors:PGLuint);cdecl;
  TPFNGLENDPERFMONITORAMDPROC = procedure (monitor:TGLuint);cdecl;
  TPFNGLGENPERFMONITORSAMDPROC = procedure (n:TGLsizei; monitors:PGLuint);cdecl;
  TPFNGLGETPERFMONITORCOUNTERDATAAMDPROC = procedure (monitor:TGLuint; pname:TGLenum; dataSize:TGLsizei; data:PGLuint; bytesWritten:PGLint);cdecl;
  TPFNGLGETPERFMONITORCOUNTERINFOAMDPROC = procedure (group:TGLuint; counter:TGLuint; pname:TGLenum; data:pointer);cdecl;
  TPFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC = procedure (group:TGLuint; counter:TGLuint; bufSize:TGLsizei; length:PGLsizei; counterString:PGLchar);cdecl;
  TPFNGLGETPERFMONITORCOUNTERSAMDPROC = procedure (group:TGLuint; numCounters:PGLint; maxActiveCounters:PGLint; countersSize:TGLsizei; counters:PGLuint);cdecl;
  TPFNGLGETPERFMONITORGROUPSTRINGAMDPROC = procedure (group:TGLuint; bufSize:TGLsizei; length:PGLsizei; groupString:PGLchar);cdecl;
  TPFNGLGETPERFMONITORGROUPSAMDPROC = procedure (numGroups:PGLint; groupsSize:TGLsizei; groups:PGLuint);cdecl;
  TPFNGLSELECTPERFMONITORCOUNTERSAMDPROC = procedure (monitor:TGLuint; enable:TGLboolean; group:TGLuint; numCounters:TGLint; counterList:PGLuint);cdecl;


{ -------------------------- GL_AMD_pinned_memory -------------------------  }

const
  GL_AMD_pinned_memory = 1;  
  GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = $9160;  


{ ----------------------- GL_AMD_program_binary_Z400 ----------------------  }

const
  GL_AMD_program_binary_Z400 = 1;  
  GL_Z400_BINARY_AMD = $8740;  


{ ----------------------- GL_AMD_query_buffer_object ----------------------  }

const
  GL_AMD_query_buffer_object = 1;  
  GL_QUERY_BUFFER_AMD = $9192;  
  GL_QUERY_BUFFER_BINDING_AMD = $9193;  
  GL_QUERY_RESULT_NO_WAIT_AMD = $9194;  


{ ------------------------ GL_AMD_sample_positions ------------------------  }

const
  GL_AMD_sample_positions = 1;  
//  GL_SUBSAMPLE_DISTANCE_AMD = $883F;  Doppelt
type

  TPFNGLSETMULTISAMPLEFVAMDPROC = procedure (pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;


{ ------------------ GL_AMD_seamless_cubemap_per_texture ------------------  }

const
  GL_AMD_seamless_cubemap_per_texture = 1;  
  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;  


{ -------------------- GL_AMD_shader_atomic_counter_ops -------------------  }

const
  GL_AMD_shader_atomic_counter_ops = 1;  


{ -------------------------- GL_AMD_shader_ballot -------------------------  }

const
  GL_AMD_shader_ballot = 1;  


{ ---------------- GL_AMD_shader_explicit_vertex_parameter ----------------  }

const
  GL_AMD_shader_explicit_vertex_parameter = 1;  


{ ------------------- GL_AMD_shader_image_load_store_lod ------------------  }

const
  GL_AMD_shader_image_load_store_lod = 1;  


{ ---------------------- GL_AMD_shader_stencil_export ---------------------  }

const
  GL_AMD_shader_stencil_export = 1;  


{ ------------------- GL_AMD_shader_stencil_value_export ------------------  }

const
  GL_AMD_shader_stencil_value_export = 1;  


{ ---------------------- GL_AMD_shader_trinary_minmax ---------------------  }

const
  GL_AMD_shader_trinary_minmax = 1;  


{ ------------------------- GL_AMD_sparse_texture -------------------------  }

const
  GL_AMD_sparse_texture = 1;  
  GL_TEXTURE_STORAGE_SPARSE_BIT_AMD = $00000001;  
  GL_VIRTUAL_PAGE_SIZE_X_AMD = $9195;  
  GL_VIRTUAL_PAGE_SIZE_Y_AMD = $9196;  
  GL_VIRTUAL_PAGE_SIZE_Z_AMD = $9197;  
  GL_MAX_SPARSE_TEXTURE_SIZE_AMD = $9198;  
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_AMD = $9199;  
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS = $919A;  
  GL_MIN_SPARSE_LEVEL_AMD = $919B;  
  GL_MIN_LOD_WARNING_AMD = $919C;  
type
  TPFNGLTEXSTORAGESPARSEAMDPROC = procedure (target:TGLenum; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; depth:TGLsizei;                layers:TGLsizei; flags:TGLbitfield);cdecl;
  TPFNGLTEXTURESTORAGESPARSEAMDPROC = procedure (texture:TGLuint; target:TGLenum; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;                depth:TGLsizei; layers:TGLsizei; flags:TGLbitfield);cdecl;


{ ------------------- GL_AMD_stencil_operation_extended -------------------  }

const
  GL_AMD_stencil_operation_extended = 1;  
  GL_SET_AMD = $874A;  
  GL_REPLACE_VALUE_AMD = $874B;  
  GL_STENCIL_OP_VALUE_AMD = $874C;  
  GL_STENCIL_BACK_OP_VALUE_AMD = $874D;  
type

  TPFNGLSTENCILOPVALUEAMDPROC = procedure (face:TGLenum; value:TGLuint);cdecl;


{ --------------------- GL_AMD_texture_gather_bias_lod --------------------  }

const
  GL_AMD_texture_gather_bias_lod = 1;  


{ ------------------------ GL_AMD_texture_texture4 ------------------------  }

const
  GL_AMD_texture_texture4 = 1;  


{ --------------- GL_AMD_transform_feedback3_lines_triangles --------------  }

const
  GL_AMD_transform_feedback3_lines_triangles = 1;  


{ ----------------------- GL_AMD_transform_feedback4 ----------------------  }

const
  GL_AMD_transform_feedback4 = 1;  
  GL_STREAM_RASTERIZATION_AMD = $91A0;  


{ ----------------------- GL_AMD_vertex_shader_layer ----------------------  }

const
  GL_AMD_vertex_shader_layer = 1;  


{ -------------------- GL_AMD_vertex_shader_tessellator -------------------  }

const
  GL_AMD_vertex_shader_tessellator = 1;  
  GL_SAMPLER_BUFFER_AMD = $9001;  
  GL_INT_SAMPLER_BUFFER_AMD = $9002;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = $9003;  
  GL_TESSELLATION_MODE_AMD = $9004;  
  GL_TESSELLATION_FACTOR_AMD = $9005;  
  GL_DISCRETE_AMD = $9006;  
  GL_CONTINUOUS_AMD = $9007;  
type
  TPFNGLTESSELLATIONFACTORAMDPROC = procedure (factor:TGLfloat);cdecl;
  TPFNGLTESSELLATIONMODEAMDPROC = procedure (mode:TGLenum);cdecl;


{ ------------------ GL_AMD_vertex_shader_viewport_index ------------------  }

const
  GL_AMD_vertex_shader_viewport_index = 1;  


{ -------------------- GL_ANDROID_extension_pack_es31a --------------------  }

const
  GL_ANDROID_extension_pack_es31a = 1;  


{ ------------------------- GL_ANGLE_depth_texture ------------------------  }

const
  GL_ANGLE_depth_texture = 1;  


{ ----------------------- GL_ANGLE_framebuffer_blit -----------------------  }

const
  GL_ANGLE_framebuffer_blit = 1;  
  GL_DRAW_FRAMEBUFFER_BINDING_ANGLE = $8CA6;  
  GL_READ_FRAMEBUFFER_ANGLE = $8CA8;  
  GL_DRAW_FRAMEBUFFER_ANGLE = $8CA9;  
  GL_READ_FRAMEBUFFER_BINDING_ANGLE = $8CAA;  
type
  TPFNGLBLITFRAMEBUFFERANGLEPROC = procedure (srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint;
                dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;


{ -------------------- GL_ANGLE_framebuffer_multisample -------------------  }

const
  GL_ANGLE_framebuffer_multisample = 1;  
  GL_RENDERBUFFER_SAMPLES_ANGLE = $8CAB;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_ANGLE = $8D56;  
  GL_MAX_SAMPLES_ANGLE = $8D57;  
type
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEANGLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ----------------------- GL_ANGLE_instanced_arrays -----------------------  }

const
  GL_ANGLE_instanced_arrays = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ANGLE = $88FE;  
type
  TPFNGLDRAWARRAYSINSTANCEDANGLEPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDANGLEPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;
  TPFNGLVERTEXATTRIBDIVISORANGLEPROC = procedure (index:TGLuint; divisor:TGLuint);cdecl;


{ -------------------- GL_ANGLE_pack_reverse_row_order --------------------  }

const
  GL_ANGLE_pack_reverse_row_order = 1;  
  GL_PACK_REVERSE_ROW_ORDER_ANGLE = $93A4;  


{ ------------------------ GL_ANGLE_program_binary ------------------------  }

const
  GL_ANGLE_program_binary = 1;  
  GL_PROGRAM_BINARY_ANGLE = $93A6;  


{ ------------------- GL_ANGLE_texture_compression_dxt1 -------------------  }

const
  GL_ANGLE_texture_compression_dxt1 = 1;  
  GL_COMPRESSED_RGB_S3TC_DXT1_ANGLE = $83F0;  
  GL_COMPRESSED_RGBA_S3TC_DXT1_ANGLE = $83F1;  
  GL_COMPRESSED_RGBA_S3TC_DXT3_ANGLE = $83F2;  
  GL_COMPRESSED_RGBA_S3TC_DXT5_ANGLE = $83F3;  


{ ------------------- GL_ANGLE_texture_compression_dxt3 -------------------  }

const
  GL_ANGLE_texture_compression_dxt3 = 1;  
//  GL_COMPRESSED_RGB_S3TC_DXT1_ANGLE = $83F0;   Doppelt
//  GL_COMPRESSED_RGBA_S3TC_DXT1_ANGLE = $83F1;  
//  GL_COMPRESSED_RGBA_S3TC_DXT3_ANGLE = $83F2;  
//  GL_COMPRESSED_RGBA_S3TC_DXT5_ANGLE = $83F3;  


{ ------------------- GL_ANGLE_texture_compression_dxt5 -------------------  }

const
  GL_ANGLE_texture_compression_dxt5 = 1;  
//  GL_COMPRESSED_RGB_S3TC_DXT1_ANGLE = $83F0; Doppelt
//  GL_COMPRESSED_RGBA_S3TC_DXT1_ANGLE = $83F1;  
//  GL_COMPRESSED_RGBA_S3TC_DXT3_ANGLE = $83F2;  
//  GL_COMPRESSED_RGBA_S3TC_DXT5_ANGLE = $83F3;  


{ ------------------------- GL_ANGLE_texture_usage ------------------------  }

const
  GL_ANGLE_texture_usage = 1;  
  GL_TEXTURE_USAGE_ANGLE = $93A2;  
  GL_FRAMEBUFFER_ATTACHMENT_ANGLE = $93A3;  


{ -------------------------- GL_ANGLE_timer_query -------------------------  }

const
  GL_ANGLE_timer_query = 1;  
  GL_QUERY_COUNTER_BITS_ANGLE = $8864;  
  GL_CURRENT_QUERY_ANGLE = $8865;  
  GL_QUERY_RESULT_ANGLE = $8866;  
  GL_QUERY_RESULT_AVAILABLE_ANGLE = $8867;  
  GL_TIME_ELAPSED_ANGLE = $88BF;  
  GL_TIMESTAMP_ANGLE = $8E28;  
type
  TPFNGLBEGINQUERYANGLEPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETEQUERIESANGLEPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLENDQUERYANGLEPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGENQUERIESANGLEPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETQUERYOBJECTI64VANGLEPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLGETQUERYOBJECTIVANGLEPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETQUERYOBJECTUI64VANGLEPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;
  TPFNGLGETQUERYOBJECTUIVANGLEPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETQUERYIVANGLEPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISQUERYANGLEPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLQUERYCOUNTERANGLEPROC = procedure (id:TGLuint; target:TGLenum);cdecl;


{ ------------------- GL_ANGLE_translated_shader_source -------------------  }

const
  GL_ANGLE_translated_shader_source = 1;  
  GL_TRANSLATED_SHADER_SOURCE_LENGTH_ANGLE = $93A0;  
type
  TPFNGLGETTRANSLATEDSHADERSOURCEANGLEPROC = procedure (shader:TGLuint; bufsize:TGLsizei; length:PGLsizei; source:PGLchar);cdecl;


{ ----------------------- GL_APPLE_aux_depth_stencil ----------------------  }

const
  GL_APPLE_aux_depth_stencil = 1;  
  GL_AUX_DEPTH_STENCIL_APPLE = $8A14;  


{ ------------------------ GL_APPLE_client_storage ------------------------  }

const
  GL_APPLE_client_storage = 1;  
  GL_UNPACK_CLIENT_STORAGE_APPLE = $85B2;  


{ ------------------------- GL_APPLE_clip_distance ------------------------  }

const
  GL_APPLE_clip_distance = 1;  
  GL_MAX_CLIP_DISTANCES_APPLE = $0D32;  
  GL_CLIP_DISTANCE0_APPLE = $3000;  
  GL_CLIP_DISTANCE1_APPLE = $3001;  
  GL_CLIP_DISTANCE2_APPLE = $3002;  
  GL_CLIP_DISTANCE3_APPLE = $3003;  
  GL_CLIP_DISTANCE4_APPLE = $3004;  
  GL_CLIP_DISTANCE5_APPLE = $3005;  
  GL_CLIP_DISTANCE6_APPLE = $3006;  
  GL_CLIP_DISTANCE7_APPLE = $3007;  


{ ------------------- GL_APPLE_color_buffer_packed_float ------------------  }

const
  GL_APPLE_color_buffer_packed_float = 1;  


{ ---------------------- GL_APPLE_copy_texture_levels ---------------------  }

const
  GL_APPLE_copy_texture_levels = 1;  
type
  TPFNGLCOPYTEXTURELEVELSAPPLEPROC = procedure (destinationTexture:TGLuint; sourceTexture:TGLuint; sourceBaseLevel:TGLint; sourceLevelCount:TGLsizei);cdecl;


{ ------------------------- GL_APPLE_element_array ------------------------  }

const
  GL_APPLE_element_array = 1;  
  GL_ELEMENT_ARRAY_APPLE = $8A0C;  
  GL_ELEMENT_ARRAY_TYPE_APPLE = $8A0D;  
  GL_ELEMENT_ARRAY_POINTER_APPLE = $8A0E;  
type
  TPFNGLDRAWELEMENTARRAYAPPLEPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei);cdecl;
  TPFNGLDRAWRANGEELEMENTARRAYAPPLEPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; first:TGLint; count:TGLsizei);cdecl;
  TPFNGLELEMENTPOINTERAPPLEPROC = procedure (_type:TGLenum; pointer:pointer);cdecl;
  TPFNGLMULTIDRAWELEMENTARRAYAPPLEPROC = procedure (mode:TGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; first:PGLint; count:PGLsizei;                primcount:TGLsizei);cdecl;


{ ----------------------------- GL_APPLE_fence ----------------------------  }

const
  GL_APPLE_fence = 1;  
  GL_DRAW_PIXELS_APPLE = $8A0A;  
  GL_FENCE_APPLE = $8A0B;  
type
  TPFNGLDELETEFENCESAPPLEPROC = procedure (n:TGLsizei; fences:PGLuint);cdecl;
  TPFNGLFINISHFENCEAPPLEPROC = procedure (fence:TGLuint);cdecl;
  TPFNGLFINISHOBJECTAPPLEPROC = procedure (obj:TGLenum; name:TGLint);cdecl;
  TPFNGLGENFENCESAPPLEPROC = procedure (n:TGLsizei; fences:PGLuint);cdecl;
  TPFNGLISFENCEAPPLEPROC = function (fence:TGLuint):TGLboolean;cdecl;
  TPFNGLSETFENCEAPPLEPROC = procedure (fence:TGLuint);cdecl;
  TPFNGLTESTFENCEAPPLEPROC = function (fence:TGLuint):TGLboolean;cdecl;
  TPFNGLTESTOBJECTAPPLEPROC = function (obj:TGLenum; name:TGLuint):TGLboolean;cdecl;


{ ------------------------- GL_APPLE_float_pixels -------------------------  }

const
  GL_APPLE_float_pixels = 1;  
  GL_HALF_APPLE = $140B;  
  GL_RGBA_FLOAT32_APPLE = $8814;  
  GL_RGB_FLOAT32_APPLE = $8815;  
  GL_ALPHA_FLOAT32_APPLE = $8816;  
  GL_INTENSITY_FLOAT32_APPLE = $8817;  
  GL_LUMINANCE_FLOAT32_APPLE = $8818;  
  GL_LUMINANCE_ALPHA_FLOAT32_APPLE = $8819;  
  GL_RGBA_FLOAT16_APPLE = $881A;  
  GL_RGB_FLOAT16_APPLE = $881B;  
  GL_ALPHA_FLOAT16_APPLE = $881C;  
  GL_INTENSITY_FLOAT16_APPLE = $881D;  
  GL_LUMINANCE_FLOAT16_APPLE = $881E;  
  GL_LUMINANCE_ALPHA_FLOAT16_APPLE = $881F;  
  GL_COLOR_FLOAT_APPLE = $8A0F;  


{ ---------------------- GL_APPLE_flush_buffer_range ----------------------  }

const
  GL_APPLE_flush_buffer_range = 1;  
  GL_BUFFER_SERIALIZED_MODIFY_APPLE = $8A12;  
  GL_BUFFER_FLUSHING_UNMAP_APPLE = $8A13;  
type
  TPFNGLBUFFERPARAMETERIAPPLEPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC = procedure (target:TGLenum; offset:TGLintptr; size:TGLsizeiptr);cdecl;


{ -------------------- GL_APPLE_framebuffer_multisample -------------------  }

const
  GL_APPLE_framebuffer_multisample = 1;  
  GL_DRAW_FRAMEBUFFER_BINDING_APPLE = $8CA6;  
  GL_READ_FRAMEBUFFER_APPLE = $8CA8;  
  GL_DRAW_FRAMEBUFFER_APPLE = $8CA9;  
  GL_READ_FRAMEBUFFER_BINDING_APPLE = $8CAA;  
  GL_RENDERBUFFER_SAMPLES_APPLE = $8CAB;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_APPLE = $8D56;  
  GL_MAX_SAMPLES_APPLE = $8D57;  
type
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEAPPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLRESOLVEMULTISAMPLEFRAMEBUFFERAPPLEPROC = procedure (para1:pointer);cdecl;


{ ----------------------- GL_APPLE_object_purgeable -----------------------  }

const
  GL_APPLE_object_purgeable = 1;  
  GL_BUFFER_OBJECT_APPLE = $85B3;  
  GL_RELEASED_APPLE = $8A19;  
  GL_VOLATILE_APPLE = $8A1A;  
  GL_RETAINED_APPLE = $8A1B;  
  GL_UNDEFINED_APPLE = $8A1C;  
  GL_PURGEABLE_APPLE = $8A1D;  
type
  TPFNGLGETOBJECTPARAMETERIVAPPLEPROC = procedure (objectType:TGLenum; name:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLOBJECTPURGEABLEAPPLEPROC = function (objectType:TGLenum; name:TGLuint; option:TGLenum):TGLenum;cdecl;
  TPFNGLOBJECTUNPURGEABLEAPPLEPROC = function (objectType:TGLenum; name:TGLuint; option:TGLenum):TGLenum;cdecl;


{ ------------------------- GL_APPLE_pixel_buffer -------------------------  }

const
  GL_APPLE_pixel_buffer = 1;  
  GL_MIN_PBUFFER_VIEWPORT_DIMS_APPLE = $8A10;  


{ ---------------------------- GL_APPLE_rgb_422 ---------------------------  }

const
  GL_APPLE_rgb_422 = 1;  
  GL_UNSIGNED_SHORT_8_8_APPLE = $85BA;  
  GL_UNSIGNED_SHORT_8_8_REV_APPLE = $85BB;  
  GL_RGB_422_APPLE = $8A1F;  
  GL_RGB_RAW_422_APPLE = $8A51;  


{ --------------------------- GL_APPLE_row_bytes --------------------------  }

const
  GL_APPLE_row_bytes = 1;  
  GL_PACK_ROW_BYTES_APPLE = $8A15;  
  GL_UNPACK_ROW_BYTES_APPLE = $8A16;  


{ ------------------------ GL_APPLE_specular_vector -----------------------  }

const
  GL_APPLE_specular_vector = 1;  
  GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = $85B0;  


{ ----------------------------- GL_APPLE_sync -----------------------------  }

const
  GL_APPLE_sync = 1;  
  GL_SYNC_FLUSH_COMMANDS_BIT_APPLE = $00000001;  
  GL_SYNC_OBJECT_APPLE = $8A53;  
  GL_MAX_SERVER_WAIT_TIMEOUT_APPLE = $9111;  
  GL_OBJECT_TYPE_APPLE = $9112;  
  GL_SYNC_CONDITION_APPLE = $9113;  
  GL_SYNC_STATUS_APPLE = $9114;  
  GL_SYNC_FLAGS_APPLE = $9115;  
  GL_SYNC_FENCE_APPLE = $9116;  
  GL_SYNC_GPU_COMMANDS_COMPLETE_APPLE = $9117;  
  GL_UNSIGNALED_APPLE = $9118;  
  GL_SIGNALED_APPLE = $9119;  
  GL_ALREADY_SIGNALED_APPLE = $911A;  
  GL_TIMEOUT_EXPIRED_APPLE = $911B;  
  GL_CONDITION_SATISFIED_APPLE = $911C;  
  GL_WAIT_FAILED_APPLE = $911D;  
  GL_TIMEOUT_IGNORED_APPLE = $FFFFFFFFFFFFFFFF;  
type
  TPFNGLCLIENTWAITSYNCAPPLEPROC = function (GLsync:TGLsync; flags:TGLbitfield; timeout:TGLuint64):TGLenum;cdecl;
  TPFNGLDELETESYNCAPPLEPROC = procedure (GLsync:TGLsync);cdecl;
  TPFNGLFENCESYNCAPPLEPROC = function (condition:TGLenum; flags:TGLbitfield):TGLsync;cdecl;
  TPFNGLGETINTEGER64VAPPLEPROC = procedure (pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLGETSYNCIVAPPLEPROC = procedure (GLsync:TGLsync; pname:TGLenum; bufSize:TGLsizei; length:PGLsizei; values:PGLint);cdecl;
  TPFNGLISSYNCAPPLEPROC = function (GLsync:TGLsync):TGLboolean;cdecl;
  TPFNGLWAITSYNCAPPLEPROC = procedure (GLsync:TGLsync; flags:TGLbitfield; timeout:TGLuint64);cdecl;


{ -------------------- GL_APPLE_texture_2D_limited_npot -------------------  }

const
  GL_APPLE_texture_2D_limited_npot = 1;  


{ -------------------- GL_APPLE_texture_format_BGRA8888 -------------------  }

const
  GL_APPLE_texture_format_BGRA8888 = 1;  
  GL_BGRA_EXT = $80E1;  
  GL_BGRA8_EXT = $93A1;  


{ ----------------------- GL_APPLE_texture_max_level ----------------------  }

const
  GL_APPLE_texture_max_level = 1;  
  GL_TEXTURE_MAX_LEVEL_APPLE = $813D;  


{ --------------------- GL_APPLE_texture_packed_float ---------------------  }

const
  GL_APPLE_texture_packed_float = 1;  
  GL_R11F_G11F_B10F_APPLE = $8C3A;  
  GL_UNSIGNED_INT_10F_11F_11F_REV_APPLE = $8C3B;  
  GL_RGB9_E5_APPLE = $8C3D;  
  GL_UNSIGNED_INT_5_9_9_9_REV_APPLE = $8C3E;  


{ ------------------------- GL_APPLE_texture_range ------------------------  }

const
  GL_APPLE_texture_range = 1;  
  GL_TEXTURE_RANGE_LENGTH_APPLE = $85B7;  
  GL_TEXTURE_RANGE_POINTER_APPLE = $85B8;  
  GL_TEXTURE_STORAGE_HINT_APPLE = $85BC;  
  GL_STORAGE_PRIVATE_APPLE = $85BD;  
  GL_STORAGE_CACHED_APPLE = $85BE;  
  GL_STORAGE_SHARED_APPLE = $85BF;  
type
  TPFNGLGETTEXPARAMETERPOINTERVAPPLEPROC = procedure (target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLTEXTURERANGEAPPLEPROC = procedure (target:TGLenum; length:TGLsizei; pointer:pointer);cdecl;


{ ------------------------ GL_APPLE_transform_hint ------------------------  }

const
  GL_APPLE_transform_hint = 1;  
  GL_TRANSFORM_HINT_APPLE = $85B1;  


{ ---------------------- GL_APPLE_vertex_array_object ---------------------  }

const
  GL_APPLE_vertex_array_object = 1;  
  GL_VERTEX_ARRAY_BINDING_APPLE = $85B5;  
type
  TPFNGLBINDVERTEXARRAYAPPLEPROC = procedure (arr:TGLuint);cdecl;
  TPFNGLDELETEVERTEXARRAYSAPPLEPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLGENVERTEXARRAYSAPPLEPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLISVERTEXARRAYAPPLEPROC = function (arr:TGLuint):TGLboolean;cdecl;


{ ---------------------- GL_APPLE_vertex_array_range ----------------------  }

const
  GL_APPLE_vertex_array_range = 1;  
  GL_VERTEX_ARRAY_RANGE_APPLE = $851D;  
  GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = $851E;  
  GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = $851F;  
  GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_APPLE = $8520;  
  GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = $8521;  
  GL_STORAGE_CLIENT_APPLE = $85B4;  
//  GL_STORAGE_CACHED_APPLE = $85BE;  Doppelt
//  GL_STORAGE_SHARED_APPLE = $85BF;  
type
  TPFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC = procedure (length:TGLsizei; pointer:pointer);cdecl;
  TPFNGLVERTEXARRAYPARAMETERIAPPLEPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLVERTEXARRAYRANGEAPPLEPROC = procedure (length:TGLsizei; pointer:pointer);cdecl;


{ ------------------- GL_APPLE_vertex_program_evaluators ------------------  }

const
  GL_APPLE_vertex_program_evaluators = 1;  
  GL_VERTEX_ATTRIB_MAP1_APPLE = $8A00;  
  GL_VERTEX_ATTRIB_MAP2_APPLE = $8A01;  
  GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE = $8A02;  
  GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE = $8A03;  
  GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE = $8A04;  
  GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = $8A05;  
  GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE = $8A06;  
  GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE = $8A07;  
  GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE = $8A08;  
  GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = $8A09;  
type
  TPFNGLDISABLEVERTEXATTRIBAPPLEPROC = procedure (index:TGLuint; pname:TGLenum);cdecl;
  TPFNGLENABLEVERTEXATTRIBAPPLEPROC = procedure (index:TGLuint; pname:TGLenum);cdecl;
  TPFNGLISVERTEXATTRIBENABLEDAPPLEPROC = function (index:TGLuint; pname:TGLenum):TGLboolean;cdecl;
  TPFNGLMAPVERTEXATTRIB1DAPPLEPROC = procedure (index:TGLuint; size:TGLuint; u1:TGLdouble; u2:TGLdouble; stride:TGLint;
                order:TGLint; points:PGLdouble);cdecl;
  TPFNGLMAPVERTEXATTRIB1FAPPLEPROC = procedure (index:TGLuint; size:TGLuint; u1:TGLfloat; u2:TGLfloat; stride:TGLint;
                order:TGLint; points:PGLfloat);cdecl;
  TPFNGLMAPVERTEXATTRIB2DAPPLEPROC = procedure (index:TGLuint; size:TGLuint; u1:TGLdouble; u2:TGLdouble; ustride:TGLint;
                uorder:TGLint; v1:TGLdouble; v2:TGLdouble; vstride:TGLint; vorder:TGLint; 
                points:PGLdouble);cdecl;
  TPFNGLMAPVERTEXATTRIB2FAPPLEPROC = procedure (index:TGLuint; size:TGLuint; u1:TGLfloat; u2:TGLfloat; ustride:TGLint;
                uorder:TGLint; v1:TGLfloat; v2:TGLfloat; vstride:TGLint; vorder:TGLint; 
                points:PGLfloat);cdecl;


{ --------------------------- GL_APPLE_ycbcr_422 --------------------------  }

const
  GL_APPLE_ycbcr_422 = 1;  
  GL_YCBCR_422_APPLE = $85B9;  


{ ------------------------ GL_ARB_ES2_compatibility -----------------------  }

const
  GL_ARB_ES2_compatibility = 1;  
  GL_FIXED = $140C;  
  GL_IMPLEMENTATION_COLOR_READ_TYPE = $8B9A;  
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B;  
  GL_RGB565 = $8D62;  
  GL_LOW_FLOAT = $8DF0;  
  GL_MEDIUM_FLOAT = $8DF1;  
  GL_HIGH_FLOAT = $8DF2;  
  GL_LOW_INT = $8DF3;  
  GL_MEDIUM_INT = $8DF4;  
  GL_HIGH_INT = $8DF5;  
  GL_SHADER_BINARY_FORMATS = $8DF8;  
  GL_NUM_SHADER_BINARY_FORMATS = $8DF9;  
  GL_SHADER_COMPILER = $8DFA;  
  GL_MAX_VERTEX_UNIFORM_VECTORS = $8DFB;  
  GL_MAX_VARYING_VECTORS = $8DFC;  
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD;  
type
  PGLfixed = ^TGLfixed;
  TGLfixed = longint;

  TPFNGLCLEARDEPTHFPROC = procedure (d:TGLclampf);cdecl;
  TPFNGLDEPTHRANGEFPROC = procedure (n:TGLclampf; f:TGLclampf);cdecl;
  TPFNGLGETSHADERPRECISIONFORMATPROC = procedure (shadertype:TGLenum; precisiontype:TGLenum; range:PGLint; precision:PGLint);cdecl;
  TPFNGLRELEASESHADERCOMPILERPROC = procedure (para1:pointer);cdecl;
  TPFNGLSHADERBINARYPROC = procedure (count:TGLsizei; shaders:PGLuint; binaryformat:TGLenum; binary:pointer; length:TGLsizei);cdecl;


{ ----------------------- GL_ARB_ES3_1_compatibility ----------------------  }

const
  GL_ARB_ES3_1_compatibility = 1;  
type
  TPFNGLMEMORYBARRIERBYREGIONPROC = procedure (barriers:TGLbitfield);cdecl;


{ ----------------------- GL_ARB_ES3_2_compatibility ----------------------  }

const
  GL_ARB_ES3_2_compatibility = 1;  
  GL_PRIMITIVE_BOUNDING_BOX_ARB = $92BE;  
  GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB = $9381;  
  GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = $9382;  
type

  TPFNGLPRIMITIVEBOUNDINGBOXARBPROC = procedure (minX:TGLfloat; minY:TGLfloat; minZ:TGLfloat; minW:TGLfloat; maxX:TGLfloat; 
                maxY:TGLfloat; maxZ:TGLfloat; maxW:TGLfloat);cdecl;


{ ------------------------ GL_ARB_ES3_compatibility -----------------------  }

const
  GL_ARB_ES3_compatibility = 1;  
  GL_TEXTURE_IMMUTABLE_LEVELS = $82DF;  
  GL_PRIMITIVE_RESTART_FIXED_INDEX = $8D69;  
  GL_ANY_SAMPLES_PASSED_CONSERVATIVE = $8D6A;  
  GL_MAX_ELEMENT_INDEX = $8D6B;  
  GL_COMPRESSED_R11_EAC = $9270;  
  GL_COMPRESSED_SIGNED_R11_EAC = $9271;  
  GL_COMPRESSED_RG11_EAC = $9272;  
  GL_COMPRESSED_SIGNED_RG11_EAC = $9273;  
  GL_COMPRESSED_RGB8_ETC2 = $9274;  
  GL_COMPRESSED_SRGB8_ETC2 = $9275;  
  GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9276;  
  GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9277;  
  GL_COMPRESSED_RGBA8_ETC2_EAC = $9278;  
  GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = $9279;  


{ ------------------------ GL_ARB_arrays_of_arrays ------------------------  }

const
  GL_ARB_arrays_of_arrays = 1;  


{ -------------------------- GL_ARB_base_instance -------------------------  }

const
  GL_ARB_base_instance = 1;  
type
 TPFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei; baseinstance:TGLuint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei;
                baseinstance:TGLuint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei;
                basevertex:TGLint; baseinstance:TGLuint);cdecl;


{ ------------------------ GL_ARB_bindless_texture ------------------------  }

const
  GL_ARB_bindless_texture = 1;  
  GL_UNSIGNED_INT64_ARB = $140F;  
type
  TPFNGLGETIMAGEHANDLEARBPROC = function (texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; format:TGLenum):TGLuint64;cdecl;
  TPFNGLGETTEXTUREHANDLEARBPROC = function (texture:TGLuint):TGLuint64;cdecl;
  TPFNGLGETTEXTURESAMPLERHANDLEARBPROC = function (texture:TGLuint; sampler:TGLuint):TGLuint64;cdecl;
  TPFNGLGETVERTEXATTRIBLUI64VARBPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;
  TPFNGLISIMAGEHANDLERESIDENTARBPROC = function (handle:TGLuint64):TGLboolean;cdecl;
  TPFNGLISTEXTUREHANDLERESIDENTARBPROC = function (handle:TGLuint64):TGLboolean;cdecl;
  TPFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLMAKEIMAGEHANDLERESIDENTARBPROC = procedure (handle:TGLuint64; access:TGLenum);cdecl;
  TPFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLMAKETEXTUREHANDLERESIDENTARBPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC = procedure (prog:TGLuint; location:TGLint; value:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; values:PGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64ARBPROC = procedure (location:TGLint; value:TGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLVERTEXATTRIBL1UI64ARBPROC = procedure (index:TGLuint; x:TGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL1UI64VARBPROC = procedure (index:TGLuint; v:PGLuint64EXT);cdecl;


{ ----------------------- GL_ARB_blend_func_extended ----------------------  }

const
  GL_ARB_blend_func_extended = 1;  
  GL_SRC1_COLOR = $88F9;  
  GL_ONE_MINUS_SRC1_COLOR = $88FA;  
  GL_ONE_MINUS_SRC1_ALPHA = $88FB;  
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = $88FC;  
type
  TPFNGLBINDFRAGDATALOCATIONINDEXEDPROC = procedure (prog:TGLuint; colorNumber:TGLuint; index:TGLuint; name:PGLchar);cdecl;
  TPFNGLGETFRAGDATAINDEXPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;


{ ------------------------- GL_ARB_buffer_storage -------------------------  }

const
  GL_ARB_buffer_storage = 1;  
  GL_MAP_READ_BIT = $0001;  
  GL_MAP_WRITE_BIT = $0002;  
  GL_MAP_PERSISTENT_BIT = $00000040;  
  GL_MAP_COHERENT_BIT = $00000080;  
  GL_DYNAMIC_STORAGE_BIT = $0100;  
  GL_CLIENT_STORAGE_BIT = $0200;  
  GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = $00004000;  
  GL_BUFFER_IMMUTABLE_STORAGE = $821F;  
  GL_BUFFER_STORAGE_FLAGS = $8220;  
type
  TPFNGLBUFFERSTORAGEPROC = procedure (target:TGLenum; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;


{ ---------------------------- GL_ARB_cl_event ----------------------------  }

const
  GL_ARB_cl_event = 1;  
  GL_SYNC_CL_EVENT_ARB = $8240;  
  GL_SYNC_CL_EVENT_COMPLETE_ARB = $8241;  
type
  Pcl_context = ^Tcl_context;
  Tcl_context = Pcl_context;

  Pcl_event = ^Tcl_event;
  Tcl_event = Pcl_event;

  TPFNGLCREATESYNCFROMCLEVENTARBPROC = function (context:Tcl_context; event:Tcl_event; flags:TGLbitfield):TGLsync;cdecl;


{ ----------------------- GL_ARB_clear_buffer_object ----------------------  }

const
  GL_ARB_clear_buffer_object = 1;  
type
  TPFNGLCLEARBUFFERDATAPROC = procedure (target:TGLenum; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARBUFFERSUBDATAPROC = procedure (target:TGLenum; internalformat:TGLenum; offset:TGLintptr; size:TGLsizeiptr; format:TGLenum;
                _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARNAMEDBUFFERDATAEXTPROC = procedure (buffer:TGLuint; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC = procedure (buffer:TGLuint; internalformat:TGLenum; offset:TGLintptr; size:TGLsizeiptr; format:TGLenum;
                _type:TGLenum; data:pointer);cdecl;


{ -------------------------- GL_ARB_clear_texture -------------------------  }

const
  GL_ARB_clear_texture = 1;  
  GL_CLEAR_TEXTURE = $9365;  
type
  TPFNGLCLEARTEXIMAGEPROC = procedure (texture:TGLuint; level:TGLint; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARTEXSUBIMAGEPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                data:pointer);cdecl;


{ -------------------------- GL_ARB_clip_control --------------------------  }

const
  GL_ARB_clip_control = 1;  
//  GL_LOWER_LEFT = $8CA1;   Doppelt
//  GL_UPPER_LEFT = $8CA2;  
  GL_CLIP_ORIGIN = $935C;  
  GL_CLIP_DEPTH_MODE = $935D;  
  GL_NEGATIVE_ONE_TO_ONE = $935E;  
  GL_ZERO_TO_ONE = $935F;  
type
  TPFNGLCLIPCONTROLPROC = procedure (origin:TGLenum; depth:TGLenum);cdecl;


{ ----------------------- GL_ARB_color_buffer_float -----------------------  }

const
  GL_ARB_color_buffer_float = 1;  
  GL_RGBA_FLOAT_MODE_ARB = $8820;  
  GL_CLAMP_VERTEX_COLOR_ARB = $891A;  
  GL_CLAMP_FRAGMENT_COLOR_ARB = $891B;  
  GL_CLAMP_READ_COLOR_ARB = $891C;  
  GL_FIXED_ONLY_ARB = $891D;  
type
  TPFNGLCLAMPCOLORARBPROC = procedure (target:TGLenum; clamp:TGLenum);cdecl;


{ -------------------------- GL_ARB_compatibility -------------------------  }

const
  GL_ARB_compatibility = 1;  


{ ---------------- GL_ARB_compressed_texture_pixel_storage ----------------  }

const
  GL_ARB_compressed_texture_pixel_storage = 1;  
  GL_UNPACK_COMPRESSED_BLOCK_WIDTH = $9127;  
  GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = $9128;  
  GL_UNPACK_COMPRESSED_BLOCK_DEPTH = $9129;  
  GL_UNPACK_COMPRESSED_BLOCK_SIZE = $912A;  
  GL_PACK_COMPRESSED_BLOCK_WIDTH = $912B;  
  GL_PACK_COMPRESSED_BLOCK_HEIGHT = $912C;  
  GL_PACK_COMPRESSED_BLOCK_DEPTH = $912D;  
  GL_PACK_COMPRESSED_BLOCK_SIZE = $912E;  


{ ------------------------- GL_ARB_compute_shader -------------------------  }

const
  GL_ARB_compute_shader = 1;  
  GL_COMPUTE_SHADER_BIT = $00000020;  
  GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = $8262;  
  GL_MAX_COMPUTE_UNIFORM_COMPONENTS = $8263;  
  GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = $8264;  
  GL_MAX_COMPUTE_ATOMIC_COUNTERS = $8265;  
  GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = $8266;  
  GL_COMPUTE_WORK_GROUP_SIZE = $8267;  
  GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = $90EB;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = $90EC;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = $90ED;  
  GL_DISPATCH_INDIRECT_BUFFER = $90EE;  
  GL_DISPATCH_INDIRECT_BUFFER_BINDING = $90EF;  
  GL_COMPUTE_SHADER = $91B9;  
  GL_MAX_COMPUTE_UNIFORM_BLOCKS = $91BB;  
  GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = $91BC;  
  GL_MAX_COMPUTE_IMAGE_UNIFORMS = $91BD;  
  GL_MAX_COMPUTE_WORK_GROUP_COUNT = $91BE;  
  GL_MAX_COMPUTE_WORK_GROUP_SIZE = $91BF;  
type
  TPFNGLDISPATCHCOMPUTEPROC = procedure (num_groups_x:TGLuint; num_groups_y:TGLuint; num_groups_z:TGLuint);cdecl;
  TPFNGLDISPATCHCOMPUTEINDIRECTPROC = procedure (indirect:TGLintptr);cdecl;


{ ------------------- GL_ARB_compute_variable_group_size ------------------  }

const
  GL_ARB_compute_variable_group_size = 1;  
  GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = $90EB;  
  GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = $91BF;  
  GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = $9344;  
  GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = $9345;  
type
  TPFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC = procedure (num_groups_x:TGLuint; num_groups_y:TGLuint; num_groups_z:TGLuint; group_size_x:TGLuint; group_size_y:TGLuint;
                group_size_z:TGLuint);cdecl;


{ ------------------- GL_ARB_conditional_render_inverted ------------------  }

const
  GL_ARB_conditional_render_inverted = 1;  
  GL_QUERY_WAIT_INVERTED = $8E17;  
  GL_QUERY_NO_WAIT_INVERTED = $8E18;  
  GL_QUERY_BY_REGION_WAIT_INVERTED = $8E19;  
  GL_QUERY_BY_REGION_NO_WAIT_INVERTED = $8E1A;  


{ ----------------------- GL_ARB_conservative_depth -----------------------  }

const
  GL_ARB_conservative_depth = 1;  


{ --------------------------- GL_ARB_copy_buffer --------------------------  }

const
  GL_ARB_copy_buffer = 1;  
  GL_COPY_READ_BUFFER = $8F36;  
  GL_COPY_WRITE_BUFFER = $8F37;  
type
  TPFNGLCOPYBUFFERSUBDATAPROC = procedure (readtarget:TGLenum; writetarget:TGLenum; readoffset:TGLintptr; writeoffset:TGLintptr; size:TGLsizeiptr);cdecl;


{ --------------------------- GL_ARB_copy_image ---------------------------  }

const
  GL_ARB_copy_image = 1;  
type
  TPFNGLCOPYIMAGESUBDATAPROC = procedure (srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint;
                srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
                dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;


{ -------------------------- GL_ARB_cull_distance -------------------------  }

const
  GL_ARB_cull_distance = 1;  
  GL_MAX_CULL_DISTANCES = $82F9;  
  GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = $82FA;  


{ -------------------------- GL_ARB_debug_output --------------------------  }

const
  GL_ARB_debug_output = 1;  
  GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB = $8242;  
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = $8243;  
  GL_DEBUG_CALLBACK_FUNCTION_ARB = $8244;  
  GL_DEBUG_CALLBACK_USER_PARAM_ARB = $8245;  
  GL_DEBUG_SOURCE_API_ARB = $8246;  
  GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = $8247;  
  GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = $8248;  
  GL_DEBUG_SOURCE_THIRD_PARTY_ARB = $8249;  
  GL_DEBUG_SOURCE_APPLICATION_ARB = $824A;  
  GL_DEBUG_SOURCE_OTHER_ARB = $824B;  
  GL_DEBUG_TYPE_ERROR_ARB = $824C;  
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = $824D;  
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = $824E;  
  GL_DEBUG_TYPE_PORTABILITY_ARB = $824F;  
  GL_DEBUG_TYPE_PERFORMANCE_ARB = $8250;  
  GL_DEBUG_TYPE_OTHER_ARB = $8251;  
  GL_MAX_DEBUG_MESSAGE_LENGTH_ARB = $9143;  
  GL_MAX_DEBUG_LOGGED_MESSAGES_ARB = $9144;  
  GL_DEBUG_LOGGED_MESSAGES_ARB = $9145;  
  GL_DEBUG_SEVERITY_HIGH_ARB = $9146;  
  GL_DEBUG_SEVERITY_MEDIUM_ARB = $9147;  
  GL_DEBUG_SEVERITY_LOW_ARB = $9148;  
type
  TGLDEBUGPROCARB = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei;
                message:PGLchar; userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGECALLBACKARBPROC = procedure (callback:TGLDEBUGPROCARB; userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGECONTROLARBPROC = procedure (source:TGLenum; _type:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint;
                enabled:TGLboolean);cdecl;
  TPFNGLDEBUGMESSAGEINSERTARBPROC = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei;
                buf:PGLchar);cdecl;
  TPFNGLGETDEBUGMESSAGELOGARBPROC = function (count:TGLuint; bufSize:TGLsizei; sources:PGLenum; types:PGLenum; ids:PGLuint;
               severities:PGLenum; lengths:PGLsizei; messageLog:PGLchar):TGLuint;cdecl;


{ ----------------------- GL_ARB_depth_buffer_float -----------------------  }

const
  GL_ARB_depth_buffer_float = 1;  
  GL_DEPTH_COMPONENT32F = $8CAC;  
  GL_DEPTH32F_STENCIL8 = $8CAD;  
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV = $8DAD;  


{ --------------------------- GL_ARB_depth_clamp --------------------------  }

const
  GL_ARB_depth_clamp = 1;  
  GL_DEPTH_CLAMP = $864F;  


{ -------------------------- GL_ARB_depth_texture -------------------------  }

const
  GL_ARB_depth_texture = 1;  
  GL_DEPTH_COMPONENT16_ARB = $81A5;  
  GL_DEPTH_COMPONENT24_ARB = $81A6;  
  GL_DEPTH_COMPONENT32_ARB = $81A7;  
  GL_TEXTURE_DEPTH_SIZE_ARB = $884A;  
  GL_DEPTH_TEXTURE_MODE_ARB = $884B;  


{ ----------------------- GL_ARB_derivative_control -----------------------  }

const
  GL_ARB_derivative_control = 1;  


{ ----------------------- GL_ARB_direct_state_access ----------------------  }

const
  GL_ARB_direct_state_access = 1;  
  GL_TEXTURE_TARGET = $1006;  
  GL_QUERY_TARGET = $82EA;  
type
  TPFNGLBINDTEXTUREUNITPROC = procedure (unit_:TGLuint; texture:TGLuint);cdecl;
  TPFNGLBLITNAMEDFRAMEBUFFERPROC = procedure (readFramebuffer:TGLuint; drawFramebuffer:TGLuint; srcX0:TGLint; srcY0:TGLint; srcX1:TGLint;
                srcY1:TGLint; dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; 
                mask:TGLbitfield; filter:TGLenum);cdecl;
  TPFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC = function (framebuffer:TGLuint; target:TGLenum):TGLenum;cdecl;
  TPFNGLCLEARNAMEDBUFFERDATAPROC = procedure (buffer:TGLuint; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARNAMEDBUFFERSUBDATAPROC = procedure (buffer:TGLuint; internalformat:TGLenum; offset:TGLintptr; size:TGLsizeiptr; format:TGLenum;
                _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARNAMEDFRAMEBUFFERFIPROC = procedure (framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; depth:TGLfloat; stencil:TGLint);cdecl;
  TPFNGLCLEARNAMEDFRAMEBUFFERFVPROC = procedure (framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLfloat);cdecl;
  TPFNGLCLEARNAMEDFRAMEBUFFERIVPROC = procedure (framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLint);cdecl;
  TPFNGLCLEARNAMEDFRAMEBUFFERUIVPROC = procedure (framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLuint);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum;
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei;
                height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
                data:pointer);cdecl;
  TPFNGLCOPYNAMEDBUFFERSUBDATAPROC = procedure (readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE1DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; x:TGLint; y:TGLint;
                width:TGLsizei);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE2DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; x:TGLint;
                y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE3DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCREATEBUFFERSPROC = procedure (n:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLCREATEFRAMEBUFFERSPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLCREATEPROGRAMPIPELINESPROC = procedure (n:TGLsizei; pipelines:PGLuint);cdecl;
  TPFNGLCREATEQUERIESPROC = procedure (target:TGLenum; n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLCREATERENDERBUFFERSPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLCREATESAMPLERSPROC = procedure (n:TGLsizei; samplers:PGLuint);cdecl;
  TPFNGLCREATETEXTURESPROC = procedure (target:TGLenum; n:TGLsizei; textures:PGLuint);cdecl;
  TPFNGLCREATETRANSFORMFEEDBACKSPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLCREATEVERTEXARRAYSPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLDISABLEVERTEXARRAYATTRIBPROC = procedure (vaobj:TGLuint; index:TGLuint);cdecl;
  TPFNGLENABLEVERTEXARRAYATTRIBPROC = procedure (vaobj:TGLuint; index:TGLuint);cdecl;
  TPFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC = procedure (buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;
  TPFNGLGENERATETEXTUREMIPMAPPROC = procedure (texture:TGLuint);cdecl;
  TPFNGLGETCOMPRESSEDTEXTUREIMAGEPROC = procedure (texture:TGLuint; level:TGLint; bufSize:TGLsizei; pixels:pointer);cdecl;
  TPFNGLGETNAMEDBUFFERPARAMETERI64VPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLGETNAMEDBUFFERPARAMETERIVPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDBUFFERPOINTERVPROC = procedure (buffer:TGLuint; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLGETNAMEDBUFFERSUBDATAPROC = procedure (buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC = procedure (framebuffer:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC = procedure (renderbuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETQUERYBUFFEROBJECTI64VPROC = procedure (id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;
  TPFNGLGETQUERYBUFFEROBJECTIVPROC = procedure (id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;
  TPFNGLGETQUERYBUFFEROBJECTUI64VPROC = procedure (id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;
  TPFNGLGETQUERYBUFFEROBJECTUIVPROC = procedure (id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;
  TPFNGLGETTEXTUREIMAGEPROC = procedure (texture:TGLuint; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei;                pixels:pointer);cdecl;
  TPFNGLGETTEXTURELEVELPARAMETERFVPROC = procedure (texture:TGLuint; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETTEXTURELEVELPARAMETERIVPROC = procedure (texture:TGLuint; level:TGLint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXTUREPARAMETERIIVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXTUREPARAMETERIUIVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETTEXTUREPARAMETERFVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETTEXTUREPARAMETERIVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKI64_VPROC = procedure (xfb:TGLuint; pname:TGLenum; index:TGLuint; param:PGLint64);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKI_VPROC = procedure (xfb:TGLuint; pname:TGLenum; index:TGLuint; param:PGLint);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKIVPROC = procedure (xfb:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETVERTEXARRAYINDEXED64IVPROC = procedure (vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint64);cdecl;
  TPFNGLGETVERTEXARRAYINDEXEDIVPROC = procedure (vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETVERTEXARRAYIVPROC = procedure (vaobj:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC = procedure (framebuffer:TGLuint; numAttachments:TGLsizei; attachments:PGLenum);cdecl;
  TPFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC = procedure (framebuffer:TGLuint; numAttachments:TGLsizei; attachments:PGLenum; x:TGLint; y:TGLint;                width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLMAPNAMEDBUFFERPROC = function (buffer:TGLuint; access:TGLenum):pointer;cdecl;
  TPFNGLMAPNAMEDBUFFERRANGEPROC = function (buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;
  TPFNGLNAMEDBUFFERDATAPROC = procedure (buffer:TGLuint; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;
  TPFNGLNAMEDBUFFERSTORAGEPROC = procedure (buffer:TGLuint; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;
  TPFNGLNAMEDBUFFERSUBDATAPROC = procedure (buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC = procedure (framebuffer:TGLuint; mode:TGLenum);cdecl;
  TPFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC = procedure (framebuffer:TGLuint; n:TGLsizei; bufs:PGLenum);cdecl;
  TPFNGLNAMEDFRAMEBUFFERPARAMETERIPROC = procedure (framebuffer:TGLuint; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERREADBUFFERPROC = procedure (framebuffer:TGLuint; mode:TGLenum);cdecl;
  TPFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTUREPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;
  TPFNGLNAMEDRENDERBUFFERSTORAGEPROC = procedure (renderbuffer:TGLuint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC = procedure (renderbuffer:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLTEXTUREBUFFERPROC = procedure (texture:TGLuint; internalformat:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLTEXTUREBUFFERRANGEPROC = procedure (texture:TGLuint; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLTEXTUREPARAMETERIIVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXTUREPARAMETERIUIVPROC = procedure (texture:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLTEXTUREPARAMETERFPROC = procedure (texture:TGLuint; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLTEXTUREPARAMETERFVPROC = procedure (texture:TGLuint; pname:TGLenum; param:PGLfloat);cdecl;
  TPFNGLTEXTUREPARAMETERIPROC = procedure (texture:TGLuint; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLTEXTUREPARAMETERIVPROC = procedure (texture:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLTEXTURESTORAGE1DPROC = procedure (texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE2DPROC = procedure (texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE2DMULTISAMPLEPROC = procedure (texture:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXTURESTORAGE3DPROC = procedure (texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE3DMULTISAMPLEPROC = procedure (texture:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXTURESUBIMAGE1DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum;
                _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTURESUBIMAGE2DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei;
                height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTURESUBIMAGE3DPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;
  TPFNGLTRANSFORMFEEDBACKBUFFERBASEPROC = procedure (xfb:TGLuint; index:TGLuint; buffer:TGLuint);cdecl;
  TPFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC = procedure (xfb:TGLuint; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLUNMAPNAMEDBUFFERPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLVERTEXARRAYATTRIBBINDINGPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; bindingindex:TGLuint);cdecl;
  TPFNGLVERTEXARRAYATTRIBFORMATPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean;
                relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYATTRIBIFORMATPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYATTRIBLFORMATPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYBINDINGDIVISORPROC = procedure (vaobj:TGLuint; bindingindex:TGLuint; divisor:TGLuint);cdecl;
  TPFNGLVERTEXARRAYELEMENTBUFFERPROC = procedure (vaobj:TGLuint; buffer:TGLuint);cdecl;
  TPFNGLVERTEXARRAYVERTEXBUFFERPROC = procedure (vaobj:TGLuint; bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;
  TPFNGLVERTEXARRAYVERTEXBUFFERSPROC = procedure (vaobj:TGLuint; first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr;                strides:PGLsizei);cdecl;


{ -------------------------- GL_ARB_draw_buffers --------------------------  }

const
  GL_ARB_draw_buffers = 1;  
  GL_MAX_DRAW_BUFFERS_ARB = $8824;  
  GL_DRAW_BUFFER0_ARB = $8825;  
  GL_DRAW_BUFFER1_ARB = $8826;  
  GL_DRAW_BUFFER2_ARB = $8827;  
  GL_DRAW_BUFFER3_ARB = $8828;  
  GL_DRAW_BUFFER4_ARB = $8829;  
  GL_DRAW_BUFFER5_ARB = $882A;  
  GL_DRAW_BUFFER6_ARB = $882B;  
  GL_DRAW_BUFFER7_ARB = $882C;  
  GL_DRAW_BUFFER8_ARB = $882D;  
  GL_DRAW_BUFFER9_ARB = $882E;  
  GL_DRAW_BUFFER10_ARB = $882F;  
  GL_DRAW_BUFFER11_ARB = $8830;  
  GL_DRAW_BUFFER12_ARB = $8831;  
  GL_DRAW_BUFFER13_ARB = $8832;  
  GL_DRAW_BUFFER14_ARB = $8833;  
  GL_DRAW_BUFFER15_ARB = $8834;  
type
  TPFNGLDRAWBUFFERSARBPROC = procedure (n:TGLsizei; bufs:PGLenum);cdecl;


{ ----------------------- GL_ARB_draw_buffers_blend -----------------------  }

const
  GL_ARB_draw_buffers_blend = 1;  
type
  TPFNGLBLENDEQUATIONSEPARATEIARBPROC = procedure (buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLBLENDEQUATIONIARBPROC = procedure (buf:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEIARBPROC = procedure (buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;
  TPFNGLBLENDFUNCIARBPROC = procedure (buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;


{ -------------------- GL_ARB_draw_elements_base_vertex -------------------  }

const
  GL_ARB_draw_elements_base_vertex = 1;  
type
  TPFNGLDRAWELEMENTSBASEVERTEXPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; basevertex:TGLint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei;
                basevertex:TGLint);cdecl;
  TPFNGLDRAWRANGEELEMENTSBASEVERTEXPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum;
                indices:pointer; basevertex:TGLint);cdecl;
  TPFNGLMULTIDRAWELEMENTSBASEVERTEXPROC = procedure (mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; drawcount:TGLsizei;
                basevertex:PGLint);cdecl;


{ -------------------------- GL_ARB_draw_indirect -------------------------  }

const
  GL_ARB_draw_indirect = 1;  
  GL_DRAW_INDIRECT_BUFFER = $8F3F;  
  GL_DRAW_INDIRECT_BUFFER_BINDING = $8F43;  
type
  TPFNGLDRAWARRAYSINDIRECTPROC = procedure (mode:TGLenum; indirect:pointer);cdecl;
  TPFNGLDRAWELEMENTSINDIRECTPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer);cdecl;


{ ------------------------- GL_ARB_draw_instanced -------------------------  }

const
  GL_ARB_draw_instanced = 1;  


{ ------------------------ GL_ARB_enhanced_layouts ------------------------  }

const
  GL_ARB_enhanced_layouts = 1;  
  GL_LOCATION_COMPONENT = $934A;  
  GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = $934B;  
  GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = $934C;  


{ -------------------- GL_ARB_explicit_attrib_location --------------------  }

const
  GL_ARB_explicit_attrib_location = 1;  


{ -------------------- GL_ARB_explicit_uniform_location -------------------  }

const
  GL_ARB_explicit_uniform_location = 1;  
  GL_MAX_UNIFORM_LOCATIONS = $826E;  


{ ------------------- GL_ARB_fragment_coord_conventions -------------------  }

const
  GL_ARB_fragment_coord_conventions = 1;  


{ --------------------- GL_ARB_fragment_layer_viewport --------------------  }

const
  GL_ARB_fragment_layer_viewport = 1;  


{ ------------------------ GL_ARB_fragment_program ------------------------  }

const
  GL_ARB_fragment_program = 1;  
  GL_FRAGMENT_PROGRAM_ARB = $8804;  
  GL_PROGRAM_ALU_INSTRUCTIONS_ARB = $8805;  
  GL_PROGRAM_TEX_INSTRUCTIONS_ARB = $8806;  
  GL_PROGRAM_TEX_INDIRECTIONS_ARB = $8807;  
  GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $8808;  
  GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $8809;  
  GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $880A;  
  GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = $880B;  
  GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = $880C;  
  GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB = $880D;  
  GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $880E;  
  GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $880F;  
  GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $8810;  
  GL_MAX_TEXTURE_COORDS_ARB = $8871;  
  GL_MAX_TEXTURE_IMAGE_UNITS_ARB = $8872;  


{ --------------------- GL_ARB_fragment_program_shadow --------------------  }

const
  GL_ARB_fragment_program_shadow = 1;  


{ ------------------------- GL_ARB_fragment_shader ------------------------  }

const
  GL_ARB_fragment_shader = 1;  
  GL_FRAGMENT_SHADER_ARB = $8B30;  
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = $8B49;  
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = $8B8B;  


{ -------------------- GL_ARB_fragment_shader_interlock -------------------  }

const
  GL_ARB_fragment_shader_interlock = 1;  


{ ------------------- GL_ARB_framebuffer_no_attachments -------------------  }

const
  GL_ARB_framebuffer_no_attachments = 1;  
  GL_FRAMEBUFFER_DEFAULT_WIDTH = $9310;  
  GL_FRAMEBUFFER_DEFAULT_HEIGHT = $9311;  
  GL_FRAMEBUFFER_DEFAULT_LAYERS = $9312;  
  GL_FRAMEBUFFER_DEFAULT_SAMPLES = $9313;  
  GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = $9314;  
  GL_MAX_FRAMEBUFFER_WIDTH = $9315;  
  GL_MAX_FRAMEBUFFER_HEIGHT = $9316;  
  GL_MAX_FRAMEBUFFER_LAYERS = $9317;  
  GL_MAX_FRAMEBUFFER_SAMPLES = $9318;  
type
  TPFNGLFRAMEBUFFERPARAMETERIPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLGETFRAMEBUFFERPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC = procedure (framebuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC = procedure (framebuffer:TGLuint; pname:TGLenum; param:TGLint);cdecl;


{ ----------------------- GL_ARB_framebuffer_object -----------------------  }

const
  GL_ARB_framebuffer_object = 1;  
  GL_INVALID_FRAMEBUFFER_OPERATION = $0506;  
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = $8210;  
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = $8211;  
  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = $8212;  
  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = $8213;  
  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = $8214;  
  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = $8215;  
  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = $8216;  
  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = $8217;  
  GL_FRAMEBUFFER_DEFAULT = $8218;  
  GL_FRAMEBUFFER_UNDEFINED = $8219;  
  GL_DEPTH_STENCIL_ATTACHMENT = $821A;  
  GL_INDEX = $8222;  
  GL_MAX_RENDERBUFFER_SIZE = $84E8;  
  GL_DEPTH_STENCIL = $84F9;  
  GL_UNSIGNED_INT_24_8 = $84FA;  
  GL_DEPTH24_STENCIL8 = $88F0;  
  GL_TEXTURE_STENCIL_SIZE = $88F1;  
  GL_UNSIGNED_NORMALIZED = $8C17;  
//  GL_SRGB = $8C40;  doppelt
  GL_DRAW_FRAMEBUFFER_BINDING = $8CA6;  
  GL_FRAMEBUFFER_BINDING = $8CA6;  
  GL_RENDERBUFFER_BINDING = $8CA7;  
  GL_READ_FRAMEBUFFER = $8CA8;  
  GL_DRAW_FRAMEBUFFER = $8CA9;  
  GL_READ_FRAMEBUFFER_BINDING = $8CAA;  
  GL_RENDERBUFFER_SAMPLES = $8CAB;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = $8CD0;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = $8CD1;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = $8CD2;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = $8CD3;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = $8CD4;  
  GL_FRAMEBUFFER_COMPLETE = $8CD5;  
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = $8CD6;  
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = $8CD7;  
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = $8CDB;  
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = $8CDC;  
  GL_FRAMEBUFFER_UNSUPPORTED = $8CDD;  
  GL_MAX_COLOR_ATTACHMENTS = $8CDF;  
  GL_COLOR_ATTACHMENT0 = $8CE0;  
  GL_COLOR_ATTACHMENT1 = $8CE1;  
  GL_COLOR_ATTACHMENT2 = $8CE2;  
  GL_COLOR_ATTACHMENT3 = $8CE3;  
  GL_COLOR_ATTACHMENT4 = $8CE4;  
  GL_COLOR_ATTACHMENT5 = $8CE5;  
  GL_COLOR_ATTACHMENT6 = $8CE6;  
  GL_COLOR_ATTACHMENT7 = $8CE7;  
  GL_COLOR_ATTACHMENT8 = $8CE8;  
  GL_COLOR_ATTACHMENT9 = $8CE9;  
  GL_COLOR_ATTACHMENT10 = $8CEA;  
  GL_COLOR_ATTACHMENT11 = $8CEB;  
  GL_COLOR_ATTACHMENT12 = $8CEC;  
  GL_COLOR_ATTACHMENT13 = $8CED;  
  GL_COLOR_ATTACHMENT14 = $8CEE;  
  GL_COLOR_ATTACHMENT15 = $8CEF;  
  GL_DEPTH_ATTACHMENT = $8D00;  
  GL_STENCIL_ATTACHMENT = $8D20;  
  GL_FRAMEBUFFER = $8D40;  
  GL_RENDERBUFFER = $8D41;  
  GL_RENDERBUFFER_WIDTH = $8D42;  
  GL_RENDERBUFFER_HEIGHT = $8D43;  
  GL_RENDERBUFFER_INTERNAL_FORMAT = $8D44;  
  GL_STENCIL_INDEX1 = $8D46;  
  GL_STENCIL_INDEX4 = $8D47;  
  GL_STENCIL_INDEX8 = $8D48;  
  GL_STENCIL_INDEX16 = $8D49;  
  GL_RENDERBUFFER_RED_SIZE = $8D50;  
  GL_RENDERBUFFER_GREEN_SIZE = $8D51;  
  GL_RENDERBUFFER_BLUE_SIZE = $8D52;  
  GL_RENDERBUFFER_ALPHA_SIZE = $8D53;  
  GL_RENDERBUFFER_DEPTH_SIZE = $8D54;  
  GL_RENDERBUFFER_STENCIL_SIZE = $8D55;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = $8D56;  
  GL_MAX_SAMPLES = $8D57;  
type
  TPFNGLBINDFRAMEBUFFERPROC = procedure (target:TGLenum; framebuffer:TGLuint);cdecl;
  TPFNGLBINDRENDERBUFFERPROC = procedure (target:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLBLITFRAMEBUFFERPROC = procedure (srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint;
                dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;
  TPFNGLCHECKFRAMEBUFFERSTATUSPROC = function (target:TGLenum):TGLenum;cdecl;
  TPFNGLDELETEFRAMEBUFFERSPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLDELETERENDERBUFFERSPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLFRAMEBUFFERRENDERBUFFERPROC = procedure (target:TGLenum; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE1DPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE2DPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE3DPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;
                layer:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURELAYERPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;
  TPFNGLGENFRAMEBUFFERSPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLGENRENDERBUFFERSPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLGENERATEMIPMAPPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC = procedure (target:TGLenum; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETRENDERBUFFERPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISFRAMEBUFFERPROC = function (framebuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLISRENDERBUFFERPROC = function (renderbuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLRENDERBUFFERSTORAGEPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ------------------------ GL_ARB_framebuffer_sRGB ------------------------  }

const
  GL_ARB_framebuffer_sRGB = 1;  
  GL_FRAMEBUFFER_SRGB = $8DB9;  


{ ------------------------ GL_ARB_geometry_shader4 ------------------------  }

const
  GL_ARB_geometry_shader4 = 1;  
  GL_LINES_ADJACENCY_ARB = $A;  
  GL_LINE_STRIP_ADJACENCY_ARB = $B;  
  GL_TRIANGLES_ADJACENCY_ARB = $C;  
  GL_TRIANGLE_STRIP_ADJACENCY_ARB = $D;  
  GL_PROGRAM_POINT_SIZE_ARB = $8642;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = $8C29;  
//  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = $8CD4;  doppelt
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = $8DA7;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = $8DA8;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = $8DA9;  
  GL_GEOMETRY_SHADER_ARB = $8DD9;  
  GL_GEOMETRY_VERTICES_OUT_ARB = $8DDA;  
  GL_GEOMETRY_INPUT_TYPE_ARB = $8DDB;  
  GL_GEOMETRY_OUTPUT_TYPE_ARB = $8DDC;  
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = $8DDD;  
  GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = $8DDE;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = $8DE1;  
type
  TPFNGLFRAMEBUFFERTEXTUREARBPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTUREFACEARBPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;
  TPFNGLFRAMEBUFFERTEXTURELAYERARBPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;
  TPFNGLPROGRAMPARAMETERIARBPROC = procedure (prog:TGLuint; pname:TGLenum; value:TGLint);cdecl;


{ ----------------------- GL_ARB_get_program_binary -----------------------  }

const
  GL_ARB_get_program_binary = 1;  
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT = $8257;  
  GL_PROGRAM_BINARY_LENGTH = $8741;  
  GL_NUM_PROGRAM_BINARY_FORMATS = $87FE;  
  GL_PROGRAM_BINARY_FORMATS = $87FF;  
type
  TPFNGLGETPROGRAMBINARYPROC = procedure (prog:TGLuint; bufSize:TGLsizei; length:PGLsizei; binaryFormat:PGLenum; binary:pointer);cdecl;
  TPFNGLPROGRAMBINARYPROC = procedure (prog:TGLuint; binaryFormat:TGLenum; binary:pointer; length:TGLsizei);cdecl;
  TPFNGLPROGRAMPARAMETERIPROC = procedure (prog:TGLuint; pname:TGLenum; value:TGLint);cdecl;


{ ---------------------- GL_ARB_get_texture_sub_image ---------------------  }

const
  GL_ARB_get_texture_sub_image = 1;  
type
  TPFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; bufSize:TGLsizei; pixels:pointer);cdecl;
  TPFNGLGETTEXTURESUBIMAGEPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                bufSize:TGLsizei; pixels:pointer);cdecl;


{ ---------------------------- GL_ARB_gl_spirv ----------------------------  }

const
  GL_ARB_gl_spirv = 1;  
  GL_SHADER_BINARY_FORMAT_SPIR_V_ARB = $9551;  
  GL_SPIR_V_BINARY_ARB = $9552;  
type
  TPFNGLSPECIALIZESHADERARBPROC = procedure (shader:TGLuint; pEntryPoint:PGLchar; numSpecializationConstants:TGLuint; pConstantIndex:PGLuint; pConstantValue:PGLuint);cdecl;


{ --------------------------- GL_ARB_gpu_shader5 --------------------------  }

const
  GL_ARB_gpu_shader5 = 1;  
  GL_GEOMETRY_SHADER_INVOCATIONS = $887F;  
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS = $8E5A;  
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = $8E5B;  
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = $8E5C;  
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = $8E5D;  
  GL_MAX_VERTEX_STREAMS = $8E71;  


{ ------------------------- GL_ARB_gpu_shader_fp64 ------------------------  }

const
  GL_ARB_gpu_shader_fp64 = 1;  
  GL_DOUBLE_MAT2 = $8F46;  
  GL_DOUBLE_MAT3 = $8F47;  
  GL_DOUBLE_MAT4 = $8F48;  
  GL_DOUBLE_MAT2x3 = $8F49;  
  GL_DOUBLE_MAT2x4 = $8F4A;  
  GL_DOUBLE_MAT3x2 = $8F4B;  
  GL_DOUBLE_MAT3x4 = $8F4C;  
  GL_DOUBLE_MAT4x2 = $8F4D;  
  GL_DOUBLE_MAT4x3 = $8F4E;  
  GL_DOUBLE_VEC2 = $8FFC;  
  GL_DOUBLE_VEC3 = $8FFD;  
  GL_DOUBLE_VEC4 = $8FFE;  
type
  TPFNGLGETUNIFORMDVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLdouble);cdecl;
  TPFNGLUNIFORM1DPROC = procedure (location:TGLint; x:TGLdouble);cdecl;
  TPFNGLUNIFORM1DVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLUNIFORM2DPROC = procedure (location:TGLint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLUNIFORM2DVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLUNIFORM3DPROC = procedure (location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLUNIFORM3DVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLUNIFORM4DPROC = procedure (location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLUNIFORM4DVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX2DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX2X3DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX2X4DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX3DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX3X2DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX3X4DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX4DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX4X2DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLUNIFORMMATRIX4X3DVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;


{ ------------------------ GL_ARB_gpu_shader_int64 ------------------------  }

const
  GL_ARB_gpu_shader_int64 = 1;  
  GL_INT64_ARB = $140E;  
//  GL_UNSIGNED_INT64_ARB = $140F;  doppelt
  GL_INT64_VEC2_ARB = $8FE9;  
  GL_INT64_VEC3_ARB = $8FEA;  
  GL_INT64_VEC4_ARB = $8FEB;  
  GL_UNSIGNED_INT64_VEC2_ARB = $8FF5;  
  GL_UNSIGNED_INT64_VEC3_ARB = $8FF6;  
  GL_UNSIGNED_INT64_VEC4_ARB = $8FF7;  
type
  TPFNGLGETUNIFORMI64VARBPROC = procedure (prog:TGLuint; location:TGLint; params:PGLint64);cdecl;
  TPFNGLGETUNIFORMUI64VARBPROC = procedure (prog:TGLuint; location:TGLint; params:PGLuint64);cdecl;
  TPFNGLGETNUNIFORMI64VARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint64);cdecl;
  TPFNGLGETNUNIFORMUI64VARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM1I64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM1I64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM1UI64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM1UI64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM2I64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64; y:TGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM2I64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM2UI64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM2UI64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM3I64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM3I64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM3UI64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM3UI64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM4I64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64;
                w:TGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM4I64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLPROGRAMUNIFORM4UI64ARBPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64;
                w:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORM4UI64VARBPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLUNIFORM1I64ARBPROC = procedure (location:TGLint; x:TGLint64);cdecl;
  TPFNGLUNIFORM1I64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLUNIFORM1UI64ARBPROC = procedure (location:TGLint; x:TGLuint64);cdecl;
  TPFNGLUNIFORM1UI64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLUNIFORM2I64ARBPROC = procedure (location:TGLint; x:TGLint64; y:TGLint64);cdecl;
  TPFNGLUNIFORM2I64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLUNIFORM2UI64ARBPROC = procedure (location:TGLint; x:TGLuint64; y:TGLuint64);cdecl;
  TPFNGLUNIFORM2UI64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLUNIFORM3I64ARBPROC = procedure (location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64);cdecl;
  TPFNGLUNIFORM3I64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLUNIFORM3UI64ARBPROC = procedure (location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64);cdecl;
  TPFNGLUNIFORM3UI64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;
  TPFNGLUNIFORM4I64ARBPROC = procedure (location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64; w:TGLint64);cdecl;
  TPFNGLUNIFORM4I64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64);cdecl;
  TPFNGLUNIFORM4UI64ARBPROC = procedure (location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64; w:TGLuint64);cdecl;
  TPFNGLUNIFORM4UI64VARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;


{ ------------------------ GL_ARB_half_float_pixel ------------------------  }

const
  GL_ARB_half_float_pixel = 1;  
  GL_HALF_FLOAT_ARB = $140B;  


{ ------------------------ GL_ARB_half_float_vertex -----------------------  }

const
  GL_ARB_half_float_vertex = 1;  
  GL_HALF_FLOAT = $140B;  


{ ----------------------------- GL_ARB_imaging ----------------------------  }

const
  GL_ARB_imaging = 1;  
  GL_CONSTANT_COLOR = $8001;  
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;  
  GL_CONSTANT_ALPHA = $8003;  
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;  
  GL_BLEND_COLOR = $8005;  
  GL_FUNC_ADD = $8006;  
  GL_MIN = $8007;  
  GL_MAX = $8008;  
  GL_BLEND_EQUATION = $8009;  
  GL_FUNC_SUBTRACT = $800A;  
  GL_FUNC_REVERSE_SUBTRACT = $800B;  
  GL_CONVOLUTION_1D = $8010;  
  GL_CONVOLUTION_2D = $8011;  
  GL_SEPARABLE_2D = $8012;  
  GL_CONVOLUTION_BORDER_MODE = $8013;  
  GL_CONVOLUTION_FILTER_SCALE = $8014;  
  GL_CONVOLUTION_FILTER_BIAS = $8015;  
  GL_REDUCE = $8016;  
  GL_CONVOLUTION_FORMAT = $8017;  
  GL_CONVOLUTION_WIDTH = $8018;  
  GL_CONVOLUTION_HEIGHT = $8019;  
  GL_MAX_CONVOLUTION_WIDTH = $801A;  
  GL_MAX_CONVOLUTION_HEIGHT = $801B;  
  GL_POST_CONVOLUTION_RED_SCALE = $801C;  
  GL_POST_CONVOLUTION_GREEN_SCALE = $801D;  
  GL_POST_CONVOLUTION_BLUE_SCALE = $801E;  
  GL_POST_CONVOLUTION_ALPHA_SCALE = $801F;  
  GL_POST_CONVOLUTION_RED_BIAS = $8020;  
  GL_POST_CONVOLUTION_GREEN_BIAS = $8021;  
  GL_POST_CONVOLUTION_BLUE_BIAS = $8022;  
  GL_POST_CONVOLUTION_ALPHA_BIAS = $8023;  
  GL_HISTOGRAM = $8024;  
  GL_PROXY_HISTOGRAM = $8025;  
  GL_HISTOGRAM_WIDTH = $8026;  
  GL_HISTOGRAM_FORMAT = $8027;  
  GL_HISTOGRAM_RED_SIZE = $8028;  
  GL_HISTOGRAM_GREEN_SIZE = $8029;  
  GL_HISTOGRAM_BLUE_SIZE = $802A;  
  GL_HISTOGRAM_ALPHA_SIZE = $802B;  
  GL_HISTOGRAM_LUMINANCE_SIZE = $802C;  
  GL_HISTOGRAM_SINK = $802D;  
  GL_MINMAX = $802E;  
  GL_MINMAX_FORMAT = $802F;  
  GL_MINMAX_SINK = $8030;  
  GL_TABLE_TOO_LARGE = $8031;  
  GL_COLOR_MATRIX = $80B1;  
  GL_COLOR_MATRIX_STACK_DEPTH = $80B2;  
  GL_MAX_COLOR_MATRIX_STACK_DEPTH = $80B3;  
  GL_POST_COLOR_MATRIX_RED_SCALE = $80B4;  
  GL_POST_COLOR_MATRIX_GREEN_SCALE = $80B5;  
  GL_POST_COLOR_MATRIX_BLUE_SCALE = $80B6;  
  GL_POST_COLOR_MATRIX_ALPHA_SCALE = $80B7;  
  GL_POST_COLOR_MATRIX_RED_BIAS = $80B8;  
  GL_POST_COLOR_MATRIX_GREEN_BIAS = $80B9;  
  GL_POST_COLOR_MATRIX_BLUE_BIAS = $80BA;  
  GL_POST_COLOR_MATRIX_ALPHA_BIAS = $80BB;  
  GL_COLOR_TABLE = $80D0;  
  GL_POST_CONVOLUTION_COLOR_TABLE = $80D1;  
  GL_POST_COLOR_MATRIX_COLOR_TABLE = $80D2;  
  GL_PROXY_COLOR_TABLE = $80D3;  
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = $80D4;  
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = $80D5;  
  GL_COLOR_TABLE_SCALE = $80D6;  
  GL_COLOR_TABLE_BIAS = $80D7;  
  GL_COLOR_TABLE_FORMAT = $80D8;  
  GL_COLOR_TABLE_WIDTH = $80D9;  
  GL_COLOR_TABLE_RED_SIZE = $80DA;  
  GL_COLOR_TABLE_GREEN_SIZE = $80DB;  
  GL_COLOR_TABLE_BLUE_SIZE = $80DC;  
  GL_COLOR_TABLE_ALPHA_SIZE = $80DD;  
  GL_COLOR_TABLE_LUMINANCE_SIZE = $80DE;  
  GL_COLOR_TABLE_INTENSITY_SIZE = $80DF;  
  GL_IGNORE_BORDER = $8150;  
  GL_CONSTANT_BORDER = $8151;  
  GL_WRAP_BORDER = $8152;  
  GL_REPLICATE_BORDER = $8153;  
  GL_CONVOLUTION_BORDER_COLOR = $8154;  
type
  TPFNGLCOLORSUBTABLEPROC = procedure (target:TGLenum; start:TGLsizei; count:TGLsizei; format:TGLenum; _type:TGLenum;                data:pointer);cdecl;
  TPFNGLCOLORTABLEPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum;                table:pointer);cdecl;
  TPFNGLCOLORTABLEPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLCOLORTABLEPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLCONVOLUTIONFILTER1DPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum;                image:pointer);cdecl;
  TPFNGLCONVOLUTIONFILTER2DPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum;                _type:TGLenum; image:pointer);cdecl;
  TPFNGLCONVOLUTIONPARAMETERFPROC = procedure (target:TGLenum; pname:TGLenum; params:TGLfloat);cdecl;
  TPFNGLCONVOLUTIONPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLCONVOLUTIONPARAMETERIPROC = procedure (target:TGLenum; pname:TGLenum; params:TGLint);cdecl;
  TPFNGLCONVOLUTIONPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLCOPYCOLORSUBTABLEPROC = procedure (target:TGLenum; start:TGLsizei; x:TGLint; y:TGLint; width:TGLsizei);cdecl;
  TPFNGLCOPYCOLORTABLEPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;
  TPFNGLCOPYCONVOLUTIONFILTER1DPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;
  TPFNGLCOPYCONVOLUTIONFILTER2DPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei;                height:TGLsizei);cdecl;
  TPFNGLGETCOLORTABLEPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; table:pointer);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETCONVOLUTIONFILTERPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; image:pointer);cdecl;
  TPFNGLGETCONVOLUTIONPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCONVOLUTIONPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETHISTOGRAMPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;
  TPFNGLGETHISTOGRAMPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETHISTOGRAMPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMINMAXPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; types:TGLenum; values:pointer);cdecl;
  TPFNGLGETMINMAXPARAMETERFVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMINMAXPARAMETERIVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSEPARABLEFILTERPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; row:pointer; column:pointer;                span:pointer);cdecl;
  TPFNGLHISTOGRAMPROC = procedure (target:TGLenum; width:TGLsizei; internalformat:TGLenum; sink:TGLboolean);cdecl;
  TPFNGLMINMAXPROC = procedure (target:TGLenum; internalformat:TGLenum; sink:TGLboolean);cdecl;
  TPFNGLRESETHISTOGRAMPROC = procedure (target:TGLenum);cdecl;
  TPFNGLRESETMINMAXPROC = procedure (target:TGLenum);cdecl;
  TPFNGLSEPARABLEFILTER2DPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum;                _type:TGLenum; row:pointer; column:pointer);cdecl;


{ ----------------------- GL_ARB_indirect_parameters ----------------------  }

const
  GL_ARB_indirect_parameters = 1;  
  GL_PARAMETER_BUFFER_ARB = $80EE;  
  GL_PARAMETER_BUFFER_BINDING_ARB = $80EF;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC = procedure (mode:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei;                stride:TGLsizei);cdecl;


{ ------------------------ GL_ARB_instanced_arrays ------------------------  }

const
  GL_ARB_instanced_arrays = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = $88FE;  
type
  TPFNGLDRAWARRAYSINSTANCEDARBPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDARBPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;
  TPFNGLVERTEXATTRIBDIVISORARBPROC = procedure (index:TGLuint; divisor:TGLuint);cdecl;


{ ---------------------- GL_ARB_internalformat_query ----------------------  }

const
  GL_ARB_internalformat_query = 1;  
  GL_NUM_SAMPLE_COUNTS = $9380;  
type
  TPFNGLGETINTERNALFORMATIVPROC = procedure (target:TGLenum; internalformat:TGLenum; pname:TGLenum; bufSize:TGLsizei; params:PGLint);cdecl;


{ ---------------------- GL_ARB_internalformat_query2 ---------------------  }

const
  GL_ARB_internalformat_query2 = 1;  
  GL_INTERNALFORMAT_SUPPORTED = $826F;  
  GL_INTERNALFORMAT_PREFERRED = $8270;  
  GL_INTERNALFORMAT_RED_SIZE = $8271;  
  GL_INTERNALFORMAT_GREEN_SIZE = $8272;  
  GL_INTERNALFORMAT_BLUE_SIZE = $8273;  
  GL_INTERNALFORMAT_ALPHA_SIZE = $8274;  
  GL_INTERNALFORMAT_DEPTH_SIZE = $8275;  
  GL_INTERNALFORMAT_STENCIL_SIZE = $8276;  
  GL_INTERNALFORMAT_SHARED_SIZE = $8277;  
  GL_INTERNALFORMAT_RED_TYPE = $8278;  
  GL_INTERNALFORMAT_GREEN_TYPE = $8279;  
  GL_INTERNALFORMAT_BLUE_TYPE = $827A;  
  GL_INTERNALFORMAT_ALPHA_TYPE = $827B;  
  GL_INTERNALFORMAT_DEPTH_TYPE = $827C;  
  GL_INTERNALFORMAT_STENCIL_TYPE = $827D;  
  GL_MAX_WIDTH = $827E;  
  GL_MAX_HEIGHT = $827F;  
  GL_MAX_DEPTH = $8280;  
  GL_MAX_LAYERS = $8281;  
  GL_MAX_COMBINED_DIMENSIONS = $8282;  
  GL_COLOR_COMPONENTS = $8283;  
  GL_DEPTH_COMPONENTS = $8284;  
  GL_STENCIL_COMPONENTS = $8285;  
  GL_COLOR_RENDERABLE = $8286;  
  GL_DEPTH_RENDERABLE = $8287;  
  GL_STENCIL_RENDERABLE = $8288;  
  GL_FRAMEBUFFER_RENDERABLE = $8289;  
  GL_FRAMEBUFFER_RENDERABLE_LAYERED = $828A;  
  GL_FRAMEBUFFER_BLEND = $828B;  
  GL_READ_PIXELS = $828C;  
  GL_READ_PIXELS_FORMAT = $828D;  
  GL_READ_PIXELS_TYPE = $828E;  
  GL_TEXTURE_IMAGE_FORMAT = $828F;  
  GL_TEXTURE_IMAGE_TYPE = $8290;  
  GL_GET_TEXTURE_IMAGE_FORMAT = $8291;  
  GL_GET_TEXTURE_IMAGE_TYPE = $8292;  
  GL_MIPMAP = $8293;  
  GL_MANUAL_GENERATE_MIPMAP = $8294;  
  GL_AUTO_GENERATE_MIPMAP = $8295;  
  GL_COLOR_ENCODING = $8296;  
  GL_SRGB_READ = $8297;  
  GL_SRGB_WRITE = $8298;  
  GL_SRGB_DECODE_ARB = $8299;  
  GL_FILTER = $829A;  
  GL_VERTEX_TEXTURE = $829B;  
  GL_TESS_CONTROL_TEXTURE = $829C;  
  GL_TESS_EVALUATION_TEXTURE = $829D;  
  GL_GEOMETRY_TEXTURE = $829E;  
  GL_FRAGMENT_TEXTURE = $829F;  
  GL_COMPUTE_TEXTURE = $82A0;  
  GL_TEXTURE_SHADOW = $82A1;  
  GL_TEXTURE_GATHER = $82A2;  
  GL_TEXTURE_GATHER_SHADOW = $82A3;  
  GL_SHADER_IMAGE_LOAD = $82A4;  
  GL_SHADER_IMAGE_STORE = $82A5;  
  GL_SHADER_IMAGE_ATOMIC = $82A6;  
  GL_IMAGE_TEXEL_SIZE = $82A7;  
  GL_IMAGE_COMPATIBILITY_CLASS = $82A8;  
  GL_IMAGE_PIXEL_FORMAT = $82A9;  
  GL_IMAGE_PIXEL_TYPE = $82AA;  
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = $82AC;  
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = $82AD;  
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = $82AE;  
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = $82AF;  
  GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = $82B1;  
  GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = $82B2;  
  GL_TEXTURE_COMPRESSED_BLOCK_SIZE = $82B3;  
  GL_CLEAR_BUFFER = $82B4;  
  GL_TEXTURE_VIEW = $82B5;  
  GL_VIEW_COMPATIBILITY_CLASS = $82B6;  
  GL_FULL_SUPPORT = $82B7;  
  GL_CAVEAT_SUPPORT = $82B8;  
  GL_IMAGE_CLASS_4_X_32 = $82B9;  
  GL_IMAGE_CLASS_2_X_32 = $82BA;  
  GL_IMAGE_CLASS_1_X_32 = $82BB;  
  GL_IMAGE_CLASS_4_X_16 = $82BC;  
  GL_IMAGE_CLASS_2_X_16 = $82BD;  
  GL_IMAGE_CLASS_1_X_16 = $82BE;  
  GL_IMAGE_CLASS_4_X_8 = $82BF;  
  GL_IMAGE_CLASS_2_X_8 = $82C0;  
  GL_IMAGE_CLASS_1_X_8 = $82C1;  
  GL_IMAGE_CLASS_11_11_10 = $82C2;  
  GL_IMAGE_CLASS_10_10_10_2 = $82C3;  
  GL_VIEW_CLASS_128_BITS = $82C4;  
  GL_VIEW_CLASS_96_BITS = $82C5;  
  GL_VIEW_CLASS_64_BITS = $82C6;  
  GL_VIEW_CLASS_48_BITS = $82C7;  
  GL_VIEW_CLASS_32_BITS = $82C8;  
  GL_VIEW_CLASS_24_BITS = $82C9;  
  GL_VIEW_CLASS_16_BITS = $82CA;  
  GL_VIEW_CLASS_8_BITS = $82CB;  
  GL_VIEW_CLASS_S3TC_DXT1_RGB = $82CC;  
  GL_VIEW_CLASS_S3TC_DXT1_RGBA = $82CD;  
  GL_VIEW_CLASS_S3TC_DXT3_RGBA = $82CE;  
  GL_VIEW_CLASS_S3TC_DXT5_RGBA = $82CF;  
  GL_VIEW_CLASS_RGTC1_RED = $82D0;  
  GL_VIEW_CLASS_RGTC2_RG = $82D1;  
  GL_VIEW_CLASS_BPTC_UNORM = $82D2;  
  GL_VIEW_CLASS_BPTC_FLOAT = $82D3;  
type
  TPFNGLGETINTERNALFORMATI64VPROC = procedure (target:TGLenum; internalformat:TGLenum; pname:TGLenum; bufSize:TGLsizei; params:PGLint64);cdecl;


{ ----------------------- GL_ARB_invalidate_subdata -----------------------  }

const
  GL_ARB_invalidate_subdata = 1;  
type
 TPFNGLINVALIDATEBUFFERDATAPROC = procedure (buffer:TGLuint);cdecl;
  TPFNGLINVALIDATEBUFFERSUBDATAPROC = procedure (buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;
  TPFNGLINVALIDATEFRAMEBUFFERPROC = procedure (target:TGLenum; numAttachments:TGLsizei; attachments:PGLenum);cdecl;
  TPFNGLINVALIDATESUBFRAMEBUFFERPROC = procedure (target:TGLenum; numAttachments:TGLsizei; attachments:PGLenum; x:TGLint; y:TGLint;                width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLINVALIDATETEXIMAGEPROC = procedure (texture:TGLuint; level:TGLint);cdecl;
  TPFNGLINVALIDATETEXSUBIMAGEPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei);cdecl;


{ ---------------------- GL_ARB_map_buffer_alignment ----------------------  }

const
  GL_ARB_map_buffer_alignment = 1;  
  GL_MIN_MAP_BUFFER_ALIGNMENT = $90BC;  


{ ------------------------ GL_ARB_map_buffer_range ------------------------  }

const
  GL_ARB_map_buffer_range = 1;  
//  GL_MAP_READ_BIT = $0001;   doppelt
//  GL_MAP_WRITE_BIT = $0002;  
  GL_MAP_INVALIDATE_RANGE_BIT = $0004;  
  GL_MAP_INVALIDATE_BUFFER_BIT = $0008;  
  GL_MAP_FLUSH_EXPLICIT_BIT = $0010;  
  GL_MAP_UNSYNCHRONIZED_BIT = $0020;  
type
  TPFNGLFLUSHMAPPEDBUFFERRANGEPROC = procedure (target:TGLenum; offset:TGLintptr; length:TGLsizeiptr);cdecl;
  TPFNGLMAPBUFFERRANGEPROC = function (target:TGLenum; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;


{ ------------------------- GL_ARB_matrix_palette -------------------------  }

const
  GL_ARB_matrix_palette = 1;  
  GL_MATRIX_PALETTE_ARB = $8840;  
  GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = $8841;  
  GL_MAX_PALETTE_MATRICES_ARB = $8842;  
  GL_CURRENT_PALETTE_MATRIX_ARB = $8843;  
  GL_MATRIX_INDEX_ARRAY_ARB = $8844;  
  GL_CURRENT_MATRIX_INDEX_ARB = $8845;  
  GL_MATRIX_INDEX_ARRAY_SIZE_ARB = $8846;  
  GL_MATRIX_INDEX_ARRAY_TYPE_ARB = $8847;  
  GL_MATRIX_INDEX_ARRAY_STRIDE_ARB = $8848;  
  GL_MATRIX_INDEX_ARRAY_POINTER_ARB = $8849;  
type
  TPFNGLCURRENTPALETTEMATRIXARBPROC = procedure (index:TGLint);cdecl;
  TPFNGLMATRIXINDEXPOINTERARBPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLMATRIXINDEXUBVARBPROC = procedure (size:TGLint; indices:PGLubyte);cdecl;
  TPFNGLMATRIXINDEXUIVARBPROC = procedure (size:TGLint; indices:PGLuint);cdecl;
  TPFNGLMATRIXINDEXUSVARBPROC = procedure (size:TGLint; indices:PGLushort);cdecl;


{ --------------------------- GL_ARB_multi_bind ---------------------------  }

const
  GL_ARB_multi_bind = 1;  
type
  TPFNGLBINDBUFFERSBASEPROC = procedure (target:TGLenum; first:TGLuint; count:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLBINDBUFFERSRANGEPROC = procedure (target:TGLenum; first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr;                sizes:PGLsizeiptr);cdecl;
  TPFNGLBINDIMAGETEXTURESPROC = procedure (first:TGLuint; count:TGLsizei; textures:PGLuint);cdecl;
  TPFNGLBINDSAMPLERSPROC = procedure (first:TGLuint; count:TGLsizei; samplers:PGLuint);cdecl;
  TPFNGLBINDTEXTURESPROC = procedure (first:TGLuint; count:TGLsizei; textures:PGLuint);cdecl;
  TPFNGLBINDVERTEXBUFFERSPROC = procedure (first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr; strides:PGLsizei);cdecl;


{ ----------------------- GL_ARB_multi_draw_indirect ----------------------  }

const
  GL_ARB_multi_draw_indirect = 1;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTPROC = procedure (mode:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;


{ --------------------------- GL_ARB_multisample --------------------------  }

const
  GL_ARB_multisample = 1;  
  GL_MULTISAMPLE_ARB = $809D;  
  GL_SAMPLE_ALPHA_TO_COVERAGE_ARB = $809E;  
  GL_SAMPLE_ALPHA_TO_ONE_ARB = $809F;  
  GL_SAMPLE_COVERAGE_ARB = $80A0;  
  GL_SAMPLE_BUFFERS_ARB = $80A8;  
  GL_SAMPLES_ARB = $80A9;  
  GL_SAMPLE_COVERAGE_VALUE_ARB = $80AA;  
  GL_SAMPLE_COVERAGE_INVERT_ARB = $80AB;  
  GL_MULTISAMPLE_BIT_ARB = $20000000;  
type

  TPFNGLSAMPLECOVERAGEARBPROC = procedure (value:TGLclampf; invert:TGLboolean);cdecl;


{ -------------------------- GL_ARB_multitexture --------------------------  }

const
  GL_ARB_multitexture = 1;  
  GL_TEXTURE0_ARB = $84C0;  
  GL_TEXTURE1_ARB = $84C1;  
  GL_TEXTURE2_ARB = $84C2;  
  GL_TEXTURE3_ARB = $84C3;  
  GL_TEXTURE4_ARB = $84C4;  
  GL_TEXTURE5_ARB = $84C5;  
  GL_TEXTURE6_ARB = $84C6;  
  GL_TEXTURE7_ARB = $84C7;  
  GL_TEXTURE8_ARB = $84C8;  
  GL_TEXTURE9_ARB = $84C9;  
  GL_TEXTURE10_ARB = $84CA;  
  GL_TEXTURE11_ARB = $84CB;  
  GL_TEXTURE12_ARB = $84CC;  
  GL_TEXTURE13_ARB = $84CD;  
  GL_TEXTURE14_ARB = $84CE;  
  GL_TEXTURE15_ARB = $84CF;  
  GL_TEXTURE16_ARB = $84D0;  
  GL_TEXTURE17_ARB = $84D1;  
  GL_TEXTURE18_ARB = $84D2;  
  GL_TEXTURE19_ARB = $84D3;  
  GL_TEXTURE20_ARB = $84D4;  
  GL_TEXTURE21_ARB = $84D5;  
  GL_TEXTURE22_ARB = $84D6;  
  GL_TEXTURE23_ARB = $84D7;  
  GL_TEXTURE24_ARB = $84D8;  
  GL_TEXTURE25_ARB = $84D9;  
  GL_TEXTURE26_ARB = $84DA;  
  GL_TEXTURE27_ARB = $84DB;  
  GL_TEXTURE28_ARB = $84DC;  
  GL_TEXTURE29_ARB = $84DD;  
  GL_TEXTURE30_ARB = $84DE;  
  GL_TEXTURE31_ARB = $84DF;  
  GL_ACTIVE_TEXTURE_ARB = $84E0;  
  GL_CLIENT_ACTIVE_TEXTURE_ARB = $84E1;  
  GL_MAX_TEXTURE_UNITS_ARB = $84E2;  
type
  TPFNGLACTIVETEXTUREARBPROC = procedure (texture:TGLenum);cdecl;
  TPFNGLCLIENTACTIVETEXTUREARBPROC = procedure (texture:TGLenum);cdecl;
  TPFNGLMULTITEXCOORD1DARBPROC = procedure (target:TGLenum; s:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD1DVARBPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD1FARBPROC = procedure (target:TGLenum; s:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD1FVARBPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD1IARBPROC = procedure (target:TGLenum; s:TGLint);cdecl;
  TPFNGLMULTITEXCOORD1IVARBPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD1SARBPROC = procedure (target:TGLenum; s:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD1SVARBPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD2DARBPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD2DVARBPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD2FARBPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD2FVARBPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD2IARBPROC = procedure (target:TGLenum; s:TGLint; t:TGLint);cdecl;
  TPFNGLMULTITEXCOORD2IVARBPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD2SARBPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD2SVARBPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD3DARBPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD3DVARBPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD3FARBPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD3FVARBPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD3IARBPROC = procedure (target:TGLenum; s:TGLint; t:TGLint; r:TGLint);cdecl;
  TPFNGLMULTITEXCOORD3IVARBPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD3SARBPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD3SVARBPROC = procedure (target:TGLenum; v:PGLshort);cdecl;
  TPFNGLMULTITEXCOORD4DARBPROC = procedure (target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble; q:TGLdouble);cdecl;
  TPFNGLMULTITEXCOORD4DVARBPROC = procedure (target:TGLenum; v:PGLdouble);cdecl;
  TPFNGLMULTITEXCOORD4FARBPROC = procedure (target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat; q:TGLfloat);cdecl;
  TPFNGLMULTITEXCOORD4FVARBPROC = procedure (target:TGLenum; v:PGLfloat);cdecl;
  TPFNGLMULTITEXCOORD4IARBPROC = procedure (target:TGLenum; s:TGLint; t:TGLint; r:TGLint; q:TGLint);cdecl;
  TPFNGLMULTITEXCOORD4IVARBPROC = procedure (target:TGLenum; v:PGLint);cdecl;
  TPFNGLMULTITEXCOORD4SARBPROC = procedure (target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort; q:TGLshort);cdecl;
  TPFNGLMULTITEXCOORD4SVARBPROC = procedure (target:TGLenum; v:PGLshort);cdecl;


{ ------------------------- GL_ARB_occlusion_query ------------------------  }

const
  GL_ARB_occlusion_query = 1;  
  GL_QUERY_COUNTER_BITS_ARB = $8864;  
  GL_CURRENT_QUERY_ARB = $8865;  
  GL_QUERY_RESULT_ARB = $8866;  
  GL_QUERY_RESULT_AVAILABLE_ARB = $8867;  
  GL_SAMPLES_PASSED_ARB = $8914;  
type
  TPFNGLBEGINQUERYARBPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETEQUERIESARBPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLENDQUERYARBPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGENQUERIESARBPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETQUERYOBJECTIVARBPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETQUERYOBJECTUIVARBPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETQUERYIVARBPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISQUERYARBPROC = function (id:TGLuint):TGLboolean;cdecl;


{ ------------------------ GL_ARB_occlusion_query2 ------------------------  }

const
  GL_ARB_occlusion_query2 = 1;  
  GL_ANY_SAMPLES_PASSED = $8C2F;  


{ --------------------- GL_ARB_parallel_shader_compile --------------------  }

const
  GL_ARB_parallel_shader_compile = 1;  
  GL_MAX_SHADER_COMPILER_THREADS_ARB = $91B0;  
  GL_COMPLETION_STATUS_ARB = $91B1;  
type
  TPFNGLMAXSHADERCOMPILERTHREADSARBPROC = procedure (count:TGLuint);cdecl;


{ -------------------- GL_ARB_pipeline_statistics_query -------------------  }

const
  GL_ARB_pipeline_statistics_query = 1;  
  GL_VERTICES_SUBMITTED_ARB = $82EE;  
  GL_PRIMITIVES_SUBMITTED_ARB = $82EF;  
  GL_VERTEX_SHADER_INVOCATIONS_ARB = $82F0;  
  GL_TESS_CONTROL_SHADER_PATCHES_ARB = $82F1;  
  GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = $82F2;  
  GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = $82F3;  
  GL_FRAGMENT_SHADER_INVOCATIONS_ARB = $82F4;  
  GL_COMPUTE_SHADER_INVOCATIONS_ARB = $82F5;  
  GL_CLIPPING_INPUT_PRIMITIVES_ARB = $82F6;  
  GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = $82F7;  
//  GL_GEOMETRY_SHADER_INVOCATIONS = $887F; doppelt


{ ----------------------- GL_ARB_pixel_buffer_object ----------------------  }

const
  GL_ARB_pixel_buffer_object = 1;  
  GL_PIXEL_PACK_BUFFER_ARB = $88EB;  
  GL_PIXEL_UNPACK_BUFFER_ARB = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING_ARB = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = $88EF;  


{ ------------------------ GL_ARB_point_parameters ------------------------  }

const
  GL_ARB_point_parameters = 1;  
  GL_POINT_SIZE_MIN_ARB = $8126;  
  GL_POINT_SIZE_MAX_ARB = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE_ARB = $8128;  
  GL_POINT_DISTANCE_ATTENUATION_ARB = $8129;  
type
 TPFNGLPOINTPARAMETERFARBPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPOINTPARAMETERFVARBPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;


{ -------------------------- GL_ARB_point_sprite --------------------------  }

const
  GL_ARB_point_sprite = 1;  
  GL_POINT_SPRITE_ARB = $8861;  
  GL_COORD_REPLACE_ARB = $8862;  


{ ---------------------- GL_ARB_polygon_offset_clamp ----------------------  }

const
  GL_ARB_polygon_offset_clamp = 1;  
//  GL_POLYGON_OFFSET_CLAMP = $8E1B;   doppelt
type
  TPFNGLPOLYGONOFFSETCLAMPPROC = procedure (factor:TGLfloat; units:TGLfloat; clamp:TGLfloat);cdecl;


{ ----------------------- GL_ARB_post_depth_coverage ----------------------  }

const
  GL_ARB_post_depth_coverage = 1;  


{ --------------------- GL_ARB_program_interface_query --------------------  }

const
  GL_ARB_program_interface_query = 1;  
  GL_UNIFORM = $92E1;  
  GL_UNIFORM_BLOCK = $92E2;  
  GL_PROGRAM_INPUT = $92E3;  
  GL_PROGRAM_OUTPUT = $92E4;  
  GL_BUFFER_VARIABLE = $92E5;  
  GL_SHADER_STORAGE_BLOCK = $92E6;  
  GL_IS_PER_PATCH = $92E7;  
  GL_VERTEX_SUBROUTINE = $92E8;  
  GL_TESS_CONTROL_SUBROUTINE = $92E9;  
  GL_TESS_EVALUATION_SUBROUTINE = $92EA;  
  GL_GEOMETRY_SUBROUTINE = $92EB;  
  GL_FRAGMENT_SUBROUTINE = $92EC;  
  GL_COMPUTE_SUBROUTINE = $92ED;  
  GL_VERTEX_SUBROUTINE_UNIFORM = $92EE;  
  GL_TESS_CONTROL_SUBROUTINE_UNIFORM = $92EF;  
  GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = $92F0;  
  GL_GEOMETRY_SUBROUTINE_UNIFORM = $92F1;  
  GL_FRAGMENT_SUBROUTINE_UNIFORM = $92F2;  
  GL_COMPUTE_SUBROUTINE_UNIFORM = $92F3;  
  GL_TRANSFORM_FEEDBACK_VARYING = $92F4;  
  GL_ACTIVE_RESOURCES = $92F5;  
  GL_MAX_NAME_LENGTH = $92F6;  
  GL_MAX_NUM_ACTIVE_VARIABLES = $92F7;  
  GL_MAX_NUM_COMPATIBLE_SUBROUTINES = $92F8;  
  GL_NAME_LENGTH = $92F9;  
  GL_TYPE = $92FA;  
  GL_ARRAY_SIZE = $92FB;  
  GL_OFFSET = $92FC;  
  GL_BLOCK_INDEX = $92FD;  
  GL_ARRAY_STRIDE = $92FE;  
  GL_MATRIX_STRIDE = $92FF;  
  GL_IS_ROW_MAJOR = $9300;  
  GL_ATOMIC_COUNTER_BUFFER_INDEX = $9301;  
  GL_BUFFER_BINDING = $9302;  
  GL_BUFFER_DATA_SIZE = $9303;  
  GL_NUM_ACTIVE_VARIABLES = $9304;  
  GL_ACTIVE_VARIABLES = $9305;  
  GL_REFERENCED_BY_VERTEX_SHADER = $9306;  
  GL_REFERENCED_BY_TESS_CONTROL_SHADER = $9307;  
  GL_REFERENCED_BY_TESS_EVALUATION_SHADER = $9308;  
  GL_REFERENCED_BY_GEOMETRY_SHADER = $9309;  
  GL_REFERENCED_BY_FRAGMENT_SHADER = $930A;  
  GL_REFERENCED_BY_COMPUTE_SHADER = $930B;  
  GL_TOP_LEVEL_ARRAY_SIZE = $930C;  
  GL_TOP_LEVEL_ARRAY_STRIDE = $930D;  
  GL_LOCATION = $930E;  
  GL_LOCATION_INDEX = $930F;  
type
  TPFNGLGETPROGRAMINTERFACEIVPROC = procedure (prog:TGLuint; programInterface:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETPROGRAMRESOURCEINDEXPROC = function (prog:TGLuint; programInterface:TGLenum; name:PGLchar):TGLuint;cdecl;
  TPFNGLGETPROGRAMRESOURCELOCATIONPROC = function (prog:TGLuint; programInterface:TGLenum; name:PGLchar):TGLint;cdecl;
  TPFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC = function (prog:TGLuint; programInterface:TGLenum; name:PGLchar):TGLint;cdecl;
  TPFNGLGETPROGRAMRESOURCENAMEPROC = procedure (prog:TGLuint; programInterface:TGLenum; index:TGLuint; bufSize:TGLsizei; length:PGLsizei;               name:PGLchar);cdecl;
  TPFNGLGETPROGRAMRESOURCEIVPROC = procedure (prog:TGLuint; programInterface:TGLenum; index:TGLuint; propCount:TGLsizei; props:PGLenum;
                bufSize:TGLsizei; length:PGLsizei; params:PGLint);cdecl;


{ ------------------------ GL_ARB_provoking_vertex ------------------------  }

const
  GL_ARB_provoking_vertex = 1;  
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = $8E4C;  
  GL_FIRST_VERTEX_CONVENTION = $8E4D;  
  GL_LAST_VERTEX_CONVENTION = $8E4E;  
  GL_PROVOKING_VERTEX = $8E4F;  
type
  TPFNGLPROVOKINGVERTEXPROC = procedure (mode:TGLenum);cdecl;


{ ----------------------- GL_ARB_query_buffer_object ----------------------  }

const
  GL_ARB_query_buffer_object = 1;  
  GL_QUERY_BUFFER_BARRIER_BIT = $00008000;  
  GL_QUERY_BUFFER = $9192;  
  GL_QUERY_BUFFER_BINDING = $9193;  
  GL_QUERY_RESULT_NO_WAIT = $9194;  


{ ------------------ GL_ARB_robust_buffer_access_behavior -----------------  }

const
  GL_ARB_robust_buffer_access_behavior = 1;  


{ --------------------------- GL_ARB_robustness ---------------------------  }

const
  GL_ARB_robustness = 1;  
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = $00000004;  
  GL_LOSE_CONTEXT_ON_RESET_ARB = $8252;  
  GL_GUILTY_CONTEXT_RESET_ARB = $8253;  
  GL_INNOCENT_CONTEXT_RESET_ARB = $8254;  
  GL_UNKNOWN_CONTEXT_RESET_ARB = $8255;  
  GL_RESET_NOTIFICATION_STRATEGY_ARB = $8256;  
  GL_NO_RESET_NOTIFICATION_ARB = $8261;  
type
  TPFNGLGETGRAPHICSRESETSTATUSARBPROC = function (para1:pointer):TGLenum;cdecl;
  TPFNGLGETNCOLORTABLEARBPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; table:pointer);cdecl;
  TPFNGLGETNCOMPRESSEDTEXIMAGEARBPROC = procedure (target:TGLenum; lod:TGLint; bufSize:TGLsizei; img:pointer);cdecl;
  TPFNGLGETNCONVOLUTIONFILTERARBPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; image:pointer);cdecl;
  TPFNGLGETNHISTOGRAMARBPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei;                            values:pointer);cdecl;
  TPFNGLGETNMAPDVARBPROC = procedure (target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLdouble);cdecl;
  TPFNGLGETNMAPFVARBPROC = procedure (target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLGETNMAPIVARBPROC = procedure (target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLint);cdecl;
  TPFNGLGETNMINMAXARBPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei;                values:pointer);cdecl;
  TPFNGLGETNPIXELMAPFVARBPROC = procedure (map:TGLenum; bufSize:TGLsizei; values:PGLfloat);cdecl;
  TPFNGLGETNPIXELMAPUIVARBPROC = procedure (map:TGLenum; bufSize:TGLsizei; values:PGLuint);cdecl;
  TPFNGLGETNPIXELMAPUSVARBPROC = procedure (map:TGLenum; bufSize:TGLsizei; values:PGLushort);cdecl;
  TPFNGLGETNPOLYGONSTIPPLEARBPROC = procedure (bufSize:TGLsizei; pattern:PGLubyte);cdecl;
  TPFNGLGETNSEPARABLEFILTERARBPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; rowBufSize:TGLsizei; row:pointer;
                columnBufSize:TGLsizei; column:pointer; span:pointer);cdecl;
  TPFNGLGETNTEXIMAGEARBPROC = procedure (target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei;                img:pointer);cdecl;
  TPFNGLGETNUNIFORMDVARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLdouble);cdecl;
  TPFNGLGETNUNIFORMFVARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLGETNUNIFORMIVARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint);cdecl;
  TPFNGLGETNUNIFORMUIVARBPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint);cdecl;
  TPFNGLREADNPIXELSARBPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum;
                _type:TGLenum; bufSize:TGLsizei; data:pointer);cdecl;


{ ---------------- GL_ARB_robustness_application_isolation ----------------  }

const
  GL_ARB_robustness_application_isolation = 1;  


{ ---------------- GL_ARB_robustness_share_group_isolation ----------------  }

const
  GL_ARB_robustness_share_group_isolation = 1;  


{ ------------------------ GL_ARB_sample_locations ------------------------  }

const
  GL_ARB_sample_locations = 1;  
  GL_SAMPLE_LOCATION_ARB = $8E50;  
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = $933D;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = $933E;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = $933F;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = $9340;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB = $9341;  
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = $9342;  
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = $9343;  
type
  TPFNGLFRAMEBUFFERSAMPLELOCATIONSFVARBPROC = procedure (target:TGLenum; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVARBPROC = procedure (framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;


{ ------------------------- GL_ARB_sample_shading -------------------------  }

const
  GL_ARB_sample_shading = 1;  
  GL_SAMPLE_SHADING_ARB = $8C36;  
  GL_MIN_SAMPLE_SHADING_VALUE_ARB = $8C37;  
type
  TPFNGLMINSAMPLESHADINGARBPROC = procedure (value:TGLclampf);cdecl;


{ ------------------------- GL_ARB_sampler_objects ------------------------  }

const
  GL_ARB_sampler_objects = 1;  
  GL_SAMPLER_BINDING = $8919;  
type
  TPFNGLBINDSAMPLERPROC = procedure (unit_:TGLuint; sampler:TGLuint);cdecl;
  TPFNGLDELETESAMPLERSPROC = procedure (count:TGLsizei; samplers:PGLuint);cdecl;
  TPFNGLGENSAMPLERSPROC = procedure (count:TGLsizei; samplers:PGLuint);cdecl;
  TPFNGLGETSAMPLERPARAMETERIIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSAMPLERPARAMETERIUIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETSAMPLERPARAMETERFVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETSAMPLERPARAMETERIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISSAMPLERPROC = function (sampler:TGLuint):TGLboolean;cdecl;
  TPFNGLSAMPLERPARAMETERIIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLSAMPLERPARAMETERIUIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLSAMPLERPARAMETERFPROC = procedure (sampler:TGLuint; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLSAMPLERPARAMETERFVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLSAMPLERPARAMETERIPROC = procedure (sampler:TGLuint; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLSAMPLERPARAMETERIVPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;


{ ------------------------ GL_ARB_seamless_cube_map -----------------------  }

const
  GL_ARB_seamless_cube_map = 1;  
//  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;   doppelt


{ ------------------ GL_ARB_seamless_cubemap_per_texture ------------------  }

const
  GL_ARB_seamless_cubemap_per_texture = 1;  
//  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;   doppelt


{ --------------------- GL_ARB_separate_shader_objects --------------------  }

const
  GL_ARB_separate_shader_objects = 1;  
  GL_VERTEX_SHADER_BIT = $00000001;  
  GL_FRAGMENT_SHADER_BIT = $00000002;  
  GL_GEOMETRY_SHADER_BIT = $00000004;  
  GL_TESS_CONTROL_SHADER_BIT = $00000008;  
  GL_TESS_EVALUATION_SHADER_BIT = $00000010;  
  GL_PROGRAM_SEPARABLE = $8258;  
  GL_ACTIVE_PROGRAM = $8259;  
  GL_PROGRAM_PIPELINE_BINDING = $825A;  
  GL_ALL_SHADER_BITS = $FFFFFFFF;  
type
  TPFNGLACTIVESHADERPROGRAMPROC = procedure (pipeline:TGLuint; prog:TGLuint);cdecl;
  TPFNGLBINDPROGRAMPIPELINEPROC = procedure (pipeline:TGLuint);cdecl;
  TPFNGLCREATESHADERPROGRAMVPROC = function (_type:TGLenum; count:TGLsizei; strings:PPGLchar):TGLuint;cdecl;
  TPFNGLDELETEPROGRAMPIPELINESPROC = procedure (n:TGLsizei; pipelines:PGLuint);cdecl;
  TPFNGLGENPROGRAMPIPELINESPROC = procedure (n:TGLsizei; pipelines:PGLuint);cdecl;
  TPFNGLGETPROGRAMPIPELINEINFOLOGPROC = procedure (pipeline:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;
  TPFNGLGETPROGRAMPIPELINEIVPROC = procedure (pipeline:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISPROGRAMPIPELINEPROC = function (pipeline:TGLuint):TGLboolean;cdecl;
  TPFNGLPROGRAMUNIFORM1DPROC = procedure (prog:TGLuint; location:TGLint; x:TGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM1DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM1FPROC = procedure (prog:TGLuint; location:TGLint; x:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM1FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM1IPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM1IVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM1UIPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM1UIVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM2DPROC = procedure (prog:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM2DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM2FPROC = procedure (prog:TGLuint; location:TGLint; x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM2FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM2IPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint; y:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM2IVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM2UIPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint; y:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM2UIVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM3DPROC = procedure (prog:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM3DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM3FPROC = procedure (prog:TGLuint; location:TGLint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM3FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM3IPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM3IVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM3UIPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint; y:TGLuint; z:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM3UIVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM4DPROC = procedure (prog:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble;                w:TGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM4DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORM4FPROC = procedure (prog:TGLuint; location:TGLint; x:TGLfloat; y:TGLfloat; z:TGLfloat;                w:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM4FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM4IPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint; y:TGLint; z:TGLint;                w:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM4IVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM4UIPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint; y:TGLuint; z:TGLuint;                w:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM4UIVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X3DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X3FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X4DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X4FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X2DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X2FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X4DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X4FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X2DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X2FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X3DVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X3FVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUSEPROGRAMSTAGESPROC = procedure (pipeline:TGLuint; stages:TGLbitfield; prog:TGLuint);cdecl;
  TPFNGLVALIDATEPROGRAMPIPELINEPROC = procedure (pipeline:TGLuint);cdecl;


{ -------------------- GL_ARB_shader_atomic_counter_ops -------------------  }

const
  GL_ARB_shader_atomic_counter_ops = 1;  


{ --------------------- GL_ARB_shader_atomic_counters ---------------------  }

const
  GL_ARB_shader_atomic_counters = 1;  
  GL_ATOMIC_COUNTER_BUFFER = $92C0;  
  GL_ATOMIC_COUNTER_BUFFER_BINDING = $92C1;  
  GL_ATOMIC_COUNTER_BUFFER_START = $92C2;  
  GL_ATOMIC_COUNTER_BUFFER_SIZE = $92C3;  
  GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = $92C4;  
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = $92C5;  
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = $92C6;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = $92C7;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = $92C8;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = $92C9;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = $92CA;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = $92CB;  
  GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = $92CC;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = $92CD;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = $92CE;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = $92CF;  
  GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = $92D0;  
  GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = $92D1;  
  GL_MAX_VERTEX_ATOMIC_COUNTERS = $92D2;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = $92D3;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = $92D4;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS = $92D5;  
  GL_MAX_FRAGMENT_ATOMIC_COUNTERS = $92D6;  
  GL_MAX_COMBINED_ATOMIC_COUNTERS = $92D7;  
  GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = $92D8;  
  GL_ACTIVE_ATOMIC_COUNTER_BUFFERS = $92D9;  
  GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = $92DA;  
  GL_UNSIGNED_INT_ATOMIC_COUNTER = $92DB;  
  GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = $92DC;  
type
  TPFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC = procedure (prog:TGLuint; bufferIndex:TGLuint; pname:TGLenum; params:PGLint);cdecl;


{ -------------------------- GL_ARB_shader_ballot -------------------------  }

const
  GL_ARB_shader_ballot = 1;  


{ ----------------------- GL_ARB_shader_bit_encoding ----------------------  }

const
  GL_ARB_shader_bit_encoding = 1;  


{ -------------------------- GL_ARB_shader_clock --------------------------  }

const
  GL_ARB_shader_clock = 1;  


{ --------------------- GL_ARB_shader_draw_parameters ---------------------  }

const
  GL_ARB_shader_draw_parameters = 1;  


{ ------------------------ GL_ARB_shader_group_vote -----------------------  }

const
  GL_ARB_shader_group_vote = 1;  


{ --------------------- GL_ARB_shader_image_load_store --------------------  }

const
  GL_ARB_shader_image_load_store = 1;  
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = $00000001;  
  GL_ELEMENT_ARRAY_BARRIER_BIT = $00000002;  
  GL_UNIFORM_BARRIER_BIT = $00000004;  
  GL_TEXTURE_FETCH_BARRIER_BIT = $00000008;  
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = $00000020;  
  GL_COMMAND_BARRIER_BIT = $00000040;  
  GL_PIXEL_BUFFER_BARRIER_BIT = $00000080;  
  GL_TEXTURE_UPDATE_BARRIER_BIT = $00000100;  
  GL_BUFFER_UPDATE_BARRIER_BIT = $00000200;  
  GL_FRAMEBUFFER_BARRIER_BIT = $00000400;  
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT = $00000800;  
  GL_ATOMIC_COUNTER_BARRIER_BIT = $00001000;  
  GL_MAX_IMAGE_UNITS = $8F38;  
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = $8F39;  
  GL_IMAGE_BINDING_NAME = $8F3A;  
  GL_IMAGE_BINDING_LEVEL = $8F3B;  
  GL_IMAGE_BINDING_LAYERED = $8F3C;  
  GL_IMAGE_BINDING_LAYER = $8F3D;  
  GL_IMAGE_BINDING_ACCESS = $8F3E;  
  GL_IMAGE_1D = $904C;  
  GL_IMAGE_2D = $904D;  
  GL_IMAGE_3D = $904E;  
  GL_IMAGE_2D_RECT = $904F;  
  GL_IMAGE_CUBE = $9050;  
  GL_IMAGE_BUFFER = $9051;  
  GL_IMAGE_1D_ARRAY = $9052;  
  GL_IMAGE_2D_ARRAY = $9053;  
  GL_IMAGE_CUBE_MAP_ARRAY = $9054;  
  GL_IMAGE_2D_MULTISAMPLE = $9055;  
  GL_IMAGE_2D_MULTISAMPLE_ARRAY = $9056;  
  GL_INT_IMAGE_1D = $9057;  
  GL_INT_IMAGE_2D = $9058;  
  GL_INT_IMAGE_3D = $9059;  
  GL_INT_IMAGE_2D_RECT = $905A;  
  GL_INT_IMAGE_CUBE = $905B;  
  GL_INT_IMAGE_BUFFER = $905C;  
  GL_INT_IMAGE_1D_ARRAY = $905D;  
  GL_INT_IMAGE_2D_ARRAY = $905E;  
  GL_INT_IMAGE_CUBE_MAP_ARRAY = $905F;  
  GL_INT_IMAGE_2D_MULTISAMPLE = $9060;  
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $9061;  
  GL_UNSIGNED_INT_IMAGE_1D = $9062;  
  GL_UNSIGNED_INT_IMAGE_2D = $9063;  
  GL_UNSIGNED_INT_IMAGE_3D = $9064;  
  GL_UNSIGNED_INT_IMAGE_2D_RECT = $9065;  
  GL_UNSIGNED_INT_IMAGE_CUBE = $9066;  
  GL_UNSIGNED_INT_IMAGE_BUFFER = $9067;  
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY = $9068;  
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY = $9069;  
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = $906A;  
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = $906B;  
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $906C;  
  GL_MAX_IMAGE_SAMPLES = $906D;  
  GL_IMAGE_BINDING_FORMAT = $906E;  
  GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = $90C7;  
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = $90C8;  
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = $90C9;  
  GL_MAX_VERTEX_IMAGE_UNIFORMS = $90CA;  
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = $90CB;  
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = $90CC;  
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS = $90CD;  
  GL_MAX_FRAGMENT_IMAGE_UNIFORMS = $90CE;  
  GL_MAX_COMBINED_IMAGE_UNIFORMS = $90CF;  
  GL_ALL_BARRIER_BITS = $FFFFFFFF;  
type
  TPFNGLBINDIMAGETEXTUREPROC = procedure (unit_:TGLuint; texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint;                access:TGLenum; format:TGLenum);cdecl;
  TPFNGLMEMORYBARRIERPROC = procedure (barriers:TGLbitfield);cdecl;


{ ------------------------ GL_ARB_shader_image_size -----------------------  }

const
  GL_ARB_shader_image_size = 1;  


{ ------------------------- GL_ARB_shader_objects -------------------------  }

const
  GL_ARB_shader_objects = 1;  
  GL_PROGRAM_OBJECT_ARB = $8B40;  
  GL_SHADER_OBJECT_ARB = $8B48;  
  GL_OBJECT_TYPE_ARB = $8B4E;  
  GL_OBJECT_SUBTYPE_ARB = $8B4F;  
  GL_FLOAT_VEC2_ARB = $8B50;  
  GL_FLOAT_VEC3_ARB = $8B51;  
  GL_FLOAT_VEC4_ARB = $8B52;  
  GL_INT_VEC2_ARB = $8B53;  
  GL_INT_VEC3_ARB = $8B54;  
  GL_INT_VEC4_ARB = $8B55;  
  GL_BOOL_ARB = $8B56;  
  GL_BOOL_VEC2_ARB = $8B57;  
  GL_BOOL_VEC3_ARB = $8B58;  
  GL_BOOL_VEC4_ARB = $8B59;  
  GL_FLOAT_MAT2_ARB = $8B5A;  
  GL_FLOAT_MAT3_ARB = $8B5B;  
  GL_FLOAT_MAT4_ARB = $8B5C;  
  GL_SAMPLER_1D_ARB = $8B5D;  
  GL_SAMPLER_2D_ARB = $8B5E;  
  GL_SAMPLER_3D_ARB = $8B5F;  
  GL_SAMPLER_CUBE_ARB = $8B60;  
  GL_SAMPLER_1D_SHADOW_ARB = $8B61;  
  GL_SAMPLER_2D_SHADOW_ARB = $8B62;  
  GL_SAMPLER_2D_RECT_ARB = $8B63;  
  GL_SAMPLER_2D_RECT_SHADOW_ARB = $8B64;  
  GL_OBJECT_DELETE_STATUS_ARB = $8B80;  
  GL_OBJECT_COMPILE_STATUS_ARB = $8B81;  
  GL_OBJECT_LINK_STATUS_ARB = $8B82;  
  GL_OBJECT_VALIDATE_STATUS_ARB = $8B83;  
  GL_OBJECT_INFO_LOG_LENGTH_ARB = $8B84;  
  GL_OBJECT_ATTACHED_OBJECTS_ARB = $8B85;  
  GL_OBJECT_ACTIVE_UNIFORMS_ARB = $8B86;  
  GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = $8B87;  
  GL_OBJECT_SHADER_SOURCE_LENGTH_ARB = $8B88;  
type
PPGLcharARB = ^PGLcharARB;
PGLcharARB = ^TGLcharARB;
  TGLcharARB = char;

  PGLhandleARB = ^TGLhandleARB;
  TGLhandleARB = dword;
  TPFNGLATTACHOBJECTARBPROC = procedure (containerObj:TGLhandleARB; obj:TGLhandleARB);cdecl;
  TPFNGLCOMPILESHADERARBPROC = procedure (shaderObj:TGLhandleARB);cdecl;
  TPFNGLCREATEPROGRAMOBJECTARBPROC = function (para1:pointer):TGLhandleARB;cdecl;
  TPFNGLCREATESHADEROBJECTARBPROC = function (shaderType:TGLenum):TGLhandleARB;cdecl;
  TPFNGLDELETEOBJECTARBPROC = procedure (obj:TGLhandleARB);cdecl;
  TPFNGLDETACHOBJECTARBPROC = procedure (containerObj:TGLhandleARB; attachedObj:TGLhandleARB);cdecl;
  TPFNGLGETACTIVEUNIFORMARBPROC = procedure (programObj:TGLhandleARB; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint;
                _type:PGLenum; name:PGLcharARB);cdecl;
  TPFNGLGETATTACHEDOBJECTSARBPROC = procedure (containerObj:TGLhandleARB; maxCount:TGLsizei; count:PGLsizei; obj:PGLhandleARB);cdecl;
  TPFNGLGETHANDLEARBPROC = function (pname:TGLenum):TGLhandleARB;cdecl;
  TPFNGLGETINFOLOGARBPROC = procedure (obj:TGLhandleARB; maxLength:TGLsizei; length:PGLsizei; infoLog:PGLcharARB);cdecl;
  TPFNGLGETOBJECTPARAMETERFVARBPROC = procedure (obj:TGLhandleARB; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETOBJECTPARAMETERIVARBPROC = procedure (obj:TGLhandleARB; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSHADERSOURCEARBPROC = procedure (obj:TGLhandleARB; maxLength:TGLsizei; length:PGLsizei; source:PGLcharARB);cdecl;
  TPFNGLGETUNIFORMLOCATIONARBPROC = function (programObj:TGLhandleARB; name:PGLcharARB):TGLint;cdecl;
  TPFNGLGETUNIFORMFVARBPROC = procedure (programObj:TGLhandleARB; location:TGLint; params:PGLfloat);cdecl;
  TPFNGLGETUNIFORMIVARBPROC = procedure (programObj:TGLhandleARB; location:TGLint; params:PGLint);cdecl;
  TPFNGLLINKPROGRAMARBPROC = procedure (programObj:TGLhandleARB);cdecl;
  TPFNGLSHADERSOURCEARBPROC = procedure (shaderObj:TGLhandleARB; count:TGLsizei; _string:PPGLcharARB; length:PGLint);cdecl;
  TPFNGLUNIFORM1FARBPROC = procedure (location:TGLint; v0:TGLfloat);cdecl;
  TPFNGLUNIFORM1FVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM1IARBPROC = procedure (location:TGLint; v0:TGLint);cdecl;
  TPFNGLUNIFORM1IVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM2FARBPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;
  TPFNGLUNIFORM2FVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM2IARBPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint);cdecl;
  TPFNGLUNIFORM2IVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM3FARBPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;
  TPFNGLUNIFORM3FVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM3IARBPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;
  TPFNGLUNIFORM3IVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORM4FARBPROC = procedure (location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; v3:TGLfloat);cdecl;
  TPFNGLUNIFORM4FVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLUNIFORM4IARBPROC = procedure (location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; v3:TGLint);cdecl;
  TPFNGLUNIFORM4IVARBPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLUNIFORMMATRIX2FVARBPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3FVARBPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4FVARBPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUSEPROGRAMOBJECTARBPROC = procedure (programObj:TGLhandleARB);cdecl;
  TPFNGLVALIDATEPROGRAMARBPROC = procedure (programObj:TGLhandleARB);cdecl;


{ ------------------------ GL_ARB_shader_precision ------------------------  }

const
  GL_ARB_shader_precision = 1;  


{ ---------------------- GL_ARB_shader_stencil_export ---------------------  }

const
  GL_ARB_shader_stencil_export = 1;  


{ ------------------ GL_ARB_shader_storage_buffer_object ------------------  }

const
  GL_ARB_shader_storage_buffer_object = 1;  
  GL_SHADER_STORAGE_BARRIER_BIT = $2000;  
  GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = $8F39;  
  GL_SHADER_STORAGE_BUFFER = $90D2;  
  GL_SHADER_STORAGE_BUFFER_BINDING = $90D3;  
  GL_SHADER_STORAGE_BUFFER_START = $90D4;  
  GL_SHADER_STORAGE_BUFFER_SIZE = $90D5;  
  GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = $90D6;  
  GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = $90D7;  
  GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = $90D8;  
  GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = $90D9;  
  GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = $90DA;  
  GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = $90DB;  
  GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = $90DC;  
  GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = $90DD;  
  GL_MAX_SHADER_STORAGE_BLOCK_SIZE = $90DE;  
  GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = $90DF;  
type
  TPFNGLSHADERSTORAGEBLOCKBINDINGPROC = procedure (prog:TGLuint; storageBlockIndex:TGLuint; storageBlockBinding:TGLuint);cdecl;


{ ------------------------ GL_ARB_shader_subroutine -----------------------  }

const
  GL_ARB_shader_subroutine = 1;  
  GL_ACTIVE_SUBROUTINES = $8DE5;  
  GL_ACTIVE_SUBROUTINE_UNIFORMS = $8DE6;  
  GL_MAX_SUBROUTINES = $8DE7;  
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = $8DE8;  
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = $8E47;  
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH = $8E48;  
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = $8E49;  
  GL_NUM_COMPATIBLE_SUBROUTINES = $8E4A;  
  GL_COMPATIBLE_SUBROUTINES = $8E4B;  
type
  TPFNGLGETACTIVESUBROUTINENAMEPROC = procedure (prog:TGLuint; shadertype:TGLenum; index:TGLuint; bufsize:TGLsizei; length:PGLsizei;                name:PGLchar);cdecl;
  TPFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC = procedure (prog:TGLuint; shadertype:TGLenum; index:TGLuint; bufsize:TGLsizei; length:PGLsizei;                name:PGLchar);cdecl;
  TPFNGLGETACTIVESUBROUTINEUNIFORMIVPROC = procedure (prog:TGLuint; shadertype:TGLenum; index:TGLuint; pname:TGLenum; values:PGLint);cdecl;
  TPFNGLGETPROGRAMSTAGEIVPROC = procedure (prog:TGLuint; shadertype:TGLenum; pname:TGLenum; values:PGLint);cdecl;
  TPFNGLGETSUBROUTINEINDEXPROC = function (prog:TGLuint; shadertype:TGLenum; name:PGLchar):TGLuint;cdecl;
  TPFNGLGETSUBROUTINEUNIFORMLOCATIONPROC = function (prog:TGLuint; shadertype:TGLenum; name:PGLchar):TGLint;cdecl;
  TPFNGLGETUNIFORMSUBROUTINEUIVPROC = procedure (shadertype:TGLenum; location:TGLint; params:PGLuint);cdecl;
  TPFNGLUNIFORMSUBROUTINESUIVPROC = procedure (shadertype:TGLenum; count:TGLsizei; indices:PGLuint);cdecl;


{ ------------------ GL_ARB_shader_texture_image_samples ------------------  }

const
  GL_ARB_shader_texture_image_samples = 1;  


{ ----------------------- GL_ARB_shader_texture_lod -----------------------  }

const
  GL_ARB_shader_texture_lod = 1;  


{ ------------------- GL_ARB_shader_viewport_layer_array ------------------  }

const
  GL_ARB_shader_viewport_layer_array = 1;  


{ ---------------------- GL_ARB_shading_language_100 ----------------------  }

const
  GL_ARB_shading_language_100 = 1;  
  GL_SHADING_LANGUAGE_VERSION_ARB = $8B8C;  


{ -------------------- GL_ARB_shading_language_420pack --------------------  }

const
  GL_ARB_shading_language_420pack = 1;  


{ -------------------- GL_ARB_shading_language_include --------------------  }

const
  GL_ARB_shading_language_include = 1;  
  GL_SHADER_INCLUDE_ARB = $8DAE;  
  GL_NAMED_STRING_LENGTH_ARB = $8DE9;  
  GL_NAMED_STRING_TYPE_ARB = $8DEA;  
type
  TPFNGLCOMPILESHADERINCLUDEARBPROC = procedure (shader:TGLuint; count:TGLsizei; path:PPGLchar; length:PGLint);cdecl;
  TPFNGLDELETENAMEDSTRINGARBPROC = procedure (namelen:TGLint; name:PGLchar);cdecl;
  TPFNGLGETNAMEDSTRINGARBPROC = procedure (namelen:TGLint; name:PGLchar; bufSize:TGLsizei; stringlen:PGLint; _string:PGLchar);cdecl;
  TPFNGLGETNAMEDSTRINGIVARBPROC = procedure (namelen:TGLint; name:PGLchar; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISNAMEDSTRINGARBPROC = function (namelen:TGLint; name:PGLchar):TGLboolean;cdecl;
  TPFNGLNAMEDSTRINGARBPROC = procedure (_type:TGLenum; namelen:TGLint; name:PGLchar; stringlen:TGLint; _string:PGLchar);cdecl;


{ -------------------- GL_ARB_shading_language_packing --------------------  }

const
  GL_ARB_shading_language_packing = 1;  


{ ----------------------------- GL_ARB_shadow -----------------------------  }

const
  GL_ARB_shadow = 1;  
  GL_TEXTURE_COMPARE_MODE_ARB = $884C;  
  GL_TEXTURE_COMPARE_FUNC_ARB = $884D;  
  GL_COMPARE_R_TO_TEXTURE_ARB = $884E;  


{ ------------------------- GL_ARB_shadow_ambient -------------------------  }

const
  GL_ARB_shadow_ambient = 1;  
  GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = $80BF;  


{ -------------------------- GL_ARB_sparse_buffer -------------------------  }

const
  GL_ARB_sparse_buffer = 1;  
  GL_SPARSE_STORAGE_BIT_ARB = $0400;  
  GL_SPARSE_BUFFER_PAGE_SIZE_ARB = $82F8;  
type
  TPFNGLBUFFERPAGECOMMITMENTARBPROC = procedure (target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; commit:TGLboolean);cdecl;


{ ------------------------- GL_ARB_sparse_texture -------------------------  }

const
  GL_ARB_sparse_texture = 1;  
  GL_VIRTUAL_PAGE_SIZE_X_ARB = $9195;  
  GL_VIRTUAL_PAGE_SIZE_Y_ARB = $9196;  
  GL_VIRTUAL_PAGE_SIZE_Z_ARB = $9197;  
  GL_MAX_SPARSE_TEXTURE_SIZE_ARB = $9198;  
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = $9199;  
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = $919A;  
  GL_TEXTURE_SPARSE_ARB = $91A6;  
  GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = $91A7;  
  GL_NUM_VIRTUAL_PAGE_SIZES_ARB = $91A8;  
  GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = $91A9;  
  GL_NUM_SPARSE_LEVELS_ARB = $91AA;  
type
  TPFNGLTEXPAGECOMMITMENTARBPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; commit:TGLboolean);cdecl;


{ ------------------------- GL_ARB_sparse_texture2 ------------------------  }

const
  GL_ARB_sparse_texture2 = 1;  


{ ---------------------- GL_ARB_sparse_texture_clamp ----------------------  }

const
  GL_ARB_sparse_texture_clamp = 1;  


{ ------------------------ GL_ARB_spirv_extensions ------------------------  }

const
  GL_ARB_spirv_extensions = 1;  
//  GL_SPIR_V_EXTENSIONS = $9553; doppelt
//  GL_NUM_SPIR_V_EXTENSIONS = $9554;  


{ ------------------------ GL_ARB_stencil_texturing -----------------------  }

const
  GL_ARB_stencil_texturing = 1;  
  GL_DEPTH_STENCIL_TEXTURE_MODE = $90EA;  


{ ------------------------------ GL_ARB_sync ------------------------------  }

const
  GL_ARB_sync = 1;  
  GL_SYNC_FLUSH_COMMANDS_BIT = $00000001;  
  GL_MAX_SERVER_WAIT_TIMEOUT = $9111;  
  GL_OBJECT_TYPE = $9112;  
  GL_SYNC_CONDITION = $9113;  
  GL_SYNC_STATUS = $9114;  
  GL_SYNC_FLAGS = $9115;  
  GL_SYNC_FENCE = $9116;  
  GL_SYNC_GPU_COMMANDS_COMPLETE = $9117;  
  GL_UNSIGNALED = $9118;  
  GL_SIGNALED = $9119;  
  GL_ALREADY_SIGNALED = $911A;  
  GL_TIMEOUT_EXPIRED = $911B;  
  GL_CONDITION_SATISFIED = $911C;  
  GL_WAIT_FAILED = $911D;  
  GL_TIMEOUT_IGNORED = $FFFFFFFFFFFFFFFF;  
type
  TPFNGLCLIENTWAITSYNCPROC = function (GLsync:TGLsync; flags:TGLbitfield; timeout:TGLuint64):TGLenum;cdecl;
  TPFNGLDELETESYNCPROC = procedure (GLsync:TGLsync);cdecl;
  TPFNGLFENCESYNCPROC = function (condition:TGLenum; flags:TGLbitfield):TGLsync;cdecl;
  TPFNGLGETINTEGER64VPROC = procedure (pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLGETSYNCIVPROC = procedure (GLsync:TGLsync; pname:TGLenum; bufSize:TGLsizei; length:PGLsizei; values:PGLint);cdecl;
  TPFNGLISSYNCPROC = function (GLsync:TGLsync):TGLboolean;cdecl;
  TPFNGLWAITSYNCPROC = procedure (GLsync:TGLsync; flags:TGLbitfield; timeout:TGLuint64);cdecl;


{ ----------------------- GL_ARB_tessellation_shader ----------------------  }

const
  GL_ARB_tessellation_shader = 1;  
  GL_PATCHES = $E;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = $84F0;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = $84F1;  
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = $886C;  
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = $886D;  
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = $8E1E;  
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E1F;  
  GL_PATCH_VERTICES = $8E72;  
  GL_PATCH_DEFAULT_INNER_LEVEL = $8E73;  
  GL_PATCH_DEFAULT_OUTER_LEVEL = $8E74;  
  GL_TESS_CONTROL_OUTPUT_VERTICES = $8E75;  
  GL_TESS_GEN_MODE = $8E76;  
  GL_TESS_GEN_SPACING = $8E77;  
  GL_TESS_GEN_VERTEX_ORDER = $8E78;  
  GL_TESS_GEN_POINT_MODE = $8E79;  
  GL_ISOLINES = $8E7A;  
  GL_FRACTIONAL_ODD = $8E7B;  
  GL_FRACTIONAL_EVEN = $8E7C;  
  GL_MAX_PATCH_VERTICES = $8E7D;  
  GL_MAX_TESS_GEN_LEVEL = $8E7E;  
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = $8E7F;  
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E80;  
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = $8E81;  
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = $8E82;  
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = $8E83;  
  GL_MAX_TESS_PATCH_COMPONENTS = $8E84;  
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = $8E85;  
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = $8E86;  
  GL_TESS_EVALUATION_SHADER = $8E87;  
  GL_TESS_CONTROL_SHADER = $8E88;  
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = $8E89;  
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = $8E8A;  
type
  TPFNGLPATCHPARAMETERFVPROC = procedure (pname:TGLenum; values:PGLfloat);cdecl;
  TPFNGLPATCHPARAMETERIPROC = procedure (pname:TGLenum; value:TGLint);cdecl;


{ ------------------------- GL_ARB_texture_barrier ------------------------  }

const
  GL_ARB_texture_barrier = 1;  
type
  TPFNGLTEXTUREBARRIERPROC = procedure (para1:pointer);cdecl;


{ ---------------------- GL_ARB_texture_border_clamp ----------------------  }

const
  GL_ARB_texture_border_clamp = 1;  
  GL_CLAMP_TO_BORDER_ARB = $812D;  


{ ---------------------- GL_ARB_texture_buffer_object ---------------------  }

const
  GL_ARB_texture_buffer_object = 1;  
  GL_TEXTURE_BUFFER_ARB = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE_ARB = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER_ARB = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = $8C2D;  
  GL_TEXTURE_BUFFER_FORMAT_ARB = $8C2E;  
type
  TPFNGLTEXBUFFERARBPROC = procedure (target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;


{ ------------------- GL_ARB_texture_buffer_object_rgb32 ------------------  }

const
  GL_ARB_texture_buffer_object_rgb32 = 1;  


{ ---------------------- GL_ARB_texture_buffer_range ----------------------  }

const
  GL_ARB_texture_buffer_range = 1;  
  GL_TEXTURE_BUFFER_OFFSET = $919D;  
  GL_TEXTURE_BUFFER_SIZE = $919E;  
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = $919F;  
type
  TPFNGLTEXBUFFERRANGEPROC = procedure (target:TGLenum; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLTEXTUREBUFFERRANGEEXTPROC = procedure (texture:TGLuint; target:TGLenum; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr;
                size:TGLsizeiptr);cdecl;


{ ----------------------- GL_ARB_texture_compression ----------------------  }

const
  GL_ARB_texture_compression = 1;  
  GL_COMPRESSED_ALPHA_ARB = $84E9;  
  GL_COMPRESSED_LUMINANCE_ARB = $84EA;  
  GL_COMPRESSED_LUMINANCE_ALPHA_ARB = $84EB;  
  GL_COMPRESSED_INTENSITY_ARB = $84EC;  
  GL_COMPRESSED_RGB_ARB = $84ED;  
  GL_COMPRESSED_RGBA_ARB = $84EE;  
  GL_TEXTURE_COMPRESSION_HINT_ARB = $84EF;  
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = $86A0;  
  GL_TEXTURE_COMPRESSED_ARB = $86A1;  
  GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB = $86A2;  
  GL_COMPRESSED_TEXTURE_FORMATS_ARB = $86A3;  
type
  TPFNGLCOMPRESSEDTEXIMAGE1DARBPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; border:TGLint;
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXIMAGE2DARBPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
 TPFNGLCOMPRESSEDTEXIMAGE3DARBPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum;
                imageSize:TGLsizei; data:pointer);cdecl;
 TPFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei;
                height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
                data:pointer);cdecl;
  TPFNGLGETCOMPRESSEDTEXIMAGEARBPROC = procedure (target:TGLenum; lod:TGLint; img:pointer);cdecl;


{ -------------------- GL_ARB_texture_compression_bptc --------------------  }

const
  GL_ARB_texture_compression_bptc = 1;  
  GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = $8E8C;  
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = $8E8D;  
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = $8E8E;  
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = $8E8F;  


{ -------------------- GL_ARB_texture_compression_rgtc --------------------  }

const
  GL_ARB_texture_compression_rgtc = 1;  
  GL_COMPRESSED_RED_RGTC1 = $8DBB;  
  GL_COMPRESSED_SIGNED_RED_RGTC1 = $8DBC;  
  GL_COMPRESSED_RG_RGTC2 = $8DBD;  
  GL_COMPRESSED_SIGNED_RG_RGTC2 = $8DBE;  


{ ------------------------ GL_ARB_texture_cube_map ------------------------  }

const
  GL_ARB_texture_cube_map = 1;  
  GL_NORMAL_MAP_ARB = $8511;  
  GL_REFLECTION_MAP_ARB = $8512;  
  GL_TEXTURE_CUBE_MAP_ARB = $8513;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARB = $8514;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = $8515;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = $8516;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = $8517;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = $8518;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = $8519;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = $851A;  
  GL_PROXY_TEXTURE_CUBE_MAP_ARB = $851B;  
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB = $851C;  


{ --------------------- GL_ARB_texture_cube_map_array ---------------------  }

const
  GL_ARB_texture_cube_map_array = 1;  
  GL_TEXTURE_CUBE_MAP_ARRAY_ARB = $9009;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = $900A;  
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = $900B;  
  GL_SAMPLER_CUBE_MAP_ARRAY_ARB = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900F;  


{ ------------------------- GL_ARB_texture_env_add ------------------------  }

const
  GL_ARB_texture_env_add = 1;  


{ ----------------------- GL_ARB_texture_env_combine ----------------------  }

const
  GL_ARB_texture_env_combine = 1;  
  GL_SUBTRACT_ARB = $84E7;  
  GL_COMBINE_ARB = $8570;  
  GL_COMBINE_RGB_ARB = $8571;  
  GL_COMBINE_ALPHA_ARB = $8572;  
  GL_RGB_SCALE_ARB = $8573;  
  GL_ADD_SIGNED_ARB = $8574;  
  GL_INTERPOLATE_ARB = $8575;  
  GL_CONSTANT_ARB = $8576;  
  GL_PRIMARY_COLOR_ARB = $8577;  
  GL_PREVIOUS_ARB = $8578;  
  GL_SOURCE0_RGB_ARB = $8580;  
  GL_SOURCE1_RGB_ARB = $8581;  
  GL_SOURCE2_RGB_ARB = $8582;  
  GL_SOURCE0_ALPHA_ARB = $8588;  
  GL_SOURCE1_ALPHA_ARB = $8589;  
  GL_SOURCE2_ALPHA_ARB = $858A;  
  GL_OPERAND0_RGB_ARB = $8590;  
  GL_OPERAND1_RGB_ARB = $8591;  
  GL_OPERAND2_RGB_ARB = $8592;  
  GL_OPERAND0_ALPHA_ARB = $8598;  
  GL_OPERAND1_ALPHA_ARB = $8599;  
  GL_OPERAND2_ALPHA_ARB = $859A;  


{ ---------------------- GL_ARB_texture_env_crossbar ----------------------  }

const
  GL_ARB_texture_env_crossbar = 1;  


{ ------------------------ GL_ARB_texture_env_dot3 ------------------------  }

const
  GL_ARB_texture_env_dot3 = 1;  
  GL_DOT3_RGB_ARB = $86AE;  
  GL_DOT3_RGBA_ARB = $86AF;  


{ ------------------- GL_ARB_texture_filter_anisotropic -------------------  }

const
  GL_ARB_texture_filter_anisotropic = 1;  
//  GL_TEXTURE_MAX_ANISOTROPY = $84FE;   doppelt
//  GL_MAX_TEXTURE_MAX_ANISOTROPY = $84FF;  


{ ---------------------- GL_ARB_texture_filter_minmax ---------------------  }

const
  GL_ARB_texture_filter_minmax = 1;  
  GL_TEXTURE_REDUCTION_MODE_ARB = $9366;  
  GL_WEIGHTED_AVERAGE_ARB = $9367;  


{ -------------------------- GL_ARB_texture_float -------------------------  }

const
  GL_ARB_texture_float = 1;  
  GL_RGBA32F_ARB = $8814;  
  GL_RGB32F_ARB = $8815;  
  GL_ALPHA32F_ARB = $8816;  
  GL_INTENSITY32F_ARB = $8817;  
  GL_LUMINANCE32F_ARB = $8818;  
  GL_LUMINANCE_ALPHA32F_ARB = $8819;  
  GL_RGBA16F_ARB = $881A;  
  GL_RGB16F_ARB = $881B;  
  GL_ALPHA16F_ARB = $881C;  
  GL_INTENSITY16F_ARB = $881D;  
  GL_LUMINANCE16F_ARB = $881E;  
  GL_LUMINANCE_ALPHA16F_ARB = $881F;  
  GL_TEXTURE_RED_TYPE_ARB = $8C10;  
  GL_TEXTURE_GREEN_TYPE_ARB = $8C11;  
  GL_TEXTURE_BLUE_TYPE_ARB = $8C12;  
  GL_TEXTURE_ALPHA_TYPE_ARB = $8C13;  
  GL_TEXTURE_LUMINANCE_TYPE_ARB = $8C14;  
  GL_TEXTURE_INTENSITY_TYPE_ARB = $8C15;  
  GL_TEXTURE_DEPTH_TYPE_ARB = $8C16;  
  GL_UNSIGNED_NORMALIZED_ARB = $8C17;  


{ ------------------------- GL_ARB_texture_gather -------------------------  }

const
  GL_ARB_texture_gather = 1;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5F;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = $8F9F;  


{ ------------------ GL_ARB_texture_mirror_clamp_to_edge ------------------  }

const
  GL_ARB_texture_mirror_clamp_to_edge = 1;  
  GL_MIRROR_CLAMP_TO_EDGE = $8743;  


{ --------------------- GL_ARB_texture_mirrored_repeat --------------------  }

const
  GL_ARB_texture_mirrored_repeat = 1;  
  GL_MIRRORED_REPEAT_ARB = $8370;  


{ ----------------------- GL_ARB_texture_multisample ----------------------  }

const
  GL_ARB_texture_multisample = 1;  
  GL_SAMPLE_POSITION = $8E50;  
  GL_SAMPLE_MASK = $8E51;  
  GL_SAMPLE_MASK_VALUE = $8E52;  
  GL_MAX_SAMPLE_MASK_WORDS = $8E59;  
  GL_TEXTURE_2D_MULTISAMPLE = $9100;  
  GL_PROXY_TEXTURE_2D_MULTISAMPLE = $9101;  
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY = $9102;  
  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = $9103;  
  GL_TEXTURE_BINDING_2D_MULTISAMPLE = $9104;  
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = $9105;  
  GL_TEXTURE_SAMPLES = $9106;  
  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = $9107;  
  GL_SAMPLER_2D_MULTISAMPLE = $9108;  
  GL_INT_SAMPLER_2D_MULTISAMPLE = $9109;  
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = $910A;  
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY = $910B;  
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910C;  
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910D;  
  GL_MAX_COLOR_TEXTURE_SAMPLES = $910E;  
  GL_MAX_DEPTH_TEXTURE_SAMPLES = $910F;  
  GL_MAX_INTEGER_SAMPLES = $9110;  
type
  TPFNGLGETMULTISAMPLEFVPROC = procedure (pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;
  TPFNGLSAMPLEMASKIPROC = procedure (index:TGLuint; mask:TGLbitfield);cdecl;
  TPFNGLTEXIMAGE2DMULTISAMPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXIMAGE3DMULTISAMPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;


{ -------------------- GL_ARB_texture_non_power_of_two --------------------  }

const
  GL_ARB_texture_non_power_of_two = 1;  


{ ---------------------- GL_ARB_texture_query_levels ----------------------  }

const
  GL_ARB_texture_query_levels = 1;  


{ ------------------------ GL_ARB_texture_query_lod -----------------------  }

const
  GL_ARB_texture_query_lod = 1;  


{ ------------------------ GL_ARB_texture_rectangle -----------------------  }

const
  GL_ARB_texture_rectangle = 1;  
  GL_TEXTURE_RECTANGLE_ARB = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE_ARB = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE_ARB = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = $84F8;  
//  GL_SAMPLER_2D_RECT_ARB = $8B63;   doppelt
//  GL_SAMPLER_2D_RECT_SHADOW_ARB = $8B64;  


{ --------------------------- GL_ARB_texture_rg ---------------------------  }

const
  GL_ARB_texture_rg = 1;  
  GL_COMPRESSED_RED = $8225;  
  GL_COMPRESSED_RG = $8226;  
  GL_RG = $8227;  
  GL_RG_INTEGER = $8228;  
  GL_R8 = $8229;  
  GL_R16 = $822A;  
  GL_RG8 = $822B;  
  GL_RG16 = $822C;  
  GL_R16F = $822D;  
  GL_R32F = $822E;  
  GL_RG16F = $822F;  
  GL_RG32F = $8230;  
  GL_R8I = $8231;  
  GL_R8UI = $8232;  
  GL_R16I = $8233;  
  GL_R16UI = $8234;  
  GL_R32I = $8235;  
  GL_R32UI = $8236;  
  GL_RG8I = $8237;  
//  GL_RG8UI = $8238;   doppelt
  GL_RG16I = $8239;  
//  GL_RG16UI = $823A;  
  GL_RG32I = $823B;  
  GL_RG32UI = $823C;  


{ ----------------------- GL_ARB_texture_rgb10_a2ui -----------------------  }

const
  GL_ARB_texture_rgb10_a2ui = 1;  
//  GL_RGB10_A2UI = $906F;    doppelt


{ ------------------------ GL_ARB_texture_stencil8 ------------------------  }

const
  GL_ARB_texture_stencil8 = 1;  
//  GL_STENCIL_INDEX = $1901;    doppelt
//  GL_STENCIL_INDEX8 = $8D48;  


{ ------------------------- GL_ARB_texture_storage ------------------------  }

const
  GL_ARB_texture_storage = 1;  
  GL_TEXTURE_IMMUTABLE_FORMAT = $912F;  
type
  TPFNGLTEXSTORAGE1DPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;
  TPFNGLTEXSTORAGE2DPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLTEXSTORAGE3DPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;                depth:TGLsizei);cdecl;


{ ------------------- GL_ARB_texture_storage_multisample ------------------  }

const
  GL_ARB_texture_storage_multisample = 1;  
type
  TPFNGLTEXSTORAGE2DMULTISAMPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXSTORAGE3DMULTISAMPLEPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC = procedure (texture:TGLuint; target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;
  TPFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC = procedure (texture:TGLuint; target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;


{ ------------------------- GL_ARB_texture_swizzle ------------------------  }

const
  GL_ARB_texture_swizzle = 1;  
  GL_TEXTURE_SWIZZLE_R = $8E42;  
  GL_TEXTURE_SWIZZLE_G = $8E43;  
  GL_TEXTURE_SWIZZLE_B = $8E44;  
  GL_TEXTURE_SWIZZLE_A = $8E45;  
  GL_TEXTURE_SWIZZLE_RGBA = $8E46;  


{ -------------------------- GL_ARB_texture_view --------------------------  }

const
  GL_ARB_texture_view = 1;  
  GL_TEXTURE_VIEW_MIN_LEVEL = $82DB;  
  GL_TEXTURE_VIEW_NUM_LEVELS = $82DC;  
  GL_TEXTURE_VIEW_MIN_LAYER = $82DD;  
  GL_TEXTURE_VIEW_NUM_LAYERS = $82DE;  
//   GL_TEXTURE_IMMUTABLE_LEVELS = $82DF; doppelt
type
  TPFNGLTEXTUREVIEWPROC = procedure (texture:TGLuint; target:TGLenum; origtexture:TGLuint; internalformat:TGLenum; minlevel:TGLuint;
                numlevels:TGLuint; minlayer:TGLuint; numlayers:TGLuint);cdecl;


{ --------------------------- GL_ARB_timer_query --------------------------  }

const
  GL_ARB_timer_query = 1;  
  GL_TIME_ELAPSED = $88BF;  
  GL_TIMESTAMP = $8E28;  
type
  TPFNGLGETQUERYOBJECTI64VPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLGETQUERYOBJECTUI64VPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;
  TPFNGLQUERYCOUNTERPROC = procedure (id:TGLuint; target:TGLenum);cdecl;


{ ----------------------- GL_ARB_transform_feedback2 ----------------------  }

const
  GL_ARB_transform_feedback2 = 1;  
  GL_TRANSFORM_FEEDBACK = $8E22;  
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = $8E23;  
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = $8E24;  
  GL_TRANSFORM_FEEDBACK_BINDING = $8E25;  
type
  TPFNGLBINDTRANSFORMFEEDBACKPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETETRANSFORMFEEDBACKSPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLDRAWTRANSFORMFEEDBACKPROC = procedure (mode:TGLenum; id:TGLuint);cdecl;
  TPFNGLGENTRANSFORMFEEDBACKSPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLISTRANSFORMFEEDBACKPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLPAUSETRANSFORMFEEDBACKPROC = procedure (para1:pointer);cdecl;
  TPFNGLRESUMETRANSFORMFEEDBACKPROC = procedure (para1:pointer);cdecl;


{ ----------------------- GL_ARB_transform_feedback3 ----------------------  }

const
  GL_ARB_transform_feedback3 = 1;  
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = $8E70;  
//   GL_MAX_VERTEX_STREAMS = $8E71; doppelt
type
  TPFNGLBEGINQUERYINDEXEDPROC = procedure (target:TGLenum; index:TGLuint; id:TGLuint);cdecl;
  TPFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC = procedure (mode:TGLenum; id:TGLuint; stream:TGLuint);cdecl;
  TPFNGLENDQUERYINDEXEDPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLGETQUERYINDEXEDIVPROC = procedure (target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLint);cdecl;


{ ------------------ GL_ARB_transform_feedback_instanced ------------------  }

const
  GL_ARB_transform_feedback_instanced = 1;  
type
  TPFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC = procedure (mode:TGLenum; id:TGLuint; primcount:TGLsizei);cdecl;
  TPFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC = procedure (mode:TGLenum; id:TGLuint; stream:TGLuint; primcount:TGLsizei);cdecl;


{ ---------------- GL_ARB_transform_feedback_overflow_query ---------------  }

const
  GL_ARB_transform_feedback_overflow_query = 1;  
  GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = $82EC;  
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = $82ED;  


{ ------------------------ GL_ARB_transpose_matrix ------------------------  }

const
  GL_ARB_transpose_matrix = 1;  
  GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = $84E3;  
  GL_TRANSPOSE_PROJECTION_MATRIX_ARB = $84E4;  
  GL_TRANSPOSE_TEXTURE_MATRIX_ARB = $84E5;  
  GL_TRANSPOSE_COLOR_MATRIX_ARB = $84E6;  
type
  TPFNGLLOADTRANSPOSEMATRIXDARBPROC = procedure (m:TdMatrix4x4);cdecl;
  TPFNGLLOADTRANSPOSEMATRIXFARBPROC = procedure (m:TfMatrix4x4);cdecl;
  TPFNGLMULTTRANSPOSEMATRIXDARBPROC = procedure (m:TdMatrix4x4);cdecl;
  TPFNGLMULTTRANSPOSEMATRIXFARBPROC = procedure (m:TfMatrix4x4);cdecl;

{ ---------------------- GL_ARB_uniform_buffer_object ---------------------  }

const
  GL_ARB_uniform_buffer_object = 1;  
  GL_UNIFORM_BUFFER = $8A11;  
  GL_UNIFORM_BUFFER_BINDING = $8A28;  
  GL_UNIFORM_BUFFER_START = $8A29;  
  GL_UNIFORM_BUFFER_SIZE = $8A2A;  
  GL_MAX_VERTEX_UNIFORM_BLOCKS = $8A2B;  
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS = $8A2C;  
  GL_MAX_FRAGMENT_UNIFORM_BLOCKS = $8A2D;  
  GL_MAX_COMBINED_UNIFORM_BLOCKS = $8A2E;  
  GL_MAX_UNIFORM_BUFFER_BINDINGS = $8A2F;  
  GL_MAX_UNIFORM_BLOCK_SIZE = $8A30;  
  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = $8A31;  
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = $8A32;  
  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = $8A33;  
  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = $8A34;  
  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = $8A35;  
  GL_ACTIVE_UNIFORM_BLOCKS = $8A36;  
  GL_UNIFORM_TYPE = $8A37;  
  GL_UNIFORM_SIZE = $8A38;  
  GL_UNIFORM_NAME_LENGTH = $8A39;  
  GL_UNIFORM_BLOCK_INDEX = $8A3A;  
  GL_UNIFORM_OFFSET = $8A3B;  
  GL_UNIFORM_ARRAY_STRIDE = $8A3C;  
  GL_UNIFORM_MATRIX_STRIDE = $8A3D;  
  GL_UNIFORM_IS_ROW_MAJOR = $8A3E;  
  GL_UNIFORM_BLOCK_BINDING = $8A3F;  
  GL_UNIFORM_BLOCK_DATA_SIZE = $8A40;  
  GL_UNIFORM_BLOCK_NAME_LENGTH = $8A41;  
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = $8A42;  
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = $8A43;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = $8A44;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = $8A45;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = $8A46;  
  GL_INVALID_INDEX = $FFFFFFFF;  
type
  TPFNGLBINDBUFFERBASEPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;
  TPFNGLBINDBUFFERRANGEPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLGETACTIVEUNIFORMBLOCKNAMEPROC = procedure (prog:TGLuint; uniformBlockIndex:TGLuint; bufSize:TGLsizei; length:PGLsizei; uniformBlockName:PGLchar);cdecl;
  TPFNGLGETACTIVEUNIFORMBLOCKIVPROC = procedure (prog:TGLuint; uniformBlockIndex:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETACTIVEUNIFORMNAMEPROC = procedure (prog:TGLuint; uniformIndex:TGLuint; bufSize:TGLsizei; length:PGLsizei; uniformName:PGLchar);cdecl;
  TPFNGLGETACTIVEUNIFORMSIVPROC = procedure (prog:TGLuint; uniformCount:TGLsizei; uniformIndices:PGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETINTEGERI_VPROC = procedure (target:TGLenum; index:TGLuint; data:PGLint);cdecl;
  TPFNGLGETUNIFORMBLOCKINDEXPROC = function (prog:TGLuint; uniformBlockName:PGLchar):TGLuint;cdecl;
  TPFNGLGETUNIFORMINDICESPROC = procedure (prog:TGLuint; uniformCount:TGLsizei; uniformNames:PPGLchar; uniformIndices:PGLuint);cdecl;
  TPFNGLUNIFORMBLOCKBINDINGPROC = procedure (prog:TGLuint; uniformBlockIndex:TGLuint; uniformBlockBinding:TGLuint);cdecl;


{ ------------------------ GL_ARB_vertex_array_bgra -----------------------  }

const
  GL_ARB_vertex_array_bgra = 1;  
//  GL_BGRA = $80E1;   doppelt


{ ----------------------- GL_ARB_vertex_array_object ----------------------  }

const
  GL_ARB_vertex_array_object = 1;  
  GL_VERTEX_ARRAY_BINDING = $85B5;  
type
  TPFNGLBINDVERTEXARRAYPROC = procedure (arr:TGLuint);cdecl;
  TPFNGLDELETEVERTEXARRAYSPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLGENVERTEXARRAYSPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLISVERTEXARRAYPROC = function (arr:TGLuint):TGLboolean;cdecl;


{ ----------------------- GL_ARB_vertex_attrib_64bit ----------------------  }

const
  GL_ARB_vertex_attrib_64bit = 1;  
type
  TPFNGLGETVERTEXATTRIBLDVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL1DPROC = procedure (index:TGLuint; x:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL1DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL2DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL2DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL3DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL3DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL4DPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL4DVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBLPOINTERPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ ---------------------- GL_ARB_vertex_attrib_binding ---------------------  }

const
  GL_ARB_vertex_attrib_binding = 1;  
  GL_VERTEX_ATTRIB_BINDING = $82D4;  
  GL_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D5;  
  GL_VERTEX_BINDING_DIVISOR = $82D6;  
  GL_VERTEX_BINDING_OFFSET = $82D7;  
  GL_VERTEX_BINDING_STRIDE = $82D8;  
  GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D9;  
  GL_MAX_VERTEX_ATTRIB_BINDINGS = $82DA;  
  GL_VERTEX_BINDING_BUFFER = $8F4F;  
type
  TPFNGLBINDVERTEXBUFFERPROC = procedure (bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;
  TPFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC = procedure (vaobj:TGLuint; bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; bindingindex:TGLuint);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean;                relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC = procedure (vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC = procedure (vaobj:TGLuint; bindingindex:TGLuint; divisor:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBBINDINGPROC = procedure (attribindex:TGLuint; bindingindex:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBFORMATPROC = procedure (attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBIFORMATPROC = procedure (attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBLFORMATPROC = procedure (attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;
  TPFNGLVERTEXBINDINGDIVISORPROC = procedure (bindingindex:TGLuint; divisor:TGLuint);cdecl;


{ -------------------------- GL_ARB_vertex_blend --------------------------  }

const
  GL_ARB_vertex_blend = 1;  
  GL_MODELVIEW0_ARB = $1700;  
  GL_MODELVIEW1_ARB = $850A;  
  GL_MAX_VERTEX_UNITS_ARB = $86A4;  
  GL_ACTIVE_VERTEX_UNITS_ARB = $86A5;  
  GL_WEIGHT_SUM_UNITY_ARB = $86A6;  
  GL_VERTEX_BLEND_ARB = $86A7;  
  GL_CURRENT_WEIGHT_ARB = $86A8;  
  GL_WEIGHT_ARRAY_TYPE_ARB = $86A9;  
  GL_WEIGHT_ARRAY_STRIDE_ARB = $86AA;  
  GL_WEIGHT_ARRAY_SIZE_ARB = $86AB;  
  GL_WEIGHT_ARRAY_POINTER_ARB = $86AC;  
  GL_WEIGHT_ARRAY_ARB = $86AD;  
  GL_MODELVIEW2_ARB = $8722;  
  GL_MODELVIEW3_ARB = $8723;  
  GL_MODELVIEW4_ARB = $8724;  
  GL_MODELVIEW5_ARB = $8725;  
  GL_MODELVIEW6_ARB = $8726;  
  GL_MODELVIEW7_ARB = $8727;  
  GL_MODELVIEW8_ARB = $8728;  
  GL_MODELVIEW9_ARB = $8729;  
  GL_MODELVIEW10_ARB = $872A;  
  GL_MODELVIEW11_ARB = $872B;  
  GL_MODELVIEW12_ARB = $872C;  
  GL_MODELVIEW13_ARB = $872D;  
  GL_MODELVIEW14_ARB = $872E;  
  GL_MODELVIEW15_ARB = $872F;  
  GL_MODELVIEW16_ARB = $8730;  
  GL_MODELVIEW17_ARB = $8731;  
  GL_MODELVIEW18_ARB = $8732;  
  GL_MODELVIEW19_ARB = $8733;  
  GL_MODELVIEW20_ARB = $8734;  
  GL_MODELVIEW21_ARB = $8735;  
  GL_MODELVIEW22_ARB = $8736;  
  GL_MODELVIEW23_ARB = $8737;  
  GL_MODELVIEW24_ARB = $8738;  
  GL_MODELVIEW25_ARB = $8739;  
  GL_MODELVIEW26_ARB = $873A;  
  GL_MODELVIEW27_ARB = $873B;  
  GL_MODELVIEW28_ARB = $873C;  
  GL_MODELVIEW29_ARB = $873D;  
  GL_MODELVIEW30_ARB = $873E;  
  GL_MODELVIEW31_ARB = $873F;  
type
  TPFNGLVERTEXBLENDARBPROC = procedure (count:TGLint);cdecl;
  TPFNGLWEIGHTPOINTERARBPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLWEIGHTBVARBPROC = procedure (size:TGLint; weights:PGLbyte);cdecl;
  TPFNGLWEIGHTDVARBPROC = procedure (size:TGLint; weights:PGLdouble);cdecl;
  TPFNGLWEIGHTFVARBPROC = procedure (size:TGLint; weights:PGLfloat);cdecl;
  TPFNGLWEIGHTIVARBPROC = procedure (size:TGLint; weights:PGLint);cdecl;
  TPFNGLWEIGHTSVARBPROC = procedure (size:TGLint; weights:PGLshort);cdecl;
  TPFNGLWEIGHTUBVARBPROC = procedure (size:TGLint; weights:PGLubyte);cdecl;
  TPFNGLWEIGHTUIVARBPROC = procedure (size:TGLint; weights:PGLuint);cdecl;
  TPFNGLWEIGHTUSVARBPROC = procedure (size:TGLint; weights:PGLushort);cdecl;


{ ---------------------- GL_ARB_vertex_buffer_object ----------------------  }

const
  GL_ARB_vertex_buffer_object = 1;  
  GL_BUFFER_SIZE_ARB = $8764;  
  GL_BUFFER_USAGE_ARB = $8765;  
  GL_ARRAY_BUFFER_ARB = $8892;  
  GL_ELEMENT_ARRAY_BUFFER_ARB = $8893;  
  GL_ARRAY_BUFFER_BINDING_ARB = $8894;  
  GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB = $8895;  
  GL_VERTEX_ARRAY_BUFFER_BINDING_ARB = $8896;  
  GL_NORMAL_ARRAY_BUFFER_BINDING_ARB = $8897;  
  GL_COLOR_ARRAY_BUFFER_BINDING_ARB = $8898;  
  GL_INDEX_ARRAY_BUFFER_BINDING_ARB = $8899;  
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = $889A;  
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = $889B;  
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = $889C;  
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = $889D;  
  GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB = $889E;  
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = $889F;  
  GL_READ_ONLY_ARB = $88B8;  
  GL_WRITE_ONLY_ARB = $88B9;  
  GL_READ_WRITE_ARB = $88BA;  
  GL_BUFFER_ACCESS_ARB = $88BB;  
  GL_BUFFER_MAPPED_ARB = $88BC;  
  GL_BUFFER_MAP_POINTER_ARB = $88BD;  
  GL_STREAM_DRAW_ARB = $88E0;  
  GL_STREAM_READ_ARB = $88E1;  
  GL_STREAM_COPY_ARB = $88E2;  
  GL_STATIC_DRAW_ARB = $88E4;  
  GL_STATIC_READ_ARB = $88E5;  
  GL_STATIC_COPY_ARB = $88E6;  
  GL_DYNAMIC_DRAW_ARB = $88E8;  
  GL_DYNAMIC_READ_ARB = $88E9;  
  GL_DYNAMIC_COPY_ARB = $88EA;  
type
  PGLintptrARB = ^TGLintptrARB;
  TGLintptrARB = Tptrdiff_t;

  PGLsizeiptrARB = ^TGLsizeiptrARB;
  TGLsizeiptrARB = Tptrdiff_t;

  TPFNGLBINDBUFFERARBPROC = procedure (target:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLBUFFERDATAARBPROC = procedure (target:TGLenum; size:TGLsizeiptrARB; data:pointer; usage:TGLenum);cdecl;
  TPFNGLBUFFERSUBDATAARBPROC = procedure (target:TGLenum; offset:TGLintptrARB; size:TGLsizeiptrARB; data:pointer);cdecl;
  TPFNGLDELETEBUFFERSARBPROC = procedure (n:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLGENBUFFERSARBPROC = procedure (n:TGLsizei; buffers:PGLuint);cdecl;
  TPFNGLGETBUFFERPARAMETERIVARBPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETBUFFERPOINTERVARBPROC = procedure (target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLGETBUFFERSUBDATAARBPROC = procedure (target:TGLenum; offset:TGLintptrARB; size:TGLsizeiptrARB; data:pointer);cdecl;
  TPFNGLISBUFFERARBPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLMAPBUFFERARBPROC = function (target:TGLenum; access:TGLenum):pointer;cdecl;
  TPFNGLUNMAPBUFFERARBPROC = function (target:TGLenum):TGLboolean;cdecl;


{ ------------------------- GL_ARB_vertex_program -------------------------  }

const
  GL_ARB_vertex_program = 1;  
  GL_COLOR_SUM_ARB = $8458;  
  GL_VERTEX_PROGRAM_ARB = $8620;  
  GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = $8622;  
  GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = $8623;  
  GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = $8624;  
  GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = $8625;  
  GL_CURRENT_VERTEX_ATTRIB_ARB = $8626;  
  GL_PROGRAM_LENGTH_ARB = $8627;  
  GL_PROGRAM_STRING_ARB = $8628;  
  GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = $862E;  
  GL_MAX_PROGRAM_MATRICES_ARB = $862F;  
  GL_CURRENT_MATRIX_STACK_DEPTH_ARB = $8640;  
  GL_CURRENT_MATRIX_ARB = $8641;  
  GL_VERTEX_PROGRAM_POINT_SIZE_ARB = $8642;  
  GL_VERTEX_PROGRAM_TWO_SIDE_ARB = $8643;  
  GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = $8645;  
  GL_PROGRAM_ERROR_POSITION_ARB = $864B;  
  GL_PROGRAM_BINDING_ARB = $8677;  
  GL_MAX_VERTEX_ATTRIBS_ARB = $8869;  
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = $886A;  
  GL_PROGRAM_ERROR_STRING_ARB = $8874;  
  GL_PROGRAM_FORMAT_ASCII_ARB = $8875;  
  GL_PROGRAM_FORMAT_ARB = $8876;  
  GL_PROGRAM_INSTRUCTIONS_ARB = $88A0;  
  GL_MAX_PROGRAM_INSTRUCTIONS_ARB = $88A1;  
  GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A2;  
  GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A3;  
  GL_PROGRAM_TEMPORARIES_ARB = $88A4;  
  GL_MAX_PROGRAM_TEMPORARIES_ARB = $88A5;  
  GL_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A6;  
  GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A7;  
  GL_PROGRAM_PARAMETERS_ARB = $88A8;  
  GL_MAX_PROGRAM_PARAMETERS_ARB = $88A9;  
  GL_PROGRAM_NATIVE_PARAMETERS_ARB = $88AA;  
  GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB = $88AB;  
  GL_PROGRAM_ATTRIBS_ARB = $88AC;  
  GL_MAX_PROGRAM_ATTRIBS_ARB = $88AD;  
  GL_PROGRAM_NATIVE_ATTRIBS_ARB = $88AE;  
  GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB = $88AF;  
  GL_PROGRAM_ADDRESS_REGISTERS_ARB = $88B0;  
  GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = $88B1;  
  GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B2;  
  GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B3;  
  GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = $88B4;  
  GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = $88B5;  
  GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = $88B6;  
  GL_TRANSPOSE_CURRENT_MATRIX_ARB = $88B7;  
  GL_MATRIX0_ARB = $88C0;  
  GL_MATRIX1_ARB = $88C1;  
  GL_MATRIX2_ARB = $88C2;  
  GL_MATRIX3_ARB = $88C3;  
  GL_MATRIX4_ARB = $88C4;  
  GL_MATRIX5_ARB = $88C5;  
  GL_MATRIX6_ARB = $88C6;  
  GL_MATRIX7_ARB = $88C7;  
  GL_MATRIX8_ARB = $88C8;  
  GL_MATRIX9_ARB = $88C9;  
  GL_MATRIX10_ARB = $88CA;  
  GL_MATRIX11_ARB = $88CB;  
  GL_MATRIX12_ARB = $88CC;  
  GL_MATRIX13_ARB = $88CD;  
  GL_MATRIX14_ARB = $88CE;  
  GL_MATRIX15_ARB = $88CF;  
  GL_MATRIX16_ARB = $88D0;  
  GL_MATRIX17_ARB = $88D1;  
  GL_MATRIX18_ARB = $88D2;  
  GL_MATRIX19_ARB = $88D3;  
  GL_MATRIX20_ARB = $88D4;  
  GL_MATRIX21_ARB = $88D5;  
  GL_MATRIX22_ARB = $88D6;  
  GL_MATRIX23_ARB = $88D7;  
  GL_MATRIX24_ARB = $88D8;  
  GL_MATRIX25_ARB = $88D9;  
  GL_MATRIX26_ARB = $88DA;  
  GL_MATRIX27_ARB = $88DB;  
  GL_MATRIX28_ARB = $88DC;  
  GL_MATRIX29_ARB = $88DD;  
  GL_MATRIX30_ARB = $88DE;  
  GL_MATRIX31_ARB = $88DF;  
type
  TPFNGLBINDPROGRAMARBPROC = procedure (target:TGLenum; prog:TGLuint);cdecl;
  TPFNGLDELETEPROGRAMSARBPROC = procedure (n:TGLsizei; programs:PGLuint);cdecl;
  TPFNGLDISABLEVERTEXATTRIBARRAYARBPROC = procedure (index:TGLuint);cdecl;
  TPFNGLENABLEVERTEXATTRIBARRAYARBPROC = procedure (index:TGLuint);cdecl;
  TPFNGLGENPROGRAMSARBPROC = procedure (n:TGLsizei; programs:PGLuint);cdecl;
  TPFNGLGETPROGRAMENVPARAMETERDVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLGETPROGRAMENVPARAMETERFVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGETPROGRAMLOCALPARAMETERDVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLGETPROGRAMLOCALPARAMETERFVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGETPROGRAMSTRINGARBPROC = procedure (target:TGLenum; pname:TGLenum; _string:pointer);cdecl;
  TPFNGLGETPROGRAMIVARBPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVERTEXATTRIBPOINTERVARBPROC = procedure (index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLGETVERTEXATTRIBDVARBPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETVERTEXATTRIBFVARBPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVERTEXATTRIBIVARBPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISPROGRAMARBPROC = function (prog:TGLuint):TGLboolean;cdecl;
  TPFNGLPROGRAMENVPARAMETER4DARBPROC = procedure (target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble;                w:TGLdouble);cdecl;
  TPFNGLPROGRAMENVPARAMETER4DVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLPROGRAMENVPARAMETER4FARBPROC = procedure (target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat;                w:TGLfloat);cdecl;
  TPFNGLPROGRAMENVPARAMETER4FVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLPROGRAMLOCALPARAMETER4DARBPROC = procedure (target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble;                w:TGLdouble);cdecl;
  TPFNGLPROGRAMLOCALPARAMETER4DVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLPROGRAMLOCALPARAMETER4FARBPROC = procedure (target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat;                w:TGLfloat);cdecl;
  TPFNGLPROGRAMLOCALPARAMETER4FVARBPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLPROGRAMSTRINGARBPROC = procedure (target:TGLenum; format:TGLenum; len:TGLsizei; _string:pointer);cdecl;
  TPFNGLVERTEXATTRIB1DARBPROC = procedure (index:TGLuint; x:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1DVARBPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1FARBPROC = procedure (index:TGLuint; x:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1FVARBPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1SARBPROC = procedure (index:TGLuint; x:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB1SVARBPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB2DARBPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2DVARBPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2FARBPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2FVARBPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2SARBPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB2SVARBPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB3DARBPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3DVARBPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3FARBPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3FVARBPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3SARBPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB3SVARBPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4NBVARBPROC = procedure (index:TGLuint; v:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIB4NIVARBPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIB4NSVARBPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4NUBARBPROC = procedure (index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4NUBVARBPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4NUIVARBPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIB4NUSVARBPROC = procedure (index:TGLuint; v:PGLushort);cdecl;
  TPFNGLVERTEXATTRIB4BVARBPROC = procedure (index:TGLuint; v:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIB4DARBPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4DVARBPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4FARBPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4FVARBPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4IVARBPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIB4SARBPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB4SVARBPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4UBVARBPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4UIVARBPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIB4USVARBPROC = procedure (index:TGLuint; v:PGLushort);cdecl;
  TPFNGLVERTEXATTRIBPOINTERARBPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei;                pointer:pointer);cdecl;


{ -------------------------- GL_ARB_vertex_shader -------------------------  }

const
  GL_ARB_vertex_shader = 1;  
  GL_VERTEX_SHADER_ARB = $8B31;  
  GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = $8B4A;  
  GL_MAX_VARYING_FLOATS_ARB = $8B4B;  
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;  
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = $8B4D;  
  GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = $8B89;  
  GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = $8B8A;  
type
  TPFNGLBINDATTRIBLOCATIONARBPROC = procedure (programObj:TGLhandleARB; index:TGLuint; name:PGLcharARB);cdecl;
  TPFNGLGETACTIVEATTRIBARBPROC = procedure (programObj:TGLhandleARB; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint;                _type:PGLenum; name:PGLcharARB);cdecl;
  TPFNGLGETATTRIBLOCATIONARBPROC = function (programObj:TGLhandleARB; name:PGLcharARB):TGLint;cdecl;


{ ------------------- GL_ARB_vertex_type_10f_11f_11f_rev ------------------  }

const
  GL_ARB_vertex_type_10f_11f_11f_rev = 1;  
//  GL_UNSIGNED_INT_10F_11F_11F_REV = $8C3B;  doppelt


{ ------------------- GL_ARB_vertex_type_2_10_10_10_rev -------------------  }

const
  GL_ARB_vertex_type_2_10_10_10_rev = 1;  
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;  
  GL_INT_2_10_10_10_REV = $8D9F;  
type
  TPFNGLCOLORP3UIPROC = procedure (_type:TGLenum; color:TGLuint);cdecl;
  TPFNGLCOLORP3UIVPROC = procedure (_type:TGLenum; color:PGLuint);cdecl;
  TPFNGLCOLORP4UIPROC = procedure (_type:TGLenum; color:TGLuint);cdecl;
  TPFNGLCOLORP4UIVPROC = procedure (_type:TGLenum; color:PGLuint);cdecl;
  TPFNGLMULTITEXCOORDP1UIPROC = procedure (texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLMULTITEXCOORDP1UIVPROC = procedure (texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLMULTITEXCOORDP2UIPROC = procedure (texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLMULTITEXCOORDP2UIVPROC = procedure (texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLMULTITEXCOORDP3UIPROC = procedure (texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLMULTITEXCOORDP3UIVPROC = procedure (texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLMULTITEXCOORDP4UIPROC = procedure (texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLMULTITEXCOORDP4UIVPROC = procedure (texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLNORMALP3UIPROC = procedure (_type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLNORMALP3UIVPROC = procedure (_type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLSECONDARYCOLORP3UIPROC = procedure (_type:TGLenum; color:TGLuint);cdecl;
  TPFNGLSECONDARYCOLORP3UIVPROC = procedure (_type:TGLenum; color:PGLuint);cdecl;
  TPFNGLTEXCOORDP1UIPROC = procedure (_type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLTEXCOORDP1UIVPROC = procedure (_type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLTEXCOORDP2UIPROC = procedure (_type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLTEXCOORDP2UIVPROC = procedure (_type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLTEXCOORDP3UIPROC = procedure (_type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLTEXCOORDP3UIVPROC = procedure (_type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLTEXCOORDP4UIPROC = procedure (_type:TGLenum; coords:TGLuint);cdecl;
  TPFNGLTEXCOORDP4UIVPROC = procedure (_type:TGLenum; coords:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBP1UIPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBP1UIVPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBP2UIPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBP2UIVPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBP3UIPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBP3UIVPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBP4UIPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBP4UIVPROC = procedure (index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;
  TPFNGLVERTEXP2UIPROC = procedure (_type:TGLenum; value:TGLuint);cdecl;
  TPFNGLVERTEXP2UIVPROC = procedure (_type:TGLenum; value:PGLuint);cdecl;
  TPFNGLVERTEXP3UIPROC = procedure (_type:TGLenum; value:TGLuint);cdecl;
  TPFNGLVERTEXP3UIVPROC = procedure (_type:TGLenum; value:PGLuint);cdecl;
  TPFNGLVERTEXP4UIPROC = procedure (_type:TGLenum; value:TGLuint);cdecl;
  TPFNGLVERTEXP4UIVPROC = procedure (_type:TGLenum; value:PGLuint);cdecl;


{ ------------------------- GL_ARB_viewport_array -------------------------  }

const
  GL_ARB_viewport_array = 1;  
//  GL_DEPTH_RANGE = $0B70;   doppelt
//  GL_VIEWPORT = $0BA2;  
//  GL_SCISSOR_BOX = $0C10;  
//  GL_SCISSOR_TEST = $0C11;  
  GL_MAX_VIEWPORTS = $825B;  
  GL_VIEWPORT_SUBPIXEL_BITS = $825C;  
  GL_VIEWPORT_BOUNDS_RANGE = $825D;  
  GL_LAYER_PROVOKING_VERTEX = $825E;  
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX = $825F;  
  GL_UNDEFINED_VERTEX = $8260;  
//  GL_FIRST_VERTEX_CONVENTION = $8E4D;  
//  GL_LAST_VERTEX_CONVENTION = $8E4E;  
//  GL_PROVOKING_VERTEX = $8E4F;  
type
  TPFNGLDEPTHRANGEARRAYVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLclampd);cdecl;
  TPFNGLDEPTHRANGEINDEXEDPROC = procedure (index:TGLuint; n:TGLclampd; f:TGLclampd);cdecl;
  TPFNGLGETDOUBLEI_VPROC = procedure (target:TGLenum; index:TGLuint; data:PGLdouble);cdecl;
  TPFNGLGETFLOATI_VPROC = procedure (target:TGLenum; index:TGLuint; data:PGLfloat);cdecl;
  TPFNGLSCISSORARRAYVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLint);cdecl;
  TPFNGLSCISSORINDEXEDPROC = procedure (index:TGLuint; left:TGLint; bottom:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLSCISSORINDEXEDVPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVIEWPORTARRAYVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVIEWPORTINDEXEDFPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; w:TGLfloat; h:TGLfloat);cdecl;
  TPFNGLVIEWPORTINDEXEDFVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;


{ --------------------------- GL_ARB_window_pos ---------------------------  }

const
  GL_ARB_window_pos = 1;  
type
  TPFNGLWINDOWPOS2DARBPROC = procedure (x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLWINDOWPOS2DVARBPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS2FARBPROC = procedure (x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLWINDOWPOS2FVARBPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS2IARBPROC = procedure (x:TGLint; y:TGLint);cdecl;
  TPFNGLWINDOWPOS2IVARBPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS2SARBPROC = procedure (x:TGLshort; y:TGLshort);cdecl;
  TPFNGLWINDOWPOS2SVARBPROC = procedure (p:PGLshort);cdecl;
  TPFNGLWINDOWPOS3DARBPROC = procedure (x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLWINDOWPOS3DVARBPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS3FARBPROC = procedure (x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLWINDOWPOS3FVARBPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS3IARBPROC = procedure (x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLWINDOWPOS3IVARBPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS3SARBPROC = procedure (x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLWINDOWPOS3SVARBPROC = procedure (p:PGLshort);cdecl;


{ ----------------------- GL_ARM_mali_program_binary ----------------------  }

const
  GL_ARM_mali_program_binary = 1;  
  GL_MALI_PROGRAM_BINARY_ARM = $8F61;  


{ ----------------------- GL_ARM_mali_shader_binary -----------------------  }

const
  GL_ARM_mali_shader_binary = 1;  
  GL_MALI_SHADER_BINARY_ARM = $8F60;  


{ ------------------------------ GL_ARM_rgba8 -----------------------------  }

const
  GL_ARM_rgba8 = 1;  
  GL_RGBA8_OES = $8058;  


{ -------------------- GL_ARM_shader_framebuffer_fetch --------------------  }

const
  GL_ARM_shader_framebuffer_fetch = 1;  
  GL_FETCH_PER_SAMPLE_ARM = $8F65;  
  GL_FRAGMENT_SHADER_FRAMEBUFFER_FETCH_MRT_ARM = $8F66;  


{ ------------- GL_ARM_shader_framebuffer_fetch_depth_stencil -------------  }

const
  GL_ARM_shader_framebuffer_fetch_depth_stencil = 1;  


{ ---------------- GL_ARM_texture_unnormalized_coordinates ----------------  }

const
  GL_ARM_texture_unnormalized_coordinates = 1;  
  GL_TEXTURE_UNNORMALIZED_COORDINATES_ARM = $8F6A;  


{ ------------------------- GL_ATIX_point_sprites -------------------------  }

const
  GL_ATIX_point_sprites = 1;  
  GL_TEXTURE_POINT_MODE_ATIX = $60B0;  
  GL_TEXTURE_POINT_ONE_COORD_ATIX = $60B1;  
  GL_TEXTURE_POINT_SPRITE_ATIX = $60B2;  
  GL_POINT_SPRITE_CULL_MODE_ATIX = $60B3;  
  GL_POINT_SPRITE_CULL_CENTER_ATIX = $60B4;  
  GL_POINT_SPRITE_CULL_CLIP_ATIX = $60B5;  


{ ---------------------- GL_ATIX_texture_env_combine3 ---------------------  }

const
  GL_ATIX_texture_env_combine3 = 1;  
  GL_MODULATE_ADD_ATIX = $8744;  
  GL_MODULATE_SIGNED_ADD_ATIX = $8745;  
  GL_MODULATE_SUBTRACT_ATIX = $8746;  


{ ----------------------- GL_ATIX_texture_env_route -----------------------  }

const
  GL_ATIX_texture_env_route = 1;  
  GL_SECONDARY_COLOR_ATIX = $8747;  
  GL_TEXTURE_OUTPUT_RGB_ATIX = $8748;  
  GL_TEXTURE_OUTPUT_ALPHA_ATIX = $8749;  


{ ---------------- GL_ATIX_vertex_shader_output_point_size ----------------  }

const
  GL_ATIX_vertex_shader_output_point_size = 1;  
  GL_OUTPUT_POINT_SIZE_ATIX = $610E;  


{ -------------------------- GL_ATI_draw_buffers --------------------------  }

const
  GL_ATI_draw_buffers = 1;  
  GL_MAX_DRAW_BUFFERS_ATI = $8824;  
  GL_DRAW_BUFFER0_ATI = $8825;  
  GL_DRAW_BUFFER1_ATI = $8826;  
  GL_DRAW_BUFFER2_ATI = $8827;  
  GL_DRAW_BUFFER3_ATI = $8828;  
  GL_DRAW_BUFFER4_ATI = $8829;  
  GL_DRAW_BUFFER5_ATI = $882A;  
  GL_DRAW_BUFFER6_ATI = $882B;  
  GL_DRAW_BUFFER7_ATI = $882C;  
  GL_DRAW_BUFFER8_ATI = $882D;  
  GL_DRAW_BUFFER9_ATI = $882E;  
  GL_DRAW_BUFFER10_ATI = $882F;  
  GL_DRAW_BUFFER11_ATI = $8830;  
  GL_DRAW_BUFFER12_ATI = $8831;  
  GL_DRAW_BUFFER13_ATI = $8832;  
  GL_DRAW_BUFFER14_ATI = $8833;  
  GL_DRAW_BUFFER15_ATI = $8834;  
type
  TPFNGLDRAWBUFFERSATIPROC = procedure (n:TGLsizei; bufs:PGLenum);cdecl;


{ -------------------------- GL_ATI_element_array -------------------------  }

const
  GL_ATI_element_array = 1;  
  GL_ELEMENT_ARRAY_ATI = $8768;  
  GL_ELEMENT_ARRAY_TYPE_ATI = $8769;  
  GL_ELEMENT_ARRAY_POINTER_ATI = $876A;  
type
  TPFNGLDRAWELEMENTARRAYATIPROC = procedure (mode:TGLenum; count:TGLsizei);cdecl;
  TPFNGLDRAWRANGEELEMENTARRAYATIPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei);cdecl;
  TPFNGLELEMENTPOINTERATIPROC = procedure (_type:TGLenum; pointer:pointer);cdecl;


{ ------------------------- GL_ATI_envmap_bumpmap -------------------------  }

const
  GL_ATI_envmap_bumpmap = 1;  
  GL_BUMP_ROT_MATRIX_ATI = $8775;  
  GL_BUMP_ROT_MATRIX_SIZE_ATI = $8776;  
  GL_BUMP_NUM_TEX_UNITS_ATI = $8777;  
  GL_BUMP_TEX_UNITS_ATI = $8778;  
  GL_DUDV_ATI = $8779;  
  GL_DU8DV8_ATI = $877A;  
  GL_BUMP_ENVMAP_ATI = $877B;  
  GL_BUMP_TARGET_ATI = $877C;  
type
  TPFNGLGETTEXBUMPPARAMETERFVATIPROC = procedure (pname:TGLenum; param:PGLfloat);cdecl;
  TPFNGLGETTEXBUMPPARAMETERIVATIPROC = procedure (pname:TGLenum; param:PGLint);cdecl;
  TPFNGLTEXBUMPPARAMETERFVATIPROC = procedure (pname:TGLenum; param:PGLfloat);cdecl;
  TPFNGLTEXBUMPPARAMETERIVATIPROC = procedure (pname:TGLenum; param:PGLint);cdecl;


{ ------------------------- GL_ATI_fragment_shader ------------------------  }

const
  GL_ATI_fragment_shader = 1;  
  GL_2X_BIT_ATI = $00000001;  
  GL_RED_BIT_ATI = $00000001;  
  GL_4X_BIT_ATI = $00000002;  
  GL_COMP_BIT_ATI = $00000002;  
  GL_GREEN_BIT_ATI = $00000002;  
  GL_8X_BIT_ATI = $00000004;  
  GL_BLUE_BIT_ATI = $00000004;  
  GL_NEGATE_BIT_ATI = $00000004;  
  GL_BIAS_BIT_ATI = $00000008;  
  GL_HALF_BIT_ATI = $00000008;  
  GL_QUARTER_BIT_ATI = $00000010;  
  GL_EIGHTH_BIT_ATI = $00000020;  
  GL_SATURATE_BIT_ATI = $00000040;  
  GL_FRAGMENT_SHADER_ATI = $8920;  
  GL_REG_0_ATI = $8921;  
  GL_REG_1_ATI = $8922;  
  GL_REG_2_ATI = $8923;  
  GL_REG_3_ATI = $8924;  
  GL_REG_4_ATI = $8925;  
  GL_REG_5_ATI = $8926;  
  GL_CON_0_ATI = $8941;  
  GL_CON_1_ATI = $8942;  
  GL_CON_2_ATI = $8943;  
  GL_CON_3_ATI = $8944;  
  GL_CON_4_ATI = $8945;  
  GL_CON_5_ATI = $8946;  
  GL_CON_6_ATI = $8947;  
  GL_CON_7_ATI = $8948;  
  GL_MOV_ATI = $8961;  
  GL_ADD_ATI = $8963;  
  GL_MUL_ATI = $8964;  
  GL_SUB_ATI = $8965;  
  GL_DOT3_ATI = $8966;  
  GL_DOT4_ATI = $8967;  
  GL_MAD_ATI = $8968;  
  GL_LERP_ATI = $8969;  
  GL_CND_ATI = $896A;  
  GL_CND0_ATI = $896B;  
  GL_DOT2_ADD_ATI = $896C;  
  GL_SECONDARY_INTERPOLATOR_ATI = $896D;  
  GL_NUM_FRAGMENT_REGISTERS_ATI = $896E;  
  GL_NUM_FRAGMENT_CONSTANTS_ATI = $896F;  
  GL_NUM_PASSES_ATI = $8970;  
  GL_NUM_INSTRUCTIONS_PER_PASS_ATI = $8971;  
  GL_NUM_INSTRUCTIONS_TOTAL_ATI = $8972;  
  GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = $8973;  
  GL_NUM_LOOPBACK_COMPONENTS_ATI = $8974;  
  GL_COLOR_ALPHA_PAIRING_ATI = $8975;  
  GL_SWIZZLE_STR_ATI = $8976;  
  GL_SWIZZLE_STQ_ATI = $8977;  
  GL_SWIZZLE_STR_DR_ATI = $8978;  
  GL_SWIZZLE_STQ_DQ_ATI = $8979;  
  GL_SWIZZLE_STRQ_ATI = $897A;  
  GL_SWIZZLE_STRQ_DQ_ATI = $897B;  
type
  TPFNGLALPHAFRAGMENTOP1ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint;                arg1Mod:TGLuint);cdecl;
  TPFNGLALPHAFRAGMENTOP2ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint;
                arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint);cdecl;
  TPFNGLALPHAFRAGMENTOP3ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint;
                arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint; arg3:TGLuint; 
                arg3Rep:TGLuint; arg3Mod:TGLuint);cdecl;
  TPFNGLBEGINFRAGMENTSHADERATIPROC = procedure (para1:pointer);cdecl;
  TPFNGLBINDFRAGMENTSHADERATIPROC = procedure (id:TGLuint);cdecl;
  TPFNGLCOLORFRAGMENTOP1ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint;                arg1Rep:TGLuint; arg1Mod:TGLuint);cdecl;
  TPFNGLCOLORFRAGMENTOP2ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint;
                arg1Rep:TGLuint; arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint);cdecl;
  TPFNGLCOLORFRAGMENTOP3ATIPROC = procedure (op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint;
                arg1Rep:TGLuint; arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint; 
                arg3:TGLuint; arg3Rep:TGLuint; arg3Mod:TGLuint);cdecl;
  TPFNGLDELETEFRAGMENTSHADERATIPROC = procedure (id:TGLuint);cdecl;
  TPFNGLENDFRAGMENTSHADERATIPROC = procedure (para1:pointer);cdecl;
  TPFNGLGENFRAGMENTSHADERSATIPROC = function (range:TGLuint):TGLuint;cdecl;
  TPFNGLPASSTEXCOORDATIPROC = procedure (dst:TGLuint; coord:TGLuint; swizzle:TGLenum);cdecl;
  TPFNGLSAMPLEMAPATIPROC = procedure (dst:TGLuint; interp:TGLuint; swizzle:TGLenum);cdecl;
  TPFNGLSETFRAGMENTSHADERCONSTANTATIPROC = procedure (dst:TGLuint; value:PGLfloat);cdecl;


{ ------------------------ GL_ATI_map_object_buffer -----------------------  }

const
  GL_ATI_map_object_buffer = 1;  
type
  TPFNGLMAPOBJECTBUFFERATIPROC = function (buffer:TGLuint):pointer;cdecl;
  TPFNGLUNMAPOBJECTBUFFERATIPROC = procedure (buffer:TGLuint);cdecl;


{ ----------------------------- GL_ATI_meminfo ----------------------------  }

const
  GL_ATI_meminfo = 1;  
  GL_VBO_FREE_MEMORY_ATI = $87FB;  
  GL_TEXTURE_FREE_MEMORY_ATI = $87FC;  
  GL_RENDERBUFFER_FREE_MEMORY_ATI = $87FD;  


{ -------------------------- GL_ATI_pn_triangles --------------------------  }

const
  GL_ATI_pn_triangles = 1;  
  GL_PN_TRIANGLES_ATI = $87F0;  
  GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F1;  
  GL_PN_TRIANGLES_POINT_MODE_ATI = $87F2;  
  GL_PN_TRIANGLES_NORMAL_MODE_ATI = $87F3;  
  GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F4;  
  GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI = $87F5;  
  GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI = $87F6;  
  GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = $87F7;  
  GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = $87F8;  
type
  TPFNGLPNTRIANGLESFATIPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPNTRIANGLESIATIPROC = procedure (pname:TGLenum; param:TGLint);cdecl;


{ ------------------------ GL_ATI_separate_stencil ------------------------  }

const
  GL_ATI_separate_stencil = 1;  
  GL_STENCIL_BACK_FUNC_ATI = $8800;  
  GL_STENCIL_BACK_FAIL_ATI = $8801;  
  GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = $8802;  
  GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = $8803;  
type
  TPFNGLSTENCILFUNCSEPARATEATIPROC = procedure (frontfunc:TGLenum; backfunc:TGLenum; ref:TGLint; mask:TGLuint);cdecl;
  TPFNGLSTENCILOPSEPARATEATIPROC = procedure (face:TGLenum; sfail:TGLenum; dpfail:TGLenum; dppass:TGLenum);cdecl;


{ ----------------------- GL_ATI_shader_texture_lod -----------------------  }

const
  GL_ATI_shader_texture_lod = 1;  


{ ---------------------- GL_ATI_text_fragment_shader ----------------------  }

const
  GL_ATI_text_fragment_shader = 1;  
  GL_TEXT_FRAGMENT_SHADER_ATI = $8200;  


{ --------------------- GL_ATI_texture_compression_3dc --------------------  }

const
  GL_ATI_texture_compression_3dc = 1;  
  GL_COMPRESSED_LUMINANCE_ALPHA_3DC_ATI = $8837;  


{ ---------------------- GL_ATI_texture_env_combine3 ----------------------  }

const
  GL_ATI_texture_env_combine3 = 1;  
  GL_MODULATE_ADD_ATI = $8744;  
  GL_MODULATE_SIGNED_ADD_ATI = $8745;  
  GL_MODULATE_SUBTRACT_ATI = $8746;  


{ -------------------------- GL_ATI_texture_float -------------------------  }

const
  GL_ATI_texture_float = 1;  
  GL_RGBA_FLOAT32_ATI = $8814;  
  GL_RGB_FLOAT32_ATI = $8815;  
  GL_ALPHA_FLOAT32_ATI = $8816;  
  GL_INTENSITY_FLOAT32_ATI = $8817;  
  GL_LUMINANCE_FLOAT32_ATI = $8818;  
  GL_LUMINANCE_ALPHA_FLOAT32_ATI = $8819;  
  GL_RGBA_FLOAT16_ATI = $881A;  
  GL_RGB_FLOAT16_ATI = $881B;  
  GL_ALPHA_FLOAT16_ATI = $881C;  
  GL_INTENSITY_FLOAT16_ATI = $881D;  
  GL_LUMINANCE_FLOAT16_ATI = $881E;  
  GL_LUMINANCE_ALPHA_FLOAT16_ATI = $881F;  


{ ----------------------- GL_ATI_texture_mirror_once ----------------------  }

const
  GL_ATI_texture_mirror_once = 1;  
  GL_MIRROR_CLAMP_ATI = $8742;  
  GL_MIRROR_CLAMP_TO_EDGE_ATI = $8743;  


{ ----------------------- GL_ATI_vertex_array_object ----------------------  }

const
  GL_ATI_vertex_array_object = 1;  
  GL_STATIC_ATI = $8760;  
  GL_DYNAMIC_ATI = $8761;  
  GL_PRESERVE_ATI = $8762;  
  GL_DISCARD_ATI = $8763;  
  GL_OBJECT_BUFFER_SIZE_ATI = $8764;  
  GL_OBJECT_BUFFER_USAGE_ATI = $8765;  
  GL_ARRAY_OBJECT_BUFFER_ATI = $8766;  
  GL_ARRAY_OBJECT_OFFSET_ATI = $8767;  
type
  TPFNGLARRAYOBJECTATIPROC = procedure (arr:TGLenum; size:TGLint; _type:TGLenum; stride:TGLsizei; buffer:TGLuint;                offset:TGLuint);cdecl;
  TPFNGLFREEOBJECTBUFFERATIPROC = procedure (buffer:TGLuint);cdecl;
  TPFNGLGETARRAYOBJECTFVATIPROC = procedure (arr:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETARRAYOBJECTIVATIPROC = procedure (arr:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETOBJECTBUFFERFVATIPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETOBJECTBUFFERIVATIPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVARIANTARRAYOBJECTFVATIPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVARIANTARRAYOBJECTIVATIPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISOBJECTBUFFERATIPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLNEWOBJECTBUFFERATIPROC = function (size:TGLsizei; pointer:pointer; usage:TGLenum):TGLuint;cdecl;
  TPFNGLUPDATEOBJECTBUFFERATIPROC = procedure (buffer:TGLuint; offset:TGLuint; size:TGLsizei; pointer:pointer; preserve:TGLenum);cdecl;
  TPFNGLVARIANTARRAYOBJECTATIPROC = procedure (id:TGLuint; _type:TGLenum; stride:TGLsizei; buffer:TGLuint; offset:TGLuint);cdecl;


{ ------------------- GL_ATI_vertex_attrib_array_object -------------------  }

const
  GL_ATI_vertex_attrib_array_object = 1;  
type
  TPFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLVERTEXATTRIBARRAYOBJECTATIPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei;                buffer:TGLuint; offset:TGLuint);cdecl;


{ ------------------------- GL_ATI_vertex_streams -------------------------  }

const
  GL_ATI_vertex_streams = 1;  
  GL_MAX_VERTEX_STREAMS_ATI = $876B;  
  GL_VERTEX_SOURCE_ATI = $876C;  
  GL_VERTEX_STREAM0_ATI = $876D;  
  GL_VERTEX_STREAM1_ATI = $876E;  
  GL_VERTEX_STREAM2_ATI = $876F;  
  GL_VERTEX_STREAM3_ATI = $8770;  
  GL_VERTEX_STREAM4_ATI = $8771;  
  GL_VERTEX_STREAM5_ATI = $8772;  
  GL_VERTEX_STREAM6_ATI = $8773;  
  GL_VERTEX_STREAM7_ATI = $8774;  
type
  TPFNGLCLIENTACTIVEVERTEXSTREAMATIPROC = procedure (stream:TGLenum);cdecl;
  TPFNGLNORMALSTREAM3BATIPROC = procedure (stream:TGLenum; x:TGLbyte; y:TGLbyte; z:TGLbyte);cdecl;
  TPFNGLNORMALSTREAM3BVATIPROC = procedure (stream:TGLenum; coords:PGLbyte);cdecl;
  TPFNGLNORMALSTREAM3DATIPROC = procedure (stream:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLNORMALSTREAM3DVATIPROC = procedure (stream:TGLenum; coords:PGLdouble);cdecl;
  TPFNGLNORMALSTREAM3FATIPROC = procedure (stream:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLNORMALSTREAM3FVATIPROC = procedure (stream:TGLenum; coords:PGLfloat);cdecl;
  TPFNGLNORMALSTREAM3IATIPROC = procedure (stream:TGLenum; x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLNORMALSTREAM3IVATIPROC = procedure (stream:TGLenum; coords:PGLint);cdecl;
  TPFNGLNORMALSTREAM3SATIPROC = procedure (stream:TGLenum; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLNORMALSTREAM3SVATIPROC = procedure (stream:TGLenum; coords:PGLshort);cdecl;
  TPFNGLVERTEXBLENDENVFATIPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLVERTEXBLENDENVIATIPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLVERTEXSTREAM1DATIPROC = procedure (stream:TGLenum; x:TGLdouble);cdecl;
  TPFNGLVERTEXSTREAM1DVATIPROC = procedure (stream:TGLenum; coords:PGLdouble);cdecl;
  TPFNGLVERTEXSTREAM1FATIPROC = procedure (stream:TGLenum; x:TGLfloat);cdecl;
  TPFNGLVERTEXSTREAM1FVATIPROC = procedure (stream:TGLenum; coords:PGLfloat);cdecl;
  TPFNGLVERTEXSTREAM1IATIPROC = procedure (stream:TGLenum; x:TGLint);cdecl;
  TPFNGLVERTEXSTREAM1IVATIPROC = procedure (stream:TGLenum; coords:PGLint);cdecl;
  TPFNGLVERTEXSTREAM1SATIPROC = procedure (stream:TGLenum; x:TGLshort);cdecl;
  TPFNGLVERTEXSTREAM1SVATIPROC = procedure (stream:TGLenum; coords:PGLshort);cdecl;
  TPFNGLVERTEXSTREAM2DATIPROC = procedure (stream:TGLenum; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXSTREAM2DVATIPROC = procedure (stream:TGLenum; coords:PGLdouble);cdecl;
  TPFNGLVERTEXSTREAM2FATIPROC = procedure (stream:TGLenum; x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLVERTEXSTREAM2FVATIPROC = procedure (stream:TGLenum; coords:PGLfloat);cdecl;
  TPFNGLVERTEXSTREAM2IATIPROC = procedure (stream:TGLenum; x:TGLint; y:TGLint);cdecl;
  TPFNGLVERTEXSTREAM2IVATIPROC = procedure (stream:TGLenum; coords:PGLint);cdecl;
  TPFNGLVERTEXSTREAM2SATIPROC = procedure (stream:TGLenum; x:TGLshort; y:TGLshort);cdecl;
  TPFNGLVERTEXSTREAM2SVATIPROC = procedure (stream:TGLenum; coords:PGLshort);cdecl;
  TPFNGLVERTEXSTREAM3DATIPROC = procedure (stream:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXSTREAM3DVATIPROC = procedure (stream:TGLenum; coords:PGLdouble);cdecl;
  TPFNGLVERTEXSTREAM3FATIPROC = procedure (stream:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLVERTEXSTREAM3FVATIPROC = procedure (stream:TGLenum; coords:PGLfloat);cdecl;
  TPFNGLVERTEXSTREAM3IATIPROC = procedure (stream:TGLenum; x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLVERTEXSTREAM3IVATIPROC = procedure (stream:TGLenum; coords:PGLint);cdecl;
  TPFNGLVERTEXSTREAM3SATIPROC = procedure (stream:TGLenum; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLVERTEXSTREAM3SVATIPROC = procedure (stream:TGLenum; coords:PGLshort);cdecl;
  TPFNGLVERTEXSTREAM4DATIPROC = procedure (stream:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXSTREAM4DVATIPROC = procedure (stream:TGLenum; coords:PGLdouble);cdecl;
  TPFNGLVERTEXSTREAM4FATIPROC = procedure (stream:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLVERTEXSTREAM4FVATIPROC = procedure (stream:TGLenum; coords:PGLfloat);cdecl;
  TPFNGLVERTEXSTREAM4IATIPROC = procedure (stream:TGLenum; x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;
  TPFNGLVERTEXSTREAM4IVATIPROC = procedure (stream:TGLenum; coords:PGLint);cdecl;
  TPFNGLVERTEXSTREAM4SATIPROC = procedure (stream:TGLenum; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;
  TPFNGLVERTEXSTREAM4SVATIPROC = procedure (stream:TGLenum; coords:PGLshort);cdecl;


{ ------------------------- GL_DMP_program_binary -------------------------  }

const
  GL_DMP_program_binary = 1;  
  GL_SMAPHS30_PROGRAM_BINARY_DMP = $9251;  
  GL_SMAPHS_PROGRAM_BINARY_DMP = $9252;  
  GL_DMP_PROGRAM_BINARY_DMP = $9253;  


{ -------------------------- GL_DMP_shader_binary -------------------------  }

const
  GL_DMP_shader_binary = 1;  
  GL_SHADER_BINARY_DMP = $9250;  


{ --------------------------- GL_EXT_422_pixels ---------------------------  }

const
  GL_EXT_422_pixels = 1;  
  GL_422_EXT = $80CC;  
  GL_422_REV_EXT = $80CD;  
  GL_422_AVERAGE_EXT = $80CE;  
  GL_422_REV_AVERAGE_EXT = $80CF;  


{ ---------------------------- GL_EXT_Cg_shader ---------------------------  }

const
  GL_EXT_Cg_shader = 1;  
  GL_CG_VERTEX_SHADER_EXT = $890E;  
  GL_CG_FRAGMENT_SHADER_EXT = $890F;  


{ ------------------------- GL_EXT_EGL_image_array ------------------------  }

const
  GL_EXT_EGL_image_array = 1;  


{ ------------------ GL_EXT_EGL_image_external_wrap_modes -----------------  }

const
  GL_EXT_EGL_image_external_wrap_modes = 1;  


{ ------------------------ GL_EXT_EGL_image_storage -----------------------  }

const
  GL_EXT_EGL_image_storage = 1;  
type
  TPFNGLEGLIMAGETARGETTEXSTORAGEEXTPROC = procedure (target:TGLenum; image:TGLeglImageOES; attrib_list:PGLint);cdecl;
  TPFNGLEGLIMAGETARGETTEXTURESTORAGEEXTPROC = procedure (texture:TGLuint; image:TGLeglImageOES; attrib_list:PGLint);cdecl;


{ ---------------------------- GL_EXT_EGL_sync ----------------------------  }

const
  GL_EXT_EGL_sync = 1;  


{ --------------------------- GL_EXT_YUV_target ---------------------------  }

const
  GL_EXT_YUV_target = 1;  
  GL_SAMPLER_EXTERNAL_2D_Y2Y_EXT = $8BE7;  


{ ------------------------------ GL_EXT_abgr ------------------------------  }

const
  GL_EXT_abgr = 1;  
  GL_ABGR_EXT = $8000;  


{ -------------------------- GL_EXT_base_instance -------------------------  }

const
  GL_EXT_base_instance = 1;  
type
  TPFNGLDRAWARRAYSINSTANCEDBASEINSTANCEEXTPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; instancecount:TGLsizei; baseinstance:TGLuint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEEXTPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei;                baseinstance:TGLuint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEEXTPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei;                basevertex:TGLint; baseinstance:TGLuint);cdecl;


{ ------------------------------ GL_EXT_bgra ------------------------------  }

const
  GL_EXT_bgra = 1;  
  GL_BGR_EXT = $80E0;  
//  GL_BGRA_EXT = $80E1;  doppelt


{ ------------------------ GL_EXT_bindable_uniform ------------------------  }

const
  GL_EXT_bindable_uniform = 1;  
  GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = $8DE2;  
  GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = $8DE3;  
  GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = $8DE4;  
  GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = $8DED;  
  GL_UNIFORM_BUFFER_EXT = $8DEE;  
  GL_UNIFORM_BUFFER_BINDING_EXT = $8DEF;  
type
  TPFNGLGETUNIFORMBUFFERSIZEEXTPROC = function (prog:TGLuint; location:TGLint):TGLint;cdecl;
  TPFNGLGETUNIFORMOFFSETEXTPROC = function (prog:TGLuint; location:TGLint):TGLintptr;cdecl;
  TPFNGLUNIFORMBUFFEREXTPROC = procedure (prog:TGLuint; location:TGLint; buffer:TGLuint);cdecl;


{ --------------------------- GL_EXT_blend_color --------------------------  }

const
  GL_EXT_blend_color = 1;  
  GL_CONSTANT_COLOR_EXT = $8001;  
  GL_ONE_MINUS_CONSTANT_COLOR_EXT = $8002;  
  GL_CONSTANT_ALPHA_EXT = $8003;  
  GL_ONE_MINUS_CONSTANT_ALPHA_EXT = $8004;  
  GL_BLEND_COLOR_EXT = $8005;  
type
  TPFNGLBLENDCOLOREXTPROC = procedure (red:TGLclampf; green:TGLclampf; blue:TGLclampf; alpha:TGLclampf);cdecl;


{ --------------------- GL_EXT_blend_equation_separate --------------------  }

const
  GL_EXT_blend_equation_separate = 1;  
  GL_BLEND_EQUATION_RGB_EXT = $8009;  
  GL_BLEND_EQUATION_ALPHA_EXT = $883D;  
type
  TPFNGLBLENDEQUATIONSEPARATEEXTPROC = procedure (modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;


{ ----------------------- GL_EXT_blend_func_extended ----------------------  }

const
  GL_EXT_blend_func_extended = 1;  
  GL_SRC_ALPHA_SATURATE_EXT = $0308;  
  GL_SRC1_ALPHA_EXT = $8589;  
  GL_SRC1_COLOR_EXT = $88F9;  
  GL_ONE_MINUS_SRC1_COLOR_EXT = $88FA;  
  GL_ONE_MINUS_SRC1_ALPHA_EXT = $88FB;  
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS_EXT = $88FC;  
  GL_LOCATION_INDEX_EXT = $930F;  
type
  TPFNGLBINDFRAGDATALOCATIONINDEXEDEXTPROC = procedure (prog:TGLuint; colorNumber:TGLuint; index:TGLuint; name:PGLchar);cdecl;
  TPFNGLGETFRAGDATAINDEXEXTPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLGETPROGRAMRESOURCELOCATIONINDEXEXTPROC = function (prog:TGLuint; programInterface:TGLenum; name:PGLchar):TGLint;cdecl;


{ ----------------------- GL_EXT_blend_func_separate ----------------------  }

const
  GL_EXT_blend_func_separate = 1;  
  GL_BLEND_DST_RGB_EXT = $80C8;  
  GL_BLEND_SRC_RGB_EXT = $80C9;  
  GL_BLEND_DST_ALPHA_EXT = $80CA;  
  GL_BLEND_SRC_ALPHA_EXT = $80CB;  
type
  TPFNGLBLENDFUNCSEPARATEEXTPROC = procedure (sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;


{ ------------------------- GL_EXT_blend_logic_op -------------------------  }

const
  GL_EXT_blend_logic_op = 1;  


{ -------------------------- GL_EXT_blend_minmax --------------------------  }

const
  GL_EXT_blend_minmax = 1;  
  GL_FUNC_ADD_EXT = $8006;  
  GL_MIN_EXT = $8007;  
  GL_MAX_EXT = $8008;  
  GL_BLEND_EQUATION_EXT = $8009;  
type
  TPFNGLBLENDEQUATIONEXTPROC = procedure (mode:TGLenum);cdecl;


{ ------------------------- GL_EXT_blend_subtract -------------------------  }

const
  GL_EXT_blend_subtract = 1;  
  GL_FUNC_SUBTRACT_EXT = $800A;  
  GL_FUNC_REVERSE_SUBTRACT_EXT = $800B;  


{ ------------------------- GL_EXT_buffer_storage -------------------------  }

const
  GL_EXT_buffer_storage = 1;  
//  GL_MAP_READ_BIT = $0001;    doppelt
//  GL_MAP_WRITE_BIT = $0002;  
  GL_MAP_PERSISTENT_BIT_EXT = $0040;  
  GL_MAP_COHERENT_BIT_EXT = $0080;  
  GL_DYNAMIC_STORAGE_BIT_EXT = $0100;  
  GL_CLIENT_STORAGE_BIT_EXT = $0200;  
  GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT_EXT = $00004000;  
  GL_BUFFER_IMMUTABLE_STORAGE_EXT = $821F;  
  GL_BUFFER_STORAGE_FLAGS_EXT = $8220;  
type
  TPFNGLBUFFERSTORAGEEXTPROC = procedure (target:TGLenum; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;
  TPFNGLNAMEDBUFFERSTORAGEEXTPROC = procedure (buffer:TGLuint; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;


{ -------------------------- GL_EXT_clear_texture -------------------------  }

const
  GL_EXT_clear_texture = 1;  
type
  TPFNGLCLEARTEXIMAGEEXTPROC = procedure (texture:TGLuint; level:TGLint; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLCLEARTEXSUBIMAGEEXTPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                data:pointer);cdecl;


{ -------------------------- GL_EXT_clip_control --------------------------  }

const
  GL_EXT_clip_control = 1;  
  GL_LOWER_LEFT_EXT = $8CA1;  
  GL_UPPER_LEFT_EXT = $8CA2;  
  GL_CLIP_ORIGIN_EXT = $935C;  
  GL_CLIP_DEPTH_MODE_EXT = $935D;  
  GL_NEGATIVE_ONE_TO_ONE_EXT = $935E;  
  GL_ZERO_TO_ONE_EXT = $935F;  
type
  TPFNGLCLIPCONTROLEXTPROC = procedure (origin:TGLenum; depth:TGLenum);cdecl;


{ ----------------------- GL_EXT_clip_cull_distance -----------------------  }

const
  GL_EXT_clip_cull_distance = 1;  
  GL_MAX_CLIP_DISTANCES_EXT = $0D32;  
  GL_CLIP_DISTANCE0_EXT = $3000;  
  GL_CLIP_DISTANCE1_EXT = $3001;  
  GL_CLIP_DISTANCE2_EXT = $3002;  
  GL_CLIP_DISTANCE3_EXT = $3003;  
  GL_CLIP_DISTANCE4_EXT = $3004;  
  GL_CLIP_DISTANCE5_EXT = $3005;  
  GL_CLIP_DISTANCE6_EXT = $3006;  
  GL_CLIP_DISTANCE7_EXT = $3007;  
  GL_MAX_CULL_DISTANCES_EXT = $82F9;  
  GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES_EXT = $82FA;  


{ ------------------------ GL_EXT_clip_volume_hint ------------------------  }

const
  GL_EXT_clip_volume_hint = 1;  
  GL_CLIP_VOLUME_CLIPPING_HINT_EXT = $80F0;  


{ ------------------------------ GL_EXT_cmyka -----------------------------  }

const
  GL_EXT_cmyka = 1;  
  GL_CMYK_EXT = $800C;  
  GL_CMYKA_EXT = $800D;  
  GL_PACK_CMYK_HINT_EXT = $800E;  
  GL_UNPACK_CMYK_HINT_EXT = $800F;  


{ ----------------------- GL_EXT_color_buffer_float -----------------------  }

const
  GL_EXT_color_buffer_float = 1;  


{ --------------------- GL_EXT_color_buffer_half_float --------------------  }

const
  GL_EXT_color_buffer_half_float = 1;  
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE_EXT = $8211;  
  GL_R16F_EXT = $822D;  
  GL_RG16F_EXT = $822F;  
  GL_RGBA16F_EXT = $881A;  
  GL_RGB16F_EXT = $881B;  
  GL_UNSIGNED_NORMALIZED_EXT = $8C17;  


{ ------------------------- GL_EXT_color_subtable -------------------------  }

const
  GL_EXT_color_subtable = 1;  
type
 TPFNGLCOLORSUBTABLEEXTPROC = procedure (target:TGLenum; start:TGLsizei; count:TGLsizei; format:TGLenum; _type:TGLenum;                data:pointer);cdecl;
  TPFNGLCOPYCOLORSUBTABLEEXTPROC = procedure (target:TGLenum; start:TGLsizei; x:TGLint; y:TGLint; width:TGLsizei);cdecl;


{ ---------------------- GL_EXT_compiled_vertex_array ---------------------  }

const
  GL_EXT_compiled_vertex_array = 1;  
  GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = $81A8;  
  GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = $81A9;  
type
  TPFNGLLOCKARRAYSEXTPROC = procedure (first:TGLint; count:TGLsizei);cdecl;
  TPFNGLUNLOCKARRAYSEXTPROC = procedure (para1:pointer);cdecl;


{ ---------------- GL_EXT_compressed_ETC1_RGB8_sub_texture ----------------  }

const
  GL_EXT_compressed_ETC1_RGB8_sub_texture = 1;  


{ ----------------------- GL_EXT_conservative_depth -----------------------  }

const
  GL_EXT_conservative_depth = 1;  


{ --------------------------- GL_EXT_convolution --------------------------  }

const
  GL_EXT_convolution = 1;  
  GL_CONVOLUTION_1D_EXT = $8010;  
  GL_CONVOLUTION_2D_EXT = $8011;  
  GL_SEPARABLE_2D_EXT = $8012;  
  GL_CONVOLUTION_BORDER_MODE_EXT = $8013;  
  GL_CONVOLUTION_FILTER_SCALE_EXT = $8014;  
  GL_CONVOLUTION_FILTER_BIAS_EXT = $8015;  
  GL_REDUCE_EXT = $8016;  
  GL_CONVOLUTION_FORMAT_EXT = $8017;  
  GL_CONVOLUTION_WIDTH_EXT = $8018;  
  GL_CONVOLUTION_HEIGHT_EXT = $8019;  
  GL_MAX_CONVOLUTION_WIDTH_EXT = $801A;  
  GL_MAX_CONVOLUTION_HEIGHT_EXT = $801B;  
  GL_POST_CONVOLUTION_RED_SCALE_EXT = $801C;  
  GL_POST_CONVOLUTION_GREEN_SCALE_EXT = $801D;  
  GL_POST_CONVOLUTION_BLUE_SCALE_EXT = $801E;  
  GL_POST_CONVOLUTION_ALPHA_SCALE_EXT = $801F;  
  GL_POST_CONVOLUTION_RED_BIAS_EXT = $8020;  
  GL_POST_CONVOLUTION_GREEN_BIAS_EXT = $8021;  
  GL_POST_CONVOLUTION_BLUE_BIAS_EXT = $8022;  
  GL_POST_CONVOLUTION_ALPHA_BIAS_EXT = $8023;  
type
  TPFNGLCONVOLUTIONFILTER1DEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum;                image:pointer);cdecl;
  TPFNGLCONVOLUTIONFILTER2DEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum;                _type:TGLenum; image:pointer);cdecl;
  TPFNGLCONVOLUTIONPARAMETERFEXTPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLCONVOLUTIONPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLCONVOLUTIONPARAMETERIEXTPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLCONVOLUTIONPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLCOPYCONVOLUTIONFILTER1DEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;
 TPFNGLCOPYCONVOLUTIONFILTER2DEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei;                height:TGLsizei);cdecl;
  TPFNGLGETCONVOLUTIONFILTEREXTPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; image:pointer);cdecl;
  TPFNGLGETCONVOLUTIONPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCONVOLUTIONPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSEPARABLEFILTEREXTPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; row:pointer; column:pointer;                span:pointer);cdecl;
  TPFNGLSEPARABLEFILTER2DEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum;                _type:TGLenum; row:pointer; column:pointer);cdecl;


{ ------------------------ GL_EXT_coordinate_frame ------------------------  }

const
  GL_EXT_coordinate_frame = 1;  
  GL_TANGENT_ARRAY_EXT = $8439;  
  GL_BINORMAL_ARRAY_EXT = $843A;  
  GL_CURRENT_TANGENT_EXT = $843B;  
  GL_CURRENT_BINORMAL_EXT = $843C;  
  GL_TANGENT_ARRAY_TYPE_EXT = $843E;  
  GL_TANGENT_ARRAY_STRIDE_EXT = $843F;  
  GL_BINORMAL_ARRAY_TYPE_EXT = $8440;  
  GL_BINORMAL_ARRAY_STRIDE_EXT = $8441;  
  GL_TANGENT_ARRAY_POINTER_EXT = $8442;  
  GL_BINORMAL_ARRAY_POINTER_EXT = $8443;  
  GL_MAP1_TANGENT_EXT = $8444;  
  GL_MAP2_TANGENT_EXT = $8445;  
  GL_MAP1_BINORMAL_EXT = $8446;  
  GL_MAP2_BINORMAL_EXT = $8447;  
type
  TPFNGLBINORMALPOINTEREXTPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLTANGENTPOINTEREXTPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ --------------------------- GL_EXT_copy_image ---------------------------  }

const
  GL_EXT_copy_image = 1;  
type
  TPFNGLCOPYIMAGESUBDATAEXTPROC = procedure (srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint;
                srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
                dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;


{ -------------------------- GL_EXT_copy_texture --------------------------  }
const
  GL_EXT_copy_texture = 1;  
type
  TPFNGLCOPYTEXIMAGE1DEXTPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; y:TGLint;                width:TGLsizei; border:TGLint);cdecl;
  TPFNGLCOPYTEXIMAGE2DEXTPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; y:TGLint;                width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;
                                                                                                                      TPFNGLCOPYTEXSUBIMAGE1DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint; y:TGLint;                width:TGLsizei);cdecl;
  TPFNGLCOPYTEXSUBIMAGE2DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; x:TGLint;                y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCOPYTEXSUBIMAGE3DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;


{ --------------------------- GL_EXT_cull_vertex --------------------------  }

const
  GL_EXT_cull_vertex = 1;  
  GL_CULL_VERTEX_EXT = $81AA;  
  GL_CULL_VERTEX_EYE_POSITION_EXT = $81AB;  
  GL_CULL_VERTEX_OBJECT_POSITION_EXT = $81AC;  
type
  TPFNGLCULLPARAMETERDVEXTPROC = procedure (pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLCULLPARAMETERFVEXTPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;


{ --------------------------- GL_EXT_debug_label --------------------------  }

const
  GL_EXT_debug_label = 1;  
  GL_PROGRAM_PIPELINE_OBJECT_EXT = $8A4F;  
  GL_PROGRAM_OBJECT_EXT = $8B40;  
  GL_SHADER_OBJECT_EXT = $8B48;  
  GL_BUFFER_OBJECT_EXT = $9151;  
  GL_QUERY_OBJECT_EXT = $9153;  
  GL_VERTEX_ARRAY_OBJECT_EXT = $9154;  
type
  TPFNGLGETOBJECTLABELEXTPROC = procedure (_type:TGLenum; obj:TGLuint; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;
  TPFNGLLABELOBJECTEXTPROC = procedure (_type:TGLenum; obj:TGLuint; length:TGLsizei; _label:PGLchar);cdecl;


{ -------------------------- GL_EXT_debug_marker --------------------------  }

const
  GL_EXT_debug_marker = 1;  
type
  TPFNGLINSERTEVENTMARKEREXTPROC = procedure (length:TGLsizei; marker:PGLchar);cdecl;
  TPFNGLPOPGROUPMARKEREXTPROC = procedure (para1:pointer);cdecl;
  TPFNGLPUSHGROUPMARKEREXTPROC = procedure (length:TGLsizei; marker:PGLchar);cdecl;


{ ------------------------ GL_EXT_depth_bounds_test -----------------------  }

const
  GL_EXT_depth_bounds_test = 1;  
  GL_DEPTH_BOUNDS_TEST_EXT = $8890;  
  GL_DEPTH_BOUNDS_EXT = $8891;  
type
  TPFNGLDEPTHBOUNDSEXTPROC = procedure (zmin:TGLclampd; zmax:TGLclampd);cdecl;


{ --------------------------- GL_EXT_depth_clamp --------------------------  }

const
  GL_EXT_depth_clamp = 1;  
  GL_DEPTH_CLAMP_EXT = $864F;  


{ ----------------------- GL_EXT_direct_state_access ----------------------  }

const
  GL_EXT_direct_state_access = 1;  
  GL_PROGRAM_MATRIX_EXT = $8E2D;  
  GL_TRANSPOSE_PROGRAM_MATRIX_EXT = $8E2E;  
  GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = $8E2F;  
type
  TPFNGLBINDMULTITEXTUREEXTPROC = procedure (texunit:TGLenum; target:TGLenum; texture:TGLuint);cdecl;
  TPFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC = function (framebuffer:TGLuint; target:TGLenum):TGLenum;cdecl;
  TPFNGLCLIENTATTRIBDEFAULTEXTPROC = procedure (mask:TGLbitfield);cdecl;
  TPFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei;
                format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                width:TGLsizei; height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei;
                format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                width:TGLsizei; height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
              zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum;
                imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOPYMULTITEXIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint;
                y:TGLint; width:TGLsizei; border:TGLint);cdecl;
  TPFNGLCOPYMULTITEXIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint;
                y:TGLint; width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;
  TPFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint;
                y:TGLint; width:TGLsizei);cdecl;
  TPFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                zoffset:TGLint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCOPYTEXTUREIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint;
                y:TGLint; width:TGLsizei; border:TGLint);cdecl;
  TPFNGLCOPYTEXTUREIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint;
                y:TGLint; width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint;
                y:TGLint; width:TGLsizei);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLCOPYTEXTURESUBIMAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                zoffset:TGLint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLDISABLECLIENTSTATEINDEXEDEXTPROC = procedure (arr:TGLenum; index:TGLuint);cdecl;
  TPFNGLDISABLECLIENTSTATEIEXTPROC = procedure (arr:TGLenum; index:TGLuint);cdecl;
  TPFNGLDISABLEVERTEXARRAYATTRIBEXTPROC = procedure (vaobj:TGLuint; index:TGLuint);cdecl;
  TPFNGLDISABLEVERTEXARRAYEXTPROC = procedure (vaobj:TGLuint; arr:TGLenum);cdecl;
  TPFNGLENABLECLIENTSTATEINDEXEDEXTPROC = procedure (arr:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLECLIENTSTATEIEXTPROC = procedure (arr:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEVERTEXARRAYATTRIBEXTPROC = procedure (vaobj:TGLuint; index:TGLuint);cdecl;
  TPFNGLENABLEVERTEXARRAYEXTPROC = procedure (vaobj:TGLuint; arr:TGLenum);cdecl;
  TPFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC = procedure (buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;
  TPFNGLFRAMEBUFFERDRAWBUFFEREXTPROC = procedure (framebuffer:TGLuint; mode:TGLenum);cdecl;
  TPFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC = procedure (framebuffer:TGLuint; n:TGLsizei; bufs:PGLenum);cdecl;
  TPFNGLFRAMEBUFFERREADBUFFEREXTPROC = procedure (framebuffer:TGLuint; mode:TGLenum);cdecl;
  TPFNGLGENERATEMULTITEXMIPMAPEXTPROC = procedure (texunit:TGLenum; target:TGLenum);cdecl;
  TPFNGLGENERATETEXTUREMIPMAPEXTPROC = procedure (texture:TGLuint; target:TGLenum);cdecl;
  TPFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; img:pointer);cdecl;
  TPFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; img:pointer);cdecl;
  TPFNGLGETDOUBLEINDEXEDVEXTPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLGETDOUBLEI_VEXTPROC = procedure (pname:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLGETFLOATINDEXEDVEXTPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGETFLOATI_VEXTPROC = procedure (pname:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC = procedure (framebuffer:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETMULTITEXENVFVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMULTITEXENVIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMULTITEXGENDVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETMULTITEXGENFVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMULTITEXGENIVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMULTITEXIMAGEEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum;                pixels:pointer);cdecl;
  TPFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMULTITEXPARAMETERIIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMULTITEXPARAMETERIUIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETMULTITEXPARAMETERFVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMULTITEXPARAMETERIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDBUFFERPOINTERVEXTPROC = procedure (buffer:TGLuint; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLGETNAMEDBUFFERSUBDATAEXTPROC = procedure (buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLint);cdecl;
  TPFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLuint);cdecl;
  TPFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGETNAMEDPROGRAMSTRINGEXTPROC = procedure (prog:TGLuint; target:TGLenum; pname:TGLenum; _string:pointer);cdecl;
  TPFNGLGETNAMEDPROGRAMIVEXTPROC = procedure (prog:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC = procedure (renderbuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETPOINTERINDEXEDVEXTPROC = procedure (target:TGLenum; index:TGLuint; params:Ppointer);cdecl;
  TPFNGLGETPOINTERI_VEXTPROC = procedure (pname:TGLenum; index:TGLuint; params:Ppointer);cdecl;
  TPFNGLGETTEXTUREIMAGEEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum;                pixels:pointer);cdecl;
  TPFNGLGETTEXTURELEVELPARAMETERFVEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETTEXTURELEVELPARAMETERIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXTUREPARAMETERIIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXTUREPARAMETERIUIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETTEXTUREPARAMETERFVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETTEXTUREPARAMETERIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVERTEXARRAYINTEGERI_VEXTPROC = procedure (vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETVERTEXARRAYINTEGERVEXTPROC = procedure (vaobj:TGLuint; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLGETVERTEXARRAYPOINTERI_VEXTPROC = procedure (vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:Ppointer);cdecl;
  TPFNGLGETVERTEXARRAYPOINTERVEXTPROC = procedure (vaobj:TGLuint; pname:TGLenum; param:Ppointer);cdecl;
  TPFNGLMAPNAMEDBUFFEREXTPROC = function (buffer:TGLuint; access:TGLenum):pointer;cdecl;
  TPFNGLMAPNAMEDBUFFERRANGEEXTPROC = function (buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;
  TPFNGLMATRIXFRUSTUMEXTPROC = procedure (matrixMode:TGLenum; l:TGLdouble; r:TGLdouble; b:TGLdouble; t:TGLdouble;                n:TGLdouble; f:TGLdouble);cdecl;
  TPFNGLMATRIXLOADIDENTITYEXTPROC = procedure (matrixMode:TGLenum);cdecl;
  TPFNGLMATRIXLOADTRANSPOSEDEXTPROC = procedure (matrixMode:TGLenum; m:PGLdouble);cdecl;
  TPFNGLMATRIXLOADTRANSPOSEFEXTPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXLOADDEXTPROC = procedure (matrixMode:TGLenum; m:PGLdouble);cdecl;
  TPFNGLMATRIXLOADFEXTPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXMULTTRANSPOSEDEXTPROC = procedure (matrixMode:TGLenum; m:PGLdouble);cdecl;
  TPFNGLMATRIXMULTTRANSPOSEFEXTPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXMULTDEXTPROC = procedure (matrixMode:TGLenum; m:PGLdouble);cdecl;
  TPFNGLMATRIXMULTFEXTPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXORTHOEXTPROC = procedure (matrixMode:TGLenum; l:TGLdouble; r:TGLdouble; b:TGLdouble; t:TGLdouble;                n:TGLdouble; f:TGLdouble);cdecl;
  TPFNGLMATRIXPOPEXTPROC = procedure (matrixMode:TGLenum);cdecl;
  TPFNGLMATRIXPUSHEXTPROC = procedure (matrixMode:TGLenum);cdecl;
  TPFNGLMATRIXROTATEDEXTPROC = procedure (matrixMode:TGLenum; angle:TGLdouble; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLMATRIXROTATEFEXTPROC = procedure (matrixMode:TGLenum; angle:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLMATRIXSCALEDEXTPROC = procedure (matrixMode:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLMATRIXSCALEFEXTPROC = procedure (matrixMode:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLMATRIXTRANSLATEDEXTPROC = procedure (matrixMode:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLMATRIXTRANSLATEFEXTPROC = procedure (matrixMode:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLMULTITEXBUFFEREXTPROC = procedure (texunit:TGLenum; target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLMULTITEXCOORDPOINTEREXTPROC = procedure (texunit:TGLenum; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLMULTITEXENVFEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLMULTITEXENVFVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLMULTITEXENVIEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLMULTITEXENVIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLMULTITEXGENDEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLdouble);cdecl;
  TPFNGLMULTITEXGENDVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLMULTITEXGENFEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLMULTITEXGENFVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLMULTITEXGENIEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLMULTITEXGENIVEXTPROC = procedure (texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLMULTITEXIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLMULTITEXIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                height:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLMULTITEXIMAGE3DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;
  TPFNGLMULTITEXPARAMETERIIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLMULTITEXPARAMETERIUIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLMULTITEXPARAMETERFEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLMULTITEXPARAMETERFVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:PGLfloat);cdecl;
  TPFNGLMULTITEXPARAMETERIEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLMULTITEXPARAMETERIVEXTPROC = procedure (texunit:TGLenum; target:TGLenum; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLMULTITEXRENDERBUFFEREXTPROC = procedure (texunit:TGLenum; target:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLMULTITEXSUBIMAGE1DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei;
                format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLMULTITEXSUBIMAGE2DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                width:TGLsizei; height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLMULTITEXSUBIMAGE3DEXTPROC = procedure (texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
                _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLNAMEDBUFFERDATAEXTPROC = procedure (buffer:TGLuint; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;
  TPFNGLNAMEDBUFFERSUBDATAEXTPROC = procedure (buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC = procedure (readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;                zoffset:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble;                z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat;                 z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; x:TGLint; y:TGLint;                z:TGLint; w:TGLint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint;                z:TGLuint; w:TGLuint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; params:PGLuint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;
  TPFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC = procedure (prog:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;
  TPFNGLNAMEDPROGRAMSTRINGEXTPROC = procedure (prog:TGLuint; target:TGLenum; format:TGLenum; len:TGLsizei; _string:pointer);cdecl;
  TPFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC = procedure (renderbuffer:TGLuint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC = procedure (renderbuffer:TGLuint; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei;                height:TGLsizei);cdecl;
  TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC = procedure (renderbuffer:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLPROGRAMUNIFORM1FEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM1FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM1IEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM1IVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM1UIEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM1UIVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM2FEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM2FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM2IEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLint; v1:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM2IVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM2UIEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM2UIVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM3FEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM3FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM3IEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM3IVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM3UIEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM3UIVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM4FEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat;                v3:TGLfloat);cdecl;
                                                                                                                    TPFNGLPROGRAMUNIFORM4FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORM4IEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint;                v3:TGLint);cdecl;
  TPFNGLPROGRAMUNIFORM4IVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;
  TPFNGLPROGRAMUNIFORM4UIEXTPROC = procedure (prog:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint;                v3:TGLuint);cdecl;
  TPFNGLPROGRAMUNIFORM4UIVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC = procedure (mask:TGLbitfield);cdecl;
  TPFNGLTEXTUREBUFFEREXTPROC = procedure (texture:TGLuint; target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLTEXTUREIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTUREIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                height:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTUREIMAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;
  TPFNGLTEXTUREPARAMETERIIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXTUREPARAMETERIUIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLTEXTUREPARAMETERFEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLTEXTUREPARAMETERFVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; param:PGLfloat);cdecl;
  TPFNGLTEXTUREPARAMETERIEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLTEXTUREPARAMETERIVEXTPROC = procedure (texture:TGLuint; target:TGLenum; pname:TGLenum; param:PGLint);cdecl;
  TPFNGLTEXTURERENDERBUFFEREXTPROC = procedure (texture:TGLuint; target:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLTEXTURESUBIMAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei;
                format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTURESUBIMAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                width:TGLsizei; height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXTURESUBIMAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint;
                zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
                _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLUNMAPNAMEDBUFFEREXTPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLVERTEXARRAYCOLOROFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei;                offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYINDEXOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; texunit:TGLenum; size:TGLint; _type:TGLenum;                stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYNORMALOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei;                offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei;                offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC = procedure (vaobj:TGLuint; index:TGLuint; divisor:TGLuint);cdecl;
    TPFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum;                stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum;
                normalized:TGLboolean; stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXARRAYVERTEXOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei;                offset:TGLintptr);cdecl;


{ ----------------------- GL_EXT_discard_framebuffer ----------------------  }

const
  GL_EXT_discard_framebuffer = 1;  
  GL_COLOR_EXT = $1800;  
  GL_DEPTH_EXT = $1801;  
  GL_STENCIL_EXT = $1802;  
type
  TPFNGLDISCARDFRAMEBUFFEREXTPROC = procedure (target:TGLenum; numAttachments:TGLsizei; attachments:PGLenum);cdecl;


{ ---------------------- GL_EXT_disjoint_timer_query ----------------------  }

const
  GL_EXT_disjoint_timer_query = 1;  
  GL_QUERY_COUNTER_BITS_EXT = $8864;  
  GL_CURRENT_QUERY_EXT = $8865;  
  GL_QUERY_RESULT_EXT = $8866;  
  GL_QUERY_RESULT_AVAILABLE_EXT = $8867;  
  GL_TIME_ELAPSED_EXT = $88BF;  
  GL_TIMESTAMP_EXT = $8E28;  
  GL_GPU_DISJOINT_EXT = $8FBB;  
type
  TPFNGLBEGINQUERYEXTPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETEQUERIESEXTPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLENDQUERYEXTPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGENQUERIESEXTPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETINTEGER64VEXTPROC = procedure (pname:TGLenum; data:PGLint64);cdecl;
  TPFNGLGETQUERYOBJECTIVEXTPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETQUERYOBJECTUIVEXTPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETQUERYIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISQUERYEXTPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLQUERYCOUNTEREXTPROC = procedure (id:TGLuint; target:TGLenum);cdecl;


{ -------------------------- GL_EXT_draw_buffers --------------------------  }

const
  GL_EXT_draw_buffers = 1;  
  GL_MAX_DRAW_BUFFERS_EXT = $8824;  
  GL_DRAW_BUFFER0_EXT = $8825;  
  GL_DRAW_BUFFER1_EXT = $8826;  
  GL_DRAW_BUFFER2_EXT = $8827;  
  GL_DRAW_BUFFER3_EXT = $8828;  
  GL_DRAW_BUFFER4_EXT = $8829;  
  GL_DRAW_BUFFER5_EXT = $882A;  
  GL_DRAW_BUFFER6_EXT = $882B;  
  GL_DRAW_BUFFER7_EXT = $882C;  
  GL_DRAW_BUFFER8_EXT = $882D;  
  GL_DRAW_BUFFER9_EXT = $882E;  
  GL_DRAW_BUFFER10_EXT = $882F;  
  GL_DRAW_BUFFER11_EXT = $8830;  
  GL_DRAW_BUFFER12_EXT = $8831;  
  GL_DRAW_BUFFER13_EXT = $8832;  
  GL_DRAW_BUFFER14_EXT = $8833;  
  GL_DRAW_BUFFER15_EXT = $8834;  
  GL_MAX_COLOR_ATTACHMENTS_EXT = $8CDF;  
  GL_COLOR_ATTACHMENT0_EXT = $8CE0;  
  GL_COLOR_ATTACHMENT1_EXT = $8CE1;  
  GL_COLOR_ATTACHMENT2_EXT = $8CE2;  
  GL_COLOR_ATTACHMENT3_EXT = $8CE3;  
  GL_COLOR_ATTACHMENT4_EXT = $8CE4;  
  GL_COLOR_ATTACHMENT5_EXT = $8CE5;  
  GL_COLOR_ATTACHMENT6_EXT = $8CE6;  
  GL_COLOR_ATTACHMENT7_EXT = $8CE7;  
  GL_COLOR_ATTACHMENT8_EXT = $8CE8;  
  GL_COLOR_ATTACHMENT9_EXT = $8CE9;  
  GL_COLOR_ATTACHMENT10_EXT = $8CEA;  
  GL_COLOR_ATTACHMENT11_EXT = $8CEB;  
  GL_COLOR_ATTACHMENT12_EXT = $8CEC;  
  GL_COLOR_ATTACHMENT13_EXT = $8CED;  
  GL_COLOR_ATTACHMENT14_EXT = $8CEE;  
  GL_COLOR_ATTACHMENT15_EXT = $8CEF;  
type
  TPFNGLDRAWBUFFERSEXTPROC = procedure (n:TGLsizei; bufs:PGLenum);cdecl;


{ -------------------------- GL_EXT_draw_buffers2 -------------------------  }

const
  GL_EXT_draw_buffers2 = 1;  
type
  TPFNGLCOLORMASKINDEXEDEXTPROC = procedure (buf:TGLuint; r:TGLboolean; g:TGLboolean; b:TGLboolean; a:TGLboolean);cdecl;
  TPFNGLDISABLEINDEXEDEXTPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEINDEXEDEXTPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLGETBOOLEANINDEXEDVEXTPROC = procedure (value:TGLenum; index:TGLuint; data:PGLboolean);cdecl;
  TPFNGLGETINTEGERINDEXEDVEXTPROC = procedure (value:TGLenum; index:TGLuint; data:PGLint);cdecl;
  TPFNGLISENABLEDINDEXEDEXTPROC = function (target:TGLenum; index:TGLuint):TGLboolean;cdecl;


{ ---------------------- GL_EXT_draw_buffers_indexed ----------------------  }

const
  GL_EXT_draw_buffers_indexed = 1;  
type
  TPFNGLBLENDEQUATIONSEPARATEIEXTPROC = procedure (buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLBLENDEQUATIONIEXTPROC = procedure (buf:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEIEXTPROC = procedure (buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;
  TPFNGLBLENDFUNCIEXTPROC = procedure (buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;
  TPFNGLCOLORMASKIEXTPROC = procedure (buf:TGLuint; r:TGLboolean; g:TGLboolean; b:TGLboolean; a:TGLboolean);cdecl;
  TPFNGLDISABLEIEXTPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEIEXTPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLISENABLEDIEXTPROC = function (target:TGLenum; index:TGLuint):TGLboolean;cdecl;


{ -------------------- GL_EXT_draw_elements_base_vertex -------------------  }

const
  GL_EXT_draw_elements_base_vertex = 1;  
type
  TPFNGLDRAWELEMENTSBASEVERTEXEXTPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; basevertex:TGLint);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXEXTPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei;                basevertex:TGLint);cdecl;
  TPFNGLDRAWRANGEELEMENTSBASEVERTEXEXTPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum;                indices:pointer; basevertex:TGLint);cdecl;
  TPFNGLMULTIDRAWELEMENTSBASEVERTEXEXTPROC = procedure (mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; primcount:TGLsizei;                basevertex:PGLint);cdecl;


{ ------------------------- GL_EXT_draw_instanced -------------------------  }

const
  GL_EXT_draw_instanced = 1;  
type
  TPFNGLDRAWARRAYSINSTANCEDEXTPROC = procedure (mode:TGLenum; start:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDEXTPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;


{ ----------------------- GL_EXT_draw_range_elements ----------------------  }

const
  GL_EXT_draw_range_elements = 1;  
  GL_MAX_ELEMENTS_VERTICES_EXT = $80E8;  
  GL_MAX_ELEMENTS_INDICES_EXT = $80E9;  
type
  TPFNGLDRAWRANGEELEMENTSEXTPROC = procedure (mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum;                indices:pointer);cdecl;


{ --------------------- GL_EXT_draw_transform_feedback --------------------  }

const
  GL_EXT_draw_transform_feedback = 1;  
type
  TPFNGLDRAWTRANSFORMFEEDBACKEXTPROC = procedure (mode:TGLenum; id:TGLuint);cdecl;
  TPFNGLDRAWTRANSFORMFEEDBACKINSTANCEDEXTPROC = procedure (mode:TGLenum; id:TGLuint; instancecount:TGLsizei);cdecl;


{ ------------------------- GL_EXT_external_buffer ------------------------  }

const
  GL_EXT_external_buffer = 1;  
type
  PGLeglClientBufferEXT = ^TGLeglClientBufferEXT;
  TGLeglClientBufferEXT = pointer;

  TPFNGLBUFFERSTORAGEEXTERNALEXTPROC = procedure (target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; clientBuffer:TGLeglClientBufferEXT; flags:TGLbitfield);cdecl;
  TPFNGLNAMEDBUFFERSTORAGEEXTERNALEXTPROC = procedure (buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; clientBuffer:TGLeglClientBufferEXT; flags:TGLbitfield);cdecl;


{ --------------------------- GL_EXT_float_blend --------------------------  }

const
  GL_EXT_float_blend = 1;  


{ ---------------------------- GL_EXT_fog_coord ---------------------------  }

const
  GL_EXT_fog_coord = 1;  
  GL_FOG_COORDINATE_SOURCE_EXT = $8450;  
  GL_FOG_COORDINATE_EXT = $8451;  
  GL_FRAGMENT_DEPTH_EXT = $8452;  
  GL_CURRENT_FOG_COORDINATE_EXT = $8453;  
  GL_FOG_COORDINATE_ARRAY_TYPE_EXT = $8454;  
  GL_FOG_COORDINATE_ARRAY_STRIDE_EXT = $8455;  
  GL_FOG_COORDINATE_ARRAY_POINTER_EXT = $8456;  
  GL_FOG_COORDINATE_ARRAY_EXT = $8457;  
type
  TPFNGLFOGCOORDPOINTEREXTPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLFOGCOORDDEXTPROC = procedure (coord:TGLdouble);cdecl;
  TPFNGLFOGCOORDDVEXTPROC = procedure (coord:PGLdouble);cdecl;
  TPFNGLFOGCOORDFEXTPROC = procedure (coord:TGLfloat);cdecl;
  TPFNGLFOGCOORDFVEXTPROC = procedure (coord:PGLfloat);cdecl;


{ --------------------------- GL_EXT_frag_depth ---------------------------  }

const
  GL_EXT_frag_depth = 1;  


{ ------------------------ GL_EXT_fragment_lighting -----------------------  }

const
  GL_EXT_fragment_lighting = 1;  
  GL_FRAGMENT_LIGHTING_EXT = $8400;  
  GL_FRAGMENT_COLOR_MATERIAL_EXT = $8401;  
  GL_FRAGMENT_COLOR_MATERIAL_FACE_EXT = $8402;  
  GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_EXT = $8403;  
  GL_MAX_FRAGMENT_LIGHTS_EXT = $8404;  
  GL_MAX_ACTIVE_LIGHTS_EXT = $8405;  
  GL_CURRENT_RASTER_NORMAL_EXT = $8406;  
  GL_LIGHT_ENV_MODE_EXT = $8407;  
  GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_EXT = $8408;  
  GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_EXT = $8409;  
  GL_FRAGMENT_LIGHT_MODEL_AMBIENT_EXT = $840A;  
  GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_EXT = $840B;  
  GL_FRAGMENT_LIGHT0_EXT = $840C;  
  GL_FRAGMENT_LIGHT7_EXT = $8413;  
type
  TPFNGLFRAGMENTCOLORMATERIALEXTPROC = procedure (face:TGLenum; mode:TGLenum);cdecl;
  TPFNGLFRAGMENTLIGHTMODELFEXTPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTMODELFVEXTPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTMODELIEXTPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTLIGHTMODELIVEXTPROC = procedure (pname:TGLenum; params:PGLint);cdecl;
  TPFNGLFRAGMENTLIGHTFEXTPROC = procedure (light:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTFVEXTPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTIEXTPROC = procedure (light:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTLIGHTIVEXTPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLFRAGMENTMATERIALFEXTPROC = procedure (face:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTMATERIALFVEXTPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTMATERIALIEXTPROC = procedure (face:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTMATERIALIVEXTPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETFRAGMENTLIGHTFVEXTPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETFRAGMENTLIGHTIVEXTPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETFRAGMENTMATERIALFVEXTPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETFRAGMENTMATERIALIVEXTPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLLIGHTENVIEXTPROC = procedure (pname:TGLenum; param:TGLint);cdecl;


{ ------------------------ GL_EXT_framebuffer_blit ------------------------  }

const
  GL_EXT_framebuffer_blit = 1;  
  GL_DRAW_FRAMEBUFFER_BINDING_EXT = $8CA6;  
  GL_READ_FRAMEBUFFER_EXT = $8CA8;  
  GL_DRAW_FRAMEBUFFER_EXT = $8CA9;  
  GL_READ_FRAMEBUFFER_BINDING_EXT = $8CAA;  
type
  TPFNGLBLITFRAMEBUFFEREXTPROC = procedure (srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint;
                dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;


{ --------------------- GL_EXT_framebuffer_multisample --------------------  }

const
  GL_EXT_framebuffer_multisample = 1;  
  GL_RENDERBUFFER_SAMPLES_EXT = $8CAB;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = $8D56;  
  GL_MAX_SAMPLES_EXT = $8D57;  
type
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ --------------- GL_EXT_framebuffer_multisample_blit_scaled --------------  }

const
  GL_EXT_framebuffer_multisample_blit_scaled = 1;  
  GL_SCALED_RESOLVE_FASTEST_EXT = $90BA;  
  GL_SCALED_RESOLVE_NICEST_EXT = $90BB;  


{ ----------------------- GL_EXT_framebuffer_object -----------------------  }

const
  GL_EXT_framebuffer_object = 1;  
  GL_INVALID_FRAMEBUFFER_OPERATION_EXT = $0506;  
  GL_MAX_RENDERBUFFER_SIZE_EXT = $84E8;  
  GL_FRAMEBUFFER_BINDING_EXT = $8CA6;  
  GL_RENDERBUFFER_BINDING_EXT = $8CA7;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = $8CD0;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = $8CD1;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = $8CD2;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = $8CD3;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = $8CD4;  
  GL_FRAMEBUFFER_COMPLETE_EXT = $8CD5;  
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = $8CD6;  
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = $8CD7;  
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = $8CD9;  
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = $8CDA;  
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = $8CDB;  
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = $8CDC;  
  GL_FRAMEBUFFER_UNSUPPORTED_EXT = $8CDD;  
  //GL_MAX_COLOR_ATTACHMENTS_EXT = $8CDF;  doppelt
  //GL_COLOR_ATTACHMENT0_EXT = $8CE0;  
  //GL_COLOR_ATTACHMENT1_EXT = $8CE1;  
  //GL_COLOR_ATTACHMENT2_EXT = $8CE2;  
  //GL_COLOR_ATTACHMENT3_EXT = $8CE3;  
  //GL_COLOR_ATTACHMENT4_EXT = $8CE4;  
  //GL_COLOR_ATTACHMENT5_EXT = $8CE5;  
  //GL_COLOR_ATTACHMENT6_EXT = $8CE6;  
  //GL_COLOR_ATTACHMENT7_EXT = $8CE7;  
  //GL_COLOR_ATTACHMENT8_EXT = $8CE8;  
  //GL_COLOR_ATTACHMENT9_EXT = $8CE9;  
  //GL_COLOR_ATTACHMENT10_EXT = $8CEA;  
  //GL_COLOR_ATTACHMENT11_EXT = $8CEB;  
  //GL_COLOR_ATTACHMENT12_EXT = $8CEC;  
  //GL_COLOR_ATTACHMENT13_EXT = $8CED;  
  //GL_COLOR_ATTACHMENT14_EXT = $8CEE;  
  //GL_COLOR_ATTACHMENT15_EXT = $8CEF;  
  GL_DEPTH_ATTACHMENT_EXT = $8D00;  
  GL_STENCIL_ATTACHMENT_EXT = $8D20;  
  GL_FRAMEBUFFER_EXT = $8D40;  
  GL_RENDERBUFFER_EXT = $8D41;  
  GL_RENDERBUFFER_WIDTH_EXT = $8D42;  
  GL_RENDERBUFFER_HEIGHT_EXT = $8D43;  
  GL_RENDERBUFFER_INTERNAL_FORMAT_EXT = $8D44;  
  GL_STENCIL_INDEX1_EXT = $8D46;  
  GL_STENCIL_INDEX4_EXT = $8D47;  
  GL_STENCIL_INDEX8_EXT = $8D48;  
  GL_STENCIL_INDEX16_EXT = $8D49;  
  GL_RENDERBUFFER_RED_SIZE_EXT = $8D50;  
  GL_RENDERBUFFER_GREEN_SIZE_EXT = $8D51;  
  GL_RENDERBUFFER_BLUE_SIZE_EXT = $8D52;  
  GL_RENDERBUFFER_ALPHA_SIZE_EXT = $8D53;  
  GL_RENDERBUFFER_DEPTH_SIZE_EXT = $8D54;  
  GL_RENDERBUFFER_STENCIL_SIZE_EXT = $8D55;  
type
  TPFNGLBINDFRAMEBUFFEREXTPROC = procedure (target:TGLenum; framebuffer:TGLuint);cdecl;
  TPFNGLBINDRENDERBUFFEREXTPROC = procedure (target:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLCHECKFRAMEBUFFERSTATUSEXTPROC = function (target:TGLenum):TGLenum;cdecl;
  TPFNGLDELETEFRAMEBUFFERSEXTPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLDELETERENDERBUFFERSEXTPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLFRAMEBUFFERRENDERBUFFEREXTPROC = procedure (target:TGLenum; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE1DEXTPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE2DEXTPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE3DEXTPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;                zoffset:TGLint);cdecl;
  TPFNGLGENFRAMEBUFFERSEXTPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLGENRENDERBUFFERSEXTPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLGENERATEMIPMAPEXTPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC = procedure (target:TGLenum; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETRENDERBUFFERPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISFRAMEBUFFEREXTPROC = function (framebuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLISRENDERBUFFEREXTPROC = function (renderbuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLRENDERBUFFERSTORAGEEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ------------------------ GL_EXT_framebuffer_sRGB ------------------------  }

const
  GL_EXT_framebuffer_sRGB = 1;  
  GL_FRAMEBUFFER_SRGB_EXT = $8DB9;  
  GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $8DBA;  


{ ----------------------- GL_EXT_geometry_point_size ----------------------  }

const
  GL_EXT_geometry_point_size = 1;  
  GL_GEOMETRY_SHADER_BIT_EXT = $00000004;  
  GL_LINES_ADJACENCY_EXT = $A;  
  GL_LINE_STRIP_ADJACENCY_EXT = $B;  
  GL_TRIANGLES_ADJACENCY_EXT = $C;  
  GL_TRIANGLE_STRIP_ADJACENCY_EXT = $D;  
  GL_LAYER_PROVOKING_VERTEX_EXT = $825E;  
  GL_UNDEFINED_VERTEX_EXT = $8260;  
  GL_GEOMETRY_SHADER_INVOCATIONS_EXT = $887F;  
  GL_GEOMETRY_LINKED_VERTICES_OUT_EXT = $8916;  
  GL_GEOMETRY_LINKED_INPUT_TYPE_EXT = $8917;  
  GL_GEOMETRY_LINKED_OUTPUT_TYPE_EXT = $8918;  
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS_EXT = $8A2C;  
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8A32;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;  
  GL_PRIMITIVES_GENERATED_EXT = $8C87;  
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;  
  GL_GEOMETRY_SHADER_EXT = $8DD9;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;  
  GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;  
  GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;  
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS_EXT = $8E5A;  
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT = $90CD;  
  GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT = $90D7;  
  GL_MAX_GEOMETRY_INPUT_COMPONENTS_EXT = $9123;  
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_EXT = $9124;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT = $92CF;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT = $92D5;  
  GL_REFERENCED_BY_GEOMETRY_SHADER_EXT = $9309;  
  GL_FRAMEBUFFER_DEFAULT_LAYERS_EXT = $9312;  
  GL_MAX_FRAMEBUFFER_LAYERS_EXT = $9317;  


{ ------------------------- GL_EXT_geometry_shader ------------------------  }

const
  GL_EXT_geometry_shader = 1;  
  //GL_GEOMETRY_SHADER_BIT_EXT = $00000004;        doppelt
  //GL_LINES_ADJACENCY_EXT = $A;  
  //GL_LINE_STRIP_ADJACENCY_EXT = $B;  
  //GL_TRIANGLES_ADJACENCY_EXT = $C;  
  //GL_TRIANGLE_STRIP_ADJACENCY_EXT = $D;  
  //GL_LAYER_PROVOKING_VERTEX_EXT = $825E;  
  //GL_UNDEFINED_VERTEX_EXT = $8260;  
  //GL_GEOMETRY_SHADER_INVOCATIONS_EXT = $887F;  
  //GL_GEOMETRY_LINKED_VERTICES_OUT_EXT = $8916;  
  //GL_GEOMETRY_LINKED_INPUT_TYPE_EXT = $8917;  
  //GL_GEOMETRY_LINKED_OUTPUT_TYPE_EXT = $8918;  
  //GL_MAX_GEOMETRY_UNIFORM_BLOCKS_EXT = $8A2C;  
  //GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8A32;  
  //GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;  
  //GL_PRIMITIVES_GENERATED_EXT = $8C87;  
  //GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;  
  //GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;  
  //GL_GEOMETRY_SHADER_EXT = $8DD9;  
  //GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;  
  //GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;  
  //GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;  
  //GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;  
  //GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;  
  //GL_MAX_GEOMETRY_SHADER_INVOCATIONS_EXT = $8E5A;  
  //GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT = $90CD;  
  //GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT = $90D7;  
  //GL_MAX_GEOMETRY_INPUT_COMPONENTS_EXT = $9123;  
  //GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_EXT = $9124;  
  //GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT = $92CF;  
  //GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT = $92D5;  
  //GL_REFERENCED_BY_GEOMETRY_SHADER_EXT = $9309;  
  //GL_FRAMEBUFFER_DEFAULT_LAYERS_EXT = $9312;  
  //GL_MAX_FRAMEBUFFER_LAYERS_EXT = $9317;  


{ ------------------------ GL_EXT_geometry_shader4 ------------------------  }

const
  GL_EXT_geometry_shader4 = 1;  
//  GL_LINES_ADJACENCY_EXT = $A;   doppelt
//  GL_LINE_STRIP_ADJACENCY_EXT = $B;  
//  GL_TRIANGLES_ADJACENCY_EXT = $C;
//  GL_TRIANGLE_STRIP_ADJACENCY_EXT = $D;  
  GL_PROGRAM_POINT_SIZE_EXT = $8642;  
  GL_MAX_VARYING_COMPONENTS_EXT = $8B4B;  
//  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = $8CD4;  
//  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;  
//  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = $8DA9;  
//  GL_GEOMETRY_SHADER_EXT = $8DD9;  
  GL_GEOMETRY_VERTICES_OUT_EXT = $8DDA;  
  GL_GEOMETRY_INPUT_TYPE_EXT = $8DDB;  
  GL_GEOMETRY_OUTPUT_TYPE_EXT = $8DDC;  
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = $8DDD;  
  GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = $8DDE;  
//  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;  
//  GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;  
//  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;  
type
  TPFNGLFRAMEBUFFERTEXTUREEXTPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTUREFACEEXTPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;
  TPFNGLPROGRAMPARAMETERIEXTPROC = procedure (prog:TGLuint; pname:TGLenum; value:TGLint);cdecl;


{ --------------------- GL_EXT_gpu_program_parameters ---------------------  }

const
  GL_EXT_gpu_program_parameters = 1;  
type
  TPFNGLPROGRAMENVPARAMETERS4FVEXTPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;


{ --------------------------- GL_EXT_gpu_shader4 --------------------------  }

const
  GL_EXT_gpu_shader4 = 1;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = $88FD;  
  GL_SAMPLER_1D_ARRAY_EXT = $8DC0;  
  GL_SAMPLER_2D_ARRAY_EXT = $8DC1;  
  GL_SAMPLER_BUFFER_EXT = $8DC2;  
  GL_SAMPLER_1D_ARRAY_SHADOW_EXT = $8DC3;  
  GL_SAMPLER_2D_ARRAY_SHADOW_EXT = $8DC4;  
  GL_SAMPLER_CUBE_SHADOW_EXT = $8DC5;  
  GL_UNSIGNED_INT_VEC2_EXT = $8DC6;  
  GL_UNSIGNED_INT_VEC3_EXT = $8DC7;  
  GL_UNSIGNED_INT_VEC4_EXT = $8DC8;  
  GL_INT_SAMPLER_1D_EXT = $8DC9;  
  GL_INT_SAMPLER_2D_EXT = $8DCA;  
  GL_INT_SAMPLER_3D_EXT = $8DCB;  
  GL_INT_SAMPLER_CUBE_EXT = $8DCC;  
  GL_INT_SAMPLER_2D_RECT_EXT = $8DCD;  
  GL_INT_SAMPLER_1D_ARRAY_EXT = $8DCE;  
  GL_INT_SAMPLER_2D_ARRAY_EXT = $8DCF;  
  GL_INT_SAMPLER_BUFFER_EXT = $8DD0;  
  GL_UNSIGNED_INT_SAMPLER_1D_EXT = $8DD1;  
  GL_UNSIGNED_INT_SAMPLER_2D_EXT = $8DD2;  
  GL_UNSIGNED_INT_SAMPLER_3D_EXT = $8DD3;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_EXT = $8DD4;  
  GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT = $8DD5;  
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = $8DD6;  
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = $8DD7;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = $8DD8;  
type
  TPFNGLBINDFRAGDATALOCATIONEXTPROC = procedure (prog:TGLuint; color:TGLuint; name:PGLchar);cdecl;
  TPFNGLGETFRAGDATALOCATIONEXTPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLGETUNIFORMUIVEXTPROC = procedure (prog:TGLuint; location:TGLint; params:PGLuint);cdecl;
  TPFNGLGETVERTEXATTRIBIIVEXTPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVERTEXATTRIBIUIVEXTPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLUNIFORM1UIEXTPROC = procedure (location:TGLint; v0:TGLuint);cdecl;
  TPFNGLUNIFORM1UIVEXTPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM2UIEXTPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;
  TPFNGLUNIFORM2UIVEXTPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM3UIEXTPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;
  TPFNGLUNIFORM3UIVEXTPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLUNIFORM4UIEXTPROC = procedure (location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; v3:TGLuint);cdecl;
  TPFNGLUNIFORM4UIVEXTPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI1IEXTPROC = procedure (index:TGLuint; x:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI1IVEXTPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI1UIEXTPROC = procedure (index:TGLuint; x:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI1UIVEXTPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI2IEXTPROC = procedure (index:TGLuint; x:TGLint; y:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI2IVEXTPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI2UIEXTPROC = procedure (index:TGLuint; x:TGLuint; y:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI2UIVEXTPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI3IEXTPROC = procedure (index:TGLuint; x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI3IVEXTPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI3UIEXTPROC = procedure (index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI3UIVEXTPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4BVEXTPROC = procedure (index:TGLuint; v:PGLbyte);cdecl;
  TPFNGLVERTEXATTRIBI4IEXTPROC = procedure (index:TGLuint; x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;
  TPFNGLVERTEXATTRIBI4IVEXTPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVERTEXATTRIBI4SVEXTPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBI4UBVEXTPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIBI4UIEXTPROC = procedure (index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint; w:TGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4UIVEXTPROC = procedure (index:TGLuint; v:PGLuint);cdecl;
  TPFNGLVERTEXATTRIBI4USVEXTPROC = procedure (index:TGLuint; v:PGLushort);cdecl;
  TPFNGLVERTEXATTRIBIPOINTEREXTPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ --------------------------- GL_EXT_gpu_shader5 --------------------------  }

const
  GL_EXT_gpu_shader5 = 1;  


{ ---------------------------- GL_EXT_histogram ---------------------------  }

const
  GL_EXT_histogram = 1;  
  GL_HISTOGRAM_EXT = $8024;  
  GL_PROXY_HISTOGRAM_EXT = $8025;  
  GL_HISTOGRAM_WIDTH_EXT = $8026;  
  GL_HISTOGRAM_FORMAT_EXT = $8027;  
  GL_HISTOGRAM_RED_SIZE_EXT = $8028;  
  GL_HISTOGRAM_GREEN_SIZE_EXT = $8029;  
  GL_HISTOGRAM_BLUE_SIZE_EXT = $802A;  
  GL_HISTOGRAM_ALPHA_SIZE_EXT = $802B;  
  GL_HISTOGRAM_LUMINANCE_SIZE_EXT = $802C;  
  GL_HISTOGRAM_SINK_EXT = $802D;  
  GL_MINMAX_EXT = $802E;  
  GL_MINMAX_FORMAT_EXT = $802F;  
  GL_MINMAX_SINK_EXT = $8030;  
type
  TPFNGLGETHISTOGRAMEXTPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;
  TPFNGLGETHISTOGRAMPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETHISTOGRAMPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMINMAXEXTPROC = procedure (target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;
  TPFNGLGETMINMAXPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMINMAXPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLHISTOGRAMEXTPROC = procedure (target:TGLenum; width:TGLsizei; internalformat:TGLenum; sink:TGLboolean);cdecl;
  TPFNGLMINMAXEXTPROC = procedure (target:TGLenum; internalformat:TGLenum; sink:TGLboolean);cdecl;
  TPFNGLRESETHISTOGRAMEXTPROC = procedure (target:TGLenum);cdecl;
  TPFNGLRESETMINMAXEXTPROC = procedure (target:TGLenum);cdecl;


{ ----------------------- GL_EXT_index_array_formats ----------------------  }

const
  GL_EXT_index_array_formats = 1;  


{ --------------------------- GL_EXT_index_func ---------------------------  }

const
  GL_EXT_index_func = 1;  
type
  TPFNGLINDEXFUNCEXTPROC = procedure (func:TGLenum; ref:TGLfloat);cdecl;


{ ------------------------- GL_EXT_index_material -------------------------  }

const
  GL_EXT_index_material = 1;  
type
  TPFNGLINDEXMATERIALEXTPROC = procedure (face:TGLenum; mode:TGLenum);cdecl;


{ -------------------------- GL_EXT_index_texture -------------------------  }

const
  GL_EXT_index_texture = 1;  


{ ------------------------ GL_EXT_instanced_arrays ------------------------  }

const
  GL_EXT_instanced_arrays = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_EXT = $88FE;  
type
 TPFNGLVERTEXATTRIBDIVISOREXTPROC = procedure (index:TGLuint; divisor:TGLuint);cdecl;


{ -------------------------- GL_EXT_light_texture -------------------------  }

const
  GL_EXT_light_texture = 1;  
  GL_FRAGMENT_MATERIAL_EXT = $8349;  
  GL_FRAGMENT_NORMAL_EXT = $834A;  
  GL_FRAGMENT_COLOR_EXT = $834C;  
  GL_ATTENUATION_EXT = $834D;  
  GL_SHADOW_ATTENUATION_EXT = $834E;  
  GL_TEXTURE_APPLICATION_MODE_EXT = $834F;  
  GL_TEXTURE_LIGHT_EXT = $8350;  
  GL_TEXTURE_MATERIAL_FACE_EXT = $8351;  
  GL_TEXTURE_MATERIAL_PARAMETER_EXT = $8352;  
type
  TPFNGLAPPLYTEXTUREEXTPROC = procedure (mode:TGLenum);cdecl;
  TPFNGLTEXTURELIGHTEXTPROC = procedure (pname:TGLenum);cdecl;
  TPFNGLTEXTUREMATERIALEXTPROC = procedure (face:TGLenum; mode:TGLenum);cdecl;


{ ------------------------ GL_EXT_map_buffer_range ------------------------  }

const
  GL_EXT_map_buffer_range = 1;  
  GL_MAP_READ_BIT_EXT = $0001;  
  GL_MAP_WRITE_BIT_EXT = $0002;  
  GL_MAP_INVALIDATE_RANGE_BIT_EXT = $0004;  
  GL_MAP_INVALIDATE_BUFFER_BIT_EXT = $0008;  
  GL_MAP_FLUSH_EXPLICIT_BIT_EXT = $0010;  
  GL_MAP_UNSYNCHRONIZED_BIT_EXT = $0020;  
type
  TPFNGLFLUSHMAPPEDBUFFERRANGEEXTPROC = procedure (target:TGLenum; offset:TGLintptr; length:TGLsizeiptr);cdecl;
  TPFNGLMAPBUFFERRANGEEXTPROC = function (target:TGLenum; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;


{ -------------------------- GL_EXT_memory_object -------------------------  }

const
  GL_EXT_memory_object = 1;  
  GL_UUID_SIZE_EXT = 16;  
  GL_TEXTURE_TILING_EXT = $9580;  
  GL_DEDICATED_MEMORY_OBJECT_EXT = $9581;  
  GL_NUM_TILING_TYPES_EXT = $9582;  
  GL_TILING_TYPES_EXT = $9583;  
  GL_OPTIMAL_TILING_EXT = $9584;  
  GL_LINEAR_TILING_EXT = $9585;  
  GL_NUM_DEVICE_UUIDS_EXT = $9596;  
  GL_DEVICE_UUID_EXT = $9597;  
  GL_DRIVER_UUID_EXT = $9598;  
  GL_PROTECTED_MEMORY_OBJECT_EXT = $959B;  
type
  TPFNGLBUFFERSTORAGEMEMEXTPROC = procedure (target:TGLenum; size:TGLsizeiptr; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLCREATEMEMORYOBJECTSEXTPROC = procedure (n:TGLsizei; memoryObjects:PGLuint);cdecl;
  TPFNGLDELETEMEMORYOBJECTSEXTPROC = procedure (n:TGLsizei; memoryObjects:PGLuint);cdecl;
  TPFNGLGETMEMORYOBJECTPARAMETERIVEXTPROC = procedure (memoryObject:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETUNSIGNEDBYTEI_VEXTPROC = procedure (target:TGLenum; index:TGLuint; data:PGLubyte);cdecl;
  TPFNGLGETUNSIGNEDBYTEVEXTPROC = procedure (pname:TGLenum; data:PGLubyte);cdecl;
  TPFNGLISMEMORYOBJECTEXTPROC = function (memoryObject:TGLuint):TGLboolean;cdecl;
  TPFNGLMEMORYOBJECTPARAMETERIVEXTPROC = procedure (memoryObject:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLNAMEDBUFFERSTORAGEMEMEXTPROC = procedure (buffer:TGLuint; size:TGLsizeiptr; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXSTORAGEMEM1DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; memory:TGLuint;                offset:TGLuint64);cdecl;
  TPFNGLTEXSTORAGEMEM2DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;                memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXSTORAGEMEM2DMULTISAMPLEEXTPROC = procedure (target:TGLenum; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXSTORAGEMEM3DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
               depth:TGLsizei; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXSTORAGEMEM3DMULTISAMPLEEXTPROC = procedure (target:TGLenum; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
               depth:TGLsizei; fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXTURESTORAGEMEM1DEXTPROC = procedure (texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; memory:TGLuint;                offset:TGLuint64);cdecl;
  TPFNGLTEXTURESTORAGEMEM2DEXTPROC = procedure (texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;                memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXTURESTORAGEMEM2DMULTISAMPLEEXTPROC = procedure (texture:TGLuint; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXTURESTORAGEMEM3DEXTPROC = procedure (texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXTURESTORAGEMEM3DMULTISAMPLEEXTPROC = procedure (texture:TGLuint; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;


{ ------------------------ GL_EXT_memory_object_fd ------------------------  }

const
  GL_EXT_memory_object_fd = 1;  
  GL_HANDLE_TYPE_OPAQUE_FD_EXT = $9586;  
type
  TPFNGLIMPORTMEMORYFDEXTPROC = procedure (memory:TGLuint; size:TGLuint64; handleType:TGLenum; fd:TGLint);cdecl;


{ ----------------------- GL_EXT_memory_object_win32 ----------------------  }

const
  GL_EXT_memory_object_win32 = 1;  
  GL_LUID_SIZE_EXT = 8;  
  GL_HANDLE_TYPE_OPAQUE_WIN32_EXT = $9587;  
  GL_HANDLE_TYPE_OPAQUE_WIN32_KMT_EXT = $9588;  
  GL_HANDLE_TYPE_D3D12_TILEPOOL_EXT = $9589;  
  GL_HANDLE_TYPE_D3D12_RESOURCE_EXT = $958A;  
  GL_HANDLE_TYPE_D3D11_IMAGE_EXT = $958B;  
  GL_HANDLE_TYPE_D3D11_IMAGE_KMT_EXT = $958C;  
  GL_HANDLE_TYPE_D3D12_FENCE_EXT = $9594;  
  GL_D3D12_FENCE_VALUE_EXT = $9595;  
  GL_DEVICE_LUID_EXT = $9599;  
  GL_DEVICE_NODE_MASK_EXT = $959A;  
type
  TPFNGLIMPORTMEMORYWIN32HANDLEEXTPROC = procedure (memory:TGLuint; size:TGLuint64; handleType:TGLenum; handle:pointer);cdecl;
  TPFNGLIMPORTMEMORYWIN32NAMEEXTPROC = procedure (memory:TGLuint; size:TGLuint64; handleType:TGLenum; name:pointer);cdecl;


{ ------------------------- GL_EXT_misc_attribute -------------------------  }

const
  GL_EXT_misc_attribute = 1;  


{ ------------------------ GL_EXT_multi_draw_arrays -----------------------  }

const
  GL_EXT_multi_draw_arrays = 1;  
type
  TPFNGLMULTIDRAWARRAYSEXTPROC = procedure (mode:TGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSEXTPROC = procedure (mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; primcount:TGLsizei);cdecl;


{ ----------------------- GL_EXT_multi_draw_indirect ----------------------  }

const
  GL_EXT_multi_draw_indirect = 1;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTEXTPROC = procedure (mode:TGLenum; indirect:pointer; drawcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTEXTPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; drawcount:TGLsizei; stride:TGLsizei);cdecl;


{ ------------------------ GL_EXT_multiple_textures -----------------------  }

const
  GL_EXT_multiple_textures = 1;  


{ --------------------------- GL_EXT_multisample --------------------------  }

const
  GL_EXT_multisample = 1;  
  GL_MULTISAMPLE_EXT = $809D;  
  GL_SAMPLE_ALPHA_TO_MASK_EXT = $809E;  
  GL_SAMPLE_ALPHA_TO_ONE_EXT = $809F;  
  GL_SAMPLE_MASK_EXT = $80A0;  
  GL_1PASS_EXT = $80A1;  
  GL_2PASS_0_EXT = $80A2;  
  GL_2PASS_1_EXT = $80A3;  
  GL_4PASS_0_EXT = $80A4;  
  GL_4PASS_1_EXT = $80A5;  
  GL_4PASS_2_EXT = $80A6;  
  GL_4PASS_3_EXT = $80A7;  
  GL_SAMPLE_BUFFERS_EXT = $80A8;  
  GL_SAMPLES_EXT = $80A9;  
  GL_SAMPLE_MASK_VALUE_EXT = $80AA;  
  GL_SAMPLE_MASK_INVERT_EXT = $80AB;  
  GL_SAMPLE_PATTERN_EXT = $80AC;  
  GL_MULTISAMPLE_BIT_EXT = $20000000;  
type
  TPFNGLSAMPLEMASKEXTPROC = procedure (value:TGLclampf; invert:TGLboolean);cdecl;
  TPFNGLSAMPLEPATTERNEXTPROC = procedure (pattern:TGLenum);cdecl;


{ -------------------- GL_EXT_multisample_compatibility -------------------  }

const
  GL_EXT_multisample_compatibility = 1;  
//  GL_MULTISAMPLE_EXT = $809D;   doppelt
//  GL_SAMPLE_ALPHA_TO_ONE_EXT = $809F;  


{ ----------------- GL_EXT_multisampled_render_to_texture -----------------  }

const
  GL_EXT_multisampled_render_to_texture = 1;  
//  GL_RENDERBUFFER_SAMPLES_EXT = $8CAB;     doppelt
//  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = $8D56;  
//  GL_MAX_SAMPLES_EXT = $8D57;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_SAMPLES_EXT = $8D6C;  
type
  TPFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEEXTPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;                samples:TGLsizei);cdecl;


{ ----------------- GL_EXT_multisampled_render_to_texture2 ----------------  }

const
  GL_EXT_multisampled_render_to_texture2 = 1;  


{ --------------------- GL_EXT_multiview_draw_buffers ---------------------  }

const
  GL_EXT_multiview_draw_buffers = 1;  
  GL_DRAW_BUFFER_EXT = $0C01;  
  GL_READ_BUFFER_EXT = $0C02;  
  GL_COLOR_ATTACHMENT_EXT = $90F0;  
  GL_MULTIVIEW_EXT = $90F1;  
  GL_MAX_MULTIVIEW_BUFFERS_EXT = $90F2;  
type
  TPFNGLDRAWBUFFERSINDEXEDEXTPROC = procedure (n:TGLint; location:PGLenum; indices:PGLint);cdecl;
  TPFNGLGETINTEGERI_VEXTPROC = procedure (target:TGLenum; index:TGLuint; data:PGLint);cdecl;
  TPFNGLREADBUFFERINDEXEDEXTPROC = procedure (src:TGLenum; index:TGLint);cdecl;


{ ------------- GL_EXT_multiview_tessellation_geometry_shader -------------  }

const
  GL_EXT_multiview_tessellation_geometry_shader = 1;  


{ ------------------ GL_EXT_multiview_texture_multisample -----------------  }

const
  GL_EXT_multiview_texture_multisample = 1;  


{ ---------------------- GL_EXT_multiview_timer_query ---------------------  }

const
  GL_EXT_multiview_timer_query = 1;  


{ --------------------- GL_EXT_occlusion_query_boolean --------------------  }

const
  GL_EXT_occlusion_query_boolean = 1;  
//  GL_CURRENT_QUERY_EXT = $8865;   doppelt
//  GL_QUERY_RESULT_EXT = $8866;  
//  GL_QUERY_RESULT_AVAILABLE_EXT = $8867;  
  GL_ANY_SAMPLES_PASSED_EXT = $8C2F;  
  GL_ANY_SAMPLES_PASSED_CONSERVATIVE_EXT = $8D6A;  


{ ---------------------- GL_EXT_packed_depth_stencil ----------------------  }

const
  GL_EXT_packed_depth_stencil = 1;  
  GL_DEPTH_STENCIL_EXT = $84F9;  
  GL_UNSIGNED_INT_24_8_EXT = $84FA;  
  GL_DEPTH24_STENCIL8_EXT = $88F0;  
  GL_TEXTURE_STENCIL_SIZE_EXT = $88F1;  


{ -------------------------- GL_EXT_packed_float --------------------------  }

const
  GL_EXT_packed_float = 1;  
  GL_R11F_G11F_B10F_EXT = $8C3A;  
  GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = $8C3B;  
  GL_RGBA_SIGNED_COMPONENTS_EXT = $8C3C;  


{ -------------------------- GL_EXT_packed_pixels -------------------------  }

const
  GL_EXT_packed_pixels = 1;  
  GL_UNSIGNED_BYTE_3_3_2_EXT = $8032;  
  GL_UNSIGNED_SHORT_4_4_4_4_EXT = $8033;  
  GL_UNSIGNED_SHORT_5_5_5_1_EXT = $8034;  
  GL_UNSIGNED_INT_8_8_8_8_EXT = $8035;  
  GL_UNSIGNED_INT_10_10_10_2_EXT = $8036;  


{ ------------------------ GL_EXT_paletted_texture ------------------------  }

const
  GL_EXT_paletted_texture = 1;  
  //GL_TEXTURE_1D = $0DE0;    doppelt
  //GL_TEXTURE_2D = $0DE1;  
  //GL_PROXY_TEXTURE_1D = $8063;  
  //GL_PROXY_TEXTURE_2D = $8064;  
  GL_COLOR_TABLE_FORMAT_EXT = $80D8;  
  GL_COLOR_TABLE_WIDTH_EXT = $80D9;  
  GL_COLOR_TABLE_RED_SIZE_EXT = $80DA;  
  GL_COLOR_TABLE_GREEN_SIZE_EXT = $80DB;  
  GL_COLOR_TABLE_BLUE_SIZE_EXT = $80DC;  
  GL_COLOR_TABLE_ALPHA_SIZE_EXT = $80DD;  
  GL_COLOR_TABLE_LUMINANCE_SIZE_EXT = $80DE;  
  GL_COLOR_TABLE_INTENSITY_SIZE_EXT = $80DF;  
  //GL_COLOR_INDEX1_EXT = $80E2;  
  //GL_COLOR_INDEX2_EXT = $80E3;  
  //GL_COLOR_INDEX4_EXT = $80E4;  
  //GL_COLOR_INDEX8_EXT = $80E5;  
  //GL_COLOR_INDEX12_EXT = $80E6;  
  //GL_COLOR_INDEX16_EXT = $80E7;  
  GL_TEXTURE_INDEX_SIZE_EXT = $80ED;  
//  GL_TEXTURE_CUBE_MAP_ARB = $8513;  
//  GL_PROXY_TEXTURE_CUBE_MAP_ARB = $851B;  
type
  TPFNGLCOLORTABLEEXTPROC = procedure (target:TGLenum; internalFormat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum;                data:pointer);cdecl;
  TPFNGLGETCOLORTABLEEXTPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ ----------------------- GL_EXT_pixel_buffer_object ----------------------  }

const
  GL_EXT_pixel_buffer_object = 1;  
  GL_PIXEL_PACK_BUFFER_EXT = $88EB;  
  GL_PIXEL_UNPACK_BUFFER_EXT = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING_EXT = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = $88EF;  


{ ------------------------- GL_EXT_pixel_transform ------------------------  }

const
  GL_EXT_pixel_transform = 1;  
  GL_PIXEL_TRANSFORM_2D_EXT = $8330;  
  GL_PIXEL_MAG_FILTER_EXT = $8331;  
  GL_PIXEL_MIN_FILTER_EXT = $8332;  
  GL_PIXEL_CUBIC_WEIGHT_EXT = $8333;  
  GL_CUBIC_EXT = $8334;  
  GL_AVERAGE_EXT = $8335;  
  GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8336;  
  GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8337;  
  GL_PIXEL_TRANSFORM_2D_MATRIX_EXT = $8338;  
type
  TPFNGLGETPIXELTRANSFORMPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETPIXELTRANSFORMPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERFEXTPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERFVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERIEXTPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ ------------------- GL_EXT_pixel_transform_color_table ------------------  }

const
  GL_EXT_pixel_transform_color_table = 1;  


{ ------------------------ GL_EXT_point_parameters ------------------------  }

const
  GL_EXT_point_parameters = 1;  
  GL_POINT_SIZE_MIN_EXT = $8126;  
  GL_POINT_SIZE_MAX_EXT = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE_EXT = $8128;  
  GL_DISTANCE_ATTENUATION_EXT = $8129;  
type
  TPFNGLPOINTPARAMETERFEXTPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPOINTPARAMETERFVEXTPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;


{ ------------------------- GL_EXT_polygon_offset -------------------------  }

const
  GL_EXT_polygon_offset = 1;  
  GL_POLYGON_OFFSET_EXT = $8037;  
  GL_POLYGON_OFFSET_FACTOR_EXT = $8038;  
  GL_POLYGON_OFFSET_BIAS_EXT = $8039;  
type
  TPFNGLPOLYGONOFFSETEXTPROC = procedure (factor:TGLfloat; bias:TGLfloat);cdecl;


{ ---------------------- GL_EXT_polygon_offset_clamp ----------------------  }

const
  GL_EXT_polygon_offset_clamp = 1;  
  GL_POLYGON_OFFSET_CLAMP_EXT = $8E1B;  
type
  TPFNGLPOLYGONOFFSETCLAMPEXTPROC = procedure (factor:TGLfloat; units:TGLfloat; clamp:TGLfloat);cdecl;


{ ----------------------- GL_EXT_post_depth_coverage ----------------------  }

const
  GL_EXT_post_depth_coverage = 1;  


{ --------------------- GL_EXT_primitive_bounding_box ---------------------  }

const
  GL_EXT_primitive_bounding_box = 1;  
  GL_PRIMITIVE_BOUNDING_BOX_EXT = $92BE;  
type
  TPFNGLPRIMITIVEBOUNDINGBOXEXTPROC = procedure (minX:TGLfloat; minY:TGLfloat; minZ:TGLfloat; minW:TGLfloat; maxX:TGLfloat;
                maxY:TGLfloat; maxZ:TGLfloat; maxW:TGLfloat);cdecl;


{ ----------------------- GL_EXT_protected_textures -----------------------  }

const
  GL_EXT_protected_textures = 1;  
  GL_CONTEXT_FLAG_PROTECTED_CONTENT_BIT_EXT = $00000010;  
  GL_TEXTURE_PROTECTED_EXT = $8BFA;  


{ ------------------------ GL_EXT_provoking_vertex ------------------------  }

const
  GL_EXT_provoking_vertex = 1;  
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = $8E4C;  
//  GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;   doppelt
//  GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;  
  GL_PROVOKING_VERTEX_EXT = $8E4F;  
type
  TPFNGLPROVOKINGVERTEXEXTPROC = procedure (mode:TGLenum);cdecl;


{ --------------------------- GL_EXT_pvrtc_sRGB ---------------------------  }

const
  GL_EXT_pvrtc_sRGB = 1;  
  GL_COMPRESSED_SRGB_PVRTC_2BPPV1_EXT = $8A54;  
  GL_COMPRESSED_SRGB_PVRTC_4BPPV1_EXT = $8A55;  
  GL_COMPRESSED_SRGB_ALPHA_PVRTC_2BPPV1_EXT = $8A56;  
  GL_COMPRESSED_SRGB_ALPHA_PVRTC_4BPPV1_EXT = $8A57;  


{ ----------------------- GL_EXT_raster_multisample -----------------------  }

const
  GL_EXT_raster_multisample = 1;  
  GL_COLOR_SAMPLES_NV = $8E20;  
  GL_RASTER_MULTISAMPLE_EXT = $9327;  
  GL_RASTER_SAMPLES_EXT = $9328;  
  GL_MAX_RASTER_SAMPLES_EXT = $9329;  
  GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = $932A;  
  GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = $932B;  
  GL_EFFECTIVE_RASTER_SAMPLES_EXT = $932C;  
  GL_DEPTH_SAMPLES_NV = $932D;  
  GL_STENCIL_SAMPLES_NV = $932E;  
  GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = $932F;  
  GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = $9330;  
  GL_COVERAGE_MODULATION_TABLE_NV = $9331;  
  GL_COVERAGE_MODULATION_NV = $9332;  
  GL_COVERAGE_MODULATION_TABLE_SIZE_NV = $9333;  
type
  TPFNGLCOVERAGEMODULATIONNVPROC = procedure (components:TGLenum);cdecl;
  TPFNGLCOVERAGEMODULATIONTABLENVPROC = procedure (n:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLGETCOVERAGEMODULATIONTABLENVPROC = procedure (bufsize:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLRASTERSAMPLESEXTPROC = procedure (samples:TGLuint; fixedsamplelocations:TGLboolean);cdecl;


{ ------------------------ GL_EXT_read_format_bgra ------------------------  }

const
  GL_EXT_read_format_bgra = 1;  
//  GL_BGRA_EXT = $80E1;   doppelt
  GL_UNSIGNED_SHORT_4_4_4_4_REV_EXT = $8365;  
  GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT = $8366;  


{ -------------------------- GL_EXT_render_snorm --------------------------  }

const
  GL_EXT_render_snorm = 1;  
  //GL_BYTE = $1400;       doppelt
  //GL_SHORT = $1402;  
  //GL_R8_SNORM = $8F94;  
  //GL_RG8_SNORM = $8F95;  
  //GL_RGBA8_SNORM = $8F97;  
  GL_R16_SNORM_EXT = $8F98;  
  GL_RG16_SNORM_EXT = $8F99;  
  GL_RGBA16_SNORM_EXT = $8F9B;  


{ ------------------------- GL_EXT_rescale_normal -------------------------  }

const
  GL_EXT_rescale_normal = 1;  
  GL_RESCALE_NORMAL_EXT = $803A;  


{ --------------------------- GL_EXT_robustness ---------------------------  }

const
  GL_EXT_robustness = 1;  
  GL_LOSE_CONTEXT_ON_RESET_EXT = $8252;  
  GL_GUILTY_CONTEXT_RESET_EXT = $8253;  
  GL_INNOCENT_CONTEXT_RESET_EXT = $8254;  
  GL_UNKNOWN_CONTEXT_RESET_EXT = $8255;  
  GL_RESET_NOTIFICATION_STRATEGY_EXT = $8256;  
  GL_NO_RESET_NOTIFICATION_EXT = $8261;  
  GL_CONTEXT_ROBUST_ACCESS_EXT = $90F3;  
type
  TPFNGLGETNUNIFORMFVEXTPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLGETNUNIFORMIVEXTPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint);cdecl;
  TPFNGLREADNPIXELSEXTPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum;
                _type:TGLenum; bufSize:TGLsizei; data:pointer);cdecl;


{ ------------------------------ GL_EXT_sRGB ------------------------------  }

const
  GL_EXT_sRGB = 1;  
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING_EXT = $8210;  
  GL_SRGB_EXT = $8C40;  
  GL_SRGB_ALPHA_EXT = $8C42;  
  GL_SRGB8_ALPHA8_EXT = $8C43;  


{ ----------------------- GL_EXT_sRGB_write_control -----------------------  }

const
  GL_EXT_sRGB_write_control = 1;  
//   GL_FRAMEBUFFER_SRGB_EXT = $8DB9;   doppelt


{ -------------------------- GL_EXT_scene_marker --------------------------  }

const
  GL_EXT_scene_marker = 1;  
type
  TPFNGLBEGINSCENEEXTPROC = procedure (para1:pointer);cdecl;
  TPFNGLENDSCENEEXTPROC = procedure (para1:pointer);cdecl;


{ ------------------------- GL_EXT_secondary_color ------------------------  }

const
  GL_EXT_secondary_color = 1;  
  GL_COLOR_SUM_EXT = $8458;  
  GL_CURRENT_SECONDARY_COLOR_EXT = $8459;  
  GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = $845A;  
  GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = $845B;  
  GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = $845C;  
  GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = $845D;  
  GL_SECONDARY_COLOR_ARRAY_EXT = $845E;  
type
  TPFNGLSECONDARYCOLOR3BEXTPROC = procedure (red:TGLbyte; green:TGLbyte; blue:TGLbyte);cdecl;
  TPFNGLSECONDARYCOLOR3BVEXTPROC = procedure (v:PGLbyte);cdecl;
  TPFNGLSECONDARYCOLOR3DEXTPROC = procedure (red:TGLdouble; green:TGLdouble; blue:TGLdouble);cdecl;
  TPFNGLSECONDARYCOLOR3DVEXTPROC = procedure (v:PGLdouble);cdecl;
  TPFNGLSECONDARYCOLOR3FEXTPROC = procedure (red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;
  TPFNGLSECONDARYCOLOR3FVEXTPROC = procedure (v:PGLfloat);cdecl;
  TPFNGLSECONDARYCOLOR3IEXTPROC = procedure (red:TGLint; green:TGLint; blue:TGLint);cdecl;
  TPFNGLSECONDARYCOLOR3IVEXTPROC = procedure (v:PGLint);cdecl;
  TPFNGLSECONDARYCOLOR3SEXTPROC = procedure (red:TGLshort; green:TGLshort; blue:TGLshort);cdecl;
  TPFNGLSECONDARYCOLOR3SVEXTPROC = procedure (v:PGLshort);cdecl;
  TPFNGLSECONDARYCOLOR3UBEXTPROC = procedure (red:TGLubyte; green:TGLubyte; blue:TGLubyte);cdecl;
  TPFNGLSECONDARYCOLOR3UBVEXTPROC = procedure (v:PGLubyte);cdecl;
  TPFNGLSECONDARYCOLOR3UIEXTPROC = procedure (red:TGLuint; green:TGLuint; blue:TGLuint);cdecl;
  TPFNGLSECONDARYCOLOR3UIVEXTPROC = procedure (v:PGLuint);cdecl;
  TPFNGLSECONDARYCOLOR3USEXTPROC = procedure (red:TGLushort; green:TGLushort; blue:TGLushort);cdecl;
  TPFNGLSECONDARYCOLOR3USVEXTPROC = procedure (v:PGLushort);cdecl;
  TPFNGLSECONDARYCOLORPOINTEREXTPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ ---------------------------- GL_EXT_semaphore ---------------------------  }

const
  GL_EXT_semaphore = 1;  
  GL_LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_EXT = $9530;  
  GL_LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_EXT = $9531;  
  GL_LAYOUT_GENERAL_EXT = $958D;  
  GL_LAYOUT_COLOR_ATTACHMENT_EXT = $958E;  
  GL_LAYOUT_DEPTH_STENCIL_ATTACHMENT_EXT = $958F;  
  GL_LAYOUT_DEPTH_STENCIL_READ_ONLY_EXT = $9590;  
  GL_LAYOUT_SHADER_READ_ONLY_EXT = $9591;  
  GL_LAYOUT_TRANSFER_SRC_EXT = $9592;  
  GL_LAYOUT_TRANSFER_DST_EXT = $9593;  
type
  TPFNGLDELETESEMAPHORESEXTPROC = procedure (n:TGLsizei; semaphores:PGLuint);cdecl;
  TPFNGLGENSEMAPHORESEXTPROC = procedure (n:TGLsizei; semaphores:PGLuint);cdecl;
  TPFNGLGETSEMAPHOREPARAMETERUI64VEXTPROC = procedure (semaphore:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;
  TPFNGLISSEMAPHOREEXTPROC = function (semaphore:TGLuint):TGLboolean;cdecl;
  TPFNGLSEMAPHOREPARAMETERUI64VEXTPROC = procedure (semaphore:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;
  TPFNGLSIGNALSEMAPHOREEXTPROC = procedure (semaphore:TGLuint; numBufferBarriers:TGLuint; buffers:PGLuint; numTextureBarriers:TGLuint; textures:PGLuint;                dstLayouts:PGLenum);cdecl;
  TPFNGLWAITSEMAPHOREEXTPROC = procedure (semaphore:TGLuint; numBufferBarriers:TGLuint; buffers:PGLuint; numTextureBarriers:TGLuint; textures:PGLuint;                srcLayouts:PGLenum);cdecl;


{ -------------------------- GL_EXT_semaphore_fd --------------------------  }

const
  GL_EXT_semaphore_fd = 1;  
type
  TPFNGLIMPORTSEMAPHOREFDEXTPROC = procedure (semaphore:TGLuint; handleType:TGLenum; fd:TGLint);cdecl;


{ ------------------------- GL_EXT_semaphore_win32 ------------------------  }

const
  GL_EXT_semaphore_win32 = 1;  
type
  TPFNGLIMPORTSEMAPHOREWIN32HANDLEEXTPROC = procedure (semaphore:TGLuint; handleType:TGLenum; handle:pointer);cdecl;
  TPFNGLIMPORTSEMAPHOREWIN32NAMEEXTPROC = procedure (semaphore:TGLuint; handleType:TGLenum; name:pointer);cdecl;


{ --------------------- GL_EXT_separate_shader_objects --------------------  }

const
  GL_EXT_separate_shader_objects = 1;  
  GL_ACTIVE_PROGRAM_EXT = $8B8D;  
type
  TPFNGLACTIVEPROGRAMEXTPROC = procedure (prog:TGLuint);cdecl;
  TPFNGLCREATESHADERPROGRAMEXTPROC = function (_type:TGLenum; _string:PGLchar):TGLuint;cdecl;
  TPFNGLUSESHADERPROGRAMEXTPROC = procedure (_type:TGLenum; prog:TGLuint);cdecl;


{ --------------------- GL_EXT_separate_specular_color --------------------  }

const
  GL_EXT_separate_specular_color = 1;  
  GL_LIGHT_MODEL_COLOR_CONTROL_EXT = $81F8;  
  GL_SINGLE_COLOR_EXT = $81F9;  
  GL_SEPARATE_SPECULAR_COLOR_EXT = $81FA;  


{ -------------------- GL_EXT_shader_framebuffer_fetch --------------------  }

const
  GL_EXT_shader_framebuffer_fetch = 1;  
  GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = $8A52;  
type
  TPFNGLFRAMEBUFFERFETCHBARRIEREXTPROC = procedure (para1:pointer);cdecl;


{ -------------- GL_EXT_shader_framebuffer_fetch_non_coherent -------------  }

const
  GL_EXT_shader_framebuffer_fetch_non_coherent = 1;  
//  GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = $8A52;     doppelt


{ ------------------------ GL_EXT_shader_group_vote -----------------------  }

const
  GL_EXT_shader_group_vote = 1;  


{ ------------------- GL_EXT_shader_image_load_formatted ------------------  }

const
  GL_EXT_shader_image_load_formatted = 1;  


{ --------------------- GL_EXT_shader_image_load_store --------------------  }

const
  GL_EXT_shader_image_load_store = 1;  
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = $00000001;  
  GL_ELEMENT_ARRAY_BARRIER_BIT_EXT = $00000002;  
  GL_UNIFORM_BARRIER_BIT_EXT = $00000004;  
  GL_TEXTURE_FETCH_BARRIER_BIT_EXT = $00000008;  
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = $00000020;  
  GL_COMMAND_BARRIER_BIT_EXT = $00000040;  
  GL_PIXEL_BUFFER_BARRIER_BIT_EXT = $00000080;  
  GL_TEXTURE_UPDATE_BARRIER_BIT_EXT = $00000100;  
  GL_BUFFER_UPDATE_BARRIER_BIT_EXT = $00000200;  
  GL_FRAMEBUFFER_BARRIER_BIT_EXT = $00000400;  
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = $00000800;  
  GL_ATOMIC_COUNTER_BARRIER_BIT_EXT = $00001000;  
  GL_MAX_IMAGE_UNITS_EXT = $8F38;  
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = $8F39;  
  GL_IMAGE_BINDING_NAME_EXT = $8F3A;  
  GL_IMAGE_BINDING_LEVEL_EXT = $8F3B;  
  GL_IMAGE_BINDING_LAYERED_EXT = $8F3C;  
  GL_IMAGE_BINDING_LAYER_EXT = $8F3D;  
  GL_IMAGE_BINDING_ACCESS_EXT = $8F3E;  
  GL_IMAGE_1D_EXT = $904C;  
  GL_IMAGE_2D_EXT = $904D;  
  GL_IMAGE_3D_EXT = $904E;  
  GL_IMAGE_2D_RECT_EXT = $904F;  
  GL_IMAGE_CUBE_EXT = $9050;  
  GL_IMAGE_BUFFER_EXT = $9051;  
  GL_IMAGE_1D_ARRAY_EXT = $9052;  
  GL_IMAGE_2D_ARRAY_EXT = $9053;  
  GL_IMAGE_CUBE_MAP_ARRAY_EXT = $9054;  
  GL_IMAGE_2D_MULTISAMPLE_EXT = $9055;  
  GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9056;  
  GL_INT_IMAGE_1D_EXT = $9057;  
  GL_INT_IMAGE_2D_EXT = $9058;  
  GL_INT_IMAGE_3D_EXT = $9059;  
  GL_INT_IMAGE_2D_RECT_EXT = $905A;  
  GL_INT_IMAGE_CUBE_EXT = $905B;  
  GL_INT_IMAGE_BUFFER_EXT = $905C;  
  GL_INT_IMAGE_1D_ARRAY_EXT = $905D;  
  GL_INT_IMAGE_2D_ARRAY_EXT = $905E;  
  GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $905F;  
  GL_INT_IMAGE_2D_MULTISAMPLE_EXT = $9060;  
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9061;  
  GL_UNSIGNED_INT_IMAGE_1D_EXT = $9062;  
  GL_UNSIGNED_INT_IMAGE_2D_EXT = $9063;  
  GL_UNSIGNED_INT_IMAGE_3D_EXT = $9064;  
  GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT = $9065;  
  GL_UNSIGNED_INT_IMAGE_CUBE_EXT = $9066;  
  GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = $9067;  
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = $9068;  
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = $9069;  
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $906A;  
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = $906B;  
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $906C;  
  GL_MAX_IMAGE_SAMPLES_EXT = $906D;  
  GL_IMAGE_BINDING_FORMAT_EXT = $906E;  
  GL_ALL_BARRIER_BITS_EXT = $FFFFFFFF;  
type
  TPFNGLBINDIMAGETEXTUREEXTPROC = procedure (index:TGLuint; texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint;                access:TGLenum; format:TGLint);cdecl;
  TPFNGLMEMORYBARRIEREXTPROC = procedure (barriers:TGLbitfield);cdecl;


{ ------------------- GL_EXT_shader_implicit_conversions ------------------  }

const
  GL_EXT_shader_implicit_conversions = 1;  


{ ----------------------- GL_EXT_shader_integer_mix -----------------------  }

const
  GL_EXT_shader_integer_mix = 1;  


{ ------------------------ GL_EXT_shader_io_blocks ------------------------  }

const
  GL_EXT_shader_io_blocks = 1;  


{ ------------- GL_EXT_shader_non_constant_global_initializers ------------  }

const
  GL_EXT_shader_non_constant_global_initializers = 1;  


{ ------------------- GL_EXT_shader_pixel_local_storage -------------------  }

const
  GL_EXT_shader_pixel_local_storage = 1;  
  GL_MAX_SHADER_PIXEL_LOCAL_STORAGE_FAST_SIZE_EXT = $8F63;  
  GL_SHADER_PIXEL_LOCAL_STORAGE_EXT = $8F64;  
  GL_MAX_SHADER_PIXEL_LOCAL_STORAGE_SIZE_EXT = $8F67;  


{ ------------------- GL_EXT_shader_pixel_local_storage2 ------------------  }

const
  GL_EXT_shader_pixel_local_storage2 = 1;  
  GL_MAX_SHADER_COMBINED_LOCAL_STORAGE_FAST_SIZE_EXT = $9650;  
  GL_MAX_SHADER_COMBINED_LOCAL_STORAGE_SIZE_EXT = $9651;  
  GL_FRAMEBUFFER_INCOMPLETE_INSUFFICIENT_SHADER_COMBINED_LOCAL_STORAGE_EXT = $9652;  
type
  TPFNGLCLEARPIXELLOCALSTORAGEUIEXTPROC = procedure (offset:TGLsizei; n:TGLsizei; values:PGLuint);cdecl;
  TPFNGLFRAMEBUFFERPIXELLOCALSTORAGESIZEEXTPROC = procedure (target:TGLuint; size:TGLsizei);cdecl;
  TPFNGLGETFRAMEBUFFERPIXELLOCALSTORAGESIZEEXTPROC = function (target:TGLuint):TGLsizei;cdecl;


{ ----------------------- GL_EXT_shader_texture_lod -----------------------  }

const
  GL_EXT_shader_texture_lod = 1;  


{ -------------------------- GL_EXT_shadow_funcs --------------------------  }

const
  GL_EXT_shadow_funcs = 1;  


{ ------------------------- GL_EXT_shadow_samplers ------------------------  }

const
  GL_EXT_shadow_samplers = 1;  
  GL_TEXTURE_COMPARE_MODE_EXT = $884C;  
  GL_TEXTURE_COMPARE_FUNC_EXT = $884D;  
  GL_COMPARE_REF_TO_TEXTURE_EXT = $884E;  
  GL_SAMPLER_2D_SHADOW_EXT = $8B62;  


{ --------------------- GL_EXT_shared_texture_palette ---------------------  }

const
  GL_EXT_shared_texture_palette = 1;  
  GL_SHARED_TEXTURE_PALETTE_EXT = $81FB;  


{ ------------------------- GL_EXT_sparse_texture -------------------------  }

const
  GL_EXT_sparse_texture = 1;  
//  GL_TEXTURE_2D = $0DE1;     doppelt
//  GL_TEXTURE_3D = $806F;  
//  GL_TEXTURE_CUBE_MAP = $8513;  
//  GL_TEXTURE_2D_ARRAY = $8C1A;  
  GL_TEXTURE_CUBE_MAP_ARRAY_OES = $9009;  
  GL_VIRTUAL_PAGE_SIZE_X_EXT = $9195;  
  GL_VIRTUAL_PAGE_SIZE_Y_EXT = $9196;  
  GL_VIRTUAL_PAGE_SIZE_Z_EXT = $9197;  
  GL_MAX_SPARSE_TEXTURE_SIZE_EXT = $9198;  
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_EXT = $9199;  
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_EXT = $919A;  
  GL_TEXTURE_SPARSE_EXT = $91A6;  
  GL_VIRTUAL_PAGE_SIZE_INDEX_EXT = $91A7;  
  GL_NUM_VIRTUAL_PAGE_SIZES_EXT = $91A8;  
  GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_EXT = $91A9;  
  GL_NUM_SPARSE_LEVELS_EXT = $91AA;  
type
  TPFNGLTEXPAGECOMMITMENTEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; commit:TGLboolean);cdecl;
  TPFNGLTEXTUREPAGECOMMITMENTEXTPROC = procedure (texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; commit:TGLboolean);cdecl;


{ ------------------------- GL_EXT_sparse_texture2 ------------------------  }

const
  GL_EXT_sparse_texture2 = 1;  


{ ----------------------- GL_EXT_static_vertex_array ----------------------  }

const
  GL_EXT_static_vertex_array = 1;  


{ ------------------------ GL_EXT_stencil_clear_tag -----------------------  }

const
  GL_EXT_stencil_clear_tag = 1;  
  GL_STENCIL_TAG_BITS_EXT = $88F2;  
  GL_STENCIL_CLEAR_TAG_VALUE_EXT = $88F3;  


{ ------------------------ GL_EXT_stencil_two_side ------------------------  }

const
  GL_EXT_stencil_two_side = 1;  
  GL_STENCIL_TEST_TWO_SIDE_EXT = $8910;  
  GL_ACTIVE_STENCIL_FACE_EXT = $8911;  
type
  TPFNGLACTIVESTENCILFACEEXTPROC = procedure (face:TGLenum);cdecl;


{ -------------------------- GL_EXT_stencil_wrap --------------------------  }

const
  GL_EXT_stencil_wrap = 1;  
  GL_INCR_WRAP_EXT = $8507;  
  GL_DECR_WRAP_EXT = $8508;  


{ --------------------------- GL_EXT_subtexture ---------------------------  }

const
  GL_EXT_subtexture = 1;  
type
  TPFNGLTEXSUBIMAGE1DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum;
                _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE2DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei;
                height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE3DEXTPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;


{ --------------------- GL_EXT_tessellation_point_size --------------------  }

const
  GL_EXT_tessellation_point_size = 1;  
  GL_QUADS_EXT = $0007;  
  GL_TESS_CONTROL_SHADER_BIT_EXT = $00000008;  
  GL_PATCHES_EXT = $E;  
  GL_TESS_EVALUATION_SHADER_BIT_EXT = $00000010;  
//  GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221;     doppelt
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_EXT = $886C;  
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_EXT = $886D;  
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS_EXT = $8E1E;  
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS_EXT = $8E1F;  
  GL_PATCH_VERTICES_EXT = $8E72;  
  GL_TESS_CONTROL_OUTPUT_VERTICES_EXT = $8E75;  
  GL_TESS_GEN_MODE_EXT = $8E76;  
  GL_TESS_GEN_SPACING_EXT = $8E77;  
  GL_TESS_GEN_VERTEX_ORDER_EXT = $8E78;  
  GL_TESS_GEN_POINT_MODE_EXT = $8E79;  
  GL_ISOLINES_EXT = $8E7A;  
  GL_FRACTIONAL_ODD_EXT = $8E7B;  
  GL_FRACTIONAL_EVEN_EXT = $8E7C;  
  GL_MAX_PATCH_VERTICES_EXT = $8E7D;  
  GL_MAX_TESS_GEN_LEVEL_EXT = $8E7E;  
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS_EXT = $8E7F;  
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS_EXT = $8E80;  
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS_EXT = $8E81;  
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS_EXT = $8E82;  
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_EXT = $8E83;  
  GL_MAX_TESS_PATCH_COMPONENTS_EXT = $8E84;  
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS_EXT = $8E85;  
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_EXT = $8E86;  
  GL_TESS_EVALUATION_SHADER_EXT = $8E87;  
  GL_TESS_CONTROL_SHADER_EXT = $8E88;  
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS_EXT = $8E89;  
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS_EXT = $8E8A;  
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS_EXT = $90CB;  
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS_EXT = $90CC;  
  GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS_EXT = $90D8;  
  GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS_EXT = $90D9;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS_EXT = $92CD;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS_EXT = $92CE;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS_EXT = $92D3;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS_EXT = $92D4;  
  GL_IS_PER_PATCH_EXT = $92E7;  
  GL_REFERENCED_BY_TESS_CONTROL_SHADER_EXT = $9307;  
  GL_REFERENCED_BY_TESS_EVALUATION_SHADER_EXT = $9308;  
type
  TPFNGLPATCHPARAMETERIEXTPROC = procedure (pname:TGLenum; value:TGLint);cdecl;


{ ----------------------- GL_EXT_tessellation_shader ----------------------  }

const
  GL_EXT_tessellation_shader = 1;  
  //GL_QUADS_EXT = $0007;                        doppelt
  //GL_TESS_CONTROL_SHADER_BIT_EXT = $00000008;  
  //GL_PATCHES_EXT = $E;  
  //GL_TESS_EVALUATION_SHADER_BIT_EXT = $00000010;  
  //GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221;  
  //GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_EXT = $886C;  
  //GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_EXT = $886D;  
  //GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS_EXT = $8E1E;  
  //GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS_EXT = $8E1F;  
  //GL_PATCH_VERTICES_EXT = $8E72;  
  //GL_TESS_CONTROL_OUTPUT_VERTICES_EXT = $8E75;  
  //GL_TESS_GEN_MODE_EXT = $8E76;  
  //GL_TESS_GEN_SPACING_EXT = $8E77;  
  //GL_TESS_GEN_VERTEX_ORDER_EXT = $8E78;  
  //GL_TESS_GEN_POINT_MODE_EXT = $8E79;  
  //GL_ISOLINES_EXT = $8E7A;  
  //GL_FRACTIONAL_ODD_EXT = $8E7B;  
  //GL_FRACTIONAL_EVEN_EXT = $8E7C;  
  //GL_MAX_PATCH_VERTICES_EXT = $8E7D;  
  //GL_MAX_TESS_GEN_LEVEL_EXT = $8E7E;  
  //GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS_EXT = $8E7F;  
  //GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS_EXT = $8E80;  
  //GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS_EXT = $8E81;  
  //GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS_EXT = $8E82;  
  //GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_EXT = $8E83;  
  //GL_MAX_TESS_PATCH_COMPONENTS_EXT = $8E84;  
  //GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS_EXT = $8E85;  
  //GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_EXT = $8E86;  
  //GL_TESS_EVALUATION_SHADER_EXT = $8E87;  
  //GL_TESS_CONTROL_SHADER_EXT = $8E88;  
  //GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS_EXT = $8E89;  
  //GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS_EXT = $8E8A;  
  //GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS_EXT = $90CB;  
  //GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS_EXT = $90CC;  
  //GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS_EXT = $90D8;  
  //GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS_EXT = $90D9;  
  //GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS_EXT = $92CD;  
  //GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS_EXT = $92CE;  
  //GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS_EXT = $92D3;  
  //GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS_EXT = $92D4;  
  //GL_IS_PER_PATCH_EXT = $92E7;  
  //GL_REFERENCED_BY_TESS_CONTROL_SHADER_EXT = $9307;  
  //GL_REFERENCED_BY_TESS_EVALUATION_SHADER_EXT = $9308;  


{ ----------------------------- GL_EXT_texture ----------------------------  }

const
  GL_EXT_texture = 1;  
  GL_ALPHA4_EXT = $803B;  
  GL_ALPHA8_EXT = $803C;  
  GL_ALPHA12_EXT = $803D;  
  GL_ALPHA16_EXT = $803E;  
  GL_LUMINANCE4_EXT = $803F;  
  GL_LUMINANCE8_EXT = $8040;  
  GL_LUMINANCE12_EXT = $8041;  
  GL_LUMINANCE16_EXT = $8042;  
  GL_LUMINANCE4_ALPHA4_EXT = $8043;  
  GL_LUMINANCE6_ALPHA2_EXT = $8044;  
  GL_LUMINANCE8_ALPHA8_EXT = $8045;  
  GL_LUMINANCE12_ALPHA4_EXT = $8046;  
  GL_LUMINANCE12_ALPHA12_EXT = $8047;  
  GL_LUMINANCE16_ALPHA16_EXT = $8048;  
  GL_INTENSITY_EXT = $8049;  
  GL_INTENSITY4_EXT = $804A;  
  GL_INTENSITY8_EXT = $804B;  
  GL_INTENSITY12_EXT = $804C;  
  GL_INTENSITY16_EXT = $804D;  
  GL_RGB2_EXT = $804E;  
  GL_RGB4_EXT = $804F;  
  GL_RGB5_EXT = $8050;  
  GL_RGB8_EXT = $8051;  
  GL_RGB10_EXT = $8052;  
  GL_RGB12_EXT = $8053;  
  GL_RGB16_EXT = $8054;  
  GL_RGBA2_EXT = $8055;  
  GL_RGBA4_EXT = $8056;  
  GL_RGB5_A1_EXT = $8057;  
  GL_RGBA8_EXT = $8058;  
  GL_RGB10_A2_EXT = $8059;  
  GL_RGBA12_EXT = $805A;  
  GL_RGBA16_EXT = $805B;  
  GL_TEXTURE_RED_SIZE_EXT = $805C;  
  GL_TEXTURE_GREEN_SIZE_EXT = $805D;  
  GL_TEXTURE_BLUE_SIZE_EXT = $805E;  
  GL_TEXTURE_ALPHA_SIZE_EXT = $805F;  
  GL_TEXTURE_LUMINANCE_SIZE_EXT = $8060;  
  GL_TEXTURE_INTENSITY_SIZE_EXT = $8061;  
  GL_REPLACE_EXT = $8062;  
  GL_PROXY_TEXTURE_1D_EXT = $8063;  
  GL_PROXY_TEXTURE_2D_EXT = $8064;  


{ ---------------------------- GL_EXT_texture3D ---------------------------  }

const
  GL_EXT_texture3D = 1;  
  GL_PACK_SKIP_IMAGES_EXT = $806B;  
  GL_PACK_IMAGE_HEIGHT_EXT = $806C;  
  GL_UNPACK_SKIP_IMAGES_EXT = $806D;  
  GL_UNPACK_IMAGE_HEIGHT_EXT = $806E;  
  GL_TEXTURE_3D_EXT = $806F;  
  GL_PROXY_TEXTURE_3D_EXT = $8070;  
  GL_TEXTURE_DEPTH_EXT = $8071;  
  GL_TEXTURE_WRAP_R_EXT = $8072;  
  GL_MAX_3D_TEXTURE_SIZE_EXT = $8073;  
type
  TPFNGLTEXIMAGE3DEXTPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;


{ -------------------------- GL_EXT_texture_array -------------------------  }

const
  GL_EXT_texture_array = 1;  
  GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = $884E;  
  GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = $88FF;  
  GL_TEXTURE_1D_ARRAY_EXT = $8C18;  
  GL_PROXY_TEXTURE_1D_ARRAY_EXT = $8C19;  
  GL_TEXTURE_2D_ARRAY_EXT = $8C1A;  
  GL_PROXY_TEXTURE_2D_ARRAY_EXT = $8C1B;  
  GL_TEXTURE_BINDING_1D_ARRAY_EXT = $8C1C;  
  GL_TEXTURE_BINDING_2D_ARRAY_EXT = $8C1D;  
type
  TPFNGLFRAMEBUFFERTEXTURELAYEREXTPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;


{ ---------------------- GL_EXT_texture_border_clamp ----------------------  }

const
  GL_EXT_texture_border_clamp = 1;  
  GL_TEXTURE_BORDER_COLOR_EXT = $1004;  
  GL_CLAMP_TO_BORDER_EXT = $812D;  
type
  TPFNGLGETSAMPLERPARAMETERIIVEXTPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSAMPLERPARAMETERIUIVEXTPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLSAMPLERPARAMETERIIVEXTPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLSAMPLERPARAMETERIUIVEXTPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;


{ ------------------------- GL_EXT_texture_buffer -------------------------  }

const
  GL_EXT_texture_buffer = 1;  
  GL_TEXTURE_BUFFER_BINDING_EXT = $8C2A;  
  GL_TEXTURE_BUFFER_EXT = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE_EXT = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER_EXT = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = $8C2D;  
  //GL_SAMPLER_BUFFER_EXT = $8DC2;      doppelt
  //GL_INT_SAMPLER_BUFFER_EXT = $8DD0;  
  //GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = $8DD8;  
  //GL_IMAGE_BUFFER_EXT = $9051;  
  //GL_INT_IMAGE_BUFFER_EXT = $905C;  
  //GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = $9067;  
  GL_TEXTURE_BUFFER_OFFSET_EXT = $919D;  
  GL_TEXTURE_BUFFER_SIZE_EXT = $919E;  
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT_EXT = $919F;  


{ ---------------------- GL_EXT_texture_buffer_object ---------------------  }

const
  GL_EXT_texture_buffer_object = 1;  
  //GL_TEXTURE_BUFFER_EXT = $8C2A   doppelt;  
  //GL_MAX_TEXTURE_BUFFER_SIZE_EXT = $8C2B;  
  //GL_TEXTURE_BINDING_BUFFER_EXT = $8C2C;  
  //GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = $8C2D;  
  GL_TEXTURE_BUFFER_FORMAT_EXT = $8C2E;  
type
  TPFNGLTEXBUFFEREXTPROC = procedure (target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;


{ -------------- GL_EXT_texture_compression_astc_decode_mode --------------  }

const
  GL_EXT_texture_compression_astc_decode_mode = 1;  
  GL_TEXTURE_ASTC_DECODE_PRECISION_EXT = $8F69;  


{ ----------- GL_EXT_texture_compression_astc_decode_mode_rgb9e5 ----------  }

const
  GL_EXT_texture_compression_astc_decode_mode_rgb9e5 = 1;  
//  GL_TEXTURE_ASTC_DECODE_PRECISION_EXT = $8F69;     doppelt


{ -------------------- GL_EXT_texture_compression_bptc --------------------  }

const
  GL_EXT_texture_compression_bptc = 1;  
  GL_COMPRESSED_RGBA_BPTC_UNORM_EXT = $8E8C;  
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_EXT = $8E8D;  
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_EXT = $8E8E;  
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_EXT = $8E8F;  


{ -------------------- GL_EXT_texture_compression_dxt1 --------------------  }

const
  GL_EXT_texture_compression_dxt1 = 1;  


{ -------------------- GL_EXT_texture_compression_latc --------------------  }

const
  GL_EXT_texture_compression_latc = 1;  
  GL_COMPRESSED_LUMINANCE_LATC1_EXT = $8C70;  
  GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = $8C71;  
  GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = $8C72;  
  GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = $8C73;  


{ -------------------- GL_EXT_texture_compression_rgtc --------------------  }

const
  GL_EXT_texture_compression_rgtc = 1;  
  GL_COMPRESSED_RED_RGTC1_EXT = $8DBB;  
  GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = $8DBC;  
  GL_COMPRESSED_RED_GREEN_RGTC2_EXT = $8DBD;  
  GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = $8DBE;  


{ -------------------- GL_EXT_texture_compression_s3tc --------------------  }

const
  GL_EXT_texture_compression_s3tc = 1;  
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0;  
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1;  
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = $83F2;  
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;  


{ ------------------ GL_EXT_texture_compression_s3tc_srgb -----------------  }

const
  GL_EXT_texture_compression_s3tc_srgb = 1;  
  GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = $8C4C;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = $8C4D;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = $8C4E;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = $8C4F;  


{ ------------------------ GL_EXT_texture_cube_map ------------------------  }

const
  GL_EXT_texture_cube_map = 1;  
  GL_NORMAL_MAP_EXT = $8511;  
  GL_REFLECTION_MAP_EXT = $8512;  
  GL_TEXTURE_CUBE_MAP_EXT = $8513;  
  GL_TEXTURE_BINDING_CUBE_MAP_EXT = $8514;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT = $8515;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = $8516;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = $8517;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = $8518;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = $8519;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = $851A;  
  GL_PROXY_TEXTURE_CUBE_MAP_EXT = $851B;  
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT = $851C;  


{ --------------------- GL_EXT_texture_cube_map_array ---------------------  }

const
  GL_EXT_texture_cube_map_array = 1;  
  GL_TEXTURE_CUBE_MAP_ARRAY_EXT = $9009;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_EXT = $900A;  
  GL_SAMPLER_CUBE_MAP_ARRAY_EXT = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_EXT = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_EXT = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_EXT = $900F;  
  //GL_IMAGE_CUBE_MAP_ARRAY_EXT = $9054   doppelt;  
  //GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $905F;  
  //GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $906A;  


{ ----------------------- GL_EXT_texture_edge_clamp -----------------------  }

const
  GL_EXT_texture_edge_clamp = 1;  
  GL_CLAMP_TO_EDGE_EXT = $812F;  


{ --------------------------- GL_EXT_texture_env --------------------------  }

const
  GL_EXT_texture_env = 1;  


{ ------------------------- GL_EXT_texture_env_add ------------------------  }

const
  GL_EXT_texture_env_add = 1;  


{ ----------------------- GL_EXT_texture_env_combine ----------------------  }

const
  GL_EXT_texture_env_combine = 1;  
  GL_COMBINE_EXT = $8570;  
  GL_COMBINE_RGB_EXT = $8571;  
  GL_COMBINE_ALPHA_EXT = $8572;  
  GL_RGB_SCALE_EXT = $8573;  
  GL_ADD_SIGNED_EXT = $8574;  
  GL_INTERPOLATE_EXT = $8575;  
  GL_CONSTANT_EXT = $8576;  
  GL_PRIMARY_COLOR_EXT = $8577;  
  GL_PREVIOUS_EXT = $8578;  
  GL_SOURCE0_RGB_EXT = $8580;  
  GL_SOURCE1_RGB_EXT = $8581;  
  GL_SOURCE2_RGB_EXT = $8582;  
  GL_SOURCE0_ALPHA_EXT = $8588;  
  GL_SOURCE1_ALPHA_EXT = $8589;  
  GL_SOURCE2_ALPHA_EXT = $858A;  
  GL_OPERAND0_RGB_EXT = $8590;  
  GL_OPERAND1_RGB_EXT = $8591;  
  GL_OPERAND2_RGB_EXT = $8592;  
  GL_OPERAND0_ALPHA_EXT = $8598;  
  GL_OPERAND1_ALPHA_EXT = $8599;  
  GL_OPERAND2_ALPHA_EXT = $859A;  


{ ------------------------ GL_EXT_texture_env_dot3 ------------------------  }

const
  GL_EXT_texture_env_dot3 = 1;  
  GL_DOT3_RGB_EXT = $8740;  
  GL_DOT3_RGBA_EXT = $8741;  


{ ------------------- GL_EXT_texture_filter_anisotropic -------------------  }

const
  GL_EXT_texture_filter_anisotropic = 1;  
  GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE;  
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;  


{ ---------------------- GL_EXT_texture_filter_minmax ---------------------  }

const
  GL_EXT_texture_filter_minmax = 1;  
  GL_TEXTURE_REDUCTION_MODE_EXT = $9366;  
  GL_WEIGHTED_AVERAGE_EXT = $9367;  


{ --------------------- GL_EXT_texture_format_BGRA8888 --------------------  }

const
  GL_EXT_texture_format_BGRA8888 = 1;  
//  GL_BGRA_EXT = $80E1;     doppelt


{ ------------------ GL_EXT_texture_format_sRGB_override ------------------  }

const
  GL_EXT_texture_format_sRGB_override = 1;  
  GL_TEXTURE_FORMAT_SRGB_OVERRIDE_EXT = $8FBF;  


{ ------------------------- GL_EXT_texture_integer ------------------------  }

const
  GL_EXT_texture_integer = 1;  
  GL_RGBA32UI_EXT = $8D70;  
  GL_RGB32UI_EXT = $8D71;  
  GL_ALPHA32UI_EXT = $8D72;  
  GL_INTENSITY32UI_EXT = $8D73;  
  GL_LUMINANCE32UI_EXT = $8D74;  
  GL_LUMINANCE_ALPHA32UI_EXT = $8D75;  
  GL_RGBA16UI_EXT = $8D76;  
  GL_RGB16UI_EXT = $8D77;  
  GL_ALPHA16UI_EXT = $8D78;  
  GL_INTENSITY16UI_EXT = $8D79;  
  GL_LUMINANCE16UI_EXT = $8D7A;  
  GL_LUMINANCE_ALPHA16UI_EXT = $8D7B;  
  GL_RGBA8UI_EXT = $8D7C;  
  GL_RGB8UI_EXT = $8D7D;  
  GL_ALPHA8UI_EXT = $8D7E;  
  GL_INTENSITY8UI_EXT = $8D7F;  
  GL_LUMINANCE8UI_EXT = $8D80;  
  GL_LUMINANCE_ALPHA8UI_EXT = $8D81;  
  GL_RGBA32I_EXT = $8D82;  
  GL_RGB32I_EXT = $8D83;  
  GL_ALPHA32I_EXT = $8D84;  
  GL_INTENSITY32I_EXT = $8D85;  
  GL_LUMINANCE32I_EXT = $8D86;  
  GL_LUMINANCE_ALPHA32I_EXT = $8D87;  
  GL_RGBA16I_EXT = $8D88;  
  GL_RGB16I_EXT = $8D89;  
  GL_ALPHA16I_EXT = $8D8A;  
  GL_INTENSITY16I_EXT = $8D8B;  
  GL_LUMINANCE16I_EXT = $8D8C;  
  GL_LUMINANCE_ALPHA16I_EXT = $8D8D;  
  GL_RGBA8I_EXT = $8D8E;  
  GL_RGB8I_EXT = $8D8F;  
  GL_ALPHA8I_EXT = $8D90;  
  GL_INTENSITY8I_EXT = $8D91;  
  GL_LUMINANCE8I_EXT = $8D92;  
  GL_LUMINANCE_ALPHA8I_EXT = $8D93;  
  GL_RED_INTEGER_EXT = $8D94;  
  GL_GREEN_INTEGER_EXT = $8D95;  
  GL_BLUE_INTEGER_EXT = $8D96;  
  GL_ALPHA_INTEGER_EXT = $8D97;  
  GL_RGB_INTEGER_EXT = $8D98;  
  GL_RGBA_INTEGER_EXT = $8D99;  
  GL_BGR_INTEGER_EXT = $8D9A;  
  GL_BGRA_INTEGER_EXT = $8D9B;  
  GL_LUMINANCE_INTEGER_EXT = $8D9C;  
  GL_LUMINANCE_ALPHA_INTEGER_EXT = $8D9D;  
  GL_RGBA_INTEGER_MODE_EXT = $8D9E;  
type
  TPFNGLCLEARCOLORIIEXTPROC = procedure (red:TGLint; green:TGLint; blue:TGLint; alpha:TGLint);cdecl;
  TPFNGLCLEARCOLORIUIEXTPROC = procedure (red:TGLuint; green:TGLuint; blue:TGLuint; alpha:TGLuint);cdecl;
  TPFNGLGETTEXPARAMETERIIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXPARAMETERIUIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLTEXPARAMETERIIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXPARAMETERIUIVEXTPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;


{ ------------------------ GL_EXT_texture_lod_bias ------------------------  }

const
  GL_EXT_texture_lod_bias = 1;  
  GL_MAX_TEXTURE_LOD_BIAS_EXT = $84FD;  
  GL_TEXTURE_FILTER_CONTROL_EXT = $8500;  
  GL_TEXTURE_LOD_BIAS_EXT = $8501;  


{ ---------------------- GL_EXT_texture_mirror_clamp ----------------------  }

const
  GL_EXT_texture_mirror_clamp = 1;  
  GL_MIRROR_CLAMP_EXT = $8742;  
  GL_MIRROR_CLAMP_TO_EDGE_EXT = $8743;  
  GL_MIRROR_CLAMP_TO_BORDER_EXT = $8912;  


{ ------------------ GL_EXT_texture_mirror_clamp_to_edge ------------------  }

const
  GL_EXT_texture_mirror_clamp_to_edge = 1;  
//  GL_MIRROR_CLAMP_TO_EDGE_EXT = $8743   doppelt;  


{ ------------------------- GL_EXT_texture_norm16 -------------------------  }

const
  GL_EXT_texture_norm16 = 1;  
//  GL_RGB16_EXT = $8054;     doppelt
//  GL_RGBA16_EXT = $805B;  
  GL_R16_EXT = $822A;  
  GL_RG16_EXT = $822C;  
//  GL_R16_SNORM_EXT = $8F98;  
//  GL_RG16_SNORM_EXT = $8F99;  
  GL_RGB16_SNORM_EXT = $8F9A;  
//  GL_RGBA16_SNORM_EXT = $8F9B;  


{ ------------------------- GL_EXT_texture_object -------------------------  }

const
  GL_EXT_texture_object = 1;  
  GL_TEXTURE_PRIORITY_EXT = $8066;  
  GL_TEXTURE_RESIDENT_EXT = $8067;  
  GL_TEXTURE_1D_BINDING_EXT = $8068;  
  GL_TEXTURE_2D_BINDING_EXT = $8069;  
  GL_TEXTURE_3D_BINDING_EXT = $806A;  
type
  TPFNGLARETEXTURESRESIDENTEXTPROC = function (n:TGLsizei; textures:PGLuint; residences:PGLboolean):TGLboolean;cdecl;
  TPFNGLBINDTEXTUREEXTPROC = procedure (target:TGLenum; texture:TGLuint);cdecl;
  TPFNGLDELETETEXTURESEXTPROC = procedure (n:TGLsizei; textures:PGLuint);cdecl;
  TPFNGLGENTEXTURESEXTPROC = procedure (n:TGLsizei; textures:PGLuint);cdecl;
  TPFNGLISTEXTUREEXTPROC = function (texture:TGLuint):TGLboolean;cdecl;
  TPFNGLPRIORITIZETEXTURESEXTPROC = procedure (n:TGLsizei; textures:PGLuint; priorities:PGLclampf);cdecl;


{ --------------------- GL_EXT_texture_perturb_normal ---------------------  }

const
  GL_EXT_texture_perturb_normal = 1;  
  GL_PERTURB_EXT = $85AE;  
  GL_TEXTURE_NORMAL_EXT = $85AF;  
type
  TPFNGLTEXTURENORMALEXTPROC = procedure (mode:TGLenum);cdecl;


{ ------------------------ GL_EXT_texture_query_lod -----------------------  }

const
  GL_EXT_texture_query_lod = 1;  


{ ------------------------ GL_EXT_texture_rectangle -----------------------  }

const
  GL_EXT_texture_rectangle = 1;  
  GL_TEXTURE_RECTANGLE_EXT = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE_EXT = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE_EXT = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE_EXT = $84F8;  


{ --------------------------- GL_EXT_texture_rg ---------------------------  }

const
  GL_EXT_texture_rg = 1;  
  GL_RED_EXT = $1903;  
  GL_RG_EXT = $8227;  
  GL_R8_EXT = $8229;  
  GL_RG8_EXT = $822B;  


{ -------------------------- GL_EXT_texture_sRGB --------------------------  }

const
  GL_EXT_texture_sRGB = 1;  
//  GL_SRGB_EXT = $8C40;  doppelt
  GL_SRGB8_EXT = $8C41;  
//  GL_SRGB_ALPHA_EXT = $8C42;  
//  GL_SRGB8_ALPHA8_EXT = $8C43;  
  GL_SLUMINANCE_ALPHA_EXT = $8C44;  
  GL_SLUMINANCE8_ALPHA8_EXT = $8C45;  
  GL_SLUMINANCE_EXT = $8C46;  
  GL_SLUMINANCE8_EXT = $8C47;  
  GL_COMPRESSED_SRGB_EXT = $8C48;  
  GL_COMPRESSED_SRGB_ALPHA_EXT = $8C49;  
  GL_COMPRESSED_SLUMINANCE_EXT = $8C4A;  
  GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = $8C4B;  
//  GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = $8C4C;  
//  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = $8C4D;  
//  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = $8C4E;  
//  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = $8C4F;  


{ ------------------------- GL_EXT_texture_sRGB_R8 ------------------------  }

const
  GL_EXT_texture_sRGB_R8 = 1;  
  GL_SR8_EXT = $8FBD;  


{ ------------------------ GL_EXT_texture_sRGB_RG8 ------------------------  }

const
  GL_EXT_texture_sRGB_RG8 = 1;  
  GL_SRG8_EXT = $8FBE;  


{ ----------------------- GL_EXT_texture_sRGB_decode ----------------------  }

const
  GL_EXT_texture_sRGB_decode = 1;  
  GL_TEXTURE_SRGB_DECODE_EXT = $8A48;  
  GL_DECODE_EXT = $8A49;  
  GL_SKIP_DECODE_EXT = $8A4A;  


{ ----------------------- GL_EXT_texture_shadow_lod -----------------------  }

const
  GL_EXT_texture_shadow_lod = 1;  


{ --------------------- GL_EXT_texture_shared_exponent --------------------  }

const
  GL_EXT_texture_shared_exponent = 1;  
  GL_RGB9_E5_EXT = $8C3D;  
  GL_UNSIGNED_INT_5_9_9_9_REV_EXT = $8C3E;  
  GL_TEXTURE_SHARED_SIZE_EXT = $8C3F;  


{ -------------------------- GL_EXT_texture_snorm -------------------------  }

const
  GL_EXT_texture_snorm = 1;  
  //GL_RED_SNORM = $8F90;    doppelt
  //GL_RG_SNORM = $8F91;  
  //GL_RGB_SNORM = $8F92;  
  //GL_RGBA_SNORM = $8F93;  
  //GL_R8_SNORM = $8F94;  
  //GL_RG8_SNORM = $8F95;  
  //GL_RGB8_SNORM = $8F96;  
  //GL_RGBA8_SNORM = $8F97;  
  //GL_R16_SNORM = $8F98;  
  //GL_RG16_SNORM = $8F99;  
  //GL_RGB16_SNORM = $8F9A;  
  //GL_RGBA16_SNORM = $8F9B;  
  //GL_SIGNED_NORMALIZED = $8F9C;  
  GL_ALPHA_SNORM = $9010;  
  GL_LUMINANCE_SNORM = $9011;  
  GL_LUMINANCE_ALPHA_SNORM = $9012;  
  GL_INTENSITY_SNORM = $9013;  
  GL_ALPHA8_SNORM = $9014;  
  GL_LUMINANCE8_SNORM = $9015;  
  GL_LUMINANCE8_ALPHA8_SNORM = $9016;  
  GL_INTENSITY8_SNORM = $9017;  
  GL_ALPHA16_SNORM = $9018;  
  GL_LUMINANCE16_SNORM = $9019;  
  GL_LUMINANCE16_ALPHA16_SNORM = $901A;  
  GL_INTENSITY16_SNORM = $901B;  


{ ------------------------- GL_EXT_texture_storage ------------------------  }

const
  GL_EXT_texture_storage = 1;  
  //GL_ALPHA8_EXT = $803C;    doppelt
  //GL_LUMINANCE8_EXT = $8040;  
  //GL_LUMINANCE8_ALPHA8_EXT = $8045;  
  //GL_RGB10_EXT = $8052;  
  //GL_RGB10_A2_EXT = $8059;  
  //GL_R8_EXT = $8229;  
  //GL_RG8_EXT = $822B;  
  //GL_R16F_EXT = $822D;  
  GL_R32F_EXT = $822E;  
  //GL_RG16F_EXT = $822F;  
  GL_RG32F_EXT = $8230;  
  GL_RGBA32F_EXT = $8814;  
  GL_RGB32F_EXT = $8815;  
  GL_ALPHA32F_EXT = $8816;  
  GL_LUMINANCE32F_EXT = $8818;  
  GL_LUMINANCE_ALPHA32F_EXT = $8819;  
//  GL_RGBA16F_EXT = $881A;  
//  GL_RGB16F_EXT = $881B;  
  GL_ALPHA16F_EXT = $881C;  
  GL_LUMINANCE16F_EXT = $881E;  
  GL_LUMINANCE_ALPHA16F_EXT = $881F;  
//  GL_RGB_RAW_422_APPLE = $8A51;  
  GL_TEXTURE_IMMUTABLE_FORMAT_EXT = $912F;  
//  GL_BGRA8_EXT = $93A1;  
type
  TPFNGLTEXSTORAGE1DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;
  TPFNGLTEXSTORAGE2DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLTEXSTORAGE3DEXTPROC = procedure (target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;                depth:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE1DEXTPROC = procedure (texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE2DEXTPROC = procedure (texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei;                height:TGLsizei);cdecl;
  TPFNGLTEXTURESTORAGE3DEXTPROC = procedure (texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei;                height:TGLsizei; depth:TGLsizei);cdecl;


{ ------------------------- GL_EXT_texture_swizzle ------------------------  }

const
  GL_EXT_texture_swizzle = 1;  
  GL_TEXTURE_SWIZZLE_R_EXT = $8E42;  
  GL_TEXTURE_SWIZZLE_G_EXT = $8E43;  
  GL_TEXTURE_SWIZZLE_B_EXT = $8E44;  
  GL_TEXTURE_SWIZZLE_A_EXT = $8E45;  
  GL_TEXTURE_SWIZZLE_RGBA_EXT = $8E46;  


{ ------------------- GL_EXT_texture_type_2_10_10_10_REV ------------------  }

const
  GL_EXT_texture_type_2_10_10_10_REV = 1;  
  GL_UNSIGNED_INT_2_10_10_10_REV_EXT = $8368;  


{ -------------------------- GL_EXT_texture_view --------------------------  }

const
  GL_EXT_texture_view = 1;  
  GL_TEXTURE_VIEW_MIN_LEVEL_EXT = $82DB;  
  GL_TEXTURE_VIEW_NUM_LEVELS_EXT = $82DC;  
  GL_TEXTURE_VIEW_MIN_LAYER_EXT = $82DD;  
  GL_TEXTURE_VIEW_NUM_LAYERS_EXT = $82DE;  
//  GL_TEXTURE_IMMUTABLE_LEVELS = $82DF;    doppelt
type
  TPFNGLTEXTUREVIEWEXTPROC = procedure (texture:TGLuint; target:TGLenum; origtexture:TGLuint; internalformat:TGLenum; minlevel:TGLuint;
                numlevels:TGLuint; minlayer:TGLuint; numlayers:TGLuint);cdecl;


{ --------------------------- GL_EXT_timer_query --------------------------  }

const
  GL_EXT_timer_query = 1;  
//  GL_TIME_ELAPSED_EXT = $88BF;    doppelt
type
  TPFNGLGETQUERYOBJECTI64VEXTPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint64EXT);cdecl;
  TPFNGLGETQUERYOBJECTUI64VEXTPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;


{ ----------------------- GL_EXT_transform_feedback -----------------------  }

const
  GL_EXT_transform_feedback = 1;  
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = $8C76;  
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = $8C7F;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = $8C80;  
  GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = $8C83;  
  GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = $8C84;  
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = $8C85;  
//  GL_PRIMITIVES_GENERATED_EXT = $8C87;    doppelt
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = $8C88;  
  GL_RASTERIZER_DISCARD_EXT = $8C89;  
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = $8C8A;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = $8C8B;  
  GL_INTERLEAVED_ATTRIBS_EXT = $8C8C;  
  GL_SEPARATE_ATTRIBS_EXT = $8C8D;  
  GL_TRANSFORM_FEEDBACK_BUFFER_EXT = $8C8E;  
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = $8C8F;  
type
  TPFNGLBEGINTRANSFORMFEEDBACKEXTPROC = procedure (primitiveMode:TGLenum);cdecl;
  TPFNGLBINDBUFFERBASEEXTPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;
  TPFNGLBINDBUFFEROFFSETEXTPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr);cdecl;
  TPFNGLBINDBUFFERRANGEEXTPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLENDTRANSFORMFEEDBACKEXTPROC = procedure (para1:pointer);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC = procedure (prog:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei;                _type:PGLenum; name:PGLchar);cdecl;
  TPFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC = procedure (prog:TGLuint; count:TGLsizei; varyings:PPGLchar; bufferMode:TGLenum);cdecl;


{ ------------------------- GL_EXT_unpack_subimage ------------------------  }

const
  GL_EXT_unpack_subimage = 1;  
  GL_UNPACK_ROW_LENGTH_EXT = $0CF2;  
  GL_UNPACK_SKIP_ROWS_EXT = $0CF3;  
  GL_UNPACK_SKIP_PIXELS_EXT = $0CF4;  


{ -------------------------- GL_EXT_vertex_array --------------------------  }

const
  GL_EXT_vertex_array = 1;  
  GL_DOUBLE_EXT = $140A;  
  GL_VERTEX_ARRAY_EXT = $8074;  
  GL_NORMAL_ARRAY_EXT = $8075;  
  GL_COLOR_ARRAY_EXT = $8076;  
  GL_INDEX_ARRAY_EXT = $8077;  
  GL_TEXTURE_COORD_ARRAY_EXT = $8078;  
  GL_EDGE_FLAG_ARRAY_EXT = $8079;  
  GL_VERTEX_ARRAY_SIZE_EXT = $807A;  
  GL_VERTEX_ARRAY_TYPE_EXT = $807B;  
  GL_VERTEX_ARRAY_STRIDE_EXT = $807C;  
  GL_VERTEX_ARRAY_COUNT_EXT = $807D;  
  GL_NORMAL_ARRAY_TYPE_EXT = $807E;  
  GL_NORMAL_ARRAY_STRIDE_EXT = $807F;  
  GL_NORMAL_ARRAY_COUNT_EXT = $8080;  
  GL_COLOR_ARRAY_SIZE_EXT = $8081;  
  GL_COLOR_ARRAY_TYPE_EXT = $8082;  
  GL_COLOR_ARRAY_STRIDE_EXT = $8083;  
  GL_COLOR_ARRAY_COUNT_EXT = $8084;  
  GL_INDEX_ARRAY_TYPE_EXT = $8085;  
  GL_INDEX_ARRAY_STRIDE_EXT = $8086;  
  GL_INDEX_ARRAY_COUNT_EXT = $8087;  
  GL_TEXTURE_COORD_ARRAY_SIZE_EXT = $8088;  
  GL_TEXTURE_COORD_ARRAY_TYPE_EXT = $8089;  
  GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = $808A;  
  GL_TEXTURE_COORD_ARRAY_COUNT_EXT = $808B;  
  GL_EDGE_FLAG_ARRAY_STRIDE_EXT = $808C;  
  GL_EDGE_FLAG_ARRAY_COUNT_EXT = $808D;  
  GL_VERTEX_ARRAY_POINTER_EXT = $808E;  
  GL_NORMAL_ARRAY_POINTER_EXT = $808F;  
  GL_COLOR_ARRAY_POINTER_EXT = $8090;  
  GL_INDEX_ARRAY_POINTER_EXT = $8091;  
  GL_TEXTURE_COORD_ARRAY_POINTER_EXT = $8092;  
  GL_EDGE_FLAG_ARRAY_POINTER_EXT = $8093;  
type
  TPFNGLARRAYELEMENTEXTPROC = procedure (i:TGLint);cdecl;
  TPFNGLCOLORPOINTEREXTPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;
  TPFNGLDRAWARRAYSEXTPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei);cdecl;
  TPFNGLEDGEFLAGPOINTEREXTPROC = procedure (stride:TGLsizei; count:TGLsizei; pointer:PGLboolean);cdecl;
  TPFNGLINDEXPOINTEREXTPROC = procedure (_type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;
  TPFNGLNORMALPOINTEREXTPROC = procedure (_type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;
  TPFNGLTEXCOORDPOINTEREXTPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;
  TPFNGLVERTEXPOINTEREXTPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;


{ ------------------------ GL_EXT_vertex_array_bgra -----------------------  }

const
  GL_EXT_vertex_array_bgra = 1;  
//  GL_BGRA = $80E1;    doppelt


{ ----------------------- GL_EXT_vertex_array_setXXX ----------------------  }

const
  GL_EXT_vertex_array_setXXX = 1;  
type
  TPFNGLBINDARRAYSETEXTPROC = procedure (arrayset:pointer);cdecl;
  TPFNGLCREATEARRAYSETEXTPROC = function :pointer;cdecl;
  TPFNGLDELETEARRAYSETSEXTPROC = procedure (n:TGLsizei; arrayset:Ppointer);cdecl;


{ ----------------------- GL_EXT_vertex_attrib_64bit ----------------------  }

const
  GL_EXT_vertex_attrib_64bit = 1;  
  GL_DOUBLE_MAT2_EXT = $8F46;  
  GL_DOUBLE_MAT3_EXT = $8F47;  
  GL_DOUBLE_MAT4_EXT = $8F48;  
  GL_DOUBLE_MAT2x3_EXT = $8F49;  
  GL_DOUBLE_MAT2x4_EXT = $8F4A;  
  GL_DOUBLE_MAT3x2_EXT = $8F4B;  
  GL_DOUBLE_MAT3x4_EXT = $8F4C;  
  GL_DOUBLE_MAT4x2_EXT = $8F4D;  
  GL_DOUBLE_MAT4x3_EXT = $8F4E;  
  GL_DOUBLE_VEC2_EXT = $8FFC;  
  GL_DOUBLE_VEC3_EXT = $8FFD;  
  GL_DOUBLE_VEC4_EXT = $8FFE;  
type
  TPFNGLGETVERTEXATTRIBLDVEXTPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
 TPFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC = procedure (vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum;
                stride:TGLsizei; offset:TGLintptr);cdecl;
  TPFNGLVERTEXATTRIBL1DEXTPROC = procedure (index:TGLuint; x:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL1DVEXTPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL2DEXTPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL2DVEXTPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL3DEXTPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL3DVEXTPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL4DEXTPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIBL4DVEXTPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBLPOINTEREXTPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ -------------------------- GL_EXT_vertex_shader -------------------------  }

const
  GL_EXT_vertex_shader = 1;  
  GL_VERTEX_SHADER_EXT = $8780;  
  GL_VERTEX_SHADER_BINDING_EXT = $8781;  
  GL_OP_INDEX_EXT = $8782;  
  GL_OP_NEGATE_EXT = $8783;  
  GL_OP_DOT3_EXT = $8784;  
  GL_OP_DOT4_EXT = $8785;  
  GL_OP_MUL_EXT = $8786;  
  GL_OP_ADD_EXT = $8787;  
  GL_OP_MADD_EXT = $8788;  
  GL_OP_FRAC_EXT = $8789;  
  GL_OP_MAX_EXT = $878A;  
  GL_OP_MIN_EXT = $878B;  
  GL_OP_SET_GE_EXT = $878C;  
  GL_OP_SET_LT_EXT = $878D;  
  GL_OP_CLAMP_EXT = $878E;  
  GL_OP_FLOOR_EXT = $878F;  
  GL_OP_ROUND_EXT = $8790;  
  GL_OP_EXP_BASE_2_EXT = $8791;  
  GL_OP_LOG_BASE_2_EXT = $8792;  
  GL_OP_POWER_EXT = $8793;  
  GL_OP_RECIP_EXT = $8794;  
  GL_OP_RECIP_SQRT_EXT = $8795;  
  GL_OP_SUB_EXT = $8796;  
  GL_OP_CROSS_PRODUCT_EXT = $8797;  
  GL_OP_MULTIPLY_MATRIX_EXT = $8798;  
  GL_OP_MOV_EXT = $8799;  
  GL_OUTPUT_VERTEX_EXT = $879A;  
  GL_OUTPUT_COLOR0_EXT = $879B;  
  GL_OUTPUT_COLOR1_EXT = $879C;  
  GL_OUTPUT_TEXTURE_COORD0_EXT = $879D;  
  GL_OUTPUT_TEXTURE_COORD1_EXT = $879E;  
  GL_OUTPUT_TEXTURE_COORD2_EXT = $879F;  
  GL_OUTPUT_TEXTURE_COORD3_EXT = $87A0;  
  GL_OUTPUT_TEXTURE_COORD4_EXT = $87A1;  
  GL_OUTPUT_TEXTURE_COORD5_EXT = $87A2;  
  GL_OUTPUT_TEXTURE_COORD6_EXT = $87A3;  
  GL_OUTPUT_TEXTURE_COORD7_EXT = $87A4;  
  GL_OUTPUT_TEXTURE_COORD8_EXT = $87A5;  
  GL_OUTPUT_TEXTURE_COORD9_EXT = $87A6;  
  GL_OUTPUT_TEXTURE_COORD10_EXT = $87A7;  
  GL_OUTPUT_TEXTURE_COORD11_EXT = $87A8;  
  GL_OUTPUT_TEXTURE_COORD12_EXT = $87A9;  
  GL_OUTPUT_TEXTURE_COORD13_EXT = $87AA;  
  GL_OUTPUT_TEXTURE_COORD14_EXT = $87AB;  
  GL_OUTPUT_TEXTURE_COORD15_EXT = $87AC;  
  GL_OUTPUT_TEXTURE_COORD16_EXT = $87AD;  
  GL_OUTPUT_TEXTURE_COORD17_EXT = $87AE;  
  GL_OUTPUT_TEXTURE_COORD18_EXT = $87AF;  
  GL_OUTPUT_TEXTURE_COORD19_EXT = $87B0;  
  GL_OUTPUT_TEXTURE_COORD20_EXT = $87B1;  
  GL_OUTPUT_TEXTURE_COORD21_EXT = $87B2;  
  GL_OUTPUT_TEXTURE_COORD22_EXT = $87B3;  
  GL_OUTPUT_TEXTURE_COORD23_EXT = $87B4;  
  GL_OUTPUT_TEXTURE_COORD24_EXT = $87B5;  
  GL_OUTPUT_TEXTURE_COORD25_EXT = $87B6;  
  GL_OUTPUT_TEXTURE_COORD26_EXT = $87B7;  
  GL_OUTPUT_TEXTURE_COORD27_EXT = $87B8;  
  GL_OUTPUT_TEXTURE_COORD28_EXT = $87B9;  
  GL_OUTPUT_TEXTURE_COORD29_EXT = $87BA;  
  GL_OUTPUT_TEXTURE_COORD30_EXT = $87BB;  
  GL_OUTPUT_TEXTURE_COORD31_EXT = $87BC;  
  GL_OUTPUT_FOG_EXT = $87BD;  
  GL_SCALAR_EXT = $87BE;  
  GL_VECTOR_EXT = $87BF;  
  GL_MATRIX_EXT = $87C0;  
  GL_VARIANT_EXT = $87C1;  
  GL_INVARIANT_EXT = $87C2;  
  GL_LOCAL_CONSTANT_EXT = $87C3;  
  GL_LOCAL_EXT = $87C4;  
  GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = $87C5;  
  GL_MAX_VERTEX_SHADER_VARIANTS_EXT = $87C6;  
  GL_MAX_VERTEX_SHADER_INVARIANTS_EXT = $87C7;  
  GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87C8;  
  GL_MAX_VERTEX_SHADER_LOCALS_EXT = $87C9;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CA;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = $87CB;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = $87CC;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87CD;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = $87CE;  
  GL_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CF;  
  GL_VERTEX_SHADER_VARIANTS_EXT = $87D0;  
  GL_VERTEX_SHADER_INVARIANTS_EXT = $87D1;  
  GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87D2;  
  GL_VERTEX_SHADER_LOCALS_EXT = $87D3;  
  GL_VERTEX_SHADER_OPTIMIZED_EXT = $87D4;  
  GL_X_EXT = $87D5;  
  GL_Y_EXT = $87D6;  
  GL_Z_EXT = $87D7;  
  GL_W_EXT = $87D8;  
  GL_NEGATIVE_X_EXT = $87D9;  
  GL_NEGATIVE_Y_EXT = $87DA;  
  GL_NEGATIVE_Z_EXT = $87DB;  
  GL_NEGATIVE_W_EXT = $87DC;  
  GL_ZERO_EXT = $87DD;  
  GL_ONE_EXT = $87DE;  
  GL_NEGATIVE_ONE_EXT = $87DF;  
  GL_NORMALIZED_RANGE_EXT = $87E0;  
  GL_FULL_RANGE_EXT = $87E1;  
  GL_CURRENT_VERTEX_EXT = $87E2;  
  GL_MVP_MATRIX_EXT = $87E3;  
  GL_VARIANT_VALUE_EXT = $87E4;  
  GL_VARIANT_DATATYPE_EXT = $87E5;  
  GL_VARIANT_ARRAY_STRIDE_EXT = $87E6;  
  GL_VARIANT_ARRAY_TYPE_EXT = $87E7;  
  GL_VARIANT_ARRAY_EXT = $87E8;  
  GL_VARIANT_ARRAY_POINTER_EXT = $87E9;  
  GL_INVARIANT_VALUE_EXT = $87EA;  
  GL_INVARIANT_DATATYPE_EXT = $87EB;  
  GL_LOCAL_CONSTANT_VALUE_EXT = $87EC;  
  GL_LOCAL_CONSTANT_DATATYPE_EXT = $87ED;  
type
  TPFNGLBEGINVERTEXSHADEREXTPROC = procedure (para1:pointer);cdecl;
  TPFNGLBINDLIGHTPARAMETEREXTPROC = function (light:TGLenum; value:TGLenum):TGLuint;cdecl;
  TPFNGLBINDMATERIALPARAMETEREXTPROC = function (face:TGLenum; value:TGLenum):TGLuint;cdecl;
  TPFNGLBINDPARAMETEREXTPROC = function (value:TGLenum):TGLuint;cdecl;
  TPFNGLBINDTEXGENPARAMETEREXTPROC = function (unit_:TGLenum; coord:TGLenum; value:TGLenum):TGLuint;cdecl;
  TPFNGLBINDTEXTUREUNITPARAMETEREXTPROC = function (unit_:TGLenum; value:TGLenum):TGLuint;cdecl;
  TPFNGLBINDVERTEXSHADEREXTPROC = procedure (id:TGLuint);cdecl;
  TPFNGLDELETEVERTEXSHADEREXTPROC = procedure (id:TGLuint);cdecl;
  TPFNGLDISABLEVARIANTCLIENTSTATEEXTPROC = procedure (id:TGLuint);cdecl;
  TPFNGLENABLEVARIANTCLIENTSTATEEXTPROC = procedure (id:TGLuint);cdecl;
  TPFNGLENDVERTEXSHADEREXTPROC = procedure (para1:pointer);cdecl;
  TPFNGLEXTRACTCOMPONENTEXTPROC = procedure (res:TGLuint; src:TGLuint; num:TGLuint);cdecl;
  TPFNGLGENSYMBOLSEXTPROC = function (dataType:TGLenum; storageType:TGLenum; range:TGLenum; components:TGLuint):TGLuint;cdecl;
  TPFNGLGENVERTEXSHADERSEXTPROC = function (range:TGLuint):TGLuint;cdecl;
  TPFNGLGETINVARIANTBOOLEANVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;
  TPFNGLGETINVARIANTFLOATVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;
  TPFNGLGETINVARIANTINTEGERVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLint);cdecl;
  TPFNGLGETLOCALCONSTANTBOOLEANVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;
  TPFNGLGETLOCALCONSTANTFLOATVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;
  TPFNGLGETLOCALCONSTANTINTEGERVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLint);cdecl;
  TPFNGLGETVARIANTBOOLEANVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;
  TPFNGLGETVARIANTFLOATVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;
  TPFNGLGETVARIANTINTEGERVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:PGLint);cdecl;
  TPFNGLGETVARIANTPOINTERVEXTPROC = procedure (id:TGLuint; value:TGLenum; data:Ppointer);cdecl;
  TPFNGLINSERTCOMPONENTEXTPROC = procedure (res:TGLuint; src:TGLuint; num:TGLuint);cdecl;
  TPFNGLISVARIANTENABLEDEXTPROC = function (id:TGLuint; cap:TGLenum):TGLboolean;cdecl;
  TPFNGLSETINVARIANTEXTPROC = procedure (id:TGLuint; _type:TGLenum; addr:pointer);cdecl;
  TPFNGLSETLOCALCONSTANTEXTPROC = procedure (id:TGLuint; _type:TGLenum; addr:pointer);cdecl;
  TPFNGLSHADEROP1EXTPROC = procedure (op:TGLenum; res:TGLuint; arg1:TGLuint);cdecl;
  TPFNGLSHADEROP2EXTPROC = procedure (op:TGLenum; res:TGLuint; arg1:TGLuint; arg2:TGLuint);cdecl;
  TPFNGLSHADEROP3EXTPROC = procedure (op:TGLenum; res:TGLuint; arg1:TGLuint; arg2:TGLuint; arg3:TGLuint);cdecl;
  TPFNGLSWIZZLEEXTPROC = procedure (res:TGLuint; in_:TGLuint; outX:TGLenum; outY:TGLenum; outZ:TGLenum;                outW:TGLenum);cdecl;
  TPFNGLVARIANTPOINTEREXTPROC = procedure (id:TGLuint; _type:TGLenum; stride:TGLuint; addr:pointer);cdecl;
  TPFNGLVARIANTBVEXTPROC = procedure (id:TGLuint; addr:PGLbyte);cdecl;
  TPFNGLVARIANTDVEXTPROC = procedure (id:TGLuint; addr:PGLdouble);cdecl;
  TPFNGLVARIANTFVEXTPROC = procedure (id:TGLuint; addr:PGLfloat);cdecl;
  TPFNGLVARIANTIVEXTPROC = procedure (id:TGLuint; addr:PGLint);cdecl;
  TPFNGLVARIANTSVEXTPROC = procedure (id:TGLuint; addr:PGLshort);cdecl;
  TPFNGLVARIANTUBVEXTPROC = procedure (id:TGLuint; addr:PGLubyte);cdecl;
  TPFNGLVARIANTUIVEXTPROC = procedure (id:TGLuint; addr:PGLuint);cdecl;
  TPFNGLVARIANTUSVEXTPROC = procedure (id:TGLuint; addr:PGLushort);cdecl;
  TPFNGLWRITEMASKEXTPROC = procedure (res:TGLuint; in_:TGLuint; outX:TGLenum; outY:TGLenum; outZ:TGLenum;                outW:TGLenum);cdecl;


{ ------------------------ GL_EXT_vertex_weighting ------------------------  }

const
  GL_EXT_vertex_weighting = 1;  
  GL_MODELVIEW0_STACK_DEPTH_EXT = $0BA3;  
  GL_MODELVIEW0_MATRIX_EXT = $0BA6;  
  GL_MODELVIEW0_EXT = $1700;  
  GL_MODELVIEW1_STACK_DEPTH_EXT = $8502;  
  GL_MODELVIEW1_MATRIX_EXT = $8506;  
  GL_VERTEX_WEIGHTING_EXT = $8509;  
  GL_MODELVIEW1_EXT = $850A;  
  GL_CURRENT_VERTEX_WEIGHT_EXT = $850B;  
  GL_VERTEX_WEIGHT_ARRAY_EXT = $850C;  
  GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = $850D;  
  GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = $850E;  
  GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = $850F;  
  GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = $8510;  
type
  TPFNGLVERTEXWEIGHTPOINTEREXTPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLVERTEXWEIGHTFEXTPROC = procedure (weight:TGLfloat);cdecl;
  TPFNGLVERTEXWEIGHTFVEXTPROC = procedure (weight:PGLfloat);cdecl;


{ ------------------------ GL_EXT_win32_keyed_mutex -----------------------  }

const
  GL_EXT_win32_keyed_mutex = 1;  
type
  TPFNGLACQUIREKEYEDMUTEXWIN32EXTPROC = function (memory:TGLuint; key:TGLuint64; timeout:TGLuint):TGLboolean;cdecl;
  TPFNGLRELEASEKEYEDMUTEXWIN32EXTPROC = function (memory:TGLuint; key:TGLuint64):TGLboolean;cdecl;


{ ------------------------ GL_EXT_window_rectangles -----------------------  }

const
  GL_EXT_window_rectangles = 1;  
  GL_INCLUSIVE_EXT = $8F10;  
  GL_EXCLUSIVE_EXT = $8F11;  
  GL_WINDOW_RECTANGLE_EXT = $8F12;  
  GL_WINDOW_RECTANGLE_MODE_EXT = $8F13;  
  GL_MAX_WINDOW_RECTANGLES_EXT = $8F14;  
  GL_NUM_WINDOW_RECTANGLES_EXT = $8F15;  
type
  TPFNGLWINDOWRECTANGLESEXTPROC = procedure (mode:TGLenum; count:TGLsizei; box:PGLint);cdecl;


{ ------------------------- GL_EXT_x11_sync_object ------------------------  }

const
  GL_EXT_x11_sync_object = 1;  
  GL_SYNC_X11_FENCE_EXT = $90E1;  
type
  TPFNGLIMPORTSYNCEXTPROC = function (external_sync_type:TGLenum; external_sync:TGLintptr; flags:TGLbitfield):TGLsync;cdecl;


{ ----------------------- GL_FJ_shader_binary_GCCSO -----------------------  }

const
  GL_FJ_shader_binary_GCCSO = 1;  
  GL_GCCSO_SHADER_BINARY_FJ = $9260;  


{ ---------------------- GL_GREMEDY_frame_terminator ----------------------  }

const
  GL_GREMEDY_frame_terminator = 1;  
type

  TPFNGLFRAMETERMINATORGREMEDYPROC = procedure (para1:pointer);cdecl;


{ ------------------------ GL_GREMEDY_string_marker -----------------------  }

const
  GL_GREMEDY_string_marker = 1;  
type
  TPFNGLSTRINGMARKERGREMEDYPROC = procedure (len:TGLsizei; _string:pointer);cdecl;


{ --------------------- GL_HP_convolution_border_modes --------------------  }

const
  GL_HP_convolution_border_modes = 1;  


{ ------------------------- GL_HP_image_transform -------------------------  }

const
  GL_HP_image_transform = 1;  
type
  TPFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLIMAGETRANSFORMPARAMETERFHPPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLIMAGETRANSFORMPARAMETERFVHPPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLIMAGETRANSFORMPARAMETERIHPPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLIMAGETRANSFORMPARAMETERIVHPPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ -------------------------- GL_HP_occlusion_test -------------------------  }

const
  GL_HP_occlusion_test = 1;  


{ ------------------------- GL_HP_texture_lighting ------------------------  }

const
  GL_HP_texture_lighting = 1;  


{ --------------------------- GL_IBM_cull_vertex --------------------------  }

const
  GL_IBM_cull_vertex = 1;  
  GL_CULL_VERTEX_IBM = 103050;  


{ ---------------------- GL_IBM_multimode_draw_arrays ---------------------  }

const
  GL_IBM_multimode_draw_arrays = 1;  
type
  TPFNGLMULTIMODEDRAWARRAYSIBMPROC = procedure (mode:PGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei; modestride:TGLint);cdecl;
  TPFNGLMULTIMODEDRAWELEMENTSIBMPROC = procedure (mode:PGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; primcount:TGLsizei;                modestride:TGLint);cdecl;


{ ------------------------- GL_IBM_rasterpos_clip -------------------------  }

const
  GL_IBM_rasterpos_clip = 1;  
  GL_RASTER_POSITION_UNCLIPPED_IBM = 103010;  


{ --------------------------- GL_IBM_static_data --------------------------  }

const
  GL_IBM_static_data = 1;  
  GL_ALL_STATIC_DATA_IBM = 103060;  
  GL_STATIC_VERTEX_ARRAY_IBM = 103061;  


{ --------------------- GL_IBM_texture_mirrored_repeat --------------------  }

const
  GL_IBM_texture_mirrored_repeat = 1;  
  GL_MIRRORED_REPEAT_IBM = $8370;  


{ ----------------------- GL_IBM_vertex_array_lists -----------------------  }

const
  GL_IBM_vertex_array_lists = 1;  
  GL_VERTEX_ARRAY_LIST_IBM = 103070;  
  GL_NORMAL_ARRAY_LIST_IBM = 103071;  
  GL_COLOR_ARRAY_LIST_IBM = 103072;  
  GL_INDEX_ARRAY_LIST_IBM = 103073;  
  GL_TEXTURE_COORD_ARRAY_LIST_IBM = 103074;  
  GL_EDGE_FLAG_ARRAY_LIST_IBM = 103075;  
  GL_FOG_COORDINATE_ARRAY_LIST_IBM = 103076;  
  GL_SECONDARY_COLOR_ARRAY_LIST_IBM = 103077;  
  GL_VERTEX_ARRAY_LIST_STRIDE_IBM = 103080;  
  GL_NORMAL_ARRAY_LIST_STRIDE_IBM = 103081;  
  GL_COLOR_ARRAY_LIST_STRIDE_IBM = 103082;  
  GL_INDEX_ARRAY_LIST_STRIDE_IBM = 103083;  
  GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103084;  
  GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103085;  
  GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103086;  
  GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103087;  
type
  TPFNGLCOLORPOINTERLISTIBMPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLEDGEFLAGPOINTERLISTIBMPROC = procedure (stride:TGLint; pointer:PPGLboolean; ptrstride:TGLint);cdecl;
  TPFNGLFOGCOORDPOINTERLISTIBMPROC = procedure (_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLINDEXPOINTERLISTIBMPROC = procedure (_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLNORMALPOINTERLISTIBMPROC = procedure (_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLSECONDARYCOLORPOINTERLISTIBMPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLTEXCOORDPOINTERLISTIBMPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;
  TPFNGLVERTEXPOINTERLISTIBMPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;


{ ------------------------ GL_IMG_bindless_texture ------------------------  }

const
  GL_IMG_bindless_texture = 1;  
type
  TPFNGLGETTEXTUREHANDLEIMGPROC = function (texture:TGLuint):TGLuint64;cdecl;
  TPFNGLGETTEXTURESAMPLERHANDLEIMGPROC = function (texture:TGLuint; sampler:TGLuint):TGLuint64;cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64IMGPROC = procedure (prog:TGLuint; location:TGLint; value:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64VIMGPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; values:PGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64IMGPROC = procedure (location:TGLint; value:TGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64VIMGPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;


{ --------------------- GL_IMG_framebuffer_downsample ---------------------  }

const
  GL_IMG_framebuffer_downsample = 1;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_AND_DOWNSAMPLE_IMG = $913C;  
  GL_NUM_DOWNSAMPLE_SCALES_IMG = $913D;  
  GL_DOWNSAMPLE_SCALES_IMG = $913E;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_SCALE_IMG = $913F;  
type
  TPFNGLFRAMEBUFFERTEXTURE2DDOWNSAMPLEIMGPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;                xscale:TGLint; yscale:TGLint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURELAYERDOWNSAMPLEIMGPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint;                xscale:TGLint; yscale:TGLint);cdecl;


{ ----------------- GL_IMG_multisampled_render_to_texture -----------------  }

const
  GL_IMG_multisampled_render_to_texture = 1;  
  GL_RENDERBUFFER_SAMPLES_IMG = $9133;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_IMG = $9134;  
  GL_MAX_SAMPLES_IMG = $9135;  
  GL_TEXTURE_SAMPLES_IMG = $9136;  
type
  TPFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMGPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;                samples:TGLsizei);cdecl;
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMGPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ------------------------- GL_IMG_program_binary -------------------------  }

const
  GL_IMG_program_binary = 1;  
  GL_SGX_PROGRAM_BINARY_IMG = $9130;  

  //GL_FLOAT16_VEC2_NV = $8FF9;
  //GL_FLOAT16_VEC3_NV = $8FFA;
  //GL_FLOAT16_VEC4_NV = $8FFB;  turn type might be wrong }

{ --------------------------- GL_IMG_read_format --------------------------  }

const
  GL_IMG_read_format = 1;  
  GL_BGRA_IMG = $80E1;  
  GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG = $8365;  


{ -------------------------- GL_IMG_shader_binary -------------------------  }

const
  GL_IMG_shader_binary = 1;  
  GL_SGX_BINARY_IMG = $8C0A;  


{ -------------------- GL_IMG_texture_compression_pvrtc -------------------  }

const
  GL_IMG_texture_compression_pvrtc = 1;  
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG = $8C00;  
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG = $8C01;  
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG = $8C02;  
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG = $8C03;  


{ ------------------- GL_IMG_texture_compression_pvrtc2 -------------------  }

const
  GL_IMG_texture_compression_pvrtc2 = 1;  
  GL_COMPRESSED_RGBA_PVRTC_2BPPV2_IMG = $9137;  
  GL_COMPRESSED_RGBA_PVRTC_4BPPV2_IMG = $9138;  


{ --------------- GL_IMG_texture_env_enhanced_fixed_function --------------  }

const
  GL_IMG_texture_env_enhanced_fixed_function = 1;  
  GL_DOT3_RGBA_IMG = $86AF;  
  GL_MODULATE_COLOR_IMG = $8C04;  
  GL_RECIP_ADD_SIGNED_ALPHA_IMG = $8C05;  
  GL_TEXTURE_ALPHA_MODULATE_IMG = $8C06;  
  GL_FACTOR_ALPHA_MODULATE_IMG = $8C07;  
  GL_FRAGMENT_ALPHA_MODULATE_IMG = $8C08;  
  GL_ADD_BLEND_IMG = $8C09;  


{ ---------------------- GL_IMG_texture_filter_cubic ----------------------  }

const
  GL_IMG_texture_filter_cubic = 1;  
  GL_CUBIC_IMG = $9139;  
  GL_CUBIC_MIPMAP_NEAREST_IMG = $913A;  
  GL_CUBIC_MIPMAP_LINEAR_IMG = $913B;  


{ -------------------------- GL_INGR_color_clamp --------------------------  }

const
  GL_INGR_color_clamp = 1;  
  GL_RED_MIN_CLAMP_INGR = $8560;  
  GL_GREEN_MIN_CLAMP_INGR = $8561;  
  GL_BLUE_MIN_CLAMP_INGR = $8562;  
  GL_ALPHA_MIN_CLAMP_INGR = $8563;  
  GL_RED_MAX_CLAMP_INGR = $8564;  
  GL_GREEN_MAX_CLAMP_INGR = $8565;  
  GL_BLUE_MAX_CLAMP_INGR = $8566;  
  GL_ALPHA_MAX_CLAMP_INGR = $8567;  


{ ------------------------- GL_INGR_interlace_read ------------------------  }

const
  GL_INGR_interlace_read = 1;  
  GL_INTERLACE_READ_INGR = $8568;  


{ ----------------------- GL_INTEL_blackhole_render -----------------------  }

const
  GL_INTEL_blackhole_render = 1;  
  GL_BLACKHOLE_RENDER_INTEL = $83FC;  


{ ------------------ GL_INTEL_conservative_rasterization ------------------  }

const
  GL_INTEL_conservative_rasterization = 1;  
  GL_CONSERVATIVE_RASTERIZATION_INTEL = $83FE;  


{ ------------------- GL_INTEL_fragment_shader_ordering -------------------  }

const
  GL_INTEL_fragment_shader_ordering = 1;  


{ ----------------------- GL_INTEL_framebuffer_CMAA -----------------------  }

const
  GL_INTEL_framebuffer_CMAA = 1;  


{ -------------------------- GL_INTEL_map_texture -------------------------  }

const
  GL_INTEL_map_texture = 1;  
  GL_LAYOUT_DEFAULT_INTEL = 0;  
  GL_LAYOUT_LINEAR_INTEL = 1;  
  GL_LAYOUT_LINEAR_CPU_CACHED_INTEL = 2;  
  GL_TEXTURE_MEMORY_LAYOUT_INTEL = $83FF;         //GL_FLOAT16_NV = $8FF8;
  //GL_FLOAT16_VEC2_NV = $8FF9;
  //GL_FLOAT16_VEC3_NV = $8FFA;
  //GL_FLOAT16_VEC4_NV = $8FFB;
type
  TPFNGLMAPTEXTURE2DINTELPROC = function (texture:TGLuint; level:TGLint; access:TGLbitfield; stride:PGLint; layout:PGLenum):pointer;cdecl;
  TPFNGLSYNCTEXTUREINTELPROC = procedure (texture:TGLuint);cdecl;
  TPFNGLUNMAPTEXTURE2DINTELPROC = procedure (texture:TGLuint; level:TGLint);cdecl;


{ ------------------------ GL_INTEL_parallel_arrays -----------------------  }

const
  GL_INTEL_parallel_arrays = 1;  
  GL_PARALLEL_ARRAYS_INTEL = $83F4;  
  GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = $83F5;  
  GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = $83F6;  
  GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = $83F7;  
  GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = $83F8;  
type
  TPFNGLCOLORPOINTERVINTELPROC = procedure (size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLNORMALPOINTERVINTELPROC = procedure (_type:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLTEXCOORDPOINTERVINTELPROC = procedure (size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLVERTEXPOINTERVINTELPROC = procedure (size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;


{ ----------------------- GL_INTEL_performance_query ----------------------  }

const
  GL_INTEL_performance_query = 1;  
  GL_PERFQUERY_SINGLE_CONTEXT_INTEL = $0000;  
  GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = $0001;  
  GL_PERFQUERY_DONOT_FLUSH_INTEL = $83F9;  
  GL_PERFQUERY_FLUSH_INTEL = $83FA;  
  GL_PERFQUERY_WAIT_INTEL = $83FB;  
  GL_PERFQUERY_COUNTER_EVENT_INTEL = $94F0;  
  GL_PERFQUERY_COUNTER_DURATION_NORM_INTEL = $94F1;  
  GL_PERFQUERY_COUNTER_DURATION_RAW_INTEL = $94F2;  
  GL_PERFQUERY_COUNTER_THROUGHPUT_INTEL = $94F3;  
  GL_PERFQUERY_COUNTER_RAW_INTEL = $94F4;  
  GL_PERFQUERY_COUNTER_TIMESTAMP_INTEL = $94F5;  
  GL_PERFQUERY_COUNTER_DATA_UINT32_INTEL = $94F8;  
  GL_PERFQUERY_COUNTER_DATA_UINT64_INTEL = $94F9;  
  GL_PERFQUERY_COUNTER_DATA_FLOAT_INTEL = $94FA;  
  GL_PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = $94FB;  
  GL_PERFQUERY_COUNTER_DATA_BOOL32_INTEL = $94FC;  
  GL_PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = $94FD;  
  GL_PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = $94FE;  
  GL_PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = $94FF;  
  GL_PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = $9500;  
type
  TPFNGLBEGINPERFQUERYINTELPROC = procedure (queryHandle:TGLuint);cdecl;
  TPFNGLCREATEPERFQUERYINTELPROC = procedure (queryId:TGLuint; queryHandle:PGLuint);cdecl;
  TPFNGLDELETEPERFQUERYINTELPROC = procedure (queryHandle:TGLuint);cdecl;
  TPFNGLENDPERFQUERYINTELPROC = procedure (queryHandle:TGLuint);cdecl;
  TPFNGLGETFIRSTPERFQUERYIDINTELPROC = procedure (queryId:PGLuint);cdecl;
  TPFNGLGETNEXTPERFQUERYIDINTELPROC = procedure (queryId:TGLuint; nextQueryId:PGLuint);cdecl;
  TPFNGLGETPERFCOUNTERINFOINTELPROC = procedure (queryId:TGLuint; counterId:TGLuint; counterNameLength:TGLuint; counterName:PGLchar; counterDescLength:TGLuint;
                counterDesc:PGLchar; counterOffset:PGLuint; counterDataSize:PGLuint; counterTypeEnum:PGLuint; counterDataTypeEnum:PGLuint; 
                rawCounterMaxValue:PGLuint64);cdecl;
  TPFNGLGETPERFQUERYDATAINTELPROC = procedure (queryHandle:TGLuint; flags:TGLuint; dataSize:TGLsizei; data:pointer; bytesWritten:PGLuint);cdecl;
  TPFNGLGETPERFQUERYIDBYNAMEINTELPROC = procedure (queryName:PGLchar; queryId:PGLuint);cdecl;
  TPFNGLGETPERFQUERYINFOINTELPROC = procedure (queryId:TGLuint; queryNameLength:TGLuint; queryName:PGLchar; dataSize:PGLuint; noCounters:PGLuint;
                noInstances:PGLuint; capsMask:PGLuint);cdecl;


{ ------------------- GL_INTEL_shader_integer_functions2 ------------------  }

const
  GL_INTEL_shader_integer_functions2 = 1;  


{ ------------------------ GL_INTEL_texture_scissor -----------------------  }

const
  GL_INTEL_texture_scissor = 1;  
type
  TPFNGLTEXSCISSORFUNCINTELPROC = procedure (target:TGLenum; lfunc:TGLenum; hfunc:TGLenum);cdecl;
  TPFNGLTEXSCISSORINTELPROC = procedure (target:TGLenum; tlow:TGLclampf; thigh:TGLclampf);cdecl;


{ --------------------- GL_KHR_blend_equation_advanced --------------------  }

const
  GL_KHR_blend_equation_advanced = 1;  
  GL_BLEND_ADVANCED_COHERENT_KHR = $9285;  
  GL_MULTIPLY_KHR = $9294;  
  GL_SCREEN_KHR = $9295;  
  GL_OVERLAY_KHR = $9296;  
  GL_DARKEN_KHR = $9297;  
  GL_LIGHTEN_KHR = $9298;  
  GL_COLORDODGE_KHR = $9299;  
  GL_COLORBURN_KHR = $929A;  
  GL_HARDLIGHT_KHR = $929B;  
  GL_SOFTLIGHT_KHR = $929C;  
  GL_DIFFERENCE_KHR = $929E;  
  GL_EXCLUSION_KHR = $92A0;  
  GL_HSL_HUE_KHR = $92AD;  
  GL_HSL_SATURATION_KHR = $92AE;  
  GL_HSL_COLOR_KHR = $92AF;  
  GL_HSL_LUMINOSITY_KHR = $92B0;  
type
  TPFNGLBLENDBARRIERKHRPROC = procedure (para1:pointer);cdecl;


{ ---------------- GL_KHR_blend_equation_advanced_coherent ----------------  }

const
  GL_KHR_blend_equation_advanced_coherent = 1;  


{ ---------------------- GL_KHR_context_flush_control ---------------------  }

const
  GL_KHR_context_flush_control = 1;  
  GL_CONTEXT_RELEASE_BEHAVIOR = $82FB;  
  GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = $82FC;  


{ ------------------------------ GL_KHR_debug -----------------------------  }

const
  GL_KHR_debug = 1;  
  GL_CONTEXT_FLAG_DEBUG_BIT = $00000002;  
//  GL_STACK_OVERFLOW = $0503;  doppelt
//  GL_STACK_UNDERFLOW = $0504;  
  GL_DEBUG_OUTPUT_SYNCHRONOUS = $8242;  
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = $8243;  
  GL_DEBUG_CALLBACK_FUNCTION = $8244;  
  GL_DEBUG_CALLBACK_USER_PARAM = $8245;  
  GL_DEBUG_SOURCE_API = $8246;  
  GL_DEBUG_SOURCE_WINDOW_SYSTEM = $8247;  
  GL_DEBUG_SOURCE_SHADER_COMPILER = $8248;  
  GL_DEBUG_SOURCE_THIRD_PARTY = $8249;  
  GL_DEBUG_SOURCE_APPLICATION = $824A;  
  GL_DEBUG_SOURCE_OTHER = $824B;  
  GL_DEBUG_TYPE_ERROR = $824C;  
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = $824D;  
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR = $824E;  
  GL_DEBUG_TYPE_PORTABILITY = $824F;  
  GL_DEBUG_TYPE_PERFORMANCE = $8250;  
  GL_DEBUG_TYPE_OTHER = $8251;  
  GL_DEBUG_TYPE_MARKER = $8268;  
  GL_DEBUG_TYPE_PUSH_GROUP = $8269;  
  GL_DEBUG_TYPE_POP_GROUP = $826A;  
  GL_DEBUG_SEVERITY_NOTIFICATION = $826B;  
  GL_MAX_DEBUG_GROUP_STACK_DEPTH = $826C;  
  GL_DEBUG_GROUP_STACK_DEPTH = $826D;  
  GL_BUFFER = $82E0;  
  GL_SHADER = $82E1;  
  GL_PROGRAM = $82E2;  
  GL_QUERY = $82E3;  
  GL_PROGRAM_PIPELINE = $82E4;  
  GL_SAMPLER = $82E6;  
  GL_DISPLAY_LIST = $82E7;  
  GL_MAX_LABEL_LENGTH = $82E8;  
  GL_MAX_DEBUG_MESSAGE_LENGTH = $9143;  
  GL_MAX_DEBUG_LOGGED_MESSAGES = $9144;  
  GL_DEBUG_LOGGED_MESSAGES = $9145;  
  GL_DEBUG_SEVERITY_HIGH = $9146;  
  GL_DEBUG_SEVERITY_MEDIUM = $9147;  
  GL_DEBUG_SEVERITY_LOW = $9148;  
  GL_DEBUG_OUTPUT = $92E0;  
type
  TGLDEBUGPROC = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei;
                message:PGLchar; userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGECALLBACKPROC = procedure (callback:TGLDEBUGPROC; userParam:pointer);cdecl;
  TPFNGLDEBUGMESSAGECONTROLPROC = procedure (source:TGLenum; _type:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint;
                enabled:TGLboolean);cdecl;
  TPFNGLDEBUGMESSAGEINSERTPROC = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei;
                buf:PGLchar);cdecl;
  TPFNGLGETDEBUGMESSAGELOGPROC = function (count:TGLuint; bufSize:TGLsizei; sources:PGLenum; types:PGLenum; ids:PGLuint;
               severities:PGLenum; lengths:PGLsizei; messageLog:PGLchar):TGLuint;cdecl;
  TPFNGLGETOBJECTLABELPROC = procedure (identifier:TGLenum; name:TGLuint; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;
  TPFNGLGETOBJECTPTRLABELPROC = procedure (ptr:pointer; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;
  TPFNGLOBJECTLABELPROC = procedure (identifier:TGLenum; name:TGLuint; length:TGLsizei; _label:PGLchar);cdecl;
  TPFNGLOBJECTPTRLABELPROC = procedure (ptr:pointer; length:TGLsizei; _label:PGLchar);cdecl;
  TPFNGLPOPDEBUGGROUPPROC = procedure (para1:pointer);cdecl;
  TPFNGLPUSHDEBUGGROUPPROC = procedure (source:TGLenum; id:TGLuint; length:TGLsizei; message:PGLchar);cdecl;


{ ---------------------------- GL_KHR_no_error ----------------------------  }

const
  GL_KHR_no_error = 1;  
  GL_CONTEXT_FLAG_NO_ERROR_BIT_KHR = $00000008;  


{ --------------------- GL_KHR_parallel_shader_compile --------------------  }

const
  GL_KHR_parallel_shader_compile = 1;  
  GL_MAX_SHADER_COMPILER_THREADS_KHR = $91B0;  
  GL_COMPLETION_STATUS_KHR = $91B1;  
type
  TPFNGLMAXSHADERCOMPILERTHREADSKHRPROC = procedure (count:TGLuint);cdecl;


{ ------------------ GL_KHR_robust_buffer_access_behavior -----------------  }

const
  GL_KHR_robust_buffer_access_behavior = 1;  


{ --------------------------- GL_KHR_robustness ---------------------------  }

const
  GL_KHR_robustness = 1;  
  GL_CONTEXT_LOST = $0507;  
  GL_LOSE_CONTEXT_ON_RESET = $8252;  
  GL_GUILTY_CONTEXT_RESET = $8253;  
  GL_INNOCENT_CONTEXT_RESET = $8254;  
  GL_UNKNOWN_CONTEXT_RESET = $8255;  
  GL_RESET_NOTIFICATION_STRATEGY = $8256;  
  GL_NO_RESET_NOTIFICATION = $8261;  
  GL_CONTEXT_ROBUST_ACCESS = $90F3;  
type
  TPFNGLGETNUNIFORMFVPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLGETNUNIFORMIVPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint);cdecl;
  TPFNGLGETNUNIFORMUIVPROC = procedure (prog:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint);cdecl;
  TPFNGLREADNPIXELSPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum;
                _type:TGLenum; bufSize:TGLsizei; data:pointer);cdecl;


{ ------------------------- GL_KHR_shader_subgroup ------------------------  }

const
  GL_KHR_shader_subgroup = 1;  
  GL_SUBGROUP_FEATURE_BASIC_BIT_KHR = $00000001;  
  GL_SUBGROUP_FEATURE_VOTE_BIT_KHR = $00000002;  
  GL_SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = $00000004;  
  GL_SUBGROUP_FEATURE_BALLOT_BIT_KHR = $00000008;  
  GL_SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = $00000010;  
  GL_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = $00000020;  
  GL_SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = $00000040;  
  GL_SUBGROUP_FEATURE_QUAD_BIT_KHR = $00000080;  
  GL_SUBGROUP_SIZE_KHR = $9532;  
  GL_SUBGROUP_SUPPORTED_STAGES_KHR = $9533;  
  GL_SUBGROUP_SUPPORTED_FEATURES_KHR = $9534;  
  GL_SUBGROUP_QUAD_ALL_STAGES_KHR = $9535;  


{ ------------------ GL_KHR_texture_compression_astc_hdr ------------------  }

const
  GL_KHR_texture_compression_astc_hdr = 1;  
  GL_COMPRESSED_RGBA_ASTC_4x4_KHR = $93B0;  
  GL_COMPRESSED_RGBA_ASTC_5x4_KHR = $93B1;  
  GL_COMPRESSED_RGBA_ASTC_5x5_KHR = $93B2;  
  GL_COMPRESSED_RGBA_ASTC_6x5_KHR = $93B3;  
  GL_COMPRESSED_RGBA_ASTC_6x6_KHR = $93B4;  
  GL_COMPRESSED_RGBA_ASTC_8x5_KHR = $93B5;  
  GL_COMPRESSED_RGBA_ASTC_8x6_KHR = $93B6;  
  GL_COMPRESSED_RGBA_ASTC_8x8_KHR = $93B7;  
  GL_COMPRESSED_RGBA_ASTC_10x5_KHR = $93B8;  
  GL_COMPRESSED_RGBA_ASTC_10x6_KHR = $93B9;  
  GL_COMPRESSED_RGBA_ASTC_10x8_KHR = $93BA;  
  GL_COMPRESSED_RGBA_ASTC_10x10_KHR = $93BB;  
  GL_COMPRESSED_RGBA_ASTC_12x10_KHR = $93BC;  
  GL_COMPRESSED_RGBA_ASTC_12x12_KHR = $93BD;  
  GL_COMPRESSED_RGBA_ASTC_3x3x3_OES = $93C0;  
  GL_COMPRESSED_RGBA_ASTC_4x3x3_OES = $93C1;  
  GL_COMPRESSED_RGBA_ASTC_4x4x3_OES = $93C2;  
  GL_COMPRESSED_RGBA_ASTC_4x4x4_OES = $93C3;  
  GL_COMPRESSED_RGBA_ASTC_5x4x4_OES = $93C4;  
  GL_COMPRESSED_RGBA_ASTC_5x5x4_OES = $93C5;  
  GL_COMPRESSED_RGBA_ASTC_5x5x5_OES = $93C6;  
  GL_COMPRESSED_RGBA_ASTC_6x5x5_OES = $93C7;  
  GL_COMPRESSED_RGBA_ASTC_6x6x5_OES = $93C8;  
  GL_COMPRESSED_RGBA_ASTC_6x6x6_OES = $93C9;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = $93D0;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = $93D1;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = $93D2;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = $93D3;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = $93D4;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = $93D5;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = $93D6;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = $93D7;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = $93D8;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = $93D9;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = $93DA;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = $93DB;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = $93DC;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = $93DD;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_3x3x3_OES = $93E0;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x3x3_OES = $93E1;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x3_OES = $93E2;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x4_OES = $93E3;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4x4_OES = $93E4;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x4_OES = $93E5;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x5_OES = $93E6;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5x5_OES = $93E7;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x5_OES = $93E8;  
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x6_OES = $93E9;  


{ ------------------ GL_KHR_texture_compression_astc_ldr ------------------  }

const
  GL_KHR_texture_compression_astc_ldr = 1;  
  //GL_COMPRESSED_RGBA_ASTC_4x4_KHR = $93B0;    doppelt
  //GL_COMPRESSED_RGBA_ASTC_5x4_KHR = $93B1;  
  //GL_COMPRESSED_RGBA_ASTC_5x5_KHR = $93B2;  
  //GL_COMPRESSED_RGBA_ASTC_6x5_KHR = $93B3;  
  //GL_COMPRESSED_RGBA_ASTC_6x6_KHR = $93B4;  
  //GL_COMPRESSED_RGBA_ASTC_8x5_KHR = $93B5;  
  //GL_COMPRESSED_RGBA_ASTC_8x6_KHR = $93B6;  
  //GL_COMPRESSED_RGBA_ASTC_8x8_KHR = $93B7;  
  //GL_COMPRESSED_RGBA_ASTC_10x5_KHR = $93B8;  
  //GL_COMPRESSED_RGBA_ASTC_10x6_KHR = $93B9;  
  //GL_COMPRESSED_RGBA_ASTC_10x8_KHR = $93BA;  
  //GL_COMPRESSED_RGBA_ASTC_10x10_KHR = $93BB;  
  //GL_COMPRESSED_RGBA_ASTC_12x10_KHR = $93BC;  
  //GL_COMPRESSED_RGBA_ASTC_12x12_KHR = $93BD;  
  //GL_COMPRESSED_RGBA_ASTC_3x3x3_OES = $93C0;  
  //GL_COMPRESSED_RGBA_ASTC_4x3x3_OES = $93C1;  
  //GL_COMPRESSED_RGBA_ASTC_4x4x3_OES = $93C2;  
  //GL_COMPRESSED_RGBA_ASTC_4x4x4_OES = $93C3;  
  //GL_COMPRESSED_RGBA_ASTC_5x4x4_OES = $93C4;  
  //GL_COMPRESSED_RGBA_ASTC_5x5x4_OES = $93C5;  
  //GL_COMPRESSED_RGBA_ASTC_5x5x5_OES = $93C6;  
  //GL_COMPRESSED_RGBA_ASTC_6x5x5_OES = $93C7;  
  //GL_COMPRESSED_RGBA_ASTC_6x6x5_OES = $93C8;  
  //GL_COMPRESSED_RGBA_ASTC_6x6x6_OES = $93C9;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = $93D0;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = $93D1;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = $93D2;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = $93D3;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = $93D4;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = $93D5;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = $93D6;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = $93D7;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = $93D8;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = $93D9;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = $93DA;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = $93DB;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = $93DC;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = $93DD;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_3x3x3_OES = $93E0;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x3x3_OES = $93E1;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x3_OES = $93E2;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x4_OES = $93E3;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4x4_OES = $93E4;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x4_OES = $93E5;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x5_OES = $93E6;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5x5_OES = $93E7;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x5_OES = $93E8;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x6_OES = $93E9;  


{ --------------- GL_KHR_texture_compression_astc_sliced_3d ---------------  }

const
  GL_KHR_texture_compression_astc_sliced_3d = 1;  


{ -------------------------- GL_KTX_buffer_region -------------------------  }

const
  GL_KTX_buffer_region = 1;  
  GL_KTX_FRONT_REGION = $0;  
  GL_KTX_BACK_REGION = $1;  
  GL_KTX_Z_REGION = $2;  
  GL_KTX_STENCIL_REGION = $3;  
type
  TPFNGLBUFFERREGIONENABLEDPROC = function (para1:pointer):TGLuint;cdecl;
  TPFNGLDELETEBUFFERREGIONPROC = procedure (region:TGLenum);cdecl;
  TPFNGLDRAWBUFFERREGIONPROC = procedure (region:TGLuint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei;                xDest:TGLint; yDest:TGLint);cdecl;
  TPFNGLNEWBUFFERREGIONPROC = function (region:TGLenum):TGLuint;cdecl;
  TPFNGLREADBUFFERREGIONPROC = procedure (region:TGLuint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;


{ ------------------------- GL_MESAX_texture_stack ------------------------  }

const
  GL_MESAX_texture_stack = 1;  
  GL_TEXTURE_1D_STACK_MESAX = $8759;  
  GL_TEXTURE_2D_STACK_MESAX = $875A;  
  GL_PROXY_TEXTURE_1D_STACK_MESAX = $875B;  
  GL_PROXY_TEXTURE_2D_STACK_MESAX = $875C;  
  GL_TEXTURE_1D_STACK_BINDING_MESAX = $875D;  
  GL_TEXTURE_2D_STACK_BINDING_MESAX = $875E;  


{ ----------------------- GL_MESA_framebuffer_flip_y ----------------------  }

const
  GL_MESA_framebuffer_flip_y = 1;  
  GL_FRAMEBUFFER_FLIP_Y_MESA = $8BBB;  
type
  TPFNGLFRAMEBUFFERPARAMETERIMESAPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLGETFRAMEBUFFERPARAMETERIVMESAPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ -------------------------- GL_MESA_pack_invert --------------------------  }

const
  GL_MESA_pack_invert = 1;  
  GL_PACK_INVERT_MESA = $8758;  


{ --------------------- GL_MESA_program_binary_formats --------------------  }

const
  GL_MESA_program_binary_formats = 1;  
  GL_PROGRAM_BINARY_FORMAT_MESA = $875F;  


{ ------------------------- GL_MESA_resize_buffers ------------------------  }

const
  GL_MESA_resize_buffers = 1;  
type
  TPFNGLRESIZEBUFFERSMESAPROC = procedure (para1:pointer);cdecl;


{ -------------------- GL_MESA_shader_integer_functions -------------------  }

const
  GL_MESA_shader_integer_functions = 1;  


{ ----------------------- GL_MESA_tile_raster_order -----------------------  }

const
  GL_MESA_tile_raster_order = 1;  


{ --------------------------- GL_MESA_window_pos --------------------------  }

const
  GL_MESA_window_pos = 1;  
type
  TPFNGLWINDOWPOS2DMESAPROC = procedure (x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLWINDOWPOS2DVMESAPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS2FMESAPROC = procedure (x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLWINDOWPOS2FVMESAPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS2IMESAPROC = procedure (x:TGLint; y:TGLint);cdecl;
  TPFNGLWINDOWPOS2IVMESAPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS2SMESAPROC = procedure (x:TGLshort; y:TGLshort);cdecl;
  TPFNGLWINDOWPOS2SVMESAPROC = procedure (p:PGLshort);cdecl;
  TPFNGLWINDOWPOS3DMESAPROC = procedure (x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLWINDOWPOS3DVMESAPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS3FMESAPROC = procedure (x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLWINDOWPOS3FVMESAPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS3IMESAPROC = procedure (x:TGLint; y:TGLint; z:TGLint);cdecl;
  TPFNGLWINDOWPOS3IVMESAPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS3SMESAPROC = procedure (x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLWINDOWPOS3SVMESAPROC = procedure (p:PGLshort);cdecl;
  TPFNGLWINDOWPOS4DMESAPROC = procedure (x:TGLdouble; y:TGLdouble; z:TGLdouble; para4:TGLdouble);cdecl;
  TPFNGLWINDOWPOS4DVMESAPROC = procedure (p:PGLdouble);cdecl;
  TPFNGLWINDOWPOS4FMESAPROC = procedure (x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLWINDOWPOS4FVMESAPROC = procedure (p:PGLfloat);cdecl;
  TPFNGLWINDOWPOS4IMESAPROC = procedure (x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;
  TPFNGLWINDOWPOS4IVMESAPROC = procedure (p:PGLint);cdecl;
  TPFNGLWINDOWPOS4SMESAPROC = procedure (x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;
  TPFNGLWINDOWPOS4SVMESAPROC = procedure (p:PGLshort);cdecl;


{ ------------------------- GL_MESA_ycbcr_texture -------------------------  }

const
  GL_MESA_ycbcr_texture = 1;  
  GL_UNSIGNED_SHORT_8_8_MESA = $85BA;  
  GL_UNSIGNED_SHORT_8_8_REV_MESA = $85BB;  
  GL_YCBCR_MESA = $8757;  


{ ----------- GL_NVX_blend_equation_advanced_multi_draw_buffers -----------  }

const
  GL_NVX_blend_equation_advanced_multi_draw_buffers = 1;  


{ ----------------------- GL_NVX_conditional_render -----------------------  }

const
  GL_NVX_conditional_render = 1;  
type
  TPFNGLBEGINCONDITIONALRENDERNVXPROC = procedure (id:TGLuint);cdecl;
  TPFNGLENDCONDITIONALRENDERNVXPROC = procedure (para1:pointer);cdecl;


{ ------------------------- GL_NVX_gpu_memory_info ------------------------  }

const
  GL_NVX_gpu_memory_info = 1;  
  GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = $9047;  
  GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = $9048;  
  GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = $9049;  
  GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX = $904A;  
  GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = $904B;  


{ ------------------------- GL_NVX_gpu_multicast2 -------------------------  }

const
  GL_NVX_gpu_multicast2 = 1;  
  GL_UPLOAD_GPU_MASK_NVX = $954A;  
type
  TPFNGLASYNCCOPYBUFFERSUBDATANVXPROC = function (waitSemaphoreCount:TGLsizei; waitSemaphoreArray:PGLuint; fenceValueArray:PGLuint64; readGpu:TGLuint; writeGpuMask:TGLbitfield;
               readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr; 
               signalSemaphoreCount:TGLsizei; signalSemaphoreArray:PGLuint; signalValueArray:PGLuint64):TGLsync;cdecl;
  TPFNGLASYNCCOPYIMAGESUBDATANVXPROC = function (waitSemaphoreCount:TGLsizei; waitSemaphoreArray:PGLuint; waitValueArray:PGLuint64; srcGpu:TGLuint; dstGpuMask:TGLbitfield;
               srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint; 
               srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
               dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei; 
               signalSemaphoreCount:TGLsizei; signalSemaphoreArray:PGLuint; signalValueArray:PGLuint64):TGLuint;cdecl;
  TPFNGLMULTICASTSCISSORARRAYVNVXPROC = procedure (gpu:TGLuint; first:TGLuint; count:TGLsizei; v:PGLint);cdecl;
  TPFNGLMULTICASTVIEWPORTARRAYVNVXPROC = procedure (gpu:TGLuint; first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLMULTICASTVIEWPORTPOSITIONWSCALENVXPROC = procedure (gpu:TGLuint; index:TGLuint; xcoeff:TGLfloat; ycoeff:TGLfloat);cdecl;
  TPFNGLUPLOADGPUMASKNVXPROC = procedure (mask:TGLbitfield);cdecl;


{ ---------------------- GL_NVX_linked_gpu_multicast ----------------------  }

const
  GL_NVX_linked_gpu_multicast = 1;  
  GL_LGPU_SEPARATE_STORAGE_BIT_NVX = $0800;  
  GL_MAX_LGPU_GPUS_NVX = $92BA;  
type
  TPFNGLLGPUCOPYIMAGESUBDATANVXPROC = procedure (sourceGpu:TGLuint; destinationGpuMask:TGLbitfield; srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint;
                srcX:TGLint; srxY:TGLint; srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; 
                dstLevel:TGLint; dstX:TGLint; dstY:TGLint; dstZ:TGLint; width:TGLsizei; 
                height:TGLsizei; depth:TGLsizei);cdecl;
  TPFNGLLGPUINTERLOCKNVXPROC = procedure (para1:pointer);cdecl;
  TPFNGLLGPUNAMEDBUFFERSUBDATANVXPROC = procedure (gpuMask:TGLbitfield; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;


{ ------------------------- GL_NVX_progress_fence -------------------------  }

const
  GL_NVX_progress_fence = 1;  
type
  TPFNGLCLIENTWAITSEMAPHOREUI64NVXPROC = procedure (fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;
  TPFNGLSIGNALSEMAPHOREUI64NVXPROC = procedure (signalGpu:TGLuint; fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;
  TPFNGLWAITSEMAPHOREUI64NVXPROC = procedure (waitGpu:TGLuint; fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;


{ ------------------------ GL_NV_3dvision_settings ------------------------  }

const
  GL_NV_3dvision_settings = 1;  
  GL_3DVISION_STEREO_NV = $90F4;  
  GL_STEREO_SEPARATION_NV = $90F5;  
  GL_STEREO_CONVERGENCE_NV = $90F6;  
  GL_STEREO_CUTOFF_NV = $90F7;  
  GL_STEREO_PROJECTION_NV = $90F8;  
  GL_STEREO_PROJECTION_PERSPECTIVE_NV = $90F9;  
  GL_STEREO_PROJECTION_ORTHO_NV = $90FA;  
type
  TPFNGLSTEREOPARAMETERFNVPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLSTEREOPARAMETERINVPROC = procedure (pname:TGLenum; param:TGLint);cdecl;


{ ------------------- GL_NV_EGL_stream_consumer_external ------------------  }

const
  GL_NV_EGL_stream_consumer_external = 1;  
  GL_TEXTURE_EXTERNAL_OES = $8D65;  
  GL_SAMPLER_EXTERNAL_OES = $8D66;  
  GL_TEXTURE_BINDING_EXTERNAL_OES = $8D67;  
  GL_REQUIRED_TEXTURE_IMAGE_UNITS_OES = $8D68;  


{ ----------------- GL_NV_alpha_to_coverage_dither_control ----------------  }

const
  GL_NV_alpha_to_coverage_dither_control = 1;  
  GL_ALPHA_TO_COVERAGE_DITHER_MODE_NV = $92BF;  
  GL_ALPHA_TO_COVERAGE_DITHER_DEFAULT_NV = $934D;  
  GL_ALPHA_TO_COVERAGE_DITHER_ENABLE_NV = $934E;  
  GL_ALPHA_TO_COVERAGE_DITHER_DISABLE_NV = $934F;  
type
  TPFNGLALPHATOCOVERAGEDITHERCONTROLNVPROC = procedure (mode:TGLenum);cdecl;


{ ------------------------------- GL_NV_bgr -------------------------------  }

const
  GL_NV_bgr = 1;  
  GL_BGR_NV = $80E0;  


{ ------------------- GL_NV_bindless_multi_draw_indirect ------------------  }

const
  GL_NV_bindless_multi_draw_indirect = 1;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC = procedure (mode:TGLenum; indirect:pointer; drawCount:TGLsizei; stride:TGLsizei; vertexBufferCount:TGLint);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; drawCount:TGLsizei; stride:TGLsizei;                vertexBufferCount:TGLint);cdecl;


{ ---------------- GL_NV_bindless_multi_draw_indirect_count ---------------  }

const
  GL_NV_bindless_multi_draw_indirect_count = 1;  
type
  TPFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC = procedure (mode:TGLenum; indirect:pointer; drawCount:TGLintptr; maxDrawCount:TGLsizei; stride:TGLsizei;                vertexBufferCount:TGLint);cdecl;
  TPFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC = procedure (mode:TGLenum; _type:TGLenum; indirect:pointer; drawCount:TGLintptr; maxDrawCount:TGLsizei;                stride:TGLsizei; vertexBufferCount:TGLint);cdecl;


{ ------------------------- GL_NV_bindless_texture ------------------------  }

const
  GL_NV_bindless_texture = 1;  
type
  TPFNGLGETIMAGEHANDLENVPROC = function (texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; format:TGLenum):TGLuint64;cdecl;
  TPFNGLGETTEXTUREHANDLENVPROC = function (texture:TGLuint):TGLuint64;cdecl;
  TPFNGLGETTEXTURESAMPLERHANDLENVPROC = function (texture:TGLuint; sampler:TGLuint):TGLuint64;cdecl;
  TPFNGLISIMAGEHANDLERESIDENTNVPROC = function (handle:TGLuint64):TGLboolean;cdecl;
  TPFNGLISTEXTUREHANDLERESIDENTNVPROC = function (handle:TGLuint64):TGLboolean;cdecl;
  TPFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLMAKEIMAGEHANDLERESIDENTNVPROC = procedure (handle:TGLuint64; access:TGLenum);cdecl;
  TPFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLMAKETEXTUREHANDLERESIDENTNVPROC = procedure (handle:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64NVPROC = procedure (prog:TGLuint; location:TGLint; value:TGLuint64);cdecl;
  TPFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; values:PGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64NVPROC = procedure (location:TGLint; value:TGLuint64);cdecl;
  TPFNGLUNIFORMHANDLEUI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;


{ --------------------- GL_NV_blend_equation_advanced ---------------------  }

const
  GL_NV_blend_equation_advanced = 1;  
  GL_XOR_NV = $1506;  
  GL_RED_NV = $1903;  
  GL_GREEN_NV = $1904;  
  GL_BLUE_NV = $1905;  
  GL_BLEND_PREMULTIPLIED_SRC_NV = $9280;  
  GL_BLEND_OVERLAP_NV = $9281;  
  GL_UNCORRELATED_NV = $9282;  
  GL_DISJOINT_NV = $9283;  
  GL_CONJOINT_NV = $9284;  
  GL_BLEND_ADVANCED_COHERENT_NV = $9285;  
  GL_SRC_NV = $9286;  
  GL_DST_NV = $9287;  
  GL_SRC_OVER_NV = $9288;  
  GL_DST_OVER_NV = $9289;  
  GL_SRC_IN_NV = $928A;  
  GL_DST_IN_NV = $928B;  
  GL_SRC_OUT_NV = $928C;  
  GL_DST_OUT_NV = $928D;  
  GL_SRC_ATOP_NV = $928E;  
  GL_DST_ATOP_NV = $928F;  
  GL_PLUS_NV = $9291;  
  GL_PLUS_DARKER_NV = $9292;  
  GL_MULTIPLY_NV = $9294;  
  GL_SCREEN_NV = $9295;  
  GL_OVERLAY_NV = $9296;  
  GL_DARKEN_NV = $9297;  
  GL_LIGHTEN_NV = $9298;  
  GL_COLORDODGE_NV = $9299;  
  GL_COLORBURN_NV = $929A;  
  GL_HARDLIGHT_NV = $929B;  
  GL_SOFTLIGHT_NV = $929C;  
  GL_DIFFERENCE_NV = $929E;  
  GL_MINUS_NV = $929F;  
  GL_EXCLUSION_NV = $92A0;  
  GL_CONTRAST_NV = $92A1;  
  GL_INVERT_RGB_NV = $92A3;  
  GL_LINEARDODGE_NV = $92A4;  
  GL_LINEARBURN_NV = $92A5;  
  GL_VIVIDLIGHT_NV = $92A6;  
  GL_LINEARLIGHT_NV = $92A7;  
  GL_PINLIGHT_NV = $92A8;  
  GL_HARDMIX_NV = $92A9;  
  GL_HSL_HUE_NV = $92AD;  
  GL_HSL_SATURATION_NV = $92AE;  
  GL_HSL_COLOR_NV = $92AF;  
  GL_HSL_LUMINOSITY_NV = $92B0;  
  GL_PLUS_CLAMPED_NV = $92B1;  
  GL_PLUS_CLAMPED_ALPHA_NV = $92B2;  
  GL_MINUS_CLAMPED_NV = $92B3;  
  GL_INVERT_OVG_NV = $92B4;  
type
  TPFNGLBLENDBARRIERNVPROC = procedure (para1:pointer);cdecl;
  TPFNGLBLENDPARAMETERINVPROC = procedure (pname:TGLenum; value:TGLint);cdecl;


{ ----------------- GL_NV_blend_equation_advanced_coherent ----------------  }

const
  GL_NV_blend_equation_advanced_coherent = 1;  


{ ----------------------- GL_NV_blend_minmax_factor -----------------------  }

const
  GL_NV_blend_minmax_factor = 1;  
//  GL_FACTOR_MIN_AMD = $901C;     doppelt
//  GL_FACTOR_MAX_AMD = $901D;  


{ --------------------------- GL_NV_blend_square --------------------------  }

const
  GL_NV_blend_square = 1;  


{ ----------------------- GL_NV_clip_space_w_scaling ----------------------  }

const
  GL_NV_clip_space_w_scaling = 1;  
  GL_VIEWPORT_POSITION_W_SCALE_NV = $937C;  
  GL_VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = $937D;  
  GL_VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = $937E;  
type
  TPFNGLVIEWPORTPOSITIONWSCALENVPROC = procedure (index:TGLuint; xcoeff:TGLfloat; ycoeff:TGLfloat);cdecl;


{ --------------------------- GL_NV_command_list --------------------------  }

const
  GL_NV_command_list = 1;  
  GL_TERMINATE_SEQUENCE_COMMAND_NV = $0000;  
  GL_NOP_COMMAND_NV = $0001;  
  GL_DRAW_ELEMENTS_COMMAND_NV = $0002;  
  GL_DRAW_ARRAYS_COMMAND_NV = $0003;  
  GL_DRAW_ELEMENTS_STRIP_COMMAND_NV = $0004;  
  GL_DRAW_ARRAYS_STRIP_COMMAND_NV = $0005;  
  GL_DRAW_ELEMENTS_INSTANCED_COMMAND_NV = $0006;  
  GL_DRAW_ARRAYS_INSTANCED_COMMAND_NV = $0007;  
  GL_ELEMENT_ADDRESS_COMMAND_NV = $0008;  
  GL_ATTRIBUTE_ADDRESS_COMMAND_NV = $0009;  
  GL_UNIFORM_ADDRESS_COMMAND_NV = $000a;  
  GL_BLEND_COLOR_COMMAND_NV = $000b;  
  GL_STENCIL_REF_COMMAND_NV = $000c;  
  GL_LINE_WIDTH_COMMAND_NV = $000d;  
  GL_POLYGON_OFFSET_COMMAND_NV = $000e;  
  GL_ALPHA_REF_COMMAND_NV = $000f;  
  GL_VIEWPORT_COMMAND_NV = $0010;  
  GL_SCISSOR_COMMAND_NV = $0011;  
  GL_FRONT_FACE_COMMAND_NV = $0012;  
type
  TPFNGLCALLCOMMANDLISTNVPROC = procedure (list:TGLuint);cdecl;
  TPFNGLCOMMANDLISTSEGMENTSNVPROC = procedure (list:TGLuint; segments:TGLuint);cdecl;
  TPFNGLCOMPILECOMMANDLISTNVPROC = procedure (list:TGLuint);cdecl;
  TPFNGLCREATECOMMANDLISTSNVPROC = procedure (n:TGLsizei; lists:PGLuint);cdecl;
  TPFNGLCREATESTATESNVPROC = procedure (n:TGLsizei; states:PGLuint);cdecl;
  TPFNGLDELETECOMMANDLISTSNVPROC = procedure (n:TGLsizei; lists:PGLuint);cdecl;
  TPFNGLDELETESTATESNVPROC = procedure (n:TGLsizei; states:PGLuint);cdecl;
  TPFNGLDRAWCOMMANDSADDRESSNVPROC = procedure (primitiveMode:TGLenum; indirects:PGLuint64; sizes:PGLsizei; count:TGLuint);cdecl;
  TPFNGLDRAWCOMMANDSNVPROC = procedure (primitiveMode:TGLenum; buffer:TGLuint; indirects:PGLintptr; sizes:PGLsizei; count:TGLuint);cdecl;
  TPFNGLDRAWCOMMANDSSTATESADDRESSNVPROC = procedure (indirects:PGLuint64; sizes:PGLsizei; states:PGLuint; fbos:PGLuint; count:TGLuint);cdecl;
  TPFNGLDRAWCOMMANDSSTATESNVPROC = procedure (buffer:TGLuint; indirects:PGLintptr; sizes:PGLsizei; states:PGLuint; fbos:PGLuint;                count:TGLuint);cdecl;
  TPFNGLGETCOMMANDHEADERNVPROC = function (tokenID:TGLenum; size:TGLuint):TGLuint;cdecl;
  TPFNGLGETSTAGEINDEXNVPROC = function (shadertype:TGLenum):TGLushort;cdecl;
  TPFNGLISCOMMANDLISTNVPROC = function (list:TGLuint):TGLboolean;cdecl;
 TPFNGLISSTATENVPROC = function (state:TGLuint):TGLboolean;cdecl;
  TPFNGLLISTDRAWCOMMANDSSTATESCLIENTNVPROC = procedure (list:TGLuint; segment:TGLuint; indirects:Ppointer; sizes:PGLsizei; states:PGLuint;                fbos:PGLuint; count:TGLuint);cdecl;
  TPFNGLSTATECAPTURENVPROC = procedure (state:TGLuint; mode:TGLenum);cdecl;


{ ------------------------- GL_NV_compute_program5 ------------------------  }

const
  GL_NV_compute_program5 = 1;  
  GL_COMPUTE_PROGRAM_NV = $90FB;  
  GL_COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = $90FC;  


{ -------------------- GL_NV_compute_shader_derivatives -------------------  }

const
  GL_NV_compute_shader_derivatives = 1;  


{ ------------------------ GL_NV_conditional_render -----------------------  }

const
  GL_NV_conditional_render = 1;  
  GL_QUERY_WAIT_NV = $8E13;  
  GL_QUERY_NO_WAIT_NV = $8E14;  
  GL_QUERY_BY_REGION_WAIT_NV = $8E15;  
  GL_QUERY_BY_REGION_NO_WAIT_NV = $8E16;  
type
  TPFNGLBEGINCONDITIONALRENDERNVPROC = procedure (id:TGLuint; mode:TGLenum);cdecl;
  TPFNGLENDCONDITIONALRENDERNVPROC = procedure (para1:pointer);cdecl;


{ ----------------------- GL_NV_conservative_raster -----------------------  }

const
  GL_NV_conservative_raster = 1;  
  GL_CONSERVATIVE_RASTERIZATION_NV = $9346;  
  GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = $9347;  
  GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = $9348;  
  GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = $9349;  
type
  TPFNGLSUBPIXELPRECISIONBIASNVPROC = procedure (xbits:TGLuint; ybits:TGLuint);cdecl;


{ -------------------- GL_NV_conservative_raster_dilate -------------------  }

const
  GL_NV_conservative_raster_dilate = 1;  
  GL_CONSERVATIVE_RASTER_DILATE_NV = $9379;  
  GL_CONSERVATIVE_RASTER_DILATE_RANGE_NV = $937A;  
  GL_CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = $937B;  
type
  TPFNGLCONSERVATIVERASTERPARAMETERFNVPROC = procedure (pname:TGLenum; value:TGLfloat);cdecl;


{ ------------------- GL_NV_conservative_raster_pre_snap ------------------  }

const
  GL_NV_conservative_raster_pre_snap = 1;  
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = $9550;  


{ -------------- GL_NV_conservative_raster_pre_snap_triangles -------------  }

const
  GL_NV_conservative_raster_pre_snap_triangles = 1;  
  GL_CONSERVATIVE_RASTER_MODE_NV = $954D;  
  GL_CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = $954E;  
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = $954F;  
type
  TPFNGLCONSERVATIVERASTERPARAMETERINVPROC = procedure (pname:TGLenum; param:TGLint);cdecl;


{ --------------- GL_NV_conservative_raster_underestimation ---------------  }

const
  GL_NV_conservative_raster_underestimation = 1;  


{ --------------------------- GL_NV_copy_buffer ---------------------------  }

const
  GL_NV_copy_buffer = 1;  
  GL_COPY_READ_BUFFER_NV = $8F36;  
  GL_COPY_WRITE_BUFFER_NV = $8F37;  
type
  TPFNGLCOPYBUFFERSUBDATANVPROC = procedure (readtarget:TGLenum; writetarget:TGLenum; readoffset:TGLintptr; writeoffset:TGLintptr; size:TGLsizeiptr);cdecl;

{ was #define dname def_expr }

{ ----------------------- GL_NV_copy_depth_to_color -----------------------  }

const
  GL_NV_copy_depth_to_color = 1;  
  GL_DEPTH_STENCIL_TO_RGBA_NV = $886E;  
  GL_DEPTH_STENCIL_TO_BGRA_NV = $886F;  


{ ---------------------------- GL_NV_copy_image ---------------------------  }

const
  GL_NV_copy_image = 1;  
type
  TPFNGLCOPYIMAGESUBDATANVPROC = procedure (srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint;
                srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
                dstY:TGLint; dstZ:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei);cdecl;


{ -------------------------- GL_NV_deep_texture3D -------------------------  }

const
  GL_NV_deep_texture3D = 1;  
  GL_MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = $90D0;  
  GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV = $90D1;  


{ ------------------------ GL_NV_depth_buffer_float -----------------------  }

const
  GL_NV_depth_buffer_float = 1;  
  GL_DEPTH_COMPONENT32F_NV = $8DAB;  
  GL_DEPTH32F_STENCIL8_NV = $8DAC;  
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = $8DAD;  
  GL_DEPTH_BUFFER_FLOAT_MODE_NV = $8DAF;  
type
  TPFNGLCLEARDEPTHDNVPROC = procedure (depth:TGLdouble);cdecl;
  TPFNGLDEPTHBOUNDSDNVPROC = procedure (zmin:TGLdouble; zmax:TGLdouble);cdecl;
  TPFNGLDEPTHRANGEDNVPROC = procedure (zNear:TGLdouble; zFar:TGLdouble);cdecl;


{ --------------------------- GL_NV_depth_clamp ---------------------------  }

const
  GL_NV_depth_clamp = 1;  
  GL_DEPTH_CLAMP_NV = $864F;  


{ ------------------------- GL_NV_depth_nonlinear -------------------------  }

const
  GL_NV_depth_nonlinear = 1;  
  GL_DEPTH_COMPONENT16_NONLINEAR_NV = $8E2C;  


{ ---------------------- GL_NV_depth_range_unclamped ----------------------  }

const
  GL_NV_depth_range_unclamped = 1;  
  GL_SAMPLE_COUNT_BITS_NV = $8864;  
  GL_CURRENT_SAMPLE_COUNT_QUERY_NV = $8865;  
  GL_QUERY_RESULT_NV = $8866;  
  GL_QUERY_RESULT_AVAILABLE_NV = $8867;  
  GL_SAMPLE_COUNT_NV = $8914;  


{ --------------------------- GL_NV_draw_buffers --------------------------  }

const
  GL_NV_draw_buffers = 1;  
  GL_MAX_DRAW_BUFFERS_NV = $8824;  
  GL_DRAW_BUFFER0_NV = $8825;  
  GL_DRAW_BUFFER1_NV = $8826;  
  GL_DRAW_BUFFER2_NV = $8827;  
  GL_DRAW_BUFFER3_NV = $8828;  
  GL_DRAW_BUFFER4_NV = $8829;  
  GL_DRAW_BUFFER5_NV = $882A;  
  GL_DRAW_BUFFER6_NV = $882B;  
  GL_DRAW_BUFFER7_NV = $882C;  
  GL_DRAW_BUFFER8_NV = $882D;  
  GL_DRAW_BUFFER9_NV = $882E;  
  GL_DRAW_BUFFER10_NV = $882F;  
  GL_DRAW_BUFFER11_NV = $8830;  
  GL_DRAW_BUFFER12_NV = $8831;  
  GL_DRAW_BUFFER13_NV = $8832;  
  GL_DRAW_BUFFER14_NV = $8833;  
  GL_DRAW_BUFFER15_NV = $8834;  
  GL_COLOR_ATTACHMENT0_NV = $8CE0;  
  GL_COLOR_ATTACHMENT1_NV = $8CE1;  
  GL_COLOR_ATTACHMENT2_NV = $8CE2;  
  GL_COLOR_ATTACHMENT3_NV = $8CE3;  
  GL_COLOR_ATTACHMENT4_NV = $8CE4;  
  GL_COLOR_ATTACHMENT5_NV = $8CE5;  
  GL_COLOR_ATTACHMENT6_NV = $8CE6;  
  GL_COLOR_ATTACHMENT7_NV = $8CE7;  
  GL_COLOR_ATTACHMENT8_NV = $8CE8;  
  GL_COLOR_ATTACHMENT9_NV = $8CE9;  
  GL_COLOR_ATTACHMENT10_NV = $8CEA;  
  GL_COLOR_ATTACHMENT11_NV = $8CEB;  
  GL_COLOR_ATTACHMENT12_NV = $8CEC;  
  GL_COLOR_ATTACHMENT13_NV = $8CED;  
  GL_COLOR_ATTACHMENT14_NV = $8CEE;  
  GL_COLOR_ATTACHMENT15_NV = $8CEF;  
type
  TPFNGLDRAWBUFFERSNVPROC = procedure (n:TGLsizei; bufs:PGLenum);cdecl;


{ -------------------------- GL_NV_draw_instanced -------------------------  }

const
  GL_NV_draw_instanced = 1;  
type
  TPFNGLDRAWARRAYSINSTANCEDNVPROC = procedure (mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;
  TPFNGLDRAWELEMENTSINSTANCEDNVPROC = procedure (mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;


{ --------------------------- GL_NV_draw_texture --------------------------  }

const
  GL_NV_draw_texture = 1;  
type
  TPFNGLDRAWTEXTURENVPROC = procedure (texture:TGLuint; sampler:TGLuint; x0:TGLfloat; y0:TGLfloat; x1:TGLfloat;
                y1:TGLfloat; z:TGLfloat; s0:TGLfloat; t0:TGLfloat; s1:TGLfloat; 
                t1:TGLfloat);cdecl;


{ ------------------------ GL_NV_draw_vulkan_image ------------------------  }

const
  GL_NV_draw_vulkan_image = 1;  
type
  TGLVULKANPROCNV = procedure (para1:pointer);cdecl;

  TPFNGLDRAWVKIMAGENVPROC = procedure (vkImage:TGLuint64; sampler:TGLuint; x0:TGLfloat; y0:TGLfloat; x1:TGLfloat; 
                y1:TGLfloat; z:TGLfloat; s0:TGLfloat; t0:TGLfloat; s1:TGLfloat; 
                t1:TGLfloat);cdecl;
  TPFNGLGETVKPROCADDRNVPROC = function (name:PGLchar):TGLVULKANPROCNV;cdecl;
  TPFNGLSIGNALVKFENCENVPROC = procedure (vkFence:TGLuint64);cdecl;
  TPFNGLSIGNALVKSEMAPHORENVPROC = procedure (vkSemaphore:TGLuint64);cdecl;
  TPFNGLWAITVKSEMAPHORENVPROC = procedure (vkSemaphore:TGLuint64);cdecl;


{ ---------------------------- GL_NV_evaluators ---------------------------  }

const
  GL_NV_evaluators = 1;  
  GL_EVAL_2D_NV = $86C0;  
  GL_EVAL_TRIANGULAR_2D_NV = $86C1;  
  GL_MAP_TESSELLATION_NV = $86C2;  
  GL_MAP_ATTRIB_U_ORDER_NV = $86C3;  
  GL_MAP_ATTRIB_V_ORDER_NV = $86C4;  
  GL_EVAL_FRACTIONAL_TESSELLATION_NV = $86C5;  
  GL_EVAL_VERTEX_ATTRIB0_NV = $86C6;  
  GL_EVAL_VERTEX_ATTRIB1_NV = $86C7;  
  GL_EVAL_VERTEX_ATTRIB2_NV = $86C8;  
  GL_EVAL_VERTEX_ATTRIB3_NV = $86C9;  
  GL_EVAL_VERTEX_ATTRIB4_NV = $86CA;  
  GL_EVAL_VERTEX_ATTRIB5_NV = $86CB;  
  GL_EVAL_VERTEX_ATTRIB6_NV = $86CC;  
  GL_EVAL_VERTEX_ATTRIB7_NV = $86CD;  
  GL_EVAL_VERTEX_ATTRIB8_NV = $86CE;  
  GL_EVAL_VERTEX_ATTRIB9_NV = $86CF;  
  GL_EVAL_VERTEX_ATTRIB10_NV = $86D0;  
  GL_EVAL_VERTEX_ATTRIB11_NV = $86D1;  
  GL_EVAL_VERTEX_ATTRIB12_NV = $86D2;  
  GL_EVAL_VERTEX_ATTRIB13_NV = $86D3;  
  GL_EVAL_VERTEX_ATTRIB14_NV = $86D4;  
  GL_EVAL_VERTEX_ATTRIB15_NV = $86D5;  
  GL_MAX_MAP_TESSELLATION_NV = $86D6;  
  GL_MAX_RATIONAL_EVAL_ORDER_NV = $86D7;  
type
  TPFNGLEVALMAPSNVPROC = procedure (target:TGLenum; mode:TGLenum);cdecl;
  TPFNGLGETMAPATTRIBPARAMETERFVNVPROC = procedure (target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMAPATTRIBPARAMETERIVNVPROC = procedure (target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMAPCONTROLPOINTSNVPROC = procedure (target:TGLenum; index:TGLuint; _type:TGLenum; ustride:TGLsizei; vstride:TGLsizei;                packed_:TGLboolean; points:pointer);cdecl;
  TPFNGLGETMAPPARAMETERFVNVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMAPPARAMETERIVNVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLMAPCONTROLPOINTSNVPROC = procedure (target:TGLenum; index:TGLuint; _type:TGLenum; ustride:TGLsizei; vstride:TGLsizei;
                uorder:TGLint; vorder:TGLint; packed_:TGLboolean; points:pointer);cdecl;
  TPFNGLMAPPARAMETERFVNVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLMAPPARAMETERIVNVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ --------------------- GL_NV_explicit_attrib_location --------------------  }

const
  GL_NV_explicit_attrib_location = 1;  


{ ----------------------- GL_NV_explicit_multisample ----------------------  }

const
  GL_NV_explicit_multisample = 1;  
  GL_SAMPLE_POSITION_NV = $8E50;  
  GL_SAMPLE_MASK_NV = $8E51;  
  GL_SAMPLE_MASK_VALUE_NV = $8E52;  
  GL_TEXTURE_BINDING_RENDERBUFFER_NV = $8E53;  
  GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = $8E54;  
  GL_TEXTURE_RENDERBUFFER_NV = $8E55;  
  GL_SAMPLER_RENDERBUFFER_NV = $8E56;  
  GL_INT_SAMPLER_RENDERBUFFER_NV = $8E57;  
  GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = $8E58;  
  GL_MAX_SAMPLE_MASK_WORDS_NV = $8E59;  
type
  TPFNGLGETMULTISAMPLEFVNVPROC = procedure (pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;
  TPFNGLSAMPLEMASKINDEXEDNVPROC = procedure (index:TGLuint; mask:TGLbitfield);cdecl;
  TPFNGLTEXRENDERBUFFERNVPROC = procedure (target:TGLenum; renderbuffer:TGLuint);cdecl;


{ ---------------------- GL_NV_fbo_color_attachments ----------------------  }

const
  GL_NV_fbo_color_attachments = 1;  
  GL_MAX_COLOR_ATTACHMENTS_NV = $8CDF;  
  //GL_COLOR_ATTACHMENT0_NV = $8CE0;     doppelt
  //GL_COLOR_ATTACHMENT1_NV = $8CE1;  
  //GL_COLOR_ATTACHMENT2_NV = $8CE2;  
  //GL_COLOR_ATTACHMENT3_NV = $8CE3;  
  //GL_COLOR_ATTACHMENT4_NV = $8CE4;  
  //GL_COLOR_ATTACHMENT5_NV = $8CE5;  
  //GL_COLOR_ATTACHMENT6_NV = $8CE6;  
  //GL_COLOR_ATTACHMENT7_NV = $8CE7;  
  //GL_COLOR_ATTACHMENT8_NV = $8CE8;  
  //GL_COLOR_ATTACHMENT9_NV = $8CE9;  
  //GL_COLOR_ATTACHMENT10_NV = $8CEA;  
  //GL_COLOR_ATTACHMENT11_NV = $8CEB;  
  //GL_COLOR_ATTACHMENT12_NV = $8CEC;  
  //GL_COLOR_ATTACHMENT13_NV = $8CED;  
  //GL_COLOR_ATTACHMENT14_NV = $8CEE;  
  //GL_COLOR_ATTACHMENT15_NV = $8CEF;  


{ ------------------------------ GL_NV_fence ------------------------------  }

const
  GL_NV_fence = 1;  
  GL_ALL_COMPLETED_NV = $84F2;  
  GL_FENCE_STATUS_NV = $84F3;  
  GL_FENCE_CONDITION_NV = $84F4;  
type
  TPFNGLDELETEFENCESNVPROC = procedure (n:TGLsizei; fences:PGLuint);cdecl;
  TPFNGLFINISHFENCENVPROC = procedure (fence:TGLuint);cdecl;
  TPFNGLGENFENCESNVPROC = procedure (n:TGLsizei; fences:PGLuint);cdecl;
  TPFNGLGETFENCEIVNVPROC = procedure (fence:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISFENCENVPROC = function (fence:TGLuint):TGLboolean;cdecl;
  TPFNGLSETFENCENVPROC = procedure (fence:TGLuint; condition:TGLenum);cdecl;
  TPFNGLTESTFENCENVPROC = function (fence:TGLuint):TGLboolean;cdecl;


{ -------------------------- GL_NV_fill_rectangle -------------------------  }

const
  GL_NV_fill_rectangle = 1;  
  GL_FILL_RECTANGLE_NV = $933C;  


{ --------------------------- GL_NV_float_buffer --------------------------  }

const
  GL_NV_float_buffer = 1;  
  GL_FLOAT_R_NV = $8880;  
  GL_FLOAT_RG_NV = $8881;  
  GL_FLOAT_RGB_NV = $8882;  
  GL_FLOAT_RGBA_NV = $8883;  
  GL_FLOAT_R16_NV = $8884;  
  GL_FLOAT_R32_NV = $8885;  
  GL_FLOAT_RG16_NV = $8886;  
  GL_FLOAT_RG32_NV = $8887;  
  GL_FLOAT_RGB16_NV = $8888;  
  GL_FLOAT_RGB32_NV = $8889;  
  GL_FLOAT_RGBA16_NV = $888A;  
  GL_FLOAT_RGBA32_NV = $888B;  
  GL_TEXTURE_FLOAT_COMPONENTS_NV = $888C;  
  GL_FLOAT_CLEAR_COLOR_VALUE_NV = $888D;  
  GL_FLOAT_RGBA_MODE_NV = $888E;  


{ --------------------------- GL_NV_fog_distance --------------------------  }

const
  GL_NV_fog_distance = 1;  
  GL_FOG_DISTANCE_MODE_NV = $855A;  
  GL_EYE_RADIAL_NV = $855B;  
  GL_EYE_PLANE_ABSOLUTE_NV = $855C;  


{ -------------------- GL_NV_fragment_coverage_to_color -------------------  }

const
  GL_NV_fragment_coverage_to_color = 1;  
  GL_FRAGMENT_COVERAGE_TO_COLOR_NV = $92DD;  
  GL_FRAGMENT_COVERAGE_COLOR_NV = $92DE;  
type
  TPFNGLFRAGMENTCOVERAGECOLORNVPROC = procedure (color:TGLuint);cdecl;


{ ------------------------- GL_NV_fragment_program ------------------------  }

const
  GL_NV_fragment_program = 1;  
  GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = $8868;  
  GL_FRAGMENT_PROGRAM_NV = $8870;  
  GL_MAX_TEXTURE_COORDS_NV = $8871;  
  GL_MAX_TEXTURE_IMAGE_UNITS_NV = $8872;  
  GL_FRAGMENT_PROGRAM_BINDING_NV = $8873;  
  GL_PROGRAM_ERROR_STRING_NV = $8874;  
type
  TPFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; params:PGLdouble);cdecl;
  TPFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; params:PGLfloat);cdecl;
  TPFNGLPROGRAMNAMEDPARAMETER4DNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; x:TGLdouble; y:TGLdouble;                z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLPROGRAMNAMEDPARAMETER4DVNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; v:PGLdouble);cdecl;
  TPFNGLPROGRAMNAMEDPARAMETER4FNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; x:TGLfloat; y:TGLfloat;               z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLPROGRAMNAMEDPARAMETER4FVNVPROC = procedure (id:TGLuint; len:TGLsizei; name:PGLubyte; v:PGLfloat);cdecl;


{ ------------------------ GL_NV_fragment_program2 ------------------------  }

const
  GL_NV_fragment_program2 = 1;  
  GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = $88F4;  
  GL_MAX_PROGRAM_CALL_DEPTH_NV = $88F5;  
  GL_MAX_PROGRAM_IF_DEPTH_NV = $88F6;  
  GL_MAX_PROGRAM_LOOP_DEPTH_NV = $88F7;  
  GL_MAX_PROGRAM_LOOP_COUNT_NV = $88F8;  


{ ------------------------ GL_NV_fragment_program4 ------------------------  }

const
  GL_NV_fragment_program4 = 1;  


{ --------------------- GL_NV_fragment_program_option ---------------------  }

const
  GL_NV_fragment_program_option = 1;  


{ ------------------- GL_NV_fragment_shader_barycentric -------------------  }

const
  GL_NV_fragment_shader_barycentric = 1;  


{ -------------------- GL_NV_fragment_shader_interlock --------------------  }

const
  GL_NV_fragment_shader_interlock = 1;  


{ ------------------------- GL_NV_framebuffer_blit ------------------------  }

const
  GL_NV_framebuffer_blit = 1;  
  GL_DRAW_FRAMEBUFFER_BINDING_NV = $8CA6;  
  GL_READ_FRAMEBUFFER_NV = $8CA8;  
  GL_DRAW_FRAMEBUFFER_NV = $8CA9;  
  GL_READ_FRAMEBUFFER_BINDING_NV = $8CAA;  
type
  TPFNGLBLITFRAMEBUFFERNVPROC = procedure (srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint;
                dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;



{ -------------------- GL_NV_framebuffer_mixed_samples --------------------  }

const
  GL_NV_framebuffer_mixed_samples = 1;  
  //GL_COLOR_SAMPLES_NV = $8E20;     doppelt
  //GL_RASTER_MULTISAMPLE_EXT = $9327;  
  //GL_RASTER_SAMPLES_EXT = $9328;  
  //GL_MAX_RASTER_SAMPLES_EXT = $9329;  
  //GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = $932A;  
  //GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = $932B;  
  //GL_EFFECTIVE_RASTER_SAMPLES_EXT = $932C;  
  //GL_DEPTH_SAMPLES_NV = $932D;  
  //GL_STENCIL_SAMPLES_NV = $932E;  
  //GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = $932F;  
  //GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = $9330;  
  //GL_COVERAGE_MODULATION_TABLE_NV = $9331;  
  //GL_COVERAGE_MODULATION_NV = $9332;  
  //GL_COVERAGE_MODULATION_TABLE_SIZE_NV = $9333;  


{ --------------------- GL_NV_framebuffer_multisample ---------------------  }

const
  GL_NV_framebuffer_multisample = 1;  
  GL_RENDERBUFFER_SAMPLES_NV = $8CAB;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_NV = $8D56;  
  GL_MAX_SAMPLES_NV = $8D57;  
type
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLENVPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ----------------- GL_NV_framebuffer_multisample_coverage ----------------  }

const
  GL_NV_framebuffer_multisample_coverage = 1;  
  GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = $8CAB;  
  GL_RENDERBUFFER_COLOR_SAMPLES_NV = $8E10;  
  GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = $8E11;  
  GL_MULTISAMPLE_COVERAGE_MODES_NV = $8E12;  
type
  TPFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC = procedure (target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei;
                height:TGLsizei);cdecl;


{ ----------------------- GL_NV_generate_mipmap_sRGB ----------------------  }

const
  GL_NV_generate_mipmap_sRGB = 1;  


{ ------------------------ GL_NV_geometry_program4 ------------------------  }

const
  GL_NV_geometry_program4 = 1;  
  GL_GEOMETRY_PROGRAM_NV = $8C26;  
  GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = $8C27;  
  GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = $8C28;  
type
  TPFNGLPROGRAMVERTEXLIMITNVPROC = procedure (target:TGLenum; limit:TGLint);cdecl;


{ ------------------------- GL_NV_geometry_shader4 ------------------------  }

const
  GL_NV_geometry_shader4 = 1;  


{ ------------------- GL_NV_geometry_shader_passthrough -------------------  }

const
  GL_NV_geometry_shader_passthrough = 1;  


{ -------------------------- GL_NV_gpu_multicast --------------------------  }

const
  GL_NV_gpu_multicast = 1;  
  GL_PER_GPU_STORAGE_BIT_NV = $0800;  
  GL_MULTICAST_GPUS_NV = $92BA;  
  GL_PER_GPU_STORAGE_NV = $9548;  
  GL_MULTICAST_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9549;  
  GL_RENDER_GPU_MASK_NV = $9558;  
type
  TPFNGLMULTICASTBARRIERNVPROC = procedure (para1:pointer);cdecl;
  TPFNGLMULTICASTBLITFRAMEBUFFERNVPROC = procedure (srcGpu:TGLuint; dstGpu:TGLuint; srcX0:TGLint; srcY0:TGLint; srcX1:TGLint;
                srcY1:TGLint; dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; 
                mask:TGLbitfield; filter:TGLenum);cdecl;
  TPFNGLMULTICASTBUFFERSUBDATANVPROC = procedure (gpuMask:TGLbitfield; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;
  TPFNGLMULTICASTCOPYBUFFERSUBDATANVPROC = procedure (readGpu:TGLuint; writeGpuMask:TGLbitfield; readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr;
                writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLMULTICASTCOPYIMAGESUBDATANVPROC = procedure (srcGpu:TGLuint; dstGpuMask:TGLbitfield; srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint;
                srcX:TGLint; srcY:TGLint; srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; 
                dstLevel:TGLint; dstX:TGLint; dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; 
                srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;
  TPFNGLMULTICASTFRAMEBUFFERSAMPLELOCATIONSFVNVPROC = procedure (gpu:TGLuint; framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLMULTICASTGETQUERYOBJECTI64VNVPROC = procedure (gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;
  TPFNGLMULTICASTGETQUERYOBJECTIVNVPROC = procedure (gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLMULTICASTGETQUERYOBJECTUI64VNVPROC = procedure (gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;
  TPFNGLMULTICASTGETQUERYOBJECTUIVNVPROC = procedure (gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLMULTICASTWAITSYNCNVPROC = procedure (signalGpu:TGLuint; waitGpuMask:TGLbitfield);cdecl;
  TPFNGLRENDERGPUMASKNVPROC = procedure (mask:TGLbitfield);cdecl;


{ --------------------------- GL_NV_gpu_program4 --------------------------  }

const
  GL_NV_gpu_program4 = 1;  
  GL_MIN_PROGRAM_TEXEL_OFFSET_NV = $8904;  
  GL_MAX_PROGRAM_TEXEL_OFFSET_NV = $8905;  
  GL_PROGRAM_ATTRIB_COMPONENTS_NV = $8906;  
  GL_PROGRAM_RESULT_COMPONENTS_NV = $8907;  
  GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV = $8908;  
  GL_MAX_PROGRAM_RESULT_COMPONENTS_NV = $8909;  
  GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV = $8DA5;  
  GL_MAX_PROGRAM_GENERIC_RESULTS_NV = $8DA6;  
type
  TPFNGLPROGRAMENVPARAMETERI4INVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLint; y:TGLint; z:TGLint;                w:TGLint);cdecl;
  TPFNGLPROGRAMENVPARAMETERI4IVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLint);cdecl;
  TPFNGLPROGRAMENVPARAMETERI4UINVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint;                w:TGLuint);cdecl;
  TPFNGLPROGRAMENVPARAMETERI4UIVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLuint);cdecl;
  TPFNGLPROGRAMENVPARAMETERSI4IVNVPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;
  TPFNGLPROGRAMENVPARAMETERSI4UIVNVPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;
  TPFNGLPROGRAMLOCALPARAMETERI4INVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLint; y:TGLint; z:TGLint;                w:TGLint);cdecl;
                                                                                                                  TPFNGLPROGRAMLOCALPARAMETERI4IVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLint);cdecl;
                                                                                                                  TPFNGLPROGRAMLOCALPARAMETERI4UINVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint;                w:TGLuint);cdecl;
  TPFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLuint);cdecl;
  TPFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;
  TPFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC = procedure (target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;


{ --------------------------- GL_NV_gpu_program5 --------------------------  }

const
  GL_NV_gpu_program5 = 1;  
  GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = $8E5A;  
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5B;  
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5C;  
  GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = $8E5D;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5F;  


{ -------------------- GL_NV_gpu_program5_mem_extended --------------------  }

const
  GL_NV_gpu_program5_mem_extended = 1;  


{ ------------------------- GL_NV_gpu_program_fp64 ------------------------  }

const
  GL_NV_gpu_program_fp64 = 1;  


{ --------------------------- GL_NV_gpu_shader5 ---------------------------  }

const
  GL_NV_gpu_shader5 = 1;  
  GL_INT64_NV = $140E;  
  GL_UNSIGNED_INT64_NV = $140F;  
  GL_INT8_NV = $8FE0;  
  GL_INT8_VEC2_NV = $8FE1;  
  GL_INT8_VEC3_NV = $8FE2;  
  GL_INT8_VEC4_NV = $8FE3;  
  GL_INT16_NV = $8FE4;  
  GL_INT16_VEC2_NV = $8FE5;  
  GL_INT16_VEC3_NV = $8FE6;  
  GL_INT16_VEC4_NV = $8FE7;  
  GL_INT64_VEC2_NV = $8FE9;  
  GL_INT64_VEC3_NV = $8FEA;  
  GL_INT64_VEC4_NV = $8FEB;  
  GL_UNSIGNED_INT8_NV = $8FEC;  
  GL_UNSIGNED_INT8_VEC2_NV = $8FED;  
  GL_UNSIGNED_INT8_VEC3_NV = $8FEE;  
  GL_UNSIGNED_INT8_VEC4_NV = $8FEF;  
  GL_UNSIGNED_INT16_NV = $8FF0;  
  GL_UNSIGNED_INT16_VEC2_NV = $8FF1;  
  GL_UNSIGNED_INT16_VEC3_NV = $8FF2;  
  GL_UNSIGNED_INT16_VEC4_NV = $8FF3;  
  GL_UNSIGNED_INT64_VEC2_NV = $8FF5;  
  GL_UNSIGNED_INT64_VEC3_NV = $8FF6;  
  GL_UNSIGNED_INT64_VEC4_NV = $8FF7;  
  //GL_FLOAT16_NV = $8FF8;           // doppelt
  //GL_FLOAT16_VEC2_NV = $8FF9;  
  //GL_FLOAT16_VEC3_NV = $8FFA;  
  //GL_FLOAT16_VEC4_NV = $8FFB;  
type
  TPFNGLGETUNIFORMI64VNVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLint64EXT);cdecl;
  TPFNGLGETUNIFORMUI64VNVPROC = procedure (prog:TGLuint; location:TGLint; params:PGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM1I64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM1I64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM1UI64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM1UI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM2I64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM2I64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM2UI64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM2UI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM3I64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM3I64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM3UI64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM3UI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM4I64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT;                w:TGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM4I64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM4UI64NVPROC = procedure (prog:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT;                w:TGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORM4UI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLUNIFORM1I64NVPROC = procedure (location:TGLint; x:TGLint64EXT);cdecl;
  TPFNGLUNIFORM1I64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLUNIFORM1UI64NVPROC = procedure (location:TGLint; x:TGLuint64EXT);cdecl;
  TPFNGLUNIFORM1UI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLUNIFORM2I64NVPROC = procedure (location:TGLint; x:TGLint64EXT; y:TGLint64EXT);cdecl;
  TPFNGLUNIFORM2I64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLUNIFORM2UI64NVPROC = procedure (location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;
  TPFNGLUNIFORM2UI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLUNIFORM3I64NVPROC = procedure (location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;
  TPFNGLUNIFORM3I64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLUNIFORM3UI64NVPROC = procedure (location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;
  TPFNGLUNIFORM3UI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLUNIFORM4I64NVPROC = procedure (location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT; w:TGLint64EXT);cdecl;
  TPFNGLUNIFORM4I64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;
  TPFNGLUNIFORM4UI64NVPROC = procedure (location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT; w:TGLuint64EXT);cdecl;
  TPFNGLUNIFORM4UI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;


{ ---------------------------- GL_NV_half_float ---------------------------  }

const
  GL_NV_half_float = 1;  
  GL_HALF_FLOAT_NV = $140B;  
type
  PGLhalf = ^TGLhalf;
  TGLhalf = word;

  TPFNGLCOLOR3HNVPROC = procedure (red:TGLhalf; green:TGLhalf; blue:TGLhalf);cdecl;
  TPFNGLCOLOR3HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLCOLOR4HNVPROC = procedure (red:TGLhalf; green:TGLhalf; blue:TGLhalf; alpha:TGLhalf);cdecl;
  TPFNGLCOLOR4HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLFOGCOORDHNVPROC = procedure (fog:TGLhalf);cdecl;
  TPFNGLFOGCOORDHVNVPROC = procedure (fog:PGLhalf);cdecl;
  TPFNGLMULTITEXCOORD1HNVPROC = procedure (target:TGLenum; s:TGLhalf);cdecl;
  TPFNGLMULTITEXCOORD1HVNVPROC = procedure (target:TGLenum; v:PGLhalf);cdecl;
  TPFNGLMULTITEXCOORD2HNVPROC = procedure (target:TGLenum; s:TGLhalf; t:TGLhalf);cdecl;
  TPFNGLMULTITEXCOORD2HVNVPROC = procedure (target:TGLenum; v:PGLhalf);cdecl;
  TPFNGLMULTITEXCOORD3HNVPROC = procedure (target:TGLenum; s:TGLhalf; t:TGLhalf; r:TGLhalf);cdecl;
  TPFNGLMULTITEXCOORD3HVNVPROC = procedure (target:TGLenum; v:PGLhalf);cdecl;
  TPFNGLMULTITEXCOORD4HNVPROC = procedure (target:TGLenum; s:TGLhalf; t:TGLhalf; r:TGLhalf; q:TGLhalf);cdecl;
  TPFNGLMULTITEXCOORD4HVNVPROC = procedure (target:TGLenum; v:PGLhalf);cdecl;
  TPFNGLNORMAL3HNVPROC = procedure (nx:TGLhalf; ny:TGLhalf; nz:TGLhalf);cdecl;
  TPFNGLNORMAL3HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLSECONDARYCOLOR3HNVPROC = procedure (red:TGLhalf; green:TGLhalf; blue:TGLhalf);cdecl;
  TPFNGLSECONDARYCOLOR3HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLTEXCOORD1HNVPROC = procedure (s:TGLhalf);cdecl;
  TPFNGLTEXCOORD1HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLTEXCOORD2HNVPROC = procedure (s:TGLhalf; t:TGLhalf);cdecl;
  TPFNGLTEXCOORD2HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLTEXCOORD3HNVPROC = procedure (s:TGLhalf; t:TGLhalf; r:TGLhalf);cdecl;
  TPFNGLTEXCOORD3HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLTEXCOORD4HNVPROC = procedure (s:TGLhalf; t:TGLhalf; r:TGLhalf; q:TGLhalf);cdecl;
  TPFNGLTEXCOORD4HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLVERTEX2HNVPROC = procedure (x:TGLhalf; y:TGLhalf);cdecl;
  TPFNGLVERTEX2HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLVERTEX3HNVPROC = procedure (x:TGLhalf; y:TGLhalf; z:TGLhalf);cdecl;
  TPFNGLVERTEX3HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLVERTEX4HNVPROC = procedure (x:TGLhalf; y:TGLhalf; z:TGLhalf; w:TGLhalf);cdecl;
  TPFNGLVERTEX4HVNVPROC = procedure (v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIB1HNVPROC = procedure (index:TGLuint; x:TGLhalf);cdecl;
  TPFNGLVERTEXATTRIB1HVNVPROC = procedure (index:TGLuint; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIB2HNVPROC = procedure (index:TGLuint; x:TGLhalf; y:TGLhalf);cdecl;
  TPFNGLVERTEXATTRIB2HVNVPROC = procedure (index:TGLuint; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIB3HNVPROC = procedure (index:TGLuint; x:TGLhalf; y:TGLhalf; z:TGLhalf);cdecl;
  TPFNGLVERTEXATTRIB3HVNVPROC = procedure (index:TGLuint; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIB4HNVPROC = procedure (index:TGLuint; x:TGLhalf; y:TGLhalf; z:TGLhalf; w:TGLhalf);cdecl;
  TPFNGLVERTEXATTRIB4HVNVPROC = procedure (index:TGLuint; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIBS1HVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIBS2HVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIBS3HVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLhalf);cdecl;
  TPFNGLVERTEXATTRIBS4HVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLhalf);cdecl;
  TPFNGLVERTEXWEIGHTHNVPROC = procedure (weight:TGLhalf);cdecl;
  TPFNGLVERTEXWEIGHTHVNVPROC = procedure (weight:PGLhalf);cdecl;


{ -------------------------- GL_NV_image_formats --------------------------  }

const
  GL_NV_image_formats = 1;  


{ ------------------------- GL_NV_instanced_arrays ------------------------  }

const
  GL_NV_instanced_arrays = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_NV = $88FE;  
type
  TPFNGLVERTEXATTRIBDIVISORNVPROC = procedure (index:TGLuint; divisor:TGLuint);cdecl;


{ ------------------- GL_NV_internalformat_sample_query -------------------  }

const
  GL_NV_internalformat_sample_query = 1;  
  GL_MULTISAMPLES_NV = $9371;  
  GL_SUPERSAMPLE_SCALE_X_NV = $9372;  
  GL_SUPERSAMPLE_SCALE_Y_NV = $9373;  
  GL_CONFORMANT_NV = $9374;  
type
  TPFNGLGETINTERNALFORMATSAMPLEIVNVPROC = procedure (target:TGLenum; internalformat:TGLenum; samples:TGLsizei; pname:TGLenum; bufSize:TGLsizei;                params:PGLint);cdecl;


{ ------------------------ GL_NV_light_max_exponent -----------------------  }

const
  GL_NV_light_max_exponent = 1;  
  GL_MAX_SHININESS_NV = $8504;  
  GL_MAX_SPOT_EXPONENT_NV = $8505;  


{ ------------------------ GL_NV_memory_attachment ------------------------  }

const
  GL_NV_memory_attachment = 1;  
  GL_ATTACHED_MEMORY_OBJECT_NV = $95A4;  
  GL_ATTACHED_MEMORY_OFFSET_NV = $95A5;  
  GL_MEMORY_ATTACHABLE_ALIGNMENT_NV = $95A6;  
  GL_MEMORY_ATTACHABLE_SIZE_NV = $95A7;  
  GL_MEMORY_ATTACHABLE_NV = $95A8;  
  GL_DETACHED_MEMORY_INCARNATION_NV = $95A9;  
  GL_DETACHED_TEXTURES_NV = $95AA;  
  GL_DETACHED_BUFFERS_NV = $95AB;  
  GL_MAX_DETACHED_TEXTURES_NV = $95AC;  
  GL_MAX_DETACHED_BUFFERS_NV = $95AD;  
type
  TPFNGLBUFFERATTACHMEMORYNVPROC = procedure (target:TGLenum; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLGETMEMORYOBJECTDETACHEDRESOURCESUIVNVPROC = procedure (memory:TGLuint; pname:TGLenum; first:TGLint; count:TGLsizei; params:PGLuint);cdecl;
  TPFNGLNAMEDBUFFERATTACHMEMORYNVPROC = procedure (buffer:TGLuint; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLRESETMEMORYOBJECTPARAMETERNVPROC = procedure (memory:TGLuint; pname:TGLenum);cdecl;
  TPFNGLTEXATTACHMEMORYNVPROC = procedure (target:TGLenum; memory:TGLuint; offset:TGLuint64);cdecl;
  TPFNGLTEXTUREATTACHMEMORYNVPROC = procedure (texture:TGLuint; memory:TGLuint; offset:TGLuint64);cdecl;


{ --------------------------- GL_NV_mesh_shader ---------------------------  }

const
  GL_NV_mesh_shader = 1;  
  GL_MESH_SHADER_BIT_NV = $00000040;  
  GL_TASK_SHADER_BIT_NV = $00000080;  
  GL_MAX_MESH_UNIFORM_BLOCKS_NV = $8E60;  
  GL_MAX_MESH_TEXTURE_IMAGE_UNITS_NV = $8E61;  
  GL_MAX_MESH_IMAGE_UNIFORMS_NV = $8E62;  
  GL_MAX_MESH_UNIFORM_COMPONENTS_NV = $8E63;  
  GL_MAX_MESH_ATOMIC_COUNTER_BUFFERS_NV = $8E64;  
  GL_MAX_MESH_ATOMIC_COUNTERS_NV = $8E65;  
  GL_MAX_MESH_SHADER_STORAGE_BLOCKS_NV = $8E66;  
  GL_MAX_COMBINED_MESH_UNIFORM_COMPONENTS_NV = $8E67;  
  GL_MAX_TASK_UNIFORM_BLOCKS_NV = $8E68;  
  GL_MAX_TASK_TEXTURE_IMAGE_UNITS_NV = $8E69;  
  GL_MAX_TASK_IMAGE_UNIFORMS_NV = $8E6A;  
  GL_MAX_TASK_UNIFORM_COMPONENTS_NV = $8E6B;  
  GL_MAX_TASK_ATOMIC_COUNTER_BUFFERS_NV = $8E6C;  
  GL_MAX_TASK_ATOMIC_COUNTERS_NV = $8E6D;  
  GL_MAX_TASK_SHADER_STORAGE_BLOCKS_NV = $8E6E;  
  GL_MAX_COMBINED_TASK_UNIFORM_COMPONENTS_NV = $8E6F;  
  GL_MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = $92DF;  
  GL_MAX_MESH_TOTAL_MEMORY_SIZE_NV = $9536;  
  GL_MAX_TASK_TOTAL_MEMORY_SIZE_NV = $9537;  
  GL_MAX_MESH_OUTPUT_VERTICES_NV = $9538;  
  GL_MAX_MESH_OUTPUT_PRIMITIVES_NV = $9539;  
  GL_MAX_TASK_OUTPUT_COUNT_NV = $953A;  
  GL_MAX_MESH_WORK_GROUP_SIZE_NV = $953B;  
  GL_MAX_TASK_WORK_GROUP_SIZE_NV = $953C;  
  GL_MAX_DRAW_MESH_TASKS_COUNT_NV = $953D;  
  GL_MESH_WORK_GROUP_SIZE_NV = $953E;  
  GL_TASK_WORK_GROUP_SIZE_NV = $953F;  
  GL_MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = $9543;  
  GL_MAX_MESH_VIEWS_NV = $9557;  
  GL_MESH_SHADER_NV = $9559;  
  GL_TASK_SHADER_NV = $955A;  
  GL_MESH_VERTICES_OUT_NV = $9579;  
  GL_MESH_PRIMITIVES_OUT_NV = $957A;  
  GL_MESH_OUTPUT_TYPE_NV = $957B;  
  GL_MESH_SUBROUTINE_NV = $957C;  
  GL_TASK_SUBROUTINE_NV = $957D;  
  GL_MESH_SUBROUTINE_UNIFORM_NV = $957E;  
  GL_TASK_SUBROUTINE_UNIFORM_NV = $957F;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = $959C;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = $959D;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = $959E;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = $959F;  
  GL_REFERENCED_BY_MESH_SHADER_NV = $95A0;  
  GL_REFERENCED_BY_TASK_SHADER_NV = $95A1;  
  GL_MAX_MESH_WORK_GROUP_INVOCATIONS_NV = $95A2;  
  GL_MAX_TASK_WORK_GROUP_INVOCATIONS_NV = $95A3;  
type
  TPFNGLDRAWMESHTASKSINDIRECTNVPROC = procedure (indirect:TGLintptr);cdecl;
  TPFNGLDRAWMESHTASKSNVPROC = procedure (first:TGLuint; count:TGLuint);cdecl;
  TPFNGLMULTIDRAWMESHTASKSINDIRECTCOUNTNVPROC = procedure (indirect:TGLintptr; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;
  TPFNGLMULTIDRAWMESHTASKSINDIRECTNVPROC = procedure (indirect:TGLintptr; drawcount:TGLsizei; stride:TGLsizei);cdecl;


{ ----------------------- GL_NV_multisample_coverage ----------------------  }

const
  GL_NV_multisample_coverage = 1;  
//  GL_COLOR_SAMPLES_NV = $8E20;   doppelt


{ --------------------- GL_NV_multisample_filter_hint ---------------------  }

const
  GL_NV_multisample_filter_hint = 1;  
  GL_MULTISAMPLE_FILTER_HINT_NV = $8534;  


{ ----------------------- GL_NV_non_square_matrices -----------------------  }

const
  GL_NV_non_square_matrices = 1;  
  GL_FLOAT_MAT2x3_NV = $8B65;  
  GL_FLOAT_MAT2x4_NV = $8B66;  
  GL_FLOAT_MAT3x2_NV = $8B67;  
  GL_FLOAT_MAT3x4_NV = $8B68;  
  GL_FLOAT_MAT4x2_NV = $8B69;  
  GL_FLOAT_MAT4x3_NV = $8B6A;  
type
  TPFNGLUNIFORMMATRIX2X3FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX2X4FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3X2FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX3X4FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4X2FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;
  TPFNGLUNIFORMMATRIX4X3FVNVPROC = procedure (location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;


{ ------------------------- GL_NV_occlusion_query -------------------------  }

const
  GL_NV_occlusion_query = 1;  
  GL_PIXEL_COUNTER_BITS_NV = $8864;  
  GL_CURRENT_OCCLUSION_QUERY_ID_NV = $8865;  
  GL_PIXEL_COUNT_NV = $8866;  
  GL_PIXEL_COUNT_AVAILABLE_NV = $8867;  
type
  TPFNGLBEGINOCCLUSIONQUERYNVPROC = procedure (id:TGLuint);cdecl;
  TPFNGLDELETEOCCLUSIONQUERIESNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLENDOCCLUSIONQUERYNVPROC = procedure (para1:pointer);cdecl;
  TPFNGLGENOCCLUSIONQUERIESNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETOCCLUSIONQUERYIVNVPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETOCCLUSIONQUERYUIVNVPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLISOCCLUSIONQUERYNVPROC = function (id:TGLuint):TGLboolean;cdecl;


{ -------------------------- GL_NV_pack_subimage --------------------------  }

const
  GL_NV_pack_subimage = 1;  
  GL_PACK_ROW_LENGTH_NV = $0D02;  
  GL_PACK_SKIP_ROWS_NV = $0D03;  
  GL_PACK_SKIP_PIXELS_NV = $0D04;  


{ ----------------------- GL_NV_packed_depth_stencil ----------------------  }

const
  GL_NV_packed_depth_stencil = 1;  
  GL_DEPTH_STENCIL_NV = $84F9;  
  GL_UNSIGNED_INT_24_8_NV = $84FA;  


{ --------------------------- GL_NV_packed_float --------------------------  }

const
  GL_NV_packed_float = 1;  
  GL_R11F_G11F_B10F_NV = $8C3A;  
  GL_UNSIGNED_INT_10F_11F_11F_REV_NV = $8C3B;  


{ ----------------------- GL_NV_packed_float_linear -----------------------  }

const
  GL_NV_packed_float_linear = 1;  
//  GL_R11F_G11F_B10F_NV = $8C3A; doppelt
//  GL_UNSIGNED_INT_10F_11F_11F_REV_NV = $8C3B;  


{ --------------------- GL_NV_parameter_buffer_object ---------------------  }

const
  GL_NV_parameter_buffer_object = 1;  
  GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = $8DA0;  
  GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = $8DA1;  
  GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = $8DA2;  
  GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = $8DA3;  
  GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = $8DA4;  
type
  TPFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC = procedure (target:TGLenum; buffer:TGLuint; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;
  TPFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC = procedure (target:TGLenum; buffer:TGLuint; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;
  TPFNGLPROGRAMBUFFERPARAMETERSFVNVPROC = procedure (target:TGLenum; buffer:TGLuint; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;


{ --------------------- GL_NV_parameter_buffer_object2 --------------------  }

const
  GL_NV_parameter_buffer_object2 = 1;  


{ -------------------------- GL_NV_path_rendering -------------------------  }

const
  GL_NV_path_rendering = 1;  
  GL_CLOSE_PATH_NV = $00;  
  GL_BOLD_BIT_NV = $01;  
  GL_GLYPH_WIDTH_BIT_NV = $01;  
  GL_GLYPH_HEIGHT_BIT_NV = $02;  
  GL_ITALIC_BIT_NV = $02;  
  GL_MOVE_TO_NV = $02;  
  GL_RELATIVE_MOVE_TO_NV = $03;  
  GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = $04;  
  GL_LINE_TO_NV = $04;  
  GL_RELATIVE_LINE_TO_NV = $05;  
  GL_HORIZONTAL_LINE_TO_NV = $06;  
  GL_RELATIVE_HORIZONTAL_LINE_TO_NV = $07;  
  GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = $08;  
  GL_VERTICAL_LINE_TO_NV = $08;  
  GL_RELATIVE_VERTICAL_LINE_TO_NV = $09;  
  GL_QUADRATIC_CURVE_TO_NV = $0A;  
  GL_RELATIVE_QUADRATIC_CURVE_TO_NV = $0B;  
  GL_CUBIC_CURVE_TO_NV = $0C;  
  GL_RELATIVE_CUBIC_CURVE_TO_NV = $0D;  
  GL_SMOOTH_QUADRATIC_CURVE_TO_NV = $0E;  
  GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = $0F;  
  GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = $10;  
  GL_SMOOTH_CUBIC_CURVE_TO_NV = $10;  
  GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = $11;  
  GL_SMALL_CCW_ARC_TO_NV = $12;  
  GL_RELATIVE_SMALL_CCW_ARC_TO_NV = $13;  
  GL_SMALL_CW_ARC_TO_NV = $14;  
  GL_RELATIVE_SMALL_CW_ARC_TO_NV = $15;  
  GL_LARGE_CCW_ARC_TO_NV = $16;  
  GL_RELATIVE_LARGE_CCW_ARC_TO_NV = $17;  
  GL_LARGE_CW_ARC_TO_NV = $18;  
  GL_RELATIVE_LARGE_CW_ARC_TO_NV = $19;  
  GL_CONIC_CURVE_TO_NV = $1A;  
  GL_RELATIVE_CONIC_CURVE_TO_NV = $1B;  
  GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = $20;  
  GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = $40;  
  GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = $80;  
  GL_ROUNDED_RECT_NV = $E8;  
  GL_RELATIVE_ROUNDED_RECT_NV = $E9;  
  GL_ROUNDED_RECT2_NV = $EA;  
  GL_RELATIVE_ROUNDED_RECT2_NV = $EB;  
  GL_ROUNDED_RECT4_NV = $EC;  
  GL_RELATIVE_ROUNDED_RECT4_NV = $ED;  
  GL_ROUNDED_RECT8_NV = $EE;  
  GL_RELATIVE_ROUNDED_RECT8_NV = $EF;  
  GL_RESTART_PATH_NV = $F0;  
  GL_DUP_FIRST_CUBIC_CURVE_TO_NV = $F2;  
  GL_DUP_LAST_CUBIC_CURVE_TO_NV = $F4;  
  GL_RECT_NV = $F6;  
  GL_RELATIVE_RECT_NV = $F7;  
  GL_CIRCULAR_CCW_ARC_TO_NV = $F8;  
  GL_CIRCULAR_CW_ARC_TO_NV = $FA;  
  GL_CIRCULAR_TANGENT_ARC_TO_NV = $FC;  
  GL_ARC_TO_NV = $FE;  
  GL_RELATIVE_ARC_TO_NV = $FF;  
  GL_GLYPH_HAS_KERNING_BIT_NV = $100;  
  GL_PRIMARY_COLOR_NV = $852C;  
  GL_SECONDARY_COLOR_NV = $852D;  
//  GL_PRIMARY_COLOR = $8577;      doppelt
  GL_PATH_FORMAT_SVG_NV = $9070;  
  GL_PATH_FORMAT_PS_NV = $9071;  
  GL_STANDARD_FONT_NAME_NV = $9072;  
  GL_SYSTEM_FONT_NAME_NV = $9073;  
  GL_FILE_NAME_NV = $9074;  
  GL_PATH_STROKE_WIDTH_NV = $9075;  
  GL_PATH_END_CAPS_NV = $9076;  
  GL_PATH_INITIAL_END_CAP_NV = $9077;  
  GL_PATH_TERMINAL_END_CAP_NV = $9078;  
  GL_PATH_JOIN_STYLE_NV = $9079;  
  GL_PATH_MITER_LIMIT_NV = $907A;  
  GL_PATH_DASH_CAPS_NV = $907B;  
  GL_PATH_INITIAL_DASH_CAP_NV = $907C;  
  GL_PATH_TERMINAL_DASH_CAP_NV = $907D;  
  GL_PATH_DASH_OFFSET_NV = $907E;  
  GL_PATH_CLIENT_LENGTH_NV = $907F;  
  GL_PATH_FILL_MODE_NV = $9080;  
  GL_PATH_FILL_MASK_NV = $9081;  
  GL_PATH_FILL_COVER_MODE_NV = $9082;  
  GL_PATH_STROKE_COVER_MODE_NV = $9083;  
  GL_PATH_STROKE_MASK_NV = $9084;  
  GL_PATH_STROKE_BOUND_NV = $9086;  
  GL_COUNT_UP_NV = $9088;  
  GL_COUNT_DOWN_NV = $9089;  
  GL_PATH_OBJECT_BOUNDING_BOX_NV = $908A;  
  GL_CONVEX_HULL_NV = $908B;  
  GL_BOUNDING_BOX_NV = $908D;  
  GL_TRANSLATE_X_NV = $908E;  
  GL_TRANSLATE_Y_NV = $908F;  
  GL_TRANSLATE_2D_NV = $9090;  
  GL_TRANSLATE_3D_NV = $9091;  
  GL_AFFINE_2D_NV = $9092;  
  GL_AFFINE_3D_NV = $9094;  
  GL_TRANSPOSE_AFFINE_2D_NV = $9096;  
  GL_TRANSPOSE_AFFINE_3D_NV = $9098;  
  GL_UTF8_NV = $909A;  
  GL_UTF16_NV = $909B;  
  GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV = $909C;  
  GL_PATH_COMMAND_COUNT_NV = $909D;  
  GL_PATH_COORD_COUNT_NV = $909E;  
  GL_PATH_DASH_ARRAY_COUNT_NV = $909F;  
  GL_PATH_COMPUTED_LENGTH_NV = $90A0;  
  GL_PATH_FILL_BOUNDING_BOX_NV = $90A1;  
  GL_PATH_STROKE_BOUNDING_BOX_NV = $90A2;  
  GL_SQUARE_NV = $90A3;  
  GL_ROUND_NV = $90A4;  
  GL_TRIANGULAR_NV = $90A5;  
  GL_BEVEL_NV = $90A6;  
  GL_MITER_REVERT_NV = $90A7;  
  GL_MITER_TRUNCATE_NV = $90A8;  
  GL_SKIP_MISSING_GLYPH_NV = $90A9;  
  GL_USE_MISSING_GLYPH_NV = $90AA;  
  GL_PATH_ERROR_POSITION_NV = $90AB;  
  GL_PATH_FOG_GEN_MODE_NV = $90AC;  
  GL_ACCUM_ADJACENT_PAIRS_NV = $90AD;  
  GL_ADJACENT_PAIRS_NV = $90AE;  
  GL_FIRST_TO_REST_NV = $90AF;  
  GL_PATH_GEN_MODE_NV = $90B0;  
  GL_PATH_GEN_COEFF_NV = $90B1;  
  GL_PATH_GEN_COLOR_FORMAT_NV = $90B2;  
  GL_PATH_GEN_COMPONENTS_NV = $90B3;  
  GL_PATH_DASH_OFFSET_RESET_NV = $90B4;  
  GL_MOVE_TO_RESETS_NV = $90B5;  
  GL_MOVE_TO_CONTINUES_NV = $90B6;  
  GL_PATH_STENCIL_FUNC_NV = $90B7;  
  GL_PATH_STENCIL_REF_NV = $90B8;  
  GL_PATH_STENCIL_VALUE_MASK_NV = $90B9;  
  GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = $90BD;  
  GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = $90BE;  
  GL_PATH_COVER_DEPTH_FUNC_NV = $90BF;  
  GL_FONT_GLYPHS_AVAILABLE_NV = $9368;  
  GL_FONT_TARGET_UNAVAILABLE_NV = $9369;  
  GL_FONT_UNAVAILABLE_NV = $936A;  
  GL_FONT_UNINTELLIGIBLE_NV = $936B;  
  GL_STANDARD_FONT_FORMAT_NV = $936C;  
  GL_FRAGMENT_INPUT_NV = $936D;  
  GL_FONT_X_MIN_BOUNDS_BIT_NV = $00010000;  
  GL_FONT_Y_MIN_BOUNDS_BIT_NV = $00020000;  
  GL_FONT_X_MAX_BOUNDS_BIT_NV = $00040000;  
  GL_FONT_Y_MAX_BOUNDS_BIT_NV = $00080000;  
  GL_FONT_UNITS_PER_EM_BIT_NV = $00100000;  
  GL_FONT_ASCENDER_BIT_NV = $00200000;  
  GL_FONT_DESCENDER_BIT_NV = $00400000;  
  GL_FONT_HEIGHT_BIT_NV = $00800000;  
  GL_FONT_MAX_ADVANCE_WIDTH_BIT_NV = $01000000;  
  GL_FONT_MAX_ADVANCE_HEIGHT_BIT_NV = $02000000;  
  GL_FONT_UNDERLINE_POSITION_BIT_NV = $04000000;  
  GL_FONT_UNDERLINE_THICKNESS_BIT_NV = $08000000;  
  GL_FONT_HAS_KERNING_BIT_NV = $10000000;  
  GL_FONT_NUM_GLYPH_INDICES_BIT_NV = $20000000;  
type
  TPFNGLCOPYPATHNVPROC = procedure (resultPath:TGLuint; srcPath:TGLuint);cdecl;
  TPFNGLCOVERFILLPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; coverMode:TGLenum;
                transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLCOVERFILLPATHNVPROC = procedure (path:TGLuint; coverMode:TGLenum);cdecl;
  TPFNGLCOVERSTROKEPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; coverMode:TGLenum;
                transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLCOVERSTROKEPATHNVPROC = procedure (path:TGLuint; coverMode:TGLenum);cdecl;
  TPFNGLDELETEPATHSNVPROC = procedure (path:TGLuint; range:TGLsizei);cdecl;
  TPFNGLGENPATHSNVPROC = function (range:TGLsizei):TGLuint;cdecl;
  TPFNGLGETPATHCOLORGENFVNVPROC = procedure (color:TGLenum; pname:TGLenum; value:PGLfloat);cdecl;
  TPFNGLGETPATHCOLORGENIVNVPROC = procedure (color:TGLenum; pname:TGLenum; value:PGLint);cdecl;
  TPFNGLGETPATHCOMMANDSNVPROC = procedure (path:TGLuint; commands:PGLubyte);cdecl;
  TPFNGLGETPATHCOORDSNVPROC = procedure (path:TGLuint; coords:PGLfloat);cdecl;
  TPFNGLGETPATHDASHARRAYNVPROC = procedure (path:TGLuint; dashArray:PGLfloat);cdecl;
  TPFNGLGETPATHLENGTHNVPROC = function (path:TGLuint; startSegment:TGLsizei; numSegments:TGLsizei):TGLfloat;cdecl;
  TPFNGLGETPATHMETRICRANGENVPROC = procedure (metricQueryMask:TGLbitfield; firstPathName:TGLuint; numPaths:TGLsizei; stride:TGLsizei; metrics:PGLfloat);cdecl;
  TPFNGLGETPATHMETRICSNVPROC = procedure (metricQueryMask:TGLbitfield; numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint;
                stride:TGLsizei; metrics:PGLfloat);cdecl;
  TPFNGLGETPATHPARAMETERFVNVPROC = procedure (path:TGLuint; pname:TGLenum; value:PGLfloat);cdecl;
  TPFNGLGETPATHPARAMETERIVNVPROC = procedure (path:TGLuint; pname:TGLenum; value:PGLint);cdecl;
  TPFNGLGETPATHSPACINGNVPROC = procedure (pathListMode:TGLenum; numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint;
                advanceScale:TGLfloat; kerningScale:TGLfloat; transformType:TGLenum; returnedSpacing:PGLfloat);cdecl;
  TPFNGLGETPATHTEXGENFVNVPROC = procedure (texCoordSet:TGLenum; pname:TGLenum; value:PGLfloat);cdecl;
  TPFNGLGETPATHTEXGENIVNVPROC = procedure (texCoordSet:TGLenum; pname:TGLenum; value:PGLint);cdecl;
  TPFNGLGETPROGRAMRESOURCEFVNVPROC = procedure (prog:TGLuint; programInterface:TGLenum; index:TGLuint; propCount:TGLsizei; props:PGLenum;
                bufSize:TGLsizei; length:PGLsizei; params:PGLfloat);cdecl;
  TPFNGLINTERPOLATEPATHSNVPROC = procedure (resultPath:TGLuint; pathA:TGLuint; pathB:TGLuint; weight:TGLfloat);cdecl;
  TPFNGLISPATHNVPROC = function (path:TGLuint):TGLboolean;cdecl;
  TPFNGLISPOINTINFILLPATHNVPROC = function (path:TGLuint; mask:TGLuint; x:TGLfloat; y:TGLfloat):TGLboolean;cdecl;
  TPFNGLISPOINTINSTROKEPATHNVPROC = function (path:TGLuint; x:TGLfloat; y:TGLfloat):TGLboolean;cdecl;
  TPFNGLMATRIXLOAD3X2FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXLOAD3X3FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXLOADTRANSPOSE3X3FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXMULT3X2FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXMULT3X3FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLMATRIXMULTTRANSPOSE3X3FNVPROC = procedure (matrixMode:TGLenum; m:PGLfloat);cdecl;
  TPFNGLPATHCOLORGENNVPROC = procedure (color:TGLenum; genMode:TGLenum; colorFormat:TGLenum; coeffs:PGLfloat);cdecl;
  TPFNGLPATHCOMMANDSNVPROC = procedure (path:TGLuint; numCommands:TGLsizei; commands:PGLubyte; numCoords:TGLsizei; coordType:TGLenum;
                coords:pointer);cdecl;
  TPFNGLPATHCOORDSNVPROC = procedure (path:TGLuint; numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;
  TPFNGLPATHCOVERDEPTHFUNCNVPROC = procedure (zfunc:TGLenum);cdecl;
  TPFNGLPATHDASHARRAYNVPROC = procedure (path:TGLuint; dashCount:TGLsizei; dashArray:PGLfloat);cdecl;
  TPFNGLPATHFOGGENNVPROC = procedure (genMode:TGLenum);cdecl;
  TPFNGLPATHGLYPHINDEXARRAYNVPROC = function (firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; firstGlyphIndex:TGLuint;
               numGlyphs:TGLsizei; pathParameterTemplate:TGLuint; emScale:TGLfloat):TGLenum;cdecl;
  TPFNGLPATHGLYPHINDEXRANGENVPROC = function (fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; pathParameterTemplate:TGLuint; emScale:TGLfloat;
               baseAndCount:TiVec2):TGLenum;cdecl;
  TPFNGLPATHGLYPHRANGENVPROC = procedure (firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; firstGlyph:TGLuint;
                numGlyphs:TGLsizei; handleMissingGlyphs:TGLenum; pathParameterTemplate:TGLuint; emScale:TGLfloat);cdecl;
  TPFNGLPATHGLYPHSNVPROC = procedure (firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; numGlyphs:TGLsizei;
               _type:TGLenum; charcodes:pointer; handleMissingGlyphs:TGLenum; pathParameterTemplate:TGLuint; emScale:TGLfloat);cdecl;
  TPFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC = function (firstPathName:TGLuint; fontTarget:TGLenum; fontSize:TGLsizeiptr; fontData:pointer; faceIndex:TGLsizei;
              firstGlyphIndex:TGLuint; numGlyphs:TGLsizei; pathParameterTemplate:TGLuint; emScale:TGLfloat):TGLenum;cdecl;
  TPFNGLPATHPARAMETERFNVPROC = procedure (path:TGLuint; pname:TGLenum; value:TGLfloat);cdecl;
  TPFNGLPATHPARAMETERFVNVPROC = procedure (path:TGLuint; pname:TGLenum; value:PGLfloat);cdecl;
  TPFNGLPATHPARAMETERINVPROC = procedure (path:TGLuint; pname:TGLenum; value:TGLint);cdecl;
  TPFNGLPATHPARAMETERIVNVPROC = procedure (path:TGLuint; pname:TGLenum; value:PGLint);cdecl;
  TPFNGLPATHSTENCILDEPTHOFFSETNVPROC = procedure (factor:TGLfloat; units:TGLfloat);cdecl;
  TPFNGLPATHSTENCILFUNCNVPROC = procedure (func:TGLenum; ref:TGLint; mask:TGLuint);cdecl;
  TPFNGLPATHSTRINGNVPROC = procedure (path:TGLuint; format:TGLenum; length:TGLsizei; pathString:pointer);cdecl;
  TPFNGLPATHSUBCOMMANDSNVPROC = procedure (path:TGLuint; commandStart:TGLsizei; commandsToDelete:TGLsizei; numCommands:TGLsizei; commands:PGLubyte;
               numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;
  TPFNGLPATHSUBCOORDSNVPROC = procedure (path:TGLuint; coordStart:TGLsizei; numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;
  TPFNGLPATHTEXGENNVPROC = procedure (texCoordSet:TGLenum; genMode:TGLenum; components:TGLint; coeffs:PGLfloat);cdecl;
  TPFNGLPOINTALONGPATHNVPROC = function (path:TGLuint; startSegment:TGLsizei; numSegments:TGLsizei; distance:TGLfloat; x:PGLfloat;
              y:PGLfloat; tangentX:PGLfloat; tangentY:PGLfloat):TGLboolean;cdecl;
  TPFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC = procedure (prog:TGLuint; location:TGLint; genMode:TGLenum; components:TGLint; coeffs:PGLfloat);cdecl;
  TPFNGLSTENCILFILLPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; fillMode:TGLenum;
               mask:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLSTENCILFILLPATHNVPROC = procedure (path:TGLuint; fillMode:TGLenum; mask:TGLuint);cdecl;
  TPFNGLSTENCILSTROKEPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; reference:TGLint;
               mask:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLSTENCILSTROKEPATHNVPROC = procedure (path:TGLuint; reference:TGLint; mask:TGLuint);cdecl;
  TPFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; fillMode:TGLenum;
               mask:TGLuint; coverMode:TGLenum; transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLSTENCILTHENCOVERFILLPATHNVPROC = procedure (path:TGLuint; fillMode:TGLenum; mask:TGLuint; coverMode:TGLenum);cdecl;
  TPFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC = procedure (numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; reference:TGLint;
               mask:TGLuint; coverMode:TGLenum; transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLSTENCILTHENCOVERSTROKEPATHNVPROC = procedure (path:TGLuint; reference:TGLint; mask:TGLuint; coverMode:TGLenum);cdecl;
  TPFNGLTRANSFORMPATHNVPROC = procedure (resultPath:TGLuint; srcPath:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;
  TPFNGLWEIGHTPATHSNVPROC = procedure (resultPath:TGLuint; numPaths:TGLsizei; paths:PGLuint; weights:PGLfloat);cdecl;


{ -------------------- GL_NV_path_rendering_shared_edge -------------------  }

const
  GL_NV_path_rendering_shared_edge = 1;  
  GL_SHARED_EDGE_NV = $C0;  


{ ----------------------- GL_NV_pixel_buffer_object -----------------------  }

const
  GL_NV_pixel_buffer_object = 1;  
  GL_PIXEL_PACK_BUFFER_NV = $88EB;  
  GL_PIXEL_UNPACK_BUFFER_NV = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING_NV = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING_NV = $88EF;  


{ ------------------------- GL_NV_pixel_data_range ------------------------  }

const
  GL_NV_pixel_data_range = 1;  
  GL_WRITE_PIXEL_DATA_RANGE_NV = $8878;  
  GL_READ_PIXEL_DATA_RANGE_NV = $8879;  
  GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = $887A;  
  GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = $887B;  
  GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = $887C;  
  GL_READ_PIXEL_DATA_RANGE_POINTER_NV = $887D;  
type
  TPFNGLFLUSHPIXELDATARANGENVPROC = procedure (target:TGLenum);cdecl;
  TPFNGLPIXELDATARANGENVPROC = procedure (target:TGLenum; length:TGLsizei; pointer:pointer);cdecl;


{ ------------------------- GL_NV_platform_binary -------------------------  }

const
  GL_NV_platform_binary = 1;  
  GL_NVIDIA_PLATFORM_BINARY_NV = $890B;  


{ --------------------------- GL_NV_point_sprite --------------------------  }

const
  GL_NV_point_sprite = 1;  
  GL_POINT_SPRITE_NV = $8861;  
  GL_COORD_REPLACE_NV = $8862;  
  GL_POINT_SPRITE_R_MODE_NV = $8863;  
type
  TPFNGLPOINTPARAMETERINVPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLPOINTPARAMETERIVNVPROC = procedure (pname:TGLenum; params:PGLint);cdecl;


{ --------------------------- GL_NV_polygon_mode --------------------------  }

const
  GL_NV_polygon_mode = 1;  
  GL_POLYGON_MODE_NV = $0B40;  
  GL_POINT_NV = $1B00;  
  GL_LINE_NV = $1B01;  
  GL_FILL_NV = $1B02;  
  GL_POLYGON_OFFSET_POINT_NV = $2A01;  
  GL_POLYGON_OFFSET_LINE_NV = $2A02;  
type
  TPFNGLPOLYGONMODENVPROC = procedure (face:TGLenum; mode:TGLenum);cdecl;


{ -------------------------- GL_NV_present_video --------------------------  }

const
  GL_NV_present_video = 1;  
  GL_FRAME_NV = $8E26;  
  GL_FIELDS_NV = $8E27;  
  GL_CURRENT_TIME_NV = $8E28;  
  GL_NUM_FILL_STREAMS_NV = $8E29;  
  GL_PRESENT_TIME_NV = $8E2A;  
  GL_PRESENT_DURATION_NV = $8E2B;  
type
  TPFNGLGETVIDEOI64VNVPROC = procedure (video_slot:TGLuint; pname:TGLenum; params:PGLint64EXT);cdecl;
  TPFNGLGETVIDEOIVNVPROC = procedure (video_slot:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVIDEOUI64VNVPROC = procedure (video_slot:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;
  TPFNGLGETVIDEOUIVNVPROC = procedure (video_slot:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLPRESENTFRAMEDUALFILLNVPROC = procedure (video_slot:TGLuint; minPresentTime:TGLuint64EXT; beginPresentTimeId:TGLuint; presentDurationId:TGLuint; _type:TGLenum;
                target0:TGLenum; fill0:TGLuint; target1:TGLenum; fill1:TGLuint; target2:TGLenum; 
                fill2:TGLuint; target3:TGLenum; fill3:TGLuint);cdecl;
  TPFNGLPRESENTFRAMEKEYEDNVPROC = procedure (video_slot:TGLuint; minPresentTime:TGLuint64EXT; beginPresentTimeId:TGLuint; presentDurationId:TGLuint; _type:TGLenum;
                target0:TGLenum; fill0:TGLuint; key0:TGLuint; target1:TGLenum; fill1:TGLuint; 
                key1:TGLuint);cdecl;


{ ------------------------ GL_NV_primitive_restart ------------------------  }

const
  GL_NV_primitive_restart = 1;  
  GL_PRIMITIVE_RESTART_NV = $8558;  
  GL_PRIMITIVE_RESTART_INDEX_NV = $8559;  
type
  TPFNGLPRIMITIVERESTARTINDEXNVPROC = procedure (index:TGLuint);cdecl;
  TPFNGLPRIMITIVERESTARTNVPROC = procedure (para1:pointer);cdecl;


{ ------------------------ GL_NV_query_resource_tag -----------------------  }

const
  GL_NV_query_resource_tag = 1;  


{ --------------------------- GL_NV_read_buffer ---------------------------  }

const
  GL_NV_read_buffer = 1;  
  GL_READ_BUFFER_NV = $0C02;  
type
  TPFNGLREADBUFFERNVPROC = procedure (mode:TGLenum);cdecl;


{ ------------------------ GL_NV_read_buffer_front ------------------------  }

const
  GL_NV_read_buffer_front = 1;  
//  GL_READ_BUFFER_NV = $0C02;   doppelt


{ ---------------------------- GL_NV_read_depth ---------------------------  }

const
  GL_NV_read_depth = 1;  


{ ------------------------ GL_NV_read_depth_stencil -----------------------  }

const
  GL_NV_read_depth_stencil = 1;  


{ --------------------------- GL_NV_read_stencil --------------------------  }

const
  GL_NV_read_stencil = 1;  


{ ------------------------ GL_NV_register_combiners -----------------------  }

const
  GL_NV_register_combiners = 1;  
  GL_REGISTER_COMBINERS_NV = $8522;  
  GL_VARIABLE_A_NV = $8523;  
  GL_VARIABLE_B_NV = $8524;  
  GL_VARIABLE_C_NV = $8525;  
  GL_VARIABLE_D_NV = $8526;  
  GL_VARIABLE_E_NV = $8527;  
  GL_VARIABLE_F_NV = $8528;  
  GL_VARIABLE_G_NV = $8529;  
  GL_CONSTANT_COLOR0_NV = $852A;  
  GL_CONSTANT_COLOR1_NV = $852B;  
//  GL_PRIMARY_COLOR_NV = $852C;     doppelt
//  GL_SECONDARY_COLOR_NV = $852D;  
  GL_SPARE0_NV = $852E;  
  GL_SPARE1_NV = $852F;  
  GL_DISCARD_NV = $8530;  
  GL_E_TIMES_F_NV = $8531;  
  GL_SPARE0_PLUS_SECONDARY_COLOR_NV = $8532;  
  GL_UNSIGNED_IDENTITY_NV = $8536;  
  GL_UNSIGNED_INVERT_NV = $8537;  
  GL_EXPAND_NORMAL_NV = $8538;  
  GL_EXPAND_NEGATE_NV = $8539;  
  GL_HALF_BIAS_NORMAL_NV = $853A;  
  GL_HALF_BIAS_NEGATE_NV = $853B;  
  GL_SIGNED_IDENTITY_NV = $853C;  
  GL_SIGNED_NEGATE_NV = $853D;  
  GL_SCALE_BY_TWO_NV = $853E;  
  GL_SCALE_BY_FOUR_NV = $853F;  
  GL_SCALE_BY_ONE_HALF_NV = $8540;  
  GL_BIAS_BY_NEGATIVE_ONE_HALF_NV = $8541;  
  GL_COMBINER_INPUT_NV = $8542;  
  GL_COMBINER_MAPPING_NV = $8543;  
  GL_COMBINER_COMPONENT_USAGE_NV = $8544;  
  GL_COMBINER_AB_DOT_PRODUCT_NV = $8545;  
  GL_COMBINER_CD_DOT_PRODUCT_NV = $8546;  
  GL_COMBINER_MUX_SUM_NV = $8547;  
  GL_COMBINER_SCALE_NV = $8548;  
  GL_COMBINER_BIAS_NV = $8549;  
  GL_COMBINER_AB_OUTPUT_NV = $854A;  
  GL_COMBINER_CD_OUTPUT_NV = $854B;  
  GL_COMBINER_SUM_OUTPUT_NV = $854C;  
  GL_MAX_GENERAL_COMBINERS_NV = $854D;  
  GL_NUM_GENERAL_COMBINERS_NV = $854E;  
  GL_COLOR_SUM_CLAMP_NV = $854F;  
  GL_COMBINER0_NV = $8550;  
  GL_COMBINER1_NV = $8551;  
  GL_COMBINER2_NV = $8552;  
  GL_COMBINER3_NV = $8553;  
  GL_COMBINER4_NV = $8554;  
  GL_COMBINER5_NV = $8555;  
  GL_COMBINER6_NV = $8556;  
  GL_COMBINER7_NV = $8557;  
type
  TPFNGLCOMBINERINPUTNVPROC = procedure (stage:TGLenum; portion:TGLenum; variable:TGLenum; input:TGLenum; mapping:TGLenum;
                componentUsage:TGLenum);cdecl;
  TPFNGLCOMBINEROUTPUTNVPROC = procedure (stage:TGLenum; portion:TGLenum; abOutput:TGLenum; cdOutput:TGLenum; sumOutput:TGLenum;
                scale:TGLenum; bias:TGLenum; abDotProduct:TGLboolean; cdDotProduct:TGLboolean; muxSum:TGLboolean);cdecl;
  TPFNGLCOMBINERPARAMETERFNVPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLCOMBINERPARAMETERFVNVPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLCOMBINERPARAMETERINVPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLCOMBINERPARAMETERIVNVPROC = procedure (pname:TGLenum; params:PGLint);cdecl;
  TPFNGLFINALCOMBINERINPUTNVPROC = procedure (variable:TGLenum; input:TGLenum; mapping:TGLenum; componentUsage:TGLenum);cdecl;
  TPFNGLGETCOMBINERINPUTPARAMETERFVNVPROC = procedure (stage:TGLenum; portion:TGLenum; variable:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOMBINERINPUTPARAMETERIVNVPROC = procedure (stage:TGLenum; portion:TGLenum; variable:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC = procedure (stage:TGLenum; portion:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC = procedure (stage:TGLenum; portion:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC = procedure (variable:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC = procedure (variable:TGLenum; pname:TGLenum; params:PGLint);cdecl;


{ ----------------------- GL_NV_register_combiners2 -----------------------  }

const
  GL_NV_register_combiners2 = 1;  
  GL_PER_STAGE_CONSTANTS_NV = $8535;  
type
  TPFNGLCOMBINERSTAGEPARAMETERFVNVPROC = procedure (stage:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC = procedure (stage:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;


{ ------------------- GL_NV_representative_fragment_test ------------------  }

const
  GL_NV_representative_fragment_test = 1;  
  GL_REPRESENTATIVE_FRAGMENT_TEST_NV = $937F;  


{ ------------------ GL_NV_robustness_video_memory_purge ------------------  }

const
  GL_NV_robustness_video_memory_purge = 1;  
  GL_PURGED_CONTEXT_RESET_NV = $92BB;  


{ --------------------------- GL_NV_sRGB_formats --------------------------  }

const
  GL_NV_sRGB_formats = 1;  
  GL_ETC1_SRGB8_NV = $88EE;  
  GL_SRGB8_NV = $8C41;  
  GL_SLUMINANCE_ALPHA_NV = $8C44;  
  GL_SLUMINANCE8_ALPHA8_NV = $8C45;  
  GL_SLUMINANCE_NV = $8C46;  
  GL_SLUMINANCE8_NV = $8C47;  
  GL_COMPRESSED_SRGB_S3TC_DXT1_NV = $8C4C;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_NV = $8C4D;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_NV = $8C4E;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_NV = $8C4F;  


{ ------------------------- GL_NV_sample_locations ------------------------  }

const
  GL_NV_sample_locations = 1;  
  GL_SAMPLE_LOCATION_NV = $8E50;  
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = $933D;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = $933E;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = $933F;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = $9340;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9341;  
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = $9342;  
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = $9343;  
type
  TPFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC = procedure (target:TGLenum; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC = procedure (framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLRESOLVEDEPTHVALUESNVPROC = procedure (para1:pointer);cdecl;


{ ------------------ GL_NV_sample_mask_override_coverage ------------------  }

const
  GL_NV_sample_mask_override_coverage = 1;  


{ ------------------------ GL_NV_scissor_exclusive ------------------------  }

const
  GL_NV_scissor_exclusive = 1;  
  GL_SCISSOR_TEST_EXCLUSIVE_NV = $9555;  
  GL_SCISSOR_BOX_EXCLUSIVE_NV = $9556;  
type
  TPFNGLSCISSOREXCLUSIVEARRAYVNVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLint);cdecl;
  TPFNGLSCISSOREXCLUSIVENVPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;


{ ---------------------- GL_NV_shader_atomic_counters ---------------------  }

const
  GL_NV_shader_atomic_counters = 1;  


{ ----------------------- GL_NV_shader_atomic_float -----------------------  }

const
  GL_NV_shader_atomic_float = 1;  


{ ---------------------- GL_NV_shader_atomic_float64 ----------------------  }

const
  GL_NV_shader_atomic_float64 = 1;  


{ -------------------- GL_NV_shader_atomic_fp16_vector --------------------  }

const
  GL_NV_shader_atomic_fp16_vector = 1;  


{ ----------------------- GL_NV_shader_atomic_int64 -----------------------  }

const
  GL_NV_shader_atomic_int64 = 1;  


{ ------------------------ GL_NV_shader_buffer_load -----------------------  }

const
  GL_NV_shader_buffer_load = 1;  
  GL_BUFFER_GPU_ADDRESS_NV = $8F1D;  
  GL_GPU_ADDRESS_NV = $8F34;  
  GL_MAX_SHADER_BUFFER_ADDRESS_NV = $8F35;  
type
  TPFNGLGETBUFFERPARAMETERUI64VNVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint64EXT);cdecl;
  TPFNGLGETINTEGERUI64VNVPROC = procedure (value:TGLenum; result:PGLuint64EXT);cdecl;
  TPFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC = procedure (buffer:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;
  TPFNGLISBUFFERRESIDENTNVPROC = function (target:TGLenum):TGLboolean;cdecl;
  TPFNGLISNAMEDBUFFERRESIDENTNVPROC = function (buffer:TGLuint):TGLboolean;cdecl;
  TPFNGLMAKEBUFFERNONRESIDENTNVPROC = procedure (target:TGLenum);cdecl;
  TPFNGLMAKEBUFFERRESIDENTNVPROC = procedure (target:TGLenum; access:TGLenum);cdecl;
  TPFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC = procedure (buffer:TGLuint);cdecl;
  TPFNGLMAKENAMEDBUFFERRESIDENTNVPROC = procedure (buffer:TGLuint; access:TGLenum);cdecl;
  TPFNGLPROGRAMUNIFORMUI64NVPROC = procedure (prog:TGLuint; location:TGLint; value:TGLuint64EXT);cdecl;
  TPFNGLPROGRAMUNIFORMUI64VNVPROC = procedure (prog:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;
  TPFNGLUNIFORMUI64NVPROC = procedure (location:TGLint; value:TGLuint64EXT);cdecl;
  TPFNGLUNIFORMUI64VNVPROC = procedure (location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;


{ ---------------- GL_NV_shader_noperspective_interpolation ---------------  }

const
  GL_NV_shader_noperspective_interpolation = 1;  


{ ------------------- GL_NV_shader_storage_buffer_object ------------------  }

const
  GL_NV_shader_storage_buffer_object = 1;  


{ ------------------- GL_NV_shader_subgroup_partitioned -------------------  }

const
  GL_NV_shader_subgroup_partitioned = 1;  
  GL_SUBGROUP_FEATURE_PARTITIONED_BIT_NV = $00000100;  


{ --------------------- GL_NV_shader_texture_footprint --------------------  }

const
  GL_NV_shader_texture_footprint = 1;  


{ ----------------------- GL_NV_shader_thread_group -----------------------  }

const
  GL_NV_shader_thread_group = 1;  
  GL_WARP_SIZE_NV = $9339;  
  GL_WARPS_PER_SM_NV = $933A;  
  GL_SM_COUNT_NV = $933B;  


{ ---------------------- GL_NV_shader_thread_shuffle ----------------------  }

const
  GL_NV_shader_thread_shuffle = 1;  


{ ------------------------ GL_NV_shading_rate_image -----------------------  }

const
  GL_NV_shading_rate_image = 1;  
  GL_SHADING_RATE_IMAGE_BINDING_NV = $955B;  
  GL_SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = $955C;  
  GL_SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = $955D;  
  GL_SHADING_RATE_IMAGE_PALETTE_SIZE_NV = $955E;  
  GL_MAX_COARSE_FRAGMENT_SAMPLES_NV = $955F;  
  GL_SHADING_RATE_IMAGE_NV = $9563;  
  GL_SHADING_RATE_NO_INVOCATIONS_NV = $9564;  
  GL_SHADING_RATE_1_INVOCATION_PER_PIXEL_NV = $9565;  
  GL_SHADING_RATE_1_INVOCATION_PER_1X2_PIXELS_NV = $9566;  
  GL_SHADING_RATE_1_INVOCATION_PER_2X1_PIXELS_NV = $9567;  
  GL_SHADING_RATE_1_INVOCATION_PER_2X2_PIXELS_NV = $9568;  
  GL_SHADING_RATE_1_INVOCATION_PER_2X4_PIXELS_NV = $9569;  
  GL_SHADING_RATE_1_INVOCATION_PER_4X2_PIXELS_NV = $956A;  
  GL_SHADING_RATE_1_INVOCATION_PER_4X4_PIXELS_NV = $956B;  
  GL_SHADING_RATE_2_INVOCATIONS_PER_PIXEL_NV = $956C;  
  GL_SHADING_RATE_4_INVOCATIONS_PER_PIXEL_NV = $956D;  
  GL_SHADING_RATE_8_INVOCATIONS_PER_PIXEL_NV = $956E;  
  GL_SHADING_RATE_16_INVOCATIONS_PER_PIXEL_NV = $956F;  
  GL_SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = $95AE;  
  GL_SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = $95AF;  
  GL_SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = $95B0;  
type
  TPFNGLBINDSHADINGRATEIMAGENVPROC = procedure (texture:TGLuint);cdecl;
  TPFNGLGETSHADINGRATEIMAGEPALETTENVPROC = procedure (viewport:TGLuint; entry:TGLuint; rate:PGLenum);cdecl;
  TPFNGLGETSHADINGRATESAMPLELOCATIONIVNVPROC = procedure (rate:TGLenum; samples:TGLuint; index:TGLuint; location:PGLint);cdecl;
  TPFNGLSHADINGRATEIMAGEBARRIERNVPROC = procedure (order:TGLenum);cdecl;
  TPFNGLSHADINGRATEIMAGEPALETTENVPROC = procedure (viewport:TGLuint; first:TGLuint; count:TGLsizei; rates:PGLenum);cdecl;
  TPFNGLSHADINGRATESAMPLEORDERCUSTOMNVPROC = procedure (rate:TGLenum; samples:TGLuint; locations:PGLint);cdecl;


{ ---------------------- GL_NV_shadow_samplers_array ----------------------  }

const
  GL_NV_shadow_samplers_array = 1;  
  GL_SAMPLER_2D_ARRAY_SHADOW_NV = $8DC4;  


{ ----------------------- GL_NV_shadow_samplers_cube ----------------------  }

const
  GL_NV_shadow_samplers_cube = 1;  
  GL_SAMPLER_CUBE_SHADOW_NV = $8DC5;  


{ ---------------------- GL_NV_stereo_view_rendering ----------------------  }

const
  GL_NV_stereo_view_rendering = 1;  


{ ---------------------- GL_NV_tessellation_program5 ----------------------  }

const
  GL_NV_tessellation_program5 = 1;  
  GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = $86D8;  
  GL_TESS_CONTROL_PROGRAM_NV = $891E;  
  GL_TESS_EVALUATION_PROGRAM_NV = $891F;  
  GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = $8C74;  
  GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = $8C75;  


{ -------------------------- GL_NV_texgen_emboss --------------------------  }

const
  GL_NV_texgen_emboss = 1;  
  GL_EMBOSS_LIGHT_NV = $855D;  
  GL_EMBOSS_CONSTANT_NV = $855E;  
  GL_EMBOSS_MAP_NV = $855F;  


{ ------------------------ GL_NV_texgen_reflection ------------------------  }

const
  GL_NV_texgen_reflection = 1;  
  GL_NORMAL_MAP_NV = $8511;  
  GL_REFLECTION_MAP_NV = $8512;  


{ -------------------------- GL_NV_texture_array --------------------------  }

const
  GL_NV_texture_array = 1;  
  GL_UNPACK_SKIP_IMAGES_NV = $806D;  
  GL_UNPACK_IMAGE_HEIGHT_NV = $806E;  
  GL_MAX_ARRAY_TEXTURE_LAYERS_NV = $88FF;  
  GL_TEXTURE_2D_ARRAY_NV = $8C1A;  
  GL_TEXTURE_BINDING_2D_ARRAY_NV = $8C1D;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_NV = $8CD4;  
  GL_SAMPLER_2D_ARRAY_NV = $8DC1;  
type
  TPFNGLCOMPRESSEDTEXIMAGE3DNVPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE3DNVPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
                data:pointer);cdecl;
  TPFNGLCOPYTEXSUBIMAGE3DNVPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLFRAMEBUFFERTEXTURELAYERNVPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;
  TPFNGLTEXIMAGE3DNVPROC = procedure (target:TGLenum; level:TGLint; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE3DNVPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;


{ ------------------------- GL_NV_texture_barrier -------------------------  }

const
  GL_NV_texture_barrier = 1;  
type
  TPFNGLTEXTUREBARRIERNVPROC = procedure (para1:pointer);cdecl;


{ ----------------------- GL_NV_texture_border_clamp ----------------------  }

const
  GL_NV_texture_border_clamp = 1;  
  GL_TEXTURE_BORDER_COLOR_NV = $1004;  
  GL_CLAMP_TO_BORDER_NV = $812D;  


{ --------------------- GL_NV_texture_compression_latc --------------------  }

const
  GL_NV_texture_compression_latc = 1;  
  GL_COMPRESSED_LUMINANCE_LATC1_NV = $8C70;  
  GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_NV = $8C71;  
  GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_NV = $8C72;  
  GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_NV = $8C73;  


{ --------------------- GL_NV_texture_compression_s3tc --------------------  }

const
  GL_NV_texture_compression_s3tc = 1;  
  GL_COMPRESSED_RGB_S3TC_DXT1_NV = $83F0;  
  GL_COMPRESSED_RGBA_S3TC_DXT1_NV = $83F1;  
  GL_COMPRESSED_RGBA_S3TC_DXT3_NV = $83F2;  
  GL_COMPRESSED_RGBA_S3TC_DXT5_NV = $83F3;  


{ ----------------- GL_NV_texture_compression_s3tc_update -----------------  }

const
  GL_NV_texture_compression_s3tc_update = 1;  


{ --------------------- GL_NV_texture_compression_vtc ---------------------  }

const
  GL_NV_texture_compression_vtc = 1;  


{ ----------------------- GL_NV_texture_env_combine4 ----------------------  }

const
  GL_NV_texture_env_combine4 = 1;  
  GL_COMBINE4_NV = $8503;  
  GL_SOURCE3_RGB_NV = $8583;  
  GL_SOURCE3_ALPHA_NV = $858B;  
  GL_OPERAND3_RGB_NV = $8593;  
  GL_OPERAND3_ALPHA_NV = $859B;  


{ ---------------------- GL_NV_texture_expand_normal ----------------------  }

const
  GL_NV_texture_expand_normal = 1;  
  GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = $888F;  


{ ----------------------- GL_NV_texture_multisample -----------------------  }

const
  GL_NV_texture_multisample = 1;  
  GL_TEXTURE_COVERAGE_SAMPLES_NV = $9045;  
  GL_TEXTURE_COLOR_SAMPLES_NV = $9046;  
type
  TPFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC = procedure (target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; width:TGLsizei;
               height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;
  TPFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC = procedure (target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;
  TPFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC = procedure (texture:TGLuint; target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint;
                width:TGLsizei; height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;
  TPFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC = procedure (texture:TGLuint; target:TGLenum; samples:TGLsizei; internalFormat:TGLint; width:TGLsizei;
                height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;
 TPFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC = procedure (texture:TGLuint; target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint;
               width:TGLsizei; height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;
  TPFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC = procedure (texture:TGLuint; target:TGLenum; samples:TGLsizei; internalFormat:TGLint; width:TGLsizei;
                height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;


{ ---------------------- GL_NV_texture_npot_2D_mipmap ---------------------  }

const
  GL_NV_texture_npot_2D_mipmap = 1;  


{ ------------------------ GL_NV_texture_rectangle ------------------------  }

const
  GL_NV_texture_rectangle = 1;  
  GL_TEXTURE_RECTANGLE_NV = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE_NV = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE_NV = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = $84F8;  


{ ------------------- GL_NV_texture_rectangle_compressed ------------------  }

const
  GL_NV_texture_rectangle_compressed = 1;  


{ -------------------------- GL_NV_texture_shader -------------------------  }

const
  GL_NV_texture_shader = 1;  
  GL_OFFSET_TEXTURE_RECTANGLE_NV = $864C;  
  GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV = $864D;  
  GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV = $864E;  
  GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = $86D9;  
  GL_UNSIGNED_INT_S8_S8_8_8_NV = $86DA;  
  GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = $86DB;  
  GL_DSDT_MAG_INTENSITY_NV = $86DC;  
  GL_SHADER_CONSISTENT_NV = $86DD;  
  GL_TEXTURE_SHADER_NV = $86DE;  
  GL_SHADER_OPERATION_NV = $86DF;  
  GL_CULL_MODES_NV = $86E0;  
  GL_OFFSET_TEXTURE_2D_MATRIX_NV = $86E1;  
  GL_OFFSET_TEXTURE_MATRIX_NV = $86E1;  
  GL_OFFSET_TEXTURE_2D_SCALE_NV = $86E2;  
  GL_OFFSET_TEXTURE_SCALE_NV = $86E2;  
  GL_OFFSET_TEXTURE_2D_BIAS_NV = $86E3;  
  GL_OFFSET_TEXTURE_BIAS_NV = $86E3;  
  GL_PREVIOUS_TEXTURE_INPUT_NV = $86E4;  
  GL_CONST_EYE_NV = $86E5;  
  GL_PASS_THROUGH_NV = $86E6;  
  GL_CULL_FRAGMENT_NV = $86E7;  
  GL_OFFSET_TEXTURE_2D_NV = $86E8;  
  GL_DEPENDENT_AR_TEXTURE_2D_NV = $86E9;  
  GL_DEPENDENT_GB_TEXTURE_2D_NV = $86EA;  
  GL_DOT_PRODUCT_NV = $86EC;  
  GL_DOT_PRODUCT_DEPTH_REPLACE_NV = $86ED;  
  GL_DOT_PRODUCT_TEXTURE_2D_NV = $86EE;  
  GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = $86F0;  
  GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = $86F1;  
  GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV = $86F2;  
  GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = $86F3;  
  GL_HILO_NV = $86F4;  
  GL_DSDT_NV = $86F5;  
  GL_DSDT_MAG_NV = $86F6;  
  GL_DSDT_MAG_VIB_NV = $86F7;  
  GL_HILO16_NV = $86F8;  
  GL_SIGNED_HILO_NV = $86F9;  
  GL_SIGNED_HILO16_NV = $86FA;  
  GL_SIGNED_RGBA_NV = $86FB;  
  GL_SIGNED_RGBA8_NV = $86FC;  
  GL_SIGNED_RGB_NV = $86FE;  
  GL_SIGNED_RGB8_NV = $86FF;  
  GL_SIGNED_LUMINANCE_NV = $8701;  
  GL_SIGNED_LUMINANCE8_NV = $8702;  
  GL_SIGNED_LUMINANCE_ALPHA_NV = $8703;  
  GL_SIGNED_LUMINANCE8_ALPHA8_NV = $8704;  
  GL_SIGNED_ALPHA_NV = $8705;  
  GL_SIGNED_ALPHA8_NV = $8706;  
  GL_SIGNED_INTENSITY_NV = $8707;  
  GL_SIGNED_INTENSITY8_NV = $8708;  
  GL_DSDT8_NV = $8709;  
  GL_DSDT8_MAG8_NV = $870A;  
  GL_DSDT8_MAG8_INTENSITY8_NV = $870B;  
  GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = $870C;  
  GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = $870D;  
  GL_HI_SCALE_NV = $870E;  
  GL_LO_SCALE_NV = $870F;  
  GL_DS_SCALE_NV = $8710;  
  GL_DT_SCALE_NV = $8711;  
  GL_MAGNITUDE_SCALE_NV = $8712;  
  GL_VIBRANCE_SCALE_NV = $8713;  
  GL_HI_BIAS_NV = $8714;  
  GL_LO_BIAS_NV = $8715;  
  GL_DS_BIAS_NV = $8716;  
  GL_DT_BIAS_NV = $8717;  
  GL_MAGNITUDE_BIAS_NV = $8718;  
  GL_VIBRANCE_BIAS_NV = $8719;  
  GL_TEXTURE_BORDER_VALUES_NV = $871A;  
  GL_TEXTURE_HI_SIZE_NV = $871B;  
  GL_TEXTURE_LO_SIZE_NV = $871C;  
  GL_TEXTURE_DS_SIZE_NV = $871D;  
  GL_TEXTURE_DT_SIZE_NV = $871E;  
  GL_TEXTURE_MAG_SIZE_NV = $871F;  


{ ------------------------- GL_NV_texture_shader2 -------------------------  }

const
  GL_NV_texture_shader2 = 1;  
//  GL_UNSIGNED_INT_S8_S8_8_8_NV = $86DA;     doppelt
//  GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = $86DB;  
//  GL_DSDT_MAG_INTENSITY_NV = $86DC;  
  GL_DOT_PRODUCT_TEXTURE_3D_NV = $86EF;  
  //GL_HILO_NV = $86F4;  
  //GL_DSDT_NV = $86F5;  
  //GL_DSDT_MAG_NV = $86F6;  
  //GL_DSDT_MAG_VIB_NV = $86F7;  
  //GL_HILO16_NV = $86F8;  
  //GL_SIGNED_HILO_NV = $86F9;  
  //GL_SIGNED_HILO16_NV = $86FA;  
  //GL_SIGNED_RGBA_NV = $86FB;  
  //GL_SIGNED_RGBA8_NV = $86FC;  
  //GL_SIGNED_RGB_NV = $86FE;  
  //GL_SIGNED_RGB8_NV = $86FF;  
  //GL_SIGNED_LUMINANCE_NV = $8701;  
  //GL_SIGNED_LUMINANCE8_NV = $8702;  
  //GL_SIGNED_LUMINANCE_ALPHA_NV = $8703;  
  //GL_SIGNED_LUMINANCE8_ALPHA8_NV = $8704;  
  //GL_SIGNED_ALPHA_NV = $8705;  
  //GL_SIGNED_ALPHA8_NV = $8706;  
  //GL_SIGNED_INTENSITY_NV = $8707;  
  //GL_SIGNED_INTENSITY8_NV = $8708;  
  //GL_DSDT8_NV = $8709;  
  //GL_DSDT8_MAG8_NV = $870A;  
  //GL_DSDT8_MAG8_INTENSITY8_NV = $870B;  
  //GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = $870C;  
  //GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = $870D;  


{ ------------------------- GL_NV_texture_shader3 -------------------------  }

const
  GL_NV_texture_shader3 = 1;  
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV = $8850;  
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = $8851;  
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8852;  
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = $8853;  
  GL_OFFSET_HILO_TEXTURE_2D_NV = $8854;  
  GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV = $8855;  
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = $8856;  
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8857;  
  GL_DEPENDENT_HILO_TEXTURE_2D_NV = $8858;  
  GL_DEPENDENT_RGB_TEXTURE_3D_NV = $8859;  
  GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = $885A;  
  GL_DOT_PRODUCT_PASS_THROUGH_NV = $885B;  
  GL_DOT_PRODUCT_TEXTURE_1D_NV = $885C;  
  GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = $885D;  
  GL_HILO8_NV = $885E;  
  GL_SIGNED_HILO8_NV = $885F;  
  GL_FORCE_BLUE_TO_ONE_NV = $8860;  


{ ------------------------ GL_NV_transform_feedback -----------------------  }

const
  GL_NV_transform_feedback = 1;  
  GL_BACK_PRIMARY_COLOR_NV = $8C77;  
  GL_BACK_SECONDARY_COLOR_NV = $8C78;  
  GL_TEXTURE_COORD_NV = $8C79;  
  GL_CLIP_DISTANCE_NV = $8C7A;  
  GL_VERTEX_ID_NV = $8C7B;  
  GL_PRIMITIVE_ID_NV = $8C7C;  
  GL_GENERIC_ATTRIB_NV = $8C7D;  
  GL_TRANSFORM_FEEDBACK_ATTRIBS_NV = $8C7E;  
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV = $8C7F;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = $8C80;  
  GL_ACTIVE_VARYINGS_NV = $8C81;  
  GL_ACTIVE_VARYING_MAX_LENGTH_NV = $8C82;  
  GL_TRANSFORM_FEEDBACK_VARYINGS_NV = $8C83;  
  GL_TRANSFORM_FEEDBACK_BUFFER_START_NV = $8C84;  
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = $8C85;  
  GL_TRANSFORM_FEEDBACK_RECORD_NV = $8C86;  
  GL_PRIMITIVES_GENERATED_NV = $8C87;  
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = $8C88;  
  GL_RASTERIZER_DISCARD_NV = $8C89;  
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = $8C8A;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = $8C8B;  
  GL_INTERLEAVED_ATTRIBS_NV = $8C8C;  
  GL_SEPARATE_ATTRIBS_NV = $8C8D;  
  GL_TRANSFORM_FEEDBACK_BUFFER_NV = $8C8E;  
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = $8C8F;  
type
  TPFNGLACTIVEVARYINGNVPROC = procedure (prog:TGLuint; name:PGLchar);cdecl;
  TPFNGLBEGINTRANSFORMFEEDBACKNVPROC = procedure (primitiveMode:TGLenum);cdecl;
  TPFNGLBINDBUFFERBASENVPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;
  TPFNGLBINDBUFFEROFFSETNVPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr);cdecl;
  TPFNGLBINDBUFFERRANGENVPROC = procedure (target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;
  TPFNGLENDTRANSFORMFEEDBACKNVPROC = procedure (para1:pointer);cdecl;
  TPFNGLGETACTIVEVARYINGNVPROC = procedure (prog:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei;
                _type:PGLenum; name:PGLchar);cdecl;
  TPFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC = procedure (prog:TGLuint; index:TGLuint; location:PGLint);cdecl;
  TPFNGLGETVARYINGLOCATIONNVPROC = function (prog:TGLuint; name:PGLchar):TGLint;cdecl;
  TPFNGLTRANSFORMFEEDBACKATTRIBSNVPROC = procedure (count:TGLuint; attribs:PGLint; bufferMode:TGLenum);cdecl;
  TPFNGLTRANSFORMFEEDBACKVARYINGSNVPROC = procedure (prog:TGLuint; count:TGLsizei; locations:PGLint; bufferMode:TGLenum);cdecl;


{ ----------------------- GL_NV_transform_feedback2 -----------------------  }

const
  GL_NV_transform_feedback2 = 1;  
  GL_TRANSFORM_FEEDBACK_NV = $8E22;  
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = $8E23;  
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = $8E24;  
  GL_TRANSFORM_FEEDBACK_BINDING_NV = $8E25;  
type
 TPFNGLBINDTRANSFORMFEEDBACKNVPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETETRANSFORMFEEDBACKSNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
 TPFNGLDRAWTRANSFORMFEEDBACKNVPROC = procedure (mode:TGLenum; id:TGLuint);cdecl;
 TPFNGLGENTRANSFORMFEEDBACKSNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLISTRANSFORMFEEDBACKNVPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLPAUSETRANSFORMFEEDBACKNVPROC = procedure (para1:pointer);cdecl;
  TPFNGLRESUMETRANSFORMFEEDBACKNVPROC = procedure (para1:pointer);cdecl;


{ ------------------ GL_NV_uniform_buffer_unified_memory ------------------  }

const
  GL_NV_uniform_buffer_unified_memory = 1;  
  GL_UNIFORM_BUFFER_UNIFIED_NV = $936E;  
  GL_UNIFORM_BUFFER_ADDRESS_NV = $936F;  
  GL_UNIFORM_BUFFER_LENGTH_NV = $9370;  


{ -------------------------- GL_NV_vdpau_interop --------------------------  }

const
  GL_NV_vdpau_interop = 1;  
  GL_SURFACE_STATE_NV = $86EB;  
  GL_SURFACE_REGISTERED_NV = $86FD;  
  GL_SURFACE_MAPPED_NV = $8700;  
  GL_WRITE_DISCARD_NV = $88BE;  
type
  PGLvdpauSurfaceNV = ^TGLvdpauSurfaceNV;
  TGLvdpauSurfaceNV = TGLintptr;

  TPFNGLVDPAUFININVPROC = procedure (para1:pointer);cdecl;
  TPFNGLVDPAUGETSURFACEIVNVPROC = procedure (surface:TGLvdpauSurfaceNV; pname:TGLenum; bufSize:TGLsizei; length:PGLsizei; values:PGLint);cdecl;
  TPFNGLVDPAUINITNVPROC = procedure (vdpDevice:pointer; getProcAddress:pointer);cdecl;
  TPFNGLVDPAUISSURFACENVPROC = procedure (surface:TGLvdpauSurfaceNV);cdecl;
  TPFNGLVDPAUMAPSURFACESNVPROC = procedure (numSurfaces:TGLsizei; surfaces:PGLvdpauSurfaceNV);cdecl;
  TPFNGLVDPAUREGISTEROUTPUTSURFACENVPROC = function (vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint):TGLvdpauSurfaceNV;cdecl;
  TPFNGLVDPAUREGISTERVIDEOSURFACENVPROC = function (vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint):TGLvdpauSurfaceNV;cdecl;
  TPFNGLVDPAUSURFACEACCESSNVPROC = procedure (surface:TGLvdpauSurfaceNV; access:TGLenum);cdecl;
  TPFNGLVDPAUUNMAPSURFACESNVPROC = procedure (numSurface:TGLsizei; surfaces:PGLvdpauSurfaceNV);cdecl;
  TPFNGLVDPAUUNREGISTERSURFACENVPROC = procedure (surface:TGLvdpauSurfaceNV);cdecl;


{ -------------------------- GL_NV_vdpau_interop2 -------------------------  }

const
  GL_NV_vdpau_interop2 = 1;  
type
  TPFNGLVDPAUREGISTERVIDEOSURFACEWITHPICTURESTRUCTURENVPROC = function (vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint; isFrameStructure:TGLboolean):TGLvdpauSurfaceNV;cdecl;


{ ------------------------ GL_NV_vertex_array_range -----------------------  }

const
  GL_NV_vertex_array_range = 1;  
  GL_VERTEX_ARRAY_RANGE_NV = $851D;  
  GL_VERTEX_ARRAY_RANGE_LENGTH_NV = $851E;  
  GL_VERTEX_ARRAY_RANGE_VALID_NV = $851F;  
  GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = $8520;  
  GL_VERTEX_ARRAY_RANGE_POINTER_NV = $8521;  
type
  TPFNGLFLUSHVERTEXARRAYRANGENVPROC = procedure (para1:pointer);cdecl;
  TPFNGLVERTEXARRAYRANGENVPROC = procedure (length:TGLsizei; pointer:pointer);cdecl;


{ ----------------------- GL_NV_vertex_array_range2 -----------------------  }

const
  GL_NV_vertex_array_range2 = 1;  
  GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = $8533;  


{ ------------------- GL_NV_vertex_attrib_integer_64bit -------------------  }

const
  GL_NV_vertex_attrib_integer_64bit = 1;  
//  GL_INT64_NV = $140E;  doppelt
//  GL_UNSIGNED_INT64_NV = $140F;  
type
  TPFNGLGETVERTEXATTRIBLI64VNVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint64EXT);cdecl;
  TPFNGLGETVERTEXATTRIBLUI64VNVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL1I64NVPROC = procedure (index:TGLuint; x:TGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL1I64VNVPROC = procedure (index:TGLuint; v:PGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL1UI64NVPROC = procedure (index:TGLuint; x:TGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL1UI64VNVPROC = procedure (index:TGLuint; v:PGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL2I64NVPROC = procedure (index:TGLuint; x:TGLint64EXT; y:TGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL2I64VNVPROC = procedure (index:TGLuint; v:PGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL2UI64NVPROC = procedure (index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL2UI64VNVPROC = procedure (index:TGLuint; v:PGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL3I64NVPROC = procedure (index:TGLuint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL3I64VNVPROC = procedure (index:TGLuint; v:PGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL3UI64NVPROC = procedure (index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL3UI64VNVPROC = procedure (index:TGLuint; v:PGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL4I64NVPROC = procedure (index:TGLuint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT; w:TGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL4I64VNVPROC = procedure (index:TGLuint; v:PGLint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL4UI64NVPROC = procedure (index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT; w:TGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBL4UI64VNVPROC = procedure (index:TGLuint; v:PGLuint64EXT);cdecl;
  TPFNGLVERTEXATTRIBLFORMATNVPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;


{ ------------------- GL_NV_vertex_buffer_unified_memory ------------------  }

const
  GL_NV_vertex_buffer_unified_memory = 1;  
  GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = $8F1E;  
  GL_ELEMENT_ARRAY_UNIFIED_NV = $8F1F;  
  GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = $8F20;  
  GL_VERTEX_ARRAY_ADDRESS_NV = $8F21;  
  GL_NORMAL_ARRAY_ADDRESS_NV = $8F22;  
  GL_COLOR_ARRAY_ADDRESS_NV = $8F23;  
  GL_INDEX_ARRAY_ADDRESS_NV = $8F24;  
  GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = $8F25;  
  GL_EDGE_FLAG_ARRAY_ADDRESS_NV = $8F26;  
  GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = $8F27;  
  GL_FOG_COORD_ARRAY_ADDRESS_NV = $8F28;  
  GL_ELEMENT_ARRAY_ADDRESS_NV = $8F29;  
  GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV = $8F2A;  
  GL_VERTEX_ARRAY_LENGTH_NV = $8F2B;  
  GL_NORMAL_ARRAY_LENGTH_NV = $8F2C;  
  GL_COLOR_ARRAY_LENGTH_NV = $8F2D;  
  GL_INDEX_ARRAY_LENGTH_NV = $8F2E;  
  GL_TEXTURE_COORD_ARRAY_LENGTH_NV = $8F2F;  
  GL_EDGE_FLAG_ARRAY_LENGTH_NV = $8F30;  
  GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = $8F31;  
  GL_FOG_COORD_ARRAY_LENGTH_NV = $8F32;  
  GL_ELEMENT_ARRAY_LENGTH_NV = $8F33;  
  GL_DRAW_INDIRECT_UNIFIED_NV = $8F40;  
  GL_DRAW_INDIRECT_ADDRESS_NV = $8F41;  
  GL_DRAW_INDIRECT_LENGTH_NV = $8F42;  
type
  TPFNGLBUFFERADDRESSRANGENVPROC = procedure (pname:TGLenum; index:TGLuint; address:TGLuint64EXT; length:TGLsizeiptr);cdecl;
  TPFNGLCOLORFORMATNVPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLEDGEFLAGFORMATNVPROC = procedure (stride:TGLsizei);cdecl;
  TPFNGLFOGCOORDFORMATNVPROC = procedure (_type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLGETINTEGERUI64I_VNVPROC = procedure (value:TGLenum; index:TGLuint; result:PGLuint64EXT);cdecl;
  TPFNGLINDEXFORMATNVPROC = procedure (_type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLNORMALFORMATNVPROC = procedure (_type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLSECONDARYCOLORFORMATNVPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLTEXCOORDFORMATNVPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLVERTEXATTRIBFORMATNVPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei);cdecl;
  TPFNGLVERTEXATTRIBIFORMATNVPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;
  TPFNGLVERTEXFORMATNVPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;


{ -------------------------- GL_NV_vertex_program -------------------------  }

const
  GL_NV_vertex_program = 1;  
  GL_VERTEX_PROGRAM_NV = $8620;  
  GL_VERTEX_STATE_PROGRAM_NV = $8621;  
  GL_ATTRIB_ARRAY_SIZE_NV = $8623;  
  GL_ATTRIB_ARRAY_STRIDE_NV = $8624;  
  GL_ATTRIB_ARRAY_TYPE_NV = $8625;  
  GL_CURRENT_ATTRIB_NV = $8626;  
  GL_PROGRAM_LENGTH_NV = $8627;  
  GL_PROGRAM_STRING_NV = $8628;  
  GL_MODELVIEW_PROJECTION_NV = $8629;  
  GL_IDENTITY_NV = $862A;  
  GL_INVERSE_NV = $862B;  
  GL_TRANSPOSE_NV = $862C;  
  GL_INVERSE_TRANSPOSE_NV = $862D;  
  GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV = $862E;  
  GL_MAX_TRACK_MATRICES_NV = $862F;  
  GL_MATRIX0_NV = $8630;  
  GL_MATRIX1_NV = $8631;  
  GL_MATRIX2_NV = $8632;  
  GL_MATRIX3_NV = $8633;  
  GL_MATRIX4_NV = $8634;  
  GL_MATRIX5_NV = $8635;  
  GL_MATRIX6_NV = $8636;  
  GL_MATRIX7_NV = $8637;  
  GL_CURRENT_MATRIX_STACK_DEPTH_NV = $8640;  
  GL_CURRENT_MATRIX_NV = $8641;  
  GL_VERTEX_PROGRAM_POINT_SIZE_NV = $8642;  
  GL_VERTEX_PROGRAM_TWO_SIDE_NV = $8643;  
  GL_PROGRAM_PARAMETER_NV = $8644;  
  GL_ATTRIB_ARRAY_POINTER_NV = $8645;  
  GL_PROGRAM_TARGET_NV = $8646;  
  GL_PROGRAM_RESIDENT_NV = $8647;  
  GL_TRACK_MATRIX_NV = $8648;  
  GL_TRACK_MATRIX_TRANSFORM_NV = $8649;  
  GL_VERTEX_PROGRAM_BINDING_NV = $864A;  
  GL_PROGRAM_ERROR_POSITION_NV = $864B;  
  GL_VERTEX_ATTRIB_ARRAY0_NV = $8650;  
  GL_VERTEX_ATTRIB_ARRAY1_NV = $8651;  
  GL_VERTEX_ATTRIB_ARRAY2_NV = $8652;  
  GL_VERTEX_ATTRIB_ARRAY3_NV = $8653;  
  GL_VERTEX_ATTRIB_ARRAY4_NV = $8654;  
  GL_VERTEX_ATTRIB_ARRAY5_NV = $8655;  
  GL_VERTEX_ATTRIB_ARRAY6_NV = $8656;  
  GL_VERTEX_ATTRIB_ARRAY7_NV = $8657;  
  GL_VERTEX_ATTRIB_ARRAY8_NV = $8658;  
  GL_VERTEX_ATTRIB_ARRAY9_NV = $8659;  
  GL_VERTEX_ATTRIB_ARRAY10_NV = $865A;  
  GL_VERTEX_ATTRIB_ARRAY11_NV = $865B;  
  GL_VERTEX_ATTRIB_ARRAY12_NV = $865C;  
  GL_VERTEX_ATTRIB_ARRAY13_NV = $865D;  
  GL_VERTEX_ATTRIB_ARRAY14_NV = $865E;  
  GL_VERTEX_ATTRIB_ARRAY15_NV = $865F;  
  GL_MAP1_VERTEX_ATTRIB0_4_NV = $8660;  
  GL_MAP1_VERTEX_ATTRIB1_4_NV = $8661;  
  GL_MAP1_VERTEX_ATTRIB2_4_NV = $8662;  
  GL_MAP1_VERTEX_ATTRIB3_4_NV = $8663;  
  GL_MAP1_VERTEX_ATTRIB4_4_NV = $8664;  
  GL_MAP1_VERTEX_ATTRIB5_4_NV = $8665;  
  GL_MAP1_VERTEX_ATTRIB6_4_NV = $8666;  
  GL_MAP1_VERTEX_ATTRIB7_4_NV = $8667;  
  GL_MAP1_VERTEX_ATTRIB8_4_NV = $8668;  
  GL_MAP1_VERTEX_ATTRIB9_4_NV = $8669;  
  GL_MAP1_VERTEX_ATTRIB10_4_NV = $866A;  
  GL_MAP1_VERTEX_ATTRIB11_4_NV = $866B;  
  GL_MAP1_VERTEX_ATTRIB12_4_NV = $866C;  
  GL_MAP1_VERTEX_ATTRIB13_4_NV = $866D;  
  GL_MAP1_VERTEX_ATTRIB14_4_NV = $866E;  
  GL_MAP1_VERTEX_ATTRIB15_4_NV = $866F;  
  GL_MAP2_VERTEX_ATTRIB0_4_NV = $8670;  
  GL_MAP2_VERTEX_ATTRIB1_4_NV = $8671;  
  GL_MAP2_VERTEX_ATTRIB2_4_NV = $8672;  
  GL_MAP2_VERTEX_ATTRIB3_4_NV = $8673;  
  GL_MAP2_VERTEX_ATTRIB4_4_NV = $8674;  
  GL_MAP2_VERTEX_ATTRIB5_4_NV = $8675;  
  GL_MAP2_VERTEX_ATTRIB6_4_NV = $8676;  
  GL_MAP2_VERTEX_ATTRIB7_4_NV = $8677;  
  GL_MAP2_VERTEX_ATTRIB8_4_NV = $8678;  
  GL_MAP2_VERTEX_ATTRIB9_4_NV = $8679;  
  GL_MAP2_VERTEX_ATTRIB10_4_NV = $867A;  
  GL_MAP2_VERTEX_ATTRIB11_4_NV = $867B;  
  GL_MAP2_VERTEX_ATTRIB12_4_NV = $867C;  
  GL_MAP2_VERTEX_ATTRIB13_4_NV = $867D;  
  GL_MAP2_VERTEX_ATTRIB14_4_NV = $867E;  
  GL_MAP2_VERTEX_ATTRIB15_4_NV = $867F;  
type
  TPFNGLAREPROGRAMSRESIDENTNVPROC = function (n:TGLsizei; ids:PGLuint; residences:PGLboolean):TGLboolean;cdecl;
  TPFNGLBINDPROGRAMNVPROC = procedure (target:TGLenum; id:TGLuint);cdecl;
  TPFNGLDELETEPROGRAMSNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLEXECUTEPROGRAMNVPROC = procedure (target:TGLenum; id:TGLuint; params:PGLfloat);cdecl;
  TPFNGLGENPROGRAMSNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLGETPROGRAMPARAMETERDVNVPROC = procedure (target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETPROGRAMPARAMETERFVNVPROC = procedure (target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETPROGRAMSTRINGNVPROC = procedure (id:TGLuint; pname:TGLenum; prog:PGLubyte);cdecl;
  TPFNGLGETPROGRAMIVNVPROC = procedure (id:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTRACKMATRIXIVNVPROC = procedure (target:TGLenum; address:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVERTEXATTRIBPOINTERVNVPROC = procedure (index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;
  TPFNGLGETVERTEXATTRIBDVNVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETVERTEXATTRIBFVNVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVERTEXATTRIBIVNVPROC = procedure (index:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISPROGRAMNVPROC = function (id:TGLuint):TGLboolean;cdecl;
  TPFNGLLOADPROGRAMNVPROC = procedure (target:TGLenum; id:TGLuint; len:TGLsizei; prog:PGLubyte);cdecl;
  TPFNGLPROGRAMPARAMETER4DNVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble;               w:TGLdouble);cdecl;
  TPFNGLPROGRAMPARAMETER4DVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;
  TPFNGLPROGRAMPARAMETER4FNVPROC = procedure (target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat;                  w:TGLfloat);cdecl;
  TPFNGLPROGRAMPARAMETER4FVNVPROC = procedure (target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;
  TPFNGLPROGRAMPARAMETERS4DVNVPROC = procedure (target:TGLenum; index:TGLuint; num:TGLsizei; params:PGLdouble);cdecl;
  TPFNGLPROGRAMPARAMETERS4FVNVPROC = procedure (target:TGLenum; index:TGLuint; num:TGLsizei; params:PGLfloat);cdecl;
  TPFNGLREQUESTRESIDENTPROGRAMSNVPROC = procedure (n:TGLsizei; ids:PGLuint);cdecl;
  TPFNGLTRACKMATRIXNVPROC = procedure (target:TGLenum; address:TGLuint; matrix:TGLenum; transform:TGLenum);cdecl;
  TPFNGLVERTEXATTRIB1DNVPROC = procedure (index:TGLuint; x:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1DVNVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB1FNVPROC = procedure (index:TGLuint; x:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1FVNVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB1SNVPROC = procedure (index:TGLuint; x:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB1SVNVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB2DNVPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2DVNVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB2FNVPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2FVNVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB2SNVPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB2SVNVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB3DNVPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3DVNVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB3FNVPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3FVNVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB3SNVPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB3SVNVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4DNVPROC = procedure (index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4DVNVPROC = procedure (index:TGLuint; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIB4FNVPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4FVNVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIB4SNVPROC = procedure (index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;
  TPFNGLVERTEXATTRIB4SVNVPROC = procedure (index:TGLuint; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIB4UBNVPROC = procedure (index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;
  TPFNGLVERTEXATTRIB4UBVNVPROC = procedure (index:TGLuint; v:PGLubyte);cdecl;
  TPFNGLVERTEXATTRIBPOINTERNVPROC = procedure (index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLVERTEXATTRIBS1DVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBS1FVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIBS1SVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBS2DVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBS2FVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIBS2SVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBS3DVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBS3FVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIBS3SVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBS4DVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLdouble);cdecl;
  TPFNGLVERTEXATTRIBS4FVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVERTEXATTRIBS4SVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLshort);cdecl;
  TPFNGLVERTEXATTRIBS4UBVNVPROC = procedure (index:TGLuint; n:TGLsizei; v:PGLubyte);cdecl;


{ ------------------------ GL_NV_vertex_program1_1 ------------------------  }

const
  GL_NV_vertex_program1_1 = 1;  


{ ------------------------- GL_NV_vertex_program2 -------------------------  }

const
  GL_NV_vertex_program2 = 1;  


{ ---------------------- GL_NV_vertex_program2_option ---------------------  }

const
  GL_NV_vertex_program2_option = 1;  
//  GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = $88F4;   doppelt
//  GL_MAX_PROGRAM_CALL_DEPTH_NV = $88F5;  


{ ------------------------- GL_NV_vertex_program3 -------------------------  }

const
  GL_NV_vertex_program3 = 1;  
  MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;  


{ ------------------------- GL_NV_vertex_program4 -------------------------  }

const
  GL_NV_vertex_program4 = 1;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV = $88FD;  


{ -------------------------- GL_NV_video_capture --------------------------  }

const
  GL_NV_video_capture = 1;  
  GL_VIDEO_BUFFER_NV = $9020;  
  GL_VIDEO_BUFFER_BINDING_NV = $9021;  
  GL_FIELD_UPPER_NV = $9022;  
  GL_FIELD_LOWER_NV = $9023;  
  GL_NUM_VIDEO_CAPTURE_STREAMS_NV = $9024;  
  GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = $9025;  
  GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV = $9026;  
  GL_LAST_VIDEO_CAPTURE_STATUS_NV = $9027;  
  GL_VIDEO_BUFFER_PITCH_NV = $9028;  
  GL_VIDEO_COLOR_CONVERSION_MATRIX_NV = $9029;  
  GL_VIDEO_COLOR_CONVERSION_MAX_NV = $902A;  
  GL_VIDEO_COLOR_CONVERSION_MIN_NV = $902B;  
  GL_VIDEO_COLOR_CONVERSION_OFFSET_NV = $902C;  
  GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV = $902D;  
  GL_PARTIAL_SUCCESS_NV = $902E;  
  GL_SUCCESS_NV = $902F;  
  GL_FAILURE_NV = $9030;  
  GL_YCBYCR8_422_NV = $9031;  
  GL_YCBAYCR8A_4224_NV = $9032;  
  GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = $9033;  
  GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = $9034;  
  GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = $9035;  
  GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = $9036;  
  GL_Z4Y12Z4CB12Z4CR12_444_NV = $9037;  
  GL_VIDEO_CAPTURE_FRAME_WIDTH_NV = $9038;  
  GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV = $9039;  
  GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = $903A;  
  GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = $903B;  
  GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV = $903C;  
type
  TPFNGLBEGINVIDEOCAPTURENVPROC = procedure (video_capture_slot:TGLuint);cdecl;
  TPFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; frame_region:TGLenum; offset:TGLintptrARB);cdecl;
  TPFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; frame_region:TGLenum; target:TGLenum; texture:TGLuint);cdecl;
  TPFNGLENDVIDEOCAPTURENVPROC = procedure (video_capture_slot:TGLuint);cdecl;
  TPFNGLGETVIDEOCAPTURESTREAMDVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLGETVIDEOCAPTURESTREAMFVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETVIDEOCAPTURESTREAMIVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETVIDEOCAPTUREIVNVPROC = procedure (video_capture_slot:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLVIDEOCAPTURENVPROC = function (video_capture_slot:TGLuint; sequence_num:PGLuint; capture_time:PGLuint64EXT):TGLenum;cdecl;
  TPFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;
  TPFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC = procedure (video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLint);cdecl;


{ -------------------------- GL_NV_viewport_array -------------------------  }

const
  GL_NV_viewport_array = 1;  
  //GL_DEPTH_RANGE = $0B70;  doppelt
  //GL_VIEWPORT = $0BA2;  
  //GL_SCISSOR_BOX = $0C10;  
  //GL_SCISSOR_TEST = $0C11;  
  GL_MAX_VIEWPORTS_NV = $825B;  
  GL_VIEWPORT_SUBPIXEL_BITS_NV = $825C;  
  GL_VIEWPORT_BOUNDS_RANGE_NV = $825D;  
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX_NV = $825F;  
type
  TPFNGLDEPTHRANGEARRAYFVNVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLDEPTHRANGEINDEXEDFNVPROC = procedure (index:TGLuint; n:TGLfloat; f:TGLfloat);cdecl;
  TPFNGLDISABLEINVPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEINVPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLGETFLOATI_VNVPROC = procedure (target:TGLenum; index:TGLuint; data:PGLfloat);cdecl;
  TPFNGLISENABLEDINVPROC = function (target:TGLenum; index:TGLuint):TGLboolean;cdecl;
  TPFNGLSCISSORARRAYVNVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLint);cdecl;
  TPFNGLSCISSORINDEXEDNVPROC = procedure (index:TGLuint; left:TGLint; bottom:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLSCISSORINDEXEDVNVPROC = procedure (index:TGLuint; v:PGLint);cdecl;
  TPFNGLVIEWPORTARRAYVNVPROC = procedure (first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;
  TPFNGLVIEWPORTINDEXEDFNVPROC = procedure (index:TGLuint; x:TGLfloat; y:TGLfloat; w:TGLfloat; h:TGLfloat);cdecl;
  TPFNGLVIEWPORTINDEXEDFVNVPROC = procedure (index:TGLuint; v:PGLfloat);cdecl;


{ ------------------------- GL_NV_viewport_array2 -------------------------  }

const
  GL_NV_viewport_array2 = 1;  


{ ------------------------- GL_NV_viewport_swizzle ------------------------  }

const
  GL_NV_viewport_swizzle = 1;  
  GL_VIEWPORT_SWIZZLE_POSITIVE_X_NV = $9350;  
  GL_VIEWPORT_SWIZZLE_NEGATIVE_X_NV = $9351;  
  GL_VIEWPORT_SWIZZLE_POSITIVE_Y_NV = $9352;  
  GL_VIEWPORT_SWIZZLE_NEGATIVE_Y_NV = $9353;  
  GL_VIEWPORT_SWIZZLE_POSITIVE_Z_NV = $9354;  
  GL_VIEWPORT_SWIZZLE_NEGATIVE_Z_NV = $9355;  
  GL_VIEWPORT_SWIZZLE_POSITIVE_W_NV = $9356;  
  GL_VIEWPORT_SWIZZLE_NEGATIVE_W_NV = $9357;  
  GL_VIEWPORT_SWIZZLE_X_NV = $9358;  
  GL_VIEWPORT_SWIZZLE_Y_NV = $9359;  
  GL_VIEWPORT_SWIZZLE_Z_NV = $935A;  
  GL_VIEWPORT_SWIZZLE_W_NV = $935B;  
type
  TPFNGLVIEWPORTSWIZZLENVPROC = procedure (index:TGLuint; swizzlex:TGLenum; swizzley:TGLenum; swizzlez:TGLenum; swizzlew:TGLenum);cdecl;


{ ---------------------------- GL_OES_EGL_image ---------------------------  }

const
  GL_OES_EGL_image = 1;  
type
  TPFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC = procedure (target:TGLenum; image:TGLeglImageOES);cdecl;
  TPFNGLEGLIMAGETARGETTEXTURE2DOESPROC = procedure (target:TGLenum; image:TGLeglImageOES);cdecl;


{ ----------------------- GL_OES_EGL_image_external -----------------------  }

const
  GL_OES_EGL_image_external = 1;  
  //GL_TEXTURE_EXTERNAL_OES = $8D65;  doppelt
  //GL_SAMPLER_EXTERNAL_OES = $8D66;  
  //GL_TEXTURE_BINDING_EXTERNAL_OES = $8D67;  
  //GL_REQUIRED_TEXTURE_IMAGE_UNITS_OES = $8D68;  


{ -------------------- GL_OES_EGL_image_external_essl3 --------------------  }

const
  GL_OES_EGL_image_external_essl3 = 1;  


{ --------------------- GL_OES_blend_equation_separate --------------------  }

const
  GL_OES_blend_equation_separate = 1;  
  GL_BLEND_EQUATION_RGB_OES = $8009;  
  GL_BLEND_EQUATION_ALPHA_OES = $883D;  
type
  TPFNGLBLENDEQUATIONSEPARATEOESPROC = procedure (modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;


{ ----------------------- GL_OES_blend_func_separate ----------------------  }

const
  GL_OES_blend_func_separate = 1;  
  GL_BLEND_DST_RGB_OES = $80C8;  
  GL_BLEND_SRC_RGB_OES = $80C9;  
  GL_BLEND_DST_ALPHA_OES = $80CA;  
  GL_BLEND_SRC_ALPHA_OES = $80CB;  
type
  TPFNGLBLENDFUNCSEPARATEOESPROC = procedure (sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;


{ ------------------------- GL_OES_blend_subtract -------------------------  }

const
  GL_OES_blend_subtract = 1;  
  GL_FUNC_ADD_OES = $8006;  
  GL_BLEND_EQUATION_OES = $8009;  
  GL_FUNC_SUBTRACT_OES = $800A;  
  GL_FUNC_REVERSE_SUBTRACT_OES = $800B;  
type
  TPFNGLBLENDEQUATIONOESPROC = procedure (mode:TGLenum);cdecl;


{ ------------------------ GL_OES_byte_coordinates ------------------------  }

const
  GL_OES_byte_coordinates = 1;  


{ ------------------ GL_OES_compressed_ETC1_RGB8_texture ------------------  }

const
  GL_OES_compressed_ETC1_RGB8_texture = 1;  
  GL_ETC1_RGB8_OES = $8D64;  


{ ------------------- GL_OES_compressed_paletted_texture ------------------  }

const
  GL_OES_compressed_paletted_texture = 1;  
  GL_PALETTE4_RGB8_OES = $8B90;  
  GL_PALETTE4_RGBA8_OES = $8B91;  
  GL_PALETTE4_R5_G6_B5_OES = $8B92;  
  GL_PALETTE4_RGBA4_OES = $8B93;  
  GL_PALETTE4_RGB5_A1_OES = $8B94;  
  GL_PALETTE8_RGB8_OES = $8B95;  
  GL_PALETTE8_RGBA8_OES = $8B96;  
  GL_PALETTE8_R5_G6_B5_OES = $8B97;  
  GL_PALETTE8_RGBA4_OES = $8B98;  
  GL_PALETTE8_RGB5_A1_OES = $8B99;  


{ --------------------------- GL_OES_copy_image ---------------------------  }

const
  GL_OES_copy_image = 1;  
type
  TPFNGLCOPYIMAGESUBDATAOESPROC = procedure (srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint;
                srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
                dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;


{ ----------------------------- GL_OES_depth24 ----------------------------  }

const
  GL_OES_depth24 = 1;  
  GL_DEPTH_COMPONENT24_OES = $81A6;  


{ ----------------------------- GL_OES_depth32 ----------------------------  }

const
  GL_OES_depth32 = 1;  
  GL_DEPTH_COMPONENT32_OES = $81A7;  


{ -------------------------- GL_OES_depth_texture -------------------------  }

const
  GL_OES_depth_texture = 1;  
//  GL_UNSIGNED_SHORT = $1403;    doppelt
//  GL_UNSIGNED_INT = $1405;  
//  GL_DEPTH_COMPONENT = $1902;  


{ --------------------- GL_OES_depth_texture_cube_map ---------------------  }

const
  GL_OES_depth_texture_cube_map = 1;  
//  GL_UNSIGNED_SHORT = $1403;     doppelt
//  GL_UNSIGNED_INT = $1405;  
//  GL_DEPTH_COMPONENT = $1902;  
  GL_DEPTH_STENCIL_OES = $84F9;  
  GL_DEPTH24_STENCIL8_OES = $88F0;  


{ ---------------------- GL_OES_draw_buffers_indexed ----------------------  }

const
  GL_OES_draw_buffers_indexed = 1;  
type
  TPFNGLBLENDEQUATIONSEPARATEIOESPROC = procedure (buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;
  TPFNGLBLENDEQUATIONIOESPROC = procedure (buf:TGLuint; mode:TGLenum);cdecl;
  TPFNGLBLENDFUNCSEPARATEIOESPROC = procedure (buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;
  TPFNGLBLENDFUNCIOESPROC = procedure (buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;
  TPFNGLCOLORMASKIOESPROC = procedure (buf:TGLuint; r:TGLboolean; g:TGLboolean; b:TGLboolean; a:TGLboolean);cdecl;
  TPFNGLDISABLEIOESPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLENABLEIOESPROC = procedure (target:TGLenum; index:TGLuint);cdecl;
  TPFNGLISENABLEDIOESPROC = function (target:TGLenum; index:TGLuint):TGLboolean;cdecl;


{ -------------------------- GL_OES_draw_texture --------------------------  }

const
  GL_OES_draw_texture = 1;  
  GL_TEXTURE_CROP_RECT_OES = $8B9D;  


{ ----------------------- GL_OES_element_index_uint -----------------------  }

const
  GL_OES_element_index_uint = 1;  
//  GL_UNSIGNED_INT = $1405;     doppelt


{ --------------------- GL_OES_extended_matrix_palette --------------------  }

const
  GL_OES_extended_matrix_palette = 1;  


{ ------------------------ GL_OES_fbo_render_mipmap -----------------------  }

const
  GL_OES_fbo_render_mipmap = 1;  


{ --------------------- GL_OES_fragment_precision_high --------------------  }

const
  GL_OES_fragment_precision_high = 1;  


{ ----------------------- GL_OES_framebuffer_object -----------------------  }

const
  GL_OES_framebuffer_object = 1;  
  GL_NONE_OES = 0;  
  GL_INVALID_FRAMEBUFFER_OPERATION_OES = $0506;  
  GL_RGBA4_OES = $8056;  
  GL_RGB5_A1_OES = $8057;  
  GL_DEPTH_COMPONENT16_OES = $81A5;  
  GL_MAX_RENDERBUFFER_SIZE_OES = $84E8;  
  GL_FRAMEBUFFER_BINDING_OES = $8CA6;  
  GL_RENDERBUFFER_BINDING_OES = $8CA7;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_OES = $8CD0;  
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_OES = $8CD1;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_OES = $8CD2;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_OES = $8CD3;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_OES = $8CD4;  
  GL_FRAMEBUFFER_COMPLETE_OES = $8CD5;  
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_OES = $8CD6;  
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_OES = $8CD7;  
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_OES = $8CD9;  
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_OES = $8CDA;  
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_OES = $8CDB;  
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_OES = $8CDC;  
  GL_FRAMEBUFFER_UNSUPPORTED_OES = $8CDD;  
  GL_COLOR_ATTACHMENT0_OES = $8CE0;  
  GL_DEPTH_ATTACHMENT_OES = $8D00;  
  GL_STENCIL_ATTACHMENT_OES = $8D20;  
  GL_FRAMEBUFFER_OES = $8D40;  
  GL_RENDERBUFFER_OES = $8D41;  
  GL_RENDERBUFFER_WIDTH_OES = $8D42;  
  GL_RENDERBUFFER_HEIGHT_OES = $8D43;  
  GL_RENDERBUFFER_INTERNAL_FORMAT_OES = $8D44;  
  GL_STENCIL_INDEX1_OES = $8D46;  
  GL_STENCIL_INDEX4_OES = $8D47;  
  GL_STENCIL_INDEX8_OES = $8D48;  
  GL_RENDERBUFFER_RED_SIZE_OES = $8D50;  
  GL_RENDERBUFFER_GREEN_SIZE_OES = $8D51;  
  GL_RENDERBUFFER_BLUE_SIZE_OES = $8D52;  
  GL_RENDERBUFFER_ALPHA_SIZE_OES = $8D53;  
  GL_RENDERBUFFER_DEPTH_SIZE_OES = $8D54;  
  GL_RENDERBUFFER_STENCIL_SIZE_OES = $8D55;  
  GL_RGB565_OES = $8D62;  
type
  TPFNGLBINDFRAMEBUFFEROESPROC = procedure (target:TGLenum; framebuffer:TGLuint);cdecl;
  TPFNGLBINDRENDERBUFFEROESPROC = procedure (target:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLCHECKFRAMEBUFFERSTATUSOESPROC = function (target:TGLenum):TGLenum;cdecl;
  TPFNGLDELETEFRAMEBUFFERSOESPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLDELETERENDERBUFFERSOESPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLFRAMEBUFFERRENDERBUFFEROESPROC = procedure (target:TGLenum; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE2DOESPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;
  TPFNGLGENFRAMEBUFFERSOESPROC = procedure (n:TGLsizei; framebuffers:PGLuint);cdecl;
  TPFNGLGENRENDERBUFFERSOESPROC = procedure (n:TGLsizei; renderbuffers:PGLuint);cdecl;
  TPFNGLGENERATEMIPMAPOESPROC = procedure (target:TGLenum);cdecl;
  TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC = procedure (target:TGLenum; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETRENDERBUFFERPARAMETERIVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLISFRAMEBUFFEROESPROC = function (framebuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLISRENDERBUFFEROESPROC = function (renderbuffer:TGLuint):TGLboolean;cdecl;
  TPFNGLRENDERBUFFERSTORAGEOESPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;


{ ----------------------- GL_OES_geometry_point_size ----------------------  }

const
  GL_OES_geometry_point_size = 1;  
  GL_GEOMETRY_SHADER_BIT_OES = $00000004;  
  GL_LINES_ADJACENCY_OES = $A;  
  GL_LINE_STRIP_ADJACENCY_OES = $B;  
  GL_TRIANGLES_ADJACENCY_OES = $C;  
  GL_TRIANGLE_STRIP_ADJACENCY_OES = $D;  
  GL_LAYER_PROVOKING_VERTEX_OES = $825E;  
  GL_UNDEFINED_VERTEX_OES = $8260;  
  GL_GEOMETRY_SHADER_INVOCATIONS_OES = $887F;  
  GL_GEOMETRY_LINKED_VERTICES_OUT_OES = $8916;  
  GL_GEOMETRY_LINKED_INPUT_TYPE_OES = $8917;  
  GL_GEOMETRY_LINKED_OUTPUT_TYPE_OES = $8918;  
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS_OES = $8A2C;  
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_OES = $8A32;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_OES = $8C29;  
  GL_PRIMITIVES_GENERATED_OES = $8C87;  
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_OES = $8DA7;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_OES = $8DA8;  
  GL_GEOMETRY_SHADER_OES = $8DD9;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_OES = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_OES = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_OES = $8DE1;  
  GL_FIRST_VERTEX_CONVENTION_OES = $8E4D;  
  GL_LAST_VERTEX_CONVENTION_OES = $8E4E;  
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS_OES = $8E5A;  
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS_OES = $90CD;  
  GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_OES = $90D7;  
  GL_MAX_GEOMETRY_INPUT_COMPONENTS_OES = $9123;  
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_OES = $9124;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_OES = $92CF;  
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS_OES = $92D5;  
  GL_REFERENCED_BY_GEOMETRY_SHADER_OES = $9309;  
  GL_FRAMEBUFFER_DEFAULT_LAYERS_OES = $9312;  
  GL_MAX_FRAMEBUFFER_LAYERS_OES = $9317;  


{ ------------------------- GL_OES_geometry_shader ------------------------  }

const
  GL_OES_geometry_shader = 1;  
  //GL_GEOMETRY_SHADER_BIT_OES = $00000004;     doppelt
  //GL_LINES_ADJACENCY_OES = $A;  
  //GL_LINE_STRIP_ADJACENCY_OES = $B;  
  //GL_TRIANGLES_ADJACENCY_OES = $C;  
  //GL_TRIANGLE_STRIP_ADJACENCY_OES = $D;  
  //GL_LAYER_PROVOKING_VERTEX_OES = $825E;  
  //GL_UNDEFINED_VERTEX_OES = $8260;  
  //GL_GEOMETRY_SHADER_INVOCATIONS_OES = $887F;  
  //GL_GEOMETRY_LINKED_VERTICES_OUT_OES = $8916;  
  //GL_GEOMETRY_LINKED_INPUT_TYPE_OES = $8917;  
  //GL_GEOMETRY_LINKED_OUTPUT_TYPE_OES = $8918;  
  //GL_MAX_GEOMETRY_UNIFORM_BLOCKS_OES = $8A2C;  
  //GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_OES = $8A32;  
  //GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_OES = $8C29;  
  //GL_PRIMITIVES_GENERATED_OES = $8C87;  
  //GL_FRAMEBUFFER_ATTACHMENT_LAYERED_OES = $8DA7;  
  //GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_OES = $8DA8;  
  //GL_GEOMETRY_SHADER_OES = $8DD9;  
  //GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_OES = $8DDF;  
  //GL_MAX_GEOMETRY_OUTPUT_VERTICES_OES = $8DE0;  
  //GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_OES = $8DE1;  
  //GL_FIRST_VERTEX_CONVENTION_OES = $8E4D;  
  //GL_LAST_VERTEX_CONVENTION_OES = $8E4E;  
  //GL_MAX_GEOMETRY_SHADER_INVOCATIONS_OES = $8E5A;  
  //GL_MAX_GEOMETRY_IMAGE_UNIFORMS_OES = $90CD;  
  //GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_OES = $90D7;  
  //GL_MAX_GEOMETRY_INPUT_COMPONENTS_OES = $9123;  
  //GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_OES = $9124;  
  //GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_OES = $92CF;  
  //GL_MAX_GEOMETRY_ATOMIC_COUNTERS_OES = $92D5;  
  //GL_REFERENCED_BY_GEOMETRY_SHADER_OES = $9309;  
  //GL_FRAMEBUFFER_DEFAULT_LAYERS_OES = $9312;  
  //GL_MAX_FRAMEBUFFER_LAYERS_OES = $9317;  


{ ----------------------- GL_OES_get_program_binary -----------------------  }

const
  GL_OES_get_program_binary = 1;  
  GL_PROGRAM_BINARY_LENGTH_OES = $8741;  
  GL_NUM_PROGRAM_BINARY_FORMATS_OES = $87FE;  
  GL_PROGRAM_BINARY_FORMATS_OES = $87FF;  
type
  TPFNGLGETPROGRAMBINARYOESPROC = procedure (prog:TGLuint; bufSize:TGLsizei; length:PGLsizei; binaryFormat:PGLenum; binary:pointer);cdecl;
  TPFNGLPROGRAMBINARYOESPROC = procedure (prog:TGLuint; binaryFormat:TGLenum; binary:pointer; length:TGLint);cdecl;


{ --------------------------- GL_OES_gpu_shader5 --------------------------  }

const
  GL_OES_gpu_shader5 = 1;  


{ ---------------------------- GL_OES_mapbuffer ---------------------------  }

const
  GL_OES_mapbuffer = 1;  
  GL_WRITE_ONLY_OES = $88B9;  
  GL_BUFFER_ACCESS_OES = $88BB;  
  GL_BUFFER_MAPPED_OES = $88BC;  
  GL_BUFFER_MAP_POINTER_OES = $88BD;  
type
  TPFNGLGETBUFFERPOINTERVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;
  TPFNGLMAPBUFFEROESPROC = function (target:TGLenum; access:TGLenum):pointer;cdecl;
  TPFNGLUNMAPBUFFEROESPROC = function (target:TGLenum):TGLboolean;cdecl;


{ --------------------------- GL_OES_matrix_get ---------------------------  }

const
  GL_OES_matrix_get = 1;  
  GL_MODELVIEW_MATRIX_FLOAT_AS_INT_BITS_OES = $898d;  
  GL_PROJECTION_MATRIX_FLOAT_AS_INT_BITS_OES = $898e;  
  GL_TEXTURE_MATRIX_FLOAT_AS_INT_BITS_OES = $898f;  


{ ------------------------- GL_OES_matrix_palette -------------------------  }

const
  GL_OES_matrix_palette = 1;  
  GL_MAX_VERTEX_UNITS_OES = $86A4;  
  GL_WEIGHT_ARRAY_TYPE_OES = $86A9;  
  GL_WEIGHT_ARRAY_STRIDE_OES = $86AA;  
  GL_WEIGHT_ARRAY_SIZE_OES = $86AB;  
  GL_WEIGHT_ARRAY_POINTER_OES = $86AC;  
  GL_WEIGHT_ARRAY_OES = $86AD;  
  GL_MATRIX_PALETTE_OES = $8840;  
  GL_MAX_PALETTE_MATRICES_OES = $8842;  
  GL_CURRENT_PALETTE_MATRIX_OES = $8843;  
  GL_MATRIX_INDEX_ARRAY_OES = $8844;  
  GL_MATRIX_INDEX_ARRAY_SIZE_OES = $8846;  
  GL_MATRIX_INDEX_ARRAY_TYPE_OES = $8847;  
  GL_MATRIX_INDEX_ARRAY_STRIDE_OES = $8848;  
  GL_MATRIX_INDEX_ARRAY_POINTER_OES = $8849;  
  GL_WEIGHT_ARRAY_BUFFER_BINDING_OES = $889E;  
  GL_MATRIX_INDEX_ARRAY_BUFFER_BINDING_OES = $8B9E;  
type
  TPFNGLCURRENTPALETTEMATRIXOESPROC = procedure (index:TGLuint);cdecl;
  TPFNGLMATRIXINDEXPOINTEROESPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLWEIGHTPOINTEROESPROC = procedure (size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;


{ ---------------------- GL_OES_packed_depth_stencil ----------------------  }

const
  GL_OES_packed_depth_stencil = 1;  
//  GL_DEPTH_STENCIL_OES = $84F9;     doppelt
  GL_UNSIGNED_INT_24_8_OES = $84FA;  
//  GL_DEPTH24_STENCIL8_OES = $88F0;  


{ ------------------------ GL_OES_point_size_array ------------------------  }

const
  GL_OES_point_size_array = 1;  
  GL_POINT_SIZE_ARRAY_TYPE_OES = $898A;  
  GL_POINT_SIZE_ARRAY_STRIDE_OES = $898B;  
  GL_POINT_SIZE_ARRAY_POINTER_OES = $898C;  
  GL_POINT_SIZE_ARRAY_OES = $8B9C;  
  GL_POINT_SIZE_ARRAY_BUFFER_BINDING_OES = $8B9F;  


{ -------------------------- GL_OES_point_sprite --------------------------  }

const
  GL_OES_point_sprite = 1;  
  GL_POINT_SPRITE_OES = $8861;  
  GL_COORD_REPLACE_OES = $8862;  


{ --------------------------- GL_OES_read_format --------------------------  }

const
  GL_OES_read_format = 1;  
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = $8B9A;  
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = $8B9B;  


{ --------------------- GL_OES_required_internalformat --------------------  }

const
  GL_OES_required_internalformat = 1;  
  GL_ALPHA8_OES = $803C;  
  GL_LUMINANCE8_OES = $8040;  
  GL_LUMINANCE4_ALPHA4_OES = $8043;  
  GL_LUMINANCE8_ALPHA8_OES = $8045;  
  GL_RGB8_OES = $8051;  
  //GL_RGB10_EXT = $8052;     doppelt
  //GL_RGBA4_OES = $8056;  
  //GL_RGB5_A1_OES = $8057;  
  //GL_RGBA8_OES = $8058;  
  //GL_RGB10_A2_EXT = $8059;  
  //GL_DEPTH_COMPONENT16_OES = $81A5;  
  //GL_DEPTH_COMPONENT24_OES = $81A6;  
  //GL_DEPTH_COMPONENT32_OES = $81A7;  
  //GL_DEPTH24_STENCIL8_OES = $88F0;  
  //GL_RGB565_OES = $8D62;  


{ --------------------------- GL_OES_rgb8_rgba8 ---------------------------  }

const
  GL_OES_rgb8_rgba8 = 1;  
//  GL_RGB8_OES = $8051;     doppelt
//  GL_RGBA8_OES = $8058;  


{ ------------------------- GL_OES_sample_shading -------------------------  }

const
  GL_OES_sample_shading = 1;  
  GL_SAMPLE_SHADING_OES = $8C36;  
  GL_MIN_SAMPLE_SHADING_VALUE_OES = $8C37;  
type
 TPFNGLMINSAMPLESHADINGOESPROC = procedure (value:TGLfloat);cdecl;


{ ------------------------ GL_OES_sample_variables ------------------------  }

const
  GL_OES_sample_variables = 1;  


{ ----------------------- GL_OES_shader_image_atomic ----------------------  }

const
  GL_OES_shader_image_atomic = 1;  


{ ------------------------ GL_OES_shader_io_blocks ------------------------  }

const
  GL_OES_shader_io_blocks = 1;  


{ ---------------- GL_OES_shader_multisample_interpolation ----------------  }

const
  GL_OES_shader_multisample_interpolation = 1;  
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_OES = $8E5B;  
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_OES = $8E5C;  
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS_OES = $8E5D;  


{ ------------------------ GL_OES_single_precision ------------------------  }

const
  GL_OES_single_precision = 1;  
type
  TPFNGLCLEARDEPTHFOESPROC = procedure (depth:TGLclampf);cdecl;
  TPFNGLCLIPPLANEFOESPROC = procedure (plane:TGLenum; equation:PGLfloat);cdecl;
  TPFNGLDEPTHRANGEFOESPROC = procedure (n:TGLclampf; f:TGLclampf);cdecl;
  TPFNGLFRUSTUMFOESPROC = procedure (l:TGLfloat; r:TGLfloat; b:TGLfloat; t:TGLfloat; n:TGLfloat;                f:TGLfloat);cdecl;
  TPFNGLGETCLIPPLANEFOESPROC = procedure (plane:TGLenum; equation:PGLfloat);cdecl;
  TPFNGLORTHOFOESPROC = procedure (l:TGLfloat; r:TGLfloat; b:TGLfloat; t:TGLfloat; n:TGLfloat;                f:TGLfloat);cdecl;


{ ---------------------- GL_OES_standard_derivatives ----------------------  }

const
  GL_OES_standard_derivatives = 1;  
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_OES = $8B8B;  


{ ---------------------------- GL_OES_stencil1 ----------------------------  }

const
  GL_OES_stencil1 = 1;  
//  GL_STENCIL_INDEX1_OES = $8D46;     doppelt


{ ---------------------------- GL_OES_stencil4 ----------------------------  }

const
  GL_OES_stencil4 = 1;  
//  GL_STENCIL_INDEX4_OES = $8D47;     doppelt


{ ---------------------------- GL_OES_stencil8 ----------------------------  }

const
  GL_OES_stencil8 = 1;  
//  GL_STENCIL_INDEX8_OES = $8D48;     doppelt


{ ----------------------- GL_OES_surfaceless_context ----------------------  }

const
  GL_OES_surfaceless_context = 1;  
  GL_FRAMEBUFFER_UNDEFINED_OES = $8219;  


{ --------------------- GL_OES_tessellation_point_size --------------------  }

const
  GL_OES_tessellation_point_size = 1;  
  GL_QUADS_OES = $0007;  
  GL_TESS_CONTROL_SHADER_BIT_OES = $00000008;  
  GL_PATCHES_OES = $E;  
  GL_TESS_EVALUATION_SHADER_BIT_OES = $00000010;  
  GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED_OES = $8221;  
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_OES = $886C;  
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_OES = $886D;  
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS_OES = $8E1E;  
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS_OES = $8E1F;  
  GL_PATCH_VERTICES_OES = $8E72;  
  GL_TESS_CONTROL_OUTPUT_VERTICES_OES = $8E75;  
  GL_TESS_GEN_MODE_OES = $8E76;  
  GL_TESS_GEN_SPACING_OES = $8E77;  
  GL_TESS_GEN_VERTEX_ORDER_OES = $8E78;  
  GL_TESS_GEN_POINT_MODE_OES = $8E79;  
  GL_ISOLINES_OES = $8E7A;  
  GL_FRACTIONAL_ODD_OES = $8E7B;  
  GL_FRACTIONAL_EVEN_OES = $8E7C;  
  GL_MAX_PATCH_VERTICES_OES = $8E7D;  
  GL_MAX_TESS_GEN_LEVEL_OES = $8E7E;  
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS_OES = $8E7F;  
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS_OES = $8E80;  
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS_OES = $8E81;  
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS_OES = $8E82;  
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_OES = $8E83;  
  GL_MAX_TESS_PATCH_COMPONENTS_OES = $8E84;  
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS_OES = $8E85;  
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_OES = $8E86;  
  GL_TESS_EVALUATION_SHADER_OES = $8E87;  
  GL_TESS_CONTROL_SHADER_OES = $8E88;  
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS_OES = $8E89;  
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS_OES = $8E8A;  
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS_OES = $90CB;  
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS_OES = $90CC;  
  GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS_OES = $90D8;  
  GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS_OES = $90D9;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS_OES = $92CD;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS_OES = $92CE;  
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS_OES = $92D3;  
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS_OES = $92D4;  
  GL_IS_PER_PATCH_OES = $92E7;  
  GL_REFERENCED_BY_TESS_CONTROL_SHADER_OES = $9307;  
  GL_REFERENCED_BY_TESS_EVALUATION_SHADER_OES = $9308;  


{ ----------------------- GL_OES_tessellation_shader ----------------------  }

const
  GL_OES_tessellation_shader = 1;  
  //GL_QUADS_OES = $0007;     doppelt
  //GL_TESS_CONTROL_SHADER_BIT_OES = $00000008;  
  //GL_PATCHES_OES = $E;  
  //GL_TESS_EVALUATION_SHADER_BIT_OES = $00000010;  
  //GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED_OES = $8221;  
  //GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_OES = $886C;  
  //GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_OES = $886D;  
  //GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS_OES = $8E1E;  
  //GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS_OES = $8E1F;  
  //GL_PATCH_VERTICES_OES = $8E72;  
  //GL_TESS_CONTROL_OUTPUT_VERTICES_OES = $8E75;  
  //GL_TESS_GEN_MODE_OES = $8E76;  
  //GL_TESS_GEN_SPACING_OES = $8E77;  
  //GL_TESS_GEN_VERTEX_ORDER_OES = $8E78;  
  //GL_TESS_GEN_POINT_MODE_OES = $8E79;  
  //GL_ISOLINES_OES = $8E7A;  
  //GL_FRACTIONAL_ODD_OES = $8E7B;  
  //GL_FRACTIONAL_EVEN_OES = $8E7C;  
  //GL_MAX_PATCH_VERTICES_OES = $8E7D;  
  //GL_MAX_TESS_GEN_LEVEL_OES = $8E7E;  
  //GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS_OES = $8E7F;  
  //GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS_OES = $8E80;  
  //GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS_OES = $8E81;  
  //GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS_OES = $8E82;  
  //GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_OES = $8E83;  
  //GL_MAX_TESS_PATCH_COMPONENTS_OES = $8E84;  
  //GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS_OES = $8E85;  
  //GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_OES = $8E86;  
  //GL_TESS_EVALUATION_SHADER_OES = $8E87;  
  //GL_TESS_CONTROL_SHADER_OES = $8E88;  
  //GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS_OES = $8E89;  
  //GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS_OES = $8E8A;  
  //GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS_OES = $90CB;  
  //GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS_OES = $90CC;  
  //GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS_OES = $90D8;  
  //GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS_OES = $90D9;  
  //GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS_OES = $92CD;  
  //GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS_OES = $92CE;  
  //GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS_OES = $92D3;  
  //GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS_OES = $92D4;  
  //GL_IS_PER_PATCH_OES = $92E7;  
  //GL_REFERENCED_BY_TESS_CONTROL_SHADER_OES = $9307;  
  //GL_REFERENCED_BY_TESS_EVALUATION_SHADER_OES = $9308;  


{ --------------------------- GL_OES_texture_3D ---------------------------  }

const
  GL_OES_texture_3D = 1;  
  GL_TEXTURE_BINDING_3D_OES = $806A;  
  GL_TEXTURE_3D_OES = $806F;  
  GL_TEXTURE_WRAP_R_OES = $8072;  
  GL_MAX_3D_TEXTURE_SIZE_OES = $8073;  
type
  TPFNGLCOMPRESSEDTEXIMAGE3DOESPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;
  TPFNGLCOMPRESSEDTEXSUBIMAGE3DOESPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
                data:pointer);cdecl;
  TPFNGLCOPYTEXSUBIMAGE3DOESPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;
  TPFNGLFRAMEBUFFERTEXTURE3DOESPROC = procedure (target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint;
                zoffset:TGLint);cdecl;
  TPFNGLTEXIMAGE3DOESPROC = procedure (target:TGLenum; level:TGLint; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE3DOESPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;


{ ---------------------- GL_OES_texture_border_clamp ----------------------  }

const
  GL_OES_texture_border_clamp = 1;  
  GL_TEXTURE_BORDER_COLOR_OES = $1004;  
  GL_CLAMP_TO_BORDER_OES = $812D;  
type
  TPFNGLGETSAMPLERPARAMETERIIVOESPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETSAMPLERPARAMETERIUIVOESPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLGETTEXPARAMETERIIVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXPARAMETERIUIVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLSAMPLERPARAMETERIIVOESPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLSAMPLERPARAMETERIUIVOESPROC = procedure (sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;
  TPFNGLTEXPARAMETERIIVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXPARAMETERIUIVOESPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;


{ ------------------------- GL_OES_texture_buffer -------------------------  }

const
  GL_OES_texture_buffer = 1;  
  GL_TEXTURE_BUFFER_BINDING_OES = $8C2A;  
  GL_TEXTURE_BUFFER_OES = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE_OES = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER_OES = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_OES = $8C2D;  
  GL_SAMPLER_BUFFER_OES = $8DC2;  
  GL_INT_SAMPLER_BUFFER_OES = $8DD0;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER_OES = $8DD8;  
  GL_IMAGE_BUFFER_OES = $9051;  
  GL_INT_IMAGE_BUFFER_OES = $905C;  
  GL_UNSIGNED_INT_IMAGE_BUFFER_OES = $9067;  
  GL_TEXTURE_BUFFER_OFFSET_OES = $919D;  
  GL_TEXTURE_BUFFER_SIZE_OES = $919E;  
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT_OES = $919F;  
type
  TPFNGLTEXBUFFEROESPROC = procedure (target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;
  TPFNGLTEXBUFFERRANGEOESPROC = procedure (target:TGLenum; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;


{ -------------------- GL_OES_texture_compression_astc --------------------  }

const
  GL_OES_texture_compression_astc = 1;  
  //GL_COMPRESSED_RGBA_ASTC_4x4_KHR = $93B0;     doppelt
  //GL_COMPRESSED_RGBA_ASTC_5x4_KHR = $93B1;  
  //GL_COMPRESSED_RGBA_ASTC_5x5_KHR = $93B2;  
  //GL_COMPRESSED_RGBA_ASTC_6x5_KHR = $93B3;  
  //GL_COMPRESSED_RGBA_ASTC_6x6_KHR = $93B4;  
  //GL_COMPRESSED_RGBA_ASTC_8x5_KHR = $93B5;  
  //GL_COMPRESSED_RGBA_ASTC_8x6_KHR = $93B6;  
  //GL_COMPRESSED_RGBA_ASTC_8x8_KHR = $93B7;  
  //GL_COMPRESSED_RGBA_ASTC_10x5_KHR = $93B8;  
  //GL_COMPRESSED_RGBA_ASTC_10x6_KHR = $93B9;  
  //GL_COMPRESSED_RGBA_ASTC_10x8_KHR = $93BA;  
  //GL_COMPRESSED_RGBA_ASTC_10x10_KHR = $93BB;  
  //GL_COMPRESSED_RGBA_ASTC_12x10_KHR = $93BC;  
  //GL_COMPRESSED_RGBA_ASTC_12x12_KHR = $93BD;  
  //GL_COMPRESSED_RGBA_ASTC_3x3x3_OES = $93C0;  
  //GL_COMPRESSED_RGBA_ASTC_4x3x3_OES = $93C1;  
  //GL_COMPRESSED_RGBA_ASTC_4x4x3_OES = $93C2;  
  //GL_COMPRESSED_RGBA_ASTC_4x4x4_OES = $93C3;  
  //GL_COMPRESSED_RGBA_ASTC_5x4x4_OES = $93C4;  
  //GL_COMPRESSED_RGBA_ASTC_5x5x4_OES = $93C5;  
  //GL_COMPRESSED_RGBA_ASTC_5x5x5_OES = $93C6;  
  //GL_COMPRESSED_RGBA_ASTC_6x5x5_OES = $93C7;  
  //GL_COMPRESSED_RGBA_ASTC_6x6x5_OES = $93C8;  
  //GL_COMPRESSED_RGBA_ASTC_6x6x6_OES = $93C9;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = $93D0;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = $93D1;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = $93D2;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = $93D3;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = $93D4;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = $93D5;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = $93D6;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = $93D7;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = $93D8;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = $93D9;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = $93DA;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = $93DB;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = $93DC;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = $93DD;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_3x3x3_OES = $93E0;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x3x3_OES = $93E1;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x3_OES = $93E2;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4x4_OES = $93E3;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4x4_OES = $93E4;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x4_OES = $93E5;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5x5_OES = $93E6;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5x5_OES = $93E7;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x5_OES = $93E8;  
  //GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6x6_OES = $93E9;  


{ ------------------------ GL_OES_texture_cube_map ------------------------  }

const
  GL_OES_texture_cube_map = 1;  
  GL_TEXTURE_GEN_MODE_OES = $2500;  
  GL_NORMAL_MAP_OES = $8511;  
  GL_REFLECTION_MAP_OES = $8512;  
  GL_TEXTURE_CUBE_MAP_OES = $8513;  
  GL_TEXTURE_BINDING_CUBE_MAP_OES = $8514;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_OES = $8515;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_OES = $8516;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_OES = $8517;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_OES = $8518;  
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_OES = $8519;  
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_OES = $851A;  
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_OES = $851C;  
  GL_TEXTURE_GEN_STR_OES = $8D60;  
type
  TPFNGLGETTEXGENFVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETTEXGENIVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETTEXGENXVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLTEXGENFOESPROC = procedure (coord:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLTEXGENFVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLTEXGENIOESPROC = procedure (coord:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLTEXGENIVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLTEXGENXOESPROC = procedure (coord:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLTEXGENXVOESPROC = procedure (coord:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;


{ --------------------- GL_OES_texture_cube_map_array ---------------------  }

const
  GL_OES_texture_cube_map_array = 1;  
//  GL_TEXTURE_CUBE_MAP_ARRAY_OES = $9009;     doppelt
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_OES = $900A;  
  GL_SAMPLER_CUBE_MAP_ARRAY_OES = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_OES = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_OES = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_OES = $900F;  
  GL_IMAGE_CUBE_MAP_ARRAY_OES = $9054;  
  GL_INT_IMAGE_CUBE_MAP_ARRAY_OES = $905F;  
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_OES = $906A;  


{ ---------------------- GL_OES_texture_env_crossbar ----------------------  }

const
  GL_OES_texture_env_crossbar = 1;  


{ --------------------- GL_OES_texture_mirrored_repeat --------------------  }

const
  GL_OES_texture_mirrored_repeat = 1;  
//  GL_MIRRORED_REPEAT = $8370;     doppelt


{ -------------------------- GL_OES_texture_npot --------------------------  }

const
  GL_OES_texture_npot = 1;  


{ ------------------------ GL_OES_texture_stencil8 ------------------------  }

const
  GL_OES_texture_stencil8 = 1;  
//  GL_STENCIL_INDEX = $1901;     doppelt
//  GL_STENCIL_INDEX8 = $8D48;  


{ -------------- GL_OES_texture_storage_multisample_2d_array --------------  }

const
  GL_OES_texture_storage_multisample_2d_array = 1;  
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY_OES = $9102;  
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY_OES = $9105;  
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY_OES = $910B;  
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY_OES = $910C;  
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY_OES = $910D;  
type
  TPFNGLTEXSTORAGE3DMULTISAMPLEOESPROC = procedure (target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;


{ -------------------------- GL_OES_texture_view --------------------------  }

const
  GL_OES_texture_view = 1;  
  GL_TEXTURE_VIEW_MIN_LEVEL_OES = $82DB;  
  GL_TEXTURE_VIEW_NUM_LEVELS_OES = $82DC;  
  GL_TEXTURE_VIEW_MIN_LAYER_OES = $82DD;  
  GL_TEXTURE_VIEW_NUM_LAYERS_OES = $82DE;  
//  GL_TEXTURE_IMMUTABLE_LEVELS = $82DF;     doppelt
type
  TPFNGLTEXTUREVIEWOESPROC = procedure (texture:TGLuint; target:TGLenum; origtexture:TGLuint; internalformat:TGLenum; minlevel:TGLuint;
                numlevels:TGLuint; minlayer:TGLuint; numlayers:TGLuint);cdecl;


{ ----------------------- GL_OES_vertex_array_object ----------------------  }

const
  GL_OES_vertex_array_object = 1;  
  GL_VERTEX_ARRAY_BINDING_OES = $85B5;  
type
  TPFNGLBINDVERTEXARRAYOESPROC = procedure (arr:TGLuint);cdecl;
  TPFNGLDELETEVERTEXARRAYSOESPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLGENVERTEXARRAYSOESPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLISVERTEXARRAYOESPROC = function (arr:TGLuint):TGLboolean;cdecl;


{ ------------------------ GL_OES_vertex_half_float -----------------------  }

const
  GL_OES_vertex_half_float = 1;  
  GL_HALF_FLOAT_OES = $8D61;  


{ --------------------- GL_OES_vertex_type_10_10_10_2 ---------------------  }

const
  GL_OES_vertex_type_10_10_10_2 = 1;  
  GL_UNSIGNED_INT_10_10_10_2_OES = $8DF6;  
  GL_INT_10_10_10_2_OES = $8DF7;  


{ ---------------------------- GL_OML_interlace ---------------------------  }

const
  GL_OML_interlace = 1;  
  GL_INTERLACE_OML = $8980;  
  GL_INTERLACE_READ_OML = $8981;  


{ ---------------------------- GL_OML_resample ----------------------------  }

const
  GL_OML_resample = 1;  
  GL_PACK_RESAMPLE_OML = $8984;  
  GL_UNPACK_RESAMPLE_OML = $8985;  
  GL_RESAMPLE_REPLICATE_OML = $8986;  
  GL_RESAMPLE_ZERO_FILL_OML = $8987;  
  GL_RESAMPLE_AVERAGE_OML = $8988;  
  GL_RESAMPLE_DECIMATE_OML = $8989;  


{ ---------------------------- GL_OML_subsample ---------------------------  }

const
  GL_OML_subsample = 1;  
  GL_FORMAT_SUBSAMPLE_24_24_OML = $8982;  
  GL_FORMAT_SUBSAMPLE_244_244_OML = $8983;  


{ ---------------------------- GL_OVR_multiview ---------------------------  }

const
  GL_OVR_multiview = 1;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = $9630;  
  GL_MAX_VIEWS_OVR = $9631;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = $9632;  
  GL_FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = $9633;  
type
  TPFNGLFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; baseViewIndex:TGLint;                numViews:TGLsizei);cdecl;
  TPFNGLNAMEDFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC = procedure (framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; baseViewIndex:TGLint;                numViews:TGLsizei);cdecl;


{ --------------------------- GL_OVR_multiview2 ---------------------------  }

const
  GL_OVR_multiview2 = 1;  


{ ------------ GL_OVR_multiview_multisampled_render_to_texture ------------  }

const
  GL_OVR_multiview_multisampled_render_to_texture = 1;  
type
  TPFNGLFRAMEBUFFERTEXTUREMULTISAMPLEMULTIVIEWOVRPROC = procedure (target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; samples:TGLsizei;                baseViewIndex:TGLint; numViews:TGLsizei);cdecl;


{ --------------------------- GL_PGI_misc_hints ---------------------------  }

const
  GL_PGI_misc_hints = 1;  
  GL_PREFER_DOUBLEBUFFER_HINT_PGI = 107000;  
  GL_CONSERVE_MEMORY_HINT_PGI = 107005;  
  GL_RECLAIM_MEMORY_HINT_PGI = 107006;  
  GL_NATIVE_GRAPHICS_HANDLE_PGI = 107010;  
  GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = 107011;  
  GL_NATIVE_GRAPHICS_END_HINT_PGI = 107012;  
  GL_ALWAYS_FAST_HINT_PGI = 107020;  
  GL_ALWAYS_SOFT_HINT_PGI = 107021;  
  GL_ALLOW_DRAW_OBJ_HINT_PGI = 107022;  
  GL_ALLOW_DRAW_WIN_HINT_PGI = 107023;  
  GL_ALLOW_DRAW_FRG_HINT_PGI = 107024;  
  GL_ALLOW_DRAW_MEM_HINT_PGI = 107025;  
  GL_STRICT_DEPTHFUNC_HINT_PGI = 107030;  
  GL_STRICT_LIGHTING_HINT_PGI = 107031;  
  GL_STRICT_SCISSOR_HINT_PGI = 107032;  
  GL_FULL_STIPPLE_HINT_PGI = 107033;  
  GL_CLIP_NEAR_HINT_PGI = 107040;  
  GL_CLIP_FAR_HINT_PGI = 107041;  
  GL_WIDE_LINE_HINT_PGI = 107042;  
  GL_BACK_NORMALS_HINT_PGI = 107043;  


{ -------------------------- GL_PGI_vertex_hints --------------------------  }

const
  GL_PGI_vertex_hints = 1;  
  GL_VERTEX23_BIT_PGI = $00000004;  
  GL_VERTEX4_BIT_PGI = $00000008;  
  GL_COLOR3_BIT_PGI = $00010000;  
  GL_COLOR4_BIT_PGI = $00020000;  
  GL_EDGEFLAG_BIT_PGI = $00040000;  
  GL_INDEX_BIT_PGI = $00080000;  
  GL_MAT_AMBIENT_BIT_PGI = $00100000;  
  GL_VERTEX_DATA_HINT_PGI = 107050;  
  GL_VERTEX_CONSISTENT_HINT_PGI = 107051;  
  GL_MATERIAL_SIDE_HINT_PGI = 107052;  
  GL_MAX_VERTEX_HINT_PGI = 107053;  
  GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = $00200000;  
  GL_MAT_DIFFUSE_BIT_PGI = $00400000;  
  GL_MAT_EMISSION_BIT_PGI = $00800000;  
  GL_MAT_COLOR_INDEXES_BIT_PGI = $01000000;  
  GL_MAT_SHININESS_BIT_PGI = $02000000;  
  GL_MAT_SPECULAR_BIT_PGI = $04000000;  
  GL_NORMAL_BIT_PGI = $08000000;  
  GL_TEXCOORD1_BIT_PGI = $10000000;  
  GL_TEXCOORD2_BIT_PGI = $20000000;  
  GL_TEXCOORD3_BIT_PGI = $40000000;  
  GL_TEXCOORD4_BIT_PGI = $80000000;  


{ ----------------------- GL_QCOM_YUV_texture_gather ----------------------  }

const
  GL_QCOM_YUV_texture_gather = 1;  


{ --------------------------- GL_QCOM_alpha_test --------------------------  }

const
  GL_QCOM_alpha_test = 1;  
  GL_ALPHA_TEST_QCOM = $0BC0;  
  GL_ALPHA_TEST_FUNC_QCOM = $0BC1;  
  GL_ALPHA_TEST_REF_QCOM = $0BC2;  
type
  TPFNGLALPHAFUNCQCOMPROC = procedure (func:TGLenum; ref:TGLclampf);cdecl;


{ ------------------------ GL_QCOM_binning_control ------------------------  }

const
  GL_QCOM_binning_control = 1;  
//  GL_DONT_CARE = $1100;     doppelt
  GL_BINNING_CONTROL_HINT_QCOM = $8FB0;  
  GL_CPU_OPTIMIZED_QCOM = $8FB1;  
  GL_GPU_OPTIMIZED_QCOM = $8FB2;  
  GL_RENDER_DIRECT_TO_FRAMEBUFFER_QCOM = $8FB3;  


{ ------------------------- GL_QCOM_driver_control ------------------------  }

const
  GL_QCOM_driver_control = 1;  
type
  TPFNGLDISABLEDRIVERCONTROLQCOMPROC = procedure (driverControl:TGLuint);cdecl;
  TPFNGLENABLEDRIVERCONTROLQCOMPROC = procedure (driverControl:TGLuint);cdecl;
  TPFNGLGETDRIVERCONTROLSTRINGQCOMPROC = procedure (driverControl:TGLuint; bufSize:TGLsizei; length:PGLsizei; driverControlString:PGLchar);cdecl;
  TPFNGLGETDRIVERCONTROLSQCOMPROC = procedure (num:PGLint; size:TGLsizei; driverControls:PGLuint);cdecl;


{ -------------------------- GL_QCOM_extended_get -------------------------  }

const
  GL_QCOM_extended_get = 1;  
  GL_TEXTURE_WIDTH_QCOM = $8BD2;  
  GL_TEXTURE_HEIGHT_QCOM = $8BD3;  
  GL_TEXTURE_DEPTH_QCOM = $8BD4;  
  GL_TEXTURE_INTERNAL_FORMAT_QCOM = $8BD5;  
  GL_TEXTURE_FORMAT_QCOM = $8BD6;  
  GL_TEXTURE_TYPE_QCOM = $8BD7;  
  GL_TEXTURE_IMAGE_VALID_QCOM = $8BD8;  
  GL_TEXTURE_NUM_LEVELS_QCOM = $8BD9;  
  GL_TEXTURE_TARGET_QCOM = $8BDA;  
  GL_TEXTURE_OBJECT_VALID_QCOM = $8BDB;  
  GL_STATE_RESTORE = $8BDC;  
type
  TPFNGLEXTGETBUFFERPOINTERVQCOMPROC = procedure (target:TGLenum; params:Ppointer);cdecl;
  TPFNGLEXTGETBUFFERSQCOMPROC = procedure (buffers:PGLuint; maxBuffers:TGLint; numBuffers:PGLint);cdecl;
  TPFNGLEXTGETFRAMEBUFFERSQCOMPROC = procedure (framebuffers:PGLuint; maxFramebuffers:TGLint; numFramebuffers:PGLint);cdecl;
  TPFNGLEXTGETRENDERBUFFERSQCOMPROC = procedure (renderbuffers:PGLuint; maxRenderbuffers:TGLint; numRenderbuffers:PGLint);cdecl;
  TPFNGLEXTGETTEXLEVELPARAMETERIVQCOMPROC = procedure (texture:TGLuint; face:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLEXTGETTEXSUBIMAGEQCOMPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
                texels:pointer);cdecl;
  TPFNGLEXTGETTEXTURESQCOMPROC = procedure (textures:PGLuint; maxTextures:TGLint; numTextures:PGLint);cdecl;
  TPFNGLEXTTEXOBJECTSTATEOVERRIDEIQCOMPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;


{ ------------------------- GL_QCOM_extended_get2 -------------------------  }

const
  GL_QCOM_extended_get2 = 1;  
type
  TPFNGLEXTGETPROGRAMBINARYSOURCEQCOMPROC = procedure (prog:TGLuint; shadertype:TGLenum; source:PGLchar; length:PGLint);cdecl;
  TPFNGLEXTGETPROGRAMSQCOMPROC = procedure (programs:PGLuint; maxPrograms:TGLint; numPrograms:PGLint);cdecl;
  TPFNGLEXTGETSHADERSQCOMPROC = procedure (shaders:PGLuint; maxShaders:TGLint; numShaders:PGLint);cdecl;
  TPFNGLEXTISPROGRAMBINARYQCOMPROC = function (prog:TGLuint):TGLboolean;cdecl;


{ ---------------------- GL_QCOM_framebuffer_foveated ---------------------  }

const
  GL_QCOM_framebuffer_foveated = 1;  
  GL_FOVEATION_ENABLE_BIT_QCOM = $1;  
  GL_FOVEATION_SCALED_BIN_METHOD_BIT_QCOM = $2;  
type
  TPFNGLFRAMEBUFFERFOVEATIONCONFIGQCOMPROC = procedure (fbo:TGLuint; numLayers:TGLuint; focalPointsPerLayer:TGLuint; requestedFeatures:TGLuint; providedFeatures:PGLuint);cdecl;
  TPFNGLFRAMEBUFFERFOVEATIONPARAMETERSQCOMPROC = procedure (fbo:TGLuint; layer:TGLuint; focalPoint:TGLuint; focalX:TGLfloat; focalY:TGLfloat;
                gainX:TGLfloat; gainY:TGLfloat; foveaArea:TGLfloat);cdecl;


{ ---------------------- GL_QCOM_perfmon_global_mode ----------------------  }

const
  GL_QCOM_perfmon_global_mode = 1;  
  GL_PERFMON_GLOBAL_MODE_QCOM = $8FA0;  


{ -------------- GL_QCOM_shader_framebuffer_fetch_noncoherent -------------  }

const
  GL_QCOM_shader_framebuffer_fetch_noncoherent = 1;  
  GL_FRAMEBUFFER_FETCH_NONCOHERENT_QCOM = $96A2;  
type
  TPFNGLFRAMEBUFFERFETCHBARRIERQCOMPROC = procedure (para1:pointer);cdecl;


{ ----------------- GL_QCOM_shader_framebuffer_fetch_rate -----------------  }

const
  GL_QCOM_shader_framebuffer_fetch_rate = 1;  


{ ------------------------ GL_QCOM_texture_foveated -----------------------  }

const
  GL_QCOM_texture_foveated = 1;  
//  GL_FOVEATION_ENABLE_BIT_QCOM = $1;     doppelt
//  GL_FOVEATION_SCALED_BIN_METHOD_BIT_QCOM = $2;  
  GL_TEXTURE_FOVEATED_FEATURE_BITS_QCOM = $8BFB;  
  GL_TEXTURE_FOVEATED_MIN_PIXEL_DENSITY_QCOM = $8BFC;  
  GL_TEXTURE_FOVEATED_FEATURE_QUERY_QCOM = $8BFD;  
  GL_TEXTURE_FOVEATED_NUM_FOCAL_POINTS_QUERY_QCOM = $8BFE;  
  GL_FRAMEBUFFER_INCOMPLETE_FOVEATION_QCOM = $8BFF;  
type
  TPFNGLTEXTUREFOVEATIONPARAMETERSQCOMPROC = procedure (texture:TGLuint; layer:TGLuint; focalPoint:TGLuint; focalX:TGLfloat; focalY:TGLfloat;
                gainX:TGLfloat; gainY:TGLfloat; foveaArea:TGLfloat);cdecl;


{ --------------- GL_QCOM_texture_foveated_subsampled_layout --------------  }

const
  GL_QCOM_texture_foveated_subsampled_layout = 1;  
  GL_FOVEATION_SUBSAMPLED_LAYOUT_METHOD_BIT_QCOM = $4;  
  GL_MAX_SHADER_SUBSAMPLED_IMAGE_UNITS_QCOM = $8FA1;  


{ ------------------------ GL_QCOM_tiled_rendering ------------------------  }

const
  GL_QCOM_tiled_rendering = 1;  
  GL_COLOR_BUFFER_BIT0_QCOM = $00000001;  
  GL_COLOR_BUFFER_BIT1_QCOM = $00000002;  
  GL_COLOR_BUFFER_BIT2_QCOM = $00000004;  
  GL_COLOR_BUFFER_BIT3_QCOM = $00000008;  
  GL_COLOR_BUFFER_BIT4_QCOM = $00000010;  
  GL_COLOR_BUFFER_BIT5_QCOM = $00000020;  
  GL_COLOR_BUFFER_BIT6_QCOM = $00000040;  
  GL_COLOR_BUFFER_BIT7_QCOM = $00000080;  
  GL_DEPTH_BUFFER_BIT0_QCOM = $00000100;  
  GL_DEPTH_BUFFER_BIT1_QCOM = $00000200;  
  GL_DEPTH_BUFFER_BIT2_QCOM = $00000400;  
  GL_DEPTH_BUFFER_BIT3_QCOM = $00000800;  
  GL_DEPTH_BUFFER_BIT4_QCOM = $00001000;  
  GL_DEPTH_BUFFER_BIT5_QCOM = $00002000;  
  GL_DEPTH_BUFFER_BIT6_QCOM = $00004000;  
  GL_DEPTH_BUFFER_BIT7_QCOM = $00008000;  
  GL_STENCIL_BUFFER_BIT0_QCOM = $00010000;  
  GL_STENCIL_BUFFER_BIT1_QCOM = $00020000;  
  GL_STENCIL_BUFFER_BIT2_QCOM = $00040000;  
  GL_STENCIL_BUFFER_BIT3_QCOM = $00080000;  
  GL_STENCIL_BUFFER_BIT4_QCOM = $00100000;  
  GL_STENCIL_BUFFER_BIT5_QCOM = $00200000;  
  GL_STENCIL_BUFFER_BIT6_QCOM = $00400000;  
  GL_STENCIL_BUFFER_BIT7_QCOM = $00800000;  
  GL_MULTISAMPLE_BUFFER_BIT0_QCOM = $01000000;  
  GL_MULTISAMPLE_BUFFER_BIT1_QCOM = $02000000;  
  GL_MULTISAMPLE_BUFFER_BIT2_QCOM = $04000000;  
  GL_MULTISAMPLE_BUFFER_BIT3_QCOM = $08000000;  
  GL_MULTISAMPLE_BUFFER_BIT4_QCOM = $10000000;  
  GL_MULTISAMPLE_BUFFER_BIT5_QCOM = $20000000;  
  GL_MULTISAMPLE_BUFFER_BIT6_QCOM = $40000000;  
  GL_MULTISAMPLE_BUFFER_BIT7_QCOM = $80000000;  
type
  TPFNGLENDTILINGQCOMPROC = procedure (preserveMask:TGLbitfield);cdecl;
  TPFNGLSTARTTILINGQCOMPROC = procedure (x:TGLuint; y:TGLuint; width:TGLuint; height:TGLuint; preserveMask:TGLbitfield);cdecl;


{ ---------------------- GL_QCOM_writeonly_rendering ----------------------  }

const
  GL_QCOM_writeonly_rendering = 1;  
  GL_WRITEONLY_RENDERING_QCOM = $8823;  


{ ---------------------- GL_REGAL_ES1_0_compatibility ---------------------  }

const
  GL_REGAL_ES1_0_compatibility = 1;  
type
  PGLclampx = ^TGLclampx;
  TGLclampx = longint;

  TPFNGLALPHAFUNCXPROC = procedure (func:TGLenum; ref:TGLclampx);cdecl;
  TPFNGLCLEARCOLORXPROC = procedure (red:TGLclampx; green:TGLclampx; blue:TGLclampx; alpha:TGLclampx);cdecl;
  TPFNGLCLEARDEPTHXPROC = procedure (depth:TGLclampx);cdecl;
  TPFNGLCOLOR4XPROC = procedure (red:TGLfixed; green:TGLfixed; blue:TGLfixed; alpha:TGLfixed);cdecl;
  TPFNGLDEPTHRANGEXPROC = procedure (zNear:TGLclampx; zFar:TGLclampx);cdecl;
  TPFNGLFOGXPROC = procedure (pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLFOGXVPROC = procedure (pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLFRUSTUMFPROC = procedure (left:TGLfloat; right:TGLfloat; bottom:TGLfloat; top:TGLfloat; zNear:TGLfloat;                zFar:TGLfloat);cdecl;
  TPFNGLFRUSTUMXPROC = procedure (left:TGLfixed; right:TGLfixed; bottom:TGLfixed; top:TGLfixed; zNear:TGLfixed;                zFar:TGLfixed);cdecl;
  TPFNGLLIGHTMODELXPROC = procedure (pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLLIGHTMODELXVPROC = procedure (pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLLIGHTXPROC = procedure (light:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLLIGHTXVPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLLINEWIDTHXPROC = procedure (width:TGLfixed);cdecl;
  TPFNGLLOADMATRIXXPROC = procedure (m:PGLfixed);cdecl;
  TPFNGLMATERIALXPROC = procedure (face:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLMATERIALXVPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLMULTMATRIXXPROC = procedure (m:PGLfixed);cdecl;
  TPFNGLMULTITEXCOORD4XPROC = procedure (target:TGLenum; s:TGLfixed; t:TGLfixed; r:TGLfixed; q:TGLfixed);cdecl;
  TPFNGLNORMAL3XPROC = procedure (nx:TGLfixed; ny:TGLfixed; nz:TGLfixed);cdecl;
  TPFNGLORTHOFPROC = procedure (left:TGLfloat; right:TGLfloat; bottom:TGLfloat; top:TGLfloat; zNear:TGLfloat;                zFar:TGLfloat);cdecl;
  TPFNGLORTHOXPROC = procedure (left:TGLfixed; right:TGLfixed; bottom:TGLfixed; top:TGLfixed; zNear:TGLfixed;                zFar:TGLfixed);cdecl;
  TPFNGLPOINTSIZEXPROC = procedure (size:TGLfixed);cdecl;
  TPFNGLPOLYGONOFFSETXPROC = procedure (factor:TGLfixed; units:TGLfixed);cdecl;
  TPFNGLROTATEXPROC = procedure (angle:TGLfixed; x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;
  TPFNGLSAMPLECOVERAGEXPROC = procedure (value:TGLclampx; invert:TGLboolean);cdecl;
  TPFNGLSCALEXPROC = procedure (x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;
  TPFNGLTEXENVXPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLTEXENVXVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLTEXPARAMETERXPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLTRANSLATEXPROC = procedure (x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;


{ ---------------------- GL_REGAL_ES1_1_compatibility ---------------------  }

const
  GL_REGAL_ES1_1_compatibility = 1;  
type
  TPFNGLCLIPPLANEFPROC = procedure (plane:TGLenum; equation:PGLfloat);cdecl;
  TPFNGLCLIPPLANEXPROC = procedure (plane:TGLenum; equation:PGLfixed);cdecl;
  TPFNGLGETCLIPPLANEFPROC = procedure (pname:TGLenum; eqn:TfVec4);cdecl;
  TPFNGLGETCLIPPLANEXPROC = procedure (pname:TGLenum; eqn:tfiVec4);cdecl;
  TPFNGLGETFIXEDVPROC = procedure (pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLGETLIGHTXVPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLGETMATERIALXVPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLGETTEXENVXVPROC = procedure (env:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLGETTEXPARAMETERXVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLPOINTPARAMETERXPROC = procedure (pname:TGLenum; param:TGLfixed);cdecl;
  TPFNGLPOINTPARAMETERXVPROC = procedure (pname:TGLenum; params:PGLfixed);cdecl;
  TPFNGLPOINTSIZEPOINTEROESPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLTEXPARAMETERXVPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;


{ ---------------------------- GL_REGAL_enable ----------------------------  }

const
  GL_REGAL_enable = 1;  
  GL_ERROR_REGAL = $9322;  
  GL_DEBUG_REGAL = $9323;  
  GL_LOG_REGAL = $9324;  
  GL_EMULATION_REGAL = $9325;  
  GL_DRIVER_REGAL = $9326;  
  GL_MISSING_REGAL = $9360;  
  GL_TRACE_REGAL = $9361;  
  GL_CACHE_REGAL = $9362;  
  GL_CODE_REGAL = $9363;  
  GL_STATISTICS_REGAL = $9364;  


{ ------------------------- GL_REGAL_error_string -------------------------  }

const
  GL_REGAL_error_string = 1;  
type
  TPFNGLERRORSTRINGREGALPROC = function (error:TGLenum):PGLchar;cdecl;


{ ------------------------ GL_REGAL_extension_query -----------------------  }

const
  GL_REGAL_extension_query = 1;  
type
  TPFNGLGETEXTENSIONREGALPROC = function (ext:PGLchar):TGLboolean;cdecl;
  TPFNGLISSUPPORTEDREGALPROC = function (ext:PGLchar):TGLboolean;cdecl;


{ ------------------------------ GL_REGAL_log -----------------------------  }

const
  GL_REGAL_log = 1;  
  GL_LOG_ERROR_REGAL = $9319;  
  GL_LOG_WARNING_REGAL = $931A;  
  GL_LOG_INFO_REGAL = $931B;  
  GL_LOG_APP_REGAL = $931C;  
  GL_LOG_DRIVER_REGAL = $931D;  
  GL_LOG_INTERNAL_REGAL = $931E;  
  GL_LOG_DEBUG_REGAL = $931F;  
  GL_LOG_STATUS_REGAL = $9320;  
  GL_LOG_HTTP_REGAL = $9321;  
type
  TGLLOGPROCREGAL = procedure (stream:TGLenum; length:TGLsizei; message:PGLchar; context:pointer);cdecl;
  TPFNGLLOGMESSAGECALLBACKREGALPROC = procedure (callback:TGLLOGPROCREGAL);cdecl;


{ ------------------------- GL_REGAL_proc_address -------------------------  }

const
  GL_REGAL_proc_address = 1;  
type
  TPFNGLGETPROCADDRESSREGALPROC = function (name:PGLchar):pointer;cdecl;


{ ----------------------- GL_REND_screen_coordinates ----------------------  }

const
  GL_REND_screen_coordinates = 1;  
  GL_SCREEN_COORDINATES_REND = $8490;  
  GL_INVERTED_SCREEN_W_REND = $8491;  


{ ------------------------------- GL_S3_s3tc ------------------------------  }

const
  GL_S3_s3tc = 1;  
  GL_RGB_S3TC = $83A0;  
  GL_RGB4_S3TC = $83A1;  
  GL_RGBA_S3TC = $83A2;  
  GL_RGBA4_S3TC = $83A3;  
  GL_RGBA_DXT5_S3TC = $83A4;  
  GL_RGBA4_DXT5_S3TC = $83A5;  


{ ------------------------- GL_SGIS_clip_band_hint ------------------------  }

const
  GL_SGIS_clip_band_hint = 1;  


{ -------------------------- GL_SGIS_color_range --------------------------  }

const
  GL_SGIS_color_range = 1;  
  GL_EXTENDED_RANGE_SGIS = $85A5;  
  GL_MIN_RED_SGIS = $85A6;  
  GL_MAX_RED_SGIS = $85A7;  
  GL_MIN_GREEN_SGIS = $85A8;  
  GL_MAX_GREEN_SGIS = $85A9;  
  GL_MIN_BLUE_SGIS = $85AA;  
  GL_MAX_BLUE_SGIS = $85AB;  
  GL_MIN_ALPHA_SGIS = $85AC;  
  GL_MAX_ALPHA_SGIS = $85AD;  


{ ------------------------- GL_SGIS_detail_texture ------------------------  }

const
  GL_SGIS_detail_texture = 1;  
type
  TPFNGLDETAILTEXFUNCSGISPROC = procedure (target:TGLenum; n:TGLsizei; points:PGLfloat);cdecl;
  TPFNGLGETDETAILTEXFUNCSGISPROC = procedure (target:TGLenum; points:PGLfloat);cdecl;


{ -------------------------- GL_SGIS_fog_function -------------------------  }

const
  GL_SGIS_fog_function = 1;  
type
  TPFNGLFOGFUNCSGISPROC = procedure (n:TGLsizei; points:PGLfloat);cdecl;
  TPFNGLGETFOGFUNCSGISPROC = procedure (points:PGLfloat);cdecl;


{ ------------------------ GL_SGIS_generate_mipmap ------------------------  }

const
  GL_SGIS_generate_mipmap = 1;  
  GL_GENERATE_MIPMAP_SGIS = $8191;  
  GL_GENERATE_MIPMAP_HINT_SGIS = $8192;  


{ -------------------------- GL_SGIS_line_texgen --------------------------  }

const
  GL_SGIS_line_texgen = 1;  


{ -------------------------- GL_SGIS_multisample --------------------------  }

const
  GL_SGIS_multisample = 1;  
  GL_MULTISAMPLE_SGIS = $809D;  
  GL_SAMPLE_ALPHA_TO_MASK_SGIS = $809E;  
  GL_SAMPLE_ALPHA_TO_ONE_SGIS = $809F;  
  GL_SAMPLE_MASK_SGIS = $80A0;  
  GL_1PASS_SGIS = $80A1;  
  GL_2PASS_0_SGIS = $80A2;  
  GL_2PASS_1_SGIS = $80A3;  
  GL_4PASS_0_SGIS = $80A4;  
  GL_4PASS_1_SGIS = $80A5;  
  GL_4PASS_2_SGIS = $80A6;  
  GL_4PASS_3_SGIS = $80A7;  
  GL_SAMPLE_BUFFERS_SGIS = $80A8;  
  GL_SAMPLES_SGIS = $80A9;  
  GL_SAMPLE_MASK_VALUE_SGIS = $80AA;  
  GL_SAMPLE_MASK_INVERT_SGIS = $80AB;  
  GL_SAMPLE_PATTERN_SGIS = $80AC;  
type
  TPFNGLSAMPLEMASKSGISPROC = procedure (value:TGLclampf; invert:TGLboolean);cdecl;
  TPFNGLSAMPLEPATTERNSGISPROC = procedure (pattern:TGLenum);cdecl;


{ -------------------------- GL_SGIS_multitexture -------------------------  }

const
  GL_SGIS_multitexture = 1;  
  GL_SELECTED_TEXTURE_SGIS = $83C0;  
  GL_SELECTED_TEXTURE_COORD_SET_SGIS = $83C1;  
  GL_SELECTED_TEXTURE_TRANSFORM_SGIS = $83C2;  
  GL_MAX_TEXTURES_SGIS = $83C3;  
  GL_MAX_TEXTURE_COORD_SETS_SGIS = $83C4;  
  GL_TEXTURE_COORD_SET_INTERLEAVE_FACTOR_SGIS = $83C5;  
  GL_TEXTURE_ENV_COORD_SET_SGIS = $83C6;  
  GL_TEXTURE0_SGIS = $83C7;  
  GL_TEXTURE1_SGIS = $83C8;  
  GL_TEXTURE2_SGIS = $83C9;  
  GL_TEXTURE3_SGIS = $83CA;  
type
  TPFNGLINTERLEAVEDTEXTURECOORDSETSSGISPROC = procedure (factor:TGLint);cdecl;
  TPFNGLSELECTTEXTURECOORDSETSGISPROC = procedure (target:TGLenum);cdecl;
  TPFNGLSELECTTEXTURESGISPROC = procedure (target:TGLenum);cdecl;
  TPFNGLSELECTTEXTURETRANSFORMSGISPROC = procedure (target:TGLenum);cdecl;


{ ------------------------- GL_SGIS_pixel_texture -------------------------  }

const
  GL_SGIS_pixel_texture = 1;  


{ ----------------------- GL_SGIS_point_line_texgen -----------------------  }

const
  GL_SGIS_point_line_texgen = 1;  
  GL_EYE_DISTANCE_TO_POINT_SGIS = $81F0;  
  GL_OBJECT_DISTANCE_TO_POINT_SGIS = $81F1;  
  GL_EYE_DISTANCE_TO_LINE_SGIS = $81F2;  
  GL_OBJECT_DISTANCE_TO_LINE_SGIS = $81F3;  
  GL_EYE_POINT_SGIS = $81F4;  
  GL_OBJECT_POINT_SGIS = $81F5;  
  GL_EYE_LINE_SGIS = $81F6;  
  GL_OBJECT_LINE_SGIS = $81F7;  


{ ----------------------- GL_SGIS_shared_multisample ----------------------  }

const
  GL_SGIS_shared_multisample = 1;  
type
  TPFNGLMULTISAMPLESUBRECTPOSSGISPROC = procedure (x:TGLint; y:TGLint);cdecl;


{ ------------------------ GL_SGIS_sharpen_texture ------------------------  }

const
  GL_SGIS_sharpen_texture = 1;  
type
  TPFNGLGETSHARPENTEXFUNCSGISPROC = procedure (target:TGLenum; points:PGLfloat);cdecl;
  TPFNGLSHARPENTEXFUNCSGISPROC = procedure (target:TGLenum; n:TGLsizei; points:PGLfloat);cdecl;


{ --------------------------- GL_SGIS_texture4D ---------------------------  }

const
  GL_SGIS_texture4D = 1;  
type
  TPFNGLTEXIMAGE4DSGISPROC = procedure (target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei;
                depth:TGLsizei; extent:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
                pixels:pointer);cdecl;
  TPFNGLTEXSUBIMAGE4DSGISPROC = procedure (target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint;
                woffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; extent:TGLsizei; 
                format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;


{ ---------------------- GL_SGIS_texture_border_clamp ---------------------  }

const
  GL_SGIS_texture_border_clamp = 1;  
  GL_CLAMP_TO_BORDER_SGIS = $812D;  


{ ----------------------- GL_SGIS_texture_edge_clamp ----------------------  }

const
  GL_SGIS_texture_edge_clamp = 1;  
  GL_CLAMP_TO_EDGE_SGIS = $812F;  


{ ------------------------ GL_SGIS_texture_filter4 ------------------------  }

const
  GL_SGIS_texture_filter4 = 1;  
type
  TPFNGLGETTEXFILTERFUNCSGISPROC = procedure (target:TGLenum; filter:TGLenum; weights:PGLfloat);cdecl;
  TPFNGLTEXFILTERFUNCSGISPROC = procedure (target:TGLenum; filter:TGLenum; n:TGLsizei; weights:PGLfloat);cdecl;


{ -------------------------- GL_SGIS_texture_lod --------------------------  }

const
  GL_SGIS_texture_lod = 1;  
  GL_TEXTURE_MIN_LOD_SGIS = $813A;  
  GL_TEXTURE_MAX_LOD_SGIS = $813B;  
  GL_TEXTURE_BASE_LEVEL_SGIS = $813C;  
  GL_TEXTURE_MAX_LEVEL_SGIS = $813D;  


{ ------------------------- GL_SGIS_texture_select ------------------------  }

const
  GL_SGIS_texture_select = 1;  


{ ----------------------------- GL_SGIX_async -----------------------------  }

const
  GL_SGIX_async = 1;  
  GL_ASYNC_MARKER_SGIX = $8329;  
type
  TPFNGLASYNCMARKERSGIXPROC = procedure (marker:TGLuint);cdecl;
  TPFNGLDELETEASYNCMARKERSSGIXPROC = procedure (marker:TGLuint; range:TGLsizei);cdecl;
  TPFNGLFINISHASYNCSGIXPROC = function (markerp:PGLuint):TGLint;cdecl;
  TPFNGLGENASYNCMARKERSSGIXPROC = function (range:TGLsizei):TGLuint;cdecl;
  TPFNGLISASYNCMARKERSGIXPROC = function (marker:TGLuint):TGLboolean;cdecl;
  TPFNGLPOLLASYNCSGIXPROC = function (markerp:PGLuint):TGLint;cdecl;


{ ------------------------ GL_SGIX_async_histogram ------------------------  }

const
  GL_SGIX_async_histogram = 1;  
  GL_ASYNC_HISTOGRAM_SGIX = $832C;  
  GL_MAX_ASYNC_HISTOGRAM_SGIX = $832D;  


{ -------------------------- GL_SGIX_async_pixel --------------------------  }

const
  GL_SGIX_async_pixel = 1;  
  GL_ASYNC_TEX_IMAGE_SGIX = $835C;  
  GL_ASYNC_DRAW_PIXELS_SGIX = $835D;  
  GL_ASYNC_READ_PIXELS_SGIX = $835E;  
  GL_MAX_ASYNC_TEX_IMAGE_SGIX = $835F;  
  GL_MAX_ASYNC_DRAW_PIXELS_SGIX = $8360;  
  GL_MAX_ASYNC_READ_PIXELS_SGIX = $8361;  


{ ----------------------- GL_SGIX_bali_g_instruments ----------------------  }

const
  GL_SGIX_bali_g_instruments = 1;  
  GL_BALI_NUM_TRIS_CULLED_INSTRUMENT = $6080;  
  GL_BALI_NUM_PRIMS_CLIPPED_INSTRUMENT = $6081;  
  GL_BALI_NUM_PRIMS_REJECT_INSTRUMENT = $6082;  
  GL_BALI_NUM_PRIMS_CLIP_RESULT_INSTRUMENT = $6083;  


{ ----------------------- GL_SGIX_bali_r_instruments ----------------------  }

const
  GL_SGIX_bali_r_instruments = 1;  
  GL_BALI_FRAGMENTS_GENERATED_INSTRUMENT = $6090;  
  GL_BALI_DEPTH_PASS_INSTRUMENT = $6091;  
  GL_BALI_R_CHIP_COUNT = $6092;  


{ --------------------- GL_SGIX_bali_timer_instruments --------------------  }

const
  GL_SGIX_bali_timer_instruments = 1;  


{ ----------------------- GL_SGIX_blend_alpha_minmax ----------------------  }

const
  GL_SGIX_blend_alpha_minmax = 1;  
  GL_ALPHA_MIN_SGIX = $8320;  
  GL_ALPHA_MAX_SGIX = $8321;  


{ --------------------------- GL_SGIX_blend_cadd --------------------------  }

const
  GL_SGIX_blend_cadd = 1;  
  GL_FUNC_COMPLEX_ADD_EXT = $601C;  


{ ------------------------ GL_SGIX_blend_cmultiply ------------------------  }

const
  GL_SGIX_blend_cmultiply = 1;  
  GL_FUNC_COMPLEX_MULTIPLY_EXT = $601B;  


{ --------------------- GL_SGIX_calligraphic_fragment ---------------------  }

const
  GL_SGIX_calligraphic_fragment = 1;  


{ ---------------------------- GL_SGIX_clipmap ----------------------------  }

const
  GL_SGIX_clipmap = 1;  


{ --------------------- GL_SGIX_color_matrix_accuracy ---------------------  }

const
  GL_SGIX_color_matrix_accuracy = 1;  
  GL_COLOR_MATRIX_HINT = $8317;  


{ --------------------- GL_SGIX_color_table_index_mode --------------------  }

const
  GL_SGIX_color_table_index_mode = 1;  


{ ------------------------- GL_SGIX_complex_polar -------------------------  }

const
  GL_SGIX_complex_polar = 1;  


{ ---------------------- GL_SGIX_convolution_accuracy ---------------------  }

const
  GL_SGIX_convolution_accuracy = 1;  
  GL_CONVOLUTION_HINT_SGIX = $8316;  


{ ---------------------------- GL_SGIX_cube_map ---------------------------  }

const
  GL_SGIX_cube_map = 1;  
  GL_ENV_MAP_SGIX = $8340;  
  GL_CUBE_MAP_SGIX = $8341;  
  GL_CUBE_MAP_ZP_SGIX = $8342;  
  GL_CUBE_MAP_ZN_SGIX = $8343;  
  GL_CUBE_MAP_XN_SGIX = $8344;  
  GL_CUBE_MAP_XP_SGIX = $8345;  
  GL_CUBE_MAP_YN_SGIX = $8346;  
  GL_CUBE_MAP_YP_SGIX = $8347;  
  GL_CUBE_MAP_BINDING_SGIX = $8348;  


{ ------------------------ GL_SGIX_cylinder_texgen ------------------------  }

const
  GL_SGIX_cylinder_texgen = 1;  


{ ---------------------------- GL_SGIX_datapipe ---------------------------  }

const
  GL_SGIX_datapipe = 1;  
  GL_GEOMETRY_BIT = $1;  
  GL_IMAGE_BIT = $2;  
type
  TPFNGLADDRESSSPACEPROC = procedure (space:TGLenum; mask:TGLbitfield);cdecl;
  TPFNGLDATAPIPEPROC = function (space:TGLenum):TGLint;cdecl;


{ --------------------------- GL_SGIX_decimation --------------------------  }

const
  GL_SGIX_decimation = 1;  


{ --------------------- GL_SGIX_depth_pass_instrument ---------------------  }

const
  GL_SGIX_depth_pass_instrument = 1;  
  GL_DEPTH_PASS_INSTRUMENT_SGIX = $8310;  
  GL_DEPTH_PASS_INSTRUMENT_COUNTERS_SGIX = $8311;  
  GL_DEPTH_PASS_INSTRUMENT_MAX_SGIX = $8312;  


{ ------------------------- GL_SGIX_depth_texture -------------------------  }

const
  GL_SGIX_depth_texture = 1;  
  GL_DEPTH_COMPONENT16_SGIX = $81A5;  
  GL_DEPTH_COMPONENT24_SGIX = $81A6;  
  GL_DEPTH_COMPONENT32_SGIX = $81A7;  


{ ------------------------------ GL_SGIX_dvc ------------------------------  }

const
  GL_SGIX_dvc = 1;  


{ -------------------------- GL_SGIX_flush_raster -------------------------  }

const
  GL_SGIX_flush_raster = 1;  
type
  TPFNGLFLUSHRASTERSGIXPROC = procedure (para1:pointer);cdecl;


{ --------------------------- GL_SGIX_fog_blend ---------------------------  }

const
  GL_SGIX_fog_blend = 1;  
  GL_FOG_BLEND_ALPHA_SGIX = $81FE;  
  GL_FOG_BLEND_COLOR_SGIX = $81FF;  


{ ---------------------- GL_SGIX_fog_factor_to_alpha ----------------------  }

const
  GL_SGIX_fog_factor_to_alpha = 1;  


{ --------------------------- GL_SGIX_fog_layers --------------------------  }

const
  GL_SGIX_fog_layers = 1;  
  GL_FOG_TYPE_SGIX = $8323;  
  GL_UNIFORM_SGIX = $8324;  
  GL_LAYERED_SGIX = $8325;  
  GL_FOG_GROUND_PLANE_SGIX = $8326;  
  GL_FOG_LAYERS_POINTS_SGIX = $8327;  
  GL_MAX_FOG_LAYERS_POINTS_SGIX = $8328;  
type
  TPFNGLFOGLAYERSSGIXPROC = procedure (n:TGLsizei; points:PGLfloat);cdecl;
  TPFNGLGETFOGLAYERSSGIXPROC = procedure (points:PGLfloat);cdecl;


{ --------------------------- GL_SGIX_fog_offset --------------------------  }

const
  GL_SGIX_fog_offset = 1;  
  GL_FOG_OFFSET_SGIX = $8198;  
  GL_FOG_OFFSET_VALUE_SGIX = $8199;  


{ --------------------------- GL_SGIX_fog_patchy --------------------------  }

const
  GL_SGIX_fog_patchy = 1;  


{ --------------------------- GL_SGIX_fog_scale ---------------------------  }

const
  GL_SGIX_fog_scale = 1;  
  GL_FOG_SCALE_SGIX = $81FC;  
  GL_FOG_SCALE_VALUE_SGIX = $81FD;  


{ -------------------------- GL_SGIX_fog_texture --------------------------  }

const
  GL_SGIX_fog_texture = 1;  
type
  TPFNGLTEXTUREFOGSGIXPROC = procedure (pname:TGLenum);cdecl;


{ -------------------- GL_SGIX_fragment_lighting_space --------------------  }

const
  GL_SGIX_fragment_lighting_space = 1;  
  GL_EYE_SPACE_SGIX = $8436;  
  GL_TANGENT_SPACE_SGIX = $8437;  
  GL_OBJECT_SPACE_SGIX = $8438;  
  GL_FRAGMENT_LIGHT_SPACE_SGIX = $843D;  


{ ------------------- GL_SGIX_fragment_specular_lighting ------------------  }

const
  GL_SGIX_fragment_specular_lighting = 1;  
type
  TPFNGLFRAGMENTCOLORMATERIALSGIXPROC = procedure (face:TGLenum; mode:TGLenum);cdecl;
  TPFNGLFRAGMENTLIGHTMODELFSGIXPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTMODELFVSGIXPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTMODELISGIXPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTLIGHTMODELIVSGIXPROC = procedure (pname:TGLenum; params:PGLint);cdecl;
  TPFNGLFRAGMENTLIGHTFSGIXPROC = procedure (light:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTFVSGIXPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTLIGHTISGIXPROC = procedure (light:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTLIGHTIVSGIXPROC = procedure (light:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLFRAGMENTMATERIALFSGIXPROC = procedure (face:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLFRAGMENTMATERIALFVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLFRAGMENTMATERIALISGIXPROC = procedure (face:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLFRAGMENTMATERIALIVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETFRAGMENTLIGHTFVSGIXPROC = procedure (light:TGLenum; value:TGLenum; data:PGLfloat);cdecl;
  TPFNGLGETFRAGMENTLIGHTIVSGIXPROC = procedure (light:TGLenum; value:TGLenum; data:PGLint);cdecl;
  TPFNGLGETFRAGMENTMATERIALFVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; data:PGLfloat);cdecl;
  TPFNGLGETFRAGMENTMATERIALIVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; data:PGLint);cdecl;


{ ---------------------- GL_SGIX_fragments_instrument ---------------------  }

const
  GL_SGIX_fragments_instrument = 1;  
  GL_FRAGMENTS_INSTRUMENT_SGIX = $8313;  
  GL_FRAGMENTS_INSTRUMENT_COUNTERS_SGIX = $8314;  
  GL_FRAGMENTS_INSTRUMENT_MAX_SGIX = $8315;  


{ --------------------------- GL_SGIX_framezoom ---------------------------  }

const
  GL_SGIX_framezoom = 1;  
type
  TPFNGLFRAMEZOOMSGIXPROC = procedure (factor:TGLint);cdecl;


{ -------------------------- GL_SGIX_icc_texture --------------------------  }

const
  GL_SGIX_icc_texture = 1;  
  GL_RGB_ICC_SGIX = $8460;  
  GL_RGBA_ICC_SGIX = $8461;  
  GL_ALPHA_ICC_SGIX = $8462;  
  GL_LUMINANCE_ICC_SGIX = $8463;  
  GL_INTENSITY_ICC_SGIX = $8464;  
  GL_LUMINANCE_ALPHA_ICC_SGIX = $8465;  
  GL_R5_G6_B5_ICC_SGIX = $8466;  
  GL_R5_G6_B5_A8_ICC_SGIX = $8467;  
  GL_ALPHA16_ICC_SGIX = $8468;  
  GL_LUMINANCE16_ICC_SGIX = $8469;  
  GL_INTENSITY16_ICC_SGIX = $846A;  
  GL_LUMINANCE16_ALPHA8_ICC_SGIX = $846B;  


{ ------------------------ GL_SGIX_igloo_interface ------------------------  }

const
  GL_SGIX_igloo_interface = 1;  
  GL_IGLOO_FULLSCREEN_SGIX = $819E;  
  GL_IGLOO_VIEWPORT_OFFSET_SGIX = $819F;  
  GL_IGLOO_SWAPTMESH_SGIX = $81A0;  
  GL_IGLOO_COLORNORMAL_SGIX = $81A1;  
  GL_IGLOO_IRISGL_MODE_SGIX = $81A2;  
  GL_IGLOO_LMC_COLOR_SGIX = $81A3;  
  GL_IGLOO_TMESHMODE_SGIX = $81A4;  
  GL_LIGHT31 = $BEAD;  
type
  TPFNGLIGLOOINTERFACESGIXPROC = procedure (pname:TGLenum; param:pointer);cdecl;


{ ----------------------- GL_SGIX_image_compression -----------------------  }

const
  GL_SGIX_image_compression = 1;  


{ ---------------------- GL_SGIX_impact_pixel_texture ---------------------  }

const
  GL_SGIX_impact_pixel_texture = 1;  


{ ------------------------ GL_SGIX_instrument_error -----------------------  }

const
  GL_SGIX_instrument_error = 1;  


{ --------------------------- GL_SGIX_interlace ---------------------------  }

const
  GL_SGIX_interlace = 1;  
  GL_INTERLACE_SGIX = $8094;  


{ ------------------------- GL_SGIX_ir_instrument1 ------------------------  }

const
  GL_SGIX_ir_instrument1 = 1;  


{ ----------------------- GL_SGIX_line_quality_hint -----------------------  }

const
  GL_SGIX_line_quality_hint = 1;  
  GL_LINE_QUALITY_HINT_SGIX = $835B;  


{ ------------------------- GL_SGIX_list_priority -------------------------  }

const
  GL_SGIX_list_priority = 1;  


{ ----------------------------- GL_SGIX_mpeg1 -----------------------------  }

const
  GL_SGIX_mpeg1 = 1;  
type
  TPFNGLALLOCMPEGPREDICTORSSGIXPROC = procedure (width:TGLsizei; height:TGLsizei; n:TGLsizei; predictors:PGLuint);cdecl;
  TPFNGLDELETEMPEGPREDICTORSSGIXPROC = procedure (n:TGLsizei; predictors:PGLuint);cdecl;
  TPFNGLGENMPEGPREDICTORSSGIXPROC = procedure (n:TGLsizei; predictors:PGLuint);cdecl;
  TPFNGLGETMPEGPARAMETERFVSGIXPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETMPEGPARAMETERIVSGIXPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETMPEGPREDICTORSGIXPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
  TPFNGLGETMPEGQUANTTABLEUBVPROC = procedure (target:TGLenum; values:PGLubyte);cdecl;
  TPFNGLISMPEGPREDICTORSGIXPROC = function (predictor:TGLuint):TGLboolean;cdecl;
  TPFNGLMPEGPREDICTORSGIXPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;
 TPFNGLMPEGQUANTTABLEUBVPROC = procedure (target:TGLenum; values:PGLubyte);cdecl;
  TPFNGLSWAPMPEGPREDICTORSSGIXPROC = procedure (target0:TGLenum; target1:TGLenum);cdecl;


{ ----------------------------- GL_SGIX_mpeg2 -----------------------------  }

const
  GL_SGIX_mpeg2 = 1;  


{ ------------------ GL_SGIX_nonlinear_lighting_pervertex -----------------  }

const
  GL_SGIX_nonlinear_lighting_pervertex = 1;  
type
  TPFNGLGETNONLINLIGHTFVSGIXPROC = procedure (light:TGLenum; pname:TGLenum; terms:PGLint; data:PGLfloat);cdecl;
  TPFNGLGETNONLINMATERIALFVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; terms:PGLint; data:PGLfloat);cdecl;
  TPFNGLNONLINLIGHTFVSGIXPROC = procedure (light:TGLenum; pname:TGLenum; terms:TGLint; params:PGLfloat);cdecl;
  TPFNGLNONLINMATERIALFVSGIXPROC = procedure (face:TGLenum; pname:TGLenum; terms:TGLint; params:PGLfloat);cdecl;


{ --------------------------- GL_SGIX_nurbs_eval --------------------------  }

const
  GL_SGIX_nurbs_eval = 1;  
  GL_MAP1_VERTEX_3_NURBS_SGIX = $81CB;  
  GL_MAP1_VERTEX_4_NURBS_SGIX = $81CC;  
  GL_MAP1_INDEX_NURBS_SGIX = $81CD;  
  GL_MAP1_COLOR_4_NURBS_SGIX = $81CE;  
  GL_MAP1_NORMAL_NURBS_SGIX = $81CF;  
  GL_MAP1_TEXTURE_COORD_1_NURBS_SGIX = $81E0;  
  GL_MAP1_TEXTURE_COORD_2_NURBS_SGIX = $81E1;  
  GL_MAP1_TEXTURE_COORD_3_NURBS_SGIX = $81E2;  
  GL_MAP1_TEXTURE_COORD_4_NURBS_SGIX = $81E3;  
  GL_MAP2_VERTEX_3_NURBS_SGIX = $81E4;  
  GL_MAP2_VERTEX_4_NURBS_SGIX = $81E5;  
  GL_MAP2_INDEX_NURBS_SGIX = $81E6;  
  GL_MAP2_COLOR_4_NURBS_SGIX = $81E7;  
  GL_MAP2_NORMAL_NURBS_SGIX = $81E8;  
  GL_MAP2_TEXTURE_COORD_1_NURBS_SGIX = $81E9;  
  GL_MAP2_TEXTURE_COORD_2_NURBS_SGIX = $81EA;  
  GL_MAP2_TEXTURE_COORD_3_NURBS_SGIX = $81EB;  
  GL_MAP2_TEXTURE_COORD_4_NURBS_SGIX = $81EC;  
  GL_NURBS_KNOT_COUNT_SGIX = $81ED;  
  GL_NURBS_KNOT_VECTOR_SGIX = $81EE;  


{ ---------------------- GL_SGIX_occlusion_instrument ---------------------  }

const
  GL_SGIX_occlusion_instrument = 1;  
  GL_OCCLUSION_INSTRUMENT_SGIX = $6060;  


{ ------------------------- GL_SGIX_packed_6bytes -------------------------  }

const
  GL_SGIX_packed_6bytes = 1;  


{ ------------------------- GL_SGIX_pixel_texture -------------------------  }

const
  GL_SGIX_pixel_texture = 1;  
type

  TPFNGLPIXELTEXGENSGIXPROC = procedure (mode:TGLenum);cdecl;


{ ----------------------- GL_SGIX_pixel_texture_bits ----------------------  }

const
  GL_SGIX_pixel_texture_bits = 1;  


{ ----------------------- GL_SGIX_pixel_texture_lod -----------------------  }

const
  GL_SGIX_pixel_texture_lod = 1;  


{ -------------------------- GL_SGIX_pixel_tiles --------------------------  }

const
  GL_SGIX_pixel_tiles = 1;  


{ ------------------------- GL_SGIX_polynomial_ffd ------------------------  }

const
  GL_SGIX_polynomial_ffd = 1;  
  GL_TEXTURE_DEFORMATION_BIT_SGIX = $1;  
  GL_GEOMETRY_DEFORMATION_BIT_SGIX = $2;  
type
  TPFNGLDEFORMSGIXPROC = procedure (mask:TGLbitfield);cdecl;
  TPFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC = procedure (mask:TGLbitfield);cdecl;


{ --------------------------- GL_SGIX_quad_mesh ---------------------------  }

const
  GL_SGIX_quad_mesh = 1;  
type
  TPFNGLMESHBREADTHSGIXPROC = procedure (breadth:TGLint);cdecl;
  TPFNGLMESHSTRIDESGIXPROC = procedure (stride:TGLint);cdecl;


{ ------------------------ GL_SGIX_reference_plane ------------------------  }

const
  GL_SGIX_reference_plane = 1;  
type
  TPFNGLREFERENCEPLANESGIXPROC = procedure (equation:PGLdouble);cdecl;


{ ---------------------------- GL_SGIX_resample ---------------------------  }

const
  GL_SGIX_resample = 1;  
  GL_PACK_RESAMPLE_SGIX = $842E;  
  GL_UNPACK_RESAMPLE_SGIX = $842F;  
  GL_RESAMPLE_DECIMATE_SGIX = $8430;  
  GL_RESAMPLE_REPLICATE_SGIX = $8433;  
  GL_RESAMPLE_ZERO_FILL_SGIX = $8434;  


{ ------------------------- GL_SGIX_scalebias_hint ------------------------  }

const
  GL_SGIX_scalebias_hint = 1;  
  GL_SCALEBIAS_HINT_SGIX = $8322;  


{ ----------------------------- GL_SGIX_shadow ----------------------------  }

const
  GL_SGIX_shadow = 1;  
  GL_TEXTURE_COMPARE_SGIX = $819A;  
  GL_TEXTURE_COMPARE_OPERATOR_SGIX = $819B;  
  GL_TEXTURE_LEQUAL_R_SGIX = $819C;  
  GL_TEXTURE_GEQUAL_R_SGIX = $819D;  


{ ------------------------- GL_SGIX_shadow_ambient ------------------------  }

const
  GL_SGIX_shadow_ambient = 1;  
  GL_SHADOW_AMBIENT_SGIX = $80BF;  


{ ------------------------------ GL_SGIX_slim -----------------------------  }

const
  GL_SGIX_slim = 1;  
  GL_PACK_MAX_COMPRESSED_SIZE_SGIX = $831B;  
  GL_SLIM8U_SGIX = $831D;  
  GL_SLIM10U_SGIX = $831E;  
  GL_SLIM12S_SGIX = $831F;  


{ ------------------------ GL_SGIX_spotlight_cutoff -----------------------  }

const
  GL_SGIX_spotlight_cutoff = 1;  
  GL_SPOT_CUTOFF_DELTA_SGIX = $8193;  


{ ----------------------------- GL_SGIX_sprite ----------------------------  }

const
  GL_SGIX_sprite = 1;  
type
  TPFNGLSPRITEPARAMETERFSGIXPROC = procedure (pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLSPRITEPARAMETERFVSGIXPROC = procedure (pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLSPRITEPARAMETERISGIXPROC = procedure (pname:TGLenum; param:TGLint);cdecl;
  TPFNGLSPRITEPARAMETERIVSGIXPROC = procedure (pname:TGLenum; params:PGLint);cdecl;


{ -------------------------- GL_SGIX_subdiv_patch -------------------------  }

const
  GL_SGIX_subdiv_patch = 1;  


{ --------------------------- GL_SGIX_subsample ---------------------------  }

const
  GL_SGIX_subsample = 1;  
  GL_PACK_SUBSAMPLE_RATE_SGIX = $85A0;  
  GL_UNPACK_SUBSAMPLE_RATE_SGIX = $85A1;  
  GL_PIXEL_SUBSAMPLE_4444_SGIX = $85A2;  
  GL_PIXEL_SUBSAMPLE_2424_SGIX = $85A3;  
  GL_PIXEL_SUBSAMPLE_4242_SGIX = $85A4;  


{ ----------------------- GL_SGIX_tag_sample_buffer -----------------------  }

const
  GL_SGIX_tag_sample_buffer = 1;  
type
  TPFNGLTAGSAMPLEBUFFERSGIXPROC = procedure (para1:pointer);cdecl;


{ ------------------------ GL_SGIX_texture_add_env ------------------------  }

const
  GL_SGIX_texture_add_env = 1;  


{ -------------------- GL_SGIX_texture_coordinate_clamp -------------------  }

const
  GL_SGIX_texture_coordinate_clamp = 1;  
  GL_TEXTURE_MAX_CLAMP_S_SGIX = $8369;  
  GL_TEXTURE_MAX_CLAMP_T_SGIX = $836A;  
  GL_TEXTURE_MAX_CLAMP_R_SGIX = $836B;  


{ ------------------------ GL_SGIX_texture_lod_bias -----------------------  }

const
  GL_SGIX_texture_lod_bias = 1;  


{ ------------------- GL_SGIX_texture_mipmap_anisotropic ------------------  }

const
  GL_SGIX_texture_mipmap_anisotropic = 1;  
  GL_TEXTURE_MIPMAP_ANISOTROPY_SGIX = $832E;  
  GL_MAX_MIPMAP_ANISOTROPY_SGIX = $832F;  


{ ---------------------- GL_SGIX_texture_multi_buffer ---------------------  }

const
  GL_SGIX_texture_multi_buffer = 1;  
  GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = $812E;  


{ ------------------------- GL_SGIX_texture_phase -------------------------  }

const
  GL_SGIX_texture_phase = 1;  
  GL_PHASE_SGIX = $832A;  


{ GL_SGIX_texture_phase  }
{ ------------------------- GL_SGIX_texture_range -------------------------  }

const
  GL_SGIX_texture_range = 1;  
  GL_RGB_SIGNED_SGIX = $85E0;  
  GL_RGBA_SIGNED_SGIX = $85E1;  
  GL_ALPHA_SIGNED_SGIX = $85E2;  
  GL_LUMINANCE_SIGNED_SGIX = $85E3;  
  GL_INTENSITY_SIGNED_SGIX = $85E4;  
  GL_LUMINANCE_ALPHA_SIGNED_SGIX = $85E5;  
  GL_RGB16_SIGNED_SGIX = $85E6;  
  GL_RGBA16_SIGNED_SGIX = $85E7;  
  GL_ALPHA16_SIGNED_SGIX = $85E8;  
  GL_LUMINANCE16_SIGNED_SGIX = $85E9;  
  GL_INTENSITY16_SIGNED_SGIX = $85EA;  
  GL_LUMINANCE16_ALPHA16_SIGNED_SGIX = $85EB;  
  GL_RGB_EXTENDED_RANGE_SGIX = $85EC;  
  GL_RGBA_EXTENDED_RANGE_SGIX = $85ED;  
  GL_ALPHA_EXTENDED_RANGE_SGIX = $85EE;  
  GL_LUMINANCE_EXTENDED_RANGE_SGIX = $85EF;  
  GL_INTENSITY_EXTENDED_RANGE_SGIX = $85F0;  
  GL_LUMINANCE_ALPHA_EXTENDED_RANGE_SGIX = $85F1;  
  GL_RGB16_EXTENDED_RANGE_SGIX = $85F2;  
  GL_RGBA16_EXTENDED_RANGE_SGIX = $85F3;  
  GL_ALPHA16_EXTENDED_RANGE_SGIX = $85F4;  
  GL_LUMINANCE16_EXTENDED_RANGE_SGIX = $85F5;  
  GL_INTENSITY16_EXTENDED_RANGE_SGIX = $85F6;  
  GL_LUMINANCE16_ALPHA16_EXTENDED_RANGE_SGIX = $85F7;  
  GL_MIN_LUMINANCE_SGIS = $85F8;  
  GL_MAX_LUMINANCE_SGIS = $85F9;  
  GL_MIN_INTENSITY_SGIS = $85FA;  
  GL_MAX_INTENSITY_SGIS = $85FB;  


{ ----------------------- GL_SGIX_texture_scale_bias ----------------------  }

const
  GL_SGIX_texture_scale_bias = 1;  
  GL_POST_TEXTURE_FILTER_BIAS_SGIX = $8179;  
  GL_POST_TEXTURE_FILTER_SCALE_SGIX = $817A;  
  GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = $817B;  
  GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = $817C;  


{ ---------------------- GL_SGIX_texture_supersample ----------------------  }

const
  GL_SGIX_texture_supersample = 1;  


{ --------------------------- GL_SGIX_vector_ops --------------------------  }

const
  GL_SGIX_vector_ops = 1;  
type
  TPFNGLGETVECTOROPERATIONSGIXPROC = procedure (operation:TGLenum);cdecl;
  TPFNGLVECTOROPERATIONSGIXPROC = procedure (operation:TGLenum);cdecl;


{ ---------------------- GL_SGIX_vertex_array_object ----------------------  }

const
  GL_SGIX_vertex_array_object = 1;  
type
  TPFNGLAREVERTEXARRAYSRESIDENTSGIXPROC = function (n:TGLsizei; arrays:PGLuint; residences:PGLboolean):TGLboolean;cdecl;
  TPFNGLBINDVERTEXARRAYSGIXPROC = procedure (arr:TGLuint);cdecl;
  TPFNGLDELETEVERTEXARRAYSSGIXPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLGENVERTEXARRAYSSGIXPROC = procedure (n:TGLsizei; arrays:PGLuint);cdecl;
  TPFNGLISVERTEXARRAYSGIXPROC = function (arr:TGLuint):TGLboolean;cdecl;
  TPFNGLPRIORITIZEVERTEXARRAYSSGIXPROC = procedure (n:TGLsizei; arrays:PGLuint; priorities:PGLclampf);cdecl;


{ ------------------------- GL_SGIX_vertex_preclip ------------------------  }

const
  GL_SGIX_vertex_preclip = 1;  
  GL_VERTEX_PRECLIP_SGIX = $83EE;  
  GL_VERTEX_PRECLIP_HINT_SGIX = $83EF;  


{ ---------------------- GL_SGIX_vertex_preclip_hint ----------------------  }

const
  GL_SGIX_vertex_preclip_hint = 1;  
//  GL_VERTEX_PRECLIP_SGIX = $83EE;   doppelt
//  GL_VERTEX_PRECLIP_HINT_SGIX = $83EF;  


{ ----------------------------- GL_SGIX_ycrcb -----------------------------  }

const
  GL_SGIX_ycrcb = 1;  


{ ------------------------ GL_SGIX_ycrcb_subsample ------------------------  }

const
  GL_SGIX_ycrcb_subsample = 1;  


{ ----------------------------- GL_SGIX_ycrcba ----------------------------  }

const
  GL_SGIX_ycrcba = 1;  
  GL_YCRCB_SGIX = $8318;  
  GL_YCRCBA_SGIX = $8319;  


{ -------------------------- GL_SGI_color_matrix --------------------------  }

const
  GL_SGI_color_matrix = 1;  
  GL_COLOR_MATRIX_SGI = $80B1;  
  GL_COLOR_MATRIX_STACK_DEPTH_SGI = $80B2;  
  GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI = $80B3;  
  GL_POST_COLOR_MATRIX_RED_SCALE_SGI = $80B4;  
  GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI = $80B5;  
  GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI = $80B6;  
  GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI = $80B7;  
  GL_POST_COLOR_MATRIX_RED_BIAS_SGI = $80B8;  
  GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI = $80B9;  
  GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI = $80BA;  
  GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI = $80BB;  


{ --------------------------- GL_SGI_color_table --------------------------  }

const
  GL_SGI_color_table = 1;  
  GL_COLOR_TABLE_SGI = $80D0;  
  GL_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D1;  
  GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D2;  
  GL_PROXY_COLOR_TABLE_SGI = $80D3;  
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D4;  
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D5;  
  GL_COLOR_TABLE_SCALE_SGI = $80D6;  
  GL_COLOR_TABLE_BIAS_SGI = $80D7;  
  GL_COLOR_TABLE_FORMAT_SGI = $80D8;  
  GL_COLOR_TABLE_WIDTH_SGI = $80D9;  
  GL_COLOR_TABLE_RED_SIZE_SGI = $80DA;  
  GL_COLOR_TABLE_GREEN_SIZE_SGI = $80DB;  
  GL_COLOR_TABLE_BLUE_SIZE_SGI = $80DC;  
  GL_COLOR_TABLE_ALPHA_SIZE_SGI = $80DD;  
  GL_COLOR_TABLE_LUMINANCE_SIZE_SGI = $80DE;  
  GL_COLOR_TABLE_INTENSITY_SIZE_SGI = $80DF;  
type
  TPFNGLCOLORTABLEPARAMETERFVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLCOLORTABLEPARAMETERIVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLCOLORTABLESGIPROC = procedure (target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum;                table:pointer);cdecl;
  TPFNGLCOPYCOLORTABLESGIPROC = procedure (target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERFVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETCOLORTABLEPARAMETERIVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLGETCOLORTABLESGIPROC = procedure (target:TGLenum; format:TGLenum; _type:TGLenum; table:pointer);cdecl;


{ ----------------------------- GL_SGI_complex ----------------------------  }

const
  GL_SGI_complex = 1;  


{ -------------------------- GL_SGI_complex_type --------------------------  }

const
  GL_SGI_complex_type = 1;  
  GL_COMPLEX_UNSIGNED_BYTE_SGI = $81BD;  
  GL_COMPLEX_BYTE_SGI = $81BE;  
  GL_COMPLEX_UNSIGNED_SHORT_SGI = $81BF;  
  GL_COMPLEX_SHORT_SGI = $81C0;  
  GL_COMPLEX_UNSIGNED_INT_SGI = $81C1;  
  GL_COMPLEX_INT_SGI = $81C2;  
  GL_COMPLEX_FLOAT_SGI = $81C3;  


{ ------------------------------- GL_SGI_fft ------------------------------  }

const
  GL_SGI_fft = 1;  
  GL_PIXEL_TRANSFORM_OPERATOR_SGI = $81C4;  
  GL_CONVOLUTION_SGI = $81C5;  
  GL_FFT_1D_SGI = $81C6;  
  GL_PIXEL_TRANSFORM_SGI = $81C7;  
  GL_MAX_FFT_WIDTH_SGI = $81C8;  
type
  TPFNGLGETPIXELTRANSFORMPARAMETERFVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLGETPIXELTRANSFORMPARAMETERIVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERFSGIPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERFVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERISGIPROC = procedure (target:TGLenum; pname:TGLenum; param:TGLint);cdecl;
  TPFNGLPIXELTRANSFORMPARAMETERIVSGIPROC = procedure (target:TGLenum; pname:TGLenum; params:PGLint);cdecl;
  TPFNGLPIXELTRANSFORMSGIPROC = procedure (target:TGLenum);cdecl;


{ ----------------------- GL_SGI_texture_color_table ----------------------  }

const
  GL_SGI_texture_color_table = 1;  
  GL_TEXTURE_COLOR_TABLE_SGI = $80BC;  
  GL_PROXY_TEXTURE_COLOR_TABLE_SGI = $80BD;  


{ ------------------------- GL_SUNX_constant_data -------------------------  }

const
  GL_SUNX_constant_data = 1;  
  GL_UNPACK_CONSTANT_DATA_SUNX = $81D5;  
  GL_TEXTURE_CONSTANT_DATA_SUNX = $81D6;  
type
  TPFNGLFINISHTEXTURESUNXPROC = procedure (para1:pointer);cdecl;


{ -------------------- GL_SUN_convolution_border_modes --------------------  }

const
  GL_SUN_convolution_border_modes = 1;  
  GL_WRAP_BORDER_SUN = $81D4;  


{ -------------------------- GL_SUN_global_alpha --------------------------  }

const
  GL_SUN_global_alpha = 1;  
  GL_GLOBAL_ALPHA_SUN = $81D9;  
  GL_GLOBAL_ALPHA_FACTOR_SUN = $81DA;  
type
  TPFNGLGLOBALALPHAFACTORBSUNPROC = procedure (factor:TGLbyte);cdecl;
  TPFNGLGLOBALALPHAFACTORDSUNPROC = procedure (factor:TGLdouble);cdecl;
  TPFNGLGLOBALALPHAFACTORFSUNPROC = procedure (factor:TGLfloat);cdecl;
  TPFNGLGLOBALALPHAFACTORISUNPROC = procedure (factor:TGLint);cdecl;
  TPFNGLGLOBALALPHAFACTORSSUNPROC = procedure (factor:TGLshort);cdecl;
  TPFNGLGLOBALALPHAFACTORUBSUNPROC = procedure (factor:TGLubyte);cdecl;
  TPFNGLGLOBALALPHAFACTORUISUNPROC = procedure (factor:TGLuint);cdecl;
  TPFNGLGLOBALALPHAFACTORUSSUNPROC = procedure (factor:TGLushort);cdecl;


{ --------------------------- GL_SUN_mesh_array ---------------------------  }

const
  GL_SUN_mesh_array = 1;  
  GL_QUAD_MESH_SUN = $8614;  
  GL_TRIANGLE_MESH_SUN = $8615;  


{ ------------------------ GL_SUN_read_video_pixels -----------------------  }

const
  GL_SUN_read_video_pixels = 1;  
type
  TPFNGLREADVIDEOPIXELSSUNPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum;
                _type:TGLenum; pixels:pointer);cdecl;


{ --------------------------- GL_SUN_slice_accum --------------------------  }

const
  GL_SUN_slice_accum = 1;  
  GL_SLICE_ACCUM_SUN = $85CC;  


{ -------------------------- GL_SUN_triangle_list -------------------------  }

const
  GL_SUN_triangle_list = 1;  
  GL_RESTART_SUN = $01;  
  GL_REPLACE_MIDDLE_SUN = $02;  
  GL_REPLACE_OLDEST_SUN = $03;  
  GL_TRIANGLE_LIST_SUN = $81D7;  
  GL_REPLACEMENT_CODE_SUN = $81D8;  
  GL_REPLACEMENT_CODE_ARRAY_SUN = $85C0;  
  GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN = $85C1;  
  GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN = $85C2;  
  GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN = $85C3;  
  GL_R1UI_V3F_SUN = $85C4;  
  GL_R1UI_C4UB_V3F_SUN = $85C5;  
  GL_R1UI_C3F_V3F_SUN = $85C6;  
  GL_R1UI_N3F_V3F_SUN = $85C7;  
  GL_R1UI_C4F_N3F_V3F_SUN = $85C8;  
  GL_R1UI_T2F_V3F_SUN = $85C9;  
  GL_R1UI_T2F_N3F_V3F_SUN = $85CA;  
  GL_R1UI_T2F_C4F_N3F_V3F_SUN = $85CB;  
type
  TPFNGLREPLACEMENTCODEPOINTERSUNPROC = procedure (_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;
  TPFNGLREPLACEMENTCODEUBSUNPROC = procedure (code:TGLubyte);cdecl;
  TPFNGLREPLACEMENTCODEUBVSUNPROC = procedure (code:PGLubyte);cdecl;
  TPFNGLREPLACEMENTCODEUISUNPROC = procedure (code:TGLuint);cdecl;
  TPFNGLREPLACEMENTCODEUIVSUNPROC = procedure (code:PGLuint);cdecl;
  TPFNGLREPLACEMENTCODEUSSUNPROC = procedure (code:TGLushort);cdecl;
  TPFNGLREPLACEMENTCODEUSVSUNPROC = procedure (code:PGLushort);cdecl;


{ ----------------------------- GL_SUN_vertex -----------------------------  }

const
  GL_SUN_vertex = 1;  
type
  TPFNGLCOLOR3FVERTEX3FSUNPROC = procedure (r:TGLfloat; g:TGLfloat; b:TGLfloat; x:TGLfloat; y:TGLfloat;                z:TGLfloat);cdecl;
  TPFNGLCOLOR3FVERTEX3FVSUNPROC = procedure (c:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC = procedure (r:TGLfloat; g:TGLfloat; b:TGLfloat; a:TGLfloat; nx:TGLfloat;
                ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC = procedure (c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLCOLOR4UBVERTEX2FSUNPROC = procedure (r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte; x:TGLfloat;                y:TGLfloat);cdecl;
  TPFNGLCOLOR4UBVERTEX2FVSUNPROC = procedure (c:PGLubyte; v:PGLfloat);cdecl;
  TPFNGLCOLOR4UBVERTEX3FSUNPROC = procedure (r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte; x:TGLfloat;                y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLCOLOR4UBVERTEX3FVSUNPROC = procedure (c:PGLubyte; v:PGLfloat);cdecl;
  TPFNGLNORMAL3FVERTEX3FSUNPROC = procedure (nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat;                z:TGLfloat);cdecl;
  TPFNGLNORMAL3FVERTEX3FVSUNPROC = procedure (n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC = procedure (rc:TGLuint; r:TGLfloat; g:TGLfloat; b:TGLfloat; x:TGLfloat;                y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC = procedure (rc:PGLuint; c:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC = procedure (rc:TGLuint; r:TGLfloat; g:TGLfloat; b:TGLfloat; a:TGLfloat;
                nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat; 
                z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC = procedure (rc:PGLuint; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC = procedure (rc:TGLuint; r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte;                x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC = procedure (rc:PGLuint; c:PGLubyte; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC = procedure (rc:TGLuint; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat;                y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC = procedure (rc:PGLuint; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC = procedure (rc:TGLuint; s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat;
                b:TGLfloat; a:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; 
                x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC = procedure (rc:PGLuint; tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC = procedure (rc:TGLuint; s:TGLfloat; t:TGLfloat; nx:TGLfloat; ny:TGLfloat;
                nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC = procedure (rc:PGLuint; tc:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC = procedure (rc:TGLuint; s:TGLfloat; t:TGLfloat; x:TGLfloat; y:TGLfloat;                z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC = procedure (rc:PGLuint; tc:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC = procedure (rc:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC = procedure (rc:PGLuint; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat; b:TGLfloat;                x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC = procedure (tc:PGLfloat; c:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat; b:TGLfloat;
                a:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; 
                y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC = procedure (tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; r:TGLubyte; g:TGLubyte; b:TGLubyte;
                a:TGLubyte; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC = procedure (tc:PGLfloat; c:PGLubyte; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat;                x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC = procedure (tc:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD2FVERTEX3FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;
  TPFNGLTEXCOORD2FVERTEX3FVSUNPROC = procedure (tc:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; p:TGLfloat; q:TGLfloat; r:TGLfloat;
                g:TGLfloat; b:TGLfloat; a:TGLfloat; nx:TGLfloat; ny:TGLfloat; 
                nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC = procedure (tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;
  TPFNGLTEXCOORD4FVERTEX4FSUNPROC = procedure (s:TGLfloat; t:TGLfloat; p:TGLfloat; q:TGLfloat; x:TGLfloat;                y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;
  TPFNGLTEXCOORD4FVERTEX4FVSUNPROC = procedure (tc:PGLfloat; v:PGLfloat);cdecl;


{ -------------------------- GL_VIV_shader_binary -------------------------  }

const
  GL_VIV_shader_binary = 1;  
  GL_SHADER_BINARY_VIV = $8FC4;  


{ -------------------------- GL_WIN_phong_shading -------------------------  }

const
  GL_WIN_phong_shading = 1;  
  GL_PHONG_WIN = $80EA;  
  GL_PHONG_HINT_WIN = $80EB;  


{ ------------------------- GL_WIN_scene_markerXXX ------------------------  }

const
  GL_WIN_scene_markerXXX = 1;  


{ -------------------------- GL_WIN_specular_fog --------------------------  }

const
  GL_WIN_specular_fog = 1;  
  GL_FOG_SPECULAR_TEXTURE_WIN = $80EC;  


{ ---------------------------- GL_WIN_swap_hint ---------------------------  }

const
  GL_WIN_swap_hint = 1;  
type
  TPFNGLADDSWAPHINTRECTWINPROC = procedure (x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;



{ -------------------------------------------------------------------------  }
  var
    __glewCopyTexSubImage3D : TPFNGLCOPYTEXSUBIMAGE3DPROC;cvar;external libGLEW;
    __glewDrawRangeElements : TPFNGLDRAWRANGEELEMENTSPROC;cvar;external libGLEW;
    __glewTexImage3D : TPFNGLTEXIMAGE3DPROC;cvar;external libGLEW;
    __glewTexSubImage3D : TPFNGLTEXSUBIMAGE3DPROC;cvar;external libGLEW;
    __glewActiveTexture : TPFNGLACTIVETEXTUREPROC;cvar;external libGLEW;
    __glewClientActiveTexture : TPFNGLCLIENTACTIVETEXTUREPROC;cvar;external libGLEW;
    __glewCompressedTexImage1D : TPFNGLCOMPRESSEDTEXIMAGE1DPROC;cvar;external libGLEW;
    __glewCompressedTexImage2D : TPFNGLCOMPRESSEDTEXIMAGE2DPROC;cvar;external libGLEW;
    __glewCompressedTexImage3D : TPFNGLCOMPRESSEDTEXIMAGE3DPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage1D : TPFNGLCOMPRESSEDTEXSUBIMAGE1DPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage2D : TPFNGLCOMPRESSEDTEXSUBIMAGE2DPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage3D : TPFNGLCOMPRESSEDTEXSUBIMAGE3DPROC;cvar;external libGLEW;
    __glewGetCompressedTexImage : TPFNGLGETCOMPRESSEDTEXIMAGEPROC;cvar;external libGLEW;
    __glewLoadTransposeMatrixd : TPFNGLLOADTRANSPOSEMATRIXDPROC;cvar;external libGLEW;
    __glewLoadTransposeMatrixf : TPFNGLLOADTRANSPOSEMATRIXFPROC;cvar;external libGLEW;
    __glewMultTransposeMatrixd : TPFNGLMULTTRANSPOSEMATRIXDPROC;cvar;external libGLEW;
    __glewMultTransposeMatrixf : TPFNGLMULTTRANSPOSEMATRIXFPROC;cvar;external libGLEW;
    __glewMultiTexCoord1d : TPFNGLMULTITEXCOORD1DPROC;cvar;external libGLEW;
    __glewMultiTexCoord1dv : TPFNGLMULTITEXCOORD1DVPROC;cvar;external libGLEW;
    __glewMultiTexCoord1f : TPFNGLMULTITEXCOORD1FPROC;cvar;external libGLEW;
    __glewMultiTexCoord1fv : TPFNGLMULTITEXCOORD1FVPROC;cvar;external libGLEW;
    __glewMultiTexCoord1i : TPFNGLMULTITEXCOORD1IPROC;cvar;external libGLEW;
    __glewMultiTexCoord1iv : TPFNGLMULTITEXCOORD1IVPROC;cvar;external libGLEW;
    __glewMultiTexCoord1s : TPFNGLMULTITEXCOORD1SPROC;cvar;external libGLEW;
    __glewMultiTexCoord1sv : TPFNGLMULTITEXCOORD1SVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2d : TPFNGLMULTITEXCOORD2DPROC;cvar;external libGLEW;
    __glewMultiTexCoord2dv : TPFNGLMULTITEXCOORD2DVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2f : TPFNGLMULTITEXCOORD2FPROC;cvar;external libGLEW;
    __glewMultiTexCoord2fv : TPFNGLMULTITEXCOORD2FVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2i : TPFNGLMULTITEXCOORD2IPROC;cvar;external libGLEW;
    __glewMultiTexCoord2iv : TPFNGLMULTITEXCOORD2IVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2s : TPFNGLMULTITEXCOORD2SPROC;cvar;external libGLEW;
    __glewMultiTexCoord2sv : TPFNGLMULTITEXCOORD2SVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3d : TPFNGLMULTITEXCOORD3DPROC;cvar;external libGLEW;
    __glewMultiTexCoord3dv : TPFNGLMULTITEXCOORD3DVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3f : TPFNGLMULTITEXCOORD3FPROC;cvar;external libGLEW;
    __glewMultiTexCoord3fv : TPFNGLMULTITEXCOORD3FVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3i : TPFNGLMULTITEXCOORD3IPROC;cvar;external libGLEW;
    __glewMultiTexCoord3iv : TPFNGLMULTITEXCOORD3IVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3s : TPFNGLMULTITEXCOORD3SPROC;cvar;external libGLEW;
    __glewMultiTexCoord3sv : TPFNGLMULTITEXCOORD3SVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4d : TPFNGLMULTITEXCOORD4DPROC;cvar;external libGLEW;
    __glewMultiTexCoord4dv : TPFNGLMULTITEXCOORD4DVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4f : TPFNGLMULTITEXCOORD4FPROC;cvar;external libGLEW;
    __glewMultiTexCoord4fv : TPFNGLMULTITEXCOORD4FVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4i : TPFNGLMULTITEXCOORD4IPROC;cvar;external libGLEW;
    __glewMultiTexCoord4iv : TPFNGLMULTITEXCOORD4IVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4s : TPFNGLMULTITEXCOORD4SPROC;cvar;external libGLEW;
    __glewMultiTexCoord4sv : TPFNGLMULTITEXCOORD4SVPROC;cvar;external libGLEW;
    __glewSampleCoverage : TPFNGLSAMPLECOVERAGEPROC;cvar;external libGLEW;
    __glewBlendColor : TPFNGLBLENDCOLORPROC;cvar;external libGLEW;
    __glewBlendEquation : TPFNGLBLENDEQUATIONPROC;cvar;external libGLEW;
    __glewBlendFuncSeparate : TPFNGLBLENDFUNCSEPARATEPROC;cvar;external libGLEW;
    __glewFogCoordPointer : TPFNGLFOGCOORDPOINTERPROC;cvar;external libGLEW;
    __glewFogCoordd : TPFNGLFOGCOORDDPROC;cvar;external libGLEW;
    __glewFogCoorddv : TPFNGLFOGCOORDDVPROC;cvar;external libGLEW;
    __glewFogCoordf : TPFNGLFOGCOORDFPROC;cvar;external libGLEW;
    __glewFogCoordfv : TPFNGLFOGCOORDFVPROC;cvar;external libGLEW;
    __glewMultiDrawArrays : TPFNGLMULTIDRAWARRAYSPROC;cvar;external libGLEW;
    __glewMultiDrawElements : TPFNGLMULTIDRAWELEMENTSPROC;cvar;external libGLEW;
    __glewPointParameterf : TPFNGLPOINTPARAMETERFPROC;cvar;external libGLEW;
    __glewPointParameterfv : TPFNGLPOINTPARAMETERFVPROC;cvar;external libGLEW;
    __glewPointParameteri : TPFNGLPOINTPARAMETERIPROC;cvar;external libGLEW;
    __glewPointParameteriv : TPFNGLPOINTPARAMETERIVPROC;cvar;external libGLEW;
    __glewSecondaryColor3b : TPFNGLSECONDARYCOLOR3BPROC;cvar;external libGLEW;
    __glewSecondaryColor3bv : TPFNGLSECONDARYCOLOR3BVPROC;cvar;external libGLEW;
    __glewSecondaryColor3d : TPFNGLSECONDARYCOLOR3DPROC;cvar;external libGLEW;
    __glewSecondaryColor3dv : TPFNGLSECONDARYCOLOR3DVPROC;cvar;external libGLEW;
    __glewSecondaryColor3f : TPFNGLSECONDARYCOLOR3FPROC;cvar;external libGLEW;
    __glewSecondaryColor3fv : TPFNGLSECONDARYCOLOR3FVPROC;cvar;external libGLEW;
    __glewSecondaryColor3i : TPFNGLSECONDARYCOLOR3IPROC;cvar;external libGLEW;
    __glewSecondaryColor3iv : TPFNGLSECONDARYCOLOR3IVPROC;cvar;external libGLEW;
    __glewSecondaryColor3s : TPFNGLSECONDARYCOLOR3SPROC;cvar;external libGLEW;
    __glewSecondaryColor3sv : TPFNGLSECONDARYCOLOR3SVPROC;cvar;external libGLEW;
    __glewSecondaryColor3ub : TPFNGLSECONDARYCOLOR3UBPROC;cvar;external libGLEW;
    __glewSecondaryColor3ubv : TPFNGLSECONDARYCOLOR3UBVPROC;cvar;external libGLEW;
    __glewSecondaryColor3ui : TPFNGLSECONDARYCOLOR3UIPROC;cvar;external libGLEW;
    __glewSecondaryColor3uiv : TPFNGLSECONDARYCOLOR3UIVPROC;cvar;external libGLEW;
    __glewSecondaryColor3us : TPFNGLSECONDARYCOLOR3USPROC;cvar;external libGLEW;
    __glewSecondaryColor3usv : TPFNGLSECONDARYCOLOR3USVPROC;cvar;external libGLEW;
    __glewSecondaryColorPointer : TPFNGLSECONDARYCOLORPOINTERPROC;cvar;external libGLEW;
    __glewWindowPos2d : TPFNGLWINDOWPOS2DPROC;cvar;external libGLEW;
    __glewWindowPos2dv : TPFNGLWINDOWPOS2DVPROC;cvar;external libGLEW;
    __glewWindowPos2f : TPFNGLWINDOWPOS2FPROC;cvar;external libGLEW;
    __glewWindowPos2fv : TPFNGLWINDOWPOS2FVPROC;cvar;external libGLEW;
    __glewWindowPos2i : TPFNGLWINDOWPOS2IPROC;cvar;external libGLEW;
    __glewWindowPos2iv : TPFNGLWINDOWPOS2IVPROC;cvar;external libGLEW;
    __glewWindowPos2s : TPFNGLWINDOWPOS2SPROC;cvar;external libGLEW;
    __glewWindowPos2sv : TPFNGLWINDOWPOS2SVPROC;cvar;external libGLEW;
    __glewWindowPos3d : TPFNGLWINDOWPOS3DPROC;cvar;external libGLEW;
    __glewWindowPos3dv : TPFNGLWINDOWPOS3DVPROC;cvar;external libGLEW;
    __glewWindowPos3f : TPFNGLWINDOWPOS3FPROC;cvar;external libGLEW;
    __glewWindowPos3fv : TPFNGLWINDOWPOS3FVPROC;cvar;external libGLEW;
    __glewWindowPos3i : TPFNGLWINDOWPOS3IPROC;cvar;external libGLEW;
    __glewWindowPos3iv : TPFNGLWINDOWPOS3IVPROC;cvar;external libGLEW;
    __glewWindowPos3s : TPFNGLWINDOWPOS3SPROC;cvar;external libGLEW;
    __glewWindowPos3sv : TPFNGLWINDOWPOS3SVPROC;cvar;external libGLEW;
    __glewBeginQuery : TPFNGLBEGINQUERYPROC;cvar;external libGLEW;
    __glewBindBuffer : TPFNGLBINDBUFFERPROC;cvar;external libGLEW;
    __glewBufferData : TPFNGLBUFFERDATAPROC;cvar;external libGLEW;
    __glewBufferSubData : TPFNGLBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewDeleteBuffers : TPFNGLDELETEBUFFERSPROC;cvar;external libGLEW;
    __glewDeleteQueries : TPFNGLDELETEQUERIESPROC;cvar;external libGLEW;
    __glewEndQuery : TPFNGLENDQUERYPROC;cvar;external libGLEW;
    __glewGenBuffers : TPFNGLGENBUFFERSPROC;cvar;external libGLEW;
    __glewGenQueries : TPFNGLGENQUERIESPROC;cvar;external libGLEW;
    __glewGetBufferParameteriv : TPFNGLGETBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetBufferPointerv : TPFNGLGETBUFFERPOINTERVPROC;cvar;external libGLEW;
    __glewGetBufferSubData : TPFNGLGETBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewGetQueryObjectiv : TPFNGLGETQUERYOBJECTIVPROC;cvar;external libGLEW;
    __glewGetQueryObjectuiv : TPFNGLGETQUERYOBJECTUIVPROC;cvar;external libGLEW;
    __glewGetQueryiv : TPFNGLGETQUERYIVPROC;cvar;external libGLEW;
    __glewIsBuffer : TPFNGLISBUFFERPROC;cvar;external libGLEW;
    __glewIsQuery : TPFNGLISQUERYPROC;cvar;external libGLEW;
    __glewMapBuffer : TPFNGLMAPBUFFERPROC;cvar;external libGLEW;
    __glewUnmapBuffer : TPFNGLUNMAPBUFFERPROC;cvar;external libGLEW;
    __glewAttachShader : TPFNGLATTACHSHADERPROC;cvar;external libGLEW;
    __glewBindAttribLocation : TPFNGLBINDATTRIBLOCATIONPROC;cvar;external libGLEW;
    __glewBlendEquationSeparate : TPFNGLBLENDEQUATIONSEPARATEPROC;cvar;external libGLEW;
    __glewCompileShader : TPFNGLCOMPILESHADERPROC;cvar;external libGLEW;
    __glewCreateProgram : TPFNGLCREATEPROGRAMPROC;cvar;external libGLEW;
    __glewCreateShader : TPFNGLCREATESHADERPROC;cvar;external libGLEW;
    __glewDeleteProgram : TPFNGLDELETEPROGRAMPROC;cvar;external libGLEW;
    __glewDeleteShader : TPFNGLDELETESHADERPROC;cvar;external libGLEW;
    __glewDetachShader : TPFNGLDETACHSHADERPROC;cvar;external libGLEW;
    __glewDisableVertexAttribArray : TPFNGLDISABLEVERTEXATTRIBARRAYPROC;cvar;external libGLEW;
    __glewDrawBuffers : TPFNGLDRAWBUFFERSPROC;cvar;external libGLEW;
    __glewEnableVertexAttribArray : TPFNGLENABLEVERTEXATTRIBARRAYPROC;cvar;external libGLEW;
    __glewGetActiveAttrib : TPFNGLGETACTIVEATTRIBPROC;cvar;external libGLEW;
    __glewGetActiveUniform : TPFNGLGETACTIVEUNIFORMPROC;cvar;external libGLEW;
    __glewGetAttachedShaders : TPFNGLGETATTACHEDSHADERSPROC;cvar;external libGLEW;
    __glewGetAttribLocation : TPFNGLGETATTRIBLOCATIONPROC;cvar;external libGLEW;
    __glewGetProgramInfoLog : TPFNGLGETPROGRAMINFOLOGPROC;cvar;external libGLEW;
    __glewGetProgramiv : TPFNGLGETPROGRAMIVPROC;cvar;external libGLEW;
    __glewGetShaderInfoLog : TPFNGLGETSHADERINFOLOGPROC;cvar;external libGLEW;
    __glewGetShaderSource : TPFNGLGETSHADERSOURCEPROC;cvar;external libGLEW;
    __glewGetShaderiv : TPFNGLGETSHADERIVPROC;cvar;external libGLEW;
    __glewGetUniformLocation : TPFNGLGETUNIFORMLOCATIONPROC;cvar;external libGLEW;
    __glewGetUniformfv : TPFNGLGETUNIFORMFVPROC;cvar;external libGLEW;
    __glewGetUniformiv : TPFNGLGETUNIFORMIVPROC;cvar;external libGLEW;
    __glewGetVertexAttribPointerv : TPFNGLGETVERTEXATTRIBPOINTERVPROC;cvar;external libGLEW;
    __glewGetVertexAttribdv : TPFNGLGETVERTEXATTRIBDVPROC;cvar;external libGLEW;
    __glewGetVertexAttribfv : TPFNGLGETVERTEXATTRIBFVPROC;cvar;external libGLEW;
    __glewGetVertexAttribiv : TPFNGLGETVERTEXATTRIBIVPROC;cvar;external libGLEW;
    __glewIsProgram : TPFNGLISPROGRAMPROC;cvar;external libGLEW;
    __glewIsShader : TPFNGLISSHADERPROC;cvar;external libGLEW;
    __glewLinkProgram : TPFNGLLINKPROGRAMPROC;cvar;external libGLEW;
    __glewShaderSource : TPFNGLSHADERSOURCEPROC;cvar;external libGLEW;
    __glewStencilFuncSeparate : TPFNGLSTENCILFUNCSEPARATEPROC;cvar;external libGLEW;
    __glewStencilMaskSeparate : TPFNGLSTENCILMASKSEPARATEPROC;cvar;external libGLEW;
    __glewStencilOpSeparate : TPFNGLSTENCILOPSEPARATEPROC;cvar;external libGLEW;
    __glewUniform1f : TPFNGLUNIFORM1FPROC;cvar;external libGLEW;
    __glewUniform1fv : TPFNGLUNIFORM1FVPROC;cvar;external libGLEW;
    __glewUniform1i : TPFNGLUNIFORM1IPROC;cvar;external libGLEW;
    __glewUniform1iv : TPFNGLUNIFORM1IVPROC;cvar;external libGLEW;
    __glewUniform2f : TPFNGLUNIFORM2FPROC;cvar;external libGLEW;
    __glewUniform2fv : TPFNGLUNIFORM2FVPROC;cvar;external libGLEW;
    __glewUniform2i : TPFNGLUNIFORM2IPROC;cvar;external libGLEW;
    __glewUniform2iv : TPFNGLUNIFORM2IVPROC;cvar;external libGLEW;
    __glewUniform3f : TPFNGLUNIFORM3FPROC;cvar;external libGLEW;
    __glewUniform3fv : TPFNGLUNIFORM3FVPROC;cvar;external libGLEW;
    __glewUniform3i : TPFNGLUNIFORM3IPROC;cvar;external libGLEW;
    __glewUniform3iv : TPFNGLUNIFORM3IVPROC;cvar;external libGLEW;
    __glewUniform4f : TPFNGLUNIFORM4FPROC;cvar;external libGLEW;
    __glewUniform4fv : TPFNGLUNIFORM4FVPROC;cvar;external libGLEW;
    __glewUniform4i : TPFNGLUNIFORM4IPROC;cvar;external libGLEW;
    __glewUniform4iv : TPFNGLUNIFORM4IVPROC;cvar;external libGLEW;
    __glewUniformMatrix2fv : TPFNGLUNIFORMMATRIX2FVPROC;cvar;external libGLEW;
    __glewUniformMatrix3fv : TPFNGLUNIFORMMATRIX3FVPROC;cvar;external libGLEW;
    __glewUniformMatrix4fv : TPFNGLUNIFORMMATRIX4FVPROC;cvar;external libGLEW;
    __glewUseProgram : TPFNGLUSEPROGRAMPROC;cvar;external libGLEW;
    __glewValidateProgram : TPFNGLVALIDATEPROGRAMPROC;cvar;external libGLEW;
    __glewVertexAttrib1d : TPFNGLVERTEXATTRIB1DPROC;cvar;external libGLEW;
    __glewVertexAttrib1dv : TPFNGLVERTEXATTRIB1DVPROC;cvar;external libGLEW;
    __glewVertexAttrib1f : TPFNGLVERTEXATTRIB1FPROC;cvar;external libGLEW;
    __glewVertexAttrib1fv : TPFNGLVERTEXATTRIB1FVPROC;cvar;external libGLEW;
    __glewVertexAttrib1s : TPFNGLVERTEXATTRIB1SPROC;cvar;external libGLEW;
    __glewVertexAttrib1sv : TPFNGLVERTEXATTRIB1SVPROC;cvar;external libGLEW;
    __glewVertexAttrib2d : TPFNGLVERTEXATTRIB2DPROC;cvar;external libGLEW;
    __glewVertexAttrib2dv : TPFNGLVERTEXATTRIB2DVPROC;cvar;external libGLEW;
    __glewVertexAttrib2f : TPFNGLVERTEXATTRIB2FPROC;cvar;external libGLEW;
    __glewVertexAttrib2fv : TPFNGLVERTEXATTRIB2FVPROC;cvar;external libGLEW;
    __glewVertexAttrib2s : TPFNGLVERTEXATTRIB2SPROC;cvar;external libGLEW;
    __glewVertexAttrib2sv : TPFNGLVERTEXATTRIB2SVPROC;cvar;external libGLEW;
    __glewVertexAttrib3d : TPFNGLVERTEXATTRIB3DPROC;cvar;external libGLEW;
    __glewVertexAttrib3dv : TPFNGLVERTEXATTRIB3DVPROC;cvar;external libGLEW;
    __glewVertexAttrib3f : TPFNGLVERTEXATTRIB3FPROC;cvar;external libGLEW;
    __glewVertexAttrib3fv : TPFNGLVERTEXATTRIB3FVPROC;cvar;external libGLEW;
    __glewVertexAttrib3s : TPFNGLVERTEXATTRIB3SPROC;cvar;external libGLEW;
    __glewVertexAttrib3sv : TPFNGLVERTEXATTRIB3SVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nbv : TPFNGLVERTEXATTRIB4NBVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Niv : TPFNGLVERTEXATTRIB4NIVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nsv : TPFNGLVERTEXATTRIB4NSVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nub : TPFNGLVERTEXATTRIB4NUBPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nubv : TPFNGLVERTEXATTRIB4NUBVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nuiv : TPFNGLVERTEXATTRIB4NUIVPROC;cvar;external libGLEW;
    __glewVertexAttrib4Nusv : TPFNGLVERTEXATTRIB4NUSVPROC;cvar;external libGLEW;
    __glewVertexAttrib4bv : TPFNGLVERTEXATTRIB4BVPROC;cvar;external libGLEW;
    __glewVertexAttrib4d : TPFNGLVERTEXATTRIB4DPROC;cvar;external libGLEW;
    __glewVertexAttrib4dv : TPFNGLVERTEXATTRIB4DVPROC;cvar;external libGLEW;
    __glewVertexAttrib4f : TPFNGLVERTEXATTRIB4FPROC;cvar;external libGLEW;
    __glewVertexAttrib4fv : TPFNGLVERTEXATTRIB4FVPROC;cvar;external libGLEW;
    __glewVertexAttrib4iv : TPFNGLVERTEXATTRIB4IVPROC;cvar;external libGLEW;
    __glewVertexAttrib4s : TPFNGLVERTEXATTRIB4SPROC;cvar;external libGLEW;
    __glewVertexAttrib4sv : TPFNGLVERTEXATTRIB4SVPROC;cvar;external libGLEW;
    __glewVertexAttrib4ubv : TPFNGLVERTEXATTRIB4UBVPROC;cvar;external libGLEW;
    __glewVertexAttrib4uiv : TPFNGLVERTEXATTRIB4UIVPROC;cvar;external libGLEW;
    __glewVertexAttrib4usv : TPFNGLVERTEXATTRIB4USVPROC;cvar;external libGLEW;
    __glewVertexAttribPointer : TPFNGLVERTEXATTRIBPOINTERPROC;cvar;external libGLEW;
    __glewUniformMatrix2x3fv : TPFNGLUNIFORMMATRIX2X3FVPROC;cvar;external libGLEW;
    __glewUniformMatrix2x4fv : TPFNGLUNIFORMMATRIX2X4FVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x2fv : TPFNGLUNIFORMMATRIX3X2FVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x4fv : TPFNGLUNIFORMMATRIX3X4FVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x2fv : TPFNGLUNIFORMMATRIX4X2FVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x3fv : TPFNGLUNIFORMMATRIX4X3FVPROC;cvar;external libGLEW;
    __glewBeginConditionalRender : TPFNGLBEGINCONDITIONALRENDERPROC;cvar;external libGLEW;
    __glewBeginTransformFeedback : TPFNGLBEGINTRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewBindFragDataLocation : TPFNGLBINDFRAGDATALOCATIONPROC;cvar;external libGLEW;
    __glewClampColor : TPFNGLCLAMPCOLORPROC;cvar;external libGLEW;
    __glewClearBufferfi : TPFNGLCLEARBUFFERFIPROC;cvar;external libGLEW;
    __glewClearBufferfv : TPFNGLCLEARBUFFERFVPROC;cvar;external libGLEW;
    __glewClearBufferiv : TPFNGLCLEARBUFFERIVPROC;cvar;external libGLEW;
    __glewClearBufferuiv : TPFNGLCLEARBUFFERUIVPROC;cvar;external libGLEW;
    __glewColorMaski : TPFNGLCOLORMASKIPROC;cvar;external libGLEW;
    __glewDisablei : TPFNGLDISABLEIPROC;cvar;external libGLEW;
    __glewEnablei : TPFNGLENABLEIPROC;cvar;external libGLEW;
    __glewEndConditionalRender : TPFNGLENDCONDITIONALRENDERPROC;cvar;external libGLEW;
    __glewEndTransformFeedback : TPFNGLENDTRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewGetBooleani_v : TPFNGLGETBOOLEANI_VPROC;cvar;external libGLEW;
    __glewGetFragDataLocation : TPFNGLGETFRAGDATALOCATIONPROC;cvar;external libGLEW;
    __glewGetStringi : TPFNGLGETSTRINGIPROC;cvar;external libGLEW;
    __glewGetTexParameterIiv : TPFNGLGETTEXPARAMETERIIVPROC;cvar;external libGLEW;
    __glewGetTexParameterIuiv : TPFNGLGETTEXPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewGetTransformFeedbackVarying : TPFNGLGETTRANSFORMFEEDBACKVARYINGPROC;cvar;external libGLEW;
    __glewGetUniformuiv : TPFNGLGETUNIFORMUIVPROC;cvar;external libGLEW;
    __glewGetVertexAttribIiv : TPFNGLGETVERTEXATTRIBIIVPROC;cvar;external libGLEW;
    __glewGetVertexAttribIuiv : TPFNGLGETVERTEXATTRIBIUIVPROC;cvar;external libGLEW;
    __glewIsEnabledi : TPFNGLISENABLEDIPROC;cvar;external libGLEW;
    __glewTexParameterIiv : TPFNGLTEXPARAMETERIIVPROC;cvar;external libGLEW;
    __glewTexParameterIuiv : TPFNGLTEXPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewTransformFeedbackVaryings : TPFNGLTRANSFORMFEEDBACKVARYINGSPROC;cvar;external libGLEW;
    __glewUniform1ui : TPFNGLUNIFORM1UIPROC;cvar;external libGLEW;
    __glewUniform1uiv : TPFNGLUNIFORM1UIVPROC;cvar;external libGLEW;
    __glewUniform2ui : TPFNGLUNIFORM2UIPROC;cvar;external libGLEW;
    __glewUniform2uiv : TPFNGLUNIFORM2UIVPROC;cvar;external libGLEW;
    __glewUniform3ui : TPFNGLUNIFORM3UIPROC;cvar;external libGLEW;
    __glewUniform3uiv : TPFNGLUNIFORM3UIVPROC;cvar;external libGLEW;
    __glewUniform4ui : TPFNGLUNIFORM4UIPROC;cvar;external libGLEW;
    __glewUniform4uiv : TPFNGLUNIFORM4UIVPROC;cvar;external libGLEW;
    __glewVertexAttribI1i : TPFNGLVERTEXATTRIBI1IPROC;cvar;external libGLEW;
    __glewVertexAttribI1iv : TPFNGLVERTEXATTRIBI1IVPROC;cvar;external libGLEW;
    __glewVertexAttribI1ui : TPFNGLVERTEXATTRIBI1UIPROC;cvar;external libGLEW;
    __glewVertexAttribI1uiv : TPFNGLVERTEXATTRIBI1UIVPROC;cvar;external libGLEW;
    __glewVertexAttribI2i : TPFNGLVERTEXATTRIBI2IPROC;cvar;external libGLEW;
    __glewVertexAttribI2iv : TPFNGLVERTEXATTRIBI2IVPROC;cvar;external libGLEW;
    __glewVertexAttribI2ui : TPFNGLVERTEXATTRIBI2UIPROC;cvar;external libGLEW;
    __glewVertexAttribI2uiv : TPFNGLVERTEXATTRIBI2UIVPROC;cvar;external libGLEW;
    __glewVertexAttribI3i : TPFNGLVERTEXATTRIBI3IPROC;cvar;external libGLEW;
    __glewVertexAttribI3iv : TPFNGLVERTEXATTRIBI3IVPROC;cvar;external libGLEW;
    __glewVertexAttribI3ui : TPFNGLVERTEXATTRIBI3UIPROC;cvar;external libGLEW;
    __glewVertexAttribI3uiv : TPFNGLVERTEXATTRIBI3UIVPROC;cvar;external libGLEW;
    __glewVertexAttribI4bv : TPFNGLVERTEXATTRIBI4BVPROC;cvar;external libGLEW;
    __glewVertexAttribI4i : TPFNGLVERTEXATTRIBI4IPROC;cvar;external libGLEW;
    __glewVertexAttribI4iv : TPFNGLVERTEXATTRIBI4IVPROC;cvar;external libGLEW;
    __glewVertexAttribI4sv : TPFNGLVERTEXATTRIBI4SVPROC;cvar;external libGLEW;
    __glewVertexAttribI4ubv : TPFNGLVERTEXATTRIBI4UBVPROC;cvar;external libGLEW;
    __glewVertexAttribI4ui : TPFNGLVERTEXATTRIBI4UIPROC;cvar;external libGLEW;
    __glewVertexAttribI4uiv : TPFNGLVERTEXATTRIBI4UIVPROC;cvar;external libGLEW;
    __glewVertexAttribI4usv : TPFNGLVERTEXATTRIBI4USVPROC;cvar;external libGLEW;
    __glewVertexAttribIPointer : TPFNGLVERTEXATTRIBIPOINTERPROC;cvar;external libGLEW;
    __glewDrawArraysInstanced : TPFNGLDRAWARRAYSINSTANCEDPROC;cvar;external libGLEW;
    __glewDrawElementsInstanced : TPFNGLDRAWELEMENTSINSTANCEDPROC;cvar;external libGLEW;
    __glewPrimitiveRestartIndex : TPFNGLPRIMITIVERESTARTINDEXPROC;cvar;external libGLEW;
    __glewTexBuffer : TPFNGLTEXBUFFERPROC;cvar;external libGLEW;
    __glewFramebufferTexture : TPFNGLFRAMEBUFFERTEXTUREPROC;cvar;external libGLEW;
    __glewGetBufferParameteri64v : TPFNGLGETBUFFERPARAMETERI64VPROC;cvar;external libGLEW;
    __glewGetInteger64i_v : TPFNGLGETINTEGER64I_VPROC;cvar;external libGLEW;
    __glewVertexAttribDivisor : TPFNGLVERTEXATTRIBDIVISORPROC;cvar;external libGLEW;
    __glewBlendEquationSeparatei : TPFNGLBLENDEQUATIONSEPARATEIPROC;cvar;external libGLEW;
    __glewBlendEquationi : TPFNGLBLENDEQUATIONIPROC;cvar;external libGLEW;
    __glewBlendFuncSeparatei : TPFNGLBLENDFUNCSEPARATEIPROC;cvar;external libGLEW;
    __glewBlendFunci : TPFNGLBLENDFUNCIPROC;cvar;external libGLEW;
    __glewMinSampleShading : TPFNGLMINSAMPLESHADINGPROC;cvar;external libGLEW;
    __glewGetGraphicsResetStatus : TPFNGLGETGRAPHICSRESETSTATUSPROC;cvar;external libGLEW;
    __glewGetnCompressedTexImage : TPFNGLGETNCOMPRESSEDTEXIMAGEPROC;cvar;external libGLEW;
    __glewGetnTexImage : TPFNGLGETNTEXIMAGEPROC;cvar;external libGLEW;
    __glewGetnUniformdv : TPFNGLGETNUNIFORMDVPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectCount : TPFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectCount : TPFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC;cvar;external libGLEW;
    __glewSpecializeShader : TPFNGLSPECIALIZESHADERPROC;cvar;external libGLEW;
    __glewTbufferMask3DFX : TPFNGLTBUFFERMASK3DFXPROC;cvar;external libGLEW;
    __glewDebugMessageCallbackAMD : TPFNGLDEBUGMESSAGECALLBACKAMDPROC;cvar;external libGLEW;
    __glewDebugMessageEnableAMD : TPFNGLDEBUGMESSAGEENABLEAMDPROC;cvar;external libGLEW;
    __glewDebugMessageInsertAMD : TPFNGLDEBUGMESSAGEINSERTAMDPROC;cvar;external libGLEW;
    __glewGetDebugMessageLogAMD : TPFNGLGETDEBUGMESSAGELOGAMDPROC;cvar;external libGLEW;
    __glewBlendEquationIndexedAMD : TPFNGLBLENDEQUATIONINDEXEDAMDPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateIndexedAMD : TPFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC;cvar;external libGLEW;
    __glewBlendFuncIndexedAMD : TPFNGLBLENDFUNCINDEXEDAMDPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateIndexedAMD : TPFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorageMultisampleAdvancedAMD : TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleAdvancedAMD : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC;cvar;external libGLEW;
    __glewFramebufferSamplePositionsfvAMD : TPFNGLFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC;cvar;external libGLEW;
    __glewGetFramebufferParameterfvAMD : TPFNGLGETFRAMEBUFFERPARAMETERFVAMDPROC;cvar;external libGLEW;
    __glewGetNamedFramebufferParameterfvAMD : TPFNGLGETNAMEDFRAMEBUFFERPARAMETERFVAMDPROC;cvar;external libGLEW;
    __glewNamedFramebufferSamplePositionsfvAMD : TPFNGLNAMEDFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC;cvar;external libGLEW;
    __glewVertexAttribParameteriAMD : TPFNGLVERTEXATTRIBPARAMETERIAMDPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectAMD : TPFNGLMULTIDRAWARRAYSINDIRECTAMDPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectAMD : TPFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC;cvar;external libGLEW;
    __glewDeleteNamesAMD : TPFNGLDELETENAMESAMDPROC;cvar;external libGLEW;
    __glewGenNamesAMD : TPFNGLGENNAMESAMDPROC;cvar;external libGLEW;
    __glewIsNameAMD : TPFNGLISNAMEAMDPROC;cvar;external libGLEW;
    __glewQueryObjectParameteruiAMD : TPFNGLQUERYOBJECTPARAMETERUIAMDPROC;cvar;external libGLEW;
    __glewBeginPerfMonitorAMD : TPFNGLBEGINPERFMONITORAMDPROC;cvar;external libGLEW;
    __glewDeletePerfMonitorsAMD : TPFNGLDELETEPERFMONITORSAMDPROC;cvar;external libGLEW;
    __glewEndPerfMonitorAMD : TPFNGLENDPERFMONITORAMDPROC;cvar;external libGLEW;
    __glewGenPerfMonitorsAMD : TPFNGLGENPERFMONITORSAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorCounterDataAMD : TPFNGLGETPERFMONITORCOUNTERDATAAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorCounterInfoAMD : TPFNGLGETPERFMONITORCOUNTERINFOAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorCounterStringAMD : TPFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorCountersAMD : TPFNGLGETPERFMONITORCOUNTERSAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorGroupStringAMD : TPFNGLGETPERFMONITORGROUPSTRINGAMDPROC;cvar;external libGLEW;
    __glewGetPerfMonitorGroupsAMD : TPFNGLGETPERFMONITORGROUPSAMDPROC;cvar;external libGLEW;
    __glewSelectPerfMonitorCountersAMD : TPFNGLSELECTPERFMONITORCOUNTERSAMDPROC;cvar;external libGLEW;
    __glewSetMultisamplefvAMD : TPFNGLSETMULTISAMPLEFVAMDPROC;cvar;external libGLEW;
    __glewTexStorageSparseAMD : TPFNGLTEXSTORAGESPARSEAMDPROC;cvar;external libGLEW;
    __glewTextureStorageSparseAMD : TPFNGLTEXTURESTORAGESPARSEAMDPROC;cvar;external libGLEW;
    __glewStencilOpValueAMD : TPFNGLSTENCILOPVALUEAMDPROC;cvar;external libGLEW;
    __glewTessellationFactorAMD : TPFNGLTESSELLATIONFACTORAMDPROC;cvar;external libGLEW;
    __glewTessellationModeAMD : TPFNGLTESSELLATIONMODEAMDPROC;cvar;external libGLEW;
    __glewBlitFramebufferANGLE : TPFNGLBLITFRAMEBUFFERANGLEPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleANGLE : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEANGLEPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedANGLE : TPFNGLDRAWARRAYSINSTANCEDANGLEPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedANGLE : TPFNGLDRAWELEMENTSINSTANCEDANGLEPROC;cvar;external libGLEW;
    __glewVertexAttribDivisorANGLE : TPFNGLVERTEXATTRIBDIVISORANGLEPROC;cvar;external libGLEW;
    __glewBeginQueryANGLE : TPFNGLBEGINQUERYANGLEPROC;cvar;external libGLEW;
    __glewDeleteQueriesANGLE : TPFNGLDELETEQUERIESANGLEPROC;cvar;external libGLEW;
    __glewEndQueryANGLE : TPFNGLENDQUERYANGLEPROC;cvar;external libGLEW;
    __glewGenQueriesANGLE : TPFNGLGENQUERIESANGLEPROC;cvar;external libGLEW;
    __glewGetQueryObjecti64vANGLE : TPFNGLGETQUERYOBJECTI64VANGLEPROC;cvar;external libGLEW;
    __glewGetQueryObjectivANGLE : TPFNGLGETQUERYOBJECTIVANGLEPROC;cvar;external libGLEW;
    __glewGetQueryObjectui64vANGLE : TPFNGLGETQUERYOBJECTUI64VANGLEPROC;cvar;external libGLEW;
    __glewGetQueryObjectuivANGLE : TPFNGLGETQUERYOBJECTUIVANGLEPROC;cvar;external libGLEW;
    __glewGetQueryivANGLE : TPFNGLGETQUERYIVANGLEPROC;cvar;external libGLEW;
    __glewIsQueryANGLE : TPFNGLISQUERYANGLEPROC;cvar;external libGLEW;
    __glewQueryCounterANGLE : TPFNGLQUERYCOUNTERANGLEPROC;cvar;external libGLEW;
    __glewGetTranslatedShaderSourceANGLE : TPFNGLGETTRANSLATEDSHADERSOURCEANGLEPROC;cvar;external libGLEW;
    __glewCopyTextureLevelsAPPLE : TPFNGLCOPYTEXTURELEVELSAPPLEPROC;cvar;external libGLEW;
    __glewDrawElementArrayAPPLE : TPFNGLDRAWELEMENTARRAYAPPLEPROC;cvar;external libGLEW;
    __glewDrawRangeElementArrayAPPLE : TPFNGLDRAWRANGEELEMENTARRAYAPPLEPROC;cvar;external libGLEW;
    __glewElementPointerAPPLE : TPFNGLELEMENTPOINTERAPPLEPROC;cvar;external libGLEW;
    __glewMultiDrawElementArrayAPPLE : TPFNGLMULTIDRAWELEMENTARRAYAPPLEPROC;cvar;external libGLEW;
    __glewMultiDrawRangeElementArrayAPPLE : TPFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC;cvar;external libGLEW;
    __glewDeleteFencesAPPLE : TPFNGLDELETEFENCESAPPLEPROC;cvar;external libGLEW;
    __glewFinishFenceAPPLE : TPFNGLFINISHFENCEAPPLEPROC;cvar;external libGLEW;
    __glewFinishObjectAPPLE : TPFNGLFINISHOBJECTAPPLEPROC;cvar;external libGLEW;
    __glewGenFencesAPPLE : TPFNGLGENFENCESAPPLEPROC;cvar;external libGLEW;
    __glewIsFenceAPPLE : TPFNGLISFENCEAPPLEPROC;cvar;external libGLEW;
    __glewSetFenceAPPLE : TPFNGLSETFENCEAPPLEPROC;cvar;external libGLEW;
    __glewTestFenceAPPLE : TPFNGLTESTFENCEAPPLEPROC;cvar;external libGLEW;
    __glewTestObjectAPPLE : TPFNGLTESTOBJECTAPPLEPROC;cvar;external libGLEW;
    __glewBufferParameteriAPPLE : TPFNGLBUFFERPARAMETERIAPPLEPROC;cvar;external libGLEW;
    __glewFlushMappedBufferRangeAPPLE : TPFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleAPPLE : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEAPPLEPROC;cvar;external libGLEW;
    __glewResolveMultisampleFramebufferAPPLE : TPFNGLRESOLVEMULTISAMPLEFRAMEBUFFERAPPLEPROC;cvar;external libGLEW;
    __glewGetObjectParameterivAPPLE : TPFNGLGETOBJECTPARAMETERIVAPPLEPROC;cvar;external libGLEW;
    __glewObjectPurgeableAPPLE : TPFNGLOBJECTPURGEABLEAPPLEPROC;cvar;external libGLEW;
    __glewObjectUnpurgeableAPPLE : TPFNGLOBJECTUNPURGEABLEAPPLEPROC;cvar;external libGLEW;
    __glewClientWaitSyncAPPLE : TPFNGLCLIENTWAITSYNCAPPLEPROC;cvar;external libGLEW;
    __glewDeleteSyncAPPLE : TPFNGLDELETESYNCAPPLEPROC;cvar;external libGLEW;
    __glewFenceSyncAPPLE : TPFNGLFENCESYNCAPPLEPROC;cvar;external libGLEW;
    __glewGetInteger64vAPPLE : TPFNGLGETINTEGER64VAPPLEPROC;cvar;external libGLEW;
    __glewGetSyncivAPPLE : TPFNGLGETSYNCIVAPPLEPROC;cvar;external libGLEW;
    __glewIsSyncAPPLE : TPFNGLISSYNCAPPLEPROC;cvar;external libGLEW;
    __glewWaitSyncAPPLE : TPFNGLWAITSYNCAPPLEPROC;cvar;external libGLEW;
    __glewGetTexParameterPointervAPPLE : TPFNGLGETTEXPARAMETERPOINTERVAPPLEPROC;cvar;external libGLEW;
    __glewTextureRangeAPPLE : TPFNGLTEXTURERANGEAPPLEPROC;cvar;external libGLEW;
    __glewBindVertexArrayAPPLE : TPFNGLBINDVERTEXARRAYAPPLEPROC;cvar;external libGLEW;
    __glewDeleteVertexArraysAPPLE : TPFNGLDELETEVERTEXARRAYSAPPLEPROC;cvar;external libGLEW;
    __glewGenVertexArraysAPPLE : TPFNGLGENVERTEXARRAYSAPPLEPROC;cvar;external libGLEW;
    __glewIsVertexArrayAPPLE : TPFNGLISVERTEXARRAYAPPLEPROC;cvar;external libGLEW;
    __glewFlushVertexArrayRangeAPPLE : TPFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC;cvar;external libGLEW;
    __glewVertexArrayParameteriAPPLE : TPFNGLVERTEXARRAYPARAMETERIAPPLEPROC;cvar;external libGLEW;
    __glewVertexArrayRangeAPPLE : TPFNGLVERTEXARRAYRANGEAPPLEPROC;cvar;external libGLEW;
    __glewDisableVertexAttribAPPLE : TPFNGLDISABLEVERTEXATTRIBAPPLEPROC;cvar;external libGLEW;
    __glewEnableVertexAttribAPPLE : TPFNGLENABLEVERTEXATTRIBAPPLEPROC;cvar;external libGLEW;
    __glewIsVertexAttribEnabledAPPLE : TPFNGLISVERTEXATTRIBENABLEDAPPLEPROC;cvar;external libGLEW;
    __glewMapVertexAttrib1dAPPLE : TPFNGLMAPVERTEXATTRIB1DAPPLEPROC;cvar;external libGLEW;
    __glewMapVertexAttrib1fAPPLE : TPFNGLMAPVERTEXATTRIB1FAPPLEPROC;cvar;external libGLEW;
    __glewMapVertexAttrib2dAPPLE : TPFNGLMAPVERTEXATTRIB2DAPPLEPROC;cvar;external libGLEW;
    __glewMapVertexAttrib2fAPPLE : TPFNGLMAPVERTEXATTRIB2FAPPLEPROC;cvar;external libGLEW;
    __glewClearDepthf : TPFNGLCLEARDEPTHFPROC;cvar;external libGLEW;
    __glewDepthRangef : TPFNGLDEPTHRANGEFPROC;cvar;external libGLEW;
    __glewGetShaderPrecisionFormat : TPFNGLGETSHADERPRECISIONFORMATPROC;cvar;external libGLEW;
    __glewReleaseShaderCompiler : TPFNGLRELEASESHADERCOMPILERPROC;cvar;external libGLEW;
    __glewShaderBinary : TPFNGLSHADERBINARYPROC;cvar;external libGLEW;
    __glewMemoryBarrierByRegion : TPFNGLMEMORYBARRIERBYREGIONPROC;cvar;external libGLEW;
    __glewPrimitiveBoundingBoxARB : TPFNGLPRIMITIVEBOUNDINGBOXARBPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedBaseInstance : TPFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseInstance : TPFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseVertexBaseInstance : TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC;cvar;external libGLEW;
    __glewGetImageHandleARB : TPFNGLGETIMAGEHANDLEARBPROC;cvar;external libGLEW;
    __glewGetTextureHandleARB : TPFNGLGETTEXTUREHANDLEARBPROC;cvar;external libGLEW;
    __glewGetTextureSamplerHandleARB : TPFNGLGETTEXTURESAMPLERHANDLEARBPROC;cvar;external libGLEW;
    __glewGetVertexAttribLui64vARB : TPFNGLGETVERTEXATTRIBLUI64VARBPROC;cvar;external libGLEW;
    __glewIsImageHandleResidentARB : TPFNGLISIMAGEHANDLERESIDENTARBPROC;cvar;external libGLEW;
    __glewIsTextureHandleResidentARB : TPFNGLISTEXTUREHANDLERESIDENTARBPROC;cvar;external libGLEW;
    __glewMakeImageHandleNonResidentARB : TPFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC;cvar;external libGLEW;
    __glewMakeImageHandleResidentARB : TPFNGLMAKEIMAGEHANDLERESIDENTARBPROC;cvar;external libGLEW;
    __glewMakeTextureHandleNonResidentARB : TPFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC;cvar;external libGLEW;
    __glewMakeTextureHandleResidentARB : TPFNGLMAKETEXTUREHANDLERESIDENTARBPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64ARB : TPFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64vARB : TPFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC;cvar;external libGLEW;
    __glewUniformHandleui64ARB : TPFNGLUNIFORMHANDLEUI64ARBPROC;cvar;external libGLEW;
    __glewUniformHandleui64vARB : TPFNGLUNIFORMHANDLEUI64VARBPROC;cvar;external libGLEW;
    __glewVertexAttribL1ui64ARB : TPFNGLVERTEXATTRIBL1UI64ARBPROC;cvar;external libGLEW;
    __glewVertexAttribL1ui64vARB : TPFNGLVERTEXATTRIBL1UI64VARBPROC;cvar;external libGLEW;
    __glewBindFragDataLocationIndexed : TPFNGLBINDFRAGDATALOCATIONINDEXEDPROC;cvar;external libGLEW;
    __glewGetFragDataIndex : TPFNGLGETFRAGDATAINDEXPROC;cvar;external libGLEW;
    __glewBufferStorage : TPFNGLBUFFERSTORAGEPROC;cvar;external libGLEW;
    __glewCreateSyncFromCLeventARB : TPFNGLCREATESYNCFROMCLEVENTARBPROC;cvar;external libGLEW;
    __glewClearBufferData : TPFNGLCLEARBUFFERDATAPROC;cvar;external libGLEW;
    __glewClearBufferSubData : TPFNGLCLEARBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewClearNamedBufferDataEXT : TPFNGLCLEARNAMEDBUFFERDATAEXTPROC;cvar;external libGLEW;
    __glewClearNamedBufferSubDataEXT : TPFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC;cvar;external libGLEW;
    __glewClearTexImage : TPFNGLCLEARTEXIMAGEPROC;cvar;external libGLEW;
    __glewClearTexSubImage : TPFNGLCLEARTEXSUBIMAGEPROC;cvar;external libGLEW;
    __glewClipControl : TPFNGLCLIPCONTROLPROC;cvar;external libGLEW;
    __glewClampColorARB : TPFNGLCLAMPCOLORARBPROC;cvar;external libGLEW;
    __glewDispatchCompute : TPFNGLDISPATCHCOMPUTEPROC;cvar;external libGLEW;
    __glewDispatchComputeIndirect : TPFNGLDISPATCHCOMPUTEINDIRECTPROC;cvar;external libGLEW;
    __glewDispatchComputeGroupSizeARB : TPFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC;cvar;external libGLEW;
    __glewCopyBufferSubData : TPFNGLCOPYBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewCopyImageSubData : TPFNGLCOPYIMAGESUBDATAPROC;cvar;external libGLEW;
    __glewDebugMessageCallbackARB : TPFNGLDEBUGMESSAGECALLBACKARBPROC;cvar;external libGLEW;
    __glewDebugMessageControlARB : TPFNGLDEBUGMESSAGECONTROLARBPROC;cvar;external libGLEW;
    __glewDebugMessageInsertARB : TPFNGLDEBUGMESSAGEINSERTARBPROC;cvar;external libGLEW;
    __glewGetDebugMessageLogARB : TPFNGLGETDEBUGMESSAGELOGARBPROC;cvar;external libGLEW;
    __glewBindTextureUnit : TPFNGLBINDTEXTUREUNITPROC;cvar;external libGLEW;
    __glewBlitNamedFramebuffer : TPFNGLBLITNAMEDFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewCheckNamedFramebufferStatus : TPFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC;cvar;external libGLEW;
    __glewClearNamedBufferData : TPFNGLCLEARNAMEDBUFFERDATAPROC;cvar;external libGLEW;
    __glewClearNamedBufferSubData : TPFNGLCLEARNAMEDBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewClearNamedFramebufferfi : TPFNGLCLEARNAMEDFRAMEBUFFERFIPROC;cvar;external libGLEW;
    __glewClearNamedFramebufferfv : TPFNGLCLEARNAMEDFRAMEBUFFERFVPROC;cvar;external libGLEW;
    __glewClearNamedFramebufferiv : TPFNGLCLEARNAMEDFRAMEBUFFERIVPROC;cvar;external libGLEW;
    __glewClearNamedFramebufferuiv : TPFNGLCLEARNAMEDFRAMEBUFFERUIVPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage1D : TPFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage2D : TPFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage3D : TPFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC;cvar;external libGLEW;
    __glewCopyNamedBufferSubData : TPFNGLCOPYNAMEDBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage1D : TPFNGLCOPYTEXTURESUBIMAGE1DPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage2D : TPFNGLCOPYTEXTURESUBIMAGE2DPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage3D : TPFNGLCOPYTEXTURESUBIMAGE3DPROC;cvar;external libGLEW;
    __glewCreateBuffers : TPFNGLCREATEBUFFERSPROC;cvar;external libGLEW;
    __glewCreateFramebuffers : TPFNGLCREATEFRAMEBUFFERSPROC;cvar;external libGLEW;
    __glewCreateProgramPipelines : TPFNGLCREATEPROGRAMPIPELINESPROC;cvar;external libGLEW;
    __glewCreateQueries : TPFNGLCREATEQUERIESPROC;cvar;external libGLEW;
    __glewCreateRenderbuffers : TPFNGLCREATERENDERBUFFERSPROC;cvar;external libGLEW;
    __glewCreateSamplers : TPFNGLCREATESAMPLERSPROC;cvar;external libGLEW;
    __glewCreateTextures : TPFNGLCREATETEXTURESPROC;cvar;external libGLEW;
    __glewCreateTransformFeedbacks : TPFNGLCREATETRANSFORMFEEDBACKSPROC;cvar;external libGLEW;
    __glewCreateVertexArrays : TPFNGLCREATEVERTEXARRAYSPROC;cvar;external libGLEW;
    __glewDisableVertexArrayAttrib : TPFNGLDISABLEVERTEXARRAYATTRIBPROC;cvar;external libGLEW;
    __glewEnableVertexArrayAttrib : TPFNGLENABLEVERTEXARRAYATTRIBPROC;cvar;external libGLEW;
    __glewFlushMappedNamedBufferRange : TPFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC;cvar;external libGLEW;
    __glewGenerateTextureMipmap : TPFNGLGENERATETEXTUREMIPMAPPROC;cvar;external libGLEW;
    __glewGetCompressedTextureImage : TPFNGLGETCOMPRESSEDTEXTUREIMAGEPROC;cvar;external libGLEW;
    __glewGetNamedBufferParameteri64v : TPFNGLGETNAMEDBUFFERPARAMETERI64VPROC;cvar;external libGLEW;
    __glewGetNamedBufferParameteriv : TPFNGLGETNAMEDBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetNamedBufferPointerv : TPFNGLGETNAMEDBUFFERPOINTERVPROC;cvar;external libGLEW;
    __glewGetNamedBufferSubData : TPFNGLGETNAMEDBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewGetNamedFramebufferAttachmentParameteriv : TPFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetNamedFramebufferParameteriv : TPFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetNamedRenderbufferParameteriv : TPFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetQueryBufferObjecti64v : TPFNGLGETQUERYBUFFEROBJECTI64VPROC;cvar;external libGLEW;
    __glewGetQueryBufferObjectiv : TPFNGLGETQUERYBUFFEROBJECTIVPROC;cvar;external libGLEW;
    __glewGetQueryBufferObjectui64v : TPFNGLGETQUERYBUFFEROBJECTUI64VPROC;cvar;external libGLEW;
    __glewGetQueryBufferObjectuiv : TPFNGLGETQUERYBUFFEROBJECTUIVPROC;cvar;external libGLEW;
    __glewGetTextureImage : TPFNGLGETTEXTUREIMAGEPROC;cvar;external libGLEW;
    __glewGetTextureLevelParameterfv : TPFNGLGETTEXTURELEVELPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetTextureLevelParameteriv : TPFNGLGETTEXTURELEVELPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetTextureParameterIiv : TPFNGLGETTEXTUREPARAMETERIIVPROC;cvar;external libGLEW;
    __glewGetTextureParameterIuiv : TPFNGLGETTEXTUREPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewGetTextureParameterfv : TPFNGLGETTEXTUREPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetTextureParameteriv : TPFNGLGETTEXTUREPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetTransformFeedbacki64_v : TPFNGLGETTRANSFORMFEEDBACKI64_VPROC;cvar;external libGLEW;
    __glewGetTransformFeedbacki_v : TPFNGLGETTRANSFORMFEEDBACKI_VPROC;cvar;external libGLEW;
    __glewGetTransformFeedbackiv : TPFNGLGETTRANSFORMFEEDBACKIVPROC;cvar;external libGLEW;
    __glewGetVertexArrayIndexed64iv : TPFNGLGETVERTEXARRAYINDEXED64IVPROC;cvar;external libGLEW;
    __glewGetVertexArrayIndexediv : TPFNGLGETVERTEXARRAYINDEXEDIVPROC;cvar;external libGLEW;
    __glewGetVertexArrayiv : TPFNGLGETVERTEXARRAYIVPROC;cvar;external libGLEW;
    __glewInvalidateNamedFramebufferData : TPFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC;cvar;external libGLEW;
    __glewInvalidateNamedFramebufferSubData : TPFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewMapNamedBuffer : TPFNGLMAPNAMEDBUFFERPROC;cvar;external libGLEW;
    __glewMapNamedBufferRange : TPFNGLMAPNAMEDBUFFERRANGEPROC;cvar;external libGLEW;
    __glewNamedBufferData : TPFNGLNAMEDBUFFERDATAPROC;cvar;external libGLEW;
    __glewNamedBufferStorage : TPFNGLNAMEDBUFFERSTORAGEPROC;cvar;external libGLEW;
    __glewNamedBufferSubData : TPFNGLNAMEDBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewNamedFramebufferDrawBuffer : TPFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC;cvar;external libGLEW;
    __glewNamedFramebufferDrawBuffers : TPFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC;cvar;external libGLEW;
    __glewNamedFramebufferParameteri : TPFNGLNAMEDFRAMEBUFFERPARAMETERIPROC;cvar;external libGLEW;
    __glewNamedFramebufferReadBuffer : TPFNGLNAMEDFRAMEBUFFERREADBUFFERPROC;cvar;external libGLEW;
    __glewNamedFramebufferRenderbuffer : TPFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC;cvar;external libGLEW;
    __glewNamedFramebufferTexture : TPFNGLNAMEDFRAMEBUFFERTEXTUREPROC;cvar;external libGLEW;
    __glewNamedFramebufferTextureLayer : TPFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorage : TPFNGLNAMEDRENDERBUFFERSTORAGEPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorageMultisample : TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTextureBuffer : TPFNGLTEXTUREBUFFERPROC;cvar;external libGLEW;
    __glewTextureBufferRange : TPFNGLTEXTUREBUFFERRANGEPROC;cvar;external libGLEW;
    __glewTextureParameterIiv : TPFNGLTEXTUREPARAMETERIIVPROC;cvar;external libGLEW;
    __glewTextureParameterIuiv : TPFNGLTEXTUREPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewTextureParameterf : TPFNGLTEXTUREPARAMETERFPROC;cvar;external libGLEW;
    __glewTextureParameterfv : TPFNGLTEXTUREPARAMETERFVPROC;cvar;external libGLEW;
    __glewTextureParameteri : TPFNGLTEXTUREPARAMETERIPROC;cvar;external libGLEW;
    __glewTextureParameteriv : TPFNGLTEXTUREPARAMETERIVPROC;cvar;external libGLEW;
    __glewTextureStorage1D : TPFNGLTEXTURESTORAGE1DPROC;cvar;external libGLEW;
    __glewTextureStorage2D : TPFNGLTEXTURESTORAGE2DPROC;cvar;external libGLEW;
    __glewTextureStorage2DMultisample : TPFNGLTEXTURESTORAGE2DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTextureStorage3D : TPFNGLTEXTURESTORAGE3DPROC;cvar;external libGLEW;
    __glewTextureStorage3DMultisample : TPFNGLTEXTURESTORAGE3DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTextureSubImage1D : TPFNGLTEXTURESUBIMAGE1DPROC;cvar;external libGLEW;
    __glewTextureSubImage2D : TPFNGLTEXTURESUBIMAGE2DPROC;cvar;external libGLEW;
    __glewTextureSubImage3D : TPFNGLTEXTURESUBIMAGE3DPROC;cvar;external libGLEW;
    __glewTransformFeedbackBufferBase : TPFNGLTRANSFORMFEEDBACKBUFFERBASEPROC;cvar;external libGLEW;
    __glewTransformFeedbackBufferRange : TPFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC;cvar;external libGLEW;
    __glewUnmapNamedBuffer : TPFNGLUNMAPNAMEDBUFFERPROC;cvar;external libGLEW;
    __glewVertexArrayAttribBinding : TPFNGLVERTEXARRAYATTRIBBINDINGPROC;cvar;external libGLEW;
    __glewVertexArrayAttribFormat : TPFNGLVERTEXARRAYATTRIBFORMATPROC;cvar;external libGLEW;
    __glewVertexArrayAttribIFormat : TPFNGLVERTEXARRAYATTRIBIFORMATPROC;cvar;external libGLEW;
    __glewVertexArrayAttribLFormat : TPFNGLVERTEXARRAYATTRIBLFORMATPROC;cvar;external libGLEW;
    __glewVertexArrayBindingDivisor : TPFNGLVERTEXARRAYBINDINGDIVISORPROC;cvar;external libGLEW;
    __glewVertexArrayElementBuffer : TPFNGLVERTEXARRAYELEMENTBUFFERPROC;cvar;external libGLEW;
    __glewVertexArrayVertexBuffer : TPFNGLVERTEXARRAYVERTEXBUFFERPROC;cvar;external libGLEW;
    __glewVertexArrayVertexBuffers : TPFNGLVERTEXARRAYVERTEXBUFFERSPROC;cvar;external libGLEW;
    __glewDrawBuffersARB : TPFNGLDRAWBUFFERSARBPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateiARB : TPFNGLBLENDEQUATIONSEPARATEIARBPROC;cvar;external libGLEW;
    __glewBlendEquationiARB : TPFNGLBLENDEQUATIONIARBPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateiARB : TPFNGLBLENDFUNCSEPARATEIARBPROC;cvar;external libGLEW;
    __glewBlendFunciARB : TPFNGLBLENDFUNCIARBPROC;cvar;external libGLEW;
    __glewDrawElementsBaseVertex : TPFNGLDRAWELEMENTSBASEVERTEXPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseVertex : TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC;cvar;external libGLEW;
    __glewDrawRangeElementsBaseVertex : TPFNGLDRAWRANGEELEMENTSBASEVERTEXPROC;cvar;external libGLEW;
    __glewMultiDrawElementsBaseVertex : TPFNGLMULTIDRAWELEMENTSBASEVERTEXPROC;cvar;external libGLEW;
    __glewDrawArraysIndirect : TPFNGLDRAWARRAYSINDIRECTPROC;cvar;external libGLEW;
    __glewDrawElementsIndirect : TPFNGLDRAWELEMENTSINDIRECTPROC;cvar;external libGLEW;
    __glewFramebufferParameteri : TPFNGLFRAMEBUFFERPARAMETERIPROC;cvar;external libGLEW;
    __glewGetFramebufferParameteriv : TPFNGLGETFRAMEBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetNamedFramebufferParameterivEXT : TPFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferParameteriEXT : TPFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewBindFramebuffer : TPFNGLBINDFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewBindRenderbuffer : TPFNGLBINDRENDERBUFFERPROC;cvar;external libGLEW;
    __glewBlitFramebuffer : TPFNGLBLITFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewCheckFramebufferStatus : TPFNGLCHECKFRAMEBUFFERSTATUSPROC;cvar;external libGLEW;
    __glewDeleteFramebuffers : TPFNGLDELETEFRAMEBUFFERSPROC;cvar;external libGLEW;
    __glewDeleteRenderbuffers : TPFNGLDELETERENDERBUFFERSPROC;cvar;external libGLEW;
    __glewFramebufferRenderbuffer : TPFNGLFRAMEBUFFERRENDERBUFFERPROC;cvar;external libGLEW;
    __glewFramebufferTexture1D : TPFNGLFRAMEBUFFERTEXTURE1DPROC;cvar;external libGLEW;
    __glewFramebufferTexture2D : TPFNGLFRAMEBUFFERTEXTURE2DPROC;cvar;external libGLEW;
    __glewFramebufferTexture3D : TPFNGLFRAMEBUFFERTEXTURE3DPROC;cvar;external libGLEW;
    __glewFramebufferTextureLayer : TPFNGLFRAMEBUFFERTEXTURELAYERPROC;cvar;external libGLEW;
    __glewGenFramebuffers : TPFNGLGENFRAMEBUFFERSPROC;cvar;external libGLEW;
    __glewGenRenderbuffers : TPFNGLGENRENDERBUFFERSPROC;cvar;external libGLEW;
    __glewGenerateMipmap : TPFNGLGENERATEMIPMAPPROC;cvar;external libGLEW;
    __glewGetFramebufferAttachmentParameteriv : TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetRenderbufferParameteriv : TPFNGLGETRENDERBUFFERPARAMETERIVPROC;cvar;external libGLEW;
    __glewIsFramebuffer : TPFNGLISFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewIsRenderbuffer : TPFNGLISRENDERBUFFERPROC;cvar;external libGLEW;
    __glewRenderbufferStorage : TPFNGLRENDERBUFFERSTORAGEPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisample : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC;cvar;external libGLEW;
    __glewFramebufferTextureARB : TPFNGLFRAMEBUFFERTEXTUREARBPROC;cvar;external libGLEW;
    __glewFramebufferTextureFaceARB : TPFNGLFRAMEBUFFERTEXTUREFACEARBPROC;cvar;external libGLEW;
    __glewFramebufferTextureLayerARB : TPFNGLFRAMEBUFFERTEXTURELAYERARBPROC;cvar;external libGLEW;
    __glewProgramParameteriARB : TPFNGLPROGRAMPARAMETERIARBPROC;cvar;external libGLEW;
    __glewGetProgramBinary : TPFNGLGETPROGRAMBINARYPROC;cvar;external libGLEW;
    __glewProgramBinary : TPFNGLPROGRAMBINARYPROC;cvar;external libGLEW;
    __glewProgramParameteri : TPFNGLPROGRAMPARAMETERIPROC;cvar;external libGLEW;
    __glewGetCompressedTextureSubImage : TPFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC;cvar;external libGLEW;
    __glewGetTextureSubImage : TPFNGLGETTEXTURESUBIMAGEPROC;cvar;external libGLEW;
    __glewSpecializeShaderARB : TPFNGLSPECIALIZESHADERARBPROC;cvar;external libGLEW;
    __glewGetUniformdv : TPFNGLGETUNIFORMDVPROC;cvar;external libGLEW;
    __glewUniform1d : TPFNGLUNIFORM1DPROC;cvar;external libGLEW;
    __glewUniform1dv : TPFNGLUNIFORM1DVPROC;cvar;external libGLEW;
    __glewUniform2d : TPFNGLUNIFORM2DPROC;cvar;external libGLEW;
    __glewUniform2dv : TPFNGLUNIFORM2DVPROC;cvar;external libGLEW;
    __glewUniform3d : TPFNGLUNIFORM3DPROC;cvar;external libGLEW;
    __glewUniform3dv : TPFNGLUNIFORM3DVPROC;cvar;external libGLEW;
    __glewUniform4d : TPFNGLUNIFORM4DPROC;cvar;external libGLEW;
    __glewUniform4dv : TPFNGLUNIFORM4DVPROC;cvar;external libGLEW;
    __glewUniformMatrix2dv : TPFNGLUNIFORMMATRIX2DVPROC;cvar;external libGLEW;
    __glewUniformMatrix2x3dv : TPFNGLUNIFORMMATRIX2X3DVPROC;cvar;external libGLEW;
    __glewUniformMatrix2x4dv : TPFNGLUNIFORMMATRIX2X4DVPROC;cvar;external libGLEW;
    __glewUniformMatrix3dv : TPFNGLUNIFORMMATRIX3DVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x2dv : TPFNGLUNIFORMMATRIX3X2DVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x4dv : TPFNGLUNIFORMMATRIX3X4DVPROC;cvar;external libGLEW;
    __glewUniformMatrix4dv : TPFNGLUNIFORMMATRIX4DVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x2dv : TPFNGLUNIFORMMATRIX4X2DVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x3dv : TPFNGLUNIFORMMATRIX4X3DVPROC;cvar;external libGLEW;
    __glewGetUniformi64vARB : TPFNGLGETUNIFORMI64VARBPROC;cvar;external libGLEW;
    __glewGetUniformui64vARB : TPFNGLGETUNIFORMUI64VARBPROC;cvar;external libGLEW;
    __glewGetnUniformi64vARB : TPFNGLGETNUNIFORMI64VARBPROC;cvar;external libGLEW;
    __glewGetnUniformui64vARB : TPFNGLGETNUNIFORMUI64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform1i64ARB : TPFNGLPROGRAMUNIFORM1I64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform1i64vARB : TPFNGLPROGRAMUNIFORM1I64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform1ui64ARB : TPFNGLPROGRAMUNIFORM1UI64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform1ui64vARB : TPFNGLPROGRAMUNIFORM1UI64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform2i64ARB : TPFNGLPROGRAMUNIFORM2I64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform2i64vARB : TPFNGLPROGRAMUNIFORM2I64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform2ui64ARB : TPFNGLPROGRAMUNIFORM2UI64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform2ui64vARB : TPFNGLPROGRAMUNIFORM2UI64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform3i64ARB : TPFNGLPROGRAMUNIFORM3I64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform3i64vARB : TPFNGLPROGRAMUNIFORM3I64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform3ui64ARB : TPFNGLPROGRAMUNIFORM3UI64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform3ui64vARB : TPFNGLPROGRAMUNIFORM3UI64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform4i64ARB : TPFNGLPROGRAMUNIFORM4I64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform4i64vARB : TPFNGLPROGRAMUNIFORM4I64VARBPROC;cvar;external libGLEW;
    __glewProgramUniform4ui64ARB : TPFNGLPROGRAMUNIFORM4UI64ARBPROC;cvar;external libGLEW;
    __glewProgramUniform4ui64vARB : TPFNGLPROGRAMUNIFORM4UI64VARBPROC;cvar;external libGLEW;
    __glewUniform1i64ARB : TPFNGLUNIFORM1I64ARBPROC;cvar;external libGLEW;
    __glewUniform1i64vARB : TPFNGLUNIFORM1I64VARBPROC;cvar;external libGLEW;
    __glewUniform1ui64ARB : TPFNGLUNIFORM1UI64ARBPROC;cvar;external libGLEW;
    __glewUniform1ui64vARB : TPFNGLUNIFORM1UI64VARBPROC;cvar;external libGLEW;
    __glewUniform2i64ARB : TPFNGLUNIFORM2I64ARBPROC;cvar;external libGLEW;
    __glewUniform2i64vARB : TPFNGLUNIFORM2I64VARBPROC;cvar;external libGLEW;
    __glewUniform2ui64ARB : TPFNGLUNIFORM2UI64ARBPROC;cvar;external libGLEW;
    __glewUniform2ui64vARB : TPFNGLUNIFORM2UI64VARBPROC;cvar;external libGLEW;
    __glewUniform3i64ARB : TPFNGLUNIFORM3I64ARBPROC;cvar;external libGLEW;
    __glewUniform3i64vARB : TPFNGLUNIFORM3I64VARBPROC;cvar;external libGLEW;
    __glewUniform3ui64ARB : TPFNGLUNIFORM3UI64ARBPROC;cvar;external libGLEW;
    __glewUniform3ui64vARB : TPFNGLUNIFORM3UI64VARBPROC;cvar;external libGLEW;
    __glewUniform4i64ARB : TPFNGLUNIFORM4I64ARBPROC;cvar;external libGLEW;
    __glewUniform4i64vARB : TPFNGLUNIFORM4I64VARBPROC;cvar;external libGLEW;
    __glewUniform4ui64ARB : TPFNGLUNIFORM4UI64ARBPROC;cvar;external libGLEW;
    __glewUniform4ui64vARB : TPFNGLUNIFORM4UI64VARBPROC;cvar;external libGLEW;
    __glewColorSubTable : TPFNGLCOLORSUBTABLEPROC;cvar;external libGLEW;
    __glewColorTable : TPFNGLCOLORTABLEPROC;cvar;external libGLEW;
    __glewColorTableParameterfv : TPFNGLCOLORTABLEPARAMETERFVPROC;cvar;external libGLEW;
    __glewColorTableParameteriv : TPFNGLCOLORTABLEPARAMETERIVPROC;cvar;external libGLEW;
    __glewConvolutionFilter1D : TPFNGLCONVOLUTIONFILTER1DPROC;cvar;external libGLEW;
    __glewConvolutionFilter2D : TPFNGLCONVOLUTIONFILTER2DPROC;cvar;external libGLEW;
    __glewConvolutionParameterf : TPFNGLCONVOLUTIONPARAMETERFPROC;cvar;external libGLEW;
    __glewConvolutionParameterfv : TPFNGLCONVOLUTIONPARAMETERFVPROC;cvar;external libGLEW;
    __glewConvolutionParameteri : TPFNGLCONVOLUTIONPARAMETERIPROC;cvar;external libGLEW;
    __glewConvolutionParameteriv : TPFNGLCONVOLUTIONPARAMETERIVPROC;cvar;external libGLEW;
    __glewCopyColorSubTable : TPFNGLCOPYCOLORSUBTABLEPROC;cvar;external libGLEW;
    __glewCopyColorTable : TPFNGLCOPYCOLORTABLEPROC;cvar;external libGLEW;
    __glewCopyConvolutionFilter1D : TPFNGLCOPYCONVOLUTIONFILTER1DPROC;cvar;external libGLEW;
    __glewCopyConvolutionFilter2D : TPFNGLCOPYCONVOLUTIONFILTER2DPROC;cvar;external libGLEW;
    __glewGetColorTable : TPFNGLGETCOLORTABLEPROC;cvar;external libGLEW;
    __glewGetColorTableParameterfv : TPFNGLGETCOLORTABLEPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetColorTableParameteriv : TPFNGLGETCOLORTABLEPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetConvolutionFilter : TPFNGLGETCONVOLUTIONFILTERPROC;cvar;external libGLEW;
    __glewGetConvolutionParameterfv : TPFNGLGETCONVOLUTIONPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetConvolutionParameteriv : TPFNGLGETCONVOLUTIONPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetHistogram : TPFNGLGETHISTOGRAMPROC;cvar;external libGLEW;
    __glewGetHistogramParameterfv : TPFNGLGETHISTOGRAMPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetHistogramParameteriv : TPFNGLGETHISTOGRAMPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetMinmax : TPFNGLGETMINMAXPROC;cvar;external libGLEW;
    __glewGetMinmaxParameterfv : TPFNGLGETMINMAXPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetMinmaxParameteriv : TPFNGLGETMINMAXPARAMETERIVPROC;cvar;external libGLEW;
    __glewGetSeparableFilter : TPFNGLGETSEPARABLEFILTERPROC;cvar;external libGLEW;
    __glewHistogram : TPFNGLHISTOGRAMPROC;cvar;external libGLEW;
    __glewMinmax : TPFNGLMINMAXPROC;cvar;external libGLEW;
    __glewResetHistogram : TPFNGLRESETHISTOGRAMPROC;cvar;external libGLEW;
    __glewResetMinmax : TPFNGLRESETMINMAXPROC;cvar;external libGLEW;
    __glewSeparableFilter2D : TPFNGLSEPARABLEFILTER2DPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectCountARB : TPFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectCountARB : TPFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedARB : TPFNGLDRAWARRAYSINSTANCEDARBPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedARB : TPFNGLDRAWELEMENTSINSTANCEDARBPROC;cvar;external libGLEW;
    __glewVertexAttribDivisorARB : TPFNGLVERTEXATTRIBDIVISORARBPROC;cvar;external libGLEW;
    __glewGetInternalformativ : TPFNGLGETINTERNALFORMATIVPROC;cvar;external libGLEW;
    __glewGetInternalformati64v : TPFNGLGETINTERNALFORMATI64VPROC;cvar;external libGLEW;
    __glewInvalidateBufferData : TPFNGLINVALIDATEBUFFERDATAPROC;cvar;external libGLEW;
    __glewInvalidateBufferSubData : TPFNGLINVALIDATEBUFFERSUBDATAPROC;cvar;external libGLEW;
    __glewInvalidateFramebuffer : TPFNGLINVALIDATEFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewInvalidateSubFramebuffer : TPFNGLINVALIDATESUBFRAMEBUFFERPROC;cvar;external libGLEW;
    __glewInvalidateTexImage : TPFNGLINVALIDATETEXIMAGEPROC;cvar;external libGLEW;
    __glewInvalidateTexSubImage : TPFNGLINVALIDATETEXSUBIMAGEPROC;cvar;external libGLEW;
    __glewFlushMappedBufferRange : TPFNGLFLUSHMAPPEDBUFFERRANGEPROC;cvar;external libGLEW;
    __glewMapBufferRange : TPFNGLMAPBUFFERRANGEPROC;cvar;external libGLEW;
    __glewCurrentPaletteMatrixARB : TPFNGLCURRENTPALETTEMATRIXARBPROC;cvar;external libGLEW;
    __glewMatrixIndexPointerARB : TPFNGLMATRIXINDEXPOINTERARBPROC;cvar;external libGLEW;
    __glewMatrixIndexubvARB : TPFNGLMATRIXINDEXUBVARBPROC;cvar;external libGLEW;
    __glewMatrixIndexuivARB : TPFNGLMATRIXINDEXUIVARBPROC;cvar;external libGLEW;
    __glewMatrixIndexusvARB : TPFNGLMATRIXINDEXUSVARBPROC;cvar;external libGLEW;
    __glewBindBuffersBase : TPFNGLBINDBUFFERSBASEPROC;cvar;external libGLEW;
    __glewBindBuffersRange : TPFNGLBINDBUFFERSRANGEPROC;cvar;external libGLEW;
    __glewBindImageTextures : TPFNGLBINDIMAGETEXTURESPROC;cvar;external libGLEW;
    __glewBindSamplers : TPFNGLBINDSAMPLERSPROC;cvar;external libGLEW;
    __glewBindTextures : TPFNGLBINDTEXTURESPROC;cvar;external libGLEW;
    __glewBindVertexBuffers : TPFNGLBINDVERTEXBUFFERSPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirect : TPFNGLMULTIDRAWARRAYSINDIRECTPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirect : TPFNGLMULTIDRAWELEMENTSINDIRECTPROC;cvar;external libGLEW;
    __glewSampleCoverageARB : TPFNGLSAMPLECOVERAGEARBPROC;cvar;external libGLEW;
    __glewActiveTextureARB : TPFNGLACTIVETEXTUREARBPROC;cvar;external libGLEW;
    __glewClientActiveTextureARB : TPFNGLCLIENTACTIVETEXTUREARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1dARB : TPFNGLMULTITEXCOORD1DARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1dvARB : TPFNGLMULTITEXCOORD1DVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1fARB : TPFNGLMULTITEXCOORD1FARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1fvARB : TPFNGLMULTITEXCOORD1FVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1iARB : TPFNGLMULTITEXCOORD1IARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1ivARB : TPFNGLMULTITEXCOORD1IVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1sARB : TPFNGLMULTITEXCOORD1SARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord1svARB : TPFNGLMULTITEXCOORD1SVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2dARB : TPFNGLMULTITEXCOORD2DARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2dvARB : TPFNGLMULTITEXCOORD2DVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2fARB : TPFNGLMULTITEXCOORD2FARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2fvARB : TPFNGLMULTITEXCOORD2FVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2iARB : TPFNGLMULTITEXCOORD2IARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2ivARB : TPFNGLMULTITEXCOORD2IVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2sARB : TPFNGLMULTITEXCOORD2SARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord2svARB : TPFNGLMULTITEXCOORD2SVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3dARB : TPFNGLMULTITEXCOORD3DARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3dvARB : TPFNGLMULTITEXCOORD3DVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3fARB : TPFNGLMULTITEXCOORD3FARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3fvARB : TPFNGLMULTITEXCOORD3FVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3iARB : TPFNGLMULTITEXCOORD3IARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3ivARB : TPFNGLMULTITEXCOORD3IVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3sARB : TPFNGLMULTITEXCOORD3SARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord3svARB : TPFNGLMULTITEXCOORD3SVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4dARB : TPFNGLMULTITEXCOORD4DARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4dvARB : TPFNGLMULTITEXCOORD4DVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4fARB : TPFNGLMULTITEXCOORD4FARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4fvARB : TPFNGLMULTITEXCOORD4FVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4iARB : TPFNGLMULTITEXCOORD4IARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4ivARB : TPFNGLMULTITEXCOORD4IVARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4sARB : TPFNGLMULTITEXCOORD4SARBPROC;cvar;external libGLEW;
    __glewMultiTexCoord4svARB : TPFNGLMULTITEXCOORD4SVARBPROC;cvar;external libGLEW;
    __glewBeginQueryARB : TPFNGLBEGINQUERYARBPROC;cvar;external libGLEW;
    __glewDeleteQueriesARB : TPFNGLDELETEQUERIESARBPROC;cvar;external libGLEW;
    __glewEndQueryARB : TPFNGLENDQUERYARBPROC;cvar;external libGLEW;
    __glewGenQueriesARB : TPFNGLGENQUERIESARBPROC;cvar;external libGLEW;
    __glewGetQueryObjectivARB : TPFNGLGETQUERYOBJECTIVARBPROC;cvar;external libGLEW;
    __glewGetQueryObjectuivARB : TPFNGLGETQUERYOBJECTUIVARBPROC;cvar;external libGLEW;
    __glewGetQueryivARB : TPFNGLGETQUERYIVARBPROC;cvar;external libGLEW;
    __glewIsQueryARB : TPFNGLISQUERYARBPROC;cvar;external libGLEW;
    __glewMaxShaderCompilerThreadsARB : TPFNGLMAXSHADERCOMPILERTHREADSARBPROC;cvar;external libGLEW;
    __glewPointParameterfARB : TPFNGLPOINTPARAMETERFARBPROC;cvar;external libGLEW;
    __glewPointParameterfvARB : TPFNGLPOINTPARAMETERFVARBPROC;cvar;external libGLEW;
    __glewPolygonOffsetClamp : TPFNGLPOLYGONOFFSETCLAMPPROC;cvar;external libGLEW;
    __glewGetProgramInterfaceiv : TPFNGLGETPROGRAMINTERFACEIVPROC;cvar;external libGLEW;
    __glewGetProgramResourceIndex : TPFNGLGETPROGRAMRESOURCEINDEXPROC;cvar;external libGLEW;
    __glewGetProgramResourceLocation : TPFNGLGETPROGRAMRESOURCELOCATIONPROC;cvar;external libGLEW;
    __glewGetProgramResourceLocationIndex : TPFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC;cvar;external libGLEW;
    __glewGetProgramResourceName : TPFNGLGETPROGRAMRESOURCENAMEPROC;cvar;external libGLEW;
    __glewGetProgramResourceiv : TPFNGLGETPROGRAMRESOURCEIVPROC;cvar;external libGLEW;
    __glewProvokingVertex : TPFNGLPROVOKINGVERTEXPROC;cvar;external libGLEW;
    __glewGetGraphicsResetStatusARB : TPFNGLGETGRAPHICSRESETSTATUSARBPROC;cvar;external libGLEW;
    __glewGetnColorTableARB : TPFNGLGETNCOLORTABLEARBPROC;cvar;external libGLEW;
    __glewGetnCompressedTexImageARB : TPFNGLGETNCOMPRESSEDTEXIMAGEARBPROC;cvar;external libGLEW;
    __glewGetnConvolutionFilterARB : TPFNGLGETNCONVOLUTIONFILTERARBPROC;cvar;external libGLEW;
    __glewGetnHistogramARB : TPFNGLGETNHISTOGRAMARBPROC;cvar;external libGLEW;
    __glewGetnMapdvARB : TPFNGLGETNMAPDVARBPROC;cvar;external libGLEW;
    __glewGetnMapfvARB : TPFNGLGETNMAPFVARBPROC;cvar;external libGLEW;
    __glewGetnMapivARB : TPFNGLGETNMAPIVARBPROC;cvar;external libGLEW;
    __glewGetnMinmaxARB : TPFNGLGETNMINMAXARBPROC;cvar;external libGLEW;
    __glewGetnPixelMapfvARB : TPFNGLGETNPIXELMAPFVARBPROC;cvar;external libGLEW;
    __glewGetnPixelMapuivARB : TPFNGLGETNPIXELMAPUIVARBPROC;cvar;external libGLEW;
    __glewGetnPixelMapusvARB : TPFNGLGETNPIXELMAPUSVARBPROC;cvar;external libGLEW;
    __glewGetnPolygonStippleARB : TPFNGLGETNPOLYGONSTIPPLEARBPROC;cvar;external libGLEW;
    __glewGetnSeparableFilterARB : TPFNGLGETNSEPARABLEFILTERARBPROC;cvar;external libGLEW;
    __glewGetnTexImageARB : TPFNGLGETNTEXIMAGEARBPROC;cvar;external libGLEW;
    __glewGetnUniformdvARB : TPFNGLGETNUNIFORMDVARBPROC;cvar;external libGLEW;
    __glewGetnUniformfvARB : TPFNGLGETNUNIFORMFVARBPROC;cvar;external libGLEW;
    __glewGetnUniformivARB : TPFNGLGETNUNIFORMIVARBPROC;cvar;external libGLEW;
    __glewGetnUniformuivARB : TPFNGLGETNUNIFORMUIVARBPROC;cvar;external libGLEW;
    __glewReadnPixelsARB : TPFNGLREADNPIXELSARBPROC;cvar;external libGLEW;
    __glewFramebufferSampleLocationsfvARB : TPFNGLFRAMEBUFFERSAMPLELOCATIONSFVARBPROC;cvar;external libGLEW;
    __glewNamedFramebufferSampleLocationsfvARB : TPFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVARBPROC;cvar;external libGLEW;
    __glewMinSampleShadingARB : TPFNGLMINSAMPLESHADINGARBPROC;cvar;external libGLEW;
    __glewBindSampler : TPFNGLBINDSAMPLERPROC;cvar;external libGLEW;
    __glewDeleteSamplers : TPFNGLDELETESAMPLERSPROC;cvar;external libGLEW;
    __glewGenSamplers : TPFNGLGENSAMPLERSPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIiv : TPFNGLGETSAMPLERPARAMETERIIVPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIuiv : TPFNGLGETSAMPLERPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewGetSamplerParameterfv : TPFNGLGETSAMPLERPARAMETERFVPROC;cvar;external libGLEW;
    __glewGetSamplerParameteriv : TPFNGLGETSAMPLERPARAMETERIVPROC;cvar;external libGLEW;
    __glewIsSampler : TPFNGLISSAMPLERPROC;cvar;external libGLEW;
    __glewSamplerParameterIiv : TPFNGLSAMPLERPARAMETERIIVPROC;cvar;external libGLEW;
    __glewSamplerParameterIuiv : TPFNGLSAMPLERPARAMETERIUIVPROC;cvar;external libGLEW;
    __glewSamplerParameterf : TPFNGLSAMPLERPARAMETERFPROC;cvar;external libGLEW;
    __glewSamplerParameterfv : TPFNGLSAMPLERPARAMETERFVPROC;cvar;external libGLEW;
    __glewSamplerParameteri : TPFNGLSAMPLERPARAMETERIPROC;cvar;external libGLEW;
    __glewSamplerParameteriv : TPFNGLSAMPLERPARAMETERIVPROC;cvar;external libGLEW;
    __glewActiveShaderProgram : TPFNGLACTIVESHADERPROGRAMPROC;cvar;external libGLEW;
    __glewBindProgramPipeline : TPFNGLBINDPROGRAMPIPELINEPROC;cvar;external libGLEW;
    __glewCreateShaderProgramv : TPFNGLCREATESHADERPROGRAMVPROC;cvar;external libGLEW;
    __glewDeleteProgramPipelines : TPFNGLDELETEPROGRAMPIPELINESPROC;cvar;external libGLEW;
    __glewGenProgramPipelines : TPFNGLGENPROGRAMPIPELINESPROC;cvar;external libGLEW;
    __glewGetProgramPipelineInfoLog : TPFNGLGETPROGRAMPIPELINEINFOLOGPROC;cvar;external libGLEW;
    __glewGetProgramPipelineiv : TPFNGLGETPROGRAMPIPELINEIVPROC;cvar;external libGLEW;
    __glewIsProgramPipeline : TPFNGLISPROGRAMPIPELINEPROC;cvar;external libGLEW;
    __glewProgramUniform1d : TPFNGLPROGRAMUNIFORM1DPROC;cvar;external libGLEW;
    __glewProgramUniform1dv : TPFNGLPROGRAMUNIFORM1DVPROC;cvar;external libGLEW;
    __glewProgramUniform1f : TPFNGLPROGRAMUNIFORM1FPROC;cvar;external libGLEW;
    __glewProgramUniform1fv : TPFNGLPROGRAMUNIFORM1FVPROC;cvar;external libGLEW;
    __glewProgramUniform1i : TPFNGLPROGRAMUNIFORM1IPROC;cvar;external libGLEW;
    __glewProgramUniform1iv : TPFNGLPROGRAMUNIFORM1IVPROC;cvar;external libGLEW;
    __glewProgramUniform1ui : TPFNGLPROGRAMUNIFORM1UIPROC;cvar;external libGLEW;
    __glewProgramUniform1uiv : TPFNGLPROGRAMUNIFORM1UIVPROC;cvar;external libGLEW;
    __glewProgramUniform2d : TPFNGLPROGRAMUNIFORM2DPROC;cvar;external libGLEW;
    __glewProgramUniform2dv : TPFNGLPROGRAMUNIFORM2DVPROC;cvar;external libGLEW;
    __glewProgramUniform2f : TPFNGLPROGRAMUNIFORM2FPROC;cvar;external libGLEW;
    __glewProgramUniform2fv : TPFNGLPROGRAMUNIFORM2FVPROC;cvar;external libGLEW;
    __glewProgramUniform2i : TPFNGLPROGRAMUNIFORM2IPROC;cvar;external libGLEW;
    __glewProgramUniform2iv : TPFNGLPROGRAMUNIFORM2IVPROC;cvar;external libGLEW;
    __glewProgramUniform2ui : TPFNGLPROGRAMUNIFORM2UIPROC;cvar;external libGLEW;
    __glewProgramUniform2uiv : TPFNGLPROGRAMUNIFORM2UIVPROC;cvar;external libGLEW;
    __glewProgramUniform3d : TPFNGLPROGRAMUNIFORM3DPROC;cvar;external libGLEW;
    __glewProgramUniform3dv : TPFNGLPROGRAMUNIFORM3DVPROC;cvar;external libGLEW;
    __glewProgramUniform3f : TPFNGLPROGRAMUNIFORM3FPROC;cvar;external libGLEW;
    __glewProgramUniform3fv : TPFNGLPROGRAMUNIFORM3FVPROC;cvar;external libGLEW;
    __glewProgramUniform3i : TPFNGLPROGRAMUNIFORM3IPROC;cvar;external libGLEW;
    __glewProgramUniform3iv : TPFNGLPROGRAMUNIFORM3IVPROC;cvar;external libGLEW;
    __glewProgramUniform3ui : TPFNGLPROGRAMUNIFORM3UIPROC;cvar;external libGLEW;
    __glewProgramUniform3uiv : TPFNGLPROGRAMUNIFORM3UIVPROC;cvar;external libGLEW;
    __glewProgramUniform4d : TPFNGLPROGRAMUNIFORM4DPROC;cvar;external libGLEW;
    __glewProgramUniform4dv : TPFNGLPROGRAMUNIFORM4DVPROC;cvar;external libGLEW;
    __glewProgramUniform4f : TPFNGLPROGRAMUNIFORM4FPROC;cvar;external libGLEW;
    __glewProgramUniform4fv : TPFNGLPROGRAMUNIFORM4FVPROC;cvar;external libGLEW;
    __glewProgramUniform4i : TPFNGLPROGRAMUNIFORM4IPROC;cvar;external libGLEW;
    __glewProgramUniform4iv : TPFNGLPROGRAMUNIFORM4IVPROC;cvar;external libGLEW;
    __glewProgramUniform4ui : TPFNGLPROGRAMUNIFORM4UIPROC;cvar;external libGLEW;
    __glewProgramUniform4uiv : TPFNGLPROGRAMUNIFORM4UIVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2dv : TPFNGLPROGRAMUNIFORMMATRIX2DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2fv : TPFNGLPROGRAMUNIFORMMATRIX2FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x3dv : TPFNGLPROGRAMUNIFORMMATRIX2X3DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x3fv : TPFNGLPROGRAMUNIFORMMATRIX2X3FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x4dv : TPFNGLPROGRAMUNIFORMMATRIX2X4DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x4fv : TPFNGLPROGRAMUNIFORMMATRIX2X4FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3dv : TPFNGLPROGRAMUNIFORMMATRIX3DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3fv : TPFNGLPROGRAMUNIFORMMATRIX3FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x2dv : TPFNGLPROGRAMUNIFORMMATRIX3X2DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x2fv : TPFNGLPROGRAMUNIFORMMATRIX3X2FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x4dv : TPFNGLPROGRAMUNIFORMMATRIX3X4DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x4fv : TPFNGLPROGRAMUNIFORMMATRIX3X4FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4dv : TPFNGLPROGRAMUNIFORMMATRIX4DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4fv : TPFNGLPROGRAMUNIFORMMATRIX4FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x2dv : TPFNGLPROGRAMUNIFORMMATRIX4X2DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x2fv : TPFNGLPROGRAMUNIFORMMATRIX4X2FVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x3dv : TPFNGLPROGRAMUNIFORMMATRIX4X3DVPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x3fv : TPFNGLPROGRAMUNIFORMMATRIX4X3FVPROC;cvar;external libGLEW;
    __glewUseProgramStages : TPFNGLUSEPROGRAMSTAGESPROC;cvar;external libGLEW;
    __glewValidateProgramPipeline : TPFNGLVALIDATEPROGRAMPIPELINEPROC;cvar;external libGLEW;
    __glewGetActiveAtomicCounterBufferiv : TPFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC;cvar;external libGLEW;
    __glewBindImageTexture : TPFNGLBINDIMAGETEXTUREPROC;cvar;external libGLEW;
    __glewMemoryBarrier : TPFNGLMEMORYBARRIERPROC;cvar;external libGLEW;
    __glewAttachObjectARB : TPFNGLATTACHOBJECTARBPROC;cvar;external libGLEW;
    __glewCompileShaderARB : TPFNGLCOMPILESHADERARBPROC;cvar;external libGLEW;
    __glewCreateProgramObjectARB : TPFNGLCREATEPROGRAMOBJECTARBPROC;cvar;external libGLEW;
    __glewCreateShaderObjectARB : TPFNGLCREATESHADEROBJECTARBPROC;cvar;external libGLEW;
    __glewDeleteObjectARB : TPFNGLDELETEOBJECTARBPROC;cvar;external libGLEW;
    __glewDetachObjectARB : TPFNGLDETACHOBJECTARBPROC;cvar;external libGLEW;
    __glewGetActiveUniformARB : TPFNGLGETACTIVEUNIFORMARBPROC;cvar;external libGLEW;
    __glewGetAttachedObjectsARB : TPFNGLGETATTACHEDOBJECTSARBPROC;cvar;external libGLEW;
    __glewGetHandleARB : TPFNGLGETHANDLEARBPROC;cvar;external libGLEW;
    __glewGetInfoLogARB : TPFNGLGETINFOLOGARBPROC;cvar;external libGLEW;
    __glewGetObjectParameterfvARB : TPFNGLGETOBJECTPARAMETERFVARBPROC;cvar;external libGLEW;
    __glewGetObjectParameterivARB : TPFNGLGETOBJECTPARAMETERIVARBPROC;cvar;external libGLEW;
    __glewGetShaderSourceARB : TPFNGLGETSHADERSOURCEARBPROC;cvar;external libGLEW;
    __glewGetUniformLocationARB : TPFNGLGETUNIFORMLOCATIONARBPROC;cvar;external libGLEW;
    __glewGetUniformfvARB : TPFNGLGETUNIFORMFVARBPROC;cvar;external libGLEW;
    __glewGetUniformivARB : TPFNGLGETUNIFORMIVARBPROC;cvar;external libGLEW;
    __glewLinkProgramARB : TPFNGLLINKPROGRAMARBPROC;cvar;external libGLEW;
    __glewShaderSourceARB : TPFNGLSHADERSOURCEARBPROC;cvar;external libGLEW;
    __glewUniform1fARB : TPFNGLUNIFORM1FARBPROC;cvar;external libGLEW;
    __glewUniform1fvARB : TPFNGLUNIFORM1FVARBPROC;cvar;external libGLEW;
    __glewUniform1iARB : TPFNGLUNIFORM1IARBPROC;cvar;external libGLEW;
    __glewUniform1ivARB : TPFNGLUNIFORM1IVARBPROC;cvar;external libGLEW;
    __glewUniform2fARB : TPFNGLUNIFORM2FARBPROC;cvar;external libGLEW;
    __glewUniform2fvARB : TPFNGLUNIFORM2FVARBPROC;cvar;external libGLEW;
    __glewUniform2iARB : TPFNGLUNIFORM2IARBPROC;cvar;external libGLEW;
    __glewUniform2ivARB : TPFNGLUNIFORM2IVARBPROC;cvar;external libGLEW;
    __glewUniform3fARB : TPFNGLUNIFORM3FARBPROC;cvar;external libGLEW;
    __glewUniform3fvARB : TPFNGLUNIFORM3FVARBPROC;cvar;external libGLEW;
    __glewUniform3iARB : TPFNGLUNIFORM3IARBPROC;cvar;external libGLEW;
    __glewUniform3ivARB : TPFNGLUNIFORM3IVARBPROC;cvar;external libGLEW;
    __glewUniform4fARB : TPFNGLUNIFORM4FARBPROC;cvar;external libGLEW;
    __glewUniform4fvARB : TPFNGLUNIFORM4FVARBPROC;cvar;external libGLEW;
    __glewUniform4iARB : TPFNGLUNIFORM4IARBPROC;cvar;external libGLEW;
    __glewUniform4ivARB : TPFNGLUNIFORM4IVARBPROC;cvar;external libGLEW;
    __glewUniformMatrix2fvARB : TPFNGLUNIFORMMATRIX2FVARBPROC;cvar;external libGLEW;
    __glewUniformMatrix3fvARB : TPFNGLUNIFORMMATRIX3FVARBPROC;cvar;external libGLEW;
    __glewUniformMatrix4fvARB : TPFNGLUNIFORMMATRIX4FVARBPROC;cvar;external libGLEW;
    __glewUseProgramObjectARB : TPFNGLUSEPROGRAMOBJECTARBPROC;cvar;external libGLEW;
    __glewValidateProgramARB : TPFNGLVALIDATEPROGRAMARBPROC;cvar;external libGLEW;
    __glewShaderStorageBlockBinding : TPFNGLSHADERSTORAGEBLOCKBINDINGPROC;cvar;external libGLEW;
    __glewGetActiveSubroutineName : TPFNGLGETACTIVESUBROUTINENAMEPROC;cvar;external libGLEW;
    __glewGetActiveSubroutineUniformName : TPFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC;cvar;external libGLEW;
    __glewGetActiveSubroutineUniformiv : TPFNGLGETACTIVESUBROUTINEUNIFORMIVPROC;cvar;external libGLEW;
    __glewGetProgramStageiv : TPFNGLGETPROGRAMSTAGEIVPROC;cvar;external libGLEW;
    __glewGetSubroutineIndex : TPFNGLGETSUBROUTINEINDEXPROC;cvar;external libGLEW;
    __glewGetSubroutineUniformLocation : TPFNGLGETSUBROUTINEUNIFORMLOCATIONPROC;cvar;external libGLEW;
    __glewGetUniformSubroutineuiv : TPFNGLGETUNIFORMSUBROUTINEUIVPROC;cvar;external libGLEW;
    __glewUniformSubroutinesuiv : TPFNGLUNIFORMSUBROUTINESUIVPROC;cvar;external libGLEW;
    __glewCompileShaderIncludeARB : TPFNGLCOMPILESHADERINCLUDEARBPROC;cvar;external libGLEW;
    __glewDeleteNamedStringARB : TPFNGLDELETENAMEDSTRINGARBPROC;cvar;external libGLEW;
    __glewGetNamedStringARB : TPFNGLGETNAMEDSTRINGARBPROC;cvar;external libGLEW;
    __glewGetNamedStringivARB : TPFNGLGETNAMEDSTRINGIVARBPROC;cvar;external libGLEW;
    __glewIsNamedStringARB : TPFNGLISNAMEDSTRINGARBPROC;cvar;external libGLEW;
    __glewNamedStringARB : TPFNGLNAMEDSTRINGARBPROC;cvar;external libGLEW;
    __glewBufferPageCommitmentARB : TPFNGLBUFFERPAGECOMMITMENTARBPROC;cvar;external libGLEW;
    __glewTexPageCommitmentARB : TPFNGLTEXPAGECOMMITMENTARBPROC;cvar;external libGLEW;
    __glewClientWaitSync : TPFNGLCLIENTWAITSYNCPROC;cvar;external libGLEW;
    __glewDeleteSync : TPFNGLDELETESYNCPROC;cvar;external libGLEW;
    __glewFenceSync : TPFNGLFENCESYNCPROC;cvar;external libGLEW;
    __glewGetInteger64v : TPFNGLGETINTEGER64VPROC;cvar;external libGLEW;
    __glewGetSynciv : TPFNGLGETSYNCIVPROC;cvar;external libGLEW;
    __glewIsSync : TPFNGLISSYNCPROC;cvar;external libGLEW;
    __glewWaitSync : TPFNGLWAITSYNCPROC;cvar;external libGLEW;
    __glewPatchParameterfv : TPFNGLPATCHPARAMETERFVPROC;cvar;external libGLEW;
    __glewPatchParameteri : TPFNGLPATCHPARAMETERIPROC;cvar;external libGLEW;
    __glewTextureBarrier : TPFNGLTEXTUREBARRIERPROC;cvar;external libGLEW;
    __glewTexBufferARB : TPFNGLTEXBUFFERARBPROC;cvar;external libGLEW;
    __glewTexBufferRange : TPFNGLTEXBUFFERRANGEPROC;cvar;external libGLEW;
    __glewTextureBufferRangeEXT : TPFNGLTEXTUREBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewCompressedTexImage1DARB : TPFNGLCOMPRESSEDTEXIMAGE1DARBPROC;cvar;external libGLEW;
    __glewCompressedTexImage2DARB : TPFNGLCOMPRESSEDTEXIMAGE2DARBPROC;cvar;external libGLEW;
    __glewCompressedTexImage3DARB : TPFNGLCOMPRESSEDTEXIMAGE3DARBPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage1DARB : TPFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage2DARB : TPFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage3DARB : TPFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC;cvar;external libGLEW;
    __glewGetCompressedTexImageARB : TPFNGLGETCOMPRESSEDTEXIMAGEARBPROC;cvar;external libGLEW;
    __glewGetMultisamplefv : TPFNGLGETMULTISAMPLEFVPROC;cvar;external libGLEW;
    __glewSampleMaski : TPFNGLSAMPLEMASKIPROC;cvar;external libGLEW;
    __glewTexImage2DMultisample : TPFNGLTEXIMAGE2DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTexImage3DMultisample : TPFNGLTEXIMAGE3DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTexStorage1D : TPFNGLTEXSTORAGE1DPROC;cvar;external libGLEW;
    __glewTexStorage2D : TPFNGLTEXSTORAGE2DPROC;cvar;external libGLEW;
    __glewTexStorage3D : TPFNGLTEXSTORAGE3DPROC;cvar;external libGLEW;
    __glewTexStorage2DMultisample : TPFNGLTEXSTORAGE2DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTexStorage3DMultisample : TPFNGLTEXSTORAGE3DMULTISAMPLEPROC;cvar;external libGLEW;
    __glewTextureStorage2DMultisampleEXT : TPFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewTextureStorage3DMultisampleEXT : TPFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewTextureView : TPFNGLTEXTUREVIEWPROC;cvar;external libGLEW;
    __glewGetQueryObjecti64v : TPFNGLGETQUERYOBJECTI64VPROC;cvar;external libGLEW;
    __glewGetQueryObjectui64v : TPFNGLGETQUERYOBJECTUI64VPROC;cvar;external libGLEW;
    __glewQueryCounter : TPFNGLQUERYCOUNTERPROC;cvar;external libGLEW;
    __glewBindTransformFeedback : TPFNGLBINDTRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewDeleteTransformFeedbacks : TPFNGLDELETETRANSFORMFEEDBACKSPROC;cvar;external libGLEW;
    __glewDrawTransformFeedback : TPFNGLDRAWTRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewGenTransformFeedbacks : TPFNGLGENTRANSFORMFEEDBACKSPROC;cvar;external libGLEW;
    __glewIsTransformFeedback : TPFNGLISTRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewPauseTransformFeedback : TPFNGLPAUSETRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewResumeTransformFeedback : TPFNGLRESUMETRANSFORMFEEDBACKPROC;cvar;external libGLEW;
    __glewBeginQueryIndexed : TPFNGLBEGINQUERYINDEXEDPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackStream : TPFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC;cvar;external libGLEW;
    __glewEndQueryIndexed : TPFNGLENDQUERYINDEXEDPROC;cvar;external libGLEW;
    __glewGetQueryIndexediv : TPFNGLGETQUERYINDEXEDIVPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackInstanced : TPFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackStreamInstanced : TPFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC;cvar;external libGLEW;
    __glewLoadTransposeMatrixdARB : TPFNGLLOADTRANSPOSEMATRIXDARBPROC;cvar;external libGLEW;
    __glewLoadTransposeMatrixfARB : TPFNGLLOADTRANSPOSEMATRIXFARBPROC;cvar;external libGLEW;
    __glewMultTransposeMatrixdARB : TPFNGLMULTTRANSPOSEMATRIXDARBPROC;cvar;external libGLEW;
    __glewMultTransposeMatrixfARB : TPFNGLMULTTRANSPOSEMATRIXFARBPROC;cvar;external libGLEW;
    __glewBindBufferBase : TPFNGLBINDBUFFERBASEPROC;cvar;external libGLEW;
    __glewBindBufferRange : TPFNGLBINDBUFFERRANGEPROC;cvar;external libGLEW;
    __glewGetActiveUniformBlockName : TPFNGLGETACTIVEUNIFORMBLOCKNAMEPROC;cvar;external libGLEW;
    __glewGetActiveUniformBlockiv : TPFNGLGETACTIVEUNIFORMBLOCKIVPROC;cvar;external libGLEW;
    __glewGetActiveUniformName : TPFNGLGETACTIVEUNIFORMNAMEPROC;cvar;external libGLEW;
    __glewGetActiveUniformsiv : TPFNGLGETACTIVEUNIFORMSIVPROC;cvar;external libGLEW;
    __glewGetIntegeri_v : TPFNGLGETINTEGERI_VPROC;cvar;external libGLEW;
    __glewGetUniformBlockIndex : TPFNGLGETUNIFORMBLOCKINDEXPROC;cvar;external libGLEW;
    __glewGetUniformIndices : TPFNGLGETUNIFORMINDICESPROC;cvar;external libGLEW;
    __glewUniformBlockBinding : TPFNGLUNIFORMBLOCKBINDINGPROC;cvar;external libGLEW;
    __glewBindVertexArray : TPFNGLBINDVERTEXARRAYPROC;cvar;external libGLEW;
    __glewDeleteVertexArrays : TPFNGLDELETEVERTEXARRAYSPROC;cvar;external libGLEW;
    __glewGenVertexArrays : TPFNGLGENVERTEXARRAYSPROC;cvar;external libGLEW;
    __glewIsVertexArray : TPFNGLISVERTEXARRAYPROC;cvar;external libGLEW;
    __glewGetVertexAttribLdv : TPFNGLGETVERTEXATTRIBLDVPROC;cvar;external libGLEW;
    __glewVertexAttribL1d : TPFNGLVERTEXATTRIBL1DPROC;cvar;external libGLEW;
    __glewVertexAttribL1dv : TPFNGLVERTEXATTRIBL1DVPROC;cvar;external libGLEW;
    __glewVertexAttribL2d : TPFNGLVERTEXATTRIBL2DPROC;cvar;external libGLEW;
    __glewVertexAttribL2dv : TPFNGLVERTEXATTRIBL2DVPROC;cvar;external libGLEW;
    __glewVertexAttribL3d : TPFNGLVERTEXATTRIBL3DPROC;cvar;external libGLEW;
    __glewVertexAttribL3dv : TPFNGLVERTEXATTRIBL3DVPROC;cvar;external libGLEW;
    __glewVertexAttribL4d : TPFNGLVERTEXATTRIBL4DPROC;cvar;external libGLEW;
    __glewVertexAttribL4dv : TPFNGLVERTEXATTRIBL4DVPROC;cvar;external libGLEW;
    __glewVertexAttribLPointer : TPFNGLVERTEXATTRIBLPOINTERPROC;cvar;external libGLEW;
    __glewBindVertexBuffer : TPFNGLBINDVERTEXBUFFERPROC;cvar;external libGLEW;
    __glewVertexArrayBindVertexBufferEXT : TPFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribBindingEXT : TPFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribFormatEXT : TPFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribIFormatEXT : TPFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribLFormatEXT : TPFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexBindingDivisorEXT : TPFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC;cvar;external libGLEW;
    __glewVertexAttribBinding : TPFNGLVERTEXATTRIBBINDINGPROC;cvar;external libGLEW;
    __glewVertexAttribFormat : TPFNGLVERTEXATTRIBFORMATPROC;cvar;external libGLEW;
    __glewVertexAttribIFormat : TPFNGLVERTEXATTRIBIFORMATPROC;cvar;external libGLEW;
    __glewVertexAttribLFormat : TPFNGLVERTEXATTRIBLFORMATPROC;cvar;external libGLEW;
    __glewVertexBindingDivisor : TPFNGLVERTEXBINDINGDIVISORPROC;cvar;external libGLEW;
    __glewVertexBlendARB : TPFNGLVERTEXBLENDARBPROC;cvar;external libGLEW;
    __glewWeightPointerARB : TPFNGLWEIGHTPOINTERARBPROC;cvar;external libGLEW;
    __glewWeightbvARB : TPFNGLWEIGHTBVARBPROC;cvar;external libGLEW;
    __glewWeightdvARB : TPFNGLWEIGHTDVARBPROC;cvar;external libGLEW;
    __glewWeightfvARB : TPFNGLWEIGHTFVARBPROC;cvar;external libGLEW;
    __glewWeightivARB : TPFNGLWEIGHTIVARBPROC;cvar;external libGLEW;
    __glewWeightsvARB : TPFNGLWEIGHTSVARBPROC;cvar;external libGLEW;
    __glewWeightubvARB : TPFNGLWEIGHTUBVARBPROC;cvar;external libGLEW;
    __glewWeightuivARB : TPFNGLWEIGHTUIVARBPROC;cvar;external libGLEW;
    __glewWeightusvARB : TPFNGLWEIGHTUSVARBPROC;cvar;external libGLEW;
    __glewBindBufferARB : TPFNGLBINDBUFFERARBPROC;cvar;external libGLEW;
    __glewBufferDataARB : TPFNGLBUFFERDATAARBPROC;cvar;external libGLEW;
    __glewBufferSubDataARB : TPFNGLBUFFERSUBDATAARBPROC;cvar;external libGLEW;
    __glewDeleteBuffersARB : TPFNGLDELETEBUFFERSARBPROC;cvar;external libGLEW;
    __glewGenBuffersARB : TPFNGLGENBUFFERSARBPROC;cvar;external libGLEW;
    __glewGetBufferParameterivARB : TPFNGLGETBUFFERPARAMETERIVARBPROC;cvar;external libGLEW;
    __glewGetBufferPointervARB : TPFNGLGETBUFFERPOINTERVARBPROC;cvar;external libGLEW;
    __glewGetBufferSubDataARB : TPFNGLGETBUFFERSUBDATAARBPROC;cvar;external libGLEW;
    __glewIsBufferARB : TPFNGLISBUFFERARBPROC;cvar;external libGLEW;
    __glewMapBufferARB : TPFNGLMAPBUFFERARBPROC;cvar;external libGLEW;
    __glewUnmapBufferARB : TPFNGLUNMAPBUFFERARBPROC;cvar;external libGLEW;
    __glewBindProgramARB : TPFNGLBINDPROGRAMARBPROC;cvar;external libGLEW;
    __glewDeleteProgramsARB : TPFNGLDELETEPROGRAMSARBPROC;cvar;external libGLEW;
    __glewDisableVertexAttribArrayARB : TPFNGLDISABLEVERTEXATTRIBARRAYARBPROC;cvar;external libGLEW;
    __glewEnableVertexAttribArrayARB : TPFNGLENABLEVERTEXATTRIBARRAYARBPROC;cvar;external libGLEW;
    __glewGenProgramsARB : TPFNGLGENPROGRAMSARBPROC;cvar;external libGLEW;
    __glewGetProgramEnvParameterdvARB : TPFNGLGETPROGRAMENVPARAMETERDVARBPROC;cvar;external libGLEW;
    __glewGetProgramEnvParameterfvARB : TPFNGLGETPROGRAMENVPARAMETERFVARBPROC;cvar;external libGLEW;
    __glewGetProgramLocalParameterdvARB : TPFNGLGETPROGRAMLOCALPARAMETERDVARBPROC;cvar;external libGLEW;
    __glewGetProgramLocalParameterfvARB : TPFNGLGETPROGRAMLOCALPARAMETERFVARBPROC;cvar;external libGLEW;
    __glewGetProgramStringARB : TPFNGLGETPROGRAMSTRINGARBPROC;cvar;external libGLEW;
    __glewGetProgramivARB : TPFNGLGETPROGRAMIVARBPROC;cvar;external libGLEW;
    __glewGetVertexAttribPointervARB : TPFNGLGETVERTEXATTRIBPOINTERVARBPROC;cvar;external libGLEW;
    __glewGetVertexAttribdvARB : TPFNGLGETVERTEXATTRIBDVARBPROC;cvar;external libGLEW;
    __glewGetVertexAttribfvARB : TPFNGLGETVERTEXATTRIBFVARBPROC;cvar;external libGLEW;
    __glewGetVertexAttribivARB : TPFNGLGETVERTEXATTRIBIVARBPROC;cvar;external libGLEW;
    __glewIsProgramARB : TPFNGLISPROGRAMARBPROC;cvar;external libGLEW;
    __glewProgramEnvParameter4dARB : TPFNGLPROGRAMENVPARAMETER4DARBPROC;cvar;external libGLEW;
    __glewProgramEnvParameter4dvARB : TPFNGLPROGRAMENVPARAMETER4DVARBPROC;cvar;external libGLEW;
    __glewProgramEnvParameter4fARB : TPFNGLPROGRAMENVPARAMETER4FARBPROC;cvar;external libGLEW;
    __glewProgramEnvParameter4fvARB : TPFNGLPROGRAMENVPARAMETER4FVARBPROC;cvar;external libGLEW;
    __glewProgramLocalParameter4dARB : TPFNGLPROGRAMLOCALPARAMETER4DARBPROC;cvar;external libGLEW;
    __glewProgramLocalParameter4dvARB : TPFNGLPROGRAMLOCALPARAMETER4DVARBPROC;cvar;external libGLEW;
    __glewProgramLocalParameter4fARB : TPFNGLPROGRAMLOCALPARAMETER4FARBPROC;cvar;external libGLEW;
    __glewProgramLocalParameter4fvARB : TPFNGLPROGRAMLOCALPARAMETER4FVARBPROC;cvar;external libGLEW;
    __glewProgramStringARB : TPFNGLPROGRAMSTRINGARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1dARB : TPFNGLVERTEXATTRIB1DARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1dvARB : TPFNGLVERTEXATTRIB1DVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1fARB : TPFNGLVERTEXATTRIB1FARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1fvARB : TPFNGLVERTEXATTRIB1FVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1sARB : TPFNGLVERTEXATTRIB1SARBPROC;cvar;external libGLEW;
    __glewVertexAttrib1svARB : TPFNGLVERTEXATTRIB1SVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2dARB : TPFNGLVERTEXATTRIB2DARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2dvARB : TPFNGLVERTEXATTRIB2DVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2fARB : TPFNGLVERTEXATTRIB2FARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2fvARB : TPFNGLVERTEXATTRIB2FVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2sARB : TPFNGLVERTEXATTRIB2SARBPROC;cvar;external libGLEW;
    __glewVertexAttrib2svARB : TPFNGLVERTEXATTRIB2SVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3dARB : TPFNGLVERTEXATTRIB3DARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3dvARB : TPFNGLVERTEXATTRIB3DVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3fARB : TPFNGLVERTEXATTRIB3FARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3fvARB : TPFNGLVERTEXATTRIB3FVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3sARB : TPFNGLVERTEXATTRIB3SARBPROC;cvar;external libGLEW;
    __glewVertexAttrib3svARB : TPFNGLVERTEXATTRIB3SVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NbvARB : TPFNGLVERTEXATTRIB4NBVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NivARB : TPFNGLVERTEXATTRIB4NIVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NsvARB : TPFNGLVERTEXATTRIB4NSVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NubARB : TPFNGLVERTEXATTRIB4NUBARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NubvARB : TPFNGLVERTEXATTRIB4NUBVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NuivARB : TPFNGLVERTEXATTRIB4NUIVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4NusvARB : TPFNGLVERTEXATTRIB4NUSVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4bvARB : TPFNGLVERTEXATTRIB4BVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4dARB : TPFNGLVERTEXATTRIB4DARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4dvARB : TPFNGLVERTEXATTRIB4DVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4fARB : TPFNGLVERTEXATTRIB4FARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4fvARB : TPFNGLVERTEXATTRIB4FVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4ivARB : TPFNGLVERTEXATTRIB4IVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4sARB : TPFNGLVERTEXATTRIB4SARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4svARB : TPFNGLVERTEXATTRIB4SVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4ubvARB : TPFNGLVERTEXATTRIB4UBVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4uivARB : TPFNGLVERTEXATTRIB4UIVARBPROC;cvar;external libGLEW;
    __glewVertexAttrib4usvARB : TPFNGLVERTEXATTRIB4USVARBPROC;cvar;external libGLEW;
    __glewVertexAttribPointerARB : TPFNGLVERTEXATTRIBPOINTERARBPROC;cvar;external libGLEW;
    __glewBindAttribLocationARB : TPFNGLBINDATTRIBLOCATIONARBPROC;cvar;external libGLEW;
    __glewGetActiveAttribARB : TPFNGLGETACTIVEATTRIBARBPROC;cvar;external libGLEW;
    __glewGetAttribLocationARB : TPFNGLGETATTRIBLOCATIONARBPROC;cvar;external libGLEW;
    __glewColorP3ui : TPFNGLCOLORP3UIPROC;cvar;external libGLEW;
    __glewColorP3uiv : TPFNGLCOLORP3UIVPROC;cvar;external libGLEW;
    __glewColorP4ui : TPFNGLCOLORP4UIPROC;cvar;external libGLEW;
    __glewColorP4uiv : TPFNGLCOLORP4UIVPROC;cvar;external libGLEW;
    __glewMultiTexCoordP1ui : TPFNGLMULTITEXCOORDP1UIPROC;cvar;external libGLEW;
    __glewMultiTexCoordP1uiv : TPFNGLMULTITEXCOORDP1UIVPROC;cvar;external libGLEW;
    __glewMultiTexCoordP2ui : TPFNGLMULTITEXCOORDP2UIPROC;cvar;external libGLEW;
    __glewMultiTexCoordP2uiv : TPFNGLMULTITEXCOORDP2UIVPROC;cvar;external libGLEW;
    __glewMultiTexCoordP3ui : TPFNGLMULTITEXCOORDP3UIPROC;cvar;external libGLEW;
    __glewMultiTexCoordP3uiv : TPFNGLMULTITEXCOORDP3UIVPROC;cvar;external libGLEW;
    __glewMultiTexCoordP4ui : TPFNGLMULTITEXCOORDP4UIPROC;cvar;external libGLEW;
    __glewMultiTexCoordP4uiv : TPFNGLMULTITEXCOORDP4UIVPROC;cvar;external libGLEW;
    __glewNormalP3ui : TPFNGLNORMALP3UIPROC;cvar;external libGLEW;
    __glewNormalP3uiv : TPFNGLNORMALP3UIVPROC;cvar;external libGLEW;
    __glewSecondaryColorP3ui : TPFNGLSECONDARYCOLORP3UIPROC;cvar;external libGLEW;
    __glewSecondaryColorP3uiv : TPFNGLSECONDARYCOLORP3UIVPROC;cvar;external libGLEW;
    __glewTexCoordP1ui : TPFNGLTEXCOORDP1UIPROC;cvar;external libGLEW;
    __glewTexCoordP1uiv : TPFNGLTEXCOORDP1UIVPROC;cvar;external libGLEW;
    __glewTexCoordP2ui : TPFNGLTEXCOORDP2UIPROC;cvar;external libGLEW;
    __glewTexCoordP2uiv : TPFNGLTEXCOORDP2UIVPROC;cvar;external libGLEW;
    __glewTexCoordP3ui : TPFNGLTEXCOORDP3UIPROC;cvar;external libGLEW;
    __glewTexCoordP3uiv : TPFNGLTEXCOORDP3UIVPROC;cvar;external libGLEW;
    __glewTexCoordP4ui : TPFNGLTEXCOORDP4UIPROC;cvar;external libGLEW;
    __glewTexCoordP4uiv : TPFNGLTEXCOORDP4UIVPROC;cvar;external libGLEW;
    __glewVertexAttribP1ui : TPFNGLVERTEXATTRIBP1UIPROC;cvar;external libGLEW;
    __glewVertexAttribP1uiv : TPFNGLVERTEXATTRIBP1UIVPROC;cvar;external libGLEW;
    __glewVertexAttribP2ui : TPFNGLVERTEXATTRIBP2UIPROC;cvar;external libGLEW;
    __glewVertexAttribP2uiv : TPFNGLVERTEXATTRIBP2UIVPROC;cvar;external libGLEW;
    __glewVertexAttribP3ui : TPFNGLVERTEXATTRIBP3UIPROC;cvar;external libGLEW;
    __glewVertexAttribP3uiv : TPFNGLVERTEXATTRIBP3UIVPROC;cvar;external libGLEW;
    __glewVertexAttribP4ui : TPFNGLVERTEXATTRIBP4UIPROC;cvar;external libGLEW;
    __glewVertexAttribP4uiv : TPFNGLVERTEXATTRIBP4UIVPROC;cvar;external libGLEW;
    __glewVertexP2ui : TPFNGLVERTEXP2UIPROC;cvar;external libGLEW;
    __glewVertexP2uiv : TPFNGLVERTEXP2UIVPROC;cvar;external libGLEW;
    __glewVertexP3ui : TPFNGLVERTEXP3UIPROC;cvar;external libGLEW;
    __glewVertexP3uiv : TPFNGLVERTEXP3UIVPROC;cvar;external libGLEW;
    __glewVertexP4ui : TPFNGLVERTEXP4UIPROC;cvar;external libGLEW;
    __glewVertexP4uiv : TPFNGLVERTEXP4UIVPROC;cvar;external libGLEW;
    __glewDepthRangeArrayv : TPFNGLDEPTHRANGEARRAYVPROC;cvar;external libGLEW;
    __glewDepthRangeIndexed : TPFNGLDEPTHRANGEINDEXEDPROC;cvar;external libGLEW;
    __glewGetDoublei_v : TPFNGLGETDOUBLEI_VPROC;cvar;external libGLEW;
    __glewGetFloati_v : TPFNGLGETFLOATI_VPROC;cvar;external libGLEW;
    __glewScissorArrayv : TPFNGLSCISSORARRAYVPROC;cvar;external libGLEW;
    __glewScissorIndexed : TPFNGLSCISSORINDEXEDPROC;cvar;external libGLEW;
    __glewScissorIndexedv : TPFNGLSCISSORINDEXEDVPROC;cvar;external libGLEW;
    __glewViewportArrayv : TPFNGLVIEWPORTARRAYVPROC;cvar;external libGLEW;
    __glewViewportIndexedf : TPFNGLVIEWPORTINDEXEDFPROC;cvar;external libGLEW;
    __glewViewportIndexedfv : TPFNGLVIEWPORTINDEXEDFVPROC;cvar;external libGLEW;
    __glewWindowPos2dARB : TPFNGLWINDOWPOS2DARBPROC;cvar;external libGLEW;
    __glewWindowPos2dvARB : TPFNGLWINDOWPOS2DVARBPROC;cvar;external libGLEW;
    __glewWindowPos2fARB : TPFNGLWINDOWPOS2FARBPROC;cvar;external libGLEW;
    __glewWindowPos2fvARB : TPFNGLWINDOWPOS2FVARBPROC;cvar;external libGLEW;
    __glewWindowPos2iARB : TPFNGLWINDOWPOS2IARBPROC;cvar;external libGLEW;
    __glewWindowPos2ivARB : TPFNGLWINDOWPOS2IVARBPROC;cvar;external libGLEW;
    __glewWindowPos2sARB : TPFNGLWINDOWPOS2SARBPROC;cvar;external libGLEW;
    __glewWindowPos2svARB : TPFNGLWINDOWPOS2SVARBPROC;cvar;external libGLEW;
    __glewWindowPos3dARB : TPFNGLWINDOWPOS3DARBPROC;cvar;external libGLEW;
    __glewWindowPos3dvARB : TPFNGLWINDOWPOS3DVARBPROC;cvar;external libGLEW;
    __glewWindowPos3fARB : TPFNGLWINDOWPOS3FARBPROC;cvar;external libGLEW;
    __glewWindowPos3fvARB : TPFNGLWINDOWPOS3FVARBPROC;cvar;external libGLEW;
    __glewWindowPos3iARB : TPFNGLWINDOWPOS3IARBPROC;cvar;external libGLEW;
    __glewWindowPos3ivARB : TPFNGLWINDOWPOS3IVARBPROC;cvar;external libGLEW;
    __glewWindowPos3sARB : TPFNGLWINDOWPOS3SARBPROC;cvar;external libGLEW;
    __glewWindowPos3svARB : TPFNGLWINDOWPOS3SVARBPROC;cvar;external libGLEW;
    __glewDrawBuffersATI : TPFNGLDRAWBUFFERSATIPROC;cvar;external libGLEW;
    __glewDrawElementArrayATI : TPFNGLDRAWELEMENTARRAYATIPROC;cvar;external libGLEW;
    __glewDrawRangeElementArrayATI : TPFNGLDRAWRANGEELEMENTARRAYATIPROC;cvar;external libGLEW;
    __glewElementPointerATI : TPFNGLELEMENTPOINTERATIPROC;cvar;external libGLEW;
    __glewGetTexBumpParameterfvATI : TPFNGLGETTEXBUMPPARAMETERFVATIPROC;cvar;external libGLEW;
    __glewGetTexBumpParameterivATI : TPFNGLGETTEXBUMPPARAMETERIVATIPROC;cvar;external libGLEW;
    __glewTexBumpParameterfvATI : TPFNGLTEXBUMPPARAMETERFVATIPROC;cvar;external libGLEW;
    __glewTexBumpParameterivATI : TPFNGLTEXBUMPPARAMETERIVATIPROC;cvar;external libGLEW;
    __glewAlphaFragmentOp1ATI : TPFNGLALPHAFRAGMENTOP1ATIPROC;cvar;external libGLEW;
    __glewAlphaFragmentOp2ATI : TPFNGLALPHAFRAGMENTOP2ATIPROC;cvar;external libGLEW;
    __glewAlphaFragmentOp3ATI : TPFNGLALPHAFRAGMENTOP3ATIPROC;cvar;external libGLEW;
    __glewBeginFragmentShaderATI : TPFNGLBEGINFRAGMENTSHADERATIPROC;cvar;external libGLEW;
    __glewBindFragmentShaderATI : TPFNGLBINDFRAGMENTSHADERATIPROC;cvar;external libGLEW;
    __glewColorFragmentOp1ATI : TPFNGLCOLORFRAGMENTOP1ATIPROC;cvar;external libGLEW;
    __glewColorFragmentOp2ATI : TPFNGLCOLORFRAGMENTOP2ATIPROC;cvar;external libGLEW;
    __glewColorFragmentOp3ATI : TPFNGLCOLORFRAGMENTOP3ATIPROC;cvar;external libGLEW;
    __glewDeleteFragmentShaderATI : TPFNGLDELETEFRAGMENTSHADERATIPROC;cvar;external libGLEW;
    __glewEndFragmentShaderATI : TPFNGLENDFRAGMENTSHADERATIPROC;cvar;external libGLEW;
    __glewGenFragmentShadersATI : TPFNGLGENFRAGMENTSHADERSATIPROC;cvar;external libGLEW;
    __glewPassTexCoordATI : TPFNGLPASSTEXCOORDATIPROC;cvar;external libGLEW;
    __glewSampleMapATI : TPFNGLSAMPLEMAPATIPROC;cvar;external libGLEW;
    __glewSetFragmentShaderConstantATI : TPFNGLSETFRAGMENTSHADERCONSTANTATIPROC;cvar;external libGLEW;
    __glewMapObjectBufferATI : TPFNGLMAPOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewUnmapObjectBufferATI : TPFNGLUNMAPOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewPNTrianglesfATI : TPFNGLPNTRIANGLESFATIPROC;cvar;external libGLEW;
    __glewPNTrianglesiATI : TPFNGLPNTRIANGLESIATIPROC;cvar;external libGLEW;
    __glewStencilFuncSeparateATI : TPFNGLSTENCILFUNCSEPARATEATIPROC;cvar;external libGLEW;
    __glewStencilOpSeparateATI : TPFNGLSTENCILOPSEPARATEATIPROC;cvar;external libGLEW;
    __glewArrayObjectATI : TPFNGLARRAYOBJECTATIPROC;cvar;external libGLEW;
    __glewFreeObjectBufferATI : TPFNGLFREEOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewGetArrayObjectfvATI : TPFNGLGETARRAYOBJECTFVATIPROC;cvar;external libGLEW;
    __glewGetArrayObjectivATI : TPFNGLGETARRAYOBJECTIVATIPROC;cvar;external libGLEW;
    __glewGetObjectBufferfvATI : TPFNGLGETOBJECTBUFFERFVATIPROC;cvar;external libGLEW;
    __glewGetObjectBufferivATI : TPFNGLGETOBJECTBUFFERIVATIPROC;cvar;external libGLEW;
    __glewGetVariantArrayObjectfvATI : TPFNGLGETVARIANTARRAYOBJECTFVATIPROC;cvar;external libGLEW;
    __glewGetVariantArrayObjectivATI : TPFNGLGETVARIANTARRAYOBJECTIVATIPROC;cvar;external libGLEW;
    __glewIsObjectBufferATI : TPFNGLISOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewNewObjectBufferATI : TPFNGLNEWOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewUpdateObjectBufferATI : TPFNGLUPDATEOBJECTBUFFERATIPROC;cvar;external libGLEW;
    __glewVariantArrayObjectATI : TPFNGLVARIANTARRAYOBJECTATIPROC;cvar;external libGLEW;
    __glewGetVertexAttribArrayObjectfvATI : TPFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC;cvar;external libGLEW;
    __glewGetVertexAttribArrayObjectivATI : TPFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC;cvar;external libGLEW;
    __glewVertexAttribArrayObjectATI : TPFNGLVERTEXATTRIBARRAYOBJECTATIPROC;cvar;external libGLEW;
    __glewClientActiveVertexStreamATI : TPFNGLCLIENTACTIVEVERTEXSTREAMATIPROC;cvar;external libGLEW;
    __glewNormalStream3bATI : TPFNGLNORMALSTREAM3BATIPROC;cvar;external libGLEW;
    __glewNormalStream3bvATI : TPFNGLNORMALSTREAM3BVATIPROC;cvar;external libGLEW;
    __glewNormalStream3dATI : TPFNGLNORMALSTREAM3DATIPROC;cvar;external libGLEW;
    __glewNormalStream3dvATI : TPFNGLNORMALSTREAM3DVATIPROC;cvar;external libGLEW;
    __glewNormalStream3fATI : TPFNGLNORMALSTREAM3FATIPROC;cvar;external libGLEW;
    __glewNormalStream3fvATI : TPFNGLNORMALSTREAM3FVATIPROC;cvar;external libGLEW;
    __glewNormalStream3iATI : TPFNGLNORMALSTREAM3IATIPROC;cvar;external libGLEW;
    __glewNormalStream3ivATI : TPFNGLNORMALSTREAM3IVATIPROC;cvar;external libGLEW;
    __glewNormalStream3sATI : TPFNGLNORMALSTREAM3SATIPROC;cvar;external libGLEW;
    __glewNormalStream3svATI : TPFNGLNORMALSTREAM3SVATIPROC;cvar;external libGLEW;
    __glewVertexBlendEnvfATI : TPFNGLVERTEXBLENDENVFATIPROC;cvar;external libGLEW;
    __glewVertexBlendEnviATI : TPFNGLVERTEXBLENDENVIATIPROC;cvar;external libGLEW;
    __glewVertexStream1dATI : TPFNGLVERTEXSTREAM1DATIPROC;cvar;external libGLEW;
    __glewVertexStream1dvATI : TPFNGLVERTEXSTREAM1DVATIPROC;cvar;external libGLEW;
    __glewVertexStream1fATI : TPFNGLVERTEXSTREAM1FATIPROC;cvar;external libGLEW;
    __glewVertexStream1fvATI : TPFNGLVERTEXSTREAM1FVATIPROC;cvar;external libGLEW;
    __glewVertexStream1iATI : TPFNGLVERTEXSTREAM1IATIPROC;cvar;external libGLEW;
    __glewVertexStream1ivATI : TPFNGLVERTEXSTREAM1IVATIPROC;cvar;external libGLEW;
    __glewVertexStream1sATI : TPFNGLVERTEXSTREAM1SATIPROC;cvar;external libGLEW;
    __glewVertexStream1svATI : TPFNGLVERTEXSTREAM1SVATIPROC;cvar;external libGLEW;
    __glewVertexStream2dATI : TPFNGLVERTEXSTREAM2DATIPROC;cvar;external libGLEW;
    __glewVertexStream2dvATI : TPFNGLVERTEXSTREAM2DVATIPROC;cvar;external libGLEW;
    __glewVertexStream2fATI : TPFNGLVERTEXSTREAM2FATIPROC;cvar;external libGLEW;
    __glewVertexStream2fvATI : TPFNGLVERTEXSTREAM2FVATIPROC;cvar;external libGLEW;
    __glewVertexStream2iATI : TPFNGLVERTEXSTREAM2IATIPROC;cvar;external libGLEW;
    __glewVertexStream2ivATI : TPFNGLVERTEXSTREAM2IVATIPROC;cvar;external libGLEW;
    __glewVertexStream2sATI : TPFNGLVERTEXSTREAM2SATIPROC;cvar;external libGLEW;
    __glewVertexStream2svATI : TPFNGLVERTEXSTREAM2SVATIPROC;cvar;external libGLEW;
    __glewVertexStream3dATI : TPFNGLVERTEXSTREAM3DATIPROC;cvar;external libGLEW;
    __glewVertexStream3dvATI : TPFNGLVERTEXSTREAM3DVATIPROC;cvar;external libGLEW;
    __glewVertexStream3fATI : TPFNGLVERTEXSTREAM3FATIPROC;cvar;external libGLEW;
    __glewVertexStream3fvATI : TPFNGLVERTEXSTREAM3FVATIPROC;cvar;external libGLEW;
    __glewVertexStream3iATI : TPFNGLVERTEXSTREAM3IATIPROC;cvar;external libGLEW;
    __glewVertexStream3ivATI : TPFNGLVERTEXSTREAM3IVATIPROC;cvar;external libGLEW;
    __glewVertexStream3sATI : TPFNGLVERTEXSTREAM3SATIPROC;cvar;external libGLEW;
    __glewVertexStream3svATI : TPFNGLVERTEXSTREAM3SVATIPROC;cvar;external libGLEW;
    __glewVertexStream4dATI : TPFNGLVERTEXSTREAM4DATIPROC;cvar;external libGLEW;
    __glewVertexStream4dvATI : TPFNGLVERTEXSTREAM4DVATIPROC;cvar;external libGLEW;
    __glewVertexStream4fATI : TPFNGLVERTEXSTREAM4FATIPROC;cvar;external libGLEW;
    __glewVertexStream4fvATI : TPFNGLVERTEXSTREAM4FVATIPROC;cvar;external libGLEW;
    __glewVertexStream4iATI : TPFNGLVERTEXSTREAM4IATIPROC;cvar;external libGLEW;
    __glewVertexStream4ivATI : TPFNGLVERTEXSTREAM4IVATIPROC;cvar;external libGLEW;
    __glewVertexStream4sATI : TPFNGLVERTEXSTREAM4SATIPROC;cvar;external libGLEW;
    __glewVertexStream4svATI : TPFNGLVERTEXSTREAM4SVATIPROC;cvar;external libGLEW;
    __glewEGLImageTargetTexStorageEXT : TPFNGLEGLIMAGETARGETTEXSTORAGEEXTPROC;cvar;external libGLEW;
    __glewEGLImageTargetTextureStorageEXT : TPFNGLEGLIMAGETARGETTEXTURESTORAGEEXTPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedBaseInstanceEXT : TPFNGLDRAWARRAYSINSTANCEDBASEINSTANCEEXTPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseInstanceEXT : TPFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEEXTPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseVertexBaseInstanceEXT : TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEEXTPROC;cvar;external libGLEW;
    __glewGetUniformBufferSizeEXT : TPFNGLGETUNIFORMBUFFERSIZEEXTPROC;cvar;external libGLEW;
    __glewGetUniformOffsetEXT : TPFNGLGETUNIFORMOFFSETEXTPROC;cvar;external libGLEW;
    __glewUniformBufferEXT : TPFNGLUNIFORMBUFFEREXTPROC;cvar;external libGLEW;
    __glewBlendColorEXT : TPFNGLBLENDCOLOREXTPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateEXT : TPFNGLBLENDEQUATIONSEPARATEEXTPROC;cvar;external libGLEW;
    __glewBindFragDataLocationIndexedEXT : TPFNGLBINDFRAGDATALOCATIONINDEXEDEXTPROC;cvar;external libGLEW;
    __glewGetFragDataIndexEXT : TPFNGLGETFRAGDATAINDEXEXTPROC;cvar;external libGLEW;
    __glewGetProgramResourceLocationIndexEXT : TPFNGLGETPROGRAMRESOURCELOCATIONINDEXEXTPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateEXT : TPFNGLBLENDFUNCSEPARATEEXTPROC;cvar;external libGLEW;
    __glewBlendEquationEXT : TPFNGLBLENDEQUATIONEXTPROC;cvar;external libGLEW;
    __glewBufferStorageEXT : TPFNGLBUFFERSTORAGEEXTPROC;cvar;external libGLEW;
    __glewNamedBufferStorageEXT : TPFNGLNAMEDBUFFERSTORAGEEXTPROC;cvar;external libGLEW;
    __glewClearTexImageEXT : TPFNGLCLEARTEXIMAGEEXTPROC;cvar;external libGLEW;
    __glewClearTexSubImageEXT : TPFNGLCLEARTEXSUBIMAGEEXTPROC;cvar;external libGLEW;
    __glewClipControlEXT : TPFNGLCLIPCONTROLEXTPROC;cvar;external libGLEW;
    __glewColorSubTableEXT : TPFNGLCOLORSUBTABLEEXTPROC;cvar;external libGLEW;
    __glewCopyColorSubTableEXT : TPFNGLCOPYCOLORSUBTABLEEXTPROC;cvar;external libGLEW;
    __glewLockArraysEXT : TPFNGLLOCKARRAYSEXTPROC;cvar;external libGLEW;
    __glewUnlockArraysEXT : TPFNGLUNLOCKARRAYSEXTPROC;cvar;external libGLEW;
    __glewConvolutionFilter1DEXT : TPFNGLCONVOLUTIONFILTER1DEXTPROC;cvar;external libGLEW;
    __glewConvolutionFilter2DEXT : TPFNGLCONVOLUTIONFILTER2DEXTPROC;cvar;external libGLEW;
    __glewConvolutionParameterfEXT : TPFNGLCONVOLUTIONPARAMETERFEXTPROC;cvar;external libGLEW;
    __glewConvolutionParameterfvEXT : TPFNGLCONVOLUTIONPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewConvolutionParameteriEXT : TPFNGLCONVOLUTIONPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewConvolutionParameterivEXT : TPFNGLCONVOLUTIONPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewCopyConvolutionFilter1DEXT : TPFNGLCOPYCONVOLUTIONFILTER1DEXTPROC;cvar;external libGLEW;
    __glewCopyConvolutionFilter2DEXT : TPFNGLCOPYCONVOLUTIONFILTER2DEXTPROC;cvar;external libGLEW;
    __glewGetConvolutionFilterEXT : TPFNGLGETCONVOLUTIONFILTEREXTPROC;cvar;external libGLEW;
    __glewGetConvolutionParameterfvEXT : TPFNGLGETCONVOLUTIONPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetConvolutionParameterivEXT : TPFNGLGETCONVOLUTIONPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetSeparableFilterEXT : TPFNGLGETSEPARABLEFILTEREXTPROC;cvar;external libGLEW;
    __glewSeparableFilter2DEXT : TPFNGLSEPARABLEFILTER2DEXTPROC;cvar;external libGLEW;
    __glewBinormalPointerEXT : TPFNGLBINORMALPOINTEREXTPROC;cvar;external libGLEW;
    __glewTangentPointerEXT : TPFNGLTANGENTPOINTEREXTPROC;cvar;external libGLEW;
    __glewCopyImageSubDataEXT : TPFNGLCOPYIMAGESUBDATAEXTPROC;cvar;external libGLEW;
    __glewCopyTexImage1DEXT : TPFNGLCOPYTEXIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyTexImage2DEXT : TPFNGLCOPYTEXIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyTexSubImage1DEXT : TPFNGLCOPYTEXSUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyTexSubImage2DEXT : TPFNGLCOPYTEXSUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyTexSubImage3DEXT : TPFNGLCOPYTEXSUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCullParameterdvEXT : TPFNGLCULLPARAMETERDVEXTPROC;cvar;external libGLEW;
    __glewCullParameterfvEXT : TPFNGLCULLPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetObjectLabelEXT : TPFNGLGETOBJECTLABELEXTPROC;cvar;external libGLEW;
    __glewLabelObjectEXT : TPFNGLLABELOBJECTEXTPROC;cvar;external libGLEW;
    __glewInsertEventMarkerEXT : TPFNGLINSERTEVENTMARKEREXTPROC;cvar;external libGLEW;
    __glewPopGroupMarkerEXT : TPFNGLPOPGROUPMARKEREXTPROC;cvar;external libGLEW;
    __glewPushGroupMarkerEXT : TPFNGLPUSHGROUPMARKEREXTPROC;cvar;external libGLEW;
    __glewDepthBoundsEXT : TPFNGLDEPTHBOUNDSEXTPROC;cvar;external libGLEW;
    __glewBindMultiTextureEXT : TPFNGLBINDMULTITEXTUREEXTPROC;cvar;external libGLEW;
    __glewCheckNamedFramebufferStatusEXT : TPFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC;cvar;external libGLEW;
    __glewClientAttribDefaultEXT : TPFNGLCLIENTATTRIBDEFAULTEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexImage1DEXT : TPFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexImage2DEXT : TPFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexImage3DEXT : TPFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexSubImage1DEXT : TPFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexSubImage2DEXT : TPFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCompressedMultiTexSubImage3DEXT : TPFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureImage1DEXT : TPFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureImage2DEXT : TPFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureImage3DEXT : TPFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage1DEXT : TPFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage2DEXT : TPFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCompressedTextureSubImage3DEXT : TPFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCopyMultiTexImage1DEXT : TPFNGLCOPYMULTITEXIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyMultiTexImage2DEXT : TPFNGLCOPYMULTITEXIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyMultiTexSubImage1DEXT : TPFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyMultiTexSubImage2DEXT : TPFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyMultiTexSubImage3DEXT : TPFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewCopyTextureImage1DEXT : TPFNGLCOPYTEXTUREIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyTextureImage2DEXT : TPFNGLCOPYTEXTUREIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage1DEXT : TPFNGLCOPYTEXTURESUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage2DEXT : TPFNGLCOPYTEXTURESUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewCopyTextureSubImage3DEXT : TPFNGLCOPYTEXTURESUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewDisableClientStateIndexedEXT : TPFNGLDISABLECLIENTSTATEINDEXEDEXTPROC;cvar;external libGLEW;
    __glewDisableClientStateiEXT : TPFNGLDISABLECLIENTSTATEIEXTPROC;cvar;external libGLEW;
    __glewDisableVertexArrayAttribEXT : TPFNGLDISABLEVERTEXARRAYATTRIBEXTPROC;cvar;external libGLEW;
    __glewDisableVertexArrayEXT : TPFNGLDISABLEVERTEXARRAYEXTPROC;cvar;external libGLEW;
    __glewEnableClientStateIndexedEXT : TPFNGLENABLECLIENTSTATEINDEXEDEXTPROC;cvar;external libGLEW;
    __glewEnableClientStateiEXT : TPFNGLENABLECLIENTSTATEIEXTPROC;cvar;external libGLEW;
    __glewEnableVertexArrayAttribEXT : TPFNGLENABLEVERTEXARRAYATTRIBEXTPROC;cvar;external libGLEW;
    __glewEnableVertexArrayEXT : TPFNGLENABLEVERTEXARRAYEXTPROC;cvar;external libGLEW;
    __glewFlushMappedNamedBufferRangeEXT : TPFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewFramebufferDrawBufferEXT : TPFNGLFRAMEBUFFERDRAWBUFFEREXTPROC;cvar;external libGLEW;
    __glewFramebufferDrawBuffersEXT : TPFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC;cvar;external libGLEW;
    __glewFramebufferReadBufferEXT : TPFNGLFRAMEBUFFERREADBUFFEREXTPROC;cvar;external libGLEW;
    __glewGenerateMultiTexMipmapEXT : TPFNGLGENERATEMULTITEXMIPMAPEXTPROC;cvar;external libGLEW;
    __glewGenerateTextureMipmapEXT : TPFNGLGENERATETEXTUREMIPMAPEXTPROC;cvar;external libGLEW;
    __glewGetCompressedMultiTexImageEXT : TPFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC;cvar;external libGLEW;
    __glewGetCompressedTextureImageEXT : TPFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC;cvar;external libGLEW;
    __glewGetDoubleIndexedvEXT : TPFNGLGETDOUBLEINDEXEDVEXTPROC;cvar;external libGLEW;
    __glewGetDoublei_vEXT : TPFNGLGETDOUBLEI_VEXTPROC;cvar;external libGLEW;
    __glewGetFloatIndexedvEXT : TPFNGLGETFLOATINDEXEDVEXTPROC;cvar;external libGLEW;
    __glewGetFloati_vEXT : TPFNGLGETFLOATI_VEXTPROC;cvar;external libGLEW;
    __glewGetFramebufferParameterivEXT : TPFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexEnvfvEXT : TPFNGLGETMULTITEXENVFVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexEnvivEXT : TPFNGLGETMULTITEXENVIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexGendvEXT : TPFNGLGETMULTITEXGENDVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexGenfvEXT : TPFNGLGETMULTITEXGENFVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexGenivEXT : TPFNGLGETMULTITEXGENIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexImageEXT : TPFNGLGETMULTITEXIMAGEEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexLevelParameterfvEXT : TPFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexLevelParameterivEXT : TPFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexParameterIivEXT : TPFNGLGETMULTITEXPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexParameterIuivEXT : TPFNGLGETMULTITEXPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexParameterfvEXT : TPFNGLGETMULTITEXPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetMultiTexParameterivEXT : TPFNGLGETMULTITEXPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedBufferParameterivEXT : TPFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedBufferPointervEXT : TPFNGLGETNAMEDBUFFERPOINTERVEXTPROC;cvar;external libGLEW;
    __glewGetNamedBufferSubDataEXT : TPFNGLGETNAMEDBUFFERSUBDATAEXTPROC;cvar;external libGLEW;
    __glewGetNamedFramebufferAttachmentParameterivEXT : TPFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramLocalParameterIivEXT : TPFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramLocalParameterIuivEXT : TPFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramLocalParameterdvEXT : TPFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramLocalParameterfvEXT : TPFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramStringEXT : TPFNGLGETNAMEDPROGRAMSTRINGEXTPROC;cvar;external libGLEW;
    __glewGetNamedProgramivEXT : TPFNGLGETNAMEDPROGRAMIVEXTPROC;cvar;external libGLEW;
    __glewGetNamedRenderbufferParameterivEXT : TPFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetPointerIndexedvEXT : TPFNGLGETPOINTERINDEXEDVEXTPROC;cvar;external libGLEW;
    __glewGetPointeri_vEXT : TPFNGLGETPOINTERI_VEXTPROC;cvar;external libGLEW;
    __glewGetTextureImageEXT : TPFNGLGETTEXTUREIMAGEEXTPROC;cvar;external libGLEW;
    __glewGetTextureLevelParameterfvEXT : TPFNGLGETTEXTURELEVELPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetTextureLevelParameterivEXT : TPFNGLGETTEXTURELEVELPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetTextureParameterIivEXT : TPFNGLGETTEXTUREPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewGetTextureParameterIuivEXT : TPFNGLGETTEXTUREPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewGetTextureParameterfvEXT : TPFNGLGETTEXTUREPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetTextureParameterivEXT : TPFNGLGETTEXTUREPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetVertexArrayIntegeri_vEXT : TPFNGLGETVERTEXARRAYINTEGERI_VEXTPROC;cvar;external libGLEW;
    __glewGetVertexArrayIntegervEXT : TPFNGLGETVERTEXARRAYINTEGERVEXTPROC;cvar;external libGLEW;
    __glewGetVertexArrayPointeri_vEXT : TPFNGLGETVERTEXARRAYPOINTERI_VEXTPROC;cvar;external libGLEW;
    __glewGetVertexArrayPointervEXT : TPFNGLGETVERTEXARRAYPOINTERVEXTPROC;cvar;external libGLEW;
    __glewMapNamedBufferEXT : TPFNGLMAPNAMEDBUFFEREXTPROC;cvar;external libGLEW;
    __glewMapNamedBufferRangeEXT : TPFNGLMAPNAMEDBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewMatrixFrustumEXT : TPFNGLMATRIXFRUSTUMEXTPROC;cvar;external libGLEW;
    __glewMatrixLoadIdentityEXT : TPFNGLMATRIXLOADIDENTITYEXTPROC;cvar;external libGLEW;
    __glewMatrixLoadTransposedEXT : TPFNGLMATRIXLOADTRANSPOSEDEXTPROC;cvar;external libGLEW;
    __glewMatrixLoadTransposefEXT : TPFNGLMATRIXLOADTRANSPOSEFEXTPROC;cvar;external libGLEW;
    __glewMatrixLoaddEXT : TPFNGLMATRIXLOADDEXTPROC;cvar;external libGLEW;
    __glewMatrixLoadfEXT : TPFNGLMATRIXLOADFEXTPROC;cvar;external libGLEW;
    __glewMatrixMultTransposedEXT : TPFNGLMATRIXMULTTRANSPOSEDEXTPROC;cvar;external libGLEW;
    __glewMatrixMultTransposefEXT : TPFNGLMATRIXMULTTRANSPOSEFEXTPROC;cvar;external libGLEW;
    __glewMatrixMultdEXT : TPFNGLMATRIXMULTDEXTPROC;cvar;external libGLEW;
    __glewMatrixMultfEXT : TPFNGLMATRIXMULTFEXTPROC;cvar;external libGLEW;
    __glewMatrixOrthoEXT : TPFNGLMATRIXORTHOEXTPROC;cvar;external libGLEW;
    __glewMatrixPopEXT : TPFNGLMATRIXPOPEXTPROC;cvar;external libGLEW;
    __glewMatrixPushEXT : TPFNGLMATRIXPUSHEXTPROC;cvar;external libGLEW;
    __glewMatrixRotatedEXT : TPFNGLMATRIXROTATEDEXTPROC;cvar;external libGLEW;
    __glewMatrixRotatefEXT : TPFNGLMATRIXROTATEFEXTPROC;cvar;external libGLEW;
    __glewMatrixScaledEXT : TPFNGLMATRIXSCALEDEXTPROC;cvar;external libGLEW;
    __glewMatrixScalefEXT : TPFNGLMATRIXSCALEFEXTPROC;cvar;external libGLEW;
    __glewMatrixTranslatedEXT : TPFNGLMATRIXTRANSLATEDEXTPROC;cvar;external libGLEW;
    __glewMatrixTranslatefEXT : TPFNGLMATRIXTRANSLATEFEXTPROC;cvar;external libGLEW;
    __glewMultiTexBufferEXT : TPFNGLMULTITEXBUFFEREXTPROC;cvar;external libGLEW;
    __glewMultiTexCoordPointerEXT : TPFNGLMULTITEXCOORDPOINTEREXTPROC;cvar;external libGLEW;
    __glewMultiTexEnvfEXT : TPFNGLMULTITEXENVFEXTPROC;cvar;external libGLEW;
    __glewMultiTexEnvfvEXT : TPFNGLMULTITEXENVFVEXTPROC;cvar;external libGLEW;
    __glewMultiTexEnviEXT : TPFNGLMULTITEXENVIEXTPROC;cvar;external libGLEW;
    __glewMultiTexEnvivEXT : TPFNGLMULTITEXENVIVEXTPROC;cvar;external libGLEW;
    __glewMultiTexGendEXT : TPFNGLMULTITEXGENDEXTPROC;cvar;external libGLEW;
    __glewMultiTexGendvEXT : TPFNGLMULTITEXGENDVEXTPROC;cvar;external libGLEW;
    __glewMultiTexGenfEXT : TPFNGLMULTITEXGENFEXTPROC;cvar;external libGLEW;
    __glewMultiTexGenfvEXT : TPFNGLMULTITEXGENFVEXTPROC;cvar;external libGLEW;
    __glewMultiTexGeniEXT : TPFNGLMULTITEXGENIEXTPROC;cvar;external libGLEW;
    __glewMultiTexGenivEXT : TPFNGLMULTITEXGENIVEXTPROC;cvar;external libGLEW;
    __glewMultiTexImage1DEXT : TPFNGLMULTITEXIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewMultiTexImage2DEXT : TPFNGLMULTITEXIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewMultiTexImage3DEXT : TPFNGLMULTITEXIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameterIivEXT : TPFNGLMULTITEXPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameterIuivEXT : TPFNGLMULTITEXPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameterfEXT : TPFNGLMULTITEXPARAMETERFEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameterfvEXT : TPFNGLMULTITEXPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameteriEXT : TPFNGLMULTITEXPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewMultiTexParameterivEXT : TPFNGLMULTITEXPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewMultiTexRenderbufferEXT : TPFNGLMULTITEXRENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewMultiTexSubImage1DEXT : TPFNGLMULTITEXSUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewMultiTexSubImage2DEXT : TPFNGLMULTITEXSUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewMultiTexSubImage3DEXT : TPFNGLMULTITEXSUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewNamedBufferDataEXT : TPFNGLNAMEDBUFFERDATAEXTPROC;cvar;external libGLEW;
    __glewNamedBufferSubDataEXT : TPFNGLNAMEDBUFFERSUBDATAEXTPROC;cvar;external libGLEW;
    __glewNamedCopyBufferSubDataEXT : TPFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferRenderbufferEXT : TPFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTexture1DEXT : TPFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTexture2DEXT : TPFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTexture3DEXT : TPFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTextureEXT : TPFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTextureFaceEXT : TPFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC;cvar;external libGLEW;
    __glewNamedFramebufferTextureLayerEXT : TPFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameter4dEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameter4dvEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameter4fEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameter4fvEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameterI4iEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameterI4ivEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameterI4uiEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameterI4uivEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParameters4fvEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParametersI4ivEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramLocalParametersI4uivEXT : TPFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC;cvar;external libGLEW;
    __glewNamedProgramStringEXT : TPFNGLNAMEDPROGRAMSTRINGEXTPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorageEXT : TPFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorageMultisampleCoverageEXT : TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC;cvar;external libGLEW;
    __glewNamedRenderbufferStorageMultisampleEXT : TPFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1fEXT : TPFNGLPROGRAMUNIFORM1FEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1fvEXT : TPFNGLPROGRAMUNIFORM1FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1iEXT : TPFNGLPROGRAMUNIFORM1IEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1ivEXT : TPFNGLPROGRAMUNIFORM1IVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1uiEXT : TPFNGLPROGRAMUNIFORM1UIEXTPROC;cvar;external libGLEW;
    __glewProgramUniform1uivEXT : TPFNGLPROGRAMUNIFORM1UIVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2fEXT : TPFNGLPROGRAMUNIFORM2FEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2fvEXT : TPFNGLPROGRAMUNIFORM2FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2iEXT : TPFNGLPROGRAMUNIFORM2IEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2ivEXT : TPFNGLPROGRAMUNIFORM2IVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2uiEXT : TPFNGLPROGRAMUNIFORM2UIEXTPROC;cvar;external libGLEW;
    __glewProgramUniform2uivEXT : TPFNGLPROGRAMUNIFORM2UIVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3fEXT : TPFNGLPROGRAMUNIFORM3FEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3fvEXT : TPFNGLPROGRAMUNIFORM3FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3iEXT : TPFNGLPROGRAMUNIFORM3IEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3ivEXT : TPFNGLPROGRAMUNIFORM3IVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3uiEXT : TPFNGLPROGRAMUNIFORM3UIEXTPROC;cvar;external libGLEW;
    __glewProgramUniform3uivEXT : TPFNGLPROGRAMUNIFORM3UIVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4fEXT : TPFNGLPROGRAMUNIFORM4FEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4fvEXT : TPFNGLPROGRAMUNIFORM4FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4iEXT : TPFNGLPROGRAMUNIFORM4IEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4ivEXT : TPFNGLPROGRAMUNIFORM4IVEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4uiEXT : TPFNGLPROGRAMUNIFORM4UIEXTPROC;cvar;external libGLEW;
    __glewProgramUniform4uivEXT : TPFNGLPROGRAMUNIFORM4UIVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2fvEXT : TPFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x3fvEXT : TPFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix2x4fvEXT : TPFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3fvEXT : TPFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x2fvEXT : TPFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix3x4fvEXT : TPFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4fvEXT : TPFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x2fvEXT : TPFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC;cvar;external libGLEW;
    __glewProgramUniformMatrix4x3fvEXT : TPFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC;cvar;external libGLEW;
    __glewPushClientAttribDefaultEXT : TPFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC;cvar;external libGLEW;
    __glewTextureBufferEXT : TPFNGLTEXTUREBUFFEREXTPROC;cvar;external libGLEW;
    __glewTextureImage1DEXT : TPFNGLTEXTUREIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewTextureImage2DEXT : TPFNGLTEXTUREIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewTextureImage3DEXT : TPFNGLTEXTUREIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewTextureParameterIivEXT : TPFNGLTEXTUREPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewTextureParameterIuivEXT : TPFNGLTEXTUREPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewTextureParameterfEXT : TPFNGLTEXTUREPARAMETERFEXTPROC;cvar;external libGLEW;
    __glewTextureParameterfvEXT : TPFNGLTEXTUREPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewTextureParameteriEXT : TPFNGLTEXTUREPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewTextureParameterivEXT : TPFNGLTEXTUREPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewTextureRenderbufferEXT : TPFNGLTEXTURERENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewTextureSubImage1DEXT : TPFNGLTEXTURESUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewTextureSubImage2DEXT : TPFNGLTEXTURESUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewTextureSubImage3DEXT : TPFNGLTEXTURESUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewUnmapNamedBufferEXT : TPFNGLUNMAPNAMEDBUFFEREXTPROC;cvar;external libGLEW;
    __glewVertexArrayColorOffsetEXT : TPFNGLVERTEXARRAYCOLOROFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayEdgeFlagOffsetEXT : TPFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayFogCoordOffsetEXT : TPFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayIndexOffsetEXT : TPFNGLVERTEXARRAYINDEXOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayMultiTexCoordOffsetEXT : TPFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayNormalOffsetEXT : TPFNGLVERTEXARRAYNORMALOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArraySecondaryColorOffsetEXT : TPFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayTexCoordOffsetEXT : TPFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribDivisorEXT : TPFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribIOffsetEXT : TPFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribOffsetEXT : TPFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexOffsetEXT : TPFNGLVERTEXARRAYVERTEXOFFSETEXTPROC;cvar;external libGLEW;
    __glewDiscardFramebufferEXT : TPFNGLDISCARDFRAMEBUFFEREXTPROC;cvar;external libGLEW;
    __glewBeginQueryEXT : TPFNGLBEGINQUERYEXTPROC;cvar;external libGLEW;
    __glewDeleteQueriesEXT : TPFNGLDELETEQUERIESEXTPROC;cvar;external libGLEW;
    __glewEndQueryEXT : TPFNGLENDQUERYEXTPROC;cvar;external libGLEW;
    __glewGenQueriesEXT : TPFNGLGENQUERIESEXTPROC;cvar;external libGLEW;
    __glewGetInteger64vEXT : TPFNGLGETINTEGER64VEXTPROC;cvar;external libGLEW;
    __glewGetQueryObjectivEXT : TPFNGLGETQUERYOBJECTIVEXTPROC;cvar;external libGLEW;
    __glewGetQueryObjectuivEXT : TPFNGLGETQUERYOBJECTUIVEXTPROC;cvar;external libGLEW;
    __glewGetQueryivEXT : TPFNGLGETQUERYIVEXTPROC;cvar;external libGLEW;
    __glewIsQueryEXT : TPFNGLISQUERYEXTPROC;cvar;external libGLEW;
    __glewQueryCounterEXT : TPFNGLQUERYCOUNTEREXTPROC;cvar;external libGLEW;
    __glewDrawBuffersEXT : TPFNGLDRAWBUFFERSEXTPROC;cvar;external libGLEW;
    __glewColorMaskIndexedEXT : TPFNGLCOLORMASKINDEXEDEXTPROC;cvar;external libGLEW;
    __glewDisableIndexedEXT : TPFNGLDISABLEINDEXEDEXTPROC;cvar;external libGLEW;
    __glewEnableIndexedEXT : TPFNGLENABLEINDEXEDEXTPROC;cvar;external libGLEW;
    __glewGetBooleanIndexedvEXT : TPFNGLGETBOOLEANINDEXEDVEXTPROC;cvar;external libGLEW;
    __glewGetIntegerIndexedvEXT : TPFNGLGETINTEGERINDEXEDVEXTPROC;cvar;external libGLEW;
    __glewIsEnabledIndexedEXT : TPFNGLISENABLEDINDEXEDEXTPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateiEXT : TPFNGLBLENDEQUATIONSEPARATEIEXTPROC;cvar;external libGLEW;
    __glewBlendEquationiEXT : TPFNGLBLENDEQUATIONIEXTPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateiEXT : TPFNGLBLENDFUNCSEPARATEIEXTPROC;cvar;external libGLEW;
    __glewBlendFunciEXT : TPFNGLBLENDFUNCIEXTPROC;cvar;external libGLEW;
    __glewColorMaskiEXT : TPFNGLCOLORMASKIEXTPROC;cvar;external libGLEW;
    __glewDisableiEXT : TPFNGLDISABLEIEXTPROC;cvar;external libGLEW;
    __glewEnableiEXT : TPFNGLENABLEIEXTPROC;cvar;external libGLEW;
    __glewIsEnablediEXT : TPFNGLISENABLEDIEXTPROC;cvar;external libGLEW;
    __glewDrawElementsBaseVertexEXT : TPFNGLDRAWELEMENTSBASEVERTEXEXTPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedBaseVertexEXT : TPFNGLDRAWELEMENTSINSTANCEDBASEVERTEXEXTPROC;cvar;external libGLEW;
    __glewDrawRangeElementsBaseVertexEXT : TPFNGLDRAWRANGEELEMENTSBASEVERTEXEXTPROC;cvar;external libGLEW;
    __glewMultiDrawElementsBaseVertexEXT : TPFNGLMULTIDRAWELEMENTSBASEVERTEXEXTPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedEXT : TPFNGLDRAWARRAYSINSTANCEDEXTPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedEXT : TPFNGLDRAWELEMENTSINSTANCEDEXTPROC;cvar;external libGLEW;
    __glewDrawRangeElementsEXT : TPFNGLDRAWRANGEELEMENTSEXTPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackEXT : TPFNGLDRAWTRANSFORMFEEDBACKEXTPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackInstancedEXT : TPFNGLDRAWTRANSFORMFEEDBACKINSTANCEDEXTPROC;cvar;external libGLEW;
    __glewBufferStorageExternalEXT : TPFNGLBUFFERSTORAGEEXTERNALEXTPROC;cvar;external libGLEW;
    __glewNamedBufferStorageExternalEXT : TPFNGLNAMEDBUFFERSTORAGEEXTERNALEXTPROC;cvar;external libGLEW;
    __glewFogCoordPointerEXT : TPFNGLFOGCOORDPOINTEREXTPROC;cvar;external libGLEW;
    __glewFogCoorddEXT : TPFNGLFOGCOORDDEXTPROC;cvar;external libGLEW;
    __glewFogCoorddvEXT : TPFNGLFOGCOORDDVEXTPROC;cvar;external libGLEW;
    __glewFogCoordfEXT : TPFNGLFOGCOORDFEXTPROC;cvar;external libGLEW;
    __glewFogCoordfvEXT : TPFNGLFOGCOORDFVEXTPROC;cvar;external libGLEW;
    __glewFragmentColorMaterialEXT : TPFNGLFRAGMENTCOLORMATERIALEXTPROC;cvar;external libGLEW;
    __glewFragmentLightModelfEXT : TPFNGLFRAGMENTLIGHTMODELFEXTPROC;cvar;external libGLEW;
    __glewFragmentLightModelfvEXT : TPFNGLFRAGMENTLIGHTMODELFVEXTPROC;cvar;external libGLEW;
    __glewFragmentLightModeliEXT : TPFNGLFRAGMENTLIGHTMODELIEXTPROC;cvar;external libGLEW;
    __glewFragmentLightModelivEXT : TPFNGLFRAGMENTLIGHTMODELIVEXTPROC;cvar;external libGLEW;
    __glewFragmentLightfEXT : TPFNGLFRAGMENTLIGHTFEXTPROC;cvar;external libGLEW;
    __glewFragmentLightfvEXT : TPFNGLFRAGMENTLIGHTFVEXTPROC;cvar;external libGLEW;
    __glewFragmentLightiEXT : TPFNGLFRAGMENTLIGHTIEXTPROC;cvar;external libGLEW;
    __glewFragmentLightivEXT : TPFNGLFRAGMENTLIGHTIVEXTPROC;cvar;external libGLEW;
    __glewFragmentMaterialfEXT : TPFNGLFRAGMENTMATERIALFEXTPROC;cvar;external libGLEW;
    __glewFragmentMaterialfvEXT : TPFNGLFRAGMENTMATERIALFVEXTPROC;cvar;external libGLEW;
    __glewFragmentMaterialiEXT : TPFNGLFRAGMENTMATERIALIEXTPROC;cvar;external libGLEW;
    __glewFragmentMaterialivEXT : TPFNGLFRAGMENTMATERIALIVEXTPROC;cvar;external libGLEW;
    __glewGetFragmentLightfvEXT : TPFNGLGETFRAGMENTLIGHTFVEXTPROC;cvar;external libGLEW;
    __glewGetFragmentLightivEXT : TPFNGLGETFRAGMENTLIGHTIVEXTPROC;cvar;external libGLEW;
    __glewGetFragmentMaterialfvEXT : TPFNGLGETFRAGMENTMATERIALFVEXTPROC;cvar;external libGLEW;
    __glewGetFragmentMaterialivEXT : TPFNGLGETFRAGMENTMATERIALIVEXTPROC;cvar;external libGLEW;
    __glewLightEnviEXT : TPFNGLLIGHTENVIEXTPROC;cvar;external libGLEW;
    __glewBlitFramebufferEXT : TPFNGLBLITFRAMEBUFFEREXTPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleEXT : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewBindFramebufferEXT : TPFNGLBINDFRAMEBUFFEREXTPROC;cvar;external libGLEW;
    __glewBindRenderbufferEXT : TPFNGLBINDRENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewCheckFramebufferStatusEXT : TPFNGLCHECKFRAMEBUFFERSTATUSEXTPROC;cvar;external libGLEW;
    __glewDeleteFramebuffersEXT : TPFNGLDELETEFRAMEBUFFERSEXTPROC;cvar;external libGLEW;
    __glewDeleteRenderbuffersEXT : TPFNGLDELETERENDERBUFFERSEXTPROC;cvar;external libGLEW;
    __glewFramebufferRenderbufferEXT : TPFNGLFRAMEBUFFERRENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewFramebufferTexture1DEXT : TPFNGLFRAMEBUFFERTEXTURE1DEXTPROC;cvar;external libGLEW;
    __glewFramebufferTexture2DEXT : TPFNGLFRAMEBUFFERTEXTURE2DEXTPROC;cvar;external libGLEW;
    __glewFramebufferTexture3DEXT : TPFNGLFRAMEBUFFERTEXTURE3DEXTPROC;cvar;external libGLEW;
    __glewGenFramebuffersEXT : TPFNGLGENFRAMEBUFFERSEXTPROC;cvar;external libGLEW;
    __glewGenRenderbuffersEXT : TPFNGLGENRENDERBUFFERSEXTPROC;cvar;external libGLEW;
    __glewGenerateMipmapEXT : TPFNGLGENERATEMIPMAPEXTPROC;cvar;external libGLEW;
    __glewGetFramebufferAttachmentParameterivEXT : TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetRenderbufferParameterivEXT : TPFNGLGETRENDERBUFFERPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewIsFramebufferEXT : TPFNGLISFRAMEBUFFEREXTPROC;cvar;external libGLEW;
    __glewIsRenderbufferEXT : TPFNGLISRENDERBUFFEREXTPROC;cvar;external libGLEW;
    __glewRenderbufferStorageEXT : TPFNGLRENDERBUFFERSTORAGEEXTPROC;cvar;external libGLEW;
    __glewFramebufferTextureEXT : TPFNGLFRAMEBUFFERTEXTUREEXTPROC;cvar;external libGLEW;
    __glewFramebufferTextureFaceEXT : TPFNGLFRAMEBUFFERTEXTUREFACEEXTPROC;cvar;external libGLEW;
    __glewProgramParameteriEXT : TPFNGLPROGRAMPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewProgramEnvParameters4fvEXT : TPFNGLPROGRAMENVPARAMETERS4FVEXTPROC;cvar;external libGLEW;
    __glewProgramLocalParameters4fvEXT : TPFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC;cvar;external libGLEW;
    __glewBindFragDataLocationEXT : TPFNGLBINDFRAGDATALOCATIONEXTPROC;cvar;external libGLEW;
    __glewGetFragDataLocationEXT : TPFNGLGETFRAGDATALOCATIONEXTPROC;cvar;external libGLEW;
    __glewGetUniformuivEXT : TPFNGLGETUNIFORMUIVEXTPROC;cvar;external libGLEW;
    __glewGetVertexAttribIivEXT : TPFNGLGETVERTEXATTRIBIIVEXTPROC;cvar;external libGLEW;
    __glewGetVertexAttribIuivEXT : TPFNGLGETVERTEXATTRIBIUIVEXTPROC;cvar;external libGLEW;
    __glewUniform1uiEXT : TPFNGLUNIFORM1UIEXTPROC;cvar;external libGLEW;
    __glewUniform1uivEXT : TPFNGLUNIFORM1UIVEXTPROC;cvar;external libGLEW;
    __glewUniform2uiEXT : TPFNGLUNIFORM2UIEXTPROC;cvar;external libGLEW;
    __glewUniform2uivEXT : TPFNGLUNIFORM2UIVEXTPROC;cvar;external libGLEW;
    __glewUniform3uiEXT : TPFNGLUNIFORM3UIEXTPROC;cvar;external libGLEW;
    __glewUniform3uivEXT : TPFNGLUNIFORM3UIVEXTPROC;cvar;external libGLEW;
    __glewUniform4uiEXT : TPFNGLUNIFORM4UIEXTPROC;cvar;external libGLEW;
    __glewUniform4uivEXT : TPFNGLUNIFORM4UIVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI1iEXT : TPFNGLVERTEXATTRIBI1IEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI1ivEXT : TPFNGLVERTEXATTRIBI1IVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI1uiEXT : TPFNGLVERTEXATTRIBI1UIEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI1uivEXT : TPFNGLVERTEXATTRIBI1UIVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI2iEXT : TPFNGLVERTEXATTRIBI2IEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI2ivEXT : TPFNGLVERTEXATTRIBI2IVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI2uiEXT : TPFNGLVERTEXATTRIBI2UIEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI2uivEXT : TPFNGLVERTEXATTRIBI2UIVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI3iEXT : TPFNGLVERTEXATTRIBI3IEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI3ivEXT : TPFNGLVERTEXATTRIBI3IVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI3uiEXT : TPFNGLVERTEXATTRIBI3UIEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI3uivEXT : TPFNGLVERTEXATTRIBI3UIVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4bvEXT : TPFNGLVERTEXATTRIBI4BVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4iEXT : TPFNGLVERTEXATTRIBI4IEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4ivEXT : TPFNGLVERTEXATTRIBI4IVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4svEXT : TPFNGLVERTEXATTRIBI4SVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4ubvEXT : TPFNGLVERTEXATTRIBI4UBVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4uiEXT : TPFNGLVERTEXATTRIBI4UIEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4uivEXT : TPFNGLVERTEXATTRIBI4UIVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribI4usvEXT : TPFNGLVERTEXATTRIBI4USVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribIPointerEXT : TPFNGLVERTEXATTRIBIPOINTEREXTPROC;cvar;external libGLEW;
    __glewGetHistogramEXT : TPFNGLGETHISTOGRAMEXTPROC;cvar;external libGLEW;
    __glewGetHistogramParameterfvEXT : TPFNGLGETHISTOGRAMPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetHistogramParameterivEXT : TPFNGLGETHISTOGRAMPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetMinmaxEXT : TPFNGLGETMINMAXEXTPROC;cvar;external libGLEW;
    __glewGetMinmaxParameterfvEXT : TPFNGLGETMINMAXPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetMinmaxParameterivEXT : TPFNGLGETMINMAXPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewHistogramEXT : TPFNGLHISTOGRAMEXTPROC;cvar;external libGLEW;
    __glewMinmaxEXT : TPFNGLMINMAXEXTPROC;cvar;external libGLEW;
    __glewResetHistogramEXT : TPFNGLRESETHISTOGRAMEXTPROC;cvar;external libGLEW;
    __glewResetMinmaxEXT : TPFNGLRESETMINMAXEXTPROC;cvar;external libGLEW;
    __glewIndexFuncEXT : TPFNGLINDEXFUNCEXTPROC;cvar;external libGLEW;
    __glewIndexMaterialEXT : TPFNGLINDEXMATERIALEXTPROC;cvar;external libGLEW;
    __glewVertexAttribDivisorEXT : TPFNGLVERTEXATTRIBDIVISOREXTPROC;cvar;external libGLEW;
    __glewApplyTextureEXT : TPFNGLAPPLYTEXTUREEXTPROC;cvar;external libGLEW;
    __glewTextureLightEXT : TPFNGLTEXTURELIGHTEXTPROC;cvar;external libGLEW;
    __glewTextureMaterialEXT : TPFNGLTEXTUREMATERIALEXTPROC;cvar;external libGLEW;
    __glewFlushMappedBufferRangeEXT : TPFNGLFLUSHMAPPEDBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewMapBufferRangeEXT : TPFNGLMAPBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewBufferStorageMemEXT : TPFNGLBUFFERSTORAGEMEMEXTPROC;cvar;external libGLEW;
    __glewCreateMemoryObjectsEXT : TPFNGLCREATEMEMORYOBJECTSEXTPROC;cvar;external libGLEW;
    __glewDeleteMemoryObjectsEXT : TPFNGLDELETEMEMORYOBJECTSEXTPROC;cvar;external libGLEW;
    __glewGetMemoryObjectParameterivEXT : TPFNGLGETMEMORYOBJECTPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetUnsignedBytei_vEXT : TPFNGLGETUNSIGNEDBYTEI_VEXTPROC;cvar;external libGLEW;
    __glewGetUnsignedBytevEXT : TPFNGLGETUNSIGNEDBYTEVEXTPROC;cvar;external libGLEW;
    __glewIsMemoryObjectEXT : TPFNGLISMEMORYOBJECTEXTPROC;cvar;external libGLEW;
    __glewMemoryObjectParameterivEXT : TPFNGLMEMORYOBJECTPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewNamedBufferStorageMemEXT : TPFNGLNAMEDBUFFERSTORAGEMEMEXTPROC;cvar;external libGLEW;
    __glewTexStorageMem1DEXT : TPFNGLTEXSTORAGEMEM1DEXTPROC;cvar;external libGLEW;
    __glewTexStorageMem2DEXT : TPFNGLTEXSTORAGEMEM2DEXTPROC;cvar;external libGLEW;
    __glewTexStorageMem2DMultisampleEXT : TPFNGLTEXSTORAGEMEM2DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewTexStorageMem3DEXT : TPFNGLTEXSTORAGEMEM3DEXTPROC;cvar;external libGLEW;
    __glewTexStorageMem3DMultisampleEXT : TPFNGLTEXSTORAGEMEM3DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewTextureStorageMem1DEXT : TPFNGLTEXTURESTORAGEMEM1DEXTPROC;cvar;external libGLEW;
    __glewTextureStorageMem2DEXT : TPFNGLTEXTURESTORAGEMEM2DEXTPROC;cvar;external libGLEW;
    __glewTextureStorageMem2DMultisampleEXT : TPFNGLTEXTURESTORAGEMEM2DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewTextureStorageMem3DEXT : TPFNGLTEXTURESTORAGEMEM3DEXTPROC;cvar;external libGLEW;
    __glewTextureStorageMem3DMultisampleEXT : TPFNGLTEXTURESTORAGEMEM3DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewImportMemoryFdEXT : TPFNGLIMPORTMEMORYFDEXTPROC;cvar;external libGLEW;
    __glewImportMemoryWin32HandleEXT : TPFNGLIMPORTMEMORYWIN32HANDLEEXTPROC;cvar;external libGLEW;
    __glewImportMemoryWin32NameEXT : TPFNGLIMPORTMEMORYWIN32NAMEEXTPROC;cvar;external libGLEW;
    __glewMultiDrawArraysEXT : TPFNGLMULTIDRAWARRAYSEXTPROC;cvar;external libGLEW;
    __glewMultiDrawElementsEXT : TPFNGLMULTIDRAWELEMENTSEXTPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectEXT : TPFNGLMULTIDRAWARRAYSINDIRECTEXTPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectEXT : TPFNGLMULTIDRAWELEMENTSINDIRECTEXTPROC;cvar;external libGLEW;
    __glewSampleMaskEXT : TPFNGLSAMPLEMASKEXTPROC;cvar;external libGLEW;
    __glewSamplePatternEXT : TPFNGLSAMPLEPATTERNEXTPROC;cvar;external libGLEW;
    __glewFramebufferTexture2DMultisampleEXT : TPFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEEXTPROC;cvar;external libGLEW;
    __glewDrawBuffersIndexedEXT : TPFNGLDRAWBUFFERSINDEXEDEXTPROC;cvar;external libGLEW;
    __glewGetIntegeri_vEXT : TPFNGLGETINTEGERI_VEXTPROC;cvar;external libGLEW;
    __glewReadBufferIndexedEXT : TPFNGLREADBUFFERINDEXEDEXTPROC;cvar;external libGLEW;
    __glewColorTableEXT : TPFNGLCOLORTABLEEXTPROC;cvar;external libGLEW;
    __glewGetColorTableEXT : TPFNGLGETCOLORTABLEEXTPROC;cvar;external libGLEW;
    __glewGetColorTableParameterfvEXT : TPFNGLGETCOLORTABLEPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetColorTableParameterivEXT : TPFNGLGETCOLORTABLEPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewGetPixelTransformParameterfvEXT : TPFNGLGETPIXELTRANSFORMPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewGetPixelTransformParameterivEXT : TPFNGLGETPIXELTRANSFORMPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewPixelTransformParameterfEXT : TPFNGLPIXELTRANSFORMPARAMETERFEXTPROC;cvar;external libGLEW;
    __glewPixelTransformParameterfvEXT : TPFNGLPIXELTRANSFORMPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewPixelTransformParameteriEXT : TPFNGLPIXELTRANSFORMPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewPixelTransformParameterivEXT : TPFNGLPIXELTRANSFORMPARAMETERIVEXTPROC;cvar;external libGLEW;
    __glewPointParameterfEXT : TPFNGLPOINTPARAMETERFEXTPROC;cvar;external libGLEW;
    __glewPointParameterfvEXT : TPFNGLPOINTPARAMETERFVEXTPROC;cvar;external libGLEW;
    __glewPolygonOffsetEXT : TPFNGLPOLYGONOFFSETEXTPROC;cvar;external libGLEW;
    __glewPolygonOffsetClampEXT : TPFNGLPOLYGONOFFSETCLAMPEXTPROC;cvar;external libGLEW;
    __glewPrimitiveBoundingBoxEXT : TPFNGLPRIMITIVEBOUNDINGBOXEXTPROC;cvar;external libGLEW;
    __glewProvokingVertexEXT : TPFNGLPROVOKINGVERTEXEXTPROC;cvar;external libGLEW;
    __glewCoverageModulationNV : TPFNGLCOVERAGEMODULATIONNVPROC;cvar;external libGLEW;
    __glewCoverageModulationTableNV : TPFNGLCOVERAGEMODULATIONTABLENVPROC;cvar;external libGLEW;
    __glewGetCoverageModulationTableNV : TPFNGLGETCOVERAGEMODULATIONTABLENVPROC;cvar;external libGLEW;
    __glewRasterSamplesEXT : TPFNGLRASTERSAMPLESEXTPROC;cvar;external libGLEW;
    __glewGetnUniformfvEXT : TPFNGLGETNUNIFORMFVEXTPROC;cvar;external libGLEW;
    __glewGetnUniformivEXT : TPFNGLGETNUNIFORMIVEXTPROC;cvar;external libGLEW;
    __glewReadnPixelsEXT : TPFNGLREADNPIXELSEXTPROC;cvar;external libGLEW;
    __glewBeginSceneEXT : TPFNGLBEGINSCENEEXTPROC;cvar;external libGLEW;
    __glewEndSceneEXT : TPFNGLENDSCENEEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3bEXT : TPFNGLSECONDARYCOLOR3BEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3bvEXT : TPFNGLSECONDARYCOLOR3BVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3dEXT : TPFNGLSECONDARYCOLOR3DEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3dvEXT : TPFNGLSECONDARYCOLOR3DVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3fEXT : TPFNGLSECONDARYCOLOR3FEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3fvEXT : TPFNGLSECONDARYCOLOR3FVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3iEXT : TPFNGLSECONDARYCOLOR3IEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3ivEXT : TPFNGLSECONDARYCOLOR3IVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3sEXT : TPFNGLSECONDARYCOLOR3SEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3svEXT : TPFNGLSECONDARYCOLOR3SVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3ubEXT : TPFNGLSECONDARYCOLOR3UBEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3ubvEXT : TPFNGLSECONDARYCOLOR3UBVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3uiEXT : TPFNGLSECONDARYCOLOR3UIEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3uivEXT : TPFNGLSECONDARYCOLOR3UIVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3usEXT : TPFNGLSECONDARYCOLOR3USEXTPROC;cvar;external libGLEW;
    __glewSecondaryColor3usvEXT : TPFNGLSECONDARYCOLOR3USVEXTPROC;cvar;external libGLEW;
    __glewSecondaryColorPointerEXT : TPFNGLSECONDARYCOLORPOINTEREXTPROC;cvar;external libGLEW;
    __glewDeleteSemaphoresEXT : TPFNGLDELETESEMAPHORESEXTPROC;cvar;external libGLEW;
    __glewGenSemaphoresEXT : TPFNGLGENSEMAPHORESEXTPROC;cvar;external libGLEW;
    __glewGetSemaphoreParameterui64vEXT : TPFNGLGETSEMAPHOREPARAMETERUI64VEXTPROC;cvar;external libGLEW;
    __glewIsSemaphoreEXT : TPFNGLISSEMAPHOREEXTPROC;cvar;external libGLEW;
    __glewSemaphoreParameterui64vEXT : TPFNGLSEMAPHOREPARAMETERUI64VEXTPROC;cvar;external libGLEW;
    __glewSignalSemaphoreEXT : TPFNGLSIGNALSEMAPHOREEXTPROC;cvar;external libGLEW;
    __glewWaitSemaphoreEXT : TPFNGLWAITSEMAPHOREEXTPROC;cvar;external libGLEW;
    __glewImportSemaphoreFdEXT : TPFNGLIMPORTSEMAPHOREFDEXTPROC;cvar;external libGLEW;
    __glewImportSemaphoreWin32HandleEXT : TPFNGLIMPORTSEMAPHOREWIN32HANDLEEXTPROC;cvar;external libGLEW;
    __glewImportSemaphoreWin32NameEXT : TPFNGLIMPORTSEMAPHOREWIN32NAMEEXTPROC;cvar;external libGLEW;
    __glewActiveProgramEXT : TPFNGLACTIVEPROGRAMEXTPROC;cvar;external libGLEW;
    __glewCreateShaderProgramEXT : TPFNGLCREATESHADERPROGRAMEXTPROC;cvar;external libGLEW;
    __glewUseShaderProgramEXT : TPFNGLUSESHADERPROGRAMEXTPROC;cvar;external libGLEW;
    __glewFramebufferFetchBarrierEXT : TPFNGLFRAMEBUFFERFETCHBARRIEREXTPROC;cvar;external libGLEW;
    __glewBindImageTextureEXT : TPFNGLBINDIMAGETEXTUREEXTPROC;cvar;external libGLEW;
    __glewMemoryBarrierEXT : TPFNGLMEMORYBARRIEREXTPROC;cvar;external libGLEW;
    __glewClearPixelLocalStorageuiEXT : TPFNGLCLEARPIXELLOCALSTORAGEUIEXTPROC;cvar;external libGLEW;
    __glewFramebufferPixelLocalStorageSizeEXT : TPFNGLFRAMEBUFFERPIXELLOCALSTORAGESIZEEXTPROC;cvar;external libGLEW;
    __glewGetFramebufferPixelLocalStorageSizeEXT : TPFNGLGETFRAMEBUFFERPIXELLOCALSTORAGESIZEEXTPROC;cvar;external libGLEW;
    __glewTexPageCommitmentEXT : TPFNGLTEXPAGECOMMITMENTEXTPROC;cvar;external libGLEW;
    __glewTexturePageCommitmentEXT : TPFNGLTEXTUREPAGECOMMITMENTEXTPROC;cvar;external libGLEW;
    __glewActiveStencilFaceEXT : TPFNGLACTIVESTENCILFACEEXTPROC;cvar;external libGLEW;
    __glewTexSubImage1DEXT : TPFNGLTEXSUBIMAGE1DEXTPROC;cvar;external libGLEW;
    __glewTexSubImage2DEXT : TPFNGLTEXSUBIMAGE2DEXTPROC;cvar;external libGLEW;
    __glewTexSubImage3DEXT : TPFNGLTEXSUBIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewPatchParameteriEXT : TPFNGLPATCHPARAMETERIEXTPROC;cvar;external libGLEW;
    __glewTexImage3DEXT : TPFNGLTEXIMAGE3DEXTPROC;cvar;external libGLEW;
    __glewFramebufferTextureLayerEXT : TPFNGLFRAMEBUFFERTEXTURELAYEREXTPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIivEXT : TPFNGLGETSAMPLERPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIuivEXT : TPFNGLGETSAMPLERPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewSamplerParameterIivEXT : TPFNGLSAMPLERPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewSamplerParameterIuivEXT : TPFNGLSAMPLERPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewTexBufferEXT : TPFNGLTEXBUFFEREXTPROC;cvar;external libGLEW;
    __glewClearColorIiEXT : TPFNGLCLEARCOLORIIEXTPROC;cvar;external libGLEW;
    __glewClearColorIuiEXT : TPFNGLCLEARCOLORIUIEXTPROC;cvar;external libGLEW;
    __glewGetTexParameterIivEXT : TPFNGLGETTEXPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewGetTexParameterIuivEXT : TPFNGLGETTEXPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewTexParameterIivEXT : TPFNGLTEXPARAMETERIIVEXTPROC;cvar;external libGLEW;
    __glewTexParameterIuivEXT : TPFNGLTEXPARAMETERIUIVEXTPROC;cvar;external libGLEW;
    __glewAreTexturesResidentEXT : TPFNGLARETEXTURESRESIDENTEXTPROC;cvar;external libGLEW;
    __glewBindTextureEXT : TPFNGLBINDTEXTUREEXTPROC;cvar;external libGLEW;
    __glewDeleteTexturesEXT : TPFNGLDELETETEXTURESEXTPROC;cvar;external libGLEW;
    __glewGenTexturesEXT : TPFNGLGENTEXTURESEXTPROC;cvar;external libGLEW;
    __glewIsTextureEXT : TPFNGLISTEXTUREEXTPROC;cvar;external libGLEW;
    __glewPrioritizeTexturesEXT : TPFNGLPRIORITIZETEXTURESEXTPROC;cvar;external libGLEW;
    __glewTextureNormalEXT : TPFNGLTEXTURENORMALEXTPROC;cvar;external libGLEW;
    __glewTexStorage1DEXT : TPFNGLTEXSTORAGE1DEXTPROC;cvar;external libGLEW;
    __glewTexStorage2DEXT : TPFNGLTEXSTORAGE2DEXTPROC;cvar;external libGLEW;
    __glewTexStorage3DEXT : TPFNGLTEXSTORAGE3DEXTPROC;cvar;external libGLEW;
    __glewTextureStorage1DEXT : TPFNGLTEXTURESTORAGE1DEXTPROC;cvar;external libGLEW;
    __glewTextureStorage2DEXT : TPFNGLTEXTURESTORAGE2DEXTPROC;cvar;external libGLEW;
    __glewTextureStorage3DEXT : TPFNGLTEXTURESTORAGE3DEXTPROC;cvar;external libGLEW;
    __glewTextureViewEXT : TPFNGLTEXTUREVIEWEXTPROC;cvar;external libGLEW;
    __glewGetQueryObjecti64vEXT : TPFNGLGETQUERYOBJECTI64VEXTPROC;cvar;external libGLEW;
    __glewGetQueryObjectui64vEXT : TPFNGLGETQUERYOBJECTUI64VEXTPROC;cvar;external libGLEW;
    __glewBeginTransformFeedbackEXT : TPFNGLBEGINTRANSFORMFEEDBACKEXTPROC;cvar;external libGLEW;
    __glewBindBufferBaseEXT : TPFNGLBINDBUFFERBASEEXTPROC;cvar;external libGLEW;
    __glewBindBufferOffsetEXT : TPFNGLBINDBUFFEROFFSETEXTPROC;cvar;external libGLEW;
    __glewBindBufferRangeEXT : TPFNGLBINDBUFFERRANGEEXTPROC;cvar;external libGLEW;
    __glewEndTransformFeedbackEXT : TPFNGLENDTRANSFORMFEEDBACKEXTPROC;cvar;external libGLEW;
    __glewGetTransformFeedbackVaryingEXT : TPFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC;cvar;external libGLEW;
    __glewTransformFeedbackVaryingsEXT : TPFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC;cvar;external libGLEW;
    __glewArrayElementEXT : TPFNGLARRAYELEMENTEXTPROC;cvar;external libGLEW;
    __glewColorPointerEXT : TPFNGLCOLORPOINTEREXTPROC;cvar;external libGLEW;
    __glewDrawArraysEXT : TPFNGLDRAWARRAYSEXTPROC;cvar;external libGLEW;
    __glewEdgeFlagPointerEXT : TPFNGLEDGEFLAGPOINTEREXTPROC;cvar;external libGLEW;
    __glewIndexPointerEXT : TPFNGLINDEXPOINTEREXTPROC;cvar;external libGLEW;
    __glewNormalPointerEXT : TPFNGLNORMALPOINTEREXTPROC;cvar;external libGLEW;
    __glewTexCoordPointerEXT : TPFNGLTEXCOORDPOINTEREXTPROC;cvar;external libGLEW;
    __glewVertexPointerEXT : TPFNGLVERTEXPOINTEREXTPROC;cvar;external libGLEW;
    __glewBindArraySetEXT : TPFNGLBINDARRAYSETEXTPROC;cvar;external libGLEW;
    __glewCreateArraySetExt : TPFNGLCREATEARRAYSETEXTPROC;cvar;external libGLEW;
    __glewDeleteArraySetsEXT : TPFNGLDELETEARRAYSETSEXTPROC;cvar;external libGLEW;
    __glewGetVertexAttribLdvEXT : TPFNGLGETVERTEXATTRIBLDVEXTPROC;cvar;external libGLEW;
    __glewVertexArrayVertexAttribLOffsetEXT : TPFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL1dEXT : TPFNGLVERTEXATTRIBL1DEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL1dvEXT : TPFNGLVERTEXATTRIBL1DVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL2dEXT : TPFNGLVERTEXATTRIBL2DEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL2dvEXT : TPFNGLVERTEXATTRIBL2DVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL3dEXT : TPFNGLVERTEXATTRIBL3DEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL3dvEXT : TPFNGLVERTEXATTRIBL3DVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL4dEXT : TPFNGLVERTEXATTRIBL4DEXTPROC;cvar;external libGLEW;
    __glewVertexAttribL4dvEXT : TPFNGLVERTEXATTRIBL4DVEXTPROC;cvar;external libGLEW;
    __glewVertexAttribLPointerEXT : TPFNGLVERTEXATTRIBLPOINTEREXTPROC;cvar;external libGLEW;
    __glewBeginVertexShaderEXT : TPFNGLBEGINVERTEXSHADEREXTPROC;cvar;external libGLEW;
    __glewBindLightParameterEXT : TPFNGLBINDLIGHTPARAMETEREXTPROC;cvar;external libGLEW;
    __glewBindMaterialParameterEXT : TPFNGLBINDMATERIALPARAMETEREXTPROC;cvar;external libGLEW;
    __glewBindParameterEXT : TPFNGLBINDPARAMETEREXTPROC;cvar;external libGLEW;
    __glewBindTexGenParameterEXT : TPFNGLBINDTEXGENPARAMETEREXTPROC;cvar;external libGLEW;
    __glewBindTextureUnitParameterEXT : TPFNGLBINDTEXTUREUNITPARAMETEREXTPROC;cvar;external libGLEW;
    __glewBindVertexShaderEXT : TPFNGLBINDVERTEXSHADEREXTPROC;cvar;external libGLEW;
    __glewDeleteVertexShaderEXT : TPFNGLDELETEVERTEXSHADEREXTPROC;cvar;external libGLEW;
    __glewDisableVariantClientStateEXT : TPFNGLDISABLEVARIANTCLIENTSTATEEXTPROC;cvar;external libGLEW;
    __glewEnableVariantClientStateEXT : TPFNGLENABLEVARIANTCLIENTSTATEEXTPROC;cvar;external libGLEW;
    __glewEndVertexShaderEXT : TPFNGLENDVERTEXSHADEREXTPROC;cvar;external libGLEW;
    __glewExtractComponentEXT : TPFNGLEXTRACTCOMPONENTEXTPROC;cvar;external libGLEW;
    __glewGenSymbolsEXT : TPFNGLGENSYMBOLSEXTPROC;cvar;external libGLEW;
    __glewGenVertexShadersEXT : TPFNGLGENVERTEXSHADERSEXTPROC;cvar;external libGLEW;
    __glewGetInvariantBooleanvEXT : TPFNGLGETINVARIANTBOOLEANVEXTPROC;cvar;external libGLEW;
    __glewGetInvariantFloatvEXT : TPFNGLGETINVARIANTFLOATVEXTPROC;cvar;external libGLEW;
    __glewGetInvariantIntegervEXT : TPFNGLGETINVARIANTINTEGERVEXTPROC;cvar;external libGLEW;
    __glewGetLocalConstantBooleanvEXT : TPFNGLGETLOCALCONSTANTBOOLEANVEXTPROC;cvar;external libGLEW;
    __glewGetLocalConstantFloatvEXT : TPFNGLGETLOCALCONSTANTFLOATVEXTPROC;cvar;external libGLEW;
    __glewGetLocalConstantIntegervEXT : TPFNGLGETLOCALCONSTANTINTEGERVEXTPROC;cvar;external libGLEW;
    __glewGetVariantBooleanvEXT : TPFNGLGETVARIANTBOOLEANVEXTPROC;cvar;external libGLEW;
    __glewGetVariantFloatvEXT : TPFNGLGETVARIANTFLOATVEXTPROC;cvar;external libGLEW;
    __glewGetVariantIntegervEXT : TPFNGLGETVARIANTINTEGERVEXTPROC;cvar;external libGLEW;
    __glewGetVariantPointervEXT : TPFNGLGETVARIANTPOINTERVEXTPROC;cvar;external libGLEW;
    __glewInsertComponentEXT : TPFNGLINSERTCOMPONENTEXTPROC;cvar;external libGLEW;
    __glewIsVariantEnabledEXT : TPFNGLISVARIANTENABLEDEXTPROC;cvar;external libGLEW;
    __glewSetInvariantEXT : TPFNGLSETINVARIANTEXTPROC;cvar;external libGLEW;
    __glewSetLocalConstantEXT : TPFNGLSETLOCALCONSTANTEXTPROC;cvar;external libGLEW;
    __glewShaderOp1EXT : TPFNGLSHADEROP1EXTPROC;cvar;external libGLEW;
    __glewShaderOp2EXT : TPFNGLSHADEROP2EXTPROC;cvar;external libGLEW;
    __glewShaderOp3EXT : TPFNGLSHADEROP3EXTPROC;cvar;external libGLEW;
    __glewSwizzleEXT : TPFNGLSWIZZLEEXTPROC;cvar;external libGLEW;
    __glewVariantPointerEXT : TPFNGLVARIANTPOINTEREXTPROC;cvar;external libGLEW;
    __glewVariantbvEXT : TPFNGLVARIANTBVEXTPROC;cvar;external libGLEW;
    __glewVariantdvEXT : TPFNGLVARIANTDVEXTPROC;cvar;external libGLEW;
    __glewVariantfvEXT : TPFNGLVARIANTFVEXTPROC;cvar;external libGLEW;
    __glewVariantivEXT : TPFNGLVARIANTIVEXTPROC;cvar;external libGLEW;
    __glewVariantsvEXT : TPFNGLVARIANTSVEXTPROC;cvar;external libGLEW;
    __glewVariantubvEXT : TPFNGLVARIANTUBVEXTPROC;cvar;external libGLEW;
    __glewVariantuivEXT : TPFNGLVARIANTUIVEXTPROC;cvar;external libGLEW;
    __glewVariantusvEXT : TPFNGLVARIANTUSVEXTPROC;cvar;external libGLEW;
    __glewWriteMaskEXT : TPFNGLWRITEMASKEXTPROC;cvar;external libGLEW;
    __glewVertexWeightPointerEXT : TPFNGLVERTEXWEIGHTPOINTEREXTPROC;cvar;external libGLEW;
    __glewVertexWeightfEXT : TPFNGLVERTEXWEIGHTFEXTPROC;cvar;external libGLEW;
    __glewVertexWeightfvEXT : TPFNGLVERTEXWEIGHTFVEXTPROC;cvar;external libGLEW;
    __glewAcquireKeyedMutexWin32EXT : TPFNGLACQUIREKEYEDMUTEXWIN32EXTPROC;cvar;external libGLEW;
    __glewReleaseKeyedMutexWin32EXT : TPFNGLRELEASEKEYEDMUTEXWIN32EXTPROC;cvar;external libGLEW;
    __glewWindowRectanglesEXT : TPFNGLWINDOWRECTANGLESEXTPROC;cvar;external libGLEW;
    __glewImportSyncEXT : TPFNGLIMPORTSYNCEXTPROC;cvar;external libGLEW;
    __glewFrameTerminatorGREMEDY : TPFNGLFRAMETERMINATORGREMEDYPROC;cvar;external libGLEW;
    __glewStringMarkerGREMEDY : TPFNGLSTRINGMARKERGREMEDYPROC;cvar;external libGLEW;
    __glewGetImageTransformParameterfvHP : TPFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC;cvar;external libGLEW;
    __glewGetImageTransformParameterivHP : TPFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC;cvar;external libGLEW;
    __glewImageTransformParameterfHP : TPFNGLIMAGETRANSFORMPARAMETERFHPPROC;cvar;external libGLEW;
    __glewImageTransformParameterfvHP : TPFNGLIMAGETRANSFORMPARAMETERFVHPPROC;cvar;external libGLEW;
    __glewImageTransformParameteriHP : TPFNGLIMAGETRANSFORMPARAMETERIHPPROC;cvar;external libGLEW;
    __glewImageTransformParameterivHP : TPFNGLIMAGETRANSFORMPARAMETERIVHPPROC;cvar;external libGLEW;
    __glewMultiModeDrawArraysIBM : TPFNGLMULTIMODEDRAWARRAYSIBMPROC;cvar;external libGLEW;
    __glewMultiModeDrawElementsIBM : TPFNGLMULTIMODEDRAWELEMENTSIBMPROC;cvar;external libGLEW;
    __glewColorPointerListIBM : TPFNGLCOLORPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewEdgeFlagPointerListIBM : TPFNGLEDGEFLAGPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewFogCoordPointerListIBM : TPFNGLFOGCOORDPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewIndexPointerListIBM : TPFNGLINDEXPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewNormalPointerListIBM : TPFNGLNORMALPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewSecondaryColorPointerListIBM : TPFNGLSECONDARYCOLORPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewTexCoordPointerListIBM : TPFNGLTEXCOORDPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewVertexPointerListIBM : TPFNGLVERTEXPOINTERLISTIBMPROC;cvar;external libGLEW;
    __glewGetTextureHandleIMG : TPFNGLGETTEXTUREHANDLEIMGPROC;cvar;external libGLEW;
    __glewGetTextureSamplerHandleIMG : TPFNGLGETTEXTURESAMPLERHANDLEIMGPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64IMG : TPFNGLPROGRAMUNIFORMHANDLEUI64IMGPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64vIMG : TPFNGLPROGRAMUNIFORMHANDLEUI64VIMGPROC;cvar;external libGLEW;
    __glewUniformHandleui64IMG : TPFNGLUNIFORMHANDLEUI64IMGPROC;cvar;external libGLEW;
    __glewUniformHandleui64vIMG : TPFNGLUNIFORMHANDLEUI64VIMGPROC;cvar;external libGLEW;
    __glewFramebufferTexture2DDownsampleIMG : TPFNGLFRAMEBUFFERTEXTURE2DDOWNSAMPLEIMGPROC;cvar;external libGLEW;
    __glewFramebufferTextureLayerDownsampleIMG : TPFNGLFRAMEBUFFERTEXTURELAYERDOWNSAMPLEIMGPROC;cvar;external libGLEW;
    __glewFramebufferTexture2DMultisampleIMG : TPFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMGPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleIMG : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMGPROC;cvar;external libGLEW;
    __glewMapTexture2DINTEL : TPFNGLMAPTEXTURE2DINTELPROC;cvar;external libGLEW;
    __glewSyncTextureINTEL : TPFNGLSYNCTEXTUREINTELPROC;cvar;external libGLEW;
    __glewUnmapTexture2DINTEL : TPFNGLUNMAPTEXTURE2DINTELPROC;cvar;external libGLEW;
    __glewColorPointervINTEL : TPFNGLCOLORPOINTERVINTELPROC;cvar;external libGLEW;
    __glewNormalPointervINTEL : TPFNGLNORMALPOINTERVINTELPROC;cvar;external libGLEW;
    __glewTexCoordPointervINTEL : TPFNGLTEXCOORDPOINTERVINTELPROC;cvar;external libGLEW;
    __glewVertexPointervINTEL : TPFNGLVERTEXPOINTERVINTELPROC;cvar;external libGLEW;
    __glewBeginPerfQueryINTEL : TPFNGLBEGINPERFQUERYINTELPROC;cvar;external libGLEW;
    __glewCreatePerfQueryINTEL : TPFNGLCREATEPERFQUERYINTELPROC;cvar;external libGLEW;
    __glewDeletePerfQueryINTEL : TPFNGLDELETEPERFQUERYINTELPROC;cvar;external libGLEW;
    __glewEndPerfQueryINTEL : TPFNGLENDPERFQUERYINTELPROC;cvar;external libGLEW;
    __glewGetFirstPerfQueryIdINTEL : TPFNGLGETFIRSTPERFQUERYIDINTELPROC;cvar;external libGLEW;
    __glewGetNextPerfQueryIdINTEL : TPFNGLGETNEXTPERFQUERYIDINTELPROC;cvar;external libGLEW;
    __glewGetPerfCounterInfoINTEL : TPFNGLGETPERFCOUNTERINFOINTELPROC;cvar;external libGLEW;
    __glewGetPerfQueryDataINTEL : TPFNGLGETPERFQUERYDATAINTELPROC;cvar;external libGLEW;
    __glewGetPerfQueryIdByNameINTEL : TPFNGLGETPERFQUERYIDBYNAMEINTELPROC;cvar;external libGLEW;
    __glewGetPerfQueryInfoINTEL : TPFNGLGETPERFQUERYINFOINTELPROC;cvar;external libGLEW;
    __glewTexScissorFuncINTEL : TPFNGLTEXSCISSORFUNCINTELPROC;cvar;external libGLEW;
    __glewTexScissorINTEL : TPFNGLTEXSCISSORINTELPROC;cvar;external libGLEW;
    __glewBlendBarrierKHR : TPFNGLBLENDBARRIERKHRPROC;cvar;external libGLEW;
    __glewDebugMessageCallback : TPFNGLDEBUGMESSAGECALLBACKPROC;cvar;external libGLEW;
    __glewDebugMessageControl : TPFNGLDEBUGMESSAGECONTROLPROC;cvar;external libGLEW;
    __glewDebugMessageInsert : TPFNGLDEBUGMESSAGEINSERTPROC;cvar;external libGLEW;
    __glewGetDebugMessageLog : TPFNGLGETDEBUGMESSAGELOGPROC;cvar;external libGLEW;
    __glewGetObjectLabel : TPFNGLGETOBJECTLABELPROC;cvar;external libGLEW;
    __glewGetObjectPtrLabel : TPFNGLGETOBJECTPTRLABELPROC;cvar;external libGLEW;
    __glewObjectLabel : TPFNGLOBJECTLABELPROC;cvar;external libGLEW;
    __glewObjectPtrLabel : TPFNGLOBJECTPTRLABELPROC;cvar;external libGLEW;
    __glewPopDebugGroup : TPFNGLPOPDEBUGGROUPPROC;cvar;external libGLEW;
    __glewPushDebugGroup : TPFNGLPUSHDEBUGGROUPPROC;cvar;external libGLEW;
    __glewMaxShaderCompilerThreadsKHR : TPFNGLMAXSHADERCOMPILERTHREADSKHRPROC;cvar;external libGLEW;
    __glewGetnUniformfv : TPFNGLGETNUNIFORMFVPROC;cvar;external libGLEW;
    __glewGetnUniformiv : TPFNGLGETNUNIFORMIVPROC;cvar;external libGLEW;
    __glewGetnUniformuiv : TPFNGLGETNUNIFORMUIVPROC;cvar;external libGLEW;
    __glewReadnPixels : TPFNGLREADNPIXELSPROC;cvar;external libGLEW;
    __glewBufferRegionEnabled : TPFNGLBUFFERREGIONENABLEDPROC;cvar;external libGLEW;
    __glewDeleteBufferRegion : TPFNGLDELETEBUFFERREGIONPROC;cvar;external libGLEW;
    __glewDrawBufferRegion : TPFNGLDRAWBUFFERREGIONPROC;cvar;external libGLEW;
    __glewNewBufferRegion : TPFNGLNEWBUFFERREGIONPROC;cvar;external libGLEW;
    __glewReadBufferRegion : TPFNGLREADBUFFERREGIONPROC;cvar;external libGLEW;
    __glewFramebufferParameteriMESA : TPFNGLFRAMEBUFFERPARAMETERIMESAPROC;cvar;external libGLEW;
    __glewGetFramebufferParameterivMESA : TPFNGLGETFRAMEBUFFERPARAMETERIVMESAPROC;cvar;external libGLEW;
    __glewResizeBuffersMESA : TPFNGLRESIZEBUFFERSMESAPROC;cvar;external libGLEW;
    __glewWindowPos2dMESA : TPFNGLWINDOWPOS2DMESAPROC;cvar;external libGLEW;
    __glewWindowPos2dvMESA : TPFNGLWINDOWPOS2DVMESAPROC;cvar;external libGLEW;
    __glewWindowPos2fMESA : TPFNGLWINDOWPOS2FMESAPROC;cvar;external libGLEW;
    __glewWindowPos2fvMESA : TPFNGLWINDOWPOS2FVMESAPROC;cvar;external libGLEW;
    __glewWindowPos2iMESA : TPFNGLWINDOWPOS2IMESAPROC;cvar;external libGLEW;
    __glewWindowPos2ivMESA : TPFNGLWINDOWPOS2IVMESAPROC;cvar;external libGLEW;
    __glewWindowPos2sMESA : TPFNGLWINDOWPOS2SMESAPROC;cvar;external libGLEW;
    __glewWindowPos2svMESA : TPFNGLWINDOWPOS2SVMESAPROC;cvar;external libGLEW;
    __glewWindowPos3dMESA : TPFNGLWINDOWPOS3DMESAPROC;cvar;external libGLEW;
    __glewWindowPos3dvMESA : TPFNGLWINDOWPOS3DVMESAPROC;cvar;external libGLEW;
    __glewWindowPos3fMESA : TPFNGLWINDOWPOS3FMESAPROC;cvar;external libGLEW;
    __glewWindowPos3fvMESA : TPFNGLWINDOWPOS3FVMESAPROC;cvar;external libGLEW;
    __glewWindowPos3iMESA : TPFNGLWINDOWPOS3IMESAPROC;cvar;external libGLEW;
    __glewWindowPos3ivMESA : TPFNGLWINDOWPOS3IVMESAPROC;cvar;external libGLEW;
    __glewWindowPos3sMESA : TPFNGLWINDOWPOS3SMESAPROC;cvar;external libGLEW;
    __glewWindowPos3svMESA : TPFNGLWINDOWPOS3SVMESAPROC;cvar;external libGLEW;
    __glewWindowPos4dMESA : TPFNGLWINDOWPOS4DMESAPROC;cvar;external libGLEW;
    __glewWindowPos4dvMESA : TPFNGLWINDOWPOS4DVMESAPROC;cvar;external libGLEW;
    __glewWindowPos4fMESA : TPFNGLWINDOWPOS4FMESAPROC;cvar;external libGLEW;
    __glewWindowPos4fvMESA : TPFNGLWINDOWPOS4FVMESAPROC;cvar;external libGLEW;
    __glewWindowPos4iMESA : TPFNGLWINDOWPOS4IMESAPROC;cvar;external libGLEW;
    __glewWindowPos4ivMESA : TPFNGLWINDOWPOS4IVMESAPROC;cvar;external libGLEW;
    __glewWindowPos4sMESA : TPFNGLWINDOWPOS4SMESAPROC;cvar;external libGLEW;
    __glewWindowPos4svMESA : TPFNGLWINDOWPOS4SVMESAPROC;cvar;external libGLEW;
    __glewBeginConditionalRenderNVX : TPFNGLBEGINCONDITIONALRENDERNVXPROC;cvar;external libGLEW;
    __glewEndConditionalRenderNVX : TPFNGLENDCONDITIONALRENDERNVXPROC;cvar;external libGLEW;
    __glewAsyncCopyBufferSubDataNVX : TPFNGLASYNCCOPYBUFFERSUBDATANVXPROC;cvar;external libGLEW;
    __glewAsyncCopyImageSubDataNVX : TPFNGLASYNCCOPYIMAGESUBDATANVXPROC;cvar;external libGLEW;
    __glewMulticastScissorArrayvNVX : TPFNGLMULTICASTSCISSORARRAYVNVXPROC;cvar;external libGLEW;
    __glewMulticastViewportArrayvNVX : TPFNGLMULTICASTVIEWPORTARRAYVNVXPROC;cvar;external libGLEW;
    __glewMulticastViewportPositionWScaleNVX : TPFNGLMULTICASTVIEWPORTPOSITIONWSCALENVXPROC;cvar;external libGLEW;
    __glewUploadGpuMaskNVX : TPFNGLUPLOADGPUMASKNVXPROC;cvar;external libGLEW;
    __glewLGPUCopyImageSubDataNVX : TPFNGLLGPUCOPYIMAGESUBDATANVXPROC;cvar;external libGLEW;
    __glewLGPUInterlockNVX : TPFNGLLGPUINTERLOCKNVXPROC;cvar;external libGLEW;
    __glewLGPUNamedBufferSubDataNVX : TPFNGLLGPUNAMEDBUFFERSUBDATANVXPROC;cvar;external libGLEW;
    __glewClientWaitSemaphoreui64NVX : TPFNGLCLIENTWAITSEMAPHOREUI64NVXPROC;cvar;external libGLEW;
    __glewSignalSemaphoreui64NVX : TPFNGLSIGNALSEMAPHOREUI64NVXPROC;cvar;external libGLEW;
    __glewWaitSemaphoreui64NVX : TPFNGLWAITSEMAPHOREUI64NVXPROC;cvar;external libGLEW;
    __glewStereoParameterfNV : TPFNGLSTEREOPARAMETERFNVPROC;cvar;external libGLEW;
    __glewStereoParameteriNV : TPFNGLSTEREOPARAMETERINVPROC;cvar;external libGLEW;
    __glewAlphaToCoverageDitherControlNV : TPFNGLALPHATOCOVERAGEDITHERCONTROLNVPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectBindlessNV : TPFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectBindlessNV : TPFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC;cvar;external libGLEW;
    __glewMultiDrawArraysIndirectBindlessCountNV : TPFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC;cvar;external libGLEW;
    __glewMultiDrawElementsIndirectBindlessCountNV : TPFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC;cvar;external libGLEW;
    __glewGetImageHandleNV : TPFNGLGETIMAGEHANDLENVPROC;cvar;external libGLEW;
    __glewGetTextureHandleNV : TPFNGLGETTEXTUREHANDLENVPROC;cvar;external libGLEW;
    __glewGetTextureSamplerHandleNV : TPFNGLGETTEXTURESAMPLERHANDLENVPROC;cvar;external libGLEW;
    __glewIsImageHandleResidentNV : TPFNGLISIMAGEHANDLERESIDENTNVPROC;cvar;external libGLEW;
    __glewIsTextureHandleResidentNV : TPFNGLISTEXTUREHANDLERESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeImageHandleNonResidentNV : TPFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeImageHandleResidentNV : TPFNGLMAKEIMAGEHANDLERESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeTextureHandleNonResidentNV : TPFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeTextureHandleResidentNV : TPFNGLMAKETEXTUREHANDLERESIDENTNVPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64NV : TPFNGLPROGRAMUNIFORMHANDLEUI64NVPROC;cvar;external libGLEW;
    __glewProgramUniformHandleui64vNV : TPFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC;cvar;external libGLEW;
    __glewUniformHandleui64NV : TPFNGLUNIFORMHANDLEUI64NVPROC;cvar;external libGLEW;
    __glewUniformHandleui64vNV : TPFNGLUNIFORMHANDLEUI64VNVPROC;cvar;external libGLEW;
    __glewBlendBarrierNV : TPFNGLBLENDBARRIERNVPROC;cvar;external libGLEW;
    __glewBlendParameteriNV : TPFNGLBLENDPARAMETERINVPROC;cvar;external libGLEW;
    __glewViewportPositionWScaleNV : TPFNGLVIEWPORTPOSITIONWSCALENVPROC;cvar;external libGLEW;
    __glewCallCommandListNV : TPFNGLCALLCOMMANDLISTNVPROC;cvar;external libGLEW;
    __glewCommandListSegmentsNV : TPFNGLCOMMANDLISTSEGMENTSNVPROC;cvar;external libGLEW;
    __glewCompileCommandListNV : TPFNGLCOMPILECOMMANDLISTNVPROC;cvar;external libGLEW;
    __glewCreateCommandListsNV : TPFNGLCREATECOMMANDLISTSNVPROC;cvar;external libGLEW;
    __glewCreateStatesNV : TPFNGLCREATESTATESNVPROC;cvar;external libGLEW;
    __glewDeleteCommandListsNV : TPFNGLDELETECOMMANDLISTSNVPROC;cvar;external libGLEW;
    __glewDeleteStatesNV : TPFNGLDELETESTATESNVPROC;cvar;external libGLEW;
    __glewDrawCommandsAddressNV : TPFNGLDRAWCOMMANDSADDRESSNVPROC;cvar;external libGLEW;
    __glewDrawCommandsNV : TPFNGLDRAWCOMMANDSNVPROC;cvar;external libGLEW;
    __glewDrawCommandsStatesAddressNV : TPFNGLDRAWCOMMANDSSTATESADDRESSNVPROC;cvar;external libGLEW;
    __glewDrawCommandsStatesNV : TPFNGLDRAWCOMMANDSSTATESNVPROC;cvar;external libGLEW;
    __glewGetCommandHeaderNV : TPFNGLGETCOMMANDHEADERNVPROC;cvar;external libGLEW;
    __glewGetStageIndexNV : TPFNGLGETSTAGEINDEXNVPROC;cvar;external libGLEW;
    __glewIsCommandListNV : TPFNGLISCOMMANDLISTNVPROC;cvar;external libGLEW;
    __glewIsStateNV : TPFNGLISSTATENVPROC;cvar;external libGLEW;
    __glewListDrawCommandsStatesClientNV : TPFNGLLISTDRAWCOMMANDSSTATESCLIENTNVPROC;cvar;external libGLEW;
    __glewStateCaptureNV : TPFNGLSTATECAPTURENVPROC;cvar;external libGLEW;
    __glewBeginConditionalRenderNV : TPFNGLBEGINCONDITIONALRENDERNVPROC;cvar;external libGLEW;
    __glewEndConditionalRenderNV : TPFNGLENDCONDITIONALRENDERNVPROC;cvar;external libGLEW;
    __glewSubpixelPrecisionBiasNV : TPFNGLSUBPIXELPRECISIONBIASNVPROC;cvar;external libGLEW;
    __glewConservativeRasterParameterfNV : TPFNGLCONSERVATIVERASTERPARAMETERFNVPROC;cvar;external libGLEW;
    __glewConservativeRasterParameteriNV : TPFNGLCONSERVATIVERASTERPARAMETERINVPROC;cvar;external libGLEW;
    __glewCopyBufferSubDataNV : TPFNGLCOPYBUFFERSUBDATANVPROC;cvar;external libGLEW;
    __glewCopyImageSubDataNV : TPFNGLCOPYIMAGESUBDATANVPROC;cvar;external libGLEW;
    __glewClearDepthdNV : TPFNGLCLEARDEPTHDNVPROC;cvar;external libGLEW;
    __glewDepthBoundsdNV : TPFNGLDEPTHBOUNDSDNVPROC;cvar;external libGLEW;
    __glewDepthRangedNV : TPFNGLDEPTHRANGEDNVPROC;cvar;external libGLEW;
    __glewDrawBuffersNV : TPFNGLDRAWBUFFERSNVPROC;cvar;external libGLEW;
    __glewDrawArraysInstancedNV : TPFNGLDRAWARRAYSINSTANCEDNVPROC;cvar;external libGLEW;
    __glewDrawElementsInstancedNV : TPFNGLDRAWELEMENTSINSTANCEDNVPROC;cvar;external libGLEW;
    __glewDrawTextureNV : TPFNGLDRAWTEXTURENVPROC;cvar;external libGLEW;
    __glewDrawVkImageNV : TPFNGLDRAWVKIMAGENVPROC;cvar;external libGLEW;
    __glewGetVkProcAddrNV : TPFNGLGETVKPROCADDRNVPROC;cvar;external libGLEW;
    __glewSignalVkFenceNV : TPFNGLSIGNALVKFENCENVPROC;cvar;external libGLEW;
    __glewSignalVkSemaphoreNV : TPFNGLSIGNALVKSEMAPHORENVPROC;cvar;external libGLEW;
    __glewWaitVkSemaphoreNV : TPFNGLWAITVKSEMAPHORENVPROC;cvar;external libGLEW;
    __glewEvalMapsNV : TPFNGLEVALMAPSNVPROC;cvar;external libGLEW;
    __glewGetMapAttribParameterfvNV : TPFNGLGETMAPATTRIBPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetMapAttribParameterivNV : TPFNGLGETMAPATTRIBPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewGetMapControlPointsNV : TPFNGLGETMAPCONTROLPOINTSNVPROC;cvar;external libGLEW;
    __glewGetMapParameterfvNV : TPFNGLGETMAPPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetMapParameterivNV : TPFNGLGETMAPPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewMapControlPointsNV : TPFNGLMAPCONTROLPOINTSNVPROC;cvar;external libGLEW;
    __glewMapParameterfvNV : TPFNGLMAPPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewMapParameterivNV : TPFNGLMAPPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewGetMultisamplefvNV : TPFNGLGETMULTISAMPLEFVNVPROC;cvar;external libGLEW;
    __glewSampleMaskIndexedNV : TPFNGLSAMPLEMASKINDEXEDNVPROC;cvar;external libGLEW;
    __glewTexRenderbufferNV : TPFNGLTEXRENDERBUFFERNVPROC;cvar;external libGLEW;
    __glewDeleteFencesNV : TPFNGLDELETEFENCESNVPROC;cvar;external libGLEW;
    __glewFinishFenceNV : TPFNGLFINISHFENCENVPROC;cvar;external libGLEW;
    __glewGenFencesNV : TPFNGLGENFENCESNVPROC;cvar;external libGLEW;
    __glewGetFenceivNV : TPFNGLGETFENCEIVNVPROC;cvar;external libGLEW;
    __glewIsFenceNV : TPFNGLISFENCENVPROC;cvar;external libGLEW;
    __glewSetFenceNV : TPFNGLSETFENCENVPROC;cvar;external libGLEW;
    __glewTestFenceNV : TPFNGLTESTFENCENVPROC;cvar;external libGLEW;
    __glewFragmentCoverageColorNV : TPFNGLFRAGMENTCOVERAGECOLORNVPROC;cvar;external libGLEW;
    __glewGetProgramNamedParameterdvNV : TPFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC;cvar;external libGLEW;
    __glewGetProgramNamedParameterfvNV : TPFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewProgramNamedParameter4dNV : TPFNGLPROGRAMNAMEDPARAMETER4DNVPROC;cvar;external libGLEW;
    __glewProgramNamedParameter4dvNV : TPFNGLPROGRAMNAMEDPARAMETER4DVNVPROC;cvar;external libGLEW;
    __glewProgramNamedParameter4fNV : TPFNGLPROGRAMNAMEDPARAMETER4FNVPROC;cvar;external libGLEW;
    __glewProgramNamedParameter4fvNV : TPFNGLPROGRAMNAMEDPARAMETER4FVNVPROC;cvar;external libGLEW;
    __glewBlitFramebufferNV : TPFNGLBLITFRAMEBUFFERNVPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleNV : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLENVPROC;cvar;external libGLEW;
    __glewRenderbufferStorageMultisampleCoverageNV : TPFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC;cvar;external libGLEW;
    __glewProgramVertexLimitNV : TPFNGLPROGRAMVERTEXLIMITNVPROC;cvar;external libGLEW;
    __glewMulticastBarrierNV : TPFNGLMULTICASTBARRIERNVPROC;cvar;external libGLEW;
    __glewMulticastBlitFramebufferNV : TPFNGLMULTICASTBLITFRAMEBUFFERNVPROC;cvar;external libGLEW;
    __glewMulticastBufferSubDataNV : TPFNGLMULTICASTBUFFERSUBDATANVPROC;cvar;external libGLEW;
    __glewMulticastCopyBufferSubDataNV : TPFNGLMULTICASTCOPYBUFFERSUBDATANVPROC;cvar;external libGLEW;
    __glewMulticastCopyImageSubDataNV : TPFNGLMULTICASTCOPYIMAGESUBDATANVPROC;cvar;external libGLEW;
    __glewMulticastFramebufferSampleLocationsfvNV : TPFNGLMULTICASTFRAMEBUFFERSAMPLELOCATIONSFVNVPROC;cvar;external libGLEW;
    __glewMulticastGetQueryObjecti64vNV : TPFNGLMULTICASTGETQUERYOBJECTI64VNVPROC;cvar;external libGLEW;
    __glewMulticastGetQueryObjectivNV : TPFNGLMULTICASTGETQUERYOBJECTIVNVPROC;cvar;external libGLEW;
    __glewMulticastGetQueryObjectui64vNV : TPFNGLMULTICASTGETQUERYOBJECTUI64VNVPROC;cvar;external libGLEW;
    __glewMulticastGetQueryObjectuivNV : TPFNGLMULTICASTGETQUERYOBJECTUIVNVPROC;cvar;external libGLEW;
    __glewMulticastWaitSyncNV : TPFNGLMULTICASTWAITSYNCNVPROC;cvar;external libGLEW;
    __glewRenderGpuMaskNV : TPFNGLRENDERGPUMASKNVPROC;cvar;external libGLEW;
    __glewProgramEnvParameterI4iNV : TPFNGLPROGRAMENVPARAMETERI4INVPROC;cvar;external libGLEW;
    __glewProgramEnvParameterI4ivNV : TPFNGLPROGRAMENVPARAMETERI4IVNVPROC;cvar;external libGLEW;
    __glewProgramEnvParameterI4uiNV : TPFNGLPROGRAMENVPARAMETERI4UINVPROC;cvar;external libGLEW;
    __glewProgramEnvParameterI4uivNV : TPFNGLPROGRAMENVPARAMETERI4UIVNVPROC;cvar;external libGLEW;
    __glewProgramEnvParametersI4ivNV : TPFNGLPROGRAMENVPARAMETERSI4IVNVPROC;cvar;external libGLEW;
    __glewProgramEnvParametersI4uivNV : TPFNGLPROGRAMENVPARAMETERSI4UIVNVPROC;cvar;external libGLEW;
    __glewProgramLocalParameterI4iNV : TPFNGLPROGRAMLOCALPARAMETERI4INVPROC;cvar;external libGLEW;
    __glewProgramLocalParameterI4ivNV : TPFNGLPROGRAMLOCALPARAMETERI4IVNVPROC;cvar;external libGLEW;
    __glewProgramLocalParameterI4uiNV : TPFNGLPROGRAMLOCALPARAMETERI4UINVPROC;cvar;external libGLEW;
    __glewProgramLocalParameterI4uivNV : TPFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC;cvar;external libGLEW;
    __glewProgramLocalParametersI4ivNV : TPFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC;cvar;external libGLEW;
    __glewProgramLocalParametersI4uivNV : TPFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC;cvar;external libGLEW;
    __glewGetUniformi64vNV : TPFNGLGETUNIFORMI64VNVPROC;cvar;external libGLEW;
    __glewGetUniformui64vNV : TPFNGLGETUNIFORMUI64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform1i64NV : TPFNGLPROGRAMUNIFORM1I64NVPROC;cvar;external libGLEW;
    __glewProgramUniform1i64vNV : TPFNGLPROGRAMUNIFORM1I64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform1ui64NV : TPFNGLPROGRAMUNIFORM1UI64NVPROC;cvar;external libGLEW;
    __glewProgramUniform1ui64vNV : TPFNGLPROGRAMUNIFORM1UI64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform2i64NV : TPFNGLPROGRAMUNIFORM2I64NVPROC;cvar;external libGLEW;
    __glewProgramUniform2i64vNV : TPFNGLPROGRAMUNIFORM2I64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform2ui64NV : TPFNGLPROGRAMUNIFORM2UI64NVPROC;cvar;external libGLEW;
    __glewProgramUniform2ui64vNV : TPFNGLPROGRAMUNIFORM2UI64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform3i64NV : TPFNGLPROGRAMUNIFORM3I64NVPROC;cvar;external libGLEW;
    __glewProgramUniform3i64vNV : TPFNGLPROGRAMUNIFORM3I64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform3ui64NV : TPFNGLPROGRAMUNIFORM3UI64NVPROC;cvar;external libGLEW;
    __glewProgramUniform3ui64vNV : TPFNGLPROGRAMUNIFORM3UI64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform4i64NV : TPFNGLPROGRAMUNIFORM4I64NVPROC;cvar;external libGLEW;
    __glewProgramUniform4i64vNV : TPFNGLPROGRAMUNIFORM4I64VNVPROC;cvar;external libGLEW;
    __glewProgramUniform4ui64NV : TPFNGLPROGRAMUNIFORM4UI64NVPROC;cvar;external libGLEW;
    __glewProgramUniform4ui64vNV : TPFNGLPROGRAMUNIFORM4UI64VNVPROC;cvar;external libGLEW;
    __glewUniform1i64NV : TPFNGLUNIFORM1I64NVPROC;cvar;external libGLEW;
    __glewUniform1i64vNV : TPFNGLUNIFORM1I64VNVPROC;cvar;external libGLEW;
    __glewUniform1ui64NV : TPFNGLUNIFORM1UI64NVPROC;cvar;external libGLEW;
    __glewUniform1ui64vNV : TPFNGLUNIFORM1UI64VNVPROC;cvar;external libGLEW;
    __glewUniform2i64NV : TPFNGLUNIFORM2I64NVPROC;cvar;external libGLEW;
    __glewUniform2i64vNV : TPFNGLUNIFORM2I64VNVPROC;cvar;external libGLEW;
    __glewUniform2ui64NV : TPFNGLUNIFORM2UI64NVPROC;cvar;external libGLEW;
    __glewUniform2ui64vNV : TPFNGLUNIFORM2UI64VNVPROC;cvar;external libGLEW;
    __glewUniform3i64NV : TPFNGLUNIFORM3I64NVPROC;cvar;external libGLEW;
    __glewUniform3i64vNV : TPFNGLUNIFORM3I64VNVPROC;cvar;external libGLEW;
    __glewUniform3ui64NV : TPFNGLUNIFORM3UI64NVPROC;cvar;external libGLEW;
    __glewUniform3ui64vNV : TPFNGLUNIFORM3UI64VNVPROC;cvar;external libGLEW;
    __glewUniform4i64NV : TPFNGLUNIFORM4I64NVPROC;cvar;external libGLEW;
    __glewUniform4i64vNV : TPFNGLUNIFORM4I64VNVPROC;cvar;external libGLEW;
    __glewUniform4ui64NV : TPFNGLUNIFORM4UI64NVPROC;cvar;external libGLEW;
    __glewUniform4ui64vNV : TPFNGLUNIFORM4UI64VNVPROC;cvar;external libGLEW;
    __glewColor3hNV : TPFNGLCOLOR3HNVPROC;cvar;external libGLEW;
    __glewColor3hvNV : TPFNGLCOLOR3HVNVPROC;cvar;external libGLEW;
    __glewColor4hNV : TPFNGLCOLOR4HNVPROC;cvar;external libGLEW;
    __glewColor4hvNV : TPFNGLCOLOR4HVNVPROC;cvar;external libGLEW;
    __glewFogCoordhNV : TPFNGLFOGCOORDHNVPROC;cvar;external libGLEW;
    __glewFogCoordhvNV : TPFNGLFOGCOORDHVNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord1hNV : TPFNGLMULTITEXCOORD1HNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord1hvNV : TPFNGLMULTITEXCOORD1HVNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2hNV : TPFNGLMULTITEXCOORD2HNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord2hvNV : TPFNGLMULTITEXCOORD2HVNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3hNV : TPFNGLMULTITEXCOORD3HNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord3hvNV : TPFNGLMULTITEXCOORD3HVNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4hNV : TPFNGLMULTITEXCOORD4HNVPROC;cvar;external libGLEW;
    __glewMultiTexCoord4hvNV : TPFNGLMULTITEXCOORD4HVNVPROC;cvar;external libGLEW;
    __glewNormal3hNV : TPFNGLNORMAL3HNVPROC;cvar;external libGLEW;
    __glewNormal3hvNV : TPFNGLNORMAL3HVNVPROC;cvar;external libGLEW;
    __glewSecondaryColor3hNV : TPFNGLSECONDARYCOLOR3HNVPROC;cvar;external libGLEW;
    __glewSecondaryColor3hvNV : TPFNGLSECONDARYCOLOR3HVNVPROC;cvar;external libGLEW;
    __glewTexCoord1hNV : TPFNGLTEXCOORD1HNVPROC;cvar;external libGLEW;
    __glewTexCoord1hvNV : TPFNGLTEXCOORD1HVNVPROC;cvar;external libGLEW;
    __glewTexCoord2hNV : TPFNGLTEXCOORD2HNVPROC;cvar;external libGLEW;
    __glewTexCoord2hvNV : TPFNGLTEXCOORD2HVNVPROC;cvar;external libGLEW;
    __glewTexCoord3hNV : TPFNGLTEXCOORD3HNVPROC;cvar;external libGLEW;
    __glewTexCoord3hvNV : TPFNGLTEXCOORD3HVNVPROC;cvar;external libGLEW;
    __glewTexCoord4hNV : TPFNGLTEXCOORD4HNVPROC;cvar;external libGLEW;
    __glewTexCoord4hvNV : TPFNGLTEXCOORD4HVNVPROC;cvar;external libGLEW;
    __glewVertex2hNV : TPFNGLVERTEX2HNVPROC;cvar;external libGLEW;
    __glewVertex2hvNV : TPFNGLVERTEX2HVNVPROC;cvar;external libGLEW;
    __glewVertex3hNV : TPFNGLVERTEX3HNVPROC;cvar;external libGLEW;
    __glewVertex3hvNV : TPFNGLVERTEX3HVNVPROC;cvar;external libGLEW;
    __glewVertex4hNV : TPFNGLVERTEX4HNVPROC;cvar;external libGLEW;
    __glewVertex4hvNV : TPFNGLVERTEX4HVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1hNV : TPFNGLVERTEXATTRIB1HNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1hvNV : TPFNGLVERTEXATTRIB1HVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2hNV : TPFNGLVERTEXATTRIB2HNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2hvNV : TPFNGLVERTEXATTRIB2HVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3hNV : TPFNGLVERTEXATTRIB3HNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3hvNV : TPFNGLVERTEXATTRIB3HVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4hNV : TPFNGLVERTEXATTRIB4HNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4hvNV : TPFNGLVERTEXATTRIB4HVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs1hvNV : TPFNGLVERTEXATTRIBS1HVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs2hvNV : TPFNGLVERTEXATTRIBS2HVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs3hvNV : TPFNGLVERTEXATTRIBS3HVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs4hvNV : TPFNGLVERTEXATTRIBS4HVNVPROC;cvar;external libGLEW;
    __glewVertexWeighthNV : TPFNGLVERTEXWEIGHTHNVPROC;cvar;external libGLEW;
    __glewVertexWeighthvNV : TPFNGLVERTEXWEIGHTHVNVPROC;cvar;external libGLEW;
    __glewVertexAttribDivisorNV : TPFNGLVERTEXATTRIBDIVISORNVPROC;cvar;external libGLEW;
    __glewGetInternalformatSampleivNV : TPFNGLGETINTERNALFORMATSAMPLEIVNVPROC;cvar;external libGLEW;
    __glewBufferAttachMemoryNV : TPFNGLBUFFERATTACHMEMORYNVPROC;cvar;external libGLEW;
    __glewGetMemoryObjectDetachedResourcesuivNV : TPFNGLGETMEMORYOBJECTDETACHEDRESOURCESUIVNVPROC;cvar;external libGLEW;
    __glewNamedBufferAttachMemoryNV : TPFNGLNAMEDBUFFERATTACHMEMORYNVPROC;cvar;external libGLEW;
    __glewResetMemoryObjectParameterNV : TPFNGLRESETMEMORYOBJECTPARAMETERNVPROC;cvar;external libGLEW;
    __glewTexAttachMemoryNV : TPFNGLTEXATTACHMEMORYNVPROC;cvar;external libGLEW;
    __glewTextureAttachMemoryNV : TPFNGLTEXTUREATTACHMEMORYNVPROC;cvar;external libGLEW;
    __glewDrawMeshTasksIndirectNV : TPFNGLDRAWMESHTASKSINDIRECTNVPROC;cvar;external libGLEW;
    __glewDrawMeshTasksNV : TPFNGLDRAWMESHTASKSNVPROC;cvar;external libGLEW;
    __glewMultiDrawMeshTasksIndirectCountNV : TPFNGLMULTIDRAWMESHTASKSINDIRECTCOUNTNVPROC;cvar;external libGLEW;
    __glewMultiDrawMeshTasksIndirectNV : TPFNGLMULTIDRAWMESHTASKSINDIRECTNVPROC;cvar;external libGLEW;
    __glewUniformMatrix2x3fvNV : TPFNGLUNIFORMMATRIX2X3FVNVPROC;cvar;external libGLEW;
    __glewUniformMatrix2x4fvNV : TPFNGLUNIFORMMATRIX2X4FVNVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x2fvNV : TPFNGLUNIFORMMATRIX3X2FVNVPROC;cvar;external libGLEW;
    __glewUniformMatrix3x4fvNV : TPFNGLUNIFORMMATRIX3X4FVNVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x2fvNV : TPFNGLUNIFORMMATRIX4X2FVNVPROC;cvar;external libGLEW;
    __glewUniformMatrix4x3fvNV : TPFNGLUNIFORMMATRIX4X3FVNVPROC;cvar;external libGLEW;
    __glewBeginOcclusionQueryNV : TPFNGLBEGINOCCLUSIONQUERYNVPROC;cvar;external libGLEW;
    __glewDeleteOcclusionQueriesNV : TPFNGLDELETEOCCLUSIONQUERIESNVPROC;cvar;external libGLEW;
    __glewEndOcclusionQueryNV : TPFNGLENDOCCLUSIONQUERYNVPROC;cvar;external libGLEW;
    __glewGenOcclusionQueriesNV : TPFNGLGENOCCLUSIONQUERIESNVPROC;cvar;external libGLEW;
    __glewGetOcclusionQueryivNV : TPFNGLGETOCCLUSIONQUERYIVNVPROC;cvar;external libGLEW;
    __glewGetOcclusionQueryuivNV : TPFNGLGETOCCLUSIONQUERYUIVNVPROC;cvar;external libGLEW;
    __glewIsOcclusionQueryNV : TPFNGLISOCCLUSIONQUERYNVPROC;cvar;external libGLEW;
    __glewProgramBufferParametersIivNV : TPFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC;cvar;external libGLEW;
    __glewProgramBufferParametersIuivNV : TPFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC;cvar;external libGLEW;
    __glewProgramBufferParametersfvNV : TPFNGLPROGRAMBUFFERPARAMETERSFVNVPROC;cvar;external libGLEW;
    __glewCopyPathNV : TPFNGLCOPYPATHNVPROC;cvar;external libGLEW;
    __glewCoverFillPathInstancedNV : TPFNGLCOVERFILLPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewCoverFillPathNV : TPFNGLCOVERFILLPATHNVPROC;cvar;external libGLEW;
    __glewCoverStrokePathInstancedNV : TPFNGLCOVERSTROKEPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewCoverStrokePathNV : TPFNGLCOVERSTROKEPATHNVPROC;cvar;external libGLEW;
    __glewDeletePathsNV : TPFNGLDELETEPATHSNVPROC;cvar;external libGLEW;
    __glewGenPathsNV : TPFNGLGENPATHSNVPROC;cvar;external libGLEW;
    __glewGetPathColorGenfvNV : TPFNGLGETPATHCOLORGENFVNVPROC;cvar;external libGLEW;
    __glewGetPathColorGenivNV : TPFNGLGETPATHCOLORGENIVNVPROC;cvar;external libGLEW;
    __glewGetPathCommandsNV : TPFNGLGETPATHCOMMANDSNVPROC;cvar;external libGLEW;
    __glewGetPathCoordsNV : TPFNGLGETPATHCOORDSNVPROC;cvar;external libGLEW;
    __glewGetPathDashArrayNV : TPFNGLGETPATHDASHARRAYNVPROC;cvar;external libGLEW;
    __glewGetPathLengthNV : TPFNGLGETPATHLENGTHNVPROC;cvar;external libGLEW;
    __glewGetPathMetricRangeNV : TPFNGLGETPATHMETRICRANGENVPROC;cvar;external libGLEW;
    __glewGetPathMetricsNV : TPFNGLGETPATHMETRICSNVPROC;cvar;external libGLEW;
    __glewGetPathParameterfvNV : TPFNGLGETPATHPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetPathParameterivNV : TPFNGLGETPATHPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewGetPathSpacingNV : TPFNGLGETPATHSPACINGNVPROC;cvar;external libGLEW;
    __glewGetPathTexGenfvNV : TPFNGLGETPATHTEXGENFVNVPROC;cvar;external libGLEW;
    __glewGetPathTexGenivNV : TPFNGLGETPATHTEXGENIVNVPROC;cvar;external libGLEW;
    __glewGetProgramResourcefvNV : TPFNGLGETPROGRAMRESOURCEFVNVPROC;cvar;external libGLEW;
    __glewInterpolatePathsNV : TPFNGLINTERPOLATEPATHSNVPROC;cvar;external libGLEW;
    __glewIsPathNV : TPFNGLISPATHNVPROC;cvar;external libGLEW;
    __glewIsPointInFillPathNV : TPFNGLISPOINTINFILLPATHNVPROC;cvar;external libGLEW;
    __glewIsPointInStrokePathNV : TPFNGLISPOINTINSTROKEPATHNVPROC;cvar;external libGLEW;
    __glewMatrixLoad3x2fNV : TPFNGLMATRIXLOAD3X2FNVPROC;cvar;external libGLEW;
    __glewMatrixLoad3x3fNV : TPFNGLMATRIXLOAD3X3FNVPROC;cvar;external libGLEW;
    __glewMatrixLoadTranspose3x3fNV : TPFNGLMATRIXLOADTRANSPOSE3X3FNVPROC;cvar;external libGLEW;
    __glewMatrixMult3x2fNV : TPFNGLMATRIXMULT3X2FNVPROC;cvar;external libGLEW;
    __glewMatrixMult3x3fNV : TPFNGLMATRIXMULT3X3FNVPROC;cvar;external libGLEW;
    __glewMatrixMultTranspose3x3fNV : TPFNGLMATRIXMULTTRANSPOSE3X3FNVPROC;cvar;external libGLEW;
    __glewPathColorGenNV : TPFNGLPATHCOLORGENNVPROC;cvar;external libGLEW;
    __glewPathCommandsNV : TPFNGLPATHCOMMANDSNVPROC;cvar;external libGLEW;
    __glewPathCoordsNV : TPFNGLPATHCOORDSNVPROC;cvar;external libGLEW;
    __glewPathCoverDepthFuncNV : TPFNGLPATHCOVERDEPTHFUNCNVPROC;cvar;external libGLEW;
    __glewPathDashArrayNV : TPFNGLPATHDASHARRAYNVPROC;cvar;external libGLEW;
    __glewPathFogGenNV : TPFNGLPATHFOGGENNVPROC;cvar;external libGLEW;
    __glewPathGlyphIndexArrayNV : TPFNGLPATHGLYPHINDEXARRAYNVPROC;cvar;external libGLEW;
    __glewPathGlyphIndexRangeNV : TPFNGLPATHGLYPHINDEXRANGENVPROC;cvar;external libGLEW;
    __glewPathGlyphRangeNV : TPFNGLPATHGLYPHRANGENVPROC;cvar;external libGLEW;
    __glewPathGlyphsNV : TPFNGLPATHGLYPHSNVPROC;cvar;external libGLEW;
    __glewPathMemoryGlyphIndexArrayNV : TPFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC;cvar;external libGLEW;
    __glewPathParameterfNV : TPFNGLPATHPARAMETERFNVPROC;cvar;external libGLEW;
    __glewPathParameterfvNV : TPFNGLPATHPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewPathParameteriNV : TPFNGLPATHPARAMETERINVPROC;cvar;external libGLEW;
    __glewPathParameterivNV : TPFNGLPATHPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewPathStencilDepthOffsetNV : TPFNGLPATHSTENCILDEPTHOFFSETNVPROC;cvar;external libGLEW;
    __glewPathStencilFuncNV : TPFNGLPATHSTENCILFUNCNVPROC;cvar;external libGLEW;
    __glewPathStringNV : TPFNGLPATHSTRINGNVPROC;cvar;external libGLEW;
    __glewPathSubCommandsNV : TPFNGLPATHSUBCOMMANDSNVPROC;cvar;external libGLEW;
    __glewPathSubCoordsNV : TPFNGLPATHSUBCOORDSNVPROC;cvar;external libGLEW;
    __glewPathTexGenNV : TPFNGLPATHTEXGENNVPROC;cvar;external libGLEW;
    __glewPointAlongPathNV : TPFNGLPOINTALONGPATHNVPROC;cvar;external libGLEW;
    __glewProgramPathFragmentInputGenNV : TPFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC;cvar;external libGLEW;
    __glewStencilFillPathInstancedNV : TPFNGLSTENCILFILLPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewStencilFillPathNV : TPFNGLSTENCILFILLPATHNVPROC;cvar;external libGLEW;
    __glewStencilStrokePathInstancedNV : TPFNGLSTENCILSTROKEPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewStencilStrokePathNV : TPFNGLSTENCILSTROKEPATHNVPROC;cvar;external libGLEW;
    __glewStencilThenCoverFillPathInstancedNV : TPFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewStencilThenCoverFillPathNV : TPFNGLSTENCILTHENCOVERFILLPATHNVPROC;cvar;external libGLEW;
    __glewStencilThenCoverStrokePathInstancedNV : TPFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC;cvar;external libGLEW;
    __glewStencilThenCoverStrokePathNV : TPFNGLSTENCILTHENCOVERSTROKEPATHNVPROC;cvar;external libGLEW;
    __glewTransformPathNV : TPFNGLTRANSFORMPATHNVPROC;cvar;external libGLEW;
    __glewWeightPathsNV : TPFNGLWEIGHTPATHSNVPROC;cvar;external libGLEW;
    __glewFlushPixelDataRangeNV : TPFNGLFLUSHPIXELDATARANGENVPROC;cvar;external libGLEW;
    __glewPixelDataRangeNV : TPFNGLPIXELDATARANGENVPROC;cvar;external libGLEW;
    __glewPointParameteriNV : TPFNGLPOINTPARAMETERINVPROC;cvar;external libGLEW;
    __glewPointParameterivNV : TPFNGLPOINTPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewPolygonModeNV : TPFNGLPOLYGONMODENVPROC;cvar;external libGLEW;
    __glewGetVideoi64vNV : TPFNGLGETVIDEOI64VNVPROC;cvar;external libGLEW;
    __glewGetVideoivNV : TPFNGLGETVIDEOIVNVPROC;cvar;external libGLEW;
    __glewGetVideoui64vNV : TPFNGLGETVIDEOUI64VNVPROC;cvar;external libGLEW;
    __glewGetVideouivNV : TPFNGLGETVIDEOUIVNVPROC;cvar;external libGLEW;
    __glewPresentFrameDualFillNV : TPFNGLPRESENTFRAMEDUALFILLNVPROC;cvar;external libGLEW;
    __glewPresentFrameKeyedNV : TPFNGLPRESENTFRAMEKEYEDNVPROC;cvar;external libGLEW;
    __glewPrimitiveRestartIndexNV : TPFNGLPRIMITIVERESTARTINDEXNVPROC;cvar;external libGLEW;
    __glewPrimitiveRestartNV : TPFNGLPRIMITIVERESTARTNVPROC;cvar;external libGLEW;
    __glewReadBufferNV : TPFNGLREADBUFFERNVPROC;cvar;external libGLEW;
    __glewCombinerInputNV : TPFNGLCOMBINERINPUTNVPROC;cvar;external libGLEW;
    __glewCombinerOutputNV : TPFNGLCOMBINEROUTPUTNVPROC;cvar;external libGLEW;
    __glewCombinerParameterfNV : TPFNGLCOMBINERPARAMETERFNVPROC;cvar;external libGLEW;
    __glewCombinerParameterfvNV : TPFNGLCOMBINERPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewCombinerParameteriNV : TPFNGLCOMBINERPARAMETERINVPROC;cvar;external libGLEW;
    __glewCombinerParameterivNV : TPFNGLCOMBINERPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewFinalCombinerInputNV : TPFNGLFINALCOMBINERINPUTNVPROC;cvar;external libGLEW;
    __glewGetCombinerInputParameterfvNV : TPFNGLGETCOMBINERINPUTPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetCombinerInputParameterivNV : TPFNGLGETCOMBINERINPUTPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewGetCombinerOutputParameterfvNV : TPFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetCombinerOutputParameterivNV : TPFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewGetFinalCombinerInputParameterfvNV : TPFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetFinalCombinerInputParameterivNV : TPFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewCombinerStageParameterfvNV : TPFNGLCOMBINERSTAGEPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetCombinerStageParameterfvNV : TPFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewFramebufferSampleLocationsfvNV : TPFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC;cvar;external libGLEW;
    __glewNamedFramebufferSampleLocationsfvNV : TPFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC;cvar;external libGLEW;
    __glewResolveDepthValuesNV : TPFNGLRESOLVEDEPTHVALUESNVPROC;cvar;external libGLEW;
    __glewScissorExclusiveArrayvNV : TPFNGLSCISSOREXCLUSIVEARRAYVNVPROC;cvar;external libGLEW;
    __glewScissorExclusiveNV : TPFNGLSCISSOREXCLUSIVENVPROC;cvar;external libGLEW;
    __glewGetBufferParameterui64vNV : TPFNGLGETBUFFERPARAMETERUI64VNVPROC;cvar;external libGLEW;
    __glewGetIntegerui64vNV : TPFNGLGETINTEGERUI64VNVPROC;cvar;external libGLEW;
    __glewGetNamedBufferParameterui64vNV : TPFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC;cvar;external libGLEW;
    __glewIsBufferResidentNV : TPFNGLISBUFFERRESIDENTNVPROC;cvar;external libGLEW;
    __glewIsNamedBufferResidentNV : TPFNGLISNAMEDBUFFERRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeBufferNonResidentNV : TPFNGLMAKEBUFFERNONRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeBufferResidentNV : TPFNGLMAKEBUFFERRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeNamedBufferNonResidentNV : TPFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC;cvar;external libGLEW;
    __glewMakeNamedBufferResidentNV : TPFNGLMAKENAMEDBUFFERRESIDENTNVPROC;cvar;external libGLEW;
    __glewProgramUniformui64NV : TPFNGLPROGRAMUNIFORMUI64NVPROC;cvar;external libGLEW;
    __glewProgramUniformui64vNV : TPFNGLPROGRAMUNIFORMUI64VNVPROC;cvar;external libGLEW;
    __glewUniformui64NV : TPFNGLUNIFORMUI64NVPROC;cvar;external libGLEW;
    __glewUniformui64vNV : TPFNGLUNIFORMUI64VNVPROC;cvar;external libGLEW;
    __glewBindShadingRateImageNV : TPFNGLBINDSHADINGRATEIMAGENVPROC;cvar;external libGLEW;
    __glewGetShadingRateImagePaletteNV : TPFNGLGETSHADINGRATEIMAGEPALETTENVPROC;cvar;external libGLEW;
    __glewGetShadingRateSampleLocationivNV : TPFNGLGETSHADINGRATESAMPLELOCATIONIVNVPROC;cvar;external libGLEW;
    __glewShadingRateImageBarrierNV : TPFNGLSHADINGRATEIMAGEBARRIERNVPROC;cvar;external libGLEW;
    __glewShadingRateImagePaletteNV : TPFNGLSHADINGRATEIMAGEPALETTENVPROC;cvar;external libGLEW;
    __glewShadingRateSampleOrderCustomNV : TPFNGLSHADINGRATESAMPLEORDERCUSTOMNVPROC;cvar;external libGLEW;
    __glewCompressedTexImage3DNV : TPFNGLCOMPRESSEDTEXIMAGE3DNVPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage3DNV : TPFNGLCOMPRESSEDTEXSUBIMAGE3DNVPROC;cvar;external libGLEW;
    __glewCopyTexSubImage3DNV : TPFNGLCOPYTEXSUBIMAGE3DNVPROC;cvar;external libGLEW;
    __glewFramebufferTextureLayerNV : TPFNGLFRAMEBUFFERTEXTURELAYERNVPROC;cvar;external libGLEW;
    __glewTexImage3DNV : TPFNGLTEXIMAGE3DNVPROC;cvar;external libGLEW;
    __glewTexSubImage3DNV : TPFNGLTEXSUBIMAGE3DNVPROC;cvar;external libGLEW;
    __glewTextureBarrierNV : TPFNGLTEXTUREBARRIERNVPROC;cvar;external libGLEW;
    __glewTexImage2DMultisampleCoverageNV : TPFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC;cvar;external libGLEW;
    __glewTexImage3DMultisampleCoverageNV : TPFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC;cvar;external libGLEW;
    __glewTextureImage2DMultisampleCoverageNV : TPFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC;cvar;external libGLEW;
    __glewTextureImage2DMultisampleNV : TPFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC;cvar;external libGLEW;
    __glewTextureImage3DMultisampleCoverageNV : TPFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC;cvar;external libGLEW;
    __glewTextureImage3DMultisampleNV : TPFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC;cvar;external libGLEW;
    __glewActiveVaryingNV : TPFNGLACTIVEVARYINGNVPROC;cvar;external libGLEW;
    __glewBeginTransformFeedbackNV : TPFNGLBEGINTRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewBindBufferBaseNV : TPFNGLBINDBUFFERBASENVPROC;cvar;external libGLEW;
    __glewBindBufferOffsetNV : TPFNGLBINDBUFFEROFFSETNVPROC;cvar;external libGLEW;
    __glewBindBufferRangeNV : TPFNGLBINDBUFFERRANGENVPROC;cvar;external libGLEW;
    __glewEndTransformFeedbackNV : TPFNGLENDTRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewGetActiveVaryingNV : TPFNGLGETACTIVEVARYINGNVPROC;cvar;external libGLEW;
    __glewGetTransformFeedbackVaryingNV : TPFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC;cvar;external libGLEW;
    __glewGetVaryingLocationNV : TPFNGLGETVARYINGLOCATIONNVPROC;cvar;external libGLEW;
    __glewTransformFeedbackAttribsNV : TPFNGLTRANSFORMFEEDBACKATTRIBSNVPROC;cvar;external libGLEW;
    __glewTransformFeedbackVaryingsNV : TPFNGLTRANSFORMFEEDBACKVARYINGSNVPROC;cvar;external libGLEW;
    __glewBindTransformFeedbackNV : TPFNGLBINDTRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewDeleteTransformFeedbacksNV : TPFNGLDELETETRANSFORMFEEDBACKSNVPROC;cvar;external libGLEW;
    __glewDrawTransformFeedbackNV : TPFNGLDRAWTRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewGenTransformFeedbacksNV : TPFNGLGENTRANSFORMFEEDBACKSNVPROC;cvar;external libGLEW;
    __glewIsTransformFeedbackNV : TPFNGLISTRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewPauseTransformFeedbackNV : TPFNGLPAUSETRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewResumeTransformFeedbackNV : TPFNGLRESUMETRANSFORMFEEDBACKNVPROC;cvar;external libGLEW;
    __glewVDPAUFiniNV : TPFNGLVDPAUFININVPROC;cvar;external libGLEW;
    __glewVDPAUGetSurfaceivNV : TPFNGLVDPAUGETSURFACEIVNVPROC;cvar;external libGLEW;
    __glewVDPAUInitNV : TPFNGLVDPAUINITNVPROC;cvar;external libGLEW;
    __glewVDPAUIsSurfaceNV : TPFNGLVDPAUISSURFACENVPROC;cvar;external libGLEW;
    __glewVDPAUMapSurfacesNV : TPFNGLVDPAUMAPSURFACESNVPROC;cvar;external libGLEW;
    __glewVDPAURegisterOutputSurfaceNV : TPFNGLVDPAUREGISTEROUTPUTSURFACENVPROC;cvar;external libGLEW;
    __glewVDPAURegisterVideoSurfaceNV : TPFNGLVDPAUREGISTERVIDEOSURFACENVPROC;cvar;external libGLEW;
    __glewVDPAUSurfaceAccessNV : TPFNGLVDPAUSURFACEACCESSNVPROC;cvar;external libGLEW;
    __glewVDPAUUnmapSurfacesNV : TPFNGLVDPAUUNMAPSURFACESNVPROC;cvar;external libGLEW;
    __glewVDPAUUnregisterSurfaceNV : TPFNGLVDPAUUNREGISTERSURFACENVPROC;cvar;external libGLEW;
    __glewVDPAURegisterVideoSurfaceWithPictureStructureNV : TPFNGLVDPAUREGISTERVIDEOSURFACEWITHPICTURESTRUCTURENVPROC;cvar;external libGLEW;
    __glewFlushVertexArrayRangeNV : TPFNGLFLUSHVERTEXARRAYRANGENVPROC;cvar;external libGLEW;
    __glewVertexArrayRangeNV : TPFNGLVERTEXARRAYRANGENVPROC;cvar;external libGLEW;
    __glewGetVertexAttribLi64vNV : TPFNGLGETVERTEXATTRIBLI64VNVPROC;cvar;external libGLEW;
    __glewGetVertexAttribLui64vNV : TPFNGLGETVERTEXATTRIBLUI64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL1i64NV : TPFNGLVERTEXATTRIBL1I64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL1i64vNV : TPFNGLVERTEXATTRIBL1I64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL1ui64NV : TPFNGLVERTEXATTRIBL1UI64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL1ui64vNV : TPFNGLVERTEXATTRIBL1UI64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL2i64NV : TPFNGLVERTEXATTRIBL2I64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL2i64vNV : TPFNGLVERTEXATTRIBL2I64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL2ui64NV : TPFNGLVERTEXATTRIBL2UI64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL2ui64vNV : TPFNGLVERTEXATTRIBL2UI64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL3i64NV : TPFNGLVERTEXATTRIBL3I64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL3i64vNV : TPFNGLVERTEXATTRIBL3I64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL3ui64NV : TPFNGLVERTEXATTRIBL3UI64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL3ui64vNV : TPFNGLVERTEXATTRIBL3UI64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL4i64NV : TPFNGLVERTEXATTRIBL4I64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL4i64vNV : TPFNGLVERTEXATTRIBL4I64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribL4ui64NV : TPFNGLVERTEXATTRIBL4UI64NVPROC;cvar;external libGLEW;
    __glewVertexAttribL4ui64vNV : TPFNGLVERTEXATTRIBL4UI64VNVPROC;cvar;external libGLEW;
    __glewVertexAttribLFormatNV : TPFNGLVERTEXATTRIBLFORMATNVPROC;cvar;external libGLEW;
    __glewBufferAddressRangeNV : TPFNGLBUFFERADDRESSRANGENVPROC;cvar;external libGLEW;
    __glewColorFormatNV : TPFNGLCOLORFORMATNVPROC;cvar;external libGLEW;
    __glewEdgeFlagFormatNV : TPFNGLEDGEFLAGFORMATNVPROC;cvar;external libGLEW;
    __glewFogCoordFormatNV : TPFNGLFOGCOORDFORMATNVPROC;cvar;external libGLEW;
    __glewGetIntegerui64i_vNV : TPFNGLGETINTEGERUI64I_VNVPROC;cvar;external libGLEW;
    __glewIndexFormatNV : TPFNGLINDEXFORMATNVPROC;cvar;external libGLEW;
    __glewNormalFormatNV : TPFNGLNORMALFORMATNVPROC;cvar;external libGLEW;
    __glewSecondaryColorFormatNV : TPFNGLSECONDARYCOLORFORMATNVPROC;cvar;external libGLEW;
    __glewTexCoordFormatNV : TPFNGLTEXCOORDFORMATNVPROC;cvar;external libGLEW;
    __glewVertexAttribFormatNV : TPFNGLVERTEXATTRIBFORMATNVPROC;cvar;external libGLEW;
    __glewVertexAttribIFormatNV : TPFNGLVERTEXATTRIBIFORMATNVPROC;cvar;external libGLEW;
    __glewVertexFormatNV : TPFNGLVERTEXFORMATNVPROC;cvar;external libGLEW;
    __glewAreProgramsResidentNV : TPFNGLAREPROGRAMSRESIDENTNVPROC;cvar;external libGLEW;
    __glewBindProgramNV : TPFNGLBINDPROGRAMNVPROC;cvar;external libGLEW;
    __glewDeleteProgramsNV : TPFNGLDELETEPROGRAMSNVPROC;cvar;external libGLEW;
    __glewExecuteProgramNV : TPFNGLEXECUTEPROGRAMNVPROC;cvar;external libGLEW;
    __glewGenProgramsNV : TPFNGLGENPROGRAMSNVPROC;cvar;external libGLEW;
    __glewGetProgramParameterdvNV : TPFNGLGETPROGRAMPARAMETERDVNVPROC;cvar;external libGLEW;
    __glewGetProgramParameterfvNV : TPFNGLGETPROGRAMPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewGetProgramStringNV : TPFNGLGETPROGRAMSTRINGNVPROC;cvar;external libGLEW;
    __glewGetProgramivNV : TPFNGLGETPROGRAMIVNVPROC;cvar;external libGLEW;
    __glewGetTrackMatrixivNV : TPFNGLGETTRACKMATRIXIVNVPROC;cvar;external libGLEW;
    __glewGetVertexAttribPointervNV : TPFNGLGETVERTEXATTRIBPOINTERVNVPROC;cvar;external libGLEW;
    __glewGetVertexAttribdvNV : TPFNGLGETVERTEXATTRIBDVNVPROC;cvar;external libGLEW;
    __glewGetVertexAttribfvNV : TPFNGLGETVERTEXATTRIBFVNVPROC;cvar;external libGLEW;
    __glewGetVertexAttribivNV : TPFNGLGETVERTEXATTRIBIVNVPROC;cvar;external libGLEW;
    __glewIsProgramNV : TPFNGLISPROGRAMNVPROC;cvar;external libGLEW;
    __glewLoadProgramNV : TPFNGLLOADPROGRAMNVPROC;cvar;external libGLEW;
    __glewProgramParameter4dNV : TPFNGLPROGRAMPARAMETER4DNVPROC;cvar;external libGLEW;
    __glewProgramParameter4dvNV : TPFNGLPROGRAMPARAMETER4DVNVPROC;cvar;external libGLEW;
    __glewProgramParameter4fNV : TPFNGLPROGRAMPARAMETER4FNVPROC;cvar;external libGLEW;
    __glewProgramParameter4fvNV : TPFNGLPROGRAMPARAMETER4FVNVPROC;cvar;external libGLEW;
    __glewProgramParameters4dvNV : TPFNGLPROGRAMPARAMETERS4DVNVPROC;cvar;external libGLEW;
    __glewProgramParameters4fvNV : TPFNGLPROGRAMPARAMETERS4FVNVPROC;cvar;external libGLEW;
    __glewRequestResidentProgramsNV : TPFNGLREQUESTRESIDENTPROGRAMSNVPROC;cvar;external libGLEW;
    __glewTrackMatrixNV : TPFNGLTRACKMATRIXNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1dNV : TPFNGLVERTEXATTRIB1DNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1dvNV : TPFNGLVERTEXATTRIB1DVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1fNV : TPFNGLVERTEXATTRIB1FNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1fvNV : TPFNGLVERTEXATTRIB1FVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1sNV : TPFNGLVERTEXATTRIB1SNVPROC;cvar;external libGLEW;
    __glewVertexAttrib1svNV : TPFNGLVERTEXATTRIB1SVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2dNV : TPFNGLVERTEXATTRIB2DNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2dvNV : TPFNGLVERTEXATTRIB2DVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2fNV : TPFNGLVERTEXATTRIB2FNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2fvNV : TPFNGLVERTEXATTRIB2FVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2sNV : TPFNGLVERTEXATTRIB2SNVPROC;cvar;external libGLEW;
    __glewVertexAttrib2svNV : TPFNGLVERTEXATTRIB2SVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3dNV : TPFNGLVERTEXATTRIB3DNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3dvNV : TPFNGLVERTEXATTRIB3DVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3fNV : TPFNGLVERTEXATTRIB3FNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3fvNV : TPFNGLVERTEXATTRIB3FVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3sNV : TPFNGLVERTEXATTRIB3SNVPROC;cvar;external libGLEW;
    __glewVertexAttrib3svNV : TPFNGLVERTEXATTRIB3SVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4dNV : TPFNGLVERTEXATTRIB4DNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4dvNV : TPFNGLVERTEXATTRIB4DVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4fNV : TPFNGLVERTEXATTRIB4FNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4fvNV : TPFNGLVERTEXATTRIB4FVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4sNV : TPFNGLVERTEXATTRIB4SNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4svNV : TPFNGLVERTEXATTRIB4SVNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4ubNV : TPFNGLVERTEXATTRIB4UBNVPROC;cvar;external libGLEW;
    __glewVertexAttrib4ubvNV : TPFNGLVERTEXATTRIB4UBVNVPROC;cvar;external libGLEW;
    __glewVertexAttribPointerNV : TPFNGLVERTEXATTRIBPOINTERNVPROC;cvar;external libGLEW;
    __glewVertexAttribs1dvNV : TPFNGLVERTEXATTRIBS1DVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs1fvNV : TPFNGLVERTEXATTRIBS1FVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs1svNV : TPFNGLVERTEXATTRIBS1SVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs2dvNV : TPFNGLVERTEXATTRIBS2DVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs2fvNV : TPFNGLVERTEXATTRIBS2FVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs2svNV : TPFNGLVERTEXATTRIBS2SVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs3dvNV : TPFNGLVERTEXATTRIBS3DVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs3fvNV : TPFNGLVERTEXATTRIBS3FVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs3svNV : TPFNGLVERTEXATTRIBS3SVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs4dvNV : TPFNGLVERTEXATTRIBS4DVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs4fvNV : TPFNGLVERTEXATTRIBS4FVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs4svNV : TPFNGLVERTEXATTRIBS4SVNVPROC;cvar;external libGLEW;
    __glewVertexAttribs4ubvNV : TPFNGLVERTEXATTRIBS4UBVNVPROC;cvar;external libGLEW;
    __glewBeginVideoCaptureNV : TPFNGLBEGINVIDEOCAPTURENVPROC;cvar;external libGLEW;
    __glewBindVideoCaptureStreamBufferNV : TPFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC;cvar;external libGLEW;
    __glewBindVideoCaptureStreamTextureNV : TPFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC;cvar;external libGLEW;
    __glewEndVideoCaptureNV : TPFNGLENDVIDEOCAPTURENVPROC;cvar;external libGLEW;
    __glewGetVideoCaptureStreamdvNV : TPFNGLGETVIDEOCAPTURESTREAMDVNVPROC;cvar;external libGLEW;
    __glewGetVideoCaptureStreamfvNV : TPFNGLGETVIDEOCAPTURESTREAMFVNVPROC;cvar;external libGLEW;
    __glewGetVideoCaptureStreamivNV : TPFNGLGETVIDEOCAPTURESTREAMIVNVPROC;cvar;external libGLEW;
    __glewGetVideoCaptureivNV : TPFNGLGETVIDEOCAPTUREIVNVPROC;cvar;external libGLEW;
    __glewVideoCaptureNV : TPFNGLVIDEOCAPTURENVPROC;cvar;external libGLEW;
    __glewVideoCaptureStreamParameterdvNV : TPFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC;cvar;external libGLEW;
    __glewVideoCaptureStreamParameterfvNV : TPFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC;cvar;external libGLEW;
    __glewVideoCaptureStreamParameterivNV : TPFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC;cvar;external libGLEW;
    __glewDepthRangeArrayfvNV : TPFNGLDEPTHRANGEARRAYFVNVPROC;cvar;external libGLEW;
    __glewDepthRangeIndexedfNV : TPFNGLDEPTHRANGEINDEXEDFNVPROC;cvar;external libGLEW;
    __glewDisableiNV : TPFNGLDISABLEINVPROC;cvar;external libGLEW;
    __glewEnableiNV : TPFNGLENABLEINVPROC;cvar;external libGLEW;
    __glewGetFloati_vNV : TPFNGLGETFLOATI_VNVPROC;cvar;external libGLEW;
    __glewIsEnablediNV : TPFNGLISENABLEDINVPROC;cvar;external libGLEW;
    __glewScissorArrayvNV : TPFNGLSCISSORARRAYVNVPROC;cvar;external libGLEW;
    __glewScissorIndexedNV : TPFNGLSCISSORINDEXEDNVPROC;cvar;external libGLEW;
    __glewScissorIndexedvNV : TPFNGLSCISSORINDEXEDVNVPROC;cvar;external libGLEW;
    __glewViewportArrayvNV : TPFNGLVIEWPORTARRAYVNVPROC;cvar;external libGLEW;
    __glewViewportIndexedfNV : TPFNGLVIEWPORTINDEXEDFNVPROC;cvar;external libGLEW;
    __glewViewportIndexedfvNV : TPFNGLVIEWPORTINDEXEDFVNVPROC;cvar;external libGLEW;
    __glewViewportSwizzleNV : TPFNGLVIEWPORTSWIZZLENVPROC;cvar;external libGLEW;
    __glewEGLImageTargetRenderbufferStorageOES : TPFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC;cvar;external libGLEW;
    __glewEGLImageTargetTexture2DOES : TPFNGLEGLIMAGETARGETTEXTURE2DOESPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateOES : TPFNGLBLENDEQUATIONSEPARATEOESPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateOES : TPFNGLBLENDFUNCSEPARATEOESPROC;cvar;external libGLEW;
    __glewBlendEquationOES : TPFNGLBLENDEQUATIONOESPROC;cvar;external libGLEW;
    __glewCopyImageSubDataOES : TPFNGLCOPYIMAGESUBDATAOESPROC;cvar;external libGLEW;
    __glewBlendEquationSeparateiOES : TPFNGLBLENDEQUATIONSEPARATEIOESPROC;cvar;external libGLEW;
    __glewBlendEquationiOES : TPFNGLBLENDEQUATIONIOESPROC;cvar;external libGLEW;
    __glewBlendFuncSeparateiOES : TPFNGLBLENDFUNCSEPARATEIOESPROC;cvar;external libGLEW;
    __glewBlendFunciOES : TPFNGLBLENDFUNCIOESPROC;cvar;external libGLEW;
    __glewColorMaskiOES : TPFNGLCOLORMASKIOESPROC;cvar;external libGLEW;
    __glewDisableiOES : TPFNGLDISABLEIOESPROC;cvar;external libGLEW;
    __glewEnableiOES : TPFNGLENABLEIOESPROC;cvar;external libGLEW;
    __glewIsEnablediOES : TPFNGLISENABLEDIOESPROC;cvar;external libGLEW;
    __glewBindFramebufferOES : TPFNGLBINDFRAMEBUFFEROESPROC;cvar;external libGLEW;
    __glewBindRenderbufferOES : TPFNGLBINDRENDERBUFFEROESPROC;cvar;external libGLEW;
    __glewCheckFramebufferStatusOES : TPFNGLCHECKFRAMEBUFFERSTATUSOESPROC;cvar;external libGLEW;
    __glewDeleteFramebuffersOES : TPFNGLDELETEFRAMEBUFFERSOESPROC;cvar;external libGLEW;
    __glewDeleteRenderbuffersOES : TPFNGLDELETERENDERBUFFERSOESPROC;cvar;external libGLEW;
    __glewFramebufferRenderbufferOES : TPFNGLFRAMEBUFFERRENDERBUFFEROESPROC;cvar;external libGLEW;
    __glewFramebufferTexture2DOES : TPFNGLFRAMEBUFFERTEXTURE2DOESPROC;cvar;external libGLEW;
    __glewGenFramebuffersOES : TPFNGLGENFRAMEBUFFERSOESPROC;cvar;external libGLEW;
    __glewGenRenderbuffersOES : TPFNGLGENRENDERBUFFERSOESPROC;cvar;external libGLEW;
    __glewGenerateMipmapOES : TPFNGLGENERATEMIPMAPOESPROC;cvar;external libGLEW;
    __glewGetFramebufferAttachmentParameterivOES : TPFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC;cvar;external libGLEW;
    __glewGetRenderbufferParameterivOES : TPFNGLGETRENDERBUFFERPARAMETERIVOESPROC;cvar;external libGLEW;
    __glewIsFramebufferOES : TPFNGLISFRAMEBUFFEROESPROC;cvar;external libGLEW;
    __glewIsRenderbufferOES : TPFNGLISRENDERBUFFEROESPROC;cvar;external libGLEW;
    __glewRenderbufferStorageOES : TPFNGLRENDERBUFFERSTORAGEOESPROC;cvar;external libGLEW;
    __glewGetProgramBinaryOES : TPFNGLGETPROGRAMBINARYOESPROC;cvar;external libGLEW;
    __glewProgramBinaryOES : TPFNGLPROGRAMBINARYOESPROC;cvar;external libGLEW;
    __glewGetBufferPointervOES : TPFNGLGETBUFFERPOINTERVOESPROC;cvar;external libGLEW;
    __glewMapBufferOES : TPFNGLMAPBUFFEROESPROC;cvar;external libGLEW;
    __glewUnmapBufferOES : TPFNGLUNMAPBUFFEROESPROC;cvar;external libGLEW;
    __glewCurrentPaletteMatrixOES : TPFNGLCURRENTPALETTEMATRIXOESPROC;cvar;external libGLEW;
    __glewMatrixIndexPointerOES : TPFNGLMATRIXINDEXPOINTEROESPROC;cvar;external libGLEW;
    __glewWeightPointerOES : TPFNGLWEIGHTPOINTEROESPROC;cvar;external libGLEW;
    __glewMinSampleShadingOES : TPFNGLMINSAMPLESHADINGOESPROC;cvar;external libGLEW;
    __glewClearDepthfOES : TPFNGLCLEARDEPTHFOESPROC;cvar;external libGLEW;
    __glewClipPlanefOES : TPFNGLCLIPPLANEFOESPROC;cvar;external libGLEW;
    __glewDepthRangefOES : TPFNGLDEPTHRANGEFOESPROC;cvar;external libGLEW;
    __glewFrustumfOES : TPFNGLFRUSTUMFOESPROC;cvar;external libGLEW;
    __glewGetClipPlanefOES : TPFNGLGETCLIPPLANEFOESPROC;cvar;external libGLEW;
    __glewOrthofOES : TPFNGLORTHOFOESPROC;cvar;external libGLEW;
    __glewCompressedTexImage3DOES : TPFNGLCOMPRESSEDTEXIMAGE3DOESPROC;cvar;external libGLEW;
    __glewCompressedTexSubImage3DOES : TPFNGLCOMPRESSEDTEXSUBIMAGE3DOESPROC;cvar;external libGLEW;
    __glewCopyTexSubImage3DOES : TPFNGLCOPYTEXSUBIMAGE3DOESPROC;cvar;external libGLEW;
    __glewFramebufferTexture3DOES : TPFNGLFRAMEBUFFERTEXTURE3DOESPROC;cvar;external libGLEW;
    __glewTexImage3DOES : TPFNGLTEXIMAGE3DOESPROC;cvar;external libGLEW;
    __glewTexSubImage3DOES : TPFNGLTEXSUBIMAGE3DOESPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIivOES : TPFNGLGETSAMPLERPARAMETERIIVOESPROC;cvar;external libGLEW;
    __glewGetSamplerParameterIuivOES : TPFNGLGETSAMPLERPARAMETERIUIVOESPROC;cvar;external libGLEW;
    __glewGetTexParameterIivOES : TPFNGLGETTEXPARAMETERIIVOESPROC;cvar;external libGLEW;
    __glewGetTexParameterIuivOES : TPFNGLGETTEXPARAMETERIUIVOESPROC;cvar;external libGLEW;
    __glewSamplerParameterIivOES : TPFNGLSAMPLERPARAMETERIIVOESPROC;cvar;external libGLEW;
    __glewSamplerParameterIuivOES : TPFNGLSAMPLERPARAMETERIUIVOESPROC;cvar;external libGLEW;
    __glewTexParameterIivOES : TPFNGLTEXPARAMETERIIVOESPROC;cvar;external libGLEW;
    __glewTexParameterIuivOES : TPFNGLTEXPARAMETERIUIVOESPROC;cvar;external libGLEW;
    __glewTexBufferOES : TPFNGLTEXBUFFEROESPROC;cvar;external libGLEW;
    __glewTexBufferRangeOES : TPFNGLTEXBUFFERRANGEOESPROC;cvar;external libGLEW;
    __glewGetTexGenfvOES : TPFNGLGETTEXGENFVOESPROC;cvar;external libGLEW;
    __glewGetTexGenivOES : TPFNGLGETTEXGENIVOESPROC;cvar;external libGLEW;
    __glewGetTexGenxvOES : TPFNGLGETTEXGENXVOESPROC;cvar;external libGLEW;
    __glewTexGenfOES : TPFNGLTEXGENFOESPROC;cvar;external libGLEW;
    __glewTexGenfvOES : TPFNGLTEXGENFVOESPROC;cvar;external libGLEW;
    __glewTexGeniOES : TPFNGLTEXGENIOESPROC;cvar;external libGLEW;
    __glewTexGenivOES : TPFNGLTEXGENIVOESPROC;cvar;external libGLEW;
    __glewTexGenxOES : TPFNGLTEXGENXOESPROC;cvar;external libGLEW;
    __glewTexGenxvOES : TPFNGLTEXGENXVOESPROC;cvar;external libGLEW;
    __glewTexStorage3DMultisampleOES : TPFNGLTEXSTORAGE3DMULTISAMPLEOESPROC;cvar;external libGLEW;
    __glewTextureViewOES : TPFNGLTEXTUREVIEWOESPROC;cvar;external libGLEW;
    __glewBindVertexArrayOES : TPFNGLBINDVERTEXARRAYOESPROC;cvar;external libGLEW;
    __glewDeleteVertexArraysOES : TPFNGLDELETEVERTEXARRAYSOESPROC;cvar;external libGLEW;
    __glewGenVertexArraysOES : TPFNGLGENVERTEXARRAYSOESPROC;cvar;external libGLEW;
    __glewIsVertexArrayOES : TPFNGLISVERTEXARRAYOESPROC;cvar;external libGLEW;
    __glewFramebufferTextureMultiviewOVR : TPFNGLFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC;cvar;external libGLEW;
    __glewNamedFramebufferTextureMultiviewOVR : TPFNGLNAMEDFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC;cvar;external libGLEW;
    __glewFramebufferTextureMultisampleMultiviewOVR : TPFNGLFRAMEBUFFERTEXTUREMULTISAMPLEMULTIVIEWOVRPROC;cvar;external libGLEW;
    __glewAlphaFuncQCOM : TPFNGLALPHAFUNCQCOMPROC;cvar;external libGLEW;
    __glewDisableDriverControlQCOM : TPFNGLDISABLEDRIVERCONTROLQCOMPROC;cvar;external libGLEW;
    __glewEnableDriverControlQCOM : TPFNGLENABLEDRIVERCONTROLQCOMPROC;cvar;external libGLEW;
    __glewGetDriverControlStringQCOM : TPFNGLGETDRIVERCONTROLSTRINGQCOMPROC;cvar;external libGLEW;
    __glewGetDriverControlsQCOM : TPFNGLGETDRIVERCONTROLSQCOMPROC;cvar;external libGLEW;
    __glewExtGetBufferPointervQCOM : TPFNGLEXTGETBUFFERPOINTERVQCOMPROC;cvar;external libGLEW;
    __glewExtGetBuffersQCOM : TPFNGLEXTGETBUFFERSQCOMPROC;cvar;external libGLEW;
    __glewExtGetFramebuffersQCOM : TPFNGLEXTGETFRAMEBUFFERSQCOMPROC;cvar;external libGLEW;
    __glewExtGetRenderbuffersQCOM : TPFNGLEXTGETRENDERBUFFERSQCOMPROC;cvar;external libGLEW;
    __glewExtGetTexLevelParameterivQCOM : TPFNGLEXTGETTEXLEVELPARAMETERIVQCOMPROC;cvar;external libGLEW;
    __glewExtGetTexSubImageQCOM : TPFNGLEXTGETTEXSUBIMAGEQCOMPROC;cvar;external libGLEW;
    __glewExtGetTexturesQCOM : TPFNGLEXTGETTEXTURESQCOMPROC;cvar;external libGLEW;
    __glewExtTexObjectStateOverrideiQCOM : TPFNGLEXTTEXOBJECTSTATEOVERRIDEIQCOMPROC;cvar;external libGLEW;
    __glewExtGetProgramBinarySourceQCOM : TPFNGLEXTGETPROGRAMBINARYSOURCEQCOMPROC;cvar;external libGLEW;
    __glewExtGetProgramsQCOM : TPFNGLEXTGETPROGRAMSQCOMPROC;cvar;external libGLEW;
    __glewExtGetShadersQCOM : TPFNGLEXTGETSHADERSQCOMPROC;cvar;external libGLEW;
    __glewExtIsProgramBinaryQCOM : TPFNGLEXTISPROGRAMBINARYQCOMPROC;cvar;external libGLEW;
    __glewFramebufferFoveationConfigQCOM : TPFNGLFRAMEBUFFERFOVEATIONCONFIGQCOMPROC;cvar;external libGLEW;
    __glewFramebufferFoveationParametersQCOM : TPFNGLFRAMEBUFFERFOVEATIONPARAMETERSQCOMPROC;cvar;external libGLEW;
    __glewFramebufferFetchBarrierQCOM : TPFNGLFRAMEBUFFERFETCHBARRIERQCOMPROC;cvar;external libGLEW;
    __glewTextureFoveationParametersQCOM : TPFNGLTEXTUREFOVEATIONPARAMETERSQCOMPROC;cvar;external libGLEW;
    __glewEndTilingQCOM : TPFNGLENDTILINGQCOMPROC;cvar;external libGLEW;
    __glewStartTilingQCOM : TPFNGLSTARTTILINGQCOMPROC;cvar;external libGLEW;
    __glewAlphaFuncx : TPFNGLALPHAFUNCXPROC;cvar;external libGLEW;
    __glewClearColorx : TPFNGLCLEARCOLORXPROC;cvar;external libGLEW;
    __glewClearDepthx : TPFNGLCLEARDEPTHXPROC;cvar;external libGLEW;
    __glewColor4x : TPFNGLCOLOR4XPROC;cvar;external libGLEW;
    __glewDepthRangex : TPFNGLDEPTHRANGEXPROC;cvar;external libGLEW;
    __glewFogx : TPFNGLFOGXPROC;cvar;external libGLEW;
    __glewFogxv : TPFNGLFOGXVPROC;cvar;external libGLEW;
    __glewFrustumf : TPFNGLFRUSTUMFPROC;cvar;external libGLEW;
    __glewFrustumx : TPFNGLFRUSTUMXPROC;cvar;external libGLEW;
    __glewLightModelx : TPFNGLLIGHTMODELXPROC;cvar;external libGLEW;
    __glewLightModelxv : TPFNGLLIGHTMODELXVPROC;cvar;external libGLEW;
    __glewLightx : TPFNGLLIGHTXPROC;cvar;external libGLEW;
    __glewLightxv : TPFNGLLIGHTXVPROC;cvar;external libGLEW;
    __glewLineWidthx : TPFNGLLINEWIDTHXPROC;cvar;external libGLEW;
    __glewLoadMatrixx : TPFNGLLOADMATRIXXPROC;cvar;external libGLEW;
    __glewMaterialx : TPFNGLMATERIALXPROC;cvar;external libGLEW;
    __glewMaterialxv : TPFNGLMATERIALXVPROC;cvar;external libGLEW;
    __glewMultMatrixx : TPFNGLMULTMATRIXXPROC;cvar;external libGLEW;
    __glewMultiTexCoord4x : TPFNGLMULTITEXCOORD4XPROC;cvar;external libGLEW;
    __glewNormal3x : TPFNGLNORMAL3XPROC;cvar;external libGLEW;
    __glewOrthof : TPFNGLORTHOFPROC;cvar;external libGLEW;
    __glewOrthox : TPFNGLORTHOXPROC;cvar;external libGLEW;
    __glewPointSizex : TPFNGLPOINTSIZEXPROC;cvar;external libGLEW;
    __glewPolygonOffsetx : TPFNGLPOLYGONOFFSETXPROC;cvar;external libGLEW;
    __glewRotatex : TPFNGLROTATEXPROC;cvar;external libGLEW;
    __glewSampleCoveragex : TPFNGLSAMPLECOVERAGEXPROC;cvar;external libGLEW;
    __glewScalex : TPFNGLSCALEXPROC;cvar;external libGLEW;
    __glewTexEnvx : TPFNGLTEXENVXPROC;cvar;external libGLEW;
    __glewTexEnvxv : TPFNGLTEXENVXVPROC;cvar;external libGLEW;
    __glewTexParameterx : TPFNGLTEXPARAMETERXPROC;cvar;external libGLEW;
    __glewTranslatex : TPFNGLTRANSLATEXPROC;cvar;external libGLEW;
    __glewClipPlanef : TPFNGLCLIPPLANEFPROC;cvar;external libGLEW;
    __glewClipPlanex : TPFNGLCLIPPLANEXPROC;cvar;external libGLEW;
    __glewGetClipPlanef : TPFNGLGETCLIPPLANEFPROC;cvar;external libGLEW;
    __glewGetClipPlanex : TPFNGLGETCLIPPLANEXPROC;cvar;external libGLEW;
    __glewGetFixedv : TPFNGLGETFIXEDVPROC;cvar;external libGLEW;
    __glewGetLightxv : TPFNGLGETLIGHTXVPROC;cvar;external libGLEW;
    __glewGetMaterialxv : TPFNGLGETMATERIALXVPROC;cvar;external libGLEW;
    __glewGetTexEnvxv : TPFNGLGETTEXENVXVPROC;cvar;external libGLEW;
    __glewGetTexParameterxv : TPFNGLGETTEXPARAMETERXVPROC;cvar;external libGLEW;
    __glewPointParameterx : TPFNGLPOINTPARAMETERXPROC;cvar;external libGLEW;
    __glewPointParameterxv : TPFNGLPOINTPARAMETERXVPROC;cvar;external libGLEW;
    __glewPointSizePointerOES : TPFNGLPOINTSIZEPOINTEROESPROC;cvar;external libGLEW;
    __glewTexParameterxv : TPFNGLTEXPARAMETERXVPROC;cvar;external libGLEW;
    __glewErrorStringREGAL : TPFNGLERRORSTRINGREGALPROC;cvar;external libGLEW;
    __glewGetExtensionREGAL : TPFNGLGETEXTENSIONREGALPROC;cvar;external libGLEW;
    __glewIsSupportedREGAL : TPFNGLISSUPPORTEDREGALPROC;cvar;external libGLEW;
    __glewLogMessageCallbackREGAL : TPFNGLLOGMESSAGECALLBACKREGALPROC;cvar;external libGLEW;
    __glewGetProcAddressREGAL : TPFNGLGETPROCADDRESSREGALPROC;cvar;external libGLEW;
    __glewDetailTexFuncSGIS : TPFNGLDETAILTEXFUNCSGISPROC;cvar;external libGLEW;
    __glewGetDetailTexFuncSGIS : TPFNGLGETDETAILTEXFUNCSGISPROC;cvar;external libGLEW;
    __glewFogFuncSGIS : TPFNGLFOGFUNCSGISPROC;cvar;external libGLEW;
    __glewGetFogFuncSGIS : TPFNGLGETFOGFUNCSGISPROC;cvar;external libGLEW;
    __glewSampleMaskSGIS : TPFNGLSAMPLEMASKSGISPROC;cvar;external libGLEW;
    __glewSamplePatternSGIS : TPFNGLSAMPLEPATTERNSGISPROC;cvar;external libGLEW;
    __glewInterleavedTextureCoordSetsSGIS : TPFNGLINTERLEAVEDTEXTURECOORDSETSSGISPROC;cvar;external libGLEW;
    __glewSelectTextureCoordSetSGIS : TPFNGLSELECTTEXTURECOORDSETSGISPROC;cvar;external libGLEW;
    __glewSelectTextureSGIS : TPFNGLSELECTTEXTURESGISPROC;cvar;external libGLEW;
    __glewSelectTextureTransformSGIS : TPFNGLSELECTTEXTURETRANSFORMSGISPROC;cvar;external libGLEW;
    __glewMultisampleSubRectPosSGIS : TPFNGLMULTISAMPLESUBRECTPOSSGISPROC;cvar;external libGLEW;
    __glewGetSharpenTexFuncSGIS : TPFNGLGETSHARPENTEXFUNCSGISPROC;cvar;external libGLEW;
    __glewSharpenTexFuncSGIS : TPFNGLSHARPENTEXFUNCSGISPROC;cvar;external libGLEW;
    __glewTexImage4DSGIS : TPFNGLTEXIMAGE4DSGISPROC;cvar;external libGLEW;
    __glewTexSubImage4DSGIS : TPFNGLTEXSUBIMAGE4DSGISPROC;cvar;external libGLEW;
    __glewGetTexFilterFuncSGIS : TPFNGLGETTEXFILTERFUNCSGISPROC;cvar;external libGLEW;
    __glewTexFilterFuncSGIS : TPFNGLTEXFILTERFUNCSGISPROC;cvar;external libGLEW;
    __glewAsyncMarkerSGIX : TPFNGLASYNCMARKERSGIXPROC;cvar;external libGLEW;
    __glewDeleteAsyncMarkersSGIX : TPFNGLDELETEASYNCMARKERSSGIXPROC;cvar;external libGLEW;
    __glewFinishAsyncSGIX : TPFNGLFINISHASYNCSGIXPROC;cvar;external libGLEW;
    __glewGenAsyncMarkersSGIX : TPFNGLGENASYNCMARKERSSGIXPROC;cvar;external libGLEW;
    __glewIsAsyncMarkerSGIX : TPFNGLISASYNCMARKERSGIXPROC;cvar;external libGLEW;
    __glewPollAsyncSGIX : TPFNGLPOLLASYNCSGIXPROC;cvar;external libGLEW;
    __glewAddressSpace : TPFNGLADDRESSSPACEPROC;cvar;external libGLEW;
    __glewDataPipe : TPFNGLDATAPIPEPROC;cvar;external libGLEW;
    __glewFlushRasterSGIX : TPFNGLFLUSHRASTERSGIXPROC;cvar;external libGLEW;
    __glewFogLayersSGIX : TPFNGLFOGLAYERSSGIXPROC;cvar;external libGLEW;
    __glewGetFogLayersSGIX : TPFNGLGETFOGLAYERSSGIXPROC;cvar;external libGLEW;
    __glewTextureFogSGIX : TPFNGLTEXTUREFOGSGIXPROC;cvar;external libGLEW;
    __glewFragmentColorMaterialSGIX : TPFNGLFRAGMENTCOLORMATERIALSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightModelfSGIX : TPFNGLFRAGMENTLIGHTMODELFSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightModelfvSGIX : TPFNGLFRAGMENTLIGHTMODELFVSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightModeliSGIX : TPFNGLFRAGMENTLIGHTMODELISGIXPROC;cvar;external libGLEW;
    __glewFragmentLightModelivSGIX : TPFNGLFRAGMENTLIGHTMODELIVSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightfSGIX : TPFNGLFRAGMENTLIGHTFSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightfvSGIX : TPFNGLFRAGMENTLIGHTFVSGIXPROC;cvar;external libGLEW;
    __glewFragmentLightiSGIX : TPFNGLFRAGMENTLIGHTISGIXPROC;cvar;external libGLEW;
    __glewFragmentLightivSGIX : TPFNGLFRAGMENTLIGHTIVSGIXPROC;cvar;external libGLEW;
    __glewFragmentMaterialfSGIX : TPFNGLFRAGMENTMATERIALFSGIXPROC;cvar;external libGLEW;
    __glewFragmentMaterialfvSGIX : TPFNGLFRAGMENTMATERIALFVSGIXPROC;cvar;external libGLEW;
    __glewFragmentMaterialiSGIX : TPFNGLFRAGMENTMATERIALISGIXPROC;cvar;external libGLEW;
    __glewFragmentMaterialivSGIX : TPFNGLFRAGMENTMATERIALIVSGIXPROC;cvar;external libGLEW;
    __glewGetFragmentLightfvSGIX : TPFNGLGETFRAGMENTLIGHTFVSGIXPROC;cvar;external libGLEW;
    __glewGetFragmentLightivSGIX : TPFNGLGETFRAGMENTLIGHTIVSGIXPROC;cvar;external libGLEW;
    __glewGetFragmentMaterialfvSGIX : TPFNGLGETFRAGMENTMATERIALFVSGIXPROC;cvar;external libGLEW;
    __glewGetFragmentMaterialivSGIX : TPFNGLGETFRAGMENTMATERIALIVSGIXPROC;cvar;external libGLEW;
    __glewFrameZoomSGIX : TPFNGLFRAMEZOOMSGIXPROC;cvar;external libGLEW;
    __glewIglooInterfaceSGIX : TPFNGLIGLOOINTERFACESGIXPROC;cvar;external libGLEW;
    __glewAllocMPEGPredictorsSGIX : TPFNGLALLOCMPEGPREDICTORSSGIXPROC;cvar;external libGLEW;
    __glewDeleteMPEGPredictorsSGIX : TPFNGLDELETEMPEGPREDICTORSSGIXPROC;cvar;external libGLEW;
    __glewGenMPEGPredictorsSGIX : TPFNGLGENMPEGPREDICTORSSGIXPROC;cvar;external libGLEW;
    __glewGetMPEGParameterfvSGIX : TPFNGLGETMPEGPARAMETERFVSGIXPROC;cvar;external libGLEW;
    __glewGetMPEGParameterivSGIX : TPFNGLGETMPEGPARAMETERIVSGIXPROC;cvar;external libGLEW;
    __glewGetMPEGPredictorSGIX : TPFNGLGETMPEGPREDICTORSGIXPROC;cvar;external libGLEW;
    __glewGetMPEGQuantTableubv : TPFNGLGETMPEGQUANTTABLEUBVPROC;cvar;external libGLEW;
    __glewIsMPEGPredictorSGIX : TPFNGLISMPEGPREDICTORSGIXPROC;cvar;external libGLEW;
    __glewMPEGPredictorSGIX : TPFNGLMPEGPREDICTORSGIXPROC;cvar;external libGLEW;
    __glewMPEGQuantTableubv : TPFNGLMPEGQUANTTABLEUBVPROC;cvar;external libGLEW;
    __glewSwapMPEGPredictorsSGIX : TPFNGLSWAPMPEGPREDICTORSSGIXPROC;cvar;external libGLEW;
    __glewGetNonlinLightfvSGIX : TPFNGLGETNONLINLIGHTFVSGIXPROC;cvar;external libGLEW;
    __glewGetNonlinMaterialfvSGIX : TPFNGLGETNONLINMATERIALFVSGIXPROC;cvar;external libGLEW;
    __glewNonlinLightfvSGIX : TPFNGLNONLINLIGHTFVSGIXPROC;cvar;external libGLEW;
    __glewNonlinMaterialfvSGIX : TPFNGLNONLINMATERIALFVSGIXPROC;cvar;external libGLEW;
    __glewPixelTexGenSGIX : TPFNGLPIXELTEXGENSGIXPROC;cvar;external libGLEW;
    __glewDeformSGIX : TPFNGLDEFORMSGIXPROC;cvar;external libGLEW;
    __glewLoadIdentityDeformationMapSGIX : TPFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC;cvar;external libGLEW;
    __glewMeshBreadthSGIX : TPFNGLMESHBREADTHSGIXPROC;cvar;external libGLEW;
    __glewMeshStrideSGIX : TPFNGLMESHSTRIDESGIXPROC;cvar;external libGLEW;
    __glewReferencePlaneSGIX : TPFNGLREFERENCEPLANESGIXPROC;cvar;external libGLEW;
    __glewSpriteParameterfSGIX : TPFNGLSPRITEPARAMETERFSGIXPROC;cvar;external libGLEW;
    __glewSpriteParameterfvSGIX : TPFNGLSPRITEPARAMETERFVSGIXPROC;cvar;external libGLEW;
    __glewSpriteParameteriSGIX : TPFNGLSPRITEPARAMETERISGIXPROC;cvar;external libGLEW;
    __glewSpriteParameterivSGIX : TPFNGLSPRITEPARAMETERIVSGIXPROC;cvar;external libGLEW;
    __glewTagSampleBufferSGIX : TPFNGLTAGSAMPLEBUFFERSGIXPROC;cvar;external libGLEW;
    __glewGetVectorOperationSGIX : TPFNGLGETVECTOROPERATIONSGIXPROC;cvar;external libGLEW;
    __glewVectorOperationSGIX : TPFNGLVECTOROPERATIONSGIXPROC;cvar;external libGLEW;
    __glewAreVertexArraysResidentSGIX : TPFNGLAREVERTEXARRAYSRESIDENTSGIXPROC;cvar;external libGLEW;
    __glewBindVertexArraySGIX : TPFNGLBINDVERTEXARRAYSGIXPROC;cvar;external libGLEW;
    __glewDeleteVertexArraysSGIX : TPFNGLDELETEVERTEXARRAYSSGIXPROC;cvar;external libGLEW;
    __glewGenVertexArraysSGIX : TPFNGLGENVERTEXARRAYSSGIXPROC;cvar;external libGLEW;
    __glewIsVertexArraySGIX : TPFNGLISVERTEXARRAYSGIXPROC;cvar;external libGLEW;
    __glewPrioritizeVertexArraysSGIX : TPFNGLPRIORITIZEVERTEXARRAYSSGIXPROC;cvar;external libGLEW;
    __glewColorTableParameterfvSGI : TPFNGLCOLORTABLEPARAMETERFVSGIPROC;cvar;external libGLEW;
    __glewColorTableParameterivSGI : TPFNGLCOLORTABLEPARAMETERIVSGIPROC;cvar;external libGLEW;
    __glewColorTableSGI : TPFNGLCOLORTABLESGIPROC;cvar;external libGLEW;
    __glewCopyColorTableSGI : TPFNGLCOPYCOLORTABLESGIPROC;cvar;external libGLEW;
    __glewGetColorTableParameterfvSGI : TPFNGLGETCOLORTABLEPARAMETERFVSGIPROC;cvar;external libGLEW;
    __glewGetColorTableParameterivSGI : TPFNGLGETCOLORTABLEPARAMETERIVSGIPROC;cvar;external libGLEW;
    __glewGetColorTableSGI : TPFNGLGETCOLORTABLESGIPROC;cvar;external libGLEW;
    __glewGetPixelTransformParameterfvSGI : TPFNGLGETPIXELTRANSFORMPARAMETERFVSGIPROC;cvar;external libGLEW;
    __glewGetPixelTransformParameterivSGI : TPFNGLGETPIXELTRANSFORMPARAMETERIVSGIPROC;cvar;external libGLEW;
    __glewPixelTransformParameterfSGI : TPFNGLPIXELTRANSFORMPARAMETERFSGIPROC;cvar;external libGLEW;
    __glewPixelTransformParameterfvSGI : TPFNGLPIXELTRANSFORMPARAMETERFVSGIPROC;cvar;external libGLEW;
    __glewPixelTransformParameteriSGI : TPFNGLPIXELTRANSFORMPARAMETERISGIPROC;cvar;external libGLEW;
    __glewPixelTransformParameterivSGI : TPFNGLPIXELTRANSFORMPARAMETERIVSGIPROC;cvar;external libGLEW;
    __glewPixelTransformSGI : TPFNGLPIXELTRANSFORMSGIPROC;cvar;external libGLEW;
    __glewFinishTextureSUNX : TPFNGLFINISHTEXTURESUNXPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactorbSUN : TPFNGLGLOBALALPHAFACTORBSUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactordSUN : TPFNGLGLOBALALPHAFACTORDSUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactorfSUN : TPFNGLGLOBALALPHAFACTORFSUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactoriSUN : TPFNGLGLOBALALPHAFACTORISUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactorsSUN : TPFNGLGLOBALALPHAFACTORSSUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactorubSUN : TPFNGLGLOBALALPHAFACTORUBSUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactoruiSUN : TPFNGLGLOBALALPHAFACTORUISUNPROC;cvar;external libGLEW;
    __glewGlobalAlphaFactorusSUN : TPFNGLGLOBALALPHAFACTORUSSUNPROC;cvar;external libGLEW;
    __glewReadVideoPixelsSUN : TPFNGLREADVIDEOPIXELSSUNPROC;cvar;external libGLEW;
    __glewReplacementCodePointerSUN : TPFNGLREPLACEMENTCODEPOINTERSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeubSUN : TPFNGLREPLACEMENTCODEUBSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeubvSUN : TPFNGLREPLACEMENTCODEUBVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiSUN : TPFNGLREPLACEMENTCODEUISUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuivSUN : TPFNGLREPLACEMENTCODEUIVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeusSUN : TPFNGLREPLACEMENTCODEUSSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeusvSUN : TPFNGLREPLACEMENTCODEUSVSUNPROC;cvar;external libGLEW;
    __glewColor3fVertex3fSUN : TPFNGLCOLOR3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewColor3fVertex3fvSUN : TPFNGLCOLOR3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewColor4fNormal3fVertex3fSUN : TPFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewColor4fNormal3fVertex3fvSUN : TPFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewColor4ubVertex2fSUN : TPFNGLCOLOR4UBVERTEX2FSUNPROC;cvar;external libGLEW;
    __glewColor4ubVertex2fvSUN : TPFNGLCOLOR4UBVERTEX2FVSUNPROC;cvar;external libGLEW;
    __glewColor4ubVertex3fSUN : TPFNGLCOLOR4UBVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewColor4ubVertex3fvSUN : TPFNGLCOLOR4UBVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewNormal3fVertex3fSUN : TPFNGLNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewNormal3fVertex3fvSUN : TPFNGLNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor3fVertex3fSUN : TPFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor3fVertex3fvSUN : TPFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor4fNormal3fVertex3fSUN : TPFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor4fNormal3fVertex3fvSUN : TPFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor4ubVertex3fSUN : TPFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiColor4ubVertex3fvSUN : TPFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiNormal3fVertex3fSUN : TPFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiNormal3fVertex3fvSUN : TPFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fNormal3fVertex3fSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fVertex3fSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiTexCoord2fVertex3fvSUN : TPFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiVertex3fSUN : TPFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewReplacementCodeuiVertex3fvSUN : TPFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor3fVertex3fSUN : TPFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor3fVertex3fvSUN : TPFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor4fNormal3fVertex3fSUN : TPFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor4fNormal3fVertex3fvSUN : TPFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor4ubVertex3fSUN : TPFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fColor4ubVertex3fvSUN : TPFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fNormal3fVertex3fSUN : TPFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fNormal3fVertex3fvSUN : TPFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fVertex3fSUN : TPFNGLTEXCOORD2FVERTEX3FSUNPROC;cvar;external libGLEW;
    __glewTexCoord2fVertex3fvSUN : TPFNGLTEXCOORD2FVERTEX3FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord4fColor4fNormal3fVertex4fSUN : TPFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC;cvar;external libGLEW;
    __glewTexCoord4fColor4fNormal3fVertex4fvSUN : TPFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC;cvar;external libGLEW;
    __glewTexCoord4fVertex4fSUN : TPFNGLTEXCOORD4FVERTEX4FSUNPROC;cvar;external libGLEW;
    __glewTexCoord4fVertex4fvSUN : TPFNGLTEXCOORD4FVERTEX4FVSUNPROC;cvar;external libGLEW;
    __glewAddSwapHintRectWIN : TPFNGLADDSWAPHINTRECTWINPROC;cvar;external libGLEW;
    __GLEW_VERSION_1_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_1_2 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_1_2_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_1_3 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_1_4 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_1_5 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_2_0 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_2_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_3_0 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_3_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_3_2 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_3_3 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_0 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_2 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_3 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_4 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_5 : TGLboolean;cvar;external libGLEW;
    __GLEW_VERSION_4_6 : TGLboolean;cvar;external libGLEW;
    __GLEW_3DFX_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_3DFX_tbuffer : TGLboolean;cvar;external libGLEW;
    __GLEW_3DFX_texture_compression_FXT1 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_blend_minmax_factor : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_compressed_3DC_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_compressed_ATC_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_conservative_depth : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_debug_output : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_depth_clamp_separate : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_draw_buffers_blend : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_framebuffer_multisample_advanced : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_framebuffer_sample_positions : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_gcn_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_gpu_shader_half_float : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_gpu_shader_half_float_fetch : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_gpu_shader_int16 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_gpu_shader_int64 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_interleaved_elements : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_multi_draw_indirect : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_name_gen_delete : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_occlusion_query_event : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_performance_monitor : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_pinned_memory : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_program_binary_Z400 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_query_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_sample_positions : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_seamless_cubemap_per_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_atomic_counter_ops : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_ballot : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_explicit_vertex_parameter : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_image_load_store_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_stencil_export : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_stencil_value_export : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_shader_trinary_minmax : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_sparse_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_stencil_operation_extended : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_texture_gather_bias_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_texture_texture4 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_transform_feedback3_lines_triangles : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_transform_feedback4 : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_vertex_shader_layer : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_vertex_shader_tessellator : TGLboolean;cvar;external libGLEW;
    __GLEW_AMD_vertex_shader_viewport_index : TGLboolean;cvar;external libGLEW;
    __GLEW_ANDROID_extension_pack_es31a : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_depth_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_framebuffer_blit : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_framebuffer_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_instanced_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_pack_reverse_row_order : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_texture_compression_dxt1 : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_texture_compression_dxt3 : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_texture_compression_dxt5 : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_texture_usage : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_timer_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ANGLE_translated_shader_source : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_aux_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_client_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_clip_distance : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_color_buffer_packed_float : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_copy_texture_levels : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_element_array : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_fence : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_float_pixels : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_flush_buffer_range : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_framebuffer_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_object_purgeable : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_pixel_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_rgb_422 : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_row_bytes : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_specular_vector : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_sync : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_texture_2D_limited_npot : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_texture_format_BGRA8888 : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_texture_max_level : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_texture_packed_float : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_texture_range : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_transform_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_vertex_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_vertex_array_range : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_vertex_program_evaluators : TGLboolean;cvar;external libGLEW;
    __GLEW_APPLE_ycbcr_422 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_ES2_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_ES3_1_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_ES3_2_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_ES3_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_arrays_of_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_base_instance : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_bindless_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_blend_func_extended : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_buffer_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_cl_event : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_clear_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_clear_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_clip_control : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_color_buffer_float : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_compressed_texture_pixel_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_compute_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_compute_variable_group_size : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_conditional_render_inverted : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_conservative_depth : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_copy_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_copy_image : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_cull_distance : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_debug_output : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_depth_buffer_float : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_depth_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_depth_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_derivative_control : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_direct_state_access : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_draw_buffers_blend : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_draw_elements_base_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_draw_indirect : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_draw_instanced : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_enhanced_layouts : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_explicit_attrib_location : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_explicit_uniform_location : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_coord_conventions : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_layer_viewport : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_program : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_program_shadow : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_fragment_shader_interlock : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_framebuffer_no_attachments : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_framebuffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_framebuffer_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_geometry_shader4 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_get_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_get_texture_sub_image : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_gl_spirv : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_gpu_shader5 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_gpu_shader_fp64 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_gpu_shader_int64 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_half_float_pixel : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_half_float_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_imaging : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_indirect_parameters : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_instanced_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_internalformat_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_internalformat_query2 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_invalidate_subdata : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_map_buffer_alignment : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_map_buffer_range : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_matrix_palette : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_multi_bind : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_multi_draw_indirect : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_multitexture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_occlusion_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_occlusion_query2 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_parallel_shader_compile : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_pipeline_statistics_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_pixel_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_point_parameters : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_point_sprite : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_polygon_offset_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_post_depth_coverage : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_program_interface_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_provoking_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_query_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_robust_buffer_access_behavior : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_robustness : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_robustness_application_isolation : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_robustness_share_group_isolation : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sample_locations : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sample_shading : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sampler_objects : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_seamless_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_seamless_cubemap_per_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_separate_shader_objects : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_atomic_counter_ops : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_atomic_counters : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_ballot : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_bit_encoding : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_clock : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_draw_parameters : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_group_vote : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_image_load_store : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_image_size : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_objects : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_precision : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_stencil_export : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_storage_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_subroutine : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_texture_image_samples : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_texture_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shader_viewport_layer_array : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shading_language_100 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shading_language_420pack : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shading_language_include : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shading_language_packing : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shadow : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_shadow_ambient : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sparse_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sparse_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sparse_texture2 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sparse_texture_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_spirv_extensions : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_stencil_texturing : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_sync : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_tessellation_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_barrier : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_border_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_buffer_object_rgb32 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_buffer_range : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_compression : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_compression_bptc : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_compression_rgtc : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_cube_map_array : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_env_add : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_env_combine : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_env_crossbar : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_env_dot3 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_filter_anisotropic : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_filter_minmax : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_float : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_gather : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_mirror_clamp_to_edge : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_mirrored_repeat : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_non_power_of_two : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_query_levels : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_query_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_rectangle : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_rg : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_rgb10_a2ui : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_stencil8 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_storage_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_swizzle : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_texture_view : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_timer_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_transform_feedback2 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_transform_feedback3 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_transform_feedback_instanced : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_transform_feedback_overflow_query : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_transpose_matrix : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_uniform_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_array_bgra : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_attrib_64bit : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_attrib_binding : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_blend : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_program : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_type_10f_11f_11f_rev : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_vertex_type_2_10_10_10_rev : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_viewport_array : TGLboolean;cvar;external libGLEW;
    __GLEW_ARB_window_pos : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_mali_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_mali_shader_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_rgba8 : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_shader_framebuffer_fetch : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_shader_framebuffer_fetch_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_ARM_texture_unnormalized_coordinates : TGLboolean;cvar;external libGLEW;
    __GLEW_ATIX_point_sprites : TGLboolean;cvar;external libGLEW;
    __GLEW_ATIX_texture_env_combine3 : TGLboolean;cvar;external libGLEW;
    __GLEW_ATIX_texture_env_route : TGLboolean;cvar;external libGLEW;
    __GLEW_ATIX_vertex_shader_output_point_size : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_element_array : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_envmap_bumpmap : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_fragment_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_map_object_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_meminfo : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_pn_triangles : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_separate_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_shader_texture_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_text_fragment_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_texture_compression_3dc : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_texture_env_combine3 : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_texture_float : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_texture_mirror_once : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_vertex_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_vertex_attrib_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_ATI_vertex_streams : TGLboolean;cvar;external libGLEW;
    __GLEW_DMP_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_DMP_shader_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_422_pixels : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_Cg_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_EGL_image_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_EGL_image_external_wrap_modes : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_EGL_image_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_EGL_sync : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_YUV_target : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_abgr : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_base_instance : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_bgra : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_bindable_uniform : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_color : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_equation_separate : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_func_extended : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_func_separate : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_logic_op : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_minmax : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_blend_subtract : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_buffer_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_clear_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_clip_control : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_clip_cull_distance : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_clip_volume_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_cmyka : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_color_buffer_float : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_color_buffer_half_float : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_color_subtable : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_compiled_vertex_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_compressed_ETC1_RGB8_sub_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_conservative_depth : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_convolution : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_coordinate_frame : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_copy_image : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_copy_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_cull_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_debug_label : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_debug_marker : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_depth_bounds_test : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_depth_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_direct_state_access : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_discard_framebuffer : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_disjoint_timer_query : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_buffers2 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_buffers_indexed : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_elements_base_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_instanced : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_range_elements : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_draw_transform_feedback : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_external_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_float_blend : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_fog_coord : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_frag_depth : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_fragment_lighting : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_framebuffer_blit : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_framebuffer_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_framebuffer_multisample_blit_scaled : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_framebuffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_framebuffer_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_geometry_point_size : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_geometry_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_geometry_shader4 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_gpu_program_parameters : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_gpu_shader4 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_gpu_shader5 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_histogram : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_index_array_formats : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_index_func : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_index_material : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_index_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_instanced_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_light_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_map_buffer_range : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_memory_object : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_memory_object_fd : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_memory_object_win32 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_misc_attribute : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multi_draw_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multi_draw_indirect : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multiple_textures : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multisample_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multisampled_render_to_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multisampled_render_to_texture2 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multiview_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multiview_tessellation_geometry_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multiview_texture_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_multiview_timer_query : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_occlusion_query_boolean : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_packed_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_packed_float : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_packed_pixels : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_paletted_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_pixel_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_pixel_transform : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_pixel_transform_color_table : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_point_parameters : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_polygon_offset : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_polygon_offset_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_post_depth_coverage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_primitive_bounding_box : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_protected_textures : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_provoking_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_pvrtc_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_raster_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_read_format_bgra : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_render_snorm : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_rescale_normal : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_robustness : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_sRGB_write_control : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_scene_marker : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_secondary_color : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_semaphore : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_semaphore_fd : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_semaphore_win32 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_separate_shader_objects : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_separate_specular_color : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_framebuffer_fetch : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_framebuffer_fetch_non_coherent : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_group_vote : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_image_load_formatted : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_image_load_store : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_implicit_conversions : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_integer_mix : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_io_blocks : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_non_constant_global_initializers : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_pixel_local_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_pixel_local_storage2 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shader_texture_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shadow_funcs : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shadow_samplers : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_shared_texture_palette : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_sparse_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_sparse_texture2 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_static_vertex_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_stencil_clear_tag : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_stencil_two_side : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_stencil_wrap : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_subtexture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_tessellation_point_size : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_tessellation_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture3D : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_border_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_astc_decode_mode : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_astc_decode_mode_rgb9e5 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_bptc : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_dxt1 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_latc : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_rgtc : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_s3tc : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_compression_s3tc_srgb : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_cube_map_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_edge_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_env : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_env_add : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_env_combine : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_env_dot3 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_filter_anisotropic : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_filter_minmax : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_format_BGRA8888 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_format_sRGB_override : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_integer : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_lod_bias : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_mirror_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_mirror_clamp_to_edge : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_norm16 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_object : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_perturb_normal : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_query_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_rectangle : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_rg : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_sRGB_R8 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_sRGB_RG8 : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_sRGB_decode : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_shadow_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_shared_exponent : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_snorm : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_storage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_swizzle : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_type_2_10_10_10_REV : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_texture_view : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_timer_query : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_transform_feedback : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_unpack_subimage : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_array : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_array_bgra : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_array_setXXX : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_attrib_64bit : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_vertex_weighting : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_win32_keyed_mutex : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_window_rectangles : TGLboolean;cvar;external libGLEW;
    __GLEW_EXT_x11_sync_object : TGLboolean;cvar;external libGLEW;
    __GLEW_FJ_shader_binary_GCCSO : TGLboolean;cvar;external libGLEW;
    __GLEW_GREMEDY_frame_terminator : TGLboolean;cvar;external libGLEW;
    __GLEW_GREMEDY_string_marker : TGLboolean;cvar;external libGLEW;
    __GLEW_HP_convolution_border_modes : TGLboolean;cvar;external libGLEW;
    __GLEW_HP_image_transform : TGLboolean;cvar;external libGLEW;
    __GLEW_HP_occlusion_test : TGLboolean;cvar;external libGLEW;
    __GLEW_HP_texture_lighting : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_cull_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_multimode_draw_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_rasterpos_clip : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_static_data : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_texture_mirrored_repeat : TGLboolean;cvar;external libGLEW;
    __GLEW_IBM_vertex_array_lists : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_bindless_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_framebuffer_downsample : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_multisampled_render_to_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_read_format : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_shader_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_texture_compression_pvrtc : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_texture_compression_pvrtc2 : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_texture_env_enhanced_fixed_function : TGLboolean;cvar;external libGLEW;
    __GLEW_IMG_texture_filter_cubic : TGLboolean;cvar;external libGLEW;
    __GLEW_INGR_color_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_INGR_interlace_read : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_blackhole_render : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_conservative_rasterization : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_fragment_shader_ordering : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_framebuffer_CMAA : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_map_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_parallel_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_performance_query : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_shader_integer_functions2 : TGLboolean;cvar;external libGLEW;
    __GLEW_INTEL_texture_scissor : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_blend_equation_advanced : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_blend_equation_advanced_coherent : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_context_flush_control : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_debug : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_no_error : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_parallel_shader_compile : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_robust_buffer_access_behavior : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_robustness : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_shader_subgroup : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_texture_compression_astc_hdr : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_texture_compression_astc_ldr : TGLboolean;cvar;external libGLEW;
    __GLEW_KHR_texture_compression_astc_sliced_3d : TGLboolean;cvar;external libGLEW;
    __GLEW_KTX_buffer_region : TGLboolean;cvar;external libGLEW;
    __GLEW_MESAX_texture_stack : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_framebuffer_flip_y : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_pack_invert : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_program_binary_formats : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_resize_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_shader_integer_functions : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_tile_raster_order : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_window_pos : TGLboolean;cvar;external libGLEW;
    __GLEW_MESA_ycbcr_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_blend_equation_advanced_multi_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_conditional_render : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_gpu_memory_info : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_gpu_multicast2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_linked_gpu_multicast : TGLboolean;cvar;external libGLEW;
    __GLEW_NVX_progress_fence : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_3dvision_settings : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_EGL_stream_consumer_external : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_alpha_to_coverage_dither_control : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_bgr : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_bindless_multi_draw_indirect : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_bindless_multi_draw_indirect_count : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_bindless_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_blend_equation_advanced : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_blend_equation_advanced_coherent : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_blend_minmax_factor : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_blend_square : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_clip_space_w_scaling : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_command_list : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_compute_program5 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_compute_shader_derivatives : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conditional_render : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conservative_raster : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conservative_raster_dilate : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conservative_raster_pre_snap : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conservative_raster_pre_snap_triangles : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_conservative_raster_underestimation : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_copy_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_copy_depth_to_color : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_copy_image : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_deep_texture3D : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_depth_buffer_float : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_depth_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_depth_nonlinear : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_depth_range_unclamped : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_draw_buffers : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_draw_instanced : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_draw_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_draw_vulkan_image : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_evaluators : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_explicit_attrib_location : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_explicit_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fbo_color_attachments : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fence : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fill_rectangle : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_float_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fog_distance : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_coverage_to_color : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_program : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_program2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_program4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_program_option : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_shader_barycentric : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_fragment_shader_interlock : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_framebuffer_blit : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_framebuffer_mixed_samples : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_framebuffer_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_framebuffer_multisample_coverage : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_generate_mipmap_sRGB : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_geometry_program4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_geometry_shader4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_geometry_shader_passthrough : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_multicast : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_program4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_program5 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_program5_mem_extended : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_program_fp64 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_gpu_shader5 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_half_float : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_image_formats : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_instanced_arrays : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_internalformat_sample_query : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_light_max_exponent : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_memory_attachment : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_mesh_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_multisample_coverage : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_multisample_filter_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_non_square_matrices : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_occlusion_query : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_pack_subimage : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_packed_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_packed_float : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_packed_float_linear : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_parameter_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_parameter_buffer_object2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_path_rendering : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_path_rendering_shared_edge : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_pixel_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_pixel_data_range : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_platform_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_point_sprite : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_polygon_mode : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_present_video : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_primitive_restart : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_query_resource_tag : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_read_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_read_buffer_front : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_read_depth : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_read_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_read_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_register_combiners : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_register_combiners2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_representative_fragment_test : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_robustness_video_memory_purge : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_sRGB_formats : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_sample_locations : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_sample_mask_override_coverage : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_scissor_exclusive : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_atomic_counters : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_atomic_float : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_atomic_float64 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_atomic_fp16_vector : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_atomic_int64 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_buffer_load : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_noperspective_interpolation : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_storage_buffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_subgroup_partitioned : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_texture_footprint : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_thread_group : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shader_thread_shuffle : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shading_rate_image : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shadow_samplers_array : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_shadow_samplers_cube : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_stereo_view_rendering : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_tessellation_program5 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texgen_emboss : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texgen_reflection : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_array : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_barrier : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_border_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_compression_latc : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_compression_s3tc : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_compression_s3tc_update : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_compression_vtc : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_env_combine4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_expand_normal : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_npot_2D_mipmap : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_rectangle : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_rectangle_compressed : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_shader2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_texture_shader3 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_transform_feedback : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_transform_feedback2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_uniform_buffer_unified_memory : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vdpau_interop : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vdpau_interop2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_array_range : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_array_range2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_attrib_integer_64bit : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_buffer_unified_memory : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program1_1 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program2_option : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program3 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_vertex_program4 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_video_capture : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_viewport_array : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_viewport_array2 : TGLboolean;cvar;external libGLEW;
    __GLEW_NV_viewport_swizzle : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_EGL_image : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_EGL_image_external : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_EGL_image_external_essl3 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_blend_equation_separate : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_blend_func_separate : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_blend_subtract : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_byte_coordinates : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_compressed_ETC1_RGB8_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_compressed_paletted_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_copy_image : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_depth24 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_depth32 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_depth_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_depth_texture_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_draw_buffers_indexed : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_draw_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_element_index_uint : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_extended_matrix_palette : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_fbo_render_mipmap : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_fragment_precision_high : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_framebuffer_object : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_geometry_point_size : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_geometry_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_get_program_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_gpu_shader5 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_mapbuffer : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_matrix_get : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_matrix_palette : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_packed_depth_stencil : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_point_size_array : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_point_sprite : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_read_format : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_required_internalformat : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_rgb8_rgba8 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_sample_shading : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_sample_variables : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_shader_image_atomic : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_shader_io_blocks : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_shader_multisample_interpolation : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_single_precision : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_standard_derivatives : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_stencil1 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_stencil4 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_stencil8 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_surfaceless_context : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_tessellation_point_size : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_tessellation_shader : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_3D : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_border_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_compression_astc : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_cube_map_array : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_env_crossbar : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_mirrored_repeat : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_npot : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_stencil8 : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_storage_multisample_2d_array : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_texture_view : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_vertex_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_vertex_half_float : TGLboolean;cvar;external libGLEW;
    __GLEW_OES_vertex_type_10_10_10_2 : TGLboolean;cvar;external libGLEW;
    __GLEW_OML_interlace : TGLboolean;cvar;external libGLEW;
    __GLEW_OML_resample : TGLboolean;cvar;external libGLEW;
    __GLEW_OML_subsample : TGLboolean;cvar;external libGLEW;
    __GLEW_OVR_multiview : TGLboolean;cvar;external libGLEW;
    __GLEW_OVR_multiview2 : TGLboolean;cvar;external libGLEW;
    __GLEW_OVR_multiview_multisampled_render_to_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_PGI_misc_hints : TGLboolean;cvar;external libGLEW;
    __GLEW_PGI_vertex_hints : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_YUV_texture_gather : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_alpha_test : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_binning_control : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_driver_control : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_extended_get : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_extended_get2 : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_framebuffer_foveated : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_perfmon_global_mode : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_shader_framebuffer_fetch_noncoherent : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_shader_framebuffer_fetch_rate : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_texture_foveated : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_texture_foveated_subsampled_layout : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_tiled_rendering : TGLboolean;cvar;external libGLEW;
    __GLEW_QCOM_writeonly_rendering : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_ES1_0_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_ES1_1_compatibility : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_enable : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_error_string : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_extension_query : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_log : TGLboolean;cvar;external libGLEW;
    __GLEW_REGAL_proc_address : TGLboolean;cvar;external libGLEW;
    __GLEW_REND_screen_coordinates : TGLboolean;cvar;external libGLEW;
    __GLEW_S3_s3tc : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_clip_band_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_color_range : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_detail_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_fog_function : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_generate_mipmap : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_line_texgen : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_multitexture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_pixel_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_point_line_texgen : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_shared_multisample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_sharpen_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture4D : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture_border_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture_edge_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture_filter4 : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIS_texture_select : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_async : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_async_histogram : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_async_pixel : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_bali_g_instruments : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_bali_r_instruments : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_bali_timer_instruments : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_blend_alpha_minmax : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_blend_cadd : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_blend_cmultiply : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_calligraphic_fragment : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_clipmap : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_color_matrix_accuracy : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_color_table_index_mode : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_complex_polar : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_convolution_accuracy : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_cube_map : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_cylinder_texgen : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_datapipe : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_decimation : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_depth_pass_instrument : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_depth_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_dvc : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_flush_raster : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_blend : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_factor_to_alpha : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_layers : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_offset : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_patchy : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_scale : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fog_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fragment_lighting_space : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fragment_specular_lighting : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_fragments_instrument : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_framezoom : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_icc_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_igloo_interface : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_image_compression : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_impact_pixel_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_instrument_error : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_interlace : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_ir_instrument1 : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_line_quality_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_list_priority : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_mpeg1 : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_mpeg2 : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_nonlinear_lighting_pervertex : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_nurbs_eval : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_occlusion_instrument : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_packed_6bytes : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_pixel_texture : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_pixel_texture_bits : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_pixel_texture_lod : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_pixel_tiles : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_polynomial_ffd : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_quad_mesh : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_reference_plane : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_resample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_scalebias_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_shadow : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_shadow_ambient : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_slim : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_spotlight_cutoff : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_sprite : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_subdiv_patch : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_subsample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_tag_sample_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_add_env : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_coordinate_clamp : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_lod_bias : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_mipmap_anisotropic : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_multi_buffer : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_phase : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_range : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_scale_bias : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_texture_supersample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_vector_ops : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_vertex_array_object : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_vertex_preclip : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_vertex_preclip_hint : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_ycrcb : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_ycrcb_subsample : TGLboolean;cvar;external libGLEW;
    __GLEW_SGIX_ycrcba : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_color_matrix : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_color_table : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_complex : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_complex_type : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_fft : TGLboolean;cvar;external libGLEW;
    __GLEW_SGI_texture_color_table : TGLboolean;cvar;external libGLEW;
    __GLEW_SUNX_constant_data : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_convolution_border_modes : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_global_alpha : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_mesh_array : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_read_video_pixels : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_slice_accum : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_triangle_list : TGLboolean;cvar;external libGLEW;
    __GLEW_SUN_vertex : TGLboolean;cvar;external libGLEW;
    __GLEW_VIV_shader_binary : TGLboolean;cvar;external libGLEW;
    __GLEW_WIN_phong_shading : TGLboolean;cvar;external libGLEW;
    __GLEW_WIN_scene_markerXXX : TGLboolean;cvar;external libGLEW;
    __GLEW_WIN_specular_fog : TGLboolean;cvar;external libGLEW;
    __GLEW_WIN_swap_hint : TGLboolean;cvar;external libGLEW;
{ -------------------------------------------------------------------------  }
{ error codes  }

const
  GLEW_OK = 0;  
  GLEW_NO_ERROR = 0;  
  GLEW_ERROR_NO_GL_VERSION = 1;
  GLEW_ERROR_GL_VERSION_10_ONLY = 2;
  GLEW_ERROR_GLX_VERSION_11_ONLY = 3;
  GLEW_ERROR_NO_GLX_DISPLAY = 4;
  GLEW_VERSION = 1;
  GLEW_VERSION_MAJOR = 2;  
  GLEW_VERSION_MINOR = 3;  
  GLEW_VERSION_MICRO = 4;  
{ -------------------------------------------------------------------------  }

{ API  }

function glewInit:TGLenum;cdecl;external libGLEW;
function glewIsSupported(name:Pchar):TGLboolean;cdecl;external libGLEW;

function glewIsExtensionSupported(x : PChar) : Boolean;

{$ifndef GLEW_GET_VAR}
{#define GLEW_GET_VAR(x) (*(const GLboolean*)&x) }
{$endif}
{$ifndef GLEW_GET_FUN}
function GLEW_GET_FUN(x : longint) : longint;

{$endif}
  var
    glewExperimental : TGLboolean;cvar;external libGLEW;

function glewGetExtension(name:Pchar):TGLboolean;cdecl;external libGLEW;
function glewGetErrorString(error:TGLenum):PGLubyte;cdecl;external libGLEW;
function glewGetString(name:TGLenum):PGLubyte;cdecl;external libGLEW;

// === Konventiert am: 24-6-25 13:43:02 ===


implementation



{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function glewIsExtensionSupported(x: PChar): Boolean;
begin
  glewIsExtensionSupported:=glewIsSupported(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function GLEW_GET_FUN(x : longint) : longint;
begin
  GLEW_GET_FUN:=x;
end;


end.
