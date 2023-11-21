#version 420

#define BackGround vec3(0.2, 0.7, 0.8)

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

uniform float col; // Start-Wert, für Farben-Spielerei

out vec4 outColor;

float VecMulti(in vec3 v0,in vec3 v1) {
  return v0.x * v1.x + v0.y * v1.y + v0.z * v1.z;
}

vec3 cross(in vec3 v1, in vec3 v2) {
    return vec3 ( v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x );
}




struct Material {
    float refractive_index;
    float albedo[4];
    vec3 diffuse_color;
    float specular_exponent;
};

struct Sphere {
    vec3 center;
    float radius;
    Material material;
};

const Material      ivory = {1.0, {0.9,  0.5, 0.1, 0.0}, {0.4, 0.4, 0.3},   50.};
const Material      glass = {1.5, {0.0,  0.9, 0.1, 0.8}, {0.6, 0.7, 0.8},  125.};
const Material red_rubber = {1.0, {1.4,  0.3, 0.0, 0.0}, {0.3, 0.1, 0.1},   10.};
const Material     mirror = {1.0, {0.0, 16.0, 0.8, 0.0}, {1.0, 1.0, 1.0}, 1425.};

const Material     defaultmat = {1.0, {2, 0, 0, 0}, {0, 0, 0}, 0};

#define sphereCount  5
const Sphere spheres[sphereCount] = {
    {{-3,    0,   -16}, 2,      ivory},
    {{-1.0, -1.5, -12}, 2,      glass},
//    {{6.0, -2.5, -12}, 2,      glass},
    {{ 1.5, -0.5, -18}, 3, red_rubber},
    {{ -7,    5,   -18}, 4,     mirror},
    {{ 7,    5,   -18}, 4,     mirror}
};

#define lightCount 3
//vec3 lights[3] = vec3[3](vec3(-20, 20,  20), vec3(30, 50, -25), vec3 (30, 20,  30));
uniform vec3 lights[3];

vec3 reflect(const vec3 I, const vec3 N) {
    return I - N * 2.f* VecMulti(I, N);
}

vec3 my_refract2(in vec3 I, in vec3 N, in float eta_t, in float eta_i) {
    float cosi = - max(-1.0, min(1.0, VecMulti(I, N)  ));
//    if (cosi<0) return refract(I, -N, eta_i, eta_t);
    float eta = eta_i / eta_t;
    float k = 1 - eta*eta*(1 - cosi*cosi);
    return k<0 ? vec3(1,0,0) : I*eta + N*(eta*cosi - sqrt(k));
}

vec3 my_refract(in vec3 I, in vec3 N, in float eta_t, in float eta_i) {
    float cosi = - max(-1.0, min(1.0, VecMulti(I, N)));
    if (cosi<0) return my_refract2(I, -N, eta_i, eta_t);
    float eta = eta_i / eta_t;
    float k = 1 - eta*eta*(1 - cosi*cosi);
    return k<0 ? vec3(1,0,0) : I*eta + N*(eta*cosi - sqrt(k));
}



void ray_sphere_intersect(in vec3 orig, in vec3 dir, in Sphere s,  out bool intersection, out float d ) {
    vec3 L = s.center - orig;
    float tca = VecMulti( L,dir);
    float d2 = VecMulti( L,L) - tca*tca;
    if (d2 > s.radius*s.radius) { intersection = false; d = 0; return;}
    float thc = sqrt(s.radius*s.radius - d2);
    float t0 = tca-thc, t1 = tca+thc;
    if (t0>.001) { intersection = true; d = t0; return;}
    if (t1>.001) { intersection = true, d = t1; return;}

    intersection = false;
    d = 0;
    return;}

