{$IFDEF read_interface}


procedure glmc_mat3x2_copy(mat: Tmat3x2; dest: Tmat3x2); cdecl; external libcglm;
procedure glmc_mat3x2_zero(mat: Tmat3x2); cdecl; external libcglm;
procedure glmc_mat3x2_make(src: Psingle; dest: Tmat3x2); cdecl; external libcglm;
procedure glmc_mat3x2_mul(m1: Tmat3x2; m2: Tmat2x3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3x2_mulv(m: Tmat3x2; v: Tvec2; dest: Tvec3); cdecl; external libcglm;
procedure glmc_mat3x2_transpose(m: Tmat3x2; dest: Tmat2x3); cdecl; external libcglm;
procedure glmc_mat3x2_scale(m: Tmat3x2; s: single); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:27 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
