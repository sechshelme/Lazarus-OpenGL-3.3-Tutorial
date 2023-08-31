#version 330

uniform ivec2 ScreenSize; // Die Grösse des Viewports

out vec4 outColor;

void main(void) {
  outColor.ba = vec2(0.0, 1.0);
  outColor.rg = 1.0 / ScreenSize * gl_FragCoord.xy;
}
