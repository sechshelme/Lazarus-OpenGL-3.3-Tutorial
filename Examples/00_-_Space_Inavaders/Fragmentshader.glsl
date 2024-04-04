#version 330

in Data {
  vec2 UV0;
} DataIn;

uniform sampler2D Texture;

layout (std140) uniform UBO {
  mat4 ModelMatrix;
  mat4 Matrix;
  int CubeEnabled;
};

out vec4 outColor;

void main(void) {
  vec4 c = texture(Texture, DataIn.UV0);
  if (c.r < 0.1) {
    discard;
  } else {
    if (CubeEnabled != 0) {
//      c.rgb += vec3(0.7, 0.7, 0.7);
    }
  }

  outColor =  c;
}

