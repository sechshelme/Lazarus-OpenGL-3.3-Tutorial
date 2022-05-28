$vertex
#version 330

in vec3 inPos;
in vec2 vertexUV0;
in vec2 vertexUV1;

uniform mat4 Matrix;

out vec2 UV0;
out vec2 UV1;
out vec4 Position;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0 = vertexUV0;
  UV1 = vertexUV1;
}


$geometrie
#version 330


layout (triangles) in;
layout (triangle_strip) out;
layout (max_vertices = 60) out;

in vec2 UV0[];
in vec2 UV1[];

in vec4 Position[];

out vec2 vUV0;
out vec2 vUV1;

out vec3 Pos;
out vec3 Normal;



vec3 GetNormal(vec3 P[3])
{
   return normalize(cross(P[1] - P[0], P[2] - P[0]));
}


void main(void)
{
   vec3 p[3];


   for (int s = 0; s <= 20; s++)
   {
     vec3 move = vec3(sin(0.3 * s), cos(0.3 * s), 0.0) / 2;

     for(int i = 0; i < gl_in.length(); i++)
     {
        for (int i = 0; i <= 2; i++)
        {
           p[i] = gl_in[i].gl_Position.xyz;
        }
        Normal = GetNormal(p);
        Pos = Position[i].xyz  - move;

        gl_Position = vec4((gl_in[i].gl_Position.xyz / 5), gl_in[i].gl_Position.w) - vec4(move, 0.0);

        vUV0 = UV0[i];
        vUV1 = UV1[i];

        EmitVertex();
     }

     EndPrimitive();

   }
   EndPrimitive();
}


$fragment
#version 330

in vec3 Pos;
in vec3 Normal;


in vec2 vUV0;
in vec2 vUV1;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

out vec4 FragColor;

uniform vec3 LightPosition = vec3(-0.4, 0.0, 0.0);
float UmgebungsLicht = 0.1;


float diffuse()
{
  vec3 LP        = (LightPosition * 1.0) - Pos;
  float distance = length(LP);
  float dif      = max(dot(Normal, LP), UmgebungsLicht);
  return           dif * (1.0 / (1.0 + (0.25 * distance * distance)));
}

void main()
{
  FragColor = (texture( Sampler0, vUV0 ) + texture( Sampler1, vUV1 )) * 0.5 * diffuse();
}


