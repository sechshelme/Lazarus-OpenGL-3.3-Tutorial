#version 330

layout (location = 10) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 mat;

out vec2 pos;                           // Koordinaten für den Fragment-Shader

void main(void) {
  gl_Position = mat * vec4(inPos, 1.0);
  pos = gl_Position.xy;                 // XY an Fragment-Shader
//  pos = inPos.xy;                 // XY an Fragment-Shader
}
