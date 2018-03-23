unit oglLightingShader;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  dglOpenGL,
  oglShader, oglVertex, oglMatrix, oglUBO;

const
  MaterialPara: array[0..21] of record
      Name: string;
      ambient: TVector4f;
      diffuse: TVector4f;
      specular: TVector4f;
      shininess: GLfloat
    end
  = ((
    Name: 'Brass';        // Messing
    ambient: (0.33, 0.22, 0.03, 1.0);
    diffuse: (0.78, 0.57, 0.11, 1.0);
    specular: (0.99, 0.94, 0.81, 1.0);
    shininess: 27.9; ), (

    Name: 'Bronze';
    ambient: (0.21, 0.13, 0.05, 1.0);
    diffuse: (0.71, 0.43, 0.18, 1.0);
    specular: (0.39, 0.27, 0.16, 1.0);
    shininess: 25.6; ), (

    Name: 'Polished_Bronze';
    ambient: (0.25, 0.14, 0.06, 1.0);
    diffuse: (0.4, 0.23, 0.10, 1.0);
    specular: (0.77, 0.46, 0.20, 1.0);
    shininess: 76.8; ), (

    Name: 'Chrome';
    ambient: (0.25, 0.25, 0.25, 1.0);
    diffuse: (0.4, 0.4, 0.4, 1.0);
    specular: (0.77, 0.77, 0.77, 1.0);
    shininess: 76.8; ), (

    Name: 'Copper';     // Kupfer
    ambient: (0.19, 0.07, 0.02, 1.0);
    diffuse: (0.70, 0.27, 0.08, 1.0);
    specular: (0.26, 0.14, 0.09, 1.0);
    shininess: 12.8; ), (

    Name: 'PolishedCopper';
    ambient: (0.23, 0.09, 0.03, 1.0);
    diffuse: (0.55, 0.21, 0.07, 1.0);
    specular: (0.58, 0.22, 0.07, 1.0);
    shininess: 51.2; ), (

    Name: 'Gold';
    ambient: (0.25, 0.20, 0.07, 1.0);
    diffuse: (0.75, 0.61, 0.23, 1.0);
    specular: (0.62, 0.56, 0.37, 1.0);
    shininess: 51.2; ), (

    Name: 'PolishedGold';
    ambient: (0.25, 0.22, 0.06, 1.0);
    diffuse: (0.35, 0.31, 0.09, 1.0);
    specular: (0.80, 0.72, 0.21, 1.0);
    shininess: 83.2; ), (

    Name: 'Pewter';    // Zinn
    ambient: (0.11, 0.06, 0.11, 1.0);
    diffuse: (0.43, 0.48, 0.54, 1.0);
    specular: (0.33, 0.33, 0.52, 1.0);
    shininess: 9.8; ), (

    Name: 'Silver';
    ambient: (0.19, 0.19, 0.19, 1.0);
    diffuse: (0.51, 0.51, 0.51, 1.0);
    specular: (0.51, 0.51, 0.51, 1.0);
    shininess: 51.2; ), (

    Name: 'PolishedSilver';
    ambient: (0.23, 0.23, 0.23, 1.0);
    diffuse: (0.28, 0.28, 0.28, 1.0);
    specular: (0.77, 0.77, 0.77, 1.0);
    shininess: 89.6; ), (

    Name: 'Emerald';          // Smaragd
    ambient: (0.02, 0.17, 0.02, 0.55);
    diffuse: (0.07, 0.61, 0.08, 0.55);
    specular: (0.63, 0.73, 0.63, 0.55);
    shininess: 76.8; ), (

    Name: 'Jade';
    ambient: (0.14, 0.22, 0.16, 0.95);
    diffuse: (0.54, 0.89, 0.63, 0.95);
    specular: (0.32, 0.32, 0.32, 0.95);
    shininess: 12.8; ), (

    Name: 'Obisdian';
    ambient: (0.05, 0.05, 0.07, 0.82);
    diffuse: (0.18, 0.17, 0.23, 0.82);
    specular: (0.33, 0.33, 0.35, 0.82);
    shininess: 38.4; ), (

    Name: 'Pearl';
    ambient: (0.25, 0.21, 0.21, 0.92);
    diffuse: (1.00, 0.83, 0.83, 0.92);
    specular: (0.30, 0.30, 0.30, 0.92);
    shininess: 12.3; ), (

    Name: 'Ruby';      // Rubin
    ambient: (0.17, 0.01, 0.01, 0.55);
    diffuse: (0.61, 0.04, 0.04, 0.55);
    specular: (0.72, 0.63, 0.63, 0.55);
    shininess: 76.8; ), (

    Name: 'Turquoise';         // Türkis
    ambient: (0.10, 0.18, 0.17, 0.8);
    diffuse: (0.40, 0.74, 0.69, 0.8);
    specular: (0.30, 0.31, 0.31, 0.8);
    shininess: 12.8; ), (

    Name: 'PlasticBlack';
    ambient: (0.00, 0.00, 0.00, 1.0);
    diffuse: (0.01, 0.01, 0.01, 1.0);
    specular: (0.50, 0.50, 0.50, 1.0);
    shininess: 32.0; ), (

    Name: 'RubberBlack';
    ambient: (0.02, 0.02, 0.02, 1.0);
    diffuse: (0.01, 0.01, 0.01, 1.0);
    specular: (0.50, 0.50, 0.50, 1.0);
    shininess: 10.0; ), (

    Name: 'PlasticGreen';
    ambient: (0.00, 0.05, 0.00, 1.0);
    diffuse: (0.40, 0.50, 0.40, 1.0);
    specular: (0.04, 0.70, 0.04, 1.0);
    shininess: 32.0; ), (

    Name: 'PlasticRed';
    ambient: (0.05, 0.00, 0.00, 1.0);
    diffuse: (0.50, 0.40, 0.40, 1.0);
    specular: (0.70, 0.04, 0.04, 1.0);
    shininess: 32.0; ), (

    Name: 'PlasticWhite';
    ambient: (0.05, 0.05, 0.05, 1.0);
    diffuse: (0.50, 0.50, 0.50, 1.0);
    specular: (0.70, 0.70, 0.70, 1.0);
    shininess: 32.0; ));

