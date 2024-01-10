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
  wglShader,
  wglMatrix,
  wglVAO,
  wglTextur,
  ShaderSource,
  Masse;

var
  canvas: TJSHTMLCanvasElement;

  VLIMasse: TVLIMasse;

  BackGroundBuffer: TVAOTextur;
  GlobusBuffer: TVAOBumpMapingTextur;

  WorldAllTextur,
  GlobusTextur,
  GlobusNormal,
  CloudsTextur,
  CloudsNormal: TTextur;

  FluegeliBuffer,
  InnenProfilBuffer,
  InnenProfilSchnittBuffer,

  ProcessFlanschSchnittBuffer,
  ProcessFlanschBuffer,
  RohrFlanschSchnittBuffer,
  RohrFlanschBuffer,
  StutzenSchnittBuffer,
  StutzenBuffer,
  StandRohrSchnittBuffer,
  StandRohrBuffer,
  SchwimmerSchnittBuffer,
  SchwimmerBuffer,

  DichtungProcessFlanschSchnittBuffer,
  DichtungProcessFlanschBuffer,
  DichtungRohrFlanschSchnittBuffer,
  DichtungRohrFlanschBuffer,

  WasserUntenBuffer,
  WasserSchwimmerSchnittBuffer,
  WasserSchwimmerBuffer: TVAOMonoColor;

  isFrontFace: boolean = False;


  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    id: JSValue;
  begin
    //Writeln(    aEvent.target.Properties['type']);
    id := aEvent.target.Properties['id'];
    if id = 'X-' then  begin
      //      proMatrix.Translate(-0.1, 0, 0);
    end;
    if id = 'X+' then  begin
      //      proMatrix.Translate(0.1, 0, 0);
    end;
    if id = 'Y-' then  begin
      //      proMatrix.Translate(0, -0.1, 0);
    end;
    if id = 'Y+' then  begin
      //      proMatrix.Translate(0, 0.1, 0);
    end;
    Result := True;
  end;

  procedure Create;
  var
    ButtonLeft, Panel, ButtonRight, ButtonTop, ButtonBottom: TJSElement;

    function ButtonInit(const titel: string): TJSElement;
    begin
      Result := document.createElement('input');
      Result['id'] := titel;
      Result['class'] := 'favorite styled';
      Result['type'] := 'button';
      Result['value'] := titel;
      Result['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
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

    // Context einrichten
    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
    canvas.Width := 800;
    canvas.Height := 800;
    document.body.appendChild(canvas);

    gl := TJSWebGLRenderingContext(canvas.getContext('webgl2'));
    if gl = nil then begin
      writeln('failed to load webgl!');
      exit;
    end;

    // WebGl Standard Parameter
    gl.clearColor(0.0, 0.0, 0.0, 1.0);
    gl.clearDepth(1.0); // Die gesamte Tiefe des Bildes soll gelöscht werden

    gl.enable(gl.DEPTH_TEST);
    //    gl.depthFunc(gl.LEQUAL);
    gl.depthFunc(gl.LESS);

    gl.enable(gl.CULL_FACE);
    gl.cullFace(gl.BACK);

    gl.enable(gl.BLEND);
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);

    gl.viewport(0, 0, canvas.Width, canvas.Height);

    // --- VLIMasse
    VLIMasse := TVLIMasse.Create;

    // --- HinterGrund inizialisieren
    BackGroundBuffer := TVAOTextur.Create('BackGround');
    WorldAllTextur := TTextur.Create('data/all.jpg');

    // --- Globus inizialisieren
    GlobusBuffer := TVAOBumpMapingTextur.Create('Earth');
    GlobusTextur := TTextur.Create('data/earth_textur.jpg');
    GlobusNormal := TTextur.Create('data/earth_normal.jpg');
    CloudsTextur := TTextur.Create('data/clouds_textur.png');
    CloudsNormal := TTextur.Create('data/clouds_normal.jpg');

    // --- VLI
    FluegeliBuffer := TVAOMonoColor.Create('Fluegeli');
    InnenProfilBuffer := TVAOMonoColor.Create('InnenProfil');
    InnenProfilSchnittBuffer := TVAOMonoColor.Create('InnenProfilSchnitt');

    ProcessFlanschSchnittBuffer := TVAOMonoColor.Create('ProcessFlanschSchnitt');
    ProcessFlanschBuffer := TVAOMonoColor.Create('ProcessFlansch');
    RohrFlanschSchnittBuffer := TVAOMonoColor.Create('RohrFlanschSchnitt');
    RohrFlanschBuffer := TVAOMonoColor.Create('RohrFlansch');
    StutzenSchnittBuffer := TVAOMonoColor.Create('StutzenSchnitt');
    StutzenBuffer := TVAOMonoColor.Create('Stutzen');
    StandRohrSchnittBuffer := TVAOMonoColor.Create('StandRohrSchnitt');
    StandRohrBuffer := TVAOMonoColor.Create('StandRohr');
    SchwimmerSchnittBuffer := TVAOMonoColor.Create('SchwimmerSchnitt');
    SchwimmerBuffer := TVAOMonoColor.Create('Schwimmer');

    DichtungProcessFlanschSchnittBuffer := TVAOMonoColor.Create('DichtungProcessFlanschSchnitt');
    DichtungProcessFlanschBuffer := TVAOMonoColor.Create('DichtungProcessFlansch');
    DichtungRohrFlanschSchnittBuffer := TVAOMonoColor.Create('DichtungRohrFlanschSchnitt');
    DichtungRohrFlanschBuffer := TVAOMonoColor.Create('DichtungRohrFlansch');

    WasserUntenBuffer := TVAOMonoColor.Create('WasserUnten');
    WasserSchwimmerSchnittBuffer := TVAOMonoColor.Create('WasserSchwimmerSchnitt');
    WasserSchwimmerBuffer := TVAOMonoColor.Create('WasserSchwimmer');

    mProjectionMatrix.Perspective(30, 1.0, 0.1, 100.0);
    mProjectionMatrix.Translate(0, -0.4, -5);
    mProjectionMatrix.Scale(0.004);

  end;

  procedure drawBackGround;
  var
    dummyMatrix, rotMatrix: TMatrix;
  begin
    // Sternenhimmel
    dummyMatrix := WorldMatrix;
    rotMatrix.Identity;

    WorldMatrix.Identity;
    WorldMatrix.Scale(1, 1, -1);

    ObjectMatrix.Identity;

    BackGroundBuffer.draw(WorldAllTextur);

    // Globus
    WorldMatrix.Identity;
    WorldMatrix.Translate(0.0, 0.0, 0.985);
    WorldMatrix.Scale(1.5, 1.5, 0.01);

    GlobusMatrix.RotateB(-0.005);
    ObjectMatrix := MatrixMultiple(rotMatrix, GlobusMatrix);
    GlobusBuffer.draw(GlobusTextur, GlobusNormal);

    // Wolken
    CloudsMatrix.RotateB(-0.0059);
    ObjectMatrix := MatrixMultiple(rotMatrix, CloudsMatrix);
    WorldMatrix.Translate(0.0, 0.0, -0.1);
    GlobusBuffer.draw(CloudsTextur, CloudsNormal);

    WorldMatrix := dummyMatrix;
  end;

  procedure SwapFrontFace;
  begin
    isFrontFace := not isFrontFace;
    if not isFrontFace then begin
      gl.frontFace(gl.CCW);
    end else begin
      gl.frontFace(gl.CW);
    end;
  end;

  procedure DrawElement(Koerper, Schnitt: TVAOMonoColor; geschnitten: boolean);
  begin
    Koerper.draw;
    if geschnitten then begin
      if Schnitt <> nil then begin
        Schnitt.draw;
      end else
    end else begin
      ObjectMatrix.Scale(-1, 1, 1);
      SwapFrontFace;
      Koerper.draw;
      SwapFrontFace;
    end;
  end;

  procedure RenderScene(OMatrix: TMatrix);
  begin
    WorldMatrix := OMatrix;
    ObjectMatrix.Identity;

    // ===== Flügeli


    // ===== Innenprofil
    ObjectMatrix.Translate(0, 0, VLIMasse.AussenD / 2);
    DrawElement(InnenProfilBuffer, InnenProfilSchnittBuffer, Geschnitten);
    ObjectMatrix.Identity;

    // =====  StandRohr
    DrawElement(StandRohrBuffer, StandRohrSchnittBuffer, Geschnitten);

    // =====  Stutzen unten
    DrawElement(StutzenBuffer, StutzenSchnittBuffer, Geschnitten);

    // =====  Stutzen oben
    ObjectMatrix.Translate( [0.0, vliMasse.L, 0.0]);
    DrawElement(StutzenBuffer, StutzenSchnittBuffer, Geschnitten);

    // =====  ProcessFlansch unten
     ObjectMatrix.Translate( [0.0, 0.0, -vliMasse.t]);
     ObjectMatrix.RotateA( PI / 2);
     DrawElement(ProcessFlanschBuffer, ProcessFlanschSchnittBuffer, Geschnitten);

     // =====  ProcessFlansch oben
     ObjectMatrix.Translate( [0.0, vliMasse.L, -vliMasse.t]);
     ObjectMatrix.RotateA(PI / 2);
     DrawElement(ProcessFlanschBuffer, ProcessFlanschSchnittBuffer, Geschnitten);

     // =====  RohrFlansch unten
     ObjectMatrix.Translate( [0.0, -vliMasse.C1, 0.0]);
     DrawElement(RohrFlanschBuffer, RohrFlanschSchnittBuffer, Geschnitten);

     // =====  RohrFlansch oben
     ObjectMatrix.Translate( [0.0, vliMasse.L + vliMasse.C2, 0.0]);
     ObjectMatrix.RotateA(PI);
     DrawElement(RohrFlanschBuffer, RohrFlanschSchnittBuffer, Geschnitten);

     // =====  DichtungProcessFlansch unten
     ObjectMatrix.Translate( [0.0, 0.0, -vliMasse.t - 2.0]);
     ObjectMatrix.RotateA(PI / 2);
     DrawElement(DichtungProcessFlanschBuffer, DichtungProcessFlanschSchnittBuffer, Geschnitten);

     // =====  DichtungProcessFlansch oben
     ObjectMatrix.Translate( [0.0, vliMasse.L, -vliMasse.t - 2.0]);
     ObjectMatrix.RotateA(PI / 2);
     DrawElement(DichtungProcessFlanschBuffer, DichtungProcessFlanschSchnittBuffer, Geschnitten);

     // =====  DichtungRohrFlansch unten
     ObjectMatrix.Translate([0.0, -vliMasse.C1 - 2.0, 0.0]);
     DrawElement(DichtungRohrFlanschBuffer, DichtungRohrFlanschSchnittBuffer, Geschnitten);

     // =====  DichtungRohrFlansch oben
     ObjectMatrix.Translate( [0.0, vliMasse.L + vliMasse.C2 + 2.0, 0.0]);
     ObjectMatrix.RotateA(PI);
     DrawElement(DichtungRohrFlanschBuffer, DichtungRohrFlanschSchnittBuffer, Geschnitten);

  end;

  procedure UpdateCanvas(time: TJSDOMHighResTimeStamp);
  var
    scretch: TMatrix;
  begin
    gl.Clear(gl.COLOR_BUFFER_BIT or gl.DEPTH_BUFFER_BIT);
    gl.clearColor(0.7,0.5,0.2,1.0);

    drawBackGround;

    scretch := MatrixMultiple(mProjectionMatrix, mRotationMatrix);
    RenderScene(scretch);

    window.requestAnimationFrame(@UpdateCanvas);
  end;

begin
  Writeln('WebGL Demo');
  Create;
  window.requestAnimationFrame(@UpdateCanvas);
end.
