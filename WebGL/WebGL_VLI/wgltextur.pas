unit wglTextur;

{$mode ObjFPC}

interface

uses
  Types, SysUtils,
  BrowserConsole, WebGL, JS,
  wglCommon, wglMatrix;

type

  { TTextur }

  TTextur = class(TObject)
  private
    id: TJSWebGLTexture;
    image: TexImageSource;
    procedure onload;
  public
    constructor Create(sFilename: string);
    procedure activateAndBin(nr:GLint);
  end;

implementation

{ TTextur }

procedure TTextur.onload;
begin

end;

constructor TTextur.Create(sFilename: string);
begin
  inherited Create;

  image.src;

  image:=TexImageSource;

  id := gl.createTexture;
  gl.bindTexture(gl.TEXTURE_2D,id);
  gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, 0);
  gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image);
  gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
  gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
  gl.bindTexture(gl.TEXTURE_2D, nil);
end;

procedure TTextur.activateAndBin(nr: GLint);
begin
  gl.activeTexture(gl.TEXTURE0 + nr);
  gl.bindTexture(gl.TEXTURE_2D, id);
end;

end.
