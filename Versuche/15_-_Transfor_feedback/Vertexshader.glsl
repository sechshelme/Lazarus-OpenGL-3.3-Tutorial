#version 420

layout (location =  0) in  float inValue;
layout (location = 10) out float outValue0;
layout (location = 11) out float outValue1;
layout (location = 12) out float multi;
layout (location = 13) out float divi;

void main(void)
{
  outValue0 = sqrt(inValue);
  outValue1 = pow(inValue, 2);
  multi = inValue * 2;
  divi = inValue / 2;
}
