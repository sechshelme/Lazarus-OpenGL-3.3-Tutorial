#version 330

// https://www.khronos.org/opengl/wiki/Geometry_Shader

#define distance 0.5
#define count 5

layout(triangles) in;
layout(triangle_strip, max_vertices = 1256) out;

//out vec3 Color; // Farb-Ausgabe für den Fragment-Shader
// Daten für Fragment-shader
out  vec3 Data_Pos;
out  vec3 Data_Normal;

void main(void)
{

for (int x = -count; x < count; x++) {
   for (int y = -count; y < count; y++) {

     for(int i = 0; i < gl_in.length(); i++) {
        gl_Position = gl_in[i].gl_Position + vec4(30.0 * x, 30.0 * y, 0.0, 0.0);

  //      Color = vec3(1.0, 0.0, 0.0);
        Data_Normal = vec3(1,1,1);
  //      Data_Normal = vec3(0,0,0);

        EmitVertex();
     }
     EndPrimitive();
   }
  }
}
