#version 330

//#define Instance_Count 200

// Vektor-Daten
layout (location = 0) in vec2 inPos;

// Instancen
layout (location = 1) in float Size;
layout (location = 2) in mat4 mat;
layout (location = 6) in vec3 Color;

out vec3 col;

void main(void)
{
  gl_Position = mat * vec4((inPos * Size), 0.0, 1.0);

  col = Color;
}
