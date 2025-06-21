unit fp_shaderc;

interface

uses
  env, status;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

const
  libshaderc = 'libshaderc';

type
  Tsize_t = SizeInt;
  Tbool = boolean;


  // ================ env.h =============================

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


  // ================== status.h ===============

type
  Pshaderc_compilation_status = ^Tshaderc_compilation_status;
  Tshaderc_compilation_status = longint;

const
  shaderc_compilation_status_success = 0;
  shaderc_compilation_status_invalid_stage = 1;
  shaderc_compilation_status_compilation_error = 2;
  shaderc_compilation_status_internal_error = 3;
  shaderc_compilation_status_null_result_object = 4;
  shaderc_compilation_status_invalid_assembly = 5;
  shaderc_compilation_status_validation_error = 6;
  shaderc_compilation_status_transformation_error = 7;
  shaderc_compilation_status_configuration_error = 8;


  // =========== shaderc.h ========================

type
  Pshaderc_source_language = ^Tshaderc_source_language;
  Tshaderc_source_language = longint;

const
  shaderc_source_language_glsl = 0;
  shaderc_source_language_hlsl = 1;

type
  Pshaderc_shader_kind = ^Tshaderc_shader_kind;
  Tshaderc_shader_kind = longint;

const
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
  shaderc_glsl_infer_from_source = (shaderc_tess_evaluation_shader) + 1;
  shaderc_glsl_default_vertex_shader = (shaderc_tess_evaluation_shader) + 2;
  shaderc_glsl_default_fragment_shader = (shaderc_tess_evaluation_shader) + 3;
  shaderc_glsl_default_compute_shader = (shaderc_tess_evaluation_shader) + 4;
  shaderc_glsl_default_geometry_shader = (shaderc_tess_evaluation_shader) + 5;
  shaderc_glsl_default_tess_control_shader = (shaderc_tess_evaluation_shader) + 6;
  shaderc_glsl_default_tess_evaluation_shader = (shaderc_tess_evaluation_shader) + 7;
  shaderc_spirv_assembly = (shaderc_tess_evaluation_shader) + 8;
  shaderc_raygen_shader = (shaderc_tess_evaluation_shader) + 9;
  shaderc_anyhit_shader = (shaderc_tess_evaluation_shader) + 10;
  shaderc_closesthit_shader = (shaderc_tess_evaluation_shader) + 11;
  shaderc_miss_shader = (shaderc_tess_evaluation_shader) + 12;
  shaderc_intersection_shader = (shaderc_tess_evaluation_shader) + 13;
  shaderc_callable_shader = (shaderc_tess_evaluation_shader) + 14;
  shaderc_glsl_raygen_shader = shaderc_raygen_shader;
  shaderc_glsl_anyhit_shader = shaderc_anyhit_shader;
  shaderc_glsl_closesthit_shader = shaderc_closesthit_shader;
  shaderc_glsl_miss_shader = shaderc_miss_shader;
  shaderc_glsl_intersection_shader = shaderc_intersection_shader;
  shaderc_glsl_callable_shader = shaderc_callable_shader;
  shaderc_glsl_default_raygen_shader = (shaderc_callable_shader) + 1;
  shaderc_glsl_default_anyhit_shader = (shaderc_callable_shader) + 2;
  shaderc_glsl_default_closesthit_shader = (shaderc_callable_shader) + 3;
  shaderc_glsl_default_miss_shader = (shaderc_callable_shader) + 4;
  shaderc_glsl_default_intersection_shader = (shaderc_callable_shader) + 5;
  shaderc_glsl_default_callable_shader = (shaderc_callable_shader) + 6;
  shaderc_task_shader = (shaderc_callable_shader) + 7;
  shaderc_mesh_shader = (shaderc_callable_shader) + 8;
  shaderc_glsl_task_shader = shaderc_task_shader;
  shaderc_glsl_mesh_shader = shaderc_mesh_shader;
  shaderc_glsl_default_task_shader = (shaderc_mesh_shader) + 1;
  shaderc_glsl_default_mesh_shader = (shaderc_mesh_shader) + 2;

type
  Pshaderc_profile = ^Tshaderc_profile;
  Tshaderc_profile = longint;

const
  shaderc_profile_none = 0;
  shaderc_profile_core = 1;
  shaderc_profile_compatibility = 2;
  shaderc_profile_es = 3;

