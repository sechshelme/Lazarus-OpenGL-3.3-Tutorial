unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls, ExtCtrls,
  oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    ScaleQuadMinusButton: TButton;
    ScaleQuadPlusButton: TButton;
    Timer1: TTimer;
    procedure FormResize(Sender: TObject);
    procedure QuadDownButtonClick(Sender: TObject);
    procedure QuadUpButtonClick(Sender: TObject);
    procedure QuadRightButtonClick(Sender: TObject);
    procedure QuadLeftButtonClick(Sender: TObject);
    procedure QuadScaleMinusButtonClick(Sender: TObject);
    procedure QuadScalePlusButtonClick(Sender: TObject);

    procedure CameraScalePlusButtonClick(Sender: TObject);
    procedure CameraScaleMinusButtonClick(Sender: TObject);
    procedure CameraRotateButtonLClick(Sender: TObject);
    procedure CameraRotateButtonRClick(Sender: TObject);
    procedure CameraTopButtonClick(Sender: TObject);
    procedure CameraLeftButtonClick(Sender: TObject);
    procedure CameraButtonRightClick(Sender: TObject);
    procedure CameraDownButtonClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure MatrixDraw(Matrix: TMatrix2D; Linien: array of TLine2D; Col: TColor);
  private
    ProjectMatrix,
    CameraMatrix,
    QuadMatrix,
    QuadScaleMatrix,
    TriangleMatrix,

    PerspektiveMatrix: TMatrix2D;
  public
  end;


var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  Quad: array [0..3] of TLine2D =
    (((-0.5, -0.5), (0.5, -0.5)), ((0.5, -0.5), (0.5, 0.5)),
    ((0.5, 0.5), (-0.5, 0.5)), ((-0.5, 0.5), (-0.5, -0.5)));

  Triangle: array [0..2] of TLine2D =
    (((0.0, -0.5), (0.5, 0.5)),
    ((0.5, 0.5), (-0.5, 0.5)), ((-0.5, 0.5), (0.0, -0.5)));

  Muster: array [0..19] of TLine2D = (
    ((-0.7, -0.1), (-0.7, -0.7)), ((-0.1, -0.1), (-0.1, -0.7)),
    ((-0.7, -0.1), (-0.1, -0.1)), ((-0.7, -0.7), (-0.1, -0.7)),

    ((-0.7, 0.1), (-0.7, 0.7)), ((-0.1, 0.1), (-0.1, 0.7)),
    ((-0.7, 0.1), (-0.1, 0.1)), ((-0.7, 0.7), (-0.1, 0.7)),

    ((0.7, -0.1), (0.7, -0.7)), ((0.1, -0.1), (0.1, -0.7)),
    ((0.7, -0.1), (0.1, -0.1)), ((0.7, -0.7), (0.1, -0.7)),

    ((0.7, 0.1), (0.7, 0.7)), ((0.1, 0.1), (0.1, 0.7)),
    ((0.7, 0.1), (0.1, 0.1)), ((0.7, 0.7), (0.1, 0.7)),

    ((0.8, 0.8), (-0.8, 0.8)), ((-0.8, 0.8), (-0.8, -0.8)),
    ((-0.8, -0.8), (0.8, -0.8)), ((0.8, -0.8), (0.8, 0.8)));


procedure MatrixWrite(Matrix: TMat3x3);
var
  x, y: integer;
  s: string;
begin
  s := '';
  for y := 0 to 2 do begin
    for x := 0 to 2 do begin
      s := s + FormatFloat('##0.00', Matrix[x, y]) + '   ';
    end;
    s := s + #13#10;
  end;
//  ShowMessage(s);
end;

{ TForm }

procedure TForm1.QuadUpButtonClick(Sender: TObject);
begin
  QuadMatrix.Translate(0.0, -0.5);
end;

procedure TForm1.QuadRightButtonClick(Sender: TObject);
begin
  QuadMatrix.Translate(0.5, 0.0);
end;

procedure TForm1.QuadLeftButtonClick(Sender: TObject);
begin
  QuadMatrix.Translate(-0.5, 0.0);
end;

procedure TForm1.QuadDownButtonClick(Sender: TObject);
begin
  QuadMatrix.Translate(0.0, 0.5);
end;

procedure TForm1.QuadScaleMinusButtonClick(Sender: TObject);
begin
  QuadScaleMatrix.Scale(0.9, 1);
end;

procedure TForm1.QuadScalePlusButtonClick(Sender: TObject);
begin
  QuadScaleMatrix.Scale(1.1, 1);
end;

procedure TForm1.CameraScaleMinusButtonClick(Sender: TObject);
begin
  ProjectMatrix.Scale(0.75, 0.75);
end;

procedure TForm1.CameraScalePlusButtonClick(Sender: TObject);
begin
  ProjectMatrix.Scale(1.5, 1.5);
