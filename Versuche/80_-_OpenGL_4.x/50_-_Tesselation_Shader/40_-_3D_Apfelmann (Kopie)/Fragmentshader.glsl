#version 400

//in float Height;
in vec3 col;

out vec4 FragColor;

void main()
{
//  float h = Height;
//  FragColor = vec4(h, h, h, 1.0);
  FragColor = vec4(col, 1.0);
}
