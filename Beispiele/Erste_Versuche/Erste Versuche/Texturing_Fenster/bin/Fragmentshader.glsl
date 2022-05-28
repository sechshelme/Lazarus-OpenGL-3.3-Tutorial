#version 330

in vec2 UV0;
in vec2 UV1;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

out vec4 FragColor;

void main()
{
  FragColor = (texture( Sampler0, UV0 ) + texture( Sampler1, UV1 )) * 0.5;



  if (texture( Sampler1, UV1 ).a == 0.0){
    FragColor=vec4(0.0, 0.0, 0.0, 1.0);
  }
}