type

  { TLightingShader }

//  {$define ubo}

  TLightingShader = class(TShader)
  private
    Lighting: record
      Enabled: boolean;

      {$ifdef ubo}
      LightUBO, MaterialUBO: TUBO;
      {$else}
            UniformID: record
              Light: record
                position, ambient, diffuse, specular: glInt;
              end;
              Material: record
                ambient, diffuse, specular, shininess: GLInt;
              end;
            end;
      {$endif}
    end;

  public
    LightParams: record
      position, ambient, diffuse, specular: TVector4f;
    end;

    MaterialParams: record
      ambient, diffuse, specular: TVector4f;
      shininess: GLfloat;     // Glanz
    end;

    constructor Create(AShader: array of ansistring; lightON: boolean);
    destructor Destroy; override;

    procedure SetMaterial(Name: string);
    procedure UpdateMaterial;

    procedure UpdateLight;
  end;


implementation

{ TLightingShader }

constructor TLightingShader.Create(AShader: array of ansistring; lightON: boolean);

const
  noLightingShader =
    'vec4 Light(in vec3 Normal, in vec3 Position)' + LineEnding +
    '{' + LineEnding +
    '  return vec4(1.0, 1.0, 1.0, 1.0);' + LineEnding +
    '}';

  {$ifdef ubo}
  LightingShader =
    'layout(std140) uniform Material {' + LineEnding +
    '   vec4 Mambient;' + LineEnding +
    '   vec4 Mdiffuse;' + LineEnding +
    '   vec4 Mspecular;' + LineEnding +
    '   float Mshininess;     // Glanz' + LineEnding +
    '};' + LineEnding +

    'layout(std140) uniform Lighting {' + LineEnding +
    '  vec4 Lposition;' + LineEnding +
    '  vec4 Lambient;    // Umgebungslicht' + LineEnding +
    '  vec4 Ldiffuse;    // Lichtfarbe' + LineEnding +
    '  vec4 Lspecular;   // Spiegelnd' + LineEnding +
    '};' + LineEnding +

    'vec4 Light(in vec3 Normal, in vec3 Position) {' + LineEnding +
    '  vec3 N       = normalize(Normal);' + LineEnding +
    '  vec4 ambient = Mambient * Lambient;' + LineEnding +
    '  vec3 L       = normalize(vec3(Lposition) - Position);' + LineEnding +
    '  vec4 Pos_eye = vec4(0.0, 0.0, 1.0, 0.0);' + LineEnding +
    '  vec3 A       = Pos_eye.xyz;' + LineEnding +
    '  vec3 H       = normalize(L + A);' + LineEnding +
    '  vec4 diffuse       = vec4(0.0, 0.0, 0.0, 1.0);' + LineEnding +
    '  vec4 specular      = vec4(0.0, 0.0, 0.0, 1.0);' + LineEnding +
    '  float diffuseLight = max(dot(N, L), 0.0);' + LineEnding +
    '  if (diffuseLight > 0.0) {' + LineEnding +
    '    diffuse         = diffuseLight * Mdiffuse * Ldiffuse;' + LineEnding +
    '    float specLight = pow(max(dot(H, N), 0.0), Mshininess);' + LineEnding +
    '    specular        = specLight * Mspecular * Lspecular;' + LineEnding +
    '  }' + LineEnding +
    '  return ambient + diffuse + specular;' + LineEnding +
    '}';
  {$else}
  LightingShader =
    'uniform vec4 Mambient;' + LineEnding +
    'uniform vec4 Mdiffuse;' + LineEnding +
    'uniform vec4 Mspecular;' + LineEnding +
    'uniform float Mshininess;' + LineEnding +     // Glanz

    'uniform vec4 Lposition;' + LineEnding +
    'uniform vec4 Lambient;' + LineEnding +    // Umgebungslicht
    'uniform vec4 Ldiffuse;' + LineEnding +    // Lichtfarbe
    'uniform vec4 Lspecular;' + LineEnding +   // Spiegelnd

    'vec4 Light(in vec3 Normal, in vec3 Position) {' + LineEnding +
    '  vec3 N       = normalize(Normal);' + LineEnding +
    '  vec4 ambient = Mambient * Lambient;' + LineEnding +

    '  vec3 L       = normalize(vec3(Lposition) - Position);' + LineEnding +
    '  vec4 Pos_eye = vec4(0.0, 0.0, 1.0, 0.0);' + LineEnding +
    '  vec3 A       = Pos_eye.xyz;' + LineEnding +
    '  vec3 H       = normalize(L + A);' + LineEnding +

    '  vec4 diffuse       = vec4(0.0, 0.0, 0.0, 1.0);' + LineEnding +
    '  vec4 specular      = vec4(0.0, 0.0, 0.0, 1.0);' + LineEnding +
    '  float diffuseLight = max(dot(N, L), 0.0);' + LineEnding +
    '  if (diffuseLight > 0.0) {' + LineEnding +
    '    diffuse         = diffuseLight * Mdiffuse * Ldiffuse;' + LineEnding +
    '    float specLight = pow(max(dot(H, N), 0.0), Mshininess);' + LineEnding +
    '    specular        = specLight * Mspecular * Lspecular;' + LineEnding +
    '  }' + LineEnding +
    '  return ambient + diffuse + specular;' + LineEnding +
    '}';
    {$endif}

