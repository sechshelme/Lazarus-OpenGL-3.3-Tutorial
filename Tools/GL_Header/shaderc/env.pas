unit env;

interface

uses
  ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ Copyright 2018 The Shaderc Authors. All rights reserved. }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{     http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{$ifndef SHADERC_ENV_H_}
{$define SHADERC_ENV_H_}
{$include <stdint.h>}
{ C++ extern C conditionnal removed }
{ SPIR-V under Vulkan semantics }
{ SPIR-V under OpenGL semantics }
{ NOTE: SPIR-V code generation is not supported for shaders under OpenGL }
{ compatibility profile. }
{ SPIR-V under OpenGL semantics, }
{ including compatibility profile }
{ functions }
{ Deprecated, SPIR-V under WebGPU }
{ semantics }
type
  Pshaderc_target_env = ^Tshaderc_target_env;
  Tshaderc_target_env =  Longint;
  Const
    shaderc_target_env_vulkan = 0;
    shaderc_target_env_opengl = 1;
    shaderc_target_env_opengl_compat = 2;
    shaderc_target_env_webgpu = 3;
    shaderc_target_env_default = shaderc_target_env_vulkan;
;
{ For Vulkan, use Vulkan's mapping of version numbers to integers. }
{ See vulkan.h }
{ For OpenGL, use the number from #version in shaders. }
{ TODO(dneto): Currently no difference between OpenGL 4.5 and 4.6. }
{ See glslang/Standalone/Standalone.cpp }
{ TODO(dneto): Glslang doesn't accept a OpenGL client version of 460. }
{ Deprecated, WebGPU env never defined versions }
type
  Pshaderc_env_version = ^Tshaderc_env_version;
  Tshaderc_env_version =  Longint;
  Const
    shaderc_env_version_vulkan_1_0 = 1 shl 22;
    shaderc_env_version_vulkan_1_1 = (1 shl 22) or (1 shl 12);
    shaderc_env_version_vulkan_1_2 = (1 shl 22) or (2 shl 12);
    shaderc_env_version_vulkan_1_3 = (1 shl 22) or (3 shl 12);
    shaderc_env_version_opengl_4_5 = 450;
    shaderc_env_version_webgpu = 451;
;
{ The known versions of SPIR-V. }
{ Use the values used for word 1 of a SPIR-V binary: }
{ - bits 24 to 31: zero }
{ - bits 16 to 23: major version number }
{ - bits 8 to 15: minor version number }
{ - bits 0 to 7: zero }
type
  Pshaderc_spirv_version = ^Tshaderc_spirv_version;
  Tshaderc_spirv_version =  Longint;
  Const
    shaderc_spirv_version_1_0 = $010000;
    shaderc_spirv_version_1_1 = $010100;
    shaderc_spirv_version_1_2 = $010200;
    shaderc_spirv_version_1_3 = $010300;
    shaderc_spirv_version_1_4 = $010400;
    shaderc_spirv_version_1_5 = $010500;
    shaderc_spirv_version_1_6 = $010600;
;
{ C++ end of extern C conditionnal removed }
{ __cplusplus }
{$endif}
{ SHADERC_ENV_H_ }

// === Konventiert am: 19-6-25 14:35:34 ===


implementation



end.
