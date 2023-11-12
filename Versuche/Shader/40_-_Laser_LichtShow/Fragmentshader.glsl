#version 330
#define depth 1000.0

#define Pi				3.14159265358979

#define HorizontalAmplitude		0.30
#define VerticleAmplitude		0.20
#define HorizontalSpeed			0.90
#define VerticleSpeed			1.50
#define ParticleMinSize			1.76
#define ParticleMaxSize			1.61
#define ParticleBreathingSpeed		0.30
#define ParticleColorChangeSpeed	0.70
#define ParticleCount			2.0
#define ParticleColor1			vec3(9.0, 5.0, 3.0)
#define ParticleColor2			vec3(1.0, 3.0, 9.0)

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

out vec4 outColor;

float LichtOeffnung = 16;
uniform float[5] LichtRichtung;

uniform vec2 LichtPosition;

uniform float time;
uniform vec2 resolution;

bool isCone(vec2 p, float LichtRichtung) {
  vec2 lr;
  lr.x = sin(LichtRichtung);
  lr.y = cos(LichtRichtung);

  float winkel;
  lr = normalize(lr);
  vec2 lp = vec2(p - LichtPosition);
  lp = normalize(lp);
  winkel = dot(lr, lp);

  return (winkel > cos(3.14 / LichtOeffnung));
}

float hash( float x ) {
  return fract( sin( x ) * 43758.5453 );
}

float noise( vec2 uv ) {
  vec3 x = vec3( uv.xy, 0.0 );

  vec3 p = floor( x );
  vec3 f = fract( x );

  f = f * f * (3.0 - 2.0 * f);

  float offset = 57.0;
  float n = dot( p, vec3(1.0, offset, offset*2.0) );

  return mix(mix(mix(hash( n + 0.0 ), hash( n + 1.0 ), f.x ),
         mix( hash( n + offset), hash( n + offset + 1.0), f.x ), f.y ),
         mix(mix( hash( n + offset * 2.0), hash( n + offset * 2.0 + 1.0), f.x),
      	 mix( hash( n + offset * 3.0), hash( n + offset * 3.0 + 1.0), f.x), f.y), f.z);
}

float snoise( vec2 uv ) {
  return noise( uv ) * 2.0 - 1.0;
}


float perlinNoise( vec2 uv ) {
  float n = noise( uv *   1.0 )	* 128.0 +
            noise( uv *   2.0 )	*  64.0 +
            noise( uv *   4.0 )	*  32.0 +
            noise( uv *   8.0 )	*  16.0 +
            noise( uv *  16.0 )	*   8.0 +
            noise( uv *  32.0 )	*   4.0 +
            noise( uv *  64.0 )	*   2.0 +
            noise( uv * 128.0 ) *   1.0;

  float noiseVal = n / ( 255.0 );
  noiseVal = abs(noiseVal * 2.0 - 1.0);

  return 	noiseVal;
}

float fBm( vec2 uv, float lacunarity, float gain )
{
  float sum = 0.0;
  float amp = 7.0;

  for( int i = 0; i < 2; ++i ) {
    sum += ( perlinNoise( uv ) ) * amp;
    amp *= gain;
    uv *= lacunarity;
  }

  return sum;
}

vec3 particles( vec2 pos ) {
  vec3 c = vec3( 0, 0, 0 );

  float noiseFactor = fBm( pos, 0.01, 0.1);

  for( float i = 1.0; i < ParticleCount+1.0; ++i ) {
    float cs = cos( time * HorizontalSpeed * (i/ParticleCount) + noiseFactor ) * HorizontalAmplitude;
    float ss = sin( time * VerticleSpeed   * (i/ParticleCount) + noiseFactor ) * VerticleAmplitude;
    vec2 origin = vec2( cs , ss );

    float t = sin( time * ParticleBreathingSpeed * i ) * 0.5 + 0.5;
    float particleSize = mix( ParticleMinSize, ParticleMaxSize, t );
    float d = clamp( sin( length( pos - origin )  + particleSize ), 0.0, particleSize);

    float t2 = sin( time * ParticleColorChangeSpeed * i ) * 0.5 + 0.5;
    vec3 color = mix( ParticleColor1, ParticleColor2, t2 );
    c += color * pow( d, 10.0 );
  }

  return c;
}


float line( vec2 a, vec2 b, vec2 p ) {
  vec2 aTob = b - a;
  vec2 aTop = p - a;

  float t = dot( aTop, aTob ) / dot( aTob, aTob);

  t = clamp( t, 0.0, 1.0);

  float d = length( p - (a + aTob * t) );
  d = 1.0 / d;

  return clamp( d, 0.0, 1.0 );
}


void main(void) {
  float aspectRatio = resolution.x / resolution.y;

  vec2 uv = ( gl_FragCoord.xy / resolution.xy );

  vec2 signedUV = uv * 2.0 - 1.0;
  signedUV.x *= aspectRatio;
  signedUV.y *= -1.0;

  float scale = 100.0;
  const float v = 90.0;
  vec3 finalColor = vec3( 0.0 );

  finalColor = (particles( sin( abs(signedUV) ) ) * length(signedUV)) * 0.20;

  vec2 _uv = signedUV;
  signedUV.x /= cos(time);
  float t;
  for (float i=0.0; i<5.0; i+=1.0) {
    float freq = mix( 0.4, 1.2, sin(time + 10.0 * i) * 0.5 + 0.5 );
    float ang =  (i / 5.0 * 2.0 - 0.1) * Pi;
    float ang2 =  ((i + 2.0) / 5.0 * 2.0 - 0.1) * Pi;
    t = line( vec2(cos(ang), sin(ang)) * v, vec2(cos(ang2), sin(ang2) + 0.05) * v, signedUV * scale );
    finalColor += vec3( 8.0 * t, 2.0 * t, 4.0 * t) * freq;
  }

  signedUV = _uv;
  signedUV.x /= sin(time);

  scale = scale * 1.8;
  t = line( vec2(0.0, v * 0.4), vec2(0.0, -v * 0.3), signedUV * scale );
  finalColor += vec3( 8.0 * t, 4.0 * t, 2.0 * t) * 0.5;

  t = line( vec2(-v * 0.2, -v*0.1), vec2(v * 0.2, -v*0.1), signedUV * scale );
  finalColor += vec3( 8.0 * t, 4.0 * t, 2.0 * t) * 0.4;


  finalColor /= 15;
  outColor = vec4( finalColor, 1.0 );

   for (int i = 0; i <= 5; i++) {
     if (isCone(pos, LichtRichtung[i])) {
       outColor *= 5;
     }
   }
}
