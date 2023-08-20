#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten

out VS_OUT {
    vec3 color;
} vs_out;
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  vs_out.color =  vec3(0.5, 0.5, 0.5);
}
