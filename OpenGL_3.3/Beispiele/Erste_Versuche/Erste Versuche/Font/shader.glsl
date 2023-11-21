$vertex
#version 330

in vec3 inPos;
in vec2 vertexUV0;

uniform mat4 Matrix;
uniform float offset;

out vec2 UV;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV = vertexUV0;
  UV.x = UV.x + offset;
}


$fragment
#version 330

in vec2 UV;

uniform sampler2D Sampler0[1];

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler0[0], UV );
}
