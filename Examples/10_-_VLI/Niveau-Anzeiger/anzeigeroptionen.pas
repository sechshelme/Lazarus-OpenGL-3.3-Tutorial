unit AnzeigerOptionen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, VLIFluegeli, VLIAnzeigeschiene, VLIStandRohr, VLIArmaflex,
  VLIBasis, VLIStutzen, VLIFlansch, VLISchwimmer, oglShader, oglLightingShader,
  oglMatrix, oglTexturVAO;

type

  { TAnzeigerOptionenForm }

  TAnzeigerOptionenForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    ComboBoxMaterial: TComboBox;
    LaengeEdit: TEdit;
    LaengeLabel: TLabel;
    RadioGroup1: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ComboBoxMaterialChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TAnzeigerOptionenForm.ComboBoxMaterialChange(Sender: TObject);

  procedure SetMaterial(Teil: TMultiTexturVAO);
  begin
    Teil.LightingShader.SetMaterial(ComboBoxMaterial.Caption);
  end;

begin
  with HauptForm.VLITeile do begin
    SetMaterial(StandRohr);
    SetMaterial(Stutzen);
    SetMaterial(ProcessFlansch);
    SetMaterial(RohrFlansch);
  end;
end;

procedure TAnzeigerOptionenForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(MaterialPara) - 1 do begin
    ComboBoxMaterial.Items.Add(MaterialPara[i].Name);
  end;
  ComboBoxMaterial.Caption := 'Chrome';
end;

procedure TAnzeigerOptionenForm.BitBtn2Click(Sender: TObject);
begin
  BitBtn3Click(Sender);
  Close;
end;

procedure TAnzeigerOptionenForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
