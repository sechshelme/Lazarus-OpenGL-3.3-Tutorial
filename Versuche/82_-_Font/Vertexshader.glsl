#version 330

#define Instance_Count 255

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform int chars[Instance_Count];

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  vec4 p = vec4(inPos, 1.0);
  p.x += float(gl_InstanceID) ;

  gl_Position = mat * p;

  int ofs = chars[gl_InstanceID] - 32;

  UV0 = inUV;
  UV0.x /= 94 * 2;
  UV0.x += (1.0 / 94) * ofs;

  UV0.y *= -1;
}