type
  Pshaderc_optimization_level = ^Tshaderc_optimization_level;
  Tshaderc_optimization_level = longint;

const
  shaderc_optimization_level_zero = 0;
  shaderc_optimization_level_size = 1;
  shaderc_optimization_level_performance = 2;

type
  Pshaderc_limit = ^Tshaderc_limit;
  Tshaderc_limit = longint;

const
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

type
  Pshaderc_uniform_kind = ^Tshaderc_uniform_kind;
  Tshaderc_uniform_kind = longint;

const
  shaderc_uniform_kind_image = 0;
  shaderc_uniform_kind_sampler = 1;
  shaderc_uniform_kind_texture = 2;
  shaderc_uniform_kind_buffer = 3;
  shaderc_uniform_kind_storage_buffer = 4;
  shaderc_uniform_kind_unordered_access_view = 5;

type
  Tshaderc_compiler = record
  end;
  Pshaderc_compiler = ^Tshaderc_compiler;

function shaderc_compiler_initialize: Pshaderc_compiler; cdecl; external libshaderc;
procedure shaderc_compiler_release(para1: Pshaderc_compiler); cdecl; external libshaderc;

type
  Tshaderc_compile_options = record
  end;
  Pshaderc_compile_options = ^Tshaderc_compile_options;

function shaderc_compile_options_initialize: Pshaderc_compile_options; cdecl; external libshaderc;
function shaderc_compile_options_clone(options: Pshaderc_compile_options): Pshaderc_compile_options; cdecl; external libshaderc;
procedure shaderc_compile_options_release(options: Pshaderc_compile_options); cdecl; external libshaderc;
procedure shaderc_compile_options_add_macro_definition(options: Pshaderc_compile_options; name: PAnsiChar; name_length: Tsize_t; value: PAnsiChar; value_length: Tsize_t); cdecl; external libshaderc;
procedure shaderc_compile_options_set_source_language(options: Pshaderc_compile_options; lang: Tshaderc_source_language); cdecl; external libshaderc;
procedure shaderc_compile_options_set_generate_debug_info(options: Pshaderc_compile_options); cdecl; external libshaderc;
procedure shaderc_compile_options_set_optimization_level(options: Pshaderc_compile_options; level: Tshaderc_optimization_level); cdecl; external libshaderc;
procedure shaderc_compile_options_set_forced_version_profile(options: Pshaderc_compile_options; version: longint; profile: Tshaderc_profile); cdecl; external libshaderc;

type
  Tshaderc_include_result = record
    source_name: PAnsiChar;
    source_name_length: Tsize_t;
    content: PAnsiChar;
    content_length: Tsize_t;
    user_data: pointer;
  end;
  Pshaderc_include_result = ^Tshaderc_include_result;

type
  Tshaderc_include_type = longint;

const
  shaderc_include_type_relative = 0;
  shaderc_include_type_standard = 1;

type
  Tshaderc_include_resolve_fn = function(user_data: pointer; requested_source: PAnsiChar; _type: longint; requesting_source: PAnsiChar; include_depth: Tsize_t): Pshaderc_include_result; cdecl;
  Tshaderc_include_result_release_fn = procedure(user_data: pointer; include_result: Pshaderc_include_result); cdecl;

