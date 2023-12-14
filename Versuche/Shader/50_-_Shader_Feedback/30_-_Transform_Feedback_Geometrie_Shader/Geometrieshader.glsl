#version 420

#define distance 0.5

layout(triangles) in;
layout(triangle_strip, max_vertices = 9) out;

out vec3 Color; // Farb-Ausgabe für den Fragment-Shader

out float posx;
out float posy;



void main(void)
{

// Linke Meshes
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(-distance, 0.0, 0.0, 0.0); // nach Links verschieben
      Color = vec3(1.0, 0.0, 0.0);                                         // Links Rot
      posx=gl_Position.x;
      posy=gl_Position.y;
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
      posx=gl_Position.x;
      posy=gl_Position.y;
      EmitVertex();
   }
   EndPrimitive();


// Rechte Meshes
   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + vec4(distance, 0.0, 0.0, 0.0);  // nach Rechts verschieben
      Color = vec3(0.0, 1.0, 0.0);                                         // Rechts Grün
      posx=gl_Position.x;
      posy=gl_Position.y;
      EmitVertex();
   }
   EndPrimitive();
}
