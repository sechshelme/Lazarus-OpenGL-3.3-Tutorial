{$IFDEF read_interface}


procedure glmc_frustum_planes(m: Tmat4; dest: Pvec4); cdecl; external libcglm;
procedure glmc_frustum_corners(invMat: Tmat4; dest: Pvec4); cdecl; external libcglm;
procedure glmc_frustum_center(corners: Pvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_frustum_box(corners: Pvec4; m: Tmat4; box: Pvec3); cdecl; external libcglm;
procedure glmc_frustum_corners_at(corners: Pvec4; splitDist: single; farDist: single; planeCorners: Pvec4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:52 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
