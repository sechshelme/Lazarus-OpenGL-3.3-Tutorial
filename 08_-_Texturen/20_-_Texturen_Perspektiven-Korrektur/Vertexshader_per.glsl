#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec4 inUV;    // Textur-Koordinaten

uniform mat4 mat;

out vec4 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.

 // UV0.z=0.0;
//  UV0.w=1.0;
//  UV0.w=abs(UV0.x / 3.0);


}
