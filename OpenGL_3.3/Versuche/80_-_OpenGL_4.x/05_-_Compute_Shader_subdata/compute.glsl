//ARB_compute_shader
#version 420
#extension GL_ARB_compute_shader : enable
#extension GL_ARB_shader_storage_buffer_object : enable

layout (local_size_x = 1) in;

layout(std430, binding = 1) buffer Out
{
  float DataOut[];
};

layout(std430, binding = 0) buffer In
{
  float DataIn[];
};

void main()
{
  uint n = gl_NumWorkGroups.x;
  for (int i; i < n; i ++)
  {
	DataOut[i] = DataIn[i] * 3;
  }
}

