unit ftmemory;

interface

uses
  ftsystem,fttypes;


{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

function FT_SET_ERROR(expression : longint) : longint;

{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{***                                                                 *** }
{***                                                                 *** }
{***                           M E M O R Y                           *** }
{***                                                                 *** }
{***                                                                 *** }
{*********************************************************************** }
{*********************************************************************** }
{*********************************************************************** }
{ The calculation `NULL + n' is undefined in C.  Even if the resulting  }
{ pointer doesn't get dereferenced, this causes warnings with           }
{ sanitizers.                                                           }
{                                                                       }
{ We thus provide a macro that should be used if `base' can be NULL.    }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_OFFSET(base,count : longint) : longint;

{
   * C++ refuses to handle statements like p = (void*)anything, with `p' a
   * typed pointer.  Since we don't have a `typeof' operator in standard C++,
   * we have to use a template to emulate it.
    }
{#define FT_ASSIGNP( p, val )  (p) = (val) }
{$ifdef FT_DEBUG_MEMORY}
(* Const before type ignored *)
  var
    ft_debug_file_ : Pchar;cvar;public;
    ft_debug_lineno_ : longint;cvar;public;
{#define FT_DEBUG_INNER( exp )  ( ft_debug_file_   = __FILE__, \
                                 ft_debug_lineno_ = __LINE__, \
                                 (exp) )

#define FT_ASSIGNP_INNER( p, exp )  ( ft_debug_file_   = __FILE__, \
                                      ft_debug_lineno_ = __LINE__, \
                                      FT_ASSIGNP( p, exp ) )
 }
{$else}
{ !FT_DEBUG_MEMORY  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function FT_DEBUG_INNER(exp : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ASSIGNP_INNER(p,exp : longint) : longint;

{$endif}
{ !FT_DEBUG_MEMORY  }
{
   * The allocation functions return a pointer, and the error code is written
   * to through the `p_error' parameter.
    }
{ The `q' variants of the functions below (`q' for `quick') don't fill  }
{ the allocated or reallocated memory with zero bytes.                  }

function ft_mem_alloc(memory:TFT_Memory; size:TFT_Long; p_error:PFT_Error):TFT_Pointer;cdecl;external;
function ft_mem_qalloc(memory:TFT_Memory; size:TFT_Long; p_error:PFT_Error):TFT_Pointer;cdecl;external;
function ft_mem_realloc(memory:TFT_Memory; item_size:TFT_Long; cur_count:TFT_Long; new_count:TFT_Long; block:pointer; 
           p_error:PFT_Error):TFT_Pointer;cdecl;external;
function ft_mem_qrealloc(memory:TFT_Memory; item_size:TFT_Long; cur_count:TFT_Long; new_count:TFT_Long; block:pointer; 
           p_error:PFT_Error):TFT_Pointer;cdecl;external;
(* Const before type ignored *)
procedure ft_mem_free(memory:TFT_Memory; P:pointer);cdecl;external;
{ The `Q' variants of the macros below (`Q' for `quick') don't fill  }
{ the allocated or reallocated memory with zero bytes.               }
{#define FT_MEM_ALLOC( ptr, size )                               \
          FT_ASSIGNP_INNER( ptr, ft_mem_alloc( memory,          \
                                               (FT_Long)(size), \
                                               &error ) )

#define FT_MEM_FREE( ptr )                                  \
          FT_BEGIN_STMNT                                    \
            FT_DEBUG_INNER( ft_mem_free( memory, (ptr) ) ); \
            (ptr) = NULL;                                   \
          FT_END_STMNT

#define FT_MEM_NEW( ptr )                        \
          FT_MEM_ALLOC( ptr, sizeof ( *(ptr) ) )

#define FT_MEM_REALLOC( ptr, cursz, newsz )                        \
          FT_ASSIGNP_INNER( ptr, ft_mem_realloc( memory,           \
                                                 1,                \
                                                 (FT_Long)(cursz), \
                                                 (FT_Long)(newsz), \
                                                 (ptr),            \
                                                 &error ) )

#define FT_MEM_QALLOC( ptr, size )                               \
          FT_ASSIGNP_INNER( ptr, ft_mem_qalloc( memory,          \
                                                (FT_Long)(size), \
                                                &error ) )

#define FT_MEM_QNEW( ptr )                        \
          FT_MEM_QALLOC( ptr, sizeof ( *(ptr) ) )

#define FT_MEM_QREALLOC( ptr, cursz, newsz )                        \
          FT_ASSIGNP_INNER( ptr, ft_mem_qrealloc( memory,           \
                                                  1,                \
                                                  (FT_Long)(cursz), \
                                                  (FT_Long)(newsz), \
                                                  (ptr),            \
                                                  &error ) )

#define FT_MEM_ALLOC_MULT( ptr, count, item_size )                     \
          FT_ASSIGNP_INNER( ptr, ft_mem_realloc( memory,               \
                                                 (FT_Long)(item_size), \
                                                 0,                    \
                                                 (FT_Long)(count),     \
                                                 NULL,                 \
                                                 &error ) )

#define FT_MEM_REALLOC_MULT( ptr, oldcnt, newcnt, itmsz )           \
          FT_ASSIGNP_INNER( ptr, ft_mem_realloc( memory,            \
                                                 (FT_Long)(itmsz),  \
                                                 (FT_Long)(oldcnt), \
                                                 (FT_Long)(newcnt), \
                                                 (ptr),             \
                                                 &error ) )

#define FT_MEM_QALLOC_MULT( ptr, count, item_size )                     \
          FT_ASSIGNP_INNER( ptr, ft_mem_qrealloc( memory,               \
                                                  (FT_Long)(item_size), \
                                                  0,                    \
                                                  (FT_Long)(count),     \
                                                  NULL,                 \
                                                  &error ) )

#define FT_MEM_QREALLOC_MULT( ptr, oldcnt, newcnt, itmsz )           \
          FT_ASSIGNP_INNER( ptr, ft_mem_qrealloc( memory,            \
                                                  (FT_Long)(itmsz),  \
                                                  (FT_Long)(oldcnt), \
                                                  (FT_Long)(newcnt), \
                                                  (ptr),             \
                                                  &error ) )


#define FT_MEM_SET_ERROR( cond )  ( (cond), error != 0 )


#define FT_MEM_SET( dest, byte, count )               \
          ft_memset( dest, byte, (FT_Offset)(count) )

#define FT_MEM_COPY( dest, source, count )              \
          ft_memcpy( dest, source, (FT_Offset)(count) )

#define FT_MEM_MOVE( dest, source, count )               \
          ft_memmove( dest, source, (FT_Offset)(count) )


#define FT_MEM_ZERO( dest, count )  FT_MEM_SET( dest, 0, count )

#define FT_ZERO( p )                FT_MEM_ZERO( p, sizeof ( *(p) ) )


#define FT_ARRAY_ZERO( dest, count )                             \
          FT_MEM_ZERO( dest,                                     \
                       (FT_Offset)(count) * sizeof ( *(dest) ) )

#define FT_ARRAY_COPY( dest, source, count )                     \
          FT_MEM_COPY( dest,                                     \
                       source,                                   \
                       (FT_Offset)(count) * sizeof ( *(dest) ) )

#define FT_ARRAY_MOVE( dest, source, count )                     \
          FT_MEM_MOVE( dest,                                     \
                       source,                                   \
                       (FT_Offset)(count) * sizeof ( *(dest) ) ) }
{
   * Return the maximum number of addressable elements in an array.  We limit
   * ourselves to INT_MAX, rather than UINT_MAX, to avoid any problems.
    }
{#define FT_ARRAY_MAX( ptr )           ( FT_INT_MAX / sizeof ( *(ptr) ) ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ARRAY_CHECK(ptr,count : longint) : longint;

{*************************************************************************
   *
   * The following functions macros expect that their pointer argument is
   * _typed_ in order to automatically compute array element sizes.
    }
{#define FT_MEM_NEW_ARRAY( ptr, count )                              \
          FT_ASSIGNP_INNER( ptr, ft_mem_realloc( memory,            \
                                                 sizeof ( *(ptr) ), \
                                                 0,                 \
                                                 (FT_Long)(count),  \
                                                 NULL,              \
                                                 &error ) )

#define FT_MEM_RENEW_ARRAY( ptr, cursz, newsz )                     \
          FT_ASSIGNP_INNER( ptr, ft_mem_realloc( memory,            \
                                                 sizeof ( *(ptr) ), \
                                                 (FT_Long)(cursz),  \
                                                 (FT_Long)(newsz),  \
                                                 (ptr),             \
                                                 &error ) )

#define FT_MEM_QNEW_ARRAY( ptr, count )                              \
          FT_ASSIGNP_INNER( ptr, ft_mem_qrealloc( memory,            \
                                                  sizeof ( *(ptr) ), \
                                                  0,                 \
                                                  (FT_Long)(count),  \
                                                  NULL,              \
                                                  &error ) )

#define FT_MEM_QRENEW_ARRAY( ptr, cursz, newsz )                     \
          FT_ASSIGNP_INNER( ptr, ft_mem_qrealloc( memory,            \
                                                  sizeof ( *(ptr) ), \
                                                  (FT_Long)(cursz),  \
                                                  (FT_Long)(newsz),  \
                                                  (ptr),             \
                                                  &error ) ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ALLOC(ptr,size : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REALLOC(ptr,cursz,newsz : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ALLOC_MULT(ptr,count,item_size : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REALLOC_MULT(ptr,oldcnt,newcnt,itmsz : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QALLOC(ptr,size : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QREALLOC(ptr,cursz,newsz : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QALLOC_MULT(ptr,count,item_size : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QREALLOC_MULT(ptr,oldcnt,newcnt,itmsz : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FREE(ptr : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_NEW(ptr : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_NEW_ARRAY(ptr,count : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_RENEW_ARRAY(ptr,curcnt,newcnt : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QNEW(ptr : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QNEW_ARRAY(ptr,count : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QRENEW_ARRAY(ptr,curcnt,newcnt : longint) : longint;

(* Const before type ignored *)
function ft_mem_strdup(memory:TFT_Memory; str:Pchar; p_error:PFT_Error):TFT_Pointer;cdecl;external;
(* Const before type ignored *)
function ft_mem_dup(memory:TFT_Memory; address:pointer; size:TFT_ULong; p_error:PFT_Error):TFT_Pointer;cdecl;external;
{#define FT_MEM_STRDUP( dst, str )                                            \ }
{          (dst) = (char*)ft_mem_strdup( memory, (const char*)(str), &error ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_STRDUP(dst,str : longint) : longint;

{#define FT_MEM_DUP( dst, address, size )                                    \ }
{          (dst) = ft_mem_dup( memory, (address), (FT_ULong)(size), &error ) }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DUP(dst,address,size : longint) : longint;

{ Return >= 1 if a truncation occurs.             }
{ Return 0 if the source string fits the buffer.  }
{ This is *not* the same as strlcpy().            }
(* Const before type ignored *)
function ft_mem_strcpyn(dst:Pchar; src:Pchar; size:TFT_ULong):TFT_Int;cdecl;external;
(* Const before type ignored *)
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_STRCPYN(dst,src,size : longint) : longint;


implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_SET_ERROR(expression : longint) : longint;
begin
//  FT_SET_ERROR:=(error:=expression)<>0;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_OFFSET(base,count : longint) : longint;
var
   if_local1 : longint;
(* result types are not known *)
begin
//  if base then
//    if_local1:=Tbase(+(count))
//  else
//    if_local1:=NULL;
//  FT_OFFSET:=if_local1;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DEBUG_INNER(exp : longint) : longint;
begin
  FT_DEBUG_INNER:=exp;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ASSIGNP_INNER(p,exp : longint) : longint;
begin
//  FT_ASSIGNP_INNER:=FT_ASSIGNP(p,exp);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ARRAY_CHECK(ptr,count : longint) : longint;
begin
//  FT_ARRAY_CHECK:=count<=(FT_ARRAY_MAX(ptr));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ALLOC(ptr,size : longint) : longint;
begin
//  FT_ALLOC:=FT_MEM_SET_ERROR(FT_MEM_ALLOC(ptr,size));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REALLOC(ptr,cursz,newsz : longint) : longint;
begin
//  FT_REALLOC:=FT_MEM_SET_ERROR(FT_MEM_REALLOC(ptr,cursz,newsz));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_ALLOC_MULT(ptr,count,item_size : longint) : longint;
begin
//  FT_ALLOC_MULT:=FT_MEM_SET_ERROR(FT_MEM_ALLOC_MULT(ptr,count,item_size));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_REALLOC_MULT(ptr,oldcnt,newcnt,itmsz : longint) : longint;
begin
//  FT_REALLOC_MULT:=FT_MEM_SET_ERROR(FT_MEM_REALLOC_MULT(ptr,oldcnt,newcnt,itmsz));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QALLOC(ptr,size : longint) : longint;
begin
//  FT_QALLOC:=FT_MEM_SET_ERROR(FT_MEM_QALLOC(ptr,size));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QREALLOC(ptr,cursz,newsz : longint) : longint;
begin
//  FT_QREALLOC:=FT_MEM_SET_ERROR(FT_MEM_QREALLOC(ptr,cursz,newsz));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QALLOC_MULT(ptr,count,item_size : longint) : longint;
begin
//  FT_QALLOC_MULT:=FT_MEM_SET_ERROR(FT_MEM_QALLOC_MULT(ptr,count,item_size));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QREALLOC_MULT(ptr,oldcnt,newcnt,itmsz : longint) : longint;
begin
//  FT_QREALLOC_MULT:=FT_MEM_SET_ERROR(FT_MEM_QREALLOC_MULT(ptr,oldcnt,newcnt,itmsz));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_FREE(ptr : longint) : longint;
begin
  //FT_FREE:=FT_MEM_FREE(ptr);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_NEW(ptr : longint) : longint;
begin
//  FT_NEW:=FT_MEM_SET_ERROR(FT_MEM_NEW(ptr));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_NEW_ARRAY(ptr,count : longint) : longint;
begin
//  FT_NEW_ARRAY:=FT_MEM_SET_ERROR(FT_MEM_NEW_ARRAY(ptr,count));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_RENEW_ARRAY(ptr,curcnt,newcnt : longint) : longint;
begin
//  FT_RENEW_ARRAY:=FT_MEM_SET_ERROR(FT_MEM_RENEW_ARRAY(ptr,curcnt,newcnt));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QNEW(ptr : longint) : longint;
begin
//  FT_QNEW:=FT_MEM_SET_ERROR(FT_MEM_QNEW(ptr));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QNEW_ARRAY(ptr,count : longint) : longint;
begin
//  FT_QNEW_ARRAY:=FT_MEM_SET_ERROR(FT_MEM_QNEW_ARRAY(ptr,count));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_QRENEW_ARRAY(ptr,curcnt,newcnt : longint) : longint;
begin
//  FT_QRENEW_ARRAY:=FT_MEM_SET_ERROR(FT_MEM_QRENEW_ARRAY(ptr,curcnt,newcnt));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_STRDUP(dst,str : longint) : longint;
begin
//  FT_STRDUP:=FT_MEM_SET_ERROR(FT_MEM_STRDUP(dst,str));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_DUP(dst,address,size : longint) : longint;
begin
//  FT_DUP:=FT_MEM_SET_ERROR(FT_MEM_DUP(dst,address,size));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function FT_STRCPYN(dst,src,size : longint) : longint;
begin
//  FT_STRCPYN:=ft_mem_strcpyn(Pchar(dst),Pchar(src),TFT_ULong(size));
end;


end.
