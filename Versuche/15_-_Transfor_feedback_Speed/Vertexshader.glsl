#version 420

layout (location =  0) in  float inValue;
layout (location = 10) out float outValue;

void main(void)
{
  outValue = inValue;
  for (int j=0; j < 1000000; j++) {
     outValue = sqrt(inValue) + outValue;
  }
}
