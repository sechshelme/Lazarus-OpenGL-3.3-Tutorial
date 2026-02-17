{$IFDEF read_interface}


procedure glmc_vec3(v4: Tvec4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_copy(a: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_zero(v: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_one(v: Tvec3); cdecl; external libcglm;
function glmc_vec3_dot(a: Tvec3; b: Tvec3): single; cdecl; external libcglm;
procedure glmc_vec3_cross(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_crossn(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_vec3_norm(v: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_norm2(v: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_norm_one(v: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_norm_inf(v: Tvec3): single; cdecl; external libcglm;
procedure glmc_vec3_normalize_to(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_normalize(v: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_add(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_adds(v: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_sub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_subs(v: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_mul(a: Tvec3; b: Tvec3; d: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_scale(v: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_scale_as(v: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_div(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_divs(a: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_addadd(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_subadd(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_muladd(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_muladds(a: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_maxadd(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_minadd(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_subsub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_addsub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_mulsub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_mulsubs(a: Tvec3; s: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_maxsub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_minsub(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_negate(v: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_negate_to(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_vec3_angle(a: Tvec3; b: Tvec3): single; cdecl; external libcglm;
procedure glmc_vec3_rotate(v: Tvec3; angle: single; axis: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_rotate_m4(m: Tmat4; v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_rotate_m3(m: Tmat3; v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_proj(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_center(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_vec3_distance2(a: Tvec3; b: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_distance(a: Tvec3; b: Tvec3): single; cdecl; external libcglm;
procedure glmc_vec3_maxv(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_minv(a: Tvec3; b: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_clamp(v: Tvec3; minVal: single; maxVal: single); cdecl; external libcglm;
procedure glmc_vec3_ortho(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_lerp(from: Tvec3; to_: Tvec3; t: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_lerpc(from: Tvec3; to_: Tvec3; t: single; dest: Tvec3); cdecl; external libcglm;

procedure glmc_vec3_mix(var from: Tvec3; var to_: Tvec3; t: single; dest: Tvec3);
procedure glmc_vec3_mixc(var from: Tvec3; var to_: Tvec3; t: single; dest: Tvec3);

procedure glmc_vec3_step_uni(edge: single; x: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_step(edge: Tvec3; x: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_smoothstep_uni(edge0: single; edge1: single; x: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_smoothstep(edge0: Tvec3; edge1: Tvec3; x: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_smoothinterp(from: Tvec3; to_: Tvec3; t: single; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_smoothinterpc(from: Tvec3; to_: Tvec3; t: single; dest: Tvec3); cdecl; external libcglm;

procedure glmc_vec3_mulv(a: Tvec3; b: Tvec3; d: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_broadcast(val: single; d: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_fill(v: Tvec3; val: single); cdecl; external libcglm;
function glmc_vec3_eq(v: Tvec3; val: single): boolean; cdecl; external libcglm;
function glmc_vec3_eq_eps(v: Tvec3; val: single): boolean; cdecl; external libcglm;
function glmc_vec3_eq_all(v: Tvec3): boolean; cdecl; external libcglm;
function glmc_vec3_eqv(a: Tvec3; b: Tvec3): boolean; cdecl; external libcglm;
function glmc_vec3_eqv_eps(a: Tvec3; b: Tvec3): boolean; cdecl; external libcglm;
function glmc_vec3_max(v: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_min(v: Tvec3): single; cdecl; external libcglm;
function glmc_vec3_isnan(v: Tvec3): boolean; cdecl; external libcglm;
function glmc_vec3_isinf(v: Tvec3): boolean; cdecl; external libcglm;
function glmc_vec3_isvalid(v: Tvec3): boolean; cdecl; external libcglm;
procedure glmc_vec3_sign(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_abs(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_fract(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_vec3_hadd(v: Tvec3): single; cdecl; external libcglm;
procedure glmc_vec3_sqrt(v: Tvec3; dest: Tvec3); cdecl; external libcglm;
procedure glmc_vec3_make(src: Psingle; dest: Tvec3); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:43:43 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}

procedure glmc_vec3_mix(var from: Tvec3; var to_: Tvec3; t: single; dest: Tvec3);
begin
  glmc_vec3_lerp(from, to_, t, dest);
end;

procedure glmc_vec3_mixc(var from: Tvec3; var to_: Tvec3; t: single; dest: Tvec3);
begin
  glmc_vec3_lerpc(from, to_, t, dest);
end;


{$ENDIF read_implementation}
