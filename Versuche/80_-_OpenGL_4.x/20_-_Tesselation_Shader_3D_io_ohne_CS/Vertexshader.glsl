// vertex shader
#version 410 core

// vertex position
layout (location = 0) in vec3 aPos;
// texture coordinate
layout (location = 1) in vec2 aTex;

//out vec2 TexCoord;
out vec2 TextureCoord;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung

void main()
{
    // convert XYZ vertex to XYZW homogeneous coordinate
    gl_Position = vec4(aPos, 1.0);
//  gl_Position = Matrix * vec4(aPos, 1.0);

    // pass texture coordinate though
//    TexCoord = aTex;
    TextureCoord = aTex;
}
