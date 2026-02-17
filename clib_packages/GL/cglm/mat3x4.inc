{$IFDEF read_interface}


procedure glmc_mat3x4_copy(mat: Tmat3x4; dest: Tmat3x4); cdecl; external libcglm;
procedure glmc_mat3x4_zero(mat: Tmat3x4); cdecl; external libcglm;
procedure glmc_mat3x4_make(src: Psingle; dest: Tmat3x4); cdecl; external libcglm;
procedure glmc_mat3x4_mul(m1: Tmat3x4; m2: Tmat4x3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3x4_mulv(m: Tmat3x4; v: Tvec4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_mat3x4_transpose(m: Tmat3x4; dest: Tmat4x3); cdecl; external libcglm;
procedure glmc_mat3x4_scale(m: Tmat3x4; s: single); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:24 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
