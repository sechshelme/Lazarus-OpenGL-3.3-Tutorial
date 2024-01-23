unit oglDebug;

interface

uses SysUtils, dglOpenGL;

type

  { TLogForm }

  TLogForm = class(TObject)
  public
    procedure Add(s: string);
    procedure AddAndTitle(Title, Comment: string);
  end;

var
  LogForm: TLogForm;

procedure InitOpenGLDebug;
procedure checkError(command: string);

{$push,}{$J-}
const
  clNormal = '0';
  clBlack = '30';
  clRed = '31';
  clGreen = '32';
  clYellow = '33';
  clBlurw = '34';
  clMagenta = '35';
  clCyan = '36';
  clWhite = '37';
  clBrightBlack = '90';
  clBrightRed = '91';
  clBrightGree = '92';
  clBrightYellow = '93';
  clBrightBlue = '94';
  clBrightMagenta = '95';
  clBrightCyan = '96';
  clBrightWhite = '97';

const
  StrNormal = #27'[' + clNormal + 'm';
  StrBrightRed = #27'[' + clBrightRed + 'm';
  StrGreen = #27'[' + clGreen + 'm';
  {$J+}{$pop}

implementation

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
      MsgSeverity := StrBrightRed + '[HIGH]' + StrNormal;
    end;
    GL_DEBUG_SEVERITY_MEDIUM: begin
      MsgSeverity := '[MEDIUM]';
    end;
    GL_DEBUG_SEVERITY_LOW: begin
      MsgSeverity := '[LOW]';
    end;
  end;

  LogForm.Add('DEBUG: ' + MsgSource + '  ' + MsgType + '  ' + MsgSeverity + '  ' + message_);
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
    LogForm.Add('Fehler-Nr: $' + IntToHex(err, 4) + ' (' + IntToStr(err) + ') bei: ' + command);
  end;
end;

procedure TLogForm.Add(s: string);
begin
  {$I-}// Wegen Windows
  WriteLn(s);
  {$I+}
end;

procedure TLogForm.AddAndTitle(Title, Comment: string);
begin
  Add(StrBrightRed + Title + StrNormal);
  Add(StringOfChar('=', Length(Title)));
  Add('');
  Add(StrGreen + Comment + StrNormal);
  Add('');
end;

initialization

  LogForm := TLogForm.Create;

finalization

  LogForm.Free;

end.