void scene_intersect(in vec3 orig, in vec3 dir,       out bool hit, out vec3 shadow_pt, out vec3 trashnrm, out Material trashmat     ) {
    vec3 pt, N;
    Material material = defaultmat;
//          material=red_rubber;

    float nearest_dist = 1e10;
    if (abs(dir.y) > 0.001) { // intersect the ray with the checkerboard, avoid division by zero
        float d = -(orig.y + 4) / dir.y; // the checkerboard plane has equation y = -4
        vec3 p = orig + dir*d;
        if (d > 0.001 && d < nearest_dist && abs(p.x) < 10 && p.z < -10 && p.z > -30) {
            nearest_dist = d;
            pt = p;
            N = vec3(0,1,0);

            int dc = int(.5*pt.x+1000) + int(.5*pt.z);
            if ((dc & 1) != 0) {
                material.diffuse_color = vec3(.3, .3, .3);
            } else {
                material.diffuse_color = vec3(.3, .2, .1);
            }
        }
    }

    for (int i = 0; i < sphereCount; i++) {
        Sphere s=spheres[i];

        bool intersection = false;
        float d = 0.0;

        ray_sphere_intersect(orig, dir, s, intersection, d);

        if (!intersection || d > nearest_dist) {} else {
          nearest_dist = d;
          pt = orig + dir*nearest_dist;
          N = normalize(pt - s.center);
          material = s.material;
        }
    }

    hit = nearest_dist < 1000;
    shadow_pt = pt;
    trashnrm = N;
    trashmat = material;
    return;
}

// === Recursiv 4 ===

vec3 cast_ray4(in vec3 orig, in vec3 dir, in int depth) {
   bool hit;
   vec3 point;
   vec3 N;
   Material material = defaultmat;
   scene_intersect(orig, dir, hit, point, N, material);

    if (depth > 4 || !hit) return BackGround;

    vec3 reflect_dir = normalize( reflect(dir, N));
    vec3 refract_dir = normalize( my_refract(dir, N, material.refractive_index, 1));

//    vec3 reflect_color = cast_ray(point, reflect_dir, depth + 1);
//    vec3 refract_color = cast_ray(point, refract_dir, depth + 1);
 vec3 reflect_color=vec3(0.2, 0.7, 0.8);
 vec3 refract_color=vec3(0.2, 0.7, 0.8);


    float diffuse_light_intensity = 0, specular_light_intensity = 0;
    for (int i = 0; i < lightCount; i++) { // checking if the point lies in the shadow of the light
        vec3 light = lights[i];

        vec3 light_dir = normalize(light - point);

        bool hit;
        vec3 shadow_pt;
        vec3 trashnrm;
        Material trashmat;
        scene_intersect(point, light_dir, hit, shadow_pt, trashnrm, trashmat);

        if (hit && length(shadow_pt-point) < length(light-point)) continue;
        diffuse_light_intensity  += max(0.f, VecMulti( light_dir,N));

        vec3 r = vec3(0,0,0) - reflect(vec3(0,0,0) - light_dir, N);

        specular_light_intensity += pow(max(0.f, VecMulti(r, dir)), material.specular_exponent + 0.0001);
    }
    return material.diffuse_color * diffuse_light_intensity * material.albedo[0] +
        vec3(1., 1., 1.) * specular_light_intensity * material.albedo[1] +
        reflect_color * material.albedo[2] +
        refract_color * material.albedo[3];
}


// === Recursiv 3 ===

vec3 cast_ray3(in vec3 orig, in vec3 dir, in int depth) {
   bool hit;
   vec3 point;
   vec3 N;
   Material material = defaultmat;
   scene_intersect(orig, dir, hit, point, N, material);

    if (depth > 4 || !hit) return BackGround;

    vec3 reflect_dir = normalize( reflect(dir, N));
    vec3 refract_dir = normalize( my_refract(dir, N, material.refractive_index, 1));

    vec3 reflect_color = cast_ray4(point, reflect_dir, depth + 1);
    vec3 refract_color = cast_ray4(point, refract_dir, depth + 1);

    float diffuse_light_intensity = 0, specular_light_intensity = 0;
    for (int i = 0; i < lightCount; i++) { // checking if the point lies in the shadow of the light
        vec3 light = lights[i];

        vec3 light_dir = normalize(light - point);

        bool hit;
        vec3 shadow_pt;
        vec3 trashnrm;
        Material trashmat;
        scene_intersect(point, light_dir, hit, shadow_pt, trashnrm, trashmat);

        if (hit && length(shadow_pt-point) < length(light-point)) continue;
        diffuse_light_intensity  += max(0.f, VecMulti( light_dir,N));

        vec3 r = vec3(0,0,0) - reflect(vec3(0,0,0) - light_dir, N);

        specular_light_intensity += pow(max(0.f, VecMulti(r, dir)), material.specular_exponent + 0.0001);
    }
    return material.diffuse_color * diffuse_light_intensity * material.albedo[0] +
        vec3(1., 1., 1.) * specular_light_intensity * material.albedo[1] +
        reflect_color * material.albedo[2] +
        refract_color * material.albedo[3];
}


