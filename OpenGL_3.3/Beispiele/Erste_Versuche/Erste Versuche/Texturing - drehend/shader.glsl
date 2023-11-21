$vertex
#version 330

layout (location = 0) in vec3 inPos;
layout (location = 10) in vec2 vertexUV0;

//uniform mat4 Matrix = mat4(1.0);
uniform mat4 Matrix;
uniform mat3 TexMatrix0, TexMatrix1;

out vec2 UV0, UV1;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0 = vec2(TexMatrix0 * vec3(vertexUV0, 1.0));
  UV1 = vec2(TexMatrix1 * vec3(vertexUV0, 1.0));
}

// -------------------------------------------------------

$fragment
#version 330

in vec2 UV0, UV1;

uniform sampler2D Sampler0[2];

out vec4 FragColor;

void main()
{
  FragColor = (texture( Sampler0[0], UV0 ) + texture( Sampler0[1], UV1)) / 2.0;
}
