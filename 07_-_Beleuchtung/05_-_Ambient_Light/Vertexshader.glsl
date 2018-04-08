#version 330

// Eine leichte Ausleuchtung in Grau.
#define ambient vec3(0.2, 0.2, 0.2)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);

  Color = vec4(ambient, 1.0);
}
