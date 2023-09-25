#version 430

uniform float MyColor[2][2][2];

out vec4 outColor;

void main(void)
{
  outColor = vec4(MyColor[1][1][1],1,1, 1.0);
}

