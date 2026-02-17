{$IFDEF read_interface}


procedure glmc_lookat_lh_zo(eye: Tvec3; center: Tvec3; up: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_look_lh_zo(eye: Tvec3; dir: Tvec3; up: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_look_anyup_lh_zo(eye: Tvec3; dir: Tvec3; dest: Tmat4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:46:20 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
