{$IFDEF read_interface}



procedure glmc_mat4x2_copy(mat: Tmat4x2; dest: Tmat4x2); cdecl; external libcglm;
procedure glmc_mat4x2_zero(mat: Tmat4x2); cdecl; external libcglm;
procedure glmc_mat4x2_make(src: Psingle; dest: Tmat4x2); cdecl; external libcglm;
procedure glmc_mat4x2_mul(m1: Tmat4x2; m2: Tmat2x4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4x2_mulv(m: Tmat4x2; v: Tvec2; dest: Tvec4); cdecl; external libcglm;
procedure glmc_mat4x2_transpose(m: Tmat4x2; dest: Tmat2x4); cdecl; external libcglm;
procedure glmc_mat4x2_scale(m: Tmat4x2; s: single); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:18 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
