unit ftdrv;

interface

uses
 integer_types, fttypes, ftsystem, ftimage;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type

//  TFT_Face_InitFunc = function (stream:TFT_Stream; face:TFT_Face; typeface_index:TFT_Int; num_params:TFT_Int; parameters:PFT_Parameter):TFT_Error;cdecl;
  //TFT_Face_DoneFunc = procedure (face:TFT_Face);cdecl;
  //TFT_Size_InitFunc = function (size:TFT_Size):TFT_Error;cdecl;
  //TFT_Size_DoneFunc = procedure (size:TFT_Size);cdecl;
  //TFT_Slot_InitFunc = function (slot:TFT_GlyphSlot):TFT_Error;cdecl;
  //TFT_Slot_DoneFunc = procedure (slot:TFT_GlyphSlot);cdecl;
  //TFT_Size_RequestFunc = function (size:TFT_Size; req:TFT_Size_Request):TFT_Error;cdecl;
  //TFT_Size_SelectFunc = function (size:TFT_Size; size_index:TFT_ULong):TFT_Error;cdecl;
  //TFT_Slot_LoadFunc = function (slot:TFT_GlyphSlot; size:TFT_Size; glyph_index:TFT_UInt; load_flags:TFT_Int32):TFT_Error;cdecl;
  //TFT_Face_GetKerningFunc = function (face:TFT_Face; left_glyph:TFT_UInt; right_glyph:TFT_UInt; kerning:PFT_Vector):TFT_Error;cdecl;
  //TFT_Face_AttachFunc = function (face:TFT_Face; stream:TFT_Stream):TFT_Error;cdecl;
  TFT_Face_InitFunc = function (stream:TFT_Stream; face:Pointer; typeface_index:TFT_Int; num_params:TFT_Int; parameters:Pointer):TFT_Error;cdecl;
  TFT_Face_DoneFunc = procedure (face:Pointer);cdecl;
  TFT_Size_InitFunc = function (size:Pointer):TFT_Error;cdecl;
  TFT_Size_DoneFunc = procedure (size:Pointer);cdecl;
  TFT_Slot_InitFunc = function (slot:Pointer):TFT_Error;cdecl;
  TFT_Slot_DoneFunc = procedure (slot:Pointer);cdecl;
  TFT_Size_RequestFunc = function (size:Pointer; req:Pointer):TFT_Error;cdecl;
  TFT_Size_SelectFunc = function (size:Pointer; size_index:TFT_ULong):TFT_Error;cdecl;
  TFT_Slot_LoadFunc = function (slot:Pointer; size:Pointer; glyph_index:TFT_UInt; load_flags:TFT_Int32):TFT_Error;cdecl;
  TFT_Face_GetKerningFunc = function (face:Pointer; left_glyph:TFT_UInt; right_glyph:TFT_UInt; kerning:PFT_Vector):TFT_Error;cdecl;
  TFT_Face_AttachFunc = function (face:Pointer; stream:TFT_Stream):TFT_Error;cdecl;
  TFT_Face_GetAdvancesFunc = function (face:Pointer; first:TFT_UInt; count:TFT_UInt; flags:TFT_Int32; advances:PFT_Fixed):TFT_Error;cdecl;
{*************************************************************************
   *
   * @struct:
   *   FT_Driver_ClassRec
   *
   * @description:
   *   The font driver class.  This structure mostly contains pointers to
   *   driver methods.
   *
   * @fields:
   *   root ::
   *     The parent module.
   *
   *   face_object_size ::
   *     The size of a face object in bytes.
   *
   *   size_object_size ::
   *     The size of a size object in bytes.
   *
   *   slot_object_size ::
   *     The size of a glyph object in bytes.
   *
   *   init_face ::
   *     The format-specific face constructor.
   *
   *   done_face ::
   *     The format-specific face destructor.
   *
   *   init_size ::
   *     The format-specific size constructor.
   *
   *   done_size ::
   *     The format-specific size destructor.
   *
   *   init_slot ::
   *     The format-specific slot constructor.
   *
   *   done_slot ::
   *     The format-specific slot destructor.
   *
   *
   *   load_glyph ::
   *     A function handle to load a glyph to a slot.  This field is
   *     mandatory!
   *
   *   get_kerning ::
   *     A function handle to return the unscaled kerning for a given pair of
   *     glyphs.  Can be set to 0 if the format doesn't support kerning.
   *
   *   attach_file ::
   *     This function handle is used to read additional data for a face from
   *     another file/stream.  For example, this can be used to add data from
   *     AFM or PFM files on a Type 1 face, or a CIDMap on a CID-keyed face.
   *
   *   get_advances ::
   *     A function handle used to return advance widths of 'count' glyphs
   *     (in font units), starting at 'first'.  The 'vertical' flag must be
   *     set to get vertical advance heights.  The 'advances' buffer is
   *     caller-allocated.  The idea of this function is to be able to
   *     perform device-independent text layout without loading a single
   *     glyph image.
   *
   *   request_size ::
   *     A handle to a function used to request the new character size.  Can
   *     be set to 0 if the scaling done in the base layer suffices.
   *
   *   select_size ::
   *     A handle to a function used to select a new fixed size.  It is used
   *     only if @FT_FACE_FLAG_FIXED_SIZES is set.  Can be set to 0 if the
   *     scaling done in the base layer suffices.
   *
   * @note:
   *   Most function pointers, with the exception of `load_glyph`, can be set
   *   to 0 to indicate a default behaviour.
    }
{ since version 2.2  }

  PFT_Driver_ClassRec_ = ^TFT_Driver_ClassRec_;
  TFT_Driver_ClassRec_ = record
      root : Pointer;
