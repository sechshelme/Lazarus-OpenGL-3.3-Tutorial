unit graphene_gobject;

interface

uses
  ctypes, graphene;


function GRAPHENE_TYPE_POINT: TGType;

function graphene_point_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_POINT3D: TGType;

function graphene_point3d_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_SIZE: TGType;

function graphene_size_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_RECT: TGType;

function graphene_rect_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_VEC2: TGType;

function graphene_vec2_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_VEC3: TGType;

function graphene_vec3_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_VEC4: TGType;

function graphene_vec4_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_QUAD: TGType;

function graphene_quad_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_QUATERNION: TGType;

function graphene_quaternion_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_MATRIX: TGType;

function graphene_matrix_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_PLANE: TGType;

function graphene_plane_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_FRUSTUM: TGType;

function graphene_frustum_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_SPHERE: TGType;

function graphene_sphere_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_BOX: TGType;

function graphene_box_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_TRIANGLE: TGType;

function graphene_triangle_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_EULER: TGType;

function graphene_euler_get_type: TGType; cdecl; external libgraphene;
function GRAPHENE_TYPE_RAY: TGType;

function graphene_ray_get_type: TGType; cdecl; external libgraphene;

implementation

function GRAPHENE_TYPE_POINT: TGType;
begin
  GRAPHENE_TYPE_POINT := graphene_point_get_type;
end;

function GRAPHENE_TYPE_POINT3D: TGType;
begin
  GRAPHENE_TYPE_POINT3D := graphene_point3d_get_type;
end;

function GRAPHENE_TYPE_SIZE: TGType;
begin
  GRAPHENE_TYPE_SIZE := graphene_size_get_type;
end;

function GRAPHENE_TYPE_RECT: TGType;
begin
  GRAPHENE_TYPE_RECT := graphene_rect_get_type;
end;

function GRAPHENE_TYPE_VEC2: TGType;
begin
  GRAPHENE_TYPE_VEC2 := graphene_vec2_get_type;
end;

function GRAPHENE_TYPE_VEC3: TGType;
begin
  GRAPHENE_TYPE_VEC3 := graphene_vec3_get_type;
end;

function GRAPHENE_TYPE_VEC4: TGType;
begin
  GRAPHENE_TYPE_VEC4 := graphene_vec4_get_type;
end;

function GRAPHENE_TYPE_QUAD: TGType;
begin
  GRAPHENE_TYPE_QUAD := graphene_quad_get_type;
end;

function GRAPHENE_TYPE_QUATERNION: TGType;
begin
  GRAPHENE_TYPE_QUATERNION := graphene_quaternion_get_type;
end;

function GRAPHENE_TYPE_MATRIX: TGType;
begin
  GRAPHENE_TYPE_MATRIX := graphene_matrix_get_type;
end;

function GRAPHENE_TYPE_PLANE: TGType;
begin
  GRAPHENE_TYPE_PLANE := graphene_plane_get_type;
end;

function GRAPHENE_TYPE_FRUSTUM: TGType;
begin
  GRAPHENE_TYPE_FRUSTUM := graphene_frustum_get_type;
end;

function GRAPHENE_TYPE_SPHERE: TGType;
begin
  GRAPHENE_TYPE_SPHERE := graphene_sphere_get_type;
end;

function GRAPHENE_TYPE_BOX: TGType;
begin
  GRAPHENE_TYPE_BOX := graphene_box_get_type;
end;

function GRAPHENE_TYPE_TRIANGLE: TGType;
begin
  GRAPHENE_TYPE_TRIANGLE := graphene_triangle_get_type;
end;

function GRAPHENE_TYPE_EULER: TGType;
begin
  GRAPHENE_TYPE_EULER := graphene_euler_get_type;
end;

function GRAPHENE_TYPE_RAY: TGType;

begin
  GRAPHENE_TYPE_RAY := graphene_ray_get_type;
end;


end.
