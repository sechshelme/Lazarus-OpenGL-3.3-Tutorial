#version 330

#define Instance_Count 255

uniform int chars[Instance_Count];
uniform mat4 mat;

out vec2 UV0;
out float layer;

const vec2 QuadVertex[] = vec2[] (
    vec2(0.0, 1.0), vec2(1.0, 0.0), vec2(0.0, 0.0),
    vec2(0.0, 1.0), vec2(1.0, 1.0), vec2(1.0, 0.0));

const vec2 TextureVertex[] = vec2[] (
    vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(0.0, 1.0),
    vec2(0.0, 0.0), vec2(1.0, 0.0), vec2(1.0, 1.0));

void main(void)
{
  vec2 p2 = QuadVertex[gl_VertexID];
  vec4 p  = vec4(p2, 0.0, 1.0);
  p.x += float(gl_InstanceID)*1.1;

  gl_Position = mat * p;

  layer = chars[gl_InstanceID] - 32;

  UV0 = TextureVertex[gl_VertexID];
  UV0.y *= 1;
}
