unit gl;

interface

uses
  ctypes;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

  {$LinkLib 'GL'}

{
 * Mesa 3-D graphics library
 *
 * Copyright (C) 1999-2006  Brian Paul   All Rights Reserved.
 * Copyright (C) 2009  VMware, Inc.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
  }

const
  GL_VERSION_1_1 = 1;
  GL_VERSION_1_2 = 1;
  GL_VERSION_1_3 = 1;
  GL_ARB_imaging = 1;
{
 * Datatypes
  }
type
  PGLenum = ^TGLenum;
  TGLenum = dword;

  PPGLboolean = ^TGLboolean;
  PGLboolean = ^TGLboolean;
  TGLboolean = byte;

  PGLbitfield = ^TGLbitfield;
  TGLbitfield = dword;

  PPGLvoid = ^PGLvoid;
  PGLvoid = ^TGLvoid;
  TGLvoid = pointer;

  PGLbyte = ^TGLbyte;
  TGLbyte = char;
  { 1-byte signed  }

  PGLshort = ^TGLshort;
  TGLshort = smallint;
  { 2-byte signed  }

  PGLint = ^TGLint;
  TGLint = longint;
  { 4-byte signed  }

  PGLubyte = ^TGLubyte;
  TGLubyte = byte;
  { 1-byte unsigned  }

  PGLushort = ^TGLushort;
  TGLushort = word;
  { 2-byte unsigned  }

  PGLuint = ^TGLuint;
  TGLuint = dword;
  { 4-byte unsigned  }

  PGLsizei = ^TGLsizei;
  TGLsizei = longint;
  { 4-byte signed  }

  PGLfloat = ^TGLfloat;
  TGLfloat = single;
  { single precision float  }

  PGLclampf = ^TGLclampf;
  TGLclampf = single;
  { single precision float in [0,1]  }

  PGLdouble = ^TGLdouble;
  TGLdouble = cdouble;
  { double precision float  }

  PGLclampd = ^TGLclampd;
  TGLclampd = cdouble;
  { double precision float in [0,1]  }
{
 * Constants
  }
  { Boolean values  }

