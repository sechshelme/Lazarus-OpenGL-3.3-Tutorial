unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix,
  Ameise,Zylinder;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Ameise:TAmeise;
    Zylinder:TZylinder;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Man kann auch in jedem Layer einzeln die Texturn laden.
Der einzige Unterschied zum kompletten laden ist, man ladetdie Texturen einzeln mit SubImage hoch.
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.
*)
//lineal

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  Ameise:=TAmeise.Create;
  Zylinder:=TZylinder.Create;
  Timer1.Enabled := True;

  Ameise.InitScene;
  Zylinder.InitScene;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  Ameise.DrawScene;
  glViewport(0, 0, ogc.Width, ogc.Height);
  Zylinder.DrawScene(Ameise.FrameTexturID);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Ameise.Free;
  Zylinder.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ogc.Invalidate;
end;

//lineal

(*
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

<b>Vertex-Shader:</b>
*)
//includeglsl Ameise.vert
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Ameise.frag

end.
