#version 420

layout (location =  0) in  float inValue;
layout (location = 0) out float outValue0;
layout (location = 1) out float outValue1;

void main(void)
{
  outValue0 = sqrt(inValue);
  outValue1 = pow(inValue, 2);
}
