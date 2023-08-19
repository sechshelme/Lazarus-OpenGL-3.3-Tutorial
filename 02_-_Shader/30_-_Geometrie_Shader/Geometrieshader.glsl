#version 330

#define distance 0.5

layout(triangles) in;
layout(triangle_strip, max_vertices = 9) out;

out vec3 Color; // Farb-Ausgabe für den Fragment-Shader 

void main(void)
{

// Linke Meshes
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(-distance, 0.0, 0.0, 0.0); // nach Links verschieben
      Color = vec3(1.0, 0.0, 0.0);                                         // Links Rot
      EmitVertex();
   }
   EndPrimitive();


// Mittlere Meshes
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(0.0, 0.0, 0.0, 0.0); // nicht verschieben
      gl_Position.y *= -0.5;
      gl_Position.x *= 0.5;
      Color = vec3(0.0, 0.0, 1.0);                                   // Mitte blau
      EmitVertex();
   }
   EndPrimitive();


// Rechte Meshes
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(distance, 0.0, 0.0, 0.0);  // nach Rechts verschieben
      Color = vec3(0.0, 1.0, 0.0);                                         // Rechts Grün
      EmitVertex();
   }
   EndPrimitive();
}
