#version 330

#define distance 0.1

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out vec2 UV0;

void main(void)
{
  vec4 p = gl_in[0].gl_Position;

      gl_Position = p + vec4(-distance, distance, 0.0, 0.0);
      UV0 = vec2(0.0, 1.0);
      EmitVertex();
      gl_Position = p + vec4(-distance, -distance, 0.0, 0.0);
      UV0 = vec2(0.0, 0.0);
      EmitVertex();
      gl_Position = p + vec4(distance, distance, 0.0, 0.0);
      UV0 = vec2(1.0, 1.0);
      EmitVertex();
      gl_Position = p + vec4(distance, -distance, 0.0, 0.0);
      UV0 = vec2(1.0, 0.0);
      EmitVertex();

   EndPrimitive();
}
