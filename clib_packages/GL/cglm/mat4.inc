{$IFDEF read_interface}


procedure glmc_mat4_ucopy(mat: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_copy(mat: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_identity(mat: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_identity_array(mat: Pmat4; count: SizeUInt); cdecl; external libcglm;
procedure glmc_mat4_zero(mat: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_pick3(mat: Tmat4; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat4_pick3t(mat: Tmat4; dest: Tmat3); cdecl; external libcglm;
procedure glmc_mat4_ins3(mat: Tmat3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_mul(m1: Tmat4; m2: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_mulN(matrices: PPmat4; len: uint32; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_mulv(m: Tmat4; v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_mat4_mulv3(m: Tmat4; v: Tvec3; last: single; dest: Tvec3); cdecl; external libcglm;
function glmc_mat4_trace(m: Tmat4): single; cdecl; external libcglm;
function glmc_mat4_trace3(m: Tmat4): single; cdecl; external libcglm;
procedure glmc_mat4_quat(m: Tmat4; dest: Tversor); cdecl; external libcglm;
procedure glmc_mat4_transpose_to(m: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_transpose(m: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_scale_p(m: Tmat4; s: single); cdecl; external libcglm;
procedure glmc_mat4_scale(m: Tmat4; s: single); cdecl; external libcglm;
function glmc_mat4_det(mat: Tmat4): single; cdecl; external libcglm;
procedure glmc_mat4_inv(mat: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_inv_precise(mat: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_inv_fast(mat: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mat4_swap_col(mat: Tmat4; col1: longint; col2: longint); cdecl; external libcglm;
procedure glmc_mat4_swap_row(mat: Tmat4; row1: longint; row2: longint); cdecl; external libcglm;
function glmc_mat4_rmc(r: Tvec4; m: Tmat4; c: Tvec4): single; cdecl; external libcglm;
procedure glmc_mat4_make(src: Psingle; dest: Tmat4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:21 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}


{$ENDIF read_implementation}