var
  i: integer;

begin
  Lighting.Enabled := lightON;

  for i := 0 to Length(AShader) - 1 do begin
    if Lighting.Enabled then begin
      AShader[i] := StringReplace(AShader[i], '$light.glsl', LightingShader, [rfReplaceAll, rfIgnoreCase]) + #0;
    end else begin
      AShader[i] := StringReplace(AShader[i], '$light.glsl', noLightingShader, [rfReplaceAll, rfIgnoreCase]) + #0;
    end;
  end;

  inherited Create(AShader);

  if Lighting.Enabled then begin

    {$ifdef ubo}
    Lighting.LightUBO := TUBO.Create(self, 'Lighting', SizeOf(LightParams));
    Lighting.MaterialUBO := TUBO.Create(self, 'Material', SizeOf(MaterialParams));
    {$else}
      with Lighting.UniformID do begin
        with Light do begin
          position := UniformLocation('Lposition');
          ambient := UniformLocation('Lambient');
          diffuse := UniformLocation('Ldiffuse');
          specular := UniformLocation('Lspecular');
        end;
        with Material do begin
          ambient := UniformLocation('Mambient');
          diffuse := UniformLocation('Mdiffuse');
          specular := UniformLocation('Mspecular');
          shininess := UniformLocation('Mshininess');
        end;
      end;
    {$endif}

    SetMaterial('PlasticWhite');

    LightParams.position := vec4(200.0, 300.0, 100.0, 0.0);
    LightParams.ambient := vec4(0.8, 0.8, 0.8, 0.0);    // Umgebungslicht
    LightParams.diffuse := vec4(2.0, 2.0, 2.0, 1.0);    // Lichtfarbe
    LightParams.specular := vec4(1.0, 1.0, 1.0, 1.0);   // Spiegelnd

    UpdateLight;
  end;

end;

destructor TLightingShader.Destroy;
begin
  {$ifdef ubo}
  if Lighting.Enabled then begin
    Lighting.LightUBO.Free;
    Lighting.MaterialUBO.Free;
  end;
  {$endif}
end;

procedure TLightingShader.SetMaterial(Name: string);
var
  i: integer;
begin
  for i := 0 to Length(MaterialPara) - 1 do begin

    if Name = MaterialPara[i].Name then begin
      with MaterialParams do begin
        ambient := MaterialPara[i].ambient;
        diffuse := MaterialPara[i].diffuse;
        specular := MaterialPara[i].specular;
        shininess := MaterialPara[i].shininess;
      end;
      break;
    end;

  end;

  UpdateMaterial;
end;

procedure TLightingShader.UpdateMaterial;
begin
  if Lighting.Enabled then begin
    UseProgram;
    {$ifdef ubo}
    Lighting.MaterialUBO.UpdateBuffer(@MaterialParams, SizeOf(MaterialParams));
    {$else}
    with Lighting.UniformID.Material do begin
      glUniform4fv(ambient, 1, @MaterialParams.ambient);
      glUniform4fv(diffuse, 1, @MaterialParams.diffuse);
      glUniform4fv(specular, 1, @MaterialParams.specular);
      glUniform1f(shininess, MaterialParams.shininess);
    end;
    {$endif}
  end;
end;

procedure TLightingShader.UpdateLight;
begin
  if Lighting.Enabled then begin
    UseProgram;
    {$ifdef ubo}
    Lighting.LightUBO.UpdateBuffer(@LightParams, SizeOf(LightParams));
    {$else}
    with Lighting.UniformID.Light do begin
      glUniform4fv(position, 1, @LightParams.position);
      glUniform4fv(ambient, 1, @LightParams.ambient);
      glUniform4fv(diffuse, 1, @LightParams.diffuse);
      glUniform4fv(specular, 1, @LightParams.specular);
    end;
    {$endif}
  end;
end;

end.
