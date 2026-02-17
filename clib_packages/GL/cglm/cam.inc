{$IFDEF read_interface}


procedure glmc_frustum(left: single; right: single; bottom: single; top: single; nearZ: single; farZ: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho(left: single; right: single; bottom: single; top: single; nearZ: single; farZ: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb(box: Pvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb_p(box: Pvec3; padding: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb_pz(box: Pvec3; padding: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_default(aspect: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_default_s(aspect: single; size: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_perspective(fovy: single; aspect: single; nearZ: single; farZ: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_persp_move_far(proj: Tmat4; deltaFar: single); cdecl; external libcglm;
procedure glmc_perspective_default(aspect: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_perspective_resize(aspect: single; proj: Tmat4); cdecl; external libcglm;
procedure glmc_lookat(eye: Tvec3; center: Tvec3; up: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_look(eye: Tvec3; dir: Tvec3; up: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_look_anyup(eye: Tvec3; dir: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_persp_decomp(proj: Tmat4; nearZ: Psingle; farZ: Psingle; top: Psingle; bottom: Psingle; left: Psingle; right: Psingle); cdecl; external libcglm;
procedure glmc_persp_decompv(proj: Tmat4; dest: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_x(proj: Tmat4; left: Psingle; right: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_y(proj: Tmat4; top: Psingle; bottom: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_z(proj: Tmat4; nearZ: Psingle; farZ: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_far(proj: Tmat4; farZ: Psingle); cdecl; external libcglm;
procedure glmc_persp_decomp_near(proj: Tmat4; nearZ: Psingle); cdecl; external libcglm;
function glmc_persp_fovy(proj: Tmat4): single; cdecl; external libcglm;
function glmc_persp_aspect(proj: Tmat4): single; cdecl; external libcglm;
procedure glmc_persp_sizes(proj: Tmat4; fovy: single; dest: Tvec4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:05 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
