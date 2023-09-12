program project1;

  {$ModeSwitch implicitfunctionspecialization}

  generic procedure Swap<T>(var a, b: T);
  var
    pa: PtrUInt absolute a;
    pb: PtrUInt absolute b;
  begin
    pa := pa xor pb;
    pb := pb xor pa;
    pa := pa xor pb;
  end;

  generic procedure Swap2<T>(var a, b: T);
  var
    c: T;
  begin
    c := a;
    a := b;
    b := c;
  end;

  generic procedure Swap3<T>(var a, b: T);
  var
    pa: PtrUInt absolute a;
    pb: PtrUInt absolute b;
    pc: PtrInt;
  begin
    pc := pa;
    pa := pb;
    pb := pc;
  end;

var
  b1: byte = 12;
  b2: byte = 45;
  f1: single = 123;
  f2: single = 456;
  s1: string = 'World !';
  s2: string = 'Hello ';

type
  TtestRec = record
    b: byte;
    f: double;
    s: string;
    i: integer
  end;

var
  r1: TtestRec = (b: 1; f: 11.11; s: 'str111'; i: 111);
  r2: TtestRec = (b: 2; f: 22.22; s: 'str222'; i: 222);

begin
  Swap(b1, b2);
  WriteLn(b1, '  ', b2);

  Swap(f1, f2);
  WriteLn(f1, '  ', f2);

  Swap(s1, s2);
  WriteLn(s1, s2);

  Swap(r1, r2);
  WriteLn(
    r1.b, ' ', r1.f: 10: 5, ' ', r1.s, ' ', r1.i, ' --- ',
    r2.b, ' ', r2.f: 10: 5, ' ', r2.s, ' ', r2.i);
end.
