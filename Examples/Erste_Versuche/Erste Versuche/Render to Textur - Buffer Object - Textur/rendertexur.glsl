$vertex
#version 330

layout (location = 0) in vec3 inPos;
layout (location = 2) in vec3 inColor;
layout (location = 10) in vec2 vertexUV0;

out vec4 Color;
out vec2 UV0;


uniform mat4 Matrix;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = vec4(inColor, 1.0);
  UV0 = vertexUV0;
}


$fragment
#version 330
in vec4 Color;     // interpolierte Farbe vom Vertexshader
in vec2 UV0;

out vec4 outColor; // ausgegebene Farbe

uniform sampler2D Sampler0;

void main(void)
{
//  outColor = (texture( Sampler0, UV0 ) + Color) * 0.5;
  outColor = texture( Sampler0, UV0 );
}