procedure shaderc_compile_options_set_include_callbacks(options: Pshaderc_compile_options; resolver: Tshaderc_include_resolve_fn; result_releaser: Tshaderc_include_result_release_fn; user_data: pointer); cdecl; external libshaderc;
procedure shaderc_compile_options_set_suppress_warnings(options: Pshaderc_compile_options); cdecl; external libshaderc;
procedure shaderc_compile_options_set_target_env(options: Pshaderc_compile_options; target: Tshaderc_target_env; version: uint32); cdecl; external libshaderc;
procedure shaderc_compile_options_set_target_spirv(options: Pshaderc_compile_options; version: Tshaderc_spirv_version); cdecl; external libshaderc;
procedure shaderc_compile_options_set_warnings_as_errors(options: Pshaderc_compile_options); cdecl; external libshaderc;
procedure shaderc_compile_options_set_limit(options: Pshaderc_compile_options; limit: Tshaderc_limit; value: longint); cdecl; external libshaderc;
procedure shaderc_compile_options_set_auto_bind_uniforms(options: Pshaderc_compile_options; auto_bind: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_auto_combined_image_sampler(options: Pshaderc_compile_options; upgrade: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_io_mapping(options: Pshaderc_compile_options; hlsl_iomap: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_offsets(options: Pshaderc_compile_options; hlsl_offsets: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_binding_base(options: Pshaderc_compile_options; kind: Tshaderc_uniform_kind; base: uint32); cdecl; external libshaderc;
procedure shaderc_compile_options_set_binding_base_for_stage(options: Pshaderc_compile_options; shader_kind: Tshaderc_shader_kind; kind: Tshaderc_uniform_kind; base: uint32); cdecl; external libshaderc;
procedure shaderc_compile_options_set_preserve_bindings(options: Pshaderc_compile_options; preserve_bindings: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_auto_map_locations(options: Pshaderc_compile_options; auto_map: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage(options: Pshaderc_compile_options; shader_kind: Tshaderc_shader_kind; reg: PAnsiChar; set_: PAnsiChar; binding: PAnsiChar); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_register_set_and_binding(options: Pshaderc_compile_options; reg: PAnsiChar; set_: PAnsiChar; binding: PAnsiChar); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_functionality1(options: Pshaderc_compile_options; enable: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_hlsl_16bit_types(options: Pshaderc_compile_options; enable: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_vulkan_rules_relaxed(options: Pshaderc_compile_options; enable: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_invert_y(options: Pshaderc_compile_options; enable: Tbool); cdecl; external libshaderc;
procedure shaderc_compile_options_set_nan_clamp(options: Pshaderc_compile_options; enable: Tbool); cdecl; external libshaderc;

type
  Tshaderc_compilation_result = record
  end;
  Pshaderc_compilation_result = ^Tshaderc_compilation_result;

function shaderc_compile_into_spv(compiler: Pshaderc_compiler; source_text: PAnsiChar; source_text_size: Tsize_t; shader_kind: Tshaderc_shader_kind; input_file_name: PAnsiChar;
  entry_point_name: PAnsiChar; additional_options: Pshaderc_compile_options): Pshaderc_compilation_result; cdecl; external libshaderc;
function shaderc_compile_into_spv_assembly(compiler: Pshaderc_compiler; source_text: PAnsiChar; source_text_size: Tsize_t; shader_kind: Tshaderc_shader_kind; input_file_name: PAnsiChar;
  entry_point_name: PAnsiChar; additional_options: Pshaderc_compile_options): Pshaderc_compilation_result; cdecl; external libshaderc;
function shaderc_compile_into_preprocessed_text(compiler: Pshaderc_compiler; source_text: PAnsiChar; source_text_size: Tsize_t; shader_kind: Tshaderc_shader_kind; input_file_name: PAnsiChar;
  entry_point_name: PAnsiChar; additional_options: Pshaderc_compile_options): Pshaderc_compilation_result; cdecl; external libshaderc;
function shaderc_assemble_into_spv(compiler: Pshaderc_compiler; source_assembly: PAnsiChar; source_assembly_size: Tsize_t; additional_options: Pshaderc_compile_options): Pshaderc_compilation_result; cdecl; external libshaderc;
procedure shaderc_result_release(res: Pshaderc_compilation_result); cdecl; external libshaderc;
function shaderc_result_get_length(result: Pshaderc_compilation_result): Tsize_t; cdecl; external libshaderc;
function shaderc_result_get_num_warnings(result: Pshaderc_compilation_result): Tsize_t; cdecl; external libshaderc;
function shaderc_result_get_num_errors(result: Pshaderc_compilation_result): Tsize_t; cdecl; external libshaderc;
function shaderc_result_get_compilation_status(para1: Pshaderc_compilation_result): Tshaderc_compilation_status; cdecl; external libshaderc;
function shaderc_result_get_bytes(result: Pshaderc_compilation_result): PAnsiChar; cdecl; external libshaderc;
function shaderc_result_get_error_message(result: Pshaderc_compilation_result): PAnsiChar; cdecl; external libshaderc;
procedure shaderc_get_spv_version(version: Pdword; revision: Pdword); cdecl; external libshaderc;
function shaderc_parse_version_profile(str: PAnsiChar; version: Plongint; profile: Pshaderc_profile): Tbool; cdecl; external libshaderc;

// === Konventiert am: 19-6-25 14:35:38 ===


implementation



end.
