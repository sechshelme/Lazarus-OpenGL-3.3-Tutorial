#version 330

layout(triangles) in;
layout(triangle_strip, max_vertices = 12) out;

in vec3 tcol[];
out vec3 gcol;
out vec3 gnorm;

void main(void)

{
   vec3 n = cross(gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz,
                  gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz);

   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position;
      gcol = tcol[i];
      gnorm = n;
      EmitVertex();
   }
   EndPrimitive();
}

