program project1;
uses
ctypes;

const
  {$IFDEF Linux}
  libc = 'c';
  {$ENDIF}

  {$IFDEF Windows}
//  libc = 'msvcrt.dll';
  libc = 'ucrtbase.dll';

  {$ENDIF}

const
  LC_CTYPE = 0;
  LC_NUMERIC = 1;
  LC_TIME = 2;
  LC_COLLATE = 3;
  LC_MONETARY = 4;
  LC_MESSAGES = 5;
  LC_ALL = 6;
  LC_PAPER = 7;
  LC_NAME = 8;
  LC_ADDRESS = 9;
  LC_TELEPHONE = 10;
  LC_MEASUREMENT = 11;
  LC_IDENTIFICATION = 12;


  function setlocale(catogory: cint; locale: PChar): PChar; cdecl; external libc;

begin
  WriteLn('Anfang');
//  WriteLn(setlocale(LC_ALL, '.UTF8'));
  WriteLn(setlocale(LC_ALL, ''));
  WriteLn('Ende');
end.

