#version 460

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

layout (binding = 1, offset = 0) uniform atomic_uint atPixel;

layout (binding = 1, offset = 4) uniform atomic_uint atRed;
layout (binding = 1, offset = 8) uniform atomic_uint atGreen;
layout (binding = 1, offset = 12) uniform atomic_uint atBlue;

void main(void)
{
  if (Color.r > 0.5) {
    atomicCounterIncrement(atRed);
  }
  if (Color.g > 0.5) {
    atomicCounterIncrement(atGreen);
  }
  if (Color.b > 0.5) {
    atomicCounterIncrement(atBlue);
  }
  uint ct = atomicCounterIncrement(atPixel);

  float r = (ct / 255) / 255.0;
 outColor = vec4(r,0,0,1);

//  outColor = Color; // Die Ausgabe der Farbe
}

