#version 400

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 1) in vec2 inTex; // Textur-Koordinaten

out vec2 TexCoord;
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  TexCoord = inTex;
}
