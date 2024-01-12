program project1;

{$mode objfpc}
{$modeswitch typehelpers}

uses
  browserconsole,
  browserapp,
  JS,
  Classes,
  SysUtils,
  Web,
  WebGL,
  Math,
  wglCommon,
  wglShader,
  wglMatrix;

type

  { TWebOpenGL }

  TWebOpenGL = class(TObject)
    constructor Create;
    procedure CreateScene;
    function InitVertexData(va: array of GLfloat): TJSUInt8Array;
    procedure Run;
  private
    function ButtonClick(aEvent: TJSMouseEvent): boolean;
  end;

  function Tan(const A : Double): Double; external name 'Math.tan';


var
  shader: TShader;
  proMatrix, modelMatrix: TMatrix;

  modelMatrix_ID, proMatrix_ID: TJSWebGLUniformLocation;

  canvas: TJSHTMLCanvasElement;

const
  Vector: array of double =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

type
  TMesh_Buffers = (mbVBOTriangleVector, mbVBOTriangleColor, mbVBOQuadVektor, mbVBOQuadColor, mbUBO);
  TDirections = (dLeft, dRight, dTop, dBottom);

var
  Mesh_Buffers: array [TMesh_Buffers] of TJSWebGLBuffer;

  // /home/tux/fpcupdeluxe_trunk/ccr/pas2js-rtl/demo/rtl/democanvas2d.pas
  // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/button

  constructor TWebOpenGL.Create;
  var
    ButtonLeft, Panel, ButtonRight, ButtonTop, ButtonBottom, Label1,
    Label2, img: TJSElement;

    function ButtonInit(const titel: string): TJSElement;
    begin
      Result := document.createElement('input');
      Result['id'] := titel;
      Result['class'] := 'favorite styled';
      Result['type'] := 'button';
      Result['value'] := titel;
      Panel.appendChild(Result);
    end;

  begin
    Panel := document.createElement('div');
    Panel['class'] := 'panel panel-default';
    document.body.appendChild(Panel);

    ButtonLeft := ButtonInit('X-');
    TJSHTMLElement(ButtonLeft).onclick := @ButtonClick;

    ButtonRight := ButtonInit('X+');
    TJSHTMLElement(ButtonRight).onclick := @ButtonClick;

    ButtonTop := ButtonInit('Y+');
    TJSHTMLElement(ButtonTop).onclick := @ButtonClick;

    ButtonBottom := ButtonInit('Y-');
    TJSHTMLElement(ButtonBottom).onclick := @ButtonClick;

    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
    canvas.Width := 640;
    canvas.Height := 480;
    document.body.appendChild(canvas);

    gl := TJSWebGLRenderingContext(canvas.getContext('webgl2'));
    if gl = nil then begin
      writeln('failed to load webgl!');
      exit;
    end;

  end;

