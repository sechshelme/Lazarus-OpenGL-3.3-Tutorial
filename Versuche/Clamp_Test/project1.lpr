program project1;

type
  GLfloat = single;
  TVector2f = array[0..1] of single;

  function vec2(x, y: GLfloat): TVector2f; inline;
  begin
    Result[0] := x;
    Result[1] := y;
  end;

  function Vec2Len(v: TVector2f): GLfloat;
  begin
    Result := sqrt(sqr(v[0]) + sqr(v[1]));
  end;



  function min(a, b: GLfloat): GLfloat; inline;
  begin
    if a < b then begin
      Result := a;
    end else begin
      Result := b;
    end;
  end;

  function min(const a, b: TVector2f): TVector2f; inline;
  begin
    if Vec2Len(a) < Vec2Len(b) then begin
      Result := a;
    end else begin
      Result := b;
    end;
  end;

  function min2(const a, b: TVector2f): TVector2f; inline;
  begin
    Result[0] := min(a[0], b[0]);
    Result[1] := min(a[1], b[1]);
  end;

  function max(a, b: GLfloat): GLfloat; inline;
  begin
    if a > b then begin
      Result := a;
    end else begin
      Result := b;
    end;
  end;

  function max(const a, b: TVector2f): TVector2f; inline;
  begin
    if Vec2Len(a) < Vec2Len(b) then begin
      Result := a;
    end else begin
      Result := b;
    end;
  end;

  function clamp(x, minVal, maxVal: GLfloat): GLfloat; inline;
  begin
    //  Result:=min(minVal, max(maxVal, x));
    if x < minVal then begin
      Result := minVal;
    end else if x > maxVal then begin
      Result := maxVal;
    end else begin
      Result := x;
    end;
  end;

  function clamp(const x, minVal, maxVal: TVector2f): TVector2f;
  var
    xl: GLfloat;
  begin
    xl := Vec2Len(x);
    if xl < Vec2Len(minVal) then begin
      Result := minVal;
    end else if xl > Vec2Len(maxVal) then begin
      Result := maxVal;
    end else begin
      Result := x;
    end;
  end;

  function clamp2(const x, minVal, maxVal: TVector2f): TVector2f;
  begin
    Result[0] := min(max(x[0], minVal[0]), maxVal[0]);
    Result[1] := min(max(x[1], minVal[1]), maxVal[1]);
  end;

  function mix1(x, y, a: GLfloat): GLfloat;
  begin
    Result := x + (y - x) * a;
    WriteLn(Result: 10: 5);
  end;

  function mix2(x, y, a: GLfloat): GLfloat;
  begin
    Result := x * (1 - a) + y * a;
    WriteLn(Result: 10: 5);
  end;

var
  v, vmin, vmax, vc: TVector2f;
  i: integer;
begin
  for i := 0 to 50 do begin
    v := vec2(i / 10, i / 10);
    vmin := vec2(0.5, 0.5);
    vmax := vec2(1, 1);
    vc := clamp2(v, vmin, vmax);
    WriteLn('x: ', vc[0]: 10: 5, '  y: ', vc[1]: 10: 5);
  end;
  mix1(-4, -6, -0.5);
  mix2(-4, -6, -0.5);

end.
