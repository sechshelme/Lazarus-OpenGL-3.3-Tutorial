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


    vec4 p00 = gl_in[0].gl_Position;
    vec4 p01 = gl_in[1].gl_Position;
    vec4 p10 = gl_in[2].gl_Position;
    vec4 p11 = gl_in[3].gl_Position;

    vec4 normal = normalize(vec4(cross(p10.xyz - p00.xyz, p01.xyz - p00.xyz), 0));

    vec4 p0 = mix(p00, p01,  u);
    vec4 p1 = mix(p10, p11,  u);
    vec4 p = mix(p1,p0, v);

    Height = texture(heightMap, texCoord).y;

    p += normal * (Height * 64.0 - 16.0) / 400;

    gl_Position = Matrix * p;
}
