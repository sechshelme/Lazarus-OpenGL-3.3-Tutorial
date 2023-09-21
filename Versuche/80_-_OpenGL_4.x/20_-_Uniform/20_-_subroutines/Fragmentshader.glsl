#version 460

out vec4 color;

// --- subroutine Color
subroutine vec3 ColorFunc();

layout(index = 10) subroutine (ColorFunc) vec3 colorRed() {
  return vec3(1, 0, 0);
}

layout(index = 11) subroutine (ColorFunc) vec3 colorGreen() {
  return vec3(0, 1, 0);
}

layout(index = 12) subroutine (ColorFunc) vec3 colorBlue() {
  return vec3(0, 0, 1);
}

subroutine uniform ColorFunc ColorSelector;

// --- subroutine Alpha-Kanal;
subroutine float AlphaFunc();

layout(index = 20) subroutine (AlphaFunc) float AlphaTrue() {
  return 0.2;
}

layout(index = 21) subroutine (AlphaFunc) float AlphaFalse() {
  return 1.0;
}

subroutine uniform AlphaFunc AlphaSelector;

// --- Main
void main()
{
  color = vec4(ColorSelector(), AlphaSelector());
}