const
  GL_FALSE = 0;
  GL_TRUE = 1;
  { Data types  }
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
  { Primitives  }
  GL_POINTS = $0000;
  GL_LINES = $0001;
  GL_LINE_LOOP = $0002;
  GL_LINE_STRIP = $0003;
  GL_TRIANGLES = $0004;
  GL_TRIANGLE_STRIP = $0005;
  GL_TRIANGLE_FAN = $0006;
  GL_QUADS = $0007;
  GL_QUAD_STRIP = $0008;
  GL_POLYGON = $0009;
  { Vertex Arrays  }
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
  { Matrix Mode  }
  GL_MATRIX_MODE = $0BA0;
  GL_MODELVIEW = $1700;
  GL_PROJECTION = $1701;
  GL_TEXTURE = $1702;
  { Points  }
  GL_POINT_SMOOTH = $0B10;
  GL_POINT_SIZE = $0B11;
  GL_POINT_SIZE_GRANULARITY = $0B13;
  GL_POINT_SIZE_RANGE = $0B12;
  { Lines  }
  GL_LINE_SMOOTH = $0B20;
  GL_LINE_STIPPLE = $0B24;
  GL_LINE_STIPPLE_PATTERN = $0B25;
  GL_LINE_STIPPLE_REPEAT = $0B26;
  GL_LINE_WIDTH = $0B21;
  GL_LINE_WIDTH_GRANULARITY = $0B23;
  GL_LINE_WIDTH_RANGE = $0B22;
  { Polygons  }
  GL_POINT = $1B00;
  GL_LINE = $1B01;
  GL_FILL = $1B02;
  GL_CW = $0900;
  GL_CCW = $0901;
  GL_FRONT = $0404;
  GL_BACK = $0405;
  GL_POLYGON_MODE = $0B40;
  GL_POLYGON_SMOOTH = $0B41;
  GL_POLYGON_STIPPLE = $0B42;
  GL_EDGE_FLAG = $0B43;
  GL_CULL_FACE = $0B44;
  GL_CULL_FACE_MODE = $0B45;
  GL_FRONT_FACE = $0B46;
  GL_POLYGON_OFFSET_FACTOR = $8038;
  GL_POLYGON_OFFSET_UNITS = $2A00;
  GL_POLYGON_OFFSET_POINT = $2A01;
  GL_POLYGON_OFFSET_LINE = $2A02;
  GL_POLYGON_OFFSET_FILL = $8037;
  { Display Lists  }
  GL_COMPILE = $1300;
  GL_COMPILE_AND_EXECUTE = $1301;
  GL_LIST_BASE = $0B32;
  GL_LIST_INDEX = $0B33;
  GL_LIST_MODE = $0B30;
  { Depth buffer  }
  GL_NEVER = $0200;
  GL_LESS = $0201;
  GL_EQUAL = $0202;
  GL_LEQUAL = $0203;
  GL_GREATER = $0204;
  GL_NOTEQUAL = $0205;
  GL_GEQUAL = $0206;
  GL_ALWAYS = $0207;
  GL_DEPTH_TEST = $0B71;
  GL_DEPTH_BITS = $0D56;
  GL_DEPTH_CLEAR_VALUE = $0B73;
  GL_DEPTH_FUNC = $0B74;
  GL_DEPTH_RANGE = $0B70;
  GL_DEPTH_WRITEMASK = $0B72;
  GL_DEPTH_COMPONENT = $1902;
  { Lighting  }
  GL_LIGHTING = $0B50;
  GL_LIGHT0 = $4000;
  GL_LIGHT1 = $4001;
  GL_LIGHT2 = $4002;
  GL_LIGHT3 = $4003;
  GL_LIGHT4 = $4004;
  GL_LIGHT5 = $4005;
  GL_LIGHT6 = $4006;
  GL_LIGHT7 = $4007;
  GL_SPOT_EXPONENT = $1205;
  GL_SPOT_CUTOFF = $1206;
  GL_CONSTANT_ATTENUATION = $1207;
  GL_LINEAR_ATTENUATION = $1208;
  GL_QUADRATIC_ATTENUATION = $1209;
  GL_AMBIENT = $1200;
  GL_DIFFUSE = $1201;
  GL_SPECULAR = $1202;
  GL_SHININESS = $1601;
  GL_EMISSION = $1600;
  GL_POSITION = $1203;
  GL_SPOT_DIRECTION = $1204;
  GL_AMBIENT_AND_DIFFUSE = $1602;
  GL_COLOR_INDEXES = $1603;
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  GL_LIGHT_MODEL_LOCAL_VIEWER = $0B51;
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  GL_FRONT_AND_BACK = $0408;
  GL_SHADE_MODEL = $0B54;
  GL_FLAT = $1D00;
  GL_SMOOTH = $1D01;
  GL_COLOR_MATERIAL = $0B57;
  GL_COLOR_MATERIAL_FACE = $0B55;
  GL_COLOR_MATERIAL_PARAMETER = $0B56;
  GL_NORMALIZE = $0BA1;
  { User clipping planes  }
  GL_CLIP_PLANE0 = $3000;
  GL_CLIP_PLANE1 = $3001;
  GL_CLIP_PLANE2 = $3002;
  GL_CLIP_PLANE3 = $3003;
  GL_CLIP_PLANE4 = $3004;
  GL_CLIP_PLANE5 = $3005;
  { Accumulation buffer  }
  GL_ACCUM_RED_BITS = $0D58;
  GL_ACCUM_GREEN_BITS = $0D59;
  GL_ACCUM_BLUE_BITS = $0D5A;
  GL_ACCUM_ALPHA_BITS = $0D5B;
  GL_ACCUM_CLEAR_VALUE = $0B80;
  GL_ACCUM = $0100;
  GL_ADD = $0104;
  GL_LOAD = $0101;
  GL_MULT = $0103;
  GL_RETURN = $0102;
  { Alpha testing  }
  GL_ALPHA_TEST = $0BC0;
  GL_ALPHA_TEST_REF = $0BC2;
  GL_ALPHA_TEST_FUNC = $0BC1;
  { Blending  }
  GL_BLEND = $0BE2;
  GL_BLEND_SRC = $0BE1;
  GL_BLEND_DST = $0BE0;
  GL_ZERO = 0;
  GL_ONE = 1;
  GL_SRC_COLOR = $0300;
  GL_ONE_MINUS_SRC_COLOR = $0301;
  GL_SRC_ALPHA = $0302;
  GL_ONE_MINUS_SRC_ALPHA = $0303;
  GL_DST_ALPHA = $0304;
  GL_ONE_MINUS_DST_ALPHA = $0305;
  GL_DST_COLOR = $0306;
  GL_ONE_MINUS_DST_COLOR = $0307;
  GL_SRC_ALPHA_SATURATE = $0308;
  { Render Mode  }
  GL_FEEDBACK = $1C01;
  GL_RENDER = $1C00;
  GL_SELECT = $1C02;
  { Feedback  }
  GL_2D = $0600;
  GL_3D = $0601;
  GL_3D_COLOR = $0602;
  GL_3D_COLOR_TEXTURE = $0603;
  GL_4D_COLOR_TEXTURE = $0604;
  GL_POINT_TOKEN = $0701;
  GL_LINE_TOKEN = $0702;
  GL_LINE_RESET_TOKEN = $0707;
  GL_POLYGON_TOKEN = $0703;
  GL_BITMAP_TOKEN = $0704;
  GL_DRAW_PIXEL_TOKEN = $0705;
  GL_COPY_PIXEL_TOKEN = $0706;
  GL_PASS_THROUGH_TOKEN = $0700;
  GL_FEEDBACK_BUFFER_POINTER = $0DF0;
  GL_FEEDBACK_BUFFER_SIZE = $0DF1;
  GL_FEEDBACK_BUFFER_TYPE = $0DF2;
  { Selection  }
  GL_SELECTION_BUFFER_POINTER = $0DF3;
  GL_SELECTION_BUFFER_SIZE = $0DF4;
  { Fog  }
  GL_FOG = $0B60;
  GL_FOG_MODE = $0B65;
  GL_FOG_DENSITY = $0B62;
  GL_FOG_COLOR = $0B66;
  GL_FOG_INDEX = $0B61;
  GL_FOG_START = $0B63;
  GL_FOG_END = $0B64;
  GL_LINEAR = $2601;
  GL_EXP = $0800;
  GL_EXP2 = $0801;
  { Logic Ops  }
  GL_LOGIC_OP = $0BF1;
  GL_INDEX_LOGIC_OP = $0BF1;
  GL_COLOR_LOGIC_OP = $0BF2;
  GL_LOGIC_OP_MODE = $0BF0;
  GL_CLEAR = $1500;
  GL_SET = $150F;
  GL_COPY = $1503;
  GL_COPY_INVERTED = $150C;
  GL_NOOP = $1505;
  GL_INVERT = $150A;
  GL_AND = $1501;
  GL_NAND = $150E;
  GL_OR = $1507;
  GL_NOR = $1508;
  GL_XOR = $1506;
  GL_EQUIV = $1509;
  GL_AND_REVERSE = $1502;
  GL_AND_INVERTED = $1504;
  GL_OR_REVERSE = $150B;
  GL_OR_INVERTED = $150D;
  { Stencil  }
  GL_STENCIL_BITS = $0D57;
  GL_STENCIL_TEST = $0B90;
  GL_STENCIL_CLEAR_VALUE = $0B91;
  GL_STENCIL_FUNC = $0B92;
  GL_STENCIL_VALUE_MASK = $0B93;
  GL_STENCIL_FAIL = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;
  GL_STENCIL_REF = $0B97;
  GL_STENCIL_WRITEMASK = $0B98;
  GL_STENCIL_INDEX = $1901;
  GL_KEEP = $1E00;
  GL_REPLACE = $1E01;
  GL_INCR = $1E02;
  GL_DECR = $1E03;
  { Buffers, Pixel Drawing/Reading  }
  GL_NONE = 0;
  GL_LEFT = $0406;
  GL_RIGHT = $0407;
  {GL_FRONT          0x0404  }
  {GL_BACK          0x0405  }
  {GL_FRONT_AND_BACK        0x0408  }
  GL_FRONT_LEFT = $0400;
  GL_FRONT_RIGHT = $0401;
  GL_BACK_LEFT = $0402;
  GL_BACK_RIGHT = $0403;
  GL_AUX0 = $0409;
  GL_AUX1 = $040A;
  GL_AUX2 = $040B;
  GL_AUX3 = $040C;
  GL_COLOR_INDEX = $1900;
  GL_RED = $1903;
  GL_GREEN = $1904;
  GL_BLUE = $1905;
  GL_ALPHA = $1906;
  GL_LUMINANCE = $1909;
  GL_LUMINANCE_ALPHA = $190A;
  GL_ALPHA_BITS = $0D55;
  GL_RED_BITS = $0D52;
  GL_GREEN_BITS = $0D53;
  GL_BLUE_BITS = $0D54;
  GL_INDEX_BITS = $0D51;
  GL_SUBPIXEL_BITS = $0D50;
  GL_AUX_BUFFERS = $0C00;
  GL_READ_BUFFER = $0C02;
  GL_DRAW_BUFFER = $0C01;
  GL_DOUBLEBUFFER = $0C32;
  GL_STEREO = $0C33;
  GL_BITMAP = $1A00;
  GL_COLOR = $1800;
  GL_DEPTH = $1801;
  GL_STENCIL = $1802;
  GL_DITHER = $0BD0;
  GL_RGB = $1907;
  GL_RGBA = $1908;
  { Implementation limits  }
  GL_MAX_LIST_NESTING = $0B31;
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
  { Gets  }
  GL_ATTRIB_STACK_DEPTH = $0BB0;
  GL_CLIENT_ATTRIB_STACK_DEPTH = $0BB1;
  GL_COLOR_CLEAR_VALUE = $0C22;
  GL_COLOR_WRITEMASK = $0C23;
  GL_CURRENT_INDEX = $0B01;
  GL_CURRENT_COLOR = $0B00;
  GL_CURRENT_NORMAL = $0B02;
  GL_CURRENT_RASTER_COLOR = $0B04;
  GL_CURRENT_RASTER_DISTANCE = $0B09;
  GL_CURRENT_RASTER_INDEX = $0B05;
  GL_CURRENT_RASTER_POSITION = $0B07;
  GL_CURRENT_RASTER_TEXTURE_COORDS = $0B06;
  GL_CURRENT_RASTER_POSITION_VALID = $0B08;
  GL_CURRENT_TEXTURE_COORDS = $0B03;
  GL_INDEX_CLEAR_VALUE = $0C20;
  GL_INDEX_MODE = $0C30;
  GL_INDEX_WRITEMASK = $0C21;
  GL_MODELVIEW_MATRIX = $0BA6;
  GL_MODELVIEW_STACK_DEPTH = $0BA3;
  GL_NAME_STACK_DEPTH = $0D70;
  GL_PROJECTION_MATRIX = $0BA7;
  GL_PROJECTION_STACK_DEPTH = $0BA4;
  GL_RENDER_MODE = $0C40;
  GL_RGBA_MODE = $0C31;
  GL_TEXTURE_MATRIX = $0BA8;
  GL_TEXTURE_STACK_DEPTH = $0BA5;
  GL_VIEWPORT = $0BA2;
  { Evaluators  }
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
  GL_COEFF = $0A00;
  GL_ORDER = $0A01;
  GL_DOMAIN = $0A02;
  { Hints  }
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;
  GL_POINT_SMOOTH_HINT = $0C51;
  GL_LINE_SMOOTH_HINT = $0C52;
  GL_POLYGON_SMOOTH_HINT = $0C53;
  GL_FOG_HINT = $0C54;
  GL_DONT_CARE = $1100;
  GL_FASTEST = $1101;
  GL_NICEST = $1102;
  { Scissor box  }
  GL_SCISSOR_BOX = $0C10;
  GL_SCISSOR_TEST = $0C11;
  { Pixel Mode / Transfer  }
  GL_MAP_COLOR = $0D10;
  GL_MAP_STENCIL = $0D11;
  GL_INDEX_SHIFT = $0D12;
  GL_INDEX_OFFSET = $0D13;
  GL_RED_SCALE = $0D14;
  GL_RED_BIAS = $0D15;
  GL_GREEN_SCALE = $0D18;
  GL_GREEN_BIAS = $0D19;
  GL_BLUE_SCALE = $0D1A;
  GL_BLUE_BIAS = $0D1B;
  GL_ALPHA_SCALE = $0D1C;
  GL_ALPHA_BIAS = $0D1D;
  GL_DEPTH_SCALE = $0D1E;
  GL_DEPTH_BIAS = $0D1F;
  GL_PIXEL_MAP_S_TO_S_SIZE = $0CB1;
  GL_PIXEL_MAP_I_TO_I_SIZE = $0CB0;
  GL_PIXEL_MAP_I_TO_R_SIZE = $0CB2;
  GL_PIXEL_MAP_I_TO_G_SIZE = $0CB3;
  GL_PIXEL_MAP_I_TO_B_SIZE = $0CB4;
  GL_PIXEL_MAP_I_TO_A_SIZE = $0CB5;
  GL_PIXEL_MAP_R_TO_R_SIZE = $0CB6;
  GL_PIXEL_MAP_G_TO_G_SIZE = $0CB7;
  GL_PIXEL_MAP_B_TO_B_SIZE = $0CB8;
  GL_PIXEL_MAP_A_TO_A_SIZE = $0CB9;
  GL_PIXEL_MAP_S_TO_S = $0C71;
  GL_PIXEL_MAP_I_TO_I = $0C70;
  GL_PIXEL_MAP_I_TO_R = $0C72;
  GL_PIXEL_MAP_I_TO_G = $0C73;
  GL_PIXEL_MAP_I_TO_B = $0C74;
  GL_PIXEL_MAP_I_TO_A = $0C75;
  GL_PIXEL_MAP_R_TO_R = $0C76;
  GL_PIXEL_MAP_G_TO_G = $0C77;
  GL_PIXEL_MAP_B_TO_B = $0C78;
  GL_PIXEL_MAP_A_TO_A = $0C79;
  GL_PACK_ALIGNMENT = $0D05;
  GL_PACK_LSB_FIRST = $0D01;
  GL_PACK_ROW_LENGTH = $0D02;
  GL_PACK_SKIP_PIXELS = $0D04;
  GL_PACK_SKIP_ROWS = $0D03;
  GL_PACK_SWAP_BYTES = $0D00;
  GL_UNPACK_ALIGNMENT = $0CF5;
  GL_UNPACK_LSB_FIRST = $0CF1;
  GL_UNPACK_ROW_LENGTH = $0CF2;
  GL_UNPACK_SKIP_PIXELS = $0CF4;
  GL_UNPACK_SKIP_ROWS = $0CF3;
  GL_UNPACK_SWAP_BYTES = $0CF0;
  GL_ZOOM_X = $0D16;
  GL_ZOOM_Y = $0D17;
  { Texture mapping  }
  GL_TEXTURE_ENV = $2300;
  GL_TEXTURE_ENV_MODE = $2200;
  GL_TEXTURE_1D = $0DE0;
  GL_TEXTURE_2D = $0DE1;
  GL_TEXTURE_WRAP_S = $2802;
  GL_TEXTURE_WRAP_T = $2803;
  GL_TEXTURE_MAG_FILTER = $2800;
  GL_TEXTURE_MIN_FILTER = $2801;
  GL_TEXTURE_ENV_COLOR = $2201;
  GL_TEXTURE_GEN_S = $0C60;
  GL_TEXTURE_GEN_T = $0C61;
  GL_TEXTURE_GEN_R = $0C62;
  GL_TEXTURE_GEN_Q = $0C63;
  GL_TEXTURE_GEN_MODE = $2500;
  GL_TEXTURE_BORDER_COLOR = $1004;
  GL_TEXTURE_WIDTH = $1000;
  GL_TEXTURE_HEIGHT = $1001;
  GL_TEXTURE_BORDER = $1005;
  GL_TEXTURE_COMPONENTS = $1003;
  GL_TEXTURE_RED_SIZE = $805C;
  GL_TEXTURE_GREEN_SIZE = $805D;
  GL_TEXTURE_BLUE_SIZE = $805E;
  GL_TEXTURE_ALPHA_SIZE = $805F;
  GL_TEXTURE_LUMINANCE_SIZE = $8060;
  GL_TEXTURE_INTENSITY_SIZE = $8061;
  GL_NEAREST_MIPMAP_NEAREST = $2700;
  GL_NEAREST_MIPMAP_LINEAR = $2702;
  GL_LINEAR_MIPMAP_NEAREST = $2701;
  GL_LINEAR_MIPMAP_LINEAR = $2703;
  GL_OBJECT_LINEAR = $2401;
  GL_OBJECT_PLANE = $2501;
  GL_EYE_LINEAR = $2400;
  GL_EYE_PLANE = $2502;
  GL_SPHERE_MAP = $2402;
  GL_DECAL = $2101;
  GL_MODULATE = $2100;
  GL_NEAREST = $2600;
  GL_REPEAT = $2901;
  GL_CLAMP = $2900;
  GL_S = $2000;
  GL_T = $2001;
  GL_R = $2002;
  GL_Q = $2003;
  { Utility  }
  GL_VENDOR = $1F00;
  GL_RENDERER = $1F01;
  GL_VERSION = $1F02;
  GL_EXTENSIONS = $1F03;
  { Errors  }
  GL_NO_ERROR = 0;
  GL_INVALID_ENUM = $0500;
  GL_INVALID_VALUE = $0501;
  GL_INVALID_OPERATION = $0502;
  GL_STACK_OVERFLOW = $0503;
  GL_STACK_UNDERFLOW = $0504;
  GL_OUT_OF_MEMORY = $0505;
  { glPush/PopAttrib bits  }
  GL_CURRENT_BIT = $00000001;
  GL_POINT_BIT = $00000002;
  GL_LINE_BIT = $00000004;
  GL_POLYGON_BIT = $00000008;
  GL_POLYGON_STIPPLE_BIT = $00000010;
  GL_PIXEL_MODE_BIT = $00000020;
  GL_LIGHTING_BIT = $00000040;
  GL_FOG_BIT = $00000080;
  GL_DEPTH_BUFFER_BIT = $00000100;
  GL_ACCUM_BUFFER_BIT = $00000200;
  GL_STENCIL_BUFFER_BIT = $00000400;
  GL_VIEWPORT_BIT = $00000800;
  GL_TRANSFORM_BIT = $00001000;
  GL_ENABLE_BIT = $00002000;
  GL_COLOR_BUFFER_BIT = $00004000;
  GL_HINT_BIT = $00008000;
  GL_EVAL_BIT = $00010000;
  GL_LIST_BIT = $00020000;
  GL_TEXTURE_BIT = $00040000;
  GL_SCISSOR_BIT = $00080000;
  GL_ALL_ATTRIB_BITS = $000FFFFF;
  { OpenGL 1.1  }
  GL_PROXY_TEXTURE_1D = $8063;
  GL_PROXY_TEXTURE_2D = $8064;
  GL_TEXTURE_PRIORITY = $8066;
  GL_TEXTURE_RESIDENT = $8067;
  GL_TEXTURE_BINDING_1D = $8068;
  GL_TEXTURE_BINDING_2D = $8069;
  GL_TEXTURE_INTERNAL_FORMAT = $1003;
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
  GL_R3_G3_B2 = $2A10;
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
  GL_CLIENT_PIXEL_STORE_BIT = $00000001;
  GL_CLIENT_VERTEX_ARRAY_BIT = $00000002;
  GL_ALL_CLIENT_ATTRIB_BITS = $FFFFFFFF;
  GL_CLIENT_ALL_ATTRIB_BITS = $FFFFFFFF;
{
 * Miscellaneous
  }

