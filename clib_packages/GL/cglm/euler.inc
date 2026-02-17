{$IFDEF read_interface}


procedure glmc_euler_angles(m: Tmat4; dest: Tvec3); cdecl; external libcglm;
procedure glmc_euler(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_xyz(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_zyx(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_zxy(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_xzy(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_yzx(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_yxz(angles: Tvec3; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_by_order(angles: Tvec3; axis: Tglm_euler_seq; dest: Tmat4); cdecl; external libcglm;
procedure glmc_euler_xyz_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_euler_xzy_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_euler_yxz_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_euler_yzx_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_euler_zxy_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;
procedure glmc_euler_zyx_quat(angles: Tvec3; dest: Tversor); cdecl; external libcglm;

// === Konventiert am: 16-2-26 19:44:55 ===


{$ENDIF read_interface}


{$IFDEF read_implementation}



{$ENDIF read_implementation}
