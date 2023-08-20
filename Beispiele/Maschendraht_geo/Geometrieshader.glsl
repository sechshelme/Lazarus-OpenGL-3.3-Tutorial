#version 330

// https://www.khronos.org/opengl/wiki/Geometry_Shader

#define distance 0.5
#define count 5

layout(triangles) in;
layout(triangle_strip, max_vertices = 256) out;

//out vec3 Color; // Farb-Ausgabe für den Fragment-Shader
// Daten für Fragment-shader

out  vec3 Data_Pos;
out  vec3 Data_Normal;

in VS_OUT {
    vec3 Pos;
    vec3 Normal;
} gs_in[];


void main(void)
{

for (int x = -count; x < count; x++) {
   for (int y = -count; y < count; y++) {

     for(int i = 0; i < gl_in.length(); i++) {
        gl_Position = gl_in[i].gl_Position + vec4(30.0 * x, 60.0 * y, 0.0, 0.0);

        Data_Normal = gs_in[i].Normal;
        Data_Pos = gs_in[i].Pos  + vec3(30.0 * x, 60.0 * y, 0.0);
//        Data_Pos = gs_in[i].Pos;

        EmitVertex();
     }
     EndPrimitive();
   }
  }
}
