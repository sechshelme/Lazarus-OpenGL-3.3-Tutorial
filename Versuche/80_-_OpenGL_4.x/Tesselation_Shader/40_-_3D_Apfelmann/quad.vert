#version 330

layout (location = 0) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 Matrix;

out vec2 pos;                           // Koordinaten für den Fragment-Shader

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);
//  pos = gl_Position.xy;                 // XY an Fragment-Shader
  pos = inPos.xy;                 // XY an Fragment-Shader
}
