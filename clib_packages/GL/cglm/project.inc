{$IFDEF read_interface}


procedure glmc_unprojecti(pos: Tvec3; invMat: Tmat4; vp: Tvec4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_unproject(pos: Tvec3; m: Tmat4; vp: Tvec4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_project(pos: Tvec3; m: Tmat4; vp: Tvec4; dest: Tvec3); cdecl; external libcglm;
function glmc_project_z(pos: Tvec3; m: Tmat4): single; cdecl; external libcglm;
procedure glmc_pickmatrix(center: Tvec2; size: Tvec2; vp: Tvec4; dest: Tmat4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:07 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
