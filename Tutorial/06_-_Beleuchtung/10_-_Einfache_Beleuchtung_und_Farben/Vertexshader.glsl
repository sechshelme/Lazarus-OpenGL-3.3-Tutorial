#version 330

#define PI 3.1415926535897932384626433832795

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inColor;  // Farben
layout (location = 2) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

vec3 LightPos = vec3(1.0, 0.0, 0.0);

float winkel(vec3 p, vec3 q){
  vec3 r1 = normalize(p);
  vec3 r2 = normalize(q);
  return acos(dot(r1, r2));
}

void main(void)
{
  vec3 Normal = mat3(Matrix) * inNormal;

  float w = winkel(LightPos, Normal);
  float col = (w / PI);

  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = (-1.0 + (vec4(col, col, col, 1.0))) + vec4(inColor, 0.0);
}
