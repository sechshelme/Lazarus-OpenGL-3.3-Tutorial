program project1;

  {$ModeSwitch advancedrecords}
  {$modeswitch typehelpers}
  {$ModeSwitch implicitfunctionspecialization}

type
  GLfloat = single;

type

  { TVector }

  generic TVector<const dim: SizeInt; T> = record
  public
    type
      TSelfType = specialize TVector<Dim, T>;
      TFieldArray = array[0..dim - 1] of T;
      TSelfVec2Type = array[0..1] of T;


  private
    function GetData(AIndex: integer): T;
    function GetX: T;
    function GetXY: TSelfVec2Type;
    function GetY: T;
    function GetZ: T;
    procedure SetData(AIndex: integer; AValue: T);
    procedure SetX(AValue: T);
    procedure SetXY(AValue: TSelfVec2Type);
    //    procedure SetXY(AValue: TVector2f);
    procedure SetY(AValue: T);
    procedure SetZ(AValue: T);
  public
    Fields: TFieldArray;

    class operator +(const rhs, lhs: TSelfType): TSelfType; inline;
    class operator / (const rhs, lhs: TSelfType): TSelfType; inline;
    class operator := (const AFields: TFieldArray): TSelfType; inline;

    property Data[AIndex: integer]: T read GetData write SetData; default;

    property x: T read GetX write SetX;
    property y: T read GetY write SetY;
    property z: T read GetZ write SetZ;
    property xy: TSelfVec2Type read GetXY write SetXY;
  end;

type
  Tvector3f = specialize TVector<3, GLfloat>;
  Tvector2f = specialize TVector<2, GLfloat>;
  Tvector2i = specialize TVector<2, integer>;

  { TVector }

  function TVector.GetData(AIndex: integer): T;
  begin
    Result := Fields[AIndex];
  end;

  function TVector.GetX: GLfloat;
  begin
    Result := Fields[0];
  end;

  function TVector.GetY: GLfloat;
  begin
    Result := Fields[1];
  end;

  function TVector.GetZ: GLfloat;
  begin
    Result := Fields[2];
  end;

  function TVector.GetXY: TSelfVec2Type;
  begin
    Result[0] := Fields[0];
    Result[1] := Fields[1];
  end;

  procedure TVector.SetData(AIndex: integer; AValue: T);
  begin
    Fields[AIndex] := AValue;
  end;

  procedure TVector.SetX(AValue: T);
  begin

  end;

  procedure TVector.SetXY(AValue: TSelfVec2Type);
  begin

  end;

  procedure TVector.SetY(AValue: T);
  begin

  end;

  procedure TVector.SetZ(AValue: T);
  begin

  end;

  class operator TVector. / (const rhs, lhs: TSelfType): TSelfType;
  var
    i: integer;
  begin
    for i := 0 to Dim - 1 do begin
      //      Result.Fields[i] := rhs.Fields[i] / lhs.Fields[i];
    end;
  end;

  class operator TVector. +(const rhs, lhs: TSelfType): TSelfType;
  var
    i: integer;
  begin
    for i := 0 to Dim - 1 do begin
      Result.Fields[i] := rhs.Fields[i] + lhs.Fields[i];
    end;
  end;

  class operator TVector.:=(const AFields: TFieldArray): TSelfType;
  var
    i: integer;
  begin
    for i := 0 to Dim - 1 do begin
      Result.Fields[i] := AFields[i];
    end;
  end;

var
  v, vmin, vmax, vc: TVector2f;
  vi0, vi1: Tvector2i;
  i: integer;

  //  function min(a,b:TVector):TVector;
  //  begin
  //  end;

  generic procedure SwapVar<T>(var a, b: T);
  var
    c: T;
  begin
    c := a;
    a := b;
    b := c;
  end;


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

var
  a: single = 2;
  b: single = 4;

var
  ba: specialize TArray<byte> = nil;



begin
//  ba.add(1);
//  ba.add(2);
 // ba.add(3);
  writeln('sdfdsfd');
  writeln('...',length(ba.items));
  for i := 0 to length(ba.items) - 1 do begin
    Write(ba.items[i], '  ');
  end;
  writeln;


  swapvar(a, b);
  writeln(a, '  ', b);


  //for i := 0 to 50 do begin
  vmin := [10 div 2, 10];
  vmax := [20, 30];
  v := vmin + vmax;
  WriteLn('x: ', v[0]: 10, '  y: ', v[1]: 10);


  vi0 := [1, 2];
  vi1 := vi0 / vi0;
  WriteLn('x: ', vi1[0]: 10, '  y: ', vi1[1]: 10);
  WriteLn('x: ', vi1.x: 10, '  y: ', vi1.y: 10);

end.
