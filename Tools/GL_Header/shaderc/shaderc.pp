
unit shaderc;
interface

{
  Automatically converted by H2Pas 1.0.0 from shaderc.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    shaderc.h
}

{ Pointers to basic pascal types, inserted by h2pas conversion program.}
Type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

Type
Pchar  = ^char;
Pdword  = ^dword;
Plongint  = ^longint;
Pshaderc_compilation_result  = ^shaderc_compilation_result;
Pshaderc_compilation_result_t  = ^shaderc_compilation_result_t;
Pshaderc_compile_options  = ^shaderc_compile_options;
Pshaderc_compile_options_t  = ^shaderc_compile_options_t;
Pshaderc_compiler  = ^shaderc_compiler;
Pshaderc_compiler_t  = ^shaderc_compiler_t;
Pshaderc_include_resolve_fn  = ^shaderc_include_resolve_fn;
Pshaderc_include_result  = ^shaderc_include_result;
Pshaderc_include_type  = ^shaderc_include_type;
Pshaderc_limit  = ^shaderc_limit;
Pshaderc_optimization_level  = ^shaderc_optimization_level;
Pshaderc_profile  = ^shaderc_profile;
Pshaderc_shader_kind  = ^shaderc_shader_kind;
Pshaderc_source_language  = ^shaderc_source_language;
Pshaderc_uniform_kind  = ^shaderc_uniform_kind;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ Copyright 2015 The Shaderc Authors. All rights reserved. }
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
{$ifndef SHADERC_SHADERC_H_}
{$define SHADERC_SHADERC_H_}
{ C++ extern C conditionnal removed }
{$include <stdbool.h>}
{$include <stddef.h>}
{$include <stdint.h>}
{$include "shaderc/env.h"}
{$include "shaderc/status.h"}
{$include "shaderc/visibility.h"}
{ Source language kind. }
type
  Pshaderc_source_language = ^Tshaderc_source_language;
  Tshaderc_source_language =  Longint;
  Const
    shaderc_source_language_glsl = 0;
    shaderc_source_language_hlsl = 1;
