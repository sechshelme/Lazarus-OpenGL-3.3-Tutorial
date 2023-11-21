#version 330

#define distance 0.4
#define size     0.11

layout(points) in;
layout(triangle_strip, max_vertices = 7) out;

in VS_OUT {
    vec3 color;
} gs_in[];

out vec3 Color; // Farb-Ausgabe für den Fragment-Shader 

void main(void)
{

// Linke Meshes ( 4 Eck )
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(-distance, size * 1.3, size, 0.0);
      Color = vec3(0.0, 0.0, 0.0);
      EmitVertex();

      gl_Position = gl_in[i].gl_Position + vec4(-distance + size, -size * 1.3, 0.0, 0.0);
      Color = gs_in[i].color;
      EmitVertex();

      gl_Position = gl_in[i].gl_Position + vec4(-distance - size, -size * 1.3, 0.0, 0.0);
      Color = gs_in[i].color;
      EmitVertex();

      gl_Position = gl_in[i].gl_Position + vec4(-distance, -size * 1.3 * 2, 0.0, 0.0);
      Color = vec3(1.0, 1.0, 1.0);
      EmitVertex();
   }
   EndPrimitive();

// Rechte Meshes ( 3 Eck )
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(distance, size, size, 0.0);
      Color = gs_in[i].color;
      EmitVertex();
      gl_Position = gl_in[i].gl_Position + vec4(distance + size, -size, 0.0, 0.0);
      Color = gs_in[i].color;
      EmitVertex();
      gl_Position = gl_in[i].gl_Position + vec4(distance - size, -size, 0.0, 0.0);
      Color = gs_in[i].color;
      EmitVertex();
   }
   EndPrimitive();
}
