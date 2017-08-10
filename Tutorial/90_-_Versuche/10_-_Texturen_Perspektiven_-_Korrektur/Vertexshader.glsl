#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec4 inUV;    // Textur-Koordinaten

uniform mat4 mat;
uniform mat4 texMat;

out vec4 UV0;
//out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);

  UV0 = texMat * (inUV- vec4(-0.5, -0.5, 0.0, 0.0));
}