procedure glClearIndex(c: TGLfloat); cdecl; external;
procedure glClearColor(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); cdecl; external;
procedure glClear(mask: TGLbitfield); cdecl; external;
procedure glIndexMask(mask: TGLuint); cdecl; external;
procedure glColorMask(red: TGLboolean; green: TGLboolean; blue: TGLboolean; alpha: TGLboolean); cdecl; external;
procedure glAlphaFunc(func: TGLenum; ref: TGLclampf); cdecl; external;
procedure glBlendFunc(sfactor: TGLenum; dfactor: TGLenum); cdecl; external;
procedure glLogicOp(opcode: TGLenum); cdecl; external;
procedure glCullFace(mode: TGLenum); cdecl; external;
procedure glFrontFace(mode: TGLenum); cdecl; external;
procedure glPointSize(size: TGLfloat); cdecl; external;
procedure glLineWidth(Width: TGLfloat); cdecl; external;
procedure glLineStipple(factor: TGLint; pattern: TGLushort); cdecl; external;
procedure glPolygonMode(face: TGLenum; mode: TGLenum); cdecl; external;
procedure glPolygonOffset(factor: TGLfloat; units: TGLfloat); cdecl; external;
procedure glPolygonStipple(mask: PGLubyte); cdecl; external;
procedure glGetPolygonStipple(mask: PGLubyte); cdecl; external;
procedure glEdgeFlag(flag: TGLboolean); cdecl; external;
procedure glEdgeFlagv(flag: PGLboolean); cdecl; external;
procedure glScissor(x: TGLint; y: TGLint; Width: TGLsizei; Height: TGLsizei); cdecl; external;
procedure glClipPlane(plane: TGLenum; equation: PGLdouble); cdecl; external;
procedure glGetClipPlane(plane: TGLenum; equation: PGLdouble); cdecl; external;
procedure glDrawBuffer(mode: TGLenum); cdecl; external;
procedure glReadBuffer(mode: TGLenum); cdecl; external;
procedure glEnable(cap: TGLenum); cdecl; external;
procedure glDisable(cap: TGLenum); cdecl; external;
function glIsEnabled(cap: TGLenum): TGLboolean; cdecl; external;
procedure glEnableClientState(cap: TGLenum); cdecl; external;
{ 1.1  }
procedure glDisableClientState(cap: TGLenum); cdecl; external;
{ 1.1  }
procedure glGetBooleanv(pname: TGLenum; params: PGLboolean); cdecl; external;
procedure glGetDoublev(pname: TGLenum; params: PGLdouble); cdecl; external;
procedure glGetFloatv(pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetIntegerv(pname: TGLenum; params: PGLint); cdecl; external;
procedure glPushAttrib(mask: TGLbitfield); cdecl; external;
procedure glPopAttrib; cdecl; external;
procedure glPushClientAttrib(mask: TGLbitfield); cdecl; external;
{ 1.1  }
procedure glPopClientAttrib; cdecl; external;
{ 1.1  }
function glRenderMode(mode: TGLenum): TGLint; cdecl; external;
function glGetError: TGLenum; cdecl; external;
function glGetString(Name: TGLenum): PGLubyte; cdecl; external;
procedure glFinish; cdecl; external;
procedure glFlush; cdecl; external;
procedure glHint(target: TGLenum; mode: TGLenum); cdecl; external;
{
 * Depth Buffer
  }
procedure glClearDepth(depth: TGLclampd); cdecl; external;
procedure glDepthFunc(func: TGLenum); cdecl; external;
procedure glDepthMask(flag: TGLboolean); cdecl; external;
procedure glDepthRange(near_val: TGLclampd; far_val: TGLclampd); cdecl; external;
{
 * Accumulation Buffer
  }
procedure glClearAccum(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); cdecl; external;
procedure glAccum(op: TGLenum; Value: TGLfloat); cdecl; external;
{
 * Transformation
  }
procedure glMatrixMode(mode: TGLenum); cdecl; external;
procedure glOrtho(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; near_val: TGLdouble;
  far_val: TGLdouble); cdecl; external;
procedure glFrustum(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; near_val: TGLdouble;
  far_val: TGLdouble); cdecl; external;
procedure glViewport(x: TGLint; y: TGLint; Width: TGLsizei; Height: TGLsizei); cdecl; external;
procedure glPushMatrix; cdecl; external;
procedure glPopMatrix; cdecl; external;
procedure glLoadIdentity; cdecl; external;
procedure glLoadMatrixd(m: PGLdouble); cdecl; external;
procedure glLoadMatrixf(m: PGLfloat); cdecl; external;
procedure glMultMatrixd(m: PGLdouble); cdecl; external;
procedure glMultMatrixf(m: PGLfloat); cdecl; external;
procedure glRotated(angle: TGLdouble; x: TGLdouble; y: TGLdouble; z: TGLdouble); cdecl; external;
procedure glRotatef(angle: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat); cdecl; external;
procedure glScaled(x: TGLdouble; y: TGLdouble; z: TGLdouble); cdecl; external;
procedure glScalef(x: TGLfloat; y: TGLfloat; z: TGLfloat); cdecl; external;
procedure glTranslated(x: TGLdouble; y: TGLdouble; z: TGLdouble); cdecl; external;
procedure glTranslatef(x: TGLfloat; y: TGLfloat; z: TGLfloat); cdecl; external;
{
 * Display Lists
  }
function glIsList(list: TGLuint): TGLboolean; cdecl; external;
procedure glDeleteLists(list: TGLuint; range: TGLsizei); cdecl; external;
function glGenLists(range: TGLsizei): TGLuint; cdecl; external;
procedure glNewList(list: TGLuint; mode: TGLenum); cdecl; external;
procedure glEndList; cdecl; external;
procedure glCallList(list: TGLuint); cdecl; external;
procedure glCallLists(n: TGLsizei; _type: TGLenum; lists: PGLvoid); cdecl; external;
procedure glListBase(base: TGLuint); cdecl; external;
{
 * Drawing Functions
  }
procedure glBegin(mode: TGLenum); cdecl; external;
procedure glEnd; cdecl; external;
procedure glVertex2d(x: TGLdouble; y: TGLdouble); cdecl; external;
procedure glVertex2f(x: TGLfloat; y: TGLfloat); cdecl; external;
procedure glVertex2i(x: TGLint; y: TGLint); cdecl; external;
procedure glVertex2s(x: TGLshort; y: TGLshort); cdecl; external;
procedure glVertex3d(x: TGLdouble; y: TGLdouble; z: TGLdouble); cdecl; external;
procedure glVertex3f(x: TGLfloat; y: TGLfloat; z: TGLfloat); cdecl; external;
procedure glVertex3i(x: TGLint; y: TGLint; z: TGLint); cdecl; external;
procedure glVertex3s(x: TGLshort; y: TGLshort; z: TGLshort); cdecl; external;
procedure glVertex4d(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); cdecl; external;
procedure glVertex4f(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); cdecl; external;
procedure glVertex4i(x: TGLint; y: TGLint; z: TGLint; w: TGLint); cdecl; external;
procedure glVertex4s(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); cdecl; external;
procedure glVertex2dv(v: PGLdouble); cdecl; external;
procedure glVertex2fv(v: PGLfloat); cdecl; external;
procedure glVertex2iv(v: PGLint); cdecl; external;
procedure glVertex2sv(v: PGLshort); cdecl; external;
procedure glVertex3dv(v: PGLdouble); cdecl; external;
procedure glVertex3fv(v: PGLfloat); cdecl; external;
procedure glVertex3iv(v: PGLint); cdecl; external;
procedure glVertex3sv(v: PGLshort); cdecl; external;
procedure glVertex4dv(v: PGLdouble); cdecl; external;
procedure glVertex4fv(v: PGLfloat); cdecl; external;
procedure glVertex4iv(v: PGLint); cdecl; external;
procedure glVertex4sv(v: PGLshort); cdecl; external;
procedure glNormal3b(nx: TGLbyte; ny: TGLbyte; nz: TGLbyte); cdecl; external;
procedure glNormal3d(nx: TGLdouble; ny: TGLdouble; nz: TGLdouble); cdecl; external;
procedure glNormal3f(nx: TGLfloat; ny: TGLfloat; nz: TGLfloat); cdecl; external;
procedure glNormal3i(nx: TGLint; ny: TGLint; nz: TGLint); cdecl; external;
procedure glNormal3s(nx: TGLshort; ny: TGLshort; nz: TGLshort); cdecl; external;
procedure glNormal3bv(v: PGLbyte); cdecl; external;
procedure glNormal3dv(v: PGLdouble); cdecl; external;
procedure glNormal3fv(v: PGLfloat); cdecl; external;
procedure glNormal3iv(v: PGLint); cdecl; external;
procedure glNormal3sv(v: PGLshort); cdecl; external;
procedure glIndexd(c: TGLdouble); cdecl; external;
procedure glIndexf(c: TGLfloat); cdecl; external;
procedure glIndexi(c: TGLint); cdecl; external;
procedure glIndexs(c: TGLshort); cdecl; external;
procedure glIndexub(c: TGLubyte); cdecl; external;
{ 1.1  }
procedure glIndexdv(c: PGLdouble); cdecl; external;
procedure glIndexfv(c: PGLfloat); cdecl; external;
procedure glIndexiv(c: PGLint); cdecl; external;
procedure glIndexsv(c: PGLshort); cdecl; external;
procedure glIndexubv(c: PGLubyte); cdecl; external;
{ 1.1  }
procedure glColor3b(red: TGLbyte; green: TGLbyte; blue: TGLbyte); cdecl; external;
procedure glColor3d(red: TGLdouble; green: TGLdouble; blue: TGLdouble); cdecl; external;
procedure glColor3f(red: TGLfloat; green: TGLfloat; blue: TGLfloat); cdecl; external;
procedure glColor3i(red: TGLint; green: TGLint; blue: TGLint); cdecl; external;
procedure glColor3s(red: TGLshort; green: TGLshort; blue: TGLshort); cdecl; external;
procedure glColor3ub(red: TGLubyte; green: TGLubyte; blue: TGLubyte); cdecl; external;
procedure glColor3ui(red: TGLuint; green: TGLuint; blue: TGLuint); cdecl; external;
procedure glColor3us(red: TGLushort; green: TGLushort; blue: TGLushort); cdecl; external;
procedure glColor4b(red: TGLbyte; green: TGLbyte; blue: TGLbyte; alpha: TGLbyte); cdecl; external;
procedure glColor4d(red: TGLdouble; green: TGLdouble; blue: TGLdouble; alpha: TGLdouble); cdecl; external;
procedure glColor4f(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); cdecl; external;
procedure glColor4i(red: TGLint; green: TGLint; blue: TGLint; alpha: TGLint); cdecl; external;
procedure glColor4s(red: TGLshort; green: TGLshort; blue: TGLshort; alpha: TGLshort); cdecl; external;
procedure glColor4ub(red: TGLubyte; green: TGLubyte; blue: TGLubyte; alpha: TGLubyte); cdecl; external;
procedure glColor4ui(red: TGLuint; green: TGLuint; blue: TGLuint; alpha: TGLuint); cdecl; external;
procedure glColor4us(red: TGLushort; green: TGLushort; blue: TGLushort; alpha: TGLushort); cdecl; external;
procedure glColor3bv(v: PGLbyte); cdecl; external;
procedure glColor3dv(v: PGLdouble); cdecl; external;
procedure glColor3fv(v: PGLfloat); cdecl; external;
procedure glColor3iv(v: PGLint); cdecl; external;
procedure glColor3sv(v: PGLshort); cdecl; external;
procedure glColor3ubv(v: PGLubyte); cdecl; external;
procedure glColor3uiv(v: PGLuint); cdecl; external;
procedure glColor3usv(v: PGLushort); cdecl; external;
procedure glColor4bv(v: PGLbyte); cdecl; external;
procedure glColor4dv(v: PGLdouble); cdecl; external;
procedure glColor4fv(v: PGLfloat); cdecl; external;
procedure glColor4iv(v: PGLint); cdecl; external;
procedure glColor4sv(v: PGLshort); cdecl; external;
procedure glColor4ubv(v: PGLubyte); cdecl; external;
procedure glColor4uiv(v: PGLuint); cdecl; external;
procedure glColor4usv(v: PGLushort); cdecl; external;
procedure glTexCoord1d(s: TGLdouble); cdecl; external;
procedure glTexCoord1f(s: TGLfloat); cdecl; external;
procedure glTexCoord1i(s: TGLint); cdecl; external;
procedure glTexCoord1s(s: TGLshort); cdecl; external;
procedure glTexCoord2d(s: TGLdouble; t: TGLdouble); cdecl; external;
procedure glTexCoord2f(s: TGLfloat; t: TGLfloat); cdecl; external;
procedure glTexCoord2i(s: TGLint; t: TGLint); cdecl; external;
procedure glTexCoord2s(s: TGLshort; t: TGLshort); cdecl; external;
procedure glTexCoord3d(s: TGLdouble; t: TGLdouble; r: TGLdouble); cdecl; external;
procedure glTexCoord3f(s: TGLfloat; t: TGLfloat; r: TGLfloat); cdecl; external;
procedure glTexCoord3i(s: TGLint; t: TGLint; r: TGLint); cdecl; external;
procedure glTexCoord3s(s: TGLshort; t: TGLshort; r: TGLshort); cdecl; external;
procedure glTexCoord4d(s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); cdecl; external;
procedure glTexCoord4f(s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); cdecl; external;
procedure glTexCoord4i(s: TGLint; t: TGLint; r: TGLint; q: TGLint); cdecl; external;
procedure glTexCoord4s(s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); cdecl; external;
procedure glTexCoord1dv(v: PGLdouble); cdecl; external;
procedure glTexCoord1fv(v: PGLfloat); cdecl; external;
procedure glTexCoord1iv(v: PGLint); cdecl; external;
procedure glTexCoord1sv(v: PGLshort); cdecl; external;
procedure glTexCoord2dv(v: PGLdouble); cdecl; external;
procedure glTexCoord2fv(v: PGLfloat); cdecl; external;
procedure glTexCoord2iv(v: PGLint); cdecl; external;
procedure glTexCoord2sv(v: PGLshort); cdecl; external;
procedure glTexCoord3dv(v: PGLdouble); cdecl; external;
procedure glTexCoord3fv(v: PGLfloat); cdecl; external;
procedure glTexCoord3iv(v: PGLint); cdecl; external;
procedure glTexCoord3sv(v: PGLshort); cdecl; external;
procedure glTexCoord4dv(v: PGLdouble); cdecl; external;
procedure glTexCoord4fv(v: PGLfloat); cdecl; external;
procedure glTexCoord4iv(v: PGLint); cdecl; external;
procedure glTexCoord4sv(v: PGLshort); cdecl; external;
procedure glRasterPos2d(x: TGLdouble; y: TGLdouble); cdecl; external;
procedure glRasterPos2f(x: TGLfloat; y: TGLfloat); cdecl; external;
procedure glRasterPos2i(x: TGLint; y: TGLint); cdecl; external;
procedure glRasterPos2s(x: TGLshort; y: TGLshort); cdecl; external;
procedure glRasterPos3d(x: TGLdouble; y: TGLdouble; z: TGLdouble); cdecl; external;
procedure glRasterPos3f(x: TGLfloat; y: TGLfloat; z: TGLfloat); cdecl; external;
procedure glRasterPos3i(x: TGLint; y: TGLint; z: TGLint); cdecl; external;
procedure glRasterPos3s(x: TGLshort; y: TGLshort; z: TGLshort); cdecl; external;
procedure glRasterPos4d(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); cdecl; external;
procedure glRasterPos4f(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); cdecl; external;
procedure glRasterPos4i(x: TGLint; y: TGLint; z: TGLint; w: TGLint); cdecl; external;
procedure glRasterPos4s(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); cdecl; external;
procedure glRasterPos2dv(v: PGLdouble); cdecl; external;
procedure glRasterPos2fv(v: PGLfloat); cdecl; external;
procedure glRasterPos2iv(v: PGLint); cdecl; external;
procedure glRasterPos2sv(v: PGLshort); cdecl; external;
procedure glRasterPos3dv(v: PGLdouble); cdecl; external;
procedure glRasterPos3fv(v: PGLfloat); cdecl; external;
procedure glRasterPos3iv(v: PGLint); cdecl; external;
procedure glRasterPos3sv(v: PGLshort); cdecl; external;
procedure glRasterPos4dv(v: PGLdouble); cdecl; external;
procedure glRasterPos4fv(v: PGLfloat); cdecl; external;
procedure glRasterPos4iv(v: PGLint); cdecl; external;
procedure glRasterPos4sv(v: PGLshort); cdecl; external;
procedure glRectd(x1: TGLdouble; y1: TGLdouble; x2: TGLdouble; y2: TGLdouble); cdecl; external;
procedure glRectf(x1: TGLfloat; y1: TGLfloat; x2: TGLfloat; y2: TGLfloat); cdecl; external;
procedure glRecti(x1: TGLint; y1: TGLint; x2: TGLint; y2: TGLint); cdecl; external;
procedure glRects(x1: TGLshort; y1: TGLshort; x2: TGLshort; y2: TGLshort); cdecl; external;
procedure glRectdv(v1: PGLdouble; v2: PGLdouble); cdecl; external;
procedure glRectfv(v1: PGLfloat; v2: PGLfloat); cdecl; external;
procedure glRectiv(v1: PGLint; v2: PGLint); cdecl; external;
procedure glRectsv(v1: PGLshort; v2: PGLshort); cdecl; external;
{
 * Vertex Arrays  (1.1)
  }
procedure glVertexPointer(size: TGLint; _type: TGLenum; stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glNormalPointer(_type: TGLenum; stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glColorPointer(size: TGLint; _type: TGLenum; stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glIndexPointer(_type: TGLenum; stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glTexCoordPointer(size: TGLint; _type: TGLenum; stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glEdgeFlagPointer(stride: TGLsizei; ptr: PGLvoid); cdecl; external;
procedure glGetPointerv(pname: TGLenum; params: PPGLvoid); cdecl; external;
procedure glArrayElement(i: TGLint); cdecl; external;
procedure glDrawArrays(mode: TGLenum; First: TGLint; Count: TGLsizei); cdecl; external;
procedure glDrawElements(mode: TGLenum; Count: TGLsizei; _type: TGLenum; indices: PGLvoid); cdecl; external;
procedure glInterleavedArrays(format: TGLenum; stride: TGLsizei; pointer: PGLvoid); cdecl; external;
{
 * Lighting
  }
procedure glShadeModel(mode: TGLenum); cdecl; external;
procedure glLightf(light: TGLenum; pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glLighti(light: TGLenum; pname: TGLenum; param: TGLint); cdecl; external;
procedure glLightfv(light: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glLightiv(light: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetLightfv(light: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetLightiv(light: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glLightModelf(pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glLightModeli(pname: TGLenum; param: TGLint); cdecl; external;
procedure glLightModelfv(pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glLightModeliv(pname: TGLenum; params: PGLint); cdecl; external;
procedure glMaterialf(face: TGLenum; pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glMateriali(face: TGLenum; pname: TGLenum; param: TGLint); cdecl; external;
procedure glMaterialfv(face: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glMaterialiv(face: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetMaterialfv(face: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetMaterialiv(face: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glColorMaterial(face: TGLenum; mode: TGLenum); cdecl; external;
{
 * Raster functions
  }
procedure glPixelZoom(xfactor: TGLfloat; yfactor: TGLfloat); cdecl; external;
procedure glPixelStoref(pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glPixelStorei(pname: TGLenum; param: TGLint); cdecl; external;
procedure glPixelTransferf(pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glPixelTransferi(pname: TGLenum; param: TGLint); cdecl; external;
procedure glPixelMapfv(map: TGLenum; mapsize: TGLsizei; values: PGLfloat); cdecl; external;
procedure glPixelMapuiv(map: TGLenum; mapsize: TGLsizei; values: PGLuint); cdecl; external;
procedure glPixelMapusv(map: TGLenum; mapsize: TGLsizei; values: PGLushort); cdecl; external;
procedure glGetPixelMapfv(map: TGLenum; values: PGLfloat); cdecl; external;
procedure glGetPixelMapuiv(map: TGLenum; values: PGLuint); cdecl; external;
procedure glGetPixelMapusv(map: TGLenum; values: PGLushort); cdecl; external;
procedure glBitmap(Width: TGLsizei; Height: TGLsizei; xorig: TGLfloat; yorig: TGLfloat; xmove: TGLfloat;
  ymove: TGLfloat; bitmap: PGLubyte); cdecl; external;
procedure glReadPixels(x: TGLint; y: TGLint; Width: TGLsizei; Height: TGLsizei; format: TGLenum;
  _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glDrawPixels(Width: TGLsizei; Height: TGLsizei; format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glCopyPixels(x: TGLint; y: TGLint; Width: TGLsizei; Height: TGLsizei; _type: TGLenum); cdecl; external;
{
 * Stenciling
  }
procedure glStencilFunc(func: TGLenum; ref: TGLint; mask: TGLuint); cdecl; external;
procedure glStencilMask(mask: TGLuint); cdecl; external;
procedure glStencilOp(fail: TGLenum; zfail: TGLenum; zpass: TGLenum); cdecl; external;
procedure glClearStencil(s: TGLint); cdecl; external;
{
 * Texture mapping
  }
procedure glTexGend(coord: TGLenum; pname: TGLenum; param: TGLdouble); cdecl; external;
procedure glTexGenf(coord: TGLenum; pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glTexGeni(coord: TGLenum; pname: TGLenum; param: TGLint); cdecl; external;
procedure glTexGendv(coord: TGLenum; pname: TGLenum; params: PGLdouble); cdecl; external;
procedure glTexGenfv(coord: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glTexGeniv(coord: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetTexGendv(coord: TGLenum; pname: TGLenum; params: PGLdouble); cdecl; external;
procedure glGetTexGenfv(coord: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetTexGeniv(coord: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glTexEnvf(target: TGLenum; pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glTexEnvi(target: TGLenum; pname: TGLenum; param: TGLint); cdecl; external;
procedure glTexEnvfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glTexEnviv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetTexEnvfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetTexEnviv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glTexParameterf(target: TGLenum; pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glTexParameteri(target: TGLenum; pname: TGLenum; param: TGLint); cdecl; external;
procedure glTexParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glTexParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetTexParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetTexParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glGetTexLevelParameterfv(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetTexLevelParameteriv(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLint); cdecl; external;
procedure glTexImage1D(target: TGLenum; level: TGLint; internalFormat: TGLint; Width: TGLsizei; border: TGLint;
  format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glTexImage2D(target: TGLenum; level: TGLint; internalFormat: TGLint; Width: TGLsizei; Height: TGLsizei;
  border: TGLint; format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glGetTexImage(target: TGLenum; level: TGLint; format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
{ 1.1 functions  }
procedure glGenTextures(n: TGLsizei; textures: PGLuint); cdecl; external;
procedure glDeleteTextures(n: TGLsizei; textures: PGLuint); cdecl; external;
procedure glBindTexture(target: TGLenum; texture: TGLuint); cdecl; external;
procedure glPrioritizeTextures(n: TGLsizei; textures: PGLuint; priorities: PGLclampf); cdecl; external;
function glAreTexturesResident(n: TGLsizei; textures: PGLuint; residences: PGLboolean): TGLboolean; cdecl; external;
function glIsTexture(texture: TGLuint): TGLboolean; cdecl; external;
procedure glTexSubImage1D(target: TGLenum; level: TGLint; xoffset: TGLint; Width: TGLsizei; format: TGLenum;
  _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glTexSubImage2D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; Width: TGLsizei;
  Height: TGLsizei; format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glCopyTexImage1D(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint;
  Width: TGLsizei; border: TGLint); cdecl; external;
procedure glCopyTexImage2D(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint;
  Width: TGLsizei; Height: TGLsizei; border: TGLint); cdecl; external;
procedure glCopyTexSubImage1D(target: TGLenum; level: TGLint; xoffset: TGLint; x: TGLint; y: TGLint;
  Width: TGLsizei); cdecl; external;
procedure glCopyTexSubImage2D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; x: TGLint;
  y: TGLint; Width: TGLsizei; Height: TGLsizei); cdecl; external;
{
 * Evaluators
  }
procedure glMap1d(target: TGLenum; u1: TGLdouble; u2: TGLdouble; stride: TGLint; order: TGLint;
  points: PGLdouble); cdecl; external;
procedure glMap1f(target: TGLenum; u1: TGLfloat; u2: TGLfloat; stride: TGLint; order: TGLint;
  points: PGLfloat); cdecl; external;
procedure glMap2d(target: TGLenum; u1: TGLdouble; u2: TGLdouble; ustride: TGLint; uorder: TGLint;
  v1: TGLdouble; v2: TGLdouble; vstride: TGLint; vorder: TGLint; points: PGLdouble); cdecl; external;
procedure glMap2f(target: TGLenum; u1: TGLfloat; u2: TGLfloat; ustride: TGLint; uorder: TGLint;
  v1: TGLfloat; v2: TGLfloat; vstride: TGLint; vorder: TGLint; points: PGLfloat); cdecl; external;
procedure glGetMapdv(target: TGLenum; query: TGLenum; v: PGLdouble); cdecl; external;
procedure glGetMapfv(target: TGLenum; query: TGLenum; v: PGLfloat); cdecl; external;
procedure glGetMapiv(target: TGLenum; query: TGLenum; v: PGLint); cdecl; external;
procedure glEvalCoord1d(u: TGLdouble); cdecl; external;
procedure glEvalCoord1f(u: TGLfloat); cdecl; external;
procedure glEvalCoord1dv(u: PGLdouble); cdecl; external;
procedure glEvalCoord1fv(u: PGLfloat); cdecl; external;
procedure glEvalCoord2d(u: TGLdouble; v: TGLdouble); cdecl; external;
procedure glEvalCoord2f(u: TGLfloat; v: TGLfloat); cdecl; external;
procedure glEvalCoord2dv(u: PGLdouble); cdecl; external;
procedure glEvalCoord2fv(u: PGLfloat); cdecl; external;
procedure glMapGrid1d(un: TGLint; u1: TGLdouble; u2: TGLdouble); cdecl; external;
procedure glMapGrid1f(un: TGLint; u1: TGLfloat; u2: TGLfloat); cdecl; external;
procedure glMapGrid2d(un: TGLint; u1: TGLdouble; u2: TGLdouble; vn: TGLint; v1: TGLdouble;
  v2: TGLdouble); cdecl; external;
procedure glMapGrid2f(un: TGLint; u1: TGLfloat; u2: TGLfloat; vn: TGLint; v1: TGLfloat;
  v2: TGLfloat); cdecl; external;
procedure glEvalPoint1(i: TGLint); cdecl; external;
procedure glEvalPoint2(i: TGLint; j: TGLint); cdecl; external;
procedure glEvalMesh1(mode: TGLenum; i1: TGLint; i2: TGLint); cdecl; external;
procedure glEvalMesh2(mode: TGLenum; i1: TGLint; i2: TGLint; j1: TGLint; j2: TGLint); cdecl; external;
{
 * Fog
  }
procedure glFogf(pname: TGLenum; param: TGLfloat); cdecl; external;
procedure glFogi(pname: TGLenum; param: TGLint); cdecl; external;
procedure glFogfv(pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glFogiv(pname: TGLenum; params: PGLint); cdecl; external;
{
 * Selection and Feedback
  }
procedure glFeedbackBuffer(size: TGLsizei; _type: TGLenum; buffer: PGLfloat); cdecl; external;
procedure glPassThrough(token: TGLfloat); cdecl; external;
procedure glSelectBuffer(size: TGLsizei; buffer: PGLuint); cdecl; external;
procedure glInitNames; cdecl; external;
procedure glLoadName(Name: TGLuint); cdecl; external;
procedure glPushName(Name: TGLuint); cdecl; external;
procedure glPopName; cdecl; external;
{
 * OpenGL 1.2
  }
const
  GL_RESCALE_NORMAL = $803A;
  GL_CLAMP_TO_EDGE = $812F;
  GL_MAX_ELEMENTS_VERTICES = $80E8;
  GL_MAX_ELEMENTS_INDICES = $80E9;
  GL_BGR = $80E0;
  GL_BGRA = $80E1;
  GL_UNSIGNED_BYTE_3_3_2 = $8032;
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;
  GL_UNSIGNED_INT_8_8_8_8 = $8035;
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;
  GL_UNSIGNED_INT_10_10_10_2 = $8036;
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;
  GL_SINGLE_COLOR = $81F9;
  GL_SEPARATE_SPECULAR_COLOR = $81FA;
  GL_TEXTURE_MIN_LOD = $813A;
  GL_TEXTURE_MAX_LOD = $813B;
  GL_TEXTURE_BASE_LEVEL = $813C;
  GL_TEXTURE_MAX_LEVEL = $813D;
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;
  GL_ALIASED_POINT_SIZE_RANGE = $846D;
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  GL_PACK_SKIP_IMAGES = $806B;
  GL_PACK_IMAGE_HEIGHT = $806C;
  GL_UNPACK_SKIP_IMAGES = $806D;
  GL_UNPACK_IMAGE_HEIGHT = $806E;
  GL_TEXTURE_3D = $806F;
  GL_PROXY_TEXTURE_3D = $8070;
  GL_TEXTURE_DEPTH = $8071;
  GL_TEXTURE_WRAP_R = $8072;
  GL_MAX_3D_TEXTURE_SIZE = $8073;
  GL_TEXTURE_BINDING_3D = $806A;

procedure glDrawRangeElements(mode: TGLenum; start: TGLuint; end_: TGLuint; Count: TGLsizei; _type: TGLenum;
  indices: PGLvoid); cdecl; external;
procedure glTexImage3D(target: TGLenum; level: TGLint; internalFormat: TGLint; Width: TGLsizei; Height: TGLsizei;
  depth: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; pixels: PGLvoid); cdecl; external;
procedure glTexSubImage3D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint;
  Width: TGLsizei; Height: TGLsizei; depth: TGLsizei; format: TGLenum; _type: TGLenum;
  pixels: PGLvoid); cdecl; external;
procedure glCopyTexSubImage3D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint;
  x: TGLint; y: TGLint; Width: TGLsizei; Height: TGLsizei); cdecl; external;

const
  GL_CONSTANT_COLOR = $8001;
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;
  GL_CONSTANT_ALPHA = $8003;
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;
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
  GL_CONSTANT_BORDER = $8151;
  GL_REPLICATE_BORDER = $8153;
  GL_CONVOLUTION_BORDER_COLOR = $8154;
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
  GL_BLEND_EQUATION = $8009;
  GL_MIN = $8007;
  GL_MAX = $8008;
  GL_FUNC_ADD = $8006;
  GL_FUNC_SUBTRACT = $800A;
  GL_FUNC_REVERSE_SUBTRACT = $800B;
  GL_BLEND_COLOR = $8005;

procedure glColorTable(target: TGLenum; internalformat: TGLenum; Width: TGLsizei; format: TGLenum; _type: TGLenum;
  table: PGLvoid); cdecl; external;
procedure glColorSubTable(target: TGLenum; start: TGLsizei; Count: TGLsizei; format: TGLenum; _type: TGLenum;
  Data: PGLvoid); cdecl; external;
procedure glColorTableParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glColorTableParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glCopyColorSubTable(target: TGLenum; start: TGLsizei; x: TGLint; y: TGLint; Width: TGLsizei); cdecl; external;
procedure glCopyColorTable(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; Width: TGLsizei); cdecl; external;
procedure glGetColorTable(target: TGLenum; format: TGLenum; _type: TGLenum; table: PGLvoid); cdecl; external;
procedure glGetColorTableParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetColorTableParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glBlendEquation(mode: TGLenum); cdecl; external;
procedure glBlendColor(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); cdecl; external;
procedure glHistogram(target: TGLenum; Width: TGLsizei; internalformat: TGLenum; sink: TGLboolean); cdecl; external;
procedure glResetHistogram(target: TGLenum); cdecl; external;
procedure glGetHistogram(target: TGLenum; reset: TGLboolean; format: TGLenum; _type: TGLenum; values: PGLvoid); cdecl; external;
procedure glGetHistogramParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetHistogramParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glMinmax(target: TGLenum; internalformat: TGLenum; sink: TGLboolean); cdecl; external;
procedure glResetMinmax(target: TGLenum); cdecl; external;
procedure glGetMinmax(target: TGLenum; reset: TGLboolean; format: TGLenum; types: TGLenum; values: PGLvoid); cdecl; external;
procedure glGetMinmaxParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetMinmaxParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glConvolutionFilter1D(target: TGLenum; internalformat: TGLenum; Width: TGLsizei; format: TGLenum; _type: TGLenum;
  image: PGLvoid); cdecl; external;
procedure glConvolutionFilter2D(target: TGLenum; internalformat: TGLenum; Width: TGLsizei; Height: TGLsizei; format: TGLenum;
  _type: TGLenum; image: PGLvoid); cdecl; external;
procedure glConvolutionParameterf(target: TGLenum; pname: TGLenum; params: TGLfloat); cdecl; external;
procedure glConvolutionParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glConvolutionParameteri(target: TGLenum; pname: TGLenum; params: TGLint); cdecl; external;
procedure glConvolutionParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glCopyConvolutionFilter1D(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; Width: TGLsizei); cdecl; external;
procedure glCopyConvolutionFilter2D(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; Width: TGLsizei;
  Height: TGLsizei); cdecl; external;
procedure glGetConvolutionFilter(target: TGLenum; format: TGLenum; _type: TGLenum; image: PGLvoid); cdecl; external;
procedure glGetConvolutionParameterfv(target: TGLenum; pname: TGLenum; params: PGLfloat); cdecl; external;
procedure glGetConvolutionParameteriv(target: TGLenum; pname: TGLenum; params: PGLint); cdecl; external;
procedure glSeparableFilter2D(target: TGLenum; internalformat: TGLenum; Width: TGLsizei; Height: TGLsizei; format: TGLenum;
  _type: TGLenum; row: PGLvoid; column: PGLvoid); cdecl; external;
procedure glGetSeparableFilter(target: TGLenum; format: TGLenum; _type: TGLenum; row: PGLvoid; column: PGLvoid;
  span: PGLvoid); cdecl; external;
{
 * OpenGL 1.3
  }
{ multitexture  }
const
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
  { texture_cube_map  }
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
  { texture_compression  }
  GL_COMPRESSED_ALPHA = $84E9;
  GL_COMPRESSED_LUMINANCE = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;
  GL_COMPRESSED_INTENSITY = $84EC;
  GL_COMPRESSED_RGB = $84ED;
  GL_COMPRESSED_RGBA = $84EE;
  GL_TEXTURE_COMPRESSION_HINT = $84EF;
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;
  GL_TEXTURE_COMPRESSED = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  { multisample  }
  GL_MULTISAMPLE = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  GL_SAMPLE_COVERAGE = $80A0;
  GL_SAMPLE_BUFFERS = $80A8;
  GL_SAMPLES = $80A9;
  GL_SAMPLE_COVERAGE_VALUE = $80AA;
  GL_SAMPLE_COVERAGE_INVERT = $80AB;
  GL_MULTISAMPLE_BIT = $20000000;
  { transpose_matrix  }
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;
  { texture_env_combine  }
  GL_COMBINE = $8570;
  GL_COMBINE_RGB = $8571;
  GL_COMBINE_ALPHA = $8572;
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
  GL_RGB_SCALE = $8573;
  GL_ADD_SIGNED = $8574;
  GL_INTERPOLATE = $8575;
  GL_SUBTRACT = $84E7;
  GL_CONSTANT = $8576;
  GL_PRIMARY_COLOR = $8577;
  GL_PREVIOUS = $8578;
  { texture_env_dot3  }
  GL_DOT3_RGB = $86AE;
  GL_DOT3_RGBA = $86AF;
  { texture_border_clamp  }
  GL_CLAMP_TO_BORDER = $812D;

procedure glActiveTexture(texture: TGLenum); cdecl; external;
procedure glClientActiveTexture(texture: TGLenum); cdecl; external;
procedure glCompressedTexImage1D(target: TGLenum; level: TGLint; internalformat: TGLenum; Width: TGLsizei; border: TGLint;
  imageSize: TGLsizei; Data: PGLvoid); cdecl; external;
procedure glCompressedTexImage2D(target: TGLenum; level: TGLint; internalformat: TGLenum; Width: TGLsizei; Height: TGLsizei;
  border: TGLint; imageSize: TGLsizei; Data: PGLvoid); cdecl; external;
procedure glCompressedTexImage3D(target: TGLenum; level: TGLint; internalformat: TGLenum; Width: TGLsizei; Height: TGLsizei;
  depth: TGLsizei; border: TGLint; imageSize: TGLsizei; Data: PGLvoid); cdecl; external;
procedure glCompressedTexSubImage1D(target: TGLenum; level: TGLint; xoffset: TGLint; Width: TGLsizei; format: TGLenum;
  imageSize: TGLsizei; Data: PGLvoid); cdecl; external;
procedure glCompressedTexSubImage2D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; Width: TGLsizei;
  Height: TGLsizei; format: TGLenum; imageSize: TGLsizei; Data: PGLvoid); cdecl; external;
procedure glCompressedTexSubImage3D(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint;
  Width: TGLsizei; Height: TGLsizei; depth: TGLsizei; format: TGLenum; imageSize: TGLsizei;
  Data: PGLvoid); cdecl; external;
procedure glGetCompressedTexImage(target: TGLenum; lod: TGLint; img: PGLvoid); cdecl; external;
procedure glMultiTexCoord1d(target: TGLenum; s: TGLdouble); cdecl; external;
procedure glMultiTexCoord1dv(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord1f(target: TGLenum; s: TGLfloat); cdecl; external;
procedure glMultiTexCoord1fv(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord1i(target: TGLenum; s: TGLint); cdecl; external;
procedure glMultiTexCoord1iv(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord1s(target: TGLenum; s: TGLshort); cdecl; external;
procedure glMultiTexCoord1sv(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord2d(target: TGLenum; s: TGLdouble; t: TGLdouble); cdecl; external;
procedure glMultiTexCoord2dv(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord2f(target: TGLenum; s: TGLfloat; t: TGLfloat); cdecl; external;
procedure glMultiTexCoord2fv(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord2i(target: TGLenum; s: TGLint; t: TGLint); cdecl; external;
procedure glMultiTexCoord2iv(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord2s(target: TGLenum; s: TGLshort; t: TGLshort); cdecl; external;
procedure glMultiTexCoord2sv(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord3d(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble); cdecl; external;
procedure glMultiTexCoord3dv(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord3f(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat); cdecl; external;
procedure glMultiTexCoord3fv(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord3i(target: TGLenum; s: TGLint; t: TGLint; r: TGLint); cdecl; external;
procedure glMultiTexCoord3iv(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord3s(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort); cdecl; external;
procedure glMultiTexCoord3sv(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord4d(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); cdecl; external;
procedure glMultiTexCoord4dv(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord4f(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); cdecl; external;
procedure glMultiTexCoord4fv(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord4i(target: TGLenum; s: TGLint; t: TGLint; r: TGLint; q: TGLint); cdecl; external;
procedure glMultiTexCoord4iv(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord4s(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); cdecl; external;
procedure glMultiTexCoord4sv(target: TGLenum; v: PGLshort); cdecl; external;
procedure glLoadTransposeMatrixd(m: PGLdouble); cdecl; external;
procedure glLoadTransposeMatrixf(m: PGLfloat); cdecl; external;
procedure glMultTransposeMatrixd(m: PGLdouble); cdecl; external;
procedure glMultTransposeMatrixf(m: PGLfloat); cdecl; external;
procedure glSampleCoverage(Value: TGLclampf; invert: TGLboolean); cdecl; external;

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

procedure glActiveTextureARB(texture: TGLenum); cdecl; external;
procedure glClientActiveTextureARB(texture: TGLenum); cdecl; external;
procedure glMultiTexCoord1dARB(target: TGLenum; s: TGLdouble); cdecl; external;
procedure glMultiTexCoord1dvARB(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord1fARB(target: TGLenum; s: TGLfloat); cdecl; external;
procedure glMultiTexCoord1fvARB(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord1iARB(target: TGLenum; s: TGLint); cdecl; external;
procedure glMultiTexCoord1ivARB(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord1sARB(target: TGLenum; s: TGLshort); cdecl; external;
procedure glMultiTexCoord1svARB(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord2dARB(target: TGLenum; s: TGLdouble; t: TGLdouble); cdecl; external;
procedure glMultiTexCoord2dvARB(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord2fARB(target: TGLenum; s: TGLfloat; t: TGLfloat); cdecl; external;
procedure glMultiTexCoord2fvARB(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord2iARB(target: TGLenum; s: TGLint; t: TGLint); cdecl; external;
procedure glMultiTexCoord2ivARB(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord2sARB(target: TGLenum; s: TGLshort; t: TGLshort); cdecl; external;
procedure glMultiTexCoord2svARB(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord3dARB(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble); cdecl; external;
procedure glMultiTexCoord3dvARB(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord3fARB(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat); cdecl; external;
procedure glMultiTexCoord3fvARB(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord3iARB(target: TGLenum; s: TGLint; t: TGLint; r: TGLint); cdecl; external;
procedure glMultiTexCoord3ivARB(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord3sARB(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort); cdecl; external;
procedure glMultiTexCoord3svARB(target: TGLenum; v: PGLshort); cdecl; external;
procedure glMultiTexCoord4dARB(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); cdecl; external;
procedure glMultiTexCoord4dvARB(target: TGLenum; v: PGLdouble); cdecl; external;
procedure glMultiTexCoord4fARB(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); cdecl; external;
procedure glMultiTexCoord4fvARB(target: TGLenum; v: PGLfloat); cdecl; external;
procedure glMultiTexCoord4iARB(target: TGLenum; s: TGLint; t: TGLint; r: TGLint; q: TGLint); cdecl; external;
procedure glMultiTexCoord4ivARB(target: TGLenum; v: PGLint); cdecl; external;
procedure glMultiTexCoord4sARB(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); cdecl; external;
procedure glMultiTexCoord4svARB(target: TGLenum; v: PGLshort); cdecl; external;

implementation

end.
