#version 330

// Licht
//#define Lposition  vec3(35.0, 17.5, 35.0)
#define Lposition  vec3(0.1, 0.1, 0.1)
#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

//// Material ( Poliertes Kupfer  )
//#define Mambient   vec3(0.23, 0.09, 0.03)
//#define Mdiffuse   vec3(0.55, 0.21, 0.07)
//#define Mspecular  vec3(0.58, 0.22, 0.07)
//#define Mshininess 51.2

// Material ( Rubin )
//#define Mambient   vec3(0.17, 0.01, 0.01)
//#define Mdiffuse   vec3(0.61, 0.04, 0.04)
//#define Mspecular  vec3(0.72, 0.63, 0.63)
//#define Mshininess 76.8


in Data {
  vec3 color;
  float radius;
  vec3 pos;

  vec3 Mambient;
  vec3 Mdiffuse;
  vec3 Mspecular;
  float Mshininess;
} DataIn;

out vec4 outColor; // ausgegebene Farbe

uniform vec4 viewport;
uniform mat4 ProjectionMatrix;


vec3 Light(in vec3 p, in vec3 n) {
  vec3 nn = normalize(n);
  vec3 np = normalize(p);
  vec3 diffuse;   // Licht
  vec3 specular;  // Reflektion
  float angele = max(dot(nn, np), 0.0);
  if (angele > 0.0) {
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));
    specular = pow(max(dot(eye, nn), 0.0), DataIn.Mshininess) * DataIn.Mspecular;
    diffuse  = angele * DataIn.Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);
    diffuse  = vec3(0.0);
  }
  return (DataIn.Mambient * Lambient) + diffuse + specular;
}


void main(void) {
    vec2 ndc_current_pixel = ((2.0 * gl_FragCoord.xy) - (2.0 * viewport.xy)) / (viewport.zw) - 1;

    vec2 diff = ndc_current_pixel - DataIn.pos.xy;
    float d2 = dot(diff, diff);
    float r2 = pow(DataIn.radius, 2);

    if (d2 > r2) {
        discard;
    } else {
        float dr =  sqrt(r2 - d2);
        vec3 n = vec3(ndc_current_pixel- DataIn.pos.xy, dr);

        outColor = vec4(Light(Lposition -  DataIn.pos, n), 1.0);

        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0 * ProjectionMatrix[2].z;
    }
}

