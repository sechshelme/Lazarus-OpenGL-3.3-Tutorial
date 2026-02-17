{$IFDEF read_interface}


procedure glmc_mat3_copy(mat: Tmat3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_identity(mat: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_zero(mat: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_identity_array(mat: Pmat3; count: SizeUInt); cdecl; external libcglm;
procedure glmc_mat3_mul(m1: Tmat3; m2: Tmat3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_transpose_to(m: Tmat3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_transpose(m: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_mulv(m: Tmat3; v: Tvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_mat3_trace(m: Tmat3): single; cdecl; external libcglm;
procedure glmc_mat3_quat(m: Tmat3; dest: Tversor); cdecl; external libcglm;
procedure glmc_mat3_scale(m: Tmat3; s: single); cdecl; external libcglm;
function glmc_mat3_det(mat: Tmat3): single; cdecl; external libcglm;
procedure glmc_mat3_inv(mat: Tmat3; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat3_swap_col(mat: Tmat3; col1: longint; col2: longint); cdecl; external libcglm;
procedure glmc_mat3_swap_row(mat: Tmat3; row1: longint; row2: longint); cdecl; external libcglm;
function glmc_mat3_rmc(r: Tvec3; m: Tmat3; c: Tvec3): single; cdecl; external libcglm;
procedure glmc_mat3_make(src: Psingle; dest: Tmat3); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:30 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
