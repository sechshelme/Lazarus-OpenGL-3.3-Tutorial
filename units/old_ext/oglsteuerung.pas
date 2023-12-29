unit oglSteuerung;

{$mode objfpc}{$H+}

interface

uses
  Forms,
  Buttons,
  ExtCtrls,
  StdCtrls,
  oglCamera,
  Classes;

type

  { TCameraSteuerung }

  TCameraSteuerung = class(TForm)
    Default: TSpeedButton;
    aMinus: TSpeedButton;
    aMinus1: TSpeedButton;
    aPlus: TSpeedButton;
    aPlus1: TSpeedButton;
    bMinus: TSpeedButton;
    bMinus1: TSpeedButton;
    bPlus: TSpeedButton;
    bPlus1: TSpeedButton;
    cMinus: TSpeedButton;
    cMinus1: TSpeedButton;
    cPlus: TSpeedButton;
    cPlus1: TSpeedButton;
    xMinus: TSpeedButton;
    xMinus1: TSpeedButton;
    xPlus: TSpeedButton;
    xPlus1: TSpeedButton;
    yMinus: TSpeedButton;
    yMinus1: TSpeedButton;
    yPlus: TSpeedButton;
    yPlus1: TSpeedButton;
    zMinus: TSpeedButton;
    zMinus1: TSpeedButton;
    zPlus: TSpeedButton;
    zPlus1: TSpeedButton;
    procedure MoveButtonClick(Sender: TObject);
  private
  public
    class var  Camera: TCamera;
  end;

var
  CameraSteuerung: TCameraSteuerung;

implementation

{$R *.lfm}

{ TCameraSteuerung }

procedure TCameraSteuerung.MoveButtonClick(Sender: TObject);
const
  t1 = 1.0;
  t2 = 10.0;
  r1 = Pi / 180;
  r2 = Pi / 18;
begin
  with Camera do
  begin
    case TButton(Sender).Name of
      'aMinus':
      begin
        RotateA(-r1);
      end;
      'aMinus1':
      begin
        RotateA(-r2);
      end;
      'aPlus':
      begin
        RotateA(r1);
      end;
      'aPlus1':
      begin
        RotateA(r2);
      end;
      'bMinus':
      begin
        RotateB(-r1);
      end;
      'bMinus1':
      begin
        RotateB(-r2);
      end;
      'bPlus':
      begin
        RotateB(r1);
      end;
      'bPlus1':
      begin
        RotateB(r2);
      end;
      'cMinus':
      begin
        RotateC(-r1);
      end;
      'cMinus1':
      begin
        RotateC(-r2);
      end;
      'cPlus':
      begin
        RotateC(r1);
      end;
      'cPlus1':
      begin
        RotateC(r2);
      end;
      'xMinus':
      begin
        Translate(-t1, 0.0, 0.0);
      end;
      'xMinus1':
      begin
        Translate(-t2, 0.0, 0.0);
      end;
      'xPlus':
      begin
        Translate(t1, 0.0, 0.0);
      end;
      'xPlus1':
      begin
        Translate(t2, 0.0, 0.0);
      end;
      'yMinus':
      begin
        Translate(0.0, -t1, 0.0);
      end;
      'yMinus1':
      begin
        Translate(0.0, -t2, 0.0);
      end;
      'yPlus':
      begin
        Translate(0.0, t1, 0.0);
      end;
      'yPlus1':
      begin
        Translate(0.0, t2, 0.0);
      end;
      'zMinus':
      begin
        Translate(0.0, 0.0, -t1);
      end;
      'zMinus1':
      begin
        Translate(0.0, 0.0, -t2);
      end;
      'zPlus':
      begin
        Translate(0.0, 0.0, t1);
      end;
      'zPlus1':
      begin
        Translate(0.0, 0.0, t2);
      end;
      'Default':
      begin
      end;
    end;
  end;
end;

begin
  CameraSteuerung:=TCameraSteuerung.Create(nil);
//  Application.CreateForm(TCameraSteuerung, CameraSteuerung);
end.
