{$IFDEF read_interface}


procedure glmc_ortho_rh_no(left: single; right: single; bottom: single; top: single; nearZ: single; farZ: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb_rh_no(box: Pvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb_p_rh_no(box: Pvec3; padding: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_aabb_pz_rh_no(box: Pvec3; padding: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_default_rh_no(aspect: single; dest: Tmat4); cdecl; external libcglm;
procedure glmc_ortho_default_s_rh_no(aspect: single; size: single; dest: Tmat4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:46:53 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
