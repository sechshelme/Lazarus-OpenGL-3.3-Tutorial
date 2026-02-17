{$IFDEF read_interface}


procedure glmc_ivec4(v3: Tivec3; last: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_copy(a: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_zero(v: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_one(v: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_add(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_adds(v: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_sub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_subs(v: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_mul(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_scale(v: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_addadd(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_addadds(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_subadd(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_subadds(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_muladd(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_muladds(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_maxadd(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_minadd(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_subsub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_subsubs(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_addsub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_addsubs(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_mulsub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_mulsubs(a: Tivec4; s: longint; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_maxsub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_minsub(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
function glmc_ivec4_distance2(a: Tivec4; b: Tivec4): longint; cdecl; external libcglm;
function glmc_ivec4_distance(a: Tivec4; b: Tivec4): single; cdecl; external libcglm;
procedure glmc_ivec4_maxv(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_minv(a: Tivec4; b: Tivec4; dest: Tivec4); cdecl; external libcglm;
procedure glmc_ivec4_clamp(v: Tivec4; minVal: longint; maxVal: longint); cdecl; external libcglm;
procedure glmc_ivec4_abs(v: Tivec4; dest: Tivec4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:41 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
