unit env;

interface

uses
  ctypes;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


type
  Pshaderc_target_env = ^Tshaderc_target_env;
  Tshaderc_target_env = longint;

const
  shaderc_target_env_vulkan = 0;
  shaderc_target_env_opengl = 1;
  shaderc_target_env_opengl_compat = 2;
  shaderc_target_env_webgpu = 3;
  shaderc_target_env_default = shaderc_target_env_vulkan;

type
  Pshaderc_env_version = ^Tshaderc_env_version;
  Tshaderc_env_version = longint;

const
  shaderc_env_version_vulkan_1_0 = 1 shl 22;
  shaderc_env_version_vulkan_1_1 = (1 shl 22) or (1 shl 12);
  shaderc_env_version_vulkan_1_2 = (1 shl 22) or (2 shl 12);
  shaderc_env_version_vulkan_1_3 = (1 shl 22) or (3 shl 12);
  shaderc_env_version_opengl_4_5 = 450;
  shaderc_env_version_webgpu = 451;

type
  Pshaderc_spirv_version = ^Tshaderc_spirv_version;
  Tshaderc_spirv_version = longint;

const
  shaderc_spirv_version_1_0 = $010000;
  shaderc_spirv_version_1_1 = $010100;
  shaderc_spirv_version_1_2 = $010200;
  shaderc_spirv_version_1_3 = $010300;
  shaderc_spirv_version_1_4 = $010400;
  shaderc_spirv_version_1_5 = $010500;
  shaderc_spirv_version_1_6 = $010600;

  // === Konventiert am: 19-6-25 14:35:34 ===


implementation



end.
