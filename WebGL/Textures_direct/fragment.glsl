#version 300 es

precision highp float;

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 outCol;

void main(void){
//  outCol = vec4(col, 1.0);
  outCol = texture(Sampler, UV0);
  outCol.a = 1.0;
}


