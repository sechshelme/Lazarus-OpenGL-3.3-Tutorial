#version 330

layout (location = 0) in vec3 inPos;     // Vertex-Koordinaten
layout (location = 10) in vec2 inUV0;    // Textur-Koordinaten
layout (location = 11) in vec2 inUV1;    // Textur-Koordinaten

uniform mat4 mat;

out vec2 UV0;
out vec2 UV1;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV0;                           // Textur-Koordinaten weiterleiten.
  UV1 = inUV1;                           // Textur-Koordinaten weiterleiten.
}
