{$IFDEF read_interface}


function glmc_sphere_radii(s: Tvec4): single; cdecl; external libcglm;
procedure glmc_sphere_transform(s: Tvec4; m: Tmat4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_sphere_merge(s1: Tvec4; s2: Tvec4; dest: Tvec4); cdecl; external libcglm;
function glmc_sphere_sphere(s1: Tvec4; s2: Tvec4): Boolean; cdecl; external libcglm;
function glmc_sphere_point(s: Tvec4; point: Tvec3): Boolean; cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:43:50 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
