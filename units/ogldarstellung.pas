unit oglDarstellung;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, oglVAO;

type
  TFlags = set of (Zubehoer, noSchnitt);

  TElemente = record
    Koerper: TBasisTriangleVAO;
    Titel: TLabel;
    Button: array[0..2] of TToggleBox;
    Flags: TFlags;
    Group: integer;
  end;

  { TDarstellung1 }

  TDarstellung = class(TForm)
  public
    constructor CreateNew(TheOwner: TComponent);
    destructor Destroy; override;
    procedure Show;
    procedure Add(const AKoerper: TBasisTriangleVAO; AFlags: TFlags);
    procedure Add(const AKoerper: TBasisTriangleVAO; AFlags: TFlags; AGroup: integer);
  private
    ScrollBox: TScrollBox;
    CloseBitBtn: TBitBtn;
    AllesButton: array[0..2] of TButton;
    GroupButton: TToggleBox;
    AllesLabel: TLabel;
    Elemente: array of TElemente;
    procedure FormResize(Sender: TObject);
    procedure ToggleBoxClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure AllesClick(Sender: TObject);
    procedure GroupButtonClick(Sender: TObject);
    procedure ButtonStateUpdate;
  end;

var
  Darstellung1: TDarstellung;

implementation

{ TDarstellung1 }

constructor TDarstellung.CreateNew(TheOwner: TComponent);
var
  i: integer;
begin
  inherited CreateNew(TheOwner);
  Caption := 'Darstellung';
  OnResize := @self.FormResize;
  Width := 450;
  Height := 400;
  Position:=poDefault;

  for i := 0 to 2 do begin
    AllesButton[i] := TButton.Create(TheOwner);
    AllesButton[i].Parent := Self;
    AllesButton[i].Left := 40 + i * 90;
    AllesButton[i].Top := 12;
    AllesButton[i].OnClick := @AllesClick;
    AllesButton[i].Tag := i;
  end;

  AllesButton[0].Caption := 'Ganz';
  AllesButton[1].Caption := 'Schnitt';
  AllesButton[2].Caption := 'Aus';

  AllesLabel := TLabel.Create(TheOwner);
  AllesLabel.Parent := Self;
  AllesLabel.Left := 5;
  AllesLabel.Top := 14;
  AllesLabel.Caption := 'Alles';

  GroupButton := TToggleBox.Create(TheOwner);
  GroupButton.Parent := Self;
  GroupButton.Caption := 'Gruppe';
  GroupButton.Left := 350;
  GroupButton.Top := 12;
  GroupButton.OnClick := @GroupButtonClick;

  ScrollBox := TScrollBox.Create(TheOwner);
  ScrollBox.Parent := Self;
  ScrollBox.Left := 0;
  ScrollBox.Top := 50;

  CloseBitBtn := TBitBtn.Create(TheOwner);
  CloseBitBtn.Parent := Self;
  CloseBitBtn.Height := 25;
  CloseBitBtn.Caption := '&Schliessen';
  CloseBitBtn.Kind := bkCancel;
  CloseBitBtn.OnClick := @CloseClick;
end;

destructor TDarstellung.Destroy;
var
  anz, i, j: integer;
begin
  anz := Length(Elemente);
  for j := 0 to anz - 1 do begin
    for i := 0 to 2 do begin
      Elemente[j].Button[i].Free;
    end;
    Elemente[j].Titel.Free;
  end;

  CloseBitBtn.Free;
  ScrollBox.Free;
  GroupButton.Free;
  AllesLabel.Free;
  for i := 0 to 2 do begin
    AllesButton[i].Free;
  end;

  inherited Destroy;
end;

procedure TDarstellung.Show;
begin
  ButtonStateUpdate;
  inherited Show;
end;

procedure TDarstellung.Add(const AKoerper: TBasisTriangleVAO; AFlags: TFlags; AGroup: integer);
var
  indexY, i: integer;

begin
  indexY := Length(Elemente);
  SetLength(Elemente, indexY + 1);

  Elemente[indexY].Koerper := AKoerper;
  Elemente[indexY].Flags := AFlags;
  Elemente[indexY].Group := AGroup;
  Elemente[indexY].Titel := TLabel.Create(Self);
  Elemente[indexY].Titel.Parent := ScrollBox;
  Elemente[indexY].Titel.Caption := AKoerper.Caption;
  Elemente[indexY].Titel.Left := 5;

  for i := 0 to 2 do begin
    Elemente[indexY].Button[i] := TToggleBox.Create(Self);
    Elemente[indexY].Button[i].Parent := ScrollBox;
    Elemente[indexY].Button[i].Left := 90 + i * 100;
    Elemente[indexY].Button[i].Tag := (indexY * $100) + i;
    Elemente[indexY].Button[i].OnClick := @Self.ToggleBoxClick;
    if AGroup = 0 then begin
      Elemente[indexY].Button[i].Font.Style := [];
    end else begin
      Elemente[indexY].Button[i].Font.Style := [fsItalic];
    end;
  end;
  if noSchnitt in AFlags then begin
    Elemente[indexY].Button[1].Enabled := False;
  end;
  Elemente[indexY].Button[0].Caption := 'Ganz';
  Elemente[indexY].Button[1].Caption := 'Schnitt';
  Elemente[indexY].Button[2].Caption := 'Aus';
