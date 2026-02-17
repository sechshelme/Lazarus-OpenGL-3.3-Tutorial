unit fp_cglm;

interface

//{$HINTS ON}
{$WARN 3187 OFF} // Schaltet speziell "C arrays are passed by reference" aus


const
  {$ifdef linux}
  libcglm = 'cglm';
  {$endif}

  {$ifdef windows}
  libcglm = 'libcglm-0.dll';
  {$endif}

type
  PFILE = type Pointer;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

  // ==== /usr/include/cglm/euler.h

type
  Pglm_euler_seq = ^Tglm_euler_seq;
  Tglm_euler_seq = longint;

const
  GLM_EULER_XYZ = ((0 shl 0) or (1 shl 2)) or (2 shl 4);
  GLM_EULER_XZY = ((0 shl 0) or (2 shl 2)) or (1 shl 4);
  GLM_EULER_YZX = ((1 shl 0) or (2 shl 2)) or (0 shl 4);
  GLM_EULER_YXZ = ((1 shl 0) or (0 shl 2)) or (2 shl 4);
  GLM_EULER_ZXY = ((2 shl 0) or (0 shl 2)) or (1 shl 4);
  GLM_EULER_ZYX = ((2 shl 0) or (1 shl 2)) or (0 shl 4);


  // ==== /usr/include/cglm/types.h

type
  Pivec2 = ^Tivec2;
  Tivec2 = array[0..1] of longint;

  Pivec3 = ^Tivec3;
  Tivec3 = array[0..2] of longint;

  Pivec4 = ^Tivec4;
  Tivec4 = array[0..3] of longint;

  Pvec2 = ^Tvec2;
  Tvec2 = array[0..1] of single;

  Pvec3 = ^Tvec3;
  Tvec3 = array[0..2] of single;

  Pvec4 = ^Tvec4;
  Tvec4 = array[0..3] of single;

  Pversor = ^Tversor;
  Tversor = Tvec4;

  Pmat3 = ^Tmat3;
  Tmat3 = array[0..2] of Tvec3;

  Pmat3x2 = ^Tmat3x2;
  Tmat3x2 = array[0..2] of Tvec2;

  Pmat3x4 = ^Tmat3x4;
  Tmat3x4 = array[0..2] of Tvec4;

  Pmat2 = ^Tmat2;
  Tmat2 = array[0..1] of Tvec2;

  Pmat2x3 = ^Tmat2x3;
  Tmat2x3 = array[0..1] of Tvec3;

  Pmat2x4 = ^Tmat2x4;
  Tmat2x4 = array[0..1] of Tvec4;

  PPmat4 = ^Pmat4;
  Pmat4 = ^Tmat4;
  Tmat4 = array[0..3] of Tvec4;

  Pmat4x2 = ^Tmat4x2;
  Tmat4x2 = array[0..3] of Tvec2;

  Pmat4x3 = ^Tmat4x3;
  Tmat4x3 = array[0..3] of Tvec3;

const
  GLM_E = 2.71828182845904523536028747135266250;
  GLM_LOG2E = 1.44269504088896340735992468100189214;
  GLM_LOG10E = 0.434294481903251827651128918916605082;
  GLM_LN2 = 0.693147180559945309417232121458176568;
  GLM_LN10 = 2.30258509299404568401799145468436421;
  GLM_PI = 3.14159265358979323846264338327950288;
  GLM_PI_2 = 1.57079632679489661923132169163975144;
  GLM_PI_4 = 0.785398163397448309615660845819875721;
  GLM_1_PI = 0.318309886183790671537767526745028724;
  GLM_2_PI = 0.636619772367581343075535053490057448;
  GLM_2_SQRTPI = 1.12837916709551257389615890312154517;
  GLM_SQRT2 = 1.41421356237309504880168872420969808;
  GLM_SQRT1_2 = 0.707106781186547524400844362104849039;

function GLM_Ef: single;
function GLM_LOG2Ef: single;
function GLM_LOG10Ef: single;
function GLM_LN2f: single;
function GLM_LN10f: single;
function GLM_PIf: single;
function GLM_PI_2f: single;
function GLM_PI_4f: single;
function GLM_1_PIf: single;
function GLM_2_PIf: single;
function GLM_2_SQRTPIf: single;
function GLM_SQRT2f: single;
function GLM_SQRT1_2f: single;

// ====


{$DEFINE read_interface}
{$include fp_cglm_includes.inc}
{$UNDEF read_interface}

implementation

{$DEFINE read_implementation}
{$include fp_cglm_includes.inc}
{$UNDEF read_implementation}

function GLM_Ef: single;
begin
  GLM_Ef := single(GLM_E);
end;

function GLM_LOG2Ef: single;
begin
  GLM_LOG2Ef := single(GLM_LOG2E);
end;

function GLM_LOG10Ef: single;
begin
  GLM_LOG10Ef := single(GLM_LOG10E);
end;

function GLM_LN2f: single;
begin
  GLM_LN2f := single(GLM_LN2);
end;

function GLM_LN10f: single;
begin
  GLM_LN10f := single(GLM_LN10);
end;

function GLM_PIf: single;
begin
  GLM_PIf := single(GLM_PI);
end;

function GLM_PI_2f: single;
begin
  GLM_PI_2f := single(GLM_PI_2);
end;

function GLM_PI_4f: single;
begin
  GLM_PI_4f := single(GLM_PI_4);
end;

function GLM_1_PIf: single;
begin
  GLM_1_PIf := single(GLM_1_PI);
end;

function GLM_2_PIf: single;
begin
  GLM_2_PIf := single(GLM_2_PI);
end;

function GLM_2_SQRTPIf: single;
begin
  GLM_2_SQRTPIf := single(GLM_2_SQRTPI);
end;

function GLM_SQRT2f: single;
begin
  GLM_SQRT2f := single(GLM_SQRT2);
end;

function GLM_SQRT1_2f: single;
begin
  GLM_SQRT1_2f := single(GLM_SQRT1_2);
end;

end.
