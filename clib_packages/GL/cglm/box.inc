{$IFDEF read_interface}


procedure glmc_aabb_transform(box: Pvec3; m: Tmat4; dest: Pvec3); cdecl; external libcglm;
procedure glmc_aabb_merge(box1: Pvec3; box2: Pvec3; dest: Pvec3); cdecl; external libcglm;
procedure glmc_aabb_crop(box: Pvec3; cropBox: Pvec3; dest: Pvec3); cdecl; external libcglm;
procedure glmc_aabb_crop_until(box: Pvec3; cropBox: Pvec3; clampBox: Pvec3; dest: Pvec3); cdecl; external libcglm;
function glmc_aabb_frustum(box: Pvec3; planes: Pvec4): boolean; cdecl; external libcglm;
procedure glmc_aabb_invalidate(box: Pvec3); cdecl; external libcglm;
function glmc_aabb_isvalid(box: Pvec3): boolean; cdecl; external libcglm;
function glmc_aabb_size(box: Pvec3): single; cdecl; external libcglm;
function glmc_aabb_radius(box: Pvec3): single; cdecl; external libcglm;
procedure glmc_aabb_center(box: Pvec3; dest: Tvec3); cdecl; external libcglm;
function glmc_aabb_aabb(box: Pvec3; other: Pvec3): boolean; cdecl; external libcglm;
function glmc_aabb_point(box: Pvec3; point: Tvec3): boolean; cdecl; external libcglm;
function glmc_aabb_contains(box: Pvec3; other: Pvec3): boolean; cdecl; external libcglm;
function glmc_aabb_sphere(box: Pvec3; s: Tvec4): boolean; cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:08 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
