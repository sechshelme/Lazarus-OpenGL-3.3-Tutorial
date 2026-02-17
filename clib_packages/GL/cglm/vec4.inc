{$IFDEF read_interface}


procedure glmc_vec4(v3: Tvec3; last: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_zero(v: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_one(v: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_copy3(v: Tvec4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec4_copy(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_ucopy(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
function glmc_vec4_dot(a: Tvec4; b: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_norm(v: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_norm2(v: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_norm_one(v: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_norm_inf(v: Tvec4): single; cdecl; external libcglm;
procedure glmc_vec4_normalize_to(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_normalize(v: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_add(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_adds(v: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_sub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_subs(v: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_mul(a: Tvec4; b: Tvec4; d: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_scale(v: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_scale_as(v: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_div(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_divs(v: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_addadd(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_subadd(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_muladd(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_muladds(a: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_maxadd(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_minadd(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_subsub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_addsub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_mulsub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_mulsubs(a: Tvec4; s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_maxsub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_minsub(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_negate(v: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_negate_to(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
function glmc_vec4_distance(a: Tvec4; b: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_distance2(a: Tvec4; b: Tvec4): single; cdecl; external libcglm;
procedure glmc_vec4_maxv(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_minv(a: Tvec4; b: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_clamp(v: Tvec4; minVal: single; maxVal: single); cdecl; external libcglm;
procedure glmc_vec4_lerp(from: Tvec4; to_: Tvec4; t: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_lerpc(from: Tvec4; to_: Tvec4; t: single; dest: Tvec4); cdecl; external libcglm;

procedure glmc_vec4_mix(var from: Tvec4; var to_: Tvec4; t: single; dest: Tvec4);
procedure glmc_vec4_mixc(var from: Tvec4; var to_: Tvec4; t: single; dest: Tvec4);

procedure glmc_vec4_step_uni(edge: single; x: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_step(edge: Tvec4; x: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_smoothstep_uni(edge0: single; edge1: single; x: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_smoothstep(edge0: Tvec4; edge1: Tvec4; x: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_smoothinterp(from: Tvec4; to_: Tvec4; t: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_smoothinterpc(from: Tvec4; to_: Tvec4; t: single; dest: Tvec4); cdecl; external libcglm;

procedure glmc_vec4_cubic(s: single; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_mulv(a: Tvec4; b: Tvec4; d: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_broadcast(val: single; d: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_fill(v: Tvec4; val: single); cdecl; external libcglm;
function glmc_vec4_eq(v: Tvec4; val: single): boolean; cdecl; external libcglm;
function glmc_vec4_eq_eps(v: Tvec4; val: single): boolean; cdecl; external libcglm;
function glmc_vec4_eq_all(v: Tvec4): boolean; cdecl; external libcglm;
function glmc_vec4_eqv(a: Tvec4; b: Tvec4): boolean; cdecl; external libcglm;
function glmc_vec4_eqv_eps(a: Tvec4; b: Tvec4): boolean; cdecl; external libcglm;
function glmc_vec4_max(v: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_min(v: Tvec4): single; cdecl; external libcglm;
function glmc_vec4_isnan(v: Tvec4): boolean; cdecl; external libcglm;
function glmc_vec4_isinf(v: Tvec4): boolean; cdecl; external libcglm;
function glmc_vec4_isvalid(v: Tvec4): boolean; cdecl; external libcglm;
procedure glmc_vec4_sign(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_abs(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_fract(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
function glmc_vec4_hadd(v: Tvec4): single; cdecl; external libcglm;
procedure glmc_vec4_sqrt(v: Tvec4; dest: Tvec4); cdecl; external libcglm;
procedure glmc_vec4_make(src: Psingle; dest: Tvec4); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:43:41 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}

procedure glmc_vec4_mix(var from: Tvec4; var to_: Tvec4; t: single; dest: Tvec4);
begin
  glmc_vec4_lerp(from, to_, t, dest);
end;

procedure glmc_vec4_mixc(var from: Tvec4; var to_: Tvec4; t: single; dest: Tvec4);
begin
  glmc_vec4_lerpc(from, to_, t, dest);
end;


{$ENDIF read_implementation}
