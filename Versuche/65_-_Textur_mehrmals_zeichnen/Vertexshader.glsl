#version 330

layout (location =  0) in vec2 inPos;   // Vertex-Koordinaten
layout (location =  1) in vec2 inUV;    // Textur-Koordinaten

// Instancen
layout (location =  5) in float inLayer;    // Textur-Koordinaten
layout (location =  6) in float inAngele;    // Textur-Koordinaten
layout (location =  7) in vec2 inTranslate;    // Textur-Koordinaten


uniform mat4 mat;

out vec2 UV0;
out float Layer;

vec2 rotate(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

void main(void)
{


  vec2 pos = inPos;
  pos = rotate(inPos, inAngele);
  pos.xy += inTranslate;

  gl_Position = mat * vec4(pos, 0.0, 1.0);
  UV0 = inUV;
  Layer = inLayer;
}
