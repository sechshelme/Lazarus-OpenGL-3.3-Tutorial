#version 330 core

in vec3 vColor;
in vec2 vTexcoord;

out vec4 outColor;

uniform sampler2D Sampler;

void main()
{
    outColor = vec4(vColor, 1.0) * texture(Sampler, vTexcoord);
};

