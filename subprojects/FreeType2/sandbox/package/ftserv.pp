unit ftserv;

interface

uses
  fttypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  PFT_ServiceDescRec_ = ^TFT_ServiceDescRec_;
  TFT_ServiceDescRec_ = record
      serv_id : Pchar;
      serv_data : pointer;
    end;
  TFT_ServiceDescRec = TFT_ServiceDescRec_;
  PFT_ServiceDescRec = ^TFT_ServiceDescRec;
(* Const before type ignored *)

  PFT_ServiceDesc = ^TFT_ServiceDesc;
  TFT_ServiceDesc = PFT_ServiceDescRec;
(* Const before type ignored *)

function ft_service_list_lookup(service_descriptors:TFT_ServiceDesc; service_id:Pchar):TFT_Pointer;cdecl;external;
type
  PFT_ServiceCacheRec_ = ^TFT_ServiceCacheRec_;
  TFT_ServiceCacheRec_ = record
      service_POSTSCRIPT_FONT_NAME : TFT_Pointer;
      service_MULTI_MASTERS : TFT_Pointer;
      service_METRICS_VARIATIONS : TFT_Pointer;
      service_GLYPH_DICT : TFT_Pointer;
      service_PFR_METRICS : TFT_Pointer;
      service_WINFNT : TFT_Pointer;
    end;
  TFT_ServiceCacheRec = TFT_ServiceCacheRec_;
  PFT_ServiceCacheRec = ^TFT_ServiceCacheRec;
  TFT_ServiceCache = PFT_ServiceCacheRec_;
  PFT_ServiceCache = ^TFT_ServiceCache;

implementation


end.
