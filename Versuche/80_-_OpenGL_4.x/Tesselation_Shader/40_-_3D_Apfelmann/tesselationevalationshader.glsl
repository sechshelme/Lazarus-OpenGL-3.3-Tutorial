#version 400

layout (quads, fractional_odd_spacing, ccw) in;

uniform sampler2D heightMap;

uniform mat4 Matrix;

in vec2 TextureCoord[];

out float Height;

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

    Height *= 2;
    p += normal * ( -Height + 0.5)  / 10;

    gl_Position = Matrix * vec4(p, 1.0);
}
