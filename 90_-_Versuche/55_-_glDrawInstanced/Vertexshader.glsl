#version 330

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten

out vec2 UV0;

uniform mat4 Matrix[30];              // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  mat4 m = Matrix[gl_InstanceID];
  gl_Position = m * vec4(inPos, 1.0);

//  gl_Position = Matrix[gl_InstanceID] * vec4(inPos, 1.0);
  UV0         = inUV;                 // Textur-Koordinaten weiterleiten.
}
