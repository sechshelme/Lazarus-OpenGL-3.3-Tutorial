#version 300 es

precision highp float;

layout(location = 0) in vec3 inPos;
layout(location = 1) in vec3 inCol;

uniform mat4 viewTransform;

out vec3 col;

//    'uniform myUBO {'+
//    '  vec3 ucol;'+
//    '};'+

void main() {
  gl_Position = viewTransform * vec4(inPos, 1.0);
  col = inCol;
}
//    '  col = ucol;}';


