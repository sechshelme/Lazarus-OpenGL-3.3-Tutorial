{$IFDEF read_interface}


procedure glmc_frustum_rh_zo(left: single; right: single; bottom: single; top: single; nearZ: single; farZ: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_perspective_rh_zo(fovy: single; aspect: single; nearVal: single; farVal: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_persp_move_far_rh_zo(proj: Tmat4; deltaFar: single); cdecl; external libcglm;
procedure glmc_persp_decomp_rh_zo(proj: Tmat4; nearZ: Psingle; farZ: Psingle; top: Psingle; bottom: Psingle; left: Psingle; right: Psingle); cdecl; external libcglm;
procedure glmc_persp_decompv_rh_zo(proj: Tmat4; dest: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_x_rh_zo(proj: Tmat4; left: Psingle; right: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_y_rh_zo(proj: Tmat4; top: Psingle; bottom: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_z_rh_zo(proj: Tmat4; nearZ: Psingle; farZ: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_far_rh_zo(proj: Tmat4; farZ: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_near_rh_zo(proj: Tmat4; nearZ: Psingle); cdecl; external libcglm;
procedure glmc_persp_sizes_rh_zo(proj: Tmat4; fovy: single; dest: Tvec4); cdecl; external libcglm;
function glmc_persp_fovy_rh_zo(proj: Tmat4): single; cdecl; external libcglm;
function glmc_persp_aspect_rh_zo(proj: Tmat4): single; cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:46:33 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
