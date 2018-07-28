#version 330

layout (location =  0) in vec3  inPos;   // Vertex-Koordinaten
layout (location = 10) in float inUV;    // Textur-Koordinaten als Float-Array

uniform mat4 mat;

out float UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
