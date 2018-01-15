unit WikiText;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Clipbrd,
  Global;

type

  { TWikiTextForm }

  TWikiTextForm = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    slFile: TStringList;
    ScrollBox: TScrollBox;
    Element: array of record
      Button: TButton;
      Label_: TLabel;
    end;
    procedure ButtonClick(Sender: TObject);
  public

  end;

var
  WikiTextForm: TWikiTextForm;

implementation

{$R *.lfm}

{ TWikiTextForm }

procedure TWikiTextForm.FormShow(Sender: TObject);
const
  h = 18;
var
  i: integer;
begin
  slFile.Clear;

  FindAllFiles(slFile, TutPara.WikiPfad, 'wiki.txt', True);
  SetLength(Element, slFile.Count);

  ScrollBox := TScrollBox.Create(Self);
  with ScrollBox do begin
    Align := alTop;
    Anchors := [akLeft, akRight, akTop, akBottom];
    Height := Self.ClientHeight - 30;
    Parent := Self;
  end;
  for i := 0 to Length(Element) - 1 do begin
    Element[i].Button := TButton.Create(Self);
    with Element[i] do begin
      with Button do begin
        Tag := i;
        Width := h;
        Height := h;
        Left := 10;
        Top := i * h;
        Caption := i.ToString;
        OnClick := @ButtonClick;
        Parent := ScrollBox;
      end;
      Element[i].Label_ := TLabel.Create(Self);
      with Label_ do begin
        Left := 30;
        Top := i * h;
        Text := Copy(slFile[i], Length(TutPara.WikiPfad) + 1);
        Parent := ScrollBox;
      end;
    end;
  end;

end;

procedure TWikiTextForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TWikiTextForm.FormCreate(Sender: TObject);
begin
  slFile := TStringList.Create;
  slFile.Sorted := True;
end;

procedure TWikiTextForm.FormDestroy(Sender: TObject);
begin
  slFile.Free;
end;

procedure TWikiTextForm.ButtonClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(slFile[TButton(Sender).Tag]);
  Clipboard.AsText := sl.Text;
  sl.Free;
end;

end.
