#version 420

#extension GL_ARB_explicit_uniform_location : enable

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten

// --- subroutine Color
subroutine vec2 MoveFunc();

layout(index = 30) subroutine (MoveFunc) vec2 MoveLeft() {
  return vec2(0.3, 0);
}

layout(index = 31) subroutine (MoveFunc) vec2 MoveRight() {
  return vec2(-0.3, 0);
}

layout (location = 0) subroutine uniform MoveFunc MoveSelector;


void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  gl_Position.xy += MoveSelector();
}
