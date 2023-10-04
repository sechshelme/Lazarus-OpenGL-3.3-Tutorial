unit oglDebug;

interface

uses SysUtils, dglOpenGL;

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
    procedure Add(s: string; fg: byte = 0; bg: byte = 0);
    procedure AddAndTitle(Title, Comment: string);
  end;

var
  LogForm: TLogForm;

procedure InitOpenGLDebug;
procedure checkError(command: string);

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

// --- Debugger ---

{$IFDEF MSWINDOWS}
procedure GLDebugCallBack(Source: GLEnum; type_: GLEnum; id: GLUInt; severity: GLUInt; length: GLsizei; const message_: PGLCHar; userParam: PGLvoid); stdcall;
{$ELSE}
procedure GLDebugCallBack(Source: GLEnum; type_: GLEnum; id: GLUInt; severity: GLUInt; length: GLsizei; const message_: PGLCHar; userParam: PGLvoid); cdecl;
{$ENDIF}

var
  MsgSource: string = '';
  MsgType: string = '';
  MsgSeverity: string = '';
  col: byte;
begin

  // Source of this message
  case Source of
    GL_DEBUG_SOURCE_API: begin
      MsgSource := 'API';
    end;
    GL_DEBUG_SOURCE_WINDOW_SYSTEM: begin
      MsgSource := 'WINDOW_SYSTEM';
    end;
    GL_DEBUG_SOURCE_SHADER_COMPILER: begin
      MsgSource := 'SHADER_COMPILER';
    end;
    GL_DEBUG_SOURCE_THIRD_PARTY: begin
      MsgSource := 'THIRD_PARTY';
    end;
    GL_DEBUG_SOURCE_APPLICATION: begin
      MsgSource := 'APPLICATION';
    end;
    GL_DEBUG_SOURCE_OTHER: begin
      MsgSource := 'OTHER';
    end;
  end;

  // Type of this message
  case type_ of
    GL_DEBUG_TYPE_ERROR: begin
      MsgType := 'ERROR';
    end;
    GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR: begin
      MsgType := 'DEPRECATED_BEHAVIOR';
    end;
    GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR: begin
      MsgType := 'UNDEFINED_BEHAVIOR';
    end;
    GL_DEBUG_TYPE_PORTABILITY: begin
      MsgType := 'PORTABILITY';
    end;
    GL_DEBUG_TYPE_PERFORMANCE: begin
      MsgType := 'PERFORMANCE';
    end;
    GL_DEBUG_TYPE_OTHER: begin
      MsgType := 'OTHER';
    end;
  end;

  // Severity of this message
  case severity of
    GL_DEBUG_SEVERITY_HIGH: begin
      MsgSeverity := 'HIGH';
      col := clBrightRed;
    end;
    GL_DEBUG_SEVERITY_MEDIUM: begin
      MsgSeverity := 'MEDIUM';
      col := clBrightYellow;
    end;
    GL_DEBUG_SEVERITY_LOW: begin
      MsgSeverity := 'LOW';
      col := clBrightWhite;
    end;
    else begin
      col := clWhite;
    end;
  end;

  LogForm.Add('DEBUG: ' + Format('%s %s [%s] : %s', [MsgSource, MsgType, MsgSeverity, message_]), col);
end;

procedure InitOpenGLDebug;
begin
  glEnable(GL_DEBUG_OUTPUT);
  glDebugMessageCallback(@GLDebugCallBack, nil);
  glDebugMessageControl(GL_DONT_CARE, GL_DONT_CARE, GL_DONT_CARE, 0, nil, True);
end;

// --- Debuger Ende ---

procedure checkError(command: string);
var
  err: integer;
begin
  err := glGetError();
  if err <> 0 then begin
    // GL_INVALID_ENUM
    LogForm.Add('Fehler-Nr: $' + IntToHex(err, 4) + ' (' + IntToStr(err) + ') bei: ' + command);
    //    LogForm.Show;
  end;
end;



procedure TLogForm.Add(s: string; fg: byte; bg: byte);
begin
  {$I-}// Wegen Windows
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
  Add(Comment, clGreen);
  Add('');
end;

initialization

  LogForm := TLogForm.Create;

finalization

  LogForm.Free;

end.
