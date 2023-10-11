#version 330

#define ArraySize 6

layout (location =  0) in  float inValue;

out float outSqrt;
out float outPow;
out ivec3 outTest;
out int[ArraySize] outInt;

void main(void)
{
  outSqrt = sqrt(inValue);
  outPow  = pow(inValue, 2);
  outTest = ivec3(111, 222,333);
  for (int i = 0; i < ArraySize; i++) {
     outInt[i] = i;
  }
}
