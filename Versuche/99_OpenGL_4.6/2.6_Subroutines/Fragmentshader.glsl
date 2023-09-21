#version 450 core

out vec4 color;

subroutine vec4 ColorFunc();

subroutine (ColorFunc) vec4 colorRed() {
  return vec4(1, 0, 0, 1);
}

subroutine (ColorFunc) vec4 colorGreen() {
  return vec4(0, 1, 0, 1);
}

subroutine (ColorFunc) vec4 colorBlue() {
  return vec4(0, 0, 1, 1);
}


subroutine uniform ColorFunc ColorSelector;

void main()
{
//  fColor = vec4(0.5, 0.4, 0.8, 1.0);
  color = ColorSelector();
}
