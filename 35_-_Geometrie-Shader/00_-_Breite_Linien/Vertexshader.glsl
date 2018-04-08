#version 330

layout (location = 0) in vec2 inPos;
layout (location = 1) in vec2 inPrev;
layout (location = 2) in vec2 inNext;

uniform mat4 mat;

out vec2 Prev;
out vec2 Next;

void main(void)
{
//  Prev = inPrev;
///  Next = inNext;

  Prev = (mat * vec4(inPrev, 0.0, 1.0)).xy;
  Next = (mat * vec4(inNext, 0.0, 1.0)).xy;

  gl_Position = mat * vec4(inPos, 0.0, 1.0);
}
