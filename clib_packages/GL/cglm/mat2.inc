{$IFDEF read_interface}


procedure glmc_mat2_copy(mat: Tmat2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_identity(mat: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_identity_array(mat: Pmat2; count: SizeUInt); cdecl; external libcglm;
procedure glmc_mat2_zero(mat: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_mul(m1: Tmat2; m2: Tmat2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_transpose_to(m: Tmat2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_transpose(m: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_mulv(m: Tmat2; v: Tvec2; dest: Tvec2); cdecl; external libcglm;
function glmc_mat2_trace(m: Tmat2): single; cdecl; external libcglm;
procedure glmc_mat2_scale(m: Tmat2; s: single); cdecl; external libcglm;
function glmc_mat2_det(mat: Tmat2): single; cdecl; external libcglm;
procedure glmc_mat2_inv(mat: Tmat2; dest: Tmat2); cdecl; external libcglm;
procedure glmc_mat2_swap_col(mat: Tmat2; col1: longint; col2: longint); cdecl; external libcglm;
procedure glmc_mat2_swap_row(mat: Tmat2; row1: longint; row2: longint); cdecl; external libcglm;
function glmc_mat2_rmc(r: Tvec2; m: Tmat2; c: Tvec2): single; cdecl; external libcglm;
procedure glmc_mat2_make(src: Psingle; dest: Tmat2); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:38 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
