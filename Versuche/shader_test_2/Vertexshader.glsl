#version 330

layout (location = 0) in vec3  inPos;
layout (location = 1) in float R;
layout (location = 2) in vec3  inColor;

uniform vec4 viewport;
uniform mat4 glModelViewProjectionMatrix;
uniform mat4 glModelViewMatrix;
uniform mat4 glModelViewProjectionMatrixInverse;
uniform mat4 glProjectionMatrixInverse;

//attribute float R;

out mat4 VPMTInverse;
out mat4 VPInverse;
out vec3 centernormclip;

out vec3 outPos;
out vec3 outColor;

void main() {

    gl_Position   = glModelViewProjectionMatrix * vec4(inPos, 1.0);
    outColor = inColor;

    mat4 T = mat4(
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            inPos.x/R, inPos.y/R, inPos.z/R, 1.0/R);

    mat4 PMTt = transpose(glModelViewProjectionMatrix * T);

    vec4 r1 = PMTt[0];
    vec4 r2 = PMTt[1];
    vec4 r4 = PMTt[3];
    float r1Dr4T = dot(r1.xyz,r4.xyz)-r1.w*r4.w;
    float r1Dr1T = dot(r1.xyz,r1.xyz)-r1.w*r1.w;
    float r4Dr4T = dot(r4.xyz,r4.xyz)-r4.w*r4.w;
    float r2Dr2T = dot(r2.xyz,r2.xyz)-r2.w*r2.w;
    float r2Dr4T = dot(r2.xyz,r4.xyz)-r2.w*r4.w;

    gl_Position = vec4(-r1Dr4T, -r2Dr4T, gl_Position.z/gl_Position.w*(-r4Dr4T), -r4Dr4T);


    float discriminant_x = r1Dr4T*r1Dr4T-r4Dr4T*r1Dr1T;
    float discriminant_y = r2Dr4T*r2Dr4T-r4Dr4T*r2Dr2T;
    float screen = max(float(viewport.z), float(viewport.w));

    gl_PointSize = sqrt(max(discriminant_x, discriminant_y))*screen/(-r4Dr4T);


    // prepare varyings

    mat4 TInverse = mat4(
            1.0,          0.0,          0.0,         0.0,
            0.0,          1.0,          0.0,         0.0,
            0.0,          0.0,          1.0,         0.0,
            -inPos.x, -inPos.y, -inPos.z, R);
    mat4 VInverse = mat4( // TODO: move this one to CPU
            2.0/float(viewport.z), 0.0, 0.0, 0.0,
            0.0, 2.0/float(viewport.w), 0.0, 0.0,
            0.0, 0.0,                   2.0/gl_DepthRange.diff, 0.0,
            -float(viewport.z+2.0*viewport.x)/float(viewport.z), -float(viewport.w+2.0*viewport.y)/float(viewport.w), -(gl_DepthRange.near+gl_DepthRange.far)/gl_DepthRange.diff, 1.0);
    VPMTInverse = TInverse*glModelViewProjectionMatrixInverse*VInverse;
    VPInverse = glProjectionMatrixInverse*VInverse; // TODO: move to CPU
    vec4 centerclip = glModelViewMatrix*vec4(inPos, 1.0);
    centernormclip = vec3(centerclip)/centerclip.w;
}

