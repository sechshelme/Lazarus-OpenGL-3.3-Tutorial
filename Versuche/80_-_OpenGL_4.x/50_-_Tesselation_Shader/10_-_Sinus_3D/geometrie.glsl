#version 330

layout(triangles) in;
layout(triangle_strip, max_vertices = 12) out;

void main(void)
{
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(0, 0, 0.0, 0.0);;
      EmitVertex();
   }
   EndPrimitive();
}

