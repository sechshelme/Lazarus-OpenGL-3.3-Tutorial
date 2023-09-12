program project1;

  {$ModeSwitch advancedrecords}
  {$modeswitch typehelpers}
  {$ModeSwitch implicitfunctionspecialization}

uses
  vecunit;

var
  v, vmin, vmax, vc: TVector2f;
  vi0, vi1: Tvector2i;
  i: integer;

  //  function min(a,b:TVector):TVector;
  //  begin
  //  end;


begin

  //for i := 0 to 50 do begin
  vmin := [10 div 2, 10];
  vmax := [20, 30];
  v := vmin + vmax;
  WriteLn('x: ', v[0]: 10, '  y: ', v[1]: 10);


  vi0 := [1, 2];
  vi1 := vi0 / vi0;
  WriteLn('x: ', vi1[0]: 10, '  y: ', vi1[1]: 10);
  WriteLn('x: ', vi1.x: 10, '  y: ', vi1.y: 10);
  WriteLn('x: ', vi1.xy[0]: 10, '  y: ', vi1.xy[1]: 10);

end.
