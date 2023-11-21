unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Spin, Buttons,
  Math,
  oglShader, oglLinesVAO, oglBackGround, oglTextur, oglUnit, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit10: TFloatSpinEdit;
    FloatSpinEdit11: TFloatSpinEdit;
    FloatSpinEdit12: TFloatSpinEdit;
    FloatSpinEdit13: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    FloatSpinEdit5: TFloatSpinEdit;
    FloatSpinEdit6: TFloatSpinEdit;
    FloatSpinEdit7: TFloatSpinEdit;
    FloatSpinEdit8: TFloatSpinEdit;
    FloatSpinEdit9: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure FloatSpinEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    HGraphParameter: record
      x, y, z, t2, dt, A, B, C, u, v, w, R, S, T, f, g, h: single;
      sk: integer;
      end;

    OpenGL: TOpenGL;
    oglLinesVAO: TColorLinesVAO;

    BackGround: record
      VAO: TBackGround;
      Textur: TTexturBuffer;
      end;

    procedure InitScene;
    procedure RenderScene;
    procedure updateXY;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.updateXY;
begin
  with HGraphParameter do begin
    t2 := t2 + dt;
    x := degtorad(A) * sin(2.0 * PI * (f * t2 + u)) * exp(-R * t2);
    y := degtorad(B) * sin(2.0 * PI * (g * t2 + v)) * exp(-S * t2);
    z := degtorad(C) * sin(2.0 * PI * (h * t2 + w)) * exp(-T * t2);
  end;
end;

procedure TForm1.InitScene;
var
  i: integer;
begin
  OpenGL.BKColor := vec4(0.0, 0.5, 1.0, 1.0);

  with HGraphParameter do begin
    t2 := 0.0;
    for i := 0 to sk do begin
      updateXY;
      oglLinesVAO.Add(
        vec3(x * 3, y * 3, z * 3),
        vec3((x * 3 + 1) / 2, (y * 3 + 1) / 2, (z * 3 + 1) / 2));
    end;
  end;

  oglLinesVAO.WriteVertex;

  with BackGround do begin
//    Textur.LoadTextures(2, 2, [$220000FF, $4400FF00, $FF0000FF, $8800FFFF]);
    Textur.LoadTextures(2, 2, [$FF880088, $FF008800, $FF000088, $FF008888]);
    //    Textur.LoadTextures('project1.ico');
    VAO.WriteVertex(2, 2);
  end;

  Timer1.Enabled := True;
end;

procedure TForm1.RenderScene;
begin
  OpenGL.Clear;

  oglLinesVAO.Draw;

  with BackGround do begin
    VAO.Draw(Textur);
  end;

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  with HGraphParameter do begin
    dt := 0.01;
    A := 10;     // Amplitude / Winkel
    B := 10;
    C := 10;
    u := 0.0;        // Phase  (0..1)
    v := 0.3;
    w := 0.7;
    R := 0.001;      // Damping (0..)
    S := 0.001;
    T := 0.001;
    f := 0.301;      // Frequenz
    g := 0.302;
    h := 0.303;
//    sk := 2000000;
    sk := 200000;
  end;

  OpenGL := TOpenGL.Create(Panel2);
  OpenGL.Camera.MouseMoveStep := 0.001;
  oglLinesVAO := TColorLinesVAO.Create;

  with BackGround do begin
    Textur := TTexturBuffer.Create;
    VAO := TBackGround.Create(1);
  end;

  InitScene;
end;

procedure TForm1.FloatSpinEditChange(Sender: TObject);
begin
  with HGraphParameter do begin
    sk := 200000;
    A := FloatSpinEdit1.Value;   // Amplitude / Winkel
    B := FloatSpinEdit2.Value;
    C := FloatSpinEdit3.Value;
    u := FloatSpinEdit4.Value;   // Phase  (0..1)
    v := FloatSpinEdit5.Value;
    w := FloatSpinEdit6.Value;
    R := FloatSpinEdit7.Value;   // Damping (0..)
    S := FloatSpinEdit8.Value;
    T := FloatSpinEdit9.Value;
    f := FloatSpinEdit10.Value;  // Frequenz
    g := FloatSpinEdit11.Value;
    h := FloatSpinEdit12.Value;
    dt := FloatSpinEdit13.Value;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  InitScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  oglLinesVAO.Free;

  with BackGround do begin
    Textur.Free;
    VAO.Free;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(Panel2.Width, Panel2.Height);
  OpenGL.Camera.Perspective(30, Panel2.Width / Panel2.Height, 0.3, 1000, -5, 1.5);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with OpenGL.Camera do begin
    ObjectMatrix.RotateB(Pi / 200);
    ObjectMatrix.RotateC(Pi / 1010);
  end;
  RenderScene;
end;

end.
