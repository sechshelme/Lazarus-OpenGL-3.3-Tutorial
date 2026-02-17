{$IFDEF read_interface}


procedure glmc_ivec2(v: Plongint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_copy(a: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_zero(v: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_one(v: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_add(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_adds(v: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_sub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_subs(v: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_mul(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_scale(v: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_addadd(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_addadds(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_subadd(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_subadds(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_muladd(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_muladds(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_maxadd(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_minadd(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_subsub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_subsubs(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_addsub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_addsubs(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_mulsub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_mulsubs(a: Tivec2; s: longint; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_maxsub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_minsub(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
function glmc_ivec2_distance2(a: Tivec2; b: Tivec2): longint; cdecl; external libcglm;
function glmc_ivec2_distance(a: Tivec2; b: Tivec2): single; cdecl; external libcglm;
procedure glmc_ivec2_fill(v: Tivec2; val: longint); cdecl; external libcglm;
function glmc_ivec2_eq(v: Tivec2; val: longint): Boolean; cdecl; external libcglm;
function glmc_ivec2_eqv(a: Tivec2; b: Tivec2): Boolean; cdecl; external libcglm;
procedure glmc_ivec2_maxv(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_minv(a: Tivec2; b: Tivec2; dest: Tivec2); cdecl; external libcglm;
procedure glmc_ivec2_clamp(v: Tivec2; minVal: longint; maxVal: longint); cdecl; external libcglm;
procedure glmc_ivec2_abs(v: Tivec2; dest: Tivec2); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:46 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
