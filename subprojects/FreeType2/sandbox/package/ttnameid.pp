
unit ttnameid;
interface

{
  Automatically converted by H2Pas 1.0.0 from ttnameid.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    ttnameid.h
}

{ Pointers to basic pascal types, inserted by h2pas conversion program.}
Type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{***************************************************************************
 *
 * ttnameid.h
 *
 *   TrueType name ID definitions (specification only).
 *
 * Copyright (C) 1996-2024 by
 * David Turner, Robert Wilhelm, and Werner Lemberg.
 *
 * This file is part of the FreeType project, and may only be used,
 * modified, and distributed under the terms of the FreeType project
 * license, LICENSE.TXT.  By continuing to use, modify, or distribute
 * this file you indicate that you have read the license and
 * understand and accept it fully.
 *
  }
{$ifndef TTNAMEID_H_}
{$define TTNAMEID_H_}
{*************************************************************************
   *
   * @section:
   *   truetype_tables
    }
{*************************************************************************
   *
   * Possible values for the 'platform' identifier code in the name records
   * of an SFNT 'name' table.
   *
    }
{*************************************************************************
   *
   * @enum:
   *   TT_PLATFORM_XXX
   *
   * @description:
   *   A list of valid values for the `platform_id` identifier code in
   *   @FT_CharMapRec and @FT_SfntName structures.
   *
   * @values:
   *   TT_PLATFORM_APPLE_UNICODE ::
   *     Used by Apple to indicate a Unicode character map and/or name entry.
   *     See @TT_APPLE_ID_XXX for corresponding `encoding_id` values.  Note
   *     that name entries in this format are coded as big-endian UCS-2
   *     character codes _only_.
   *
   *   TT_PLATFORM_MACINTOSH ::
   *     Used by Apple to indicate a MacOS-specific charmap and/or name
   *     entry.  See @TT_MAC_ID_XXX for corresponding `encoding_id` values.
   *     Note that most TrueType fonts contain an Apple roman charmap to be
   *     usable on MacOS systems (even if they contain a Microsoft charmap as
   *     well).
   *
   *   TT_PLATFORM_ISO ::
   *     This value was used to specify ISO/IEC 10646 charmaps.  It is
   *     however now deprecated.  See @TT_ISO_ID_XXX for a list of
   *     corresponding `encoding_id` values.
   *
   *   TT_PLATFORM_MICROSOFT ::
   *     Used by Microsoft to indicate Windows-specific charmaps.  See
   *     @TT_MS_ID_XXX for a list of corresponding `encoding_id` values.
   *     Note that most fonts contain a Unicode charmap using
   *     (`TT_PLATFORM_MICROSOFT`, @TT_MS_ID_UNICODE_CS).
   *
   *   TT_PLATFORM_CUSTOM ::
   *     Used to indicate application-specific charmaps.
   *
   *   TT_PLATFORM_ADOBE ::
   *     This value isn't part of any font format specification, but is used
   *     by FreeType to report Adobe-specific charmaps in an @FT_CharMapRec
   *     structure.  See @TT_ADOBE_ID_XXX.
    }

