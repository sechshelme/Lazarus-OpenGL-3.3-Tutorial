unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  oglVector;

type
  TBone = record
    posx, posy: integer;
    x0, y0, x1, y1: integer;
    Child: array of TBone;
  end;

  { TForm2 }

  TForm2 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    procedure Paint(bone: TBone; x, y: integer);
  end;

var
  Form2: TForm2;


var
  Bones: TBone = (
  posx: 200; posy: 0; x0: -50; y0: 0; x1: 50; y1: 100; Child: ((
    posx: -50; posy: 50; x0: 0; y0: -16; x1: -50; y1: 16; Child: ((
      posx: -50; posy: 0; x0: 0; y0: -16; x1: -50; y1: 15; Child: ()), (
      posx: -25; posy: 16; x0: -5; y0: 0; x1: 5; y1: 16; Child: (); ));
  ), (
    posx: 50; posy: 80; x0: 0; y0: -16; x1: 50; y1: 16; Child: (); ));
  );


implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormPaint(Sender: TObject);
begin
  Paint(Bones, 200, 0);
end;

procedure TForm2.Paint(bone: TBone; x, y: integer);
var
  i: integer;
begin
  Canvas.Rectangle(x + bone.posx + bone.x0, y + bone.posy + bone.y0, x + bone.posx + bone.x1, y + bone.posy + bone.y1);
  Canvas.Ellipse(x + bone.posx - 4, y + bone.posy - 4, x + bone.posx + 4, y + bone.posy + 4);
  for i := 0 to Length(bone.Child) - 1 do begin
    Paint(bone.Child[i], x + bone.posx, y + bone.posy);
  end;
end;

end.
