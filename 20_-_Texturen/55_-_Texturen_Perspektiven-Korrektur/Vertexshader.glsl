#version 330

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec2 inUV0;    // Textur-Koordinaten
layout (location = 11) in vec3 inUV1;

uniform mat4 mat;

out Data {
  vec2 UV0;
  vec3 UV1;
} DataOut;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  DataOut.UV0 = inUV0;
  DataOut.UV1 = inUV1;
}
