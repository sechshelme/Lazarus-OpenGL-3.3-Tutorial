program project1;

{$L test.o}
function myfunc(): Integer; cdecl; external;
begin
  WriteLn(myfunc());
end.
