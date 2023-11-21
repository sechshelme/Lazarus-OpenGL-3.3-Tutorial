#version 330

layout (location = 10) in vec2 inPos;

out vec3 col;
 
void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);
  switch (gl_VertexID) // Den aktuellen Vertex abfragen.
  {
    case 0:  col = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  col = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  col = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  col = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  col = vec3(0.0, 1.0, 1.0);
             break;
    default: col = vec3(1.0, 0.0, 1.0);
  }
}
