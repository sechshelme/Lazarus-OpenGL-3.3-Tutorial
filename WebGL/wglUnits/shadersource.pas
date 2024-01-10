unit ShaderSource;

interface

const
  texturVertex=
'           attribute vec3 inPos;'+#10+
'           attribute vec3 inNormal;'+#10+
'           attribute vec2 inUV;'+#10+
''+#10+
'           uniform mat4 ObjectMatrix;'+#10+
'           uniform mat4 WorldMatrix;'+#10+
''+#10+
'           varying vec3 Pos;'+#10+
'           varying vec3 Normal;'+#10+
'           varying vec2 UV;'+#10+
''+#10+
'           void main()'+#10+
'           {'+#10+
'           UV = inUV;'+#10+
'           Pos = (ObjectMatrix * vec4(inPos, 1.0)).xyz;'+#10+
'           Normal = normalize(mat3(ObjectMatrix) * inNormal);'+#10+
'           gl_Position = ObjectMatrix * vec4(inPos, 1.0);'+#10+
'           }';

texturFragment=
'           precision mediump float;'+#10+
''+#10+
'           varying vec3 Pos;'+#10+
'           varying vec3 Normal;'+#10+
'           varying vec2 UV;'+#10+
''+#10+
'           uniform sampler2D Sampler0;'+#10+
''+#10+
'           vec3 LightPosition = vec3(1.0, 1.0, 1.4);'+#10+
''+#10+
'           float UmgebungsLicht = 0.3;'+#10+
''+#10+
'           float diffuse()'+#10+
'           {'+#10+
'           vec3 LP        = (LightPosition * 1.0) - Pos;'+#10+
'           float distance = length(LP);'+#10+
'           float dif      = max(dot(Normal, LP), UmgebungsLicht);'+#10+
'           return           dif * (1.0 / (1.0 + (0.25 * distance * distance)));'+#10+
'           }'+#10+
''+#10+
'           float specular()'+#10+
'           {'+#10+
'           vec3 Eye          = normalize(LightPosition);'+#10+
'           vec3 Reflected    = normalize( reflect( -Pos, Normal ));'+#10+
'           return              0.15 * pow(max(dot(Reflected, Eye), 0.0), 1.0);'+#10+
'           }'+#10+
''+#10+
''+#10+
'           void main()'+#10+
'           {'+#10+
'               vec4 Color = texture2D(Sampler0, UV);'+#10+
'//                Color.a=1.0;  // ?????'+#10+
'               float cola = Color.a;'+#10+
'               gl_FragColor = (Color * diffuse() + specular());'+#10+
'               gl_FragColor.a = cola;'+#10+
'           }';


texturBumpMapingVertex =

'    attribute vec3 inPos;'+#10+
'    attribute vec3 inNormal;'+#10+
'    attribute vec2 inUV;'+#10+
''+#10+
'    uniform mat4 ObjectMatrix;'+#10+
'    uniform mat4 WorldMatrix;'+#10+
''+#10+
'    varying vec3 Pos;'+#10+
'    varying vec3 Normal;'+#10+
'    varying vec2 UV;'+#10+
''+#10+
'    void main()'+#10+
'    {'+#10+
'    UV = inUV;'+#10+
'    Pos = (ObjectMatrix * vec4(inPos, 1.0)).xyz;'+#10+
'    Normal = normalize(mat3(ObjectMatrix) * inNormal);'+#10+
'    gl_Position = ObjectMatrix * vec4(inPos, 1.0);'+#10+
'    }';

texturBumpMapingFragment=
'    precision mediump float;'+#10+
''+#10+
'    varying vec3 Pos;'+#10+
'    varying vec3 Normal;'+#10+
'    varying vec2 UV;'+#10+
''+#10+
'    uniform sampler2D Sampler0;'+#10+
'    uniform sampler2D Sampler1;'+#10+
''+#10+
'//            vec3 LightPosition = vec3(1.0, 0.0, 1.4);'+#10+
'    vec3 LightPosition = vec3(1.0, 1.0, 1.4);'+#10+
''+#10+
'    float UmgebungsLicht = 0.4;'+#10+
'      vec3  Normal2;'+#10+
  ''+#10+
'    float diffuse()'+#10+
'    {'+#10+
'    vec3 LP        = (LightPosition * 1.0) - Pos;'+#10+
'    float distance = length(LP);'+#10+
'    float dif      = max(dot(Normal2, LP), UmgebungsLicht);'+#10+
'    return           dif * (1.0 / (1.0 + (0.25 * distance* distance)));'+#10+
'    }'+#10+
''+#10+
'    float specular()'+#10+
'    {'+#10+
'    vec3 Eye          = normalize(LightPosition);'+#10+
'    vec3 Reflected    = normalize( reflect( -Pos, Normal2 ));'+#10+
'    return              0.15 * pow(max(dot(Reflected, Eye), 0.0), 1.0);'+#10+
'    }'+#10+
''+#10+
''+#10+
'    void main()'+#10+
'    {'+#10+
'        Normal2 = (texture2D(Sampler1, UV.st).rgb * 2.0 - 1.0) + normalize(Normal);'+#10+
'        vec4 Color = texture2D(Sampler0, UV);'+#10+
    ''+#10+
'        float cola = Color.a;'+#10+
    ''+#10+
'        gl_FragColor = (Color * diffuse() + specular());'+#10+
'        gl_FragColor.a = cola;'+#10+
'    }';







implementation

end.

