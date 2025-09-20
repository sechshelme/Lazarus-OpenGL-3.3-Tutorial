#version 330

//layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
//layout (location = 11) in vec3 inCol; // Farbe
//layout (location = 10) in vec3[2] inTest; // Farbe
layout (location = 10) in float[6] inTest; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
 // gl_Position = vec4(inPos, 1.0);
//  Color = vec4(inCol, 1.0);
//  gl_Position = vec4(inTest[0], 1.0);
//  Color = vec4(inTest[1], 1.0);
  gl_Position = vec4(inTest[0],inTest[1],inTest[2], 1.0);
  Color = vec4(inTest[3],inTest[4],inTest[5], 1.0);
}
