#version 330

layout (location = 10) in vec3 inPos;    // Vertex-Koordinaten

out vec2 PosXY;


void main(void)
{
  vec4 p = vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.
  PosXY = p.xy;
  gl_Position = p;
}
