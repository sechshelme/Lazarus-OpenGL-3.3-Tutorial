unit oglLogForm;

interface

const
  clBlack = 30;
  clRed = 31;
  clGreen = 32;
  clYellow = 33;
  clBlurw = 34;
  clMagenta = 35;
  clCyan = 36;
  clWhite = 37;
  clBrightBlack = 90;
  clBrightRed = 91;
  clBrightGree = 92;
  clBrightYellow = 93;
  clBrightBlue = 94;
  clBrightMagenta = 95;
  clBrightCyan = 96;
  clBrightWhite = 97;

type

  { TLogForm }

  TLogForm = class(TObject)
  public
    procedure Add(s: string; fg:Byte=0; bg:Byte=0);
    procedure AddAndTitle(Title, Comment: string);
  end;

  var
  LogForm:TLogForm;

implementation

procedure SetFGColor(c: byte);
begin
  Write(#27'[', Ord(c), 'm');
end;

procedure SetBGColor(c: byte);
begin
  Write(#27'[', Ord(c + 10), 'm');
end;

procedure SetFGNormalColor;
begin
  Write(#27'[0m');
  //  SetFGColor(clBrightWhite);
end;

procedure TLogForm.Add(s: string; fg: Byte; bg: Byte);
begin
  {$I-}  // Wegen Windows
  SetFGColor(fg);
  SetBGColor(bg);
  WriteLn(s);
  {$I+}
end;

procedure TLogForm.AddAndTitle(Title, Comment: string);
begin
  Add(Title, clBrightRed);
  Add(StringOfChar('=', Length(Title)));
  Add('');
  Add(Comment,clGreen);
  Add('');
end;

initialization

LogForm := TLogForm.Create;

finalization

LogForm.Free;

end.
