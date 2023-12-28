#version 330

#define size 4

in vec2 UV0;

uniform sampler2D Sampler0;

out vec4 FragColor;

const float blurSizeH = 1.0 / 300.0;
const float blurSizeV = 1.0 / 200.0;



void main()
{
    vec4 sum = vec4(0.0);
    for (int x = -size; x <= size; x++)
        for (int y = -size; y <= size; y++)
            sum += texture(
                Sampler0,
                vec2(UV0.x + x * blurSizeH, UV0.y + y * blurSizeV)
            ) / 81.0;
    FragColor = sum;
}

