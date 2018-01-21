#version 330

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec2 inUV0;    // Textur-Koordinaten
layout (location = 11) in vec3 inUV1;    // Textur-Koordinaten
layout (location = 12) in vec4 inUV2;    // Textur-Koordinaten

uniform mat4 mat;

out Data {
  vec2 UV0;
  out vec3 UV1;
  out vec4 UV2;
} DataOut;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  DataOut.UV0 = inUV0;                           // Textur-Koordinaten weiterleiten.
  DataOut.UV1 = inUV1,                           // Textur-Koordinaten weiterleiten.
  DataOut.UV2 = inUV2;                           // Textur-Koordinaten weiterleiten.
}
