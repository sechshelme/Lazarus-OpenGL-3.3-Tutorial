#version 330

layout (location =  0) in  float inValue;

out float outSqrt;
out float outPow;

void main(void)
{
  outSqrt = sqrt(inValue);
  outPow  = pow(inValue, 2);
}
