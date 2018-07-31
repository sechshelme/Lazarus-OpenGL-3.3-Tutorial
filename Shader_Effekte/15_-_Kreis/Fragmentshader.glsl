#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : disable

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

vec3 lightDir = normalize(vec3(sin(time * 1.5), 2.0, cos(time * 0.5)));

mat3 camera(vec3 ro, vec3 ta, vec3 up) {
	vec3 nz = normalize(ta - ro);
	vec3 nx = cross(nz, normalize(up));
	vec3 ny = cross(nx, nz);

	return mat3(nx, ny, nz);
}

float plane(vec3 p) {
	return p.y+2.;
}

float sphere(vec3 p, float r) {
	return length(p) - r;
}

float torus(vec3 p, vec2 t) {
	return length(vec2(length(p.xz) - t.x, p.y)) - t.y;
}

vec4 scene(vec3 p) {

	vec3 check = sin(p.x * 5.0) * sin(p.z * 5.0) > 0.0 ? vec3(0.7) : vec3(0.0);

	vec4 resP = vec4(check, plane(p - vec3(0.0, -1.0, 0.0)));
	vec4 resS = vec4(vec3(0.5, 0.1, 0.1), sphere(p - vec3(sin(time) * 2., cos(time) * 2. + 2.0, 0.0), 1.0));
	vec4 resT = vec4(vec3(0.1, 0.4, 0.5), torus(p - vec3(-2.0, 2.0, 0.0), vec2(2.0, 0.5)));

	vec4 res = resP.w < resS.w ? resP : resS;
	res = res.w < resT.w ? res : resT;

	return res;
}

vec3 normal(vec3 p) {
	float d = 0.0001;
	return normalize(vec3(
		scene(p + vec3(d, 0.0, 0.0)).w - scene(p + vec3(-d, 0.0, 0.0)).w,
		scene(p + vec3(0.0, d, 0.0)).w - scene(p + vec3(0.0, -d, 0.0)).w,
		scene(p + vec3(0.0, 0.0, d)).w - scene(p + vec3(0.0, 0.0, -d)).w
	));
}

float softshadow(vec3 ro, vec3 rd) {

	float v = 1.0;
	float t = 0.0;
	vec3 p = ro;
	for (int i = 0; i < 16; i++) {
		vec4 res = scene(p);
		float d = res.w;
		if (d < 0.001) {
			return 0.0;
		}
		v = min(v, 4.0 * d / t);
		t += d;
		p = ro + t * rd;
	}

	return v;
}

vec3 render(vec3 ro, vec3 rd) {


	vec3 color = vec3(0.8, 0.9, 1.0);

	float tmax = 30.0;

	float t = 0.0;
	float d = 0.0;
	vec3 p = ro;
	vec3 c;
	for(int i = 0; i < 64; i++) {
		vec4 res = scene(p);
		c = res.rgb;
		d = res.w;
		t += d;
		p = ro + t * rd;
		if (t > tmax) break;
	}

	if (t < tmax) {
		color = c;

		vec3 nor = normal(p);
		float dif = clamp(dot(nor, lightDir), 0.0, 1.0);
		color += vec3(0.3, 0.4, 0.5) * dif;

		vec3 ref = reflect(rd, nor);
		float spe = clamp(dot(ref, lightDir), 0.0, 1.0);
		color += vec3(4.0) * pow(spe, 30.0);

		float sf = softshadow(p + nor * 0.01, lightDir);
		color *= clamp(sf + 0.3, 0.0, 1.0);
	}


	color = mix(color, vec3(0.8, 0.9, 1.0), 1.0 - exp(-0.00005  * t * t * t));


	return color;

}

void main( void ) {

	vec2 p = (gl_FragCoord.xy * 2.0 - resolution) / resolution;
	p.x *= resolution.x / resolution.y;

	vec3 ro = vec3(10.0 * cos(mouse.x * 6.0), mouse.y * 10., 10.0 * sin(mouse.x * 6.0));
	vec3 ta = vec3(0.0, 0.0, 0.0);

	vec3 rd = camera(ro, ta, vec3(0.0, 1.0, 0.0)) * normalize(vec3(p.xy, 2.0));

	vec3 col = render(ro, rd);

	gl_FragColor = vec4(col, 1.0);

}
