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
  wglCommon,
  wglMatrix,
  wglShader,
  wglTextur;

type
  TMesh_Buffers = (mbVBOQuadVektor, mbVBOTexCoord, mbUBO);

  TImage = record
    Width, Height: integer;
    Data: TJSUint8Array;
  end;

var
  shader: TShader = nil;
  modelMatrix: TMatrix;
  modelMatrix_ID: TJSWebGLUniformLocation;
  pos_ID: TJSWebGLUniformLocation;

  myTextur0, myTextur1: TTextur;

  canvas: TJSHTMLCanvasElement;

  Mesh_Buffers: array [TMesh_Buffers] of TJSWebGLBuffer;

  vertexShaderSource: string = '';
  fragmentShaderSource: string = '';
  xhrVert, xhrFrag: TJSXMLHttpRequest;

const
  QuadVertex: array of GLfloat = (
    -0.8, -0.8, 0.0, 0.8, 0.8, 0.0, -0.8, 0.8, 0.0,
    -0.8, -0.8, 0.0, 0.8, -0.8, 0.0, 0.8, 0.8, 0.0);

  TextureVertex: array of GLfloat = (
    0.0, 1.0, 1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 1.0, 1.0, 1.0, 0.0);

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

  function CreateTexture: TImage;
  const
    size = 16;
  var
    i: integer;
  begin
    Result.Width := size;
    Result.Height := size;
    Result.Data := TJSUint8Array.new(size * size * 4);

    for i := 0 to size * size * 4 - 1 do begin
      Result.Data[i] := Random($FF);
    end;
  end;

  // https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Using_textures_in_WebGL?retiredLocale=de
  procedure CreateScene;
  var
    Panel, img: TJSElement;
  begin
    // --- Canvas erstellen
    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
    canvas.Width := 640;
    canvas.Height := 480;
    document.body.appendChild(canvas);

    Panel := document.createElement('div');
    Panel['class'] := 'panel panel-default';
    document.body.appendChild(Panel);

    myTextur0 := TTextur.Create('examples.ico');
    myTextur1 := TTextur.Create('image.png');

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
    // Quad
    Mesh_Buffers[mbVBOQuadVektor] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(QuadVertex), gl.STATIC_DRAW);

    Mesh_Buffers[mbVBOTexCoord] := gl.createBuffer;
    gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTexCoord]);
    gl.bufferData(gl.ARRAY_BUFFER, InitVertexData(TextureVertex), gl.STATIC_DRAW);

    gl.bindBuffer(gl.ARRAY_BUFFER, nil);
  end;

  procedure UpdateCanvas(time: TJSDOMHighResTimeStamp);
  var
    im: TJSHTMLImageElement;
  begin
    if shader = nil then begin
      if (vertexShaderSource <> '') and (fragmentShaderSource <> '') then begin
        shader := TShader.Create;
        shader.LoadShaderObject(gl.VERTEX_SHADER, vertexShaderSource);
        shader.LoadShaderObject(gl.FRAGMENT_SHADER, fragmentShaderSource);
        shader.LinkProgram;
        shader.UseProgram;

        modelMatrix_ID := shader.UniformLocation('viewTransform');
        pos_ID := shader.UniformLocation('pos');

        modelMatrix.Indenty;
        modelMatrix.Scale(0.5, 0.5, 1.0);
      end;
    end else begin
      modelMatrix.RotateC(0.03);
      modelMatrix.Uniform(modelMatrix_ID);

      gl.Clear(gl.COLOR_BUFFER_BIT);

      // --- Quad links
      myTextur0.activateAndBin(0);

      gl.uniform1f(pos_ID, -0.5);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
      gl.enableVertexAttribArray(0);
      gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTexCoord]);
      gl.enableVertexAttribArray(1);
      gl.vertexAttribPointer(1, 2, gl.FLOAT, False, 0, 0);

      gl.drawArrays(gl.TRIANGLES, 0, 6);

      // --- Quad rechts
      myTextur1.activateAndBin(0);

      gl.uniform1f(pos_ID, 0.5);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOQuadVektor]);
      gl.enableVertexAttribArray(0);
      gl.vertexAttribPointer(0, 3, gl.FLOAT, False, 0, 0);

      gl.bindBuffer(gl.ARRAY_BUFFER, Mesh_Buffers[mbVBOTexCoord]);
      gl.enableVertexAttribArray(1);
      gl.vertexAttribPointer(1, 2, gl.FLOAT, False, 0, 0);

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
