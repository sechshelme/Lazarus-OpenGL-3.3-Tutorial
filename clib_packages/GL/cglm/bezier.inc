{$IFDEF read_interface}


function glmc_bezier(s: single; p0: single; c0: single; c1: single; p1: single): single; cdecl; external libcglm;
function glmc_hermite(s: single; p0: single; t0: single; t1: single; p1: single): single; cdecl; external libcglm;
function glmc_decasteljau(prm: single; p0: single; c0: single; c1: single; p1: single): single; cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:12 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
