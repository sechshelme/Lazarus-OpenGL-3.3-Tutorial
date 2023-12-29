unit AnzeigerOptionen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, VLIBasis;

type

  { TAnzeigerOptionenForm }

  TAnzeigerOptionenForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    LaengeEdit: TEdit;
    LaengeLabel: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AnzeigerOptionenForm: TAnzeigerOptionenForm;

implementation

uses HauptFenster;

{$R *.lfm}

{ TAnzeigerOptionenForm }

procedure TAnzeigerOptionenForm.FormShow(Sender: TObject);
begin
  LaengeEdit.Text := FloatToStr(TUrAnzeiger.AnzeigerMasse.StandRohr.L);
end;

procedure TAnzeigerOptionenForm.BitBtn3Click(Sender: TObject);
begin
  TUrAnzeiger.AnzeigerMasse.StandRohr.L := StrToFloat(LaengeEdit.Text);
  case ComboBox1.Text of
    'Smart': begin
      TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD := 35;
      TUrAnzeiger.AnzeigerMasse.StandRohr.InnenD := 30;
      TUrAnzeiger.AnzeigerMasse.Stutzen.AussenD := 17;
      TUrAnzeiger.AnzeigerMasse.Stutzen.InnenD := 14;
    end;
    'Standard': begin
      TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD := 54;
      TUrAnzeiger.AnzeigerMasse.StandRohr.InnenD := 52;
      TUrAnzeiger.AnzeigerMasse.Stutzen.AussenD := 30;
      TUrAnzeiger.AnzeigerMasse.Stutzen.InnenD := 26;
    end;
    'Hochdruck': begin
      TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD := 60;
      TUrAnzeiger.AnzeigerMasse.StandRohr.InnenD := 52;
      TUrAnzeiger.AnzeigerMasse.Stutzen.AussenD := 30;
      TUrAnzeiger.AnzeigerMasse.Stutzen.InnenD := 22;
    end;
  end;
  TUrAnzeiger.AnzeigerMasse.Schwimmer.AussenD := TUrAnzeiger.AnzeigerMasse.StandRohr.InnenD - 5;
  TUrAnzeiger.AnzeigerMasse.Schwimmer.InnenD := TUrAnzeiger.AnzeigerMasse.Schwimmer.AussenD - 2;
  HauptForm.InitScene;
end;

procedure TAnzeigerOptionenForm.BitBtn2Click(Sender: TObject);
begin
  BitBtn3Click(Sender);
  Close;
end;

end.
