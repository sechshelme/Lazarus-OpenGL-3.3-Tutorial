#version 330

in Data {
  vec3 color;
  float radius;
  vec2 center;
} DataIn;


out vec4 outColor; // ausgegebene Farbe

uniform vec4 viewport;


vec3 camera = vec3(.6,0,1);
vec4 light0_position = vec4(1,1,1,0);


void main(void) {
    vec2 ndc_current_pixel = ((2.0 * gl_FragCoord.xy) - (2.0 * viewport.xy)) / (viewport.zw) - 1;

    vec2 diff = ndc_current_pixel - DataIn.center;
    float d2 = dot(diff, diff);
    float r2 = DataIn.radius * DataIn.radius;

    if (d2 > r2) {
        discard;
    } else {
        vec3 l = normalize(light0_position.xyz);
        float dr =  sqrt(r2-d2);
        vec3 n = vec3(ndc_current_pixel- DataIn.center, dr);
        float intensity = .2 + max(dot(l,normalize(n)), 0.0);

        outColor = vec4(DataIn.color * intensity, 1.0);
//        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0 * gl_ProjectionMatrix[2].z;
        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0;
    }
}

