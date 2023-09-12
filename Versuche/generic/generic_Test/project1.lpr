program project1;

  {$ModeSwitch advancedrecords}
  {$modeswitch typehelpers}
  {$ModeSwitch implicitfunctionspecialization}

type
  generic TArray<T> = class
    Items: array of T;
    procedure Add(Value: T);
  end;

  procedure TArray.Add(Value: T);
  begin
    SetLength(Items, Length(Items) + 1);
    Items[Length(Items) - 1] := Value;
  end;

type
  Tba = specialize TArray<Integer>;

var
  ba: Tba;
  i: integer;

begin
  writeln('xxxxxx');
  ba.add(1);
  writeln('yyyyyy');
  writeln('...', length(ba.items));
  for i := 0 to length(ba.items) - 1 do begin
    Write(ba.items[i], '  ');
  end;
end.
