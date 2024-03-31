program project1;

{$IFDEF UNIX}
const
  glLib='GL';
{$ENDIF}

{$IFDEF WINDOWS}
const
  glLib='opengl32.dll';
{$ENDIF}

procedure glClear(mask: DWord); stdcall; external glLib;
procedure glEnableVertexAttribArray(index: Integer); cdecl; external glLib;

begin
  glClear(0);
  glEnableVertexAttribArray(0);
end.
