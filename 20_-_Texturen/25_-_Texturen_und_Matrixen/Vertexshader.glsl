#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;
uniform mat3 texMat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);

  // Texturkoordinaten transformieren
  UV0 = (texMat * vec3(inUV, 1.0)).xy;
}
