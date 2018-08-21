#version 330

#define size 4

in vec2 UV0;

uniform sampler2D Sampler0;

out vec4 FragColor;

void main() {
  vec4 top         = texture(Sampler0, vec2(UV0.x, UV0.y + 1.0 / 200.0));
  vec4 bottom      = texture(Sampler0, vec2(UV0.x, UV0.y - 1.0 / 200.0));
  vec4 left        = texture(Sampler0, vec2(UV0.x - 1.0 / 300.0, UV0.y));
  vec4 right       = texture(Sampler0, vec2(UV0.x + 1.0 / 300.0, UV0.y));
  vec4 topLeft     = texture(Sampler0, vec2(UV0.x - 1.0 / 300.0, UV0.y + 1.0 / 200.0));
  vec4 topRight    = texture(Sampler0, vec2(UV0.x + 1.0 / 300.0, UV0.y + 1.0 / 200.0));
  vec4 bottomLeft  = texture(Sampler0, vec2(UV0.x - 1.0 / 300.0, UV0.y - 1.0 / 200.0));
  vec4 bottomRight = texture(Sampler0, vec2(UV0.x + 1.0 / 300.0, UV0.y - 1.0 / 200.0));
  vec4 sx = -topLeft - 2 * left - bottomLeft + topRight   + 2 * right  + bottomRight;
  vec4 sy = -topLeft - 2 * top  - topRight   + bottomLeft + 2 * bottom + bottomRight;
  vec4 sobel = sqrt(sx * sx + sy * sy);
  FragColor = sobel;
}

