{$IFDEF read_interface}



procedure glmc_mat2x3_copy(mat: Tmat2x3; dest: Tmat2x3); cdecl; external libcglm;
procedure glmc_mat2x3_zero(mat: Tmat2x3); cdecl; external libcglm;
procedure glmc_mat2x3_make(src: Psingle; dest: Tmat2x3); cdecl; external libcglm;
procedure glmc_mat2x3_mul(m1: Tmat2x3; m2: Tmat3x2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2x3_mulv(m: Tmat2x3; v: Tvec3; dest: Tvec2); cdecl; external libcglm;
procedure glmc_mat2x3_transpose(m: Tmat2x3; dest: Tmat3x2); cdecl; external libcglm;
procedure glmc_mat2x3_scale(m: Tmat2x3; s: single); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:36 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
