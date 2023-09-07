#version 330

// Licht
//#define Lposition  vec4(35.0, 17.5, 35.0)
//#define Lambient   vec4(1.8, 1.8, 1.8)
//#define Ldiffuse   vec4(1.5, 1.5, 1.5)
//#define Lspecular  vec4(1.5, 1.5, 1.5)

//#define Lposition  vec4(200.0, 300.0, 100.0, 0.0)
#define Lposition  vec4(35.0, 17.5, 35.0, 0.0)
#define Lambient   vec4(0.8, 0.8, 0.8, 0.0)
#define Ldiffuse   vec4(2.0, 2.0, 2.0, 1.0)
#define Lspecular  vec4(1.0, 1.0, 1.0, 1.0)

// Material ( Rubin )
#define Mambient   vec4(0.17, 0.01, 0.01, 0.55)
#define Mdiffuse   vec4(0.61, 0.04, 0.04, 0.55)
#define Mspecular  vec4(0.72, 0.63, 0.63, 0.55)
#define Mshininess 76.8


in Data {
  vec3 color;
  float radius;
  vec3 center;
} DataIn;

out vec4 outColor; // ausgegebene Farbe

uniform vec4 viewport;

//vec3 Light_alt(in vec3 p, in vec3 n) {
//  vec3 nn = normalize(n);
//  vec3 np = normalize(p);
//  vec3 diffuse;   // Licht
//  vec3 specular;  // Reflektion
//  float angele = max(dot(nn, np), 0.0);
//  if (angele > 0.0) {
//    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));
//    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
//    diffuse  = angele * Mdiffuse * Ldiffuse;
//  } else {
//    specular = vec3(0.0);
//    diffuse  = vec3(0.0);
//  }
//  return (Mambient * Lambient) + diffuse + specular;
//}

vec4 Light(in vec3 Normal, in vec3 Position) {
  vec3 N       = normalize(Normal);
  vec4 ambient = Mambient * Lambient;

  vec3 L       = normalize(vec3(Lposition) - Position);
  vec4 Pos_eye = vec4(0.0, 0.0, 1.0, 0.0);
  vec3 A       = Pos_eye.xyz;
  vec3 H       = normalize(L + A);

  vec4 diffuse       = vec4(0.0, 0.0, 0.0, 1.0);
  vec4 specular      = vec4(0.0, 0.0, 0.0, 1.0);
  float diffuseLight = max(dot(N, L), 0.0);
  if (diffuseLight > 0.0) {
    diffuse         = diffuseLight * Mdiffuse * Ldiffuse;
    float specLight = pow(max(dot(H, N), 0.0), Mshininess);
    specular        = specLight * Mspecular * Lspecular;
  }
  return ambient + diffuse + specular;
}




void main(void) {
    vec2 ndc_current_pixel = ((2.0 * gl_FragCoord.xy) - (2.0 * viewport.xy)) / (viewport.zw) - 1;

    vec2 diff = ndc_current_pixel - DataIn.center.xy;
    float d2 = dot(diff, diff);
    float r2 = pow(DataIn.radius, 2);

    if (d2 > r2) {
        discard;
    } else {
        float dr =  sqrt(r2 - d2);
        vec3 n = vec3(ndc_current_pixel- DataIn.center.xy, dr);

//        outColor = vec4(Light(Lposition -  DataIn.center, n), 1.0);
        outColor = Light(DataIn.center, n);

        gl_FragDepth = gl_FragCoord.z + dr * gl_DepthRange.diff / 2.0;
    }
}

