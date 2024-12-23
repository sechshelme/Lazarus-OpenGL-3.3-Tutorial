program project1;

//  #define FT_CONFIG_OPTION_ERROR_STRINGS

{$define FT_CONFIG_OPTION_ERROR_STRINGS}

uses
  ctypes,
  sysutils,
  FreeType2;

  procedure main;
  const
    fontfile = '/usr/share/fonts/truetype/ubuntu/Ubuntu-MI.ttf';
  var
    font_library: TFT_Library;
    font_face: TFT_Face;
    num_chars: TFT_Long;
    cur_glyph: TFT_GlyphSlot;
    bitmap: TFT_Bitmap;
    glyph_metrics: TFT_Glyph_Metrics;
    glyph_ind, i: integer;
    char_name: array[0..255] of char;
    fterror: TFT_Error;

  begin
    fterror:= FT_Init_FreeType(@font_library);
    if fterror <> 0 then begin
      WriteLn('Fehler: FT_Init  ',fterror);
    end;
    fterror:=FT_New_Face(font_library, fontfile, 0, @font_face);
    if fterror <> 0 then begin
      WriteLn('Fehler: FT_New_Face  ',fterror);
    end;
    fterror:=FT_Set_Char_Size(font_face  , 0, 768, 300, 300);
    if fterror <> 0 then begin
      WriteLn('Fehler: FT_Set_Char_Size  ',FT_Error_String(fterror));
    end;

    num_chars := font_face^.num_glyphs;
    WriteLn('num_chars: ', num_chars);

    FT_Set_Transform(font_face, nil, nil);

    //    for glyph_ind := 0 to num_chars - 1 do begin
    for glyph_ind := 0 to 255 do begin
      if FT_Load_Glyph(font_face, glyph_ind, FT_LOAD_DEFAULT) <> 0 then begin
        WriteLn('Fehler: FT_Load_Glyph');
      end;
      cur_glyph := font_face^.glyph;
      if cur_glyph^.format <> FT_GLYPH_FORMAT_BITMAP then begin
        if FT_Render_Glyph(font_face^.glyph, FT_RENDER_MODE_MONO) <> 0 then begin
          WriteLn('Fehler: FT_Render_Glyph');
        end;
      end;
      if FT_Get_Glyph_Name(font_face, glyph_ind, @char_name, 16) <> 0 then begin
        WriteLn('Fehler: FT_Get_Glyph_Name');
      end;

      bitmap := cur_glyph^.bitmap;
      glyph_metrics := cur_glyph^.metrics;

      WriteLn('Glyph ', glyph_ind: 4, '  name ', char_name: 20, ' ',
        glyph_metrics.horiBearingX div 64: 6, ' ',
        glyph_metrics.horiBearingY div 64: 6, ' ',
        glyph_metrics.horiAdvance div 64: 6, ' ',
        bitmap.Width: 3, ' x ', bitmap.rows: 3);

    end;
  end;

begin
  main;
end.
