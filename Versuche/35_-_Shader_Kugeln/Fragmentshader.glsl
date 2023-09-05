#version 330

uniform vec3 Color  ;  // Farbe von Uniform

in vec3 outCol;
in float radius;
in vec2 center;


out vec4 outColor; // ausgegebene Farbe

uniform vec4 viewport;


vec3 camera = vec3(.6,0,1);
vec4 light0_position = vec4(1,1,1,0);


void main(void) {
    vec2 ndc_current_pixel = ((2.0 * gl_FragCoord.xy) - (2.0 * viewport.xy)) / (viewport.zw) - 1;

    vec2 diff = ndc_current_pixel - center;
    float d2 = dot(diff, diff);
    float r2 = radius * radius;

    if (d2 > r2) {
        discard;
    } else {
        vec3 l = normalize(light0_position.xyz);
        float dr =  sqrt(r2-d2);
        vec3 n = vec3(ndc_current_pixel-center, dr);
        float intensity = .2 + max(dot(l,normalize(n)), 0.0);

        outColor = vec4(outCol * intensity, 1.0);
//        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0 * gl_ProjectionMatrix[2].z;
        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0;
    }
}
//
//
//
//void main(void)
//{
//if (length(gl_PointCoord - 0.5) > 0.5) {
//              discard;
//            } else {
//              outColor = vec4(outCol, 1.0);
//
//              outColor.rg = gl_PointCoord;
//              outColor.b = 0.0;
//            }
//}
