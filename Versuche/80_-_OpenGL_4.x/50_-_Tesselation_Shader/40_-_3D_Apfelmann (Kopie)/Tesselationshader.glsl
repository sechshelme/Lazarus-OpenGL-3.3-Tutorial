#version 400

layout (quads, fractional_odd_spacing, ccw) in;

uniform sampler2D heightMap;

uniform mat4 Matrix;

in vec2 TextureCoord[];

//out float Height;
float Height;
out vec3 col;

float log10(float x){
    //log10(x) = log(x) / log(10) = (1 / log(10)) * log(x)
    const float d = 1. / log(10);
    return d * log(x);
}

void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec2 t0 = mix(TextureCoord[1], TextureCoord[0], u);
    vec2 t1 = mix(TextureCoord[3], TextureCoord[2], u);
    vec2 texCoord = mix(t1, t0, v);

    vec3 p00 = gl_in[0].gl_Position.xyz;
    vec3 p01 = gl_in[1].gl_Position.xyz;
    vec3 p10 = gl_in[2].gl_Position.xyz;
    vec3 p11 = gl_in[3].gl_Position.xyz;

    vec3 normal = normalize(cross(p10 - p00, p01 - p00));

    vec3 p0 = mix(p00, p01,  u);
    vec3 p1 = mix(p10, p11,  u);
    vec3 p = mix(p1,p0, v);

    if ((u <= 0.0) || (v <= 0.0) || (u >= 1.0) || (v >= 1.0)) {
      Height = 0.5;
    } else {
      Height = texture(heightMap, texCoord).z;
    }

    col = texture(heightMap, texCoord).rgb;

    Height *= 2.0;
//    Height = log(Height)/log(100);
//    Height = log(Height) / 3;
    Height = log10(Height);


//    p +=  normal * ( -Height + 0.5)  / 10;
    p.z +=  (normal * ( -Height + 0.5)  / 10).z;

   gl_Position = Matrix * vec4(p, 1.0);
}
