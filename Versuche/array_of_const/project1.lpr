
program project1;


  procedure Test(ar: array of const);
  var
    i: integer;
    t: TVarRec;
  begin
    t:= ar[0];
    WriteLn(PtrUInt(t.VInteger));

    WriteLn(SizeOf(t));
    for i := 0 to Length(ar) - 1 do begin
      case ar[i].VType of
        vtInteger: begin
          WriteLn('int: ', ar[i].VInteger);
        end;
        vtBoolean: begin
          WriteLn(' boolean: ', ar[i].VBoolean);
        end;
        vtAnsiString: begin
          WriteLn('ansistring: ', string(ar[i].VAnsiString));
        end;
        else begin
          WriteLn('unknow: ', ar[i].VType);
        end;
      end;
    end;
  end;

procedure rec(vr:TVarRec);
begin

end;

begin
  test([1, 2, 3, 4, True, 'aaa']);
//  rec(TVarRec( 123).VInteger);
end.
