#version 330

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten
layout (location =  1) in vec3 inNormal; // Normale
layout (location = 10) in vec2 inUV;     // Textur-Koordinaten

// Daten für Fragment-shader
out Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
  DataOut.UV     = inUV;
}
