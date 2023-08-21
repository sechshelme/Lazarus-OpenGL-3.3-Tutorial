#version 330

// https://www.khronos.org/opengl/wiki/Geometry_Shader

#define distance 0.5
#define count 5

layout(triangles) in;
layout(triangle_strip, max_vertices = 256) out;

//out vec3 Color; // Farb-Ausgabe für den Fragment-Shader
// Daten für Fragment-shader

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;


in VS_OUT {
    vec3 Normal;
} gs_in[];

out GS_OUT {
    vec3 Pos;
    vec3 Normal;
} gs_out;

vec4 gp;


void main(void)
{

for (int x = -count; x < count; x++) {
   for (int y = -count; y < count; y++) {

     for(int i = 0; i < gl_in.length(); i++) {
        //  gl_Position    = Matrix * vec4(inPos, 1.0);
        gp = gl_in[i].gl_Position;
        gp = gp + vec4(1.3 * x, 1.3 * y, 0.0, 0.0);
        gp = Matrix * gp;
        gl_Position = gp;

        gs_out.Pos = (ModelMatrix * gl_Position).xyz;
        gs_out.Normal =  mat3(ModelMatrix) * gs_in[i].Normal;

        EmitVertex();
     }
     EndPrimitive();
   }
  }
}
