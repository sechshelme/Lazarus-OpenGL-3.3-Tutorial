#version 400

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTex;

out vec2 TextureCoord;

void main()
{
    gl_Position = vec4(aPos, 1.0);
    TextureCoord = aTex;
}
