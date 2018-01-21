unit oglCamera;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  oglMatrix;

{ TCamera }

type
  TCamera = class(TObject)
  private
    FEnabled: boolean;
    FIsCameraMatrixTransform: boolean;
    FMouseMoveStep: single;
    FRotationsMatrix: TMatrix;
    FProjectionMatrix: TMatrix;
    FCameraMatrix: TMatrix;
    FWorldMatrix: TMatrix;
    MousePos: record
      x, y: integer;
    end;
    procedure MatrixMulti;
    procedure SetEnabled(AValue: boolean);
    procedure SetMouseMoveStep(AValue: single);
  public
    ObjectMatrix: TMatrix;
    constructor Create;
    destructor Destroy; override;

    property Enabled: boolean read FEnabled write SetEnabled;
    property MouseMoveStep: single read FMouseMoveStep write SetMouseMoveStep;

    procedure SetCameraMatrixTransform(AValue: boolean);

    property CameraMatrix: TMatrix read FCameraMatrix;
    property WorldMatrix: TMatrix read FWorldMatrix;

    procedure SetOrtho; overload;
    procedure SetOrtho(left, right, bottom, top, znear, zfar: single); overload;
    procedure SetFrustum; overload;
    procedure SetFrustum(left, right, bottom, top, znear, zfar: single); overload;
    procedure Perspective(fovy, aspect, near, far, posZ, Scale: single);

    procedure Scale(Faktor: single); overload;
    procedure Scale(FaktorX, FaktorY, FaktorZ: single); overload;
    procedure RotateA(angle: single);
    procedure RotateB(angle: single);
    procedure RotateC(angle: single);
    procedure Translate(x, y, z: single);

    procedure Indentity;
    procedure ModifKey(Key: char);
    procedure MouseMove(Shift: TShiftState; X, Y: integer);
    procedure MouseWheel(WheelDelta: integer);
  end;


implementation

{ TCamera }

constructor TCamera.Create;
begin
  inherited;

  FEnabled := True;
  FIsCameraMatrixTransform:=True;
  FMouseMoveStep := 1.0;

  FRotationsMatrix := TMatrix.Create;
  FProjectionMatrix := TMatrix.Create;
  FCameraMatrix := TMatrix.Create;
  FWorldMatrix := TMatrix.Create;
  ObjectMatrix := TMatrix.Create;

  SetOrtho;
end;

destructor TCamera.Destroy;
begin
  FRotationsMatrix.Free;
  FProjectionMatrix.Free;
  FCameraMatrix.Free;
  FWorldMatrix.Free;
  ObjectMatrix.Free;

  inherited Destroy;
end;

procedure TCamera.MatrixMulti;
begin
  FCameraMatrix.Multiply(FProjectionMatrix, FRotationsMatrix);
end;

procedure TCamera.SetEnabled(AValue: boolean);
begin
  if FEnabled = AValue then begin
    Exit;
  end;
  FEnabled := AValue;
  if FEnabled then begin
    FCameraMatrix.Pop;
    FWorldMatrix.Pop;
  end else begin
    FCameraMatrix.Push;
    FCameraMatrix.Identity;
    FCameraMatrix.Scale(1.0, 1.0, -1.0); // Weil keine Ortho/Frustumm z-Achse vertauschen

    FWorldMatrix.Push;
    FWorldMatrix.Identity;
  end;
end;

procedure TCamera.SetCameraMatrixTransform(AValue: boolean);
begin
  FIsCameraMatrixTransform := AValue;
end;

procedure TCamera.SetMouseMoveStep(AValue: single);
begin
  if FMouseMoveStep = AValue then begin
    Exit;
  end;
  FMouseMoveStep := AValue;
end;

procedure TCamera.SetOrtho; inline;
begin
  SetOrtho(-1.0, 1.0, -1.0, 1.0, -40.0, 40.0);
end;


procedure TCamera.SetOrtho(left, right, bottom, top, znear, zfar: single);
begin
  FProjectionMatrix.Ortho(left, right, bottom, top, znear, zfar);
  MatrixMulti;
end;