end;

procedure TDarstellung.Add(const AKoerper: TBasisTriangleVAO; AFlags: TFlags);
begin
  Add(AKoerper, AFlags, 0);
end;

procedure TDarstellung.ButtonStateUpdate;
var
  Gruppe, oben, anz, i, j: integer;

const
  Abstand = 25;

begin
  anz := Length(Elemente);
  oben := 10;
  Gruppe := 0;
  for j := 0 to anz - 1 do begin
    if (noSchnitt in Elemente[j].Flags) and (Elemente[j].Koerper.Darstellung = geschnitten) then begin
      Elemente[j].Koerper.Darstellung := Ganz;
    end;

    if (Gruppe <> 0) and (Gruppe = Elemente[j].Group) and (GroupButton.State = cbChecked) then begin
      Elemente[j].Titel.Visible := False;
      for i := 0 to 2 do begin
        Elemente[j].Button[i].Visible := False;
      end;
    end else begin
      Elemente[j].Titel.Visible := True;
      for i := 0 to 2 do begin
        Elemente[j].Button[i].Visible := True;
      end;
      oben += Abstand;
    end;

    Gruppe := Elemente[j].Group;

    Elemente[j].Titel.Top := oben + 2;

    for i := 0 to 2 do begin
      Elemente[j].Button[i].Top := oben;
      Elemente[j].Button[i].State := cbUnchecked;
    end;
    case Elemente[j].Koerper.Darstellung of
      ganz: begin
        Elemente[j].Button[0].State := cbChecked;
      end;
      geschnitten: begin
        Elemente[j].Button[1].State := cbChecked;
      end;
      aus: begin
        Elemente[j].Button[2].State := cbChecked;
      end;
    end;
  end;
end;

procedure TDarstellung.FormResize(Sender: TObject);
begin
  ScrollBox.Width := ClientWidth;
  ScrollBox.Height := ClientHeight - ScrollBox.Top - 40;
  CloseBitBtn.Left := ClientWidth - 80;
  CloseBitBtn.Top := ClientHeight - CloseBitBtn.Height - 7;
end;

procedure TDarstellung.ToggleBoxClick(Sender: TObject);
var
  indexY, indexX, i, Gruppe: integer;

begin
  indexX := TToggleBox(Sender).Tag mod $100;
  indexY := TToggleBox(Sender).Tag div $100;

  if (Elemente[indexY].Group <> 0) and (GroupButton.State = cbChecked) then begin
    Gruppe := Elemente[indexY].Group;
    for i := 0 to Length(Elemente) - 1 do begin
      if Elemente[i].Group = Gruppe then begin
        case indexX of
          0: begin
            Elemente[i].Koerper.Darstellung := Ganz;
          end;
          1: begin
            Elemente[i].Koerper.Darstellung := geschnitten;
          end;
          2: begin
            Elemente[i].Koerper.Darstellung := aus;
          end;
        end;
      end;
    end;
  end else begin
    case indexX of
      0: begin
        Elemente[indexY].Koerper.Darstellung := Ganz;
      end;
      1: begin
        Elemente[indexY].Koerper.Darstellung := geschnitten;
      end;
      2: begin
        Elemente[indexY].Koerper.Darstellung := aus;
      end;
    end;
  end;
  ButtonStateUpdate;
end;

procedure TDarstellung.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDarstellung.AllesClick(Sender: TObject);
var
  anz: integer;
  p: PtrInt;
  i: integer;
begin
  p := TButton(Sender).Tag;
  anz := Length(Elemente);
  for i := 0 to anz - 1 do begin
    if (not (Zubehoer in Elemente[i].Flags)) or (p = 2) then begin
      case p of
        0: begin
          Elemente[i].Koerper.Darstellung := Ganz;
        end;
        1: begin
          if noSchnitt in Elemente[i].Flags then begin
            Elemente[i].Koerper.Darstellung := Ganz;
          end else begin
            Elemente[i].Koerper.Darstellung := geschnitten;
          end;
        end;
        2: begin
          Elemente[i].Koerper.Darstellung := aus;
        end;
      end;
    end;
  end;
  ButtonStateUpdate;
end;

procedure TDarstellung.GroupButtonClick(Sender: TObject);
begin
  ButtonStateUpdate;
end;

initialization
  Darstellung1 := TDarstellung.CreateNew(nil);

finalization
  FreeAndNil(Darstellung1);

end.
