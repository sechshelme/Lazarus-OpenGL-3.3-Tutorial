#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 mat;

out vec3 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inPos;                           // Textur-Koordinaten weiterleiten.
}
