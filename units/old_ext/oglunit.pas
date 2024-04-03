unit oglUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, Graphics, SysUtils, Controls, Dialogs, Forms,
  OpenGLContext,
  oglglad_gl,
  oglVector, oglMatrix, oglTextur,
  oglCamera, oglVAO, oglSteuerung;

type

  { TBuffer }

  TBuffer = class(TObject)
  protected
    FWidth, FHeight: GLint;
    FBkColor: TVector4f;
    FrontFace: boolean;
    procedure SetBkColor(col: TVector4f);
  public
    Camera: TCamera;
    property Width: GLint read FWidth;
    property Height: GLint read FHeight;
    property BkColor: TVector4f read FBkColor write SetBkColor;

    constructor Create;
    destructor Destroy; override;
    procedure AlphaBlending(Blending: boolean = True);
    function BkColorRGB: TColor;
    procedure Clear;
    procedure Resize(AWidth, AHeight: GLint);
    procedure SwapFrontFace;
  end;

  { TOpenGL }

  TOpenGL = class(TBuffer)
  private
    OpenGLControl: TOpenGLControl;

    procedure MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure MyMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
  public
    constructor Create(Form: TWinControl; MajorVersion: Cardinal=3; MinorVersion: Cardinal=3; Msampling: Cardinal=1);
    destructor Destroy; override;
    procedure SwapBuffers;
    procedure Clear;
    function GetVersion: string;
  end;

  { TRenderTexturBuffer }

  TRenderTexturBuffer = class(TBuffer)
  private
    FTexturBuffer: TTexturBuffer;
    // Render Bufffer
    FramebufferName, depthrenderbuffer: GLint;

  public
    property TexturBuffer: TTexturBuffer read FTexturBuffer;

    constructor Create(AWidth, AHeight: GLint);
    destructor Destroy; override;
    procedure Resize(AWidth: GLint = 1024; AHeight: GLint = 1024);
    procedure Clear;
  end;


implementation


{ TBuffer }

procedure TBuffer.SetBkColor(col: TVector4f);
var
  i: GLint;
begin
  FBkColor := col;
  for i := 0 to 3 do begin
    if FBKColor[i] < 0.0 then begin
      FBkColor[i] := 0.0;
    end;
    if FBKColor[i] > 1.0 then begin
      FBkColor[i] := 1.0;
    end;
  end;
end;

constructor TBuffer.Create;
begin
  inherited Create;
  Camera := TCamera.Create;
  BkColor := vec4(0.3, 0.0, 0.0, 1.0);
end;

destructor TBuffer.Destroy;
begin
  Camera.Free;
  inherited Destroy;
end;

procedure TBuffer.AlphaBlending(Blending: boolean);
begin
  if Blending then begin
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  end else begin
    glDisable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ZERO);
  end;
end;

function TBuffer.BkColorRGB: TColor;
begin
  Result := FBkColor.ToInt;
end;

procedure TBuffer.Clear;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor(FBkColor[0], FBkColor[1], FBkColor[2], FBkColor[3]);

  // Tiefenbuffer aktivieren
  glEnable(GL_DEPTH_TEST);
  // Legt die Tiefenvergleichsfunktion fest
  glDepthFunc(GL_LESS);

  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

  FrontFace := True;
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  AlphaBlending(True);

  glViewport(0, 0, FWidth, FHeight);
  TVAO.Camera := Camera;
end;

procedure TBuffer.Resize(AWidth, AHeight: GLint);
begin
  FWidth := AWidth;
  FHeight := AHeight;
end;

procedure TBuffer.SwapFrontFace;
begin
  FrontFace := not FrontFace;
  if FrontFace then begin
    glFrontFace(GL_CCW);
  end else begin
    glFrontFace(GL_CW);
  end;
end;


{ TOpenGL }

procedure TOpenGL.MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  Camera.MouseMove(Shift, X, Y);
end;

procedure TOpenGL.MyMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  Camera.MouseWheel(WheelDelta);
end;

constructor TOpenGL.Create(Form: TWinControl; MajorVersion: Cardinal = 3; MinorVersion: Cardinal = 3; Msampling: Cardinal = 1);
begin
  inherited Create;

  // --- Context erzeugen, funktioniert auch mit Linux

  OpenGLControl := TOpenGLControl.Create(Form);

  with OpenGLControl do begin
    Name := 'OpenGLControl';
    Parent := Form;
    Align := alClient;
    //    Enabled := False;              // Deaktiviert sämtliche Events, Tastatur und Maus
    OpenGLMajorVersion := MajorVersion;
    OpenGLMinorVersion := MinorVersion;

    MultiSampling := Msampling;

    OnMouseWheel := @MyMouseWheel;
    OnMouseMove := @MyMouseMove;


//    InitOpenGL;
    MakeCurrent;
    Load_GLADE;
//    ReadExtensions;
//    ReadImplementationProperties;
  end;

  TCameraSteuerung.Camera := Camera;
end;

destructor TOpenGL.Destroy;
begin
  inherited Destroy;
  FreeAndNil(OpenGLControl);
end;

procedure TOpenGL.SwapBuffers;
begin
  OpenGLControl.SwapBuffers;
end;

procedure TOpenGL.Clear;
begin
  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  inherited Clear;
end;

function TOpenGL.GetVersion: string;
begin
  Result :=
    'GL_VENDOR: ' +PChar( glGetString(GL_VENDOR)) + #13#10#13#10 +
    'GL_RENDERER: ' +PChar( glGetString(GL_RENDERER)) + #13#10#13#10 +
    'GL_VERSION: ' + PChar(glGetString(GL_VERSION)) + #13#10#13#10 +
    'GL_SHADING_LANGUAGE_VERSION: ' +PChar( glGetString(GL_SHADING_LANGUAGE_VERSION)) + #13#10#13#10;
  //    'GL_EXTENSIONS: ' + glGetString(GL_EXTENSIONS);
end;

{ TRenderTexturBuffer }

constructor TRenderTexturBuffer.Create(AWidth, AHeight: GLint);
begin
  inherited Create;
  FTexturBuffer := TTexturBuffer.Create;
  FWidth := AWidth;
  FHeight := AHeight;

  TexturBuffer.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  TexturBuffer.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  TexturBuffer.LoadTextures(AWidth, AHeight);

  // Render Buffer erzeugen

  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);
  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, FWidth, FHeight);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, TexturBuffer.ID, 0);
end;

destructor TRenderTexturBuffer.Destroy;
begin
  TexturBuffer.Free;

  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);

  inherited Destroy;
end;

procedure TRenderTexturBuffer.Resize(AWidth: GLint; AHeight: GLint);
begin
  inherited Resize(AWidth, AHeight);
  TexturBuffer.LoadTextures(AWidth, AHeight);
end;

procedure TRenderTexturBuffer.Clear;
begin
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  inherited Clear;
end;

end.
