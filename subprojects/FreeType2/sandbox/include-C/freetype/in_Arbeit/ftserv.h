#ifndef FTSERV_H_
#define FTSERV_H_

#include "compiler-macros.h"


  typedef struct  FT_ServiceDescRec_
  {
    const char*  serv_id;     /* service name         */
    const void*  serv_data;   /* service pointer/data */

  } FT_ServiceDescRec;

  typedef const FT_ServiceDescRec*  FT_ServiceDesc;


   FT_Pointer 
  ft_service_list_lookup( FT_ServiceDesc  service_descriptors,
                          const char*     service_id );


  typedef struct  FT_ServiceCacheRec_
  {
    FT_Pointer  service_POSTSCRIPT_FONT_NAME;
    FT_Pointer  service_MULTI_MASTERS;
    FT_Pointer  service_METRICS_VARIATIONS;
    FT_Pointer  service_GLYPH_DICT;
    FT_Pointer  service_PFR_METRICS;
    FT_Pointer  service_WINFNT;

  } FT_ServiceCacheRec, *FT_ServiceCache;



