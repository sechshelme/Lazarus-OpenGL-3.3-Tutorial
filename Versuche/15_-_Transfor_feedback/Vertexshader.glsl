#version 420

layout (location =  0) in  float inValue;
layout (location = 10) out float outValue;

void main(void)
{
  outValue = sqrt(inValue);
}
