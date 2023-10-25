#version 330 core

in vec4 vColor;
in vec2 vTexcoord;

out vec4 outColor;

uniform sampler2D Sampler;

void main()
{
  outColor = vColor * texture(Sampler, vTexcoord);
};

