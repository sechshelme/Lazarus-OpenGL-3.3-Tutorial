#version 330

layout (location = 0) in vec3 inPos;   // Vertex-Koordinaten
layout (location = 1) in vec2 inUV;    // Textur-Koordinaten

layout (std140) uniform UBO {
  mat4x4 mat;
};

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
