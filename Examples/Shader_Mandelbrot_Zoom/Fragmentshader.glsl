#version 330
#define depth 10000.0

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

layout (std140) uniform ubo {
  mat4x4 matrix;
  float left;
  float right;
  float top;
  float bottom;
  float col; // Start-Wert, für Farben-Spielerei
};

out vec4 outColor;

void main(void) {

  float creal = pos.x * (left - right) - (left + right) / 2;
  float cimag = pos.y * (bottom - top) - (top + bottom) / 2;

  float Color = 0.0;
  float XPos  = 0.0;
  float YPos  = 0.0;

  float SqrX, SqrY;

  do {
    SqrX   = XPos * XPos;
    SqrY   = YPos * YPos;
    YPos   = XPos * YPos * 2 + cimag;
    XPos   = SqrX - SqrY + creal;
    Color += 1;
  } while (!((SqrX + SqrY > 8) || (Color > depth)));

  Color += col;

  if (Color > depth) {
    Color -= depth;
  }

  outColor = vec4(Color / 3, Color / 10 , Color / 100, 1.0);
}
