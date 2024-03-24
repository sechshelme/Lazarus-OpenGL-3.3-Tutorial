
unit oglGLext;
interface

uses
  oglGL;

{$LinkLib 'GL'}

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{//////////////////////////////////////////////////////////////////////// }
{ }
{    glext.h }
{ }
{//////////////////////////////////////////////////////////////////////// }
{////#ifndef __gl_glext_h_ }

const
  __gl_glext_h_ = 1;  
{////#ifdef __cplusplus }
{////extern "C"  }
{////#endif }
{
** Copyright 2013-2020 The Khronos Group Inc.
** SPDX-License-Identifier: MIT
**
** This header is generated from the Khronos OpenGL / OpenGL ES XML
** API Registry. The current version of the Registry, generator scripts
** used to make the header, and the header can be found at
**   https://github.com/KhronosGroup/OpenGL-Registry
 }
{////#if defined(_WIN32) && !defined() && !defined(__CYGWIN__) && !defined(__SCITECH_SNAP__) }
{////#ifndef WIN32_LEAN_AND_MEAN }
  WIN32_LEAN_AND_MEAN = 1;  
{////#endif }
{////#include <windows.h> }
{////#endif }
{////#ifndef  }
{////#define  }
{////#endif }
{//////////#ifndef P }
{////#define P APIENTRY * }
{////#endif }
{////#ifndef  }
{////#define  extern }
{////#endif }
  GL_GLEXT_VERSION = 20230309;  
{////#include <KHR/khrplatform.h> }
{ Generated C header for:
 * API: gl
 * Profile: compatibility
 * Versions considered: .*
 * Versions emitted: 1\.[2-9]|[234]\.[0-9]
 * Default extensions included: gl
 * Additional extensions included: _nomatch_^
 * Extensions removed: _nomatch_^
  }
{////#ifndef GL_VERSION_1_2 }
  GL_VERSION_1_2 = 1;  
  GL_UNSIGNED_BYTE_3_3_2 = $8032;  
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;  
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;  
  GL_UNSIGNED_INT_8_8_8_8 = $8035;  
  GL_UNSIGNED_INT_10_10_10_2 = $8036;  
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
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;  
  GL_UNSIGNED_SHORT_5_6_5 = $8363;  
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;  
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;  
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;  
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;  
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;  
  GL_BGR = $80E0;  
  GL_BGRA = $80E1;  
  GL_MAX_ELEMENTS_VERTICES = $80E8;  
  GL_MAX_ELEMENTS_INDICES = $80E9;  
  GL_CLAMP_TO_EDGE = $812F;  
  GL_TEXTURE_MIN_LOD = $813A;  
  GL_TEXTURE_MAX_LOD = $813B;  
  GL_TEXTURE_BASE_LEVEL = $813C;  
  GL_TEXTURE_MAX_LEVEL = $813D;  
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;  
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;  
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;  
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;  
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;  
  GL_RESCALE_NORMAL = $803A;  
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;  
  GL_SINGLE_COLOR = $81F9;  
  GL_SEPARATE_SPECULAR_COLOR = $81FA;  
  GL_ALIASED_POINT_SIZE_RANGE = $846D;  
{////typedef void (P PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end_, GLsizei count, GLenum type, const void *indices); }
{////typedef void (P PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDrawRangeElements(mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum; 
            indices:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexImage3D(target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexSubImage3D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
procedure glCopyTexSubImage3D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_1_2 */ }
{////#ifndef GL_VERSION_1_3 }
const
  GL_VERSION_1_3 = 1;  
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
  GL_MULTISAMPLE = $809D;  
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;  
  GL_SAMPLE_ALPHA_TO_ONE = $809F;  
  GL_SAMPLE_COVERAGE = $80A0;  
  GL_SAMPLE_BUFFERS = $80A8;  
  GL_SAMPLES = $80A9;  
  GL_SAMPLE_COVERAGE_VALUE = $80AA;  
  GL_SAMPLE_COVERAGE_INVERT = $80AB;  
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
  GL_COMPRESSED_RGB = $84ED;  
  GL_COMPRESSED_RGBA = $84EE;  
  GL_TEXTURE_COMPRESSION_HINT = $84EF;  
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;  
  GL_TEXTURE_COMPRESSED = $86A1;  
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;  
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;  
  GL_CLAMP_TO_BORDER = $812D;  
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;  
  GL_MAX_TEXTURE_UNITS = $84E2;  
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;  
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;  
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;  
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;  
  GL_MULTISAMPLE_BIT = $20000000;  
  GL_NORMAL_MAP = $8511;  
  GL_REFLECTION_MAP = $8512;  
  GL_COMPRESSED_ALPHA = $84E9;  
  GL_COMPRESSED_LUMINANCE = $84EA;  
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;  
  GL_COMPRESSED_INTENSITY = $84EC;  
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
  GL_DOT3_RGB = $86AE;  
  GL_DOT3_RGBA = $86AF;  
{////typedef void (P PFNGLACTIVETEXTUREPROC) (GLenum texture); }
{////typedef void (P PFNGLSAMPLECOVERAGEPROC) (GLfloat value, GLboolean invert); }
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, void *img); }
{////typedef void (P PFNGLCLIENTACTIVETEXTUREPROC) (GLenum texture); }
{////typedef void (P PFNGLMULTITEXCOORD1DPROC) (GLenum target, GLdouble s); }
{////typedef void (P PFNGLMULTITEXCOORD1DVPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD1FPROC) (GLenum target, GLfloat s); }
{////typedef void (P PFNGLMULTITEXCOORD1FVPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD1IPROC) (GLenum target, GLint s); }
{////typedef void (P PFNGLMULTITEXCOORD1IVPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD1SPROC) (GLenum target, GLshort s); }
{////typedef void (P PFNGLMULTITEXCOORD1SVPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD2DPROC) (GLenum target, GLdouble s, GLdouble t); }
{////typedef void (P PFNGLMULTITEXCOORD2DVPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD2FPROC) (GLenum target, GLfloat s, GLfloat t); }
{////typedef void (P PFNGLMULTITEXCOORD2FVPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD2IPROC) (GLenum target, GLint s, GLint t); }
{////typedef void (P PFNGLMULTITEXCOORD2IVPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD2SPROC) (GLenum target, GLshort s, GLshort t); }
{////typedef void (P PFNGLMULTITEXCOORD2SVPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD3DPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r); }
{////typedef void (P PFNGLMULTITEXCOORD3DVPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD3FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r); }
{////typedef void (P PFNGLMULTITEXCOORD3FVPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD3IPROC) (GLenum target, GLint s, GLint t, GLint r); }
{////typedef void (P PFNGLMULTITEXCOORD3IVPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD3SPROC) (GLenum target, GLshort s, GLshort t, GLshort r); }
{////typedef void (P PFNGLMULTITEXCOORD3SVPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD4DPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q); }
{////typedef void (P PFNGLMULTITEXCOORD4DVPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD4FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q); }
{////typedef void (P PFNGLMULTITEXCOORD4FVPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD4IPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q); }
{////typedef void (P PFNGLMULTITEXCOORD4IVPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD4SPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q); }
{////typedef void (P PFNGLMULTITEXCOORD4SVPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLLOADTRANSPOSEMATRIXFPROC) (const GLfloat *m); }
{////typedef void (P PFNGLLOADTRANSPOSEMATRIXDPROC) (const GLdouble *m); }
{////typedef void (P PFNGLMULTTRANSPOSEMATRIXFPROC) (const GLfloat *m); }
{////typedef void (P PFNGLMULTTRANSPOSEMATRIXDPROC) (const GLdouble *m); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glActiveTexture(texture:TGLenum);cdecl;external;
procedure glSampleCoverage(value:TGLfloat; invert:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexImage3D(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexImage2D(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexImage1D(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; border:TGLint; 
            imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage3D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
            data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage2D(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage1D(target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            imageSize:TGLsizei; data:pointer);cdecl;external;
procedure glGetCompressedTexImage(target:TGLenum; level:TGLint; img:pointer);cdecl;external;
procedure glClientActiveTexture(texture:TGLenum);cdecl;external;
procedure glMultiTexCoord1d(target:TGLenum; s:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1dv(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord1f(target:TGLenum; s:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1fv(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord1i(target:TGLenum; s:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1iv(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord1s(target:TGLenum; s:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1sv(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord2d(target:TGLenum; s:TGLdouble; t:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2dv(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord2f(target:TGLenum; s:TGLfloat; t:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2fv(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord2i(target:TGLenum; s:TGLint; t:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2iv(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord2s(target:TGLenum; s:TGLshort; t:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2sv(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord3d(target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3dv(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord3f(target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3fv(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord3i(target:TGLenum; s:TGLint; t:TGLint; r:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3iv(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord3s(target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3sv(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord4d(target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble; q:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4dv(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord4f(target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat; q:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4fv(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord4i(target:TGLenum; s:TGLint; t:TGLint; r:TGLint; q:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4iv(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord4s(target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort; q:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4sv(target:TGLenum; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glLoadTransposeMatrixf(m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glLoadTransposeMatrixd(m:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultTransposeMatrixf(m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultTransposeMatrixd(m:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_1_3 */ }
{////#ifndef GL_VERSION_1_4 }
const
  GL_VERSION_1_4 = 1;  
  GL_BLEND_DST_RGB = $80C8;  
  GL_BLEND_SRC_RGB = $80C9;  
  GL_BLEND_DST_ALPHA = $80CA;  
  GL_BLEND_SRC_ALPHA = $80CB;  
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;  
  GL_DEPTH_COMPONENT16 = $81A5;  
  GL_DEPTH_COMPONENT24 = $81A6;  
  GL_DEPTH_COMPONENT32 = $81A7;  
  GL_MIRRORED_REPEAT = $8370;  
  GL_MAX_TEXTURE_LOD_BIAS = $84FD;  
  GL_TEXTURE_LOD_BIAS = $8501;  
  GL_INCR_WRAP = $8507;  
  GL_DECR_WRAP = $8508;  
  GL_TEXTURE_DEPTH_SIZE = $884A;  
  GL_TEXTURE_COMPARE_MODE = $884C;  
  GL_TEXTURE_COMPARE_FUNC = $884D;  
  GL_POINT_SIZE_MIN = $8126;  
  GL_POINT_SIZE_MAX = $8127;  
  GL_POINT_DISTANCE_ATTENUATION = $8129;  
  GL_GENERATE_MIPMAP = $8191;  
  GL_GENERATE_MIPMAP_HINT = $8192;  
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
  GL_TEXTURE_FILTER_CONTROL = $8500;  
  GL_DEPTH_TEXTURE_MODE = $884B;  
  GL_COMPARE_R_TO_TEXTURE = $884E;  
  GL_BLEND_COLOR = $8005;  
  GL_BLEND_EQUATION = $8009;  
  GL_CONSTANT_COLOR = $8001;  
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;  
  GL_CONSTANT_ALPHA = $8003;  
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;  
  GL_FUNC_ADD = $8006;  
  GL_FUNC_REVERSE_SUBTRACT = $800B;  
  GL_FUNC_SUBTRACT = $800A;  
  GL_MIN = $8007;  
  GL_MAX = $8008;  
{////typedef void (P PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha); }
{////typedef void (P PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount); }
{////typedef void (P PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params); }
{////typedef void (P PFNGLFOGCOORDFPROC) (GLfloat coord); }
{////typedef void (P PFNGLFOGCOORDFVPROC) (const GLfloat *coord); }
{////typedef void (P PFNGLFOGCOORDDPROC) (GLdouble coord); }
{////typedef void (P PFNGLFOGCOORDDVPROC) (const GLdouble *coord); }
{////typedef void (P PFNGLFOGCOORDPOINTERPROC) (GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLSECONDARYCOLOR3BPROC) (GLbyte red, GLbyte green, GLbyte blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3BVPROC) (const GLbyte *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3DPROC) (GLdouble red, GLdouble green, GLdouble blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3DVPROC) (const GLdouble *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3FPROC) (GLfloat red, GLfloat green, GLfloat blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3FVPROC) (const GLfloat *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3IPROC) (GLint red, GLint green, GLint blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3IVPROC) (const GLint *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3SPROC) (GLshort red, GLshort green, GLshort blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3SVPROC) (const GLshort *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3UBPROC) (GLubyte red, GLubyte green, GLubyte blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3UBVPROC) (const GLubyte *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3UIPROC) (GLuint red, GLuint green, GLuint blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3UIVPROC) (const GLuint *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3USPROC) (GLushort red, GLushort green, GLushort blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3USVPROC) (const GLushort *v); }
{////typedef void (P PFNGLSECONDARYCOLORPOINTERPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLWINDOWPOS2DPROC) (GLdouble x, GLdouble y); }
{////typedef void (P PFNGLWINDOWPOS2DVPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS2FPROC) (GLfloat x, GLfloat y); }
{////typedef void (P PFNGLWINDOWPOS2FVPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS2IPROC) (GLint x, GLint y); }
{////typedef void (P PFNGLWINDOWPOS2IVPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS2SPROC) (GLshort x, GLshort y); }
{////typedef void (P PFNGLWINDOWPOS2SVPROC) (const GLshort *v); }
{////typedef void (P PFNGLWINDOWPOS3DPROC) (GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLWINDOWPOS3DVPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS3FPROC) (GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLWINDOWPOS3FVPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS3IPROC) (GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLWINDOWPOS3IVPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS3SPROC) (GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLWINDOWPOS3SVPROC) (const GLshort *v); }
{////typedef void (P PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha); }
{////typedef void (P PFNGLBLENDEQUATIONPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendFuncSeparate(sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glMultiDrawArrays(mode:TGLenum; first:PGLint; count:PGLsizei; drawcount:TGLsizei);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glMultiDrawElements(mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; drawcount:TGLsizei);cdecl;external;
procedure glPointParameterf(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterfv(pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glPointParameteri(pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glPointParameteriv(pname:TGLenum; params:PGLint);cdecl;external;
procedure glFogCoordf(coord:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordfv(coord:PGLfloat);cdecl;external;
procedure glFogCoordd(coord:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glFogCoorddv(coord:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordPointer(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glSecondaryColor3b(red:TGLbyte; green:TGLbyte; blue:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3bv(v:PGLbyte);cdecl;external;
procedure glSecondaryColor3d(red:TGLdouble; green:TGLdouble; blue:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3dv(v:PGLdouble);cdecl;external;
procedure glSecondaryColor3f(red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3fv(v:PGLfloat);cdecl;external;
procedure glSecondaryColor3i(red:TGLint; green:TGLint; blue:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3iv(v:PGLint);cdecl;external;
procedure glSecondaryColor3s(red:TGLshort; green:TGLshort; blue:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3sv(v:PGLshort);cdecl;external;
procedure glSecondaryColor3ub(red:TGLubyte; green:TGLubyte; blue:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3ubv(v:PGLubyte);cdecl;external;
procedure glSecondaryColor3ui(red:TGLuint; green:TGLuint; blue:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3uiv(v:PGLuint);cdecl;external;
procedure glSecondaryColor3us(red:TGLushort; green:TGLushort; blue:TGLushort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3usv(v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColorPointer(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glWindowPos2d(x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2dv(v:PGLdouble);cdecl;external;
procedure glWindowPos2f(x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2fv(v:PGLfloat);cdecl;external;
procedure glWindowPos2i(x:TGLint; y:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2iv(v:PGLint);cdecl;external;
procedure glWindowPos2s(x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2sv(v:PGLshort);cdecl;external;
procedure glWindowPos3d(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3dv(v:PGLdouble);cdecl;external;
procedure glWindowPos3f(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3fv(v:PGLfloat);cdecl;external;
procedure glWindowPos3i(x:TGLint; y:TGLint; z:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3iv(v:PGLint);cdecl;external;
procedure glWindowPos3s(x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3sv(v:PGLshort);cdecl;external;
procedure glBlendColor(red:TGLfloat; green:TGLfloat; blue:TGLfloat; alpha:TGLfloat);cdecl;external;
procedure glBlendEquation(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_1_4 */ }
{////#ifndef GL_VERSION_1_5 }
const
  GL_VERSION_1_5 = 1;  
type
  PGLsizeiptr = ^TGLsizeiptr;
  TGLsizeiptr = SizeInt;

  PGLintptr = ^TGLintptr;
  TGLintptr = PtrInt;

const
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
  GL_SRC1_ALPHA = $8589;  
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;  
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;  
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;  
  GL_INDEX_ARRAY_BUFFER_BINDING = $8899;  
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;  
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B;  
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C;  
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D;  
  GL_WEIGHT_ARRAY_BUFFER_BINDING = $889E;  
  GL_FOG_COORD_SRC = $8450;  
  GL_FOG_COORD = $8451;  
  GL_CURRENT_FOG_COORD = $8453;  
  GL_FOG_COORD_ARRAY_TYPE = $8454;  
  GL_FOG_COORD_ARRAY_STRIDE = $8455;  
  GL_FOG_COORD_ARRAY_POINTER = $8456;  
  GL_FOG_COORD_ARRAY = $8457;  
  GL_FOG_COORD_ARRAY_BUFFER_BINDING = $889D;  
  GL_SRC0_RGB = $8580;  
  GL_SRC1_RGB = $8581;  
  GL_SRC2_RGB = $8582;  
  GL_SRC0_ALPHA = $8588;  
  GL_SRC2_ALPHA = $858A;  
{////typedef void (P PFNGLGENQUERIESPROC) (GLsizei n, GLuint *ids); }
{////typedef void (P PFNGLDELETEQUERIESPROC) (GLsizei n, const GLuint *ids); }
{////typedef GLboolean (P PFNGLISQUERYPROC) (GLuint id); }
{////typedef void (P PFNGLBEGINQUERYPROC) (GLenum target, GLuint id); }
{////typedef void (P PFNGLENDQUERYPROC) (GLenum target); }
{////typedef void (P PFNGLGETQUERYIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETQUERYOBJECTIVPROC) (GLuint id, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETQUERYOBJECTUIVPROC) (GLuint id, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLBINDBUFFERPROC) (GLenum target, GLuint buffer); }
{////typedef void (P PFNGLDELETEBUFFERSPROC) (GLsizei n, const GLuint *buffers); }
{////typedef void (P PFNGLGENBUFFERSPROC) (GLsizei n, GLuint *buffers); }
{////typedef GLboolean (P PFNGLISBUFFERPROC) (GLuint buffer); }
{////typedef void (P PFNGLBUFFERDATAPROC) (GLenum target, GLsizeiptr size, const void *data, GLenum usage); }
{////typedef void (P PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const void *data); }
{////typedef void (P PFNGLGETBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, void *data); }
{////typedef void *(P PFNGLMAPBUFFERPROC) (GLenum target, GLenum access); }
{////typedef GLboolean (P PFNGLUNMAPBUFFERPROC) (GLenum target); }
{////typedef void (P PFNGLGETBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETBUFFERPOINTERVPROC) (GLenum target, GLenum pname, void **params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenQueries(n:TGLsizei; ids:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteQueries(n:TGLsizei; ids:PGLuint);cdecl;external;
function glIsQuery(id:TGLuint):TGLboolean;cdecl;external;
procedure glBeginQuery(target:TGLenum; id:TGLuint);cdecl;external;
procedure glEndQuery(target:TGLenum);cdecl;external;
procedure glGetQueryiv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetQueryObjectiv(id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetQueryObjectuiv(id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glBindBuffer(target:TGLenum; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteBuffers(n:TGLsizei; buffers:PGLuint);cdecl;external;
procedure glGenBuffers(n:TGLsizei; buffers:PGLuint);cdecl;external;
function glIsBuffer(buffer:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glBufferData(target:TGLenum; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glBufferSubData(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glGetBufferSubData(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
function glMapBuffer(target:TGLenum; access:TGLenum):pointer;cdecl;external;
function glUnmapBuffer(target:TGLenum):TGLboolean;cdecl;external;
procedure glGetBufferParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetBufferPointerv(target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_1_5 */ }
{////#ifndef GL_VERSION_2_0 }
const
  GL_VERSION_2_0 = 1;  
type
  PPGLchar = ^PGLchar;
  PGLchar = ^TGLchar;
  TGLchar = char;

const
  GL_BLEND_EQUATION_RGB = $8009;  
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622;  
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623;  
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624;  
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625;  
  GL_CURRENT_VERTEX_ATTRIB = $8626;  
  GL_VERTEX_PROGRAM_POINT_SIZE = $8642;  
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
  GL_MAX_VERTEX_ATTRIBS = $8869;  
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A;  
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
  GL_VERTEX_PROGRAM_TWO_SIDE = $8643;  
  GL_POINT_SPRITE = $8861;  
  GL_COORD_REPLACE = $8862;  
  GL_MAX_TEXTURE_COORDS = $8871;  
{////typedef void (P PFNGLBLENDEQUATIONSEPARATEPROC) (GLenum modeRGB, GLenum modeAlpha); }
{////typedef void (P PFNGLDRAWBUFFERSPROC) (GLsizei n, const GLenum *bufs); }
{////typedef void (P PFNGLSTENCILOPSEPARATEPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass); }
{////typedef void (P PFNGLSTENCILFUNCSEPARATEPROC) (GLenum face, GLenum func, GLint ref, GLuint mask); }
{////typedef void (P PFNGLSTENCILMASKSEPARATEPROC) (GLenum face, GLuint mask); }
{////typedef void (P PFNGLATTACHSHADERPROC) (GLuint program_, GLuint shader); }
{////typedef void (P PFNGLBINDATTRIBLOCATIONPROC) (GLuint program_, GLuint index, const GLchar *name); }
{////typedef void (P PFNGLCOMPILESHADERPROC) (GLuint shader); }
{////typedef GLuint (P PFNGLCREATEPROGRAMPROC) (void); }
{////typedef GLuint (P PFNGLCREATESHADERPROC) (GLenum type); }
{////typedef void (P PFNGLDELETEPROGRAMPROC) (GLuint program_); }
{////typedef void (P PFNGLDELETESHADERPROC) (GLuint shader); }
{////typedef void (P PFNGLDETACHSHADERPROC) (GLuint program_, GLuint shader); }
{////typedef void (P PFNGLDISABLEVERTEXATTRIBARRAYPROC) (GLuint index); }
{////typedef void (P PFNGLENABLEVERTEXATTRIBARRAYPROC) (GLuint index); }
{////typedef void (P PFNGLGETACTIVEATTRIBPROC) (GLuint program_, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name); }
{////typedef void (P PFNGLGETACTIVEUNIFORMPROC) (GLuint program_, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name); }
{////typedef void (P PFNGLGETATTACHEDSHADERSPROC) (GLuint program_, GLsizei maxCount, GLsizei *count, GLuint *shaders); }
{////typedef GLint (P PFNGLGETATTRIBLOCATIONPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLGETPROGRAMIVPROC) (GLuint program_, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETPROGRAMINFOLOGPROC) (GLuint program_, GLsizei bufSize, GLsizei *length, GLchar *infoLog); }
{////typedef void (P PFNGLGETSHADERIVPROC) (GLuint shader, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETSHADERINFOLOGPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog); }
{////typedef void (P PFNGLGETSHADERSOURCEPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source); }
{////typedef GLint (P PFNGLGETUNIFORMLOCATIONPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLGETUNIFORMFVPROC) (GLuint program_, GLint location, GLfloat *params); }
{////typedef void (P PFNGLGETUNIFORMIVPROC) (GLuint program_, GLint location, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBDVPROC) (GLuint index, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBFVPROC) (GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBIVPROC) (GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBPOINTERVPROC) (GLuint index, GLenum pname, void **pointer); }
{////typedef GLboolean (P PFNGLISPROGRAMPROC) (GLuint program_); }
{////typedef GLboolean (P PFNGLISSHADERPROC) (GLuint shader); }
{////typedef void (P PFNGLLINKPROGRAMPROC) (GLuint program_); }
{////typedef void (P PFNGLSHADERSOURCEPROC) (GLuint shader, GLsizei count, const GLchar *const*string, const GLint *length); }
{////typedef void (P PFNGLUSEPROGRAMPROC) (GLuint program_); }
{////typedef void (P PFNGLUNIFORM1FPROC) (GLint location, GLfloat v0); }
{////typedef void (P PFNGLUNIFORM2FPROC) (GLint location, GLfloat v0, GLfloat v1); }
{////typedef void (P PFNGLUNIFORM3FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2); }
{////typedef void (P PFNGLUNIFORM4FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3); }
{////typedef void (P PFNGLUNIFORM1IPROC) (GLint location, GLint v0); }
{////typedef void (P PFNGLUNIFORM2IPROC) (GLint location, GLint v0, GLint v1); }
{////typedef void (P PFNGLUNIFORM3IPROC) (GLint location, GLint v0, GLint v1, GLint v2); }
{////typedef void (P PFNGLUNIFORM4IPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3); }
{////typedef void (P PFNGLUNIFORM1FVPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM2FVPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM3FVPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM4FVPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM1IVPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM2IVPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM3IVPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM4IVPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLVALIDATEPROGRAMPROC) (GLuint program_); }
{////typedef void (P PFNGLVERTEXATTRIB1DPROC) (GLuint index, GLdouble x); }
{////typedef void (P PFNGLVERTEXATTRIB1DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x); }
{////typedef void (P PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x); }
{////typedef void (P PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB2DPROC) (GLuint index, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXATTRIB2DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y); }
{////typedef void (P PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y); }
{////typedef void (P PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXATTRIB3DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB3FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLVERTEXATTRIB3FVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB3SPROC) (GLuint index, GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLVERTEXATTRIB3SVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NBVPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NIVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NSVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w); }
{////typedef void (P PFNGLVERTEXATTRIB4NUBVPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUSVPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4BVPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXATTRIB4DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w); }
{////typedef void (P PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendEquationSeparate(modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glDrawBuffers(n:TGLsizei; bufs:PGLenum);cdecl;external;
procedure glStencilOpSeparate(face:TGLenum; sfail:TGLenum; dpfail:TGLenum; dppass:TGLenum);cdecl;external;
procedure glStencilFuncSeparate(face:TGLenum; func:TGLenum; ref:TGLint; mask:TGLuint);cdecl;external;
procedure glStencilMaskSeparate(face:TGLenum; mask:TGLuint);cdecl;external;
procedure glAttachShader(program_:TGLuint; shader:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glBindAttribLocation(program_:TGLuint; index:TGLuint; name:PGLchar);cdecl;external;
procedure glCompileShader(shader:TGLuint);cdecl;external;
function glCreateProgram:TGLuint;cdecl;external;
function glCreateShader(_type:TGLenum):TGLuint;cdecl;external;
procedure glDeleteProgram(program_:TGLuint);cdecl;external;
procedure glDeleteShader(shader:TGLuint);cdecl;external;
procedure glDetachShader(program_:TGLuint; shader:TGLuint);cdecl;external;
procedure glDisableVertexAttribArray(index:TGLuint);cdecl;external;
procedure glEnableVertexAttribArray(index:TGLuint);cdecl;external;
procedure glGetActiveAttrib(program_:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLint; 
            _type:PGLenum; name:PGLchar);cdecl;external;
procedure glGetActiveUniform(program_:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLint; 
            _type:PGLenum; name:PGLchar);cdecl;external;
procedure glGetAttachedShaders(program_:TGLuint; maxCount:TGLsizei; count:PGLsizei; shaders:PGLuint);cdecl;external;
(* Const before type ignored *)
function glGetAttribLocation(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glGetProgramiv(program_:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetProgramInfoLog(program_:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;external;
procedure glGetShaderiv(shader:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetShaderInfoLog(shader:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;external;
procedure glGetShaderSource(shader:TGLuint; bufSize:TGLsizei; length:PGLsizei; source:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetUniformLocation(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glGetUniformfv(program_:TGLuint; location:TGLint; params:PGLfloat);cdecl;external;
procedure glGetUniformiv(program_:TGLuint; location:TGLint; params:PGLint);cdecl;external;
procedure glGetVertexAttribdv(index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glGetVertexAttribfv(index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVertexAttribiv(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribPointerv(index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;external;
function glIsProgram(program_:TGLuint):TGLboolean;cdecl;external;
function glIsShader(shader:TGLuint):TGLboolean;cdecl;external;
procedure glLinkProgram(program_:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
(* Const before type ignored *)
procedure glShaderSource(shader:TGLuint; count:TGLsizei; _string:PPGLchar; length:PGLint);cdecl;external;
procedure glUseProgram(program_:TGLuint);cdecl;external;
procedure glUniform1f(location:TGLint; v0:TGLfloat);cdecl;external;
procedure glUniform2f(location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;external;
procedure glUniform3f(location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;external;
procedure glUniform4f(location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; v3:TGLfloat);cdecl;external;
procedure glUniform1i(location:TGLint; v0:TGLint);cdecl;external;
procedure glUniform2i(location:TGLint; v0:TGLint; v1:TGLint);cdecl;external;
procedure glUniform3i(location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;external;
procedure glUniform4i(location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; v3:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform1fv(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform2fv(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform3fv(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform4fv(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform1iv(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform2iv(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform3iv(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform4iv(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
procedure glValidateProgram(program_:TGLuint);cdecl;external;
procedure glVertexAttrib1d(index:TGLuint; x:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1dv(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib1f(index:TGLuint; x:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1fv(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib1s(index:TGLuint; x:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1sv(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib2d(index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2dv(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib2f(index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2fv(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib2s(index:TGLuint; x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2sv(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib3d(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3dv(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib3f(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3fv(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib3s(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3sv(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Nbv(index:TGLuint; v:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Niv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Nsv(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib4Nub(index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Nubv(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Nuiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4Nusv(index:TGLuint; v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4bv(index:TGLuint; v:PGLbyte);cdecl;external;
procedure glVertexAttrib4d(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4dv(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib4f(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4fv(index:TGLuint; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4iv(index:TGLuint; v:PGLint);cdecl;external;
procedure glVertexAttrib4s(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4sv(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4ubv(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4uiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4usv(index:TGLuint; v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribPointer(index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei; 
            pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_2_0 */ }
{////#ifndef GL_VERSION_2_1 }
const
  GL_VERSION_2_1 = 1;  
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
  GL_COMPRESSED_SRGB = $8C48;  
  GL_COMPRESSED_SRGB_ALPHA = $8C49;  
  GL_CURRENT_RASTER_SECONDARY_COLOR = $845F;  
  GL_SLUMINANCE_ALPHA = $8C44;  
  GL_SLUMINANCE8_ALPHA8 = $8C45;  
  GL_SLUMINANCE = $8C46;  
  GL_SLUMINANCE8 = $8C47;  
  GL_COMPRESSED_SLUMINANCE = $8C4A;  
  GL_COMPRESSED_SLUMINANCE_ALPHA = $8C4B;  
{////typedef void (P PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glUniformMatrix2x3fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3x2fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2x4fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4x2fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3x4fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4x3fv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_2_1 */ }
{////#ifndef GL_VERSION_3_0 }
const
  GL_VERSION_3_0 = 1;  
type
  PGLhalf = ^TGLhalf;
  TGLhalf = uint16;

const
  GL_COMPARE_REF_TO_TEXTURE = $884E;  
  GL_CLIP_DISTANCE0 = $3000;  
  GL_CLIP_DISTANCE1 = $3001;  
  GL_CLIP_DISTANCE2 = $3002;  
  GL_CLIP_DISTANCE3 = $3003;  
  GL_CLIP_DISTANCE4 = $3004;  
  GL_CLIP_DISTANCE5 = $3005;  
  GL_CLIP_DISTANCE6 = $3006;  
  GL_CLIP_DISTANCE7 = $3007;  
  GL_MAX_CLIP_DISTANCES = $0D32;  
  GL_MAJOR_VERSION = $821B;  
  GL_MINOR_VERSION = $821C;  
  GL_NUM_EXTENSIONS = $821D;  
  GL_CONTEXT_FLAGS = $821E;  
  GL_COMPRESSED_RED = $8225;  
  GL_COMPRESSED_RG = $8226;  
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = $00000001;  
  GL_RGBA32F = $8814;  
  GL_RGB32F = $8815;  
  GL_RGBA16F = $881A;  
  GL_RGB16F = $881B;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER = $88FD;  
  GL_MAX_ARRAY_TEXTURE_LAYERS = $88FF;  
  GL_MIN_PROGRAM_TEXEL_OFFSET = $8904;  
  GL_MAX_PROGRAM_TEXEL_OFFSET = $8905;  
  GL_CLAMP_READ_COLOR = $891C;  
  GL_FIXED_ONLY = $891D;  
  GL_MAX_VARYING_COMPONENTS = $8B4B;  
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
  GL_BUFFER_ACCESS_FLAGS = $911F;  
  GL_BUFFER_MAP_LENGTH = $9120;  
  GL_BUFFER_MAP_OFFSET = $9121;  
  GL_DEPTH_COMPONENT32F = $8CAC;  
  GL_DEPTH32F_STENCIL8 = $8CAD;  
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV = $8DAD;  
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
  GL_MAX_RENDERBUFFER_SIZE = $84E8;  
  GL_DEPTH_STENCIL = $84F9;  
  GL_UNSIGNED_INT_24_8 = $84FA;  
  GL_DEPTH24_STENCIL8 = $88F0;  
  GL_TEXTURE_STENCIL_SIZE = $88F1;  
  GL_TEXTURE_RED_TYPE = $8C10;  
  GL_TEXTURE_GREEN_TYPE = $8C11;  
  GL_TEXTURE_BLUE_TYPE = $8C12;  
  GL_TEXTURE_ALPHA_TYPE = $8C13;  
  GL_TEXTURE_DEPTH_TYPE = $8C16;  
  GL_UNSIGNED_NORMALIZED = $8C17;  
  GL_FRAMEBUFFER_BINDING = $8CA6;  
  GL_DRAW_FRAMEBUFFER_BINDING = $8CA6;  
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
  GL_COLOR_ATTACHMENT16 = $8CF0;  
  GL_COLOR_ATTACHMENT17 = $8CF1;  
  GL_COLOR_ATTACHMENT18 = $8CF2;  
  GL_COLOR_ATTACHMENT19 = $8CF3;  
  GL_COLOR_ATTACHMENT20 = $8CF4;  
  GL_COLOR_ATTACHMENT21 = $8CF5;  
  GL_COLOR_ATTACHMENT22 = $8CF6;  
  GL_COLOR_ATTACHMENT23 = $8CF7;  
  GL_COLOR_ATTACHMENT24 = $8CF8;  
  GL_COLOR_ATTACHMENT25 = $8CF9;  
  GL_COLOR_ATTACHMENT26 = $8CFA;  
  GL_COLOR_ATTACHMENT27 = $8CFB;  
  GL_COLOR_ATTACHMENT28 = $8CFC;  
  GL_COLOR_ATTACHMENT29 = $8CFD;  
  GL_COLOR_ATTACHMENT30 = $8CFE;  
  GL_COLOR_ATTACHMENT31 = $8CFF;  
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
  GL_INDEX = $8222;  
  GL_TEXTURE_LUMINANCE_TYPE = $8C14;  
  GL_TEXTURE_INTENSITY_TYPE = $8C15;  
  GL_FRAMEBUFFER_SRGB = $8DB9;  
  GL_HALF_FLOAT = $140B;  
  GL_MAP_READ_BIT = $0001;  
  GL_MAP_WRITE_BIT = $0002;  
  GL_MAP_INVALIDATE_RANGE_BIT = $0004;  
  GL_MAP_INVALIDATE_BUFFER_BIT = $0008;  
  GL_MAP_FLUSH_EXPLICIT_BIT = $0010;  
  GL_MAP_UNSYNCHRONIZED_BIT = $0020;  
  GL_COMPRESSED_RED_RGTC1 = $8DBB;  
  GL_COMPRESSED_SIGNED_RED_RGTC1 = $8DBC;  
  GL_COMPRESSED_RG_RGTC2 = $8DBD;  
  GL_COMPRESSED_SIGNED_RG_RGTC2 = $8DBE;  
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
  GL_RG8UI = $8238;  
  GL_RG16I = $8239;  
  GL_RG16UI = $823A;  
  GL_RG32I = $823B;  
  GL_RG32UI = $823C;  
  GL_VERTEX_ARRAY_BINDING = $85B5;  
  GL_CLAMP_VERTEX_COLOR = $891A;  
  GL_CLAMP_FRAGMENT_COLOR = $891B;  
  GL_ALPHA_INTEGER = $8D97;  
{////typedef void (P PFNGLCOLORMASKIPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a); }
{////typedef void (P PFNGLGETBOOLEANI_VPROC) (GLenum target, GLuint index, GLboolean *data); }
{////typedef void (P PFNGLGETINTEGERI_VPROC) (GLenum target, GLuint index, GLint *data); }
{////typedef void (P PFNGLENABLEIPROC) (GLenum target, GLuint index); }
{////typedef void (P PFNGLDISABLEIPROC) (GLenum target, GLuint index); }
{////typedef GLboolean (P PFNGLISENABLEDIPROC) (GLenum target, GLuint index); }
{////typedef void (P PFNGLBEGINTRANSFORMFEEDBACKPROC) (GLenum primitiveMode); }
{////typedef void (P PFNGLENDTRANSFORMFEEDBACKPROC) (void); }
{////typedef void (P PFNGLBINDBUFFERRANGEPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLBINDBUFFERBASEPROC) (GLenum target, GLuint index, GLuint buffer); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKVARYINGSPROC) (GLuint program_, GLsizei count, const GLchar *const*varyings, GLenum bufferMode); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKVARYINGPROC) (GLuint program_, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name); }
{////typedef void (P PFNGLCLAMPCOLORPROC) (GLenum target, GLenum clamp); }
{////typedef void (P PFNGLBEGINCONDITIONALRENDERPROC) (GLuint id, GLenum mode); }
{////typedef void (P PFNGLENDCONDITIONALRENDERPROC) (void); }
{////typedef void (P PFNGLVERTEXATTRIBIPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLGETVERTEXATTRIBIIVPROC) (GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBIUIVPROC) (GLuint index, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLVERTEXATTRIBI1IPROC) (GLuint index, GLint x); }
{////typedef void (P PFNGLVERTEXATTRIBI2IPROC) (GLuint index, GLint x, GLint y); }
{////typedef void (P PFNGLVERTEXATTRIBI3IPROC) (GLuint index, GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLVERTEXATTRIBI4IPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLVERTEXATTRIBI1UIPROC) (GLuint index, GLuint x); }
{////typedef void (P PFNGLVERTEXATTRIBI2UIPROC) (GLuint index, GLuint x, GLuint y); }
{////typedef void (P PFNGLVERTEXATTRIBI3UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z); }
{////typedef void (P PFNGLVERTEXATTRIBI4UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w); }
{////typedef void (P PFNGLVERTEXATTRIBI1IVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI2IVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI3IVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4IVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI1UIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI2UIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI3UIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4UIVPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4BVPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4SVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4UBVPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4USVPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLGETUNIFORMUIVPROC) (GLuint program_, GLint location, GLuint *params); }
{////typedef void (P PFNGLBINDFRAGDATALOCATIONPROC) (GLuint program_, GLuint color, const GLchar *name); }
{////typedef GLint (P PFNGLGETFRAGDATALOCATIONPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLUNIFORM1UIPROC) (GLint location, GLuint v0); }
{////typedef void (P PFNGLUNIFORM2UIPROC) (GLint location, GLuint v0, GLuint v1); }
{////typedef void (P PFNGLUNIFORM3UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2); }
{////typedef void (P PFNGLUNIFORM4UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3); }
{////typedef void (P PFNGLUNIFORM1UIVPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM2UIVPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM3UIVPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM4UIVPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, const GLuint *params); }
{////typedef void (P PFNGLGETTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLCLEARBUFFERIVPROC) (GLenum buffer, GLint drawbuffer, const GLint *value); }
{////typedef void (P PFNGLCLEARBUFFERUIVPROC) (GLenum buffer, GLint drawbuffer, const GLuint *value); }
{////typedef void (P PFNGLCLEARBUFFERFVPROC) (GLenum buffer, GLint drawbuffer, const GLfloat *value); }
{////typedef void (P PFNGLCLEARBUFFERFIPROC) (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil); }
{////typedef const GLubyte *(P PFNGLGETSTRINGIPROC) (GLenum name, GLuint index); }
{////typedef GLboolean (P PFNGLISRENDERBUFFERPROC) (GLuint renderbuffer); }
{////typedef void (P PFNGLBINDRENDERBUFFERPROC) (GLenum target, GLuint renderbuffer); }
{////typedef void (P PFNGLDELETERENDERBUFFERSPROC) (GLsizei n, const GLuint *renderbuffers); }
{////typedef void (P PFNGLGENRENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers); }
{////typedef void (P PFNGLRENDERBUFFERSTORAGEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETRENDERBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef GLboolean (P PFNGLISFRAMEBUFFERPROC) (GLuint framebuffer); }
{////typedef void (P PFNGLBINDFRAMEBUFFERPROC) (GLenum target, GLuint framebuffer); }
{////typedef void (P PFNGLDELETEFRAMEBUFFERSPROC) (GLsizei n, const GLuint *framebuffers); }
{////typedef void (P PFNGLGENFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers); }
{////typedef GLenum (P PFNGLCHECKFRAMEBUFFERSTATUSPROC) (GLenum target); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE1DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE2DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE3DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset); }
{////typedef void (P PFNGLFRAMEBUFFERRENDERBUFFERPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer); }
{////typedef void (P PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGENERATEMIPMAPPROC) (GLenum target); }
{////typedef void (P PFNGLBLITFRAMEBUFFERPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter); }
{////typedef void (P PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURELAYERPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer); }
{////typedef void *(P PFNGLMAPBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access); }
{////typedef void (P PFNGLFLUSHMAPPEDBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length); }
{////typedef void (P PFNGLBINDVERTEXARRAYPROC) (GLuint array); }
{////typedef void (P PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays); }
{////typedef void (P PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays); }
{////typedef GLboolean (P PFNGLISVERTEXARRAYPROC) (GLuint array); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glColorMaski(index:TGLuint; r:TGLboolean; g:TGLboolean; b:TGLboolean; a:TGLboolean);cdecl;external;
procedure glGetBooleani_v(target:TGLenum; index:TGLuint; data:PGLboolean);cdecl;external;
procedure glGetIntegeri_v(target:TGLenum; index:TGLuint; data:PGLint);cdecl;external;
procedure glEnablei(target:TGLenum; index:TGLuint);cdecl;external;
procedure glDisablei(target:TGLenum; index:TGLuint);cdecl;external;
function glIsEnabledi(target:TGLenum; index:TGLuint):TGLboolean;cdecl;external;
procedure glBeginTransformFeedback(primitiveMode:TGLenum);cdecl;external;
procedure glEndTransformFeedback;cdecl;external;
procedure glBindBufferRange(target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glBindBufferBase(target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glTransformFeedbackVaryings(program_:TGLuint; count:TGLsizei; varyings:PPGLchar; bufferMode:TGLenum);cdecl;external;
procedure glGetTransformFeedbackVarying(program_:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei; 
            _type:PGLenum; name:PGLchar);cdecl;external;
procedure glClampColor(target:TGLenum; clamp:TGLenum);cdecl;external;
procedure glBeginConditionalRender(id:TGLuint; mode:TGLenum);cdecl;external;
procedure glEndConditionalRender;cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribIPointer(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glGetVertexAttribIiv(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribIuiv(index:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glVertexAttribI1i(index:TGLuint; x:TGLint);cdecl;external;
procedure glVertexAttribI2i(index:TGLuint; x:TGLint; y:TGLint);cdecl;external;
procedure glVertexAttribI3i(index:TGLuint; x:TGLint; y:TGLint; z:TGLint);cdecl;external;
procedure glVertexAttribI4i(index:TGLuint; x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external;
procedure glVertexAttribI1ui(index:TGLuint; x:TGLuint);cdecl;external;
procedure glVertexAttribI2ui(index:TGLuint; x:TGLuint; y:TGLuint);cdecl;external;
procedure glVertexAttribI3ui(index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint);cdecl;external;
procedure glVertexAttribI4ui(index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint; w:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI1iv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI2iv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI3iv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4iv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI1uiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI2uiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI3uiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4uiv(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4bv(index:TGLuint; v:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4sv(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4ubv(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4usv(index:TGLuint; v:PGLushort);cdecl;external;
procedure glGetUniformuiv(program_:TGLuint; location:TGLint; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glBindFragDataLocation(program_:TGLuint; color:TGLuint; name:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetFragDataLocation(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glUniform1ui(location:TGLint; v0:TGLuint);cdecl;external;
procedure glUniform2ui(location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;external;
procedure glUniform3ui(location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;external;
procedure glUniform4ui(location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; v3:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform1uiv(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform2uiv(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform3uiv(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform4uiv(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTexParameterIiv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTexParameterIuiv(target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetTexParameterIiv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTexParameterIuiv(target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glClearBufferiv(buffer:TGLenum; drawbuffer:TGLint; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glClearBufferuiv(buffer:TGLenum; drawbuffer:TGLint; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glClearBufferfv(buffer:TGLenum; drawbuffer:TGLint; value:PGLfloat);cdecl;external;
procedure glClearBufferfi(buffer:TGLenum; drawbuffer:TGLint; depth:TGLfloat; stencil:TGLint);cdecl;external;
(* Const before type ignored *)
function glGetStringi(name:TGLenum; index:TGLuint):PGLubyte;cdecl;external;
function glIsRenderbuffer(renderbuffer:TGLuint):TGLboolean;cdecl;external;
procedure glBindRenderbuffer(target:TGLenum; renderbuffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteRenderbuffers(n:TGLsizei; renderbuffers:PGLuint);cdecl;external;
procedure glGenRenderbuffers(n:TGLsizei; renderbuffers:PGLuint);cdecl;external;
procedure glRenderbufferStorage(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetRenderbufferParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
function glIsFramebuffer(framebuffer:TGLuint):TGLboolean;cdecl;external;
procedure glBindFramebuffer(target:TGLenum; framebuffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteFramebuffers(n:TGLsizei; framebuffers:PGLuint);cdecl;external;
procedure glGenFramebuffers(n:TGLsizei; framebuffers:PGLuint);cdecl;external;
function glCheckFramebufferStatus(target:TGLenum):TGLenum;cdecl;external;
procedure glFramebufferTexture1D(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTexture2D(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTexture3D(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint; 
            zoffset:TGLint);cdecl;external;
procedure glFramebufferRenderbuffer(target:TGLenum; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glGetFramebufferAttachmentParameteriv(target:TGLenum; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGenerateMipmap(target:TGLenum);cdecl;external;
procedure glBlitFramebuffer(srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint; 
            dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;external;
procedure glRenderbufferStorageMultisample(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glFramebufferTextureLayer(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;external;
function glMapBufferRange(target:TGLenum; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;external;
procedure glFlushMappedBufferRange(target:TGLenum; offset:TGLintptr; length:TGLsizeiptr);cdecl;external;
procedure glBindVertexArray(array_:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteVertexArrays(n:TGLsizei; arrays:PGLuint);cdecl;external;
procedure glGenVertexArrays(n:TGLsizei; arrays:PGLuint);cdecl;external;
function glIsVertexArray(array_:TGLuint):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_3_0 */ }
{////#ifndef GL_VERSION_3_1 }
const
  GL_VERSION_3_1 = 1;  
  GL_SAMPLER_2D_RECT = $8B63;  
  GL_SAMPLER_2D_RECT_SHADOW = $8B64;  
  GL_SAMPLER_BUFFER = $8DC2;  
  GL_INT_SAMPLER_2D_RECT = $8DCD;  
  GL_INT_SAMPLER_BUFFER = $8DD0;  
  GL_UNSIGNED_INT_SAMPLER_2D_RECT = $8DD5;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER = $8DD8;  
  GL_TEXTURE_BUFFER = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING = $8C2D;  
  GL_TEXTURE_RECTANGLE = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE = $84F8;  
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
  GL_COPY_READ_BUFFER = $8F36;  
  GL_COPY_WRITE_BUFFER = $8F37;  
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
{////typedef void (P PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount); }
{////typedef void (P PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer); }
{////typedef void (P PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index); }
{////typedef void (P PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size); }
{////typedef void (P PFNGLGETUNIFORMINDICESPROC) (GLuint program_, GLsizei uniformCount, const GLchar *const*uniformNames, GLuint *uniformIndices); }
{////typedef void (P PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program_, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program_, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName); }
{////typedef GLuint (P PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program_, const GLchar *uniformBlockName); }
{////typedef void (P PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program_, GLuint uniformBlockIndex, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program_, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName); }
{////typedef void (P PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program_, GLuint uniformBlockIndex, GLuint uniformBlockBinding); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawArraysInstanced(mode:TGLenum; first:TGLint; count:TGLsizei; instancecount:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstanced(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei);cdecl;external;
procedure glTexBuffer(target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
procedure glPrimitiveRestartIndex(index:TGLuint);cdecl;external;
procedure glCopyBufferSubData(readTarget:TGLenum; writeTarget:TGLenum; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glGetUniformIndices(program_:TGLuint; uniformCount:TGLsizei; uniformNames:PPGLchar; uniformIndices:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glGetActiveUniformsiv(program_:TGLuint; uniformCount:TGLsizei; uniformIndices:PGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetActiveUniformName(program_:TGLuint; uniformIndex:TGLuint; bufSize:TGLsizei; length:PGLsizei; uniformName:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetUniformBlockIndex(program_:TGLuint; uniformBlockName:PGLchar):TGLuint;cdecl;external;
procedure glGetActiveUniformBlockiv(program_:TGLuint; uniformBlockIndex:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetActiveUniformBlockName(program_:TGLuint; uniformBlockIndex:TGLuint; bufSize:TGLsizei; length:PGLsizei; uniformBlockName:PGLchar);cdecl;external;
procedure glUniformBlockBinding(program_:TGLuint; uniformBlockIndex:TGLuint; uniformBlockBinding:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_3_1 */ }
{////#ifndef GL_VERSION_3_2 }
const
  GL_VERSION_3_2 = 1;  
type
  PGLsync = ^TGLsync;
  TGLsync = Pointer;

  PGLuint64 = ^TGLuint64;
  TGLuint64 = uint64;

  PGLint64 = ^TGLint64;
  TGLint64 = int64;

const
  GL_CONTEXT_CORE_PROFILE_BIT = $00000001;  
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = $00000002;  
  GL_LINES_ADJACENCY = $000A;  
  GL_LINE_STRIP_ADJACENCY = $000B;  
  GL_TRIANGLES_ADJACENCY = $000C;  
  GL_TRIANGLE_STRIP_ADJACENCY = $000D;  
  GL_PROGRAM_POINT_SIZE = $8642;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = $8C29;  
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED = $8DA7;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = $8DA8;  
  GL_GEOMETRY_SHADER = $8DD9;  
  GL_GEOMETRY_VERTICES_OUT = $8916;  
  GL_GEOMETRY_INPUT_TYPE = $8917;  
  GL_GEOMETRY_OUTPUT_TYPE = $8918;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = $8DE1;  
  GL_MAX_VERTEX_OUTPUT_COMPONENTS = $9122;  
  GL_MAX_GEOMETRY_INPUT_COMPONENTS = $9123;  
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = $9124;  
  GL_MAX_FRAGMENT_INPUT_COMPONENTS = $9125;  
  GL_CONTEXT_PROFILE_MASK = $9126;  
  GL_DEPTH_CLAMP = $864F;  
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = $8E4C;  
  GL_FIRST_VERTEX_CONVENTION = $8E4D;  
  GL_LAST_VERTEX_CONVENTION = $8E4E;  
  GL_PROVOKING_VERTEX = $8E4F;  
  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;  
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
  GL_SYNC_FLUSH_COMMANDS_BIT = $00000001;  
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
{////typedef void (P PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLint basevertex); }
{////typedef void (P PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end_, GLsizei count, GLenum type, const void *indices, GLint basevertex); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount, const GLint *basevertex); }
{////typedef void (P PFNGLPROVOKINGVERTEXPROC) (GLenum mode); }
{////typedef GLsync (P PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags); }
{////typedef GLboolean (P PFNGLISSYNCPROC) (GLsync sync); }
{////typedef void (P PFNGLDELETESYNCPROC) (GLsync sync); }
{////typedef GLenum (P PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout); }
{////typedef void (P PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout); }
{////typedef void (P PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *data); }
{////typedef void (P PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values); }
{////typedef void (P PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data); }
{////typedef void (P PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level); }
{////typedef void (P PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val); }
{////typedef void (P PFNGLSAMPLEMASKIPROC) (GLuint maskNumber, GLbitfield mask); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDrawElementsBaseVertex(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; basevertex:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glDrawRangeElementsBaseVertex(mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum; 
            indices:pointer; basevertex:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstancedBaseVertex(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei; 
            basevertex:TGLint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before declarator ignored *)
(* Const before type ignored *)
procedure glMultiDrawElementsBaseVertex(mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; drawcount:TGLsizei; 
            basevertex:PGLint);cdecl;external;
procedure glProvokingVertex(mode:TGLenum);cdecl;external;
function glFenceSync(condition:TGLenum; flags:TGLbitfield):TGLsync;cdecl;external;
function glIsSync(sync:TGLsync):TGLboolean;cdecl;external;
procedure glDeleteSync(sync:TGLsync);cdecl;external;
function glClientWaitSync(sync:TGLsync; flags:TGLbitfield; timeout:TGLuint64):TGLenum;cdecl;external;
procedure glWaitSync(sync:TGLsync; flags:TGLbitfield; timeout:TGLuint64);cdecl;external;
procedure glGetInteger64v(pname:TGLenum; data:PGLint64);cdecl;external;
procedure glGetSynciv(sync:TGLsync; pname:TGLenum; count:TGLsizei; length:PGLsizei; values:PGLint);cdecl;external;
procedure glGetInteger64i_v(target:TGLenum; index:TGLuint; data:PGLint64);cdecl;external;
procedure glGetBufferParameteri64v(target:TGLenum; pname:TGLenum; params:PGLint64);cdecl;external;
procedure glFramebufferTexture(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glTexImage2DMultisample(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            fixedsamplelocations:TGLboolean);cdecl;external;
procedure glTexImage3DMultisample(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;external;
procedure glGetMultisamplefv(pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;external;
procedure glSampleMaski(maskNumber:TGLuint; mask:TGLbitfield);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_3_2 */ }
{////#ifndef GL_VERSION_3_3 }
const
  GL_VERSION_3_3 = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR = $88FE;  
  GL_SRC1_COLOR = $88F9;  
  GL_ONE_MINUS_SRC1_COLOR = $88FA;  
  GL_ONE_MINUS_SRC1_ALPHA = $88FB;  
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = $88FC;  
  GL_ANY_SAMPLES_PASSED = $8C2F;  
  GL_SAMPLER_BINDING = $8919;  
  GL_RGB10_A2UI = $906F;  
  GL_TEXTURE_SWIZZLE_R = $8E42;  
  GL_TEXTURE_SWIZZLE_G = $8E43;  
  GL_TEXTURE_SWIZZLE_B = $8E44;  
  GL_TEXTURE_SWIZZLE_A = $8E45;  
  GL_TEXTURE_SWIZZLE_RGBA = $8E46;  
  GL_TIME_ELAPSED = $88BF;  
  GL_TIMESTAMP = $8E28;  
  GL_INT_2_10_10_10_REV = $8D9F;  
{////typedef void (P PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program_, GLuint colorNumber, GLuint index, const GLchar *name); }
{////typedef GLint (P PFNGLGETFRAGDATAINDEXPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLGENSAMPLERSPROC) (GLsizei count, GLuint *samplers); }
{////typedef void (P PFNGLDELETESAMPLERSPROC) (GLsizei count, const GLuint *samplers); }
{////typedef GLboolean (P PFNGLISSAMPLERPROC) (GLuint sampler); }
{////typedef void (P PFNGLBINDSAMPLERPROC) (GLuint unit, GLuint sampler); }
{////typedef void (P PFNGLSAMPLERPARAMETERIPROC) (GLuint sampler, GLenum pname, GLint param); }
{////typedef void (P PFNGLSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, const GLint *param); }
{////typedef void (P PFNGLSAMPLERPARAMETERFPROC) (GLuint sampler, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, const GLfloat *param); }
{////typedef void (P PFNGLSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, const GLint *param); }
{////typedef void (P PFNGLSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, const GLuint *param); }
{////typedef void (P PFNGLGETSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target); }
{////typedef void (P PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params); }
{////typedef void (P PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params); }
{////typedef void (P PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor); }
{////typedef void (P PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value); }
{////typedef void (P PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value); }
{////typedef void (P PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value); }
{////typedef void (P PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value); }
{////typedef void (P PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value); }
{////typedef void (P PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value); }
{////typedef void (P PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value); }
{////typedef void (P PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value); }
{////typedef void (P PFNGLVERTEXP2UIPROC) (GLenum type, GLuint value); }
{////typedef void (P PFNGLVERTEXP2UIVPROC) (GLenum type, const GLuint *value); }
{////typedef void (P PFNGLVERTEXP3UIPROC) (GLenum type, GLuint value); }
{////typedef void (P PFNGLVERTEXP3UIVPROC) (GLenum type, const GLuint *value); }
{////typedef void (P PFNGLVERTEXP4UIPROC) (GLenum type, GLuint value); }
{////typedef void (P PFNGLVERTEXP4UIVPROC) (GLenum type, const GLuint *value); }
{////typedef void (P PFNGLTEXCOORDP1UIPROC) (GLenum type, GLuint coords); }
{////typedef void (P PFNGLTEXCOORDP1UIVPROC) (GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLTEXCOORDP2UIPROC) (GLenum type, GLuint coords); }
{////typedef void (P PFNGLTEXCOORDP2UIVPROC) (GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLTEXCOORDP3UIPROC) (GLenum type, GLuint coords); }
{////typedef void (P PFNGLTEXCOORDP3UIVPROC) (GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLTEXCOORDP4UIPROC) (GLenum type, GLuint coords); }
{////typedef void (P PFNGLTEXCOORDP4UIVPROC) (GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLMULTITEXCOORDP1UIPROC) (GLenum texture, GLenum type, GLuint coords); }
{////typedef void (P PFNGLMULTITEXCOORDP1UIVPROC) (GLenum texture, GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLMULTITEXCOORDP2UIPROC) (GLenum texture, GLenum type, GLuint coords); }
{////typedef void (P PFNGLMULTITEXCOORDP2UIVPROC) (GLenum texture, GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLMULTITEXCOORDP3UIPROC) (GLenum texture, GLenum type, GLuint coords); }
{////typedef void (P PFNGLMULTITEXCOORDP3UIVPROC) (GLenum texture, GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLMULTITEXCOORDP4UIPROC) (GLenum texture, GLenum type, GLuint coords); }
{////typedef void (P PFNGLMULTITEXCOORDP4UIVPROC) (GLenum texture, GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLNORMALP3UIPROC) (GLenum type, GLuint coords); }
{////typedef void (P PFNGLNORMALP3UIVPROC) (GLenum type, const GLuint *coords); }
{////typedef void (P PFNGLCOLORP3UIPROC) (GLenum type, GLuint color); }
{////typedef void (P PFNGLCOLORP3UIVPROC) (GLenum type, const GLuint *color); }
{////typedef void (P PFNGLCOLORP4UIPROC) (GLenum type, GLuint color); }
{////typedef void (P PFNGLCOLORP4UIVPROC) (GLenum type, const GLuint *color); }
{////typedef void (P PFNGLSECONDARYCOLORP3UIPROC) (GLenum type, GLuint color); }
{////typedef void (P PFNGLSECONDARYCOLORP3UIVPROC) (GLenum type, const GLuint *color); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glBindFragDataLocationIndexed(program_:TGLuint; colorNumber:TGLuint; index:TGLuint; name:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetFragDataIndex(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glGenSamplers(count:TGLsizei; samplers:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteSamplers(count:TGLsizei; samplers:PGLuint);cdecl;external;
function glIsSampler(sampler:TGLuint):TGLboolean;cdecl;external;
procedure glBindSampler(unit_:TGLuint; sampler:TGLuint);cdecl;external;
procedure glSamplerParameteri(sampler:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glSamplerParameteriv(sampler:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glSamplerParameterf(sampler:TGLuint; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glSamplerParameterfv(sampler:TGLuint; pname:TGLenum; param:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glSamplerParameterIiv(sampler:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glSamplerParameterIuiv(sampler:TGLuint; pname:TGLenum; param:PGLuint);cdecl;external;
procedure glGetSamplerParameteriv(sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetSamplerParameterIiv(sampler:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetSamplerParameterfv(sampler:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetSamplerParameterIuiv(sampler:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glQueryCounter(id:TGLuint; target:TGLenum);cdecl;external;
procedure glGetQueryObjecti64v(id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;external;
procedure glGetQueryObjectui64v(id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;external;
procedure glVertexAttribDivisor(index:TGLuint; divisor:TGLuint);cdecl;external;
procedure glVertexAttribP1ui(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribP1uiv(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;external;
procedure glVertexAttribP2ui(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribP2uiv(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;external;
procedure glVertexAttribP3ui(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribP3uiv(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;external;
procedure glVertexAttribP4ui(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribP4uiv(index:TGLuint; _type:TGLenum; normalized:TGLboolean; value:PGLuint);cdecl;external;
procedure glVertexP2ui(_type:TGLenum; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexP2uiv(_type:TGLenum; value:PGLuint);cdecl;external;
procedure glVertexP3ui(_type:TGLenum; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexP3uiv(_type:TGLenum; value:PGLuint);cdecl;external;
procedure glVertexP4ui(_type:TGLenum; value:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexP4uiv(_type:TGLenum; value:PGLuint);cdecl;external;
procedure glTexCoordP1ui(_type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordP1uiv(_type:TGLenum; coords:PGLuint);cdecl;external;
procedure glTexCoordP2ui(_type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordP2uiv(_type:TGLenum; coords:PGLuint);cdecl;external;
procedure glTexCoordP3ui(_type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordP3uiv(_type:TGLenum; coords:PGLuint);cdecl;external;
procedure glTexCoordP4ui(_type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordP4uiv(_type:TGLenum; coords:PGLuint);cdecl;external;
procedure glMultiTexCoordP1ui(texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoordP1uiv(texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;external;
procedure glMultiTexCoordP2ui(texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoordP2uiv(texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;external;
procedure glMultiTexCoordP3ui(texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoordP3uiv(texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;external;
procedure glMultiTexCoordP4ui(texture:TGLenum; _type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoordP4uiv(texture:TGLenum; _type:TGLenum; coords:PGLuint);cdecl;external;
procedure glNormalP3ui(_type:TGLenum; coords:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glNormalP3uiv(_type:TGLenum; coords:PGLuint);cdecl;external;
procedure glColorP3ui(_type:TGLenum; color:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glColorP3uiv(_type:TGLenum; color:PGLuint);cdecl;external;
procedure glColorP4ui(_type:TGLenum; color:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glColorP4uiv(_type:TGLenum; color:PGLuint);cdecl;external;
procedure glSecondaryColorP3ui(_type:TGLenum; color:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColorP3uiv(_type:TGLenum; color:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_3_3 */ }
{////#ifndef GL_VERSION_4_0 }
const
  GL_VERSION_4_0 = 1;  
  GL_SAMPLE_SHADING = $8C36;  
  GL_MIN_SAMPLE_SHADING_VALUE = $8C37;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5F;  
  GL_TEXTURE_CUBE_MAP_ARRAY = $9009;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = $900A;  
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = $900B;  
  GL_SAMPLER_CUBE_MAP_ARRAY = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = $900F;  
  GL_DRAW_INDIRECT_BUFFER = $8F3F;  
  GL_DRAW_INDIRECT_BUFFER_BINDING = $8F43;  
  GL_GEOMETRY_SHADER_INVOCATIONS = $887F;  
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS = $8E5A;  
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = $8E5B;  
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = $8E5C;  
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = $8E5D;  
  GL_MAX_VERTEX_STREAMS = $8E71;  
  GL_DOUBLE_VEC2 = $8FFC;  
  GL_DOUBLE_VEC3 = $8FFD;  
  GL_DOUBLE_VEC4 = $8FFE;  
  GL_DOUBLE_MAT2 = $8F46;  
  GL_DOUBLE_MAT3 = $8F47;  
  GL_DOUBLE_MAT4 = $8F48;  
  GL_DOUBLE_MAT2x3 = $8F49;  
  GL_DOUBLE_MAT2x4 = $8F4A;  
  GL_DOUBLE_MAT3x2 = $8F4B;  
  GL_DOUBLE_MAT3x4 = $8F4C;  
  GL_DOUBLE_MAT4x2 = $8F4D;  
  GL_DOUBLE_MAT4x3 = $8F4E;  
  GL_ACTIVE_SUBROUTINES = $8DE5;  
  GL_ACTIVE_SUBROUTINE_UNIFORMS = $8DE6;  
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = $8E47;  
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH = $8E48;  
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = $8E49;  
  GL_MAX_SUBROUTINES = $8DE7;  
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = $8DE8;  
  GL_NUM_COMPATIBLE_SUBROUTINES = $8E4A;  
  GL_COMPATIBLE_SUBROUTINES = $8E4B;  
  GL_PATCHES = $000E;  
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
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = $8E89;  
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = $8E8A;  
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = $886C;  
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = $886D;  
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = $8E1E;  
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E1F;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = $84F0;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = $84F1;  
  GL_TESS_EVALUATION_SHADER = $8E87;  
  GL_TESS_CONTROL_SHADER = $8E88;  
  GL_TRANSFORM_FEEDBACK = $8E22;  
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = $8E23;  
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = $8E24;  
  GL_TRANSFORM_FEEDBACK_BINDING = $8E25;  
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = $8E70;  
{////typedef void (P PFNGLMINSAMPLESHADINGPROC) (GLfloat value); }
{////typedef void (P PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode); }
{////typedef void (P PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha); }
{////typedef void (P PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst); }
{////typedef void (P PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha); }
{////typedef void (P PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect); }
{////typedef void (P PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect); }
{////typedef void (P PFNGLUNIFORM1DPROC) (GLint location, GLdouble x); }
{////typedef void (P PFNGLUNIFORM2DPROC) (GLint location, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLUNIFORM3DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLUNIFORM4DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLUNIFORM1DVPROC) (GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORM2DVPROC) (GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORM3DVPROC) (GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORM4DVPROC) (GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLGETUNIFORMDVPROC) (GLuint program_, GLint location, GLdouble *params); }
{////typedef GLint (P PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program_, GLenum shadertype, const GLchar *name); }
{////typedef GLuint (P PFNGLGETSUBROUTINEINDEXPROC) (GLuint program_, GLenum shadertype, const GLchar *name); }
{////typedef void (P PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program_, GLenum shadertype, GLuint index, GLenum pname, GLint *values); }
{////typedef void (P PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program_, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name); }
{////typedef void (P PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program_, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name); }
{////typedef void (P PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices); }
{////typedef void (P PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params); }
{////typedef void (P PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program_, GLenum shadertype, GLenum pname, GLint *values); }
{////typedef void (P PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value); }
{////typedef void (P PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values); }
{////typedef void (P PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id); }
{////typedef void (P PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids); }
{////typedef void (P PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids); }
{////typedef GLboolean (P PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id); }
{////typedef void (P PFNGLPAUSETRANSFORMFEEDBACKPROC) (void); }
{////typedef void (P PFNGLRESUMETRANSFORMFEEDBACKPROC) (void); }
{////typedef void (P PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id); }
{////typedef void (P PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream); }
{////typedef void (P PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id); }
{////typedef void (P PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index); }
{////typedef void (P PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMinSampleShading(value:TGLfloat);cdecl;external;
procedure glBlendEquationi(buf:TGLuint; mode:TGLenum);cdecl;external;
procedure glBlendEquationSeparatei(buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;external;
procedure glBlendFunci(buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;external;
procedure glBlendFuncSeparatei(buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glDrawArraysIndirect(mode:TGLenum; indirect:pointer);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsIndirect(mode:TGLenum; _type:TGLenum; indirect:pointer);cdecl;external;
procedure glUniform1d(location:TGLint; x:TGLdouble);cdecl;external;
procedure glUniform2d(location:TGLint; x:TGLdouble; y:TGLdouble);cdecl;external;
procedure glUniform3d(location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glUniform4d(location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniform1dv(location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniform2dv(location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniform3dv(location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniform4dv(location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2x3dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2x4dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3x2dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3x4dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4x2dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4x3dv(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
procedure glGetUniformdv(program_:TGLuint; location:TGLint; params:PGLdouble);cdecl;external;
(* Const before type ignored *)
function glGetSubroutineUniformLocation(program_:TGLuint; shadertype:TGLenum; name:PGLchar):TGLint;cdecl;external;
(* Const before type ignored *)
function glGetSubroutineIndex(program_:TGLuint; shadertype:TGLenum; name:PGLchar):TGLuint;cdecl;external;
procedure glGetActiveSubroutineUniformiv(program_:TGLuint; shadertype:TGLenum; index:TGLuint; pname:TGLenum; values:PGLint);cdecl;external;
procedure glGetActiveSubroutineUniformName(program_:TGLuint; shadertype:TGLenum; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; 
            name:PGLchar);cdecl;external;
procedure glGetActiveSubroutineName(program_:TGLuint; shadertype:TGLenum; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; 
            name:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glUniformSubroutinesuiv(shadertype:TGLenum; count:TGLsizei; indices:PGLuint);cdecl;external;
procedure glGetUniformSubroutineuiv(shadertype:TGLenum; location:TGLint; params:PGLuint);cdecl;external;
procedure glGetProgramStageiv(program_:TGLuint; shadertype:TGLenum; pname:TGLenum; values:PGLint);cdecl;external;
procedure glPatchParameteri(pname:TGLenum; value:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glPatchParameterfv(pname:TGLenum; values:PGLfloat);cdecl;external;
procedure glBindTransformFeedback(target:TGLenum; id:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteTransformFeedbacks(n:TGLsizei; ids:PGLuint);cdecl;external;
procedure glGenTransformFeedbacks(n:TGLsizei; ids:PGLuint);cdecl;external;
function glIsTransformFeedback(id:TGLuint):TGLboolean;cdecl;external;
procedure glPauseTransformFeedback;cdecl;external;
procedure glResumeTransformFeedback;cdecl;external;
procedure glDrawTransformFeedback(mode:TGLenum; id:TGLuint);cdecl;external;
procedure glDrawTransformFeedbackStream(mode:TGLenum; id:TGLuint; stream:TGLuint);cdecl;external;
procedure glBeginQueryIndexed(target:TGLenum; index:TGLuint; id:TGLuint);cdecl;external;
procedure glEndQueryIndexed(target:TGLenum; index:TGLuint);cdecl;external;
procedure glGetQueryIndexediv(target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_0 */ }
{////#ifndef GL_VERSION_4_1 }
const
  GL_VERSION_4_1 = 1;  
  GL_FIXED = $140C;  
  GL_IMPLEMENTATION_COLOR_READ_TYPE = $8B9A;  
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B;  
  GL_LOW_FLOAT = $8DF0;  
  GL_MEDIUM_FLOAT = $8DF1;  
  GL_HIGH_FLOAT = $8DF2;  
  GL_LOW_INT = $8DF3;  
  GL_MEDIUM_INT = $8DF4;  
  GL_HIGH_INT = $8DF5;  
  GL_SHADER_COMPILER = $8DFA;  
  GL_SHADER_BINARY_FORMATS = $8DF8;  
  GL_NUM_SHADER_BINARY_FORMATS = $8DF9;  
  GL_MAX_VERTEX_UNIFORM_VECTORS = $8DFB;  
  GL_MAX_VARYING_VECTORS = $8DFC;  
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD;  
  GL_RGB565 = $8D62;  
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT = $8257;  
  GL_PROGRAM_BINARY_LENGTH = $8741;  
  GL_NUM_PROGRAM_BINARY_FORMATS = $87FE;  
  GL_PROGRAM_BINARY_FORMATS = $87FF;  
  GL_VERTEX_SHADER_BIT = $00000001;  
  GL_FRAGMENT_SHADER_BIT = $00000002;  
  GL_GEOMETRY_SHADER_BIT = $00000004;  
  GL_TESS_CONTROL_SHADER_BIT = $00000008;  
  GL_TESS_EVALUATION_SHADER_BIT = $00000010;  
  GL_ALL_SHADER_BITS = $FFFFFFFF;  
  GL_PROGRAM_SEPARABLE = $8258;  
  GL_ACTIVE_PROGRAM = $8259;  
  GL_PROGRAM_PIPELINE_BINDING = $825A;  
  GL_MAX_VIEWPORTS = $825B;  
  GL_VIEWPORT_SUBPIXEL_BITS = $825C;  
  GL_VIEWPORT_BOUNDS_RANGE = $825D;  
  GL_LAYER_PROVOKING_VERTEX = $825E;  
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX = $825F;  
  GL_UNDEFINED_VERTEX = $8260;  
{////typedef void (P PFNGLRELEASESHADERCOMPILERPROC) (void); }
{////typedef void (P PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryFormat, const void *binary, GLsizei length); }
{////typedef void (P PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision); }
{////typedef void (P PFNGLDEPTHRANGEFPROC) (GLfloat n, GLfloat f); }
{////typedef void (P PFNGLCLEARDEPTHFPROC) (GLfloat d); }
{////typedef void (P PFNGLGETPROGRAMBINARYPROC) (GLuint program_, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, void *binary); }
{////typedef void (P PFNGLPROGRAMBINARYPROC) (GLuint program_, GLenum binaryFormat, const void *binary, GLsizei length); }
{////typedef void (P PFNGLPROGRAMPARAMETERIPROC) (GLuint program_, GLenum pname, GLint value); }
{////typedef void (P PFNGLUSEPROGRAMSTAGESPROC) (GLuint pipeline, GLbitfield stages, GLuint program_); }
{////typedef void (P PFNGLACTIVESHADERPROGRAMPROC) (GLuint pipeline, GLuint program_); }
{////typedef GLuint (P PFNGLCREATESHADERPROGRAMVPROC) (GLenum type, GLsizei count, const GLchar *const*strings); }
{////typedef void (P PFNGLBINDPROGRAMPIPELINEPROC) (GLuint pipeline); }
{////typedef void (P PFNGLDELETEPROGRAMPIPELINESPROC) (GLsizei n, const GLuint *pipelines); }
{////typedef void (P PFNGLGENPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines); }
{////typedef GLboolean (P PFNGLISPROGRAMPIPELINEPROC) (GLuint pipeline); }
{////typedef void (P PFNGLGETPROGRAMPIPELINEIVPROC) (GLuint pipeline, GLenum pname, GLint *params); }
{////typedef void (P PFNGLPROGRAMUNIFORM1IPROC) (GLuint program_, GLint location, GLint v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM1IVPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1FPROC) (GLuint program_, GLint location, GLfloat v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM1FVPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1DPROC) (GLuint program_, GLint location, GLdouble v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM1DVPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UIPROC) (GLuint program_, GLint location, GLuint v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UIVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2IPROC) (GLuint program_, GLint location, GLint v0, GLint v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM2IVPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2FPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM2FVPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2DPROC) (GLuint program_, GLint location, GLdouble v0, GLdouble v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM2DVPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UIPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UIVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3IPROC) (GLuint program_, GLint location, GLint v0, GLint v1, GLint v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM3IVPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3FPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1, GLfloat v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM3FVPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3DPROC) (GLuint program_, GLint location, GLdouble v0, GLdouble v1, GLdouble v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM3DVPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UIPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1, GLuint v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UIVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4IPROC) (GLuint program_, GLint location, GLint v0, GLint v1, GLint v2, GLint v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM4IVPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4FPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM4FVPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4DPROC) (GLuint program_, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM4DVPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UIPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UIVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLVALIDATEPROGRAMPIPELINEPROC) (GLuint pipeline); }
{////typedef void (P PFNGLGETPROGRAMPIPELINEINFOLOGPROC) (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog); }
{////typedef void (P PFNGLVERTEXATTRIBL1DPROC) (GLuint index, GLdouble x); }
{////typedef void (P PFNGLVERTEXATTRIBL2DPROC) (GLuint index, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXATTRIBL3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXATTRIBL4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXATTRIBL1DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL2DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL3DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL4DVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBLPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLGETVERTEXATTRIBLDVPROC) (GLuint index, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLVIEWPORTARRAYVPROC) (GLuint first, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLVIEWPORTINDEXEDFPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h); }
{////typedef void (P PFNGLVIEWPORTINDEXEDFVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLSCISSORARRAYVPROC) (GLuint first, GLsizei count, const GLint *v); }
{////typedef void (P PFNGLSCISSORINDEXEDPROC) (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLSCISSORINDEXEDVPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLDEPTHRANGEARRAYVPROC) (GLuint first, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLDEPTHRANGEINDEXEDPROC) (GLuint index, GLdouble n, GLdouble f); }
{////typedef void (P PFNGLGETFLOATI_VPROC) (GLenum target, GLuint index, GLfloat *data); }
{////typedef void (P PFNGLGETDOUBLEI_VPROC) (GLenum target, GLuint index, GLdouble *data); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glReleaseShaderCompiler;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glShaderBinary(count:TGLsizei; shaders:PGLuint; binaryFormat:TGLenum; binary:pointer; length:TGLsizei);cdecl;external;
procedure glGetShaderPrecisionFormat(shadertype:TGLenum; precisiontype:TGLenum; range:PGLint; precision:PGLint);cdecl;external;
procedure glDepthRangef(n:TGLfloat; f:TGLfloat);cdecl;external;
procedure glClearDepthf(d:TGLfloat);cdecl;external;
procedure glGetProgramBinary(program_:TGLuint; bufSize:TGLsizei; length:PGLsizei; binaryFormat:PGLenum; binary:pointer);cdecl;external;
(* Const before type ignored *)
procedure glProgramBinary(program_:TGLuint; binaryFormat:TGLenum; binary:pointer; length:TGLsizei);cdecl;external;
procedure glProgramParameteri(program_:TGLuint; pname:TGLenum; value:TGLint);cdecl;external;
procedure glUseProgramStages(pipeline:TGLuint; stages:TGLbitfield; program_:TGLuint);cdecl;external;
procedure glActiveShaderProgram(pipeline:TGLuint; program_:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
function glCreateShaderProgramv(_type:TGLenum; count:TGLsizei; strings:PPGLchar):TGLuint;cdecl;external;
procedure glBindProgramPipeline(pipeline:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteProgramPipelines(n:TGLsizei; pipelines:PGLuint);cdecl;external;
procedure glGenProgramPipelines(n:TGLsizei; pipelines:PGLuint);cdecl;external;
function glIsProgramPipeline(pipeline:TGLuint):TGLboolean;cdecl;external;
procedure glGetProgramPipelineiv(pipeline:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glProgramUniform1i(program_:TGLuint; location:TGLint; v0:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1iv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
procedure glProgramUniform1f(program_:TGLuint; location:TGLint; v0:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1fv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
procedure glProgramUniform1d(program_:TGLuint; location:TGLint; v0:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1dv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
procedure glProgramUniform1ui(program_:TGLuint; location:TGLint; v0:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1uiv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
procedure glProgramUniform2i(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2iv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
procedure glProgramUniform2f(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2fv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
procedure glProgramUniform2d(program_:TGLuint; location:TGLint; v0:TGLdouble; v1:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2dv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
procedure glProgramUniform2ui(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2uiv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
procedure glProgramUniform3i(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3iv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
procedure glProgramUniform3f(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3fv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
procedure glProgramUniform3d(program_:TGLuint; location:TGLint; v0:TGLdouble; v1:TGLdouble; v2:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3dv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
procedure glProgramUniform3ui(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3uiv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
procedure glProgramUniform4i(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; 
            v3:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4iv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
procedure glProgramUniform4f(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; 
            v3:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4fv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
procedure glProgramUniform4d(program_:TGLuint; location:TGLint; v0:TGLdouble; v1:TGLdouble; v2:TGLdouble; 
            v3:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4dv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
procedure glProgramUniform4ui(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; 
            v3:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4uiv(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x3fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x2fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x4fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x2fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x4fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x3fv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x3dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x2dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x4dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x2dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x4dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x3dv(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
procedure glValidateProgramPipeline(pipeline:TGLuint);cdecl;external;
procedure glGetProgramPipelineInfoLog(pipeline:TGLuint; bufSize:TGLsizei; length:PGLsizei; infoLog:PGLchar);cdecl;external;
procedure glVertexAttribL1d(index:TGLuint; x:TGLdouble);cdecl;external;
procedure glVertexAttribL2d(index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;external;
procedure glVertexAttribL3d(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glVertexAttribL4d(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL1dv(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL2dv(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL3dv(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL4dv(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribLPointer(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glGetVertexAttribLdv(index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glViewportArrayv(first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
procedure glViewportIndexedf(index:TGLuint; x:TGLfloat; y:TGLfloat; w:TGLfloat; h:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glViewportIndexedfv(index:TGLuint; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glScissorArrayv(first:TGLuint; count:TGLsizei; v:PGLint);cdecl;external;
procedure glScissorIndexed(index:TGLuint; left:TGLint; bottom:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glScissorIndexedv(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glDepthRangeArrayv(first:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
procedure glDepthRangeIndexed(index:TGLuint; n:TGLdouble; f:TGLdouble);cdecl;external;
procedure glGetFloati_v(target:TGLenum; index:TGLuint; data:PGLfloat);cdecl;external;
procedure glGetDoublei_v(target:TGLenum; index:TGLuint; data:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_1 */ }
{////#ifndef GL_VERSION_4_2 }
const
  GL_VERSION_4_2 = 1;  
  GL_COPY_READ_BUFFER_BINDING = $8F36;  
  GL_COPY_WRITE_BUFFER_BINDING = $8F37;  
  GL_TRANSFORM_FEEDBACK_ACTIVE = $8E24;  
  GL_TRANSFORM_FEEDBACK_PAUSED = $8E23;  
  GL_UNPACK_COMPRESSED_BLOCK_WIDTH = $9127;  
  GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = $9128;  
  GL_UNPACK_COMPRESSED_BLOCK_DEPTH = $9129;  
  GL_UNPACK_COMPRESSED_BLOCK_SIZE = $912A;  
  GL_PACK_COMPRESSED_BLOCK_WIDTH = $912B;  
  GL_PACK_COMPRESSED_BLOCK_HEIGHT = $912C;  
  GL_PACK_COMPRESSED_BLOCK_DEPTH = $912D;  
  GL_PACK_COMPRESSED_BLOCK_SIZE = $912E;  
  GL_NUM_SAMPLE_COUNTS = $9380;  
  GL_MIN_MAP_BUFFER_ALIGNMENT = $90BC;  
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
  GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = $92DC;  
  GL_ACTIVE_ATOMIC_COUNTER_BUFFERS = $92D9;  
  GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = $92DA;  
  GL_UNSIGNED_INT_ATOMIC_COUNTER = $92DB;  
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
  GL_ALL_BARRIER_BITS = $FFFFFFFF;  
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
  GL_COMPRESSED_RGBA_BPTC_UNORM = $8E8C;  
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = $8E8D;  
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = $8E8E;  
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = $8E8F;  
  GL_TEXTURE_IMMUTABLE_FORMAT = $912F;  
{////typedef void (P PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance); }
{////typedef void (P PFNGLGETINTERNALFORMATIVPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint *params); }
{////typedef void (P PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC) (GLuint program_, GLuint bufferIndex, GLenum pname, GLint *params); }
{////typedef void (P PFNGLBINDIMAGETEXTUREPROC) (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format); }
{////typedef void (P PFNGLMEMORYBARRIERPROC) (GLbitfield barriers); }
{////typedef void (P PFNGLTEXSTORAGE1DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width); }
{////typedef void (P PFNGLTEXSTORAGE2DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLTEXSTORAGE3DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth); }
{////typedef void (P PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC) (GLenum mode, GLuint id, GLsizei instancecount); }
{////typedef void (P PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC) (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawArraysInstancedBaseInstance(mode:TGLenum; first:TGLint; count:TGLsizei; instancecount:TGLsizei; baseinstance:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstancedBaseInstance(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei; 
            baseinstance:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstancedBaseVertexBaseInstance(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; instancecount:TGLsizei; 
            basevertex:TGLint; baseinstance:TGLuint);cdecl;external;
procedure glGetInternalformativ(target:TGLenum; internalformat:TGLenum; pname:TGLenum; count:TGLsizei; params:PGLint);cdecl;external;
procedure glGetActiveAtomicCounterBufferiv(program_:TGLuint; bufferIndex:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glBindImageTexture(unit_:TGLuint; texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; 
            access:TGLenum; format:TGLenum);cdecl;external;
procedure glMemoryBarrier(barriers:TGLbitfield);cdecl;external;
procedure glTexStorage1D(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;external;
procedure glTexStorage2D(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glTexStorage3D(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei);cdecl;external;
procedure glDrawTransformFeedbackInstanced(mode:TGLenum; id:TGLuint; instancecount:TGLsizei);cdecl;external;
procedure glDrawTransformFeedbackStreamInstanced(mode:TGLenum; id:TGLuint; stream:TGLuint; instancecount:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_2 */ }
{////#ifndef GL_VERSION_4_3 }
const
  GL_VERSION_4_3 = 1;  
(* Const before type ignored *)
(* Const before type ignored *)
type

  TGLDEBUGPROC = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei; 
                message:PGLchar; userParam:pointer);cdecl;

const
  GL_NUM_SHADING_LANGUAGE_VERSIONS = $82E9;  
  GL_VERTEX_ATTRIB_ARRAY_LONG = $874E;  
  GL_COMPRESSED_RGB8_ETC2 = $9274;  
  GL_COMPRESSED_SRGB8_ETC2 = $9275;  
  GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9276;  
  GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9277;  
  GL_COMPRESSED_RGBA8_ETC2_EAC = $9278;  
  GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = $9279;  
  GL_COMPRESSED_R11_EAC = $9270;  
  GL_COMPRESSED_SIGNED_R11_EAC = $9271;  
  GL_COMPRESSED_RG11_EAC = $9272;  
  GL_COMPRESSED_SIGNED_RG11_EAC = $9273;  
  GL_PRIMITIVE_RESTART_FIXED_INDEX = $8D69;  
  GL_ANY_SAMPLES_PASSED_CONSERVATIVE = $8D6A;  
  GL_MAX_ELEMENT_INDEX = $8D6B;  
  GL_COMPUTE_SHADER = $91B9;  
  GL_MAX_COMPUTE_UNIFORM_BLOCKS = $91BB;  
  GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = $91BC;  
  GL_MAX_COMPUTE_IMAGE_UNIFORMS = $91BD;  
  GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = $8262;  
  GL_MAX_COMPUTE_UNIFORM_COMPONENTS = $8263;  
  GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = $8264;  
  GL_MAX_COMPUTE_ATOMIC_COUNTERS = $8265;  
  GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = $8266;  
  GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = $90EB;  
  GL_MAX_COMPUTE_WORK_GROUP_COUNT = $91BE;  
  GL_MAX_COMPUTE_WORK_GROUP_SIZE = $91BF;  
  GL_COMPUTE_WORK_GROUP_SIZE = $8267;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = $90EC;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = $90ED;  
  GL_DISPATCH_INDIRECT_BUFFER = $90EE;  
  GL_DISPATCH_INDIRECT_BUFFER_BINDING = $90EF;  
  GL_COMPUTE_SHADER_BIT = $00000020;  
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
  GL_MAX_DEBUG_MESSAGE_LENGTH = $9143;  
  GL_MAX_DEBUG_LOGGED_MESSAGES = $9144;  
  GL_DEBUG_LOGGED_MESSAGES = $9145;  
  GL_DEBUG_SEVERITY_HIGH = $9146;  
  GL_DEBUG_SEVERITY_MEDIUM = $9147;  
  GL_DEBUG_SEVERITY_LOW = $9148;  
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
  GL_MAX_LABEL_LENGTH = $82E8;  
  GL_DEBUG_OUTPUT = $92E0;  
  GL_CONTEXT_FLAG_DEBUG_BIT = $00000002;  
  GL_MAX_UNIFORM_LOCATIONS = $826E;  
  GL_FRAMEBUFFER_DEFAULT_WIDTH = $9310;  
  GL_FRAMEBUFFER_DEFAULT_HEIGHT = $9311;  
  GL_FRAMEBUFFER_DEFAULT_LAYERS = $9312;  
  GL_FRAMEBUFFER_DEFAULT_SAMPLES = $9313;  
  GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = $9314;  
  GL_MAX_FRAMEBUFFER_WIDTH = $9315;  
  GL_MAX_FRAMEBUFFER_HEIGHT = $9316;  
  GL_MAX_FRAMEBUFFER_LAYERS = $9317;  
  GL_MAX_FRAMEBUFFER_SAMPLES = $9318;  
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
  GL_UNIFORM = $92E1;  
  GL_UNIFORM_BLOCK = $92E2;  
  GL_PROGRAM_INPUT = $92E3;  
  GL_PROGRAM_OUTPUT = $92E4;  
  GL_BUFFER_VARIABLE = $92E5;  
  GL_SHADER_STORAGE_BLOCK = $92E6;  
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
  GL_IS_PER_PATCH = $92E7;  
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
  GL_SHADER_STORAGE_BARRIER_BIT = $00002000;  
  GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = $8F39;  
  GL_DEPTH_STENCIL_TEXTURE_MODE = $90EA;  
  GL_TEXTURE_BUFFER_OFFSET = $919D;  
  GL_TEXTURE_BUFFER_SIZE = $919E;  
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = $919F;  
  GL_TEXTURE_VIEW_MIN_LEVEL = $82DB;  
  GL_TEXTURE_VIEW_NUM_LEVELS = $82DC;  
  GL_TEXTURE_VIEW_MIN_LAYER = $82DD;  
  GL_TEXTURE_VIEW_NUM_LAYERS = $82DE;  
  GL_TEXTURE_IMMUTABLE_LEVELS = $82DF;  
  GL_VERTEX_ATTRIB_BINDING = $82D4;  
  GL_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D5;  
  GL_VERTEX_BINDING_DIVISOR = $82D6;  
  GL_VERTEX_BINDING_OFFSET = $82D7;  
  GL_VERTEX_BINDING_STRIDE = $82D8;  
  GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D9;  
  GL_MAX_VERTEX_ATTRIB_BINDINGS = $82DA;  
  GL_VERTEX_BINDING_BUFFER = $8F4F;  
  GL_DISPLAY_LIST = $82E7;  
{////typedef void (P PFNGLCLEARBUFFERDATAPROC) (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCLEARBUFFERSUBDATAPROC) (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLDISPATCHCOMPUTEPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z); }
{////typedef void (P PFNGLDISPATCHCOMPUTEINDIRECTPROC) (GLintptr indirect); }
{////typedef void (P PFNGLCOPYIMAGESUBDATAPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth); }
{////typedef void (P PFNGLFRAMEBUFFERPARAMETERIPROC) (GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLGETFRAMEBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETINTERNALFORMATI64VPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint64 *params); }
{////typedef void (P PFNGLINVALIDATETEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth); }
{////typedef void (P PFNGLINVALIDATETEXIMAGEPROC) (GLuint texture, GLint level); }
{////typedef void (P PFNGLINVALIDATEBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length); }
{////typedef void (P PFNGLINVALIDATEBUFFERDATAPROC) (GLuint buffer); }
{////typedef void (P PFNGLINVALIDATEFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments); }
{////typedef void (P PFNGLINVALIDATESUBFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride); }
{////typedef void (P PFNGLGETPROGRAMINTERFACEIVPROC) (GLuint program_, GLenum programInterface, GLenum pname, GLint *params); }
{////typedef GLuint (P PFNGLGETPROGRAMRESOURCEINDEXPROC) (GLuint program_, GLenum programInterface, const GLchar *name); }
{////typedef void (P PFNGLGETPROGRAMRESOURCENAMEPROC) (GLuint program_, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name); }
{////typedef void (P PFNGLGETPROGRAMRESOURCEIVPROC) (GLuint program_, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLint *params); }
{////typedef GLint (P PFNGLGETPROGRAMRESOURCELOCATIONPROC) (GLuint program_, GLenum programInterface, const GLchar *name); }
{////typedef GLint (P PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC) (GLuint program_, GLenum programInterface, const GLchar *name); }
{////typedef void (P PFNGLSHADERSTORAGEBLOCKBINDINGPROC) (GLuint program_, GLuint storageBlockIndex, GLuint storageBlockBinding); }
{////typedef void (P PFNGLTEXBUFFERRANGEPROC) (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLTEXSTORAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXSTORAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXTUREVIEWPROC) (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers); }
{////typedef void (P PFNGLBINDVERTEXBUFFERPROC) (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride); }
{////typedef void (P PFNGLVERTEXATTRIBFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXATTRIBIFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXATTRIBLFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXATTRIBBINDINGPROC) (GLuint attribindex, GLuint bindingindex); }
{////typedef void (P PFNGLVERTEXBINDINGDIVISORPROC) (GLuint bindingindex, GLuint divisor); }
{////typedef void (P PFNGLDEBUGMESSAGECONTROLPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled); }
{////typedef void (P PFNGLDEBUGMESSAGEINSERTPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf); }
{////typedef void (P PFNGLDEBUGMESSAGECALLBACKPROC) (GLDEBUGPROC callback, const void *userParam); }
{////typedef GLuint (P PFNGLGETDEBUGMESSAGELOGPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog); }
{////typedef void (P PFNGLPUSHDEBUGGROUPPROC) (GLenum source, GLuint id, GLsizei length, const GLchar *message); }
{////typedef void (P PFNGLPOPDEBUGGROUPPROC) (void); }
{////typedef void (P PFNGLOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei length, const GLchar *label); }
{////typedef void (P PFNGLGETOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label); }
{////typedef void (P PFNGLOBJECTPTRLABELPROC) (const void *ptr, GLsizei length, const GLchar *label); }
{////typedef void (P PFNGLGETOBJECTPTRLABELPROC) (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glClearBufferData(target:TGLenum; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glClearBufferSubData(target:TGLenum; internalformat:TGLenum; offset:TGLintptr; size:TGLsizeiptr; format:TGLenum; 
            _type:TGLenum; data:pointer);cdecl;external;
procedure glDispatchCompute(num_groups_x:TGLuint; num_groups_y:TGLuint; num_groups_z:TGLuint);cdecl;external;
procedure glDispatchComputeIndirect(indirect:TGLintptr);cdecl;external;
procedure glCopyImageSubData(srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint; 
            srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
            dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;external;
procedure glFramebufferParameteri(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
procedure glGetFramebufferParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetInternalformati64v(target:TGLenum; internalformat:TGLenum; pname:TGLenum; count:TGLsizei; params:PGLint64);cdecl;external;
procedure glInvalidateTexSubImage(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei);cdecl;external;
procedure glInvalidateTexImage(texture:TGLuint; level:TGLint);cdecl;external;
procedure glInvalidateBufferSubData(buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;external;
procedure glInvalidateBufferData(buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glInvalidateFramebuffer(target:TGLenum; numAttachments:TGLsizei; attachments:PGLenum);cdecl;external;
(* Const before type ignored *)
procedure glInvalidateSubFramebuffer(target:TGLenum; numAttachments:TGLsizei; attachments:PGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; height:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawArraysIndirect(mode:TGLenum; indirect:pointer; drawcount:TGLsizei; stride:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirect(mode:TGLenum; _type:TGLenum; indirect:pointer; drawcount:TGLsizei; stride:TGLsizei);cdecl;external;
procedure glGetProgramInterfaceiv(program_:TGLuint; programInterface:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
function glGetProgramResourceIndex(program_:TGLuint; programInterface:TGLenum; name:PGLchar):TGLuint;cdecl;external;
procedure glGetProgramResourceName(program_:TGLuint; programInterface:TGLenum; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; 
            name:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glGetProgramResourceiv(program_:TGLuint; programInterface:TGLenum; index:TGLuint; propCount:TGLsizei; props:PGLenum; 
            count:TGLsizei; length:PGLsizei; params:PGLint);cdecl;external;
(* Const before type ignored *)
function glGetProgramResourceLocation(program_:TGLuint; programInterface:TGLenum; name:PGLchar):TGLint;cdecl;external;
(* Const before type ignored *)
function glGetProgramResourceLocationIndex(program_:TGLuint; programInterface:TGLenum; name:PGLchar):TGLint;cdecl;external;
procedure glShaderStorageBlockBinding(program_:TGLuint; storageBlockIndex:TGLuint; storageBlockBinding:TGLuint);cdecl;external;
procedure glTexBufferRange(target:TGLenum; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glTexStorage2DMultisample(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            fixedsamplelocations:TGLboolean);cdecl;external;
procedure glTexStorage3DMultisample(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;external;
procedure glTextureView(texture:TGLuint; target:TGLenum; origtexture:TGLuint; internalformat:TGLenum; minlevel:TGLuint; 
            numlevels:TGLuint; minlayer:TGLuint; numlayers:TGLuint);cdecl;external;
procedure glBindVertexBuffer(bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;external;
procedure glVertexAttribFormat(attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; relativeoffset:TGLuint);cdecl;external;
procedure glVertexAttribIFormat(attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexAttribLFormat(attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexAttribBinding(attribindex:TGLuint; bindingindex:TGLuint);cdecl;external;
procedure glVertexBindingDivisor(bindingindex:TGLuint; divisor:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageControl(source:TGLenum; _type:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint; 
            enabled:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageInsert(source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei; 
            buf:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageCallback(callback:TGLDEBUGPROC; userParam:pointer);cdecl;external;
function glGetDebugMessageLog(count:TGLuint; bufSize:TGLsizei; sources:PGLenum; types:PGLenum; ids:PGLuint; 
           severities:PGLenum; lengths:PGLsizei; messageLog:PGLchar):TGLuint;cdecl;external;
(* Const before type ignored *)
procedure glPushDebugGroup(source:TGLenum; id:TGLuint; length:TGLsizei; message:PGLchar);cdecl;external;
procedure glPopDebugGroup;cdecl;external;
(* Const before type ignored *)
procedure glObjectLabel(identifier:TGLenum; name:TGLuint; length:TGLsizei; _label:PGLchar);cdecl;external;
procedure glGetObjectLabel(identifier:TGLenum; name:TGLuint; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glObjectPtrLabel(ptr:pointer; length:TGLsizei; _label:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glGetObjectPtrLabel(ptr:pointer; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_3 */ }
{////#ifndef GL_VERSION_4_4 }
const
  GL_VERSION_4_4 = 1;  
  GL_MAX_VERTEX_ATTRIB_STRIDE = $82E5;  
  GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221;  
  GL_TEXTURE_BUFFER_BINDING = $8C2A;  
  GL_MAP_PERSISTENT_BIT = $0040;  
  GL_MAP_COHERENT_BIT = $0080;  
  GL_DYNAMIC_STORAGE_BIT = $0100;  
  GL_CLIENT_STORAGE_BIT = $0200;  
  GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = $00004000;  
  GL_BUFFER_IMMUTABLE_STORAGE = $821F;  
  GL_BUFFER_STORAGE_FLAGS = $8220;  
  GL_CLEAR_TEXTURE = $9365;  
  GL_LOCATION_COMPONENT = $934A;  
  GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = $934B;  
  GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = $934C;  
  GL_QUERY_BUFFER = $9192;  
  GL_QUERY_BUFFER_BARRIER_BIT = $00008000;  
  GL_QUERY_BUFFER_BINDING = $9193;  
  GL_QUERY_RESULT_NO_WAIT = $9194;  
  GL_MIRROR_CLAMP_TO_EDGE = $8743;  
{////typedef void (P PFNGLBUFFERSTORAGEPROC) (GLenum target, GLsizeiptr size, const void *data, GLbitfield flags); }
{////typedef void (P PFNGLCLEARTEXIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCLEARTEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLBINDBUFFERSBASEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers); }
{////typedef void (P PFNGLBINDBUFFERSRANGEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizeiptr *sizes); }
{////typedef void (P PFNGLBINDTEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures); }
{////typedef void (P PFNGLBINDSAMPLERSPROC) (GLuint first, GLsizei count, const GLuint *samplers); }
{////typedef void (P PFNGLBINDIMAGETEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures); }
{////typedef void (P PFNGLBINDVERTEXBUFFERSPROC) (GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glBufferStorage(target:TGLenum; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;external;
(* Const before type ignored *)
procedure glClearTexImage(texture:TGLuint; level:TGLint; format:TGLenum; _type:TGLenum; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glClearTexSubImage(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
            data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glBindBuffersBase(target:TGLenum; first:TGLuint; count:TGLsizei; buffers:PGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glBindBuffersRange(target:TGLenum; first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr; 
            sizes:PGLsizeiptr);cdecl;external;
(* Const before type ignored *)
procedure glBindTextures(first:TGLuint; count:TGLsizei; textures:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glBindSamplers(first:TGLuint; count:TGLsizei; samplers:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glBindImageTextures(first:TGLuint; count:TGLsizei; textures:PGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glBindVertexBuffers(first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr; strides:PGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_4 */ }
{////#ifndef GL_VERSION_4_5 }
const
  GL_VERSION_4_5 = 1;  
  GL_CONTEXT_LOST = $0507;  
  GL_NEGATIVE_ONE_TO_ONE = $935E;  
  GL_ZERO_TO_ONE = $935F;  
  GL_CLIP_ORIGIN = $935C;  
  GL_CLIP_DEPTH_MODE = $935D;  
  GL_QUERY_WAIT_INVERTED = $8E17;  
  GL_QUERY_NO_WAIT_INVERTED = $8E18;  
  GL_QUERY_BY_REGION_WAIT_INVERTED = $8E19;  
  GL_QUERY_BY_REGION_NO_WAIT_INVERTED = $8E1A;  
  GL_MAX_CULL_DISTANCES = $82F9;  
  GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = $82FA;  
  GL_TEXTURE_TARGET = $1006;  
  GL_QUERY_TARGET = $82EA;  
  GL_GUILTY_CONTEXT_RESET = $8253;  
  GL_INNOCENT_CONTEXT_RESET = $8254;  
  GL_UNKNOWN_CONTEXT_RESET = $8255;  
  GL_RESET_NOTIFICATION_STRATEGY = $8256;  
  GL_LOSE_CONTEXT_ON_RESET = $8252;  
  GL_NO_RESET_NOTIFICATION = $8261;  
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = $00000004;  
  GL_COLOR_TABLE = $80D0;  
  GL_POST_CONVOLUTION_COLOR_TABLE = $80D1;  
  GL_POST_COLOR_MATRIX_COLOR_TABLE = $80D2;  
  GL_PROXY_COLOR_TABLE = $80D3;  
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = $80D4;  
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = $80D5;  
  GL_CONVOLUTION_1D = $8010;  
  GL_CONVOLUTION_2D = $8011;  
  GL_SEPARABLE_2D = $8012;  
  GL_HISTOGRAM = $8024;  
  GL_PROXY_HISTOGRAM = $8025;  
  GL_MINMAX = $802E;  
  GL_CONTEXT_RELEASE_BEHAVIOR = $82FB;  
  GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = $82FC;  
{////typedef void (P PFNGLCLIPCONTROLPROC) (GLenum origin, GLenum depth); }
{////typedef void (P PFNGLCREATETRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC) (GLuint xfb, GLuint index, GLuint buffer); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC) (GLuint xfb, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKIVPROC) (GLuint xfb, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKI_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint *param); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKI64_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint64 *param); }
{////typedef void (P PFNGLCREATEBUFFERSPROC) (GLsizei n, GLuint *buffers); }
{////typedef void (P PFNGLNAMEDBUFFERSTORAGEPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags); }
{////typedef void (P PFNGLNAMEDBUFFERDATAPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage); }
{////typedef void (P PFNGLNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data); }
{////typedef void (P PFNGLCOPYNAMEDBUFFERSUBDATAPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size); }
{////typedef void (P PFNGLCLEARNAMEDBUFFERDATAPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCLEARNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data); }
{////typedef void *(P PFNGLMAPNAMEDBUFFERPROC) (GLuint buffer, GLenum access); }
{////typedef void *(P PFNGLMAPNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access); }
{////typedef GLboolean (P PFNGLUNMAPNAMEDBUFFERPROC) (GLuint buffer); }
{////typedef void (P PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length); }
{////typedef void (P PFNGLGETNAMEDBUFFERPARAMETERIVPROC) (GLuint buffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETNAMEDBUFFERPARAMETERI64VPROC) (GLuint buffer, GLenum pname, GLint64 *params); }
{////typedef void (P PFNGLGETNAMEDBUFFERPOINTERVPROC) (GLuint buffer, GLenum pname, void **params); }
{////typedef void (P PFNGLGETNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data); }
{////typedef void (P PFNGLCREATEFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC) (GLuint framebuffer, GLenum pname, GLint param); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTUREPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC) (GLuint framebuffer, GLenum buf); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC) (GLuint framebuffer, GLenum src); }
{////typedef void (P PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments); }
{////typedef void (P PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLCLEARNAMEDFRAMEBUFFERIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLint *value); }
{////typedef void (P PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLuint *value); }
{////typedef void (P PFNGLCLEARNAMEDFRAMEBUFFERFVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLfloat *value); }
{////typedef void (P PFNGLCLEARNAMEDFRAMEBUFFERFIPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil); }
{////typedef void (P PFNGLBLITNAMEDFRAMEBUFFERPROC) (GLuint readFramebuffer, GLuint drawFramebuffer, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter); }
{////typedef GLenum (P PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC) (GLuint framebuffer, GLenum target); }
{////typedef void (P PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC) (GLuint framebuffer, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params); }
{////typedef void (P PFNGLCREATERENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC) (GLuint renderbuffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLCREATETEXTURESPROC) (GLenum target, GLsizei n, GLuint *textures); }
{////typedef void (P PFNGLTEXTUREBUFFERPROC) (GLuint texture, GLenum internalformat, GLuint buffer); }
{////typedef void (P PFNGLTEXTUREBUFFERRANGEPROC) (GLuint texture, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLTEXTURESTORAGE1DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width); }
{////typedef void (P PFNGLTEXTURESTORAGE2DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLTEXTURESTORAGE3DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth); }
{////typedef void (P PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLTEXTUREPARAMETERFPROC) (GLuint texture, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, const GLfloat *param); }
{////typedef void (P PFNGLTEXTUREPARAMETERIPROC) (GLuint texture, GLenum pname, GLint param); }
{////typedef void (P PFNGLTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, const GLuint *params); }
{////typedef void (P PFNGLTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, const GLint *param); }
{////typedef void (P PFNGLGENERATETEXTUREMIPMAPPROC) (GLuint texture); }
{////typedef void (P PFNGLBINDTEXTUREUNITPROC) (GLuint unit, GLuint texture); }
{////typedef void (P PFNGLGETTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels); }
{////typedef void (P PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLsizei bufSize, void *pixels); }
{////typedef void (P PFNGLGETTEXTURELEVELPARAMETERFVPROC) (GLuint texture, GLint level, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETTEXTURELEVELPARAMETERIVPROC) (GLuint texture, GLint level, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, GLint *params); }
{////typedef void (P PFNGLCREATEVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays); }
{////typedef void (P PFNGLDISABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index); }
{////typedef void (P PFNGLENABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index); }
{////typedef void (P PFNGLVERTEXARRAYELEMENTBUFFERPROC) (GLuint vaobj, GLuint buffer); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXBUFFERPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXBUFFERSPROC) (GLuint vaobj, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides); }
{////typedef void (P PFNGLVERTEXARRAYATTRIBBINDINGPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex); }
{////typedef void (P PFNGLVERTEXARRAYATTRIBFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYATTRIBIFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYATTRIBLFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYBINDINGDIVISORPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor); }
{////typedef void (P PFNGLGETVERTEXARRAYIVPROC) (GLuint vaobj, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETVERTEXARRAYINDEXEDIVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETVERTEXARRAYINDEXED64IVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint64 *param); }
{////typedef void (P PFNGLCREATESAMPLERSPROC) (GLsizei n, GLuint *samplers); }
{////typedef void (P PFNGLCREATEPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines); }
{////typedef void (P PFNGLCREATEQUERIESPROC) (GLenum target, GLsizei n, GLuint *ids); }
{////typedef void (P PFNGLGETQUERYBUFFEROBJECTI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset); }
{////typedef void (P PFNGLGETQUERYBUFFEROBJECTIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset); }
{////typedef void (P PFNGLGETQUERYBUFFEROBJECTUI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset); }
{////typedef void (P PFNGLGETQUERYBUFFEROBJECTUIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset); }
{////typedef void (P PFNGLMEMORYBARRIERBYREGIONPROC) (GLbitfield barriers); }
{////typedef void (P PFNGLGETTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLsizei bufSize, void *pixels); }
{////typedef void (P PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei bufSize, void *pixels); }
{////typedef GLenum (P PFNGLGETGRAPHICSRESETSTATUSPROC) (void); }
{////typedef void (P PFNGLGETNCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint lod, GLsizei bufSize, void *pixels); }
{////typedef void (P PFNGLGETNTEXIMAGEPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels); }
{////typedef void (P PFNGLGETNUNIFORMDVPROC) (GLuint program_, GLint location, GLsizei bufSize, GLdouble *params); }
{////typedef void (P PFNGLGETNUNIFORMFVPROC) (GLuint program_, GLint location, GLsizei bufSize, GLfloat *params); }
{////typedef void (P PFNGLGETNUNIFORMIVPROC) (GLuint program_, GLint location, GLsizei bufSize, GLint *params); }
{////typedef void (P PFNGLGETNUNIFORMUIVPROC) (GLuint program_, GLint location, GLsizei bufSize, GLuint *params); }
{////typedef void (P PFNGLREADNPIXELSPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data); }
{////typedef void (P PFNGLGETNMAPDVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v); }
{////typedef void (P PFNGLGETNMAPFVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v); }
{////typedef void (P PFNGLGETNMAPIVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLint *v); }
{////typedef void (P PFNGLGETNPIXELMAPFVPROC) (GLenum map, GLsizei bufSize, GLfloat *values); }
{////typedef void (P PFNGLGETNPIXELMAPUIVPROC) (GLenum map, GLsizei bufSize, GLuint *values); }
{////typedef void (P PFNGLGETNPIXELMAPUSVPROC) (GLenum map, GLsizei bufSize, GLushort *values); }
{////typedef void (P PFNGLGETNPOLYGONSTIPPLEPROC) (GLsizei bufSize, GLubyte *pattern); }
{////typedef void (P PFNGLGETNCOLORTABLEPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table); }
{////typedef void (P PFNGLGETNCONVOLUTIONFILTERPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image); }
{////typedef void (P PFNGLGETNSEPARABLEFILTERPROC) (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span); }
{////typedef void (P PFNGLGETNHISTOGRAMPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values); }
{////typedef void (P PFNGLGETNMINMAXPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values); }
{////typedef void (P PFNGLTEXTUREBARRIERPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glClipControl(origin:TGLenum; depth:TGLenum);cdecl;external;
procedure glCreateTransformFeedbacks(n:TGLsizei; ids:PGLuint);cdecl;external;
procedure glTransformFeedbackBufferBase(xfb:TGLuint; index:TGLuint; buffer:TGLuint);cdecl;external;
procedure glTransformFeedbackBufferRange(xfb:TGLuint; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glGetTransformFeedbackiv(xfb:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetTransformFeedbacki_v(xfb:TGLuint; pname:TGLenum; index:TGLuint; param:PGLint);cdecl;external;
procedure glGetTransformFeedbacki64_v(xfb:TGLuint; pname:TGLenum; index:TGLuint; param:PGLint64);cdecl;external;
procedure glCreateBuffers(n:TGLsizei; buffers:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferStorage(buffer:TGLuint; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferData(buffer:TGLuint; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferSubData(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glCopyNamedBufferSubData(readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedBufferData(buffer:TGLuint; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedBufferSubData(buffer:TGLuint; internalformat:TGLenum; offset:TGLintptr; size:TGLsizeiptr; format:TGLenum; 
            _type:TGLenum; data:pointer);cdecl;external;
function glMapNamedBuffer(buffer:TGLuint; access:TGLenum):pointer;cdecl;external;
function glMapNamedBufferRange(buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;external;
function glUnmapNamedBuffer(buffer:TGLuint):TGLboolean;cdecl;external;
procedure glFlushMappedNamedBufferRange(buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;external;
procedure glGetNamedBufferParameteriv(buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetNamedBufferParameteri64v(buffer:TGLuint; pname:TGLenum; params:PGLint64);cdecl;external;
procedure glGetNamedBufferPointerv(buffer:TGLuint; pname:TGLenum; params:Ppointer);cdecl;external;
procedure glGetNamedBufferSubData(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glCreateFramebuffers(n:TGLsizei; framebuffers:PGLuint);cdecl;external;
procedure glNamedFramebufferRenderbuffer(framebuffer:TGLuint; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glNamedFramebufferParameteri(framebuffer:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
procedure glNamedFramebufferTexture(framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glNamedFramebufferTextureLayer(framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;external;
procedure glNamedFramebufferDrawBuffer(framebuffer:TGLuint; buf:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glNamedFramebufferDrawBuffers(framebuffer:TGLuint; n:TGLsizei; bufs:PGLenum);cdecl;external;
procedure glNamedFramebufferReadBuffer(framebuffer:TGLuint; src:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glInvalidateNamedFramebufferData(framebuffer:TGLuint; numAttachments:TGLsizei; attachments:PGLenum);cdecl;external;
(* Const before type ignored *)
procedure glInvalidateNamedFramebufferSubData(framebuffer:TGLuint; numAttachments:TGLsizei; attachments:PGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; height:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedFramebufferiv(framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedFramebufferuiv(framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedFramebufferfv(framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; value:PGLfloat);cdecl;external;
procedure glClearNamedFramebufferfi(framebuffer:TGLuint; buffer:TGLenum; drawbuffer:TGLint; depth:TGLfloat; stencil:TGLint);cdecl;external;
procedure glBlitNamedFramebuffer(readFramebuffer:TGLuint; drawFramebuffer:TGLuint; srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; 
            srcY1:TGLint; dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; 
            mask:TGLbitfield; filter:TGLenum);cdecl;external;
function glCheckNamedFramebufferStatus(framebuffer:TGLuint; target:TGLenum):TGLenum;cdecl;external;
procedure glGetNamedFramebufferParameteriv(framebuffer:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetNamedFramebufferAttachmentParameteriv(framebuffer:TGLuint; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCreateRenderbuffers(n:TGLsizei; renderbuffers:PGLuint);cdecl;external;
procedure glNamedRenderbufferStorage(renderbuffer:TGLuint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glNamedRenderbufferStorageMultisample(renderbuffer:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetNamedRenderbufferParameteriv(renderbuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCreateTextures(target:TGLenum; n:TGLsizei; textures:PGLuint);cdecl;external;
procedure glTextureBuffer(texture:TGLuint; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
procedure glTextureBufferRange(texture:TGLuint; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glTextureStorage1D(texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;external;
procedure glTextureStorage2D(texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glTextureStorage3D(texture:TGLuint; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei);cdecl;external;
procedure glTextureStorage2DMultisample(texture:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            fixedsamplelocations:TGLboolean);cdecl;external;
procedure glTextureStorage3DMultisample(texture:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage1D(texture:TGLuint; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage2D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage3D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage1D(texture:TGLuint; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage2D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage3D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
            data:pointer);cdecl;external;
procedure glCopyTextureSubImage1D(texture:TGLuint; level:TGLint; xoffset:TGLint; x:TGLint; y:TGLint; 
            width:TGLsizei);cdecl;external;
procedure glCopyTextureSubImage2D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; x:TGLint; 
            y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glCopyTextureSubImage3D(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glTextureParameterf(texture:TGLuint; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterfv(texture:TGLuint; pname:TGLenum; param:PGLfloat);cdecl;external;
procedure glTextureParameteri(texture:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterIiv(texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterIuiv(texture:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameteriv(texture:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGenerateTextureMipmap(texture:TGLuint);cdecl;external;
procedure glBindTextureUnit(unit_:TGLuint; texture:TGLuint);cdecl;external;
procedure glGetTextureImage(texture:TGLuint; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            pixels:pointer);cdecl;external;
procedure glGetCompressedTextureImage(texture:TGLuint; level:TGLint; bufSize:TGLsizei; pixels:pointer);cdecl;external;
procedure glGetTextureLevelParameterfv(texture:TGLuint; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetTextureLevelParameteriv(texture:TGLuint; level:TGLint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTextureParameterfv(texture:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetTextureParameterIiv(texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTextureParameterIuiv(texture:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetTextureParameteriv(texture:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCreateVertexArrays(n:TGLsizei; arrays:PGLuint);cdecl;external;
procedure glDisableVertexArrayAttrib(vaobj:TGLuint; index:TGLuint);cdecl;external;
procedure glEnableVertexArrayAttrib(vaobj:TGLuint; index:TGLuint);cdecl;external;
procedure glVertexArrayElementBuffer(vaobj:TGLuint; buffer:TGLuint);cdecl;external;
procedure glVertexArrayVertexBuffer(vaobj:TGLuint; bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glVertexArrayVertexBuffers(vaobj:TGLuint; first:TGLuint; count:TGLsizei; buffers:PGLuint; offsets:PGLintptr; 
            strides:PGLsizei);cdecl;external;
procedure glVertexArrayAttribBinding(vaobj:TGLuint; attribindex:TGLuint; bindingindex:TGLuint);cdecl;external;
procedure glVertexArrayAttribFormat(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; 
            relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayAttribIFormat(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayAttribLFormat(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayBindingDivisor(vaobj:TGLuint; bindingindex:TGLuint; divisor:TGLuint);cdecl;external;
procedure glGetVertexArrayiv(vaobj:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetVertexArrayIndexediv(vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetVertexArrayIndexed64iv(vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint64);cdecl;external;
procedure glCreateSamplers(n:TGLsizei; samplers:PGLuint);cdecl;external;
procedure glCreateProgramPipelines(n:TGLsizei; pipelines:PGLuint);cdecl;external;
procedure glCreateQueries(target:TGLenum; n:TGLsizei; ids:PGLuint);cdecl;external;
procedure glGetQueryBufferObjecti64v(id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;external;
procedure glGetQueryBufferObjectiv(id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;external;
procedure glGetQueryBufferObjectui64v(id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;external;
procedure glGetQueryBufferObjectuiv(id:TGLuint; buffer:TGLuint; pname:TGLenum; offset:TGLintptr);cdecl;external;
procedure glMemoryBarrierByRegion(barriers:TGLbitfield);cdecl;external;
procedure glGetTextureSubImage(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
            bufSize:TGLsizei; pixels:pointer);cdecl;external;
procedure glGetCompressedTextureSubImage(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; bufSize:TGLsizei; pixels:pointer);cdecl;external;
function glGetGraphicsResetStatus:TGLenum;cdecl;external;
procedure glGetnCompressedTexImage(target:TGLenum; lod:TGLint; bufSize:TGLsizei; pixels:pointer);cdecl;external;
procedure glGetnTexImage(target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            pixels:pointer);cdecl;external;
procedure glGetnUniformdv(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLdouble);cdecl;external;
procedure glGetnUniformfv(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLfloat);cdecl;external;
procedure glGetnUniformiv(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint);cdecl;external;
procedure glGetnUniformuiv(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint);cdecl;external;
procedure glReadnPixels(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; bufSize:TGLsizei; data:pointer);cdecl;external;
procedure glGetnMapdv(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLdouble);cdecl;external;
procedure glGetnMapfv(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLfloat);cdecl;external;
procedure glGetnMapiv(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLint);cdecl;external;
procedure glGetnPixelMapfv(map:TGLenum; bufSize:TGLsizei; values:PGLfloat);cdecl;external;
procedure glGetnPixelMapuiv(map:TGLenum; bufSize:TGLsizei; values:PGLuint);cdecl;external;
procedure glGetnPixelMapusv(map:TGLenum; bufSize:TGLsizei; values:PGLushort);cdecl;external;
procedure glGetnPolygonStipple(bufSize:TGLsizei; pattern:PGLubyte);cdecl;external;
procedure glGetnColorTable(target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; table:pointer);cdecl;external;
procedure glGetnConvolutionFilter(target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; image:pointer);cdecl;external;
procedure glGetnSeparableFilter(target:TGLenum; format:TGLenum; _type:TGLenum; rowBufSize:TGLsizei; row:pointer; 
            columnBufSize:TGLsizei; column:pointer; span:pointer);cdecl;external;
procedure glGetnHistogram(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            values:pointer);cdecl;external;
procedure glGetnMinmax(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            values:pointer);cdecl;external;
procedure glTextureBarrier;cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_5 */ }
{////#ifndef GL_VERSION_4_6 }
const
  GL_VERSION_4_6 = 1;  
  GL_SHADER_BINARY_FORMAT_SPIR_V = $9551;  
  GL_SPIR_V_BINARY = $9552;  
  GL_PARAMETER_BUFFER = $80EE;  
  GL_PARAMETER_BUFFER_BINDING = $80EF;  
  GL_CONTEXT_FLAG_NO_ERROR_BIT = $00000008;  
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
  GL_POLYGON_OFFSET_CLAMP = $8E1B;  
  GL_SPIR_V_EXTENSIONS = $9553;  
  GL_NUM_SPIR_V_EXTENSIONS = $9554;  
  GL_TEXTURE_MAX_ANISOTROPY = $84FE;  
  GL_MAX_TEXTURE_MAX_ANISOTROPY = $84FF;  
  GL_TRANSFORM_FEEDBACK_OVERFLOW = $82EC;  
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW = $82ED;  
{////typedef void (P PFNGLSPECIALIZESHADERPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue); }
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride); }
{////typedef void (P PFNGLPOLYGONOFFSETCLAMPPROC) (GLfloat factor, GLfloat units, GLfloat clamp); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

procedure glSpecializeShader(shader:TGLuint; pEntryPoint:PGLchar; numSpecializationConstants:TGLuint; pConstantIndex:PGLuint; pConstantValue:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawArraysIndirectCount(mode:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirectCount(mode:TGLenum; _type:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei; 
            stride:TGLsizei);cdecl;external;
procedure glPolygonOffsetClamp(factor:TGLfloat; units:TGLfloat; clamp:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_VERSION_4_6 */ }
{////#ifndef GL_ARB_ES2_compatibility }
const
  GL_ARB_ES2_compatibility = 1;  
{////#endif /* GL_ARB_ES2_compatibility */ }
{////#ifndef GL_ARB_ES3_1_compatibility }
  GL_ARB_ES3_1_compatibility = 1;  
{////#endif /* GL_ARB_ES3_1_compatibility */ }
{////#ifndef GL_ARB_ES3_2_compatibility }
  GL_ARB_ES3_2_compatibility = 1;  
  GL_PRIMITIVE_BOUNDING_BOX_ARB = $92BE;  
  GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB = $9381;  
  GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = $9382;  
{////typedef void (P PFNGLPRIMITIVEBOUNDINGBOXARBPROC) (GLfloat minX, GLfloat minY, GLfloat minZ, GLfloat minW, GLfloat maxX, GLfloat maxY, GLfloat maxZ, GLfloat maxW); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPrimitiveBoundingBoxARB(minX:TGLfloat; minY:TGLfloat; minZ:TGLfloat; minW:TGLfloat; maxX:TGLfloat; 
            maxY:TGLfloat; maxZ:TGLfloat; maxW:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_ES3_2_compatibility */ }
{////#ifndef GL_ARB_ES3_compatibility }
const
  GL_ARB_ES3_compatibility = 1;  
{////#endif /* GL_ARB_ES3_compatibility */ }
{////#ifndef GL_ARB_arrays_of_arrays }
  GL_ARB_arrays_of_arrays = 1;  
{////#endif /* GL_ARB_arrays_of_arrays */ }
{////#ifndef GL_ARB_base_instance }
  GL_ARB_base_instance = 1;  
{////#endif /* GL_ARB_base_instance */ }
{////#ifndef GL_ARB_bindless_texture }
  GL_ARB_bindless_texture = 1;  
type
  PGLuint64EXT = ^TGLuint64EXT;
  TGLuint64EXT = uint64;

const
  GL_UNSIGNED_INT64_ARB = $140F;  
{////typedef GLuint64 (P PFNGLGETTEXTUREHANDLEARBPROC) (GLuint texture); }
{////typedef GLuint64 (P PFNGLGETTEXTURESAMPLERHANDLEARBPROC) (GLuint texture, GLuint sampler); }
{////typedef void (P PFNGLMAKETEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle); }
{////typedef void (P PFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC) (GLuint64 handle); }
{////typedef GLuint64 (P PFNGLGETIMAGEHANDLEARBPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format); }
{////typedef void (P PFNGLMAKEIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle, GLenum access); }
{////typedef void (P PFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC) (GLuint64 handle); }
{////typedef void (P PFNGLUNIFORMHANDLEUI64ARBPROC) (GLint location, GLuint64 value); }
{////typedef void (P PFNGLUNIFORMHANDLEUI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC) (GLuint program_, GLint location, GLuint64 value); }
{////typedef void (P PFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *values); }
{////typedef GLboolean (P PFNGLISTEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle); }
{////typedef GLboolean (P PFNGLISIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle); }
{////typedef void (P PFNGLVERTEXATTRIBL1UI64ARBPROC) (GLuint index, GLuint64EXT x); }
{////typedef void (P PFNGLVERTEXATTRIBL1UI64VARBPROC) (GLuint index, const GLuint64EXT *v); }
{////typedef void (P PFNGLGETVERTEXATTRIBLUI64VARBPROC) (GLuint index, GLenum pname, GLuint64EXT *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGetTextureHandleARB(texture:TGLuint):TGLuint64;cdecl;external;
function glGetTextureSamplerHandleARB(texture:TGLuint; sampler:TGLuint):TGLuint64;cdecl;external;
procedure glMakeTextureHandleResidentARB(handle:TGLuint64);cdecl;external;
procedure glMakeTextureHandleNonResidentARB(handle:TGLuint64);cdecl;external;
function glGetImageHandleARB(texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; format:TGLenum):TGLuint64;cdecl;external;
procedure glMakeImageHandleResidentARB(handle:TGLuint64; access:TGLenum);cdecl;external;
procedure glMakeImageHandleNonResidentARB(handle:TGLuint64);cdecl;external;
procedure glUniformHandleui64ARB(location:TGLint; value:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniformHandleui64vARB(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
procedure glProgramUniformHandleui64ARB(program_:TGLuint; location:TGLint; value:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformHandleui64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; values:PGLuint64);cdecl;external;
function glIsTextureHandleResidentARB(handle:TGLuint64):TGLboolean;cdecl;external;
function glIsImageHandleResidentARB(handle:TGLuint64):TGLboolean;cdecl;external;
procedure glVertexAttribL1ui64ARB(index:TGLuint; x:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL1ui64vARB(index:TGLuint; v:PGLuint64EXT);cdecl;external;
procedure glGetVertexAttribLui64vARB(index:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_bindless_texture */ }
{////#ifndef GL_ARB_blend_func_extended }
const
  GL_ARB_blend_func_extended = 1;  
{////#endif /* GL_ARB_blend_func_extended */ }
{////#ifndef GL_ARB_buffer_storage }
  GL_ARB_buffer_storage = 1;  
{////#endif /* GL_ARB_buffer_storage */ }
{////#ifndef GL_ARB_cl_event }
  GL_ARB_cl_event = 1;  
type
  Pcl_context = ^Tcl_context;
  Tcl_context = record
      {undefined structure}
    end;

  Pcl_event = ^Tcl_event;
  Tcl_event = record
      {undefined structure}
    end;


const
  GL_SYNC_CL_EVENT_ARB = $8240;  
  GL_SYNC_CL_EVENT_COMPLETE_ARB = $8241;  
{////typedef GLsync (P PFNGLCREATESYNCFROMCLEVENTARBPROC) (struct _cl_context *context, struct _cl_event *event, GLbitfield flags); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glCreateSyncFromCLeventARB(context:Pcl_context; event:Pcl_event; flags:TGLbitfield):TGLsync;cdecl;external;
{////#endif }
{////#endif /* GL_ARB_cl_event */ }
{////#ifndef GL_ARB_clear_buffer_object }
const
  GL_ARB_clear_buffer_object = 1;  
{////#endif /* GL_ARB_clear_buffer_object */ }
{////#ifndef GL_ARB_clear_texture }
  GL_ARB_clear_texture = 1;  
{////#endif /* GL_ARB_clear_texture */ }
{////#ifndef GL_ARB_clip_control }
  GL_ARB_clip_control = 1;  
{////#endif /* GL_ARB_clip_control */ }
{////#ifndef GL_ARB_color_buffer_float }
  GL_ARB_color_buffer_float = 1;  
  GL_RGBA_FLOAT_MODE_ARB = $8820;  
  GL_CLAMP_VERTEX_COLOR_ARB = $891A;  
  GL_CLAMP_FRAGMENT_COLOR_ARB = $891B;  
  GL_CLAMP_READ_COLOR_ARB = $891C;  
  GL_FIXED_ONLY_ARB = $891D;  
{////typedef void (P PFNGLCLAMPCOLORARBPROC) (GLenum target, GLenum clamp); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glClampColorARB(target:TGLenum; clamp:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_color_buffer_float */ }
{////#ifndef GL_ARB_compatibility }
const
  GL_ARB_compatibility = 1;  
{////#endif /* GL_ARB_compatibility */ }
{////#ifndef GL_ARB_compressed_texture_pixel_storage }
  GL_ARB_compressed_texture_pixel_storage = 1;  
{////#endif /* GL_ARB_compressed_texture_pixel_storage */ }
{////#ifndef GL_ARB_compute_shader }
  GL_ARB_compute_shader = 1;  
{////#endif /* GL_ARB_compute_shader */ }
{////#ifndef GL_ARB_compute_variable_group_size }
  GL_ARB_compute_variable_group_size = 1;  
  GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = $9344;  
  GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = $90EB;  
  GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = $9345;  
  GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = $91BF;  
{////typedef void (P PFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z, GLuint group_size_x, GLuint group_size_y, GLuint group_size_z); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDispatchComputeGroupSizeARB(num_groups_x:TGLuint; num_groups_y:TGLuint; num_groups_z:TGLuint; group_size_x:TGLuint; group_size_y:TGLuint; 
            group_size_z:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_compute_variable_group_size */ }
{////#ifndef GL_ARB_conditional_render_inverted }
const
  GL_ARB_conditional_render_inverted = 1;  
{////#endif /* GL_ARB_conditional_render_inverted */ }
{////#ifndef GL_ARB_conservative_depth }
  GL_ARB_conservative_depth = 1;  
{////#endif /* GL_ARB_conservative_depth */ }
{////#ifndef GL_ARB_copy_buffer }
  GL_ARB_copy_buffer = 1;  
{////#endif /* GL_ARB_copy_buffer */ }
{////#ifndef GL_ARB_copy_image }
  GL_ARB_copy_image = 1;  
{////#endif /* GL_ARB_copy_image */ }
{////#ifndef GL_ARB_cull_distance }
  GL_ARB_cull_distance = 1;  
{////#endif /* GL_ARB_cull_distance */ }
{////#ifndef GL_ARB_debug_output }
  GL_ARB_debug_output = 1;  
(* Const before type ignored *)
(* Const before type ignored *)
type

  TGLDEBUGPROCARB = procedure (source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei; 
                message:PGLchar; userParam:pointer);cdecl;

const
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
{////typedef void (P PFNGLDEBUGMESSAGECONTROLARBPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled); }
{////typedef void (P PFNGLDEBUGMESSAGEINSERTARBPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf); }
{////typedef void (P PFNGLDEBUGMESSAGECALLBACKARBPROC) (GLDEBUGPROCARB callback, const void *userParam); }
{////typedef GLuint (P PFNGLGETDEBUGMESSAGELOGARBPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDebugMessageControlARB(source:TGLenum; _type:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint; 
            enabled:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageInsertARB(source:TGLenum; _type:TGLenum; id:TGLuint; severity:TGLenum; length:TGLsizei; 
            buf:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageCallbackARB(callback:TGLDEBUGPROCARB; userParam:pointer);cdecl;external;
function glGetDebugMessageLogARB(count:TGLuint; bufSize:TGLsizei; sources:PGLenum; types:PGLenum; ids:PGLuint; 
           severities:PGLenum; lengths:PGLsizei; messageLog:PGLchar):TGLuint;cdecl;external;
{////#endif }
{////#endif /* GL_ARB_debug_output */ }
{////#ifndef GL_ARB_depth_buffer_float }
const
  GL_ARB_depth_buffer_float = 1;  
{////#endif /* GL_ARB_depth_buffer_float */ }
{////#ifndef GL_ARB_depth_clamp }
  GL_ARB_depth_clamp = 1;  
{////#endif /* GL_ARB_depth_clamp */ }
{////#ifndef GL_ARB_depth_texture }
  GL_ARB_depth_texture = 1;  
  GL_DEPTH_COMPONENT16_ARB = $81A5;  
  GL_DEPTH_COMPONENT24_ARB = $81A6;  
  GL_DEPTH_COMPONENT32_ARB = $81A7;  
  GL_TEXTURE_DEPTH_SIZE_ARB = $884A;  
  GL_DEPTH_TEXTURE_MODE_ARB = $884B;  
{////#endif /* GL_ARB_depth_texture */ }
{////#ifndef GL_ARB_derivative_control }
  GL_ARB_derivative_control = 1;  
{////#endif /* GL_ARB_derivative_control */ }
{////#ifndef GL_ARB_direct_state_access }
  GL_ARB_direct_state_access = 1;  
{////#endif /* GL_ARB_direct_state_access */ }
{////#ifndef GL_ARB_draw_buffers }
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
{////typedef void (P PFNGLDRAWBUFFERSARBPROC) (GLsizei n, const GLenum *bufs); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDrawBuffersARB(n:TGLsizei; bufs:PGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_draw_buffers */ }
{////#ifndef GL_ARB_draw_buffers_blend }
const
  GL_ARB_draw_buffers_blend = 1;  
{////typedef void (P PFNGLBLENDEQUATIONIARBPROC) (GLuint buf, GLenum mode); }
{////typedef void (P PFNGLBLENDEQUATIONSEPARATEIARBPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha); }
{////typedef void (P PFNGLBLENDFUNCIARBPROC) (GLuint buf, GLenum src, GLenum dst); }
{////typedef void (P PFNGLBLENDFUNCSEPARATEIARBPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendEquationiARB(buf:TGLuint; mode:TGLenum);cdecl;external;
procedure glBlendEquationSeparateiARB(buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;external;
procedure glBlendFunciARB(buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;external;
procedure glBlendFuncSeparateiARB(buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_draw_buffers_blend */ }
{////#ifndef GL_ARB_draw_elements_base_vertex }
const
  GL_ARB_draw_elements_base_vertex = 1;  
{////#endif /* GL_ARB_draw_elements_base_vertex */ }
{////#ifndef GL_ARB_draw_indirect }
  GL_ARB_draw_indirect = 1;  
{////#endif /* GL_ARB_draw_indirect */ }
{////#ifndef GL_ARB_draw_instanced }
  GL_ARB_draw_instanced = 1;  
{////typedef void (P PFNGLDRAWARRAYSINSTANCEDARBPROC) (GLenum mode, GLint first, GLsizei count, GLsizei primcount); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDARBPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawArraysInstancedARB(mode:TGLenum; first:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstancedARB(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_draw_instanced */ }
{////#ifndef GL_ARB_enhanced_layouts }
const
  GL_ARB_enhanced_layouts = 1;  
{////#endif /* GL_ARB_enhanced_layouts */ }
{////#ifndef GL_ARB_explicit_attrib_location }
  GL_ARB_explicit_attrib_location = 1;  
{////#endif /* GL_ARB_explicit_attrib_location */ }
{////#ifndef GL_ARB_explicit_uniform_location }
  GL_ARB_explicit_uniform_location = 1;  
{////#endif /* GL_ARB_explicit_uniform_location */ }
{////#ifndef GL_ARB_fragment_coord_conventions }
  GL_ARB_fragment_coord_conventions = 1;  
{////#endif /* GL_ARB_fragment_coord_conventions */ }
{////#ifndef GL_ARB_fragment_layer_viewport }
  GL_ARB_fragment_layer_viewport = 1;  
{////#endif /* GL_ARB_fragment_layer_viewport */ }
{////#ifndef GL_ARB_fragment_program }
  GL_ARB_fragment_program = 1;  
  GL_FRAGMENT_PROGRAM_ARB = $8804;  
  GL_PROGRAM_FORMAT_ASCII_ARB = $8875;  
  GL_PROGRAM_LENGTH_ARB = $8627;  
  GL_PROGRAM_FORMAT_ARB = $8876;  
  GL_PROGRAM_BINDING_ARB = $8677;  
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
  GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = $88B4;  
  GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = $88B5;  
  GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = $88B6;  
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
  GL_PROGRAM_STRING_ARB = $8628;  
  GL_PROGRAM_ERROR_POSITION_ARB = $864B;  
  GL_CURRENT_MATRIX_ARB = $8641;  
  GL_TRANSPOSE_CURRENT_MATRIX_ARB = $88B7;  
  GL_CURRENT_MATRIX_STACK_DEPTH_ARB = $8640;  
  GL_MAX_PROGRAM_MATRICES_ARB = $862F;  
  GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = $862E;  
  GL_MAX_TEXTURE_COORDS_ARB = $8871;  
  GL_MAX_TEXTURE_IMAGE_UNITS_ARB = $8872;  
  GL_PROGRAM_ERROR_STRING_ARB = $8874;  
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
{////typedef void (P PFNGLPROGRAMSTRINGARBPROC) (GLenum target, GLenum format, GLsizei len, const void *string); }
{////typedef void (P PFNGLBINDPROGRAMARBPROC) (GLenum target, GLuint program_); }
{////typedef void (P PFNGLDELETEPROGRAMSARBPROC) (GLsizei n, const GLuint *programs); }
{////typedef void (P PFNGLGENPROGRAMSARBPROC) (GLsizei n, GLuint *programs); }
{////typedef void (P PFNGLPROGRAMENVPARAMETER4DARBPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLPROGRAMENVPARAMETER4DVARBPROC) (GLenum target, GLuint index, const GLdouble *params); }
{////typedef void (P PFNGLPROGRAMENVPARAMETER4FARBPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLPROGRAMENVPARAMETER4FVARBPROC) (GLenum target, GLuint index, const GLfloat *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETER4DARBPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETER4DVARBPROC) (GLenum target, GLuint index, const GLdouble *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETER4FARBPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETER4FVARBPROC) (GLenum target, GLuint index, const GLfloat *params); }
{////typedef void (P PFNGLGETPROGRAMENVPARAMETERDVARBPROC) (GLenum target, GLuint index, GLdouble *params); }
{////typedef void (P PFNGLGETPROGRAMENVPARAMETERFVARBPROC) (GLenum target, GLuint index, GLfloat *params); }
{////typedef void (P PFNGLGETPROGRAMLOCALPARAMETERDVARBPROC) (GLenum target, GLuint index, GLdouble *params); }
{////typedef void (P PFNGLGETPROGRAMLOCALPARAMETERFVARBPROC) (GLenum target, GLuint index, GLfloat *params); }
{////typedef void (P PFNGLGETPROGRAMIVARBPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETPROGRAMSTRINGARBPROC) (GLenum target, GLenum pname, void *string); }
{////typedef GLboolean (P PFNGLISPROGRAMARBPROC) (GLuint program_); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glProgramStringARB(target:TGLenum; format:TGLenum; len:TGLsizei; _string:pointer);cdecl;external;
procedure glBindProgramARB(target:TGLenum; program_:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteProgramsARB(n:TGLsizei; programs:PGLuint);cdecl;external;
procedure glGenProgramsARB(n:TGLsizei; programs:PGLuint);cdecl;external;
procedure glProgramEnvParameter4dARB(target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; 
            w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParameter4dvARB(target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glProgramEnvParameter4fARB(target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; 
            w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParameter4fvARB(target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glProgramLocalParameter4dARB(target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; 
            w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParameter4dvARB(target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glProgramLocalParameter4fARB(target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; 
            w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParameter4fvARB(target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetProgramEnvParameterdvARB(target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glGetProgramEnvParameterfvARB(target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetProgramLocalParameterdvARB(target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glGetProgramLocalParameterfvARB(target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetProgramivARB(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetProgramStringARB(target:TGLenum; pname:TGLenum; _string:pointer);cdecl;external;
function glIsProgramARB(program_:TGLuint):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_ARB_fragment_program */ }
{////#ifndef GL_ARB_fragment_program_shadow }
const
  GL_ARB_fragment_program_shadow = 1;  
{////#endif /* GL_ARB_fragment_program_shadow */ }
{////#ifndef GL_ARB_fragment_shader }
  GL_ARB_fragment_shader = 1;  
  GL_FRAGMENT_SHADER_ARB = $8B30;  
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = $8B49;  
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = $8B8B;  
{////#endif /* GL_ARB_fragment_shader */ }
{////#ifndef GL_ARB_fragment_shader_interlock }
  GL_ARB_fragment_shader_interlock = 1;  
{////#endif /* GL_ARB_fragment_shader_interlock */ }
{////#ifndef GL_ARB_framebuffer_no_attachments }
  GL_ARB_framebuffer_no_attachments = 1;  
{////#endif /* GL_ARB_framebuffer_no_attachments */ }
{////#ifndef GL_ARB_framebuffer_object }
  GL_ARB_framebuffer_object = 1;  
{////#endif /* GL_ARB_framebuffer_object */ }
{////#ifndef GL_ARB_framebuffer_sRGB }
  GL_ARB_framebuffer_sRGB = 1;  
{////#endif /* GL_ARB_framebuffer_sRGB */ }
{////#ifndef GL_ARB_geometry_shader4 }
  GL_ARB_geometry_shader4 = 1;  
  GL_LINES_ADJACENCY_ARB = $000A;  
  GL_LINE_STRIP_ADJACENCY_ARB = $000B;  
  GL_TRIANGLES_ADJACENCY_ARB = $000C;  
  GL_TRIANGLE_STRIP_ADJACENCY_ARB = $000D;  
  GL_PROGRAM_POINT_SIZE_ARB = $8642;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = $8C29;  
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
{////typedef void (P PFNGLPROGRAMPARAMETERIARBPROC) (GLuint program_, GLenum pname, GLint value); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURELAYERARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREFACEARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glProgramParameteriARB(program_:TGLuint; pname:TGLenum; value:TGLint);cdecl;external;
procedure glFramebufferTextureARB(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTextureLayerARB(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;external;
procedure glFramebufferTextureFaceARB(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_geometry_shader4 */ }
{////#ifndef GL_ARB_get_program_binary }
const
  GL_ARB_get_program_binary = 1;  
{////#endif /* GL_ARB_get_program_binary */ }
{////#ifndef GL_ARB_get_texture_sub_image }
  GL_ARB_get_texture_sub_image = 1;  
{////#endif /* GL_ARB_get_texture_sub_image */ }
{////#ifndef GL_ARB_gl_spirv }
  GL_ARB_gl_spirv = 1;  
  GL_SHADER_BINARY_FORMAT_SPIR_V_ARB = $9551;  
  GL_SPIR_V_BINARY_ARB = $9552;  
{////typedef void (P PFNGLSPECIALIZESHADERARBPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

procedure glSpecializeShaderARB(shader:TGLuint; pEntryPoint:PGLchar; numSpecializationConstants:TGLuint; pConstantIndex:PGLuint; pConstantValue:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_gl_spirv */ }
{////#ifndef GL_ARB_gpu_shader5 }
const
  GL_ARB_gpu_shader5 = 1;  
{////#endif /* GL_ARB_gpu_shader5 */ }
{////#ifndef GL_ARB_gpu_shader_fp64 }
  GL_ARB_gpu_shader_fp64 = 1;  
{////#endif /* GL_ARB_gpu_shader_fp64 */ }
{////#ifndef GL_ARB_gpu_shader_int64 }
  GL_ARB_gpu_shader_int64 = 1;  
  GL_INT64_ARB = $140E;  
  GL_INT64_VEC2_ARB = $8FE9;  
  GL_INT64_VEC3_ARB = $8FEA;  
  GL_INT64_VEC4_ARB = $8FEB;  
  GL_UNSIGNED_INT64_VEC2_ARB = $8FF5;  
  GL_UNSIGNED_INT64_VEC3_ARB = $8FF6;  
  GL_UNSIGNED_INT64_VEC4_ARB = $8FF7;  
{////typedef void (P PFNGLUNIFORM1I64ARBPROC) (GLint location, GLint64 x); }
{////typedef void (P PFNGLUNIFORM2I64ARBPROC) (GLint location, GLint64 x, GLint64 y); }
{////typedef void (P PFNGLUNIFORM3I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z); }
{////typedef void (P PFNGLUNIFORM4I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w); }
{////typedef void (P PFNGLUNIFORM1I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLUNIFORM2I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLUNIFORM3I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLUNIFORM4I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLUNIFORM1UI64ARBPROC) (GLint location, GLuint64 x); }
{////typedef void (P PFNGLUNIFORM2UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y); }
{////typedef void (P PFNGLUNIFORM3UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z); }
{////typedef void (P PFNGLUNIFORM4UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w); }
{////typedef void (P PFNGLUNIFORM1UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLUNIFORM2UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLUNIFORM3UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLUNIFORM4UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLGETUNIFORMI64VARBPROC) (GLuint program_, GLint location, GLint64 *params); }
{////typedef void (P PFNGLGETUNIFORMUI64VARBPROC) (GLuint program_, GLint location, GLuint64 *params); }
{////typedef void (P PFNGLGETNUNIFORMI64VARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLint64 *params); }
{////typedef void (P PFNGLGETNUNIFORMUI64VARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLuint64 *params); }
{////typedef void (P PFNGLPROGRAMUNIFORM1I64ARBPROC) (GLuint program_, GLint location, GLint64 x); }
{////typedef void (P PFNGLPROGRAMUNIFORM2I64ARBPROC) (GLuint program_, GLint location, GLint64 x, GLint64 y); }
{////typedef void (P PFNGLPROGRAMUNIFORM3I64ARBPROC) (GLuint program_, GLint location, GLint64 x, GLint64 y, GLint64 z); }
{////typedef void (P PFNGLPROGRAMUNIFORM4I64ARBPROC) (GLuint program_, GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w); }
{////typedef void (P PFNGLPROGRAMUNIFORM1I64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2I64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3I64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4I64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UI64ARBPROC) (GLuint program_, GLint location, GLuint64 x); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UI64ARBPROC) (GLuint program_, GLint location, GLuint64 x, GLuint64 y); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UI64ARBPROC) (GLuint program_, GLint location, GLuint64 x, GLuint64 y, GLuint64 z); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UI64ARBPROC) (GLuint program_, GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UI64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UI64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UI64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UI64VARBPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glUniform1i64ARB(location:TGLint; x:TGLint64);cdecl;external;
procedure glUniform2i64ARB(location:TGLint; x:TGLint64; y:TGLint64);cdecl;external;
procedure glUniform3i64ARB(location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64);cdecl;external;
procedure glUniform4i64ARB(location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64; w:TGLint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform1i64vARB(location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform2i64vARB(location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform3i64vARB(location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform4i64vARB(location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
procedure glUniform1ui64ARB(location:TGLint; x:TGLuint64);cdecl;external;
procedure glUniform2ui64ARB(location:TGLint; x:TGLuint64; y:TGLuint64);cdecl;external;
procedure glUniform3ui64ARB(location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64);cdecl;external;
procedure glUniform4ui64ARB(location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64; w:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform1ui64vARB(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform2ui64vARB(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform3ui64vARB(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniform4ui64vARB(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
procedure glGetUniformi64vARB(program_:TGLuint; location:TGLint; params:PGLint64);cdecl;external;
procedure glGetUniformui64vARB(program_:TGLuint; location:TGLint; params:PGLuint64);cdecl;external;
procedure glGetnUniformi64vARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint64);cdecl;external;
procedure glGetnUniformui64vARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint64);cdecl;external;
procedure glProgramUniform1i64ARB(program_:TGLuint; location:TGLint; x:TGLint64);cdecl;external;
procedure glProgramUniform2i64ARB(program_:TGLuint; location:TGLint; x:TGLint64; y:TGLint64);cdecl;external;
procedure glProgramUniform3i64ARB(program_:TGLuint; location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64);cdecl;external;
procedure glProgramUniform4i64ARB(program_:TGLuint; location:TGLint; x:TGLint64; y:TGLint64; z:TGLint64; 
            w:TGLint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1i64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2i64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3i64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4i64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64);cdecl;external;
procedure glProgramUniform1ui64ARB(program_:TGLuint; location:TGLint; x:TGLuint64);cdecl;external;
procedure glProgramUniform2ui64ARB(program_:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64);cdecl;external;
procedure glProgramUniform3ui64ARB(program_:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64);cdecl;external;
procedure glProgramUniform4ui64ARB(program_:TGLuint; location:TGLint; x:TGLuint64; y:TGLuint64; z:TGLuint64; 
            w:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1ui64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2ui64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3ui64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4ui64vARB(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_gpu_shader_int64 */ }
{////#ifndef GL_ARB_half_float_pixel }
const
  GL_ARB_half_float_pixel = 1;  
type
  PGLhalfARB = ^TGLhalfARB;
  TGLhalfARB = uint16;

const
  GL_HALF_FLOAT_ARB = $140B;  
{////#endif /* GL_ARB_half_float_pixel */ }
{////#ifndef GL_ARB_half_float_vertex }
  GL_ARB_half_float_vertex = 1;  
{////#endif /* GL_ARB_half_float_vertex */ }
{////#ifndef GL_ARB_imaging }
  GL_ARB_imaging = 1;  
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
  GL_HISTOGRAM_WIDTH = $8026;  
  GL_HISTOGRAM_FORMAT = $8027;  
  GL_HISTOGRAM_RED_SIZE = $8028;  
  GL_HISTOGRAM_GREEN_SIZE = $8029;  
  GL_HISTOGRAM_BLUE_SIZE = $802A;  
  GL_HISTOGRAM_ALPHA_SIZE = $802B;  
  GL_HISTOGRAM_LUMINANCE_SIZE = $802C;  
  GL_HISTOGRAM_SINK = $802D;  
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
  GL_CONSTANT_BORDER = $8151;  
  GL_REPLICATE_BORDER = $8153;  
  GL_CONVOLUTION_BORDER_COLOR = $8154;  
{////typedef void (P PFNGLCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table); }
{////typedef void (P PFNGLCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLCOPYCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLGETCOLORTABLEPROC) (GLenum target, GLenum format, GLenum type, void *table); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCOPYCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image); }
{////typedef void (P PFNGLCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERFPROC) (GLenum target, GLenum pname, GLfloat params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERIPROC) (GLenum target, GLenum pname, GLint params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLCOPYCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETCONVOLUTIONFILTERPROC) (GLenum target, GLenum format, GLenum type, void *image); }
{////typedef void (P PFNGLGETCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETSEPARABLEFILTERPROC) (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span); }
{////typedef void (P PFNGLSEPARABLEFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column); }
{////typedef void (P PFNGLGETHISTOGRAMPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values); }
{////typedef void (P PFNGLGETHISTOGRAMPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETHISTOGRAMPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMINMAXPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values); }
{////typedef void (P PFNGLGETMINMAXPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMINMAXPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLHISTOGRAMPROC) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink); }
{////typedef void (P PFNGLMINMAXPROC) (GLenum target, GLenum internalformat, GLboolean sink); }
{////typedef void (P PFNGLRESETHISTOGRAMPROC) (GLenum target); }
{////typedef void (P PFNGLRESETMINMAXPROC) (GLenum target); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glColorTable(target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum; 
            table:pointer);cdecl;external;
(* Const before type ignored *)
procedure glColorTableParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glColorTableParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCopyColorTable(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
procedure glGetColorTable(target:TGLenum; format:TGLenum; _type:TGLenum; table:pointer);cdecl;external;
procedure glGetColorTableParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetColorTableParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glColorSubTable(target:TGLenum; start:TGLsizei; count:TGLsizei; format:TGLenum; _type:TGLenum; 
            data:pointer);cdecl;external;
procedure glCopyColorSubTable(target:TGLenum; start:TGLsizei; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionFilter1D(target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum; 
            image:pointer);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionFilter2D(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; image:pointer);cdecl;external;
procedure glConvolutionParameterf(target:TGLenum; pname:TGLenum; params:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glConvolutionParameteri(target:TGLenum; pname:TGLenum; params:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCopyConvolutionFilter1D(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
procedure glCopyConvolutionFilter2D(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
procedure glGetConvolutionFilter(target:TGLenum; format:TGLenum; _type:TGLenum; image:pointer);cdecl;external;
procedure glGetConvolutionParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetConvolutionParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetSeparableFilter(target:TGLenum; format:TGLenum; _type:TGLenum; row:pointer; column:pointer; 
            span:pointer);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glSeparableFilter2D(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; row:pointer; column:pointer);cdecl;external;
procedure glGetHistogram(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;external;
procedure glGetHistogramParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetHistogramParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMinmax(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;external;
procedure glGetMinmaxParameterfv(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMinmaxParameteriv(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glHistogram(target:TGLenum; width:TGLsizei; internalformat:TGLenum; sink:TGLboolean);cdecl;external;
procedure glMinmax(target:TGLenum; internalformat:TGLenum; sink:TGLboolean);cdecl;external;
procedure glResetHistogram(target:TGLenum);cdecl;external;
procedure glResetMinmax(target:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_imaging */ }
{////#ifndef GL_ARB_indirect_parameters }
const
  GL_ARB_indirect_parameters = 1;  
  GL_PARAMETER_BUFFER_ARB = $80EE;  
  GL_PARAMETER_BUFFER_BINDING_ARB = $80EF;  
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMultiDrawArraysIndirectCountARB(mode:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirectCountARB(mode:TGLenum; _type:TGLenum; indirect:pointer; drawcount:TGLintptr; maxdrawcount:TGLsizei; 
            stride:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_indirect_parameters */ }
{////#ifndef GL_ARB_instanced_arrays }
const
  GL_ARB_instanced_arrays = 1;  
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = $88FE;  
{////typedef void (P PFNGLVERTEXATTRIBDIVISORARBPROC) (GLuint index, GLuint divisor); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttribDivisorARB(index:TGLuint; divisor:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_instanced_arrays */ }
{////#ifndef GL_ARB_internalformat_query }
const
  GL_ARB_internalformat_query = 1;  
{////#endif /* GL_ARB_internalformat_query */ }
{////#ifndef GL_ARB_internalformat_query2 }
  GL_ARB_internalformat_query2 = 1;  
  GL_SRGB_DECODE_ARB = $8299;  
  GL_VIEW_CLASS_EAC_R11 = $9383;  
  GL_VIEW_CLASS_EAC_RG11 = $9384;  
  GL_VIEW_CLASS_ETC2_RGB = $9385;  
  GL_VIEW_CLASS_ETC2_RGBA = $9386;  
  GL_VIEW_CLASS_ETC2_EAC_RGBA = $9387;  
  GL_VIEW_CLASS_ASTC_4x4_RGBA = $9388;  
  GL_VIEW_CLASS_ASTC_5x4_RGBA = $9389;  
  GL_VIEW_CLASS_ASTC_5x5_RGBA = $938A;  
  GL_VIEW_CLASS_ASTC_6x5_RGBA = $938B;  
  GL_VIEW_CLASS_ASTC_6x6_RGBA = $938C;  
  GL_VIEW_CLASS_ASTC_8x5_RGBA = $938D;  
  GL_VIEW_CLASS_ASTC_8x6_RGBA = $938E;  
  GL_VIEW_CLASS_ASTC_8x8_RGBA = $938F;  
  GL_VIEW_CLASS_ASTC_10x5_RGBA = $9390;  
  GL_VIEW_CLASS_ASTC_10x6_RGBA = $9391;  
  GL_VIEW_CLASS_ASTC_10x8_RGBA = $9392;  
  GL_VIEW_CLASS_ASTC_10x10_RGBA = $9393;  
  GL_VIEW_CLASS_ASTC_12x10_RGBA = $9394;  
  GL_VIEW_CLASS_ASTC_12x12_RGBA = $9395;  
{////#endif /* GL_ARB_internalformat_query2 */ }
{////#ifndef GL_ARB_invalidate_subdata }
  GL_ARB_invalidate_subdata = 1;  
{////#endif /* GL_ARB_invalidate_subdata */ }
{////#ifndef GL_ARB_map_buffer_alignment }
  GL_ARB_map_buffer_alignment = 1;  
{////#endif /* GL_ARB_map_buffer_alignment */ }
{////#ifndef GL_ARB_map_buffer_range }
  GL_ARB_map_buffer_range = 1;  
{////#endif /* GL_ARB_map_buffer_range */ }
{////#ifndef GL_ARB_matrix_palette }
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
{////typedef void (P PFNGLCURRENTPALETTEMATRIXARBPROC) (GLint index); }
{////typedef void (P PFNGLMATRIXINDEXUBVARBPROC) (GLint size, const GLubyte *indices); }
{////typedef void (P PFNGLMATRIXINDEXUSVARBPROC) (GLint size, const GLushort *indices); }
{////typedef void (P PFNGLMATRIXINDEXUIVARBPROC) (GLint size, const GLuint *indices); }
{////typedef void (P PFNGLMATRIXINDEXPOINTERARBPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCurrentPaletteMatrixARB(index:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMatrixIndexubvARB(size:TGLint; indices:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glMatrixIndexusvARB(size:TGLint; indices:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glMatrixIndexuivARB(size:TGLint; indices:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMatrixIndexPointerARB(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_matrix_palette */ }
{////#ifndef GL_ARB_multi_bind }
const
  GL_ARB_multi_bind = 1;  
{////#endif /* GL_ARB_multi_bind */ }
{////#ifndef GL_ARB_multi_draw_indirect }
  GL_ARB_multi_draw_indirect = 1;  
{////#endif /* GL_ARB_multi_draw_indirect */ }
{////#ifndef GL_ARB_multisample }
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
{////typedef void (P PFNGLSAMPLECOVERAGEARBPROC) (GLfloat value, GLboolean invert); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSampleCoverageARB(value:TGLfloat; invert:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_multisample */ }
{////#ifndef GL_ARB_multitexture }
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
{////typedef void (P PFNGLACTIVETEXTUREARBPROC) (GLenum texture); }
{////typedef void (P PFNGLCLIENTACTIVETEXTUREARBPROC) (GLenum texture); }
{////typedef void (P PFNGLMULTITEXCOORD1DARBPROC) (GLenum target, GLdouble s); }
{////typedef void (P PFNGLMULTITEXCOORD1DVARBPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD1FARBPROC) (GLenum target, GLfloat s); }
{////typedef void (P PFNGLMULTITEXCOORD1FVARBPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD1IARBPROC) (GLenum target, GLint s); }
{////typedef void (P PFNGLMULTITEXCOORD1IVARBPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD1SARBPROC) (GLenum target, GLshort s); }
{////typedef void (P PFNGLMULTITEXCOORD1SVARBPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD2DARBPROC) (GLenum target, GLdouble s, GLdouble t); }
{////typedef void (P PFNGLMULTITEXCOORD2DVARBPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD2FARBPROC) (GLenum target, GLfloat s, GLfloat t); }
{////typedef void (P PFNGLMULTITEXCOORD2FVARBPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD2IARBPROC) (GLenum target, GLint s, GLint t); }
{////typedef void (P PFNGLMULTITEXCOORD2IVARBPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD2SARBPROC) (GLenum target, GLshort s, GLshort t); }
{////typedef void (P PFNGLMULTITEXCOORD2SVARBPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD3DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r); }
{////typedef void (P PFNGLMULTITEXCOORD3DVARBPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD3FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r); }
{////typedef void (P PFNGLMULTITEXCOORD3FVARBPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD3IARBPROC) (GLenum target, GLint s, GLint t, GLint r); }
{////typedef void (P PFNGLMULTITEXCOORD3IVARBPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD3SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r); }
{////typedef void (P PFNGLMULTITEXCOORD3SVARBPROC) (GLenum target, const GLshort *v); }
{////typedef void (P PFNGLMULTITEXCOORD4DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q); }
{////typedef void (P PFNGLMULTITEXCOORD4DVARBPROC) (GLenum target, const GLdouble *v); }
{////typedef void (P PFNGLMULTITEXCOORD4FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q); }
{////typedef void (P PFNGLMULTITEXCOORD4FVARBPROC) (GLenum target, const GLfloat *v); }
{////typedef void (P PFNGLMULTITEXCOORD4IARBPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q); }
{////typedef void (P PFNGLMULTITEXCOORD4IVARBPROC) (GLenum target, const GLint *v); }
{////typedef void (P PFNGLMULTITEXCOORD4SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q); }
{////typedef void (P PFNGLMULTITEXCOORD4SVARBPROC) (GLenum target, const GLshort *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glActiveTextureARB(texture:TGLenum);cdecl;external;
procedure glClientActiveTextureARB(texture:TGLenum);cdecl;external;
procedure glMultiTexCoord1dARB(target:TGLenum; s:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1dvARB(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord1fARB(target:TGLenum; s:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1fvARB(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord1iARB(target:TGLenum; s:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1ivARB(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord1sARB(target:TGLenum; s:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1svARB(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord2dARB(target:TGLenum; s:TGLdouble; t:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2dvARB(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord2fARB(target:TGLenum; s:TGLfloat; t:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2fvARB(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord2iARB(target:TGLenum; s:TGLint; t:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2ivARB(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord2sARB(target:TGLenum; s:TGLshort; t:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2svARB(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord3dARB(target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3dvARB(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord3fARB(target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3fvARB(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord3iARB(target:TGLenum; s:TGLint; t:TGLint; r:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3ivARB(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord3sARB(target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3svARB(target:TGLenum; v:PGLshort);cdecl;external;
procedure glMultiTexCoord4dARB(target:TGLenum; s:TGLdouble; t:TGLdouble; r:TGLdouble; q:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4dvARB(target:TGLenum; v:PGLdouble);cdecl;external;
procedure glMultiTexCoord4fARB(target:TGLenum; s:TGLfloat; t:TGLfloat; r:TGLfloat; q:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4fvARB(target:TGLenum; v:PGLfloat);cdecl;external;
procedure glMultiTexCoord4iARB(target:TGLenum; s:TGLint; t:TGLint; r:TGLint; q:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4ivARB(target:TGLenum; v:PGLint);cdecl;external;
procedure glMultiTexCoord4sARB(target:TGLenum; s:TGLshort; t:TGLshort; r:TGLshort; q:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4svARB(target:TGLenum; v:PGLshort);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_multitexture */ }
{////#ifndef GL_ARB_occlusion_query }
const
  GL_ARB_occlusion_query = 1;  
  GL_QUERY_COUNTER_BITS_ARB = $8864;  
  GL_CURRENT_QUERY_ARB = $8865;  
  GL_QUERY_RESULT_ARB = $8866;  
  GL_QUERY_RESULT_AVAILABLE_ARB = $8867;  
  GL_SAMPLES_PASSED_ARB = $8914;  
{////typedef void (P PFNGLGENQUERIESARBPROC) (GLsizei n, GLuint *ids); }
{////typedef void (P PFNGLDELETEQUERIESARBPROC) (GLsizei n, const GLuint *ids); }
{////typedef GLboolean (P PFNGLISQUERYARBPROC) (GLuint id); }
{////typedef void (P PFNGLBEGINQUERYARBPROC) (GLenum target, GLuint id); }
{////typedef void (P PFNGLENDQUERYARBPROC) (GLenum target); }
{////typedef void (P PFNGLGETQUERYIVARBPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETQUERYOBJECTIVARBPROC) (GLuint id, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETQUERYOBJECTUIVARBPROC) (GLuint id, GLenum pname, GLuint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenQueriesARB(n:TGLsizei; ids:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteQueriesARB(n:TGLsizei; ids:PGLuint);cdecl;external;
function glIsQueryARB(id:TGLuint):TGLboolean;cdecl;external;
procedure glBeginQueryARB(target:TGLenum; id:TGLuint);cdecl;external;
procedure glEndQueryARB(target:TGLenum);cdecl;external;
procedure glGetQueryivARB(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetQueryObjectivARB(id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetQueryObjectuivARB(id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_occlusion_query */ }
{////#ifndef GL_ARB_occlusion_query2 }
const
  GL_ARB_occlusion_query2 = 1;  
{////#endif /* GL_ARB_occlusion_query2 */ }
{////#ifndef GL_ARB_parallel_shader_compile }
  GL_ARB_parallel_shader_compile = 1;  
  GL_MAX_SHADER_COMPILER_THREADS_ARB = $91B0;  
  GL_COMPLETION_STATUS_ARB = $91B1;  
{////typedef void (P PFNGLMAXSHADERCOMPILERTHREADSARBPROC) (GLuint count); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMaxShaderCompilerThreadsARB(count:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_parallel_shader_compile */ }
{////#ifndef GL_ARB_pipeline_statistics_query }
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
{////#endif /* GL_ARB_pipeline_statistics_query */ }
{////#ifndef GL_ARB_pixel_buffer_object }
  GL_ARB_pixel_buffer_object = 1;  
  GL_PIXEL_PACK_BUFFER_ARB = $88EB;  
  GL_PIXEL_UNPACK_BUFFER_ARB = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING_ARB = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = $88EF;  
{////#endif /* GL_ARB_pixel_buffer_object */ }
{////#ifndef GL_ARB_point_parameters }
  GL_ARB_point_parameters = 1;  
  GL_POINT_SIZE_MIN_ARB = $8126;  
  GL_POINT_SIZE_MAX_ARB = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE_ARB = $8128;  
  GL_POINT_DISTANCE_ATTENUATION_ARB = $8129;  
{////typedef void (P PFNGLPOINTPARAMETERFARBPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPOINTPARAMETERFVARBPROC) (GLenum pname, const GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPointParameterfARB(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterfvARB(pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_point_parameters */ }
{////#ifndef GL_ARB_point_sprite }
const
  GL_ARB_point_sprite = 1;  
  GL_POINT_SPRITE_ARB = $8861;  
  GL_COORD_REPLACE_ARB = $8862;  
{////#endif /* GL_ARB_point_sprite */ }
{////#ifndef GL_ARB_polygon_offset_clamp }
  GL_ARB_polygon_offset_clamp = 1;  
{////#endif /* GL_ARB_polygon_offset_clamp */ }
{////#ifndef GL_ARB_post_depth_coverage }
  GL_ARB_post_depth_coverage = 1;  
{////#endif /* GL_ARB_post_depth_coverage */ }
{////#ifndef GL_ARB_program_interface_query }
  GL_ARB_program_interface_query = 1;  
{////#endif /* GL_ARB_program_interface_query */ }
{////#ifndef GL_ARB_provoking_vertex }
  GL_ARB_provoking_vertex = 1;  
{////#endif /* GL_ARB_provoking_vertex */ }
{////#ifndef GL_ARB_query_buffer_object }
  GL_ARB_query_buffer_object = 1;  
{////#endif /* GL_ARB_query_buffer_object */ }
{////#ifndef GL_ARB_robust_buffer_access_behavior }
  GL_ARB_robust_buffer_access_behavior = 1;  
{////#endif /* GL_ARB_robust_buffer_access_behavior */ }
{////#ifndef GL_ARB_robustness }
  GL_ARB_robustness = 1;  
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = $00000004;  
  GL_LOSE_CONTEXT_ON_RESET_ARB = $8252;  
  GL_GUILTY_CONTEXT_RESET_ARB = $8253;  
  GL_INNOCENT_CONTEXT_RESET_ARB = $8254;  
  GL_UNKNOWN_CONTEXT_RESET_ARB = $8255;  
  GL_RESET_NOTIFICATION_STRATEGY_ARB = $8256;  
  GL_NO_RESET_NOTIFICATION_ARB = $8261;  
{////typedef GLenum (P PFNGLGETGRAPHICSRESETSTATUSARBPROC) (void); }
{////typedef void (P PFNGLGETNTEXIMAGEARBPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *img); }
{////typedef void (P PFNGLREADNPIXELSARBPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data); }
{////typedef void (P PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint lod, GLsizei bufSize, void *img); }
{////typedef void (P PFNGLGETNUNIFORMFVARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLfloat *params); }
{////typedef void (P PFNGLGETNUNIFORMIVARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLint *params); }
{////typedef void (P PFNGLGETNUNIFORMUIVARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLuint *params); }
{////typedef void (P PFNGLGETNUNIFORMDVARBPROC) (GLuint program_, GLint location, GLsizei bufSize, GLdouble *params); }
{////typedef void (P PFNGLGETNMAPDVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v); }
{////typedef void (P PFNGLGETNMAPFVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v); }
{////typedef void (P PFNGLGETNMAPIVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLint *v); }
{////typedef void (P PFNGLGETNPIXELMAPFVARBPROC) (GLenum map, GLsizei bufSize, GLfloat *values); }
{////typedef void (P PFNGLGETNPIXELMAPUIVARBPROC) (GLenum map, GLsizei bufSize, GLuint *values); }
{////typedef void (P PFNGLGETNPIXELMAPUSVARBPROC) (GLenum map, GLsizei bufSize, GLushort *values); }
{////typedef void (P PFNGLGETNPOLYGONSTIPPLEARBPROC) (GLsizei bufSize, GLubyte *pattern); }
{////typedef void (P PFNGLGETNCOLORTABLEARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table); }
{////typedef void (P PFNGLGETNCONVOLUTIONFILTERARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image); }
{////typedef void (P PFNGLGETNSEPARABLEFILTERARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span); }
{////typedef void (P PFNGLGETNHISTOGRAMARBPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values); }
{////typedef void (P PFNGLGETNMINMAXARBPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGetGraphicsResetStatusARB:TGLenum;cdecl;external;
procedure glGetnTexImageARB(target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            img:pointer);cdecl;external;
procedure glReadnPixelsARB(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; bufSize:TGLsizei; data:pointer);cdecl;external;
procedure glGetnCompressedTexImageARB(target:TGLenum; lod:TGLint; bufSize:TGLsizei; img:pointer);cdecl;external;
procedure glGetnUniformfvARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLfloat);cdecl;external;
procedure glGetnUniformivARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLint);cdecl;external;
procedure glGetnUniformuivARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLuint);cdecl;external;
procedure glGetnUniformdvARB(program_:TGLuint; location:TGLint; bufSize:TGLsizei; params:PGLdouble);cdecl;external;
procedure glGetnMapdvARB(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLdouble);cdecl;external;
procedure glGetnMapfvARB(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLfloat);cdecl;external;
procedure glGetnMapivARB(target:TGLenum; query:TGLenum; bufSize:TGLsizei; v:PGLint);cdecl;external;
procedure glGetnPixelMapfvARB(map:TGLenum; bufSize:TGLsizei; values:PGLfloat);cdecl;external;
procedure glGetnPixelMapuivARB(map:TGLenum; bufSize:TGLsizei; values:PGLuint);cdecl;external;
procedure glGetnPixelMapusvARB(map:TGLenum; bufSize:TGLsizei; values:PGLushort);cdecl;external;
procedure glGetnPolygonStippleARB(bufSize:TGLsizei; pattern:PGLubyte);cdecl;external;
procedure glGetnColorTableARB(target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; table:pointer);cdecl;external;
procedure glGetnConvolutionFilterARB(target:TGLenum; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; image:pointer);cdecl;external;
procedure glGetnSeparableFilterARB(target:TGLenum; format:TGLenum; _type:TGLenum; rowBufSize:TGLsizei; row:pointer; 
            columnBufSize:TGLsizei; column:pointer; span:pointer);cdecl;external;
procedure glGetnHistogramARB(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            values:pointer);cdecl;external;
procedure glGetnMinmaxARB(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; bufSize:TGLsizei; 
            values:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_robustness */ }
{////#ifndef GL_ARB_robustness_isolation }
const
  GL_ARB_robustness_isolation = 1;  
{////#endif /* GL_ARB_robustness_isolation */ }
{////#ifndef GL_ARB_sample_locations }
  GL_ARB_sample_locations = 1;  
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = $933D;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = $933E;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = $933F;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = $9340;  
  GL_SAMPLE_LOCATION_ARB = $8E50;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB = $9341;  
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = $9342;  
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = $9343;  
{////typedef void (P PFNGLFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLEVALUATEDEPTHVALUESARBPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glFramebufferSampleLocationsfvARB(target:TGLenum; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glNamedFramebufferSampleLocationsfvARB(framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
procedure glEvaluateDepthValuesARB;cdecl;external;
{////#endif }
{////#endif /* GL_ARB_sample_locations */ }
{////#ifndef GL_ARB_sample_shading }
const
  GL_ARB_sample_shading = 1;  
  GL_SAMPLE_SHADING_ARB = $8C36;  
  GL_MIN_SAMPLE_SHADING_VALUE_ARB = $8C37;  
{////typedef void (P PFNGLMINSAMPLESHADINGARBPROC) (GLfloat value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMinSampleShadingARB(value:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_sample_shading */ }
{////#ifndef GL_ARB_sampler_objects }
const
  GL_ARB_sampler_objects = 1;  
{////#endif /* GL_ARB_sampler_objects */ }
{////#ifndef GL_ARB_seamless_cube_map }
  GL_ARB_seamless_cube_map = 1;  
{////#endif /* GL_ARB_seamless_cube_map */ }
{////#ifndef GL_ARB_seamless_cubemap_per_texture }
  GL_ARB_seamless_cubemap_per_texture = 1;  
{////#endif /* GL_ARB_seamless_cubemap_per_texture */ }
{////#ifndef GL_ARB_separate_shader_objects }
  GL_ARB_separate_shader_objects = 1;  
{////#endif /* GL_ARB_separate_shader_objects */ }
{////#ifndef GL_ARB_shader_atomic_counter_ops }
  GL_ARB_shader_atomic_counter_ops = 1;  
{////#endif /* GL_ARB_shader_atomic_counter_ops */ }
{////#ifndef GL_ARB_shader_atomic_counters }
  GL_ARB_shader_atomic_counters = 1;  
{////#endif /* GL_ARB_shader_atomic_counters */ }
{////#ifndef GL_ARB_shader_ballot }
  GL_ARB_shader_ballot = 1;  
{////#endif /* GL_ARB_shader_ballot */ }
{////#ifndef GL_ARB_shader_bit_encoding }
  GL_ARB_shader_bit_encoding = 1;  
{////#endif /* GL_ARB_shader_bit_encoding */ }
{////#ifndef GL_ARB_shader_clock }
  GL_ARB_shader_clock = 1;  
{////#endif /* GL_ARB_shader_clock */ }
{////#ifndef GL_ARB_shader_draw_parameters }
  GL_ARB_shader_draw_parameters = 1;  
{////#endif /* GL_ARB_shader_draw_parameters */ }
{////#ifndef GL_ARB_shader_group_vote }
  GL_ARB_shader_group_vote = 1;  
{////#endif /* GL_ARB_shader_group_vote */ }
{////#ifndef GL_ARB_shader_image_load_store }
  GL_ARB_shader_image_load_store = 1;  
{////#endif /* GL_ARB_shader_image_load_store */ }
{////#ifndef GL_ARB_shader_image_size }
  GL_ARB_shader_image_size = 1;  
{////#endif /* GL_ARB_shader_image_size */ }
{////#ifndef GL_ARB_shader_objects }
  GL_ARB_shader_objects = 1;  
{////#ifdef __APPLE__ }
{////#ifdef BUILDING_MESA }
{ Avoid uint <-> void* warnings  }
type
  PGLhandleARB = ^TGLhandleARB;
  TGLhandleARB = dword;
{////#else }

//  PGLhandleARB = ^TGLhandleARB;
//  TGLhandleARB = pointer;
{////#endif }
{////#else }

//  PGLhandleARB = ^TGLhandleARB;
//  TGLhandleARB = dword;
{////#endif }

PPGLcharARB = ^PGLcharARB;
PGLcharARB = ^TGLcharARB;
  TGLcharARB = char;

const
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
{////typedef void (P PFNGLDELETEOBJECTARBPROC) (GLhandleARB obj); }
{////typedef GLhandleARB (P PFNGLGETHANDLEARBPROC) (GLenum pname); }
{////typedef void (P PFNGLDETACHOBJECTARBPROC) (GLhandleARB containerObj, GLhandleARB attachedObj); }
{////typedef GLhandleARB (P PFNGLCREATESHADEROBJECTARBPROC) (GLenum shaderType); }
{////typedef void (P PFNGLSHADERSOURCEARBPROC) (GLhandleARB shaderObj, GLsizei count, const GLcharARB **string, const GLint *length); }
{////typedef void (P PFNGLCOMPILESHADERARBPROC) (GLhandleARB shaderObj); }
{////typedef GLhandleARB (P PFNGLCREATEPROGRAMOBJECTARBPROC) (void); }
{////typedef void (P PFNGLATTACHOBJECTARBPROC) (GLhandleARB containerObj, GLhandleARB obj); }
{////typedef void (P PFNGLLINKPROGRAMARBPROC) (GLhandleARB programObj); }
{////typedef void (P PFNGLUSEPROGRAMOBJECTARBPROC) (GLhandleARB programObj); }
{////typedef void (P PFNGLVALIDATEPROGRAMARBPROC) (GLhandleARB programObj); }
{////typedef void (P PFNGLUNIFORM1FARBPROC) (GLint location, GLfloat v0); }
{////typedef void (P PFNGLUNIFORM2FARBPROC) (GLint location, GLfloat v0, GLfloat v1); }
{////typedef void (P PFNGLUNIFORM3FARBPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2); }
{////typedef void (P PFNGLUNIFORM4FARBPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3); }
{////typedef void (P PFNGLUNIFORM1IARBPROC) (GLint location, GLint v0); }
{////typedef void (P PFNGLUNIFORM2IARBPROC) (GLint location, GLint v0, GLint v1); }
{////typedef void (P PFNGLUNIFORM3IARBPROC) (GLint location, GLint v0, GLint v1, GLint v2); }
{////typedef void (P PFNGLUNIFORM4IARBPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3); }
{////typedef void (P PFNGLUNIFORM1FVARBPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM2FVARBPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM3FVARBPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM4FVARBPROC) (GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORM1IVARBPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM2IVARBPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM3IVARBPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORM4IVARBPROC) (GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLUNIFORMMATRIX2FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX3FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLUNIFORMMATRIX4FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLGETOBJECTPARAMETERFVARBPROC) (GLhandleARB obj, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETOBJECTPARAMETERIVARBPROC) (GLhandleARB obj, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETINFOLOGARBPROC) (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *infoLog); }
{////typedef void (P PFNGLGETATTACHEDOBJECTSARBPROC) (GLhandleARB containerObj, GLsizei maxCount, GLsizei *count, GLhandleARB *obj); }
{////typedef GLint (P PFNGLGETUNIFORMLOCATIONARBPROC) (GLhandleARB programObj, const GLcharARB *name); }
{////typedef void (P PFNGLGETACTIVEUNIFORMARBPROC) (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name); }
{////typedef void (P PFNGLGETUNIFORMFVARBPROC) (GLhandleARB programObj, GLint location, GLfloat *params); }
{////typedef void (P PFNGLGETUNIFORMIVARBPROC) (GLhandleARB programObj, GLint location, GLint *params); }
{////typedef void (P PFNGLGETSHADERSOURCEARBPROC) (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *source); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDeleteObjectARB(obj:TGLhandleARB);cdecl;external;
function glGetHandleARB(pname:TGLenum):TGLhandleARB;cdecl;external;
procedure glDetachObjectARB(containerObj:TGLhandleARB; attachedObj:TGLhandleARB);cdecl;external;
function glCreateShaderObjectARB(shaderType:TGLenum):TGLhandleARB;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glShaderSourceARB(shaderObj:TGLhandleARB; count:TGLsizei; _string:PPGLcharARB; length:PGLint);cdecl;external;
procedure glCompileShaderARB(shaderObj:TGLhandleARB);cdecl;external;
function glCreateProgramObjectARB:TGLhandleARB;cdecl;external;
procedure glAttachObjectARB(containerObj:TGLhandleARB; obj:TGLhandleARB);cdecl;external;
procedure glLinkProgramARB(programObj:TGLhandleARB);cdecl;external;
procedure glUseProgramObjectARB(programObj:TGLhandleARB);cdecl;external;
procedure glValidateProgramARB(programObj:TGLhandleARB);cdecl;external;
procedure glUniform1fARB(location:TGLint; v0:TGLfloat);cdecl;external;
procedure glUniform2fARB(location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;external;
procedure glUniform3fARB(location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;external;
procedure glUniform4fARB(location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; v3:TGLfloat);cdecl;external;
procedure glUniform1iARB(location:TGLint; v0:TGLint);cdecl;external;
procedure glUniform2iARB(location:TGLint; v0:TGLint; v1:TGLint);cdecl;external;
procedure glUniform3iARB(location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;external;
procedure glUniform4iARB(location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; v3:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform1fvARB(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform2fvARB(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform3fvARB(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform4fvARB(location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniform1ivARB(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform2ivARB(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform3ivARB(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniform4ivARB(location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix2fvARB(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix3fvARB(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glUniformMatrix4fvARB(location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
procedure glGetObjectParameterfvARB(obj:TGLhandleARB; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetObjectParameterivARB(obj:TGLhandleARB; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetInfoLogARB(obj:TGLhandleARB; maxLength:TGLsizei; length:PGLsizei; infoLog:PGLcharARB);cdecl;external;
procedure glGetAttachedObjectsARB(containerObj:TGLhandleARB; maxCount:TGLsizei; count:PGLsizei; obj:PGLhandleARB);cdecl;external;
(* Const before type ignored *)
function glGetUniformLocationARB(programObj:TGLhandleARB; name:PGLcharARB):TGLint;cdecl;external;
procedure glGetActiveUniformARB(programObj:TGLhandleARB; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint; 
            _type:PGLenum; name:PGLcharARB);cdecl;external;
procedure glGetUniformfvARB(programObj:TGLhandleARB; location:TGLint; params:PGLfloat);cdecl;external;
procedure glGetUniformivARB(programObj:TGLhandleARB; location:TGLint; params:PGLint);cdecl;external;
procedure glGetShaderSourceARB(obj:TGLhandleARB; maxLength:TGLsizei; length:PGLsizei; source:PGLcharARB);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_shader_objects */ }
{////#ifndef GL_ARB_shader_precision }
const
  GL_ARB_shader_precision = 1;  
{////#endif /* GL_ARB_shader_precision */ }
{////#ifndef GL_ARB_shader_stencil_export }
  GL_ARB_shader_stencil_export = 1;  
{////#endif /* GL_ARB_shader_stencil_export */ }
{////#ifndef GL_ARB_shader_storage_buffer_object }
  GL_ARB_shader_storage_buffer_object = 1;  
{////#endif /* GL_ARB_shader_storage_buffer_object */ }
{////#ifndef GL_ARB_shader_subroutine }
  GL_ARB_shader_subroutine = 1;  
{////#endif /* GL_ARB_shader_subroutine */ }
{////#ifndef GL_ARB_shader_texture_image_samples }
  GL_ARB_shader_texture_image_samples = 1;  
{////#endif /* GL_ARB_shader_texture_image_samples */ }
{////#ifndef GL_ARB_shader_texture_lod }
  GL_ARB_shader_texture_lod = 1;  
{////#endif /* GL_ARB_shader_texture_lod */ }
{////#ifndef GL_ARB_shader_viewport_layer_array }
  GL_ARB_shader_viewport_layer_array = 1;  
{////#endif /* GL_ARB_shader_viewport_layer_array */ }
{////#ifndef GL_ARB_shading_language_100 }
  GL_ARB_shading_language_100 = 1;  
  GL_SHADING_LANGUAGE_VERSION_ARB = $8B8C;  
{////#endif /* GL_ARB_shading_language_100 */ }
{////#ifndef GL_ARB_shading_language_420pack }
  GL_ARB_shading_language_420pack = 1;  
{////#endif /* GL_ARB_shading_language_420pack */ }
{////#ifndef GL_ARB_shading_language_include }
  GL_ARB_shading_language_include = 1;  
  GL_SHADER_INCLUDE_ARB = $8DAE;  
  GL_NAMED_STRING_LENGTH_ARB = $8DE9;  
  GL_NAMED_STRING_TYPE_ARB = $8DEA;  
{////typedef void (P PFNGLNAMEDSTRINGARBPROC) (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string); }
{////typedef void (P PFNGLDELETENAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name); }
{////typedef void (P PFNGLCOMPILESHADERINCLUDEARBPROC) (GLuint shader, GLsizei count, const GLchar *const*path, const GLint *length); }
{////typedef GLboolean (P PFNGLISNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name); }
{////typedef void (P PFNGLGETNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string); }
{////typedef void (P PFNGLGETNAMEDSTRINGIVARBPROC) (GLint namelen, const GLchar *name, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)

procedure glNamedStringARB(_type:TGLenum; namelen:TGLint; name:PGLchar; stringlen:TGLint; _string:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glDeleteNamedStringARB(namelen:TGLint; name:PGLchar);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
(* Const before type ignored *)
procedure glCompileShaderIncludeARB(shader:TGLuint; count:TGLsizei; path:PPGLchar; length:PGLint);cdecl;external;
(* Const before type ignored *)
function glIsNamedStringARB(namelen:TGLint; name:PGLchar):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glGetNamedStringARB(namelen:TGLint; name:PGLchar; bufSize:TGLsizei; stringlen:PGLint; _string:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glGetNamedStringivARB(namelen:TGLint; name:PGLchar; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_shading_language_include */ }
{////#ifndef GL_ARB_shading_language_packing }
const
  GL_ARB_shading_language_packing = 1;  
{////#endif /* GL_ARB_shading_language_packing */ }
{////#ifndef GL_ARB_shadow }
  GL_ARB_shadow = 1;  
  GL_TEXTURE_COMPARE_MODE_ARB = $884C;  
  GL_TEXTURE_COMPARE_FUNC_ARB = $884D;  
  GL_COMPARE_R_TO_TEXTURE_ARB = $884E;  
{////#endif /* GL_ARB_shadow */ }
{////#ifndef GL_ARB_shadow_ambient }
  GL_ARB_shadow_ambient = 1;  
  GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = $80BF;  
{////#endif /* GL_ARB_shadow_ambient */ }
{////#ifndef GL_ARB_sparse_buffer }
  GL_ARB_sparse_buffer = 1;  
  GL_SPARSE_STORAGE_BIT_ARB = $0400;  
  GL_SPARSE_BUFFER_PAGE_SIZE_ARB = $82F8;  
{////typedef void (P PFNGLBUFFERPAGECOMMITMENTARBPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLboolean commit); }
{////typedef void (P PFNGLNAMEDBUFFERPAGECOMMITMENTEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit); }
{////typedef void (P PFNGLNAMEDBUFFERPAGECOMMITMENTARBPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBufferPageCommitmentARB(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; commit:TGLboolean);cdecl;external;
procedure glNamedBufferPageCommitmentEXT(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; commit:TGLboolean);cdecl;external;
procedure glNamedBufferPageCommitmentARB(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; commit:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_sparse_buffer */ }
{////#ifndef GL_ARB_sparse_texture }
const
  GL_ARB_sparse_texture = 1;  
  GL_TEXTURE_SPARSE_ARB = $91A6;  
  GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = $91A7;  
  GL_NUM_SPARSE_LEVELS_ARB = $91AA;  
  GL_NUM_VIRTUAL_PAGE_SIZES_ARB = $91A8;  
  GL_VIRTUAL_PAGE_SIZE_X_ARB = $9195;  
  GL_VIRTUAL_PAGE_SIZE_Y_ARB = $9196;  
  GL_VIRTUAL_PAGE_SIZE_Z_ARB = $9197;  
  GL_MAX_SPARSE_TEXTURE_SIZE_ARB = $9198;  
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = $9199;  
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = $919A;  
  GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = $91A9;  
{////typedef void (P PFNGLTEXPAGECOMMITMENTARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexPageCommitmentARB(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; commit:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_sparse_texture */ }
{////#ifndef GL_ARB_sparse_texture2 }
const
  GL_ARB_sparse_texture2 = 1;  
{////#endif /* GL_ARB_sparse_texture2 */ }
{////#ifndef GL_ARB_sparse_texture_clamp }
  GL_ARB_sparse_texture_clamp = 1;  
{////#endif /* GL_ARB_sparse_texture_clamp */ }
{////#ifndef GL_ARB_spirv_extensions }
  GL_ARB_spirv_extensions = 1;  
{////#endif /* GL_ARB_spirv_extensions */ }
{////#ifndef GL_ARB_stencil_texturing }
  GL_ARB_stencil_texturing = 1;  
{////#endif /* GL_ARB_stencil_texturing */ }
{////#ifndef GL_ARB_sync }
  GL_ARB_sync = 1;  
{////#endif /* GL_ARB_sync */ }
{////#ifndef GL_ARB_tessellation_shader }
  GL_ARB_tessellation_shader = 1;  
{////#endif /* GL_ARB_tessellation_shader */ }
{////#ifndef GL_ARB_texture_barrier }
  GL_ARB_texture_barrier = 1;  
{////#endif /* GL_ARB_texture_barrier */ }
{////#ifndef GL_ARB_texture_border_clamp }
  GL_ARB_texture_border_clamp = 1;  
  GL_CLAMP_TO_BORDER_ARB = $812D;  
{////#endif /* GL_ARB_texture_border_clamp */ }
{////#ifndef GL_ARB_texture_buffer_object }
  GL_ARB_texture_buffer_object = 1;  
  GL_TEXTURE_BUFFER_ARB = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE_ARB = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER_ARB = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = $8C2D;  
  GL_TEXTURE_BUFFER_FORMAT_ARB = $8C2E;  
{////typedef void (P PFNGLTEXBUFFERARBPROC) (GLenum target, GLenum internalformat, GLuint buffer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexBufferARB(target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_texture_buffer_object */ }
{////#ifndef GL_ARB_texture_buffer_object_rgb32 }
const
  GL_ARB_texture_buffer_object_rgb32 = 1;  
{////#endif /* GL_ARB_texture_buffer_object_rgb32 */ }
{////#ifndef GL_ARB_texture_buffer_range }
  GL_ARB_texture_buffer_range = 1;  
{////#endif /* GL_ARB_texture_buffer_range */ }
{////#ifndef GL_ARB_texture_compression }
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
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE3DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE2DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXIMAGE1DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data); }
{////typedef void (P PFNGLGETCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint level, void *img); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glCompressedTexImage3DARB(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexImage2DARB(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            border:TGLint; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexImage1DARB(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; border:TGLint; 
            imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage3DARB(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; imageSize:TGLsizei; 
            data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage2DARB(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; imageSize:TGLsizei; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTexSubImage1DARB(target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            imageSize:TGLsizei; data:pointer);cdecl;external;
procedure glGetCompressedTexImageARB(target:TGLenum; level:TGLint; img:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_texture_compression */ }
{////#ifndef GL_ARB_texture_compression_bptc }
const
  GL_ARB_texture_compression_bptc = 1;  
  GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = $8E8C;  
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = $8E8D;  
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = $8E8E;  
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = $8E8F;  
{////#endif /* GL_ARB_texture_compression_bptc */ }
{////#ifndef GL_ARB_texture_compression_rgtc }
  GL_ARB_texture_compression_rgtc = 1;  
{////#endif /* GL_ARB_texture_compression_rgtc */ }
{////#ifndef GL_ARB_texture_cube_map }
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
{////#endif /* GL_ARB_texture_cube_map */ }
{////#ifndef GL_ARB_texture_cube_map_array }
  GL_ARB_texture_cube_map_array = 1;  
  GL_TEXTURE_CUBE_MAP_ARRAY_ARB = $9009;  
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = $900A;  
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = $900B;  
  GL_SAMPLER_CUBE_MAP_ARRAY_ARB = $900C;  
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = $900D;  
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900E;  
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900F;  
{////#endif /* GL_ARB_texture_cube_map_array */ }
{////#ifndef GL_ARB_texture_env_add }
  GL_ARB_texture_env_add = 1;  
{////#endif /* GL_ARB_texture_env_add */ }
{////#ifndef GL_ARB_texture_env_combine }
  GL_ARB_texture_env_combine = 1;  
  GL_COMBINE_ARB = $8570;  
  GL_COMBINE_RGB_ARB = $8571;  
  GL_COMBINE_ALPHA_ARB = $8572;  
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
  GL_RGB_SCALE_ARB = $8573;  
  GL_ADD_SIGNED_ARB = $8574;  
  GL_INTERPOLATE_ARB = $8575;  
  GL_SUBTRACT_ARB = $84E7;  
  GL_CONSTANT_ARB = $8576;  
  GL_PRIMARY_COLOR_ARB = $8577;  
  GL_PREVIOUS_ARB = $8578;  
{////#endif /* GL_ARB_texture_env_combine */ }
{////#ifndef GL_ARB_texture_env_crossbar }
  GL_ARB_texture_env_crossbar = 1;  
{////#endif /* GL_ARB_texture_env_crossbar */ }
{////#ifndef GL_ARB_texture_env_dot3 }
  GL_ARB_texture_env_dot3 = 1;  
  GL_DOT3_RGB_ARB = $86AE;  
  GL_DOT3_RGBA_ARB = $86AF;  
{////#endif /* GL_ARB_texture_env_dot3 */ }
{////#ifndef GL_ARB_texture_filter_anisotropic }
  GL_ARB_texture_filter_anisotropic = 1;  
{////#endif /* GL_ARB_texture_filter_anisotropic */ }
{////#ifndef GL_ARB_texture_filter_minmax }
  GL_ARB_texture_filter_minmax = 1;  
  GL_TEXTURE_REDUCTION_MODE_ARB = $9366;  
  GL_WEIGHTED_AVERAGE_ARB = $9367;  
{////#endif /* GL_ARB_texture_filter_minmax */ }
{////#ifndef GL_ARB_texture_float }
  GL_ARB_texture_float = 1;  
  GL_TEXTURE_RED_TYPE_ARB = $8C10;  
  GL_TEXTURE_GREEN_TYPE_ARB = $8C11;  
  GL_TEXTURE_BLUE_TYPE_ARB = $8C12;  
  GL_TEXTURE_ALPHA_TYPE_ARB = $8C13;  
  GL_TEXTURE_LUMINANCE_TYPE_ARB = $8C14;  
  GL_TEXTURE_INTENSITY_TYPE_ARB = $8C15;  
  GL_TEXTURE_DEPTH_TYPE_ARB = $8C16;  
  GL_UNSIGNED_NORMALIZED_ARB = $8C17;  
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
{////#endif /* GL_ARB_texture_float */ }
{////#ifndef GL_ARB_texture_gather }
  GL_ARB_texture_gather = 1;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5F;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = $8F9F;  
{////#endif /* GL_ARB_texture_gather */ }
{////#ifndef GL_ARB_texture_mirror_clamp_to_edge }
  GL_ARB_texture_mirror_clamp_to_edge = 1;  
{////#endif /* GL_ARB_texture_mirror_clamp_to_edge */ }
{////#ifndef GL_ARB_texture_mirrored_repeat }
  GL_ARB_texture_mirrored_repeat = 1;  
  GL_MIRRORED_REPEAT_ARB = $8370;  
{////#endif /* GL_ARB_texture_mirrored_repeat */ }
{////#ifndef GL_ARB_texture_multisample }
  GL_ARB_texture_multisample = 1;  
{////#endif /* GL_ARB_texture_multisample */ }
{////#ifndef GL_ARB_texture_non_power_of_two }
  GL_ARB_texture_non_power_of_two = 1;  
{////#endif /* GL_ARB_texture_non_power_of_two */ }
{////#ifndef GL_ARB_texture_query_levels }
  GL_ARB_texture_query_levels = 1;  
{////#endif /* GL_ARB_texture_query_levels */ }
{////#ifndef GL_ARB_texture_query_lod }
  GL_ARB_texture_query_lod = 1;  
{////#endif /* GL_ARB_texture_query_lod */ }
{////#ifndef GL_ARB_texture_rectangle }
  GL_ARB_texture_rectangle = 1;  
  GL_TEXTURE_RECTANGLE_ARB = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE_ARB = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE_ARB = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = $84F8;  
{////#endif /* GL_ARB_texture_rectangle */ }
{////#ifndef GL_ARB_texture_rg }
  GL_ARB_texture_rg = 1;  
{////#endif /* GL_ARB_texture_rg */ }
{////#ifndef GL_ARB_texture_rgb10_a2ui }
  GL_ARB_texture_rgb10_a2ui = 1;  
{////#endif /* GL_ARB_texture_rgb10_a2ui */ }
{////#ifndef GL_ARB_texture_stencil8 }
  GL_ARB_texture_stencil8 = 1;  
{////#endif /* GL_ARB_texture_stencil8 */ }
{////#ifndef GL_ARB_texture_storage }
  GL_ARB_texture_storage = 1;  
{////#endif /* GL_ARB_texture_storage */ }
{////#ifndef GL_ARB_texture_storage_multisample }
  GL_ARB_texture_storage_multisample = 1;  
{////#endif /* GL_ARB_texture_storage_multisample */ }
{////#ifndef GL_ARB_texture_swizzle }
  GL_ARB_texture_swizzle = 1;  
{////#endif /* GL_ARB_texture_swizzle */ }
{////#ifndef GL_ARB_texture_view }
  GL_ARB_texture_view = 1;  
{////#endif /* GL_ARB_texture_view */ }
{////#ifndef GL_ARB_timer_query }
  GL_ARB_timer_query = 1;  
{////#endif /* GL_ARB_timer_query */ }
{////#ifndef GL_ARB_transform_feedback2 }
  GL_ARB_transform_feedback2 = 1;  
{////#endif /* GL_ARB_transform_feedback2 */ }
{////#ifndef GL_ARB_transform_feedback3 }
  GL_ARB_transform_feedback3 = 1;  
{////#endif /* GL_ARB_transform_feedback3 */ }
{////#ifndef GL_ARB_transform_feedback_instanced }
  GL_ARB_transform_feedback_instanced = 1;  
{////#endif /* GL_ARB_transform_feedback_instanced */ }
{////#ifndef GL_ARB_transform_feedback_overflow_query }
  GL_ARB_transform_feedback_overflow_query = 1;  
  GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = $82EC;  
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = $82ED;  
{////#endif /* GL_ARB_transform_feedback_overflow_query */ }
{////#ifndef GL_ARB_transpose_matrix }
  GL_ARB_transpose_matrix = 1;  
  GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = $84E3;  
  GL_TRANSPOSE_PROJECTION_MATRIX_ARB = $84E4;  
  GL_TRANSPOSE_TEXTURE_MATRIX_ARB = $84E5;  
  GL_TRANSPOSE_COLOR_MATRIX_ARB = $84E6;  
{////typedef void (P PFNGLLOADTRANSPOSEMATRIXFARBPROC) (const GLfloat *m); }
{////typedef void (P PFNGLLOADTRANSPOSEMATRIXDARBPROC) (const GLdouble *m); }
{////typedef void (P PFNGLMULTTRANSPOSEMATRIXFARBPROC) (const GLfloat *m); }
{////typedef void (P PFNGLMULTTRANSPOSEMATRIXDARBPROC) (const GLdouble *m); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glLoadTransposeMatrixfARB(m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glLoadTransposeMatrixdARB(m:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultTransposeMatrixfARB(m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultTransposeMatrixdARB(m:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_transpose_matrix */ }
{////#ifndef GL_ARB_uniform_buffer_object }
const
  GL_ARB_uniform_buffer_object = 1;  
{////#endif /* GL_ARB_uniform_buffer_object */ }
{////#ifndef GL_ARB_vertex_array_bgra }
  GL_ARB_vertex_array_bgra = 1;  
{////#endif /* GL_ARB_vertex_array_bgra */ }
{////#ifndef GL_ARB_vertex_array_object }
  GL_ARB_vertex_array_object = 1;  
{////#endif /* GL_ARB_vertex_array_object */ }
{////#ifndef GL_ARB_vertex_attrib_64bit }
  GL_ARB_vertex_attrib_64bit = 1;  
{////#endif /* GL_ARB_vertex_attrib_64bit */ }
{////#ifndef GL_ARB_vertex_attrib_binding }
  GL_ARB_vertex_attrib_binding = 1;  
{////#endif /* GL_ARB_vertex_attrib_binding */ }
{////#ifndef GL_ARB_vertex_blend }
  GL_ARB_vertex_blend = 1;  
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
  GL_MODELVIEW0_ARB = $1700;  
  GL_MODELVIEW1_ARB = $850A;  
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
{////typedef void (P PFNGLWEIGHTBVARBPROC) (GLint size, const GLbyte *weights); }
{////typedef void (P PFNGLWEIGHTSVARBPROC) (GLint size, const GLshort *weights); }
{////typedef void (P PFNGLWEIGHTIVARBPROC) (GLint size, const GLint *weights); }
{////typedef void (P PFNGLWEIGHTFVARBPROC) (GLint size, const GLfloat *weights); }
{////typedef void (P PFNGLWEIGHTDVARBPROC) (GLint size, const GLdouble *weights); }
{////typedef void (P PFNGLWEIGHTUBVARBPROC) (GLint size, const GLubyte *weights); }
{////typedef void (P PFNGLWEIGHTUSVARBPROC) (GLint size, const GLushort *weights); }
{////typedef void (P PFNGLWEIGHTUIVARBPROC) (GLint size, const GLuint *weights); }
{////typedef void (P PFNGLWEIGHTPOINTERARBPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLVERTEXBLENDARBPROC) (GLint count); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glWeightbvARB(size:TGLint; weights:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glWeightsvARB(size:TGLint; weights:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWeightivARB(size:TGLint; weights:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glWeightfvARB(size:TGLint; weights:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWeightdvARB(size:TGLint; weights:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWeightubvARB(size:TGLint; weights:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glWeightusvARB(size:TGLint; weights:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glWeightuivARB(size:TGLint; weights:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glWeightPointerARB(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glVertexBlendARB(count:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_vertex_blend */ }
{////#ifndef GL_ARB_vertex_buffer_object }
const
  GL_ARB_vertex_buffer_object = 1;  
type
  PGLsizeiptrARB = ^TGLsizeiptrARB;
  TGLsizeiptrARB = SizeInt;

  PGLintptrARB = ^TGLintptrARB;
  TGLintptrARB = PtrInt;

const
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
{////typedef void (P PFNGLBINDBUFFERARBPROC) (GLenum target, GLuint buffer); }
{////typedef void (P PFNGLDELETEBUFFERSARBPROC) (GLsizei n, const GLuint *buffers); }
{////typedef void (P PFNGLGENBUFFERSARBPROC) (GLsizei n, GLuint *buffers); }
{////typedef GLboolean (P PFNGLISBUFFERARBPROC) (GLuint buffer); }
{////typedef void (P PFNGLBUFFERDATAARBPROC) (GLenum target, GLsizeiptrARB size, const void *data, GLenum usage); }
{////typedef void (P PFNGLBUFFERSUBDATAARBPROC) (GLenum target, GLintptrARB offset, GLsizeiptrARB size, const void *data); }
{////typedef void (P PFNGLGETBUFFERSUBDATAARBPROC) (GLenum target, GLintptrARB offset, GLsizeiptrARB size, void *data); }
{////typedef void *(P PFNGLMAPBUFFERARBPROC) (GLenum target, GLenum access); }
{////typedef GLboolean (P PFNGLUNMAPBUFFERARBPROC) (GLenum target); }
{////typedef void (P PFNGLGETBUFFERPARAMETERIVARBPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETBUFFERPOINTERVARBPROC) (GLenum target, GLenum pname, void **params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBindBufferARB(target:TGLenum; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteBuffersARB(n:TGLsizei; buffers:PGLuint);cdecl;external;
procedure glGenBuffersARB(n:TGLsizei; buffers:PGLuint);cdecl;external;
function glIsBufferARB(buffer:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glBufferDataARB(target:TGLenum; size:TGLsizeiptrARB; data:pointer; usage:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glBufferSubDataARB(target:TGLenum; offset:TGLintptrARB; size:TGLsizeiptrARB; data:pointer);cdecl;external;
procedure glGetBufferSubDataARB(target:TGLenum; offset:TGLintptrARB; size:TGLsizeiptrARB; data:pointer);cdecl;external;
function glMapBufferARB(target:TGLenum; access:TGLenum):pointer;cdecl;external;
function glUnmapBufferARB(target:TGLenum):TGLboolean;cdecl;external;
procedure glGetBufferParameterivARB(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetBufferPointervARB(target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_vertex_buffer_object */ }
{////#ifndef GL_ARB_vertex_program }
const
  GL_ARB_vertex_program = 1;  
  GL_COLOR_SUM_ARB = $8458;  
  GL_VERTEX_PROGRAM_ARB = $8620;  
  GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = $8622;  
  GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = $8623;  
  GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = $8624;  
  GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = $8625;  
  GL_CURRENT_VERTEX_ATTRIB_ARB = $8626;  
  GL_VERTEX_PROGRAM_POINT_SIZE_ARB = $8642;  
  GL_VERTEX_PROGRAM_TWO_SIDE_ARB = $8643;  
  GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = $8645;  
  GL_MAX_VERTEX_ATTRIBS_ARB = $8869;  
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = $886A;  
  GL_PROGRAM_ADDRESS_REGISTERS_ARB = $88B0;  
  GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = $88B1;  
  GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B2;  
  GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B3;  
{////typedef void (P PFNGLVERTEXATTRIB1DARBPROC) (GLuint index, GLdouble x); }
{////typedef void (P PFNGLVERTEXATTRIB1DVARBPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB1FARBPROC) (GLuint index, GLfloat x); }
{////typedef void (P PFNGLVERTEXATTRIB1FVARBPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB1SARBPROC) (GLuint index, GLshort x); }
{////typedef void (P PFNGLVERTEXATTRIB1SVARBPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB2DARBPROC) (GLuint index, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXATTRIB2DVARBPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB2FARBPROC) (GLuint index, GLfloat x, GLfloat y); }
{////typedef void (P PFNGLVERTEXATTRIB2FVARBPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB2SARBPROC) (GLuint index, GLshort x, GLshort y); }
{////typedef void (P PFNGLVERTEXATTRIB2SVARBPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB3DARBPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXATTRIB3DVARBPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB3FARBPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLVERTEXATTRIB3FVARBPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB3SARBPROC) (GLuint index, GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLVERTEXATTRIB3SVARBPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NBVARBPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NIVARBPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NSVARBPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUBARBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w); }
{////typedef void (P PFNGLVERTEXATTRIB4NUBVARBPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUIVARBPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4NUSVARBPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4BVARBPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4DARBPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXATTRIB4DVARBPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB4FARBPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLVERTEXATTRIB4FVARBPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB4IVARBPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4SARBPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w); }
{////typedef void (P PFNGLVERTEXATTRIB4SVARBPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4UBVARBPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIB4UIVARBPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIB4USVARBPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLVERTEXATTRIBPOINTERARBPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLENABLEVERTEXATTRIBARRAYARBPROC) (GLuint index); }
{////typedef void (P PFNGLDISABLEVERTEXATTRIBARRAYARBPROC) (GLuint index); }
{////typedef void (P PFNGLGETVERTEXATTRIBDVARBPROC) (GLuint index, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBFVARBPROC) (GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBIVARBPROC) (GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBPOINTERVARBPROC) (GLuint index, GLenum pname, void **pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttrib1dARB(index:TGLuint; x:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1dvARB(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib1fARB(index:TGLuint; x:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1fvARB(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib1sARB(index:TGLuint; x:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1svARB(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib2dARB(index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2dvARB(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib2fARB(index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2fvARB(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib2sARB(index:TGLuint; x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2svARB(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib3dARB(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3dvARB(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib3fARB(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3fvARB(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib3sARB(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3svARB(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NbvARB(index:TGLuint; v:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NivARB(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NsvARB(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib4NubARB(index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NubvARB(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NuivARB(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4NusvARB(index:TGLuint; v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4bvARB(index:TGLuint; v:PGLbyte);cdecl;external;
procedure glVertexAttrib4dARB(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4dvARB(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib4fARB(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4fvARB(index:TGLuint; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4ivARB(index:TGLuint; v:PGLint);cdecl;external;
procedure glVertexAttrib4sARB(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4svARB(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4ubvARB(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4uivARB(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4usvARB(index:TGLuint; v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribPointerARB(index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei; 
            pointer:pointer);cdecl;external;
procedure glEnableVertexAttribArrayARB(index:TGLuint);cdecl;external;
procedure glDisableVertexAttribArrayARB(index:TGLuint);cdecl;external;
procedure glGetVertexAttribdvARB(index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glGetVertexAttribfvARB(index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVertexAttribivARB(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribPointervARB(index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_vertex_program */ }
{////#ifndef GL_ARB_vertex_shader }
const
  GL_ARB_vertex_shader = 1;  
  GL_VERTEX_SHADER_ARB = $8B31;  
  GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = $8B4A;  
  GL_MAX_VARYING_FLOATS_ARB = $8B4B;  
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;  
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = $8B4D;  
  GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = $8B89;  
  GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = $8B8A;  
{////typedef void (P PFNGLBINDATTRIBLOCATIONARBPROC) (GLhandleARB programObj, GLuint index, const GLcharARB *name); }
{////typedef void (P PFNGLGETACTIVEATTRIBARBPROC) (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name); }
{////typedef GLint (P PFNGLGETATTRIBLOCATIONARBPROC) (GLhandleARB programObj, const GLcharARB *name); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glBindAttribLocationARB(programObj:TGLhandleARB; index:TGLuint; name:PGLcharARB);cdecl;external;
procedure glGetActiveAttribARB(programObj:TGLhandleARB; index:TGLuint; maxLength:TGLsizei; length:PGLsizei; size:PGLint; 
            _type:PGLenum; name:PGLcharARB);cdecl;external;
(* Const before type ignored *)
function glGetAttribLocationARB(programObj:TGLhandleARB; name:PGLcharARB):TGLint;cdecl;external;
{////#endif }
{////#endif /* GL_ARB_vertex_shader */ }
{////#ifndef GL_ARB_vertex_type_10f_11f_11f_rev }
const
  GL_ARB_vertex_type_10f_11f_11f_rev = 1;  
{////#endif /* GL_ARB_vertex_type_10f_11f_11f_rev */ }
{////#ifndef GL_ARB_vertex_type_2_10_10_10_rev }
  GL_ARB_vertex_type_2_10_10_10_rev = 1;  
{////#endif /* GL_ARB_vertex_type_2_10_10_10_rev */ }
{////#ifndef GL_ARB_viewport_array }
  GL_ARB_viewport_array = 1;  
{////typedef void (P PFNGLDEPTHRANGEARRAYDVNVPROC) (GLuint first, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLDEPTHRANGEINDEXEDDNVPROC) (GLuint index, GLdouble n, GLdouble f); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDepthRangeArraydvNV(first:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
procedure glDepthRangeIndexeddNV(index:TGLuint; n:TGLdouble; f:TGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_viewport_array */ }
{////#ifndef GL_ARB_window_pos }
const
  GL_ARB_window_pos = 1;  
{////typedef void (P PFNGLWINDOWPOS2DARBPROC) (GLdouble x, GLdouble y); }
{////typedef void (P PFNGLWINDOWPOS2DVARBPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS2FARBPROC) (GLfloat x, GLfloat y); }
{////typedef void (P PFNGLWINDOWPOS2FVARBPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS2IARBPROC) (GLint x, GLint y); }
{////typedef void (P PFNGLWINDOWPOS2IVARBPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS2SARBPROC) (GLshort x, GLshort y); }
{////typedef void (P PFNGLWINDOWPOS2SVARBPROC) (const GLshort *v); }
{////typedef void (P PFNGLWINDOWPOS3DARBPROC) (GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLWINDOWPOS3DVARBPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS3FARBPROC) (GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLWINDOWPOS3FVARBPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS3IARBPROC) (GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLWINDOWPOS3IVARBPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS3SARBPROC) (GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLWINDOWPOS3SVARBPROC) (const GLshort *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glWindowPos2dARB(x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2dvARB(v:PGLdouble);cdecl;external;
procedure glWindowPos2fARB(x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2fvARB(v:PGLfloat);cdecl;external;
procedure glWindowPos2iARB(x:TGLint; y:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2ivARB(v:PGLint);cdecl;external;
procedure glWindowPos2sARB(x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2svARB(v:PGLshort);cdecl;external;
procedure glWindowPos3dARB(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3dvARB(v:PGLdouble);cdecl;external;
procedure glWindowPos3fARB(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3fvARB(v:PGLfloat);cdecl;external;
procedure glWindowPos3iARB(x:TGLint; y:TGLint; z:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3ivARB(v:PGLint);cdecl;external;
procedure glWindowPos3sARB(x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3svARB(v:PGLshort);cdecl;external;
{////#endif }
{////#endif /* GL_ARB_window_pos */ }
{////#ifndef GL_KHR_blend_equation_advanced }
const
  GL_KHR_blend_equation_advanced = 1;  
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
{////typedef void (P PFNGLBLENDBARRIERKHRPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendBarrierKHR;cdecl;external;
{////#endif }
{////#endif /* GL_KHR_blend_equation_advanced */ }
{////#ifndef GL_KHR_blend_equation_advanced_coherent }
const
  GL_KHR_blend_equation_advanced_coherent = 1;  
  GL_BLEND_ADVANCED_COHERENT_KHR = $9285;  
{////#endif /* GL_KHR_blend_equation_advanced_coherent */ }
{////#ifndef GL_KHR_context_flush_control }
  GL_KHR_context_flush_control = 1;  
{////#endif /* GL_KHR_context_flush_control */ }
{////#ifndef GL_KHR_debug }
  GL_KHR_debug = 1;  
{////#endif /* GL_KHR_debug */ }
{////#ifndef GL_KHR_no_error }
  GL_KHR_no_error = 1;  
  GL_CONTEXT_FLAG_NO_ERROR_BIT_KHR = $00000008;  
{////#endif /* GL_KHR_no_error */ }
{////#ifndef GL_KHR_parallel_shader_compile }
  GL_KHR_parallel_shader_compile = 1;  
  GL_MAX_SHADER_COMPILER_THREADS_KHR = $91B0;  
  GL_COMPLETION_STATUS_KHR = $91B1;  
{////typedef void (P PFNGLMAXSHADERCOMPILERTHREADSKHRPROC) (GLuint count); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMaxShaderCompilerThreadsKHR(count:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_KHR_parallel_shader_compile */ }
{////#ifndef GL_KHR_robust_buffer_access_behavior }
const
  GL_KHR_robust_buffer_access_behavior = 1;  
{////#endif /* GL_KHR_robust_buffer_access_behavior */ }
{////#ifndef GL_KHR_robustness }
  GL_KHR_robustness = 1;  
  GL_CONTEXT_ROBUST_ACCESS = $90F3;  
{////#endif /* GL_KHR_robustness */ }
{////#ifndef GL_KHR_shader_subgroup }
  GL_KHR_shader_subgroup = 1;  
  GL_SUBGROUP_SIZE_KHR = $9532;  
  GL_SUBGROUP_SUPPORTED_STAGES_KHR = $9533;  
  GL_SUBGROUP_SUPPORTED_FEATURES_KHR = $9534;  
  GL_SUBGROUP_QUAD_ALL_STAGES_KHR = $9535;  
  GL_SUBGROUP_FEATURE_BASIC_BIT_KHR = $00000001;  
  GL_SUBGROUP_FEATURE_VOTE_BIT_KHR = $00000002;  
  GL_SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = $00000004;  
  GL_SUBGROUP_FEATURE_BALLOT_BIT_KHR = $00000008;  
  GL_SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = $00000010;  
  GL_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = $00000020;  
  GL_SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = $00000040;  
  GL_SUBGROUP_FEATURE_QUAD_BIT_KHR = $00000080;  
{////#endif /* GL_KHR_shader_subgroup */ }
{////#ifndef GL_KHR_texture_compression_astc_hdr }
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
{////#endif /* GL_KHR_texture_compression_astc_hdr */ }
{////#ifndef GL_KHR_texture_compression_astc_ldr }
  GL_KHR_texture_compression_astc_ldr = 1;  
{////#endif /* GL_KHR_texture_compression_astc_ldr */ }
{////#ifndef GL_KHR_texture_compression_astc_sliced_3d }
  GL_KHR_texture_compression_astc_sliced_3d = 1;  
{////#endif /* GL_KHR_texture_compression_astc_sliced_3d */ }
{////#ifndef GL_OES_byte_coordinates }
  GL_OES_byte_coordinates = 1;  
{////typedef void (P PFNGLMULTITEXCOORD1BOESPROC) (GLenum texture, GLbyte s); }
{////typedef void (P PFNGLMULTITEXCOORD1BVOESPROC) (GLenum texture, const GLbyte *coords); }
{////typedef void (P PFNGLMULTITEXCOORD2BOESPROC) (GLenum texture, GLbyte s, GLbyte t); }
{////typedef void (P PFNGLMULTITEXCOORD2BVOESPROC) (GLenum texture, const GLbyte *coords); }
{////typedef void (P PFNGLMULTITEXCOORD3BOESPROC) (GLenum texture, GLbyte s, GLbyte t, GLbyte r); }
{////typedef void (P PFNGLMULTITEXCOORD3BVOESPROC) (GLenum texture, const GLbyte *coords); }
{////typedef void (P PFNGLMULTITEXCOORD4BOESPROC) (GLenum texture, GLbyte s, GLbyte t, GLbyte r, GLbyte q); }
{////typedef void (P PFNGLMULTITEXCOORD4BVOESPROC) (GLenum texture, const GLbyte *coords); }
{////typedef void (P PFNGLTEXCOORD1BOESPROC) (GLbyte s); }
{////typedef void (P PFNGLTEXCOORD1BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLTEXCOORD2BOESPROC) (GLbyte s, GLbyte t); }
{////typedef void (P PFNGLTEXCOORD2BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLTEXCOORD3BOESPROC) (GLbyte s, GLbyte t, GLbyte r); }
{////typedef void (P PFNGLTEXCOORD3BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLTEXCOORD4BOESPROC) (GLbyte s, GLbyte t, GLbyte r, GLbyte q); }
{////typedef void (P PFNGLTEXCOORD4BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLVERTEX2BOESPROC) (GLbyte x, GLbyte y); }
{////typedef void (P PFNGLVERTEX2BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLVERTEX3BOESPROC) (GLbyte x, GLbyte y, GLbyte z); }
{////typedef void (P PFNGLVERTEX3BVOESPROC) (const GLbyte *coords); }
{////typedef void (P PFNGLVERTEX4BOESPROC) (GLbyte x, GLbyte y, GLbyte z, GLbyte w); }
{////typedef void (P PFNGLVERTEX4BVOESPROC) (const GLbyte *coords); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMultiTexCoord1bOES(texture:TGLenum; s:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1bvOES(texture:TGLenum; coords:PGLbyte);cdecl;external;
procedure glMultiTexCoord2bOES(texture:TGLenum; s:TGLbyte; t:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2bvOES(texture:TGLenum; coords:PGLbyte);cdecl;external;
procedure glMultiTexCoord3bOES(texture:TGLenum; s:TGLbyte; t:TGLbyte; r:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3bvOES(texture:TGLenum; coords:PGLbyte);cdecl;external;
procedure glMultiTexCoord4bOES(texture:TGLenum; s:TGLbyte; t:TGLbyte; r:TGLbyte; q:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4bvOES(texture:TGLenum; coords:PGLbyte);cdecl;external;
procedure glTexCoord1bOES(s:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord1bvOES(coords:PGLbyte);cdecl;external;
procedure glTexCoord2bOES(s:TGLbyte; t:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord2bvOES(coords:PGLbyte);cdecl;external;
procedure glTexCoord3bOES(s:TGLbyte; t:TGLbyte; r:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord3bvOES(coords:PGLbyte);cdecl;external;
procedure glTexCoord4bOES(s:TGLbyte; t:TGLbyte; r:TGLbyte; q:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord4bvOES(coords:PGLbyte);cdecl;external;
procedure glVertex2bOES(x:TGLbyte; y:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertex2bvOES(coords:PGLbyte);cdecl;external;
procedure glVertex3bOES(x:TGLbyte; y:TGLbyte; z:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertex3bvOES(coords:PGLbyte);cdecl;external;
procedure glVertex4bOES(x:TGLbyte; y:TGLbyte; z:TGLbyte; w:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertex4bvOES(coords:PGLbyte);cdecl;external;
{////#endif }
{////#endif /* GL_OES_byte_coordinates */ }
{////#ifndef GL_OES_compressed_paletted_texture }
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
{////#endif /* GL_OES_compressed_paletted_texture */ }
{////#ifndef GL_OES_fixed_point }
  GL_OES_fixed_point = 1;  
type
  PGLfixed = ^TGLfixed;
  TGLfixed = int32;

const
  GL_FIXED_OES = $140C;  
{////typedef void (P PFNGLALPHAFUNCXOESPROC) (GLenum func, GLfixed ref); }
{////typedef void (P PFNGLCLEARCOLORXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha); }
{////typedef void (P PFNGLCLEARDEPTHXOESPROC) (GLfixed depth); }
{////typedef void (P PFNGLCLIPPLANEXOESPROC) (GLenum plane, const GLfixed *equation); }
{////typedef void (P PFNGLCOLOR4XOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha); }
{////typedef void (P PFNGLDEPTHRANGEXOESPROC) (GLfixed n, GLfixed f); }
{////typedef void (P PFNGLFOGXOESPROC) (GLenum pname, GLfixed param); }
{////typedef void (P PFNGLFOGXVOESPROC) (GLenum pname, const GLfixed *param); }
{////typedef void (P PFNGLFRUSTUMXOESPROC) (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f); }
{////typedef void (P PFNGLGETCLIPPLANEXOESPROC) (GLenum plane, GLfixed *equation); }
{////typedef void (P PFNGLGETFIXEDVOESPROC) (GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETTEXENVXVOESPROC) (GLenum target, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETTEXPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLLIGHTMODELXOESPROC) (GLenum pname, GLfixed param); }
{////typedef void (P PFNGLLIGHTMODELXVOESPROC) (GLenum pname, const GLfixed *param); }
{////typedef void (P PFNGLLIGHTXOESPROC) (GLenum light, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLLIGHTXVOESPROC) (GLenum light, GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLLINEWIDTHXOESPROC) (GLfixed width); }
{////typedef void (P PFNGLLOADMATRIXXOESPROC) (const GLfixed *m); }
{////typedef void (P PFNGLMATERIALXOESPROC) (GLenum face, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLMATERIALXVOESPROC) (GLenum face, GLenum pname, const GLfixed *param); }
{////typedef void (P PFNGLMULTMATRIXXOESPROC) (const GLfixed *m); }
{////typedef void (P PFNGLMULTITEXCOORD4XOESPROC) (GLenum texture, GLfixed s, GLfixed t, GLfixed r, GLfixed q); }
{////typedef void (P PFNGLNORMAL3XOESPROC) (GLfixed nx, GLfixed ny, GLfixed nz); }
{////typedef void (P PFNGLORTHOXOESPROC) (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f); }
{////typedef void (P PFNGLPOINTPARAMETERXVOESPROC) (GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLPOINTSIZEXOESPROC) (GLfixed size); }
{////typedef void (P PFNGLPOLYGONOFFSETXOESPROC) (GLfixed factor, GLfixed units); }
{////typedef void (P PFNGLROTATEXOESPROC) (GLfixed angle, GLfixed x, GLfixed y, GLfixed z); }
{////typedef void (P PFNGLSCALEXOESPROC) (GLfixed x, GLfixed y, GLfixed z); }
{////typedef void (P PFNGLTEXENVXOESPROC) (GLenum target, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLTEXENVXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLTEXPARAMETERXOESPROC) (GLenum target, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLTEXPARAMETERXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLTRANSLATEXOESPROC) (GLfixed x, GLfixed y, GLfixed z); }
{////typedef void (P PFNGLACCUMXOESPROC) (GLenum op, GLfixed value); }
{////typedef void (P PFNGLBITMAPXOESPROC) (GLsizei width, GLsizei height, GLfixed xorig, GLfixed yorig, GLfixed xmove, GLfixed ymove, const GLubyte *bitmap); }
{////typedef void (P PFNGLBLENDCOLORXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha); }
{////typedef void (P PFNGLCLEARACCUMXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha); }
{////typedef void (P PFNGLCOLOR3XOESPROC) (GLfixed red, GLfixed green, GLfixed blue); }
{////typedef void (P PFNGLCOLOR3XVOESPROC) (const GLfixed *components); }
{////typedef void (P PFNGLCOLOR4XVOESPROC) (const GLfixed *components); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERXOESPROC) (GLenum target, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLEVALCOORD1XOESPROC) (GLfixed u); }
{////typedef void (P PFNGLEVALCOORD1XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLEVALCOORD2XOESPROC) (GLfixed u, GLfixed v); }
{////typedef void (P PFNGLEVALCOORD2XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLFEEDBACKBUFFERXOESPROC) (GLsizei n, GLenum type, const GLfixed *buffer); }
{////typedef void (P PFNGLGETCONVOLUTIONPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETHISTOGRAMPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETLIGHTXOESPROC) (GLenum light, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETMAPXVOESPROC) (GLenum target, GLenum query, GLfixed *v); }
{////typedef void (P PFNGLGETMATERIALXOESPROC) (GLenum face, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLGETPIXELMAPXVPROC) (GLenum map, GLint size, GLfixed *values); }
{////typedef void (P PFNGLGETTEXGENXVOESPROC) (GLenum coord, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLGETTEXLEVELPARAMETERXVOESPROC) (GLenum target, GLint level, GLenum pname, GLfixed *params); }
{////typedef void (P PFNGLINDEXXOESPROC) (GLfixed component); }
{////typedef void (P PFNGLINDEXXVOESPROC) (const GLfixed *component); }
{////typedef void (P PFNGLLOADTRANSPOSEMATRIXXOESPROC) (const GLfixed *m); }
{////typedef void (P PFNGLMAP1XOESPROC) (GLenum target, GLfixed u1, GLfixed u2, GLint stride, GLint order, GLfixed points); }
{////typedef void (P PFNGLMAP2XOESPROC) (GLenum target, GLfixed u1, GLfixed u2, GLint ustride, GLint uorder, GLfixed v1, GLfixed v2, GLint vstride, GLint vorder, GLfixed points); }
{////typedef void (P PFNGLMAPGRID1XOESPROC) (GLint n, GLfixed u1, GLfixed u2); }
{////typedef void (P PFNGLMAPGRID2XOESPROC) (GLint n, GLfixed u1, GLfixed u2, GLfixed v1, GLfixed v2); }
{////typedef void (P PFNGLMULTTRANSPOSEMATRIXXOESPROC) (const GLfixed *m); }
{////typedef void (P PFNGLMULTITEXCOORD1XOESPROC) (GLenum texture, GLfixed s); }
{////typedef void (P PFNGLMULTITEXCOORD1XVOESPROC) (GLenum texture, const GLfixed *coords); }
{////typedef void (P PFNGLMULTITEXCOORD2XOESPROC) (GLenum texture, GLfixed s, GLfixed t); }
{////typedef void (P PFNGLMULTITEXCOORD2XVOESPROC) (GLenum texture, const GLfixed *coords); }
{////typedef void (P PFNGLMULTITEXCOORD3XOESPROC) (GLenum texture, GLfixed s, GLfixed t, GLfixed r); }
{////typedef void (P PFNGLMULTITEXCOORD3XVOESPROC) (GLenum texture, const GLfixed *coords); }
{////typedef void (P PFNGLMULTITEXCOORD4XVOESPROC) (GLenum texture, const GLfixed *coords); }
{////typedef void (P PFNGLNORMAL3XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLPASSTHROUGHXOESPROC) (GLfixed token); }
{////typedef void (P PFNGLPIXELMAPXPROC) (GLenum map, GLint size, const GLfixed *values); }
{////typedef void (P PFNGLPIXELSTOREXPROC) (GLenum pname, GLfixed param); }
{////typedef void (P PFNGLPIXELTRANSFERXOESPROC) (GLenum pname, GLfixed param); }
{////typedef void (P PFNGLPIXELZOOMXOESPROC) (GLfixed xfactor, GLfixed yfactor); }
{////typedef void (P PFNGLPRIORITIZETEXTURESXOESPROC) (GLsizei n, const GLuint *textures, const GLfixed *priorities); }
{////typedef void (P PFNGLRASTERPOS2XOESPROC) (GLfixed x, GLfixed y); }
{////typedef void (P PFNGLRASTERPOS2XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLRASTERPOS3XOESPROC) (GLfixed x, GLfixed y, GLfixed z); }
{////typedef void (P PFNGLRASTERPOS3XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLRASTERPOS4XOESPROC) (GLfixed x, GLfixed y, GLfixed z, GLfixed w); }
{////typedef void (P PFNGLRASTERPOS4XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLRECTXOESPROC) (GLfixed x1, GLfixed y1, GLfixed x2, GLfixed y2); }
{////typedef void (P PFNGLRECTXVOESPROC) (const GLfixed *v1, const GLfixed *v2); }
{////typedef void (P PFNGLTEXCOORD1XOESPROC) (GLfixed s); }
{////typedef void (P PFNGLTEXCOORD1XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLTEXCOORD2XOESPROC) (GLfixed s, GLfixed t); }
{////typedef void (P PFNGLTEXCOORD2XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLTEXCOORD3XOESPROC) (GLfixed s, GLfixed t, GLfixed r); }
{////typedef void (P PFNGLTEXCOORD3XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLTEXCOORD4XOESPROC) (GLfixed s, GLfixed t, GLfixed r, GLfixed q); }
{////typedef void (P PFNGLTEXCOORD4XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLTEXGENXOESPROC) (GLenum coord, GLenum pname, GLfixed param); }
{////typedef void (P PFNGLTEXGENXVOESPROC) (GLenum coord, GLenum pname, const GLfixed *params); }
{////typedef void (P PFNGLVERTEX2XOESPROC) (GLfixed x); }
{////typedef void (P PFNGLVERTEX2XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLVERTEX3XOESPROC) (GLfixed x, GLfixed y); }
{////typedef void (P PFNGLVERTEX3XVOESPROC) (const GLfixed *coords); }
{////typedef void (P PFNGLVERTEX4XOESPROC) (GLfixed x, GLfixed y, GLfixed z); }
{////typedef void (P PFNGLVERTEX4XVOESPROC) (const GLfixed *coords); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glAlphaFuncxOES(func:TGLenum; ref:TGLfixed);cdecl;external;
procedure glClearColorxOES(red:TGLfixed; green:TGLfixed; blue:TGLfixed; alpha:TGLfixed);cdecl;external;
procedure glClearDepthxOES(depth:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glClipPlanexOES(plane:TGLenum; equation:PGLfixed);cdecl;external;
procedure glColor4xOES(red:TGLfixed; green:TGLfixed; blue:TGLfixed; alpha:TGLfixed);cdecl;external;
procedure glDepthRangexOES(n:TGLfixed; f:TGLfixed);cdecl;external;
procedure glFogxOES(pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glFogxvOES(pname:TGLenum; param:PGLfixed);cdecl;external;
procedure glFrustumxOES(l:TGLfixed; r:TGLfixed; b:TGLfixed; t:TGLfixed; n:TGLfixed; 
            f:TGLfixed);cdecl;external;
procedure glGetClipPlanexOES(plane:TGLenum; equation:PGLfixed);cdecl;external;
procedure glGetFixedvOES(pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetTexEnvxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetTexParameterxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glLightModelxOES(pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glLightModelxvOES(pname:TGLenum; param:PGLfixed);cdecl;external;
procedure glLightxOES(light:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glLightxvOES(light:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glLineWidthxOES(width:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glLoadMatrixxOES(m:PGLfixed);cdecl;external;
procedure glMaterialxOES(face:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMaterialxvOES(face:TGLenum; pname:TGLenum; param:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultMatrixxOES(m:PGLfixed);cdecl;external;
procedure glMultiTexCoord4xOES(texture:TGLenum; s:TGLfixed; t:TGLfixed; r:TGLfixed; q:TGLfixed);cdecl;external;
procedure glNormal3xOES(nx:TGLfixed; ny:TGLfixed; nz:TGLfixed);cdecl;external;
procedure glOrthoxOES(l:TGLfixed; r:TGLfixed; b:TGLfixed; t:TGLfixed; n:TGLfixed; 
            f:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterxvOES(pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glPointSizexOES(size:TGLfixed);cdecl;external;
procedure glPolygonOffsetxOES(factor:TGLfixed; units:TGLfixed);cdecl;external;
procedure glRotatexOES(angle:TGLfixed; x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;external;
procedure glScalexOES(x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;external;
procedure glTexEnvxOES(target:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexEnvxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glTexParameterxOES(target:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexParameterxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glTranslatexOES(x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;external;
procedure glAccumxOES(op:TGLenum; value:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glBitmapxOES(width:TGLsizei; height:TGLsizei; xorig:TGLfixed; yorig:TGLfixed; xmove:TGLfixed; 
            ymove:TGLfixed; bitmap:PGLubyte);cdecl;external;
procedure glBlendColorxOES(red:TGLfixed; green:TGLfixed; blue:TGLfixed; alpha:TGLfixed);cdecl;external;
procedure glClearAccumxOES(red:TGLfixed; green:TGLfixed; blue:TGLfixed; alpha:TGLfixed);cdecl;external;
procedure glColor3xOES(red:TGLfixed; green:TGLfixed; blue:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glColor3xvOES(components:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glColor4xvOES(components:PGLfixed);cdecl;external;
procedure glConvolutionParameterxOES(target:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionParameterxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glEvalCoord1xOES(u:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glEvalCoord1xvOES(coords:PGLfixed);cdecl;external;
procedure glEvalCoord2xOES(u:TGLfixed; v:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glEvalCoord2xvOES(coords:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glFeedbackBufferxOES(n:TGLsizei; _type:TGLenum; buffer:PGLfixed);cdecl;external;
procedure glGetConvolutionParameterxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetHistogramParameterxvOES(target:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetLightxOES(light:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetMapxvOES(target:TGLenum; query:TGLenum; v:PGLfixed);cdecl;external;
procedure glGetMaterialxOES(face:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
procedure glGetPixelMapxv(map:TGLenum; size:TGLint; values:PGLfixed);cdecl;external;
procedure glGetTexGenxvOES(coord:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glGetTexLevelParameterxvOES(target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glIndexxOES(component:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glIndexxvOES(component:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glLoadTransposeMatrixxOES(m:PGLfixed);cdecl;external;
procedure glMap1xOES(target:TGLenum; u1:TGLfixed; u2:TGLfixed; stride:TGLint; order:TGLint; 
            points:TGLfixed);cdecl;external;
procedure glMap2xOES(target:TGLenum; u1:TGLfixed; u2:TGLfixed; ustride:TGLint; uorder:TGLint; 
            v1:TGLfixed; v2:TGLfixed; vstride:TGLint; vorder:TGLint; points:TGLfixed);cdecl;external;
procedure glMapGrid1xOES(n:TGLint; u1:TGLfixed; u2:TGLfixed);cdecl;external;
procedure glMapGrid2xOES(n:TGLint; u1:TGLfixed; u2:TGLfixed; v1:TGLfixed; v2:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultTransposeMatrixxOES(m:PGLfixed);cdecl;external;
procedure glMultiTexCoord1xOES(texture:TGLenum; s:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1xvOES(texture:TGLenum; coords:PGLfixed);cdecl;external;
procedure glMultiTexCoord2xOES(texture:TGLenum; s:TGLfixed; t:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2xvOES(texture:TGLenum; coords:PGLfixed);cdecl;external;
procedure glMultiTexCoord3xOES(texture:TGLenum; s:TGLfixed; t:TGLfixed; r:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3xvOES(texture:TGLenum; coords:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4xvOES(texture:TGLenum; coords:PGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glNormal3xvOES(coords:PGLfixed);cdecl;external;
procedure glPassThroughxOES(token:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glPixelMapx(map:TGLenum; size:TGLint; values:PGLfixed);cdecl;external;
procedure glPixelStorex(pname:TGLenum; param:TGLfixed);cdecl;external;
procedure glPixelTransferxOES(pname:TGLenum; param:TGLfixed);cdecl;external;
procedure glPixelZoomxOES(xfactor:TGLfixed; yfactor:TGLfixed);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glPrioritizeTexturesxOES(n:TGLsizei; textures:PGLuint; priorities:PGLfixed);cdecl;external;
procedure glRasterPos2xOES(x:TGLfixed; y:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glRasterPos2xvOES(coords:PGLfixed);cdecl;external;
procedure glRasterPos3xOES(x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glRasterPos3xvOES(coords:PGLfixed);cdecl;external;
procedure glRasterPos4xOES(x:TGLfixed; y:TGLfixed; z:TGLfixed; w:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glRasterPos4xvOES(coords:PGLfixed);cdecl;external;
procedure glRectxOES(x1:TGLfixed; y1:TGLfixed; x2:TGLfixed; y2:TGLfixed);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glRectxvOES(v1:PGLfixed; v2:PGLfixed);cdecl;external;
procedure glTexCoord1xOES(s:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord1xvOES(coords:PGLfixed);cdecl;external;
procedure glTexCoord2xOES(s:TGLfixed; t:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord2xvOES(coords:PGLfixed);cdecl;external;
procedure glTexCoord3xOES(s:TGLfixed; t:TGLfixed; r:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord3xvOES(coords:PGLfixed);cdecl;external;
procedure glTexCoord4xOES(s:TGLfixed; t:TGLfixed; r:TGLfixed; q:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord4xvOES(coords:PGLfixed);cdecl;external;
procedure glTexGenxOES(coord:TGLenum; pname:TGLenum; param:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glTexGenxvOES(coord:TGLenum; pname:TGLenum; params:PGLfixed);cdecl;external;
procedure glVertex2xOES(x:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glVertex2xvOES(coords:PGLfixed);cdecl;external;
procedure glVertex3xOES(x:TGLfixed; y:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glVertex3xvOES(coords:PGLfixed);cdecl;external;
procedure glVertex4xOES(x:TGLfixed; y:TGLfixed; z:TGLfixed);cdecl;external;
(* Const before type ignored *)
procedure glVertex4xvOES(coords:PGLfixed);cdecl;external;
{////#endif }
{////#endif /* GL_OES_fixed_point */ }
{////#ifndef GL_OES_query_matrix }
const
  GL_OES_query_matrix = 1;  
{////typedef GLbitfield (P PFNGLQUERYMATRIXXOESPROC) (GLfixed *mantissa, GLint *exponent); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glQueryMatrixxOES(mantissa:PGLfixed; exponent:PGLint):TGLbitfield;cdecl;external;
{////#endif }
{////#endif /* GL_OES_query_matrix */ }
{////#ifndef GL_OES_read_format }
const
  GL_OES_read_format = 1;  
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = $8B9A;  
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = $8B9B;  
{////#endif /* GL_OES_read_format */ }
{////#ifndef GL_OES_single_precision }
  GL_OES_single_precision = 1;  
{////typedef void (P PFNGLCLEARDEPTHFOESPROC) (GLclampf depth); }
{////typedef void (P PFNGLCLIPPLANEFOESPROC) (GLenum plane, const GLfloat *equation); }
{////typedef void (P PFNGLDEPTHRANGEFOESPROC) (GLclampf n, GLclampf f); }
{////typedef void (P PFNGLFRUSTUMFOESPROC) (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f); }
{////typedef void (P PFNGLGETCLIPPLANEFOESPROC) (GLenum plane, GLfloat *equation); }
{////typedef void (P PFNGLORTHOFOESPROC) (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glClearDepthfOES(depth:TGLclampf);cdecl;external;
(* Const before type ignored *)
procedure glClipPlanefOES(plane:TGLenum; equation:PGLfloat);cdecl;external;
procedure glDepthRangefOES(n:TGLclampf; f:TGLclampf);cdecl;external;
procedure glFrustumfOES(l:TGLfloat; r:TGLfloat; b:TGLfloat; t:TGLfloat; n:TGLfloat; 
            f:TGLfloat);cdecl;external;
procedure glGetClipPlanefOES(plane:TGLenum; equation:PGLfloat);cdecl;external;
procedure glOrthofOES(l:TGLfloat; r:TGLfloat; b:TGLfloat; t:TGLfloat; n:TGLfloat; 
            f:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_OES_single_precision */ }
{////#ifndef GL_3DFX_multisample }
const
  GL_3DFX_multisample = 1;  
  GL_MULTISAMPLE_3DFX = $86B2;  
  GL_SAMPLE_BUFFERS_3DFX = $86B3;  
  GL_SAMPLES_3DFX = $86B4;  
  GL_MULTISAMPLE_BIT_3DFX = $20000000;  
{////#endif /* GL_3DFX_multisample */ }
{////#ifndef GL_3DFX_tbuffer }
  GL_3DFX_tbuffer = 1;  
{////typedef void (P PFNGLTBUFFERMASK3DFXPROC) (GLuint mask); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTbufferMask3DFX(mask:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_3DFX_tbuffer */ }
{////#ifndef GL_3DFX_texture_compression_FXT1 }
const
  GL_3DFX_texture_compression_FXT1 = 1;  
  GL_COMPRESSED_RGB_FXT1_3DFX = $86B0;  
  GL_COMPRESSED_RGBA_FXT1_3DFX = $86B1;  
{////#endif /* GL_3DFX_texture_compression_FXT1 */ }
{////#ifndef GL_AMD_blend_minmax_factor }
  GL_AMD_blend_minmax_factor = 1;  
  GL_FACTOR_MIN_AMD = $901C;  
  GL_FACTOR_MAX_AMD = $901D;  
{////#endif /* GL_AMD_blend_minmax_factor */ }
{////#ifndef GL_AMD_conservative_depth }
  GL_AMD_conservative_depth = 1;  
{////#endif /* GL_AMD_conservative_depth */ }
{////#ifndef GL_AMD_debug_output }
  GL_AMD_debug_output = 1;  
(* Const before type ignored *)
type

  TGLDEBUGPROCAMD = procedure (id:TGLuint; category:TGLenum; severity:TGLenum; length:TGLsizei; message:PGLchar; 
                userParam:pointer);cdecl;

const
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
{////typedef void (P PFNGLDEBUGMESSAGEENABLEAMDPROC) (GLenum category, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled); }
{////typedef void (P PFNGLDEBUGMESSAGEINSERTAMDPROC) (GLenum category, GLenum severity, GLuint id, GLsizei length, const GLchar *buf); }
{////typedef void (P PFNGLDEBUGMESSAGECALLBACKAMDPROC) (GLDEBUGPROCAMD callback, void *userParam); }
{////typedef GLuint (P PFNGLGETDEBUGMESSAGELOGAMDPROC) (GLuint count, GLsizei bufSize, GLenum *categories, GLenum *severities, GLuint *ids, GLsizei *lengths, GLchar *message); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDebugMessageEnableAMD(category:TGLenum; severity:TGLenum; count:TGLsizei; ids:PGLuint; enabled:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glDebugMessageInsertAMD(category:TGLenum; severity:TGLenum; id:TGLuint; length:TGLsizei; buf:PGLchar);cdecl;external;
procedure glDebugMessageCallbackAMD(callback:TGLDEBUGPROCAMD; userParam:pointer);cdecl;external;
function glGetDebugMessageLogAMD(count:TGLuint; bufSize:TGLsizei; categories:PGLenum; severities:PGLenum; ids:PGLuint; 
           lengths:PGLsizei; message:PGLchar):TGLuint;cdecl;external;
{////#endif }
{////#endif /* GL_AMD_debug_output */ }
{////#ifndef GL_AMD_depth_clamp_separate }
const
  GL_AMD_depth_clamp_separate = 1;  
  GL_DEPTH_CLAMP_NEAR_AMD = $901E;  
  GL_DEPTH_CLAMP_FAR_AMD = $901F;  
{////#endif /* GL_AMD_depth_clamp_separate */ }
{////#ifndef GL_AMD_draw_buffers_blend }
  GL_AMD_draw_buffers_blend = 1;  
{////typedef void (P PFNGLBLENDFUNCINDEXEDAMDPROC) (GLuint buf, GLenum src, GLenum dst); }
{////typedef void (P PFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha); }
{////typedef void (P PFNGLBLENDEQUATIONINDEXEDAMDPROC) (GLuint buf, GLenum mode); }
{////typedef void (P PFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendFuncIndexedAMD(buf:TGLuint; src:TGLenum; dst:TGLenum);cdecl;external;
procedure glBlendFuncSeparateIndexedAMD(buf:TGLuint; srcRGB:TGLenum; dstRGB:TGLenum; srcAlpha:TGLenum; dstAlpha:TGLenum);cdecl;external;
procedure glBlendEquationIndexedAMD(buf:TGLuint; mode:TGLenum);cdecl;external;
procedure glBlendEquationSeparateIndexedAMD(buf:TGLuint; modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_draw_buffers_blend */ }
{////#ifndef GL_AMD_framebuffer_multisample_advanced }
const
  GL_AMD_framebuffer_multisample_advanced = 1;  
  GL_RENDERBUFFER_STORAGE_SAMPLES_AMD = $91B2;  
  GL_MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = $91B3;  
  GL_MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = $91B4;  
  GL_MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = $91B5;  
  GL_NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B6;  
  GL_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B7;  
{////typedef void (P PFNGLRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLenum target, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLuint renderbuffer, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glRenderbufferStorageMultisampleAdvancedAMD(target:TGLenum; samples:TGLsizei; storageSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
procedure glNamedRenderbufferStorageMultisampleAdvancedAMD(renderbuffer:TGLuint; samples:TGLsizei; storageSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_framebuffer_multisample_advanced */ }
{////#ifndef GL_AMD_framebuffer_sample_positions }
const
  GL_AMD_framebuffer_sample_positions = 1;  
  GL_SUBSAMPLE_DISTANCE_AMD = $883F;  
  GL_PIXELS_PER_SAMPLE_PATTERN_X_AMD = $91AE;  
  GL_PIXELS_PER_SAMPLE_PATTERN_Y_AMD = $91AF;  
  GL_ALL_PIXELS_AMD = $FFFFFFFF;  
{////typedef void (P PFNGLFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC) (GLenum target, GLuint numsamples, GLuint pixelindex, const GLfloat *values); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC) (GLuint framebuffer, GLuint numsamples, GLuint pixelindex, const GLfloat *values); }
{////typedef void (P PFNGLGETFRAMEBUFFERPARAMETERFVAMDPROC) (GLenum target, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values); }
{////typedef void (P PFNGLGETNAMEDFRAMEBUFFERPARAMETERFVAMDPROC) (GLuint framebuffer, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glFramebufferSamplePositionsfvAMD(target:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; values:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glNamedFramebufferSamplePositionsfvAMD(framebuffer:TGLuint; numsamples:TGLuint; pixelindex:TGLuint; values:PGLfloat);cdecl;external;
procedure glGetFramebufferParameterfvAMD(target:TGLenum; pname:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; size:TGLsizei; 
            values:PGLfloat);cdecl;external;
procedure glGetNamedFramebufferParameterfvAMD(framebuffer:TGLuint; pname:TGLenum; numsamples:TGLuint; pixelindex:TGLuint; size:TGLsizei; 
            values:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_framebuffer_sample_positions */ }
{////#ifndef GL_AMD_gcn_shader }
const
  GL_AMD_gcn_shader = 1;  
{////#endif /* GL_AMD_gcn_shader */ }
{////#ifndef GL_AMD_gpu_shader_half_float }
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
{////#endif /* GL_AMD_gpu_shader_half_float */ }
{////#ifndef GL_AMD_gpu_shader_int16 }
  GL_AMD_gpu_shader_int16 = 1;  
{////#endif /* GL_AMD_gpu_shader_int16 */ }
{////#ifndef GL_AMD_gpu_shader_int64 }
  GL_AMD_gpu_shader_int64 = 1;  
type
  PGLint64EXT = ^TGLint64EXT;
  TGLint64EXT = int64;

const
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
{////typedef void (P PFNGLUNIFORM1I64NVPROC) (GLint location, GLint64EXT x); }
{////typedef void (P PFNGLUNIFORM2I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y); }
{////typedef void (P PFNGLUNIFORM3I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z); }
{////typedef void (P PFNGLUNIFORM4I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w); }
{////typedef void (P PFNGLUNIFORM1I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLUNIFORM2I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLUNIFORM3I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLUNIFORM4I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLUNIFORM1UI64NVPROC) (GLint location, GLuint64EXT x); }
{////typedef void (P PFNGLUNIFORM2UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y); }
{////typedef void (P PFNGLUNIFORM3UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z); }
{////typedef void (P PFNGLUNIFORM4UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w); }
{////typedef void (P PFNGLUNIFORM1UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLUNIFORM2UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLUNIFORM3UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLUNIFORM4UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLGETUNIFORMI64VNVPROC) (GLuint program_, GLint location, GLint64EXT *params); }
{////typedef void (P PFNGLGETUNIFORMUI64VNVPROC) (GLuint program_, GLint location, GLuint64EXT *params); }
{////typedef void (P PFNGLPROGRAMUNIFORM1I64NVPROC) (GLuint program_, GLint location, GLint64EXT x); }
{////typedef void (P PFNGLPROGRAMUNIFORM2I64NVPROC) (GLuint program_, GLint location, GLint64EXT x, GLint64EXT y); }
{////typedef void (P PFNGLPROGRAMUNIFORM3I64NVPROC) (GLuint program_, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z); }
{////typedef void (P PFNGLPROGRAMUNIFORM4I64NVPROC) (GLuint program_, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w); }
{////typedef void (P PFNGLPROGRAMUNIFORM1I64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2I64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3I64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4I64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UI64NVPROC) (GLuint program_, GLint location, GLuint64EXT x); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UI64NVPROC) (GLuint program_, GLint location, GLuint64EXT x, GLuint64EXT y); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UI64NVPROC) (GLuint program_, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UI64NVPROC) (GLuint program_, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64EXT *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glUniform1i64NV(location:TGLint; x:TGLint64EXT);cdecl;external;
procedure glUniform2i64NV(location:TGLint; x:TGLint64EXT; y:TGLint64EXT);cdecl;external;
procedure glUniform3i64NV(location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;external;
procedure glUniform4i64NV(location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT; w:TGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform1i64vNV(location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform2i64vNV(location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform3i64vNV(location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform4i64vNV(location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
procedure glUniform1ui64NV(location:TGLint; x:TGLuint64EXT);cdecl;external;
procedure glUniform2ui64NV(location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;external;
procedure glUniform3ui64NV(location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;external;
procedure glUniform4ui64NV(location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT; w:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform1ui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform2ui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform3ui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniform4ui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
procedure glGetUniformi64vNV(program_:TGLuint; location:TGLint; params:PGLint64EXT);cdecl;external;
procedure glGetUniformui64vNV(program_:TGLuint; location:TGLint; params:PGLuint64EXT);cdecl;external;
procedure glProgramUniform1i64NV(program_:TGLuint; location:TGLint; x:TGLint64EXT);cdecl;external;
procedure glProgramUniform2i64NV(program_:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT);cdecl;external;
procedure glProgramUniform3i64NV(program_:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;external;
procedure glProgramUniform4i64NV(program_:TGLuint; location:TGLint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT; 
            w:TGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1i64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2i64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3i64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4i64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint64EXT);cdecl;external;
procedure glProgramUniform1ui64NV(program_:TGLuint; location:TGLint; x:TGLuint64EXT);cdecl;external;
procedure glProgramUniform2ui64NV(program_:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;external;
procedure glProgramUniform3ui64NV(program_:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;external;
procedure glProgramUniform4ui64NV(program_:TGLuint; location:TGLint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT; 
            w:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1ui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2ui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3ui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4ui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_gpu_shader_int64 */ }
{////#ifndef GL_AMD_interleaved_elements }
const
  GL_AMD_interleaved_elements = 1;  
  GL_VERTEX_ELEMENT_SWIZZLE_AMD = $91A4;  
  GL_VERTEX_ID_SWIZZLE_AMD = $91A5;  
{////typedef void (P PFNGLVERTEXATTRIBPARAMETERIAMDPROC) (GLuint index, GLenum pname, GLint param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttribParameteriAMD(index:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_interleaved_elements */ }
{////#ifndef GL_AMD_multi_draw_indirect }
const
  GL_AMD_multi_draw_indirect = 1;  
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTAMDPROC) (GLenum mode, const void *indirect, GLsizei primcount, GLsizei stride); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei primcount, GLsizei stride); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMultiDrawArraysIndirectAMD(mode:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirectAMD(mode:TGLenum; _type:TGLenum; indirect:pointer; primcount:TGLsizei; stride:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_multi_draw_indirect */ }
{////#ifndef GL_AMD_name_gen_delete }
const
  GL_AMD_name_gen_delete = 1;  
  GL_DATA_BUFFER_AMD = $9151;  
  GL_PERFORMANCE_MONITOR_AMD = $9152;  
  GL_QUERY_OBJECT_AMD = $9153;  
  GL_VERTEX_ARRAY_OBJECT_AMD = $9154;  
  GL_SAMPLER_OBJECT_AMD = $9155;  
{////typedef void (P PFNGLGENNAMESAMDPROC) (GLenum identifier, GLuint num, GLuint *names); }
{////typedef void (P PFNGLDELETENAMESAMDPROC) (GLenum identifier, GLuint num, const GLuint *names); }
{////typedef GLboolean (P PFNGLISNAMEAMDPROC) (GLenum identifier, GLuint name); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenNamesAMD(identifier:TGLenum; num:TGLuint; names:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteNamesAMD(identifier:TGLenum; num:TGLuint; names:PGLuint);cdecl;external;
function glIsNameAMD(identifier:TGLenum; name:TGLuint):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_AMD_name_gen_delete */ }
{////#ifndef GL_AMD_occlusion_query_event }
const
  GL_AMD_occlusion_query_event = 1;  
  GL_OCCLUSION_QUERY_EVENT_MASK_AMD = $874F;  
  GL_QUERY_DEPTH_PASS_EVENT_BIT_AMD = $00000001;  
  GL_QUERY_DEPTH_FAIL_EVENT_BIT_AMD = $00000002;  
  GL_QUERY_STENCIL_FAIL_EVENT_BIT_AMD = $00000004;  
  GL_QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = $00000008;  
  GL_QUERY_ALL_EVENT_BITS_AMD = $FFFFFFFF;  
{////typedef void (P PFNGLQUERYOBJECTPARAMETERUIAMDPROC) (GLenum target, GLuint id, GLenum pname, GLuint param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glQueryObjectParameteruiAMD(target:TGLenum; id:TGLuint; pname:TGLenum; param:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_occlusion_query_event */ }
{////#ifndef GL_AMD_performance_monitor }
const
  GL_AMD_performance_monitor = 1;  
  GL_COUNTER_TYPE_AMD = $8BC0;  
  GL_COUNTER_RANGE_AMD = $8BC1;  
  GL_UNSIGNED_INT64_AMD = $8BC2;  
  GL_PERCENTAGE_AMD = $8BC3;  
  GL_PERFMON_RESULT_AVAILABLE_AMD = $8BC4;  
  GL_PERFMON_RESULT_SIZE_AMD = $8BC5;  
  GL_PERFMON_RESULT_AMD = $8BC6;  
{////typedef void (P PFNGLGETPERFMONITORGROUPSAMDPROC) (GLint *numGroups, GLsizei groupsSize, GLuint *groups); }
{////typedef void (P PFNGLGETPERFMONITORCOUNTERSAMDPROC) (GLuint group, GLint *numCounters, GLint *maxActiveCounters, GLsizei counterSize, GLuint *counters); }
{////typedef void (P PFNGLGETPERFMONITORGROUPSTRINGAMDPROC) (GLuint group, GLsizei bufSize, GLsizei *length, GLchar *groupString); }
{////typedef void (P PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC) (GLuint group, GLuint counter, GLsizei bufSize, GLsizei *length, GLchar *counterString); }
{////typedef void (P PFNGLGETPERFMONITORCOUNTERINFOAMDPROC) (GLuint group, GLuint counter, GLenum pname, void *data); }
{////typedef void (P PFNGLGENPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors); }
{////typedef void (P PFNGLDELETEPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors); }
{////typedef void (P PFNGLSELECTPERFMONITORCOUNTERSAMDPROC) (GLuint monitor, GLboolean enable, GLuint group, GLint numCounters, GLuint *counterList); }
{////typedef void (P PFNGLBEGINPERFMONITORAMDPROC) (GLuint monitor); }
{////typedef void (P PFNGLENDPERFMONITORAMDPROC) (GLuint monitor); }
{////typedef void (P PFNGLGETPERFMONITORCOUNTERDATAAMDPROC) (GLuint monitor, GLenum pname, GLsizei dataSize, GLuint *data, GLint *bytesWritten); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetPerfMonitorGroupsAMD(numGroups:PGLint; groupsSize:TGLsizei; groups:PGLuint);cdecl;external;
procedure glGetPerfMonitorCountersAMD(group:TGLuint; numCounters:PGLint; maxActiveCounters:PGLint; counterSize:TGLsizei; counters:PGLuint);cdecl;external;
procedure glGetPerfMonitorGroupStringAMD(group:TGLuint; bufSize:TGLsizei; length:PGLsizei; groupString:PGLchar);cdecl;external;
procedure glGetPerfMonitorCounterStringAMD(group:TGLuint; counter:TGLuint; bufSize:TGLsizei; length:PGLsizei; counterString:PGLchar);cdecl;external;
procedure glGetPerfMonitorCounterInfoAMD(group:TGLuint; counter:TGLuint; pname:TGLenum; data:pointer);cdecl;external;
procedure glGenPerfMonitorsAMD(n:TGLsizei; monitors:PGLuint);cdecl;external;
procedure glDeletePerfMonitorsAMD(n:TGLsizei; monitors:PGLuint);cdecl;external;
procedure glSelectPerfMonitorCountersAMD(monitor:TGLuint; enable:TGLboolean; group:TGLuint; numCounters:TGLint; counterList:PGLuint);cdecl;external;
procedure glBeginPerfMonitorAMD(monitor:TGLuint);cdecl;external;
procedure glEndPerfMonitorAMD(monitor:TGLuint);cdecl;external;
procedure glGetPerfMonitorCounterDataAMD(monitor:TGLuint; pname:TGLenum; dataSize:TGLsizei; data:PGLuint; bytesWritten:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_performance_monitor */ }
{////#ifndef GL_AMD_pinned_memory }
const
  GL_AMD_pinned_memory = 1;  
  GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = $9160;  
{////#endif /* GL_AMD_pinned_memory */ }
{////#ifndef GL_AMD_query_buffer_object }
  GL_AMD_query_buffer_object = 1;  
  GL_QUERY_BUFFER_AMD = $9192;  
  GL_QUERY_BUFFER_BINDING_AMD = $9193;  
  GL_QUERY_RESULT_NO_WAIT_AMD = $9194;  
{////#endif /* GL_AMD_query_buffer_object */ }
{////#ifndef GL_AMD_sample_positions }
  GL_AMD_sample_positions = 1;  
{////typedef void (P PFNGLSETMULTISAMPLEFVAMDPROC) (GLenum pname, GLuint index, const GLfloat *val); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glSetMultisamplefvAMD(pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_sample_positions */ }
{////#ifndef GL_AMD_seamless_cubemap_per_texture }
const
  GL_AMD_seamless_cubemap_per_texture = 1;  
{////#endif /* GL_AMD_seamless_cubemap_per_texture */ }
{////#ifndef GL_AMD_shader_atomic_counter_ops }
  GL_AMD_shader_atomic_counter_ops = 1;  
{////#endif /* GL_AMD_shader_atomic_counter_ops */ }
{////#ifndef GL_AMD_shader_ballot }
  GL_AMD_shader_ballot = 1;  
{////#endif /* GL_AMD_shader_ballot */ }
{////#ifndef GL_AMD_shader_explicit_vertex_parameter }
  GL_AMD_shader_explicit_vertex_parameter = 1;  
{////#endif /* GL_AMD_shader_explicit_vertex_parameter */ }
{////#ifndef GL_AMD_shader_gpu_shader_half_float_fetch }
  GL_AMD_shader_gpu_shader_half_float_fetch = 1;  
{////#endif /* GL_AMD_shader_gpu_shader_half_float_fetch */ }
{////#ifndef GL_AMD_shader_image_load_store_lod }
  GL_AMD_shader_image_load_store_lod = 1;  
{////#endif /* GL_AMD_shader_image_load_store_lod */ }
{////#ifndef GL_AMD_shader_stencil_export }
  GL_AMD_shader_stencil_export = 1;  
{////#endif /* GL_AMD_shader_stencil_export */ }
{////#ifndef GL_AMD_shader_trinary_minmax }
  GL_AMD_shader_trinary_minmax = 1;  
{////#endif /* GL_AMD_shader_trinary_minmax */ }
{////#ifndef GL_AMD_sparse_texture }
  GL_AMD_sparse_texture = 1;  
  GL_VIRTUAL_PAGE_SIZE_X_AMD = $9195;  
  GL_VIRTUAL_PAGE_SIZE_Y_AMD = $9196;  
  GL_VIRTUAL_PAGE_SIZE_Z_AMD = $9197;  
  GL_MAX_SPARSE_TEXTURE_SIZE_AMD = $9198;  
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_AMD = $9199;  
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS = $919A;  
  GL_MIN_SPARSE_LEVEL_AMD = $919B;  
  GL_MIN_LOD_WARNING_AMD = $919C;  
  GL_TEXTURE_STORAGE_SPARSE_BIT_AMD = $00000001;  
{////typedef void (P PFNGLTEXSTORAGESPARSEAMDPROC) (GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags); }
{////typedef void (P PFNGLTEXTURESTORAGESPARSEAMDPROC) (GLuint texture, GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexStorageSparseAMD(target:TGLenum; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; depth:TGLsizei; 
            layers:TGLsizei; flags:TGLbitfield);cdecl;external;
procedure glTextureStorageSparseAMD(texture:TGLuint; target:TGLenum; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; layers:TGLsizei; flags:TGLbitfield);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_sparse_texture */ }
{////#ifndef GL_AMD_stencil_operation_extended }
const
  GL_AMD_stencil_operation_extended = 1;  
  GL_SET_AMD = $874A;  
  GL_REPLACE_VALUE_AMD = $874B;  
  GL_STENCIL_OP_VALUE_AMD = $874C;  
  GL_STENCIL_BACK_OP_VALUE_AMD = $874D;  
{////typedef void (P PFNGLSTENCILOPVALUEAMDPROC) (GLenum face, GLuint value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glStencilOpValueAMD(face:TGLenum; value:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_stencil_operation_extended */ }
{////#ifndef GL_AMD_texture_gather_bias_lod }
const
  GL_AMD_texture_gather_bias_lod = 1;  
{////#endif /* GL_AMD_texture_gather_bias_lod */ }
{////#ifndef GL_AMD_texture_texture4 }
  GL_AMD_texture_texture4 = 1;  
{////#endif /* GL_AMD_texture_texture4 */ }
{////#ifndef GL_AMD_transform_feedback3_lines_triangles }
  GL_AMD_transform_feedback3_lines_triangles = 1;  
{////#endif /* GL_AMD_transform_feedback3_lines_triangles */ }
{////#ifndef GL_AMD_transform_feedback4 }
  GL_AMD_transform_feedback4 = 1;  
  GL_STREAM_RASTERIZATION_AMD = $91A0;  
{////#endif /* GL_AMD_transform_feedback4 */ }
{////#ifndef GL_AMD_vertex_shader_layer }
  GL_AMD_vertex_shader_layer = 1;  
{////#endif /* GL_AMD_vertex_shader_layer */ }
{////#ifndef GL_AMD_vertex_shader_tessellator }
  GL_AMD_vertex_shader_tessellator = 1;  
  GL_SAMPLER_BUFFER_AMD = $9001;  
  GL_INT_SAMPLER_BUFFER_AMD = $9002;  
  GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = $9003;  
  GL_TESSELLATION_MODE_AMD = $9004;  
  GL_TESSELLATION_FACTOR_AMD = $9005;  
  GL_DISCRETE_AMD = $9006;  
  GL_CONTINUOUS_AMD = $9007;  
{////typedef void (P PFNGLTESSELLATIONFACTORAMDPROC) (GLfloat factor); }
{////typedef void (P PFNGLTESSELLATIONMODEAMDPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTessellationFactorAMD(factor:TGLfloat);cdecl;external;
procedure glTessellationModeAMD(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_AMD_vertex_shader_tessellator */ }
{////#ifndef GL_AMD_vertex_shader_viewport_index }
const
  GL_AMD_vertex_shader_viewport_index = 1;  
{////#endif /* GL_AMD_vertex_shader_viewport_index */ }
{////#ifndef GL_APPLE_aux_depth_stencil }
  GL_APPLE_aux_depth_stencil = 1;  
  GL_AUX_DEPTH_STENCIL_APPLE = $8A14;  
{////#endif /* GL_APPLE_aux_depth_stencil */ }
{////#ifndef GL_APPLE_client_storage }
  GL_APPLE_client_storage = 1;  
  GL_UNPACK_CLIENT_STORAGE_APPLE = $85B2;  
{////#endif /* GL_APPLE_client_storage */ }
{////#ifndef GL_APPLE_element_array }
  GL_APPLE_element_array = 1;  
  GL_ELEMENT_ARRAY_APPLE = $8A0C;  
  GL_ELEMENT_ARRAY_TYPE_APPLE = $8A0D;  
  GL_ELEMENT_ARRAY_POINTER_APPLE = $8A0E;  
{////typedef void (P PFNGLELEMENTPOINTERAPPLEPROC) (GLenum type, const void *pointer); }
{////typedef void (P PFNGLDRAWELEMENTARRAYAPPLEPROC) (GLenum mode, GLint first, GLsizei count); }
{////typedef void (P PFNGLDRAWRANGEELEMENTARRAYAPPLEPROC) (GLenum mode, GLuint start, GLuint end_, GLint first, GLsizei count); }
{////typedef void (P PFNGLMULTIDRAWELEMENTARRAYAPPLEPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount); }
{////typedef void (P PFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC) (GLenum mode, GLuint start, GLuint end_, const GLint *first, const GLsizei *count, GLsizei primcount); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glElementPointerAPPLE(_type:TGLenum; pointer:pointer);cdecl;external;
procedure glDrawElementArrayAPPLE(mode:TGLenum; first:TGLint; count:TGLsizei);cdecl;external;
procedure glDrawRangeElementArrayAPPLE(mode:TGLenum; start:TGLuint; end_:TGLuint; first:TGLint; count:TGLsizei);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glMultiDrawElementArrayAPPLE(mode:TGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glMultiDrawRangeElementArrayAPPLE(mode:TGLenum; start:TGLuint; end_:TGLuint; first:PGLint; count:PGLsizei; 
            primcount:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_element_array */ }
{////#ifndef GL_APPLE_fence }
const
  GL_APPLE_fence = 1;  
  GL_DRAW_PIXELS_APPLE = $8A0A;  
  GL_FENCE_APPLE = $8A0B;  
{////typedef void (P PFNGLGENFENCESAPPLEPROC) (GLsizei n, GLuint *fences); }
{////typedef void (P PFNGLDELETEFENCESAPPLEPROC) (GLsizei n, const GLuint *fences); }
{////typedef void (P PFNGLSETFENCEAPPLEPROC) (GLuint fence); }
{////typedef GLboolean (P PFNGLISFENCEAPPLEPROC) (GLuint fence); }
{////typedef GLboolean (P PFNGLTESTFENCEAPPLEPROC) (GLuint fence); }
{////typedef void (P PFNGLFINISHFENCEAPPLEPROC) (GLuint fence); }
{////typedef GLboolean (P PFNGLTESTOBJECTAPPLEPROC) (GLenum object, GLuint name); }
{////typedef void (P PFNGLFINISHOBJECTAPPLEPROC) (GLenum object, GLint name); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenFencesAPPLE(n:TGLsizei; fences:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteFencesAPPLE(n:TGLsizei; fences:PGLuint);cdecl;external;
procedure glSetFenceAPPLE(fence:TGLuint);cdecl;external;
function glIsFenceAPPLE(fence:TGLuint):TGLboolean;cdecl;external;
function glTestFenceAPPLE(fence:TGLuint):TGLboolean;cdecl;external;
procedure glFinishFenceAPPLE(fence:TGLuint);cdecl;external;
function glTestObjectAPPLE(object_:TGLenum; name:TGLuint):TGLboolean;cdecl;external;
procedure glFinishObjectAPPLE(object_:TGLenum; name:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_fence */ }
{////#ifndef GL_APPLE_float_pixels }
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
{////#endif /* GL_APPLE_float_pixels */ }
{////#ifndef GL_APPLE_flush_buffer_range }
  GL_APPLE_flush_buffer_range = 1;  
  GL_BUFFER_SERIALIZED_MODIFY_APPLE = $8A12;  
  GL_BUFFER_FLUSHING_UNMAP_APPLE = $8A13;  
{////typedef void (P PFNGLBUFFERPARAMETERIAPPLEPROC) (GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC) (GLenum target, GLintptr offset, GLsizeiptr size); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBufferParameteriAPPLE(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
procedure glFlushMappedBufferRangeAPPLE(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_flush_buffer_range */ }
{////#ifndef GL_APPLE_object_purgeable }
const
  GL_APPLE_object_purgeable = 1;  
  GL_BUFFER_OBJECT_APPLE = $85B3;  
  GL_RELEASED_APPLE = $8A19;  
  GL_VOLATILE_APPLE = $8A1A;  
  GL_RETAINED_APPLE = $8A1B;  
  GL_UNDEFINED_APPLE = $8A1C;  
  GL_PURGEABLE_APPLE = $8A1D;  
{////typedef GLenum (P PFNGLOBJECTPURGEABLEAPPLEPROC) (GLenum objectType, GLuint name, GLenum option); }
{////typedef GLenum (P PFNGLOBJECTUNPURGEABLEAPPLEPROC) (GLenum objectType, GLuint name, GLenum option); }
{////typedef void (P PFNGLGETOBJECTPARAMETERIVAPPLEPROC) (GLenum objectType, GLuint name, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glObjectPurgeableAPPLE(objectType:TGLenum; name:TGLuint; option:TGLenum):TGLenum;cdecl;external;
function glObjectUnpurgeableAPPLE(objectType:TGLenum; name:TGLuint; option:TGLenum):TGLenum;cdecl;external;
procedure glGetObjectParameterivAPPLE(objectType:TGLenum; name:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_object_purgeable */ }
{////#ifndef GL_APPLE_rgb_422 }
const
  GL_APPLE_rgb_422 = 1;  
  GL_RGB_422_APPLE = $8A1F;  
  GL_UNSIGNED_SHORT_8_8_APPLE = $85BA;  
  GL_UNSIGNED_SHORT_8_8_REV_APPLE = $85BB;  
  GL_RGB_RAW_422_APPLE = $8A51;  
{////#endif /* GL_APPLE_rgb_422 */ }
{////#ifndef GL_APPLE_row_bytes }
  GL_APPLE_row_bytes = 1;  
  GL_PACK_ROW_BYTES_APPLE = $8A15;  
  GL_UNPACK_ROW_BYTES_APPLE = $8A16;  
{////#endif /* GL_APPLE_row_bytes */ }
{////#ifndef GL_APPLE_specular_vector }
  GL_APPLE_specular_vector = 1;  
  GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = $85B0;  
{////#endif /* GL_APPLE_specular_vector */ }
{////#ifndef GL_APPLE_texture_range }
  GL_APPLE_texture_range = 1;  
  GL_TEXTURE_RANGE_LENGTH_APPLE = $85B7;  
  GL_TEXTURE_RANGE_POINTER_APPLE = $85B8;  
  GL_TEXTURE_STORAGE_HINT_APPLE = $85BC;  
  GL_STORAGE_PRIVATE_APPLE = $85BD;  
  GL_STORAGE_CACHED_APPLE = $85BE;  
  GL_STORAGE_SHARED_APPLE = $85BF;  
{////typedef void (P PFNGLTEXTURERANGEAPPLEPROC) (GLenum target, GLsizei length, const void *pointer); }
{////typedef void (P PFNGLGETTEXPARAMETERPOINTERVAPPLEPROC) (GLenum target, GLenum pname, void **params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTextureRangeAPPLE(target:TGLenum; length:TGLsizei; pointer:pointer);cdecl;external;
procedure glGetTexParameterPointervAPPLE(target:TGLenum; pname:TGLenum; params:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_texture_range */ }
{////#ifndef GL_APPLE_transform_hint }
const
  GL_APPLE_transform_hint = 1;  
  GL_TRANSFORM_HINT_APPLE = $85B1;  
{////#endif /* GL_APPLE_transform_hint */ }
{////#ifndef GL_APPLE_vertex_array_object }
  GL_APPLE_vertex_array_object = 1;  
  GL_VERTEX_ARRAY_BINDING_APPLE = $85B5;  
{////typedef void (P PFNGLBINDVERTEXARRAYAPPLEPROC) (GLuint array); }
{////typedef void (P PFNGLDELETEVERTEXARRAYSAPPLEPROC) (GLsizei n, const GLuint *arrays); }
{////typedef void (P PFNGLGENVERTEXARRAYSAPPLEPROC) (GLsizei n, GLuint *arrays); }
{////typedef GLboolean (P PFNGLISVERTEXARRAYAPPLEPROC) (GLuint array); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBindVertexArrayAPPLE(array_:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteVertexArraysAPPLE(n:TGLsizei; arrays:PGLuint);cdecl;external;
procedure glGenVertexArraysAPPLE(n:TGLsizei; arrays:PGLuint);cdecl;external;
function glIsVertexArrayAPPLE(array_:TGLuint):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_vertex_array_object */ }
{////#ifndef GL_APPLE_vertex_array_range }
const
  GL_APPLE_vertex_array_range = 1;  
  GL_VERTEX_ARRAY_RANGE_APPLE = $851D;  
  GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = $851E;  
  GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = $851F;  
  GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = $8521;  
  GL_STORAGE_CLIENT_APPLE = $85B4;  
{////typedef void (P PFNGLVERTEXARRAYRANGEAPPLEPROC) (GLsizei length, void *pointer); }
{////typedef void (P PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC) (GLsizei length, void *pointer); }
{////typedef void (P PFNGLVERTEXARRAYPARAMETERIAPPLEPROC) (GLenum pname, GLint param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexArrayRangeAPPLE(length:TGLsizei; pointer:pointer);cdecl;external;
procedure glFlushVertexArrayRangeAPPLE(length:TGLsizei; pointer:pointer);cdecl;external;
procedure glVertexArrayParameteriAPPLE(pname:TGLenum; param:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_vertex_array_range */ }
{////#ifndef GL_APPLE_vertex_program_evaluators }
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
{////typedef void (P PFNGLENABLEVERTEXATTRIBAPPLEPROC) (GLuint index, GLenum pname); }
{////typedef void (P PFNGLDISABLEVERTEXATTRIBAPPLEPROC) (GLuint index, GLenum pname); }
{////typedef GLboolean (P PFNGLISVERTEXATTRIBENABLEDAPPLEPROC) (GLuint index, GLenum pname); }
{////typedef void (P PFNGLMAPVERTEXATTRIB1DAPPLEPROC) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points); }
{////typedef void (P PFNGLMAPVERTEXATTRIB1FAPPLEPROC) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points); }
{////typedef void (P PFNGLMAPVERTEXATTRIB2DAPPLEPROC) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points); }
{////typedef void (P PFNGLMAPVERTEXATTRIB2FAPPLEPROC) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glEnableVertexAttribAPPLE(index:TGLuint; pname:TGLenum);cdecl;external;
procedure glDisableVertexAttribAPPLE(index:TGLuint; pname:TGLenum);cdecl;external;
function glIsVertexAttribEnabledAPPLE(index:TGLuint; pname:TGLenum):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glMapVertexAttrib1dAPPLE(index:TGLuint; size:TGLuint; u1:TGLdouble; u2:TGLdouble; stride:TGLint; 
            order:TGLint; points:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMapVertexAttrib1fAPPLE(index:TGLuint; size:TGLuint; u1:TGLfloat; u2:TGLfloat; stride:TGLint; 
            order:TGLint; points:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMapVertexAttrib2dAPPLE(index:TGLuint; size:TGLuint; u1:TGLdouble; u2:TGLdouble; ustride:TGLint; 
            uorder:TGLint; v1:TGLdouble; v2:TGLdouble; vstride:TGLint; vorder:TGLint; 
            points:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMapVertexAttrib2fAPPLE(index:TGLuint; size:TGLuint; u1:TGLfloat; u2:TGLfloat; ustride:TGLint; 
            uorder:TGLint; v1:TGLfloat; v2:TGLfloat; vstride:TGLint; vorder:TGLint; 
            points:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_APPLE_vertex_program_evaluators */ }
{////#ifndef GL_APPLE_ycbcr_422 }
const
  GL_APPLE_ycbcr_422 = 1;  
  GL_YCBCR_422_APPLE = $85B9;  
{////#endif /* GL_APPLE_ycbcr_422 */ }
{////#ifndef GL_ATI_draw_buffers }
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
{////typedef void (P PFNGLDRAWBUFFERSATIPROC) (GLsizei n, const GLenum *bufs); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDrawBuffersATI(n:TGLsizei; bufs:PGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_draw_buffers */ }
{////#ifndef GL_ATI_element_array }
const
  GL_ATI_element_array = 1;  
  GL_ELEMENT_ARRAY_ATI = $8768;  
  GL_ELEMENT_ARRAY_TYPE_ATI = $8769;  
  GL_ELEMENT_ARRAY_POINTER_ATI = $876A;  
{////typedef void (P PFNGLELEMENTPOINTERATIPROC) (GLenum type, const void *pointer); }
{////typedef void (P PFNGLDRAWELEMENTARRAYATIPROC) (GLenum mode, GLsizei count); }
{////typedef void (P PFNGLDRAWRANGEELEMENTARRAYATIPROC) (GLenum mode, GLuint start, GLuint end_, GLsizei count); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glElementPointerATI(_type:TGLenum; pointer:pointer);cdecl;external;
procedure glDrawElementArrayATI(mode:TGLenum; count:TGLsizei);cdecl;external;
procedure glDrawRangeElementArrayATI(mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_element_array */ }
{////#ifndef GL_ATI_envmap_bumpmap }
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
{////typedef void (P PFNGLTEXBUMPPARAMETERIVATIPROC) (GLenum pname, const GLint *param); }
{////typedef void (P PFNGLTEXBUMPPARAMETERFVATIPROC) (GLenum pname, const GLfloat *param); }
{////typedef void (P PFNGLGETTEXBUMPPARAMETERIVATIPROC) (GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETTEXBUMPPARAMETERFVATIPROC) (GLenum pname, GLfloat *param); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTexBumpParameterivATI(pname:TGLenum; param:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTexBumpParameterfvATI(pname:TGLenum; param:PGLfloat);cdecl;external;
procedure glGetTexBumpParameterivATI(pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetTexBumpParameterfvATI(pname:TGLenum; param:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_envmap_bumpmap */ }
{////#ifndef GL_ATI_fragment_shader }
const
  GL_ATI_fragment_shader = 1;  
  GL_FRAGMENT_SHADER_ATI = $8920;  
  GL_REG_0_ATI = $8921;  
  GL_REG_1_ATI = $8922;  
  GL_REG_2_ATI = $8923;  
  GL_REG_3_ATI = $8924;  
  GL_REG_4_ATI = $8925;  
  GL_REG_5_ATI = $8926;  
  GL_REG_6_ATI = $8927;  
  GL_REG_7_ATI = $8928;  
  GL_REG_8_ATI = $8929;  
  GL_REG_9_ATI = $892A;  
  GL_REG_10_ATI = $892B;  
  GL_REG_11_ATI = $892C;  
  GL_REG_12_ATI = $892D;  
  GL_REG_13_ATI = $892E;  
  GL_REG_14_ATI = $892F;  
  GL_REG_15_ATI = $8930;  
  GL_REG_16_ATI = $8931;  
  GL_REG_17_ATI = $8932;  
  GL_REG_18_ATI = $8933;  
  GL_REG_19_ATI = $8934;  
  GL_REG_20_ATI = $8935;  
  GL_REG_21_ATI = $8936;  
  GL_REG_22_ATI = $8937;  
  GL_REG_23_ATI = $8938;  
  GL_REG_24_ATI = $8939;  
  GL_REG_25_ATI = $893A;  
  GL_REG_26_ATI = $893B;  
  GL_REG_27_ATI = $893C;  
  GL_REG_28_ATI = $893D;  
  GL_REG_29_ATI = $893E;  
  GL_REG_30_ATI = $893F;  
  GL_REG_31_ATI = $8940;  
  GL_CON_0_ATI = $8941;  
  GL_CON_1_ATI = $8942;  
  GL_CON_2_ATI = $8943;  
  GL_CON_3_ATI = $8944;  
  GL_CON_4_ATI = $8945;  
  GL_CON_5_ATI = $8946;  
  GL_CON_6_ATI = $8947;  
  GL_CON_7_ATI = $8948;  
  GL_CON_8_ATI = $8949;  
  GL_CON_9_ATI = $894A;  
  GL_CON_10_ATI = $894B;  
  GL_CON_11_ATI = $894C;  
  GL_CON_12_ATI = $894D;  
  GL_CON_13_ATI = $894E;  
  GL_CON_14_ATI = $894F;  
  GL_CON_15_ATI = $8950;  
  GL_CON_16_ATI = $8951;  
  GL_CON_17_ATI = $8952;  
  GL_CON_18_ATI = $8953;  
  GL_CON_19_ATI = $8954;  
  GL_CON_20_ATI = $8955;  
  GL_CON_21_ATI = $8956;  
  GL_CON_22_ATI = $8957;  
  GL_CON_23_ATI = $8958;  
  GL_CON_24_ATI = $8959;  
  GL_CON_25_ATI = $895A;  
  GL_CON_26_ATI = $895B;  
  GL_CON_27_ATI = $895C;  
  GL_CON_28_ATI = $895D;  
  GL_CON_29_ATI = $895E;  
  GL_CON_30_ATI = $895F;  
  GL_CON_31_ATI = $8960;  
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
  GL_RED_BIT_ATI = $00000001;  
  GL_GREEN_BIT_ATI = $00000002;  
  GL_BLUE_BIT_ATI = $00000004;  
  GL_2X_BIT_ATI = $00000001;  
  GL_4X_BIT_ATI = $00000002;  
  GL_8X_BIT_ATI = $00000004;  
  GL_HALF_BIT_ATI = $00000008;  
  GL_QUARTER_BIT_ATI = $00000010;  
  GL_EIGHTH_BIT_ATI = $00000020;  
  GL_SATURATE_BIT_ATI = $00000040;  
  GL_COMP_BIT_ATI = $00000002;  
  GL_NEGATE_BIT_ATI = $00000004;  
  GL_BIAS_BIT_ATI = $00000008;  
{////typedef GLuint (P PFNGLGENFRAGMENTSHADERSATIPROC) (GLuint range); }
{////typedef void (P PFNGLBINDFRAGMENTSHADERATIPROC) (GLuint id); }
{////typedef void (P PFNGLDELETEFRAGMENTSHADERATIPROC) (GLuint id); }
{////typedef void (P PFNGLBEGINFRAGMENTSHADERATIPROC) (void); }
{////typedef void (P PFNGLENDFRAGMENTSHADERATIPROC) (void); }
{////typedef void (P PFNGLPASSTEXCOORDATIPROC) (GLuint dst, GLuint coord, GLenum swizzle); }
{////typedef void (P PFNGLSAMPLEMAPATIPROC) (GLuint dst, GLuint interp, GLenum swizzle); }
{////typedef void (P PFNGLCOLORFRAGMENTOP1ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod); }
{////typedef void (P PFNGLCOLORFRAGMENTOP2ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod); }
{////typedef void (P PFNGLCOLORFRAGMENTOP3ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod); }
{////typedef void (P PFNGLALPHAFRAGMENTOP1ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod); }
{////typedef void (P PFNGLALPHAFRAGMENTOP2ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod); }
{////typedef void (P PFNGLALPHAFRAGMENTOP3ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod); }
{////typedef void (P PFNGLSETFRAGMENTSHADERCONSTANTATIPROC) (GLuint dst, const GLfloat *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGenFragmentShadersATI(range:TGLuint):TGLuint;cdecl;external;
procedure glBindFragmentShaderATI(id:TGLuint);cdecl;external;
procedure glDeleteFragmentShaderATI(id:TGLuint);cdecl;external;
procedure glBeginFragmentShaderATI;cdecl;external;
procedure glEndFragmentShaderATI;cdecl;external;
procedure glPassTexCoordATI(dst:TGLuint; coord:TGLuint; swizzle:TGLenum);cdecl;external;
procedure glSampleMapATI(dst:TGLuint; interp:TGLuint; swizzle:TGLenum);cdecl;external;
procedure glColorFragmentOp1ATI(op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint; 
            arg1Rep:TGLuint; arg1Mod:TGLuint);cdecl;external;
procedure glColorFragmentOp2ATI(op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint; 
            arg1Rep:TGLuint; arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint);cdecl;external;
procedure glColorFragmentOp3ATI(op:TGLenum; dst:TGLuint; dstMask:TGLuint; dstMod:TGLuint; arg1:TGLuint; 
            arg1Rep:TGLuint; arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint; 
            arg3:TGLuint; arg3Rep:TGLuint; arg3Mod:TGLuint);cdecl;external;
procedure glAlphaFragmentOp1ATI(op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint; 
            arg1Mod:TGLuint);cdecl;external;
procedure glAlphaFragmentOp2ATI(op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint; 
            arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint);cdecl;external;
procedure glAlphaFragmentOp3ATI(op:TGLenum; dst:TGLuint; dstMod:TGLuint; arg1:TGLuint; arg1Rep:TGLuint; 
            arg1Mod:TGLuint; arg2:TGLuint; arg2Rep:TGLuint; arg2Mod:TGLuint; arg3:TGLuint; 
            arg3Rep:TGLuint; arg3Mod:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glSetFragmentShaderConstantATI(dst:TGLuint; value:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_fragment_shader */ }
{////#ifndef GL_ATI_map_object_buffer }
const
  GL_ATI_map_object_buffer = 1;  
{////typedef void *(P PFNGLMAPOBJECTBUFFERATIPROC) (GLuint buffer); }
{////typedef void (P PFNGLUNMAPOBJECTBUFFERATIPROC) (GLuint buffer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glMapObjectBufferATI(buffer:TGLuint):pointer;cdecl;external;
procedure glUnmapObjectBufferATI(buffer:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_map_object_buffer */ }
{////#ifndef GL_ATI_meminfo }
const
  GL_ATI_meminfo = 1;  
  GL_VBO_FREE_MEMORY_ATI = $87FB;  
  GL_TEXTURE_FREE_MEMORY_ATI = $87FC;  
  GL_RENDERBUFFER_FREE_MEMORY_ATI = $87FD;  
{////#endif /* GL_ATI_meminfo */ }
{////#ifndef GL_ATI_pixel_format_float }
  GL_ATI_pixel_format_float = 1;  
  GL_RGBA_FLOAT_MODE_ATI = $8820;  
  GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = $8835;  
{////#endif /* GL_ATI_pixel_format_float */ }
{////#ifndef GL_ATI_pn_triangles }
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
{////typedef void (P PFNGLPNTRIANGLESIATIPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLPNTRIANGLESFATIPROC) (GLenum pname, GLfloat param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPNTrianglesiATI(pname:TGLenum; param:TGLint);cdecl;external;
procedure glPNTrianglesfATI(pname:TGLenum; param:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_pn_triangles */ }
{////#ifndef GL_ATI_separate_stencil }
const
  GL_ATI_separate_stencil = 1;  
  GL_STENCIL_BACK_FUNC_ATI = $8800;  
  GL_STENCIL_BACK_FAIL_ATI = $8801;  
  GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = $8802;  
  GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = $8803;  
{////typedef void (P PFNGLSTENCILOPSEPARATEATIPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass); }
{////typedef void (P PFNGLSTENCILFUNCSEPARATEATIPROC) (GLenum frontfunc, GLenum backfunc, GLint ref, GLuint mask); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glStencilOpSeparateATI(face:TGLenum; sfail:TGLenum; dpfail:TGLenum; dppass:TGLenum);cdecl;external;
procedure glStencilFuncSeparateATI(frontfunc:TGLenum; backfunc:TGLenum; ref:TGLint; mask:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_separate_stencil */ }
{////#ifndef GL_ATI_text_fragment_shader }
const
  GL_ATI_text_fragment_shader = 1;  
  GL_TEXT_FRAGMENT_SHADER_ATI = $8200;  
{////#endif /* GL_ATI_text_fragment_shader */ }
{////#ifndef GL_ATI_texture_env_combine3 }
  GL_ATI_texture_env_combine3 = 1;  
  GL_MODULATE_ADD_ATI = $8744;  
  GL_MODULATE_SIGNED_ADD_ATI = $8745;  
  GL_MODULATE_SUBTRACT_ATI = $8746;  
{////#endif /* GL_ATI_texture_env_combine3 */ }
{////#ifndef GL_ATI_texture_float }
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
{////#endif /* GL_ATI_texture_float */ }
{////#ifndef GL_ATI_texture_mirror_once }
  GL_ATI_texture_mirror_once = 1;  
  GL_MIRROR_CLAMP_ATI = $8742;  
  GL_MIRROR_CLAMP_TO_EDGE_ATI = $8743;  
{////#endif /* GL_ATI_texture_mirror_once */ }
{////#ifndef GL_ATI_vertex_array_object }
  GL_ATI_vertex_array_object = 1;  
  GL_STATIC_ATI = $8760;  
  GL_DYNAMIC_ATI = $8761;  
  GL_PRESERVE_ATI = $8762;  
  GL_DISCARD_ATI = $8763;  
  GL_OBJECT_BUFFER_SIZE_ATI = $8764;  
  GL_OBJECT_BUFFER_USAGE_ATI = $8765;  
  GL_ARRAY_OBJECT_BUFFER_ATI = $8766;  
  GL_ARRAY_OBJECT_OFFSET_ATI = $8767;  
{////typedef GLuint (P PFNGLNEWOBJECTBUFFERATIPROC) (GLsizei size, const void *pointer, GLenum usage); }
{////typedef GLboolean (P PFNGLISOBJECTBUFFERATIPROC) (GLuint buffer); }
{////typedef void (P PFNGLUPDATEOBJECTBUFFERATIPROC) (GLuint buffer, GLuint offset, GLsizei size, const void *pointer, GLenum preserve); }
{////typedef void (P PFNGLGETOBJECTBUFFERFVATIPROC) (GLuint buffer, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETOBJECTBUFFERIVATIPROC) (GLuint buffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLFREEOBJECTBUFFERATIPROC) (GLuint buffer); }
{////typedef void (P PFNGLARRAYOBJECTATIPROC) (GLenum array, GLint size, GLenum type, GLsizei stride, GLuint buffer, GLuint offset); }
{////typedef void (P PFNGLGETARRAYOBJECTFVATIPROC) (GLenum array, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETARRAYOBJECTIVATIPROC) (GLenum array, GLenum pname, GLint *params); }
{////typedef void (P PFNGLVARIANTARRAYOBJECTATIPROC) (GLuint id, GLenum type, GLsizei stride, GLuint buffer, GLuint offset); }
{////typedef void (P PFNGLGETVARIANTARRAYOBJECTFVATIPROC) (GLuint id, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVARIANTARRAYOBJECTIVATIPROC) (GLuint id, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

function glNewObjectBufferATI(size:TGLsizei; pointer:pointer; usage:TGLenum):TGLuint;cdecl;external;
function glIsObjectBufferATI(buffer:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glUpdateObjectBufferATI(buffer:TGLuint; offset:TGLuint; size:TGLsizei; pointer:pointer; preserve:TGLenum);cdecl;external;
procedure glGetObjectBufferfvATI(buffer:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetObjectBufferivATI(buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glFreeObjectBufferATI(buffer:TGLuint);cdecl;external;
procedure glArrayObjectATI(array_:TGLenum; size:TGLint; _type:TGLenum; stride:TGLsizei; buffer:TGLuint; 
            offset:TGLuint);cdecl;external;
procedure glGetArrayObjectfvATI(array_:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetArrayObjectivATI(array_:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glVariantArrayObjectATI(id:TGLuint; _type:TGLenum; stride:TGLsizei; buffer:TGLuint; offset:TGLuint);cdecl;external;
procedure glGetVariantArrayObjectfvATI(id:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVariantArrayObjectivATI(id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_vertex_array_object */ }
{////#ifndef GL_ATI_vertex_attrib_array_object }
const
  GL_ATI_vertex_attrib_array_object = 1;  
{////typedef void (P PFNGLVERTEXATTRIBARRAYOBJECTATIPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLuint buffer, GLuint offset); }
{////typedef void (P PFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC) (GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC) (GLuint index, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttribArrayObjectATI(index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei; 
            buffer:TGLuint; offset:TGLuint);cdecl;external;
procedure glGetVertexAttribArrayObjectfvATI(index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVertexAttribArrayObjectivATI(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_vertex_attrib_array_object */ }
{////#ifndef GL_ATI_vertex_streams }
const
  GL_ATI_vertex_streams = 1;  
  GL_MAX_VERTEX_STREAMS_ATI = $876B;  
  GL_VERTEX_STREAM0_ATI = $876C;  
  GL_VERTEX_STREAM1_ATI = $876D;  
  GL_VERTEX_STREAM2_ATI = $876E;  
  GL_VERTEX_STREAM3_ATI = $876F;  
  GL_VERTEX_STREAM4_ATI = $8770;  
  GL_VERTEX_STREAM5_ATI = $8771;  
  GL_VERTEX_STREAM6_ATI = $8772;  
  GL_VERTEX_STREAM7_ATI = $8773;  
  GL_VERTEX_SOURCE_ATI = $8774;  
{////typedef void (P PFNGLVERTEXSTREAM1SATIPROC) (GLenum stream, GLshort x); }
{////typedef void (P PFNGLVERTEXSTREAM1SVATIPROC) (GLenum stream, const GLshort *coords); }
{////typedef void (P PFNGLVERTEXSTREAM1IATIPROC) (GLenum stream, GLint x); }
{////typedef void (P PFNGLVERTEXSTREAM1IVATIPROC) (GLenum stream, const GLint *coords); }
{////typedef void (P PFNGLVERTEXSTREAM1FATIPROC) (GLenum stream, GLfloat x); }
{////typedef void (P PFNGLVERTEXSTREAM1FVATIPROC) (GLenum stream, const GLfloat *coords); }
{////typedef void (P PFNGLVERTEXSTREAM1DATIPROC) (GLenum stream, GLdouble x); }
{////typedef void (P PFNGLVERTEXSTREAM1DVATIPROC) (GLenum stream, const GLdouble *coords); }
{////typedef void (P PFNGLVERTEXSTREAM2SATIPROC) (GLenum stream, GLshort x, GLshort y); }
{////typedef void (P PFNGLVERTEXSTREAM2SVATIPROC) (GLenum stream, const GLshort *coords); }
{////typedef void (P PFNGLVERTEXSTREAM2IATIPROC) (GLenum stream, GLint x, GLint y); }
{////typedef void (P PFNGLVERTEXSTREAM2IVATIPROC) (GLenum stream, const GLint *coords); }
{////typedef void (P PFNGLVERTEXSTREAM2FATIPROC) (GLenum stream, GLfloat x, GLfloat y); }
{////typedef void (P PFNGLVERTEXSTREAM2FVATIPROC) (GLenum stream, const GLfloat *coords); }
{////typedef void (P PFNGLVERTEXSTREAM2DATIPROC) (GLenum stream, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXSTREAM2DVATIPROC) (GLenum stream, const GLdouble *coords); }
{////typedef void (P PFNGLVERTEXSTREAM3SATIPROC) (GLenum stream, GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLVERTEXSTREAM3SVATIPROC) (GLenum stream, const GLshort *coords); }
{////typedef void (P PFNGLVERTEXSTREAM3IATIPROC) (GLenum stream, GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLVERTEXSTREAM3IVATIPROC) (GLenum stream, const GLint *coords); }
{////typedef void (P PFNGLVERTEXSTREAM3FATIPROC) (GLenum stream, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLVERTEXSTREAM3FVATIPROC) (GLenum stream, const GLfloat *coords); }
{////typedef void (P PFNGLVERTEXSTREAM3DATIPROC) (GLenum stream, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXSTREAM3DVATIPROC) (GLenum stream, const GLdouble *coords); }
{////typedef void (P PFNGLVERTEXSTREAM4SATIPROC) (GLenum stream, GLshort x, GLshort y, GLshort z, GLshort w); }
{////typedef void (P PFNGLVERTEXSTREAM4SVATIPROC) (GLenum stream, const GLshort *coords); }
{////typedef void (P PFNGLVERTEXSTREAM4IATIPROC) (GLenum stream, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLVERTEXSTREAM4IVATIPROC) (GLenum stream, const GLint *coords); }
{////typedef void (P PFNGLVERTEXSTREAM4FATIPROC) (GLenum stream, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLVERTEXSTREAM4FVATIPROC) (GLenum stream, const GLfloat *coords); }
{////typedef void (P PFNGLVERTEXSTREAM4DATIPROC) (GLenum stream, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXSTREAM4DVATIPROC) (GLenum stream, const GLdouble *coords); }
{////typedef void (P PFNGLNORMALSTREAM3BATIPROC) (GLenum stream, GLbyte nx, GLbyte ny, GLbyte nz); }
{////typedef void (P PFNGLNORMALSTREAM3BVATIPROC) (GLenum stream, const GLbyte *coords); }
{////typedef void (P PFNGLNORMALSTREAM3SATIPROC) (GLenum stream, GLshort nx, GLshort ny, GLshort nz); }
{////typedef void (P PFNGLNORMALSTREAM3SVATIPROC) (GLenum stream, const GLshort *coords); }
{////typedef void (P PFNGLNORMALSTREAM3IATIPROC) (GLenum stream, GLint nx, GLint ny, GLint nz); }
{////typedef void (P PFNGLNORMALSTREAM3IVATIPROC) (GLenum stream, const GLint *coords); }
{////typedef void (P PFNGLNORMALSTREAM3FATIPROC) (GLenum stream, GLfloat nx, GLfloat ny, GLfloat nz); }
{////typedef void (P PFNGLNORMALSTREAM3FVATIPROC) (GLenum stream, const GLfloat *coords); }
{////typedef void (P PFNGLNORMALSTREAM3DATIPROC) (GLenum stream, GLdouble nx, GLdouble ny, GLdouble nz); }
{////typedef void (P PFNGLNORMALSTREAM3DVATIPROC) (GLenum stream, const GLdouble *coords); }
{////typedef void (P PFNGLCLIENTACTIVEVERTEXSTREAMATIPROC) (GLenum stream); }
{////typedef void (P PFNGLVERTEXBLENDENVIATIPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLVERTEXBLENDENVFATIPROC) (GLenum pname, GLfloat param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexStream1sATI(stream:TGLenum; x:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream1svATI(stream:TGLenum; coords:PGLshort);cdecl;external;
procedure glVertexStream1iATI(stream:TGLenum; x:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream1ivATI(stream:TGLenum; coords:PGLint);cdecl;external;
procedure glVertexStream1fATI(stream:TGLenum; x:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream1fvATI(stream:TGLenum; coords:PGLfloat);cdecl;external;
procedure glVertexStream1dATI(stream:TGLenum; x:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream1dvATI(stream:TGLenum; coords:PGLdouble);cdecl;external;
procedure glVertexStream2sATI(stream:TGLenum; x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream2svATI(stream:TGLenum; coords:PGLshort);cdecl;external;
procedure glVertexStream2iATI(stream:TGLenum; x:TGLint; y:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream2ivATI(stream:TGLenum; coords:PGLint);cdecl;external;
procedure glVertexStream2fATI(stream:TGLenum; x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream2fvATI(stream:TGLenum; coords:PGLfloat);cdecl;external;
procedure glVertexStream2dATI(stream:TGLenum; x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream2dvATI(stream:TGLenum; coords:PGLdouble);cdecl;external;
procedure glVertexStream3sATI(stream:TGLenum; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream3svATI(stream:TGLenum; coords:PGLshort);cdecl;external;
procedure glVertexStream3iATI(stream:TGLenum; x:TGLint; y:TGLint; z:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream3ivATI(stream:TGLenum; coords:PGLint);cdecl;external;
procedure glVertexStream3fATI(stream:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream3fvATI(stream:TGLenum; coords:PGLfloat);cdecl;external;
procedure glVertexStream3dATI(stream:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream3dvATI(stream:TGLenum; coords:PGLdouble);cdecl;external;
procedure glVertexStream4sATI(stream:TGLenum; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream4svATI(stream:TGLenum; coords:PGLshort);cdecl;external;
procedure glVertexStream4iATI(stream:TGLenum; x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream4ivATI(stream:TGLenum; coords:PGLint);cdecl;external;
procedure glVertexStream4fATI(stream:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream4fvATI(stream:TGLenum; coords:PGLfloat);cdecl;external;
procedure glVertexStream4dATI(stream:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexStream4dvATI(stream:TGLenum; coords:PGLdouble);cdecl;external;
procedure glNormalStream3bATI(stream:TGLenum; nx:TGLbyte; ny:TGLbyte; nz:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glNormalStream3bvATI(stream:TGLenum; coords:PGLbyte);cdecl;external;
procedure glNormalStream3sATI(stream:TGLenum; nx:TGLshort; ny:TGLshort; nz:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glNormalStream3svATI(stream:TGLenum; coords:PGLshort);cdecl;external;
procedure glNormalStream3iATI(stream:TGLenum; nx:TGLint; ny:TGLint; nz:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glNormalStream3ivATI(stream:TGLenum; coords:PGLint);cdecl;external;
procedure glNormalStream3fATI(stream:TGLenum; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glNormalStream3fvATI(stream:TGLenum; coords:PGLfloat);cdecl;external;
procedure glNormalStream3dATI(stream:TGLenum; nx:TGLdouble; ny:TGLdouble; nz:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glNormalStream3dvATI(stream:TGLenum; coords:PGLdouble);cdecl;external;
procedure glClientActiveVertexStreamATI(stream:TGLenum);cdecl;external;
procedure glVertexBlendEnviATI(pname:TGLenum; param:TGLint);cdecl;external;
procedure glVertexBlendEnvfATI(pname:TGLenum; param:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_ATI_vertex_streams */ }
{////#ifndef GL_EXT_422_pixels }
const
  GL_EXT_422_pixels = 1;  
  GL_422_EXT = $80CC;  
  GL_422_REV_EXT = $80CD;  
  GL_422_AVERAGE_EXT = $80CE;  
  GL_422_REV_AVERAGE_EXT = $80CF;  
{////#endif /* GL_EXT_422_pixels */ }
{////#ifndef GL_EXT_EGL_image_storage }
  GL_EXT_EGL_image_storage = 1;  
type
  PGLeglImageOES = ^TGLeglImageOES;
  TGLeglImageOES = pointer;
{////typedef void (P PFNGLEGLIMAGETARGETTEXSTORAGEEXTPROC) (GLenum target, GLeglImageOES image, const GLint* attrib_list); }
{////typedef void (P PFNGLEGLIMAGETARGETTEXTURESTORAGEEXTPROC) (GLuint texture, GLeglImageOES image, const GLint* attrib_list); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glEGLImageTargetTexStorageEXT(target:TGLenum; image:TGLeglImageOES; attrib_list:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glEGLImageTargetTextureStorageEXT(texture:TGLuint; image:TGLeglImageOES; attrib_list:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_EGL_image_storage */ }
{////#ifndef GL_EXT_EGL_sync }
const
  GL_EXT_EGL_sync = 1;  
{////#endif /* GL_EXT_EGL_sync */ }
{////#ifndef GL_EXT_abgr }
  GL_EXT_abgr = 1;  
  GL_ABGR_EXT = $8000;  
{////#endif /* GL_EXT_abgr */ }
{////#ifndef GL_EXT_bgra }
  GL_EXT_bgra = 1;  
  GL_BGR_EXT = $80E0;  
  GL_BGRA_EXT = $80E1;  
{////#endif /* GL_EXT_bgra */ }
{////#ifndef GL_EXT_bindable_uniform }
  GL_EXT_bindable_uniform = 1;  
  GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = $8DE2;  
  GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = $8DE3;  
  GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = $8DE4;  
  GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = $8DED;  
  GL_UNIFORM_BUFFER_EXT = $8DEE;  
  GL_UNIFORM_BUFFER_BINDING_EXT = $8DEF;  
{////typedef void (P PFNGLUNIFORMBUFFEREXTPROC) (GLuint program_, GLint location, GLuint buffer); }
{////typedef GLint (P PFNGLGETUNIFORMBUFFERSIZEEXTPROC) (GLuint program_, GLint location); }
{////typedef GLintptr (P PFNGLGETUNIFORMOFFSETEXTPROC) (GLuint program_, GLint location); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glUniformBufferEXT(program_:TGLuint; location:TGLint; buffer:TGLuint);cdecl;external;
function glGetUniformBufferSizeEXT(program_:TGLuint; location:TGLint):TGLint;cdecl;external;
function glGetUniformOffsetEXT(program_:TGLuint; location:TGLint):TGLintptr;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_bindable_uniform */ }
{////#ifndef GL_EXT_blend_color }
const
  GL_EXT_blend_color = 1;  
  GL_CONSTANT_COLOR_EXT = $8001;  
  GL_ONE_MINUS_CONSTANT_COLOR_EXT = $8002;  
  GL_CONSTANT_ALPHA_EXT = $8003;  
  GL_ONE_MINUS_CONSTANT_ALPHA_EXT = $8004;  
  GL_BLEND_COLOR_EXT = $8005;  
{////typedef void (P PFNGLBLENDCOLOREXTPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendColorEXT(red:TGLfloat; green:TGLfloat; blue:TGLfloat; alpha:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_blend_color */ }
{////#ifndef GL_EXT_blend_equation_separate }
const
  GL_EXT_blend_equation_separate = 1;  
  GL_BLEND_EQUATION_RGB_EXT = $8009;  
  GL_BLEND_EQUATION_ALPHA_EXT = $883D;  
{////typedef void (P PFNGLBLENDEQUATIONSEPARATEEXTPROC) (GLenum modeRGB, GLenum modeAlpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendEquationSeparateEXT(modeRGB:TGLenum; modeAlpha:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_blend_equation_separate */ }
{////#ifndef GL_EXT_blend_func_separate }
const
  GL_EXT_blend_func_separate = 1;  
  GL_BLEND_DST_RGB_EXT = $80C8;  
  GL_BLEND_SRC_RGB_EXT = $80C9;  
  GL_BLEND_DST_ALPHA_EXT = $80CA;  
  GL_BLEND_SRC_ALPHA_EXT = $80CB;  
{////typedef void (P PFNGLBLENDFUNCSEPARATEEXTPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendFuncSeparateEXT(sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_blend_func_separate */ }
{////#ifndef GL_EXT_blend_logic_op }
const
  GL_EXT_blend_logic_op = 1;  
{////#endif /* GL_EXT_blend_logic_op */ }
{////#ifndef GL_EXT_blend_minmax }
  GL_EXT_blend_minmax = 1;  
  GL_MIN_EXT = $8007;  
  GL_MAX_EXT = $8008;  
  GL_FUNC_ADD_EXT = $8006;  
  GL_BLEND_EQUATION_EXT = $8009;  
{////typedef void (P PFNGLBLENDEQUATIONEXTPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendEquationEXT(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_blend_minmax */ }
{////#ifndef GL_EXT_blend_subtract }
const
  GL_EXT_blend_subtract = 1;  
  GL_FUNC_SUBTRACT_EXT = $800A;  
  GL_FUNC_REVERSE_SUBTRACT_EXT = $800B;  
{////#endif /* GL_EXT_blend_subtract */ }
{////#ifndef GL_EXT_clip_volume_hint }
  GL_EXT_clip_volume_hint = 1;  
  GL_CLIP_VOLUME_CLIPPING_HINT_EXT = $80F0;  
{////#endif /* GL_EXT_clip_volume_hint */ }
{////#ifndef GL_EXT_cmyka }
  GL_EXT_cmyka = 1;  
  GL_CMYK_EXT = $800C;  
  GL_CMYKA_EXT = $800D;  
  GL_PACK_CMYK_HINT_EXT = $800E;  
  GL_UNPACK_CMYK_HINT_EXT = $800F;  
{////#endif /* GL_EXT_cmyka */ }
{////#ifndef GL_EXT_color_subtable }
  GL_EXT_color_subtable = 1;  
{////typedef void (P PFNGLCOLORSUBTABLEEXTPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCOPYCOLORSUBTABLEEXTPROC) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glColorSubTableEXT(target:TGLenum; start:TGLsizei; count:TGLsizei; format:TGLenum; _type:TGLenum; 
            data:pointer);cdecl;external;
procedure glCopyColorSubTableEXT(target:TGLenum; start:TGLsizei; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_color_subtable */ }
{////#ifndef GL_EXT_compiled_vertex_array }
const
  GL_EXT_compiled_vertex_array = 1;  
  GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = $81A8;  
  GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = $81A9;  
{////typedef void (P PFNGLLOCKARRAYSEXTPROC) (GLint first, GLsizei count); }
{////typedef void (P PFNGLUNLOCKARRAYSEXTPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glLockArraysEXT(first:TGLint; count:TGLsizei);cdecl;external;
procedure glUnlockArraysEXT;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_compiled_vertex_array */ }
{////#ifndef GL_EXT_convolution }
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
{////typedef void (P PFNGLCONVOLUTIONFILTER1DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image); }
{////typedef void (P PFNGLCONVOLUTIONFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERFEXTPROC) (GLenum target, GLenum pname, GLfloat params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERFVEXTPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERIEXTPROC) (GLenum target, GLenum pname, GLint params); }
{////typedef void (P PFNGLCONVOLUTIONPARAMETERIVEXTPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLCOPYCONVOLUTIONFILTER1DEXTPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYCONVOLUTIONFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETCONVOLUTIONFILTEREXTPROC) (GLenum target, GLenum format, GLenum type, void *image); }
{////typedef void (P PFNGLGETCONVOLUTIONPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCONVOLUTIONPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETSEPARABLEFILTEREXTPROC) (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span); }
{////typedef void (P PFNGLSEPARABLEFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glConvolutionFilter1DEXT(target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum; 
            image:pointer);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionFilter2DEXT(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; image:pointer);cdecl;external;
procedure glConvolutionParameterfEXT(target:TGLenum; pname:TGLenum; params:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glConvolutionParameteriEXT(target:TGLenum; pname:TGLenum; params:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glConvolutionParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCopyConvolutionFilter1DEXT(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
procedure glCopyConvolutionFilter2DEXT(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
procedure glGetConvolutionFilterEXT(target:TGLenum; format:TGLenum; _type:TGLenum; image:pointer);cdecl;external;
procedure glGetConvolutionParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetConvolutionParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetSeparableFilterEXT(target:TGLenum; format:TGLenum; _type:TGLenum; row:pointer; column:pointer; 
            span:pointer);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glSeparableFilter2DEXT(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; format:TGLenum; 
            _type:TGLenum; row:pointer; column:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_convolution */ }
{////#ifndef GL_EXT_coordinate_frame }
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
{////typedef void (P PFNGLTANGENT3BEXTPROC) (GLbyte tx, GLbyte ty, GLbyte tz); }
{////typedef void (P PFNGLTANGENT3BVEXTPROC) (const GLbyte *v); }
{////typedef void (P PFNGLTANGENT3DEXTPROC) (GLdouble tx, GLdouble ty, GLdouble tz); }
{////typedef void (P PFNGLTANGENT3DVEXTPROC) (const GLdouble *v); }
{////typedef void (P PFNGLTANGENT3FEXTPROC) (GLfloat tx, GLfloat ty, GLfloat tz); }
{////typedef void (P PFNGLTANGENT3FVEXTPROC) (const GLfloat *v); }
{////typedef void (P PFNGLTANGENT3IEXTPROC) (GLint tx, GLint ty, GLint tz); }
{////typedef void (P PFNGLTANGENT3IVEXTPROC) (const GLint *v); }
{////typedef void (P PFNGLTANGENT3SEXTPROC) (GLshort tx, GLshort ty, GLshort tz); }
{////typedef void (P PFNGLTANGENT3SVEXTPROC) (const GLshort *v); }
{////typedef void (P PFNGLBINORMAL3BEXTPROC) (GLbyte bx, GLbyte by, GLbyte bz); }
{////typedef void (P PFNGLBINORMAL3BVEXTPROC) (const GLbyte *v); }
{////typedef void (P PFNGLBINORMAL3DEXTPROC) (GLdouble bx, GLdouble by, GLdouble bz); }
{////typedef void (P PFNGLBINORMAL3DVEXTPROC) (const GLdouble *v); }
{////typedef void (P PFNGLBINORMAL3FEXTPROC) (GLfloat bx, GLfloat by, GLfloat bz); }
{////typedef void (P PFNGLBINORMAL3FVEXTPROC) (const GLfloat *v); }
{////typedef void (P PFNGLBINORMAL3IEXTPROC) (GLint bx, GLint by, GLint bz); }
{////typedef void (P PFNGLBINORMAL3IVEXTPROC) (const GLint *v); }
{////typedef void (P PFNGLBINORMAL3SEXTPROC) (GLshort bx, GLshort by, GLshort bz); }
{////typedef void (P PFNGLBINORMAL3SVEXTPROC) (const GLshort *v); }
{////typedef void (P PFNGLTANGENTPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLBINORMALPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTangent3bEXT(tx:TGLbyte; ty:TGLbyte; tz:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glTangent3bvEXT(v:PGLbyte);cdecl;external;
procedure glTangent3dEXT(tx:TGLdouble; ty:TGLdouble; tz:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glTangent3dvEXT(v:PGLdouble);cdecl;external;
procedure glTangent3fEXT(tx:TGLfloat; ty:TGLfloat; tz:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glTangent3fvEXT(v:PGLfloat);cdecl;external;
procedure glTangent3iEXT(tx:TGLint; ty:TGLint; tz:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glTangent3ivEXT(v:PGLint);cdecl;external;
procedure glTangent3sEXT(tx:TGLshort; ty:TGLshort; tz:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glTangent3svEXT(v:PGLshort);cdecl;external;
procedure glBinormal3bEXT(bx:TGLbyte; by:TGLbyte; bz:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glBinormal3bvEXT(v:PGLbyte);cdecl;external;
procedure glBinormal3dEXT(bx:TGLdouble; by:TGLdouble; bz:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glBinormal3dvEXT(v:PGLdouble);cdecl;external;
procedure glBinormal3fEXT(bx:TGLfloat; by:TGLfloat; bz:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glBinormal3fvEXT(v:PGLfloat);cdecl;external;
procedure glBinormal3iEXT(bx:TGLint; by:TGLint; bz:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glBinormal3ivEXT(v:PGLint);cdecl;external;
procedure glBinormal3sEXT(bx:TGLshort; by:TGLshort; bz:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glBinormal3svEXT(v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glTangentPointerEXT(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
(* Const before type ignored *)
procedure glBinormalPointerEXT(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_coordinate_frame */ }
{////#ifndef GL_EXT_copy_texture }
const
  GL_EXT_copy_texture = 1;  
{////typedef void (P PFNGLCOPYTEXIMAGE1DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border); }
{////typedef void (P PFNGLCOPYTEXIMAGE2DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border); }
{////typedef void (P PFNGLCOPYTEXSUBIMAGE1DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYTEXSUBIMAGE2DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLCOPYTEXSUBIMAGE3DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCopyTexImage1DEXT(target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyTexImage2DEXT(target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; y:TGLint; 
            width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyTexSubImage1DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint; y:TGLint; 
            width:TGLsizei);cdecl;external;
procedure glCopyTexSubImage2DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; x:TGLint; 
            y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glCopyTexSubImage3DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_copy_texture */ }
{////#ifndef GL_EXT_cull_vertex }
const
  GL_EXT_cull_vertex = 1;  
  GL_CULL_VERTEX_EXT = $81AA;  
  GL_CULL_VERTEX_EYE_POSITION_EXT = $81AB;  
  GL_CULL_VERTEX_OBJECT_POSITION_EXT = $81AC;  
{////typedef void (P PFNGLCULLPARAMETERDVEXTPROC) (GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLCULLPARAMETERFVEXTPROC) (GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCullParameterdvEXT(pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glCullParameterfvEXT(pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_cull_vertex */ }
{////#ifndef GL_EXT_debug_label }
const
  GL_EXT_debug_label = 1;  
  GL_PROGRAM_PIPELINE_OBJECT_EXT = $8A4F;  
  GL_PROGRAM_OBJECT_EXT = $8B40;  
  GL_SHADER_OBJECT_EXT = $8B48;  
  GL_BUFFER_OBJECT_EXT = $9151;  
  GL_QUERY_OBJECT_EXT = $9153;  
  GL_VERTEX_ARRAY_OBJECT_EXT = $9154;  
{////typedef void (P PFNGLLABELOBJECTEXTPROC) (GLenum type, GLuint object, GLsizei length, const GLchar *label); }
{////typedef void (P PFNGLGETOBJECTLABELEXTPROC) (GLenum type, GLuint object, GLsizei bufSize, GLsizei *length, GLchar *label); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glLabelObjectEXT(_type:TGLenum; object_:TGLuint; length:TGLsizei; _label:PGLchar);cdecl;external;
procedure glGetObjectLabelEXT(_type:TGLenum; object_:TGLuint; bufSize:TGLsizei; length:PGLsizei; _label:PGLchar);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_debug_label */ }
{////#ifndef GL_EXT_debug_marker }
const
  GL_EXT_debug_marker = 1;  
{////typedef void (P PFNGLINSERTEVENTMARKEREXTPROC) (GLsizei length, const GLchar *marker); }
{////typedef void (P PFNGLPUSHGROUPMARKEREXTPROC) (GLsizei length, const GLchar *marker); }
{////typedef void (P PFNGLPOPGROUPMARKEREXTPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glInsertEventMarkerEXT(length:TGLsizei; marker:PGLchar);cdecl;external;
(* Const before type ignored *)
procedure glPushGroupMarkerEXT(length:TGLsizei; marker:PGLchar);cdecl;external;
procedure glPopGroupMarkerEXT;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_debug_marker */ }
{////#ifndef GL_EXT_depth_bounds_test }
const
  GL_EXT_depth_bounds_test = 1;  
  GL_DEPTH_BOUNDS_TEST_EXT = $8890;  
  GL_DEPTH_BOUNDS_EXT = $8891;  
{////typedef void (P PFNGLDEPTHBOUNDSEXTPROC) (GLclampd zmin, GLclampd zmax); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDepthBoundsEXT(zmin:TGLclampd; zmax:TGLclampd);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_depth_bounds_test */ }
{////#ifndef GL_EXT_direct_state_access }
const
  GL_EXT_direct_state_access = 1;  
  GL_PROGRAM_MATRIX_EXT = $8E2D;  
  GL_TRANSPOSE_PROGRAM_MATRIX_EXT = $8E2E;  
  GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = $8E2F;  
{////typedef void (P PFNGLMATRIXLOADFEXTPROC) (GLenum mode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXLOADDEXTPROC) (GLenum mode, const GLdouble *m); }
{////typedef void (P PFNGLMATRIXMULTFEXTPROC) (GLenum mode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXMULTDEXTPROC) (GLenum mode, const GLdouble *m); }
{////typedef void (P PFNGLMATRIXLOADIDENTITYEXTPROC) (GLenum mode); }
{////typedef void (P PFNGLMATRIXROTATEFEXTPROC) (GLenum mode, GLfloat angle, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLMATRIXROTATEDEXTPROC) (GLenum mode, GLdouble angle, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLMATRIXSCALEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLMATRIXSCALEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLMATRIXTRANSLATEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLMATRIXTRANSLATEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLMATRIXFRUSTUMEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar); }
{////typedef void (P PFNGLMATRIXORTHOEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar); }
{////typedef void (P PFNGLMATRIXPOPEXTPROC) (GLenum mode); }
{////typedef void (P PFNGLMATRIXPUSHEXTPROC) (GLenum mode); }
{////typedef void (P PFNGLCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask); }
{////typedef void (P PFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask); }
{////typedef void (P PFNGLTEXTUREPARAMETERFEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLTEXTUREPARAMETERIEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOPYTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border); }
{////typedef void (P PFNGLCOPYTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum format, GLenum type, void *pixels); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXTURELEVELPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETTEXTURELEVELPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLint *params); }
{////typedef void (P PFNGLTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOPYTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLBINDMULTITEXTUREEXTPROC) (GLenum texunit, GLenum target, GLuint texture); }
{////typedef void (P PFNGLMULTITEXCOORDPOINTEREXTPROC) (GLenum texunit, GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLMULTITEXENVFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLMULTITEXENVIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLMULTITEXGENDEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble param); }
{////typedef void (P PFNGLMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLdouble *params); }
{////typedef void (P PFNGLMULTITEXGENFEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLMULTITEXGENIEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint param); }
{////typedef void (P PFNGLMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLGETMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLGETMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint *params); }
{////typedef void (P PFNGLMULTITEXPARAMETERIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLMULTITEXPARAMETERFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOPYMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border); }
{////typedef void (P PFNGLCOPYMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border); }
{////typedef void (P PFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum format, GLenum type, void *pixels); }
{////typedef void (P PFNGLGETMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLint *params); }
{////typedef void (P PFNGLMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLENABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index); }
{////typedef void (P PFNGLDISABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index); }
{////typedef void (P PFNGLGETFLOATINDEXEDVEXTPROC) (GLenum target, GLuint index, GLfloat *data); }
{////typedef void (P PFNGLGETDOUBLEINDEXEDVEXTPROC) (GLenum target, GLuint index, GLdouble *data); }
{////typedef void (P PFNGLGETPOINTERINDEXEDVEXTPROC) (GLenum target, GLuint index, void **data); }
{////typedef void (P PFNGLENABLEINDEXEDEXTPROC) (GLenum target, GLuint index); }
{////typedef void (P PFNGLDISABLEINDEXEDEXTPROC) (GLenum target, GLuint index); }
{////typedef GLboolean (P PFNGLISENABLEDINDEXEDEXTPROC) (GLenum target, GLuint index); }
{////typedef void (P PFNGLGETINTEGERINDEXEDVEXTPROC) (GLenum target, GLuint index, GLint *data); }
{////typedef void (P PFNGLGETBOOLEANINDEXEDVEXTPROC) (GLenum target, GLuint index, GLboolean *data); }
{////typedef void (P PFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint lod, void *img); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits); }
{////typedef void (P PFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint lod, void *img); }
{////typedef void (P PFNGLMATRIXLOADTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXLOADTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m); }
{////typedef void (P PFNGLMATRIXMULTTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXMULTTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m); }
{////typedef void (P PFNGLNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage); }
{////typedef void (P PFNGLNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data); }
{////typedef void *(P PFNGLMAPNAMEDBUFFEREXTPROC) (GLuint buffer, GLenum access); }
{////typedef GLboolean (P PFNGLUNMAPNAMEDBUFFEREXTPROC) (GLuint buffer); }
{////typedef void (P PFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC) (GLuint buffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETNAMEDBUFFERPOINTERVEXTPROC) (GLuint buffer, GLenum pname, void **params); }
{////typedef void (P PFNGLGETNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data); }
{////typedef void (P PFNGLPROGRAMUNIFORM1FEXTPROC) (GLuint program_, GLint location, GLfloat v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM2FEXTPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM3FEXTPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1, GLfloat v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM4FEXTPROC) (GLuint program_, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM1IEXTPROC) (GLuint program_, GLint location, GLint v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM2IEXTPROC) (GLuint program_, GLint location, GLint v0, GLint v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM3IEXTPROC) (GLuint program_, GLint location, GLint v0, GLint v1, GLint v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM4IEXTPROC) (GLuint program_, GLint location, GLint v0, GLint v1, GLint v2, GLint v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM1FVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2FVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3FVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4FVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM1IVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2IVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3IVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4IVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value); }
{////typedef void (P PFNGLTEXTUREBUFFEREXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer); }
{////typedef void (P PFNGLMULTITEXBUFFEREXTPROC) (GLenum texunit, GLenum target, GLenum internalformat, GLuint buffer); }
{////typedef void (P PFNGLTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLuint *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLuint *params); }
{////typedef void (P PFNGLGETMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UIEXTPROC) (GLuint program_, GLint location, GLuint v0); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UIEXTPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UIEXTPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1, GLuint v2); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UIEXTPROC) (GLuint program_, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3); }
{////typedef void (P PFNGLPROGRAMUNIFORM1UIVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2UIVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3UIVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4UIVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLsizei count, const GLfloat *params); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC) (GLuint program_, GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC) (GLuint program_, GLenum target, GLuint index, const GLint *params); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLsizei count, const GLint *params); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC) (GLuint program_, GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC) (GLuint program_, GLenum target, GLuint index, const GLuint *params); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLsizei count, const GLuint *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLint *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLuint *params); }
{////typedef void (P PFNGLENABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index); }
{////typedef void (P PFNGLDISABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index); }
{////typedef void (P PFNGLGETFLOATI_VEXTPROC) (GLenum pname, GLuint index, GLfloat *params); }
{////typedef void (P PFNGLGETDOUBLEI_VEXTPROC) (GLenum pname, GLuint index, GLdouble *params); }
{////typedef void (P PFNGLGETPOINTERI_VEXTPROC) (GLenum pname, GLuint index, void **params); }
{////typedef void (P PFNGLNAMEDPROGRAMSTRINGEXTPROC) (GLuint program_, GLenum target, GLenum format, GLsizei len, const void *string); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC) (GLuint program_, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC) (GLuint program_, GLenum target, GLuint index, const GLdouble *params); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC) (GLuint program_, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC) (GLuint program_, GLenum target, GLuint index, const GLfloat *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLdouble *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC) (GLuint program_, GLenum target, GLuint index, GLfloat *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMIVEXTPROC) (GLuint program_, GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETNAMEDPROGRAMSTRINGEXTPROC) (GLuint program_, GLenum target, GLenum pname, void *string); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC) (GLuint renderbuffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC) (GLuint renderbuffer, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef GLenum (P PFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC) (GLuint framebuffer, GLenum target); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer); }
{////typedef void (P PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGENERATETEXTUREMIPMAPEXTPROC) (GLuint texture, GLenum target); }
{////typedef void (P PFNGLGENERATEMULTITEXMIPMAPEXTPROC) (GLenum texunit, GLenum target); }
{////typedef void (P PFNGLFRAMEBUFFERDRAWBUFFEREXTPROC) (GLuint framebuffer, GLenum mode); }
{////typedef void (P PFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs); }
{////typedef void (P PFNGLFRAMEBUFFERREADBUFFEREXTPROC) (GLuint framebuffer, GLenum mode); }
{////typedef void (P PFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLenum face); }
{////typedef void (P PFNGLTEXTURERENDERBUFFEREXTPROC) (GLuint texture, GLenum target, GLuint renderbuffer); }
{////typedef void (P PFNGLMULTITEXRENDERBUFFEREXTPROC) (GLenum texunit, GLenum target, GLuint renderbuffer); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYINDEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYNORMALOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum texunit, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLENABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array); }
{////typedef void (P PFNGLDISABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array); }
{////typedef void (P PFNGLENABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index); }
{////typedef void (P PFNGLDISABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index); }
{////typedef void (P PFNGLGETVERTEXARRAYINTEGERVEXTPROC) (GLuint vaobj, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETVERTEXARRAYPOINTERVEXTPROC) (GLuint vaobj, GLenum pname, void **param); }
{////typedef void (P PFNGLGETVERTEXARRAYINTEGERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param); }
{////typedef void (P PFNGLGETVERTEXARRAYPOINTERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, void **param); }
{////typedef void *(P PFNGLMAPNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access); }
{////typedef void (P PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length); }
{////typedef void (P PFNGLNAMEDBUFFERSTORAGEEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags); }
{////typedef void (P PFNGLCLEARNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLsizeiptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC) (GLuint framebuffer, GLenum pname, GLint param); }
{////typedef void (P PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params); }
{////typedef void (P PFNGLPROGRAMUNIFORM1DEXTPROC) (GLuint program_, GLint location, GLdouble x); }
{////typedef void (P PFNGLPROGRAMUNIFORM2DEXTPROC) (GLuint program_, GLint location, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLPROGRAMUNIFORM3DEXTPROC) (GLuint program_, GLint location, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLPROGRAMUNIFORM4DEXTPROC) (GLuint program_, GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLPROGRAMUNIFORM1DVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM2DVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM3DVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORM4DVEXTPROC) (GLuint program_, GLint location, GLsizei count, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X3DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX2X4DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X2DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX3X4DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X2DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMMATRIX4X3DVEXTPROC) (GLuint program_, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value); }
{////typedef void (P PFNGLTEXTUREBUFFERRANGEEXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLTEXTURESTORAGE1DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width); }
{////typedef void (P PFNGLTEXTURESTORAGE2DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLTEXTURESTORAGE3DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth); }
{////typedef void (P PFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations); }
{////typedef void (P PFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset); }
{////typedef void (P PFNGLTEXTUREPAGECOMMITMENTEXTPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit); }
{////typedef void (P PFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC) (GLuint vaobj, GLuint index, GLuint divisor); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMatrixLoadfEXT(mode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoaddEXT(mode:TGLenum; m:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMultfEXT(mode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMultdEXT(mode:TGLenum; m:PGLdouble);cdecl;external;
procedure glMatrixLoadIdentityEXT(mode:TGLenum);cdecl;external;
procedure glMatrixRotatefEXT(mode:TGLenum; angle:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
procedure glMatrixRotatedEXT(mode:TGLenum; angle:TGLdouble; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glMatrixScalefEXT(mode:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
procedure glMatrixScaledEXT(mode:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glMatrixTranslatefEXT(mode:TGLenum; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
procedure glMatrixTranslatedEXT(mode:TGLenum; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glMatrixFrustumEXT(mode:TGLenum; left:TGLdouble; right:TGLdouble; bottom:TGLdouble; top:TGLdouble; 
            zNear:TGLdouble; zFar:TGLdouble);cdecl;external;
procedure glMatrixOrthoEXT(mode:TGLenum; left:TGLdouble; right:TGLdouble; bottom:TGLdouble; top:TGLdouble; 
            zNear:TGLdouble; zFar:TGLdouble);cdecl;external;
procedure glMatrixPopEXT(mode:TGLenum);cdecl;external;
procedure glMatrixPushEXT(mode:TGLenum);cdecl;external;
procedure glClientAttribDefaultEXT(mask:TGLbitfield);cdecl;external;
procedure glPushClientAttribDefaultEXT(mask:TGLbitfield);cdecl;external;
procedure glTextureParameterfEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterfvEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glTextureParameteriEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            height:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; 
            format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
procedure glCopyTextureImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; 
            y:TGLint; width:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyTextureImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; 
            y:TGLint; width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyTextureSubImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint; 
            y:TGLint; width:TGLsizei);cdecl;external;
procedure glCopyTextureSubImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetTextureImageEXT(texture:TGLuint; target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
procedure glGetTextureParameterfvEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetTextureParameterivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTextureLevelParameterfvEXT(texture:TGLuint; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetTextureLevelParameterivEXT(texture:TGLuint; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureImage3DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTextureSubImage3DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external;
procedure glCopyTextureSubImage3DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glBindMultiTextureEXT(texunit:TGLenum; target:TGLenum; texture:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoordPointerEXT(texunit:TGLenum; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glMultiTexEnvfEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexEnvfvEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glMultiTexEnviEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexEnvivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glMultiTexGendEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexGendvEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glMultiTexGenfEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexGenfvEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glMultiTexGeniEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexGenivEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMultiTexEnvfvEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMultiTexEnvivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMultiTexGendvEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glGetMultiTexGenfvEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMultiTexGenivEXT(texunit:TGLenum; coord:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glMultiTexParameteriEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexParameterivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glMultiTexParameterfEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexParameterfvEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            height:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexSubImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; 
            format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexSubImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
procedure glCopyMultiTexImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; 
            y:TGLint; width:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyMultiTexImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; x:TGLint; 
            y:TGLint; width:TGLsizei; height:TGLsizei; border:TGLint);cdecl;external;
procedure glCopyMultiTexSubImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; x:TGLint; 
            y:TGLint; width:TGLsizei);cdecl;external;
procedure glCopyMultiTexSubImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetMultiTexImageEXT(texunit:TGLenum; target:TGLenum; level:TGLint; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
procedure glGetMultiTexParameterfvEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMultiTexParameterivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMultiTexLevelParameterfvEXT(texunit:TGLenum; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMultiTexLevelParameterivEXT(texunit:TGLenum; target:TGLenum; level:TGLint; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexImage3DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLint; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexSubImage3DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external;
procedure glCopyMultiTexSubImage3DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glEnableClientStateIndexedEXT(array_:TGLenum; index:TGLuint);cdecl;external;
procedure glDisableClientStateIndexedEXT(array_:TGLenum; index:TGLuint);cdecl;external;
procedure glGetFloatIndexedvEXT(target:TGLenum; index:TGLuint; data:PGLfloat);cdecl;external;
procedure glGetDoubleIndexedvEXT(target:TGLenum; index:TGLuint; data:PGLdouble);cdecl;external;
procedure glGetPointerIndexedvEXT(target:TGLenum; index:TGLuint; data:Ppointer);cdecl;external;
procedure glEnableIndexedEXT(target:TGLenum; index:TGLuint);cdecl;external;
procedure glDisableIndexedEXT(target:TGLenum; index:TGLuint);cdecl;external;
function glIsEnabledIndexedEXT(target:TGLenum; index:TGLuint):TGLboolean;cdecl;external;
procedure glGetIntegerIndexedvEXT(target:TGLenum; index:TGLuint; data:PGLint);cdecl;external;
procedure glGetBooleanIndexedvEXT(target:TGLenum; index:TGLuint; data:PGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureImage3DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage3DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
            imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage2DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; format:TGLenum; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedTextureSubImage1DEXT(texture:TGLuint; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; 
            format:TGLenum; imageSize:TGLsizei; bits:pointer);cdecl;external;
procedure glGetCompressedTextureImageEXT(texture:TGLuint; target:TGLenum; lod:TGLint; img:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexImage3DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; 
            border:TGLint; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexSubImage3DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; 
            imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexSubImage2DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; format:TGLenum; imageSize:TGLsizei; bits:pointer);cdecl;external;
(* Const before type ignored *)
procedure glCompressedMultiTexSubImage1DEXT(texunit:TGLenum; target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; 
            format:TGLenum; imageSize:TGLsizei; bits:pointer);cdecl;external;
procedure glGetCompressedMultiTexImageEXT(texunit:TGLenum; target:TGLenum; lod:TGLint; img:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoadTransposefEXT(mode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoadTransposedEXT(mode:TGLenum; m:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMultTransposefEXT(mode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMultTransposedEXT(mode:TGLenum; m:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferDataEXT(buffer:TGLuint; size:TGLsizeiptr; data:pointer; usage:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferSubDataEXT(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
function glMapNamedBufferEXT(buffer:TGLuint; access:TGLenum):pointer;cdecl;external;
function glUnmapNamedBufferEXT(buffer:TGLuint):TGLboolean;cdecl;external;
procedure glGetNamedBufferParameterivEXT(buffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetNamedBufferPointervEXT(buffer:TGLuint; pname:TGLenum; params:Ppointer);cdecl;external;
procedure glGetNamedBufferSubDataEXT(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glProgramUniform1fEXT(program_:TGLuint; location:TGLint; v0:TGLfloat);cdecl;external;
procedure glProgramUniform2fEXT(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat);cdecl;external;
procedure glProgramUniform3fEXT(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat);cdecl;external;
procedure glProgramUniform4fEXT(program_:TGLuint; location:TGLint; v0:TGLfloat; v1:TGLfloat; v2:TGLfloat; 
            v3:TGLfloat);cdecl;external;
procedure glProgramUniform1iEXT(program_:TGLuint; location:TGLint; v0:TGLint);cdecl;external;
procedure glProgramUniform2iEXT(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint);cdecl;external;
procedure glProgramUniform3iEXT(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint);cdecl;external;
procedure glProgramUniform4iEXT(program_:TGLuint; location:TGLint; v0:TGLint; v1:TGLint; v2:TGLint; 
            v3:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1ivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2ivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3ivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4ivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x3fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x2fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x4fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x2fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x4fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x3fvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLfloat);cdecl;external;
procedure glTextureBufferEXT(texture:TGLuint; target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
procedure glMultiTexBufferEXT(texunit:TGLenum; target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterIivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTextureParameterIuivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetTextureParameterIivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTextureParameterIuivEXT(texture:TGLuint; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexParameterIivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexParameterIuivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetMultiTexParameterIivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMultiTexParameterIuivEXT(texunit:TGLenum; target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glProgramUniform1uiEXT(program_:TGLuint; location:TGLint; v0:TGLuint);cdecl;external;
procedure glProgramUniform2uiEXT(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;external;
procedure glProgramUniform3uiEXT(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;external;
procedure glProgramUniform4uiEXT(program_:TGLuint; location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; 
            v3:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1uivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2uivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3uivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4uivEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParameters4fvEXT(program_:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;external;
procedure glNamedProgramLocalParameterI4iEXT(program_:TGLuint; target:TGLenum; index:TGLuint; x:TGLint; y:TGLint; 
            z:TGLint; w:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParameterI4ivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParametersI4ivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;external;
procedure glNamedProgramLocalParameterI4uiEXT(program_:TGLuint; target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint; 
            z:TGLuint; w:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParameterI4uivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParametersI4uivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;external;
procedure glGetNamedProgramLocalParameterIivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
procedure glGetNamedProgramLocalParameterIuivEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
procedure glEnableClientStateiEXT(array_:TGLenum; index:TGLuint);cdecl;external;
procedure glDisableClientStateiEXT(array_:TGLenum; index:TGLuint);cdecl;external;
procedure glGetFloati_vEXT(pname:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetDoublei_vEXT(pname:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glGetPointeri_vEXT(pname:TGLenum; index:TGLuint; params:Ppointer);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramStringEXT(program_:TGLuint; target:TGLenum; format:TGLenum; len:TGLsizei; _string:pointer);cdecl;external;
procedure glNamedProgramLocalParameter4dEXT(program_:TGLuint; target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; 
            z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParameter4dvEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glNamedProgramLocalParameter4fEXT(program_:TGLuint; target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glNamedProgramLocalParameter4fvEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetNamedProgramLocalParameterdvEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLdouble);cdecl;external;
procedure glGetNamedProgramLocalParameterfvEXT(program_:TGLuint; target:TGLenum; index:TGLuint; params:PGLfloat);cdecl;external;
procedure glGetNamedProgramivEXT(program_:TGLuint; target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetNamedProgramStringEXT(program_:TGLuint; target:TGLenum; pname:TGLenum; _string:pointer);cdecl;external;
procedure glNamedRenderbufferStorageEXT(renderbuffer:TGLuint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetNamedRenderbufferParameterivEXT(renderbuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glNamedRenderbufferStorageMultisampleEXT(renderbuffer:TGLuint; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glNamedRenderbufferStorageMultisampleCoverageEXT(renderbuffer:TGLuint; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
function glCheckNamedFramebufferStatusEXT(framebuffer:TGLuint; target:TGLenum):TGLenum;cdecl;external;
procedure glNamedFramebufferTexture1DEXT(framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glNamedFramebufferTexture2DEXT(framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glNamedFramebufferTexture3DEXT(framebuffer:TGLuint; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint; 
            zoffset:TGLint);cdecl;external;
procedure glNamedFramebufferRenderbufferEXT(framebuffer:TGLuint; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glGetNamedFramebufferAttachmentParameterivEXT(framebuffer:TGLuint; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGenerateTextureMipmapEXT(texture:TGLuint; target:TGLenum);cdecl;external;
procedure glGenerateMultiTexMipmapEXT(texunit:TGLenum; target:TGLenum);cdecl;external;
procedure glFramebufferDrawBufferEXT(framebuffer:TGLuint; mode:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glFramebufferDrawBuffersEXT(framebuffer:TGLuint; n:TGLsizei; bufs:PGLenum);cdecl;external;
procedure glFramebufferReadBufferEXT(framebuffer:TGLuint; mode:TGLenum);cdecl;external;
procedure glGetFramebufferParameterivEXT(framebuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glNamedCopyBufferSubDataEXT(readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glNamedFramebufferTextureEXT(framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glNamedFramebufferTextureLayerEXT(framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;external;
procedure glNamedFramebufferTextureFaceEXT(framebuffer:TGLuint; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;external;
procedure glTextureRenderbufferEXT(texture:TGLuint; target:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glMultiTexRenderbufferEXT(texunit:TGLenum; target:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glVertexArrayVertexOffsetEXT(vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; 
            offset:TGLintptr);cdecl;external;
procedure glVertexArrayColorOffsetEXT(vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; 
            offset:TGLintptr);cdecl;external;
procedure glVertexArrayEdgeFlagOffsetEXT(vaobj:TGLuint; buffer:TGLuint; stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArrayIndexOffsetEXT(vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArrayNormalOffsetEXT(vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArrayTexCoordOffsetEXT(vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; 
            offset:TGLintptr);cdecl;external;
procedure glVertexArrayMultiTexCoordOffsetEXT(vaobj:TGLuint; buffer:TGLuint; texunit:TGLenum; size:TGLint; _type:TGLenum; 
            stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArrayFogCoordOffsetEXT(vaobj:TGLuint; buffer:TGLuint; _type:TGLenum; stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArraySecondaryColorOffsetEXT(vaobj:TGLuint; buffer:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; 
            offset:TGLintptr);cdecl;external;
procedure glVertexArrayVertexAttribOffsetEXT(vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum; 
            normalized:TGLboolean; stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glVertexArrayVertexAttribIOffsetEXT(vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum; 
            stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glEnableVertexArrayEXT(vaobj:TGLuint; array_:TGLenum);cdecl;external;
procedure glDisableVertexArrayEXT(vaobj:TGLuint; array_:TGLenum);cdecl;external;
procedure glEnableVertexArrayAttribEXT(vaobj:TGLuint; index:TGLuint);cdecl;external;
procedure glDisableVertexArrayAttribEXT(vaobj:TGLuint; index:TGLuint);cdecl;external;
procedure glGetVertexArrayIntegervEXT(vaobj:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetVertexArrayPointervEXT(vaobj:TGLuint; pname:TGLenum; param:Ppointer);cdecl;external;
procedure glGetVertexArrayIntegeri_vEXT(vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:PGLint);cdecl;external;
procedure glGetVertexArrayPointeri_vEXT(vaobj:TGLuint; index:TGLuint; pname:TGLenum; param:Ppointer);cdecl;external;
function glMapNamedBufferRangeEXT(buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr; access:TGLbitfield):pointer;cdecl;external;
procedure glFlushMappedNamedBufferRangeEXT(buffer:TGLuint; offset:TGLintptr; length:TGLsizeiptr);cdecl;external;
(* Const before type ignored *)
procedure glNamedBufferStorageEXT(buffer:TGLuint; size:TGLsizeiptr; data:pointer; flags:TGLbitfield);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedBufferDataEXT(buffer:TGLuint; internalformat:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glClearNamedBufferSubDataEXT(buffer:TGLuint; internalformat:TGLenum; offset:TGLsizeiptr; size:TGLsizeiptr; format:TGLenum; 
            _type:TGLenum; data:pointer);cdecl;external;
procedure glNamedFramebufferParameteriEXT(framebuffer:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
procedure glGetNamedFramebufferParameterivEXT(framebuffer:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glProgramUniform1dEXT(program_:TGLuint; location:TGLint; x:TGLdouble);cdecl;external;
procedure glProgramUniform2dEXT(program_:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble);cdecl;external;
procedure glProgramUniform3dEXT(program_:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glProgramUniform4dEXT(program_:TGLuint; location:TGLint; x:TGLdouble; y:TGLdouble; z:TGLdouble; 
            w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform1dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform2dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform3dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniform4dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x3dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix2x4dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x2dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix3x4dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x2dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformMatrix4x3dvEXT(program_:TGLuint; location:TGLint; count:TGLsizei; transpose:TGLboolean; value:PGLdouble);cdecl;external;
procedure glTextureBufferRangeEXT(texture:TGLuint; target:TGLenum; internalformat:TGLenum; buffer:TGLuint; offset:TGLintptr; 
            size:TGLsizeiptr);cdecl;external;
procedure glTextureStorage1DEXT(texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;external;
procedure glTextureStorage2DEXT(texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
procedure glTextureStorage3DEXT(texture:TGLuint; target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei);cdecl;external;
procedure glTextureStorage2DMultisampleEXT(texture:TGLuint; target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;external;
procedure glTextureStorage3DMultisampleEXT(texture:TGLuint; target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; fixedsamplelocations:TGLboolean);cdecl;external;
procedure glVertexArrayBindVertexBufferEXT(vaobj:TGLuint; bindingindex:TGLuint; buffer:TGLuint; offset:TGLintptr; stride:TGLsizei);cdecl;external;
procedure glVertexArrayVertexAttribFormatEXT(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; 
            relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayVertexAttribIFormatEXT(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayVertexAttribLFormatEXT(vaobj:TGLuint; attribindex:TGLuint; size:TGLint; _type:TGLenum; relativeoffset:TGLuint);cdecl;external;
procedure glVertexArrayVertexAttribBindingEXT(vaobj:TGLuint; attribindex:TGLuint; bindingindex:TGLuint);cdecl;external;
procedure glVertexArrayVertexBindingDivisorEXT(vaobj:TGLuint; bindingindex:TGLuint; divisor:TGLuint);cdecl;external;
procedure glVertexArrayVertexAttribLOffsetEXT(vaobj:TGLuint; buffer:TGLuint; index:TGLuint; size:TGLint; _type:TGLenum; 
            stride:TGLsizei; offset:TGLintptr);cdecl;external;
procedure glTexturePageCommitmentEXT(texture:TGLuint; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; commit:TGLboolean);cdecl;external;
procedure glVertexArrayVertexAttribDivisorEXT(vaobj:TGLuint; index:TGLuint; divisor:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_direct_state_access */ }
{////#ifndef GL_EXT_draw_buffers2 }
const
  GL_EXT_draw_buffers2 = 1;  
{////typedef void (P PFNGLCOLORMASKINDEXEDEXTPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glColorMaskIndexedEXT(index:TGLuint; r:TGLboolean; g:TGLboolean; b:TGLboolean; a:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_draw_buffers2 */ }
{////#ifndef GL_EXT_draw_instanced }
const
  GL_EXT_draw_instanced = 1;  
{////typedef void (P PFNGLDRAWARRAYSINSTANCEDEXTPROC) (GLenum mode, GLint start, GLsizei count, GLsizei primcount); }
{////typedef void (P PFNGLDRAWELEMENTSINSTANCEDEXTPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawArraysInstancedEXT(mode:TGLenum; start:TGLint; count:TGLsizei; primcount:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glDrawElementsInstancedEXT(mode:TGLenum; count:TGLsizei; _type:TGLenum; indices:pointer; primcount:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_draw_instanced */ }
{////#ifndef GL_EXT_draw_range_elements }
const
  GL_EXT_draw_range_elements = 1;  
  GL_MAX_ELEMENTS_VERTICES_EXT = $80E8;  
  GL_MAX_ELEMENTS_INDICES_EXT = $80E9;  
{////typedef void (P PFNGLDRAWRANGEELEMENTSEXTPROC) (GLenum mode, GLuint start, GLuint end_, GLsizei count, GLenum type, const void *indices); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDrawRangeElementsEXT(mode:TGLenum; start:TGLuint; end_:TGLuint; count:TGLsizei; _type:TGLenum; 
            indices:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_draw_range_elements */ }
{////#ifndef GL_EXT_external_buffer }
const
  GL_EXT_external_buffer = 1;  
type
  PGLeglClientBufferEXT = ^TGLeglClientBufferEXT;
  TGLeglClientBufferEXT = pointer;
{////typedef void (P PFNGLBUFFERSTORAGEEXTERNALEXTPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags); }
{////typedef void (P PFNGLNAMEDBUFFERSTORAGEEXTERNALEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBufferStorageExternalEXT(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; clientBuffer:TGLeglClientBufferEXT; flags:TGLbitfield);cdecl;external;
procedure glNamedBufferStorageExternalEXT(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; clientBuffer:TGLeglClientBufferEXT; flags:TGLbitfield);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_external_buffer */ }
{////#ifndef GL_EXT_fog_coord }
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
{////typedef void (P PFNGLFOGCOORDFEXTPROC) (GLfloat coord); }
{////typedef void (P PFNGLFOGCOORDFVEXTPROC) (const GLfloat *coord); }
{////typedef void (P PFNGLFOGCOORDDEXTPROC) (GLdouble coord); }
{////typedef void (P PFNGLFOGCOORDDVEXTPROC) (const GLdouble *coord); }
{////typedef void (P PFNGLFOGCOORDPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFogCoordfEXT(coord:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordfvEXT(coord:PGLfloat);cdecl;external;
procedure glFogCoorddEXT(coord:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glFogCoorddvEXT(coord:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordPointerEXT(_type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_fog_coord */ }
{////#ifndef GL_EXT_framebuffer_blit }
const
  GL_EXT_framebuffer_blit = 1;  
  GL_READ_FRAMEBUFFER_EXT = $8CA8;  
  GL_DRAW_FRAMEBUFFER_EXT = $8CA9;  
  GL_DRAW_FRAMEBUFFER_BINDING_EXT = $8CA6;  
  GL_READ_FRAMEBUFFER_BINDING_EXT = $8CAA;  
{////typedef void (P PFNGLBLITFRAMEBUFFEREXTPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlitFramebufferEXT(srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint; 
            dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_framebuffer_blit */ }
{////#ifndef GL_EXT_framebuffer_blit_layers }
const
  GL_EXT_framebuffer_blit_layers = 1;  
{////typedef void (P PFNGLBLITFRAMEBUFFERLAYERSEXTPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter); }
{////typedef void (P PFNGLBLITFRAMEBUFFERLAYEREXTPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint srcLayer, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLint dstLayer, GLbitfield mask, GLenum filter); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlitFramebufferLayersEXT(srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; dstX0:TGLint; 
            dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; filter:TGLenum);cdecl;external;
procedure glBlitFramebufferLayerEXT(srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; srcLayer:TGLint; 
            dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; dstLayer:TGLint; 
            mask:TGLbitfield; filter:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_framebuffer_blit_layers */ }
{////#ifndef GL_EXT_framebuffer_multisample }
const
  GL_EXT_framebuffer_multisample = 1;  
  GL_RENDERBUFFER_SAMPLES_EXT = $8CAB;  
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = $8D56;  
  GL_MAX_SAMPLES_EXT = $8D57;  
{////typedef void (P PFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glRenderbufferStorageMultisampleEXT(target:TGLenum; samples:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_framebuffer_multisample */ }
{////#ifndef GL_EXT_framebuffer_multisample_blit_scaled }
const
  GL_EXT_framebuffer_multisample_blit_scaled = 1;  
  GL_SCALED_RESOLVE_FASTEST_EXT = $90BA;  
  GL_SCALED_RESOLVE_NICEST_EXT = $90BB;  
{////#endif /* GL_EXT_framebuffer_multisample_blit_scaled */ }
{////#ifndef GL_EXT_framebuffer_object }
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
{////typedef GLboolean (P PFNGLISRENDERBUFFEREXTPROC) (GLuint renderbuffer); }
{////typedef void (P PFNGLBINDRENDERBUFFEREXTPROC) (GLenum target, GLuint renderbuffer); }
{////typedef void (P PFNGLDELETERENDERBUFFERSEXTPROC) (GLsizei n, const GLuint *renderbuffers); }
{////typedef void (P PFNGLGENRENDERBUFFERSEXTPROC) (GLsizei n, GLuint *renderbuffers); }
{////typedef void (P PFNGLRENDERBUFFERSTORAGEEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLGETRENDERBUFFERPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef GLboolean (P PFNGLISFRAMEBUFFEREXTPROC) (GLuint framebuffer); }
{////typedef void (P PFNGLBINDFRAMEBUFFEREXTPROC) (GLenum target, GLuint framebuffer); }
{////typedef void (P PFNGLDELETEFRAMEBUFFERSEXTPROC) (GLsizei n, const GLuint *framebuffers); }
{////typedef void (P PFNGLGENFRAMEBUFFERSEXTPROC) (GLsizei n, GLuint *framebuffers); }
{////typedef GLenum (P PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC) (GLenum target); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE1DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE2DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTURE3DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset); }
{////typedef void (P PFNGLFRAMEBUFFERRENDERBUFFEREXTPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer); }
{////typedef void (P PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGENERATEMIPMAPEXTPROC) (GLenum target); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glIsRenderbufferEXT(renderbuffer:TGLuint):TGLboolean;cdecl;external;
procedure glBindRenderbufferEXT(target:TGLenum; renderbuffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteRenderbuffersEXT(n:TGLsizei; renderbuffers:PGLuint);cdecl;external;
procedure glGenRenderbuffersEXT(n:TGLsizei; renderbuffers:PGLuint);cdecl;external;
procedure glRenderbufferStorageEXT(target:TGLenum; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glGetRenderbufferParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
function glIsFramebufferEXT(framebuffer:TGLuint):TGLboolean;cdecl;external;
procedure glBindFramebufferEXT(target:TGLenum; framebuffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteFramebuffersEXT(n:TGLsizei; framebuffers:PGLuint);cdecl;external;
procedure glGenFramebuffersEXT(n:TGLsizei; framebuffers:PGLuint);cdecl;external;
function glCheckFramebufferStatusEXT(target:TGLenum):TGLenum;cdecl;external;
procedure glFramebufferTexture1DEXT(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTexture2DEXT(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTexture3DEXT(target:TGLenum; attachment:TGLenum; textarget:TGLenum; texture:TGLuint; level:TGLint; 
            zoffset:TGLint);cdecl;external;
procedure glFramebufferRenderbufferEXT(target:TGLenum; attachment:TGLenum; renderbuffertarget:TGLenum; renderbuffer:TGLuint);cdecl;external;
procedure glGetFramebufferAttachmentParameterivEXT(target:TGLenum; attachment:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGenerateMipmapEXT(target:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_framebuffer_object */ }
{////#ifndef GL_EXT_framebuffer_sRGB }
const
  GL_EXT_framebuffer_sRGB = 1;  
  GL_FRAMEBUFFER_SRGB_EXT = $8DB9;  
  GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $8DBA;  
{////#endif /* GL_EXT_framebuffer_sRGB */ }
{////#ifndef GL_EXT_geometry_shader4 }
  GL_EXT_geometry_shader4 = 1;  
  GL_GEOMETRY_SHADER_EXT = $8DD9;  
  GL_GEOMETRY_VERTICES_OUT_EXT = $8DDA;  
  GL_GEOMETRY_INPUT_TYPE_EXT = $8DDB;  
  GL_GEOMETRY_OUTPUT_TYPE_EXT = $8DDC;  
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;  
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = $8DDD;  
  GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = $8DDE;  
  GL_MAX_VARYING_COMPONENTS_EXT = $8B4B;  
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;  
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;  
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;  
  GL_LINES_ADJACENCY_EXT = $000A;  
  GL_LINE_STRIP_ADJACENCY_EXT = $000B;  
  GL_TRIANGLES_ADJACENCY_EXT = $000C;  
  GL_TRIANGLE_STRIP_ADJACENCY_EXT = $000D;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;  
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = $8DA9;  
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = $8CD4;  
  GL_PROGRAM_POINT_SIZE_EXT = $8642;  
{////typedef void (P PFNGLPROGRAMPARAMETERIEXTPROC) (GLuint program_, GLenum pname, GLint value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glProgramParameteriEXT(program_:TGLuint; pname:TGLenum; value:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_geometry_shader4 */ }
{////#ifndef GL_EXT_gpu_program_parameters }
const
  GL_EXT_gpu_program_parameters = 1;  
{////typedef void (P PFNGLPROGRAMENVPARAMETERS4FVEXTPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glProgramEnvParameters4fvEXT(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParameters4fvEXT(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_gpu_program_parameters */ }
{////#ifndef GL_EXT_gpu_shader4 }
const
  GL_EXT_gpu_shader4 = 1;  
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
  GL_MIN_PROGRAM_TEXEL_OFFSET_EXT = $8904;  
  GL_MAX_PROGRAM_TEXEL_OFFSET_EXT = $8905;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = $88FD;  
{////typedef void (P PFNGLGETUNIFORMUIVEXTPROC) (GLuint program_, GLint location, GLuint *params); }
{////typedef void (P PFNGLBINDFRAGDATALOCATIONEXTPROC) (GLuint program_, GLuint color, const GLchar *name); }
{////typedef GLint (P PFNGLGETFRAGDATALOCATIONEXTPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLUNIFORM1UIEXTPROC) (GLint location, GLuint v0); }
{////typedef void (P PFNGLUNIFORM2UIEXTPROC) (GLint location, GLuint v0, GLuint v1); }
{////typedef void (P PFNGLUNIFORM3UIEXTPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2); }
{////typedef void (P PFNGLUNIFORM4UIEXTPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3); }
{////typedef void (P PFNGLUNIFORM1UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM2UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM3UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLUNIFORM4UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value); }
{////typedef void (P PFNGLVERTEXATTRIBI1IEXTPROC) (GLuint index, GLint x); }
{////typedef void (P PFNGLVERTEXATTRIBI2IEXTPROC) (GLuint index, GLint x, GLint y); }
{////typedef void (P PFNGLVERTEXATTRIBI3IEXTPROC) (GLuint index, GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLVERTEXATTRIBI4IEXTPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLVERTEXATTRIBI1UIEXTPROC) (GLuint index, GLuint x); }
{////typedef void (P PFNGLVERTEXATTRIBI2UIEXTPROC) (GLuint index, GLuint x, GLuint y); }
{////typedef void (P PFNGLVERTEXATTRIBI3UIEXTPROC) (GLuint index, GLuint x, GLuint y, GLuint z); }
{////typedef void (P PFNGLVERTEXATTRIBI4UIEXTPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w); }
{////typedef void (P PFNGLVERTEXATTRIBI1IVEXTPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI2IVEXTPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI3IVEXTPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4IVEXTPROC) (GLuint index, const GLint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI1UIVEXTPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI2UIVEXTPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI3UIVEXTPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4UIVEXTPROC) (GLuint index, const GLuint *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4BVEXTPROC) (GLuint index, const GLbyte *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4SVEXTPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4UBVEXTPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIBI4USVEXTPROC) (GLuint index, const GLushort *v); }
{////typedef void (P PFNGLVERTEXATTRIBIPOINTEREXTPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLGETVERTEXATTRIBIIVEXTPROC) (GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBIUIVEXTPROC) (GLuint index, GLenum pname, GLuint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetUniformuivEXT(program_:TGLuint; location:TGLint; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glBindFragDataLocationEXT(program_:TGLuint; color:TGLuint; name:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetFragDataLocationEXT(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glUniform1uiEXT(location:TGLint; v0:TGLuint);cdecl;external;
procedure glUniform2uiEXT(location:TGLint; v0:TGLuint; v1:TGLuint);cdecl;external;
procedure glUniform3uiEXT(location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint);cdecl;external;
procedure glUniform4uiEXT(location:TGLint; v0:TGLuint; v1:TGLuint; v2:TGLuint; v3:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform1uivEXT(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform2uivEXT(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform3uivEXT(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glUniform4uivEXT(location:TGLint; count:TGLsizei; value:PGLuint);cdecl;external;
procedure glVertexAttribI1iEXT(index:TGLuint; x:TGLint);cdecl;external;
procedure glVertexAttribI2iEXT(index:TGLuint; x:TGLint; y:TGLint);cdecl;external;
procedure glVertexAttribI3iEXT(index:TGLuint; x:TGLint; y:TGLint; z:TGLint);cdecl;external;
procedure glVertexAttribI4iEXT(index:TGLuint; x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external;
procedure glVertexAttribI1uiEXT(index:TGLuint; x:TGLuint);cdecl;external;
procedure glVertexAttribI2uiEXT(index:TGLuint; x:TGLuint; y:TGLuint);cdecl;external;
procedure glVertexAttribI3uiEXT(index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint);cdecl;external;
procedure glVertexAttribI4uiEXT(index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint; w:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI1ivEXT(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI2ivEXT(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI3ivEXT(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4ivEXT(index:TGLuint; v:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI1uivEXT(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI2uivEXT(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI3uivEXT(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4uivEXT(index:TGLuint; v:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4bvEXT(index:TGLuint; v:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4svEXT(index:TGLuint; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4ubvEXT(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribI4usvEXT(index:TGLuint; v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribIPointerEXT(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glGetVertexAttribIivEXT(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribIuivEXT(index:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_gpu_shader4 */ }
{////#ifndef GL_EXT_histogram }
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
  GL_TABLE_TOO_LARGE_EXT = $8031;  
{////typedef void (P PFNGLGETHISTOGRAMEXTPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values); }
{////typedef void (P PFNGLGETHISTOGRAMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETHISTOGRAMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMINMAXEXTPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values); }
{////typedef void (P PFNGLGETMINMAXPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMINMAXPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLHISTOGRAMEXTPROC) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink); }
{////typedef void (P PFNGLMINMAXEXTPROC) (GLenum target, GLenum internalformat, GLboolean sink); }
{////typedef void (P PFNGLRESETHISTOGRAMEXTPROC) (GLenum target); }
{////typedef void (P PFNGLRESETMINMAXEXTPROC) (GLenum target); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetHistogramEXT(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;external;
procedure glGetHistogramParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetHistogramParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMinmaxEXT(target:TGLenum; reset:TGLboolean; format:TGLenum; _type:TGLenum; values:pointer);cdecl;external;
procedure glGetMinmaxParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMinmaxParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glHistogramEXT(target:TGLenum; width:TGLsizei; internalformat:TGLenum; sink:TGLboolean);cdecl;external;
procedure glMinmaxEXT(target:TGLenum; internalformat:TGLenum; sink:TGLboolean);cdecl;external;
procedure glResetHistogramEXT(target:TGLenum);cdecl;external;
procedure glResetMinmaxEXT(target:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_histogram */ }
{////#ifndef GL_EXT_index_array_formats }
const
  GL_EXT_index_array_formats = 1;  
  GL_IUI_V2F_EXT = $81AD;  
  GL_IUI_V3F_EXT = $81AE;  
  GL_IUI_N3F_V2F_EXT = $81AF;  
  GL_IUI_N3F_V3F_EXT = $81B0;  
  GL_T2F_IUI_V2F_EXT = $81B1;  
  GL_T2F_IUI_V3F_EXT = $81B2;  
  GL_T2F_IUI_N3F_V2F_EXT = $81B3;  
  GL_T2F_IUI_N3F_V3F_EXT = $81B4;  
{////#endif /* GL_EXT_index_array_formats */ }
{////#ifndef GL_EXT_index_func }
  GL_EXT_index_func = 1;  
  GL_INDEX_TEST_EXT = $81B5;  
  GL_INDEX_TEST_FUNC_EXT = $81B6;  
  GL_INDEX_TEST_REF_EXT = $81B7;  
{////typedef void (P PFNGLINDEXFUNCEXTPROC) (GLenum func, GLclampf ref); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glIndexFuncEXT(func:TGLenum; ref:TGLclampf);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_index_func */ }
{////#ifndef GL_EXT_index_material }
const
  GL_EXT_index_material = 1;  
  GL_INDEX_MATERIAL_EXT = $81B8;  
  GL_INDEX_MATERIAL_PARAMETER_EXT = $81B9;  
  GL_INDEX_MATERIAL_FACE_EXT = $81BA;  
{////typedef void (P PFNGLINDEXMATERIALEXTPROC) (GLenum face, GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glIndexMaterialEXT(face:TGLenum; mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_index_material */ }
{////#ifndef GL_EXT_index_texture }
const
  GL_EXT_index_texture = 1;  
{////#endif /* GL_EXT_index_texture */ }
{////#ifndef GL_EXT_light_texture }
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
{////typedef void (P PFNGLAPPLYTEXTUREEXTPROC) (GLenum mode); }
{////typedef void (P PFNGLTEXTURELIGHTEXTPROC) (GLenum pname); }
{////typedef void (P PFNGLTEXTUREMATERIALEXTPROC) (GLenum face, GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glApplyTextureEXT(mode:TGLenum);cdecl;external;
procedure glTextureLightEXT(pname:TGLenum);cdecl;external;
procedure glTextureMaterialEXT(face:TGLenum; mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_light_texture */ }
{////#ifndef GL_EXT_memory_object }
const
  GL_EXT_memory_object = 1;  
  GL_TEXTURE_TILING_EXT = $9580;  
  GL_DEDICATED_MEMORY_OBJECT_EXT = $9581;  
  GL_PROTECTED_MEMORY_OBJECT_EXT = $959B;  
  GL_NUM_TILING_TYPES_EXT = $9582;  
  GL_TILING_TYPES_EXT = $9583;  
  GL_OPTIMAL_TILING_EXT = $9584;  
  GL_LINEAR_TILING_EXT = $9585;  
  GL_NUM_DEVICE_UUIDS_EXT = $9596;  
  GL_DEVICE_UUID_EXT = $9597;  
  GL_DRIVER_UUID_EXT = $9598;  
  GL_UUID_SIZE_EXT = 16;  
{////typedef void (P PFNGLGETUNSIGNEDBYTEVEXTPROC) (GLenum pname, GLubyte *data); }
{////typedef void (P PFNGLGETUNSIGNEDBYTEI_VEXTPROC) (GLenum target, GLuint index, GLubyte *data); }
{////typedef void (P PFNGLDELETEMEMORYOBJECTSEXTPROC) (GLsizei n, const GLuint *memoryObjects); }
{////typedef GLboolean (P PFNGLISMEMORYOBJECTEXTPROC) (GLuint memoryObject); }
{////typedef void (P PFNGLCREATEMEMORYOBJECTSEXTPROC) (GLsizei n, GLuint *memoryObjects); }
{////typedef void (P PFNGLMEMORYOBJECTPARAMETERIVEXTPROC) (GLuint memoryObject, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLGETMEMORYOBJECTPARAMETERIVEXTPROC) (GLuint memoryObject, GLenum pname, GLint *params); }
{////typedef void (P PFNGLTEXSTORAGEMEM2DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXSTORAGEMEM2DMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXSTORAGEMEM3DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXSTORAGEMEM3DMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLBUFFERSTORAGEMEMEXTPROC) (GLenum target, GLsizeiptr size, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTURESTORAGEMEM2DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTURESTORAGEMEM2DMULTISAMPLEEXTPROC) (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTURESTORAGEMEM3DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTURESTORAGEMEM3DMULTISAMPLEEXTPROC) (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLNAMEDBUFFERSTORAGEMEMEXTPROC) (GLuint buffer, GLsizeiptr size, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXSTORAGEMEM1DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTURESTORAGEMEM1DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetUnsignedBytevEXT(pname:TGLenum; data:PGLubyte);cdecl;external;
procedure glGetUnsignedBytei_vEXT(target:TGLenum; index:TGLuint; data:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glDeleteMemoryObjectsEXT(n:TGLsizei; memoryObjects:PGLuint);cdecl;external;
function glIsMemoryObjectEXT(memoryObject:TGLuint):TGLboolean;cdecl;external;
procedure glCreateMemoryObjectsEXT(n:TGLsizei; memoryObjects:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glMemoryObjectParameterivEXT(memoryObject:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMemoryObjectParameterivEXT(memoryObject:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glTexStorageMem2DEXT(target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTexStorageMem2DMultisampleEXT(target:TGLenum; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTexStorageMem3DEXT(target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTexStorageMem3DMultisampleEXT(target:TGLenum; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glBufferStorageMemEXT(target:TGLenum; size:TGLsizeiptr; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTextureStorageMem2DEXT(texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTextureStorageMem2DMultisampleEXT(texture:TGLuint; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTextureStorageMem3DEXT(texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTextureStorageMem3DMultisampleEXT(texture:TGLuint; samples:TGLsizei; internalFormat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; fixedSampleLocations:TGLboolean; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glNamedBufferStorageMemEXT(buffer:TGLuint; size:TGLsizeiptr; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTexStorageMem1DEXT(target:TGLenum; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; memory:TGLuint; 
            offset:TGLuint64);cdecl;external;
procedure glTextureStorageMem1DEXT(texture:TGLuint; levels:TGLsizei; internalFormat:TGLenum; width:TGLsizei; memory:TGLuint; 
            offset:TGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_memory_object */ }
{////#ifndef GL_EXT_memory_object_fd }
const
  GL_EXT_memory_object_fd = 1;  
  GL_HANDLE_TYPE_OPAQUE_FD_EXT = $9586;  
{////typedef void (P PFNGLIMPORTMEMORYFDEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, GLint fd); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glImportMemoryFdEXT(memory:TGLuint; size:TGLuint64; handleType:TGLenum; fd:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_memory_object_fd */ }
{////#ifndef GL_EXT_memory_object_win32 }
const
  GL_EXT_memory_object_win32 = 1;  
  GL_HANDLE_TYPE_OPAQUE_WIN32_EXT = $9587;  
  GL_HANDLE_TYPE_OPAQUE_WIN32_KMT_EXT = $9588;  
  GL_DEVICE_LUID_EXT = $9599;  
  GL_DEVICE_NODE_MASK_EXT = $959A;  
  GL_LUID_SIZE_EXT = 8;  
  GL_HANDLE_TYPE_D3D12_TILEPOOL_EXT = $9589;  
  GL_HANDLE_TYPE_D3D12_RESOURCE_EXT = $958A;  
  GL_HANDLE_TYPE_D3D11_IMAGE_EXT = $958B;  
  GL_HANDLE_TYPE_D3D11_IMAGE_KMT_EXT = $958C;  
{////typedef void (P PFNGLIMPORTMEMORYWIN32HANDLEEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, void *handle); }
{////typedef void (P PFNGLIMPORTMEMORYWIN32NAMEEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, const void *name); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glImportMemoryWin32HandleEXT(memory:TGLuint; size:TGLuint64; handleType:TGLenum; handle:pointer);cdecl;external;
(* Const before type ignored *)
procedure glImportMemoryWin32NameEXT(memory:TGLuint; size:TGLuint64; handleType:TGLenum; name:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_memory_object_win32 */ }
{////#ifndef GL_EXT_misc_attribute }
const
  GL_EXT_misc_attribute = 1;  
{////#endif /* GL_EXT_misc_attribute */ }
{////#ifndef GL_EXT_multi_draw_arrays }
  GL_EXT_multi_draw_arrays = 1;  
{////typedef void (P PFNGLMULTIDRAWARRAYSEXTPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSEXTPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)

procedure glMultiDrawArraysEXT(mode:TGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glMultiDrawElementsEXT(mode:TGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; primcount:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_multi_draw_arrays */ }
{////#ifndef GL_EXT_multisample }
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
{////typedef void (P PFNGLSAMPLEMASKEXTPROC) (GLclampf value, GLboolean invert); }
{////typedef void (P PFNGLSAMPLEPATTERNEXTPROC) (GLenum pattern); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSampleMaskEXT(value:TGLclampf; invert:TGLboolean);cdecl;external;
procedure glSamplePatternEXT(pattern:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_multisample */ }
{////#ifndef GL_EXT_multiview_tessellation_geometry_shader }
const
  GL_EXT_multiview_tessellation_geometry_shader = 1;  
{////#endif /* GL_EXT_multiview_tessellation_geometry_shader */ }
{////#ifndef GL_EXT_multiview_texture_multisample }
  GL_EXT_multiview_texture_multisample = 1;  
{////#endif /* GL_EXT_multiview_texture_multisample */ }
{////#ifndef GL_EXT_multiview_timer_query }
  GL_EXT_multiview_timer_query = 1;  
{////#endif /* GL_EXT_multiview_timer_query */ }
{////#ifndef GL_EXT_packed_depth_stencil }
  GL_EXT_packed_depth_stencil = 1;  
  GL_DEPTH_STENCIL_EXT = $84F9;  
  GL_UNSIGNED_INT_24_8_EXT = $84FA;  
  GL_DEPTH24_STENCIL8_EXT = $88F0;  
  GL_TEXTURE_STENCIL_SIZE_EXT = $88F1;  
{////#endif /* GL_EXT_packed_depth_stencil */ }
{////#ifndef GL_EXT_packed_float }
  GL_EXT_packed_float = 1;  
  GL_R11F_G11F_B10F_EXT = $8C3A;  
  GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = $8C3B;  
  GL_RGBA_SIGNED_COMPONENTS_EXT = $8C3C;  
{////#endif /* GL_EXT_packed_float */ }
{////#ifndef GL_EXT_packed_pixels }
  GL_EXT_packed_pixels = 1;  
  GL_UNSIGNED_BYTE_3_3_2_EXT = $8032;  
  GL_UNSIGNED_SHORT_4_4_4_4_EXT = $8033;  
  GL_UNSIGNED_SHORT_5_5_5_1_EXT = $8034;  
  GL_UNSIGNED_INT_8_8_8_8_EXT = $8035;  
  GL_UNSIGNED_INT_10_10_10_2_EXT = $8036;  
{////#endif /* GL_EXT_packed_pixels */ }
{////#ifndef GL_EXT_paletted_texture }
  GL_EXT_paletted_texture = 1;  
  GL_COLOR_INDEX1_EXT = $80E2;  
  GL_COLOR_INDEX2_EXT = $80E3;  
  GL_COLOR_INDEX4_EXT = $80E4;  
  GL_COLOR_INDEX8_EXT = $80E5;  
  GL_COLOR_INDEX12_EXT = $80E6;  
  GL_COLOR_INDEX16_EXT = $80E7;  
  GL_TEXTURE_INDEX_SIZE_EXT = $80ED;  
{////typedef void (P PFNGLCOLORTABLEEXTPROC) (GLenum target, GLenum internalFormat, GLsizei width, GLenum format, GLenum type, const void *table); }
{////typedef void (P PFNGLGETCOLORTABLEEXTPROC) (GLenum target, GLenum format, GLenum type, void *data); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glColorTableEXT(target:TGLenum; internalFormat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum; 
            table:pointer);cdecl;external;
procedure glGetColorTableEXT(target:TGLenum; format:TGLenum; _type:TGLenum; data:pointer);cdecl;external;
procedure glGetColorTableParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetColorTableParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_paletted_texture */ }
{////#ifndef GL_EXT_pixel_buffer_object }
const
  GL_EXT_pixel_buffer_object = 1;  
  GL_PIXEL_PACK_BUFFER_EXT = $88EB;  
  GL_PIXEL_UNPACK_BUFFER_EXT = $88EC;  
  GL_PIXEL_PACK_BUFFER_BINDING_EXT = $88ED;  
  GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = $88EF;  
{////#endif /* GL_EXT_pixel_buffer_object */ }
{////#ifndef GL_EXT_pixel_transform }
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
{////typedef void (P PFNGLPIXELTRANSFORMPARAMETERIEXTPROC) (GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLPIXELTRANSFORMPARAMETERFEXTPROC) (GLenum target, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPIXELTRANSFORMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLPIXELTRANSFORMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLGETPIXELTRANSFORMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETPIXELTRANSFORMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPixelTransformParameteriEXT(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
procedure glPixelTransformParameterfEXT(target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPixelTransformParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glPixelTransformParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetPixelTransformParameterivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetPixelTransformParameterfvEXT(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_pixel_transform */ }
{////#ifndef GL_EXT_pixel_transform_color_table }
const
  GL_EXT_pixel_transform_color_table = 1;  
{////#endif /* GL_EXT_pixel_transform_color_table */ }
{////#ifndef GL_EXT_point_parameters }
  GL_EXT_point_parameters = 1;  
  GL_POINT_SIZE_MIN_EXT = $8126;  
  GL_POINT_SIZE_MAX_EXT = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE_EXT = $8128;  
  GL_DISTANCE_ATTENUATION_EXT = $8129;  
{////typedef void (P PFNGLPOINTPARAMETERFEXTPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPOINTPARAMETERFVEXTPROC) (GLenum pname, const GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPointParameterfEXT(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterfvEXT(pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_point_parameters */ }
{////#ifndef GL_EXT_polygon_offset }
const
  GL_EXT_polygon_offset = 1;  
  GL_POLYGON_OFFSET_EXT = $8037;  
  GL_POLYGON_OFFSET_FACTOR_EXT = $8038;  
  GL_POLYGON_OFFSET_BIAS_EXT = $8039;  
{////typedef void (P PFNGLPOLYGONOFFSETEXTPROC) (GLfloat factor, GLfloat bias); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPolygonOffsetEXT(factor:TGLfloat; bias:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_polygon_offset */ }
{////#ifndef GL_EXT_polygon_offset_clamp }
const
  GL_EXT_polygon_offset_clamp = 1;  
  GL_POLYGON_OFFSET_CLAMP_EXT = $8E1B;  
{////typedef void (P PFNGLPOLYGONOFFSETCLAMPEXTPROC) (GLfloat factor, GLfloat units, GLfloat clamp); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPolygonOffsetClampEXT(factor:TGLfloat; units:TGLfloat; clamp:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_polygon_offset_clamp */ }
{////#ifndef GL_EXT_post_depth_coverage }
const
  GL_EXT_post_depth_coverage = 1;  
{////#endif /* GL_EXT_post_depth_coverage */ }
{////#ifndef GL_EXT_provoking_vertex }
  GL_EXT_provoking_vertex = 1;  
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = $8E4C;  
  GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;  
  GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;  
  GL_PROVOKING_VERTEX_EXT = $8E4F;  
{////typedef void (P PFNGLPROVOKINGVERTEXEXTPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glProvokingVertexEXT(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_provoking_vertex */ }
{////#ifndef GL_EXT_raster_multisample }
const
  GL_EXT_raster_multisample = 1;  
  GL_RASTER_MULTISAMPLE_EXT = $9327;  
  GL_RASTER_SAMPLES_EXT = $9328;  
  GL_MAX_RASTER_SAMPLES_EXT = $9329;  
  GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = $932A;  
  GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = $932B;  
  GL_EFFECTIVE_RASTER_SAMPLES_EXT = $932C;  
{////typedef void (P PFNGLRASTERSAMPLESEXTPROC) (GLuint samples, GLboolean fixedsamplelocations); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glRasterSamplesEXT(samples:TGLuint; fixedsamplelocations:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_raster_multisample */ }
{////#ifndef GL_EXT_rescale_normal }
const
  GL_EXT_rescale_normal = 1;  
  GL_RESCALE_NORMAL_EXT = $803A;  
{////#endif /* GL_EXT_rescale_normal */ }
{////#ifndef GL_EXT_secondary_color }
  GL_EXT_secondary_color = 1;  
  GL_COLOR_SUM_EXT = $8458;  
  GL_CURRENT_SECONDARY_COLOR_EXT = $8459;  
  GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = $845A;  
  GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = $845B;  
  GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = $845C;  
  GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = $845D;  
  GL_SECONDARY_COLOR_ARRAY_EXT = $845E;  
{////typedef void (P PFNGLSECONDARYCOLOR3BEXTPROC) (GLbyte red, GLbyte green, GLbyte blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3BVEXTPROC) (const GLbyte *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3DEXTPROC) (GLdouble red, GLdouble green, GLdouble blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3DVEXTPROC) (const GLdouble *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3FEXTPROC) (GLfloat red, GLfloat green, GLfloat blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3FVEXTPROC) (const GLfloat *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3IEXTPROC) (GLint red, GLint green, GLint blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3IVEXTPROC) (const GLint *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3SEXTPROC) (GLshort red, GLshort green, GLshort blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3SVEXTPROC) (const GLshort *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3UBEXTPROC) (GLubyte red, GLubyte green, GLubyte blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3UBVEXTPROC) (const GLubyte *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3UIEXTPROC) (GLuint red, GLuint green, GLuint blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3UIVEXTPROC) (const GLuint *v); }
{////typedef void (P PFNGLSECONDARYCOLOR3USEXTPROC) (GLushort red, GLushort green, GLushort blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3USVEXTPROC) (const GLushort *v); }
{////typedef void (P PFNGLSECONDARYCOLORPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSecondaryColor3bEXT(red:TGLbyte; green:TGLbyte; blue:TGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3bvEXT(v:PGLbyte);cdecl;external;
procedure glSecondaryColor3dEXT(red:TGLdouble; green:TGLdouble; blue:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3dvEXT(v:PGLdouble);cdecl;external;
procedure glSecondaryColor3fEXT(red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3fvEXT(v:PGLfloat);cdecl;external;
procedure glSecondaryColor3iEXT(red:TGLint; green:TGLint; blue:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3ivEXT(v:PGLint);cdecl;external;
procedure glSecondaryColor3sEXT(red:TGLshort; green:TGLshort; blue:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3svEXT(v:PGLshort);cdecl;external;
procedure glSecondaryColor3ubEXT(red:TGLubyte; green:TGLubyte; blue:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3ubvEXT(v:PGLubyte);cdecl;external;
procedure glSecondaryColor3uiEXT(red:TGLuint; green:TGLuint; blue:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3uivEXT(v:PGLuint);cdecl;external;
procedure glSecondaryColor3usEXT(red:TGLushort; green:TGLushort; blue:TGLushort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3usvEXT(v:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColorPointerEXT(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_secondary_color */ }
{////#ifndef GL_EXT_semaphore }
const
  GL_EXT_semaphore = 1;  
  GL_LAYOUT_GENERAL_EXT = $958D;  
  GL_LAYOUT_COLOR_ATTACHMENT_EXT = $958E;  
  GL_LAYOUT_DEPTH_STENCIL_ATTACHMENT_EXT = $958F;  
  GL_LAYOUT_DEPTH_STENCIL_READ_ONLY_EXT = $9590;  
  GL_LAYOUT_SHADER_READ_ONLY_EXT = $9591;  
  GL_LAYOUT_TRANSFER_SRC_EXT = $9592;  
  GL_LAYOUT_TRANSFER_DST_EXT = $9593;  
  GL_LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_EXT = $9530;  
  GL_LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_EXT = $9531;  
{////typedef void (P PFNGLGENSEMAPHORESEXTPROC) (GLsizei n, GLuint *semaphores); }
{////typedef void (P PFNGLDELETESEMAPHORESEXTPROC) (GLsizei n, const GLuint *semaphores); }
{////typedef GLboolean (P PFNGLISSEMAPHOREEXTPROC) (GLuint semaphore); }
{////typedef void (P PFNGLSEMAPHOREPARAMETERUI64VEXTPROC) (GLuint semaphore, GLenum pname, const GLuint64 *params); }
{////typedef void (P PFNGLGETSEMAPHOREPARAMETERUI64VEXTPROC) (GLuint semaphore, GLenum pname, GLuint64 *params); }
{////typedef void (P PFNGLWAITSEMAPHOREEXTPROC) (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *srcLayouts); }
{////typedef void (P PFNGLSIGNALSEMAPHOREEXTPROC) (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *dstLayouts); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenSemaphoresEXT(n:TGLsizei; semaphores:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteSemaphoresEXT(n:TGLsizei; semaphores:PGLuint);cdecl;external;
function glIsSemaphoreEXT(semaphore:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glSemaphoreParameterui64vEXT(semaphore:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;external;
procedure glGetSemaphoreParameterui64vEXT(semaphore:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glWaitSemaphoreEXT(semaphore:TGLuint; numBufferBarriers:TGLuint; buffers:PGLuint; numTextureBarriers:TGLuint; textures:PGLuint; 
            srcLayouts:PGLenum);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glSignalSemaphoreEXT(semaphore:TGLuint; numBufferBarriers:TGLuint; buffers:PGLuint; numTextureBarriers:TGLuint; textures:PGLuint; 
            dstLayouts:PGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_semaphore */ }
{////#ifndef GL_EXT_semaphore_fd }
const
  GL_EXT_semaphore_fd = 1;  
{////typedef void (P PFNGLIMPORTSEMAPHOREFDEXTPROC) (GLuint semaphore, GLenum handleType, GLint fd); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glImportSemaphoreFdEXT(semaphore:TGLuint; handleType:TGLenum; fd:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_semaphore_fd */ }
{////#ifndef GL_EXT_semaphore_win32 }
const
  GL_EXT_semaphore_win32 = 1;  
  GL_HANDLE_TYPE_D3D12_FENCE_EXT = $9594;  
  GL_D3D12_FENCE_VALUE_EXT = $9595;  
{////typedef void (P PFNGLIMPORTSEMAPHOREWIN32HANDLEEXTPROC) (GLuint semaphore, GLenum handleType, void *handle); }
{////typedef void (P PFNGLIMPORTSEMAPHOREWIN32NAMEEXTPROC) (GLuint semaphore, GLenum handleType, const void *name); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glImportSemaphoreWin32HandleEXT(semaphore:TGLuint; handleType:TGLenum; handle:pointer);cdecl;external;
(* Const before type ignored *)
procedure glImportSemaphoreWin32NameEXT(semaphore:TGLuint; handleType:TGLenum; name:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_semaphore_win32 */ }
{////#ifndef GL_EXT_separate_shader_objects }
const
  GL_EXT_separate_shader_objects = 1;  
  GL_ACTIVE_PROGRAM_EXT = $8B8D;  
{////typedef void (P PFNGLUSESHADERPROGRAMEXTPROC) (GLenum type, GLuint program_); }
{////typedef void (P PFNGLACTIVEPROGRAMEXTPROC) (GLuint program_); }
{////typedef GLuint (P PFNGLCREATESHADERPROGRAMEXTPROC) (GLenum type, const GLchar *string); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glUseShaderProgramEXT(_type:TGLenum; program_:TGLuint);cdecl;external;
procedure glActiveProgramEXT(program_:TGLuint);cdecl;external;
(* Const before type ignored *)
function glCreateShaderProgramEXT(_type:TGLenum; _string:PGLchar):TGLuint;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_separate_shader_objects */ }
{////#ifndef GL_EXT_separate_specular_color }
const
  GL_EXT_separate_specular_color = 1;  
  GL_LIGHT_MODEL_COLOR_CONTROL_EXT = $81F8;  
  GL_SINGLE_COLOR_EXT = $81F9;  
  GL_SEPARATE_SPECULAR_COLOR_EXT = $81FA;  
{////#endif /* GL_EXT_separate_specular_color */ }
{////#ifndef GL_EXT_shader_framebuffer_fetch }
  GL_EXT_shader_framebuffer_fetch = 1;  
  GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = $8A52;  
{////#endif /* GL_EXT_shader_framebuffer_fetch */ }
{////#ifndef GL_EXT_shader_framebuffer_fetch_non_coherent }
  GL_EXT_shader_framebuffer_fetch_non_coherent = 1;  
{////typedef void (P PFNGLFRAMEBUFFERFETCHBARRIEREXTPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFramebufferFetchBarrierEXT;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_shader_framebuffer_fetch_non_coherent */ }
{////#ifndef GL_EXT_shader_image_load_formatted }
const
  GL_EXT_shader_image_load_formatted = 1;  
{////#endif /* GL_EXT_shader_image_load_formatted */ }
{////#ifndef GL_EXT_shader_image_load_store }
  GL_EXT_shader_image_load_store = 1;  
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
  GL_ALL_BARRIER_BITS_EXT = $FFFFFFFF;  
{////typedef void (P PFNGLBINDIMAGETEXTUREEXTPROC) (GLuint index, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLint format); }
{////typedef void (P PFNGLMEMORYBARRIEREXTPROC) (GLbitfield barriers); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBindImageTextureEXT(index:TGLuint; texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; 
            access:TGLenum; format:TGLint);cdecl;external;
procedure glMemoryBarrierEXT(barriers:TGLbitfield);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_shader_image_load_store */ }
{////#ifndef GL_EXT_shader_integer_mix }
const
  GL_EXT_shader_integer_mix = 1;  
{////#endif /* GL_EXT_shader_integer_mix */ }
{////#ifndef GL_EXT_shader_samples_identical }
  GL_EXT_shader_samples_identical = 1;  
{////#endif /* GL_EXT_shader_samples_identical */ }
{////#ifndef GL_EXT_shadow_funcs }
  GL_EXT_shadow_funcs = 1;  
{////#endif /* GL_EXT_shadow_funcs */ }
{////#ifndef GL_EXT_shared_texture_palette }
  GL_EXT_shared_texture_palette = 1;  
  GL_SHARED_TEXTURE_PALETTE_EXT = $81FB;  
{////#endif /* GL_EXT_shared_texture_palette */ }
{////#ifndef GL_EXT_sparse_texture2 }
  GL_EXT_sparse_texture2 = 1;  
{////#endif /* GL_EXT_sparse_texture2 */ }
{////#ifndef GL_EXT_stencil_clear_tag }
  GL_EXT_stencil_clear_tag = 1;  
  GL_STENCIL_TAG_BITS_EXT = $88F2;  
  GL_STENCIL_CLEAR_TAG_VALUE_EXT = $88F3;  
{////typedef void (P PFNGLSTENCILCLEARTAGEXTPROC) (GLsizei stencilTagBits, GLuint stencilClearTag); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glStencilClearTagEXT(stencilTagBits:TGLsizei; stencilClearTag:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_stencil_clear_tag */ }
{////#ifndef GL_EXT_stencil_two_side }
const
  GL_EXT_stencil_two_side = 1;  
  GL_STENCIL_TEST_TWO_SIDE_EXT = $8910;  
  GL_ACTIVE_STENCIL_FACE_EXT = $8911;  
{////typedef void (P PFNGLACTIVESTENCILFACEEXTPROC) (GLenum face); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glActiveStencilFaceEXT(face:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_stencil_two_side */ }
{////#ifndef GL_EXT_stencil_wrap }
const
  GL_EXT_stencil_wrap = 1;  
  GL_INCR_WRAP_EXT = $8507;  
  GL_DECR_WRAP_EXT = $8508;  
{////#endif /* GL_EXT_stencil_wrap */ }
{////#ifndef GL_EXT_subtexture }
  GL_EXT_subtexture = 1;  
{////typedef void (P PFNGLTEXSUBIMAGE1DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXSUBIMAGE2DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTexSubImage1DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; width:TGLsizei; format:TGLenum; 
            _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexSubImage2DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; width:TGLsizei; 
            height:TGLsizei; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_subtexture */ }
{////#ifndef GL_EXT_texture }
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
  GL_TEXTURE_TOO_LARGE_EXT = $8065;  
{////#endif /* GL_EXT_texture */ }
{////#ifndef GL_EXT_texture3D }
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
{////typedef void (P PFNGLTEXIMAGE3DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXSUBIMAGE3DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTexImage3DEXT(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexSubImage3DEXT(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture3D */ }
{////#ifndef GL_EXT_texture_array }
const
  GL_EXT_texture_array = 1;  
  GL_TEXTURE_1D_ARRAY_EXT = $8C18;  
  GL_PROXY_TEXTURE_1D_ARRAY_EXT = $8C19;  
  GL_TEXTURE_2D_ARRAY_EXT = $8C1A;  
  GL_PROXY_TEXTURE_2D_ARRAY_EXT = $8C1B;  
  GL_TEXTURE_BINDING_1D_ARRAY_EXT = $8C1C;  
  GL_TEXTURE_BINDING_2D_ARRAY_EXT = $8C1D;  
  GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = $88FF;  
  GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = $884E;  
{////typedef void (P PFNGLFRAMEBUFFERTEXTURELAYEREXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFramebufferTextureLayerEXT(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; layer:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_array */ }
{////#ifndef GL_EXT_texture_buffer_object }
const
  GL_EXT_texture_buffer_object = 1;  
  GL_TEXTURE_BUFFER_EXT = $8C2A;  
  GL_MAX_TEXTURE_BUFFER_SIZE_EXT = $8C2B;  
  GL_TEXTURE_BINDING_BUFFER_EXT = $8C2C;  
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = $8C2D;  
  GL_TEXTURE_BUFFER_FORMAT_EXT = $8C2E;  
{////typedef void (P PFNGLTEXBUFFEREXTPROC) (GLenum target, GLenum internalformat, GLuint buffer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexBufferEXT(target:TGLenum; internalformat:TGLenum; buffer:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_buffer_object */ }
{////#ifndef GL_EXT_texture_compression_latc }
const
  GL_EXT_texture_compression_latc = 1;  
  GL_COMPRESSED_LUMINANCE_LATC1_EXT = $8C70;  
  GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = $8C71;  
  GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = $8C72;  
  GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = $8C73;  
{////#endif /* GL_EXT_texture_compression_latc */ }
{////#ifndef GL_EXT_texture_compression_rgtc }
  GL_EXT_texture_compression_rgtc = 1;  
  GL_COMPRESSED_RED_RGTC1_EXT = $8DBB;  
  GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = $8DBC;  
  GL_COMPRESSED_RED_GREEN_RGTC2_EXT = $8DBD;  
  GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = $8DBE;  
{////#endif /* GL_EXT_texture_compression_rgtc */ }
{////#ifndef GL_EXT_texture_compression_s3tc }
  GL_EXT_texture_compression_s3tc = 1;  
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0;  
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1;  
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = $83F2;  
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;  
{////#endif /* GL_EXT_texture_compression_s3tc */ }
{////#ifndef GL_EXT_texture_cube_map }
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
{////#endif /* GL_EXT_texture_cube_map */ }
{////#ifndef GL_EXT_texture_env_add }
  GL_EXT_texture_env_add = 1;  
{////#endif /* GL_EXT_texture_env_add */ }
{////#ifndef GL_EXT_texture_env_combine }
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
{////#endif /* GL_EXT_texture_env_combine */ }
{////#ifndef GL_EXT_texture_env_dot3 }
  GL_EXT_texture_env_dot3 = 1;  
  GL_DOT3_RGB_EXT = $8740;  
  GL_DOT3_RGBA_EXT = $8741;  
{////#endif /* GL_EXT_texture_env_dot3 */ }
{////#ifndef GL_EXT_texture_filter_anisotropic }
  GL_EXT_texture_filter_anisotropic = 1;  
  GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE;  
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;  
{////#endif /* GL_EXT_texture_filter_anisotropic */ }
{////#ifndef GL_EXT_texture_filter_minmax }
  GL_EXT_texture_filter_minmax = 1;  
  GL_TEXTURE_REDUCTION_MODE_EXT = $9366;  
  GL_WEIGHTED_AVERAGE_EXT = $9367;  
{////#endif /* GL_EXT_texture_filter_minmax */ }
{////#ifndef GL_EXT_texture_integer }
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
{////typedef void (P PFNGLTEXPARAMETERIIVEXTPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLTEXPARAMETERIUIVEXTPROC) (GLenum target, GLenum pname, const GLuint *params); }
{////typedef void (P PFNGLGETTEXPARAMETERIIVEXTPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETTEXPARAMETERIUIVEXTPROC) (GLenum target, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLCLEARCOLORIIEXTPROC) (GLint red, GLint green, GLint blue, GLint alpha); }
{////typedef void (P PFNGLCLEARCOLORIUIEXTPROC) (GLuint red, GLuint green, GLuint blue, GLuint alpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTexParameterIivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glTexParameterIuivEXT(target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetTexParameterIivEXT(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetTexParameterIuivEXT(target:TGLenum; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glClearColorIiEXT(red:TGLint; green:TGLint; blue:TGLint; alpha:TGLint);cdecl;external;
procedure glClearColorIuiEXT(red:TGLuint; green:TGLuint; blue:TGLuint; alpha:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_integer */ }
{////#ifndef GL_EXT_texture_lod_bias }
const
  GL_EXT_texture_lod_bias = 1;  
  GL_MAX_TEXTURE_LOD_BIAS_EXT = $84FD;  
  GL_TEXTURE_FILTER_CONTROL_EXT = $8500;  
  GL_TEXTURE_LOD_BIAS_EXT = $8501;  
{////#endif /* GL_EXT_texture_lod_bias */ }
{////#ifndef GL_EXT_texture_mirror_clamp }
  GL_EXT_texture_mirror_clamp = 1;  
  GL_MIRROR_CLAMP_EXT = $8742;  
  GL_MIRROR_CLAMP_TO_EDGE_EXT = $8743;  
  GL_MIRROR_CLAMP_TO_BORDER_EXT = $8912;  
{////#endif /* GL_EXT_texture_mirror_clamp */ }
{////#ifndef GL_EXT_texture_object }
  GL_EXT_texture_object = 1;  
  GL_TEXTURE_PRIORITY_EXT = $8066;  
  GL_TEXTURE_RESIDENT_EXT = $8067;  
  GL_TEXTURE_1D_BINDING_EXT = $8068;  
  GL_TEXTURE_2D_BINDING_EXT = $8069;  
  GL_TEXTURE_3D_BINDING_EXT = $806A;  
{////typedef GLboolean (P PFNGLARETEXTURESRESIDENTEXTPROC) (GLsizei n, const GLuint *textures, GLboolean *residences); }
{////typedef void (P PFNGLBINDTEXTUREEXTPROC) (GLenum target, GLuint texture); }
{////typedef void (P PFNGLDELETETEXTURESEXTPROC) (GLsizei n, const GLuint *textures); }
{////typedef void (P PFNGLGENTEXTURESEXTPROC) (GLsizei n, GLuint *textures); }
{////typedef GLboolean (P PFNGLISTEXTUREEXTPROC) (GLuint texture); }
{////typedef void (P PFNGLPRIORITIZETEXTURESEXTPROC) (GLsizei n, const GLuint *textures, const GLclampf *priorities); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

function glAreTexturesResidentEXT(n:TGLsizei; textures:PGLuint; residences:PGLboolean):TGLboolean;cdecl;external;
procedure glBindTextureEXT(target:TGLenum; texture:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteTexturesEXT(n:TGLsizei; textures:PGLuint);cdecl;external;
procedure glGenTexturesEXT(n:TGLsizei; textures:PGLuint);cdecl;external;
function glIsTextureEXT(texture:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glPrioritizeTexturesEXT(n:TGLsizei; textures:PGLuint; priorities:PGLclampf);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_object */ }
{////#ifndef GL_EXT_texture_perturb_normal }
const
  GL_EXT_texture_perturb_normal = 1;  
  GL_PERTURB_EXT = $85AE;  
  GL_TEXTURE_NORMAL_EXT = $85AF;  
{////typedef void (P PFNGLTEXTURENORMALEXTPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTextureNormalEXT(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_perturb_normal */ }
{////#ifndef GL_EXT_texture_sRGB }
const
  GL_EXT_texture_sRGB = 1;  
  GL_SRGB_EXT = $8C40;  
  GL_SRGB8_EXT = $8C41;  
  GL_SRGB_ALPHA_EXT = $8C42;  
  GL_SRGB8_ALPHA8_EXT = $8C43;  
  GL_SLUMINANCE_ALPHA_EXT = $8C44;  
  GL_SLUMINANCE8_ALPHA8_EXT = $8C45;  
  GL_SLUMINANCE_EXT = $8C46;  
  GL_SLUMINANCE8_EXT = $8C47;  
  GL_COMPRESSED_SRGB_EXT = $8C48;  
  GL_COMPRESSED_SRGB_ALPHA_EXT = $8C49;  
  GL_COMPRESSED_SLUMINANCE_EXT = $8C4A;  
  GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = $8C4B;  
  GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = $8C4C;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = $8C4D;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = $8C4E;  
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = $8C4F;  
{////#endif /* GL_EXT_texture_sRGB */ }
{////#ifndef GL_EXT_texture_sRGB_R8 }
  GL_EXT_texture_sRGB_R8 = 1;  
  GL_SR8_EXT = $8FBD;  
{////#endif /* GL_EXT_texture_sRGB_R8 */ }
{////#ifndef GL_EXT_texture_sRGB_RG8 }
  GL_EXT_texture_sRGB_RG8 = 1;  
  GL_SRG8_EXT = $8FBE;  
{////#endif /* GL_EXT_texture_sRGB_RG8 */ }
{////#ifndef GL_EXT_texture_sRGB_decode }
  GL_EXT_texture_sRGB_decode = 1;  
  GL_TEXTURE_SRGB_DECODE_EXT = $8A48;  
  GL_DECODE_EXT = $8A49;  
  GL_SKIP_DECODE_EXT = $8A4A;  
{////#endif /* GL_EXT_texture_sRGB_decode */ }
{////#ifndef GL_EXT_texture_shadow_lod }
  GL_EXT_texture_shadow_lod = 1;  
{////#endif /* GL_EXT_texture_shadow_lod */ }
{////#ifndef GL_EXT_texture_shared_exponent }
  GL_EXT_texture_shared_exponent = 1;  
  GL_RGB9_E5_EXT = $8C3D;  
  GL_UNSIGNED_INT_5_9_9_9_REV_EXT = $8C3E;  
  GL_TEXTURE_SHARED_SIZE_EXT = $8C3F;  
{////#endif /* GL_EXT_texture_shared_exponent */ }
{////#ifndef GL_EXT_texture_snorm }
  GL_EXT_texture_snorm = 1;  
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
  GL_RED_SNORM = $8F90;  
  GL_RG_SNORM = $8F91;  
  GL_RGB_SNORM = $8F92;  
  GL_RGBA_SNORM = $8F93;  
{////#endif /* GL_EXT_texture_snorm */ }
{////#ifndef GL_EXT_texture_storage }
  GL_EXT_texture_storage = 1;  
  GL_TEXTURE_IMMUTABLE_FORMAT_EXT = $912F;  
  GL_RGBA32F_EXT = $8814;  
  GL_RGB32F_EXT = $8815;  
  GL_ALPHA32F_EXT = $8816;  
  GL_LUMINANCE32F_EXT = $8818;  
  GL_LUMINANCE_ALPHA32F_EXT = $8819;  
  GL_RGBA16F_EXT = $881A;  
  GL_RGB16F_EXT = $881B;  
  GL_ALPHA16F_EXT = $881C;  
  GL_LUMINANCE16F_EXT = $881E;  
  GL_LUMINANCE_ALPHA16F_EXT = $881F;  
  GL_BGRA8_EXT = $93A1;  
  GL_R8_EXT = $8229;  
  GL_RG8_EXT = $822B;  
  GL_R32F_EXT = $822E;  
  GL_RG32F_EXT = $8230;  
  GL_R16F_EXT = $822D;  
  GL_RG16F_EXT = $822F;  
{////typedef void (P PFNGLTEXSTORAGE1DEXTPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width); }
{////typedef void (P PFNGLTEXSTORAGE2DEXTPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLTEXSTORAGE3DEXTPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexStorage1DEXT(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei);cdecl;external;
procedure glTexStorage2DEXT(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei);cdecl;external;
procedure glTexStorage3DEXT(target:TGLenum; levels:TGLsizei; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_texture_storage */ }
{////#ifndef GL_EXT_texture_swizzle }
const
  GL_EXT_texture_swizzle = 1;  
  GL_TEXTURE_SWIZZLE_R_EXT = $8E42;  
  GL_TEXTURE_SWIZZLE_G_EXT = $8E43;  
  GL_TEXTURE_SWIZZLE_B_EXT = $8E44;  
  GL_TEXTURE_SWIZZLE_A_EXT = $8E45;  
  GL_TEXTURE_SWIZZLE_RGBA_EXT = $8E46;  
{////#endif /* GL_EXT_texture_swizzle */ }
{////#ifndef GL_EXT_timer_query }
  GL_EXT_timer_query = 1;  
  GL_TIME_ELAPSED_EXT = $88BF;  
{////typedef void (P PFNGLGETQUERYOBJECTI64VEXTPROC) (GLuint id, GLenum pname, GLint64 *params); }
{////typedef void (P PFNGLGETQUERYOBJECTUI64VEXTPROC) (GLuint id, GLenum pname, GLuint64 *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetQueryObjecti64vEXT(id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;external;
procedure glGetQueryObjectui64vEXT(id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_timer_query */ }
{////#ifndef GL_EXT_transform_feedback }
const
  GL_EXT_transform_feedback = 1;  
  GL_TRANSFORM_FEEDBACK_BUFFER_EXT = $8C8E;  
  GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = $8C84;  
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = $8C85;  
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = $8C8F;  
  GL_INTERLEAVED_ATTRIBS_EXT = $8C8C;  
  GL_SEPARATE_ATTRIBS_EXT = $8C8D;  
  GL_PRIMITIVES_GENERATED_EXT = $8C87;  
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = $8C88;  
  GL_RASTERIZER_DISCARD_EXT = $8C89;  
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = $8C8A;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = $8C8B;  
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = $8C80;  
  GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = $8C83;  
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = $8C7F;  
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = $8C76;  
{////typedef void (P PFNGLBEGINTRANSFORMFEEDBACKEXTPROC) (GLenum primitiveMode); }
{////typedef void (P PFNGLENDTRANSFORMFEEDBACKEXTPROC) (void); }
{////typedef void (P PFNGLBINDBUFFERRANGEEXTPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLBINDBUFFEROFFSETEXTPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset); }
{////typedef void (P PFNGLBINDBUFFERBASEEXTPROC) (GLenum target, GLuint index, GLuint buffer); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC) (GLuint program_, GLsizei count, const GLchar *const*varyings, GLenum bufferMode); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC) (GLuint program_, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginTransformFeedbackEXT(primitiveMode:TGLenum);cdecl;external;
procedure glEndTransformFeedbackEXT;cdecl;external;
procedure glBindBufferRangeEXT(target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glBindBufferOffsetEXT(target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr);cdecl;external;
procedure glBindBufferBaseEXT(target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glTransformFeedbackVaryingsEXT(program_:TGLuint; count:TGLsizei; varyings:PPGLchar; bufferMode:TGLenum);cdecl;external;
procedure glGetTransformFeedbackVaryingEXT(program_:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei; 
            _type:PGLenum; name:PGLchar);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_transform_feedback */ }
{////#ifndef GL_EXT_vertex_array }
const
  GL_EXT_vertex_array = 1;  
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
{////typedef void (P PFNGLARRAYELEMENTEXTPROC) (GLint i); }
{////typedef void (P PFNGLCOLORPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const void *pointer); }
{////typedef void (P PFNGLDRAWARRAYSEXTPROC) (GLenum mode, GLint first, GLsizei count); }
{////typedef void (P PFNGLEDGEFLAGPOINTEREXTPROC) (GLsizei stride, GLsizei count, const GLboolean *pointer); }
{////typedef void (P PFNGLGETPOINTERVEXTPROC) (GLenum pname, void **params); }
{////typedef void (P PFNGLINDEXPOINTEREXTPROC) (GLenum type, GLsizei stride, GLsizei count, const void *pointer); }
{////typedef void (P PFNGLNORMALPOINTEREXTPROC) (GLenum type, GLsizei stride, GLsizei count, const void *pointer); }
{////typedef void (P PFNGLTEXCOORDPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const void *pointer); }
{////typedef void (P PFNGLVERTEXPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glArrayElementEXT(i:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glColorPointerEXT(size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;external;
procedure glDrawArraysEXT(mode:TGLenum; first:TGLint; count:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glEdgeFlagPointerEXT(stride:TGLsizei; count:TGLsizei; pointer:PGLboolean);cdecl;external;
procedure glGetPointervEXT(pname:TGLenum; params:Ppointer);cdecl;external;
(* Const before type ignored *)
procedure glIndexPointerEXT(_type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;external;
(* Const before type ignored *)
procedure glNormalPointerEXT(_type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordPointerEXT(size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;external;
(* Const before type ignored *)
procedure glVertexPointerEXT(size:TGLint; _type:TGLenum; stride:TGLsizei; count:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_vertex_array */ }
{////#ifndef GL_EXT_vertex_array_bgra }
const
  GL_EXT_vertex_array_bgra = 1;  
{////#endif /* GL_EXT_vertex_array_bgra */ }
{////#ifndef GL_EXT_vertex_attrib_64bit }
  GL_EXT_vertex_attrib_64bit = 1;  
  GL_DOUBLE_VEC2_EXT = $8FFC;  
  GL_DOUBLE_VEC3_EXT = $8FFD;  
  GL_DOUBLE_VEC4_EXT = $8FFE;  
  GL_DOUBLE_MAT2_EXT = $8F46;  
  GL_DOUBLE_MAT3_EXT = $8F47;  
  GL_DOUBLE_MAT4_EXT = $8F48;  
  GL_DOUBLE_MAT2x3_EXT = $8F49;  
  GL_DOUBLE_MAT2x4_EXT = $8F4A;  
  GL_DOUBLE_MAT3x2_EXT = $8F4B;  
  GL_DOUBLE_MAT3x4_EXT = $8F4C;  
  GL_DOUBLE_MAT4x2_EXT = $8F4D;  
  GL_DOUBLE_MAT4x3_EXT = $8F4E;  
{////typedef void (P PFNGLVERTEXATTRIBL1DEXTPROC) (GLuint index, GLdouble x); }
{////typedef void (P PFNGLVERTEXATTRIBL2DEXTPROC) (GLuint index, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXATTRIBL3DEXTPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXATTRIBL4DEXTPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXATTRIBL1DVEXTPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL2DVEXTPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL3DVEXTPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBL4DVEXTPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBLPOINTEREXTPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLGETVERTEXATTRIBLDVEXTPROC) (GLuint index, GLenum pname, GLdouble *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttribL1dEXT(index:TGLuint; x:TGLdouble);cdecl;external;
procedure glVertexAttribL2dEXT(index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;external;
procedure glVertexAttribL3dEXT(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
procedure glVertexAttribL4dEXT(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL1dvEXT(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL2dvEXT(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL3dvEXT(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL4dvEXT(index:TGLuint; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribLPointerEXT(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glGetVertexAttribLdvEXT(index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_vertex_attrib_64bit */ }
{////#ifndef GL_EXT_vertex_shader }
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
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87CC;  
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = $87CD;  
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
{////typedef void (P PFNGLBEGINVERTEXSHADEREXTPROC) (void); }
{////typedef void (P PFNGLENDVERTEXSHADEREXTPROC) (void); }
{////typedef void (P PFNGLBINDVERTEXSHADEREXTPROC) (GLuint id); }
{////typedef GLuint (P PFNGLGENVERTEXSHADERSEXTPROC) (GLuint range); }
{////typedef void (P PFNGLDELETEVERTEXSHADEREXTPROC) (GLuint id); }
{////typedef void (P PFNGLSHADEROP1EXTPROC) (GLenum op, GLuint res, GLuint arg1); }
{////typedef void (P PFNGLSHADEROP2EXTPROC) (GLenum op, GLuint res, GLuint arg1, GLuint arg2); }
{////typedef void (P PFNGLSHADEROP3EXTPROC) (GLenum op, GLuint res, GLuint arg1, GLuint arg2, GLuint arg3); }
{////typedef void (P PFNGLSWIZZLEEXTPROC) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW); }
{////typedef void (P PFNGLWRITEMASKEXTPROC) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW); }
{////typedef void (P PFNGLINSERTCOMPONENTEXTPROC) (GLuint res, GLuint src, GLuint num); }
{////typedef void (P PFNGLEXTRACTCOMPONENTEXTPROC) (GLuint res, GLuint src, GLuint num); }
{////typedef GLuint (P PFNGLGENSYMBOLSEXTPROC) (GLenum datatype, GLenum storagetype, GLenum range, GLuint components); }
{////typedef void (P PFNGLSETINVARIANTEXTPROC) (GLuint id, GLenum type, const void *addr); }
{////typedef void (P PFNGLSETLOCALCONSTANTEXTPROC) (GLuint id, GLenum type, const void *addr); }
{////typedef void (P PFNGLVARIANTBVEXTPROC) (GLuint id, const GLbyte *addr); }
{////typedef void (P PFNGLVARIANTSVEXTPROC) (GLuint id, const GLshort *addr); }
{////typedef void (P PFNGLVARIANTIVEXTPROC) (GLuint id, const GLint *addr); }
{////typedef void (P PFNGLVARIANTFVEXTPROC) (GLuint id, const GLfloat *addr); }
{////typedef void (P PFNGLVARIANTDVEXTPROC) (GLuint id, const GLdouble *addr); }
{////typedef void (P PFNGLVARIANTUBVEXTPROC) (GLuint id, const GLubyte *addr); }
{////typedef void (P PFNGLVARIANTUSVEXTPROC) (GLuint id, const GLushort *addr); }
{////typedef void (P PFNGLVARIANTUIVEXTPROC) (GLuint id, const GLuint *addr); }
{////typedef void (P PFNGLVARIANTPOINTEREXTPROC) (GLuint id, GLenum type, GLuint stride, const void *addr); }
{////typedef void (P PFNGLENABLEVARIANTCLIENTSTATEEXTPROC) (GLuint id); }
{////typedef void (P PFNGLDISABLEVARIANTCLIENTSTATEEXTPROC) (GLuint id); }
{////typedef GLuint (P PFNGLBINDLIGHTPARAMETEREXTPROC) (GLenum light, GLenum value); }
{////typedef GLuint (P PFNGLBINDMATERIALPARAMETEREXTPROC) (GLenum face, GLenum value); }
{////typedef GLuint (P PFNGLBINDTEXGENPARAMETEREXTPROC) (GLenum unit, GLenum coord, GLenum value); }
{////typedef GLuint (P PFNGLBINDTEXTUREUNITPARAMETEREXTPROC) (GLenum unit, GLenum value); }
{////typedef GLuint (P PFNGLBINDPARAMETEREXTPROC) (GLenum value); }
{////typedef GLboolean (P PFNGLISVARIANTENABLEDEXTPROC) (GLuint id, GLenum cap); }
{////typedef void (P PFNGLGETVARIANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data); }
{////typedef void (P PFNGLGETVARIANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data); }
{////typedef void (P PFNGLGETVARIANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data); }
{////typedef void (P PFNGLGETVARIANTPOINTERVEXTPROC) (GLuint id, GLenum value, void **data); }
{////typedef void (P PFNGLGETINVARIANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data); }
{////typedef void (P PFNGLGETINVARIANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data); }
{////typedef void (P PFNGLGETINVARIANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data); }
{////typedef void (P PFNGLGETLOCALCONSTANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data); }
{////typedef void (P PFNGLGETLOCALCONSTANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data); }
{////typedef void (P PFNGLGETLOCALCONSTANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginVertexShaderEXT;cdecl;external;
procedure glEndVertexShaderEXT;cdecl;external;
procedure glBindVertexShaderEXT(id:TGLuint);cdecl;external;
function glGenVertexShadersEXT(range:TGLuint):TGLuint;cdecl;external;
procedure glDeleteVertexShaderEXT(id:TGLuint);cdecl;external;
procedure glShaderOp1EXT(op:TGLenum; res:TGLuint; arg1:TGLuint);cdecl;external;
procedure glShaderOp2EXT(op:TGLenum; res:TGLuint; arg1:TGLuint; arg2:TGLuint);cdecl;external;
procedure glShaderOp3EXT(op:TGLenum; res:TGLuint; arg1:TGLuint; arg2:TGLuint; arg3:TGLuint);cdecl;external;
procedure glSwizzleEXT(res:TGLuint; in_:TGLuint; outX:TGLenum; outY:TGLenum; outZ:TGLenum; 
            outW:TGLenum);cdecl;external;
procedure glWriteMaskEXT(res:TGLuint; in_:TGLuint; outX:TGLenum; outY:TGLenum; outZ:TGLenum; 
            outW:TGLenum);cdecl;external;
procedure glInsertComponentEXT(res:TGLuint; src:TGLuint; num:TGLuint);cdecl;external;
procedure glExtractComponentEXT(res:TGLuint; src:TGLuint; num:TGLuint);cdecl;external;
function glGenSymbolsEXT(datatype:TGLenum; storagetype:TGLenum; range:TGLenum; components:TGLuint):TGLuint;cdecl;external;
(* Const before type ignored *)
procedure glSetInvariantEXT(id:TGLuint; _type:TGLenum; addr:pointer);cdecl;external;
(* Const before type ignored *)
procedure glSetLocalConstantEXT(id:TGLuint; _type:TGLenum; addr:pointer);cdecl;external;
(* Const before type ignored *)
procedure glVariantbvEXT(id:TGLuint; addr:PGLbyte);cdecl;external;
(* Const before type ignored *)
procedure glVariantsvEXT(id:TGLuint; addr:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVariantivEXT(id:TGLuint; addr:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVariantfvEXT(id:TGLuint; addr:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVariantdvEXT(id:TGLuint; addr:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVariantubvEXT(id:TGLuint; addr:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVariantusvEXT(id:TGLuint; addr:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glVariantuivEXT(id:TGLuint; addr:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glVariantPointerEXT(id:TGLuint; _type:TGLenum; stride:TGLuint; addr:pointer);cdecl;external;
procedure glEnableVariantClientStateEXT(id:TGLuint);cdecl;external;
procedure glDisableVariantClientStateEXT(id:TGLuint);cdecl;external;
function glBindLightParameterEXT(light:TGLenum; value:TGLenum):TGLuint;cdecl;external;
function glBindMaterialParameterEXT(face:TGLenum; value:TGLenum):TGLuint;cdecl;external;
function glBindTexGenParameterEXT(unit_:TGLenum; coord:TGLenum; value:TGLenum):TGLuint;cdecl;external;
function glBindTextureUnitParameterEXT(unit_:TGLenum; value:TGLenum):TGLuint;cdecl;external;
function glBindParameterEXT(value:TGLenum):TGLuint;cdecl;external;
function glIsVariantEnabledEXT(id:TGLuint; cap:TGLenum):TGLboolean;cdecl;external;
procedure glGetVariantBooleanvEXT(id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;external;
procedure glGetVariantIntegervEXT(id:TGLuint; value:TGLenum; data:PGLint);cdecl;external;
procedure glGetVariantFloatvEXT(id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;external;
procedure glGetVariantPointervEXT(id:TGLuint; value:TGLenum; data:Ppointer);cdecl;external;
procedure glGetInvariantBooleanvEXT(id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;external;
procedure glGetInvariantIntegervEXT(id:TGLuint; value:TGLenum; data:PGLint);cdecl;external;
procedure glGetInvariantFloatvEXT(id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;external;
procedure glGetLocalConstantBooleanvEXT(id:TGLuint; value:TGLenum; data:PGLboolean);cdecl;external;
procedure glGetLocalConstantIntegervEXT(id:TGLuint; value:TGLenum; data:PGLint);cdecl;external;
procedure glGetLocalConstantFloatvEXT(id:TGLuint; value:TGLenum; data:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_vertex_shader */ }
{////#ifndef GL_EXT_vertex_weighting }
const
  GL_EXT_vertex_weighting = 1;  
  GL_MODELVIEW0_STACK_DEPTH_EXT = $0BA3;  
  GL_MODELVIEW1_STACK_DEPTH_EXT = $8502;  
  GL_MODELVIEW0_MATRIX_EXT = $0BA6;  
  GL_MODELVIEW1_MATRIX_EXT = $8506;  
  GL_VERTEX_WEIGHTING_EXT = $8509;  
  GL_MODELVIEW0_EXT = $1700;  
  GL_MODELVIEW1_EXT = $850A;  
  GL_CURRENT_VERTEX_WEIGHT_EXT = $850B;  
  GL_VERTEX_WEIGHT_ARRAY_EXT = $850C;  
  GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = $850D;  
  GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = $850E;  
  GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = $850F;  
  GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = $8510;  
{////typedef void (P PFNGLVERTEXWEIGHTFEXTPROC) (GLfloat weight); }
{////typedef void (P PFNGLVERTEXWEIGHTFVEXTPROC) (const GLfloat *weight); }
{////typedef void (P PFNGLVERTEXWEIGHTPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexWeightfEXT(weight:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexWeightfvEXT(weight:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexWeightPointerEXT(size:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_vertex_weighting */ }
{////#ifndef GL_EXT_win32_keyed_mutex }
const
  GL_EXT_win32_keyed_mutex = 1;  
{////typedef GLboolean (P PFNGLACQUIREKEYEDMUTEXWIN32EXTPROC) (GLuint memory, GLuint64 key, GLuint timeout); }
{////typedef GLboolean (P PFNGLRELEASEKEYEDMUTEXWIN32EXTPROC) (GLuint memory, GLuint64 key); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glAcquireKeyedMutexWin32EXT(memory:TGLuint; key:TGLuint64; timeout:TGLuint):TGLboolean;cdecl;external;
function glReleaseKeyedMutexWin32EXT(memory:TGLuint; key:TGLuint64):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_win32_keyed_mutex */ }
{////#ifndef GL_EXT_window_rectangles }
const
  GL_EXT_window_rectangles = 1;  
  GL_INCLUSIVE_EXT = $8F10;  
  GL_EXCLUSIVE_EXT = $8F11;  
  GL_WINDOW_RECTANGLE_EXT = $8F12;  
  GL_WINDOW_RECTANGLE_MODE_EXT = $8F13;  
  GL_MAX_WINDOW_RECTANGLES_EXT = $8F14;  
  GL_NUM_WINDOW_RECTANGLES_EXT = $8F15;  
{////typedef void (P PFNGLWINDOWRECTANGLESEXTPROC) (GLenum mode, GLsizei count, const GLint *box); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glWindowRectanglesEXT(mode:TGLenum; count:TGLsizei; box:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_EXT_window_rectangles */ }
{////#ifndef GL_EXT_x11_sync_object }
const
  GL_EXT_x11_sync_object = 1;  
  GL_SYNC_X11_FENCE_EXT = $90E1;  
{////typedef GLsync (P PFNGLIMPORTSYNCEXTPROC) (GLenum external_sync_type, GLintptr external_sync, GLbitfield flags); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glImportSyncEXT(external_sync_type:TGLenum; external_sync:TGLintptr; flags:TGLbitfield):TGLsync;cdecl;external;
{////#endif }
{////#endif /* GL_EXT_x11_sync_object */ }
{////#ifndef GL_GREMEDY_frame_terminator }
const
  GL_GREMEDY_frame_terminator = 1;  
{////typedef void (P PFNGLFRAMETERMINATORGREMEDYPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFrameTerminatorGREMEDY;cdecl;external;
{////#endif }
{////#endif /* GL_GREMEDY_frame_terminator */ }
{////#ifndef GL_GREMEDY_string_marker }
const
  GL_GREMEDY_string_marker = 1;  
{////typedef void (P PFNGLSTRINGMARKERGREMEDYPROC) (GLsizei len, const void *string); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glStringMarkerGREMEDY(len:TGLsizei; _string:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_GREMEDY_string_marker */ }
{////#ifndef GL_HP_convolution_border_modes }
const
  GL_HP_convolution_border_modes = 1;  
  GL_IGNORE_BORDER_HP = $8150;  
  GL_CONSTANT_BORDER_HP = $8151;  
  GL_REPLICATE_BORDER_HP = $8153;  
  GL_CONVOLUTION_BORDER_COLOR_HP = $8154;  
{////#endif /* GL_HP_convolution_border_modes */ }
{////#ifndef GL_HP_image_transform }
  GL_HP_image_transform = 1;  
  GL_IMAGE_SCALE_X_HP = $8155;  
  GL_IMAGE_SCALE_Y_HP = $8156;  
  GL_IMAGE_TRANSLATE_X_HP = $8157;  
  GL_IMAGE_TRANSLATE_Y_HP = $8158;  
  GL_IMAGE_ROTATE_ANGLE_HP = $8159;  
  GL_IMAGE_ROTATE_ORIGIN_X_HP = $815A;  
  GL_IMAGE_ROTATE_ORIGIN_Y_HP = $815B;  
  GL_IMAGE_MAG_FILTER_HP = $815C;  
  GL_IMAGE_MIN_FILTER_HP = $815D;  
  GL_IMAGE_CUBIC_WEIGHT_HP = $815E;  
  GL_CUBIC_HP = $815F;  
  GL_AVERAGE_HP = $8160;  
  GL_IMAGE_TRANSFORM_2D_HP = $8161;  
  GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8162;  
  GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8163;  
{////typedef void (P PFNGLIMAGETRANSFORMPARAMETERIHPPROC) (GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLIMAGETRANSFORMPARAMETERFHPPROC) (GLenum target, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLIMAGETRANSFORMPARAMETERIVHPPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLIMAGETRANSFORMPARAMETERFVHPPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glImageTransformParameteriHP(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
procedure glImageTransformParameterfHP(target:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glImageTransformParameterivHP(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glImageTransformParameterfvHP(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetImageTransformParameterivHP(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetImageTransformParameterfvHP(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_HP_image_transform */ }
{////#ifndef GL_HP_occlusion_test }
const
  GL_HP_occlusion_test = 1;  
  GL_OCCLUSION_TEST_HP = $8165;  
  GL_OCCLUSION_TEST_RESULT_HP = $8166;  
{////#endif /* GL_HP_occlusion_test */ }
{////#ifndef GL_HP_texture_lighting }
  GL_HP_texture_lighting = 1;  
  GL_TEXTURE_LIGHTING_MODE_HP = $8167;  
  GL_TEXTURE_POST_SPECULAR_HP = $8168;  
  GL_TEXTURE_PRE_SPECULAR_HP = $8169;  
{////#endif /* GL_HP_texture_lighting */ }
{////#ifndef GL_IBM_cull_vertex }
  GL_IBM_cull_vertex = 1;  
  GL_CULL_VERTEX_IBM = 103050;  
{////#endif /* GL_IBM_cull_vertex */ }
{////#ifndef GL_IBM_multimode_draw_arrays }
  GL_IBM_multimode_draw_arrays = 1;  
{////typedef void (P PFNGLMULTIMODEDRAWARRAYSIBMPROC) (const GLenum *mode, const GLint *first, const GLsizei *count, GLsizei primcount, GLint modestride); }
{////typedef void (P PFNGLMULTIMODEDRAWELEMENTSIBMPROC) (const GLenum *mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount, GLint modestride); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

procedure glMultiModeDrawArraysIBM(mode:PGLenum; first:PGLint; count:PGLsizei; primcount:TGLsizei; modestride:TGLint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before declarator ignored *)
procedure glMultiModeDrawElementsIBM(mode:PGLenum; count:PGLsizei; _type:TGLenum; indices:Ppointer; primcount:TGLsizei; 
            modestride:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_IBM_multimode_draw_arrays */ }
{////#ifndef GL_IBM_rasterpos_clip }
const
  GL_IBM_rasterpos_clip = 1;  
  GL_RASTER_POSITION_UNCLIPPED_IBM = $19262;  
{////#endif /* GL_IBM_rasterpos_clip */ }
{////#ifndef GL_IBM_static_data }
  GL_IBM_static_data = 1;  
  GL_ALL_STATIC_DATA_IBM = 103060;  
  GL_STATIC_VERTEX_ARRAY_IBM = 103061;  
{////typedef void (P PFNGLFLUSHSTATICDATAIBMPROC) (GLenum target); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFlushStaticDataIBM(target:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_IBM_static_data */ }
{////#ifndef GL_IBM_texture_mirrored_repeat }
const
  GL_IBM_texture_mirrored_repeat = 1;  
  GL_MIRRORED_REPEAT_IBM = $8370;  
{////#endif /* GL_IBM_texture_mirrored_repeat */ }
{////#ifndef GL_IBM_vertex_array_lists }
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
{////typedef void (P PFNGLCOLORPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLSECONDARYCOLORPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLEDGEFLAGPOINTERLISTIBMPROC) (GLint stride, const GLboolean **pointer, GLint ptrstride); }
{////typedef void (P PFNGLFOGCOORDPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLINDEXPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLNORMALPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLTEXCOORDPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////typedef void (P PFNGLVERTEXPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glColorPointerListIBM(size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColorPointerListIBM(size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)

//type PPGLboolean=^PGLboolean;

procedure glEdgeFlagPointerListIBM(stride:TGLint; pointer_:PPGLboolean; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordPointerListIBM(_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glIndexPointerListIBM(_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glNormalPointerListIBM(_type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordPointerListIBM(size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glVertexPointerListIBM(size:TGLint; _type:TGLenum; stride:TGLint; pointer:Ppointer; ptrstride:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_IBM_vertex_array_lists */ }
{////#ifndef GL_INGR_blend_func_separate }
const
  GL_INGR_blend_func_separate = 1;  
{////typedef void (P PFNGLBLENDFUNCSEPARATEINGRPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendFuncSeparateINGR(sfactorRGB:TGLenum; dfactorRGB:TGLenum; sfactorAlpha:TGLenum; dfactorAlpha:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_INGR_blend_func_separate */ }
{////#ifndef GL_INGR_color_clamp }
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
{////#endif /* GL_INGR_color_clamp */ }
{////#ifndef GL_INGR_interlace_read }
  GL_INGR_interlace_read = 1;  
  GL_INTERLACE_READ_INGR = $8568;  
{////#endif /* GL_INGR_interlace_read */ }
{////#ifndef GL_INTEL_blackhole_render }
  GL_INTEL_blackhole_render = 1;  
  GL_BLACKHOLE_RENDER_INTEL = $83FC;  
{////#endif /* GL_INTEL_blackhole_render */ }
{////#ifndef GL_INTEL_conservative_rasterization }
  GL_INTEL_conservative_rasterization = 1;  
  GL_CONSERVATIVE_RASTERIZATION_INTEL = $83FE;  
{////#endif /* GL_INTEL_conservative_rasterization */ }
{////#ifndef GL_INTEL_fragment_shader_ordering }
  GL_INTEL_fragment_shader_ordering = 1;  
{////#endif /* GL_INTEL_fragment_shader_ordering */ }
{////#ifndef GL_INTEL_framebuffer_CMAA }
  GL_INTEL_framebuffer_CMAA = 1;  
{////typedef void (P PFNGLAPPLYFRAMEBUFFERATTACHMENTCMAAINTELPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glApplyFramebufferAttachmentCMAAINTEL;cdecl;external;
{////#endif }
{////#endif /* GL_INTEL_framebuffer_CMAA */ }
{////#ifndef GL_INTEL_map_texture }
const
  GL_INTEL_map_texture = 1;  
  GL_TEXTURE_MEMORY_LAYOUT_INTEL = $83FF;  
  GL_LAYOUT_DEFAULT_INTEL = 0;  
  GL_LAYOUT_LINEAR_INTEL = 1;  
  GL_LAYOUT_LINEAR_CPU_CACHED_INTEL = 2;  
{////typedef void (P PFNGLSYNCTEXTUREINTELPROC) (GLuint texture); }
{////typedef void (P PFNGLUNMAPTEXTURE2DINTELPROC) (GLuint texture, GLint level); }
{////typedef void *(P PFNGLMAPTEXTURE2DINTELPROC) (GLuint texture, GLint level, GLbitfield access, GLint *stride, GLenum *layout); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSyncTextureINTEL(texture:TGLuint);cdecl;external;
procedure glUnmapTexture2DINTEL(texture:TGLuint; level:TGLint);cdecl;external;
function glMapTexture2DINTEL(texture:TGLuint; level:TGLint; access:TGLbitfield; stride:PGLint; layout:PGLenum):pointer;cdecl;external;
{////#endif }
{////#endif /* GL_INTEL_map_texture */ }
{////#ifndef GL_INTEL_parallel_arrays }
const
  GL_INTEL_parallel_arrays = 1;  
  GL_PARALLEL_ARRAYS_INTEL = $83F4;  
  GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = $83F5;  
  GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = $83F6;  
  GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = $83F7;  
  GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = $83F8;  
{////typedef void (P PFNGLVERTEXPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer); }
{////typedef void (P PFNGLNORMALPOINTERVINTELPROC) (GLenum type, const void **pointer); }
{////typedef void (P PFNGLCOLORPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer); }
{////typedef void (P PFNGLTEXCOORDPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glVertexPointervINTEL(size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;external;
(* Const before type ignored *)
procedure glNormalPointervINTEL(_type:TGLenum; pointer:Ppointer);cdecl;external;
(* Const before type ignored *)
procedure glColorPointervINTEL(size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;external;
(* Const before type ignored *)
procedure glTexCoordPointervINTEL(size:TGLint; _type:TGLenum; pointer:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_INTEL_parallel_arrays */ }
{////#ifndef GL_INTEL_performance_query }
const
  GL_INTEL_performance_query = 1;  
  GL_PERFQUERY_SINGLE_CONTEXT_INTEL = $00000000;  
  GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = $00000001;  
  GL_PERFQUERY_WAIT_INTEL = $83FB;  
  GL_PERFQUERY_FLUSH_INTEL = $83FA;  
  GL_PERFQUERY_DONOT_FLUSH_INTEL = $83F9;  
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
{////typedef void (P PFNGLBEGINPERFQUERYINTELPROC) (GLuint queryHandle); }
{////typedef void (P PFNGLCREATEPERFQUERYINTELPROC) (GLuint queryId, GLuint *queryHandle); }
{////typedef void (P PFNGLDELETEPERFQUERYINTELPROC) (GLuint queryHandle); }
{////typedef void (P PFNGLENDPERFQUERYINTELPROC) (GLuint queryHandle); }
{////typedef void (P PFNGLGETFIRSTPERFQUERYIDINTELPROC) (GLuint *queryId); }
{////typedef void (P PFNGLGETNEXTPERFQUERYIDINTELPROC) (GLuint queryId, GLuint *nextQueryId); }
{////typedef void (P PFNGLGETPERFCOUNTERINFOINTELPROC) (GLuint queryId, GLuint counterId, GLuint counterNameLength, GLchar *counterName, GLuint counterDescLength, GLchar *counterDesc, GLuint *counterOffset, GLuint *counterDataSize, GLuint *counterTypeEnum, GLuint *counterDataTypeEnum, GLuint64 *rawCounterMaxValue); }
{////typedef void (P PFNGLGETPERFQUERYDATAINTELPROC) (GLuint queryHandle, GLuint flags, GLsizei dataSize, void *data, GLuint *bytesWritten); }
{////typedef void (P PFNGLGETPERFQUERYIDBYNAMEINTELPROC) (GLchar *queryName, GLuint *queryId); }
{////typedef void (P PFNGLGETPERFQUERYINFOINTELPROC) (GLuint queryId, GLuint queryNameLength, GLchar *queryName, GLuint *dataSize, GLuint *noCounters, GLuint *noInstances, GLuint *capsMask); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginPerfQueryINTEL(queryHandle:TGLuint);cdecl;external;
procedure glCreatePerfQueryINTEL(queryId:TGLuint; queryHandle:PGLuint);cdecl;external;
procedure glDeletePerfQueryINTEL(queryHandle:TGLuint);cdecl;external;
procedure glEndPerfQueryINTEL(queryHandle:TGLuint);cdecl;external;
procedure glGetFirstPerfQueryIdINTEL(queryId:PGLuint);cdecl;external;
procedure glGetNextPerfQueryIdINTEL(queryId:TGLuint; nextQueryId:PGLuint);cdecl;external;
procedure glGetPerfCounterInfoINTEL(queryId:TGLuint; counterId:TGLuint; counterNameLength:TGLuint; counterName:PGLchar; counterDescLength:TGLuint; 
            counterDesc:PGLchar; counterOffset:PGLuint; counterDataSize:PGLuint; counterTypeEnum:PGLuint; counterDataTypeEnum:PGLuint; 
            rawCounterMaxValue:PGLuint64);cdecl;external;
procedure glGetPerfQueryDataINTEL(queryHandle:TGLuint; flags:TGLuint; dataSize:TGLsizei; data:pointer; bytesWritten:PGLuint);cdecl;external;
procedure glGetPerfQueryIdByNameINTEL(queryName:PGLchar; queryId:PGLuint);cdecl;external;
procedure glGetPerfQueryInfoINTEL(queryId:TGLuint; queryNameLength:TGLuint; queryName:PGLchar; dataSize:PGLuint; noCounters:PGLuint; 
            noInstances:PGLuint; capsMask:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_INTEL_performance_query */ }
{////#ifndef GL_MESAX_texture_stack }
const
  GL_MESAX_texture_stack = 1;  
  GL_TEXTURE_1D_STACK_MESAX = $8759;  
  GL_TEXTURE_2D_STACK_MESAX = $875A;  
  GL_PROXY_TEXTURE_1D_STACK_MESAX = $875B;  
  GL_PROXY_TEXTURE_2D_STACK_MESAX = $875C;  
  GL_TEXTURE_1D_STACK_BINDING_MESAX = $875D;  
  GL_TEXTURE_2D_STACK_BINDING_MESAX = $875E;  
{////#endif /* GL_MESAX_texture_stack */ }
{////#ifndef GL_MESA_framebuffer_flip_x }
  GL_MESA_framebuffer_flip_x = 1;  
  GL_FRAMEBUFFER_FLIP_X_MESA = $8BBC;  
{////#endif /* GL_MESA_framebuffer_flip_x */ }
{////#ifndef GL_MESA_framebuffer_flip_y }
  GL_MESA_framebuffer_flip_y = 1;  
  GL_FRAMEBUFFER_FLIP_Y_MESA = $8BBB;  
{////typedef void (P PFNGLFRAMEBUFFERPARAMETERIMESAPROC) (GLenum target, GLenum pname, GLint param); }
{////typedef void (P PFNGLGETFRAMEBUFFERPARAMETERIVMESAPROC) (GLenum target, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFramebufferParameteriMESA(target:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
procedure glGetFramebufferParameterivMESA(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_MESA_framebuffer_flip_y */ }
{////#ifndef GL_MESA_framebuffer_swap_xy }
const
  GL_MESA_framebuffer_swap_xy = 1;  
  GL_FRAMEBUFFER_SWAP_XY_MESA = $8BBD;  
{////#endif /* GL_MESA_framebuffer_swap_xy */ }
{////#ifndef GL_MESA_pack_invert }
  GL_MESA_pack_invert = 1;  
  GL_PACK_INVERT_MESA = $8758;  
{////#endif /* GL_MESA_pack_invert */ }
{////#ifndef GL_MESA_program_binary_formats }
  GL_MESA_program_binary_formats = 1;  
  GL_PROGRAM_BINARY_FORMAT_MESA = $875F;  
{////#endif /* GL_MESA_program_binary_formats */ }
{////#ifndef GL_MESA_resize_buffers }
  GL_MESA_resize_buffers = 1;  
{////typedef void (P PFNGLRESIZEBUFFERSMESAPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glResizeBuffersMESA;cdecl;external;
{////#endif }
{////#endif /* GL_MESA_resize_buffers */ }
{////#ifndef GL_MESA_shader_integer_functions }
const
  GL_MESA_shader_integer_functions = 1;  
{////#endif /* GL_MESA_shader_integer_functions */ }
{////#ifndef GL_MESA_tile_raster_order }
  GL_MESA_tile_raster_order = 1;  
  GL_TILE_RASTER_ORDER_FIXED_MESA = $8BB8;  
  GL_TILE_RASTER_ORDER_INCREASING_X_MESA = $8BB9;  
  GL_TILE_RASTER_ORDER_INCREASING_Y_MESA = $8BBA;  
{////#endif /* GL_MESA_tile_raster_order */ }
{////#ifndef GL_MESA_window_pos }
  GL_MESA_window_pos = 1;  
{////typedef void (P PFNGLWINDOWPOS2DMESAPROC) (GLdouble x, GLdouble y); }
{////typedef void (P PFNGLWINDOWPOS2DVMESAPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS2FMESAPROC) (GLfloat x, GLfloat y); }
{////typedef void (P PFNGLWINDOWPOS2FVMESAPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS2IMESAPROC) (GLint x, GLint y); }
{////typedef void (P PFNGLWINDOWPOS2IVMESAPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS2SMESAPROC) (GLshort x, GLshort y); }
{////typedef void (P PFNGLWINDOWPOS2SVMESAPROC) (const GLshort *v); }
{////typedef void (P PFNGLWINDOWPOS3DMESAPROC) (GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLWINDOWPOS3DVMESAPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS3FMESAPROC) (GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLWINDOWPOS3FVMESAPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS3IMESAPROC) (GLint x, GLint y, GLint z); }
{////typedef void (P PFNGLWINDOWPOS3IVMESAPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS3SMESAPROC) (GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLWINDOWPOS3SVMESAPROC) (const GLshort *v); }
{////typedef void (P PFNGLWINDOWPOS4DMESAPROC) (GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLWINDOWPOS4DVMESAPROC) (const GLdouble *v); }
{////typedef void (P PFNGLWINDOWPOS4FMESAPROC) (GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLWINDOWPOS4FVMESAPROC) (const GLfloat *v); }
{////typedef void (P PFNGLWINDOWPOS4IMESAPROC) (GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLWINDOWPOS4IVMESAPROC) (const GLint *v); }
{////typedef void (P PFNGLWINDOWPOS4SMESAPROC) (GLshort x, GLshort y, GLshort z, GLshort w); }
{////typedef void (P PFNGLWINDOWPOS4SVMESAPROC) (const GLshort *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glWindowPos2dMESA(x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2dvMESA(v:PGLdouble);cdecl;external;
procedure glWindowPos2fMESA(x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2fvMESA(v:PGLfloat);cdecl;external;
procedure glWindowPos2iMESA(x:TGLint; y:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2ivMESA(v:PGLint);cdecl;external;
procedure glWindowPos2sMESA(x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos2svMESA(v:PGLshort);cdecl;external;
procedure glWindowPos3dMESA(x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3dvMESA(v:PGLdouble);cdecl;external;
procedure glWindowPos3fMESA(x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3fvMESA(v:PGLfloat);cdecl;external;
procedure glWindowPos3iMESA(x:TGLint; y:TGLint; z:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3ivMESA(v:PGLint);cdecl;external;
procedure glWindowPos3sMESA(x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos3svMESA(v:PGLshort);cdecl;external;
procedure glWindowPos4dMESA(x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos4dvMESA(v:PGLdouble);cdecl;external;
procedure glWindowPos4fMESA(x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos4fvMESA(v:PGLfloat);cdecl;external;
procedure glWindowPos4iMESA(x:TGLint; y:TGLint; z:TGLint; w:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos4ivMESA(v:PGLint);cdecl;external;
procedure glWindowPos4sMESA(x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glWindowPos4svMESA(v:PGLshort);cdecl;external;
{////#endif }
{////#endif /* GL_MESA_window_pos */ }
{////#ifndef GL_MESA_ycbcr_texture }
const
  GL_MESA_ycbcr_texture = 1;  
  GL_UNSIGNED_SHORT_8_8_MESA = $85BA;  
  GL_UNSIGNED_SHORT_8_8_REV_MESA = $85BB;  
  GL_YCBCR_MESA = $8757;  
{////#endif /* GL_MESA_ycbcr_texture */ }
{////#ifndef GL_NVX_blend_equation_advanced_multi_draw_buffers }
  GL_NVX_blend_equation_advanced_multi_draw_buffers = 1;  
{////#endif /* GL_NVX_blend_equation_advanced_multi_draw_buffers */ }
{////#ifndef GL_NVX_conditional_render }
  GL_NVX_conditional_render = 1;  
{////typedef void (P PFNGLBEGINCONDITIONALRENDERNVXPROC) (GLuint id); }
{////typedef void (P PFNGLENDCONDITIONALRENDERNVXPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginConditionalRenderNVX(id:TGLuint);cdecl;external;
procedure glEndConditionalRenderNVX;cdecl;external;
{////#endif }
{////#endif /* GL_NVX_conditional_render */ }
{////#ifndef GL_NVX_gpu_memory_info }
const
  GL_NVX_gpu_memory_info = 1;  
  GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = $9047;  
  GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = $9048;  
  GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = $9049;  
  GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX = $904A;  
  GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = $904B;  
{////#endif /* GL_NVX_gpu_memory_info */ }
{////#ifndef GL_NVX_gpu_multicast2 }
  GL_NVX_gpu_multicast2 = 1;  
  GL_UPLOAD_GPU_MASK_NVX = $954A;  
{////typedef void (P PFNGLUPLOADGPUMASKNVXPROC) (GLbitfield mask); }
{////typedef void (P PFNGLMULTICASTVIEWPORTARRAYVNVXPROC) (GLuint gpu, GLuint first, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLMULTICASTVIEWPORTPOSITIONWSCALENVXPROC) (GLuint gpu, GLuint index, GLfloat xcoeff, GLfloat ycoeff); }
{////typedef void (P PFNGLMULTICASTSCISSORARRAYVNVXPROC) (GLuint gpu, GLuint first, GLsizei count, const GLint *v); }
{////typedef GLuint (P PFNGLASYNCCOPYBUFFERSUBDATANVXPROC) (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *fenceValueArray, GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray); }
{////typedef GLuint (P PFNGLASYNCCOPYIMAGESUBDATANVXPROC) (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *waitValueArray, GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glUploadGpuMaskNVX(mask:TGLbitfield);cdecl;external;
(* Const before type ignored *)
procedure glMulticastViewportArrayvNVX(gpu:TGLuint; first:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
procedure glMulticastViewportPositionWScaleNVX(gpu:TGLuint; index:TGLuint; xcoeff:TGLfloat; ycoeff:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMulticastScissorArrayvNVX(gpu:TGLuint; first:TGLuint; count:TGLsizei; v:PGLint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function glAsyncCopyBufferSubDataNVX(waitSemaphoreCount:TGLsizei; waitSemaphoreArray:PGLuint; fenceValueArray:PGLuint64; readGpu:TGLuint; writeGpuMask:TGLbitfield; 
           readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr; 
           signalSemaphoreCount:TGLsizei; signalSemaphoreArray:PGLuint; signalValueArray:PGLuint64):TGLuint;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function glAsyncCopyImageSubDataNVX(waitSemaphoreCount:TGLsizei; waitSemaphoreArray:PGLuint; waitValueArray:PGLuint64; srcGpu:TGLuint; dstGpuMask:TGLbitfield; 
           srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint; 
           srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
           dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; srcHeight:TGLsizei; srcDepth:TGLsizei; 
           signalSemaphoreCount:TGLsizei; signalSemaphoreArray:PGLuint; signalValueArray:PGLuint64):TGLuint;cdecl;external;
{////#endif }
{////#endif /* GL_NVX_gpu_multicast2 */ }
{////#ifndef GL_NVX_linked_gpu_multicast }
const
  GL_NVX_linked_gpu_multicast = 1;  
  GL_LGPU_SEPARATE_STORAGE_BIT_NVX = $0800;  
  GL_MAX_LGPU_GPUS_NVX = $92BA;  
{////typedef void (P PFNGLLGPUNAMEDBUFFERSUBDATANVXPROC) (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data); }
{////typedef void (P PFNGLLGPUCOPYIMAGESUBDATANVXPROC) (GLuint sourceGpu, GLbitfield destinationGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srxY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth); }
{////typedef void (P PFNGLLGPUINTERLOCKNVXPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glLGPUNamedBufferSubDataNVX(gpuMask:TGLbitfield; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glLGPUCopyImageSubDataNVX(sourceGpu:TGLuint; destinationGpuMask:TGLbitfield; srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; 
            srcX:TGLint; srxY:TGLint; srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; 
            dstLevel:TGLint; dstX:TGLint; dstY:TGLint; dstZ:TGLint; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei);cdecl;external;
procedure glLGPUInterlockNVX;cdecl;external;
{////#endif }
{////#endif /* GL_NVX_linked_gpu_multicast */ }
{////#ifndef GL_NVX_progress_fence }
const
  GL_NVX_progress_fence = 1;  
{////typedef GLuint (P PFNGLCREATEPROGRESSFENCENVXPROC) (void); }
{////typedef void (P PFNGLSIGNALSEMAPHOREUI64NVXPROC) (GLuint signalGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray); }
{////typedef void (P PFNGLWAITSEMAPHOREUI64NVXPROC) (GLuint waitGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray); }
{////typedef void (P PFNGLCLIENTWAITSEMAPHOREUI64NVXPROC) (GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glCreateProgressFenceNVX:TGLuint;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glSignalSemaphoreui64NVX(signalGpu:TGLuint; fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glWaitSemaphoreui64NVX(waitGpu:TGLuint; fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glClientWaitSemaphoreui64NVX(fenceObjectCount:TGLsizei; semaphoreArray:PGLuint; fenceValueArray:PGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_NVX_progress_fence */ }
{////#ifndef GL_NV_alpha_to_coverage_dither_control }
const
  GL_NV_alpha_to_coverage_dither_control = 1;  
  GL_ALPHA_TO_COVERAGE_DITHER_DEFAULT_NV = $934D;  
  GL_ALPHA_TO_COVERAGE_DITHER_ENABLE_NV = $934E;  
  GL_ALPHA_TO_COVERAGE_DITHER_DISABLE_NV = $934F;  
  GL_ALPHA_TO_COVERAGE_DITHER_MODE_NV = $92BF;  
{////typedef void (P PFNGLALPHATOCOVERAGEDITHERCONTROLNVPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glAlphaToCoverageDitherControlNV(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_alpha_to_coverage_dither_control */ }
{////#ifndef GL_NV_bindless_multi_draw_indirect }
const
  GL_NV_bindless_multi_draw_indirect = 1;  
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMultiDrawArraysIndirectBindlessNV(mode:TGLenum; indirect:pointer; drawCount:TGLsizei; stride:TGLsizei; vertexBufferCount:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirectBindlessNV(mode:TGLenum; _type:TGLenum; indirect:pointer; drawCount:TGLsizei; stride:TGLsizei; 
            vertexBufferCount:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_bindless_multi_draw_indirect */ }
{////#ifndef GL_NV_bindless_multi_draw_indirect_count }
const
  GL_NV_bindless_multi_draw_indirect_count = 1;  
{////typedef void (P PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount); }
{////typedef void (P PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMultiDrawArraysIndirectBindlessCountNV(mode:TGLenum; indirect:pointer; drawCount:TGLsizei; maxDrawCount:TGLsizei; stride:TGLsizei; 
            vertexBufferCount:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glMultiDrawElementsIndirectBindlessCountNV(mode:TGLenum; _type:TGLenum; indirect:pointer; drawCount:TGLsizei; maxDrawCount:TGLsizei; 
            stride:TGLsizei; vertexBufferCount:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_bindless_multi_draw_indirect_count */ }
{////#ifndef GL_NV_bindless_texture }
const
  GL_NV_bindless_texture = 1;  
{////typedef GLuint64 (P PFNGLGETTEXTUREHANDLENVPROC) (GLuint texture); }
{////typedef GLuint64 (P PFNGLGETTEXTURESAMPLERHANDLENVPROC) (GLuint texture, GLuint sampler); }
{////typedef void (P PFNGLMAKETEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle); }
{////typedef void (P PFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC) (GLuint64 handle); }
{////typedef GLuint64 (P PFNGLGETIMAGEHANDLENVPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format); }
{////typedef void (P PFNGLMAKEIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle, GLenum access); }
{////typedef void (P PFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC) (GLuint64 handle); }
{////typedef void (P PFNGLUNIFORMHANDLEUI64NVPROC) (GLint location, GLuint64 value); }
{////typedef void (P PFNGLUNIFORMHANDLEUI64VNVPROC) (GLint location, GLsizei count, const GLuint64 *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMHANDLEUI64NVPROC) (GLuint program_, GLint location, GLuint64 value); }
{////typedef void (P PFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64 *values); }
{////typedef GLboolean (P PFNGLISTEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle); }
{////typedef GLboolean (P PFNGLISIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGetTextureHandleNV(texture:TGLuint):TGLuint64;cdecl;external;
function glGetTextureSamplerHandleNV(texture:TGLuint; sampler:TGLuint):TGLuint64;cdecl;external;
procedure glMakeTextureHandleResidentNV(handle:TGLuint64);cdecl;external;
procedure glMakeTextureHandleNonResidentNV(handle:TGLuint64);cdecl;external;
function glGetImageHandleNV(texture:TGLuint; level:TGLint; layered:TGLboolean; layer:TGLint; format:TGLenum):TGLuint64;cdecl;external;
procedure glMakeImageHandleResidentNV(handle:TGLuint64; access:TGLenum);cdecl;external;
procedure glMakeImageHandleNonResidentNV(handle:TGLuint64);cdecl;external;
procedure glUniformHandleui64NV(location:TGLint; value:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glUniformHandleui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64);cdecl;external;
procedure glProgramUniformHandleui64NV(program_:TGLuint; location:TGLint; value:TGLuint64);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformHandleui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; values:PGLuint64);cdecl;external;
function glIsTextureHandleResidentNV(handle:TGLuint64):TGLboolean;cdecl;external;
function glIsImageHandleResidentNV(handle:TGLuint64):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_NV_bindless_texture */ }
{////#ifndef GL_NV_blend_equation_advanced }
const
  GL_NV_blend_equation_advanced = 1;  
  GL_BLEND_OVERLAP_NV = $9281;  
  GL_BLEND_PREMULTIPLIED_SRC_NV = $9280;  
  GL_BLUE_NV = $1905;  
  GL_COLORBURN_NV = $929A;  
  GL_COLORDODGE_NV = $9299;  
  GL_CONJOINT_NV = $9284;  
  GL_CONTRAST_NV = $92A1;  
  GL_DARKEN_NV = $9297;  
  GL_DIFFERENCE_NV = $929E;  
  GL_DISJOINT_NV = $9283;  
  GL_DST_ATOP_NV = $928F;  
  GL_DST_IN_NV = $928B;  
  GL_DST_NV = $9287;  
  GL_DST_OUT_NV = $928D;  
  GL_DST_OVER_NV = $9289;  
  GL_EXCLUSION_NV = $92A0;  
  GL_GREEN_NV = $1904;  
  GL_HARDLIGHT_NV = $929B;  
  GL_HARDMIX_NV = $92A9;  
  GL_HSL_COLOR_NV = $92AF;  
  GL_HSL_HUE_NV = $92AD;  
  GL_HSL_LUMINOSITY_NV = $92B0;  
  GL_HSL_SATURATION_NV = $92AE;  
  GL_INVERT_OVG_NV = $92B4;  
  GL_INVERT_RGB_NV = $92A3;  
  GL_LIGHTEN_NV = $9298;  
  GL_LINEARBURN_NV = $92A5;  
  GL_LINEARDODGE_NV = $92A4;  
  GL_LINEARLIGHT_NV = $92A7;  
  GL_MINUS_CLAMPED_NV = $92B3;  
  GL_MINUS_NV = $929F;  
  GL_MULTIPLY_NV = $9294;  
  GL_OVERLAY_NV = $9296;  
  GL_PINLIGHT_NV = $92A8;  
  GL_PLUS_CLAMPED_ALPHA_NV = $92B2;  
  GL_PLUS_CLAMPED_NV = $92B1;  
  GL_PLUS_DARKER_NV = $9292;  
  GL_PLUS_NV = $9291;  
  GL_RED_NV = $1903;  
  GL_SCREEN_NV = $9295;  
  GL_SOFTLIGHT_NV = $929C;  
  GL_SRC_ATOP_NV = $928E;  
  GL_SRC_IN_NV = $928A;  
  GL_SRC_NV = $9286;  
  GL_SRC_OUT_NV = $928C;  
  GL_SRC_OVER_NV = $9288;  
  GL_UNCORRELATED_NV = $9282;  
  GL_VIVIDLIGHT_NV = $92A6;  
  GL_XOR_NV = $1506;  
{////typedef void (P PFNGLBLENDPARAMETERINVPROC) (GLenum pname, GLint value); }
{////typedef void (P PFNGLBLENDBARRIERNVPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBlendParameteriNV(pname:TGLenum; value:TGLint);cdecl;external;
procedure glBlendBarrierNV;cdecl;external;
{////#endif }
{////#endif /* GL_NV_blend_equation_advanced */ }
{////#ifndef GL_NV_blend_equation_advanced_coherent }
const
  GL_NV_blend_equation_advanced_coherent = 1;  
  GL_BLEND_ADVANCED_COHERENT_NV = $9285;  
{////#endif /* GL_NV_blend_equation_advanced_coherent */ }
{////#ifndef GL_NV_blend_minmax_factor }
  GL_NV_blend_minmax_factor = 1;  
{////#endif /* GL_NV_blend_minmax_factor */ }
{////#ifndef GL_NV_blend_square }
  GL_NV_blend_square = 1;  
{////#endif /* GL_NV_blend_square */ }
{////#ifndef GL_NV_clip_space_w_scaling }
  GL_NV_clip_space_w_scaling = 1;  
  GL_VIEWPORT_POSITION_W_SCALE_NV = $937C;  
  GL_VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = $937D;  
  GL_VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = $937E;  
{////typedef void (P PFNGLVIEWPORTPOSITIONWSCALENVPROC) (GLuint index, GLfloat xcoeff, GLfloat ycoeff); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glViewportPositionWScaleNV(index:TGLuint; xcoeff:TGLfloat; ycoeff:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_NV_clip_space_w_scaling */ }
{////#ifndef GL_NV_command_list }
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
  GL_UNIFORM_ADDRESS_COMMAND_NV = $000A;  
  GL_BLEND_COLOR_COMMAND_NV = $000B;  
  GL_STENCIL_REF_COMMAND_NV = $000C;  
  GL_LINE_WIDTH_COMMAND_NV = $000D;  
  GL_POLYGON_OFFSET_COMMAND_NV = $000E;  
  GL_ALPHA_REF_COMMAND_NV = $000F;  
  GL_VIEWPORT_COMMAND_NV = $0010;  
  GL_SCISSOR_COMMAND_NV = $0011;  
  GL_FRONT_FACE_COMMAND_NV = $0012;  
{////typedef void (P PFNGLCREATESTATESNVPROC) (GLsizei n, GLuint *states); }
{////typedef void (P PFNGLDELETESTATESNVPROC) (GLsizei n, const GLuint *states); }
{////typedef GLboolean (P PFNGLISSTATENVPROC) (GLuint state); }
{////typedef void (P PFNGLSTATECAPTURENVPROC) (GLuint state, GLenum mode); }
{////typedef GLuint (P PFNGLGETCOMMANDHEADERNVPROC) (GLenum tokenID, GLuint size); }
{////typedef GLushort (P PFNGLGETSTAGEINDEXNVPROC) (GLenum shadertype); }
{////typedef void (P PFNGLDRAWCOMMANDSNVPROC) (GLenum primitiveMode, GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, GLuint count); }
{////typedef void (P PFNGLDRAWCOMMANDSADDRESSNVPROC) (GLenum primitiveMode, const GLuint64 *indirects, const GLsizei *sizes, GLuint count); }
{////typedef void (P PFNGLDRAWCOMMANDSSTATESNVPROC) (GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count); }
{////typedef void (P PFNGLDRAWCOMMANDSSTATESADDRESSNVPROC) (const GLuint64 *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count); }
{////typedef void (P PFNGLCREATECOMMANDLISTSNVPROC) (GLsizei n, GLuint *lists); }
{////typedef void (P PFNGLDELETECOMMANDLISTSNVPROC) (GLsizei n, const GLuint *lists); }
{////typedef GLboolean (P PFNGLISCOMMANDLISTNVPROC) (GLuint list); }
{////typedef void (P PFNGLLISTDRAWCOMMANDSSTATESCLIENTNVPROC) (GLuint list, GLuint segment, const void **indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count); }
{////typedef void (P PFNGLCOMMANDLISTSEGMENTSNVPROC) (GLuint list, GLuint segments); }
{////typedef void (P PFNGLCOMPILECOMMANDLISTNVPROC) (GLuint list); }
{////typedef void (P PFNGLCALLCOMMANDLISTNVPROC) (GLuint list); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCreateStatesNV(n:TGLsizei; states:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteStatesNV(n:TGLsizei; states:PGLuint);cdecl;external;
function glIsStateNV(state:TGLuint):TGLboolean;cdecl;external;
procedure glStateCaptureNV(state:TGLuint; mode:TGLenum);cdecl;external;
function glGetCommandHeaderNV(tokenID:TGLenum; size:TGLuint):TGLuint;cdecl;external;
function glGetStageIndexNV(shadertype:TGLenum):TGLushort;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glDrawCommandsNV(primitiveMode:TGLenum; buffer:TGLuint; indirects:PGLintptr; sizes:PGLsizei; count:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glDrawCommandsAddressNV(primitiveMode:TGLenum; indirects:PGLuint64; sizes:PGLsizei; count:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glDrawCommandsStatesNV(buffer:TGLuint; indirects:PGLintptr; sizes:PGLsizei; states:PGLuint; fbos:PGLuint; 
            count:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glDrawCommandsStatesAddressNV(indirects:PGLuint64; sizes:PGLsizei; states:PGLuint; fbos:PGLuint; count:TGLuint);cdecl;external;
procedure glCreateCommandListsNV(n:TGLsizei; lists:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteCommandListsNV(n:TGLsizei; lists:PGLuint);cdecl;external;
function glIsCommandListNV(list:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glListDrawCommandsStatesClientNV(list:TGLuint; segment:TGLuint; indirects:Ppointer; sizes:PGLsizei; states:PGLuint; 
            fbos:PGLuint; count:TGLuint);cdecl;external;
procedure glCommandListSegmentsNV(list:TGLuint; segments:TGLuint);cdecl;external;
procedure glCompileCommandListNV(list:TGLuint);cdecl;external;
procedure glCallCommandListNV(list:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_command_list */ }
{////#ifndef GL_NV_compute_program5 }
const
  GL_NV_compute_program5 = 1;  
  GL_COMPUTE_PROGRAM_NV = $90FB;  
  GL_COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = $90FC;  
{////#endif /* GL_NV_compute_program5 */ }
{////#ifndef GL_NV_compute_shader_derivatives }
  GL_NV_compute_shader_derivatives = 1;  
{////#endif /* GL_NV_compute_shader_derivatives */ }
{////#ifndef GL_NV_conditional_render }
  GL_NV_conditional_render = 1;  
  GL_QUERY_WAIT_NV = $8E13;  
  GL_QUERY_NO_WAIT_NV = $8E14;  
  GL_QUERY_BY_REGION_WAIT_NV = $8E15;  
  GL_QUERY_BY_REGION_NO_WAIT_NV = $8E16;  
{////typedef void (P PFNGLBEGINCONDITIONALRENDERNVPROC) (GLuint id, GLenum mode); }
{////typedef void (P PFNGLENDCONDITIONALRENDERNVPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginConditionalRenderNV(id:TGLuint; mode:TGLenum);cdecl;external;
procedure glEndConditionalRenderNV;cdecl;external;
{////#endif }
{////#endif /* GL_NV_conditional_render */ }
{////#ifndef GL_NV_conservative_raster }
const
  GL_NV_conservative_raster = 1;  
  GL_CONSERVATIVE_RASTERIZATION_NV = $9346;  
  GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = $9347;  
  GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = $9348;  
  GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = $9349;  
{////typedef void (P PFNGLSUBPIXELPRECISIONBIASNVPROC) (GLuint xbits, GLuint ybits); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSubpixelPrecisionBiasNV(xbits:TGLuint; ybits:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_conservative_raster */ }
{////#ifndef GL_NV_conservative_raster_dilate }
const
  GL_NV_conservative_raster_dilate = 1;  
  GL_CONSERVATIVE_RASTER_DILATE_NV = $9379;  
  GL_CONSERVATIVE_RASTER_DILATE_RANGE_NV = $937A;  
  GL_CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = $937B;  
{////typedef void (P PFNGLCONSERVATIVERASTERPARAMETERFNVPROC) (GLenum pname, GLfloat value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glConservativeRasterParameterfNV(pname:TGLenum; value:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_NV_conservative_raster_dilate */ }
{////#ifndef GL_NV_conservative_raster_pre_snap }
const
  GL_NV_conservative_raster_pre_snap = 1;  
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = $9550;  
{////#endif /* GL_NV_conservative_raster_pre_snap */ }
{////#ifndef GL_NV_conservative_raster_pre_snap_triangles }
  GL_NV_conservative_raster_pre_snap_triangles = 1;  
  GL_CONSERVATIVE_RASTER_MODE_NV = $954D;  
  GL_CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = $954E;  
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = $954F;  
{////typedef void (P PFNGLCONSERVATIVERASTERPARAMETERINVPROC) (GLenum pname, GLint param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glConservativeRasterParameteriNV(pname:TGLenum; param:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_conservative_raster_pre_snap_triangles */ }
{////#ifndef GL_NV_conservative_raster_underestimation }
const
  GL_NV_conservative_raster_underestimation = 1;  
{////#endif /* GL_NV_conservative_raster_underestimation */ }
{////#ifndef GL_NV_copy_depth_to_color }
  GL_NV_copy_depth_to_color = 1;  
  GL_DEPTH_STENCIL_TO_RGBA_NV = $886E;  
  GL_DEPTH_STENCIL_TO_BGRA_NV = $886F;  
{////#endif /* GL_NV_copy_depth_to_color */ }
{////#ifndef GL_NV_copy_image }
  GL_NV_copy_image = 1;  
{////typedef void (P PFNGLCOPYIMAGESUBDATANVPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCopyImageSubDataNV(srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; srcX:TGLint; srcY:TGLint; 
            srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; 
            dstY:TGLint; dstZ:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_NV_copy_image */ }
{////#ifndef GL_NV_deep_texture3D }
const
  GL_NV_deep_texture3D = 1;  
  GL_MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = $90D0;  
  GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV = $90D1;  
{////#endif /* GL_NV_deep_texture3D */ }
{////#ifndef GL_NV_depth_buffer_float }
  GL_NV_depth_buffer_float = 1;  
  GL_DEPTH_COMPONENT32F_NV = $8DAB;  
  GL_DEPTH32F_STENCIL8_NV = $8DAC;  
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = $8DAD;  
  GL_DEPTH_BUFFER_FLOAT_MODE_NV = $8DAF;  
{////typedef void (P PFNGLDEPTHRANGEDNVPROC) (GLdouble zNear, GLdouble zFar); }
{////typedef void (P PFNGLCLEARDEPTHDNVPROC) (GLdouble depth); }
{////typedef void (P PFNGLDEPTHBOUNDSDNVPROC) (GLdouble zmin, GLdouble zmax); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDepthRangedNV(zNear:TGLdouble; zFar:TGLdouble);cdecl;external;
procedure glClearDepthdNV(depth:TGLdouble);cdecl;external;
procedure glDepthBoundsdNV(zmin:TGLdouble; zmax:TGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_NV_depth_buffer_float */ }
{////#ifndef GL_NV_depth_clamp }
const
  GL_NV_depth_clamp = 1;  
  GL_DEPTH_CLAMP_NV = $864F;  
{////#endif /* GL_NV_depth_clamp */ }
{////#ifndef GL_NV_draw_texture }
  GL_NV_draw_texture = 1;  
{////typedef void (P PFNGLDRAWTEXTURENVPROC) (GLuint texture, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawTextureNV(texture:TGLuint; sampler:TGLuint; x0:TGLfloat; y0:TGLfloat; x1:TGLfloat; 
            y1:TGLfloat; z:TGLfloat; s0:TGLfloat; t0:TGLfloat; s1:TGLfloat; 
            t1:TGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_NV_draw_texture */ }
{////#ifndef GL_NV_draw_vulkan_image }
const
  GL_NV_draw_vulkan_image = 1;  
type

  TGLVULKANPROCNV = procedure (para1:pointer);cdecl;
{////typedef void (P PFNGLDRAWVKIMAGENVPROC) (GLuint64 vkImage, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1); }
{////typedef GLVULKANPROCNV (P PFNGLGETVKPROCADDRNVPROC) (const GLchar *name); }
{////typedef void (P PFNGLWAITVKSEMAPHORENVPROC) (GLuint64 vkSemaphore); }
{////typedef void (P PFNGLSIGNALVKSEMAPHORENVPROC) (GLuint64 vkSemaphore); }
{////typedef void (P PFNGLSIGNALVKFENCENVPROC) (GLuint64 vkFence); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawVkImageNV(vkImage:TGLuint64; sampler:TGLuint; x0:TGLfloat; y0:TGLfloat; x1:TGLfloat; 
            y1:TGLfloat; z:TGLfloat; s0:TGLfloat; t0:TGLfloat; s1:TGLfloat; 
            t1:TGLfloat);cdecl;external;
(* Const before type ignored *)
function glGetVkProcAddrNV(name:PGLchar):TGLVULKANPROCNV;cdecl;external;
procedure glWaitVkSemaphoreNV(vkSemaphore:TGLuint64);cdecl;external;
procedure glSignalVkSemaphoreNV(vkSemaphore:TGLuint64);cdecl;external;
procedure glSignalVkFenceNV(vkFence:TGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_NV_draw_vulkan_image */ }
{////#ifndef GL_NV_evaluators }
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
{////typedef void (P PFNGLMAPCONTROLPOINTSNVPROC) (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLint uorder, GLint vorder, GLboolean packed, const void *points); }
{////typedef void (P PFNGLMAPPARAMETERIVNVPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLMAPPARAMETERFVNVPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLGETMAPCONTROLPOINTSNVPROC) (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLboolean packed, void *points); }
{////typedef void (P PFNGLGETMAPPARAMETERIVNVPROC) (GLenum target, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMAPPARAMETERFVNVPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETMAPATTRIBPARAMETERIVNVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETMAPATTRIBPARAMETERFVNVPROC) (GLenum target, GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLEVALMAPSNVPROC) (GLenum target, GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glMapControlPointsNV(target:TGLenum; index:TGLuint; _type:TGLenum; ustride:TGLsizei; vstride:TGLsizei; 
            uorder:TGLint; vorder:TGLint; _packed:TGLboolean; points:pointer);cdecl;external;
(* Const before type ignored *)
procedure glMapParameterivNV(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glMapParameterfvNV(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMapControlPointsNV(target:TGLenum; index:TGLuint; _type:TGLenum; ustride:TGLsizei; vstride:TGLsizei; 
            packed_:TGLboolean; points:pointer);cdecl;external;
procedure glGetMapParameterivNV(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMapParameterfvNV(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetMapAttribParameterivNV(target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetMapAttribParameterfvNV(target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glEvalMapsNV(target:TGLenum; mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_evaluators */ }
{////#ifndef GL_NV_explicit_multisample }
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
{////typedef void (P PFNGLGETMULTISAMPLEFVNVPROC) (GLenum pname, GLuint index, GLfloat *val); }
{////typedef void (P PFNGLSAMPLEMASKINDEXEDNVPROC) (GLuint index, GLbitfield mask); }
{////typedef void (P PFNGLTEXRENDERBUFFERNVPROC) (GLenum target, GLuint renderbuffer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetMultisamplefvNV(pname:TGLenum; index:TGLuint; val:PGLfloat);cdecl;external;
procedure glSampleMaskIndexedNV(index:TGLuint; mask:TGLbitfield);cdecl;external;
procedure glTexRenderbufferNV(target:TGLenum; renderbuffer:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_explicit_multisample */ }
{////#ifndef GL_NV_fence }
const
  GL_NV_fence = 1;  
  GL_ALL_COMPLETED_NV = $84F2;  
  GL_FENCE_STATUS_NV = $84F3;  
  GL_FENCE_CONDITION_NV = $84F4;  
{////typedef void (P PFNGLDELETEFENCESNVPROC) (GLsizei n, const GLuint *fences); }
{////typedef void (P PFNGLGENFENCESNVPROC) (GLsizei n, GLuint *fences); }
{////typedef GLboolean (P PFNGLISFENCENVPROC) (GLuint fence); }
{////typedef GLboolean (P PFNGLTESTFENCENVPROC) (GLuint fence); }
{////typedef void (P PFNGLGETFENCEIVNVPROC) (GLuint fence, GLenum pname, GLint *params); }
{////typedef void (P PFNGLFINISHFENCENVPROC) (GLuint fence); }
{////typedef void (P PFNGLSETFENCENVPROC) (GLuint fence, GLenum condition); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDeleteFencesNV(n:TGLsizei; fences:PGLuint);cdecl;external;
procedure glGenFencesNV(n:TGLsizei; fences:PGLuint);cdecl;external;
function glIsFenceNV(fence:TGLuint):TGLboolean;cdecl;external;
function glTestFenceNV(fence:TGLuint):TGLboolean;cdecl;external;
procedure glGetFenceivNV(fence:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glFinishFenceNV(fence:TGLuint);cdecl;external;
procedure glSetFenceNV(fence:TGLuint; condition:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_fence */ }
{////#ifndef GL_NV_fill_rectangle }
const
  GL_NV_fill_rectangle = 1;  
  GL_FILL_RECTANGLE_NV = $933C;  
{////#endif /* GL_NV_fill_rectangle */ }
{////#ifndef GL_NV_float_buffer }
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
{////#endif /* GL_NV_float_buffer */ }
{////#ifndef GL_NV_fog_distance }
  GL_NV_fog_distance = 1;  
  GL_FOG_DISTANCE_MODE_NV = $855A;  
  GL_EYE_RADIAL_NV = $855B;  
  GL_EYE_PLANE_ABSOLUTE_NV = $855C;  
{////#endif /* GL_NV_fog_distance */ }
{////#ifndef GL_NV_fragment_coverage_to_color }
  GL_NV_fragment_coverage_to_color = 1;  
  GL_FRAGMENT_COVERAGE_TO_COLOR_NV = $92DD;  
  GL_FRAGMENT_COVERAGE_COLOR_NV = $92DE;  
{////typedef void (P PFNGLFRAGMENTCOVERAGECOLORNVPROC) (GLuint color); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFragmentCoverageColorNV(color:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_fragment_coverage_to_color */ }
{////#ifndef GL_NV_fragment_program }
const
  GL_NV_fragment_program = 1;  
  GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = $8868;  
  GL_FRAGMENT_PROGRAM_NV = $8870;  
  GL_MAX_TEXTURE_COORDS_NV = $8871;  
  GL_MAX_TEXTURE_IMAGE_UNITS_NV = $8872;  
  GL_FRAGMENT_PROGRAM_BINDING_NV = $8873;  
  GL_PROGRAM_ERROR_STRING_NV = $8874;  
{////typedef void (P PFNGLPROGRAMNAMEDPARAMETER4FNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLPROGRAMNAMEDPARAMETER4FVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, const GLfloat *v); }
{////typedef void (P PFNGLPROGRAMNAMEDPARAMETER4DNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLPROGRAMNAMEDPARAMETER4DVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, const GLdouble *v); }
{////typedef void (P PFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLfloat *params); }
{////typedef void (P PFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLdouble *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glProgramNamedParameter4fNV(id:TGLuint; len:TGLsizei; name:PGLubyte; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glProgramNamedParameter4fvNV(id:TGLuint; len:TGLsizei; name:PGLubyte; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramNamedParameter4dNV(id:TGLuint; len:TGLsizei; name:PGLubyte; x:TGLdouble; y:TGLdouble; 
            z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glProgramNamedParameter4dvNV(id:TGLuint; len:TGLsizei; name:PGLubyte; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glGetProgramNamedParameterfvNV(id:TGLuint; len:TGLsizei; name:PGLubyte; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glGetProgramNamedParameterdvNV(id:TGLuint; len:TGLsizei; name:PGLubyte; params:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_NV_fragment_program */ }
{////#ifndef GL_NV_fragment_program2 }
const
  GL_NV_fragment_program2 = 1;  
  GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = $88F4;  
  GL_MAX_PROGRAM_CALL_DEPTH_NV = $88F5;  
  GL_MAX_PROGRAM_IF_DEPTH_NV = $88F6;  
  GL_MAX_PROGRAM_LOOP_DEPTH_NV = $88F7;  
  GL_MAX_PROGRAM_LOOP_COUNT_NV = $88F8;  
{////#endif /* GL_NV_fragment_program2 */ }
{////#ifndef GL_NV_fragment_program4 }
  GL_NV_fragment_program4 = 1;  
{////#endif /* GL_NV_fragment_program4 */ }
{////#ifndef GL_NV_fragment_program_option }
  GL_NV_fragment_program_option = 1;  
{////#endif /* GL_NV_fragment_program_option */ }
{////#ifndef GL_NV_fragment_shader_barycentric }
  GL_NV_fragment_shader_barycentric = 1;  
{////#endif /* GL_NV_fragment_shader_barycentric */ }
{////#ifndef GL_NV_fragment_shader_interlock }
  GL_NV_fragment_shader_interlock = 1;  
{////#endif /* GL_NV_fragment_shader_interlock */ }
{////#ifndef GL_NV_framebuffer_mixed_samples }
  GL_NV_framebuffer_mixed_samples = 1;  
  GL_COVERAGE_MODULATION_TABLE_NV = $9331;  
  GL_COLOR_SAMPLES_NV = $8E20;  
  GL_DEPTH_SAMPLES_NV = $932D;  
  GL_STENCIL_SAMPLES_NV = $932E;  
  GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = $932F;  
  GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = $9330;  
  GL_COVERAGE_MODULATION_NV = $9332;  
  GL_COVERAGE_MODULATION_TABLE_SIZE_NV = $9333;  
{////typedef void (P PFNGLCOVERAGEMODULATIONTABLENVPROC) (GLsizei n, const GLfloat *v); }
{////typedef void (P PFNGLGETCOVERAGEMODULATIONTABLENVPROC) (GLsizei bufSize, GLfloat *v); }
{////typedef void (P PFNGLCOVERAGEMODULATIONNVPROC) (GLenum components); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glCoverageModulationTableNV(n:TGLsizei; v:PGLfloat);cdecl;external;
procedure glGetCoverageModulationTableNV(bufSize:TGLsizei; v:PGLfloat);cdecl;external;
procedure glCoverageModulationNV(components:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_framebuffer_mixed_samples */ }
{////#ifndef GL_NV_framebuffer_multisample_coverage }
const
  GL_NV_framebuffer_multisample_coverage = 1;  
  GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = $8CAB;  
  GL_RENDERBUFFER_COLOR_SAMPLES_NV = $8E10;  
  GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = $8E11;  
  GL_MULTISAMPLE_COVERAGE_MODES_NV = $8E12;  
{////typedef void (P PFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glRenderbufferStorageMultisampleCoverageNV(target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalformat:TGLenum; width:TGLsizei; 
            height:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_NV_framebuffer_multisample_coverage */ }
{////#ifndef GL_NV_geometry_program4 }
const
  GL_NV_geometry_program4 = 1;  
  GL_GEOMETRY_PROGRAM_NV = $8C26;  
  GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = $8C27;  
  GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = $8C28;  
{////typedef void (P PFNGLPROGRAMVERTEXLIMITNVPROC) (GLenum target, GLint limit); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREEXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level); }
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREFACEEXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glProgramVertexLimitNV(target:TGLenum; limit:TGLint);cdecl;external;
procedure glFramebufferTextureEXT(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint);cdecl;external;
procedure glFramebufferTextureFaceEXT(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; face:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_geometry_program4 */ }
{////#ifndef GL_NV_geometry_shader4 }
const
  GL_NV_geometry_shader4 = 1;  
{////#endif /* GL_NV_geometry_shader4 */ }
{////#ifndef GL_NV_geometry_shader_passthrough }
  GL_NV_geometry_shader_passthrough = 1;  
{////#endif /* GL_NV_geometry_shader_passthrough */ }
{////#ifndef GL_NV_gpu_multicast }
  GL_NV_gpu_multicast = 1;  
  GL_PER_GPU_STORAGE_BIT_NV = $0800;  
  GL_MULTICAST_GPUS_NV = $92BA;  
  GL_RENDER_GPU_MASK_NV = $9558;  
  GL_PER_GPU_STORAGE_NV = $9548;  
  GL_MULTICAST_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9549;  
{////typedef void (P PFNGLRENDERGPUMASKNVPROC) (GLbitfield mask); }
{////typedef void (P PFNGLMULTICASTBUFFERSUBDATANVPROC) (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data); }
{////typedef void (P PFNGLMULTICASTCOPYBUFFERSUBDATANVPROC) (GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size); }
{////typedef void (P PFNGLMULTICASTCOPYIMAGESUBDATANVPROC) (GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth); }
{////typedef void (P PFNGLMULTICASTBLITFRAMEBUFFERNVPROC) (GLuint srcGpu, GLuint dstGpu, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter); }
{////typedef void (P PFNGLMULTICASTFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLuint gpu, GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLMULTICASTBARRIERNVPROC) (void); }
{////typedef void (P PFNGLMULTICASTWAITSYNCNVPROC) (GLuint signalGpu, GLbitfield waitGpuMask); }
{////typedef void (P PFNGLMULTICASTGETQUERYOBJECTIVNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLint *params); }
{////typedef void (P PFNGLMULTICASTGETQUERYOBJECTUIVNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLMULTICASTGETQUERYOBJECTI64VNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLint64 *params); }
{////typedef void (P PFNGLMULTICASTGETQUERYOBJECTUI64VNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLuint64 *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glRenderGpuMaskNV(mask:TGLbitfield);cdecl;external;
(* Const before type ignored *)
procedure glMulticastBufferSubDataNV(gpuMask:TGLbitfield; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; data:pointer);cdecl;external;
procedure glMulticastCopyBufferSubDataNV(readGpu:TGLuint; writeGpuMask:TGLbitfield; readBuffer:TGLuint; writeBuffer:TGLuint; readOffset:TGLintptr; 
            writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glMulticastCopyImageSubDataNV(srcGpu:TGLuint; dstGpuMask:TGLbitfield; srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; 
            srcX:TGLint; srcY:TGLint; srcZ:TGLint; dstName:TGLuint; dstTarget:TGLenum; 
            dstLevel:TGLint; dstX:TGLint; dstY:TGLint; dstZ:TGLint; srcWidth:TGLsizei; 
            srcHeight:TGLsizei; srcDepth:TGLsizei);cdecl;external;
procedure glMulticastBlitFramebufferNV(srcGpu:TGLuint; dstGpu:TGLuint; srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; 
            srcY1:TGLint; dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; 
            mask:TGLbitfield; filter:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glMulticastFramebufferSampleLocationsfvNV(gpu:TGLuint; framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
procedure glMulticastBarrierNV;cdecl;external;
procedure glMulticastWaitSyncNV(signalGpu:TGLuint; waitGpuMask:TGLbitfield);cdecl;external;
procedure glMulticastGetQueryObjectivNV(gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glMulticastGetQueryObjectuivNV(gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glMulticastGetQueryObjecti64vNV(gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLint64);cdecl;external;
procedure glMulticastGetQueryObjectui64vNV(gpu:TGLuint; id:TGLuint; pname:TGLenum; params:PGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_NV_gpu_multicast */ }
{////#ifndef GL_NV_gpu_program4 }
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
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERI4INVPROC) (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERI4IVNVPROC) (GLenum target, GLuint index, const GLint *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLint *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERI4UINVPROC) (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC) (GLenum target, GLuint index, const GLuint *params); }
{////typedef void (P PFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLuint *params); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERI4INVPROC) (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERI4IVNVPROC) (GLenum target, GLuint index, const GLint *params); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERSI4IVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLint *params); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERI4UINVPROC) (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERI4UIVNVPROC) (GLenum target, GLuint index, const GLuint *params); }
{////typedef void (P PFNGLPROGRAMENVPARAMETERSI4UIVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLuint *params); }
{////typedef void (P PFNGLGETPROGRAMLOCALPARAMETERIIVNVPROC) (GLenum target, GLuint index, GLint *params); }
{////typedef void (P PFNGLGETPROGRAMLOCALPARAMETERIUIVNVPROC) (GLenum target, GLuint index, GLuint *params); }
{////typedef void (P PFNGLGETPROGRAMENVPARAMETERIIVNVPROC) (GLenum target, GLuint index, GLint *params); }
{////typedef void (P PFNGLGETPROGRAMENVPARAMETERIUIVNVPROC) (GLenum target, GLuint index, GLuint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glProgramLocalParameterI4iNV(target:TGLenum; index:TGLuint; x:TGLint; y:TGLint; z:TGLint; 
            w:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParameterI4ivNV(target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParametersI4ivNV(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;external;
procedure glProgramLocalParameterI4uiNV(target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint; 
            w:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParameterI4uivNV(target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramLocalParametersI4uivNV(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;external;
procedure glProgramEnvParameterI4iNV(target:TGLenum; index:TGLuint; x:TGLint; y:TGLint; z:TGLint; 
            w:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParameterI4ivNV(target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParametersI4ivNV(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLint);cdecl;external;
procedure glProgramEnvParameterI4uiNV(target:TGLenum; index:TGLuint; x:TGLuint; y:TGLuint; z:TGLuint; 
            w:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParameterI4uivNV(target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glProgramEnvParametersI4uivNV(target:TGLenum; index:TGLuint; count:TGLsizei; params:PGLuint);cdecl;external;
procedure glGetProgramLocalParameterIivNV(target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
procedure glGetProgramLocalParameterIuivNV(target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
procedure glGetProgramEnvParameterIivNV(target:TGLenum; index:TGLuint; params:PGLint);cdecl;external;
procedure glGetProgramEnvParameterIuivNV(target:TGLenum; index:TGLuint; params:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_gpu_program4 */ }
{////#ifndef GL_NV_gpu_program5 }
const
  GL_NV_gpu_program5 = 1;  
  GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = $8E5A;  
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5B;  
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5C;  
  GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = $8E5D;  
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5E;  
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5F;  
  GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = $8F44;  
  GL_MAX_PROGRAM_SUBROUTINE_NUM_NV = $8F45;  
{////typedef void (P PFNGLPROGRAMSUBROUTINEPARAMETERSUIVNVPROC) (GLenum target, GLsizei count, const GLuint *params); }
{////typedef void (P PFNGLGETPROGRAMSUBROUTINEPARAMETERUIVNVPROC) (GLenum target, GLuint index, GLuint *param); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glProgramSubroutineParametersuivNV(target:TGLenum; count:TGLsizei; params:PGLuint);cdecl;external;
procedure glGetProgramSubroutineParameteruivNV(target:TGLenum; index:TGLuint; param:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_gpu_program5 */ }
{////#ifndef GL_NV_gpu_program5_mem_extended }
const
  GL_NV_gpu_program5_mem_extended = 1;  
{////#endif /* GL_NV_gpu_program5_mem_extended */ }
{////#ifndef GL_NV_gpu_shader5 }
  GL_NV_gpu_shader5 = 1;  
{////#endif /* GL_NV_gpu_shader5 */ }
{////#ifndef GL_NV_half_float }
  GL_NV_half_float = 1;  
type
  PGLhalfNV = ^TGLhalfNV;
  TGLhalfNV = word;

const
  GL_HALF_FLOAT_NV = $140B;  
{////typedef void (P PFNGLVERTEX2HNVPROC) (GLhalfNV x, GLhalfNV y); }
{////typedef void (P PFNGLVERTEX2HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEX3HNVPROC) (GLhalfNV x, GLhalfNV y, GLhalfNV z); }
{////typedef void (P PFNGLVERTEX3HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEX4HNVPROC) (GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w); }
{////typedef void (P PFNGLVERTEX4HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLNORMAL3HNVPROC) (GLhalfNV nx, GLhalfNV ny, GLhalfNV nz); }
{////typedef void (P PFNGLNORMAL3HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLCOLOR3HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue); }
{////typedef void (P PFNGLCOLOR3HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLCOLOR4HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue, GLhalfNV alpha); }
{////typedef void (P PFNGLCOLOR4HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLTEXCOORD1HNVPROC) (GLhalfNV s); }
{////typedef void (P PFNGLTEXCOORD1HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLTEXCOORD2HNVPROC) (GLhalfNV s, GLhalfNV t); }
{////typedef void (P PFNGLTEXCOORD2HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLTEXCOORD3HNVPROC) (GLhalfNV s, GLhalfNV t, GLhalfNV r); }
{////typedef void (P PFNGLTEXCOORD3HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLTEXCOORD4HNVPROC) (GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q); }
{////typedef void (P PFNGLTEXCOORD4HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLMULTITEXCOORD1HNVPROC) (GLenum target, GLhalfNV s); }
{////typedef void (P PFNGLMULTITEXCOORD1HVNVPROC) (GLenum target, const GLhalfNV *v); }
{////typedef void (P PFNGLMULTITEXCOORD2HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t); }
{////typedef void (P PFNGLMULTITEXCOORD2HVNVPROC) (GLenum target, const GLhalfNV *v); }
{////typedef void (P PFNGLMULTITEXCOORD3HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r); }
{////typedef void (P PFNGLMULTITEXCOORD3HVNVPROC) (GLenum target, const GLhalfNV *v); }
{////typedef void (P PFNGLMULTITEXCOORD4HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q); }
{////typedef void (P PFNGLMULTITEXCOORD4HVNVPROC) (GLenum target, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIB1HNVPROC) (GLuint index, GLhalfNV x); }
{////typedef void (P PFNGLVERTEXATTRIB1HVNVPROC) (GLuint index, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIB2HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y); }
{////typedef void (P PFNGLVERTEXATTRIB2HVNVPROC) (GLuint index, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIB3HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z); }
{////typedef void (P PFNGLVERTEXATTRIB3HVNVPROC) (GLuint index, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIB4HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w); }
{////typedef void (P PFNGLVERTEXATTRIB4HVNVPROC) (GLuint index, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIBS1HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIBS2HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIBS3HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXATTRIBS4HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v); }
{////typedef void (P PFNGLFOGCOORDHNVPROC) (GLhalfNV fog); }
{////typedef void (P PFNGLFOGCOORDHVNVPROC) (const GLhalfNV *fog); }
{////typedef void (P PFNGLSECONDARYCOLOR3HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue); }
{////typedef void (P PFNGLSECONDARYCOLOR3HVNVPROC) (const GLhalfNV *v); }
{////typedef void (P PFNGLVERTEXWEIGHTHNVPROC) (GLhalfNV weight); }
{////typedef void (P PFNGLVERTEXWEIGHTHVNVPROC) (const GLhalfNV *weight); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertex2hNV(x:TGLhalfNV; y:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertex2hvNV(v:PGLhalfNV);cdecl;external;
procedure glVertex3hNV(x:TGLhalfNV; y:TGLhalfNV; z:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertex3hvNV(v:PGLhalfNV);cdecl;external;
procedure glVertex4hNV(x:TGLhalfNV; y:TGLhalfNV; z:TGLhalfNV; w:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertex4hvNV(v:PGLhalfNV);cdecl;external;
procedure glNormal3hNV(nx:TGLhalfNV; ny:TGLhalfNV; nz:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glNormal3hvNV(v:PGLhalfNV);cdecl;external;
procedure glColor3hNV(red:TGLhalfNV; green:TGLhalfNV; blue:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glColor3hvNV(v:PGLhalfNV);cdecl;external;
procedure glColor4hNV(red:TGLhalfNV; green:TGLhalfNV; blue:TGLhalfNV; alpha:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glColor4hvNV(v:PGLhalfNV);cdecl;external;
procedure glTexCoord1hNV(s:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord1hvNV(v:PGLhalfNV);cdecl;external;
procedure glTexCoord2hNV(s:TGLhalfNV; t:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord2hvNV(v:PGLhalfNV);cdecl;external;
procedure glTexCoord3hNV(s:TGLhalfNV; t:TGLhalfNV; r:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord3hvNV(v:PGLhalfNV);cdecl;external;
procedure glTexCoord4hNV(s:TGLhalfNV; t:TGLhalfNV; r:TGLhalfNV; q:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glTexCoord4hvNV(v:PGLhalfNV);cdecl;external;
procedure glMultiTexCoord1hNV(target:TGLenum; s:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord1hvNV(target:TGLenum; v:PGLhalfNV);cdecl;external;
procedure glMultiTexCoord2hNV(target:TGLenum; s:TGLhalfNV; t:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord2hvNV(target:TGLenum; v:PGLhalfNV);cdecl;external;
procedure glMultiTexCoord3hNV(target:TGLenum; s:TGLhalfNV; t:TGLhalfNV; r:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord3hvNV(target:TGLenum; v:PGLhalfNV);cdecl;external;
procedure glMultiTexCoord4hNV(target:TGLenum; s:TGLhalfNV; t:TGLhalfNV; r:TGLhalfNV; q:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glMultiTexCoord4hvNV(target:TGLenum; v:PGLhalfNV);cdecl;external;
procedure glVertexAttrib1hNV(index:TGLuint; x:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1hvNV(index:TGLuint; v:PGLhalfNV);cdecl;external;
procedure glVertexAttrib2hNV(index:TGLuint; x:TGLhalfNV; y:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2hvNV(index:TGLuint; v:PGLhalfNV);cdecl;external;
procedure glVertexAttrib3hNV(index:TGLuint; x:TGLhalfNV; y:TGLhalfNV; z:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3hvNV(index:TGLuint; v:PGLhalfNV);cdecl;external;
procedure glVertexAttrib4hNV(index:TGLuint; x:TGLhalfNV; y:TGLhalfNV; z:TGLhalfNV; w:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4hvNV(index:TGLuint; v:PGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs1hvNV(index:TGLuint; n:TGLsizei; v:PGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs2hvNV(index:TGLuint; n:TGLsizei; v:PGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs3hvNV(index:TGLuint; n:TGLsizei; v:PGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs4hvNV(index:TGLuint; n:TGLsizei; v:PGLhalfNV);cdecl;external;
procedure glFogCoordhNV(fog:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glFogCoordhvNV(fog:PGLhalfNV);cdecl;external;
procedure glSecondaryColor3hNV(red:TGLhalfNV; green:TGLhalfNV; blue:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glSecondaryColor3hvNV(v:PGLhalfNV);cdecl;external;
procedure glVertexWeighthNV(weight:TGLhalfNV);cdecl;external;
(* Const before type ignored *)
procedure glVertexWeighthvNV(weight:PGLhalfNV);cdecl;external;
{////#endif }
{////#endif /* GL_NV_half_float */ }
{////#ifndef GL_NV_internalformat_sample_query }
const
  GL_NV_internalformat_sample_query = 1;  
  GL_MULTISAMPLES_NV = $9371;  
  GL_SUPERSAMPLE_SCALE_X_NV = $9372;  
  GL_SUPERSAMPLE_SCALE_Y_NV = $9373;  
  GL_CONFORMANT_NV = $9374;  
{////typedef void (P PFNGLGETINTERNALFORMATSAMPLEIVNVPROC) (GLenum target, GLenum internalformat, GLsizei samples, GLenum pname, GLsizei count, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetInternalformatSampleivNV(target:TGLenum; internalformat:TGLenum; samples:TGLsizei; pname:TGLenum; count:TGLsizei; 
            params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_internalformat_sample_query */ }
{////#ifndef GL_NV_light_max_exponent }
const
  GL_NV_light_max_exponent = 1;  
  GL_MAX_SHININESS_NV = $8504;  
  GL_MAX_SPOT_EXPONENT_NV = $8505;  
{////#endif /* GL_NV_light_max_exponent */ }
{////#ifndef GL_NV_memory_attachment }
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
{////typedef void (P PFNGLGETMEMORYOBJECTDETACHEDRESOURCESUIVNVPROC) (GLuint memory, GLenum pname, GLint first, GLsizei count, GLuint *params); }
{////typedef void (P PFNGLRESETMEMORYOBJECTPARAMETERNVPROC) (GLuint memory, GLenum pname); }
{////typedef void (P PFNGLTEXATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLBUFFERATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLTEXTUREATTACHMEMORYNVPROC) (GLuint texture, GLuint memory, GLuint64 offset); }
{////typedef void (P PFNGLNAMEDBUFFERATTACHMEMORYNVPROC) (GLuint buffer, GLuint memory, GLuint64 offset); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetMemoryObjectDetachedResourcesuivNV(memory:TGLuint; pname:TGLenum; first:TGLint; count:TGLsizei; params:PGLuint);cdecl;external;
procedure glResetMemoryObjectParameterNV(memory:TGLuint; pname:TGLenum);cdecl;external;
procedure glTexAttachMemoryNV(target:TGLenum; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glBufferAttachMemoryNV(target:TGLenum; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glTextureAttachMemoryNV(texture:TGLuint; memory:TGLuint; offset:TGLuint64);cdecl;external;
procedure glNamedBufferAttachMemoryNV(buffer:TGLuint; memory:TGLuint; offset:TGLuint64);cdecl;external;
{////#endif }
{////#endif /* GL_NV_memory_attachment */ }
{////#ifndef GL_NV_memory_object_sparse }
const
  GL_NV_memory_object_sparse = 1;  
{////typedef void (P PFNGLBUFFERPAGECOMMITMENTMEMNVPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit); }
{////typedef void (P PFNGLTEXPAGECOMMITMENTMEMNVPROC) (GLenum target, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit); }
{////typedef void (P PFNGLNAMEDBUFFERPAGECOMMITMENTMEMNVPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit); }
{////typedef void (P PFNGLTEXTUREPAGECOMMITMENTMEMNVPROC) (GLuint texture, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBufferPageCommitmentMemNV(target:TGLenum; offset:TGLintptr; size:TGLsizeiptr; memory:TGLuint; memOffset:TGLuint64; 
            commit:TGLboolean);cdecl;external;
procedure glTexPageCommitmentMemNV(target:TGLenum; layer:TGLint; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; memory:TGLuint; 
            offset:TGLuint64; commit:TGLboolean);cdecl;external;
procedure glNamedBufferPageCommitmentMemNV(buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr; memory:TGLuint; memOffset:TGLuint64; 
            commit:TGLboolean);cdecl;external;
procedure glTexturePageCommitmentMemNV(texture:TGLuint; layer:TGLint; level:TGLint; xoffset:TGLint; yoffset:TGLint; 
            zoffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; memory:TGLuint; 
            offset:TGLuint64; commit:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_NV_memory_object_sparse */ }
{////#ifndef GL_NV_mesh_shader }
const
  GL_NV_mesh_shader = 1;  
  GL_MESH_SHADER_NV = $9559;  
  GL_TASK_SHADER_NV = $955A;  
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
  GL_MAX_MESH_WORK_GROUP_INVOCATIONS_NV = $95A2;  
  GL_MAX_TASK_WORK_GROUP_INVOCATIONS_NV = $95A3;  
  GL_MAX_MESH_TOTAL_MEMORY_SIZE_NV = $9536;  
  GL_MAX_TASK_TOTAL_MEMORY_SIZE_NV = $9537;  
  GL_MAX_MESH_OUTPUT_VERTICES_NV = $9538;  
  GL_MAX_MESH_OUTPUT_PRIMITIVES_NV = $9539;  
  GL_MAX_TASK_OUTPUT_COUNT_NV = $953A;  
  GL_MAX_DRAW_MESH_TASKS_COUNT_NV = $953D;  
  GL_MAX_MESH_VIEWS_NV = $9557;  
  GL_MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = $92DF;  
  GL_MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = $9543;  
  GL_MAX_MESH_WORK_GROUP_SIZE_NV = $953B;  
  GL_MAX_TASK_WORK_GROUP_SIZE_NV = $953C;  
  GL_MESH_WORK_GROUP_SIZE_NV = $953E;  
  GL_TASK_WORK_GROUP_SIZE_NV = $953F;  
  GL_MESH_VERTICES_OUT_NV = $9579;  
  GL_MESH_PRIMITIVES_OUT_NV = $957A;  
  GL_MESH_OUTPUT_TYPE_NV = $957B;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = $959C;  
  GL_UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = $959D;  
  GL_REFERENCED_BY_MESH_SHADER_NV = $95A0;  
  GL_REFERENCED_BY_TASK_SHADER_NV = $95A1;  
  GL_MESH_SHADER_BIT_NV = $00000040;  
  GL_TASK_SHADER_BIT_NV = $00000080;  
  GL_MESH_SUBROUTINE_NV = $957C;  
  GL_TASK_SUBROUTINE_NV = $957D;  
  GL_MESH_SUBROUTINE_UNIFORM_NV = $957E;  
  GL_TASK_SUBROUTINE_UNIFORM_NV = $957F;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = $959E;  
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = $959F;  
{////typedef void (P PFNGLDRAWMESHTASKSNVPROC) (GLuint first, GLuint count); }
{////typedef void (P PFNGLDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect); }
{////typedef void (P PFNGLMULTIDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect, GLsizei drawcount, GLsizei stride); }
{////typedef void (P PFNGLMULTIDRAWMESHTASKSINDIRECTCOUNTNVPROC) (GLintptr indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawMeshTasksNV(first:TGLuint; count:TGLuint);cdecl;external;
procedure glDrawMeshTasksIndirectNV(indirect:TGLintptr);cdecl;external;
procedure glMultiDrawMeshTasksIndirectNV(indirect:TGLintptr; drawcount:TGLsizei; stride:TGLsizei);cdecl;external;
procedure glMultiDrawMeshTasksIndirectCountNV(indirect:TGLintptr; drawcount:TGLintptr; maxdrawcount:TGLsizei; stride:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_NV_mesh_shader */ }
{////#ifndef GL_NV_multisample_coverage }
const
  GL_NV_multisample_coverage = 1;  
{////#endif /* GL_NV_multisample_coverage */ }
{////#ifndef GL_NV_multisample_filter_hint }
  GL_NV_multisample_filter_hint = 1;  
  GL_MULTISAMPLE_FILTER_HINT_NV = $8534;  
{////#endif /* GL_NV_multisample_filter_hint */ }
{////#ifndef GL_NV_occlusion_query }
  GL_NV_occlusion_query = 1;  
  GL_PIXEL_COUNTER_BITS_NV = $8864;  
  GL_CURRENT_OCCLUSION_QUERY_ID_NV = $8865;  
  GL_PIXEL_COUNT_NV = $8866;  
  GL_PIXEL_COUNT_AVAILABLE_NV = $8867;  
{////typedef void (P PFNGLGENOCCLUSIONQUERIESNVPROC) (GLsizei n, GLuint *ids); }
{////typedef void (P PFNGLDELETEOCCLUSIONQUERIESNVPROC) (GLsizei n, const GLuint *ids); }
{////typedef GLboolean (P PFNGLISOCCLUSIONQUERYNVPROC) (GLuint id); }
{////typedef void (P PFNGLBEGINOCCLUSIONQUERYNVPROC) (GLuint id); }
{////typedef void (P PFNGLENDOCCLUSIONQUERYNVPROC) (void); }
{////typedef void (P PFNGLGETOCCLUSIONQUERYIVNVPROC) (GLuint id, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETOCCLUSIONQUERYUIVNVPROC) (GLuint id, GLenum pname, GLuint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenOcclusionQueriesNV(n:TGLsizei; ids:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteOcclusionQueriesNV(n:TGLsizei; ids:PGLuint);cdecl;external;
function glIsOcclusionQueryNV(id:TGLuint):TGLboolean;cdecl;external;
procedure glBeginOcclusionQueryNV(id:TGLuint);cdecl;external;
procedure glEndOcclusionQueryNV;cdecl;external;
procedure glGetOcclusionQueryivNV(id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetOcclusionQueryuivNV(id:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_occlusion_query */ }
{////#ifndef GL_NV_packed_depth_stencil }
const
  GL_NV_packed_depth_stencil = 1;  
  GL_DEPTH_STENCIL_NV = $84F9;  
  GL_UNSIGNED_INT_24_8_NV = $84FA;  
{////#endif /* GL_NV_packed_depth_stencil */ }
{////#ifndef GL_NV_parameter_buffer_object }
  GL_NV_parameter_buffer_object = 1;  
  GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = $8DA0;  
  GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = $8DA1;  
  GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = $8DA2;  
  GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = $8DA3;  
  GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = $8DA4;  
{////typedef void (P PFNGLPROGRAMBUFFERPARAMETERSFVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLfloat *params); }
{////typedef void (P PFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLint *params); }
{////typedef void (P PFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLuint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glProgramBufferParametersfvNV(target:TGLenum; bindingIndex:TGLuint; wordIndex:TGLuint; count:TGLsizei; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramBufferParametersIivNV(target:TGLenum; bindingIndex:TGLuint; wordIndex:TGLuint; count:TGLsizei; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glProgramBufferParametersIuivNV(target:TGLenum; bindingIndex:TGLuint; wordIndex:TGLuint; count:TGLsizei; params:PGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_parameter_buffer_object */ }
{////#ifndef GL_NV_parameter_buffer_object2 }
const
  GL_NV_parameter_buffer_object2 = 1;  
{////#endif /* GL_NV_parameter_buffer_object2 */ }
{////#ifndef GL_NV_path_rendering }
  GL_NV_path_rendering = 1;  
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
  GL_ACCUM_ADJACENT_PAIRS_NV = $90AD;  
  GL_ADJACENT_PAIRS_NV = $90AE;  
  GL_FIRST_TO_REST_NV = $90AF;  
  GL_PATH_GEN_MODE_NV = $90B0;  
  GL_PATH_GEN_COEFF_NV = $90B1;  
  GL_PATH_GEN_COMPONENTS_NV = $90B3;  
  GL_PATH_STENCIL_FUNC_NV = $90B7;  
  GL_PATH_STENCIL_REF_NV = $90B8;  
  GL_PATH_STENCIL_VALUE_MASK_NV = $90B9;  
  GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = $90BD;  
  GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = $90BE;  
  GL_PATH_COVER_DEPTH_FUNC_NV = $90BF;  
  GL_PATH_DASH_OFFSET_RESET_NV = $90B4;  
  GL_MOVE_TO_RESETS_NV = $90B5;  
  GL_MOVE_TO_CONTINUES_NV = $90B6;  
  GL_CLOSE_PATH_NV = $00;  
  GL_MOVE_TO_NV = $02;  
  GL_RELATIVE_MOVE_TO_NV = $03;  
  GL_LINE_TO_NV = $04;  
  GL_RELATIVE_LINE_TO_NV = $05;  
  GL_HORIZONTAL_LINE_TO_NV = $06;  
  GL_RELATIVE_HORIZONTAL_LINE_TO_NV = $07;  
  GL_VERTICAL_LINE_TO_NV = $08;  
  GL_RELATIVE_VERTICAL_LINE_TO_NV = $09;  
  GL_QUADRATIC_CURVE_TO_NV = $0A;  
  GL_RELATIVE_QUADRATIC_CURVE_TO_NV = $0B;  
  GL_CUBIC_CURVE_TO_NV = $0C;  
  GL_RELATIVE_CUBIC_CURVE_TO_NV = $0D;  
  GL_SMOOTH_QUADRATIC_CURVE_TO_NV = $0E;  
  GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = $0F;  
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
  GL_RESTART_PATH_NV = $F0;  
  GL_DUP_FIRST_CUBIC_CURVE_TO_NV = $F2;  
  GL_DUP_LAST_CUBIC_CURVE_TO_NV = $F4;  
  GL_RECT_NV = $F6;  
  GL_CIRCULAR_CCW_ARC_TO_NV = $F8;  
  GL_CIRCULAR_CW_ARC_TO_NV = $FA;  
  GL_CIRCULAR_TANGENT_ARC_TO_NV = $FC;  
  GL_ARC_TO_NV = $FE;  
  GL_RELATIVE_ARC_TO_NV = $FF;  
  GL_BOLD_BIT_NV = $01;  
  GL_ITALIC_BIT_NV = $02;  
  GL_GLYPH_WIDTH_BIT_NV = $01;  
  GL_GLYPH_HEIGHT_BIT_NV = $02;  
  GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = $04;  
  GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = $08;  
  GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = $10;  
  GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = $20;  
  GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = $40;  
  GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = $80;  
  GL_GLYPH_HAS_KERNING_BIT_NV = $100;  
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
  GL_ROUNDED_RECT_NV = $E8;  
  GL_RELATIVE_ROUNDED_RECT_NV = $E9;  
  GL_ROUNDED_RECT2_NV = $EA;  
  GL_RELATIVE_ROUNDED_RECT2_NV = $EB;  
  GL_ROUNDED_RECT4_NV = $EC;  
  GL_RELATIVE_ROUNDED_RECT4_NV = $ED;  
  GL_ROUNDED_RECT8_NV = $EE;  
  GL_RELATIVE_ROUNDED_RECT8_NV = $EF;  
  GL_RELATIVE_RECT_NV = $F7;  
  GL_FONT_GLYPHS_AVAILABLE_NV = $9368;  
  GL_FONT_TARGET_UNAVAILABLE_NV = $9369;  
  GL_FONT_UNAVAILABLE_NV = $936A;  
  GL_FONT_UNINTELLIGIBLE_NV = $936B;  
  GL_CONIC_CURVE_TO_NV = $1A;  
  GL_RELATIVE_CONIC_CURVE_TO_NV = $1B;  
  GL_FONT_NUM_GLYPH_INDICES_BIT_NV = $20000000;  
  GL_STANDARD_FONT_FORMAT_NV = $936C;  
  GL_2_BYTES_NV = $1407;  
  GL_3_BYTES_NV = $1408;  
  GL_4_BYTES_NV = $1409;  
  GL_EYE_LINEAR_NV = $2400;  
  GL_OBJECT_LINEAR_NV = $2401;  
  GL_CONSTANT_NV = $8576;  
  GL_PATH_FOG_GEN_MODE_NV = $90AC;  
  GL_PRIMARY_COLOR_NV = $852C;  
  GL_SECONDARY_COLOR_NV = $852D;  
  GL_PATH_GEN_COLOR_FORMAT_NV = $90B2;  
  GL_PATH_PROJECTION_NV = $1701;  
  GL_PATH_MODELVIEW_NV = $1700;  
  GL_PATH_MODELVIEW_STACK_DEPTH_NV = $0BA3;  
  GL_PATH_MODELVIEW_MATRIX_NV = $0BA6;  
  GL_PATH_MAX_MODELVIEW_STACK_DEPTH_NV = $0D36;  
  GL_PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = $84E3;  
  GL_PATH_PROJECTION_STACK_DEPTH_NV = $0BA4;  
  GL_PATH_PROJECTION_MATRIX_NV = $0BA7;  
  GL_PATH_MAX_PROJECTION_STACK_DEPTH_NV = $0D38;  
  GL_PATH_TRANSPOSE_PROJECTION_MATRIX_NV = $84E4;  
  GL_FRAGMENT_INPUT_NV = $936D;  
{////typedef GLuint (P PFNGLGENPATHSNVPROC) (GLsizei range); }
{////typedef void (P PFNGLDELETEPATHSNVPROC) (GLuint path, GLsizei range); }
{////typedef GLboolean (P PFNGLISPATHNVPROC) (GLuint path); }
{////typedef void (P PFNGLPATHCOMMANDSNVPROC) (GLuint path, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords); }
{////typedef void (P PFNGLPATHCOORDSNVPROC) (GLuint path, GLsizei numCoords, GLenum coordType, const void *coords); }
{////typedef void (P PFNGLPATHSUBCOMMANDSNVPROC) (GLuint path, GLsizei commandStart, GLsizei commandsToDelete, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords); }
{////typedef void (P PFNGLPATHSUBCOORDSNVPROC) (GLuint path, GLsizei coordStart, GLsizei numCoords, GLenum coordType, const void *coords); }
{////typedef void (P PFNGLPATHSTRINGNVPROC) (GLuint path, GLenum format, GLsizei length, const void *pathString); }
{////typedef void (P PFNGLPATHGLYPHSNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLsizei numGlyphs, GLenum type, const void *charcodes, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale); }
{////typedef void (P PFNGLPATHGLYPHRANGENVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyph, GLsizei numGlyphs, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale); }
{////typedef void (P PFNGLWEIGHTPATHSNVPROC) (GLuint resultPath, GLsizei numPaths, const GLuint *paths, const GLfloat *weights); }
{////typedef void (P PFNGLCOPYPATHNVPROC) (GLuint resultPath, GLuint srcPath); }
{////typedef void (P PFNGLINTERPOLATEPATHSNVPROC) (GLuint resultPath, GLuint pathA, GLuint pathB, GLfloat weight); }
{////typedef void (P PFNGLTRANSFORMPATHNVPROC) (GLuint resultPath, GLuint srcPath, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, const GLint *value); }
{////typedef void (P PFNGLPATHPARAMETERINVPROC) (GLuint path, GLenum pname, GLint value); }
{////typedef void (P PFNGLPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, const GLfloat *value); }
{////typedef void (P PFNGLPATHPARAMETERFNVPROC) (GLuint path, GLenum pname, GLfloat value); }
{////typedef void (P PFNGLPATHDASHARRAYNVPROC) (GLuint path, GLsizei dashCount, const GLfloat *dashArray); }
{////typedef void (P PFNGLPATHSTENCILFUNCNVPROC) (GLenum func, GLint ref, GLuint mask); }
{////typedef void (P PFNGLPATHSTENCILDEPTHOFFSETNVPROC) (GLfloat factor, GLfloat units); }
{////typedef void (P PFNGLSTENCILFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask); }
{////typedef void (P PFNGLSTENCILSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask); }
{////typedef void (P PFNGLSTENCILFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLSTENCILSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLPATHCOVERDEPTHFUNCNVPROC) (GLenum func); }
{////typedef void (P PFNGLCOVERFILLPATHNVPROC) (GLuint path, GLenum coverMode); }
{////typedef void (P PFNGLCOVERSTROKEPATHNVPROC) (GLuint path, GLenum coverMode); }
{////typedef void (P PFNGLCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLGETPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, GLint *value); }
{////typedef void (P PFNGLGETPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, GLfloat *value); }
{////typedef void (P PFNGLGETPATHCOMMANDSNVPROC) (GLuint path, GLubyte *commands); }
{////typedef void (P PFNGLGETPATHCOORDSNVPROC) (GLuint path, GLfloat *coords); }
{////typedef void (P PFNGLGETPATHDASHARRAYNVPROC) (GLuint path, GLfloat *dashArray); }
{////typedef void (P PFNGLGETPATHMETRICSNVPROC) (GLbitfield metricQueryMask, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLsizei stride, GLfloat *metrics); }
{////typedef void (P PFNGLGETPATHMETRICRANGENVPROC) (GLbitfield metricQueryMask, GLuint firstPathName, GLsizei numPaths, GLsizei stride, GLfloat *metrics); }
{////typedef void (P PFNGLGETPATHSPACINGNVPROC) (GLenum pathListMode, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLfloat advanceScale, GLfloat kerningScale, GLenum transformType, GLfloat *returnedSpacing); }
{////typedef GLboolean (P PFNGLISPOINTINFILLPATHNVPROC) (GLuint path, GLuint mask, GLfloat x, GLfloat y); }
{////typedef GLboolean (P PFNGLISPOINTINSTROKEPATHNVPROC) (GLuint path, GLfloat x, GLfloat y); }
{////typedef GLfloat (P PFNGLGETPATHLENGTHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments); }
{////typedef GLboolean (P PFNGLPOINTALONGPATHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments, GLfloat distance, GLfloat *x, GLfloat *y, GLfloat *tangentX, GLfloat *tangentY); }
{////typedef void (P PFNGLMATRIXLOAD3X2FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXLOAD3X3FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXLOADTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXMULT3X2FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXMULT3X3FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLMATRIXMULTTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m); }
{////typedef void (P PFNGLSTENCILTHENCOVERFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask, GLenum coverMode); }
{////typedef void (P PFNGLSTENCILTHENCOVERSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask, GLenum coverMode); }
{////typedef void (P PFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues); }
{////typedef void (P PFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues); }
{////typedef GLenum (P PFNGLPATHGLYPHINDEXRANGENVPROC) (GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint pathParameterTemplate, GLfloat emScale, GLuint *baseAndCount); }
{////typedef GLenum (P PFNGLPATHGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale); }
{////typedef GLenum (P PFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, GLsizeiptr fontSize, const void *fontData, GLsizei faceIndex, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale); }
{////typedef void (P PFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC) (GLuint program_, GLint location, GLenum genMode, GLint components, const GLfloat *coeffs); }
{////typedef void (P PFNGLGETPROGRAMRESOURCEFVNVPROC) (GLuint program_, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLfloat *params); }
{////typedef void (P PFNGLPATHCOLORGENNVPROC) (GLenum color, GLenum genMode, GLenum colorFormat, const GLfloat *coeffs); }
{////typedef void (P PFNGLPATHTEXGENNVPROC) (GLenum texCoordSet, GLenum genMode, GLint components, const GLfloat *coeffs); }
{////typedef void (P PFNGLPATHFOGGENNVPROC) (GLenum genMode); }
{////typedef void (P PFNGLGETPATHCOLORGENIVNVPROC) (GLenum color, GLenum pname, GLint *value); }
{////typedef void (P PFNGLGETPATHCOLORGENFVNVPROC) (GLenum color, GLenum pname, GLfloat *value); }
{////typedef void (P PFNGLGETPATHTEXGENIVNVPROC) (GLenum texCoordSet, GLenum pname, GLint *value); }
{////typedef void (P PFNGLGETPATHTEXGENFVNVPROC) (GLenum texCoordSet, GLenum pname, GLfloat *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGenPathsNV(range:TGLsizei):TGLuint;cdecl;external;
procedure glDeletePathsNV(path:TGLuint; range:TGLsizei);cdecl;external;
function glIsPathNV(path:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glPathCommandsNV(path:TGLuint; numCommands:TGLsizei; commands:PGLubyte; numCoords:TGLsizei; coordType:TGLenum; 
            coords:pointer);cdecl;external;
(* Const before type ignored *)
procedure glPathCoordsNV(path:TGLuint; numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glPathSubCommandsNV(path:TGLuint; commandStart:TGLsizei; commandsToDelete:TGLsizei; numCommands:TGLsizei; commands:PGLubyte; 
            numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;external;
(* Const before type ignored *)
procedure glPathSubCoordsNV(path:TGLuint; coordStart:TGLsizei; numCoords:TGLsizei; coordType:TGLenum; coords:pointer);cdecl;external;
(* Const before type ignored *)
procedure glPathStringNV(path:TGLuint; format:TGLenum; length:TGLsizei; pathString:pointer);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glPathGlyphsNV(firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; numGlyphs:TGLsizei; 
            _type:TGLenum; charcodes:pointer; handleMissingGlyphs:TGLenum; pathParameterTemplate:TGLuint; emScale:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPathGlyphRangeNV(firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; firstGlyph:TGLuint; 
            numGlyphs:TGLsizei; handleMissingGlyphs:TGLenum; pathParameterTemplate:TGLuint; emScale:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glWeightPathsNV(resultPath:TGLuint; numPaths:TGLsizei; paths:PGLuint; weights:PGLfloat);cdecl;external;
procedure glCopyPathNV(resultPath:TGLuint; srcPath:TGLuint);cdecl;external;
procedure glInterpolatePathsNV(resultPath:TGLuint; pathA:TGLuint; pathB:TGLuint; weight:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glTransformPathNV(resultPath:TGLuint; srcPath:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPathParameterivNV(path:TGLuint; pname:TGLenum; value:PGLint);cdecl;external;
procedure glPathParameteriNV(path:TGLuint; pname:TGLenum; value:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glPathParameterfvNV(path:TGLuint; pname:TGLenum; value:PGLfloat);cdecl;external;
procedure glPathParameterfNV(path:TGLuint; pname:TGLenum; value:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPathDashArrayNV(path:TGLuint; dashCount:TGLsizei; dashArray:PGLfloat);cdecl;external;
procedure glPathStencilFuncNV(func:TGLenum; ref:TGLint; mask:TGLuint);cdecl;external;
procedure glPathStencilDepthOffsetNV(factor:TGLfloat; units:TGLfloat);cdecl;external;
procedure glStencilFillPathNV(path:TGLuint; fillMode:TGLenum; mask:TGLuint);cdecl;external;
procedure glStencilStrokePathNV(path:TGLuint; reference:TGLint; mask:TGLuint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glStencilFillPathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; fillMode:TGLenum; 
            mask:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glStencilStrokePathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; reference:TGLint; 
            mask:TGLuint; transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
procedure glPathCoverDepthFuncNV(func:TGLenum);cdecl;external;
procedure glCoverFillPathNV(path:TGLuint; coverMode:TGLenum);cdecl;external;
procedure glCoverStrokePathNV(path:TGLuint; coverMode:TGLenum);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glCoverFillPathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; coverMode:TGLenum; 
            transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glCoverStrokePathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; coverMode:TGLenum; 
            transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
procedure glGetPathParameterivNV(path:TGLuint; pname:TGLenum; value:PGLint);cdecl;external;
procedure glGetPathParameterfvNV(path:TGLuint; pname:TGLenum; value:PGLfloat);cdecl;external;
procedure glGetPathCommandsNV(path:TGLuint; commands:PGLubyte);cdecl;external;
procedure glGetPathCoordsNV(path:TGLuint; coords:PGLfloat);cdecl;external;
procedure glGetPathDashArrayNV(path:TGLuint; dashArray:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glGetPathMetricsNV(metricQueryMask:TGLbitfield; numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; 
            stride:TGLsizei; metrics:PGLfloat);cdecl;external;
procedure glGetPathMetricRangeNV(metricQueryMask:TGLbitfield; firstPathName:TGLuint; numPaths:TGLsizei; stride:TGLsizei; metrics:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glGetPathSpacingNV(pathListMode:TGLenum; numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; 
            advanceScale:TGLfloat; kerningScale:TGLfloat; transformType:TGLenum; returnedSpacing:PGLfloat);cdecl;external;
function glIsPointInFillPathNV(path:TGLuint; mask:TGLuint; x:TGLfloat; y:TGLfloat):TGLboolean;cdecl;external;
function glIsPointInStrokePathNV(path:TGLuint; x:TGLfloat; y:TGLfloat):TGLboolean;cdecl;external;
function glGetPathLengthNV(path:TGLuint; startSegment:TGLsizei; numSegments:TGLsizei):TGLfloat;cdecl;external;
function glPointAlongPathNV(path:TGLuint; startSegment:TGLsizei; numSegments:TGLsizei; distance:TGLfloat; x:PGLfloat; 
           y:PGLfloat; tangentX:PGLfloat; tangentY:PGLfloat):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoad3x2fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoad3x3fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixLoadTranspose3x3fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMult3x2fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMult3x3fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glMatrixMultTranspose3x3fNV(matrixMode:TGLenum; m:PGLfloat);cdecl;external;
procedure glStencilThenCoverFillPathNV(path:TGLuint; fillMode:TGLenum; mask:TGLuint; coverMode:TGLenum);cdecl;external;
procedure glStencilThenCoverStrokePathNV(path:TGLuint; reference:TGLint; mask:TGLuint; coverMode:TGLenum);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glStencilThenCoverFillPathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; fillMode:TGLenum; 
            mask:TGLuint; coverMode:TGLenum; transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glStencilThenCoverStrokePathInstancedNV(numPaths:TGLsizei; pathNameType:TGLenum; paths:pointer; pathBase:TGLuint; reference:TGLint; 
            mask:TGLuint; coverMode:TGLenum; transformType:TGLenum; transformValues:PGLfloat);cdecl;external;
(* Const before type ignored *)
function glPathGlyphIndexRangeNV(fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; pathParameterTemplate:TGLuint; emScale:TGLfloat; 
           baseAndCount:PGLuint):TGLenum;cdecl;external;
(* Const before type ignored *)
function glPathGlyphIndexArrayNV(firstPathName:TGLuint; fontTarget:TGLenum; fontName:pointer; fontStyle:TGLbitfield; firstGlyphIndex:TGLuint; 
           numGlyphs:TGLsizei; pathParameterTemplate:TGLuint; emScale:TGLfloat):TGLenum;cdecl;external;
(* Const before type ignored *)
function glPathMemoryGlyphIndexArrayNV(firstPathName:TGLuint; fontTarget:TGLenum; fontSize:TGLsizeiptr; fontData:pointer; faceIndex:TGLsizei; 
           firstGlyphIndex:TGLuint; numGlyphs:TGLsizei; pathParameterTemplate:TGLuint; emScale:TGLfloat):TGLenum;cdecl;external;
(* Const before type ignored *)
procedure glProgramPathFragmentInputGenNV(program_:TGLuint; location:TGLint; genMode:TGLenum; components:TGLint; coeffs:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glGetProgramResourcefvNV(program_:TGLuint; programInterface:TGLenum; index:TGLuint; propCount:TGLsizei; props:PGLenum; 
            count:TGLsizei; length:PGLsizei; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPathColorGenNV(color:TGLenum; genMode:TGLenum; colorFormat:TGLenum; coeffs:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPathTexGenNV(texCoordSet:TGLenum; genMode:TGLenum; components:TGLint; coeffs:PGLfloat);cdecl;external;
procedure glPathFogGenNV(genMode:TGLenum);cdecl;external;
procedure glGetPathColorGenivNV(color:TGLenum; pname:TGLenum; value:PGLint);cdecl;external;
procedure glGetPathColorGenfvNV(color:TGLenum; pname:TGLenum; value:PGLfloat);cdecl;external;
procedure glGetPathTexGenivNV(texCoordSet:TGLenum; pname:TGLenum; value:PGLint);cdecl;external;
procedure glGetPathTexGenfvNV(texCoordSet:TGLenum; pname:TGLenum; value:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_NV_path_rendering */ }
{////#ifndef GL_NV_path_rendering_shared_edge }
const
  GL_NV_path_rendering_shared_edge = 1;  
  GL_SHARED_EDGE_NV = $C0;  
{////#endif /* GL_NV_path_rendering_shared_edge */ }
{////#ifndef GL_NV_pixel_data_range }
  GL_NV_pixel_data_range = 1;  
  GL_WRITE_PIXEL_DATA_RANGE_NV = $8878;  
  GL_READ_PIXEL_DATA_RANGE_NV = $8879;  
  GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = $887A;  
  GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = $887B;  
  GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = $887C;  
  GL_READ_PIXEL_DATA_RANGE_POINTER_NV = $887D;  
{////typedef void (P PFNGLPIXELDATARANGENVPROC) (GLenum target, GLsizei length, const void *pointer); }
{////typedef void (P PFNGLFLUSHPIXELDATARANGENVPROC) (GLenum target); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glPixelDataRangeNV(target:TGLenum; length:TGLsizei; pointer:pointer);cdecl;external;
procedure glFlushPixelDataRangeNV(target:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_pixel_data_range */ }
{////#ifndef GL_NV_point_sprite }
const
  GL_NV_point_sprite = 1;  
  GL_POINT_SPRITE_NV = $8861;  
  GL_COORD_REPLACE_NV = $8862;  
  GL_POINT_SPRITE_R_MODE_NV = $8863;  
{////typedef void (P PFNGLPOINTPARAMETERINVPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLPOINTPARAMETERIVNVPROC) (GLenum pname, const GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPointParameteriNV(pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterivNV(pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_point_sprite */ }
{////#ifndef GL_NV_present_video }
const
  GL_NV_present_video = 1;  
  GL_FRAME_NV = $8E26;  
  GL_FIELDS_NV = $8E27;  
  GL_CURRENT_TIME_NV = $8E28;  
  GL_NUM_FILL_STREAMS_NV = $8E29;  
  GL_PRESENT_TIME_NV = $8E2A;  
  GL_PRESENT_DURATION_NV = $8E2B;  
{////typedef void (P PFNGLPRESENTFRAMEKEYEDNVPROC) (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLuint key0, GLenum target1, GLuint fill1, GLuint key1); }
{////typedef void (P PFNGLPRESENTFRAMEDUALFILLNVPROC) (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLenum target1, GLuint fill1, GLenum target2, GLuint fill2, GLenum target3, GLuint fill3); }
{////typedef void (P PFNGLGETVIDEOIVNVPROC) (GLuint video_slot, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVIDEOUIVNVPROC) (GLuint video_slot, GLenum pname, GLuint *params); }
{////typedef void (P PFNGLGETVIDEOI64VNVPROC) (GLuint video_slot, GLenum pname, GLint64EXT *params); }
{////typedef void (P PFNGLGETVIDEOUI64VNVPROC) (GLuint video_slot, GLenum pname, GLuint64EXT *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPresentFrameKeyedNV(video_slot:TGLuint; minPresentTime:TGLuint64EXT; beginPresentTimeId:TGLuint; presentDurationId:TGLuint; _type:TGLenum; 
            target0:TGLenum; fill0:TGLuint; key0:TGLuint; target1:TGLenum; fill1:TGLuint; 
            key1:TGLuint);cdecl;external;
procedure glPresentFrameDualFillNV(video_slot:TGLuint; minPresentTime:TGLuint64EXT; beginPresentTimeId:TGLuint; presentDurationId:TGLuint; _type:TGLenum; 
            target0:TGLenum; fill0:TGLuint; target1:TGLenum; fill1:TGLuint; target2:TGLenum; 
            fill2:TGLuint; target3:TGLenum; fill3:TGLuint);cdecl;external;
procedure glGetVideoivNV(video_slot:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVideouivNV(video_slot:TGLuint; pname:TGLenum; params:PGLuint);cdecl;external;
procedure glGetVideoi64vNV(video_slot:TGLuint; pname:TGLenum; params:PGLint64EXT);cdecl;external;
procedure glGetVideoui64vNV(video_slot:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;external;
{////#endif }
{////#endif /* GL_NV_present_video */ }
{////#ifndef GL_NV_primitive_restart }
const
  GL_NV_primitive_restart = 1;  
  GL_PRIMITIVE_RESTART_NV = $8558;  
  GL_PRIMITIVE_RESTART_INDEX_NV = $8559;  
{////typedef void (P PFNGLPRIMITIVERESTARTNVPROC) (void); }
{////typedef void (P PFNGLPRIMITIVERESTARTINDEXNVPROC) (GLuint index); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPrimitiveRestartNV;cdecl;external;
procedure glPrimitiveRestartIndexNV(index:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_primitive_restart */ }
{////#ifndef GL_NV_primitive_shading_rate }
const
  GL_NV_primitive_shading_rate = 1;  
  GL_SHADING_RATE_IMAGE_PER_PRIMITIVE_NV = $95B1;  
  GL_SHADING_RATE_IMAGE_PALETTE_COUNT_NV = $95B2;  
{////#endif /* GL_NV_primitive_shading_rate */ }
{////#ifndef GL_NV_query_resource }
  GL_NV_query_resource = 1;  
  GL_QUERY_RESOURCE_TYPE_VIDMEM_ALLOC_NV = $9540;  
  GL_QUERY_RESOURCE_MEMTYPE_VIDMEM_NV = $9542;  
  GL_QUERY_RESOURCE_SYS_RESERVED_NV = $9544;  
  GL_QUERY_RESOURCE_TEXTURE_NV = $9545;  
  GL_QUERY_RESOURCE_RENDERBUFFER_NV = $9546;  
  GL_QUERY_RESOURCE_BUFFEROBJECT_NV = $9547;  
{////typedef GLint (P PFNGLQUERYRESOURCENVPROC) (GLenum queryType, GLint tagId, GLuint count, GLint *buffer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glQueryResourceNV(queryType:TGLenum; tagId:TGLint; count:TGLuint; buffer:PGLint):TGLint;cdecl;external;
{////#endif }
{////#endif /* GL_NV_query_resource */ }
{////#ifndef GL_NV_query_resource_tag }
const
  GL_NV_query_resource_tag = 1;  
{////typedef void (P PFNGLGENQUERYRESOURCETAGNVPROC) (GLsizei n, GLint *tagIds); }
{////typedef void (P PFNGLDELETEQUERYRESOURCETAGNVPROC) (GLsizei n, const GLint *tagIds); }
{////typedef void (P PFNGLQUERYRESOURCETAGNVPROC) (GLint tagId, const GLchar *tagString); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGenQueryResourceTagNV(n:TGLsizei; tagIds:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteQueryResourceTagNV(n:TGLsizei; tagIds:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glQueryResourceTagNV(tagId:TGLint; tagString:PGLchar);cdecl;external;
{////#endif }
{////#endif /* GL_NV_query_resource_tag */ }
{////#ifndef GL_NV_register_combiners }
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
{////typedef void (P PFNGLCOMBINERPARAMETERFVNVPROC) (GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLCOMBINERPARAMETERFNVPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLCOMBINERPARAMETERIVNVPROC) (GLenum pname, const GLint *params); }
{////typedef void (P PFNGLCOMBINERPARAMETERINVPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLCOMBINERINPUTNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage); }
{////typedef void (P PFNGLCOMBINEROUTPUTNVPROC) (GLenum stage, GLenum portion, GLenum abOutput, GLenum cdOutput, GLenum sumOutput, GLenum scale, GLenum bias, GLboolean abDotProduct, GLboolean cdDotProduct, GLboolean muxSum); }
{////typedef void (P PFNGLFINALCOMBINERINPUTNVPROC) (GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage); }
{////typedef void (P PFNGLGETCOMBINERINPUTPARAMETERFVNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCOMBINERINPUTPARAMETERIVNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC) (GLenum stage, GLenum portion, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC) (GLenum stage, GLenum portion, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC) (GLenum variable, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC) (GLenum variable, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glCombinerParameterfvNV(pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glCombinerParameterfNV(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glCombinerParameterivNV(pname:TGLenum; params:PGLint);cdecl;external;
procedure glCombinerParameteriNV(pname:TGLenum; param:TGLint);cdecl;external;
procedure glCombinerInputNV(stage:TGLenum; portion:TGLenum; variable:TGLenum; input:TGLenum; mapping:TGLenum; 
            componentUsage:TGLenum);cdecl;external;
procedure glCombinerOutputNV(stage:TGLenum; portion:TGLenum; abOutput:TGLenum; cdOutput:TGLenum; sumOutput:TGLenum; 
            scale:TGLenum; bias:TGLenum; abDotProduct:TGLboolean; cdDotProduct:TGLboolean; muxSum:TGLboolean);cdecl;external;
procedure glFinalCombinerInputNV(variable:TGLenum; input:TGLenum; mapping:TGLenum; componentUsage:TGLenum);cdecl;external;
procedure glGetCombinerInputParameterfvNV(stage:TGLenum; portion:TGLenum; variable:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetCombinerInputParameterivNV(stage:TGLenum; portion:TGLenum; variable:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetCombinerOutputParameterfvNV(stage:TGLenum; portion:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetCombinerOutputParameterivNV(stage:TGLenum; portion:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetFinalCombinerInputParameterfvNV(variable:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetFinalCombinerInputParameterivNV(variable:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_register_combiners */ }
{////#ifndef GL_NV_register_combiners2 }
const
  GL_NV_register_combiners2 = 1;  
  GL_PER_STAGE_CONSTANTS_NV = $8535;  
{////typedef void (P PFNGLCOMBINERSTAGEPARAMETERFVNVPROC) (GLenum stage, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC) (GLenum stage, GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glCombinerStageParameterfvNV(stage:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetCombinerStageParameterfvNV(stage:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_NV_register_combiners2 */ }
{////#ifndef GL_NV_representative_fragment_test }
const
  GL_NV_representative_fragment_test = 1;  
  GL_REPRESENTATIVE_FRAGMENT_TEST_NV = $937F;  
{////#endif /* GL_NV_representative_fragment_test */ }
{////#ifndef GL_NV_robustness_video_memory_purge }
  GL_NV_robustness_video_memory_purge = 1;  
  GL_PURGED_CONTEXT_RESET_NV = $92BB;  
{////#endif /* GL_NV_robustness_video_memory_purge */ }
{////#ifndef GL_NV_sample_locations }
  GL_NV_sample_locations = 1;  
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = $933D;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = $933E;  
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = $933F;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = $9340;  
  GL_SAMPLE_LOCATION_NV = $8E50;  
  GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9341;  
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = $9342;  
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = $9343;  
{////typedef void (P PFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLRESOLVEDEPTHVALUESNVPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glFramebufferSampleLocationsfvNV(target:TGLenum; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glNamedFramebufferSampleLocationsfvNV(framebuffer:TGLuint; start:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
procedure glResolveDepthValuesNV;cdecl;external;
{////#endif }
{////#endif /* GL_NV_sample_locations */ }
{////#ifndef GL_NV_sample_mask_override_coverage }
const
  GL_NV_sample_mask_override_coverage = 1;  
{////#endif /* GL_NV_sample_mask_override_coverage */ }
{////#ifndef GL_NV_scissor_exclusive }
  GL_NV_scissor_exclusive = 1;  
  GL_SCISSOR_TEST_EXCLUSIVE_NV = $9555;  
  GL_SCISSOR_BOX_EXCLUSIVE_NV = $9556;  
{////typedef void (P PFNGLSCISSOREXCLUSIVENVPROC) (GLint x, GLint y, GLsizei width, GLsizei height); }
{////typedef void (P PFNGLSCISSOREXCLUSIVEARRAYVNVPROC) (GLuint first, GLsizei count, const GLint *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glScissorExclusiveNV(x:TGLint; y:TGLint; width:TGLsizei; height:TGLsizei);cdecl;external;
(* Const before type ignored *)
procedure glScissorExclusiveArrayvNV(first:TGLuint; count:TGLsizei; v:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_scissor_exclusive */ }
{////#ifndef GL_NV_shader_atomic_counters }
const
  GL_NV_shader_atomic_counters = 1;  
{////#endif /* GL_NV_shader_atomic_counters */ }
{////#ifndef GL_NV_shader_atomic_float }
  GL_NV_shader_atomic_float = 1;  
{////#endif /* GL_NV_shader_atomic_float */ }
{////#ifndef GL_NV_shader_atomic_float64 }
  GL_NV_shader_atomic_float64 = 1;  
{////#endif /* GL_NV_shader_atomic_float64 */ }
{////#ifndef GL_NV_shader_atomic_fp16_vector }
  GL_NV_shader_atomic_fp16_vector = 1;  
{////#endif /* GL_NV_shader_atomic_fp16_vector */ }
{////#ifndef GL_NV_shader_atomic_int64 }
  GL_NV_shader_atomic_int64 = 1;  
{////#endif /* GL_NV_shader_atomic_int64 */ }
{////#ifndef GL_NV_shader_buffer_load }
  GL_NV_shader_buffer_load = 1;  
  GL_BUFFER_GPU_ADDRESS_NV = $8F1D;  
  GL_GPU_ADDRESS_NV = $8F34;  
  GL_MAX_SHADER_BUFFER_ADDRESS_NV = $8F35;  
{////typedef void (P PFNGLMAKEBUFFERRESIDENTNVPROC) (GLenum target, GLenum access); }
{////typedef void (P PFNGLMAKEBUFFERNONRESIDENTNVPROC) (GLenum target); }
{////typedef GLboolean (P PFNGLISBUFFERRESIDENTNVPROC) (GLenum target); }
{////typedef void (P PFNGLMAKENAMEDBUFFERRESIDENTNVPROC) (GLuint buffer, GLenum access); }
{////typedef void (P PFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC) (GLuint buffer); }
{////typedef GLboolean (P PFNGLISNAMEDBUFFERRESIDENTNVPROC) (GLuint buffer); }
{////typedef void (P PFNGLGETBUFFERPARAMETERUI64VNVPROC) (GLenum target, GLenum pname, GLuint64EXT *params); }
{////typedef void (P PFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC) (GLuint buffer, GLenum pname, GLuint64EXT *params); }
{////typedef void (P PFNGLGETINTEGERUI64VNVPROC) (GLenum value, GLuint64EXT *result); }
{////typedef void (P PFNGLUNIFORMUI64NVPROC) (GLint location, GLuint64EXT value); }
{////typedef void (P PFNGLUNIFORMUI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value); }
{////typedef void (P PFNGLPROGRAMUNIFORMUI64NVPROC) (GLuint program_, GLint location, GLuint64EXT value); }
{////typedef void (P PFNGLPROGRAMUNIFORMUI64VNVPROC) (GLuint program_, GLint location, GLsizei count, const GLuint64EXT *value); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glMakeBufferResidentNV(target:TGLenum; access:TGLenum);cdecl;external;
procedure glMakeBufferNonResidentNV(target:TGLenum);cdecl;external;
function glIsBufferResidentNV(target:TGLenum):TGLboolean;cdecl;external;
procedure glMakeNamedBufferResidentNV(buffer:TGLuint; access:TGLenum);cdecl;external;
procedure glMakeNamedBufferNonResidentNV(buffer:TGLuint);cdecl;external;
function glIsNamedBufferResidentNV(buffer:TGLuint):TGLboolean;cdecl;external;
procedure glGetBufferParameterui64vNV(target:TGLenum; pname:TGLenum; params:PGLuint64EXT);cdecl;external;
procedure glGetNamedBufferParameterui64vNV(buffer:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;external;
procedure glGetIntegerui64vNV(value:TGLenum; result:PGLuint64EXT);cdecl;external;
procedure glUniformui64NV(location:TGLint; value:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glUniformui64vNV(location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
procedure glProgramUniformui64NV(program_:TGLuint; location:TGLint; value:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glProgramUniformui64vNV(program_:TGLuint; location:TGLint; count:TGLsizei; value:PGLuint64EXT);cdecl;external;
{////#endif }
{////#endif /* GL_NV_shader_buffer_load */ }
{////#ifndef GL_NV_shader_buffer_store }
const
  GL_NV_shader_buffer_store = 1;  
  GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = $00000010;  
{////#endif /* GL_NV_shader_buffer_store */ }
{////#ifndef GL_NV_shader_storage_buffer_object }
  GL_NV_shader_storage_buffer_object = 1;  
{////#endif /* GL_NV_shader_storage_buffer_object */ }
{////#ifndef GL_NV_shader_subgroup_partitioned }
  GL_NV_shader_subgroup_partitioned = 1;  
  GL_SUBGROUP_FEATURE_PARTITIONED_BIT_NV = $00000100;  
{////#endif /* GL_NV_shader_subgroup_partitioned */ }
{////#ifndef GL_NV_shader_texture_footprint }
  GL_NV_shader_texture_footprint = 1;  
{////#endif /* GL_NV_shader_texture_footprint */ }
{////#ifndef GL_NV_shader_thread_group }
  GL_NV_shader_thread_group = 1;  
  GL_WARP_SIZE_NV = $9339;  
  GL_WARPS_PER_SM_NV = $933A;  
  GL_SM_COUNT_NV = $933B;  
{////#endif /* GL_NV_shader_thread_group */ }
{////#ifndef GL_NV_shader_thread_shuffle }
  GL_NV_shader_thread_shuffle = 1;  
{////#endif /* GL_NV_shader_thread_shuffle */ }
{////#ifndef GL_NV_shading_rate_image }
  GL_NV_shading_rate_image = 1;  
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
  GL_SHADING_RATE_IMAGE_BINDING_NV = $955B;  
  GL_SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = $955C;  
  GL_SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = $955D;  
  GL_SHADING_RATE_IMAGE_PALETTE_SIZE_NV = $955E;  
  GL_MAX_COARSE_FRAGMENT_SAMPLES_NV = $955F;  
  GL_SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = $95AE;  
  GL_SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = $95AF;  
  GL_SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = $95B0;  
{////typedef void (P PFNGLBINDSHADINGRATEIMAGENVPROC) (GLuint texture); }
{////typedef void (P PFNGLGETSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint entry, GLenum *rate); }
{////typedef void (P PFNGLGETSHADINGRATESAMPLELOCATIONIVNVPROC) (GLenum rate, GLuint samples, GLuint index, GLint *location); }
{////typedef void (P PFNGLSHADINGRATEIMAGEBARRIERNVPROC) (GLboolean synchronize); }
{////typedef void (P PFNGLSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint first, GLsizei count, const GLenum *rates); }
{////typedef void (P PFNGLSHADINGRATESAMPLEORDERNVPROC) (GLenum order); }
{////typedef void (P PFNGLSHADINGRATESAMPLEORDERCUSTOMNVPROC) (GLenum rate, GLuint samples, const GLint *locations); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBindShadingRateImageNV(texture:TGLuint);cdecl;external;
procedure glGetShadingRateImagePaletteNV(viewport:TGLuint; entry:TGLuint; rate:PGLenum);cdecl;external;
procedure glGetShadingRateSampleLocationivNV(rate:TGLenum; samples:TGLuint; index:TGLuint; location:PGLint);cdecl;external;
procedure glShadingRateImageBarrierNV(synchronize:TGLboolean);cdecl;external;
(* Const before type ignored *)
procedure glShadingRateImagePaletteNV(viewport:TGLuint; first:TGLuint; count:TGLsizei; rates:PGLenum);cdecl;external;
procedure glShadingRateSampleOrderNV(order:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glShadingRateSampleOrderCustomNV(rate:TGLenum; samples:TGLuint; locations:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_shading_rate_image */ }
{////#ifndef GL_NV_stereo_view_rendering }
const
  GL_NV_stereo_view_rendering = 1;  
{////#endif /* GL_NV_stereo_view_rendering */ }
{////#ifndef GL_NV_tessellation_program5 }
  GL_NV_tessellation_program5 = 1;  
  GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = $86D8;  
  GL_TESS_CONTROL_PROGRAM_NV = $891E;  
  GL_TESS_EVALUATION_PROGRAM_NV = $891F;  
  GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = $8C74;  
  GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = $8C75;  
{////#endif /* GL_NV_tessellation_program5 */ }
{////#ifndef GL_NV_texgen_emboss }
  GL_NV_texgen_emboss = 1;  
  GL_EMBOSS_LIGHT_NV = $855D;  
  GL_EMBOSS_CONSTANT_NV = $855E;  
  GL_EMBOSS_MAP_NV = $855F;  
{////#endif /* GL_NV_texgen_emboss */ }
{////#ifndef GL_NV_texgen_reflection }
  GL_NV_texgen_reflection = 1;  
  GL_NORMAL_MAP_NV = $8511;  
  GL_REFLECTION_MAP_NV = $8512;  
{////#endif /* GL_NV_texgen_reflection */ }
{////#ifndef GL_NV_texture_barrier }
  GL_NV_texture_barrier = 1;  
{////typedef void (P PFNGLTEXTUREBARRIERNVPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTextureBarrierNV;cdecl;external;
{////#endif }
{////#endif /* GL_NV_texture_barrier */ }
{////#ifndef GL_NV_texture_compression_vtc }
const
  GL_NV_texture_compression_vtc = 1;  
{////#endif /* GL_NV_texture_compression_vtc */ }
{////#ifndef GL_NV_texture_env_combine4 }
  GL_NV_texture_env_combine4 = 1;  
  GL_COMBINE4_NV = $8503;  
  GL_SOURCE3_RGB_NV = $8583;  
  GL_SOURCE3_ALPHA_NV = $858B;  
  GL_OPERAND3_RGB_NV = $8593;  
  GL_OPERAND3_ALPHA_NV = $859B;  
{////#endif /* GL_NV_texture_env_combine4 */ }
{////#ifndef GL_NV_texture_expand_normal }
  GL_NV_texture_expand_normal = 1;  
  GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = $888F;  
{////#endif /* GL_NV_texture_expand_normal */ }
{////#ifndef GL_NV_texture_multisample }
  GL_NV_texture_multisample = 1;  
  GL_TEXTURE_COVERAGE_SAMPLES_NV = $9045;  
  GL_TEXTURE_COLOR_SAMPLES_NV = $9046;  
{////typedef void (P PFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations); }
{////typedef void (P PFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations); }
{////typedef void (P PFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC) (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations); }
{////typedef void (P PFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC) (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations); }
{////typedef void (P PFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC) (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations); }
{////typedef void (P PFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC) (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTexImage2DMultisampleCoverageNV(target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; width:TGLsizei; 
            height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
procedure glTexImage3DMultisampleCoverageNV(target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
procedure glTextureImage2DMultisampleNV(texture:TGLuint; target:TGLenum; samples:TGLsizei; internalFormat:TGLint; width:TGLsizei; 
            height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
procedure glTextureImage3DMultisampleNV(texture:TGLuint; target:TGLenum; samples:TGLsizei; internalFormat:TGLint; width:TGLsizei; 
            height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
procedure glTextureImage2DMultisampleCoverageNV(texture:TGLuint; target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; 
            width:TGLsizei; height:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
procedure glTextureImage3DMultisampleCoverageNV(texture:TGLuint; target:TGLenum; coverageSamples:TGLsizei; colorSamples:TGLsizei; internalFormat:TGLint; 
            width:TGLsizei; height:TGLsizei; depth:TGLsizei; fixedSampleLocations:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_NV_texture_multisample */ }
{////#ifndef GL_NV_texture_rectangle }
const
  GL_NV_texture_rectangle = 1;  
  GL_TEXTURE_RECTANGLE_NV = $84F5;  
  GL_TEXTURE_BINDING_RECTANGLE_NV = $84F6;  
  GL_PROXY_TEXTURE_RECTANGLE_NV = $84F7;  
  GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = $84F8;  
{////#endif /* GL_NV_texture_rectangle */ }
{////#ifndef GL_NV_texture_rectangle_compressed }
  GL_NV_texture_rectangle_compressed = 1;  
{////#endif /* GL_NV_texture_rectangle_compressed */ }
{////#ifndef GL_NV_texture_shader }
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
  GL_OFFSET_TEXTURE_MATRIX_NV = $86E1;  
  GL_OFFSET_TEXTURE_SCALE_NV = $86E2;  
  GL_OFFSET_TEXTURE_BIAS_NV = $86E3;  
  GL_OFFSET_TEXTURE_2D_MATRIX_NV = $86E1;  
  GL_OFFSET_TEXTURE_2D_SCALE_NV = $86E2;  
  GL_OFFSET_TEXTURE_2D_BIAS_NV = $86E3;  
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
{////#endif /* GL_NV_texture_shader */ }
{////#ifndef GL_NV_texture_shader2 }
  GL_NV_texture_shader2 = 1;  
  GL_DOT_PRODUCT_TEXTURE_3D_NV = $86EF;  
{////#endif /* GL_NV_texture_shader2 */ }
{////#ifndef GL_NV_texture_shader3 }
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
{////#endif /* GL_NV_texture_shader3 */ }
{////#ifndef GL_NV_timeline_semaphore }
  GL_NV_timeline_semaphore = 1;  
  GL_TIMELINE_SEMAPHORE_VALUE_NV = $9595;  
  GL_SEMAPHORE_TYPE_NV = $95B3;  
  GL_SEMAPHORE_TYPE_BINARY_NV = $95B4;  
  GL_SEMAPHORE_TYPE_TIMELINE_NV = $95B5;  
  GL_MAX_TIMELINE_SEMAPHORE_VALUE_DIFFERENCE_NV = $95B6;  
{////typedef void (P PFNGLCREATESEMAPHORESNVPROC) (GLsizei n, GLuint *semaphores); }
{////typedef void (P PFNGLSEMAPHOREPARAMETERIVNVPROC) (GLuint semaphore, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLGETSEMAPHOREPARAMETERIVNVPROC) (GLuint semaphore, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glCreateSemaphoresNV(n:TGLsizei; semaphores:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glSemaphoreParameterivNV(semaphore:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetSemaphoreParameterivNV(semaphore:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_timeline_semaphore */ }
{////#ifndef GL_NV_transform_feedback }
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
  GL_LAYER_NV = $8DAA;  
  GL_NEXT_BUFFER_NV = -(2);  
  GL_SKIP_COMPONENTS4_NV = -(3);  
  GL_SKIP_COMPONENTS3_NV = -(4);  
  GL_SKIP_COMPONENTS2_NV = -(5);  
  GL_SKIP_COMPONENTS1_NV = -(6);  
{////typedef void (P PFNGLBEGINTRANSFORMFEEDBACKNVPROC) (GLenum primitiveMode); }
{////typedef void (P PFNGLENDTRANSFORMFEEDBACKNVPROC) (void); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKATTRIBSNVPROC) (GLsizei count, const GLint *attribs, GLenum bufferMode); }
{////typedef void (P PFNGLBINDBUFFERRANGENVPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size); }
{////typedef void (P PFNGLBINDBUFFEROFFSETNVPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset); }
{////typedef void (P PFNGLBINDBUFFERBASENVPROC) (GLenum target, GLuint index, GLuint buffer); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKVARYINGSNVPROC) (GLuint program_, GLsizei count, const GLint *locations, GLenum bufferMode); }
{////typedef void (P PFNGLACTIVEVARYINGNVPROC) (GLuint program_, const GLchar *name); }
{////typedef GLint (P PFNGLGETVARYINGLOCATIONNVPROC) (GLuint program_, const GLchar *name); }
{////typedef void (P PFNGLGETACTIVEVARYINGNVPROC) (GLuint program_, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name); }
{////typedef void (P PFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC) (GLuint program_, GLuint index, GLint *location); }
{////typedef void (P PFNGLTRANSFORMFEEDBACKSTREAMATTRIBSNVPROC) (GLsizei count, const GLint *attribs, GLsizei nbuffers, const GLint *bufstreams, GLenum bufferMode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginTransformFeedbackNV(primitiveMode:TGLenum);cdecl;external;
procedure glEndTransformFeedbackNV;cdecl;external;
(* Const before type ignored *)
procedure glTransformFeedbackAttribsNV(count:TGLsizei; attribs:PGLint; bufferMode:TGLenum);cdecl;external;
procedure glBindBufferRangeNV(target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr; size:TGLsizeiptr);cdecl;external;
procedure glBindBufferOffsetNV(target:TGLenum; index:TGLuint; buffer:TGLuint; offset:TGLintptr);cdecl;external;
procedure glBindBufferBaseNV(target:TGLenum; index:TGLuint; buffer:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glTransformFeedbackVaryingsNV(program_:TGLuint; count:TGLsizei; locations:PGLint; bufferMode:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glActiveVaryingNV(program_:TGLuint; name:PGLchar);cdecl;external;
(* Const before type ignored *)
function glGetVaryingLocationNV(program_:TGLuint; name:PGLchar):TGLint;cdecl;external;
procedure glGetActiveVaryingNV(program_:TGLuint; index:TGLuint; bufSize:TGLsizei; length:PGLsizei; size:PGLsizei; 
            _type:PGLenum; name:PGLchar);cdecl;external;
procedure glGetTransformFeedbackVaryingNV(program_:TGLuint; index:TGLuint; location:PGLint);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTransformFeedbackStreamAttribsNV(count:TGLsizei; attribs:PGLint; nbuffers:TGLsizei; bufstreams:PGLint; bufferMode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_transform_feedback */ }
{////#ifndef GL_NV_transform_feedback2 }
const
  GL_NV_transform_feedback2 = 1;  
  GL_TRANSFORM_FEEDBACK_NV = $8E22;  
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = $8E23;  
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = $8E24;  
  GL_TRANSFORM_FEEDBACK_BINDING_NV = $8E25;  
{////typedef void (P PFNGLBINDTRANSFORMFEEDBACKNVPROC) (GLenum target, GLuint id); }
{////typedef void (P PFNGLDELETETRANSFORMFEEDBACKSNVPROC) (GLsizei n, const GLuint *ids); }
{////typedef void (P PFNGLGENTRANSFORMFEEDBACKSNVPROC) (GLsizei n, GLuint *ids); }
{////typedef GLboolean (P PFNGLISTRANSFORMFEEDBACKNVPROC) (GLuint id); }
{////typedef void (P PFNGLPAUSETRANSFORMFEEDBACKNVPROC) (void); }
{////typedef void (P PFNGLRESUMETRANSFORMFEEDBACKNVPROC) (void); }
{////typedef void (P PFNGLDRAWTRANSFORMFEEDBACKNVPROC) (GLenum mode, GLuint id); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBindTransformFeedbackNV(target:TGLenum; id:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteTransformFeedbacksNV(n:TGLsizei; ids:PGLuint);cdecl;external;
procedure glGenTransformFeedbacksNV(n:TGLsizei; ids:PGLuint);cdecl;external;
function glIsTransformFeedbackNV(id:TGLuint):TGLboolean;cdecl;external;
procedure glPauseTransformFeedbackNV;cdecl;external;
procedure glResumeTransformFeedbackNV;cdecl;external;
procedure glDrawTransformFeedbackNV(mode:TGLenum; id:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_NV_transform_feedback2 */ }
{////#ifndef GL_NV_uniform_buffer_unified_memory }
const
  GL_NV_uniform_buffer_unified_memory = 1;  
  GL_UNIFORM_BUFFER_UNIFIED_NV = $936E;  
  GL_UNIFORM_BUFFER_ADDRESS_NV = $936F;  
  GL_UNIFORM_BUFFER_LENGTH_NV = $9370;  
{////#endif /* GL_NV_uniform_buffer_unified_memory */ }
{////#ifndef GL_NV_vdpau_interop }
  GL_NV_vdpau_interop = 1;  
type
  PGLvdpauSurfaceNV = ^TGLvdpauSurfaceNV;
  TGLvdpauSurfaceNV = TGLintptr;

const
  GL_SURFACE_STATE_NV = $86EB;  
  GL_SURFACE_REGISTERED_NV = $86FD;  
  GL_SURFACE_MAPPED_NV = $8700;  
  GL_WRITE_DISCARD_NV = $88BE;  
{////typedef void (P PFNGLVDPAUINITNVPROC) (const void *vdpDevice, const void *getProcAddress); }
{////typedef void (P PFNGLVDPAUFININVPROC) (void); }
{////typedef GLvdpauSurfaceNV (P PFNGLVDPAUREGISTERVIDEOSURFACENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames); }
{////typedef GLvdpauSurfaceNV (P PFNGLVDPAUREGISTEROUTPUTSURFACENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames); }
{////typedef GLboolean (P PFNGLVDPAUISSURFACENVPROC) (GLvdpauSurfaceNV surface); }
{////typedef void (P PFNGLVDPAUUNREGISTERSURFACENVPROC) (GLvdpauSurfaceNV surface); }
{////typedef void (P PFNGLVDPAUGETSURFACEIVNVPROC) (GLvdpauSurfaceNV surface, GLenum pname, GLsizei count, GLsizei *length, GLint *values); }
{////typedef void (P PFNGLVDPAUSURFACEACCESSNVPROC) (GLvdpauSurfaceNV surface, GLenum access); }
{////typedef void (P PFNGLVDPAUMAPSURFACESNVPROC) (GLsizei numSurfaces, const GLvdpauSurfaceNV *surfaces); }
{////typedef void (P PFNGLVDPAUUNMAPSURFACESNVPROC) (GLsizei numSurface, const GLvdpauSurfaceNV *surfaces); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)

procedure glVDPAUInitNV(vdpDevice:pointer; getProcAddress:pointer);cdecl;external;
procedure glVDPAUFiniNV;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function glVDPAURegisterVideoSurfaceNV(vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint):TGLvdpauSurfaceNV;cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
function glVDPAURegisterOutputSurfaceNV(vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint):TGLvdpauSurfaceNV;cdecl;external;
function glVDPAUIsSurfaceNV(surface:TGLvdpauSurfaceNV):TGLboolean;cdecl;external;
procedure glVDPAUUnregisterSurfaceNV(surface:TGLvdpauSurfaceNV);cdecl;external;
procedure glVDPAUGetSurfaceivNV(surface:TGLvdpauSurfaceNV; pname:TGLenum; count:TGLsizei; length:PGLsizei; values:PGLint);cdecl;external;
procedure glVDPAUSurfaceAccessNV(surface:TGLvdpauSurfaceNV; access:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glVDPAUMapSurfacesNV(numSurfaces:TGLsizei; surfaces:PGLvdpauSurfaceNV);cdecl;external;
(* Const before type ignored *)
procedure glVDPAUUnmapSurfacesNV(numSurface:TGLsizei; surfaces:PGLvdpauSurfaceNV);cdecl;external;
{////#endif }
{////#endif /* GL_NV_vdpau_interop */ }
{////#ifndef GL_NV_vdpau_interop2 }
const
  GL_NV_vdpau_interop2 = 1;  
{////typedef GLvdpauSurfaceNV (P PFNGLVDPAUREGISTERVIDEOSURFACEWITHPICTURESTRUCTURENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames, GLboolean isFrameStructure); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)
(* Const before type ignored *)

function glVDPAURegisterVideoSurfaceWithPictureStructureNV(vdpSurface:pointer; target:TGLenum; numTextureNames:TGLsizei; textureNames:PGLuint; isFrameStructure:TGLboolean):TGLvdpauSurfaceNV;cdecl;external;
{////#endif }
{////#endif /* GL_NV_vdpau_interop2 */ }
{////#ifndef GL_NV_vertex_array_range }
const
  GL_NV_vertex_array_range = 1;  
  GL_VERTEX_ARRAY_RANGE_NV = $851D;  
  GL_VERTEX_ARRAY_RANGE_LENGTH_NV = $851E;  
  GL_VERTEX_ARRAY_RANGE_VALID_NV = $851F;  
  GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = $8520;  
  GL_VERTEX_ARRAY_RANGE_POINTER_NV = $8521;  
{////typedef void (P PFNGLFLUSHVERTEXARRAYRANGENVPROC) (void); }
{////typedef void (P PFNGLVERTEXARRAYRANGENVPROC) (GLsizei length, const void *pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFlushVertexArrayRangeNV;cdecl;external;
(* Const before type ignored *)
procedure glVertexArrayRangeNV(length:TGLsizei; pointer:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_NV_vertex_array_range */ }
{////#ifndef GL_NV_vertex_array_range2 }
const
  GL_NV_vertex_array_range2 = 1;  
  GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = $8533;  
{////#endif /* GL_NV_vertex_array_range2 */ }
{////#ifndef GL_NV_vertex_attrib_integer_64bit }
  GL_NV_vertex_attrib_integer_64bit = 1;  
{////typedef void (P PFNGLVERTEXATTRIBL1I64NVPROC) (GLuint index, GLint64EXT x); }
{////typedef void (P PFNGLVERTEXATTRIBL2I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y); }
{////typedef void (P PFNGLVERTEXATTRIBL3I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z); }
{////typedef void (P PFNGLVERTEXATTRIBL4I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w); }
{////typedef void (P PFNGLVERTEXATTRIBL1I64VNVPROC) (GLuint index, const GLint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL2I64VNVPROC) (GLuint index, const GLint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL3I64VNVPROC) (GLuint index, const GLint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL4I64VNVPROC) (GLuint index, const GLint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL1UI64NVPROC) (GLuint index, GLuint64EXT x); }
{////typedef void (P PFNGLVERTEXATTRIBL2UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y); }
{////typedef void (P PFNGLVERTEXATTRIBL3UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z); }
{////typedef void (P PFNGLVERTEXATTRIBL4UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w); }
{////typedef void (P PFNGLVERTEXATTRIBL1UI64VNVPROC) (GLuint index, const GLuint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL2UI64VNVPROC) (GLuint index, const GLuint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL3UI64VNVPROC) (GLuint index, const GLuint64EXT *v); }
{////typedef void (P PFNGLVERTEXATTRIBL4UI64VNVPROC) (GLuint index, const GLuint64EXT *v); }
{////typedef void (P PFNGLGETVERTEXATTRIBLI64VNVPROC) (GLuint index, GLenum pname, GLint64EXT *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBLUI64VNVPROC) (GLuint index, GLenum pname, GLuint64EXT *params); }
{////typedef void (P PFNGLVERTEXATTRIBLFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glVertexAttribL1i64NV(index:TGLuint; x:TGLint64EXT);cdecl;external;
procedure glVertexAttribL2i64NV(index:TGLuint; x:TGLint64EXT; y:TGLint64EXT);cdecl;external;
procedure glVertexAttribL3i64NV(index:TGLuint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT);cdecl;external;
procedure glVertexAttribL4i64NV(index:TGLuint; x:TGLint64EXT; y:TGLint64EXT; z:TGLint64EXT; w:TGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL1i64vNV(index:TGLuint; v:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL2i64vNV(index:TGLuint; v:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL3i64vNV(index:TGLuint; v:PGLint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL4i64vNV(index:TGLuint; v:PGLint64EXT);cdecl;external;
procedure glVertexAttribL1ui64NV(index:TGLuint; x:TGLuint64EXT);cdecl;external;
procedure glVertexAttribL2ui64NV(index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT);cdecl;external;
procedure glVertexAttribL3ui64NV(index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT);cdecl;external;
procedure glVertexAttribL4ui64NV(index:TGLuint; x:TGLuint64EXT; y:TGLuint64EXT; z:TGLuint64EXT; w:TGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL1ui64vNV(index:TGLuint; v:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL2ui64vNV(index:TGLuint; v:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL3ui64vNV(index:TGLuint; v:PGLuint64EXT);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribL4ui64vNV(index:TGLuint; v:PGLuint64EXT);cdecl;external;
procedure glGetVertexAttribLi64vNV(index:TGLuint; pname:TGLenum; params:PGLint64EXT);cdecl;external;
procedure glGetVertexAttribLui64vNV(index:TGLuint; pname:TGLenum; params:PGLuint64EXT);cdecl;external;
procedure glVertexAttribLFormatNV(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_NV_vertex_attrib_integer_64bit */ }
{////#ifndef GL_NV_vertex_buffer_unified_memory }
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
{////typedef void (P PFNGLBUFFERADDRESSRANGENVPROC) (GLenum pname, GLuint index, GLuint64EXT address, GLsizeiptr length); }
{////typedef void (P PFNGLVERTEXFORMATNVPROC) (GLint size, GLenum type, GLsizei stride); }
{////typedef void (P PFNGLNORMALFORMATNVPROC) (GLenum type, GLsizei stride); }
{////typedef void (P PFNGLCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride); }
{////typedef void (P PFNGLINDEXFORMATNVPROC) (GLenum type, GLsizei stride); }
{////typedef void (P PFNGLTEXCOORDFORMATNVPROC) (GLint size, GLenum type, GLsizei stride); }
{////typedef void (P PFNGLEDGEFLAGFORMATNVPROC) (GLsizei stride); }
{////typedef void (P PFNGLSECONDARYCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride); }
{////typedef void (P PFNGLFOGCOORDFORMATNVPROC) (GLenum type, GLsizei stride); }
{////typedef void (P PFNGLVERTEXATTRIBFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride); }
{////typedef void (P PFNGLVERTEXATTRIBIFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride); }
{////typedef void (P PFNGLGETINTEGERUI64I_VNVPROC) (GLenum value, GLuint index, GLuint64EXT *result); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBufferAddressRangeNV(pname:TGLenum; index:TGLuint; address:TGLuint64EXT; length:TGLsizeiptr);cdecl;external;
procedure glVertexFormatNV(size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glNormalFormatNV(_type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glColorFormatNV(size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glIndexFormatNV(_type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glTexCoordFormatNV(size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glEdgeFlagFormatNV(stride:TGLsizei);cdecl;external;
procedure glSecondaryColorFormatNV(size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glFogCoordFormatNV(_type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glVertexAttribFormatNV(index:TGLuint; size:TGLint; _type:TGLenum; normalized:TGLboolean; stride:TGLsizei);cdecl;external;
procedure glVertexAttribIFormatNV(index:TGLuint; size:TGLint; _type:TGLenum; stride:TGLsizei);cdecl;external;
procedure glGetIntegerui64i_vNV(value:TGLenum; index:TGLuint; result:PGLuint64EXT);cdecl;external;
{////#endif }
{////#endif /* GL_NV_vertex_buffer_unified_memory */ }
{////#ifndef GL_NV_vertex_program }
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
{////typedef GLboolean (P PFNGLAREPROGRAMSRESIDENTNVPROC) (GLsizei n, const GLuint *programs, GLboolean *residences); }
{////typedef void (P PFNGLBINDPROGRAMNVPROC) (GLenum target, GLuint id); }
{////typedef void (P PFNGLDELETEPROGRAMSNVPROC) (GLsizei n, const GLuint *programs); }
{////typedef void (P PFNGLEXECUTEPROGRAMNVPROC) (GLenum target, GLuint id, const GLfloat *params); }
{////typedef void (P PFNGLGENPROGRAMSNVPROC) (GLsizei n, GLuint *programs); }
{////typedef void (P PFNGLGETPROGRAMPARAMETERDVNVPROC) (GLenum target, GLuint index, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLGETPROGRAMPARAMETERFVNVPROC) (GLenum target, GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETPROGRAMIVNVPROC) (GLuint id, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETPROGRAMSTRINGNVPROC) (GLuint id, GLenum pname, GLubyte *program); }
{////typedef void (P PFNGLGETTRACKMATRIXIVNVPROC) (GLenum target, GLuint address, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBDVNVPROC) (GLuint index, GLenum pname, GLdouble *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBFVNVPROC) (GLuint index, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBIVNVPROC) (GLuint index, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVERTEXATTRIBPOINTERVNVPROC) (GLuint index, GLenum pname, void **pointer); }
{////typedef GLboolean (P PFNGLISPROGRAMNVPROC) (GLuint id); }
{////typedef void (P PFNGLLOADPROGRAMNVPROC) (GLenum target, GLuint id, GLsizei len, const GLubyte *program); }
{////typedef void (P PFNGLPROGRAMPARAMETER4DNVPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLPROGRAMPARAMETER4DVNVPROC) (GLenum target, GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLPROGRAMPARAMETER4FNVPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLPROGRAMPARAMETER4FVNVPROC) (GLenum target, GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLPROGRAMPARAMETERS4DVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLPROGRAMPARAMETERS4FVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLREQUESTRESIDENTPROGRAMSNVPROC) (GLsizei n, const GLuint *programs); }
{////typedef void (P PFNGLTRACKMATRIXNVPROC) (GLenum target, GLuint address, GLenum matrix, GLenum transform); }
{////typedef void (P PFNGLVERTEXATTRIBPOINTERNVPROC) (GLuint index, GLint fsize, GLenum type, GLsizei stride, const void *pointer); }
{////typedef void (P PFNGLVERTEXATTRIB1DNVPROC) (GLuint index, GLdouble x); }
{////typedef void (P PFNGLVERTEXATTRIB1DVNVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB1FNVPROC) (GLuint index, GLfloat x); }
{////typedef void (P PFNGLVERTEXATTRIB1FVNVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB1SNVPROC) (GLuint index, GLshort x); }
{////typedef void (P PFNGLVERTEXATTRIB1SVNVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB2DNVPROC) (GLuint index, GLdouble x, GLdouble y); }
{////typedef void (P PFNGLVERTEXATTRIB2DVNVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB2FNVPROC) (GLuint index, GLfloat x, GLfloat y); }
{////typedef void (P PFNGLVERTEXATTRIB2FVNVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB2SNVPROC) (GLuint index, GLshort x, GLshort y); }
{////typedef void (P PFNGLVERTEXATTRIB2SVNVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB3DNVPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z); }
{////typedef void (P PFNGLVERTEXATTRIB3DVNVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB3FNVPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLVERTEXATTRIB3FVNVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB3SNVPROC) (GLuint index, GLshort x, GLshort y, GLshort z); }
{////typedef void (P PFNGLVERTEXATTRIB3SVNVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4DNVPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w); }
{////typedef void (P PFNGLVERTEXATTRIB4DVNVPROC) (GLuint index, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIB4FNVPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLVERTEXATTRIB4FVNVPROC) (GLuint index, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIB4SNVPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w); }
{////typedef void (P PFNGLVERTEXATTRIB4SVNVPROC) (GLuint index, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIB4UBNVPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w); }
{////typedef void (P PFNGLVERTEXATTRIB4UBVNVPROC) (GLuint index, const GLubyte *v); }
{////typedef void (P PFNGLVERTEXATTRIBS1DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBS1FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIBS1SVNVPROC) (GLuint index, GLsizei count, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBS2DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBS2FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIBS2SVNVPROC) (GLuint index, GLsizei count, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBS3DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBS3FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIBS3SVNVPROC) (GLuint index, GLsizei count, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBS4DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v); }
{////typedef void (P PFNGLVERTEXATTRIBS4FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v); }
{////typedef void (P PFNGLVERTEXATTRIBS4SVNVPROC) (GLuint index, GLsizei count, const GLshort *v); }
{////typedef void (P PFNGLVERTEXATTRIBS4UBVNVPROC) (GLuint index, GLsizei count, const GLubyte *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

function glAreProgramsResidentNV(n:TGLsizei; programs:PGLuint; residences:PGLboolean):TGLboolean;cdecl;external;
procedure glBindProgramNV(target:TGLenum; id:TGLuint);cdecl;external;
(* Const before type ignored *)
procedure glDeleteProgramsNV(n:TGLsizei; programs:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glExecuteProgramNV(target:TGLenum; id:TGLuint; params:PGLfloat);cdecl;external;
procedure glGenProgramsNV(n:TGLsizei; programs:PGLuint);cdecl;external;
procedure glGetProgramParameterdvNV(target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glGetProgramParameterfvNV(target:TGLenum; index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetProgramivNV(id:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetProgramStringNV(id:TGLuint; pname:TGLenum; program_:PGLubyte);cdecl;external;
procedure glGetTrackMatrixivNV(target:TGLenum; address:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribdvNV(index:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
procedure glGetVertexAttribfvNV(index:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVertexAttribivNV(index:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVertexAttribPointervNV(index:TGLuint; pname:TGLenum; pointer:Ppointer);cdecl;external;
function glIsProgramNV(id:TGLuint):TGLboolean;cdecl;external;
(* Const before type ignored *)
procedure glLoadProgramNV(target:TGLenum; id:TGLuint; len:TGLsizei; program_:PGLubyte);cdecl;external;
procedure glProgramParameter4dNV(target:TGLenum; index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; 
            w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramParameter4dvNV(target:TGLenum; index:TGLuint; v:PGLdouble);cdecl;external;
procedure glProgramParameter4fNV(target:TGLenum; index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; 
            w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramParameter4fvNV(target:TGLenum; index:TGLuint; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glProgramParameters4dvNV(target:TGLenum; index:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glProgramParameters4fvNV(target:TGLenum; index:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glRequestResidentProgramsNV(n:TGLsizei; programs:PGLuint);cdecl;external;
procedure glTrackMatrixNV(target:TGLenum; address:TGLuint; matrix:TGLenum; transform:TGLenum);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribPointerNV(index:TGLuint; fsize:TGLint; _type:TGLenum; stride:TGLsizei; pointer:pointer);cdecl;external;
procedure glVertexAttrib1dNV(index:TGLuint; x:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1dvNV(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib1fNV(index:TGLuint; x:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1fvNV(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib1sNV(index:TGLuint; x:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib1svNV(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib2dNV(index:TGLuint; x:TGLdouble; y:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2dvNV(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib2fNV(index:TGLuint; x:TGLfloat; y:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2fvNV(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib2sNV(index:TGLuint; x:TGLshort; y:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib2svNV(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib3dNV(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3dvNV(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib3fNV(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3fvNV(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib3sNV(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib3svNV(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib4dNV(index:TGLuint; x:TGLdouble; y:TGLdouble; z:TGLdouble; w:TGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4dvNV(index:TGLuint; v:PGLdouble);cdecl;external;
procedure glVertexAttrib4fNV(index:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4fvNV(index:TGLuint; v:PGLfloat);cdecl;external;
procedure glVertexAttrib4sNV(index:TGLuint; x:TGLshort; y:TGLshort; z:TGLshort; w:TGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4svNV(index:TGLuint; v:PGLshort);cdecl;external;
procedure glVertexAttrib4ubNV(index:TGLuint; x:TGLubyte; y:TGLubyte; z:TGLubyte; w:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttrib4ubvNV(index:TGLuint; v:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs1dvNV(index:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs1fvNV(index:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs1svNV(index:TGLuint; count:TGLsizei; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs2dvNV(index:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs2fvNV(index:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs2svNV(index:TGLuint; count:TGLsizei; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs3dvNV(index:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs3fvNV(index:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs3svNV(index:TGLuint; count:TGLsizei; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs4dvNV(index:TGLuint; count:TGLsizei; v:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs4fvNV(index:TGLuint; count:TGLsizei; v:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs4svNV(index:TGLuint; count:TGLsizei; v:PGLshort);cdecl;external;
(* Const before type ignored *)
procedure glVertexAttribs4ubvNV(index:TGLuint; count:TGLsizei; v:PGLubyte);cdecl;external;
{////#endif }
{////#endif /* GL_NV_vertex_program */ }
{////#ifndef GL_NV_vertex_program1_1 }
const
  GL_NV_vertex_program1_1 = 1;  
{////#endif /* GL_NV_vertex_program1_1 */ }
{////#ifndef GL_NV_vertex_program2 }
  GL_NV_vertex_program2 = 1;  
{////#endif /* GL_NV_vertex_program2 */ }
{////#ifndef GL_NV_vertex_program2_option }
  GL_NV_vertex_program2_option = 1;  
{////#endif /* GL_NV_vertex_program2_option */ }
{////#ifndef GL_NV_vertex_program3 }
  GL_NV_vertex_program3 = 1;  
{////#endif /* GL_NV_vertex_program3 */ }
{////#ifndef GL_NV_vertex_program4 }
  GL_NV_vertex_program4 = 1;  
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV = $88FD;  
{////#endif /* GL_NV_vertex_program4 */ }
{////#ifndef GL_NV_video_capture }
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
{////typedef void (P PFNGLBEGINVIDEOCAPTURENVPROC) (GLuint video_capture_slot); }
{////typedef void (P PFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLintptrARB offset); }
{////typedef void (P PFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC) (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLenum target, GLuint texture); }
{////typedef void (P PFNGLENDVIDEOCAPTURENVPROC) (GLuint video_capture_slot); }
{////typedef void (P PFNGLGETVIDEOCAPTUREIVNVPROC) (GLuint video_capture_slot, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVIDEOCAPTURESTREAMIVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETVIDEOCAPTURESTREAMFVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETVIDEOCAPTURESTREAMDVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLdouble *params); }
{////typedef GLenum (P PFNGLVIDEOCAPTURENVPROC) (GLuint video_capture_slot, GLuint *sequence_num, GLuint64EXT *capture_time); }
{////typedef void (P PFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLdouble *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glBeginVideoCaptureNV(video_capture_slot:TGLuint);cdecl;external;
procedure glBindVideoCaptureStreamBufferNV(video_capture_slot:TGLuint; stream:TGLuint; frame_region:TGLenum; offset:TGLintptrARB);cdecl;external;
procedure glBindVideoCaptureStreamTextureNV(video_capture_slot:TGLuint; stream:TGLuint; frame_region:TGLenum; target:TGLenum; texture:TGLuint);cdecl;external;
procedure glEndVideoCaptureNV(video_capture_slot:TGLuint);cdecl;external;
procedure glGetVideoCaptureivNV(video_capture_slot:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVideoCaptureStreamivNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetVideoCaptureStreamfvNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetVideoCaptureStreamdvNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
function glVideoCaptureNV(video_capture_slot:TGLuint; sequence_num:PGLuint; capture_time:PGLuint64EXT):TGLenum;cdecl;external;
(* Const before type ignored *)
procedure glVideoCaptureStreamParameterivNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
(* Const before type ignored *)
procedure glVideoCaptureStreamParameterfvNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glVideoCaptureStreamParameterdvNV(video_capture_slot:TGLuint; stream:TGLuint; pname:TGLenum; params:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_NV_video_capture */ }
{////#ifndef GL_NV_viewport_array2 }
const
  GL_NV_viewport_array2 = 1;  
{////#endif /* GL_NV_viewport_array2 */ }
{////#ifndef GL_NV_viewport_swizzle }
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
{////typedef void (P PFNGLVIEWPORTSWIZZLENVPROC) (GLuint index, GLenum swizzlex, GLenum swizzley, GLenum swizzlez, GLenum swizzlew); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glViewportSwizzleNV(index:TGLuint; swizzlex:TGLenum; swizzley:TGLenum; swizzlez:TGLenum; swizzlew:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_NV_viewport_swizzle */ }
{////#ifndef GL_OML_interlace }
const
  GL_OML_interlace = 1;  
  GL_INTERLACE_OML = $8980;  
  GL_INTERLACE_READ_OML = $8981;  
{////#endif /* GL_OML_interlace */ }
{////#ifndef GL_OML_resample }
  GL_OML_resample = 1;  
  GL_PACK_RESAMPLE_OML = $8984;  
  GL_UNPACK_RESAMPLE_OML = $8985;  
  GL_RESAMPLE_REPLICATE_OML = $8986;  
  GL_RESAMPLE_ZERO_FILL_OML = $8987;  
  GL_RESAMPLE_AVERAGE_OML = $8988;  
  GL_RESAMPLE_DECIMATE_OML = $8989;  
{////#endif /* GL_OML_resample */ }
{////#ifndef GL_OML_subsample }
  GL_OML_subsample = 1;  
  GL_FORMAT_SUBSAMPLE_24_24_OML = $8982;  
  GL_FORMAT_SUBSAMPLE_244_244_OML = $8983;  
{////#endif /* GL_OML_subsample */ }
{////#ifndef GL_OVR_multiview }
  GL_OVR_multiview = 1;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = $9630;  
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = $9632;  
  GL_MAX_VIEWS_OVR = $9631;  
  GL_FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = $9633;  
{////typedef void (P PFNGLFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint baseViewIndex, GLsizei numViews); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFramebufferTextureMultiviewOVR(target:TGLenum; attachment:TGLenum; texture:TGLuint; level:TGLint; baseViewIndex:TGLint; 
            numViews:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_OVR_multiview */ }
{////#ifndef GL_OVR_multiview2 }
const
  GL_OVR_multiview2 = 1;  
{////#endif /* GL_OVR_multiview2 */ }
{////#ifndef GL_PGI_misc_hints }
  GL_PGI_misc_hints = 1;  
  GL_PREFER_DOUBLEBUFFER_HINT_PGI = $1A1F8;  
  GL_CONSERVE_MEMORY_HINT_PGI = $1A1FD;  
  GL_RECLAIM_MEMORY_HINT_PGI = $1A1FE;  
  GL_NATIVE_GRAPHICS_HANDLE_PGI = $1A202;  
  GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = $1A203;  
  GL_NATIVE_GRAPHICS_END_HINT_PGI = $1A204;  
  GL_ALWAYS_FAST_HINT_PGI = $1A20C;  
  GL_ALWAYS_SOFT_HINT_PGI = $1A20D;  
  GL_ALLOW_DRAW_OBJ_HINT_PGI = $1A20E;  
  GL_ALLOW_DRAW_WIN_HINT_PGI = $1A20F;  
  GL_ALLOW_DRAW_FRG_HINT_PGI = $1A210;  
  GL_ALLOW_DRAW_MEM_HINT_PGI = $1A211;  
  GL_STRICT_DEPTHFUNC_HINT_PGI = $1A216;  
  GL_STRICT_LIGHTING_HINT_PGI = $1A217;  
  GL_STRICT_SCISSOR_HINT_PGI = $1A218;  
  GL_FULL_STIPPLE_HINT_PGI = $1A219;  
  GL_CLIP_NEAR_HINT_PGI = $1A220;  
  GL_CLIP_FAR_HINT_PGI = $1A221;  
  GL_WIDE_LINE_HINT_PGI = $1A222;  
  GL_BACK_NORMALS_HINT_PGI = $1A223;  
{////typedef void (P PFNGLHINTPGIPROC) (GLenum target, GLint mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glHintPGI(target:TGLenum; mode:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_PGI_misc_hints */ }
{////#ifndef GL_PGI_vertex_hints }
const
  GL_PGI_vertex_hints = 1;  
  GL_VERTEX_DATA_HINT_PGI = $1A22A;  
  GL_VERTEX_CONSISTENT_HINT_PGI = $1A22B;  
  GL_MATERIAL_SIDE_HINT_PGI = $1A22C;  
  GL_MAX_VERTEX_HINT_PGI = $1A22D;  
  GL_COLOR3_BIT_PGI = $00010000;  
  GL_COLOR4_BIT_PGI = $00020000;  
  GL_EDGEFLAG_BIT_PGI = $00040000;  
  GL_INDEX_BIT_PGI = $00080000;  
  GL_MAT_AMBIENT_BIT_PGI = $00100000;  
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
  GL_VERTEX23_BIT_PGI = $00000004;  
  GL_VERTEX4_BIT_PGI = $00000008;  
{////#endif /* GL_PGI_vertex_hints */ }
{////#ifndef GL_REND_screen_coordinates }
  GL_REND_screen_coordinates = 1;  
  GL_SCREEN_COORDINATES_REND = $8490;  
  GL_INVERTED_SCREEN_W_REND = $8491;  
{////#endif /* GL_REND_screen_coordinates */ }
{////#ifndef GL_S3_s3tc }
  GL_S3_s3tc = 1;  
  GL_RGB_S3TC = $83A0;  
  GL_RGB4_S3TC = $83A1;  
  GL_RGBA_S3TC = $83A2;  
  GL_RGBA4_S3TC = $83A3;  
  GL_RGBA_DXT5_S3TC = $83A4;  
  GL_RGBA4_DXT5_S3TC = $83A5;  
{////#endif /* GL_S3_s3tc */ }
{////#ifndef GL_SGIS_detail_texture }
  GL_SGIS_detail_texture = 1;  
  GL_DETAIL_TEXTURE_2D_SGIS = $8095;  
  GL_DETAIL_TEXTURE_2D_BINDING_SGIS = $8096;  
  GL_LINEAR_DETAIL_SGIS = $8097;  
  GL_LINEAR_DETAIL_ALPHA_SGIS = $8098;  
  GL_LINEAR_DETAIL_COLOR_SGIS = $8099;  
  GL_DETAIL_TEXTURE_LEVEL_SGIS = $809A;  
  GL_DETAIL_TEXTURE_MODE_SGIS = $809B;  
  GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS = $809C;  
{////typedef void (P PFNGLDETAILTEXFUNCSGISPROC) (GLenum target, GLsizei n, const GLfloat *points); }
{////typedef void (P PFNGLGETDETAILTEXFUNCSGISPROC) (GLenum target, GLfloat *points); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDetailTexFuncSGIS(target:TGLenum; n:TGLsizei; points:PGLfloat);cdecl;external;
procedure glGetDetailTexFuncSGIS(target:TGLenum; points:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_detail_texture */ }
{////#ifndef GL_SGIS_fog_function }
const
  GL_SGIS_fog_function = 1;  
  GL_FOG_FUNC_SGIS = $812A;  
  GL_FOG_FUNC_POINTS_SGIS = $812B;  
  GL_MAX_FOG_FUNC_POINTS_SGIS = $812C;  
{////typedef void (P PFNGLFOGFUNCSGISPROC) (GLsizei n, const GLfloat *points); }
{////typedef void (P PFNGLGETFOGFUNCSGISPROC) (GLfloat *points); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glFogFuncSGIS(n:TGLsizei; points:PGLfloat);cdecl;external;
procedure glGetFogFuncSGIS(points:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_fog_function */ }
{////#ifndef GL_SGIS_generate_mipmap }
const
  GL_SGIS_generate_mipmap = 1;  
  GL_GENERATE_MIPMAP_SGIS = $8191;  
  GL_GENERATE_MIPMAP_HINT_SGIS = $8192;  
{////#endif /* GL_SGIS_generate_mipmap */ }
{////#ifndef GL_SGIS_multisample }
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
{////typedef void (P PFNGLSAMPLEMASKSGISPROC) (GLclampf value, GLboolean invert); }
{////typedef void (P PFNGLSAMPLEPATTERNSGISPROC) (GLenum pattern); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSampleMaskSGIS(value:TGLclampf; invert:TGLboolean);cdecl;external;
procedure glSamplePatternSGIS(pattern:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_multisample */ }
{////#ifndef GL_SGIS_pixel_texture }
const
  GL_SGIS_pixel_texture = 1;  
  GL_PIXEL_TEXTURE_SGIS = $8353;  
  GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS = $8354;  
  GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = $8355;  
  GL_PIXEL_GROUP_COLOR_SGIS = $8356;  
{////typedef void (P PFNGLPIXELTEXGENPARAMETERISGISPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLPIXELTEXGENPARAMETERIVSGISPROC) (GLenum pname, const GLint *params); }
{////typedef void (P PFNGLPIXELTEXGENPARAMETERFSGISPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPIXELTEXGENPARAMETERFVSGISPROC) (GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLGETPIXELTEXGENPARAMETERIVSGISPROC) (GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETPIXELTEXGENPARAMETERFVSGISPROC) (GLenum pname, GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPixelTexGenParameteriSGIS(pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glPixelTexGenParameterivSGIS(pname:TGLenum; params:PGLint);cdecl;external;
procedure glPixelTexGenParameterfSGIS(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPixelTexGenParameterfvSGIS(pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetPixelTexGenParameterivSGIS(pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetPixelTexGenParameterfvSGIS(pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_pixel_texture */ }
{////#ifndef GL_SGIS_point_line_texgen }
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
{////#endif /* GL_SGIS_point_line_texgen */ }
{////#ifndef GL_SGIS_point_parameters }
  GL_SGIS_point_parameters = 1;  
  GL_POINT_SIZE_MIN_SGIS = $8126;  
  GL_POINT_SIZE_MAX_SGIS = $8127;  
  GL_POINT_FADE_THRESHOLD_SIZE_SGIS = $8128;  
  GL_DISTANCE_ATTENUATION_SGIS = $8129;  
{////typedef void (P PFNGLPOINTPARAMETERFSGISPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLPOINTPARAMETERFVSGISPROC) (GLenum pname, const GLfloat *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPointParameterfSGIS(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glPointParameterfvSGIS(pname:TGLenum; params:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_point_parameters */ }
{////#ifndef GL_SGIS_sharpen_texture }
const
  GL_SGIS_sharpen_texture = 1;  
  GL_LINEAR_SHARPEN_SGIS = $80AD;  
  GL_LINEAR_SHARPEN_ALPHA_SGIS = $80AE;  
  GL_LINEAR_SHARPEN_COLOR_SGIS = $80AF;  
  GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS = $80B0;  
{////typedef void (P PFNGLSHARPENTEXFUNCSGISPROC) (GLenum target, GLsizei n, const GLfloat *points); }
{////typedef void (P PFNGLGETSHARPENTEXFUNCSGISPROC) (GLenum target, GLfloat *points); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glSharpenTexFuncSGIS(target:TGLenum; n:TGLsizei; points:PGLfloat);cdecl;external;
procedure glGetSharpenTexFuncSGIS(target:TGLenum; points:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_sharpen_texture */ }
{////#ifndef GL_SGIS_texture4D }
const
  GL_SGIS_texture4D = 1;  
  GL_PACK_SKIP_VOLUMES_SGIS = $8130;  
  GL_PACK_IMAGE_DEPTH_SGIS = $8131;  
  GL_UNPACK_SKIP_VOLUMES_SGIS = $8132;  
  GL_UNPACK_IMAGE_DEPTH_SGIS = $8133;  
  GL_TEXTURE_4D_SGIS = $8134;  
  GL_PROXY_TEXTURE_4D_SGIS = $8135;  
  GL_TEXTURE_4DSIZE_SGIS = $8136;  
  GL_TEXTURE_WRAP_Q_SGIS = $8137;  
  GL_MAX_4D_TEXTURE_SIZE_SGIS = $8138;  
  GL_TEXTURE_4D_BINDING_SGIS = $814F;  
{////typedef void (P PFNGLTEXIMAGE4DSGISPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLint border, GLenum format, GLenum type, const void *pixels); }
{////typedef void (P PFNGLTEXSUBIMAGE4DSGISPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint woffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLenum format, GLenum type, const void *pixels); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glTexImage4DSGIS(target:TGLenum; level:TGLint; internalformat:TGLenum; width:TGLsizei; height:TGLsizei; 
            depth:TGLsizei; size4d:TGLsizei; border:TGLint; format:TGLenum; _type:TGLenum; 
            pixels:pointer);cdecl;external;
(* Const before type ignored *)
procedure glTexSubImage4DSGIS(target:TGLenum; level:TGLint; xoffset:TGLint; yoffset:TGLint; zoffset:TGLint; 
            woffset:TGLint; width:TGLsizei; height:TGLsizei; depth:TGLsizei; size4d:TGLsizei; 
            format:TGLenum; _type:TGLenum; pixels:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_texture4D */ }
{////#ifndef GL_SGIS_texture_border_clamp }
const
  GL_SGIS_texture_border_clamp = 1;  
  GL_CLAMP_TO_BORDER_SGIS = $812D;  
{////#endif /* GL_SGIS_texture_border_clamp */ }
{////#ifndef GL_SGIS_texture_color_mask }
  GL_SGIS_texture_color_mask = 1;  
  GL_TEXTURE_COLOR_WRITEMASK_SGIS = $81EF;  
{////typedef void (P PFNGLTEXTURECOLORMASKSGISPROC) (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTextureColorMaskSGIS(red:TGLboolean; green:TGLboolean; blue:TGLboolean; alpha:TGLboolean);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_texture_color_mask */ }
{////#ifndef GL_SGIS_texture_edge_clamp }
const
  GL_SGIS_texture_edge_clamp = 1;  
  GL_CLAMP_TO_EDGE_SGIS = $812F;  
{////#endif /* GL_SGIS_texture_edge_clamp */ }
{////#ifndef GL_SGIS_texture_filter4 }
  GL_SGIS_texture_filter4 = 1;  
  GL_FILTER4_SGIS = $8146;  
  GL_TEXTURE_FILTER4_SIZE_SGIS = $8147;  
{////typedef void (P PFNGLGETTEXFILTERFUNCSGISPROC) (GLenum target, GLenum filter, GLfloat *weights); }
{////typedef void (P PFNGLTEXFILTERFUNCSGISPROC) (GLenum target, GLenum filter, GLsizei n, const GLfloat *weights); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetTexFilterFuncSGIS(target:TGLenum; filter:TGLenum; weights:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glTexFilterFuncSGIS(target:TGLenum; filter:TGLenum; n:TGLsizei; weights:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SGIS_texture_filter4 */ }
{////#ifndef GL_SGIS_texture_lod }
const
  GL_SGIS_texture_lod = 1;  
  GL_TEXTURE_MIN_LOD_SGIS = $813A;  
  GL_TEXTURE_MAX_LOD_SGIS = $813B;  
  GL_TEXTURE_BASE_LEVEL_SGIS = $813C;  
  GL_TEXTURE_MAX_LEVEL_SGIS = $813D;  
{////#endif /* GL_SGIS_texture_lod */ }
{////#ifndef GL_SGIS_texture_select }
  GL_SGIS_texture_select = 1;  
  GL_DUAL_ALPHA4_SGIS = $8110;  
  GL_DUAL_ALPHA8_SGIS = $8111;  
  GL_DUAL_ALPHA12_SGIS = $8112;  
  GL_DUAL_ALPHA16_SGIS = $8113;  
  GL_DUAL_LUMINANCE4_SGIS = $8114;  
  GL_DUAL_LUMINANCE8_SGIS = $8115;  
  GL_DUAL_LUMINANCE12_SGIS = $8116;  
  GL_DUAL_LUMINANCE16_SGIS = $8117;  
  GL_DUAL_INTENSITY4_SGIS = $8118;  
  GL_DUAL_INTENSITY8_SGIS = $8119;  
  GL_DUAL_INTENSITY12_SGIS = $811A;  
  GL_DUAL_INTENSITY16_SGIS = $811B;  
  GL_DUAL_LUMINANCE_ALPHA4_SGIS = $811C;  
  GL_DUAL_LUMINANCE_ALPHA8_SGIS = $811D;  
  GL_QUAD_ALPHA4_SGIS = $811E;  
  GL_QUAD_ALPHA8_SGIS = $811F;  
  GL_QUAD_LUMINANCE4_SGIS = $8120;  
  GL_QUAD_LUMINANCE8_SGIS = $8121;  
  GL_QUAD_INTENSITY4_SGIS = $8122;  
  GL_QUAD_INTENSITY8_SGIS = $8123;  
  GL_DUAL_TEXTURE_SELECT_SGIS = $8124;  
  GL_QUAD_TEXTURE_SELECT_SGIS = $8125;  
{////#endif /* GL_SGIS_texture_select */ }
{////#ifndef GL_SGIX_async }
  GL_SGIX_async = 1;  
  GL_ASYNC_MARKER_SGIX = $8329;  
{////typedef void (P PFNGLASYNCMARKERSGIXPROC) (GLuint marker); }
{////typedef GLint (P PFNGLFINISHASYNCSGIXPROC) (GLuint *markerp); }
{////typedef GLint (P PFNGLPOLLASYNCSGIXPROC) (GLuint *markerp); }
{////typedef GLuint (P PFNGLGENASYNCMARKERSSGIXPROC) (GLsizei range); }
{////typedef void (P PFNGLDELETEASYNCMARKERSSGIXPROC) (GLuint marker, GLsizei range); }
{////typedef GLboolean (P PFNGLISASYNCMARKERSGIXPROC) (GLuint marker); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glAsyncMarkerSGIX(marker:TGLuint);cdecl;external;
function glFinishAsyncSGIX(markerp:PGLuint):TGLint;cdecl;external;
function glPollAsyncSGIX(markerp:PGLuint):TGLint;cdecl;external;
function glGenAsyncMarkersSGIX(range:TGLsizei):TGLuint;cdecl;external;
procedure glDeleteAsyncMarkersSGIX(marker:TGLuint; range:TGLsizei);cdecl;external;
function glIsAsyncMarkerSGIX(marker:TGLuint):TGLboolean;cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_async */ }
{////#ifndef GL_SGIX_async_histogram }
const
  GL_SGIX_async_histogram = 1;  
  GL_ASYNC_HISTOGRAM_SGIX = $832C;  
  GL_MAX_ASYNC_HISTOGRAM_SGIX = $832D;  
{////#endif /* GL_SGIX_async_histogram */ }
{////#ifndef GL_SGIX_async_pixel }
  GL_SGIX_async_pixel = 1;  
  GL_ASYNC_TEX_IMAGE_SGIX = $835C;  
  GL_ASYNC_DRAW_PIXELS_SGIX = $835D;  
  GL_ASYNC_READ_PIXELS_SGIX = $835E;  
  GL_MAX_ASYNC_TEX_IMAGE_SGIX = $835F;  
  GL_MAX_ASYNC_DRAW_PIXELS_SGIX = $8360;  
  GL_MAX_ASYNC_READ_PIXELS_SGIX = $8361;  
{////#endif /* GL_SGIX_async_pixel */ }
{////#ifndef GL_SGIX_blend_alpha_minmax }
  GL_SGIX_blend_alpha_minmax = 1;  
  GL_ALPHA_MIN_SGIX = $8320;  
  GL_ALPHA_MAX_SGIX = $8321;  
{////#endif /* GL_SGIX_blend_alpha_minmax */ }
{////#ifndef GL_SGIX_calligraphic_fragment }
  GL_SGIX_calligraphic_fragment = 1;  
  GL_CALLIGRAPHIC_FRAGMENT_SGIX = $8183;  
{////#endif /* GL_SGIX_calligraphic_fragment */ }
{////#ifndef GL_SGIX_clipmap }
  GL_SGIX_clipmap = 1;  
  GL_LINEAR_CLIPMAP_LINEAR_SGIX = $8170;  
  GL_TEXTURE_CLIPMAP_CENTER_SGIX = $8171;  
  GL_TEXTURE_CLIPMAP_FRAME_SGIX = $8172;  
  GL_TEXTURE_CLIPMAP_OFFSET_SGIX = $8173;  
  GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8174;  
  GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = $8175;  
  GL_TEXTURE_CLIPMAP_DEPTH_SGIX = $8176;  
  GL_MAX_CLIPMAP_DEPTH_SGIX = $8177;  
  GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8178;  
  GL_NEAREST_CLIPMAP_NEAREST_SGIX = $844D;  
  GL_NEAREST_CLIPMAP_LINEAR_SGIX = $844E;  
  GL_LINEAR_CLIPMAP_NEAREST_SGIX = $844F;  
{////#endif /* GL_SGIX_clipmap */ }
{////#ifndef GL_SGIX_convolution_accuracy }
  GL_SGIX_convolution_accuracy = 1;  
  GL_CONVOLUTION_HINT_SGIX = $8316;  
{////#endif /* GL_SGIX_convolution_accuracy */ }
{////#ifndef GL_SGIX_depth_pass_instrument }
  GL_SGIX_depth_pass_instrument = 1;  
{////#endif /* GL_SGIX_depth_pass_instrument */ }
{////#ifndef GL_SGIX_depth_texture }
  GL_SGIX_depth_texture = 1;  
  GL_DEPTH_COMPONENT16_SGIX = $81A5;  
  GL_DEPTH_COMPONENT24_SGIX = $81A6;  
  GL_DEPTH_COMPONENT32_SGIX = $81A7;  
{////#endif /* GL_SGIX_depth_texture */ }
{////#ifndef GL_SGIX_flush_raster }
  GL_SGIX_flush_raster = 1;  
{////typedef void (P PFNGLFLUSHRASTERSGIXPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFlushRasterSGIX;cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_flush_raster */ }
{////#ifndef GL_SGIX_fog_offset }
const
  GL_SGIX_fog_offset = 1;  
  GL_FOG_OFFSET_SGIX = $8198;  
  GL_FOG_OFFSET_VALUE_SGIX = $8199;  
{////#endif /* GL_SGIX_fog_offset */ }
{////#ifndef GL_SGIX_fragment_lighting }
  GL_SGIX_fragment_lighting = 1;  
  GL_FRAGMENT_LIGHTING_SGIX = $8400;  
  GL_FRAGMENT_COLOR_MATERIAL_SGIX = $8401;  
  GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX = $8402;  
  GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = $8403;  
  GL_MAX_FRAGMENT_LIGHTS_SGIX = $8404;  
  GL_MAX_ACTIVE_LIGHTS_SGIX = $8405;  
  GL_CURRENT_RASTER_NORMAL_SGIX = $8406;  
  GL_LIGHT_ENV_MODE_SGIX = $8407;  
  GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = $8408;  
  GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = $8409;  
  GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = $840A;  
  GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = $840B;  
  GL_FRAGMENT_LIGHT0_SGIX = $840C;  
  GL_FRAGMENT_LIGHT1_SGIX = $840D;  
  GL_FRAGMENT_LIGHT2_SGIX = $840E;  
  GL_FRAGMENT_LIGHT3_SGIX = $840F;  
  GL_FRAGMENT_LIGHT4_SGIX = $8410;  
  GL_FRAGMENT_LIGHT5_SGIX = $8411;  
  GL_FRAGMENT_LIGHT6_SGIX = $8412;  
  GL_FRAGMENT_LIGHT7_SGIX = $8413;  
{////typedef void (P PFNGLFRAGMENTCOLORMATERIALSGIXPROC) (GLenum face, GLenum mode); }
{////typedef void (P PFNGLFRAGMENTLIGHTFSGIXPROC) (GLenum light, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLFRAGMENTLIGHTFVSGIXPROC) (GLenum light, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLFRAGMENTLIGHTISGIXPROC) (GLenum light, GLenum pname, GLint param); }
{////typedef void (P PFNGLFRAGMENTLIGHTIVSGIXPROC) (GLenum light, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLFRAGMENTLIGHTMODELFSGIXPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLFRAGMENTLIGHTMODELFVSGIXPROC) (GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLFRAGMENTLIGHTMODELISGIXPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLFRAGMENTLIGHTMODELIVSGIXPROC) (GLenum pname, const GLint *params); }
{////typedef void (P PFNGLFRAGMENTMATERIALFSGIXPROC) (GLenum face, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLFRAGMENTMATERIALFVSGIXPROC) (GLenum face, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLFRAGMENTMATERIALISGIXPROC) (GLenum face, GLenum pname, GLint param); }
{////typedef void (P PFNGLFRAGMENTMATERIALIVSGIXPROC) (GLenum face, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLGETFRAGMENTLIGHTFVSGIXPROC) (GLenum light, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETFRAGMENTLIGHTIVSGIXPROC) (GLenum light, GLenum pname, GLint *params); }
{////typedef void (P PFNGLGETFRAGMENTMATERIALFVSGIXPROC) (GLenum face, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETFRAGMENTMATERIALIVSGIXPROC) (GLenum face, GLenum pname, GLint *params); }
{////typedef void (P PFNGLLIGHTENVISGIXPROC) (GLenum pname, GLint param); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFragmentColorMaterialSGIX(face:TGLenum; mode:TGLenum);cdecl;external;
procedure glFragmentLightfSGIX(light:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glFragmentLightfvSGIX(light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glFragmentLightiSGIX(light:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glFragmentLightivSGIX(light:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glFragmentLightModelfSGIX(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glFragmentLightModelfvSGIX(pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glFragmentLightModeliSGIX(pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glFragmentLightModelivSGIX(pname:TGLenum; params:PGLint);cdecl;external;
procedure glFragmentMaterialfSGIX(face:TGLenum; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glFragmentMaterialfvSGIX(face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glFragmentMaterialiSGIX(face:TGLenum; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glFragmentMaterialivSGIX(face:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetFragmentLightfvSGIX(light:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetFragmentLightivSGIX(light:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glGetFragmentMaterialfvSGIX(face:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetFragmentMaterialivSGIX(face:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glLightEnviSGIX(pname:TGLenum; param:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_fragment_lighting */ }
{////#ifndef GL_SGIX_framezoom }
const
  GL_SGIX_framezoom = 1;  
  GL_FRAMEZOOM_SGIX = $818B;  
  GL_FRAMEZOOM_FACTOR_SGIX = $818C;  
  GL_MAX_FRAMEZOOM_FACTOR_SGIX = $818D;  
{////typedef void (P PFNGLFRAMEZOOMSGIXPROC) (GLint factor); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFrameZoomSGIX(factor:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_framezoom */ }
{////#ifndef GL_SGIX_igloo_interface }
const
  GL_SGIX_igloo_interface = 1;  
{////typedef void (P PFNGLIGLOOINTERFACESGIXPROC) (GLenum pname, const void *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glIglooInterfaceSGIX(pname:TGLenum; params:pointer);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_igloo_interface */ }
{////#ifndef GL_SGIX_instruments }
const
  GL_SGIX_instruments = 1;  
  GL_INSTRUMENT_BUFFER_POINTER_SGIX = $8180;  
  GL_INSTRUMENT_MEASUREMENTS_SGIX = $8181;  
{////typedef GLint (P PFNGLGETINSTRUMENTSSGIXPROC) (void); }
{////typedef void (P PFNGLINSTRUMENTSBUFFERSGIXPROC) (GLsizei size, GLint *buffer); }
{////typedef GLint (P PFNGLPOLLINSTRUMENTSSGIXPROC) (GLint *marker_p); }
{////typedef void (P PFNGLREADINSTRUMENTSSGIXPROC) (GLint marker); }
{////typedef void (P PFNGLSTARTINSTRUMENTSSGIXPROC) (void); }
{////typedef void (P PFNGLSTOPINSTRUMENTSSGIXPROC) (GLint marker); }
{////#ifdef GL_GLEXT_PROTOTYPES }

function glGetInstrumentsSGIX:TGLint;cdecl;external;
procedure glInstrumentsBufferSGIX(size:TGLsizei; buffer:PGLint);cdecl;external;
function glPollInstrumentsSGIX(marker_p:PGLint):TGLint;cdecl;external;
procedure glReadInstrumentsSGIX(marker:TGLint);cdecl;external;
procedure glStartInstrumentsSGIX;cdecl;external;
procedure glStopInstrumentsSGIX(marker:TGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_instruments */ }
{////#ifndef GL_SGIX_interlace }
const
  GL_SGIX_interlace = 1;  
  GL_INTERLACE_SGIX = $8094;  
{////#endif /* GL_SGIX_interlace */ }
{////#ifndef GL_SGIX_ir_instrument1 }
  GL_SGIX_ir_instrument1 = 1;  
  GL_IR_INSTRUMENT1_SGIX = $817F;  
{////#endif /* GL_SGIX_ir_instrument1 */ }
{////#ifndef GL_SGIX_list_priority }
  GL_SGIX_list_priority = 1;  
  GL_LIST_PRIORITY_SGIX = $8182;  
{////typedef void (P PFNGLGETLISTPARAMETERFVSGIXPROC) (GLuint list, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETLISTPARAMETERIVSGIXPROC) (GLuint list, GLenum pname, GLint *params); }
{////typedef void (P PFNGLLISTPARAMETERFSGIXPROC) (GLuint list, GLenum pname, GLfloat param); }
{////typedef void (P PFNGLLISTPARAMETERFVSGIXPROC) (GLuint list, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLLISTPARAMETERISGIXPROC) (GLuint list, GLenum pname, GLint param); }
{////typedef void (P PFNGLLISTPARAMETERIVSGIXPROC) (GLuint list, GLenum pname, const GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGetListParameterfvSGIX(list:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetListParameterivSGIX(list:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
procedure glListParameterfSGIX(list:TGLuint; pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glListParameterfvSGIX(list:TGLuint; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glListParameteriSGIX(list:TGLuint; pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glListParameterivSGIX(list:TGLuint; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_list_priority */ }
{////#ifndef GL_SGIX_pixel_texture }
const
  GL_SGIX_pixel_texture = 1;  
  GL_PIXEL_TEX_GEN_SGIX = $8139;  
  GL_PIXEL_TEX_GEN_MODE_SGIX = $832B;  
{////typedef void (P PFNGLPIXELTEXGENSGIXPROC) (GLenum mode); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glPixelTexGenSGIX(mode:TGLenum);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_pixel_texture */ }
{////#ifndef GL_SGIX_pixel_tiles }
const
  GL_SGIX_pixel_tiles = 1;  
  GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX = $813E;  
  GL_PIXEL_TILE_CACHE_INCREMENT_SGIX = $813F;  
  GL_PIXEL_TILE_WIDTH_SGIX = $8140;  
  GL_PIXEL_TILE_HEIGHT_SGIX = $8141;  
  GL_PIXEL_TILE_GRID_WIDTH_SGIX = $8142;  
  GL_PIXEL_TILE_GRID_HEIGHT_SGIX = $8143;  
  GL_PIXEL_TILE_GRID_DEPTH_SGIX = $8144;  
  GL_PIXEL_TILE_CACHE_SIZE_SGIX = $8145;  
{////#endif /* GL_SGIX_pixel_tiles */ }
{////#ifndef GL_SGIX_polynomial_ffd }
  GL_SGIX_polynomial_ffd = 1;  
  GL_TEXTURE_DEFORMATION_BIT_SGIX = $00000001;  
  GL_GEOMETRY_DEFORMATION_BIT_SGIX = $00000002;  
  GL_GEOMETRY_DEFORMATION_SGIX = $8194;  
  GL_TEXTURE_DEFORMATION_SGIX = $8195;  
  GL_DEFORMATIONS_MASK_SGIX = $8196;  
  GL_MAX_DEFORMATION_ORDER_SGIX = $8197;  
{////typedef void (P PFNGLDEFORMATIONMAP3DSGIXPROC) (GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, GLdouble w1, GLdouble w2, GLint wstride, GLint worder, const GLdouble *points); }
{////typedef void (P PFNGLDEFORMATIONMAP3FSGIXPROC) (GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, GLfloat w1, GLfloat w2, GLint wstride, GLint worder, const GLfloat *points); }
{////typedef void (P PFNGLDEFORMSGIXPROC) (GLbitfield mask); }
{////typedef void (P PFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC) (GLbitfield mask); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glDeformationMap3dSGIX(target:TGLenum; u1:TGLdouble; u2:TGLdouble; ustride:TGLint; uorder:TGLint; 
            v1:TGLdouble; v2:TGLdouble; vstride:TGLint; vorder:TGLint; w1:TGLdouble; 
            w2:TGLdouble; wstride:TGLint; worder:TGLint; points:PGLdouble);cdecl;external;
(* Const before type ignored *)
procedure glDeformationMap3fSGIX(target:TGLenum; u1:TGLfloat; u2:TGLfloat; ustride:TGLint; uorder:TGLint; 
            v1:TGLfloat; v2:TGLfloat; vstride:TGLint; vorder:TGLint; w1:TGLfloat; 
            w2:TGLfloat; wstride:TGLint; worder:TGLint; points:PGLfloat);cdecl;external;
procedure glDeformSGIX(mask:TGLbitfield);cdecl;external;
procedure glLoadIdentityDeformationMapSGIX(mask:TGLbitfield);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_polynomial_ffd */ }
{////#ifndef GL_SGIX_reference_plane }
const
  GL_SGIX_reference_plane = 1;  
  GL_REFERENCE_PLANE_SGIX = $817D;  
  GL_REFERENCE_PLANE_EQUATION_SGIX = $817E;  
{////typedef void (P PFNGLREFERENCEPLANESGIXPROC) (const GLdouble *equation); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glReferencePlaneSGIX(equation:PGLdouble);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_reference_plane */ }
{////#ifndef GL_SGIX_resample }
const
  GL_SGIX_resample = 1;  
  GL_PACK_RESAMPLE_SGIX = $842E;  
  GL_UNPACK_RESAMPLE_SGIX = $842F;  
  GL_RESAMPLE_REPLICATE_SGIX = $8433;  
  GL_RESAMPLE_ZERO_FILL_SGIX = $8434;  
  GL_RESAMPLE_DECIMATE_SGIX = $8430;  
{////#endif /* GL_SGIX_resample */ }
{////#ifndef GL_SGIX_scalebias_hint }
  GL_SGIX_scalebias_hint = 1;  
  GL_SCALEBIAS_HINT_SGIX = $8322;  
{////#endif /* GL_SGIX_scalebias_hint */ }
{////#ifndef GL_SGIX_shadow }
  GL_SGIX_shadow = 1;  
  GL_TEXTURE_COMPARE_SGIX = $819A;  
  GL_TEXTURE_COMPARE_OPERATOR_SGIX = $819B;  
  GL_TEXTURE_LEQUAL_R_SGIX = $819C;  
  GL_TEXTURE_GEQUAL_R_SGIX = $819D;  
{////#endif /* GL_SGIX_shadow */ }
{////#ifndef GL_SGIX_shadow_ambient }
  GL_SGIX_shadow_ambient = 1;  
  GL_SHADOW_AMBIENT_SGIX = $80BF;  
{////#endif /* GL_SGIX_shadow_ambient */ }
{////#ifndef GL_SGIX_sprite }
  GL_SGIX_sprite = 1;  
  GL_SPRITE_SGIX = $8148;  
  GL_SPRITE_MODE_SGIX = $8149;  
  GL_SPRITE_AXIS_SGIX = $814A;  
  GL_SPRITE_TRANSLATION_SGIX = $814B;  
  GL_SPRITE_AXIAL_SGIX = $814C;  
  GL_SPRITE_OBJECT_ALIGNED_SGIX = $814D;  
  GL_SPRITE_EYE_ALIGNED_SGIX = $814E;  
{////typedef void (P PFNGLSPRITEPARAMETERFSGIXPROC) (GLenum pname, GLfloat param); }
{////typedef void (P PFNGLSPRITEPARAMETERFVSGIXPROC) (GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLSPRITEPARAMETERISGIXPROC) (GLenum pname, GLint param); }
{////typedef void (P PFNGLSPRITEPARAMETERIVSGIXPROC) (GLenum pname, const GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glSpriteParameterfSGIX(pname:TGLenum; param:TGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glSpriteParameterfvSGIX(pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glSpriteParameteriSGIX(pname:TGLenum; param:TGLint);cdecl;external;
(* Const before type ignored *)
procedure glSpriteParameterivSGIX(pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_sprite */ }
{////#ifndef GL_SGIX_subsample }
const
  GL_SGIX_subsample = 1;  
  GL_PACK_SUBSAMPLE_RATE_SGIX = $85A0;  
  GL_UNPACK_SUBSAMPLE_RATE_SGIX = $85A1;  
  GL_PIXEL_SUBSAMPLE_4444_SGIX = $85A2;  
  GL_PIXEL_SUBSAMPLE_2424_SGIX = $85A3;  
  GL_PIXEL_SUBSAMPLE_4242_SGIX = $85A4;  
{////#endif /* GL_SGIX_subsample */ }
{////#ifndef GL_SGIX_tag_sample_buffer }
  GL_SGIX_tag_sample_buffer = 1;  
{////typedef void (P PFNGLTAGSAMPLEBUFFERSGIXPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glTagSampleBufferSGIX;cdecl;external;
{////#endif }
{////#endif /* GL_SGIX_tag_sample_buffer */ }
{////#ifndef GL_SGIX_texture_add_env }
const
  GL_SGIX_texture_add_env = 1;  
  GL_TEXTURE_ENV_BIAS_SGIX = $80BE;  
{////#endif /* GL_SGIX_texture_add_env */ }
{////#ifndef GL_SGIX_texture_coordinate_clamp }
  GL_SGIX_texture_coordinate_clamp = 1;  
  GL_TEXTURE_MAX_CLAMP_S_SGIX = $8369;  
  GL_TEXTURE_MAX_CLAMP_T_SGIX = $836A;  
  GL_TEXTURE_MAX_CLAMP_R_SGIX = $836B;  
{////#endif /* GL_SGIX_texture_coordinate_clamp */ }
{////#ifndef GL_SGIX_texture_lod_bias }
  GL_SGIX_texture_lod_bias = 1;  
  GL_TEXTURE_LOD_BIAS_S_SGIX = $818E;  
  GL_TEXTURE_LOD_BIAS_T_SGIX = $818F;  
  GL_TEXTURE_LOD_BIAS_R_SGIX = $8190;  
{////#endif /* GL_SGIX_texture_lod_bias */ }
{////#ifndef GL_SGIX_texture_multi_buffer }
  GL_SGIX_texture_multi_buffer = 1;  
  GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = $812E;  
{////#endif /* GL_SGIX_texture_multi_buffer */ }
{////#ifndef GL_SGIX_texture_scale_bias }
  GL_SGIX_texture_scale_bias = 1;  
  GL_POST_TEXTURE_FILTER_BIAS_SGIX = $8179;  
  GL_POST_TEXTURE_FILTER_SCALE_SGIX = $817A;  
  GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = $817B;  
  GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = $817C;  
{////#endif /* GL_SGIX_texture_scale_bias */ }
{////#ifndef GL_SGIX_vertex_preclip }
  GL_SGIX_vertex_preclip = 1;  
  GL_VERTEX_PRECLIP_SGIX = $83EE;  
  GL_VERTEX_PRECLIP_HINT_SGIX = $83EF;  
{////#endif /* GL_SGIX_vertex_preclip */ }
{////#ifndef GL_SGIX_ycrcb }
  GL_SGIX_ycrcb = 1;  
  GL_YCRCB_422_SGIX = $81BB;  
  GL_YCRCB_444_SGIX = $81BC;  
{////#endif /* GL_SGIX_ycrcb */ }
{////#ifndef GL_SGIX_ycrcb_subsample }
  GL_SGIX_ycrcb_subsample = 1;  
{////#endif /* GL_SGIX_ycrcb_subsample */ }
{////#ifndef GL_SGIX_ycrcba }
  GL_SGIX_ycrcba = 1;  
  GL_YCRCB_SGIX = $8318;  
  GL_YCRCBA_SGIX = $8319;  
{////#endif /* GL_SGIX_ycrcba */ }
{////#ifndef GL_SGI_color_matrix }
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
{////#endif /* GL_SGI_color_matrix */ }
{////#ifndef GL_SGI_color_table }
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
{////typedef void (P PFNGLCOLORTABLESGIPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table); }
{////typedef void (P PFNGLCOLORTABLEPARAMETERFVSGIPROC) (GLenum target, GLenum pname, const GLfloat *params); }
{////typedef void (P PFNGLCOLORTABLEPARAMETERIVSGIPROC) (GLenum target, GLenum pname, const GLint *params); }
{////typedef void (P PFNGLCOPYCOLORTABLESGIPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width); }
{////typedef void (P PFNGLGETCOLORTABLESGIPROC) (GLenum target, GLenum format, GLenum type, void *table); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERFVSGIPROC) (GLenum target, GLenum pname, GLfloat *params); }
{////typedef void (P PFNGLGETCOLORTABLEPARAMETERIVSGIPROC) (GLenum target, GLenum pname, GLint *params); }
{////#ifdef GL_GLEXT_PROTOTYPES }
(* Const before type ignored *)

procedure glColorTableSGI(target:TGLenum; internalformat:TGLenum; width:TGLsizei; format:TGLenum; _type:TGLenum; 
            table:pointer);cdecl;external;
(* Const before type ignored *)
procedure glColorTableParameterfvSGI(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
(* Const before type ignored *)
procedure glColorTableParameterivSGI(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
procedure glCopyColorTableSGI(target:TGLenum; internalformat:TGLenum; x:TGLint; y:TGLint; width:TGLsizei);cdecl;external;
procedure glGetColorTableSGI(target:TGLenum; format:TGLenum; _type:TGLenum; table:pointer);cdecl;external;
procedure glGetColorTableParameterfvSGI(target:TGLenum; pname:TGLenum; params:PGLfloat);cdecl;external;
procedure glGetColorTableParameterivSGI(target:TGLenum; pname:TGLenum; params:PGLint);cdecl;external;
{////#endif }
{////#endif /* GL_SGI_color_table */ }
{////#ifndef GL_SGI_texture_color_table }
const
  GL_SGI_texture_color_table = 1;  
  GL_TEXTURE_COLOR_TABLE_SGI = $80BC;  
  GL_PROXY_TEXTURE_COLOR_TABLE_SGI = $80BD;  
{////#endif /* GL_SGI_texture_color_table */ }
{////#ifndef GL_SUNX_constant_data }
  GL_SUNX_constant_data = 1;  
  GL_UNPACK_CONSTANT_DATA_SUNX = $81D5;  
  GL_TEXTURE_CONSTANT_DATA_SUNX = $81D6;  
{////typedef void (P PFNGLFINISHTEXTURESUNXPROC) (void); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glFinishTextureSUNX;cdecl;external;
{////#endif }
{////#endif /* GL_SUNX_constant_data */ }
{////#ifndef GL_SUN_convolution_border_modes }
const
  GL_SUN_convolution_border_modes = 1;  
  GL_WRAP_BORDER_SUN = $81D4;  
{////#endif /* GL_SUN_convolution_border_modes */ }
{////#ifndef GL_SUN_global_alpha }
  GL_SUN_global_alpha = 1;  
  GL_GLOBAL_ALPHA_SUN = $81D9;  
  GL_GLOBAL_ALPHA_FACTOR_SUN = $81DA;  
{////typedef void (P PFNGLGLOBALALPHAFACTORBSUNPROC) (GLbyte factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORSSUNPROC) (GLshort factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORISUNPROC) (GLint factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORFSUNPROC) (GLfloat factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORDSUNPROC) (GLdouble factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORUBSUNPROC) (GLubyte factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORUSSUNPROC) (GLushort factor); }
{////typedef void (P PFNGLGLOBALALPHAFACTORUISUNPROC) (GLuint factor); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glGlobalAlphaFactorbSUN(factor:TGLbyte);cdecl;external;
procedure glGlobalAlphaFactorsSUN(factor:TGLshort);cdecl;external;
procedure glGlobalAlphaFactoriSUN(factor:TGLint);cdecl;external;
procedure glGlobalAlphaFactorfSUN(factor:TGLfloat);cdecl;external;
procedure glGlobalAlphaFactordSUN(factor:TGLdouble);cdecl;external;
procedure glGlobalAlphaFactorubSUN(factor:TGLubyte);cdecl;external;
procedure glGlobalAlphaFactorusSUN(factor:TGLushort);cdecl;external;
procedure glGlobalAlphaFactoruiSUN(factor:TGLuint);cdecl;external;
{////#endif }
{////#endif /* GL_SUN_global_alpha */ }
{////#ifndef GL_SUN_mesh_array }
const
  GL_SUN_mesh_array = 1;  
  GL_QUAD_MESH_SUN = $8614;  
  GL_TRIANGLE_MESH_SUN = $8615;  
{////typedef void (P PFNGLDRAWMESHARRAYSSUNPROC) (GLenum mode, GLint first, GLsizei count, GLsizei width); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glDrawMeshArraysSUN(mode:TGLenum; first:TGLint; count:TGLsizei; width:TGLsizei);cdecl;external;
{////#endif }
{////#endif /* GL_SUN_mesh_array */ }
{////#ifndef GL_SUN_slice_accum }
const
  GL_SUN_slice_accum = 1;  
  GL_SLICE_ACCUM_SUN = $85CC;  
{////#endif /* GL_SUN_slice_accum */ }
{////#ifndef GL_SUN_triangle_list }
  GL_SUN_triangle_list = 1;  
  GL_RESTART_SUN = $0001;  
  GL_REPLACE_MIDDLE_SUN = $0002;  
  GL_REPLACE_OLDEST_SUN = $0003;  
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
{////typedef void (P PFNGLREPLACEMENTCODEUISUNPROC) (GLuint code); }
{////typedef void (P PFNGLREPLACEMENTCODEUSSUNPROC) (GLushort code); }
{////typedef void (P PFNGLREPLACEMENTCODEUBSUNPROC) (GLubyte code); }
{////typedef void (P PFNGLREPLACEMENTCODEUIVSUNPROC) (const GLuint *code); }
{////typedef void (P PFNGLREPLACEMENTCODEUSVSUNPROC) (const GLushort *code); }
{////typedef void (P PFNGLREPLACEMENTCODEUBVSUNPROC) (const GLubyte *code); }
{////typedef void (P PFNGLREPLACEMENTCODEPOINTERSUNPROC) (GLenum type, GLsizei stride, const void **pointer); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glReplacementCodeuiSUN(code:TGLuint);cdecl;external;
procedure glReplacementCodeusSUN(code:TGLushort);cdecl;external;
procedure glReplacementCodeubSUN(code:TGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glReplacementCodeuivSUN(code:PGLuint);cdecl;external;
(* Const before type ignored *)
procedure glReplacementCodeusvSUN(code:PGLushort);cdecl;external;
(* Const before type ignored *)
procedure glReplacementCodeubvSUN(code:PGLubyte);cdecl;external;
(* Const before type ignored *)
procedure glReplacementCodePointerSUN(_type:TGLenum; stride:TGLsizei; pointer:Ppointer);cdecl;external;
{////#endif }
{////#endif /* GL_SUN_triangle_list */ }
{////#ifndef GL_SUN_vertex }
const
  GL_SUN_vertex = 1;  
{////typedef void (P PFNGLCOLOR4UBVERTEX2FSUNPROC) (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y); }
{////typedef void (P PFNGLCOLOR4UBVERTEX2FVSUNPROC) (const GLubyte *c, const GLfloat *v); }
{////typedef void (P PFNGLCOLOR4UBVERTEX3FSUNPROC) (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLCOLOR4UBVERTEX3FVSUNPROC) (const GLubyte *c, const GLfloat *v); }
{////typedef void (P PFNGLCOLOR3FVERTEX3FSUNPROC) (GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLCOLOR3FVERTEX3FVSUNPROC) (const GLfloat *c, const GLfloat *v); }
{////typedef void (P PFNGLNORMAL3FVERTEX3FSUNPROC) (GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *c, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD2FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLTEXCOORD2FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD4FVERTEX4FSUNPROC) (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLTEXCOORD4FVERTEX4FVSUNPROC) (const GLfloat *tc, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC) (const GLfloat *tc, const GLubyte *c, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC) (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z, GLfloat w); }
{////typedef void (P PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC) (GLuint rc, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC) (GLuint rc, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC) (const GLuint *rc, const GLubyte *c, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC) (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *c, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *c, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *n, const GLfloat *v); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z); }
{////typedef void (P PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v); }
{////#ifdef GL_GLEXT_PROTOTYPES }

procedure glColor4ubVertex2fSUN(r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte; x:TGLfloat; 
            y:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glColor4ubVertex2fvSUN(c:PGLubyte; v:PGLfloat);cdecl;external;
procedure glColor4ubVertex3fSUN(r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte; x:TGLfloat; 
            y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glColor4ubVertex3fvSUN(c:PGLubyte; v:PGLfloat);cdecl;external;
procedure glColor3fVertex3fSUN(r:TGLfloat; g:TGLfloat; b:TGLfloat; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glColor3fVertex3fvSUN(c:PGLfloat; v:PGLfloat);cdecl;external;
procedure glNormal3fVertex3fSUN(nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glNormal3fVertex3fvSUN(n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glColor4fNormal3fVertex3fSUN(r:TGLfloat; g:TGLfloat; b:TGLfloat; a:TGLfloat; nx:TGLfloat; 
            ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glColor4fNormal3fVertex3fvSUN(c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord2fVertex3fSUN(s:TGLfloat; t:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord2fVertex3fvSUN(tc:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord4fVertex4fSUN(s:TGLfloat; t:TGLfloat; p:TGLfloat; q:TGLfloat; x:TGLfloat; 
            y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord4fVertex4fvSUN(tc:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord2fColor4ubVertex3fSUN(s:TGLfloat; t:TGLfloat; r:TGLubyte; g:TGLubyte; b:TGLubyte; 
            a:TGLubyte; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord2fColor4ubVertex3fvSUN(tc:PGLfloat; c:PGLubyte; v:PGLfloat);cdecl;external;
procedure glTexCoord2fColor3fVertex3fSUN(s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat; b:TGLfloat; 
            x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord2fColor3fVertex3fvSUN(tc:PGLfloat; c:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord2fNormal3fVertex3fSUN(s:TGLfloat; t:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; 
            x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord2fNormal3fVertex3fvSUN(tc:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord2fColor4fNormal3fVertex3fSUN(s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat; b:TGLfloat; 
            a:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; 
            y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord2fColor4fNormal3fVertex3fvSUN(tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glTexCoord4fColor4fNormal3fVertex4fSUN(s:TGLfloat; t:TGLfloat; p:TGLfloat; q:TGLfloat; r:TGLfloat; 
            g:TGLfloat; b:TGLfloat; a:TGLfloat; nx:TGLfloat; ny:TGLfloat; 
            nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat; w:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glTexCoord4fColor4fNormal3fVertex4fvSUN(tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiVertex3fSUN(rc:TGLuint; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiVertex3fvSUN(rc:PGLuint; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiColor4ubVertex3fSUN(rc:TGLuint; r:TGLubyte; g:TGLubyte; b:TGLubyte; a:TGLubyte; 
            x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiColor4ubVertex3fvSUN(rc:PGLuint; c:PGLubyte; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiColor3fVertex3fSUN(rc:TGLuint; r:TGLfloat; g:TGLfloat; b:TGLfloat; x:TGLfloat; 
            y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiColor3fVertex3fvSUN(rc:PGLuint; c:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiNormal3fVertex3fSUN(rc:TGLuint; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; 
            y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiNormal3fVertex3fvSUN(rc:PGLuint; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiColor4fNormal3fVertex3fSUN(rc:TGLuint; r:TGLfloat; g:TGLfloat; b:TGLfloat; a:TGLfloat; 
            nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiColor4fNormal3fVertex3fvSUN(rc:PGLuint; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiTexCoord2fVertex3fSUN(rc:TGLuint; s:TGLfloat; t:TGLfloat; x:TGLfloat; y:TGLfloat; 
            z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiTexCoord2fVertex3fvSUN(rc:PGLuint; tc:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN(rc:TGLuint; s:TGLfloat; t:TGLfloat; nx:TGLfloat; ny:TGLfloat; 
            nz:TGLfloat; x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN(rc:PGLuint; tc:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
procedure glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(rc:TGLuint; s:TGLfloat; t:TGLfloat; r:TGLfloat; g:TGLfloat; 
            b:TGLfloat; a:TGLfloat; nx:TGLfloat; ny:TGLfloat; nz:TGLfloat; 
            x:TGLfloat; y:TGLfloat; z:TGLfloat);cdecl;external;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN(rc:PGLuint; tc:PGLfloat; c:PGLfloat; n:PGLfloat; v:PGLfloat);cdecl;external;
{////#endif }
{////#endif /* GL_SUN_vertex */ }
{////#ifndef GL_WIN_phong_shading }
const
  GL_WIN_phong_shading = 1;  
  GL_PHONG_WIN = $80EA;  
  GL_PHONG_HINT_WIN = $80EB;  
{////#endif /* GL_WIN_phong_shading */ }
{////#ifndef GL_WIN_specular_fog }
  GL_WIN_specular_fog = 1;  
  GL_FOG_SPECULAR_TEXTURE_WIN = $80EC;  
{////#endif /* GL_WIN_specular_fog */ }
{////#ifndef GL_MESA_texture_const_bandwidth }
  GL_MESA_texture_const_bandwidth = 1;  
  GL_CONST_BW_TILING_MESA = $8BBE;  
{////#endif }
{////#ifdef __cplusplus }
{//// }
{////#endif }
{////#endif }

implementation


end.
