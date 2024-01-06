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
  GLUtils,
  GLTypes,
  WebGL,
  Math,
  wglShader,
  wglMatrix;

type
  TMesh_Buffers = (mbVBOTriangleVector, mbVBOTriangleColor, mbVBOQuadVektor, mbVBOQuadColor, mbUBO);

var
  shader: TShader = nil;
  viewTransform: TMatrix;
  modelMatrix_ID: TJSWebGLUniformLocation;

  canvas: TJSHTMLCanvasElement;

  Mesh_Buffers: array [TMesh_Buffers] of TJSWebGLBuffer;

  vertexShaderSource: string = '';
  fragmentShaderSource: string = '';
  xhrVert, xhrFrag: TJSXMLHttpRequest;

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

  function InitVertexData(va: array of GLfloat): TJSUInt8Array;
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

  procedure CreateScene;
  begin
    // --- Canvas erstellen
    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
    canvas.Width := 640;
    canvas.Height := 480;
    document.body.appendChild(canvas);

    // --- WebGl Context erstellen
    gl := TJSWebGLRenderingContext(canvas.getContext('webgl2'));
    if gl = nil then begin
      writeln('Konnte WebGL Context nicht erstellen !');
    end;

    // --- GL-Parameter
    gl.clearColor(0.3, 0.0, 0.0, 1);
    gl.viewport(0, 0, canvas.Width, canvas.Height);
    gl.Clear(gl.COLOR_BUFFER_BIT);

    // --- Create VBO-Buffer
    // Triangle
    Mesh_Buffers[mbVBOTriangleVector] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleVector]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(TriangleVector), gl.STATIC_DRAW);

    Mesh_Buffers[mbVBOTriangleColor] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleColor]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(TriangleColor), gl.STATIC_DRAW);

    // Quad
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
    if shader = nil then begin
      if (vertexShaderSource <> '') and (fragmentShaderSource <> '') then begin
        shader := TShader.Create;
        shader.LoadShaderObject(gl.VERTEX_SHADER, vertexShaderSource);
        shader.LoadShaderObject(gl.FRAGMENT_SHADER, fragmentShaderSource);
        shader.LinkProgram;
        shader.UseProgram;

        modelMatrix_ID := shader.UniformLocation('viewTransform');
        viewTransform.Indenty;
      end;
    end else begin
      viewTransform.RotateC(0.03);
      viewTransform.Uniform(modelMatrix_ID);

      gl.Clear(gl.COLOR_BUFFER_BIT);

      // --- Triangle
      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleVector]);
      gl.enableVertexAttribArray(0);
      gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTriangleColor]);
      gl.enableVertexAttribArray(1);
      gl.vertexAttribPointer(1, 3, gl.FLOAT, False, 0, 0);

      gl.drawArrays(gl.TRIANGLES, 0, 3);

      // --- Quad
      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
      gl.enableVertexAttribArray(0);
      gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadColor]);
      gl.enableVertexAttribArray(1);
      gl.vertexAttribPointer(1, 3, gl.FLOAT, False, 0, 0);

      gl.drawArrays(gl.TRIANGLES, 0, 6);
    end;

    window.requestAnimationFrame(@UpdateCanvas);
  end;

  procedure vertexLoad(Event: TEventListenerEvent);
  begin
    if (xhrVert.status = 200) then  begin
      vertexShaderSource := xhrVert.responseText;
    end;
  end;

  procedure fragmentLoad(Event: TEventListenerEvent);
  begin
    if (xhrFrag.status = 200) then  begin
      fragmentShaderSource := xhrFrag.responseText;
    end;
  end;

begin
  Writeln('WebGL Demo');

  xhrVert := TJSXMLHttpRequest.New;
  xhrVert.addEventListener('load', @vertexLoad);
  xhrVert.Open('GET', 'vertex.glsl');
  xhrVert.send;

  xhrFrag := TJSXMLHttpRequest.New;
  xhrFrag.responseType := 'text';
  xhrFrag.addEventListener('load', @fragmentLoad);
  xhrFrag.Open('GET', 'fragment.glsl');
  xhrFrag.send;

  CreateScene;
  window.requestAnimationFrame(@UpdateCanvas);
end.
