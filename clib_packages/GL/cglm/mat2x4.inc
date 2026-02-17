{$IFDEF read_interface}


procedure glmc_mat2x4_copy(mat: Tmat2x4; dest: Tmat2x4); cdecl; external libcglm;
procedure glmc_mat2x4_zero(mat: Tmat2x4); cdecl; external libcglm;
procedure glmc_mat2x4_make(src: Psingle; dest: Tmat2x4); cdecl; external libcglm;
procedure glmc_mat2x4_mul(m1: Tmat2x4; m2: Tmat4x2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2x4_mulv(m: Tmat2x4; v: Tvec4; dest: Tvec2); cdecl; external libcglm;
procedure glmc_mat2x4_transpose(m: Tmat2x4; dest: Tmat4x2); cdecl; external libcglm;
procedure glmc_mat2x4_scale(m: Tmat2x4; s: single); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:33 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
