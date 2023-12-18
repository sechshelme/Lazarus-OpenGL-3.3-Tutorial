#version 330

layout (location = 0) in vec2 inPos;
layout (location = 1) in vec3 inCol;

layout (std140) uniform UBO {
  mat4x4 proMat;
  mat2x2 modelMat;
};

uniform mat2x2 mm;

out vec3 vCol;

void main(void)
{
  vCol = inCol;
//  mat2x2 m = modelMat;
  mat2x2 m = mm;

//m = mat2x2(1,0,0,1);
//m[0][0]=1;
//m[0][1]=0;
//m[1][0]=0;
//m[1][1]=1;

  vec2 p = m * inPos;


 gl_Position = proMat * vec4(p, 0.0, 1.0);
}