//      root : TFT_Module_Class;
      face_object_size : TFT_Long;
      size_object_size : TFT_Long;
      slot_object_size : TFT_Long;
      init_face : TFT_Face_InitFunc;
      done_face : TFT_Face_DoneFunc;
      init_size : TFT_Size_InitFunc;
      done_size : TFT_Size_DoneFunc;
      init_slot : TFT_Slot_InitFunc;
      done_slot : TFT_Slot_DoneFunc;
      load_glyph : TFT_Slot_LoadFunc;
      get_kerning : TFT_Face_GetKerningFunc;
      attach_file : TFT_Face_AttachFunc;
      get_advances : TFT_Face_GetAdvancesFunc;
      request_size : TFT_Size_RequestFunc;
      select_size : TFT_Size_SelectFunc;
    end;
  TFT_Driver_ClassRec = TFT_Driver_ClassRec_;
  PFT_Driver_ClassRec = ^TFT_Driver_ClassRec;
  TFT_Driver_Class = PFT_Driver_ClassRec_;
  PFT_Driver_Class = ^TFT_Driver_Class;
{*************************************************************************
   *
   * @macro:
   *   FT_DECLARE_DRIVER
   *
   * @description:
   *   Used to create a forward declaration of an FT_Driver_ClassRec struct
   *   instance.
   *
   * @macro:
   *   FT_DEFINE_DRIVER
   *
   * @description:
   *   Used to initialize an instance of FT_Driver_ClassRec struct.
   *
   *   `ftinit.c` (ft_create_default_module_classes) already contains a
   *   mechanism to call these functions for the default modules described in
   *   `ftmodule.h`.
   *
   *   The struct will be allocated in the global scope (or the scope where
   *   the macro is used).
    }
{#define FT_DECLARE_DRIVER( class_ )  \ }
{//  FT_CALLBACK_TABLE                  \ }
{const FT_Driver_ClassRec  class_; }
{
#define FT_DEFINE_DRIVER(                    \
          class_,                            \
          flags_,                            \
          size_,                             \
          name_,                             \
          version_,                          \
          requires_,                         \
          interface_,                        \
          init_,                             \
          done_,                             \
          get_interface_,                    \
          face_object_size_,                 \
          size_object_size_,                 \
          slot_object_size_,                 \
          init_face_,                        \
          done_face_,                        \
          init_size_,                        \
          done_size_,                        \
          init_slot_,                        \
          done_slot_,                        \
          load_glyph_,                       \
          get_kerning_,                      \
          attach_file_,                      \
          get_advances_,                     \
          request_size_,                     \
          select_size_ )                     \
  FT_CALLBACK_TABLE_DEF                      \
  const FT_Driver_ClassRec  class_ =         \
                                            \
    FT_DEFINE_ROOT_MODULE( flags_,           \
                           size_,            \
                           name_,            \
                           version_,         \
                           requires_,        \
                           interface_,       \
                           init_,            \
                           done_,            \
                           get_interface_ )  \
                                             \
    face_object_size_,                       \
    size_object_size_,                       \
    slot_object_size_,                       \
                                             \
    init_face_,                              \
    done_face_,                              \
                                             \
    init_size_,                              \
    done_size_,                              \
                                             \
    init_slot_,                              \
    done_slot_,                              \
                                             \
    load_glyph_,                             \
                                             \
    get_kerning_,                            \
    attach_file_,                            \
    get_advances_,                           \
                                             \
    request_size_,                           \
    select_size_                             \
  ;

 }

implementation

end.
