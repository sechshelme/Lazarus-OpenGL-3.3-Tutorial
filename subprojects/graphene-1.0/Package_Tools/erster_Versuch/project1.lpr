program project1;

uses
  graphene,
  graphene_macros,
  graphene_gobject,
  graphene_types,
  graphene_version,
  graphene_vec2,        // io.
  graphene_vec3,        // io.
  graphene_vec4,        // io.
  graphene_point,       // io.
  graphene_size,        // io.
  graphene_rect,        // io. -> graphene_size, graphene_point
  graphene_point3d,     // io. -> graphene_rect
  graphene_euler,       // io.
  graphene_quaternion,  // io. -> graphene_euler
  graphene_plane,       // io. -> graphene_point3d
  graphene_box,         // io. -> graphene_point3d
  graphene_sphere,      // io. -> graphene_point3d
  graphene_triangle,    // io. -> graphene_point3d, graphene_plane
  graphene_ray,         // io. -> graphene_point3d, graphene_plane, graphene_triangle
  graphene_quad,        // io. -> graphene_point, graphene_rect
  graphene_frustum,     // io. -> graphene_plane, graphene_point3d
  graphene_matrix,      // io. -> graphene_point3d, graphene_point, graphene_rect, graphene_quad, graphene_ray, graphene_euler
  graphene_simd4f,      // inline und record Problem
  graphene_simd4x4f,    // inline und record Problem


  ctypes;




  function main(argc: cint; argv: PPChar): cint;
  var
    v1, v2, res: Tgraphene_simd4f_t;
    x, y, z, w: single;
    vec: Pgraphene_vec4_t;
  begin
    v1 := graphene_simd4f_init(1.0, 2.0, 3.0, 4.0);
    v2 := graphene_simd4f_init(5.0, 6.0, 7.0, 8.0);
    res := graphene_simd4f_add(v1, v2);

    res.x := 111;
    res.y := 222;
    res.z := 333;
    res.w := 444;

    x := graphene_simd4f_get_x(res);
    y := graphene_simd4f_get_y(res);
    z := graphene_simd4f_get_z(res);
    w := graphene_simd4f_get_w(res);

    WriteLn('x: ', x: 4: 2, '  y: ', y: 4: 2, '  z: ', z: 4: 2, '  w: ', w: 4: 2);


    vec := graphene_vec4_alloc;

    graphene_vec4_init(vec, 1, 2, 3, 4);

    graphene_vec4_scale(vec, 0.5, vec);

    x := graphene_vec4_get_x(vec);
    y := graphene_vec4_get_y(vec);
    z := graphene_vec4_get_z(vec);
    w := graphene_vec4_get_w(vec);

    WriteLn('x: ', x: 4: 2, '  y: ', y: 4: 2, '  z: ', z: 4: 2, '  w: ', w: 4: 2);

    graphene_vec4_free(vec);
  end;

begin
  WriteLn('size: ', SizeOf(Tgraphene_simd4f_t));

  main(argc, argv);
end.
typedef struct {
  float x, y, z, w;
} v4;
extern v4 v_add  (const v4 a, const v4 b);
