#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten

uniform mat4 Matrix;                  // Matrix für die Drehbewegung
 
void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
}
