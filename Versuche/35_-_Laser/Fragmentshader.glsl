#version 330
#define depth 1000.0

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

uniform float col; // Start-Wert, für Farben-Spielerei

out vec4 outColor;

float LichtOeffnung = 16;
uniform float[5] LichtRichtung;
uniform float MandelRot;

vec2 LichtPosition = vec2(-0.4, -0.2);


vec2 rot(vec2 p, float Winkel) {
float  x0, y0, c, s;
  c = cos(Winkel);
  s = sin(Winkel);
  x0 = p.x;
  y0 = p.y;
  return vec2(x0 * c - y0 * s, x0 * s + y0 * c);
}


bool isCone(vec2 p, float LichtRichtung) {
  vec2 lr;
  lr.x = sin(LichtRichtung);
  lr.y = cos(LichtRichtung);

  float winkel;
  lr = normalize(lr);
  vec2 lp = vec2(p - LichtPosition);
  lp = normalize(lp);
  winkel = dot(lr, lp);

  return (winkel > cos(3.14 / LichtOeffnung));
}


void main(void) {
   vec2 p = pos;
   p = rot(p, MandelRot);

   float creal = p.x * 1.5 - 0.3;
   float cimag = p.y * 1.5;

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
   outColor.rgb /= 40;

   for (int i = 0; i <= 5; i++) {
     if (isCone(pos, LichtRichtung[i])) {
       outColor *= 5;
     }
   }


   //if ((isCone(pos, LichtRichtung[0])) || (isCone(pos, LichtRichtung[1])) || (isCone(pos, LichtRichtung[2])) || (isCone(pos, LichtRichtung[3]))) {
   //   outColor = vec4(Color / 3, Color / 10 , Color / 100, 1.0);
   //} else {
   //  outColor = vec4(0.0);
   //}
}
