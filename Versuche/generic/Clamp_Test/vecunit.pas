unit vecunit;

{$mode ObjFPC}{$H+}
{$ModeSwitch advancedrecords}
{$modeswitch typehelpers}
{$ModeSwitch implicitfunctionspecialization}



interface

uses
  Classes, SysUtils;

type
  GLfloat = single;

type

  { TVector }

  generic TVector<const dim: SizeInt; T> = record
  private
    type
      TSelfType = specialize TVector<Dim, T>;
      TFieldArray = array[0..dim - 1] of T;
      TSelfVec2Type = array[0..1] of T;
    var
      Fields: TFieldArray;
    function GetData(AIndex: integer): T;
    function GetX: T;
    function GetXY: TSelfVec2Type;
    function GetY: T;
    function GetZ: T;
    procedure SetData(AIndex: integer; AValue: T);
    procedure SetX(AValue: T);
    procedure SetXY(AValue: TSelfVec2Type);
    procedure SetY(AValue: T);
    procedure SetZ(AValue: T);
  public
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

implementation

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
  if dim = 2 then  begin
    Result[1] := Fields[1];
  end;
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

end.