const
  TT_PLATFORM_APPLE_UNICODE = 0;  
  TT_PLATFORM_MACINTOSH = 1;  
{ deprecated  }
  TT_PLATFORM_ISO = 2;  
  TT_PLATFORM_MICROSOFT = 3;  
  TT_PLATFORM_CUSTOM = 4;  
{ artificial  }
  TT_PLATFORM_ADOBE = 7;  
{*************************************************************************
   *
   * @enum:
   *   TT_APPLE_ID_XXX
   *
   * @description:
   *   A list of valid values for the `encoding_id` for
   *   @TT_PLATFORM_APPLE_UNICODE charmaps and name entries.
   *
   * @values:
   *   TT_APPLE_ID_DEFAULT ::
   *     Unicode version 1.0.
   *
   *   TT_APPLE_ID_UNICODE_1_1 ::
   *     Unicode 1.1; specifies Hangul characters starting at U+34xx.
   *
   *   TT_APPLE_ID_ISO_10646 ::
   *     Deprecated (identical to preceding).
   *
   *   TT_APPLE_ID_UNICODE_2_0 ::
   *     Unicode 2.0 and beyond (UTF-16 BMP only).
   *
   *   TT_APPLE_ID_UNICODE_32 ::
   *     Unicode 3.1 and beyond, using UTF-32.
   *
   *   TT_APPLE_ID_VARIANT_SELECTOR ::
   *     From Adobe, not Apple.  Not a normal cmap.  Specifies variations on
   *     a real cmap.
   *
   *   TT_APPLE_ID_FULL_UNICODE ::
   *     Used for fallback fonts that provide complete Unicode coverage with
   *     a type~13 cmap.
    }
{ Unicode 1.0                    }
  TT_APPLE_ID_DEFAULT = 0;  
{ specify Hangul at U+34xx       }
  TT_APPLE_ID_UNICODE_1_1 = 1;  
{ deprecated                     }
  TT_APPLE_ID_ISO_10646 = 2;  
{ or later                       }
  TT_APPLE_ID_UNICODE_2_0 = 3;  
{ 2.0 or later, full repertoire  }
  TT_APPLE_ID_UNICODE_32 = 4;  
{ variation selector data        }
  TT_APPLE_ID_VARIANT_SELECTOR = 5;  
{ used with type 13 cmaps        }
  TT_APPLE_ID_FULL_UNICODE = 6;  
{*************************************************************************
   *
   * @enum:
   *   TT_MAC_ID_XXX
   *
   * @description:
   *   A list of valid values for the `encoding_id` for
   *   @TT_PLATFORM_MACINTOSH charmaps and name entries.
    }
  TT_MAC_ID_ROMAN = 0;  
  TT_MAC_ID_JAPANESE = 1;  
  TT_MAC_ID_TRADITIONAL_CHINESE = 2;  
  TT_MAC_ID_KOREAN = 3;  
  TT_MAC_ID_ARABIC = 4;  
  TT_MAC_ID_HEBREW = 5;  
  TT_MAC_ID_GREEK = 6;  
  TT_MAC_ID_RUSSIAN = 7;  
  TT_MAC_ID_RSYMBOL = 8;  
  TT_MAC_ID_DEVANAGARI = 9;  
  TT_MAC_ID_GURMUKHI = 10;  
  TT_MAC_ID_GUJARATI = 11;  
  TT_MAC_ID_ORIYA = 12;  
  TT_MAC_ID_BENGALI = 13;  
  TT_MAC_ID_TAMIL = 14;  
  TT_MAC_ID_TELUGU = 15;  
  TT_MAC_ID_KANNADA = 16;  
  TT_MAC_ID_MALAYALAM = 17;  
  TT_MAC_ID_SINHALESE = 18;  
  TT_MAC_ID_BURMESE = 19;  
  TT_MAC_ID_KHMER = 20;  
  TT_MAC_ID_THAI = 21;  
  TT_MAC_ID_LAOTIAN = 22;  
  TT_MAC_ID_GEORGIAN = 23;  
  TT_MAC_ID_ARMENIAN = 24;  
  TT_MAC_ID_MALDIVIAN = 25;  
  TT_MAC_ID_SIMPLIFIED_CHINESE = 25;  
  TT_MAC_ID_TIBETAN = 26;  
  TT_MAC_ID_MONGOLIAN = 27;  
  TT_MAC_ID_GEEZ = 28;  
  TT_MAC_ID_SLAVIC = 29;  
  TT_MAC_ID_VIETNAMESE = 30;  
  TT_MAC_ID_SINDHI = 31;  
  TT_MAC_ID_UNINTERP = 32;  
{*************************************************************************
   *
   * @enum:
   *   TT_ISO_ID_XXX
   *
   * @description:
   *   A list of valid values for the `encoding_id` for @TT_PLATFORM_ISO
   *   charmaps and name entries.
   *
   *   Their use is now deprecated.
   *
   * @values:
   *   TT_ISO_ID_7BIT_ASCII ::
   *     ASCII.
   *   TT_ISO_ID_10646 ::
   *     ISO/10646.
   *   TT_ISO_ID_8859_1 ::
   *     Also known as Latin-1.
    }
  TT_ISO_ID_7BIT_ASCII = 0;  
  TT_ISO_ID_10646 = 1;  
  TT_ISO_ID_8859_1 = 2;  
{*************************************************************************
   *
   * @enum:
   *   TT_MS_ID_XXX
   *
   * @description:
   *   A list of valid values for the `encoding_id` for
   *   @TT_PLATFORM_MICROSOFT charmaps and name entries.
   *
   * @values:
   *   TT_MS_ID_SYMBOL_CS ::
   *     Microsoft symbol encoding.  See @FT_ENCODING_MS_SYMBOL.
   *
   *   TT_MS_ID_UNICODE_CS ::
   *     Microsoft WGL4 charmap, matching Unicode.  See @FT_ENCODING_UNICODE.
   *
   *   TT_MS_ID_SJIS ::
   *     Shift JIS Japanese encoding.  See @FT_ENCODING_SJIS.
   *
   *   TT_MS_ID_PRC ::
   *     Chinese encodings as used in the People's Republic of China (PRC).
   *     This means the encodings GB~2312 and its supersets GBK and GB~18030.
   *     See @FT_ENCODING_PRC.
   *
   *   TT_MS_ID_BIG_5 ::
   *     Traditional Chinese as used in Taiwan and Hong Kong.  See
   *     @FT_ENCODING_BIG5.
   *
   *   TT_MS_ID_WANSUNG ::
   *     Korean Extended Wansung encoding.  See @FT_ENCODING_WANSUNG.
   *
   *   TT_MS_ID_JOHAB ::
   *     Korean Johab encoding.  See @FT_ENCODING_JOHAB.
   *
   *   TT_MS_ID_UCS_4 ::
   *     UCS-4 or UTF-32 charmaps.  This has been added to the OpenType
   *     specification version 1.4 (mid-2001).
    }
  TT_MS_ID_SYMBOL_CS = 0;  
  TT_MS_ID_UNICODE_CS = 1;  
  TT_MS_ID_SJIS = 2;  
  TT_MS_ID_PRC = 3;  
  TT_MS_ID_BIG_5 = 4;  
  TT_MS_ID_WANSUNG = 5;  
  TT_MS_ID_JOHAB = 6;  
  TT_MS_ID_UCS_4 = 10;  
{ this value is deprecated  }
  TT_MS_ID_GB2312 = TT_MS_ID_PRC;  
{*************************************************************************
   *
   * @enum:
   *   TT_ADOBE_ID_XXX
   *
   * @description:
   *   A list of valid values for the `encoding_id` for @TT_PLATFORM_ADOBE
   *   charmaps.  This is a FreeType-specific extension!
   *
   * @values:
   *   TT_ADOBE_ID_STANDARD ::
   *     Adobe standard encoding.
   *   TT_ADOBE_ID_EXPERT ::
   *     Adobe expert encoding.
   *   TT_ADOBE_ID_CUSTOM ::
   *     Adobe custom encoding.
   *   TT_ADOBE_ID_LATIN_1 ::
   *     Adobe Latin~1 encoding.
    }
  TT_ADOBE_ID_STANDARD = 0;  
  TT_ADOBE_ID_EXPERT = 1;  
  TT_ADOBE_ID_CUSTOM = 2;  
  TT_ADOBE_ID_LATIN_1 = 3;  
{*************************************************************************
   *
   * @enum:
   *   TT_MAC_LANGID_XXX
   *
   * @description:
   *   Possible values of the language identifier field in the name records
   *   of the SFNT 'name' table if the 'platform' identifier code is
   *   @TT_PLATFORM_MACINTOSH.  These values are also used as return values
   *   for function @FT_Get_CMap_Language_ID.
   *
   *   The canonical source for Apple's IDs is
   *
   *     https://developer.apple.com/fonts/TrueType-Reference-Manual/RM06/Chap6name.html
    }
  TT_MAC_LANGID_ENGLISH = 0;  
  TT_MAC_LANGID_FRENCH = 1;  
  TT_MAC_LANGID_GERMAN = 2;  
  TT_MAC_LANGID_ITALIAN = 3;  
  TT_MAC_LANGID_DUTCH = 4;  
  TT_MAC_LANGID_SWEDISH = 5;  
  TT_MAC_LANGID_SPANISH = 6;  
  TT_MAC_LANGID_DANISH = 7;  
  TT_MAC_LANGID_PORTUGUESE = 8;  
  TT_MAC_LANGID_NORWEGIAN = 9;  
  TT_MAC_LANGID_HEBREW = 10;  
  TT_MAC_LANGID_JAPANESE = 11;  
  TT_MAC_LANGID_ARABIC = 12;  
  TT_MAC_LANGID_FINNISH = 13;  
  TT_MAC_LANGID_GREEK = 14;  
  TT_MAC_LANGID_ICELANDIC = 15;  
  TT_MAC_LANGID_MALTESE = 16;  
  TT_MAC_LANGID_TURKISH = 17;  
  TT_MAC_LANGID_CROATIAN = 18;  
  TT_MAC_LANGID_CHINESE_TRADITIONAL = 19;  
  TT_MAC_LANGID_URDU = 20;  
  TT_MAC_LANGID_HINDI = 21;  
  TT_MAC_LANGID_THAI = 22;  
  TT_MAC_LANGID_KOREAN = 23;  
  TT_MAC_LANGID_LITHUANIAN = 24;  
  TT_MAC_LANGID_POLISH = 25;  
  TT_MAC_LANGID_HUNGARIAN = 26;  
  TT_MAC_LANGID_ESTONIAN = 27;  
  TT_MAC_LANGID_LETTISH = 28;  
  TT_MAC_LANGID_SAAMISK = 29;  
  TT_MAC_LANGID_FAEROESE = 30;  
  TT_MAC_LANGID_FARSI = 31;  
  TT_MAC_LANGID_RUSSIAN = 32;  
  TT_MAC_LANGID_CHINESE_SIMPLIFIED = 33;  
  TT_MAC_LANGID_FLEMISH = 34;  
  TT_MAC_LANGID_IRISH = 35;  
  TT_MAC_LANGID_ALBANIAN = 36;  
  TT_MAC_LANGID_ROMANIAN = 37;  
  TT_MAC_LANGID_CZECH = 38;  
  TT_MAC_LANGID_SLOVAK = 39;  
  TT_MAC_LANGID_SLOVENIAN = 40;  
  TT_MAC_LANGID_YIDDISH = 41;  
  TT_MAC_LANGID_SERBIAN = 42;  
  TT_MAC_LANGID_MACEDONIAN = 43;  
  TT_MAC_LANGID_BULGARIAN = 44;  
  TT_MAC_LANGID_UKRAINIAN = 45;  
  TT_MAC_LANGID_BYELORUSSIAN = 46;  
  TT_MAC_LANGID_UZBEK = 47;  
  TT_MAC_LANGID_KAZAKH = 48;  
  TT_MAC_LANGID_AZERBAIJANI = 49;  
  TT_MAC_LANGID_AZERBAIJANI_CYRILLIC_SCRIPT = 49;  
  TT_MAC_LANGID_AZERBAIJANI_ARABIC_SCRIPT = 50;  
  TT_MAC_LANGID_ARMENIAN = 51;  
  TT_MAC_LANGID_GEORGIAN = 52;  
  TT_MAC_LANGID_MOLDAVIAN = 53;  
  TT_MAC_LANGID_KIRGHIZ = 54;  
  TT_MAC_LANGID_TAJIKI = 55;  
  TT_MAC_LANGID_TURKMEN = 56;  
  TT_MAC_LANGID_MONGOLIAN = 57;  
  TT_MAC_LANGID_MONGOLIAN_MONGOLIAN_SCRIPT = 57;  
  TT_MAC_LANGID_MONGOLIAN_CYRILLIC_SCRIPT = 58;  
  TT_MAC_LANGID_PASHTO = 59;  
  TT_MAC_LANGID_KURDISH = 60;  
  TT_MAC_LANGID_KASHMIRI = 61;  
  TT_MAC_LANGID_SINDHI = 62;  
  TT_MAC_LANGID_TIBETAN = 63;  
  TT_MAC_LANGID_NEPALI = 64;  
  TT_MAC_LANGID_SANSKRIT = 65;  
  TT_MAC_LANGID_MARATHI = 66;  
  TT_MAC_LANGID_BENGALI = 67;  
  TT_MAC_LANGID_ASSAMESE = 68;  
  TT_MAC_LANGID_GUJARATI = 69;  
  TT_MAC_LANGID_PUNJABI = 70;  
  TT_MAC_LANGID_ORIYA = 71;  
  TT_MAC_LANGID_MALAYALAM = 72;  
  TT_MAC_LANGID_KANNADA = 73;  
  TT_MAC_LANGID_TAMIL = 74;  
  TT_MAC_LANGID_TELUGU = 75;  
  TT_MAC_LANGID_SINHALESE = 76;  
  TT_MAC_LANGID_BURMESE = 77;  
  TT_MAC_LANGID_KHMER = 78;  
  TT_MAC_LANGID_LAO = 79;  
  TT_MAC_LANGID_VIETNAMESE = 80;  
  TT_MAC_LANGID_INDONESIAN = 81;  
  TT_MAC_LANGID_TAGALOG = 82;  
  TT_MAC_LANGID_MALAY_ROMAN_SCRIPT = 83;  
  TT_MAC_LANGID_MALAY_ARABIC_SCRIPT = 84;  
  TT_MAC_LANGID_AMHARIC = 85;  
  TT_MAC_LANGID_TIGRINYA = 86;  
  TT_MAC_LANGID_GALLA = 87;  
  TT_MAC_LANGID_SOMALI = 88;  
  TT_MAC_LANGID_SWAHILI = 89;  
  TT_MAC_LANGID_RUANDA = 90;  
  TT_MAC_LANGID_RUNDI = 91;  
  TT_MAC_LANGID_CHEWA = 92;  
  TT_MAC_LANGID_MALAGASY = 93;  
  TT_MAC_LANGID_ESPERANTO = 94;  
  TT_MAC_LANGID_WELSH = 128;  
  TT_MAC_LANGID_BASQUE = 129;  
  TT_MAC_LANGID_CATALAN = 130;  
  TT_MAC_LANGID_LATIN = 131;  
  TT_MAC_LANGID_QUECHUA = 132;  
  TT_MAC_LANGID_GUARANI = 133;  
  TT_MAC_LANGID_AYMARA = 134;  
  TT_MAC_LANGID_TATAR = 135;  
  TT_MAC_LANGID_UIGHUR = 136;  
  TT_MAC_LANGID_DZONGKHA = 137;  
  TT_MAC_LANGID_JAVANESE = 138;  
  TT_MAC_LANGID_SUNDANESE = 139;  
{ The following codes are new as of 2000-03-10  }
  TT_MAC_LANGID_GALICIAN = 140;  
  TT_MAC_LANGID_AFRIKAANS = 141;  
  TT_MAC_LANGID_BRETON = 142;  
  TT_MAC_LANGID_INUKTITUT = 143;  
  TT_MAC_LANGID_SCOTTISH_GAELIC = 144;  
  TT_MAC_LANGID_MANX_GAELIC = 145;  
  TT_MAC_LANGID_IRISH_GAELIC = 146;  
  TT_MAC_LANGID_TONGAN = 147;  
  TT_MAC_LANGID_GREEK_POLYTONIC = 148;  
  TT_MAC_LANGID_GREELANDIC = 149;  
  TT_MAC_LANGID_AZERBAIJANI_ROMAN_SCRIPT = 150;  
{*************************************************************************
   *
   * @enum:
   *   TT_MS_LANGID_XXX
   *
   * @description:
   *   Possible values of the language identifier field in the name records
   *   of the SFNT 'name' table if the 'platform' identifier code is
   *   @TT_PLATFORM_MICROSOFT.  These values are also used as return values
   *   for function @FT_Get_CMap_Language_ID.
   *
   *   The canonical source for Microsoft's IDs is
   *
   *     https://docs.microsoft.com/en-us/windows/desktop/Intl/language-identifier-constants-and-strings ,
   *
   *   however, we only provide macros for language identifiers present in
   *   the OpenType specification: Microsoft has abandoned the concept of
   *   LCIDs (language code identifiers), and format~1 of the 'name' table
   *   provides a better mechanism for languages not covered here.
   *
   *   More legacy values not listed in the reference can be found in the
   *   @FT_TRUETYPE_IDS_H header file.
    }
  TT_MS_LANGID_ARABIC_SAUDI_ARABIA = $0401;  
  TT_MS_LANGID_ARABIC_IRAQ = $0801;  
  TT_MS_LANGID_ARABIC_EGYPT = $0C01;  
  TT_MS_LANGID_ARABIC_LIBYA = $1001;  
  TT_MS_LANGID_ARABIC_ALGERIA = $1401;  
  TT_MS_LANGID_ARABIC_MOROCCO = $1801;  
  TT_MS_LANGID_ARABIC_TUNISIA = $1C01;  
  TT_MS_LANGID_ARABIC_OMAN = $2001;  
  TT_MS_LANGID_ARABIC_YEMEN = $2401;  
  TT_MS_LANGID_ARABIC_SYRIA = $2801;  
  TT_MS_LANGID_ARABIC_JORDAN = $2C01;  
  TT_MS_LANGID_ARABIC_LEBANON = $3001;  
  TT_MS_LANGID_ARABIC_KUWAIT = $3401;  
  TT_MS_LANGID_ARABIC_UAE = $3801;  
  TT_MS_LANGID_ARABIC_BAHRAIN = $3C01;  
  TT_MS_LANGID_ARABIC_QATAR = $4001;  
  TT_MS_LANGID_BULGARIAN_BULGARIA = $0402;  
  TT_MS_LANGID_CATALAN_CATALAN = $0403;  
  TT_MS_LANGID_CHINESE_TAIWAN = $0404;  
  TT_MS_LANGID_CHINESE_PRC = $0804;  
  TT_MS_LANGID_CHINESE_HONG_KONG = $0C04;  
  TT_MS_LANGID_CHINESE_SINGAPORE = $1004;  
  TT_MS_LANGID_CHINESE_MACAO = $1404;  
  TT_MS_LANGID_CZECH_CZECH_REPUBLIC = $0405;  
  TT_MS_LANGID_DANISH_DENMARK = $0406;  
  TT_MS_LANGID_GERMAN_GERMANY = $0407;  
  TT_MS_LANGID_GERMAN_SWITZERLAND = $0807;  
  TT_MS_LANGID_GERMAN_AUSTRIA = $0C07;  
  TT_MS_LANGID_GERMAN_LUXEMBOURG = $1007;  
  TT_MS_LANGID_GERMAN_LIECHTENSTEIN = $1407;  
  TT_MS_LANGID_GREEK_GREECE = $0408;  
  TT_MS_LANGID_ENGLISH_UNITED_STATES = $0409;  
  TT_MS_LANGID_ENGLISH_UNITED_KINGDOM = $0809;  
  TT_MS_LANGID_ENGLISH_AUSTRALIA = $0C09;  
  TT_MS_LANGID_ENGLISH_CANADA = $1009;  
  TT_MS_LANGID_ENGLISH_NEW_ZEALAND = $1409;  
  TT_MS_LANGID_ENGLISH_IRELAND = $1809;  
  TT_MS_LANGID_ENGLISH_SOUTH_AFRICA = $1C09;  
  TT_MS_LANGID_ENGLISH_JAMAICA = $2009;  
  TT_MS_LANGID_ENGLISH_CARIBBEAN = $2409;  
  TT_MS_LANGID_ENGLISH_BELIZE = $2809;  
  TT_MS_LANGID_ENGLISH_TRINIDAD = $2C09;  
  TT_MS_LANGID_ENGLISH_ZIMBABWE = $3009;  
  TT_MS_LANGID_ENGLISH_PHILIPPINES = $3409;  
  TT_MS_LANGID_ENGLISH_INDIA = $4009;  
  TT_MS_LANGID_ENGLISH_MALAYSIA = $4409;  
  TT_MS_LANGID_ENGLISH_SINGAPORE = $4809;  
  TT_MS_LANGID_SPANISH_SPAIN_TRADITIONAL_SORT = $040A;  
  TT_MS_LANGID_SPANISH_MEXICO = $080A;  
  TT_MS_LANGID_SPANISH_SPAIN_MODERN_SORT = $0C0A;  
  TT_MS_LANGID_SPANISH_GUATEMALA = $100A;  
  TT_MS_LANGID_SPANISH_COSTA_RICA = $140A;  
  TT_MS_LANGID_SPANISH_PANAMA = $180A;  
  TT_MS_LANGID_SPANISH_DOMINICAN_REPUBLIC = $1C0A;  
  TT_MS_LANGID_SPANISH_VENEZUELA = $200A;  
  TT_MS_LANGID_SPANISH_COLOMBIA = $240A;  
  TT_MS_LANGID_SPANISH_PERU = $280A;  
  TT_MS_LANGID_SPANISH_ARGENTINA = $2C0A;  
  TT_MS_LANGID_SPANISH_ECUADOR = $300A;  
  TT_MS_LANGID_SPANISH_CHILE = $340A;  
  TT_MS_LANGID_SPANISH_URUGUAY = $380A;  
  TT_MS_LANGID_SPANISH_PARAGUAY = $3C0A;  
  TT_MS_LANGID_SPANISH_BOLIVIA = $400A;  
  TT_MS_LANGID_SPANISH_EL_SALVADOR = $440A;  
  TT_MS_LANGID_SPANISH_HONDURAS = $480A;  
  TT_MS_LANGID_SPANISH_NICARAGUA = $4C0A;  
  TT_MS_LANGID_SPANISH_PUERTO_RICO = $500A;  
  TT_MS_LANGID_SPANISH_UNITED_STATES = $540A;  
  TT_MS_LANGID_FINNISH_FINLAND = $040B;  
  TT_MS_LANGID_FRENCH_FRANCE = $040C;  
  TT_MS_LANGID_FRENCH_BELGIUM = $080C;  
  TT_MS_LANGID_FRENCH_CANADA = $0C0C;  
  TT_MS_LANGID_FRENCH_SWITZERLAND = $100C;  
  TT_MS_LANGID_FRENCH_LUXEMBOURG = $140C;  
  TT_MS_LANGID_FRENCH_MONACO = $180C;  
  TT_MS_LANGID_HEBREW_ISRAEL = $040D;  
  TT_MS_LANGID_HUNGARIAN_HUNGARY = $040E;  
  TT_MS_LANGID_ICELANDIC_ICELAND = $040F;  
  TT_MS_LANGID_ITALIAN_ITALY = $0410;  
  TT_MS_LANGID_ITALIAN_SWITZERLAND = $0810;  
  TT_MS_LANGID_JAPANESE_JAPAN = $0411;  
  TT_MS_LANGID_KOREAN_KOREA = $0412;  
  TT_MS_LANGID_DUTCH_NETHERLANDS = $0413;  
  TT_MS_LANGID_DUTCH_BELGIUM = $0813;  
  TT_MS_LANGID_NORWEGIAN_NORWAY_BOKMAL = $0414;  
  TT_MS_LANGID_NORWEGIAN_NORWAY_NYNORSK = $0814;  
  TT_MS_LANGID_POLISH_POLAND = $0415;  
  TT_MS_LANGID_PORTUGUESE_BRAZIL = $0416;  
  TT_MS_LANGID_PORTUGUESE_PORTUGAL = $0816;  
  TT_MS_LANGID_ROMANSH_SWITZERLAND = $0417;  
  TT_MS_LANGID_ROMANIAN_ROMANIA = $0418;  
  TT_MS_LANGID_RUSSIAN_RUSSIA = $0419;  
  TT_MS_LANGID_CROATIAN_CROATIA = $041A;  
  TT_MS_LANGID_SERBIAN_SERBIA_LATIN = $081A;  
  TT_MS_LANGID_SERBIAN_SERBIA_CYRILLIC = $0C1A;  
  TT_MS_LANGID_CROATIAN_BOSNIA_HERZEGOVINA = $101A;  
  TT_MS_LANGID_BOSNIAN_BOSNIA_HERZEGOVINA = $141A;  
  TT_MS_LANGID_SERBIAN_BOSNIA_HERZ_LATIN = $181A;  
  TT_MS_LANGID_SERBIAN_BOSNIA_HERZ_CYRILLIC = $1C1A;  
  TT_MS_LANGID_BOSNIAN_BOSNIA_HERZ_CYRILLIC = $201A;  
  TT_MS_LANGID_SLOVAK_SLOVAKIA = $041B;  
  TT_MS_LANGID_ALBANIAN_ALBANIA = $041C;  
  TT_MS_LANGID_SWEDISH_SWEDEN = $041D;  
  TT_MS_LANGID_SWEDISH_FINLAND = $081D;  
  TT_MS_LANGID_THAI_THAILAND = $041E;  
  TT_MS_LANGID_TURKISH_TURKEY = $041F;  
  TT_MS_LANGID_URDU_PAKISTAN = $0420;  
  TT_MS_LANGID_INDONESIAN_INDONESIA = $0421;  
  TT_MS_LANGID_UKRAINIAN_UKRAINE = $0422;  
  TT_MS_LANGID_BELARUSIAN_BELARUS = $0423;  
  TT_MS_LANGID_SLOVENIAN_SLOVENIA = $0424;  
  TT_MS_LANGID_ESTONIAN_ESTONIA = $0425;  
  TT_MS_LANGID_LATVIAN_LATVIA = $0426;  
  TT_MS_LANGID_LITHUANIAN_LITHUANIA = $0427;  
  TT_MS_LANGID_TAJIK_TAJIKISTAN = $0428;  
  TT_MS_LANGID_VIETNAMESE_VIET_NAM = $042A;  
  TT_MS_LANGID_ARMENIAN_ARMENIA = $042B;  
  TT_MS_LANGID_AZERI_AZERBAIJAN_LATIN = $042C;  
  TT_MS_LANGID_AZERI_AZERBAIJAN_CYRILLIC = $082C;  
  TT_MS_LANGID_BASQUE_BASQUE = $042D;  
  TT_MS_LANGID_UPPER_SORBIAN_GERMANY = $042E;  
  TT_MS_LANGID_LOWER_SORBIAN_GERMANY = $082E;  
  TT_MS_LANGID_MACEDONIAN_MACEDONIA = $042F;  
  TT_MS_LANGID_SETSWANA_SOUTH_AFRICA = $0432;  
  TT_MS_LANGID_ISIXHOSA_SOUTH_AFRICA = $0434;  
  TT_MS_LANGID_ISIZULU_SOUTH_AFRICA = $0435;  
  TT_MS_LANGID_AFRIKAANS_SOUTH_AFRICA = $0436;  
  TT_MS_LANGID_GEORGIAN_GEORGIA = $0437;  
  TT_MS_LANGID_FAEROESE_FAEROE_ISLANDS = $0438;  
  TT_MS_LANGID_HINDI_INDIA = $0439;  
  TT_MS_LANGID_MALTESE_MALTA = $043A;  
  TT_MS_LANGID_SAMI_NORTHERN_NORWAY = $043B;  
  TT_MS_LANGID_SAMI_NORTHERN_SWEDEN = $083B;  
  TT_MS_LANGID_SAMI_NORTHERN_FINLAND = $0C3B;  
  TT_MS_LANGID_SAMI_LULE_NORWAY = $103B;  
  TT_MS_LANGID_SAMI_LULE_SWEDEN = $143B;  
  TT_MS_LANGID_SAMI_SOUTHERN_NORWAY = $183B;  
  TT_MS_LANGID_SAMI_SOUTHERN_SWEDEN = $1C3B;  
  TT_MS_LANGID_SAMI_SKOLT_FINLAND = $203B;  
  TT_MS_LANGID_SAMI_INARI_FINLAND = $243B;  
  TT_MS_LANGID_IRISH_IRELAND = $083C;  
  TT_MS_LANGID_MALAY_MALAYSIA = $043E;  
  TT_MS_LANGID_MALAY_BRUNEI_DARUSSALAM = $083E;  
  TT_MS_LANGID_KAZAKH_KAZAKHSTAN = $043F;  
{ Cyrillic  }  TT_MS_LANGID_KYRGYZ_KYRGYZSTAN = $0440;  
  TT_MS_LANGID_KISWAHILI_KENYA = $0441;  
  TT_MS_LANGID_TURKMEN_TURKMENISTAN = $0442;  
  TT_MS_LANGID_UZBEK_UZBEKISTAN_LATIN = $0443;  
  TT_MS_LANGID_UZBEK_UZBEKISTAN_CYRILLIC = $0843;  
  TT_MS_LANGID_TATAR_RUSSIA = $0444;  
  TT_MS_LANGID_BENGALI_INDIA = $0445;  
  TT_MS_LANGID_BENGALI_BANGLADESH = $0845;  
  TT_MS_LANGID_PUNJABI_INDIA = $0446;  
  TT_MS_LANGID_GUJARATI_INDIA = $0447;  
  TT_MS_LANGID_ODIA_INDIA = $0448;  
  TT_MS_LANGID_TAMIL_INDIA = $0449;  
  TT_MS_LANGID_TELUGU_INDIA = $044A;  
  TT_MS_LANGID_KANNADA_INDIA = $044B;  
  TT_MS_LANGID_MALAYALAM_INDIA = $044C;  
  TT_MS_LANGID_ASSAMESE_INDIA = $044D;  
  TT_MS_LANGID_MARATHI_INDIA = $044E;  
  TT_MS_LANGID_SANSKRIT_INDIA = $044F;  
{ Cyrillic  }  TT_MS_LANGID_MONGOLIAN_MONGOLIA = $0450;  
  TT_MS_LANGID_MONGOLIAN_PRC = $0850;  
  TT_MS_LANGID_TIBETAN_PRC = $0451;  
  TT_MS_LANGID_WELSH_UNITED_KINGDOM = $0452;  
  TT_MS_LANGID_KHMER_CAMBODIA = $0453;  
  TT_MS_LANGID_LAO_LAOS = $0454;  
  TT_MS_LANGID_GALICIAN_GALICIAN = $0456;  
  TT_MS_LANGID_KONKANI_INDIA = $0457;  
  TT_MS_LANGID_SYRIAC_SYRIA = $045A;  
  TT_MS_LANGID_SINHALA_SRI_LANKA = $045B;  
  TT_MS_LANGID_INUKTITUT_CANADA = $045D;  
  TT_MS_LANGID_INUKTITUT_CANADA_LATIN = $085D;  
  TT_MS_LANGID_AMHARIC_ETHIOPIA = $045E;  
  TT_MS_LANGID_TAMAZIGHT_ALGERIA = $085F;  
  TT_MS_LANGID_NEPALI_NEPAL = $0461;  
  TT_MS_LANGID_FRISIAN_NETHERLANDS = $0462;  
  TT_MS_LANGID_PASHTO_AFGHANISTAN = $0463;  
  TT_MS_LANGID_FILIPINO_PHILIPPINES = $0464;  
  TT_MS_LANGID_DHIVEHI_MALDIVES = $0465;  
  TT_MS_LANGID_HAUSA_NIGERIA = $0468;  
  TT_MS_LANGID_YORUBA_NIGERIA = $046A;  
  TT_MS_LANGID_QUECHUA_BOLIVIA = $046B;  
  TT_MS_LANGID_QUECHUA_ECUADOR = $086B;  
  TT_MS_LANGID_QUECHUA_PERU = $0C6B;  
  TT_MS_LANGID_SESOTHO_SA_LEBOA_SOUTH_AFRICA = $046C;  
  TT_MS_LANGID_BASHKIR_RUSSIA = $046D;  
  TT_MS_LANGID_LUXEMBOURGISH_LUXEMBOURG = $046E;  
  TT_MS_LANGID_GREENLANDIC_GREENLAND = $046F;  
  TT_MS_LANGID_IGBO_NIGERIA = $0470;  
  TT_MS_LANGID_YI_PRC = $0478;  
  TT_MS_LANGID_MAPUDUNGUN_CHILE = $047A;  
  TT_MS_LANGID_MOHAWK_MOHAWK = $047C;  
  TT_MS_LANGID_BRETON_FRANCE = $047E;  
  TT_MS_LANGID_UIGHUR_PRC = $0480;  
  TT_MS_LANGID_MAORI_NEW_ZEALAND = $0481;  
  TT_MS_LANGID_OCCITAN_FRANCE = $0482;  
  TT_MS_LANGID_CORSICAN_FRANCE = $0483;  
  TT_MS_LANGID_ALSATIAN_FRANCE = $0484;  
  TT_MS_LANGID_YAKUT_RUSSIA = $0485;  
  TT_MS_LANGID_KICHE_GUATEMALA = $0486;  
  TT_MS_LANGID_KINYARWANDA_RWANDA = $0487;  
  TT_MS_LANGID_WOLOF_SENEGAL = $0488;  
  TT_MS_LANGID_DARI_AFGHANISTAN = $048C;  
{  }
{ legacy macro definitions not present in OpenType 1.8.1  }
  TT_MS_LANGID_ARABIC_GENERAL = $0001;  
  TT_MS_LANGID_CATALAN_SPAIN = TT_MS_LANGID_CATALAN_CATALAN;  
  TT_MS_LANGID_CHINESE_GENERAL = $0004;  
  TT_MS_LANGID_CHINESE_MACAU = TT_MS_LANGID_CHINESE_MACAO;  
  TT_MS_LANGID_GERMAN_LIECHTENSTEI = TT_MS_LANGID_GERMAN_LIECHTENSTEIN;  
  TT_MS_LANGID_ENGLISH_GENERAL = $0009;  
  TT_MS_LANGID_ENGLISH_INDONESIA = $3809;  
  TT_MS_LANGID_ENGLISH_HONG_KONG = $3C09;  
  TT_MS_LANGID_SPANISH_SPAIN_INTERNATIONAL_SORT = TT_MS_LANGID_SPANISH_SPAIN_MODERN_SORT;  
  TT_MS_LANGID_SPANISH_LATIN_AMERICA = $E40A;  
  TT_MS_LANGID_FRENCH_WEST_INDIES = $1C0C;  
  TT_MS_LANGID_FRENCH_REUNION = $200C;  
  TT_MS_LANGID_FRENCH_CONGO = $240C;  
{ which was formerly:  }
  TT_MS_LANGID_FRENCH_ZAIRE = TT_MS_LANGID_FRENCH_CONGO;  
  TT_MS_LANGID_FRENCH_SENEGAL = $280C;  
  TT_MS_LANGID_FRENCH_CAMEROON = $2C0C;  
  TT_MS_LANGID_FRENCH_COTE_D_IVOIRE = $300C;  
  TT_MS_LANGID_FRENCH_MALI = $340C;  
  TT_MS_LANGID_FRENCH_MOROCCO = $380C;  
  TT_MS_LANGID_FRENCH_HAITI = $3C0C;  
  TT_MS_LANGID_FRENCH_NORTH_AFRICA = $E40C;  
  TT_MS_LANGID_KOREAN_EXTENDED_WANSUNG_KOREA = TT_MS_LANGID_KOREAN_KOREA;  
  TT_MS_LANGID_KOREAN_JOHAB_KOREA = $0812;  
  TT_MS_LANGID_RHAETO_ROMANIC_SWITZERLAND = TT_MS_LANGID_ROMANSH_SWITZERLAND;  
  TT_MS_LANGID_MOLDAVIAN_MOLDAVIA = $0818;  
  TT_MS_LANGID_RUSSIAN_MOLDAVIA = $0819;  
  TT_MS_LANGID_URDU_INDIA = $0820;  
  TT_MS_LANGID_CLASSIC_LITHUANIAN_LITHUANIA = $0827;  
  TT_MS_LANGID_SLOVENE_SLOVENIA = TT_MS_LANGID_SLOVENIAN_SLOVENIA;  
  TT_MS_LANGID_FARSI_IRAN = $0429;  
  TT_MS_LANGID_BASQUE_SPAIN = TT_MS_LANGID_BASQUE_BASQUE;  
  TT_MS_LANGID_SORBIAN_GERMANY = TT_MS_LANGID_UPPER_SORBIAN_GERMANY;  
  TT_MS_LANGID_SUTU_SOUTH_AFRICA = $0430;  
  TT_MS_LANGID_TSONGA_SOUTH_AFRICA = $0431;  
  TT_MS_LANGID_TSWANA_SOUTH_AFRICA = TT_MS_LANGID_SETSWANA_SOUTH_AFRICA;  
  TT_MS_LANGID_VENDA_SOUTH_AFRICA = $0433;  
  TT_MS_LANGID_XHOSA_SOUTH_AFRICA = TT_MS_LANGID_ISIXHOSA_SOUTH_AFRICA;  
  TT_MS_LANGID_ZULU_SOUTH_AFRICA = TT_MS_LANGID_ISIZULU_SOUTH_AFRICA;  
  TT_MS_LANGID_SAAMI_LAPONIA = $043B;  
{ the next two values are incorrectly inverted  }
  TT_MS_LANGID_IRISH_GAELIC_IRELAND = $043C;  
  TT_MS_LANGID_SCOTTISH_GAELIC_UNITED_KINGDOM = $083C;  
  TT_MS_LANGID_YIDDISH_GERMANY = $043D;  
  TT_MS_LANGID_KAZAK_KAZAKSTAN = TT_MS_LANGID_KAZAKH_KAZAKHSTAN;  
  TT_MS_LANGID_KIRGHIZ_KIRGHIZ_REPUBLIC = TT_MS_LANGID_KYRGYZ_KYRGYZSTAN;  
  TT_MS_LANGID_KIRGHIZ_KIRGHIZSTAN = TT_MS_LANGID_KYRGYZ_KYRGYZSTAN;  
  TT_MS_LANGID_SWAHILI_KENYA = TT_MS_LANGID_KISWAHILI_KENYA;  
  TT_MS_LANGID_TATAR_TATARSTAN = TT_MS_LANGID_TATAR_RUSSIA;  
  TT_MS_LANGID_PUNJABI_ARABIC_PAKISTAN = $0846;  
  TT_MS_LANGID_ORIYA_INDIA = TT_MS_LANGID_ODIA_INDIA;  
  TT_MS_LANGID_MONGOLIAN_MONGOLIA_MONGOLIAN = TT_MS_LANGID_MONGOLIAN_PRC;  
  TT_MS_LANGID_TIBETAN_CHINA = TT_MS_LANGID_TIBETAN_PRC;  
  TT_MS_LANGID_DZONGHKA_BHUTAN = $0851;  
  TT_MS_LANGID_TIBETAN_BHUTAN = TT_MS_LANGID_DZONGHKA_BHUTAN;  
  TT_MS_LANGID_WELSH_WALES = TT_MS_LANGID_WELSH_UNITED_KINGDOM;  
  TT_MS_LANGID_BURMESE_MYANMAR = $0455;  
  TT_MS_LANGID_GALICIAN_SPAIN = TT_MS_LANGID_GALICIAN_GALICIAN;  
{ Bengali  }  TT_MS_LANGID_MANIPURI_INDIA = $0458;  
{ Arabic  }  TT_MS_LANGID_SINDHI_INDIA = $0459;  
  TT_MS_LANGID_SINDHI_PAKISTAN = $0859;  
  TT_MS_LANGID_SINHALESE_SRI_LANKA = TT_MS_LANGID_SINHALA_SRI_LANKA;  
  TT_MS_LANGID_CHEROKEE_UNITED_STATES = $045C;  
{ Arabic  }  TT_MS_LANGID_TAMAZIGHT_MOROCCO = $045F;  
  TT_MS_LANGID_TAMAZIGHT_MOROCCO_LATIN = TT_MS_LANGID_TAMAZIGHT_ALGERIA;  
{ Arabic  }  TT_MS_LANGID_KASHMIRI_PAKISTAN = $0460;  
  TT_MS_LANGID_KASHMIRI_SASIA = $0860;  
  TT_MS_LANGID_KASHMIRI_INDIA = TT_MS_LANGID_KASHMIRI_SASIA;  
  TT_MS_LANGID_NEPALI_INDIA = $0861;  
  TT_MS_LANGID_DIVEHI_MALDIVES = TT_MS_LANGID_DHIVEHI_MALDIVES;  
  TT_MS_LANGID_EDO_NIGERIA = $0466;  
  TT_MS_LANGID_FULFULDE_NIGERIA = $0467;  
  TT_MS_LANGID_IBIBIO_NIGERIA = $0469;  
  TT_MS_LANGID_SEPEDI_SOUTH_AFRICA = TT_MS_LANGID_SESOTHO_SA_LEBOA_SOUTH_AFRICA;  
  TT_MS_LANGID_SOTHO_SOUTHERN_SOUTH_AFRICA = TT_MS_LANGID_SESOTHO_SA_LEBOA_SOUTH_AFRICA;  
  TT_MS_LANGID_KANURI_NIGERIA = $0471;  
  TT_MS_LANGID_OROMO_ETHIOPIA = $0472;  
  TT_MS_LANGID_TIGRIGNA_ETHIOPIA = $0473;  
  TT_MS_LANGID_TIGRIGNA_ERYTHREA = $0873;  
  TT_MS_LANGID_TIGRIGNA_ERYTREA = TT_MS_LANGID_TIGRIGNA_ERYTHREA;  
  TT_MS_LANGID_GUARANI_PARAGUAY = $0474;  
  TT_MS_LANGID_HAWAIIAN_UNITED_STATES = $0475;  
  TT_MS_LANGID_LATIN = $0476;  
  TT_MS_LANGID_SOMALI_SOMALIA = $0477;  
  TT_MS_LANGID_YI_CHINA = TT_MS_LANGID_YI_PRC;  
  TT_MS_LANGID_PAPIAMENTU_NETHERLANDS_ANTILLES = $0479;  
  TT_MS_LANGID_UIGHUR_CHINA = TT_MS_LANGID_UIGHUR_PRC;  
{*************************************************************************
   *
   * @enum:
   *   TT_NAME_ID_XXX
   *
   * @description:
   *   Possible values of the 'name' identifier field in the name records of
   *   an SFNT 'name' table.  These values are platform independent.
    }
  TT_NAME_ID_COPYRIGHT = 0;  
  TT_NAME_ID_FONT_FAMILY = 1;  
  TT_NAME_ID_FONT_SUBFAMILY = 2;  
  TT_NAME_ID_UNIQUE_ID = 3;  
  TT_NAME_ID_FULL_NAME = 4;  
  TT_NAME_ID_VERSION_STRING = 5;  
  TT_NAME_ID_PS_NAME = 6;  
  TT_NAME_ID_TRADEMARK = 7;  
{ the following values are from the OpenType spec  }
  TT_NAME_ID_MANUFACTURER = 8;  
  TT_NAME_ID_DESIGNER = 9;  
  TT_NAME_ID_DESCRIPTION = 10;  
  TT_NAME_ID_VENDOR_URL = 11;  
  TT_NAME_ID_DESIGNER_URL = 12;  
  TT_NAME_ID_LICENSE = 13;  
  TT_NAME_ID_LICENSE_URL = 14;  
{ number 15 is reserved  }
  TT_NAME_ID_TYPOGRAPHIC_FAMILY = 16;  
  TT_NAME_ID_TYPOGRAPHIC_SUBFAMILY = 17;  
  TT_NAME_ID_MAC_FULL_NAME = 18;  
{ The following code is new as of 2000-01-21  }
  TT_NAME_ID_SAMPLE_TEXT = 19;  
{ This is new in OpenType 1.3  }
  TT_NAME_ID_CID_FINDFONT_NAME = 20;  
{ This is new in OpenType 1.5  }
  TT_NAME_ID_WWS_FAMILY = 21;  
  TT_NAME_ID_WWS_SUBFAMILY = 22;  
{ This is new in OpenType 1.7  }
  TT_NAME_ID_LIGHT_BACKGROUND = 23;  
  TT_NAME_ID_DARK_BACKGROUND = 24;  
{ This is new in OpenType 1.8  }
  TT_NAME_ID_VARIATIONS_PREFIX = 25;  
{ these two values are deprecated  }
  TT_NAME_ID_PREFERRED_FAMILY = TT_NAME_ID_TYPOGRAPHIC_FAMILY;  
  TT_NAME_ID_PREFERRED_SUBFAMILY = TT_NAME_ID_TYPOGRAPHIC_SUBFAMILY;  
{*************************************************************************
   *
   * @enum:
   *   TT_UCR_XXX
   *
   * @description:
   *   Possible bit mask values for the `ulUnicodeRangeX` fields in an SFNT
   *   'OS/2' table.
    }
{ ulUnicodeRange1  }
{ ---------------  }
{ Bit  0   Basic Latin  }
{ U+0020-U+007E  }
  TT_UCR_BASIC_LATIN = 1 shl 0;  
{ Bit  1   C1 Controls and Latin-1 Supplement  }
{ U+0080-U+00FF  }
  TT_UCR_LATIN1_SUPPLEMENT = 1 shl 1;  
{ Bit  2   Latin Extended-A  }
{ U+0100-U+017F  }
  TT_UCR_LATIN_EXTENDED_A = 1 shl 2;  
{ Bit  3   Latin Extended-B  }
{ U+0180-U+024F  }
  TT_UCR_LATIN_EXTENDED_B = 1 shl 3;  
{ Bit  4   IPA Extensions                  }
{          Phonetic Extensions             }
{          Phonetic Extensions Supplement  }
{ U+0250-U+02AF  }
  TT_UCR_IPA_EXTENSIONS = 1 shl 4;  
{ U+1D00-U+1D7F  }
{ U+1D80-U+1DBF  }
{ Bit  5   Spacing Modifier Letters  }
{          Modifier Tone Letters     }
{ U+02B0-U+02FF  }
  TT_UCR_SPACING_MODIFIER = 1 shl 5;  
{ U+A700-U+A71F  }
{ Bit  6   Combining Diacritical Marks             }
{          Combining Diacritical Marks Supplement  }
{ U+0300-U+036F  }
  TT_UCR_COMBINING_DIACRITICAL_MARKS = 1 shl 6;  
{ U+1DC0-U+1DFF  }
{ Bit  7   Greek and Coptic  }
{ U+0370-U+03FF  }
  TT_UCR_GREEK = 1 shl 7;  
{ Bit  8   Coptic  }
{ U+2C80-U+2CFF  }
  TT_UCR_COPTIC = 1 shl 8;  
{ Bit  9   Cyrillic             }
{          Cyrillic Supplement  }
{          Cyrillic Extended-A  }
{          Cyrillic Extended-B  }
{ U+0400-U+04FF  }
  TT_UCR_CYRILLIC = 1 shl 9;  
{ U+0500-U+052F  }
{ U+2DE0-U+2DFF  }
{ U+A640-U+A69F  }
{ Bit 10   Armenian  }
{ U+0530-U+058F  }
  TT_UCR_ARMENIAN = 1 shl 10;  
{ Bit 11   Hebrew  }
{ U+0590-U+05FF  }
  TT_UCR_HEBREW = 1 shl 11;  
{ Bit 12   Vai  }
{ U+A500-U+A63F  }
  TT_UCR_VAI = 1 shl 12;  
{ Bit 13   Arabic             }
{          Arabic Supplement  }
{ U+0600-U+06FF  }
  TT_UCR_ARABIC = 1 shl 13;  
{ U+0750-U+077F  }
{ Bit 14   NKo  }
{ U+07C0-U+07FF  }
  TT_UCR_NKO = 1 shl 14;  
{ Bit 15   Devanagari  }
{ U+0900-U+097F  }
  TT_UCR_DEVANAGARI = 1 shl 15;  
{ Bit 16   Bengali  }
{ U+0980-U+09FF  }
  TT_UCR_BENGALI = 1 shl 16;  
{ Bit 17   Gurmukhi  }
{ U+0A00-U+0A7F  }
  TT_UCR_GURMUKHI = 1 shl 17;  
{ Bit 18   Gujarati  }
{ U+0A80-U+0AFF  }
  TT_UCR_GUJARATI = 1 shl 18;  
{ Bit 19   Oriya  }
{ U+0B00-U+0B7F  }
  TT_UCR_ORIYA = 1 shl 19;  
{ Bit 20   Tamil  }
{ U+0B80-U+0BFF  }
  TT_UCR_TAMIL = 1 shl 20;  
{ Bit 21   Telugu  }
{ U+0C00-U+0C7F  }
  TT_UCR_TELUGU = 1 shl 21;  
{ Bit 22   Kannada  }
{ U+0C80-U+0CFF  }
  TT_UCR_KANNADA = 1 shl 22;  
{ Bit 23   Malayalam  }
{ U+0D00-U+0D7F  }
  TT_UCR_MALAYALAM = 1 shl 23;  
{ Bit 24   Thai  }
{ U+0E00-U+0E7F  }
  TT_UCR_THAI = 1 shl 24;  
{ Bit 25   Lao  }
{ U+0E80-U+0EFF  }
  TT_UCR_LAO = 1 shl 25;  
{ Bit 26   Georgian             }
{          Georgian Supplement  }
{ U+10A0-U+10FF  }
  TT_UCR_GEORGIAN = 1 shl 26;  
{ U+2D00-U+2D2F  }
{ Bit 27   Balinese  }
{ U+1B00-U+1B7F  }
  TT_UCR_BALINESE = 1 shl 27;  
{ Bit 28   Hangul Jamo  }
{ U+1100-U+11FF  }
  TT_UCR_HANGUL_JAMO = 1 shl 28;  
{ Bit 29   Latin Extended Additional  }
{          Latin Extended-C           }
{          Latin Extended-D           }
{ U+1E00-U+1EFF  }
  TT_UCR_LATIN_EXTENDED_ADDITIONAL = 1 shl 29;  
{ U+2C60-U+2C7F  }
{ U+A720-U+A7FF  }
{ Bit 30   Greek Extended  }
{ U+1F00-U+1FFF  }
  TT_UCR_GREEK_EXTENDED = 1 shl 30;  
{ Bit 31   General Punctuation       }
{          Supplemental Punctuation  }
{ U+2000-U+206F  }
  TT_UCR_GENERAL_PUNCTUATION = 1 shl 31;  
{ U+2E00-U+2E7F  }
{ ulUnicodeRange2  }
{ ---------------  }
{ Bit 32   Superscripts And Subscripts  }
{ U+2070-U+209F  }
  TT_UCR_SUPERSCRIPTS_SUBSCRIPTS = 1 shl 0;  
{ Bit 33   Currency Symbols  }
{ U+20A0-U+20CF  }
  TT_UCR_CURRENCY_SYMBOLS = 1 shl 1;  
{ Bit 34   Combining Diacritical Marks For Symbols  }
{ U+20D0-U+20FF  }
  TT_UCR_COMBINING_DIACRITICAL_MARKS_SYMB = 1 shl 2;  
{ Bit 35   Letterlike Symbols  }
{ U+2100-U+214F  }
  TT_UCR_LETTERLIKE_SYMBOLS = 1 shl 3;  
{ Bit 36   Number Forms  }
{ U+2150-U+218F  }
  TT_UCR_NUMBER_FORMS = 1 shl 4;  
{ Bit 37   Arrows                            }
{          Supplemental Arrows-A             }
{          Supplemental Arrows-B             }
{          Miscellaneous Symbols and Arrows  }
{ U+2190-U+21FF  }
  TT_UCR_ARROWS = 1 shl 5;  
{ U+27F0-U+27FF  }
{ U+2900-U+297F  }
{ U+2B00-U+2BFF  }
{ Bit 38   Mathematical Operators                }
{          Supplemental Mathematical Operators   }
{          Miscellaneous Mathematical Symbols-A  }
{          Miscellaneous Mathematical Symbols-B  }
{ U+2200-U+22FF  }
  TT_UCR_MATHEMATICAL_OPERATORS = 1 shl 6;  
{ U+2A00-U+2AFF  }
{ U+27C0-U+27EF  }
{ U+2980-U+29FF  }
{ Bit 39 Miscellaneous Technical  }
{ U+2300-U+23FF  }
  TT_UCR_MISCELLANEOUS_TECHNICAL = 1 shl 7;  
{ Bit 40   Control Pictures  }
{ U+2400-U+243F  }
  TT_UCR_CONTROL_PICTURES = 1 shl 8;  
{ Bit 41   Optical Character Recognition  }
{ U+2440-U+245F  }
  TT_UCR_OCR = 1 shl 9;  
{ Bit 42   Enclosed Alphanumerics  }
{ U+2460-U+24FF  }
  TT_UCR_ENCLOSED_ALPHANUMERICS = 1 shl 10;  
{ Bit 43   Box Drawing  }
{ U+2500-U+257F  }
  TT_UCR_BOX_DRAWING = 1 shl 11;  
{ Bit 44   Block Elements  }
{ U+2580-U+259F  }
  TT_UCR_BLOCK_ELEMENTS = 1 shl 12;  
{ Bit 45   Geometric Shapes  }
{ U+25A0-U+25FF  }
  TT_UCR_GEOMETRIC_SHAPES = 1 shl 13;  
{ Bit 46   Miscellaneous Symbols  }
{ U+2600-U+26FF  }
  TT_UCR_MISCELLANEOUS_SYMBOLS = 1 shl 14;  
{ Bit 47   Dingbats  }
{ U+2700-U+27BF  }
  TT_UCR_DINGBATS = 1 shl 15;  
{ Bit 48   CJK Symbols and Punctuation  }
{ U+3000-U+303F  }
  TT_UCR_CJK_SYMBOLS = 1 shl 16;  
{ Bit 49   Hiragana  }
{ U+3040-U+309F  }
  TT_UCR_HIRAGANA = 1 shl 17;  
{ Bit 50   Katakana                      }
{          Katakana Phonetic Extensions  }
{ U+30A0-U+30FF  }
  TT_UCR_KATAKANA = 1 shl 18;  
{ U+31F0-U+31FF  }
{ Bit 51   Bopomofo           }
{          Bopomofo Extended  }
{ U+3100-U+312F  }
  TT_UCR_BOPOMOFO = 1 shl 19;  
{ U+31A0-U+31BF  }
{ Bit 52   Hangul Compatibility Jamo  }
{ U+3130-U+318F  }
  TT_UCR_HANGUL_COMPATIBILITY_JAMO = 1 shl 20;  
{ Bit 53   Phags-Pa  }
{ U+A840-U+A87F  }
  TT_UCR_CJK_MISC = 1 shl 21;  
{ deprecated  }
  TT_UCR_KANBUN = TT_UCR_CJK_MISC;  
{$define TT_UCR_PHAGSPA}
{ Bit 54   Enclosed CJK Letters and Months  }
{ U+3200-U+32FF  }
  TT_UCR_ENCLOSED_CJK_LETTERS_MONTHS = 1 shl 22;  
{ Bit 55   CJK Compatibility  }
{ U+3300-U+33FF  }
  TT_UCR_CJK_COMPATIBILITY = 1 shl 23;  
{ Bit 56   Hangul Syllables  }
{ U+AC00-U+D7A3  }
  TT_UCR_HANGUL = 1 shl 24;  
{ Bit 57   High Surrogates               }
{          High Private Use Surrogates   }
{          Low Surrogates                }
{ According to OpenType specs v.1.3+,    }
{ setting bit 57 implies that there is   }
{ at least one codepoint beyond the      }
{ Basic Multilingual Plane that is       }
{ supported by this font.  So it really  }
{ means >= U+10000.                      }
{ U+D800-U+DB7F  }
  TT_UCR_SURROGATES = 1 shl 25;  
{ U+DB80-U+DBFF  }
{ U+DC00-U+DFFF  }
  TT_UCR_NON_PLANE_0 = TT_UCR_SURROGATES;  
{ Bit 58  Phoenician  }
{U+10900-U+1091F }
  TT_UCR_PHOENICIAN = 1 shl 26;  
{ Bit 59   CJK Unified Ideographs              }
{          CJK Radicals Supplement             }
{          Kangxi Radicals                     }
{          Ideographic Description Characters  }
{          CJK Unified Ideographs Extension A  }
{          CJK Unified Ideographs Extension B  }
{          Kanbun                              }
{ U+4E00-U+9FFF  }
  TT_UCR_CJK_UNIFIED_IDEOGRAPHS = 1 shl 27;  
{ U+2E80-U+2EFF  }
{ U+2F00-U+2FDF  }
{ U+2FF0-U+2FFF  }
{ U+3400-U+4DB5  }
{U+20000-U+2A6DF }
{ U+3190-U+319F  }
{ Bit 60   Private Use  }
{ U+E000-U+F8FF  }
  TT_UCR_PRIVATE_USE = 1 shl 28;  
{ Bit 61   CJK Strokes                              }
{          CJK Compatibility Ideographs             }
{          CJK Compatibility Ideographs Supplement  }
{ U+31C0-U+31EF  }
  TT_UCR_CJK_COMPATIBILITY_IDEOGRAPHS = 1 shl 29;  
{ U+F900-U+FAFF  }
{U+2F800-U+2FA1F }
{ Bit 62   Alphabetic Presentation Forms  }
{ U+FB00-U+FB4F  }
  TT_UCR_ALPHABETIC_PRESENTATION_FORMS = 1 shl 30;  
{ Bit 63   Arabic Presentation Forms-A  }
{ U+FB50-U+FDFF  }
  TT_UCR_ARABIC_PRESENTATION_FORMS_A = 1 shl 31;  
{ ulUnicodeRange3  }
{ ---------------  }
{ Bit 64   Combining Half Marks  }
{ U+FE20-U+FE2F  }
  TT_UCR_COMBINING_HALF_MARKS = 1 shl 0;  
{ Bit 65   Vertical forms           }
{          CJK Compatibility Forms  }
{ U+FE10-U+FE1F  }
  TT_UCR_CJK_COMPATIBILITY_FORMS = 1 shl 1;  
{ U+FE30-U+FE4F  }
{ Bit 66   Small Form Variants  }
{ U+FE50-U+FE6F  }
  TT_UCR_SMALL_FORM_VARIANTS = 1 shl 2;  
{ Bit 67   Arabic Presentation Forms-B  }
{ U+FE70-U+FEFE  }
  TT_UCR_ARABIC_PRESENTATION_FORMS_B = 1 shl 3;  
{ Bit 68   Halfwidth and Fullwidth Forms  }
{ U+FF00-U+FFEF  }
  TT_UCR_HALFWIDTH_FULLWIDTH_FORMS = 1 shl 4;  
{ Bit 69   Specials  }
{ U+FFF0-U+FFFD  }
  TT_UCR_SPECIALS = 1 shl 5;  
{ Bit 70   Tibetan  }
{ U+0F00-U+0FFF  }
  TT_UCR_TIBETAN = 1 shl 6;  
{ Bit 71   Syriac  }
{ U+0700-U+074F  }
  TT_UCR_SYRIAC = 1 shl 7;  
{ Bit 72   Thaana  }
{ U+0780-U+07BF  }
  TT_UCR_THAANA = 1 shl 8;  
{ Bit 73   Sinhala  }
{ U+0D80-U+0DFF  }
  TT_UCR_SINHALA = 1 shl 9;  
{ Bit 74   Myanmar  }
{ U+1000-U+109F  }
  TT_UCR_MYANMAR = 1 shl 10;  
{ Bit 75   Ethiopic             }
{          Ethiopic Supplement  }
{          Ethiopic Extended    }
{ U+1200-U+137F  }
  TT_UCR_ETHIOPIC = 1 shl 11;  
{ U+1380-U+139F  }
{ U+2D80-U+2DDF  }
{ Bit 76   Cherokee  }
{ U+13A0-U+13FF  }
  TT_UCR_CHEROKEE = 1 shl 12;  
{ Bit 77   Unified Canadian Aboriginal Syllabics  }
{ U+1400-U+167F  }
  TT_UCR_CANADIAN_ABORIGINAL_SYLLABICS = 1 shl 13;  
{ Bit 78   Ogham  }
{ U+1680-U+169F  }
  TT_UCR_OGHAM = 1 shl 14;  
{ Bit 79   Runic  }
{ U+16A0-U+16FF  }
  TT_UCR_RUNIC = 1 shl 15;  
{ Bit 80   Khmer          }
{          Khmer Symbols  }
{ U+1780-U+17FF  }
  TT_UCR_KHMER = 1 shl 16;  
{ U+19E0-U+19FF  }
{ Bit 81   Mongolian  }
{ U+1800-U+18AF  }
  TT_UCR_MONGOLIAN = 1 shl 17;  
{ Bit 82   Braille Patterns  }
{ U+2800-U+28FF  }
  TT_UCR_BRAILLE = 1 shl 18;  
{ Bit 83   Yi Syllables  }
{          Yi Radicals   }
{ U+A000-U+A48F  }
  TT_UCR_YI = 1 shl 19;  
{ U+A490-U+A4CF  }
{ Bit 84   Tagalog   }
{          Hanunoo   }
{          Buhid     }
{          Tagbanwa  }
{ U+1700-U+171F  }
  TT_UCR_PHILIPPINE = 1 shl 20;  
{ U+1720-U+173F  }
{ U+1740-U+175F  }
{ U+1760-U+177F  }
{ Bit 85   Old Italic  }
{U+10300-U+1032F }
  TT_UCR_OLD_ITALIC = 1 shl 21;  
{ Bit 86   Gothic  }
{U+10330-U+1034F }
  TT_UCR_GOTHIC = 1 shl 22;  
{ Bit 87   Deseret  }
{U+10400-U+1044F }
  TT_UCR_DESERET = 1 shl 23;  
{ Bit 88   Byzantine Musical Symbols       }
{          Musical Symbols                 }
{          Ancient Greek Musical Notation  }
{U+1D000-U+1D0FF }
  TT_UCR_MUSICAL_SYMBOLS = 1 shl 24;  
{U+1D100-U+1D1FF }
{U+1D200-U+1D24F }
{ Bit 89   Mathematical Alphanumeric Symbols  }
{U+1D400-U+1D7FF }
  TT_UCR_MATH_ALPHANUMERIC_SYMBOLS = 1 shl 25;  
{ Bit 90   Private Use (plane 15)  }
{          Private Use (plane 16)  }
{U+F0000-U+FFFFD }
  TT_UCR_PRIVATE_USE_SUPPLEMENTARY = 1 shl 26;  
{U+100000-U+10FFFD }
{ Bit 91   Variation Selectors             }
{          Variation Selectors Supplement  }
{ U+FE00-U+FE0F  }
  TT_UCR_VARIATION_SELECTORS = 1 shl 27;  
{U+E0100-U+E01EF }
{ Bit 92   Tags  }
{U+E0000-U+E007F }
  TT_UCR_TAGS = 1 shl 28;  
{ Bit 93   Limbu  }
{ U+1900-U+194F  }
  TT_UCR_LIMBU = 1 shl 29;  
{ Bit 94   Tai Le  }
{ U+1950-U+197F  }
  TT_UCR_TAI_LE = 1 shl 30;  
{ Bit 95   New Tai Lue  }
{ U+1980-U+19DF  }
  TT_UCR_NEW_TAI_LUE = 1 shl 31;  
{ ulUnicodeRange4  }
{ ---------------  }
{ Bit 96   Buginese  }
{ U+1A00-U+1A1F  }
  TT_UCR_BUGINESE = 1 shl 0;  
{ Bit 97   Glagolitic  }
{ U+2C00-U+2C5F  }
  TT_UCR_GLAGOLITIC = 1 shl 1;  
{ Bit 98   Tifinagh  }
{ U+2D30-U+2D7F  }
  TT_UCR_TIFINAGH = 1 shl 2;  
{ Bit 99   Yijing Hexagram Symbols  }
{ U+4DC0-U+4DFF  }
  TT_UCR_YIJING = 1 shl 3;  
{ Bit 100  Syloti Nagri  }
{ U+A800-U+A82F  }
  TT_UCR_SYLOTI_NAGRI = 1 shl 4;  
{ Bit 101  Linear B Syllabary  }
{          Linear B Ideograms  }
{          Aegean Numbers      }
{U+10000-U+1007F }
  TT_UCR_LINEAR_B = 1 shl 5;  
{U+10080-U+100FF }
{U+10100-U+1013F }
{ Bit 102  Ancient Greek Numbers  }
{U+10140-U+1018F }
  TT_UCR_ANCIENT_GREEK_NUMBERS = 1 shl 6;  
{ Bit 103  Ugaritic  }
{U+10380-U+1039F }
  TT_UCR_UGARITIC = 1 shl 7;  
{ Bit 104  Old Persian  }
{U+103A0-U+103DF }
  TT_UCR_OLD_PERSIAN = 1 shl 8;  
{ Bit 105  Shavian  }
{U+10450-U+1047F }
  TT_UCR_SHAVIAN = 1 shl 9;  
{ Bit 106  Osmanya  }
{U+10480-U+104AF }
  TT_UCR_OSMANYA = 1 shl 10;  
{ Bit 107  Cypriot Syllabary  }
{U+10800-U+1083F }
  TT_UCR_CYPRIOT_SYLLABARY = 1 shl 11;  
{ Bit 108  Kharoshthi  }
{U+10A00-U+10A5F }
  TT_UCR_KHAROSHTHI = 1 shl 12;  
{ Bit 109  Tai Xuan Jing Symbols  }
{U+1D300-U+1D35F }
  TT_UCR_TAI_XUAN_JING = 1 shl 13;  
{ Bit 110  Cuneiform                          }
{          Cuneiform Numbers and Punctuation  }
{U+12000-U+123FF }
  TT_UCR_CUNEIFORM = 1 shl 14;  
{U+12400-U+1247F }
{ Bit 111  Counting Rod Numerals  }
{U+1D360-U+1D37F }
  TT_UCR_COUNTING_ROD_NUMERALS = 1 shl 15;  
{ Bit 112  Sundanese  }
{ U+1B80-U+1BBF  }
  TT_UCR_SUNDANESE = 1 shl 16;  
{ Bit 113  Lepcha  }
{ U+1C00-U+1C4F  }
  TT_UCR_LEPCHA = 1 shl 17;  
{ Bit 114  Ol Chiki  }
{ U+1C50-U+1C7F  }
  TT_UCR_OL_CHIKI = 1 shl 18;  
{ Bit 115  Saurashtra  }
{ U+A880-U+A8DF  }
  TT_UCR_SAURASHTRA = 1 shl 19;  
{ Bit 116  Kayah Li  }
{ U+A900-U+A92F  }
  TT_UCR_KAYAH_LI = 1 shl 20;  
{ Bit 117  Rejang  }
{ U+A930-U+A95F  }
  TT_UCR_REJANG = 1 shl 21;  
{ Bit 118  Cham  }
{ U+AA00-U+AA5F  }
  TT_UCR_CHAM = 1 shl 22;  
{ Bit 119  Ancient Symbols  }
{U+10190-U+101CF }
  TT_UCR_ANCIENT_SYMBOLS = 1 shl 23;  
{ Bit 120  Phaistos Disc  }
{U+101D0-U+101FF }
  TT_UCR_PHAISTOS_DISC = 1 shl 24;  
{ Bit 121  Carian  }
{          Lycian  }
{          Lydian  }
{U+102A0-U+102DF }
  TT_UCR_OLD_ANATOLIAN = 1 shl 25;  
{U+10280-U+1029F }
{U+10920-U+1093F }
{ Bit 122  Domino Tiles   }
{          Mahjong Tiles  }
{U+1F030-U+1F09F }
  TT_UCR_GAME_TILES = 1 shl 26;  
{U+1F000-U+1F02F }
{ Bit 123-127 Reserved for process-internal usage  }
{  }
{ for backward compatibility with older FreeType versions  }
  TT_UCR_ARABIC_PRESENTATION_A = TT_UCR_ARABIC_PRESENTATION_FORMS_A;  
  TT_UCR_ARABIC_PRESENTATION_B = TT_UCR_ARABIC_PRESENTATION_FORMS_B;  
  TT_UCR_COMBINING_DIACRITICS = TT_UCR_COMBINING_DIACRITICAL_MARKS;  
  TT_UCR_COMBINING_DIACRITICS_SYMB = TT_UCR_COMBINING_DIACRITICAL_MARKS_SYMB;  
{$endif}
{ TTNAMEID_H_  }
{ END  }

implementation


end.
