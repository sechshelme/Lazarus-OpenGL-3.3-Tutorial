unit Masse;

{$mode ObjFPC}

interface

uses
  Types, SysUtils,
  Web, BrowserConsole, WebGL, JS,
  wglCommon, wglMatrix, wglShader, wglTextur,
  ShaderSource;
type

     { TVLIMasse }

     TVLIMasse=class(TObject)
       private
           reader: TJSXMLHttpRequest;
     public
       L,C1,C2,t,
       Schienenlaenge,
       AussenD, InnenD:Single;
       anzKugeln:Integer;
       SchwimmerAussenD:Single;
       anzFluegeli:Integer;
       constructor Create;
       procedure onload;
     end;


implementation

{ TVLIMasse }

constructor TVLIMasse.Create;
begin
  inherited Create;

    reader := TJSXMLHttpRequest.New;
  reader.addEventListener('load', @onload);
  reader.Open('GET', 'data/VLIMasse.bin');
  reader.responseType := 'arraybuffer';
  reader.send(nil);
end;

procedure TVLIMasse.onload;
var
  arrayBuffer: TJSArrayBuffer;
  floatBuffer: TJSFloat32Array;
  intBuffer: TJSInt32Array;
begin
      arrayBuffer := TJSArrayBuffer( reader.response);
    Writeln('xhrlen: ',arrayBuffer.byteLength);
    floatBuffer:= TJSFloat32Array.new (arrayBuffer);
    intBuffer:= TJSInt32Array.new (arrayBuffer);

    L := floatBuffer[0];
    C1 := floatBuffer[1];
    C2 := floatBuffer[2];
    t := floatBuffer[3];

    SchienenLaenge := floatBuffer[4];
    AussenD := floatBuffer[5];
    InnenD := floatBuffer[6];
    anzKugeln := intBuffer[7];
    SchwimmerAussenD := floatBuffer[8];

    anzFluegeli := Round( SchienenLaenge / 10);
end;

end.

