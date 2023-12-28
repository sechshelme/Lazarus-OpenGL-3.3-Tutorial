$vertex
#version 330

layout (location = 0) in vec4 inPos;
layout (location = 1) in vec3 inNormal;
layout (location = 10) in vec2 vertexUV;

uniform mat4 WorldMatrix;

out Data {
  vec2 UV;
  vec3 normal;
  vec4 eye;
} DataOut;


void main(void)
{
  DataOut.UV = vertexUV;

  DataOut.normal = normalize(vec3(WorldMatrix * vec4(inNormal, 1.0)));
  DataOut.eye = -(WorldMatrix * inPos);

  gl_Position = WorldMatrix * inPos;
}

///////////////////////////////////////////////////

$fragment
#version 330

struct Lights {
  vec4 l_dir;    // Lichtposition
};

struct Materials {
  vec4 diffuse;    // Farbe
  vec4 ambient;    // Umgebungslicht
  vec4 specular;   // Spiegelnd
  float shininess; // Glanz
};

struct AllUniforms {
  Lights lights;
  Materials materials;
};

uniform AllUniforms allUniforms;

in Data {
  vec2 UV;
  vec3 normal;
  vec4 eye;
} DataIn;

uniform sampler2D Sampler[2];

out vec4 OutColor;

void main()
{

  vec4 spec = vec4(0.0);
  vec3 n = normalize(texture2D(Sampler[1], DataIn.UV.st).rgb * 2.0 - 1.0) + normalize(DataIn.normal);
  vec3 e = normalize(vec3(DataIn.eye));

  float intensity = max(dot(n, allUniforms.lights.l_dir.xyz), 0.0);

  if (intensity > 0.0) {

    vec3 h = normalize(allUniforms.lights.l_dir.xyz + e);
    float intSpec = max(dot(h,n), 0.0);
    spec = allUniforms.materials.specular * pow(intSpec, allUniforms.materials.shininess);
  }

  OutColor = texture( Sampler[0], DataIn.UV );
  OutColor = max(intensity * allUniforms.materials.diffuse * OutColor + spec, allUniforms.materials.ambient);
}