const
  TriangleVector: array of GLfloat =
    (-0.4, 0.1, 0.0, 0.4, 0.1, 0.0, 0.0, 0.7, 0.0);
  TriangleColor: array of GLfloat =
    (1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0);

  QuadVector: array of GLfloat =
    (-0.2, -0.6, 0.0, -0.2, -0.1, 0.0, 0.2, -0.1, 0.0,
    -0.2, -0.6, 0.0, 0.2, -0.1, 0.0, 0.2, -0.6, 0.0);
  QuadColor: array of GLfloat =
    (1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0,
    1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0);

  function TWebOpenGL.InitVertexData(va: array of GLfloat): TJSUInt8Array;
  var
    floatBuffer: TJSFloat32Array;
    byteBuffer: TJSUint8Array;

  begin
    byteBuffer := TJSUint8Array.New(Length(va) * 4);
    floatBuffer := TJSFloat32Array.New(byteBuffer.buffer, 0, Length(va));
    floatBuffer._set(va, 0);

    Result := byteBuffer;
  end;

  // https://webgl2fundamentals.org/webgl/lessons/webgl-shaders-and-glsl.html
  // https://gist.github.com/jialiang/2880d4cc3364df117320e8cb324c2880

  procedure TWebOpenGL.CreateScene;
  var
    vertexShaderSource, fragmentShaderSource: string;

  begin
    vertexShaderSource :=
      '#version 300 es' + #10 +

      'precision highp float;' + #10 +

      'layout(location = 0) in vec3 inPos;' + #10 +
      'layout(location = 1) in vec3 inCol;' + #10 +

      'uniform mat4 proMatrix;' + #10 +
      'uniform mat4 modelMatrix;' + #10 +

      'out vec3 col;' + #10 +

      'void main(){' + #10 +
      '  gl_Position = proMatrix * modelMatrix * vec4(inPos, 1.0);' + #10 +
      '  col = inCol;}';

    fragmentShaderSource :=
      '#version 300 es' + #10 +

      'precision highp float;' + #10 +

      'in vec3 col;' + #10 +

      'out vec4 outCol;' + #10 +
      'void main(void){' + #10 +
      '  outCol = vec4(col, 1.0); }';


    shader := TShader.Create;
    shader.LoadShaderObject(gl.VERTEX_SHADER, vertexShaderSource);
    shader.LoadShaderObject(gl.FRAGMENT_SHADER, fragmentShaderSource);
    shader.LinkProgram;

    proMatrix_ID := shader.UniformLocation('proMatrix');
    modelMatrix_ID := shader.UniformLocation('modelMatrix');

    shader.UseProgram;

    // prepare context
    gl.clearColor(0.3, 0.0, 0.0, 1);
    gl.viewport(0, 0, canvas.Width, canvas.Height);
    gl.Clear(gl.COLOR_BUFFER_BIT);

    // setup transform matricies
    proMatrix.Identity;
    modelMatrix.Identity;

    // --- Create Triangle Buffer
    Mesh_Buffers[mbVBOTriangleVector] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleVector]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(TriangleVector), gl.STATIC_DRAW);

    Mesh_Buffers[mbVBOTriangleColor] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleColor]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(TriangleColor), gl.STATIC_DRAW);

    // --- Create Quad Buffer
    Mesh_Buffers[mbVBOQuadVektor] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(QuadVector), gl.STATIC_DRAW);

    Mesh_Buffers[mbVBOQuadColor] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadColor]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(QuadColor), gl.STATIC_DRAW);

    gl.bindBuffer(gl.ARRAY_BUFFER, nil);
  end;

  procedure UpdateCanvas(time: TJSDOMHighResTimeStamp);
  begin
    modelMatrix.RotateC(0.03);
    modelMatrix.Uniform(modelMatrix_ID);

    proMatrix.Uniform(proMatrix_ID);

    gl.Clear(gl.COLOR_BUFFER_BIT);

    // --- Triangle
    // position
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleVector]);
    gl.enableVertexAttribArray(0);
    gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);
    // color
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleColor]);
    gl.enableVertexAttribArray(1);
    gl.vertexAttribPointer(1, 3, gl.FLOAT, False, 0, 0);

    gl.drawArrays(gl.TRIANGLES, 0, 3);

    // --- Quad
    // position
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
    gl.enableVertexAttribArray(0);
    gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);
    // color
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadColor]);
    gl.enableVertexAttribArray(1);
    gl.vertexAttribPointer(1, 3, gl.FLOAT, False, 0, 0);

    gl.drawArrays(gl.TRIANGLES, 0, 6);

    window.requestAnimationFrame(@UpdateCanvas);
  end;

  procedure TWebOpenGL.Run;
  begin
    window.requestAnimationFrame(@UpdateCanvas);
  end;

  function TWebOpenGL.ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    id: JSValue;
  begin
//Writeln(    aEvent.target.Properties['type']);
    id := aEvent.target.Properties['id'];
    if id = 'X-' then  begin
      proMatrix.Translate(-0.1, 0, 0);
    end;
    if id = 'X+' then  begin
      proMatrix.Translate(0.1, 0, 0);
    end;
    if id = 'Y-' then  begin
      proMatrix.Translate(0, -0.1, 0);
    end;
    if id = 'Y+' then  begin
      proMatrix.Translate(0, 0.1, 0);
    end;
    Result := True;
  end;

var
  MyApp: TWebOpenGL;

begin
  Writeln('WebGL Demo');
  MyApp := TWebOpenGL.Create;

  MyApp.CreateScene;
  MyApp.Run;

  MyApp.Free;
end.
