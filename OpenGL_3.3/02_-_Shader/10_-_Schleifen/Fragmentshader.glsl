#version 330

uniform bool rot;   // Ist es "rot" ?
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  // Die if-Abfrage
  if (rot) {
    outColor = vec4(1.0, 0.0, 0.0, 1.0); // Rot
  } else {
    outColor = vec4(0.0, 0.0, 0.0, 1.0); // Schwarz
  }
}
