#version 300 es

precision highp float;

//    'uniform myUBO {'+
//    '  vec3 ucol;'+
//    '};'+

in vec3 col;

out vec4 outCol;
void main(void){
  outCol = vec4(col, 1.0);
}


