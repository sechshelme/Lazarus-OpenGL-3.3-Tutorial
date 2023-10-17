#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
uniform mat4 mat;                        // Matrix von Uniform

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.
}
