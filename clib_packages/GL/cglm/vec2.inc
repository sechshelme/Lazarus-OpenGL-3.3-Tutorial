{$IFDEF read_interface}


procedure glmc_vec2(v: Psingle; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_copy(a: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_zero(v: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_one(v: Tvec2); cdecl; external libcglm;
function glmc_vec2_dot(a: Tvec2; b: Tvec2): single; cdecl; external libcglm;
function glmc_vec2_cross(a: Tvec2; b: Tvec2): single; cdecl; external libcglm;
function glmc_vec2_norm2(v: Tvec2): single; cdecl; external libcglm;
function glmc_vec2_norm(v: Tvec2): single; cdecl; external libcglm;
procedure glmc_vec2_add(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_adds(v: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_sub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_subs(v: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_mul(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_scale(v: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_scale_as(v: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_div(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_divs(v: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_addadd(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_subadd(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_muladd(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_muladds(a: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_maxadd(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_minadd(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_subsub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_addsub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_mulsub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_mulsubs(a: Tvec2; s: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_maxsub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_minsub(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_negate_to(v: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_negate(v: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_normalize(v: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_normalize_to(v: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_rotate(v: Tvec2; angle: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_center(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
function glmc_vec2_distance2(a: Tvec2; b: Tvec2): single; cdecl; external libcglm;
function glmc_vec2_distance(a: Tvec2; b: Tvec2): single; cdecl; external libcglm;
procedure glmc_vec2_maxv(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_minv(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_clamp(v: Tvec2; minval: single; maxval: single); cdecl; external libcglm;
procedure glmc_vec2_abs(v: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_lerp(from: Tvec2; to_: Tvec2; t: single; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_complex_mul(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_complex_div(a: Tvec2; b: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_complex_conjugate(a: Tvec2; dest: Tvec2); cdecl; external libcglm;
procedure glmc_vec2_make(src: Psingle; dest: Tvec2); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:43:46 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
