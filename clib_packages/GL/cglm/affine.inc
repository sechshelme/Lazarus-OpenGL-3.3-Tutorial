{$IFDEF read_interface}


procedure glmc_translate_make(m: Tmat4; v: Tvec3); cdecl; external libcglm;
procedure glmc_translate_to(m: Tmat4; v: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_translate(m: Tmat4; v: Tvec3); cdecl; external libcglm;
procedure glmc_translate_x(m: Tmat4; to_: single); cdecl; external libcglm;
procedure glmc_translate_y(m: Tmat4; to_: single); cdecl; external libcglm;
procedure glmc_translate_z(m: Tmat4; to_: single); cdecl; external libcglm;
procedure glmc_scale_make(m: Tmat4; v: Tvec3); cdecl; external libcglm;
procedure glmc_scale_to(m: Tmat4; v: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_scale(m: Tmat4; v: Tvec3); cdecl; external libcglm;
procedure glmc_scale_uni(m: Tmat4; s: single); cdecl; external libcglm;
procedure glmc_rotate_x(m: Tmat4; rad: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotate_y(m: Tmat4; rad: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotate_z(m: Tmat4; rad: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotate_make(m: Tmat4; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_rotate(m: Tmat4; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_rotate_at(m: Tmat4; pivot: Tvec3; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_rotate_atm(m: Tmat4; pivot: Tvec3; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_spin(m: Tmat4; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_decompose_scalev(m: Tmat4; s: Tvec3); cdecl; external libcglm;
function glmc_uniscaled(m: Tmat4): Boolean; cdecl; external libcglm;
procedure glmc_decompose_rs(m: Tmat4; r: Tmat4; s: Tvec3); cdecl; external libcglm;
procedure glmc_decompose(m: Tmat4; t: Tvec4; r: Tmat4; s: Tvec3); cdecl; external libcglm;

procedure glmc_translated(m: Tmat4; v: Tvec3); cdecl; external libcglm;
procedure glmc_translated_to(m: Tmat4; v: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_translated_x(m: Tmat4; x: single); cdecl; external libcglm;
procedure glmc_translated_y(m: Tmat4; y: single); cdecl; external libcglm;
procedure glmc_translated_z(m: Tmat4; z: single); cdecl; external libcglm;
procedure glmc_rotated_x(m: Tmat4; angle: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotated_y(m: Tmat4; angle: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotated_z(m: Tmat4; angle: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_rotated(m: Tmat4; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_rotated_at(m: Tmat4; pivot: Tvec3; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_spinned(m: Tmat4; angle: single; axis: Tvec3); cdecl; external libcglm;

procedure glmc_mul(m1: Tmat4; m2: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_mul_rot(m1: Tmat4; m2: Tmat4; dest: Tmat4); cdecl; external libcglm;
procedure glmc_inv_tr(mat: Tmat4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:18 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
