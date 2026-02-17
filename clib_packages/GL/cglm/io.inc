{$IFDEF read_interface}


procedure glmc_mat4_print(matrix: Tmat4; ostream: PFILE); cdecl; external libcglm;
procedure glmc_mat3_print(matrix: Tmat3; ostream: PFILE); cdecl; external libcglm;
procedure glmc_vec4_print(vec: Tvec4; ostream: PFILE); cdecl; external libcglm;
procedure glmc_vec3_print(vec: Tvec3; ostream: PFILE); cdecl; external libcglm;
procedure glmc_versor_print(vec: Tversor; ostream: PFILE); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:49 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
