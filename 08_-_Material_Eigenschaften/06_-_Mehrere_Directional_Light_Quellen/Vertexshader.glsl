#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out Data {
  vec3 pos;
  vec3 Normal;
} DataOut;

// out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;


void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}

//void main(void)
//{
//  // Vektoren mit komplette vorberechneter Matrix multipizieren.
//  gl_Position = Matrix * vec4(inPos, 1.0);
//
//  // Normale nur mit lokaler Matrix Multipizieren.
//  vec3 Normal = mat3(ModelMatrix) * inNormal;
//
//  // Ambiente Lichtquelle
//  Color = vec4(ambient2, 1.0);
//
//  // Lichtquellen auf verlangen berechnen und addieren.
////  vec3 colRed = vec3(light(LightPos, Normal));
//  vec3 colRed = Light(Normal, gl_Position.xyz).rgb;
//  Color.rgb += colRed;
//}
