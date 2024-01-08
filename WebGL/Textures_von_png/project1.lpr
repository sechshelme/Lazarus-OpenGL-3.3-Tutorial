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
  wglShader;

type
  TMesh_Buffers = (mbVBOQuadVektor, mbVBOTexCoord, mbUBO);

  TImage = record
    Width, Height: integer;
    Data: TJSUint8Array;
  end;

var
  shader: TShader = nil;
  viewTransform: TMatrix;
  modelMatrix_ID: TJSWebGLUniformLocation;
  textureID: TJSWebGLTexture = nil;

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

    //<div style="display: none;">
    //  <img id="ghost1" src="ghost1.png"/>
    //  <img id="ghost2" src="ghost2.png"/>
    //  <img id="ghost3" src="ghost3.png"/>
    //  <img id="ghost4" src="ghost4.png"/>
    //</div>
    //


    Panel := document.createElement('div');
    Panel['class'] := 'panel panel-default';
    document.body.appendChild(Panel);

    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';
    img['style'] := 'display: none;';

    document.body.appendChild(img);

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
    he: TJSHTMLElement;
    im: TJSHTMLImageElement;
  begin
    if textureID = nil then begin
      he := TJSHTMLElement(document.getElementById('image'));
      im := TJSHTMLImageElement(he);
      if im.Width > 0 then begin
        textureID := gl.createTexture;
        gl.bindTexture(gl.TEXTURE_2D, textureID);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, im);
        gl.bindTexture(gl.TEXTURE_2D, nil);
      end;
    end;

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
    end;

    if (shader <> nil) and (textureID <> nil) then begin
      viewTransform.RotateC(0.03);
      viewTransform.Uniform(modelMatrix_ID);

      gl.Clear(gl.COLOR_BUFFER_BIT);

      // --- Quad
      gl.bindTexture(gl.TEXTURE_2D, textureID);

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
