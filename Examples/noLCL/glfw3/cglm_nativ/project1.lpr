program project1;

{$CODEALIGN LOCALMIN=16}

const
  {$IFDEF Linux}
  libcglm = 'cglm';
  {$ENDIF}

  {$IFDEF Windows}
  libcglm = 'libcglm-0.dll';
  {$ENDIF}

type
  Tvec4 = array[0..3] of single;
  Tmat4 = array[0..3] of Tvec4;

  procedure glmc_mat4_identity(mat: Tmat4); cdecl; external libcglm;


  procedure printMatrix(const m: Tmat4);
  var
    y, x: integer;
  begin
    for y := 0 to 3 do begin
      for x := 0 to 3 do begin
        Write(m[y, x]: 4: 2, ' ');
      end;
      WriteLn();
    end;
    WriteLn();
  end;

  procedure main;
  var
    mat_ID: integer;
    m: Tmat4;
    i2: integer;
  begin
    glmc_mat4_identity(m);
    printMatrix(m);
  end;

begin
  main;
end.
