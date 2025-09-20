#version 330

in vec2 UV0;

uniform sampler1D myPalette;
uniform sampler2D myTexture;

layout (std140) uniform UBO {
  mat4x4 mat;
};

out vec4 FragColor;

void main()
{
  vec4 index = texture(myTexture, UV0);

  FragColor = texture(myPalette, index.r);
}