// === Recursiv 3 ===

vec3 cast_ray2(in vec3 orig, in vec3 dir, in int depth) {
   bool hit;
   vec3 point;
   vec3 N;
   Material material = defaultmat;
   scene_intersect(orig, dir, hit, point, N, material);

    if (depth > 4 || !hit) return BackGround;

    vec3 reflect_dir = normalize( reflect(dir, N));
    vec3 refract_dir = normalize( my_refract(dir, N, material.refractive_index, 1));

    vec3 reflect_color = cast_ray3(point, reflect_dir, depth + 1);
    vec3 refract_color = cast_ray3(point, refract_dir, depth + 1);

    float diffuse_light_intensity = 0, specular_light_intensity = 0;
    for (int i = 0; i < lightCount; i++) { // checking if the point lies in the shadow of the light
        vec3 light = lights[i];

        vec3 light_dir = normalize(light - point);

        bool hit;
        vec3 shadow_pt;
        vec3 trashnrm;
        Material trashmat;
        scene_intersect(point, light_dir, hit, shadow_pt, trashnrm, trashmat);

        if (hit && length(shadow_pt-point) < length(light-point)) continue;
        diffuse_light_intensity  += max(0.f, VecMulti( light_dir,N));

        vec3 r = vec3(0,0,0) - reflect(vec3(0,0,0) - light_dir, N);

        specular_light_intensity += pow(max(0.f, VecMulti(r, dir)), material.specular_exponent + 0.0001);
    }
    return material.diffuse_color * diffuse_light_intensity * material.albedo[0] +
        vec3(1., 1., 1.) * specular_light_intensity * material.albedo[1] +
        reflect_color * material.albedo[2] +
        refract_color * material.albedo[3];
}


// === Recursiv 1 ===

vec3 cast_ray(in vec3 orig, in vec3 dir, in int depth) {
   bool hit;
   vec3 point;
   vec3 N;
   Material material = defaultmat;
   scene_intersect(orig, dir, hit, point, N, material);

    if (depth > 4 || !hit) return BackGround;

    vec3 reflect_dir = normalize( reflect(dir, N));
    vec3 refract_dir = normalize( my_refract(dir, N, material.refractive_index, 1));

    vec3 reflect_color = cast_ray2(point, reflect_dir, depth + 1);
    vec3 refract_color = cast_ray2(point, refract_dir, depth + 1);

    float diffuse_light_intensity = 0, specular_light_intensity = 0;
    for (int i = 0; i < lightCount; i++) { // checking if the point lies in the shadow of the light
        vec3 light = lights[i];

        vec3 light_dir = normalize(light - point);

        bool hit;
        vec3 shadow_pt;
        vec3 trashnrm;
        Material trashmat;
        scene_intersect(point, light_dir, hit, shadow_pt, trashnrm, trashmat);

        if (hit && length(shadow_pt-point) < length(light-point)) continue;
        diffuse_light_intensity  += max(0.f, VecMulti( light_dir,N));

        vec3 r = vec3(0,0,0) - reflect(vec3(0,0,0) - light_dir, N);

        specular_light_intensity += pow(max(0.f, VecMulti(r, dir)), material.specular_exponent + 0.0001);
    }
    return material.diffuse_color * diffuse_light_intensity * material.albedo[0] +
        vec3(1., 1., 1.) * specular_light_intensity * material.albedo[1] +
        reflect_color * material.albedo[2] +
        refract_color * material.albedo[3];
}


void main(void) {
  int pix = 10;

  float fov    = 1.05;

  float dir_x =  pos.x * 1.2;
  float dir_y =  pos.y * 1;
  float dir_z = -1 * 2 / (2. * tan(fov / 2.));

  outColor = vec4(cast_ray(vec3(0,0,0), normalize( vec3(dir_x, dir_y, dir_z)) , 0), 1);

}
