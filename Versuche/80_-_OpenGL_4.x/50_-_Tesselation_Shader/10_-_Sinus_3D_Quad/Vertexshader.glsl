#version 330

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  gl_Position.xz *= 0.5;
}