procedure TCamera.SetFrustum; inline;
begin
  SetFrustum(-1.0, 1.0, -1.0, 1.0, 10, 70.0);
end;


procedure TCamera.SetFrustum(left, right, bottom, top, znear, zfar: single);
begin
  FProjectionMatrix.Frustum(left, right, bottom, top, znear, zfar);
  MatrixMulti;
end;

procedure TCamera.Perspective(fovy, aspect, near, far, posZ, Scale: single);
var
  TransMatrix: TMatrix;
begin
  TransMatrix := TMatrix.Create;

  TransMatrix.Translate(0.0, 0.0, posZ);
  TransMatrix.Scale(scale);

  FProjectionMatrix.Perspective(fovy, aspect, near, far);
  FProjectionMatrix.Multiply(FProjectionMatrix, TransMatrix);

  MatrixMulti;

  TransMatrix.Free;
end;


procedure TCamera.Scale(Faktor: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.Scale(Faktor);
    MatrixMulti;
  end else begin
    FWorldMatrix.Scale(Faktor);
  end;
end;

procedure TCamera.Scale(FaktorX, FaktorY, FaktorZ: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.Scale(FaktorX, FaktorY, FaktorZ);
    MatrixMulti;
  end else begin
    FWorldMatrix.Scale(FaktorX, FaktorY, FaktorZ);
  end;
end;


procedure TCamera.RotateA(angle: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.RotateA(angle);
    MatrixMulti;
  end else begin
    FWorldMatrix.RotateA(angle);
  end;
end;


procedure TCamera.RotateB(angle: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.RotateB(angle);
    MatrixMulti;
  end else begin
    FWorldMatrix.RotateB(angle);
  end;
end;


procedure TCamera.RotateC(angle: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.RotateC(angle);
    MatrixMulti;
  end else begin
    FWorldMatrix.RotateC(angle);
  end;
end;


procedure TCamera.Translate(x, y, z: single);
begin
  if FIsCameraMatrixTransform then begin
    FRotationsMatrix.Translate(x, y, z);
    MatrixMulti;
  end else begin
    FWorldMatrix.Translate(x, y, z);
  end;
end;


procedure TCamera.Indentity;
begin
  FRotationsMatrix.Identity;
  MatrixMulti;
end;


procedure TCamera.ModifKey(Key: char);
begin
  case Key of
    'x': begin
      Translate(0.01, 0.0, 0.0);
    end;
    'X': begin
      Translate(-0.01, 0.0, 0.0);
    end;
    'y': begin
      Translate(0.0, 0.01, 0.0);
    end;
    'Y': begin
      Translate(0.0, -0.01, 0.0);
    end;
    'z': begin
      Translate(0.0, 0.0, 0.01);
    end;
    'Z': begin
      Translate(0.0, 0.0, -0.01);
    end;
    'q': begin
      Scale(1.1);
    end;
    'Q': begin
      Scale(0.9);
    end;
    'r': begin
      RotateA(Pi / 180);
    end;
    'R': begin
      RotateA(-Pi / 180);
    end;
    's': begin
      RotateB(Pi / 180);
    end;
    'S': begin
      RotateB(-Pi / 180);
    end;
    't': begin
      RotateC(Pi / 180);
    end;
    'T': begin
      RotateC(-Pi / 180);
    end;
    #32: begin
      Indentity;
      Scale(0.2);
    end;
  end;
end;

procedure TCamera.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  if Shift = [ssLeft] then begin
    Translate((X - MousePos.x) * FMouseMoveStep, -(Y - MousePos.y) * FMouseMoveStep, 0.0);
  end;
  if Shift = [ssRight] then begin
    RotateB(-(X - MousePos.x) / 200);
    RotateA((Y - MousePos.y) / 200);
  end;
  if Shift = [ssMiddle] then begin
    RotateC(-(X - MousePos.x) / 200);
  end;
  MousePos.x := X;
  MousePos.y := Y;
end;

procedure TCamera.MouseWheel(WheelDelta: integer);
begin
  if WheelDelta < 0 then begin
    Scale(1.1);
  end else begin
    Scale(0.9);
  end;
end;


end.