end;

procedure TForm1.CameraRotateButtonLClick(Sender: TObject);
begin
  CameraMatrix.Rotate(-0.1);
end;

procedure TForm1.CameraRotateButtonRClick(Sender: TObject);
begin
  CameraMatrix.Rotate(0.1);
end;

procedure TForm1.CameraTopButtonClick(Sender: TObject);
begin
  CameraMatrix.Translate(0.0, -5.0);
end;

procedure TForm1.CameraLeftButtonClick(Sender: TObject);
begin
  CameraMatrix.Translate(-5.0, 0.0);
end;

procedure TForm1.CameraButtonRightClick(Sender: TObject);
begin
  CameraMatrix.Translate(5.0, 0.0);
end;

procedure TForm1.CameraDownButtonClick(Sender: TObject);
begin
  CameraMatrix.Translate(0.0, 5.0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  Color := clBlack;

  ProjectMatrix.Identity;
  CameraMatrix.Identity;
  QuadMatrix.Identity;
  QuadScaleMatrix.Identity;
  TriangleMatrix.Identity;

  // PerspektiveMatrix: TMat3x3 = ((1.0, 0.5, 0), (0.0, 1.0, 0), (0.0, -0, 1.0));

  // PerspektiveMatrix: TMat3x3 = ((-0.07, -0.44, 0.0), (0.01, 0.66, 0.0), (75.88, 45.76, 1));
  // PerspektiveMatrix: TMat3x3 = ((-0.07, -0.01, 75.88), (-0.44, 0.66, 45.76), (0, 0, 1));


  QuadMatrix.Shear(1.0, 0.0);
  QuadMatrix.Translate(-2.0, 0.0);

  TriangleMatrix.Translate(2.0, 0.0);

  ProjectMatrix.Scale(1.2, 1.2);

  Timer1.Enabled := True;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  FrustumMatrix: TMatrix2D;
begin
  PerspektiveMatrix.Identity;
  PerspektiveMatrix.Translate(0, 3.0);

  FrustumMatrix.Frustum(-1, 1, 1, 1000);
  FrustumMatrix.Scale(1.0, -1.0);

  PerspektiveMatrix := FrustumMatrix * PerspektiveMatrix;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  Matrix: TMatrix2D;
begin
  Canvas.brush.color := Color;
  Canvas.FillRect(rect(0, 0, Width, Height));
  Canvas.Refresh;

  Matrix := QuadMatrix * QuadScaleMatrix;
  Matrix := ProjectMatrix * Matrix;
  Matrix := CameraMatrix * Matrix;
  Matrix := PerspektiveMatrix * Matrix;
  //  Matrix := FrustumMatrix * Matrix;
  MatrixDraw(Matrix, Quad, $FFFF);

  Matrix := ProjectMatrix * TriangleMatrix;
  Matrix := CameraMatrix * Matrix;
  Matrix := PerspektiveMatrix * Matrix;
  //  Matrix := FrustumMatrix * Matrix;
  MatrixDraw(Matrix, Triangle, $FFFF00);

  Matrix := CameraMatrix * ProjectMatrix;
  Matrix := PerspektiveMatrix * Matrix;
  //  Matrix := FrustumMatrix * Matrix;
  MatrixDraw(Matrix, Muster, $FF00FF);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  QuadMatrix.Rotate(-0.02);
  TriangleMatrix.Rotate(0.08);
  Paint;
end;

procedure TForm1.MatrixDraw(Matrix: TMatrix2D; Linien: array of TLine2D; Col: TColor);
var
  l: TRect;
  i, j: integer;
  v: TVector3f;
  ofsx, ofsy, scale: integer;
begin
  ofsx := ClientWidth div 2;
  ofsy := ClientHeight div 2;
  scale := ClientHeight div 2;

  for i := 0 to Length(Linien) - 1 do begin

    for j := 0 to 1 do begin
      v := Matrix * vec3(Linien[i, j], 1.0);
      if v[0]=0 then v[0] := 0.00001;
      if v[1]=0 then v[1] := 0.00001;
      if v[2]=0 then v[2] := 0.00001;
      Linien[i, j, 0] := v[0] / v[2];
      Linien[i, j, 1] := v[1] / v[2];
    end;
    l.Left := Round(Linien[i, 0, 0] * scale) + ofsx;
    l.Top := Round(Linien[i, 0, 1] * scale) + ofsy;
    l.Right := Round(Linien[i, 1, 0] * scale) + ofsx;
    l.Bottom := Round(Linien[i, 1, 1] * scale) + ofsy;

    Caption := 'X1:' + IntToStr(l.Left) + '  Y1:' + IntToStr(l.Top) + '  X2:' + IntToStr(l.Right) + '  Y2:' + IntToStr(l.Bottom);

    Canvas.Pen.Color := Col;
    Canvas.Line(l);
  end;
end;


end.
