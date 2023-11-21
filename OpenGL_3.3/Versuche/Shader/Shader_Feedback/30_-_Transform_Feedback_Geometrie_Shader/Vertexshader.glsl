#version 420

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten

uniform mat4x4 matrix;

void main(void)
{
  gl_Position = matrix * vec4(inPos, 1.0);
}
