{$IFDEF read_interface}


procedure glmc_ivec3(v4: Tivec4; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_copy(a: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_zero(v: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_one(v: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_add(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_adds(v: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_sub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_subs(v: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_mul(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_scale(v: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_addadd(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_addadds(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_subadd(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_subadds(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_muladd(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_muladds(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_maxadd(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_minadd(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_subsub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_subsubs(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_addsub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_addsubs(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_mulsub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_mulsubs(a: Tivec3; s: longint; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_maxsub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_minsub(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
function glmc_ivec3_distance2(a: Tivec3; b: Tivec3): longint; cdecl; external libcglm;
function glmc_ivec3_distance(a: Tivec3; b: Tivec3): single; cdecl; external libcglm;
procedure glmc_ivec3_fill(v: Tivec3; val: longint); cdecl; external libcglm;
function glmc_ivec3_eq(v: Tivec3; val: longint): Boolean; cdecl; external libcglm;
function glmc_ivec3_eqv(a: Tivec3; b: Tivec3): Boolean; cdecl; external libcglm;
procedure glmc_ivec3_maxv(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_minv(a: Tivec3; b: Tivec3; dest: Tivec3); cdecl; external libcglm;
procedure glmc_ivec3_clamp(v: Tivec3; minVal: longint; maxVal: longint); cdecl; external libcglm;
procedure glmc_ivec3_abs(v: Tivec3; dest: Tivec3); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:44 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
