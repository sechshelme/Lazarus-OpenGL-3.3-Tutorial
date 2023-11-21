#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Geometrie-shader
out VS_OUT {
    vec3 Normal;
} vs_out;

void main(void) {
  gl_Position    = vec4(inPos, 1.0);

  vs_out.Normal = inNormal;
}
