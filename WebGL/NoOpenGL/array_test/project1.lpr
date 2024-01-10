program project1;

uses
  JS,
  Classes,
  SysUtils,
  Web,
  browserconsole;

  procedure onload;
  type
    TCharArray = array of char;
    TByteArray = array of byte;
  var
    ba: TByteArray;
    ca: TCharArray;
    i: integer;

  var
    ch: char;
    by:Byte;
  begin
    ch := #65;
    Writeln(ch);
    by:=Byte(ch);
    Writeln(by);

    SetLength(ca, 10);

    for i := 0 to Length(ca) - 1 do begin
      ca[i] := char(byte('A') + i);
    end;

    ba := TByteArray(ca);

    Writeln('ba: ', Length(ba));
    Writeln('ca: ', Length(ca));
    for i := 0 to Length(ba) - 1 do begin
      Write(ba[i], ' - ');
    end;
    Writeln;
    for i := 0 to Length(ca) - 1 do begin
      Write(ca[i], ' - ');
    end;
  end;

begin
  onload;
end.
