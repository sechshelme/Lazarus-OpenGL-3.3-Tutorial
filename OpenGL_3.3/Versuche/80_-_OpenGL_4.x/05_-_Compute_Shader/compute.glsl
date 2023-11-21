#version 430

layout (local_size_x = 7) in;

layout(std430, binding = 1) writeonly buffer Ouput
{
  float Data[];
} Out;

layout(std430, binding = 0) readonly buffer Input
{
float Data[];
} In;

void main()
{
  uint n = gl_NumWorkGroups.x;
  for (int i; i < n-1; i ++)
  {
	Out.Data[i] = In.Data[i] * 3;
  }
	//Out.Data[0] = gl_NumWorkGroups.x;
	//Out.Data[1] = gl_WorkGroupSize.x;
	//Out.Data[2] = gl_LocalInvocationIndex;
	//Out.Data[2] = gl_LocalInvocationIndex;
	//Out.Data[2] = gl_LocalInvocationIndex;
}

