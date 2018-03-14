unit oglLogForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Clipbrd;

type

  { TLogForm }

  TLogForm = class(TForm)
  private
    Memo: TMemo;
    CloseButton, ClipbrdButton, SaveButton: TBitBtn;
    SaveDialog: TSaveDialog;
    procedure ClipbrdClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
  public
    constructor CreateNew(TheOwner: TComponent);
    procedure Add(s: string);
  end;

procedure ShowError(Title, Text: string);

implementation

procedure ShowError(Title, Text: string);
var
  lf: TLogForm;
begin
  lf := TLogForm.CreateNew(nil);
  lf.Caption := Title;
  lf.Add(Text);
  lf.ShowModal;
  lf.Free;
end;

{ TLogForm }

procedure TLogForm.SaveClick(Sender: TObject);
begin
  SaveDialog := TSaveDialog.Create(Self);
  SaveDialog.Title := 'Speichern unter';
  SaveDialog.FileName := 'error.txt';
  SaveDialog.Filter := 'Text file|*.txt';
  if SaveDialog.Execute then begin
    Memo.Lines.SaveToFile(SaveDialog.FileName);
  end;
  SaveDialog.Free;
end;

procedure TLogForm.ClipbrdClick(Sender: TObject);
begin
  Clipboard.AsText := Memo.Lines.Text;
end;

procedure TLogForm.CloseClick(Sender: TObject);
begin
  Close;
end;

constructor TLogForm.CreateNew(TheOwner: TComponent);
begin
  inherited CreateNew(TheOwner);
  Left := 50;
  Top := 50;
  Width := Screen.Width div 3;
  Height := Screen.Height - 200;
  Memo := TMemo.Create(Self);
  with Memo do begin
    Font.Name := 'monospace';
    Font.Color := clLtGray;
    Color := clBlack;
    Align := alTop;
    Height := Self.ClientHeight - 40;
    Anchors := [akTop, akLeft, akBottom, akRight];
    ScrollBars := ssAutoBoth;
    Parent := self;
  end;

  SaveButton := TBitBtn.Create(TheOwner);
  with SaveButton do begin
    Anchors := [akBottom, akRight];
    Top := Self.ClientHeight - 35;
    Left := Self.ClientWidth - 200;
    Height := 25;
    Width := 90;
    Kind := bkCustom;
    Caption := 'Speichern';
    OnClick := @SaveClick;
    Parent := Self;
  end;

  CloseButton := TBitBtn.Create(TheOwner);
  with CloseButton do begin
    Anchors := [akBottom, akRight];
    Top := Self.ClientHeight - 35;
    Left := Self.ClientWidth - 100;
    Height := 25;
    Width := 90;
    Kind := bkCancel;
    Caption := 'Schliessen';
    OnClick := @CloseClick;
    Parent := Self;
  end;

  ClipbrdButton := TBitBtn.Create(TheOwner);
  with ClipbrdButton do begin
    Anchors := [akBottom, akRight];
    Top := Self.ClientHeight - 35;
    Left := Self.ClientWidth - 300;
    Height := 25;
    Width := 90;
    Kind := bkRetry;
    Caption := 'Clipbrd';
    OnClick := @ClipbrdClick;
    Parent := Self;
  end;
end;

procedure TLogForm.Add(s: string);
begin
  Memo.Text := s;
end;

end.
