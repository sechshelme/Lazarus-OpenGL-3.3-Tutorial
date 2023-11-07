#version 330

layout (location = 0) in vec3 inPos;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
};

out vec3 vcol;

void main(void)
{
  gl_Position = WorldMatrix * ModelMatrix * vec4(inPos, 1.0);

  switch (gl_VertexID / 6) // Den aktuellen Vertex abfragen.
  {
    case 0:  vcol = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  vcol = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  vcol = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  vcol = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  vcol = vec3(0.0, 1.0, 1.0);
             break;
    default: vcol = vec3(1.0, 0.0, 1.0);
  }}
