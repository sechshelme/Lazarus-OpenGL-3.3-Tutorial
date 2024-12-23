unit graphene_version;

interface

uses
  ctypes, graphene;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

const
  GRAPHENE_MAJOR_VERSION = 1;
  GRAPHENE_MINOR_VERSION = 10;
  GRAPHENE_MICRO_VERSION = 8;

implementation


end.
