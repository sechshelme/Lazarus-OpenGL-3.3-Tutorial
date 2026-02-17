{$IFDEF read_interface}


procedure glmc_aabb2d_copy(aabb: Pvec2; dest: Pvec2); cdecl; external libcglm;
procedure glmc_aabb2d_transform(aabb: Pvec2; m: Tmat3; dest: Pvec2); cdecl; external libcglm;
procedure glmc_aabb2d_merge(aabb1: Pvec2; aabb2: Pvec2; dest: Pvec2); cdecl; external libcglm;
procedure glmc_aabb2d_crop(aabb: Pvec2; cropAabb: Pvec2; dest: Pvec2); cdecl; external libcglm;
procedure glmc_aabb2d_crop_until(aabb: Pvec2; cropAabb: Pvec2; clampAabb: Pvec2; dest: Pvec2); cdecl; external libcglm;
procedure glmc_aabb2d_invalidate(aabb: Pvec2); cdecl; external libcglm;
function glmc_aabb2d_isvalid(aabb: Pvec2): Boolean; cdecl; external libcglm;
function glmc_aabb2d_size(aabb: Pvec2): single; cdecl; external libcglm;
function glmc_aabb2d_radius(aabb: Pvec2): single; cdecl; external libcglm;
procedure glmc_aabb2d_center(aabb: Pvec2; dest: Tvec2); cdecl; external libcglm;
function glmc_aabb2d_aabb(aabb: Pvec2; other: Pvec2): Boolean; cdecl; external libcglm;
function glmc_aabb2d_point(aabb: Pvec2; point: Tvec2): Boolean; cdecl; external libcglm;
function glmc_aabb2d_contains(aabb: Pvec2; other: Pvec2): Boolean; cdecl; external libcglm;
function glmc_aabb2d_circle(aabb: Pvec2; s: Tvec3): Boolean; cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:45:21 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
