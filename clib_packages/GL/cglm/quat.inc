{$IFDEF read_interface}


procedure glmc_quat_identity(q: Tversor); cdecl; external libcglm;
procedure glmc_quat_identity_array(q: Pversor; count: SizeUInt); cdecl; external libcglm;
procedure glmc_quat_init(q: Tversor; x: single; y: single; z: single; w: single); cdecl; external libcglm;
procedure glmc_quat(q: Tversor; angle: single; x: single; y: single; z: single); cdecl; external libcglm;
procedure glmc_quatv(q: Tversor; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_quat_copy(q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_from_vecs(a: Tvec3; b: Tvec3; dest: Tversor); cdecl; external libcglm;
function glmc_quat_norm(q: Tversor): single; cdecl; external libcglm;
procedure glmc_quat_normalize_to(q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_normalize(q: Tversor); cdecl; external libcglm;
function glmc_quat_dot(p: Tversor; q: Tversor): single; cdecl; external libcglm;
procedure glmc_quat_conjugate(q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_inv(q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_add(p: Tversor; q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_sub(p: Tversor; q: Tversor; dest: Tversor); cdecl; external libcglm;
function glmc_quat_real(q: Tversor): single; cdecl; external libcglm;
procedure glmc_quat_imag(q: Tversor; dest: Tvec3); cdecl; external libcglm;
procedure glmc_quat_imagn(q: Tversor; dest: Tvec3); cdecl; external libcglm;
function glmc_quat_imaglen(q: Tversor): single; cdecl; external libcglm;
function glmc_quat_angle(q: Tversor): single; cdecl; external libcglm;
procedure glmc_quat_axis(q: Tversor; dest: Tvec3); cdecl; external libcglm;
procedure glmc_quat_mul(p: Tversor; q: Tversor; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_mat4(q: Tversor; dest: Tmat4); cdecl; external libcglm;
procedure glmc_quat_mat4t(q: Tversor; dest: Tmat4); cdecl; external libcglm;
procedure glmc_quat_mat3(q: Tversor; dest: Tmat3); cdecl; external libcglm;
procedure glmc_quat_mat3t(q: Tversor; dest: Tmat3); cdecl; external libcglm;
procedure glmc_quat_lerp(from: Tversor; to_: Tversor; t: single; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_lerpc(from: Tversor; to_: Tversor; t: single; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_nlerp(q: Tversor; r: Tversor; t: single; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_slerp(q: Tversor; r: Tversor; t: single; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_look(eye: Tvec3; ori: Tversor; dest: Tmat4); cdecl; external libcglm;
procedure glmc_quat_for(dir: Tvec3; up: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_forp(from: Tvec3; to_: Tvec3; up: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_quat_rotatev(from: Tversor; to_: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_quat_rotate(m: Tmat4; q: Tversor; dest: Tmat4); cdecl; external libcglm;
procedure glmc_quat_rotate_at(model: Tmat4; q: Tversor; pivot: Tvec3); cdecl; external libcglm;
procedure glmc_quat_rotate_atm(m: Tmat4; q: Tversor; pivot: Tvec3); cdecl; external libcglm;
procedure glmc_quat_make(src: Psingle; dest: Tversor); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:04 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
