{$IFDEF read_interface}


procedure glmc_translate2d_make(m: Tmat3; v: Tvec2); cdecl; external libcglm;
procedure glmc_translate2d_to(m: Tmat3; v: Tvec2; dest: Tmat3); cdecl; external libcglm;
procedure glmc_translate2d(m: Tmat3; v: Tvec2); cdecl; external libcglm;
procedure glmc_translate2d_x(m: Tmat3; to_: single); cdecl; external libcglm;
procedure glmc_translate2d_y(m: Tmat3; to_: single); cdecl; external libcglm;
procedure glmc_scale2d_to(m: Tmat3; v: Tvec2; dest: Tmat3); cdecl; external libcglm;
procedure glmc_scale2d_make(m: Tmat3; v: Tvec2); cdecl; external libcglm;
procedure glmc_scale2d(m: Tmat3; v: Tvec2); cdecl; external libcglm;
procedure glmc_scale2d_uni(m: Tmat3; s: single); cdecl; external libcglm;
procedure glmc_rotate2d_make(m: Tmat3; angle: single); cdecl; external libcglm;
procedure glmc_rotate2d(m: Tmat3; angle: single); cdecl; external libcglm;
procedure glmc_rotate2d_to(m: Tmat3; angle: single; dest: Tmat3); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:14 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
