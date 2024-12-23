unit graphene;

interface

uses
  ctypes;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

const
  {$IFDEF Linux}
  libgraphene = 'libgraphene-1.0';
  {$ENDIF}

  {$IFDEF Windows}
  libgraphene = 'libgraphene-1.0-1.dll';
  {$ENDIF}

type
  TGType = longint;

implementation


end.
