#version 330
#define depth 1000.0

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

uniform float col; // Start-Wert, für Farben-Spielerei

out vec4 outColor;

void main(void) {
   float creal = pos.x * 1.5 - 0.3;
   float cimag = pos.y * 1.5;

   float Color = 0.0;
   float XPos  = 0.0;
   float YPos  = 0.0;

   float SqrX, SqrY;

   do {
      SqrX = XPos * XPos;
      SqrY = YPos * YPos;
      YPos = 2 * XPos * YPos + cimag;
      XPos = SqrX - SqrY + creal;
      Color += 1;
   } while (!((SqrX + SqrY > 8) || (Color > depth)));

   Color += col;

   if (Color > depth) {
      Color -= depth;
   }

   outColor = vec4(Color / 3, Color / 10 , Color / 100, 1.0);
}
