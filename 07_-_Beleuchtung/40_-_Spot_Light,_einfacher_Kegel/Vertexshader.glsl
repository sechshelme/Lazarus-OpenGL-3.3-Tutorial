#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten

out Data {
  vec3 pos;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}
