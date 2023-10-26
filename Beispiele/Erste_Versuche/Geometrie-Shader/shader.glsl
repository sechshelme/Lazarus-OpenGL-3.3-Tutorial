$vertex
#version 330

layout (location = 0) in vec3 inPos;
layout (location = 10) in vec2 vertexUV0;

uniform mat4 WorldMatrix;

out vec2 UV0;

void main(void)
{
  gl_Position = WorldMatrix * vec4(inPos, 1.0);
  UV0 = vertexUV0;
}


$geometrie
#version 330
#define dist  0.4

layout(triangles) in;
layout(triangle_strip, max_vertices = 12) out;

in vec2 UV0[];

out vec2 vUV0;

void main(void)
{
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(-dist, dist, 0.0, 0.0);;
      vUV0 = UV0[i];
      EmitVertex();
   }
   EndPrimitive();

   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(dist, dist, 0.0, 0.0);
      vUV0 = UV0[i];
      EmitVertex();
   }
   EndPrimitive();

   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(-dist, -dist, 0.0, 0.0);;
      vUV0 = UV0[i];
      EmitVertex();
   }
   EndPrimitive();

   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(dist, -dist, 0.0, 0.0);
      vUV0 = UV0[i];
      EmitVertex();
   }
   EndPrimitive();
}


$fragment
#version 330

in vec2 vUV0;

uniform sampler2D myTextureSampler[8];

out vec4 FragColor;

void main()
{
  FragColor = texture( myTextureSampler[0], vUV0);
}