;
{ Forced shader kinds. These shader kinds force the compiler to compile the }
{ source code as the specified kind of shader. }
{ Deduce the shader kind from #pragma annotation in the source code. Compiler }
{ will emit error if #pragma annotation is not found. }
{ Default shader kinds. Compiler will fall back to compile the source code as }
{ the specified kind of shader when #pragma annotation is not found in the }
{ source code. }
type
  Pshaderc_shader_kind = ^Tshaderc_shader_kind;
  Tshaderc_shader_kind =  Longint;
  Const
    shaderc_vertex_shader = 0;
    shaderc_fragment_shader = 1;
    shaderc_compute_shader = 2;
    shaderc_geometry_shader = 3;
    shaderc_tess_control_shader = 4;
    shaderc_tess_evaluation_shader = 5;
    shaderc_glsl_vertex_shader = shaderc_vertex_shader;
    shaderc_glsl_fragment_shader = shaderc_fragment_shader;
    shaderc_glsl_compute_shader = shaderc_compute_shader;
    shaderc_glsl_geometry_shader = shaderc_geometry_shader;
    shaderc_glsl_tess_control_shader = shaderc_tess_control_shader;
    shaderc_glsl_tess_evaluation_shader = shaderc_tess_evaluation_shader;
    shaderc_glsl_infer_from_source = (shaderc_tess_evaluation_shader)+1;
    shaderc_glsl_default_vertex_shader = (shaderc_tess_evaluation_shader)+2;
    shaderc_glsl_default_fragment_shader = (shaderc_tess_evaluation_shader)+3;
    shaderc_glsl_default_compute_shader = (shaderc_tess_evaluation_shader)+4;
    shaderc_glsl_default_geometry_shader = (shaderc_tess_evaluation_shader)+5;
    shaderc_glsl_default_tess_control_shader = (shaderc_tess_evaluation_shader)+6;
    shaderc_glsl_default_tess_evaluation_shader = (shaderc_tess_evaluation_shader)+7;
    shaderc_spirv_assembly = (shaderc_tess_evaluation_shader)+8;
    shaderc_raygen_shader = (shaderc_tess_evaluation_shader)+9;
    shaderc_anyhit_shader = (shaderc_tess_evaluation_shader)+10;
    shaderc_closesthit_shader = (shaderc_tess_evaluation_shader)+11;
    shaderc_miss_shader = (shaderc_tess_evaluation_shader)+12;
    shaderc_intersection_shader = (shaderc_tess_evaluation_shader)+13;
    shaderc_callable_shader = (shaderc_tess_evaluation_shader)+14;
    shaderc_glsl_raygen_shader = shaderc_raygen_shader;
    shaderc_glsl_anyhit_shader = shaderc_anyhit_shader;
    shaderc_glsl_closesthit_shader = shaderc_closesthit_shader;
    shaderc_glsl_miss_shader = shaderc_miss_shader;
    shaderc_glsl_intersection_shader = shaderc_intersection_shader;
    shaderc_glsl_callable_shader = shaderc_callable_shader;
    shaderc_glsl_default_raygen_shader = (shaderc_callable_shader)+1;
    shaderc_glsl_default_anyhit_shader = (shaderc_callable_shader)+2;
    shaderc_glsl_default_closesthit_shader = (shaderc_callable_shader)+3;
    shaderc_glsl_default_miss_shader = (shaderc_callable_shader)+4;
    shaderc_glsl_default_intersection_shader = (shaderc_callable_shader)+5;
    shaderc_glsl_default_callable_shader = (shaderc_callable_shader)+6;
    shaderc_task_shader = (shaderc_callable_shader)+7;
    shaderc_mesh_shader = (shaderc_callable_shader)+8;
    shaderc_glsl_task_shader = shaderc_task_shader;
    shaderc_glsl_mesh_shader = shaderc_mesh_shader;
    shaderc_glsl_default_task_shader = (shaderc_mesh_shader)+1;
    shaderc_glsl_default_mesh_shader = (shaderc_mesh_shader)+2;
;
{ Used if and only if GLSL version did not specify }
{ profiles. }
{ Disabled. This generates an error }
type
  Pshaderc_profile = ^Tshaderc_profile;
  Tshaderc_profile =  Longint;
  Const
    shaderc_profile_none = 0;
    shaderc_profile_core = 1;
    shaderc_profile_compatibility = 2;
    shaderc_profile_es = 3;
;
{ Optimization level. }
{ no optimization }
{ optimize towards reducing code size }
{ optimize towards performance }
type
  Pshaderc_optimization_level = ^Tshaderc_optimization_level;
  Tshaderc_optimization_level =  Longint;
  Const
    shaderc_optimization_level_zero = 0;
    shaderc_optimization_level_size = 1;
    shaderc_optimization_level_performance = 2;
;
{ Resource limits. }
type
  Pshaderc_limit = ^Tshaderc_limit;
  Tshaderc_limit =  Longint;
  Const
    shaderc_limit_max_lights = 0;
    shaderc_limit_max_clip_planes = 1;
    shaderc_limit_max_texture_units = 2;
    shaderc_limit_max_texture_coords = 3;
    shaderc_limit_max_vertex_attribs = 4;
    shaderc_limit_max_vertex_uniform_components = 5;
    shaderc_limit_max_varying_floats = 6;
    shaderc_limit_max_vertex_texture_image_units = 7;
    shaderc_limit_max_combined_texture_image_units = 8;
    shaderc_limit_max_texture_image_units = 9;
    shaderc_limit_max_fragment_uniform_components = 10;
    shaderc_limit_max_draw_buffers = 11;
    shaderc_limit_max_vertex_uniform_vectors = 12;
    shaderc_limit_max_varying_vectors = 13;
    shaderc_limit_max_fragment_uniform_vectors = 14;
    shaderc_limit_max_vertex_output_vectors = 15;
    shaderc_limit_max_fragment_input_vectors = 16;
    shaderc_limit_min_program_texel_offset = 17;
    shaderc_limit_max_program_texel_offset = 18;
    shaderc_limit_max_clip_distances = 19;
    shaderc_limit_max_compute_work_group_count_x = 20;
    shaderc_limit_max_compute_work_group_count_y = 21;
    shaderc_limit_max_compute_work_group_count_z = 22;
    shaderc_limit_max_compute_work_group_size_x = 23;
    shaderc_limit_max_compute_work_group_size_y = 24;
    shaderc_limit_max_compute_work_group_size_z = 25;
    shaderc_limit_max_compute_uniform_components = 26;
    shaderc_limit_max_compute_texture_image_units = 27;
    shaderc_limit_max_compute_image_uniforms = 28;
    shaderc_limit_max_compute_atomic_counters = 29;
    shaderc_limit_max_compute_atomic_counter_buffers = 30;
    shaderc_limit_max_varying_components = 31;
    shaderc_limit_max_vertex_output_components = 32;
    shaderc_limit_max_geometry_input_components = 33;
    shaderc_limit_max_geometry_output_components = 34;
    shaderc_limit_max_fragment_input_components = 35;
    shaderc_limit_max_image_units = 36;
    shaderc_limit_max_combined_image_units_and_fragment_outputs = 37;
    shaderc_limit_max_combined_shader_output_resources = 38;
    shaderc_limit_max_image_samples = 39;
    shaderc_limit_max_vertex_image_uniforms = 40;
    shaderc_limit_max_tess_control_image_uniforms = 41;
    shaderc_limit_max_tess_evaluation_image_uniforms = 42;
    shaderc_limit_max_geometry_image_uniforms = 43;
    shaderc_limit_max_fragment_image_uniforms = 44;
    shaderc_limit_max_combined_image_uniforms = 45;
    shaderc_limit_max_geometry_texture_image_units = 46;
    shaderc_limit_max_geometry_output_vertices = 47;
    shaderc_limit_max_geometry_total_output_components = 48;
    shaderc_limit_max_geometry_uniform_components = 49;
    shaderc_limit_max_geometry_varying_components = 50;
    shaderc_limit_max_tess_control_input_components = 51;
    shaderc_limit_max_tess_control_output_components = 52;
    shaderc_limit_max_tess_control_texture_image_units = 53;
    shaderc_limit_max_tess_control_uniform_components = 54;
    shaderc_limit_max_tess_control_total_output_components = 55;
    shaderc_limit_max_tess_evaluation_input_components = 56;
    shaderc_limit_max_tess_evaluation_output_components = 57;
    shaderc_limit_max_tess_evaluation_texture_image_units = 58;
    shaderc_limit_max_tess_evaluation_uniform_components = 59;
    shaderc_limit_max_tess_patch_components = 60;
    shaderc_limit_max_patch_vertices = 61;
    shaderc_limit_max_tess_gen_level = 62;
    shaderc_limit_max_viewports = 63;
    shaderc_limit_max_vertex_atomic_counters = 64;
    shaderc_limit_max_tess_control_atomic_counters = 65;
    shaderc_limit_max_tess_evaluation_atomic_counters = 66;
    shaderc_limit_max_geometry_atomic_counters = 67;
    shaderc_limit_max_fragment_atomic_counters = 68;
    shaderc_limit_max_combined_atomic_counters = 69;
    shaderc_limit_max_atomic_counter_bindings = 70;
    shaderc_limit_max_vertex_atomic_counter_buffers = 71;
    shaderc_limit_max_tess_control_atomic_counter_buffers = 72;
    shaderc_limit_max_tess_evaluation_atomic_counter_buffers = 73;
    shaderc_limit_max_geometry_atomic_counter_buffers = 74;
    shaderc_limit_max_fragment_atomic_counter_buffers = 75;
    shaderc_limit_max_combined_atomic_counter_buffers = 76;
    shaderc_limit_max_atomic_counter_buffer_size = 77;
    shaderc_limit_max_transform_feedback_buffers = 78;
    shaderc_limit_max_transform_feedback_interleaved_components = 79;
    shaderc_limit_max_cull_distances = 80;
    shaderc_limit_max_combined_clip_and_cull_distances = 81;
    shaderc_limit_max_samples = 82;
    shaderc_limit_max_mesh_output_vertices_nv = 83;
    shaderc_limit_max_mesh_output_primitives_nv = 84;
    shaderc_limit_max_mesh_work_group_size_x_nv = 85;
    shaderc_limit_max_mesh_work_group_size_y_nv = 86;
    shaderc_limit_max_mesh_work_group_size_z_nv = 87;
    shaderc_limit_max_task_work_group_size_x_nv = 88;
    shaderc_limit_max_task_work_group_size_y_nv = 89;
    shaderc_limit_max_task_work_group_size_z_nv = 90;
    shaderc_limit_max_mesh_view_count_nv = 91;
    shaderc_limit_max_mesh_output_vertices_ext = 92;
    shaderc_limit_max_mesh_output_primitives_ext = 93;
    shaderc_limit_max_mesh_work_group_size_x_ext = 94;
    shaderc_limit_max_mesh_work_group_size_y_ext = 95;
    shaderc_limit_max_mesh_work_group_size_z_ext = 96;
    shaderc_limit_max_task_work_group_size_x_ext = 97;
    shaderc_limit_max_task_work_group_size_y_ext = 98;
    shaderc_limit_max_task_work_group_size_z_ext = 99;
    shaderc_limit_max_mesh_view_count_ext = 100;
    shaderc_limit_max_dual_source_draw_buffers_ext = 101;
;
{ Uniform resource kinds. }
{ In Vulkan, uniform resources are bound to the pipeline via descriptors }
{ with numbered bindings and sets. }
{ Image and image buffer. }
{ Pure sampler. }
{ Sampled texture in GLSL, and Shader Resource View in HLSL. }
{ Uniform Buffer Object (UBO) in GLSL.  Cbuffer in HLSL. }
{ Shader Storage Buffer Object (SSBO) in GLSL. }
{ Unordered Access View, in HLSL.  (Writable storage image or storage }
{ buffer.) }
type
  Pshaderc_uniform_kind = ^Tshaderc_uniform_kind;
  Tshaderc_uniform_kind =  Longint;
  Const
    shaderc_uniform_kind_image = 0;
    shaderc_uniform_kind_sampler = 1;
    shaderc_uniform_kind_texture = 2;
    shaderc_uniform_kind_buffer = 3;
    shaderc_uniform_kind_storage_buffer = 4;
    shaderc_uniform_kind_unordered_access_view = 5;
;
{ Usage examples: }
{ }
{ Aggressively release compiler resources, but spend time in initialization }
{ for each new use. }
{      shaderc_compiler_t compiler = shaderc_compiler_initialize(); }
{      shaderc_compilation_result_t result = shaderc_compile_into_spv( }
{          compiler, "#version 450\nvoid main() ", 27, }
{          shaderc_glsl_vertex_shader, "main.vert", "main", nullptr); }
{      // Do stuff with compilation results. }
{      shaderc_result_release(result); }
{      shaderc_compiler_release(compiler); }
{ }
{ Keep the compiler object around for a long time, but pay for extra space }
{ occupied. }
{      shaderc_compiler_t compiler = shaderc_compiler_initialize(); }
{      // On the same, other or multiple simultaneous threads. }
{      shaderc_compilation_result_t result = shaderc_compile_into_spv( }
{          compiler, "#version 450\nvoid main() ", 27, }
{          shaderc_glsl_vertex_shader, "main.vert", "main", nullptr); }
{      // Do stuff with compilation results. }
{      shaderc_result_release(result); }
{      // Once no more compilations are to happen. }
{      shaderc_compiler_release(compiler); }
{ An opaque handle to an object that manages all compiler state. }
type
  Pshaderc_compiler_t = ^Tshaderc_compiler_t;
  Tshaderc_compiler_t = Pshaderc_compiler;
{ Returns a shaderc_compiler_t that can be used to compile modules. }
{ A return of NULL indicates that there was an error initializing the compiler. }
{ Any function operating on shaderc_compiler_t must offer the basic }
{ thread-safety guarantee. }
{ [http://herbsutter.com/2014/01/13/gotw-95-solution-thread-safety-and-synchronization/] }
{ That is: concurrent invocation of these functions on DIFFERENT objects needs }
{ no synchronization; concurrent invocation of these functions on the SAME }
{ object requires synchronization IF AND ONLY IF some of them take a non-const }
{ argument. }

function shaderc_compiler_initialize:Tshaderc_compiler_t;cdecl;external;
{ Releases the resources held by the shaderc_compiler_t. }
{ After this call it is invalid to make any future calls to functions }
{ involving this shaderc_compiler_t. }
procedure shaderc_compiler_release(para1:Tshaderc_compiler_t);cdecl;external;
{ An opaque handle to an object that manages options to a single compilation }
{ result. }
type
  Pshaderc_compile_options_t = ^Tshaderc_compile_options_t;
  Tshaderc_compile_options_t = Pshaderc_compile_options;
{ Returns a default-initialized shaderc_compile_options_t that can be used }
{ to modify the functionality of a compiled module. }
{ A return of NULL indicates that there was an error initializing the options. }
{ Any function operating on shaderc_compile_options_t must offer the }
{ basic thread-safety guarantee. }

function shaderc_compile_options_initialize:Tshaderc_compile_options_t;cdecl;external;
{ Returns a copy of the given shaderc_compile_options_t. }
{ If NULL is passed as the parameter the call is the same as }
{ shaderc_compile_options_init. }
(* Const before type ignored *)
function shaderc_compile_options_clone(options:Tshaderc_compile_options_t):Tshaderc_compile_options_t;cdecl;external;
{ Releases the compilation options. It is invalid to use the given }
{ shaderc_compile_options_t object in any future calls. It is safe to pass }
{ NULL to this function, and doing such will have no effect. }
procedure shaderc_compile_options_release(options:Tshaderc_compile_options_t);cdecl;external;
{ Adds a predefined macro to the compilation options. This has the same }
{ effect as passing -Dname=value to the command-line compiler.  If value }
{ is NULL, it has the same effect as passing -Dname to the command-line }
{ compiler. If a macro definition with the same name has previously been }
{ added, the value is replaced with the new value. The macro name and }
{ value are passed in with char pointers, which point to their data, and }
{ the lengths of their data. The strings that the name and value pointers }
{ point to must remain valid for the duration of the call, but can be }
{ modified or deleted after this function has returned. In case of adding }
{ a valueless macro, the value argument should be a null pointer or the }
{ value_length should be 0u. }
(* Const before type ignored *)
(* Const before type ignored *)
procedure shaderc_compile_options_add_macro_definition(options:Tshaderc_compile_options_t; name:Pchar; name_length:Tsize_t; value:Pchar; value_length:Tsize_t);cdecl;external;
{ Sets the source language.  The default is GLSL. }
procedure shaderc_compile_options_set_source_language(options:Tshaderc_compile_options_t; lang:Tshaderc_source_language);cdecl;external;
{ Sets the compiler mode to generate debug information in the output. }
procedure shaderc_compile_options_set_generate_debug_info(options:Tshaderc_compile_options_t);cdecl;external;
{ Sets the compiler optimization level to the given level. Only the last one }
{ takes effect if multiple calls of this function exist. }
procedure shaderc_compile_options_set_optimization_level(options:Tshaderc_compile_options_t; level:Tshaderc_optimization_level);cdecl;external;
{ Forces the GLSL language version and profile to a given pair. The version }
{ number is the same as would appear in the #version annotation in the source. }
{ Version and profile specified here overrides the #version annotation in the }
{ source. Use profile: 'shaderc_profile_none' for GLSL versions that do not }
{ define profiles, e.g. versions below 150. }
procedure shaderc_compile_options_set_forced_version_profile(options:Tshaderc_compile_options_t; version:longint; profile:Tshaderc_profile);cdecl;external;
{ Source text inclusion via #include is supported with a pair of callbacks }
{ to an "includer" on the client side.  The first callback processes an }
{ inclusion request, and returns an include result.  The includer owns }
{ the contents of the result, and those contents must remain valid until the }
{ second callback is invoked to release the result.  Both callbacks take a }
{ user_data argument to specify the client context. }
{ To return an error, set the source_name to an empty string and put your }
{ error message in content. }
{ An include result. }
{ The name of the source file.  The name should be fully resolved }
{ in the sense that it should be a unique name in the context of the }
{ includer.  For example, if the includer maps source names to files in }
{ a filesystem, then this name should be the absolute path of the file. }
{ For a failed inclusion, this string is empty. }
(* Const before type ignored *)
{ The text contents of the source file in the normal case. }
{ For a failed inclusion, this contains the error message. }
(* Const before type ignored *)
{ User data to be passed along with this request. }
type
  Pshaderc_include_result = ^Tshaderc_include_result;
  Tshaderc_include_result = record
      source_name : Pchar;
      source_name_length : Tsize_t;
      content : Pchar;
      content_length : Tsize_t;
      user_data : pointer;
    end;
{ The kinds of include requests. }
{ E.g. #include "source" }
{ E.g. #include <source> }
  Tshaderc_include_type =  Longint;
  Const
    shaderc_include_type_relative = 0;
    shaderc_include_type_standard = 1;

{ An includer callback type for mapping an #include request to an include }
{ result.  The user_data parameter specifies the client context.  The }
{ requested_source parameter specifies the name of the source being requested. }
{ The type parameter specifies the kind of inclusion request being made. }
{ The requesting_source parameter specifies the name of the source containing }
{ the #include request.  The includer owns the result object and its contents, }
{ and both must remain valid until the release callback is called on the result }
{ object. }
(* Const before type ignored *)
(* Const before type ignored *)
type
  Pshaderc_include_resolve_fn = ^Tshaderc_include_resolve_fn;
  Tshaderc_include_resolve_fn = function (user_data:pointer; requested_source:Pchar; _type:longint; requesting_source:Pchar; include_depth:Tsize_t):Pshaderc_include_result;cdecl;
{ An includer callback type for destroying an include result. }

  Tshaderc_include_result_release_fn = procedure (user_data:pointer; include_result:Pshaderc_include_result);cdecl;
{ Sets includer callback functions. }

procedure shaderc_compile_options_set_include_callbacks(options:Tshaderc_compile_options_t; resolver:Tshaderc_include_resolve_fn; result_releaser:Tshaderc_include_result_release_fn; user_data:pointer);cdecl;external;
{ Sets the compiler mode to suppress warnings, overriding warnings-as-errors }
{ mode. When both suppress-warnings and warnings-as-errors modes are }
{ turned on, warning messages will be inhibited, and will not be emitted }
{ as error messages. }
procedure shaderc_compile_options_set_suppress_warnings(options:Tshaderc_compile_options_t);cdecl;external;
{ Sets the target shader environment, affecting which warnings or errors will }
{ be issued.  The version will be for distinguishing between different versions }
{ of the target environment.  The version value should be either 0 or }
{ a value listed in shaderc_env_version.  The 0 value maps to Vulkan 1.0 if }
{ |target| is Vulkan, and it maps to OpenGL 4.5 if |target| is OpenGL. }
procedure shaderc_compile_options_set_target_env(options:Tshaderc_compile_options_t; target:Tshaderc_target_env; version:Tuint32_t);cdecl;external;
{ Sets the target SPIR-V version. The generated module will use this version }
{ of SPIR-V.  Each target environment determines what versions of SPIR-V }
{ it can consume.  Defaults to the highest version of SPIR-V 1.0 which is }
{ required to be supported by the target environment.  E.g. Default to SPIR-V }
{ 1.0 for Vulkan 1.0 and SPIR-V 1.3 for Vulkan 1.1. }
procedure shaderc_compile_options_set_target_spirv(options:Tshaderc_compile_options_t; version:Tshaderc_spirv_version);cdecl;external;
{ Sets the compiler mode to treat all warnings as errors. Note the }
{ suppress-warnings mode overrides this option, i.e. if both }
{ warning-as-errors and suppress-warnings modes are set, warnings will not }
{ be emitted as error messages. }
procedure shaderc_compile_options_set_warnings_as_errors(options:Tshaderc_compile_options_t);cdecl;external;
{ Sets a resource limit. }
procedure shaderc_compile_options_set_limit(options:Tshaderc_compile_options_t; limit:Tshaderc_limit; value:longint);cdecl;external;
{ Sets whether the compiler should automatically assign bindings to uniforms }
{ that aren't already explicitly bound in the shader source. }
procedure shaderc_compile_options_set_auto_bind_uniforms(options:Tshaderc_compile_options_t; auto_bind:Tbool);cdecl;external;
{ Sets whether the compiler should automatically remove sampler variables }
{ and convert image variables to combined image-sampler variables. }
procedure shaderc_compile_options_set_auto_combined_image_sampler(options:Tshaderc_compile_options_t; upgrade:Tbool);cdecl;external;
{ Sets whether the compiler should use HLSL IO mapping rules for bindings. }
{ Defaults to false. }
procedure shaderc_compile_options_set_hlsl_io_mapping(options:Tshaderc_compile_options_t; hlsl_iomap:Tbool);cdecl;external;
{ Sets whether the compiler should determine block member offsets using HLSL }
{ packing rules instead of standard GLSL rules.  Defaults to false.  Only }
{ affects GLSL compilation.  HLSL rules are always used when compiling HLSL. }
procedure shaderc_compile_options_set_hlsl_offsets(options:Tshaderc_compile_options_t; hlsl_offsets:Tbool);cdecl;external;
{ Sets the base binding number used for for a uniform resource type when }
{ automatically assigning bindings.  For GLSL compilation, sets the lowest }
{ automatically assigned number.  For HLSL compilation, the regsiter number }
{ assigned to the resource is added to this specified base. }
procedure shaderc_compile_options_set_binding_base(options:Tshaderc_compile_options_t; kind:Tshaderc_uniform_kind; base:Tuint32_t);cdecl;external;
{ Like shaderc_compile_options_set_binding_base, but only takes effect when }
{ compiling a given shader stage.  The stage is assumed to be one of vertex, }
{ fragment, tessellation evaluation, tesselation control, geometry, or compute. }
procedure shaderc_compile_options_set_binding_base_for_stage(options:Tshaderc_compile_options_t; shader_kind:Tshaderc_shader_kind; kind:Tshaderc_uniform_kind; base:Tuint32_t);cdecl;external;
{ Sets whether the compiler should preserve all bindings, even when those }
{ bindings are not used. }
procedure shaderc_compile_options_set_preserve_bindings(options:Tshaderc_compile_options_t; preserve_bindings:Tbool);cdecl;external;
{ Sets whether the compiler should automatically assign locations to }
{ uniform variables that don't have explicit locations in the shader source. }
procedure shaderc_compile_options_set_auto_map_locations(options:Tshaderc_compile_options_t; auto_map:Tbool);cdecl;external;
{ Sets a descriptor set and binding for an HLSL register in the given stage. }
{ This method keeps a copy of the string data. }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage(options:Tshaderc_compile_options_t; shader_kind:Tshaderc_shader_kind; reg:Pchar; set:Pchar; binding:Pchar);cdecl;external;
{ Like shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage, }
{ but affects all shader stages. }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
procedure shaderc_compile_options_set_hlsl_register_set_and_binding(options:Tshaderc_compile_options_t; reg:Pchar; set:Pchar; binding:Pchar);cdecl;external;
{ Sets whether the compiler should enable extension }
{ SPV_GOOGLE_hlsl_functionality1. }
procedure shaderc_compile_options_set_hlsl_functionality1(options:Tshaderc_compile_options_t; enable:Tbool);cdecl;external;
{ Sets whether 16-bit types are supported in HLSL or not. }
procedure shaderc_compile_options_set_hlsl_16bit_types(options:Tshaderc_compile_options_t; enable:Tbool);cdecl;external;
{ Enables or disables relaxed Vulkan rules. }
{ }
{ This allows most OpenGL shaders to compile under Vulkan semantics. }
procedure shaderc_compile_options_set_vulkan_rules_relaxed(options:Tshaderc_compile_options_t; enable:Tbool);cdecl;external;
{ Sets whether the compiler should invert position.Y output in vertex shader. }
procedure shaderc_compile_options_set_invert_y(options:Tshaderc_compile_options_t; enable:Tbool);cdecl;external;
{ Sets whether the compiler generates code for max and min builtins which, }
{ if given a NaN operand, will return the other operand. Similarly, the clamp }
{ builtin will favour the non-NaN operands, as if clamp were implemented }
{ as a composition of max and min. }
procedure shaderc_compile_options_set_nan_clamp(options:Tshaderc_compile_options_t; enable:Tbool);cdecl;external;
{ An opaque handle to the results of a call to any shaderc_compile_into_*() }
{ function. }
type
  Pshaderc_compilation_result_t = ^Tshaderc_compilation_result_t;
  Tshaderc_compilation_result_t = Pshaderc_compilation_result;
{ Takes a GLSL source string and the associated shader kind, input file }
{ name, compiles it according to the given additional_options. If the shader }
{ kind is not set to a specified kind, but shaderc_glslc_infer_from_source, }
{ the compiler will try to deduce the shader kind from the source }
{ string and a failure in deducing will generate an error. Currently only }
{ #pragma annotation is supported. If the shader kind is set to one of the }
{ default shader kinds, the compiler will fall back to the default shader }
{ kind in case it failed to deduce the shader kind from source string. }
{ The input_file_name is a null-termintated string. It is used as a tag to }
{ identify the source string in cases like emitting error messages. It }
{ doesn't have to be a 'file name'. }
{ The source string will be compiled into SPIR-V binary and a }
{ shaderc_compilation_result will be returned to hold the results. }
{ The entry_point_name null-terminated string defines the name of the entry }
{ point to associate with this GLSL source. If the additional_options }
{ parameter is not null, then the compilation is modified by any options }
{ present.  May be safely called from multiple threads without explicit }
{ synchronization. If there was failure in allocating the compiler object, }
{ null will be returned. }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

function shaderc_compile_into_spv(compiler:Tshaderc_compiler_t; source_text:Pchar; source_text_size:Tsize_t; shader_kind:Tshaderc_shader_kind; input_file_name:Pchar; 
           entry_point_name:Pchar; additional_options:Tshaderc_compile_options_t):Tshaderc_compilation_result_t;cdecl;external;
{ Like shaderc_compile_into_spv, but the result contains SPIR-V assembly text }
{ instead of a SPIR-V binary module.  The SPIR-V assembly syntax is as defined }
{ by the SPIRV-Tools open source project. }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function shaderc_compile_into_spv_assembly(compiler:Tshaderc_compiler_t; source_text:Pchar; source_text_size:Tsize_t; shader_kind:Tshaderc_shader_kind; input_file_name:Pchar; 
           entry_point_name:Pchar; additional_options:Tshaderc_compile_options_t):Tshaderc_compilation_result_t;cdecl;external;
{ Like shaderc_compile_into_spv, but the result contains preprocessed source }
{ code instead of a SPIR-V binary module }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function shaderc_compile_into_preprocessed_text(compiler:Tshaderc_compiler_t; source_text:Pchar; source_text_size:Tsize_t; shader_kind:Tshaderc_shader_kind; input_file_name:Pchar; 
           entry_point_name:Pchar; additional_options:Tshaderc_compile_options_t):Tshaderc_compilation_result_t;cdecl;external;
{ Takes an assembly string of the format defined in the SPIRV-Tools project }
{ (https://github.com/KhronosGroup/SPIRV-Tools/blob/master/syntax.md), }
{ assembles it into SPIR-V binary and a shaderc_compilation_result will be }
{ returned to hold the results. }
{ The assembling will pick options suitable for assembling specified in the }
{ additional_options parameter. }
{ May be safely called from multiple threads without explicit synchronization. }
{ If there was failure in allocating the compiler object, null will be }
{ returned. }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
function shaderc_assemble_into_spv(compiler:Tshaderc_compiler_t; source_assembly:Pchar; source_assembly_size:Tsize_t; additional_options:Tshaderc_compile_options_t):Tshaderc_compilation_result_t;cdecl;external;
{ The following functions, operating on shaderc_compilation_result_t objects, }
{ offer only the basic thread-safety guarantee. }
{ Releases the resources held by the result object. It is invalid to use the }
{ result object for any further operations. }
procedure shaderc_result_release(result:Tshaderc_compilation_result_t);cdecl;external;
{ Returns the number of bytes of the compilation output data in a result }
{ object. }
(* Const before type ignored *)
function shaderc_result_get_length(result:Tshaderc_compilation_result_t):Tsize_t;cdecl;external;
{ Returns the number of warnings generated during the compilation. }
(* Const before type ignored *)
function shaderc_result_get_num_warnings(result:Tshaderc_compilation_result_t):Tsize_t;cdecl;external;
{ Returns the number of errors generated during the compilation. }
(* Const before type ignored *)
function shaderc_result_get_num_errors(result:Tshaderc_compilation_result_t):Tsize_t;cdecl;external;
{ Returns the compilation status, indicating whether the compilation succeeded, }
{ or failed due to some reasons, like invalid shader stage or compilation }
{ errors. }
(* Const before type ignored *)
function shaderc_result_get_compilation_status(para1:Tshaderc_compilation_result_t):Tshaderc_compilation_status;cdecl;external;
{ Returns a pointer to the start of the compilation output data bytes, either }
{ SPIR-V binary or char string. When the source string is compiled into SPIR-V }
{ binary, this is guaranteed to be castable to a uint32_t*. If the result }
{ contains assembly text or preprocessed source text, the pointer will point to }
{ the resulting array of characters. }
(* Const before type ignored *)
(* Const before type ignored *)
function shaderc_result_get_bytes(result:Tshaderc_compilation_result_t):Pchar;cdecl;external;
{ Returns a null-terminated string that contains any error messages generated }
{ during the compilation. }
(* Const before type ignored *)
(* Const before type ignored *)
function shaderc_result_get_error_message(result:Tshaderc_compilation_result_t):Pchar;cdecl;external;
{ Provides the version & revision of the SPIR-V which will be produced }
procedure shaderc_get_spv_version(version:Pdword; revision:Pdword);cdecl;external;
{ Parses the version and profile from a given null-terminated string }
{ containing both version and profile, like: '450core'. Returns false if }
{ the string can not be parsed. Returns true when the parsing succeeds. The }
{ parsed version and profile are returned through arguments. }
(* Const before type ignored *)
function shaderc_parse_version_profile(str:Pchar; version:Plongint; profile:Pshaderc_profile):Tbool;cdecl;external;
{ C++ end of extern C conditionnal removed }
{ __cplusplus }
{$endif}
{ SHADERC_SHADERC_H_ }

implementation


end.
