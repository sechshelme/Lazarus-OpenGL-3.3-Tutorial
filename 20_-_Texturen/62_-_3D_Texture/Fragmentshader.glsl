#version 330

in vec2 UV;

uniform sampler3D Sampler;

layout (std140) uniform UBO {
  mat4x4 mat;
  float W;  //
};

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV, W));
}
