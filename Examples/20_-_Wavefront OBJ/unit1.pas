unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Menus,
  oglglad_gl,
  oglKoerper, oglWaveFrontOBJ, oglUnit,
  oglVector, oglMatrix, oglShader, oglLighting;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItemIsAnimation: TMenuItem;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItemIsAnimationClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    TexturCube: TCube;
    obj: TWavefrontOBJ;

    OBJLighting: TLightingDlg;

    procedure InitObjScene(const Datei: string);
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.InitObjScene(const Datei: string);
begin
  Timer1.Enabled := False;
  obj.WriteVertex(Datei);
  obj.AddLigthing(OBJLighting);
  Timer1.Enabled := True;
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  OpenGL.Clear;

  with OpenGL.Camera do begin

    // obj;

    m := ObjectMatrix;
    ObjectMatrix.Translate(0.0001, 0.0, 0.0);
    obj.Draw;

    ObjectMatrix := m;

    // TexturCube;

    ObjectMatrix.Translate(-3, 2, 0);
    ObjectMatrix.Scale(5.5);
//       TexturCube.Draw;

    ObjectMatrix.Translate(3, 0, 2);
    ObjectMatrix.Scale(0.5);
//        TexturCube.Draw;

    ObjectMatrix := m;
    OpenGL.SwapBuffers;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);
//  InitOpenGLDebug;
  OpenGL.Camera.Scale(0.1);
  OpenGL.BkColor := vec4(0.4, 0.2, 0.1, 1.0);
  OpenGL.Camera.MouseMoveStep := 0.002;

  obj := TWavefrontOBJ.Create;
  TexturCube := TCube.Create;

  OBJLighting := TLightingDlg.Create;
  OBJLighting.Form.Caption := 'Licht Steuerung';

  TexturCube.WriteVertex;
  OBJLighting.Add(TexturCube);

//  InitObjScene('obj/soccerball.obj');
  InitObjScene('obj/test.obj');

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  obj.Free;
  TexturCube.Free;
  OBJLighting.Free;
  OpenGL.Free;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
//  OpenGL.Camera.Perspective(60, ClientWidth / ClientHeight, 0.01, 700, 0.0, 1.0);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.3, 1000, -5, 1 / 150);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    obj.DeleteLigthing(OBJLighting);
    InitObjScene(OpenDialog1.FileName);
  end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  OBJLighting.Show;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  ShowMessage('OBJ-Viewer');
end;

procedure TForm1.MenuItemIsAnimationClick(Sender: TObject);
begin
  MenuItemIsAnimation.Checked := not MenuItemIsAnimation.Checked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with OpenGL.Camera do begin
    if MenuItemIsAnimation.Checked then begin
      ObjectMatrix.RotateA(Pi / 512);
      ObjectMatrix.RotateB(Pi / 220);
    end;
    RenderScene;
  end;
end;

end.
