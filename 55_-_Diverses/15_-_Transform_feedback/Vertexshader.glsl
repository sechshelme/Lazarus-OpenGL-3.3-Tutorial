#version 330

layout (location =  0) in float inValue;

out float outSqrt;
out mat4x4 outMat;

void main(void)
{
  outSqrt = sqrt(inValue);
  for (int x = 0; x < 4; x++)
  {
    for (int y = 0; y < 4; y++)
    {
      outMat[y][x] = (x + y * 4) * inValue;
    }
  }
}
