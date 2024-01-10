unit wglTextur;

{$mode ObjFPC}

interface

uses
  Types, SysUtils, Web,
  BrowserConsole, WebGL, JS,
  wglCommon;

type
  TTextur = class(TObject)
  private
    FID: TJSWebGLTexture;
    FFileName: string;
  public
    constructor Create(AFilename: string);
    destructor Destroy; override;
    procedure activateAndBind(nr: GLint);
  end;

implementation

constructor TTextur.Create(AFilename: string);
var
  img: TJSElement;
begin
  inherited Create;
  FFileName := AFilename;
  FID := nil;

  img := document.createElement('img');
  img['id'] := AFilename;
  img['src'] := AFilename;
  img['style'] := 'display: none;';
  document.body.appendChild(img);
end;

destructor TTextur.Destroy;
begin
  if FID <> nil then  begin
    gl.deleteTexture(FID);
  end;
  inherited Destroy;
end;

procedure TTextur.activateAndBind(nr: GLint);
var
  im: TJSHTMLImageElement;
begin
  if FID = nil then begin
    im := TJSHTMLImageElement(document.getElementById(FFileName));
    if im.Width > 0 then begin
      FID := gl.createTexture;
      gl.bindTexture(gl.TEXTURE_2D, FID);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, im);
    end;
  end else begin
    gl.activeTexture(gl.TEXTURE0 + nr);
    gl.bindTexture(gl.TEXTURE_2D, FID);
  end;
end;

end.
