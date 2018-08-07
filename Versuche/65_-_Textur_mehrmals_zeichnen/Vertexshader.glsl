#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten
layout (location =  1) in vec2 inUV;    // Textur-Koordinaten

// Instancen
layout (location =  5) in float inLayer;    // Textur-Koordinaten
layout (location =  6) in vec2 inTranslate;    // Textur-Koordinaten


uniform mat4 mat;

out vec2 UV0;
out float Layer;

void main(void)
{
  vec4 pos = vec4(inPos, 1.0);
  pos.xy += inTranslate;

  gl_Position = mat * pos;
  UV0 = inUV;
  Layer = inLayer;
}
