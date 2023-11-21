unit videodev2;

interface

uses
  BaseUnix,
  v4l2_controls;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


  { SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause)  }
{
 *  Video for Linux Two header file
 *
 *  Copyright (C) 1999-2012 the contributors
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  Alternatively you can redistribute this file under the terms of the
 *  BSD license as stated below:
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *  3. The names of its contributors may not be used to endorse or promote
 *     products derived from this software without specific prior written
 *     permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Header file for v4l or V4L2 drivers and applications
 * with public API.
 * All kernel-specific stuff were moved to media/v4l2-dev.h, so
 * no #if __KERNEL tests are allowed here
 *
 *  See https://linuxtv.org for more info
 *
 *  Author: Bill Dirks <bill@thedirks.org>
 *    Justin Schoeman
 *              Hans Verkuil <hverkuil@xs4all.nl>
 *    et al.
  }

    const
     _IOC_NRBITS = 8;
     _IOC_TYPEBITS = 8;
     _IOC_SIZEBITS = 14;
     _IOC_DIRBITS = 2;
     _IOC_NRMASK = (1 shl _IOC_NRBITS)-1;
     _IOC_TYPEMASK = (1 shl _IOC_TYPEBITS)-1;
     _IOC_SIZEMASK = (1 shl _IOC_SIZEBITS)-1;
     _IOC_DIRMASK = (1 shl _IOC_DIRBITS)-1;
     _IOC_NRSHIFT = 0;
     _IOC_TYPESHIFT = _IOC_NRSHIFT+_IOC_NRBITS;
     _IOC_SIZESHIFT = _IOC_TYPESHIFT+_IOC_TYPEBITS;
     _IOC_DIRSHIFT = _IOC_SIZESHIFT+_IOC_SIZEBITS;
  {
   * Direction bits.
    }
     _IOC_NONE = 0;
     _IOC_WRITE = 1;
     _IOC_READ = 2;

const
  VIDEO_MAX_FRAME = 32;
  VIDEO_MAX_PLANES = 8;
{
 *  M I S C E L L A N E O U S
  }
  {  Four-character-code (FOURCC)  }
  {#define v4l2_fourcc(a, b, c, d)\ }
  {((__u32)(a) | ((__u32)(b) << 8) | ((__u32)(c) << 16) | ((__u32)(d) << 24)) }
  {#define v4l2_fourcc_be(a, b, c, d)  (v4l2_fourcc(a, b, c, d) | (1U << 31)) }
{
 *  E N U M S
  }
{ driver can choose from none,
           top, bottom, interlaced
           depending on whatever it thinks
           is approximate ...  }
  { this device has no fields ...  }
  { top field only  }
  { bottom field only  }
  { both fields interlaced  }
{ both fields sequential into one
           buffer, top-bottom order  }
  { same as above + bottom-top order  }
{ both fields alternating into
           separate buffers  }
{ both fields interlaced, top field
           first and the top field is
           transmitted first  }
{ both fields interlaced, top field
           first and the bottom field is
           transmitted first  }
type
  Tv4l2_field = longint;

const
  V4L2_FIELD_ANY = 0;
  V4L2_FIELD_NONE = 1;
  V4L2_FIELD_TOP = 2;
  V4L2_FIELD_BOTTOM = 3;
  V4L2_FIELD_INTERLACED = 4;
  V4L2_FIELD_SEQ_TB = 5;
  V4L2_FIELD_SEQ_BT = 6;
  V4L2_FIELD_ALTERNATE = 7;
  V4L2_FIELD_INTERLACED_TB = 8;
  V4L2_FIELD_INTERLACED_BT = 9;

  //#define V4L2_FIELD_HAS_TOP(field)  \
  //  ((field) == V4L2_FIELD_TOP   ||\
  //   (field) == V4L2_FIELD_INTERLACED ||\
  //   (field) == V4L2_FIELD_INTERLACED_TB ||\
  //   (field) == V4L2_FIELD_INTERLACED_BT ||\
  //   (field) == V4L2_FIELD_SEQ_TB  ||\
  //   (field) == V4L2_FIELD_SEQ_BT)
  //#define V4L2_FIELD_HAS_BOTTOM(field)  \
  //  ((field) == V4L2_FIELD_BOTTOM   ||\
  //   (field) == V4L2_FIELD_INTERLACED ||\
  //   (field) == V4L2_FIELD_INTERLACED_TB ||\
  //   (field) == V4L2_FIELD_INTERLACED_BT ||\
  //   (field) == V4L2_FIELD_SEQ_TB  ||\
  //   (field) == V4L2_FIELD_SEQ_BT)
  //#define V4L2_FIELD_HAS_BOTH(field)  \
  //  ((field) == V4L2_FIELD_INTERLACED ||\
  //   (field) == V4L2_FIELD_INTERLACED_TB ||\
  //   (field) == V4L2_FIELD_INTERLACED_BT ||\
  //   (field) == V4L2_FIELD_SEQ_TB ||\
  //   (field) == V4L2_FIELD_SEQ_BT)
  // }


{ Deprecated, do not use  }
type
  Tv4l2_buf_type = longint;

const
  V4L2_BUF_TYPE_VIDEO_CAPTURE = 1;
  V4L2_BUF_TYPE_VIDEO_OUTPUT = 2;
  V4L2_BUF_TYPE_VIDEO_OVERLAY = 3;
  V4L2_BUF_TYPE_VBI_CAPTURE = 4;
  V4L2_BUF_TYPE_VBI_OUTPUT = 5;
  V4L2_BUF_TYPE_SLICED_VBI_CAPTURE = 6;
  V4L2_BUF_TYPE_SLICED_VBI_OUTPUT = 7;
  V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY = 8;
  V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE = 9;
  V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE = 10;
  V4L2_BUF_TYPE_SDR_CAPTURE = 11;
  V4L2_BUF_TYPE_SDR_OUTPUT = 12;
  V4L2_BUF_TYPE_META_CAPTURE = 13;
  V4L2_BUF_TYPE_META_OUTPUT = 14;
  V4L2_BUF_TYPE_PRIVATE = $80;

  {
  #define V4L2_TYPE_IS_MULTIPLANAR(type)			\
  	((type) == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE	\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
  #define V4L2_TYPE_IS_OUTPUT(type)				\
  	((type) == V4L2_BUF_TYPE_VIDEO_OUTPUT			\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE		\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OVERLAY		\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY	\
  	 || (type) == V4L2_BUF_TYPE_VBI_OUTPUT			\
  	 || (type) == V4L2_BUF_TYPE_SLICED_VBI_OUTPUT)
   }

type
  Tv4l2_tuner_type = longint;

const
  V4L2_TUNER_RADIO = 1;
  V4L2_TUNER_ANALOG_TV = 2;
  V4L2_TUNER_DIGITAL_TV = 3;
  V4L2_TUNER_SDR = 4;
  V4L2_TUNER_RF = 5;

  { Deprecated, do not use  }
  V4L2_TUNER_ADC = V4L2_TUNER_SDR;

type
  Tv4l2_memory = longint;

const
  V4L2_MEMORY_MMAP = 1;
  V4L2_MEMORY_USERPTR = 2;
  V4L2_MEMORY_OVERLAY = 3;
  V4L2_MEMORY_DMABUF = 4;

  { see also http://vektor.theorem.ca/graphics/ycbcr/  }
{
   * Default colorspace, i.e. let the driver figure it out.
   * Can only be used with video capture.
    }
  { SMPTE 170M: used for broadcast NTSC/PAL SDTV  }
  { Obsolete pre-1998 SMPTE 240M HDTV standard, superseded by Rec 709  }
  { Rec.709: used for HDTV  }
{
   * Deprecated, do not use. No driver will ever return this. This was
   * based on a misunderstanding of the bt878 datasheet.
    }
{
   * NTSC 1953 colorspace. This only makes sense when dealing with
   * really, really old NTSC recordings. Superseded by SMPTE 170M.
    }
{
   * EBU Tech 3213 PAL/SECAM colorspace.
    }
{
   * Effectively shorthand for V4L2_COLORSPACE_SRGB, V4L2_YCBCR_ENC_601
   * and V4L2_QUANTIZATION_FULL_RANGE. To be used for (Motion-)JPEG.
    }
  { For RGB colorspaces such as produces by most webcams.  }
  { opRGB colorspace  }
  { BT.2020 colorspace, used for UHDTV.  }
  { Raw colorspace: for RAW unprocessed images  }
  { DCI-P3 colorspace, used by cinema projectors  }
type
  Tv4l2_colorspace = longint;

const
  V4L2_COLORSPACE_DEFAULT = 0;
  V4L2_COLORSPACE_SMPTE170M = 1;
  V4L2_COLORSPACE_SMPTE240M = 2;
  V4L2_COLORSPACE_REC709 = 3;
  V4L2_COLORSPACE_BT878 = 4;
  V4L2_COLORSPACE_470_SYSTEM_M = 5;
  V4L2_COLORSPACE_470_SYSTEM_BG = 6;
  V4L2_COLORSPACE_JPEG = 7;
  V4L2_COLORSPACE_SRGB = 8;
  V4L2_COLORSPACE_OPRGB = 9;
  V4L2_COLORSPACE_BT2020 = 10;
  V4L2_COLORSPACE_RAW = 11;
  V4L2_COLORSPACE_DCI_P3 = 12;

{
 * Determine how COLORSPACE_DEFAULT should map to a proper colorspace.
 * This depends on whether this is a SDTV image (use SMPTE 170M), an
 * HDTV image (use Rec. 709), or something else (use sRGB).
  }

{
   * Mapping of V4L2_XFER_FUNC_DEFAULT to actual transfer functions
   * for the various colorspaces:
   *
   * V4L2_COLORSPACE_SMPTE170M, V4L2_COLORSPACE_470_SYSTEM_M,
   * V4L2_COLORSPACE_470_SYSTEM_BG, V4L2_COLORSPACE_REC709 and
   * V4L2_COLORSPACE_BT2020: V4L2_XFER_FUNC_709
   *
   * V4L2_COLORSPACE_SRGB, V4L2_COLORSPACE_JPEG: V4L2_XFER_FUNC_SRGB
   *
   * V4L2_COLORSPACE_OPRGB: V4L2_XFER_FUNC_OPRGB
   *
   * V4L2_COLORSPACE_SMPTE240M: V4L2_XFER_FUNC_SMPTE240M
   *
   * V4L2_COLORSPACE_RAW: V4L2_XFER_FUNC_NONE
   *
   * V4L2_COLORSPACE_DCI_P3: V4L2_XFER_FUNC_DCI_P3
    }
type
  Tv4l2_xfer_func = longint;

const
  V4L2_XFER_FUNC_DEFAULT = 0;
  V4L2_XFER_FUNC_709 = 1;
  V4L2_XFER_FUNC_SRGB = 2;
  V4L2_XFER_FUNC_OPRGB = 3;
  V4L2_XFER_FUNC_SMPTE240M = 4;
  V4L2_XFER_FUNC_NONE = 5;
  V4L2_XFER_FUNC_DCI_P3 = 6;
  V4L2_XFER_FUNC_SMPTE2084 = 7;

{
 * Determine how XFER_FUNC_DEFAULT should map to a proper transfer function.
 * This depends on the colorspace.
  }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }

function V4L2_MAP_XFER_FUNC_DEFAULT(colsp: longint): longint;

{
   * Mapping of V4L2_YCBCR_ENC_DEFAULT to actual encodings for the
   * various colorspaces:
   *
   * V4L2_COLORSPACE_SMPTE170M, V4L2_COLORSPACE_470_SYSTEM_M,
   * V4L2_COLORSPACE_470_SYSTEM_BG, V4L2_COLORSPACE_SRGB,
   * V4L2_COLORSPACE_OPRGB and V4L2_COLORSPACE_JPEG: V4L2_YCBCR_ENC_601
   *
   * V4L2_COLORSPACE_REC709 and V4L2_COLORSPACE_DCI_P3: V4L2_YCBCR_ENC_709
   *
   * V4L2_COLORSPACE_BT2020: V4L2_YCBCR_ENC_BT2020
   *
   * V4L2_COLORSPACE_SMPTE240M: V4L2_YCBCR_ENC_SMPTE240M
    }
{ ITU-R 601 -- SDTV  }
{ Rec. 709 -- HDTV  }
{ ITU-R 601/EN 61966-2-4 Extended Gamut -- SDTV  }
{ Rec. 709/EN 61966-2-4 Extended Gamut -- HDTV  }
{
   * sYCC (Y'CbCr encoding of sRGB), identical to ENC_601. It was added
   * originally due to a misunderstanding of the sYCC standard. It should
   * not be used, instead use V4L2_YCBCR_ENC_601.
    }
{ BT.2020 Non-constant Luminance Y'CbCr  }
{ BT.2020 Constant Luminance Y'CbcCrc  }
{ SMPTE 240M -- Obsolete HDTV  }
type
  Tv4l2_ycbcr_encoding = longint;

const
  V4L2_YCBCR_ENC_DEFAULT = 0;
  V4L2_YCBCR_ENC_601 = 1;
  V4L2_YCBCR_ENC_709 = 2;
  V4L2_YCBCR_ENC_XV601 = 3;
  V4L2_YCBCR_ENC_XV709 = 4;
  V4L2_YCBCR_ENC_SYCC = 5;
  V4L2_YCBCR_ENC_BT2020 = 6;
  V4L2_YCBCR_ENC_BT2020_CONST_LUM = 7;
  V4L2_YCBCR_ENC_SMPTE240M = 8;

{
 * enum v4l2_hsv_encoding values should not collide with the ones from
 * enum v4l2_ycbcr_encoding.
  }
  { Hue mapped to 0 - 179  }
  { Hue mapped to 0 - 255  }
type
  Tv4l2_hsv_encoding = longint;

const
  V4L2_HSV_ENC_180 = 128;
  V4L2_HSV_ENC_256 = 129;

{
   * The default for R'G'B' quantization is always full range.
   * For Y'CbCr the quantization is always limited range, except
   * for COLORSPACE_JPEG: this is full range.
    }
type
  Tv4l2_quantization = longint;

const
  V4L2_QUANTIZATION_DEFAULT = 0;
  V4L2_QUANTIZATION_FULL_RANGE = 1;
  V4L2_QUANTIZATION_LIM_RANGE = 2;

{
 * Deprecated names for opRGB colorspace (IEC 61966-2-5)
 *
 * WARNING: Please don't use these deprecated defines in your code, as
 * there is a chance we have to remove them in the future.
  }
const
  V4L2_COLORSPACE_ADOBERGB = V4L2_COLORSPACE_OPRGB;
  V4L2_XFER_FUNC_ADOBERGB = V4L2_XFER_FUNC_OPRGB;
  { not initialized  }
type
  Tv4l2_priority = longint;

const
  V4L2_PRIORITY_UNSET = 0;
  V4L2_PRIORITY_BACKGROUND = 1;
  V4L2_PRIORITY_INTERACTIVE = 2;
  V4L2_PRIORITY_RECORD = 3;
  V4L2_PRIORITY_DEFAULT = V4L2_PRIORITY_INTERACTIVE;

type
  Pv4l2_rect = ^Tv4l2_rect;

  Tv4l2_rect = record
    left: int32;
    top: int32;
    Width: int32;
    Height: int32;
  end;

  Pv4l2_fract = ^Tv4l2_fract;

  Tv4l2_fract = record
    numerator: uint32;
    denominator: uint32;
  end;

  Pv4l2_area = ^Tv4l2_area;

  Tv4l2_area = record
    Width: uint32;
    Height: uint32;
  end;

{*
  * struct v4l2_capability - Describes V4L2 device caps returned by VIDIOC_QUERYCAP
  *
  * @driver:     name of the driver module (e.g. "bttv")
  * @card:     name of the card (e.g. "Hauppauge WinTV")
  * @bus_info:     name of the bus (e.g. "PCI:" + pci_name(pci_dev) )
  * @version:     KERNEL_VERSION
  * @capabilities: capabilities of the physical device as a whole
  * @device_caps:  capabilities accessed via this particular device (node)
  * @reserved:     reserved fields for future extensions
   }
  Pv4l2_capability = ^Tv4l2_capability;

  Tv4l2_capability = record
    driver: array[0..15] of char;
    card: array[0..31] of char;
    bus_info: array[0..31] of char;
    version: uint32;
    capabilities: uint32;
    device_caps: uint32;
    reserved: array[0..2] of uint32;
  end;

  { Values for 'capabilities' field  }
  { Is a video capture device  }

const
  V4L2_CAP_VIDEO_CAPTURE = $00000001;
  { Is a video output device  }
  V4L2_CAP_VIDEO_OUTPUT = $00000002;
  { Can do video overlay  }
  V4L2_CAP_VIDEO_OVERLAY = $00000004;
  { Is a raw VBI capture device  }
  V4L2_CAP_VBI_CAPTURE = $00000010;
  { Is a raw VBI output device  }
  V4L2_CAP_VBI_OUTPUT = $00000020;
  { Is a sliced VBI capture device  }
  V4L2_CAP_SLICED_VBI_CAPTURE = $00000040;
  { Is a sliced VBI output device  }
  V4L2_CAP_SLICED_VBI_OUTPUT = $00000080;
  { RDS data capture  }
  V4L2_CAP_RDS_CAPTURE = $00000100;
  { Can do video output overlay  }
  V4L2_CAP_VIDEO_OUTPUT_OVERLAY = $00000200;
  { Can do hardware frequency seek   }
  V4L2_CAP_HW_FREQ_SEEK = $00000400;
  { Is an RDS encoder  }
  V4L2_CAP_RDS_OUTPUT = $00000800;
  { Is a video capture device that supports multiplanar formats  }
  V4L2_CAP_VIDEO_CAPTURE_MPLANE = $00001000;
  { Is a video output device that supports multiplanar formats  }
  V4L2_CAP_VIDEO_OUTPUT_MPLANE = $00002000;
  { Is a video mem-to-mem device that supports multiplanar formats  }
  V4L2_CAP_VIDEO_M2M_MPLANE = $00004000;
  { Is a video mem-to-mem device  }
  V4L2_CAP_VIDEO_M2M = $00008000;
  { has a tuner  }
  V4L2_CAP_TUNER = $00010000;
  { has audio support  }
  V4L2_CAP_AUDIO = $00020000;
  { is a radio device  }
  V4L2_CAP_RADIO = $00040000;
  { has a modulator  }
  V4L2_CAP_MODULATOR = $00080000;
  { Is a SDR capture device  }
  V4L2_CAP_SDR_CAPTURE = $00100000;
  { Supports the extended pixel format  }
  V4L2_CAP_EXT_PIX_FORMAT = $00200000;
  { Is a SDR output device  }
  V4L2_CAP_SDR_OUTPUT = $00400000;
  { Is a metadata capture device  }
  V4L2_CAP_META_CAPTURE = $00800000;
  { read/write systemcalls  }
  V4L2_CAP_READWRITE = $01000000;
  { async I/O  }
  V4L2_CAP_ASYNCIO = $02000000;
  { streaming I/O ioctls  }
  V4L2_CAP_STREAMING = $04000000;
  { Is a metadata output device  }
  V4L2_CAP_META_OUTPUT = $08000000;
  { Is a touch device  }
  V4L2_CAP_TOUCH = $10000000;
  { Is input/output controlled by the media controller  }
  V4L2_CAP_IO_MC = $20000000;
  { sets device capabilities field  }
  V4L2_CAP_DEVICE_CAPS = $80000000;
{
 *  V I D E O   I M A G E   F O R M A T
  }

type
  Pv4l2_pix_format = ^Tv4l2_pix_format;

  Tv4l2_pix_format = record
    Width: uint32;
    Height: uint32;
    pixelformat: uint32;
    field: uint32;
    bytesperline: uint32;
    sizeimage: uint32;
    colorspace: uint32;
    priv: uint32;
    flags: uint32;
    u: record
      case longint of
        0: (ycbcr_enc: uint32);
        1: (hsv_enc: uint32);
      end;
    quantization: uint32;
    xfer_func: uint32;
  end;

  {      Pixel format         FOURCC                          depth  Description  }
const
  { RGB formats }
  V4L2_PIX_FMT_RGB332 = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('1') shl 24); {  8  RGB-3-3-2     *}
  V4L2_PIX_FMT_RGB444 = (Ord('R')) or (Ord('4') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); { 16  xxxxrrrr ggggbbbb *}
  V4L2_PIX_FMT_RGB555 = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('O') shl 24); { 16  RGB-5-5-5     *}
  V4L2_PIX_FMT_RGB565 = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('P') shl 24); { 16  RGB-5-6-5     *}
  V4L2_PIX_FMT_RGB555X = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('Q') shl 24); { 16  RGB-5-5-5 BE  *}
  V4L2_PIX_FMT_RGB565X = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('R') shl 24); { 16  RGB-5-6-5 BE  *}
  V4L2_PIX_FMT_BGR666 = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('H') shl 24); { 18  BGR-6-6-6     *}
  V4L2_PIX_FMT_BGR24 = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('3') shl 24); { 24  BGR-8-8-8     *}
  V4L2_PIX_FMT_RGB24 = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('3') shl 24); { 24  RGB-8-8-8     *}
  V4L2_PIX_FMT_BGR32 = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('4') shl 24); { 32  BGR-8-8-8-8   *}
  V4L2_PIX_FMT_RGB32 = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('4') shl 24); { 32  RGB-8-8-8-8   *}

  { Grey formats }
  V4L2_PIX_FMT_GREY = (Ord('G')) or (Ord('R') shl 8) or (Ord('E') shl 16) or (Ord('Y') shl 24); {  8  Greyscale     *}
  V4L2_PIX_FMT_Y4 = (Ord('Y')) or (Ord('0') shl 8) or (Ord('4') shl 16) or (Ord(' ') shl 24); {  4  Greyscale     *}
  V4L2_PIX_FMT_Y6 = (Ord('Y')) or (Ord('0') shl 8) or (Ord('6') shl 16) or (Ord(' ') shl 24); {  6  Greyscale     *}
  V4L2_PIX_FMT_Y10 = (Ord('Y')) or (Ord('1') shl 8) or (Ord('0') shl 16) or (Ord(' ') shl 24); { 10  Greyscale     *}
  V4L2_PIX_FMT_Y12 = (Ord('Y')) or (Ord('1') shl 8) or (Ord('2') shl 16) or (Ord(' ') shl 24); { 12  Greyscale     *}
  V4L2_PIX_FMT_Y16 = (Ord('Y')) or (Ord('1') shl 8) or (Ord('6') shl 16) or (Ord(' ') shl 24); { 16  Greyscale     *}

  { Grey bit-packed formats }
  V4L2_PIX_FMT_Y10BPACK = (Ord('Y')) or (Ord('1') shl 8) or (Ord('0') shl 16) or (Ord('B') shl 24); { 10  Greyscale bit-packed *}

  { Palette formats }
  V4L2_PIX_FMT_PAL8 = (Ord('P')) or (Ord('A') shl 8) or (Ord('L') shl 16) or (Ord('8') shl 24); {  8  8-bit palette *}

  { Chrominance formats }
  V4L2_PIX_FMT_UV8 = (Ord('U')) or (Ord('V') shl 8) or (Ord('8') shl 16) or (Ord(' ') shl 24); {  8  UV 4:4 *}

  { Luminance+Chrominance formats }
  V4L2_PIX_FMT_YVU410 = (Ord('Y')) or (Ord('V') shl 8) or (Ord('U') shl 16) or (Ord('9') shl 24); {  9  YVU 4:1:0     *}
  V4L2_PIX_FMT_YVU420 = (Ord('Y')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YVU 4:2:0     *}
  V4L2_PIX_FMT_YUYV = (Ord('Y')) or (Ord('U') shl 8) or (Ord('Y') shl 16) or (Ord('V') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YYUV = (Ord('Y')) or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YVYU = (Ord('Y')) or (Ord('V') shl 8) or (Ord('Y') shl 16) or (Ord('U') shl 24); { 16 YVU 4:2:2 *}
  V4L2_PIX_FMT_UYVY = (Ord('U')) or (Ord('Y') shl 8) or (Ord('V') shl 16) or (Ord('Y') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_VYUY = (Ord('V')) or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('Y') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YUV422P = (Ord('4')) or (Ord('2') shl 8) or (Ord('2') shl 16) or (Ord('P') shl 24); { 16  YVU422 planar *}
  V4L2_PIX_FMT_YUV411P = (Ord('4')) or (Ord('1') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); { 16  YVU411 planar *}
  V4L2_PIX_FMT_Y41P = (Ord('Y')) or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); { 12  YUV 4:1:1     *}
  V4L2_PIX_FMT_YUV444 = (Ord('Y')) or (Ord('4') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); { 16  xxxxyyyy uuuuvvvv *}
  V4L2_PIX_FMT_YUV555 = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('O') shl 24); { 16  YUV-5-5-5     *}
  V4L2_PIX_FMT_YUV565 = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('P') shl 24); { 16  YUV-5-6-5     *}
  V4L2_PIX_FMT_YUV32 = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('4') shl 24); { 32  YUV-8-8-8-8   *}
  V4L2_PIX_FMT_YUV410 = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('9') shl 24); {  9  YUV 4:1:0     *}
  V4L2_PIX_FMT_YUV420 = (Ord('Y')) or (Ord('U') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YUV 4:2:0     *}
  V4L2_PIX_FMT_HI240 = (Ord('H')) or (Ord('I') shl 8) or (Ord('2') shl 16) or (Ord('4') shl 24); {  8  8-bit color   *}
  V4L2_PIX_FMT_HM12 = (Ord('H')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); {  8  YUV 4:2:0 16x16 macroblocks *}
  V4L2_PIX_FMT_M420 = (Ord('M')) or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { 12  YUV 4:2:0 2 lines y, 1 line uv interleaved *}

  { two planes -- one Y, one Cr + Cb interleaved  }
  V4L2_PIX_FMT_NV12 = (Ord('N')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0  *}
  V4L2_PIX_FMT_NV21 = (Ord('N')) or (Ord('V') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 12  Y/CrCb 4:2:0  *}
  V4L2_PIX_FMT_NV16 = (Ord('N')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); { 16  Y/CbCr 4:2:2  *}
  V4L2_PIX_FMT_NV61 = (Ord('N')) or (Ord('V') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { 16  Y/CrCb 4:2:2  *}
  V4L2_PIX_FMT_NV24 = (Ord('N')) or (Ord('V') shl 8) or (Ord('2') shl 16) or (Ord('4') shl 24); { 24  Y/CbCr 4:4:4  *}
  V4L2_PIX_FMT_NV42 = (Ord('N')) or (Ord('V') shl 8) or (Ord('4') shl 16) or (Ord('2') shl 24); { 24  Y/CrCb 4:4:4  *}

  { two non contiguous planes - one Y, one Cr + Cb interleaved  }
  V4L2_PIX_FMT_NV12M = (Ord('N')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0  *}
  V4L2_PIX_FMT_NV21M = (Ord('N')) or (Ord('M') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 21  Y/CrCb 4:2:0  *}
  V4L2_PIX_FMT_NV16M = (Ord('N')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); { 16  Y/CbCr 4:2:2  *}
  V4L2_PIX_FMT_NV61M = (Ord('N')) or (Ord('M') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { 16  Y/CrCb 4:2:2  *}
  V4L2_PIX_FMT_NV12MT = (Ord('T')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0 64x32 macroblocks *}
  V4L2_PIX_FMT_NV12MT_16X16 = (Ord('V')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0 16x16 macroblocks *}

  { three non contiguous planes - Y, Cb, Cr }
  V4L2_PIX_FMT_YUV420M = (Ord('Y')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YUV420 planar *}
  V4L2_PIX_FMT_YVU420M = (Ord('Y')) or (Ord('M') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 12  YVU420 planar *}

  { Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm }
  V4L2_PIX_FMT_SBGGR8 = (Ord('B')) or (Ord('A') shl 8) or (Ord('8') shl 16) or (Ord('1') shl 24); {  8  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG8 = (Ord('G')) or (Ord('B') shl 8) or (Ord('R') shl 16) or (Ord('G') shl 24); {  8  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG8 = (Ord('G')) or (Ord('R') shl 8) or (Ord('B') shl 16) or (Ord('G') shl 24); {  8  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB8 = (Ord('R')) or (Ord('G') shl 8) or (Ord('G') shl 16) or (Ord('B') shl 24); {  8  RGRG.. GBGB.. *}
  V4L2_PIX_FMT_SBGGR10 = (Ord('B')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG10 = (Ord('G')) or (Ord('B') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG10 = (Ord('B')) or (Ord('A') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB10 = (Ord('R')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  RGRG.. GBGB.. *}
  V4L2_PIX_FMT_SBGGR12 = (Ord('B')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG12 = (Ord('G')) or (Ord('B') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG12 = (Ord('B')) or (Ord('A') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB12 = (Ord('R')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  RGRG.. GBGB.. *}
  { 10bit raw bayer a-law compressed to 8 bits }
  V4L2_PIX_FMT_SBGGR10ALAW8 = (Ord('a')) or (Ord('B') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGBRG10ALAW8 = (Ord('a')) or (Ord('G') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGRBG10ALAW8 = (Ord('a')) or (Ord('g') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SRGGB10ALAW8 = (Ord('a')) or (Ord('R') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  { 10bit raw bayer DPCM compressed to 8 bits }
  V4L2_PIX_FMT_SBGGR10DPCM8 = (Ord('b')) or (Ord('B') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGBRG10DPCM8 = (Ord('b')) or (Ord('G') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGRBG10DPCM8 = (Ord('B')) or (Ord('D') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24);
  V4L2_PIX_FMT_SRGGB10DPCM8 = (Ord('b')) or (Ord('R') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
          {
           * 10bit raw bayer, expanded to 16 bits
           * xxxxrrrrrrrrrrxxxxgggggggggg xxxxggggggggggxxxxbbbbbbbbbb...
           }
  V4L2_PIX_FMT_SBGGR16 = (Ord('B')) or (Ord('Y') shl 8) or (Ord('R') shl 16) or (Ord('2') shl 24); { 16  BGBG.. GRGR.. *}

  { compressed formats }
  V4L2_PIX_FMT_MJPEG = (Ord('M')) or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); { Motion-JPEG   *}
  V4L2_PIX_FMT_JPEG = (Ord('J')) or (Ord('P') shl 8) or (Ord('E') shl 16) or (Ord('G') shl 24); { JFIF JPEG     *}
  V4L2_PIX_FMT_DV = (Ord('d')) or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('d') shl 24); { 1394          *}
  V4L2_PIX_FMT_MPEG = (Ord('M')) or (Ord('P') shl 8) or (Ord('E') shl 16) or (Ord('G') shl 24); { MPEG-1/2/4 Multiplexed *}
  V4L2_PIX_FMT_H264 = (Ord('H')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24); { H264 with start codes *}
  V4L2_PIX_FMT_H264_NO_SC = (Ord('A')) or (Ord('V') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); { H264 without start codes *}
  V4L2_PIX_FMT_H264_MVC = (Ord('M')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24); { H264 MVC *}
  V4L2_PIX_FMT_H263 = (Ord('H')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('3') shl 24); { H263          *}
  V4L2_PIX_FMT_MPEG1 = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('1') shl 24); { MPEG-1 ES     *}
  V4L2_PIX_FMT_MPEG2 = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('2') shl 24); { MPEG-2 ES     *}
  V4L2_PIX_FMT_MPEG4 = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('4') shl 24); { MPEG-4 part 2 ES *}
  V4L2_PIX_FMT_XVID = (Ord('X')) or (Ord('V') shl 8) or (Ord('I') shl 16) or (Ord('D') shl 24); { Xvid           *}
  V4L2_PIX_FMT_VC1_ANNEX_G = (Ord('V')) or (Ord('C') shl 8) or (Ord('1') shl 16) or (Ord('G') shl 24); { SMPTE 421M Annex G compliant stream *}
  V4L2_PIX_FMT_VC1_ANNEX_L = (Ord('V')) or (Ord('C') shl 8) or (Ord('1') shl 16) or (Ord('L') shl 24); { SMPTE 421M Annex L compliant stream *}
  V4L2_PIX_FMT_VP8 = (Ord('V')) or (Ord('P') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); { VP8 *}

  {  Vendor-specific formats   }
  V4L2_PIX_FMT_CPIA1 = (Ord('C')) or (Ord('P') shl 8) or (Ord('I') shl 16) or (Ord('A') shl 24); { cpia1 YUV *}
  V4L2_PIX_FMT_WNVA = (Ord('W')) or (Ord('N') shl 8) or (Ord('V') shl 16) or (Ord('A') shl 24); { Winnov hw compress *}
  V4L2_PIX_FMT_SN9C10X = (Ord('S')) or (Ord('9') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { SN9C10x compression *}
  V4L2_PIX_FMT_SN9C20X_I420 = (Ord('S')) or (Ord('9') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { SN9C20x YUV 4:2:0 *}
  V4L2_PIX_FMT_PWC1 = (Ord('P')) or (Ord('W') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); { pwc older webcam *}
  V4L2_PIX_FMT_PWC2 = (Ord('P')) or (Ord('W') shl 8) or (Ord('C') shl 16) or (Ord('2') shl 24); { pwc newer webcam *}
  V4L2_PIX_FMT_ET61X251 = (Ord('E')) or (Ord('6') shl 8) or (Ord('2') shl 16) or (Ord('5') shl 24); { ET61X251 compression *}
  V4L2_PIX_FMT_SPCA501 = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('1') shl 24); { YUYV per line *}
  V4L2_PIX_FMT_SPCA505 = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('5') shl 24); { YYUV per line *}
  V4L2_PIX_FMT_SPCA508 = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('8') shl 24); { YUVY per line *}
  V4L2_PIX_FMT_SPCA561 = (Ord('S')) or (Ord('5') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { compressed GBRG bayer *}
  V4L2_PIX_FMT_PAC207 = (Ord('P')) or (Ord('2') shl 8) or (Ord('0') shl 16) or (Ord('7') shl 24); { compressed BGGR bayer *}
  V4L2_PIX_FMT_MR97310A = (Ord('M')) or (Ord('3') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { compressed BGGR bayer *}
  V4L2_PIX_FMT_JL2005BCD = (Ord('J')) or (Ord('L') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { compressed RGGB bayer *}
  V4L2_PIX_FMT_SN9C2028 = (Ord('S')) or (Ord('O') shl 8) or (Ord('N') shl 16) or (Ord('X') shl 24); { compressed GBRG bayer *}
  V4L2_PIX_FMT_SQ905C = (Ord('9')) or (Ord('0') shl 8) or (Ord('5') shl 16) or (Ord('C') shl 24); { compressed RGGB bayer *}
  V4L2_PIX_FMT_PJPG = (Ord('P')) or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); { Pixart 73xx JPEG *}
  V4L2_PIX_FMT_OV511 = (Ord('O')) or (Ord('5') shl 8) or (Ord('1') shl 16) or (Ord('1') shl 24); { ov511 JPEG *}
  V4L2_PIX_FMT_OV518 = (Ord('O')) or (Ord('5') shl 8) or (Ord('1') shl 16) or (Ord('8') shl 24); { ov518 JPEG *}
  V4L2_PIX_FMT_STV0680 = (Ord('S')) or (Ord('6') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); { stv0680 bayer *}
  V4L2_PIX_FMT_TM6000 = (Ord('T')) or (Ord('M') shl 8) or (Ord('6') shl 16) or (Ord('0') shl 24); { tm5600/tm60x0 *}
  V4L2_PIX_FMT_CIT_YYVYUY = (Ord('C')) or (Ord('I') shl 8) or (Ord('T') shl 16) or (Ord('V') shl 24); { one line of Y then 1 line of VYUY *}
  V4L2_PIX_FMT_KONICA420 = (Ord('K')) or (Ord('O') shl 8) or (Ord('N') shl 16) or (Ord('I') shl 24); { YUV420 planar in blocks of 256 pixels *}
  V4L2_PIX_FMT_JPGL = (Ord('J')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('L') shl 24); { JPEG-Lite *}
  V4L2_PIX_FMT_SE401 = (Ord('S')) or (Ord('4') shl 8) or (Ord('0') shl 16) or (Ord('1') shl 24); { se401 janggu compressed rgb *}
  V4L2_PIX_FMT_S5C_UYVY_JPG = (Ord('S')) or (Ord('5') shl 8) or (Ord('C') shl 16) or (Ord('I') shl 24); { S5C73M3 interleaved UYVY/JPEG *}

const
  V4L2_PIX_FMT_PRIV_MAGIC = $feedcafe;
  { Flags  }
  V4L2_PIX_FMT_FLAG_PREMUL_ALPHA = $00000001;
  V4L2_PIX_FMT_FLAG_SET_CSC = $00000002;
{
 *  F O R M A T   E N U M E R A T I O N
  }
  { Format number       }
  { enum v4l2_buf_type  }
  { Description string  }
  { Format fourcc       }
  { Media bus code     }
type
  Pv4l2_fmtdesc = ^Tv4l2_fmtdesc;

  Tv4l2_fmtdesc = record
    index: uint32;
    _type: uint32;
    flags: uint32;
    description: array[0..31] of char;
    pixelformat: uint32;
    mbus_code: uint32;
    reserved: array[0..2] of uint32;
  end;


const
  V4L2_FMT_FLAG_COMPRESSED = $0001;
  V4L2_FMT_FLAG_EMULATED = $0002;
  V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM = $0004;
  V4L2_FMT_FLAG_DYN_RESOLUTION = $0008;
  V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL = $0010;
  V4L2_FMT_FLAG_CSC_COLORSPACE = $0020;
  V4L2_FMT_FLAG_CSC_XFER_FUNC = $0040;
  V4L2_FMT_FLAG_CSC_YCBCR_ENC = $0080;
  V4L2_FMT_FLAG_CSC_HSV_ENC = V4L2_FMT_FLAG_CSC_YCBCR_ENC;
  V4L2_FMT_FLAG_CSC_QUANTIZATION = $0100;
  { Frame Size and frame rate enumeration  }
{
 *  F R A M E   S I Z E   E N U M E R A T I O N
  }
type
  Tv4l2_frmsizetypes = longint;

const
  V4L2_FRMSIZE_TYPE_DISCRETE = 1;
  V4L2_FRMSIZE_TYPE_CONTINUOUS = 2;
  V4L2_FRMSIZE_TYPE_STEPWISE = 3;

  { Frame width [pixel]  }
  { Frame height [pixel]  }
type
  Pv4l2_frmsize_discrete = ^Tv4l2_frmsize_discrete;

  Tv4l2_frmsize_discrete = record
    Width: uint32;
    Height: uint32;
  end;

  { Minimum frame width [pixel]  }
  { Maximum frame width [pixel]  }
  { Frame width step size [pixel]  }
  { Minimum frame height [pixel]  }
  { Maximum frame height [pixel]  }
  { Frame height step size [pixel]  }
  Pv4l2_frmsize_stepwise = ^Tv4l2_frmsize_stepwise;

  Tv4l2_frmsize_stepwise = record
    min_width: uint32;
    max_width: uint32;
    step_width: uint32;
    min_height: uint32;
    max_height: uint32;
    step_height: uint32;
  end;

  { Frame size number  }
  { Pixel format  }
  { Frame size type the device supports.  }
  { Frame size  }
  { Reserved space for future use  }
  Pv4l2_frmsizeenum = ^Tv4l2_frmsizeenum;

  Tv4l2_frmsizeenum = record
    index: uint32;
    pixel_format: uint32;
    _type: uint32;
    u: record
      case longint of
        0: (discrete: Tv4l2_frmsize_discrete);
        1: (stepwise: Tv4l2_frmsize_stepwise);
      end;
    reserved: array[0..1] of uint32;
  end;

{
 *  F R A M E   R A T E   E N U M E R A T I O N
  }
  Tv4l2_frmivaltypes = longint;

const
  V4L2_FRMIVAL_TYPE_DISCRETE = 1;
  V4L2_FRMIVAL_TYPE_CONTINUOUS = 2;
  V4L2_FRMIVAL_TYPE_STEPWISE = 3;

  { Minimum frame interval [s]  }
  { Maximum frame interval [s]  }
  { Frame interval step size [s]  }
type
  Pv4l2_frmival_stepwise = ^Tv4l2_frmival_stepwise;

  Tv4l2_frmival_stepwise = record
    min: Tv4l2_fract;
    max: Tv4l2_fract;
    step: Tv4l2_fract;
  end;

  { Frame format index  }
  { Pixel format  }
  { Frame width  }
  { Frame height  }
  { Frame interval type the device supports.  }
  { Frame interval  }
  { Reserved space for future use  }
  Pv4l2_frmivalenum = ^Tv4l2_frmivalenum;

  Tv4l2_frmivalenum = record
    index: uint32;
    pixel_format: uint32;
    Width: uint32;
    Height: uint32;
    _type: uint32;
    u: record
      case longint of
        0: (discrete: Tv4l2_fract);
        1: (stepwise: Tv4l2_frmival_stepwise);
      end;
    reserved: array[0..1] of uint32;
  end;

{
 *  T I M E C O D E
  }
  Pv4l2_timecode = ^Tv4l2_timecode;

  Tv4l2_timecode = record
    _type: uint32;
    flags: uint32;
    frames: char;
    seconds: char;
    minutes: char;
    hours: char;
    userbits: array[0..3] of char;
  end;

  {  Type   }

const
  V4L2_TC_TYPE_24FPS = 1;
  V4L2_TC_TYPE_25FPS = 2;
  V4L2_TC_TYPE_30FPS = 3;
  V4L2_TC_TYPE_50FPS = 4;
  V4L2_TC_TYPE_60FPS = 5;
  {  Flags   }
  { "drop-frame" mode  }
  V4L2_TC_FLAG_DROPFRAME = $0001;
  V4L2_TC_FLAG_COLORFRAME = $0002;
  V4L2_TC_USERBITS_field = $000C;
  V4L2_TC_USERBITS_USERDEFINED = $0000;
  V4L2_TC_USERBITS_8BITCHARS = $0008;
  { The above is based on SMPTE timecodes  }
  { Define Huffman Tables  }
  V4L2_JPEG_MARKER_DHT = 1 shl 3;
  { Define Quantization Tables  }
  V4L2_JPEG_MARKER_DQT = 1 shl 4;
  { Define Restart Interval  }
  V4L2_JPEG_MARKER_DRI = 1 shl 5;
  { Comment segment  }
  V4L2_JPEG_MARKER_COM = 1 shl 6;
{ App segment, driver will
          * always use APP0  }
  V4L2_JPEG_MARKER_APP = 1 shl 7;
{ Number of APP segment to be written,
         * must be 0..15  }
  { Length of data in JPEG APPn segment  }
  { Data in the JPEG APPn segment.  }
  { Length of data in JPEG COM segment  }
  { Data in JPEG COM segment  }
{ Which markers should go into the JPEG
         * output. Unless you exactly know what
         * you do, leave them untouched.
         * Including less markers will make the
         * resulting code smaller, but there will
         * be fewer applications which can read it.
         * The presence of the APP and COM marker
         * is influenced by APP_len and COM_len
         * ONLY, not by this property!  }
type
  Pv4l2_jpegcompression = ^Tv4l2_jpegcompression;

  Tv4l2_jpegcompression = record
    quality: longint;
    APPn: longint;
    APP_len: longint;
    APP_data: array[0..59] of char;
    COM_len: longint;
    COM_data: array[0..59] of char;
    jpeg_markers: uint32;
  end;

{
 *  M E M O R Y - M A P P I N G   B U F F E R S
  }
  { enum v4l2_buf_type  }
  { enum v4l2_memory  }
  Pv4l2_requestbuffers = ^Tv4l2_requestbuffers;

  Tv4l2_requestbuffers = record
    Count: uint32;
    _type: uint32;
    memory: uint32;
    capabilities: uint32;
    reserved: array[0..0] of uint32;
  end;

  { capabilities for struct v4l2_requestbuffers and v4l2_create_buffers  }

const
  V4L2_BUF_CAP_SUPPORTS_MMAP = 1 shl 0;
  V4L2_BUF_CAP_SUPPORTS_USERPTR = 1 shl 1;
  V4L2_BUF_CAP_SUPPORTS_DMABUF = 1 shl 2;
  V4L2_BUF_CAP_SUPPORTS_REQUESTS = 1 shl 3;
  V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS = 1 shl 4;
  V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF = 1 shl 5;
  V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS = 1 shl 6;
{*
 * struct v4l2_plane - plane info for multi-planar buffers
 * @bytesused:    number of bytes occupied by data in the plane (payload)
 * @length:    size of this plane (NOT the payload) in bytes
 * @mem_offset:    when memory in the associated struct v4l2_buffer is
 *      V4L2_MEMORY_MMAP, equals the offset from the start of
 *      the device memory for this plane (or is a "cookie" that
 *      should be passed to mmap() called on the video node)
 * @userptr:    when memory is V4L2_MEMORY_USERPTR, a userspace pointer
 *      pointing to this plane
 * @fd:      when memory is V4L2_MEMORY_DMABUF, a userspace file
 *      descriptor associated with this plane
 * @m:      union of @mem_offset, @userptr and @fd
 * @data_offset:  offset in the plane to the start of data; usually 0,
 *      unless there is a header in front of the data
 * @reserved:    drivers and applications must zero this array
 *
 * Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
 * with two planes can have one plane for Y, and another for interleaved CbCr
 * components. Each plane can reside in a separate memory buffer, or even in
 * a completely separate memory node (e.g. in embedded devices).
  }
type
  Pv4l2_plane = ^Tv4l2_plane;

  Tv4l2_plane = record
    bytesused: uint32;
    length: uint32;
    m: record
      case longint of
        0: (mem_offset: uint32);
        1: (userptr: dword);
        2: (fd: int32);
      end;
    data_offset: uint32;
    reserved: array[0..10] of uint32;
  end;

{*
 * struct v4l2_buffer - video buffer info
 * @index:  id number of the buffer
 * @type:  enum v4l2_buf_type; buffer type (type = *_MPLANE for
 *    multiplanar buffers);
 * @bytesused:  number of bytes occupied by data in the buffer (payload);
 *    unused (set to 0) for multiplanar buffers
 * @flags:  buffer informational flags
 * @field:  enum v4l2_field; field order of the image in the buffer
 * @timestamp:  frame timestamp
 * @timecode:  frame timecode
 * @sequence:  sequence count of this frame
 * @memory:  enum v4l2_memory; the method, in which the actual video data is
 *    passed
 * @offset:  for non-multiplanar buffers with memory = V4L2_MEMORY_MMAP;
 *    offset from the start of the device memory for this plane,
 *    (or a "cookie" that should be passed to mmap() as offset)
 * @userptr:  for non-multiplanar buffers with memory = V4L2_MEMORY_USERPTR;
 *    a userspace pointer pointing to this buffer
 * @fd:    for non-multiplanar buffers with memory = V4L2_MEMORY_DMABUF;
 *    a userspace file descriptor associated with this buffer
 * @planes:  for multiplanar buffers; userspace pointer to the array of plane
 *    info structs for this buffer
 * @m:    union of @offset, @userptr, @planes and @fd
 * @length:  size in bytes of the buffer (NOT its payload) for single-plane
 *    buffers (when type != *_MPLANE); number of elements in the
 *    planes array for multi-plane buffers
 * @reserved2:  drivers and applications must zero this field
 * @request_fd: fd of the request that this buffer should use
 * @reserved:  for backwards compatibility with applications that do not know
 *    about @request_fd
 *
 * Contains data exchanged by application and driver using one of the Streaming
 * I/O methods.
  }
  { memory location  }
  Pv4l2_buffer = ^Tv4l2_buffer;

  Tv4l2_buffer = record
    index: uint32;
    _type: uint32;
    bytesused: uint32;
    flags: uint32;
    field: uint32;
    timestamp: Ttimeval;
    timecode: Tv4l2_timecode;
    sequence: uint32;
    memory: uint32;
    m: record
      case longint of
        0: (offset: uint32);
        1: (userptr: dword);
        2: (planes: Pv4l2_plane);
        3: (fd: int32);
      end;
    length: uint32;
    reserved2: uint32;
    u: record
      case longint of
        0: (request_fd: int32);
        1: (reserved: uint32);
      end;
  end;

const
  V4L2_BUF_FLAG_MAPPED = $00000001;
  { Buffer is queued for processing  }
  V4L2_BUF_FLAG_QUEUED = $00000002;
  { Buffer is ready  }
  V4L2_BUF_FLAG_DONE = $00000004;
  { Image is a keyframe (I-frame)  }
  V4L2_BUF_FLAG_KEYFRAME = $00000008;
  { Image is a P-frame  }
  V4L2_BUF_FLAG_PFRAME = $00000010;
  { Image is a B-frame  }
  V4L2_BUF_FLAG_BFRAME = $00000020;
  { Buffer is ready, but the data contained within is corrupted.  }
  V4L2_BUF_FLAG_ERROR = $00000040;
  { Buffer is added to an unqueued request  }
  V4L2_BUF_FLAG_IN_REQUEST = $00000080;
  { timecode field is valid  }
  V4L2_BUF_FLAG_TIMECODE = $00000100;
  { Don't return the capture buffer until OUTPUT timestamp changes  }
  V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF = $00000200;
  { Buffer is prepared for queuing  }
  V4L2_BUF_FLAG_PREPARED = $00000400;
  { Cache handling flags  }
  V4L2_BUF_FLAG_NO_CACHE_INVALIDATE = $00000800;
  V4L2_BUF_FLAG_NO_CACHE_CLEAN = $00001000;
  { Timestamp type  }
  V4L2_BUF_FLAG_TIMESTAMP_MASK = $0000e000;
  V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN = $00000000;
  V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC = $00002000;
  V4L2_BUF_FLAG_TIMESTAMP_COPY = $00004000;
  { Timestamp sources.  }
  V4L2_BUF_FLAG_TSTAMP_SRC_MASK = $00070000;
  V4L2_BUF_FLAG_TSTAMP_SRC_EOF = $00000000;
  V4L2_BUF_FLAG_TSTAMP_SRC_SOE = $00010000;
  { mem2mem encoder/decoder  }
  V4L2_BUF_FLAG_LAST = $00100000;
  { request_fd is valid  }
  V4L2_BUF_FLAG_REQUEST_FD = $00800000;
{*
 * struct v4l2_exportbuffer - export of video buffer as DMABUF file descriptor
 *
 * @index:  id number of the buffer
 * @type:  enum v4l2_buf_type; buffer type (type = *_MPLANE for
 *    multiplanar buffers);
 * @plane:  index of the plane to be exported, 0 for single plane queues
 * @flags:  flags for newly created file, currently only O_CLOEXEC is
 *    supported, refer to manual of open syscall for more details
 * @fd:    file descriptor associated with DMABUF (set by driver)
 * @reserved:  drivers and applications must zero this array
 *
 * Contains data used for exporting a video buffer as DMABUF file descriptor.
 * The buffer is identified by a 'cookie' returned by VIDIOC_QUERYBUF
 * (identical to the cookie used to mmap() the buffer to userspace). All
 * reserved fields must be set to zero. The field reserved0 is expected to
 * become a structure 'type' allowing an alternative layout of the structure
 * content. Therefore this field should not be used for any other extensions.
  }
  { enum v4l2_buf_type  }
type
  Pv4l2_exportbuffer = ^Tv4l2_exportbuffer;

  Tv4l2_exportbuffer = record
    _type: uint32;
    index: uint32;
    plane: uint32;
    flags: uint32;
    fd: int32;
    reserved: array[0..10] of uint32;
  end;

{
 *  O V E R L A Y   P R E V I E W
  }
{ FIXME: in theory we should pass something like PCI device + memory
 * region + offset instead of some physical address  }
  { enum v4l2_field  }
  { for padding, zero if unused  }
  { enum v4l2_colorspace  }
  { reserved field, set to 0  }
  Pv4l2_framebuffer = ^Tv4l2_framebuffer;

  Tv4l2_framebuffer = record
    capability: uint32;
    flags: uint32;
    base: pointer;
    fmt: record
      Width: uint32;
      Height: uint32;
      pixelformat: uint32;
      field: uint32;
      bytesperline: uint32;
      sizeimage: uint32;
      colorspace: uint32;
      priv: uint32;
      end;
  end;

  {  Flags for the 'capability' field. Read only  }

const
  V4L2_FBUF_CAP_EXTERNOVERLAY = $0001;
  V4L2_FBUF_CAP_CHROMAKEY = $0002;
  V4L2_FBUF_CAP_LIST_CLIPPING = $0004;
  V4L2_FBUF_CAP_BITMAP_CLIPPING = $0008;
  V4L2_FBUF_CAP_LOCAL_ALPHA = $0010;
  V4L2_FBUF_CAP_GLOBAL_ALPHA = $0020;
  V4L2_FBUF_CAP_LOCAL_INV_ALPHA = $0040;
  V4L2_FBUF_CAP_SRC_CHROMAKEY = $0080;
  {  Flags for the 'flags' field.  }
  V4L2_FBUF_FLAG_PRIMARY = $0001;
  V4L2_FBUF_FLAG_OVERLAY = $0002;
  V4L2_FBUF_FLAG_CHROMAKEY = $0004;
  V4L2_FBUF_FLAG_LOCAL_ALPHA = $0008;
  V4L2_FBUF_FLAG_GLOBAL_ALPHA = $0010;
  V4L2_FBUF_FLAG_LOCAL_INV_ALPHA = $0020;
  V4L2_FBUF_FLAG_SRC_CHROMAKEY = $0040;

type
  Pv4l2_clip = ^Tv4l2_clip;

  Tv4l2_clip = record
    c: Tv4l2_rect;
    Next: Pv4l2_clip;
  end;

  { enum v4l2_field  }
  Pv4l2_window = ^Tv4l2_window;

  Tv4l2_window = record
    w: Tv4l2_rect;
    field: uint32;
    chromakey: uint32;
    clips: Pv4l2_clip;
    clipcount: uint32;
    bitmap: pointer;
    global_alpha: char;
  end;

{
 *  C A P T U R E   P A R A M E T E R S
  }
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in seconds  }
  {  Driver-specific extensions  }
  {  # of buffers for read  }
  Pv4l2_captureparm = ^Tv4l2_captureparm;

  Tv4l2_captureparm = record
    capability: uint32;
    capturemode: uint32;
    timeperframe: Tv4l2_fract;
    extendedmode: uint32;
    readbuffers: uint32;
    reserved: array[0..3] of uint32;
  end;

  {  Flags for 'capability' and 'capturemode' fields  }
  {  High quality imaging mode  }

const
  V4L2_MODE_HIGHQUALITY = $0001;
  {  timeperframe field is supported  }
  V4L2_CAP_TIMEPERFRAME = $1000;
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in seconds  }
  {  Driver-specific extensions  }
  {  # of buffers for write  }
type
  Pv4l2_outputparm = ^Tv4l2_outputparm;

  Tv4l2_outputparm = record
    capability: uint32;
    outputmode: uint32;
    timeperframe: Tv4l2_fract;
    extendedmode: uint32;
    writebuffers: uint32;
    reserved: array[0..3] of uint32;
  end;

{
 *  I N P U T   I M A G E   C R O P P I N G
  }
  { enum v4l2_buf_type  }
  Pv4l2_cropcap = ^Tv4l2_cropcap;

  Tv4l2_cropcap = record
    _type: uint32;
    bounds: Tv4l2_rect;
    defrect: Tv4l2_rect;
    pixelaspect: Tv4l2_fract;
  end;

  { enum v4l2_buf_type  }
  Pv4l2_crop = ^Tv4l2_crop;

  Tv4l2_crop = record
    _type: uint32;
    c: Tv4l2_rect;
  end;

{*
 * struct v4l2_selection - selection info
 * @type:  buffer type (do not use *_MPLANE types)
 * @target:  Selection target, used to choose one of possible rectangles;
 *    defined in v4l2-common.h; V4L2_SEL_TGT_* .
 * @flags:  constraints flags, defined in v4l2-common.h; V4L2_SEL_FLAG_*.
 * @r:    coordinates of selection window
 * @reserved:  for future use, rounds structure size to 64 bytes, set to zero
 *
 * Hardware may use multiple helper windows to process a video stream.
 * The structure is used to exchange this selection areas between
 * an application and a driver.
  }
  Pv4l2_selection = ^Tv4l2_selection;

  Tv4l2_selection = record
    _type: uint32;
    target: uint32;
    flags: uint32;
    r: Tv4l2_rect;
    reserved: array[0..8] of uint32;
  end;

{
 *      A N A L O G   V I D E O   S T A N D A R D
  }

  Pv4l2_std_id = ^Tv4l2_std_id;
  Tv4l2_std_id = uint64;
{
 * Attention: Keep the V4L2_STD_* bit definitions in sync with
 * include/dt-bindings/display/sdtv-standards.h SDTV_STD_* bit definitions.
  }
  { one bit for each  }

const
  V4L2_STD_PAL_B = $00000001;
  V4L2_STD_PAL_B1 = $00000002;
  V4L2_STD_PAL_G = $00000004;
  V4L2_STD_PAL_H = $00000008;
  V4L2_STD_PAL_I = $00000010;
  V4L2_STD_PAL_D = $00000020;
  V4L2_STD_PAL_D1 = $00000040;
  V4L2_STD_PAL_K = $00000080;
  V4L2_STD_PAL_M = $00000100;
  V4L2_STD_PAL_N = $00000200;
  V4L2_STD_PAL_Nc = $00000400;
  V4L2_STD_PAL_60 = $00000800;
  { BTSC  }
  V4L2_STD_NTSC_M = $00001000;
  { EIA-J  }
  V4L2_STD_NTSC_M_JP = $00002000;
  V4L2_STD_NTSC_443 = $00004000;
  { FM A2  }
  V4L2_STD_NTSC_M_KR = $00008000;
  V4L2_STD_SECAM_B = $00010000;
  V4L2_STD_SECAM_D = $00020000;
  V4L2_STD_SECAM_G = $00040000;
  V4L2_STD_SECAM_H = $00080000;
  V4L2_STD_SECAM_K = $00100000;
  V4L2_STD_SECAM_K1 = $00200000;
  V4L2_STD_SECAM_L = $00400000;
  V4L2_STD_SECAM_LC = $00800000;
  { ATSC/HDTV  }
  V4L2_STD_ATSC_8_VSB = $01000000;
  V4L2_STD_ATSC_16_VSB = $02000000;
{ FIXME:
   Although std_id is 64 bits, there is an issue on PPC32 architecture that
   makes switch(__u64) to break. So, there's a hack on v4l2-common.c rounding
   this value to 32 bits.
   As, currently, the max value is for V4L2_STD_ATSC_16_VSB (30 bits wide),
   it should work fine. However, if needed to add more than two standards,
   v4l2-common.c should be fixed.
  }
{
 * Some macros to merge video standards in order to make live easier for the
 * drivers and V4L2 applications
  }
{
 * "Common" NTSC/M - It should be noticed that V4L2_STD_NTSC_443 is
 * Missing here.
  }
const
  V4L2_STD_NTSC = (V4L2_STD_NTSC_M or V4L2_STD_NTSC_M_JP) or V4L2_STD_NTSC_M_KR;
  { Secam macros  }
  V4L2_STD_SECAM_DK = (V4L2_STD_SECAM_D or V4L2_STD_SECAM_K) or V4L2_STD_SECAM_K1;
  { All Secam Standards  }
  V4L2_STD_SECAM = ((((V4L2_STD_SECAM_B or V4L2_STD_SECAM_G) or V4L2_STD_SECAM_H) or V4L2_STD_SECAM_DK) or V4L2_STD_SECAM_L) or V4L2_STD_SECAM_LC;
  { PAL macros  }
  V4L2_STD_PAL_BG = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_PAL_G;
  V4L2_STD_PAL_DK = (V4L2_STD_PAL_D or V4L2_STD_PAL_D1) or V4L2_STD_PAL_K;
{
 * "Common" PAL - This macro is there to be compatible with the old
 * V4L1 concept of "PAL": /BGDKHI.
 * Several PAL standards are missing here: /M, /N and /Nc
  }
  V4L2_STD_PAL = ((V4L2_STD_PAL_BG or V4L2_STD_PAL_DK) or V4L2_STD_PAL_H) or V4L2_STD_PAL_I;
  { Chroma "agnostic" standards  }
  V4L2_STD_B = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_SECAM_B;
  V4L2_STD_G = V4L2_STD_PAL_G or V4L2_STD_SECAM_G;
  V4L2_STD_H = V4L2_STD_PAL_H or V4L2_STD_SECAM_H;
  V4L2_STD_L = V4L2_STD_SECAM_L or V4L2_STD_SECAM_LC;
  V4L2_STD_GH = V4L2_STD_G or V4L2_STD_H;
  V4L2_STD_DK = V4L2_STD_PAL_DK or V4L2_STD_SECAM_DK;
  V4L2_STD_BG = V4L2_STD_B or V4L2_STD_G;
  V4L2_STD_MN = ((V4L2_STD_PAL_M or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_NTSC;
  { Standards where MTS/BTSC stereo could be found  }
  V4L2_STD_MTS = ((V4L2_STD_NTSC_M or V4L2_STD_PAL_M) or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc;
  { Standards for Countries with 60Hz Line frequency  }
  V4L2_STD_525_60 = ((V4L2_STD_PAL_M or V4L2_STD_PAL_60) or V4L2_STD_NTSC) or V4L2_STD_NTSC_443;
  { Standards for Countries with 50Hz Line frequency  }
  V4L2_STD_625_50 = ((V4L2_STD_PAL or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_SECAM;
  V4L2_STD_ATSC = V4L2_STD_ATSC_8_VSB or V4L2_STD_ATSC_16_VSB;
  { Macros with none and all analog standards  }
  V4L2_STD_UNKNOWN = 0;
  V4L2_STD_ALL = V4L2_STD_525_60 or V4L2_STD_625_50;
  { Frames, not fields  }
type
  Pv4l2_standard = ^Tv4l2_standard;

  Tv4l2_standard = record
    index: uint32;
    id: Tv4l2_std_id;
    Name: array[0..23] of char;
    frameperiod: Tv4l2_fract;
    framelines: uint32;
    reserved: array[0..3] of uint32;
  end;

{
 *  D V  B T  T I M I N G S
  }
{* struct v4l2_bt_timings - BT.656/BT.1120 timing data
 * @width:  total width of the active video in pixels
 * @height:  total height of the active video in lines
 * @interlaced:  Interlaced or progressive
 * @polarities:  Positive or negative polarities
 * @pixelclock:  Pixel clock in HZ. Ex. 74.25MHz->74250000
 * @hfrontporch:Horizontal front porch in pixels
 * @hsync:  Horizontal Sync length in pixels
 * @hbackporch:  Horizontal back porch in pixels
 * @vfrontporch:Vertical front porch in lines
 * @vsync:  Vertical Sync length in lines
 * @vbackporch:  Vertical back porch in lines
 * @il_vfrontporch:Vertical front porch for the even field
 *    (aka field 2) of interlaced field formats
 * @il_vsync:  Vertical Sync length for the even field
 *    (aka field 2) of interlaced field formats
 * @il_vbackporch:Vertical back porch for the even field
 *    (aka field 2) of interlaced field formats
 * @standards:  Standards the timing belongs to
 * @flags:  Flags
 * @picture_aspect: The picture aspect ratio (hor/vert).
 * @cea861_vic:  VIC code as per the CEA-861 standard.
 * @hdmi_vic:  VIC code as per the HDMI standard.
 * @reserved:  Reserved fields, must be zeroed.
 *
 * A note regarding vertical interlaced timings: height refers to the total
 * height of the active video frame (= two fields). The blanking timings refer
 * to the blanking of each field. So the height of the total frame is
 * calculated as follows:
 *
 * tot_height = height + vfrontporch + vsync + vbackporch +
 *                       il_vfrontporch + il_vsync + il_vbackporch
 *
 * The active height of each field is height / 2.
  }
  Pv4l2_bt_timings = ^Tv4l2_bt_timings;

  Tv4l2_bt_timings = packed record
    Width: uint32;
    Height: uint32;
    interlaced: uint32;
    polarities: uint32;
    pixelclock: uint64;
    hfrontporch: uint32;
    hsync: uint32;
    hbackporch: uint32;
    vfrontporch: uint32;
    vsync: uint32;
    vbackporch: uint32;
    il_vfrontporch: uint32;
    il_vsync: uint32;
    il_vbackporch: uint32;
    standards: uint32;
    flags: uint32;
    picture_aspect: Tv4l2_fract;
    cea861_vic: char;
    hdmi_vic: char;
    reserved: array[0..45] of char;
  end;

  { Interlaced or progressive format  }

const
  V4L2_DV_PROGRESSIVE = 0;
  V4L2_DV_INTERLACED = 1;
  { Polarities. If bit is not set, it is assumed to be negative polarity  }
  V4L2_DV_VSYNC_POS_POL = $00000001;
  V4L2_DV_HSYNC_POS_POL = $00000002;
  { Timings standards  }
  { CEA-861 Digital TV Profile  }
  V4L2_DV_BT_STD_CEA861 = 1 shl 0;
  { VESA Discrete Monitor Timings  }
  V4L2_DV_BT_STD_DMT = 1 shl 1;
  { VESA Coordinated Video Timings  }
  V4L2_DV_BT_STD_CVT = 1 shl 2;
  { VESA Generalized Timings Formula  }
  V4L2_DV_BT_STD_GTF = 1 shl 3;
  { SDI Timings  }
  V4L2_DV_BT_STD_SDI = 1 shl 4;
  { Flags  }
{
 * CVT/GTF specific: timing uses reduced blanking (CVT) or the 'Secondary
 * GTF' curve (GTF). In both cases the horizontal and/or vertical blanking
 * intervals are reduced, allowing a higher resolution over the same
 * bandwidth. This is a read-only flag.
  }
  V4L2_DV_FL_REDUCED_BLANKING = 1 shl 0;
{
 * CEA-861 specific: set for CEA-861 formats with a framerate of a multiple
 * of six. These formats can be optionally played at 1 / 1.001 speed.
 * This is a read-only flag.
  }
  V4L2_DV_FL_CAN_REDUCE_FPS = 1 shl 1;
{
 * CEA-861 specific: only valid for video transmitters, the flag is cleared
 * by receivers.
 * If the framerate of the format is a multiple of six, then the pixelclock
 * used to set up the transmitter is divided by 1.001 to make it compatible
 * with 60 Hz based standards such as NTSC and PAL-M that use a framerate of
 * 29.97 Hz. Otherwise this flag is cleared. If the transmitter can't generate
 * such frequencies, then the flag will also be cleared.
  }
  V4L2_DV_FL_REDUCED_FPS = 1 shl 2;
{
 * Specific to interlaced formats: if set, then field 1 is really one half-line
 * longer and field 2 is really one half-line shorter, so each field has
 * exactly the same number of half-lines. Whether half-lines can be detected
 * or used depends on the hardware.
  }
  V4L2_DV_FL_HALF_LINE = 1 shl 3;
{
 * If set, then this is a Consumer Electronics (CE) video format. Such formats
 * differ from other formats (commonly called IT formats) in that if RGB
 * encoding is used then by default the RGB values use limited range (i.e.
 * use the range 16-235) as opposed to 0-255. All formats defined in CEA-861
 * except for the 640x480 format are CE formats.
  }
  V4L2_DV_FL_IS_CE_VIDEO = 1 shl 4;
{ Some formats like SMPTE-125M have an interlaced signal with a odd
 * total height. For these formats, if this flag is set, the first
 * field has the extra line. If not, it is the second field.
  }
  V4L2_DV_FL_FIRST_FIELD_EXTRA_LINE = 1 shl 5;
{
 * If set, then the picture_aspect field is valid. Otherwise assume that the
 * pixels are square, so the picture aspect ratio is the same as the width to
 * height ratio.
  }
  V4L2_DV_FL_HAS_PICTURE_ASPECT = 1 shl 6;
{
 * If set, then the cea861_vic field is valid and contains the Video
 * Identification Code as per the CEA-861 standard.
  }
  V4L2_DV_FL_HAS_CEA861_VIC = 1 shl 7;
{
 * If set, then the hdmi_vic field is valid and contains the Video
 * Identification Code as per the HDMI standard (HDMI Vendor Specific
 * InfoFrame).
  }
  V4L2_DV_FL_HAS_HDMI_VIC = 1 shl 8;
{
 * CEA-861 specific: only valid for video receivers.
 * If set, then HW can detect the difference between regular FPS and
 * 1000/1001 FPS. Note: This flag is only valid for HDMI VIC codes with
 * the V4L2_DV_FL_CAN_REDUCE_FPS flag set.
  }
  V4L2_DV_FL_CAN_DETECT_REDUCED_FPS = 1 shl 9;
  { A few useful defines to calculate the total blanking and frame sizes  }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  //
  //function V4L2_DV_BT_BLANKING_WIDTH(bt : longint) : longint;
  //
  //{ was #define dname(params) para_def_expr }
  //{ argument types are unknown }
  //{ return type might be wrong }
  //function V4L2_DV_BT_FRAME_WIDTH(bt : longint) : longint;
  //
  //{ was #define dname(params) para_def_expr }
  //{ argument types are unknown }
  //{ return type might be wrong }
  //function V4L2_DV_BT_BLANKING_HEIGHT(bt : longint) : longint;
  //
  //{ was #define dname(params) para_def_expr }
  //{ argument types are unknown }
  //{ return type might be wrong }
  //function V4L2_DV_BT_FRAME_HEIGHT(bt : longint) : longint;
  //
{* struct v4l2_dv_timings - DV timings
 * @type:  the type of the timings
 * @bt:  BT656/1120 timings
  }
type
  Pv4l2_dv_timings = ^Tv4l2_dv_timings;

  Tv4l2_dv_timings = packed record
    _type: uint32;
    u: record
      case longint of
        0: (bt: Tv4l2_bt_timings);
        1: (reserved: array[0..31] of uint32);
      end;
  end;

  { Values for the type field  }
  { BT.656/1120 timing type  }

const
  V4L2_DV_BT_656_1120 = 0;
{* struct v4l2_enum_dv_timings - DV timings enumeration
 * @index:  enumeration index
 * @pad:  the pad number for which to enumerate timings (used with
 *    v4l-subdev nodes only)
 * @reserved:  must be zeroed
 * @timings:  the timings for the given index
  }
type
  Pv4l2_enum_dv_timings = ^Tv4l2_enum_dv_timings;

  Tv4l2_enum_dv_timings = record
    index: uint32;
    pad: uint32;
    reserved: array[0..1] of uint32;
    timings: Tv4l2_dv_timings;
  end;

{* struct v4l2_bt_timings_cap - BT.656/BT.1120 timing capabilities
 * @min_width:    width in pixels
 * @max_width:    width in pixels
 * @min_height:    height in lines
 * @max_height:    height in lines
 * @min_pixelclock:  Pixel clock in HZ. Ex. 74.25MHz->74250000
 * @max_pixelclock:  Pixel clock in HZ. Ex. 74.25MHz->74250000
 * @standards:    Supported standards
 * @capabilities:  Supported capabilities
 * @reserved:    Must be zeroed
  }
  Pv4l2_bt_timings_cap = ^Tv4l2_bt_timings_cap;

  Tv4l2_bt_timings_cap = packed record
    min_width: uint32;
    max_width: uint32;
    min_height: uint32;
    max_height: uint32;
    min_pixelclock: uint64;
    max_pixelclock: uint64;
    standards: uint32;
    capabilities: uint32;
    reserved: array[0..15] of uint32;
  end;

  { Supports interlaced formats  }

const
  V4L2_DV_BT_CAP_INTERLACED = 1 shl 0;
  { Supports progressive formats  }
  V4L2_DV_BT_CAP_PROGRESSIVE = 1 shl 1;
  { Supports CVT/GTF reduced blanking  }
  V4L2_DV_BT_CAP_REDUCED_BLANKING = 1 shl 2;
  { Supports custom formats  }
  V4L2_DV_BT_CAP_CUSTOM = 1 shl 3;
{* struct v4l2_dv_timings_cap - DV timings capabilities
 * @type:  the type of the timings (same as in struct v4l2_dv_timings)
 * @pad:  the pad number for which to query capabilities (used with
 *    v4l-subdev nodes only)
 * @bt:    the BT656/1120 timings capabilities
  }
type
  Pv4l2_dv_timings_cap = ^Tv4l2_dv_timings_cap;

  Tv4l2_dv_timings_cap = record
    _type: uint32;
    pad: uint32;
    reserved: array[0..1] of uint32;
    u: record
      case longint of
        0: (bt: Tv4l2_bt_timings_cap);
        1: (raw_data: array[0..31] of uint32);
      end;
  end;

{
 *  V I D E O   I N P U T S
  }
  {  Which input  }
  {  Label  }
  {  Type of input  }
  {  Associated audios (bitfield)  }
  {  enum v4l2_tuner_type  }
  Pv4l2_input = ^Tv4l2_input;

  Tv4l2_input = record
    index: uint32;
    Name: array[0..31] of char;
    _type: uint32;
    audioset: uint32;
    tuner: uint32;
    std: Tv4l2_std_id;
    status: uint32;
    capabilities: uint32;
    reserved: array[0..2] of uint32;
  end;

  {  Values for the 'type' field  }

const
  V4L2_INPUT_TYPE_TUNER = 1;
  V4L2_INPUT_TYPE_CAMERA = 2;
  V4L2_INPUT_TYPE_TOUCH = 3;
  { field 'status' - general  }
  { Attached device is off  }
  V4L2_IN_ST_NO_POWER = $00000001;
  V4L2_IN_ST_NO_SIGNAL = $00000002;
  V4L2_IN_ST_NO_COLOR = $00000004;
  { field 'status' - sensor orientation  }
  { If sensor is mounted upside down set both bits  }
  { Frames are flipped horizontally  }
  V4L2_IN_ST_HFLIP = $00000010;
  { Frames are flipped vertically  }
  V4L2_IN_ST_VFLIP = $00000020;
  { field 'status' - analog  }
  { No horizontal sync lock  }
  V4L2_IN_ST_NO_H_LOCK = $00000100;
  { Color killer is active  }
  V4L2_IN_ST_COLOR_KILL = $00000200;
  { No vertical sync lock  }
  V4L2_IN_ST_NO_V_LOCK = $00000400;
  { No standard format lock  }
  V4L2_IN_ST_NO_STD_LOCK = $00000800;
  { field 'status' - digital  }
  { No synchronization lock  }
  V4L2_IN_ST_NO_SYNC = $00010000;
  { No equalizer lock  }
  V4L2_IN_ST_NO_EQU = $00020000;
  { Carrier recovery failed  }
  V4L2_IN_ST_NO_CARRIER = $00040000;
  { field 'status' - VCR and set-top box  }
  { Macrovision detected  }
  V4L2_IN_ST_MACROVISION = $01000000;
  { Conditional access denied  }
  V4L2_IN_ST_NO_ACCESS = $02000000;
  { VTR time constant  }
  V4L2_IN_ST_VTR = $04000000;
  { capabilities flags  }
  { Supports S_DV_TIMINGS  }
  V4L2_IN_CAP_DV_TIMINGS = $00000002;
  { For compatibility  }
  V4L2_IN_CAP_CUSTOM_TIMINGS = V4L2_IN_CAP_DV_TIMINGS;
  { Supports S_STD  }
  V4L2_IN_CAP_STD = $00000004;
  { Supports setting native size  }
  V4L2_IN_CAP_NATIVE_SIZE = $00000008;
{
 *  V I D E O   O U T P U T S
  }
  {  Which output  }
  {  Label  }
  {  Type of output  }
  {  Associated audios (bitfield)  }
  {  Associated modulator  }
type
  Pv4l2_output = ^Tv4l2_output;

  Tv4l2_output = record
    index: uint32;
    Name: array[0..31] of char;
    _type: uint32;
    audioset: uint32;
    modulator: uint32;
    std: Tv4l2_std_id;
    capabilities: uint32;
    reserved: array[0..2] of uint32;
  end;

  {  Values for the 'type' field  }

const
  V4L2_OUTPUT_TYPE_MODULATOR = 1;
  V4L2_OUTPUT_TYPE_ANALOG = 2;
  V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY = 3;
  { capabilities flags  }
  { Supports S_DV_TIMINGS  }
  V4L2_OUT_CAP_DV_TIMINGS = $00000002;
  { For compatibility  }
  V4L2_OUT_CAP_CUSTOM_TIMINGS = V4L2_OUT_CAP_DV_TIMINGS;
  { Supports S_STD  }
  V4L2_OUT_CAP_STD = $00000004;
  { Supports setting native size  }
  V4L2_OUT_CAP_NATIVE_SIZE = $00000008;
{
 *  C O N T R O L S
  }
type
  Pv4l2_control = ^Tv4l2_control;

  Tv4l2_control = record
    id: uint32;
    Value: int32;
  end;

  Pv4l2_ext_control = ^Tv4l2_ext_control;

  Tv4l2_ext_control = packed record
    id: uint32;
    size: uint32;
    reserved2: array[0..0] of uint32;
    u: record
      case longint of
        0: (Value: int32);
        1: (value64: int64);
        2: (_string: PChar);
        3: (p_u8: Puint8);
        4: (p_u16: Puint16);
        5: (p_u32: Puint32);
        6: (p_area: Pv4l2_area);
        7: (p_h264_sps: Pv4l2_ctrl_h264_sps);
        8: (p_h264_pps: Pv4l2_ctrl_h264_pps);
        9: (p_h264_scaling_matrix: Pv4l2_ctrl_h264_scaling_matrix);
        10: (p_h264_pred_weights: Pv4l2_ctrl_h264_pred_weights);
        11: (p_h264_slice_params: Pv4l2_ctrl_h264_slice_params);
        12: (p_h264_decode_params: Pv4l2_ctrl_h264_decode_params);
        13: (p_fwht_params: Pv4l2_ctrl_fwht_params);
        14: (p_vp8_frame: Pv4l2_ctrl_vp8_frame);
        15: (p_mpeg2_sequence: Pv4l2_ctrl_mpeg2_sequence);
        16: (p_mpeg2_picture: Pv4l2_ctrl_mpeg2_picture);
        17: (p_mpeg2_quantisation: Pv4l2_ctrl_mpeg2_quantisation);
        18: (ptr: pointer);
      end;
  end;

  Pv4l2_ext_controls = ^Tv4l2_ext_controls;

  Tv4l2_ext_controls = record
    u: record
      case longint of
        0: (ctrl_class: uint32);
        1: (which: uint32);
      end;
    Count: uint32;
    error_idx: uint32;
    request_fd: int32;
    reserved: array[0..0] of uint32;
    Controls: Pv4l2_ext_control;
  end;


const
  V4L2_CTRL_ID_MASK = $0fffffff;
  { was #define dname(params) para_def_expr }
  { argument types are unknown }

  //function V4L2_CTRL_ID2CLASS(id : culong) : culong;
  //
  //{ was #define dname(params) para_def_expr }
  //{ argument types are unknown }
  //function V4L2_CTRL_ID2WHICH(id : culong) : culong;
  //
  //{ was #define dname(params) para_def_expr }
  //{ argument types are unknown }
  //{ return type might be wrong }
  //function V4L2_CTRL_DRIVER_PRIV(id : longint) : longint;
  //
const
  V4L2_CTRL_MAX_DIMS = 4;
  V4L2_CTRL_WHICH_CUR_VAL = 0;
  V4L2_CTRL_WHICH_DEF_VAL = $0f000000;
  V4L2_CTRL_WHICH_REQUEST_VAL = $0f010000;
  { Compound types are >= 0x0100  }
type
  Tv4l2_ctrl_type = longint;

const
  V4L2_CTRL_TYPE_INTEGER = 1;
  V4L2_CTRL_TYPE_BOOLEAN = 2;
  V4L2_CTRL_TYPE_MENU = 3;
  V4L2_CTRL_TYPE_BUTTON = 4;
  V4L2_CTRL_TYPE_INTEGER64 = 5;
  V4L2_CTRL_TYPE_CTRL_CLASS = 6;
  V4L2_CTRL_TYPE_STRING = 7;
  V4L2_CTRL_TYPE_BITMASK = 8;
  V4L2_CTRL_TYPE_INTEGER_MENU = 9;
  V4L2_CTRL_COMPOUND_TYPES = $0100;
  V4L2_CTRL_TYPE_U8 = $0100;
  V4L2_CTRL_TYPE_uint16 = $0101;
  V4L2_CTRL_TYPE_uint32 = $0102;
  V4L2_CTRL_TYPE_AREA = $0106;
  V4L2_CTRL_TYPE_HDR10_CLL_INFO = $0110;
  V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY = $0111;
  V4L2_CTRL_TYPE_H264_SPS = $0200;
  V4L2_CTRL_TYPE_H264_PPS = $0201;
  V4L2_CTRL_TYPE_H264_SCALING_MATRIX = $0202;
  V4L2_CTRL_TYPE_H264_SLICE_PARAMS = $0203;
  V4L2_CTRL_TYPE_H264_DECODE_PARAMS = $0204;
  V4L2_CTRL_TYPE_H264_PRED_WEIGHTS = $0205;
  V4L2_CTRL_TYPE_FWHT_PARAMS = $0220;
  V4L2_CTRL_TYPE_VP8_FRAME = $0240;
  V4L2_CTRL_TYPE_MPEG2_QUANTISATION = $0250;
  V4L2_CTRL_TYPE_MPEG2_SEQUENCE = $0251;
  V4L2_CTRL_TYPE_MPEG2_PICTURE = $0252;

  {  Used in the VIDIOC_QUERYCTRL ioctl for querying controls  }
  { enum v4l2_ctrl_type  }
  { Whatever  }
  { Note signedness  }
type
  Pv4l2_queryctrl = ^Tv4l2_queryctrl;

  Tv4l2_queryctrl = record
    id: uint32;
    _type: uint32;
    Name: array[0..31] of char;
    minimum: int32;
    maximum: int32;
    step: int32;
    default_value: int32;
    flags: uint32;
    reserved: array[0..1] of uint32;
  end;

  {  Used in the VIDIOC_QUERY_EXT_CTRL ioctl for querying extended controls  }
  Pv4l2_query_ext_ctrl = ^Tv4l2_query_ext_ctrl;

  Tv4l2_query_ext_ctrl = record
    id: uint32;
    _type: uint32;
    Name: array[0..31] of char;
    minimum: int64;
    maximum: int64;
    step: uint64;
    default_value: int64;
    flags: uint32;
    elem_size: uint32;
    elems: uint32;
    nr_of_dims: uint32;
    dims: array[0..(V4L2_CTRL_MAX_DIMS) - 1] of uint32;
    reserved: array[0..31] of uint32;
  end;

  {  Used in the VIDIOC_QUERYMENU ioctl for querying menu items  }
  { Whatever  }
  Pv4l2_querymenu = ^Tv4l2_querymenu;

  Tv4l2_querymenu = packed record
    id: uint32;
    index: uint32;
    u: record
      case longint of
        0: (Name: array[0..31] of char);
        1: (Value: int64);
      end;
    reserved: uint32;
  end;

  {  Control flags   }

const
  V4L2_CTRL_FLAG_DISABLED = $0001;
  V4L2_CTRL_FLAG_GRABBED = $0002;
  V4L2_CTRL_FLAG_READ_ONLY = $0004;
  V4L2_CTRL_FLAG_UPDATE = $0008;
  V4L2_CTRL_FLAG_INACTIVE = $0010;
  V4L2_CTRL_FLAG_SLIDER = $0020;
  V4L2_CTRL_FLAG_WRITE_ONLY = $0040;
  V4L2_CTRL_FLAG_VOLATILE = $0080;
  V4L2_CTRL_FLAG_HAS_PAYLOAD = $0100;
  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE = $0200;
  V4L2_CTRL_FLAG_MODIFY_LAYOUT = $0400;
  {  Query flags, to be ORed with the control ID  }
  V4L2_CTRL_FLAG_NEXT_CTRL = $80000000;
  V4L2_CTRL_FLAG_NEXT_COMPOUND = $40000000;
  {  User-class control IDs defined by V4L2  }
  V4L2_CID_MAX_CTRLS = 1024;
  {  IDs reserved for driver specific controls  }
  V4L2_CID_PRIVATE_BASE = $08000000;
{
 *  T U N I N G
  }
  { enum v4l2_tuner_type  }
type
  Pv4l2_tuner = ^Tv4l2_tuner;

  Tv4l2_tuner = record
    index: uint32;
    Name: array[0..31] of char;
    _type: uint32;
    capability: uint32;
    rangelow: uint32;
    rangehigh: uint32;
    rxsubchans: uint32;
    audmode: uint32;
    signal: int32;
    afc: int32;
    reserved: array[0..3] of uint32;
  end;

  { enum v4l2_tuner_type  }
  Pv4l2_modulator = ^Tv4l2_modulator;

  Tv4l2_modulator = record
    index: uint32;
    Name: array[0..31] of char;
    capability: uint32;
    rangelow: uint32;
    rangehigh: uint32;
    txsubchans: uint32;
    _type: uint32;
    reserved: array[0..2] of uint32;
  end;

  {  Flags for the 'capability' field  }

const
  V4L2_TUNER_CAP_LOW = $0001;
  V4L2_TUNER_CAP_NORM = $0002;
  V4L2_TUNER_CAP_HWSEEK_BOUNDED = $0004;
  V4L2_TUNER_CAP_HWSEEK_WRAP = $0008;
  V4L2_TUNER_CAP_STEREO = $0010;
  V4L2_TUNER_CAP_LANG2 = $0020;
  V4L2_TUNER_CAP_SAP = $0020;
  V4L2_TUNER_CAP_LANG1 = $0040;
  V4L2_TUNER_CAP_RDS = $0080;
  V4L2_TUNER_CAP_RDS_BLOCK_IO = $0100;
  V4L2_TUNER_CAP_RDS_CONTROLS = $0200;
  V4L2_TUNER_CAP_FREQ_BANDS = $0400;
  V4L2_TUNER_CAP_HWSEEK_PROG_LIM = $0800;
  V4L2_TUNER_CAP_1HZ = $1000;
  {  Flags for the 'rxsubchans' field  }
  V4L2_TUNER_SUB_MONO = $0001;
  V4L2_TUNER_SUB_STEREO = $0002;
  V4L2_TUNER_SUB_LANG2 = $0004;
  V4L2_TUNER_SUB_SAP = $0004;
  V4L2_TUNER_SUB_LANG1 = $0008;
  V4L2_TUNER_SUB_RDS = $0010;
  {  Values for the 'audmode' field  }
  V4L2_TUNER_MODE_MONO = $0000;
  V4L2_TUNER_MODE_STEREO = $0001;
  V4L2_TUNER_MODE_LANG2 = $0002;
  V4L2_TUNER_MODE_SAP = $0002;
  V4L2_TUNER_MODE_LANG1 = $0003;
  V4L2_TUNER_MODE_LANG1_LANG2 = $0004;
  { enum v4l2_tuner_type  }
type
  Pv4l2_frequency = ^Tv4l2_frequency;

  Tv4l2_frequency = record
    tuner: uint32;
    _type: uint32;
    frequency: uint32;
    reserved: array[0..7] of uint32;
  end;


const
  V4L2_BAND_MODULATION_VSB = 1 shl 1;
  V4L2_BAND_MODULATION_FM = 1 shl 2;
  V4L2_BAND_MODULATION_AM = 1 shl 3;
  { enum v4l2_tuner_type  }
type
  Pv4l2_frequency_band = ^Tv4l2_frequency_band;

  Tv4l2_frequency_band = record
    tuner: uint32;
    _type: uint32;
    index: uint32;
    capability: uint32;
    rangelow: uint32;
    rangehigh: uint32;
    modulation: uint32;
    reserved: array[0..8] of uint32;
  end;

  { enum v4l2_tuner_type  }
  Pv4l2_hw_freq_seek = ^Tv4l2_hw_freq_seek;

  Tv4l2_hw_freq_seek = record
    tuner: uint32;
    _type: uint32;
    seek_upward: uint32;
    wrap_around: uint32;
    spacing: uint32;
    rangelow: uint32;
    rangehigh: uint32;
    reserved: array[0..4] of uint32;
  end;

{
 *  R D S
  }
  Pv4l2_rds_data = ^Tv4l2_rds_data;

  Tv4l2_rds_data = packed record
    lsb: char;
    msb: char;
    block: char;
  end;

const
  V4L2_RDS_BLOCK_MSK = $7;
  V4L2_RDS_BLOCK_A = 0;
  V4L2_RDS_BLOCK_B = 1;
  V4L2_RDS_BLOCK_C = 2;
  V4L2_RDS_BLOCK_D = 3;
  V4L2_RDS_BLOCK_C_ALT = 4;
  V4L2_RDS_BLOCK_INVALID = 7;
  V4L2_RDS_BLOCK_CORRECTED = $40;
  V4L2_RDS_BLOCK_ERROR = $80;
{
 *  A U D I O
  }
type
  Pv4l2_audio = ^Tv4l2_audio;

  Tv4l2_audio = record
    index: uint32;
    Name: array[0..31] of char;
    capability: uint32;
    mode: uint32;
    reserved: array[0..1] of uint32;
  end;

  {  Flags for the 'capability' field  }

const
  V4L2_AUDCAP_STEREO = $00001;
  V4L2_AUDCAP_AVL = $00002;
  {  Flags for the 'mode' field  }
  V4L2_AUDMODE_AVL = $00001;

type
  Pv4l2_audioout = ^Tv4l2_audioout;

  Tv4l2_audioout = record
    index: uint32;
    Name: array[0..31] of char;
    capability: uint32;
    mode: uint32;
    reserved: array[0..1] of uint32;
  end;

{
 *  M P E G   S E R V I C E S
  }
  {$if 1}

const
  V4L2_ENC_IDX_FRAME_I = 0;
  V4L2_ENC_IDX_FRAME_P = 1;
  V4L2_ENC_IDX_FRAME_B = 2;
  V4L2_ENC_IDX_FRAME_MASK = $f;

type
  Pv4l2_enc_idx_entry = ^Tv4l2_enc_idx_entry;

  Tv4l2_enc_idx_entry = record
    offset: uint64;
    pts: uint64;
    length: uint32;
    flags: uint32;
    reserved: array[0..1] of uint32;
  end;


const
  V4L2_ENC_IDX_ENTRIES = 64;

type
  Pv4l2_enc_idx = ^Tv4l2_enc_idx;

  Tv4l2_enc_idx = record
    entries: uint32;
    entries_cap: uint32;
    reserved: array[0..3] of uint32;
    entry: array[0..(V4L2_ENC_IDX_ENTRIES) - 1] of Tv4l2_enc_idx_entry;
  end;


const
  V4L2_ENC_CMD_START = 0;
  V4L2_ENC_CMD_STOP = 1;
  V4L2_ENC_CMD_PAUSE = 2;
  V4L2_ENC_CMD_RESUME = 3;
  { Flags for V4L2_ENC_CMD_STOP  }
  V4L2_ENC_CMD_STOP_AT_GOP_END = 1 shl 0;

type
  Pv4l2_encoder_cmd = ^Tv4l2_encoder_cmd;

  Tv4l2_encoder_cmd = record
    cmd: uint32;
    flags: uint32;
    u: record
      case longint of
        0: (raw: record
            Data: array[0..7] of uint32;
            end);
      end;
  end;

  { Decoder commands  }

const
  V4L2_DEC_CMD_START = 0;
  V4L2_DEC_CMD_STOP = 1;
  V4L2_DEC_CMD_PAUSE = 2;
  V4L2_DEC_CMD_RESUME = 3;
  V4L2_DEC_CMD_FLUSH = 4;
  { Flags for V4L2_DEC_CMD_START  }
  V4L2_DEC_CMD_START_MUTE_AUDIO = 1 shl 0;
  { Flags for V4L2_DEC_CMD_PAUSE  }
  V4L2_DEC_CMD_PAUSE_TO_BLACK = 1 shl 0;
  { Flags for V4L2_DEC_CMD_STOP  }
  V4L2_DEC_CMD_STOP_TO_BLACK = 1 shl 0;
  V4L2_DEC_CMD_STOP_IMMEDIATELY = 1 shl 1;
  { Play format requirements (returned by the driver):  }
  { The decoder has no special format requirements  }
  V4L2_DEC_START_FMT_NONE = 0;
  { The decoder requires full GOPs  }
  V4L2_DEC_START_FMT_GOP = 1;
{ The structure must be zeroed before use by the application
   This ensures it can be extended safely in the future.  }
{ 0 or 1000 specifies normal speed,
         1 specifies forward single stepping,
         -1 specifies backward single stepping,
         >1: playback at speed/1000 of the normal speed,
         <-1: reverse playback at (-speed/1000) of the normal speed.  }
type
  Pv4l2_decoder_cmd = ^Tv4l2_decoder_cmd;

  Tv4l2_decoder_cmd = record
    cmd: uint32;
    flags: uint32;
    u: record
      case longint of
        0: (stop: record
            pts: uint64;
            end);
        1: (start: record
            speed: int32;
            format: uint32;
            end);
        2: (raw: record
            Data: array[0..15] of uint32;
            end);
      end;
  end;

  {$endif}
{
 *  D A T A   S E R V I C E S   ( V B I )
 *
 *  Data services API by Michael Schimek
  }
  { Raw VBI  }
  { in 1 Hz  }
  { V4L2_PIX_FMT_*  }
  { V4L2_VBI_*  }
  { must be zero  }
type
  Pv4l2_vbi_format = ^Tv4l2_vbi_format;

  Tv4l2_vbi_format = record
    sampling_rate: uint32;
    offset: uint32;
    samples_per_line: uint32;
    sample_format: uint32;
    start: array[0..1] of int32;
    Count: array[0..1] of uint32;
    flags: uint32;
    reserved: array[0..1] of uint32;
  end;

  {  VBI flags   }

const
  V4L2_VBI_UNSYNC = 1 shl 0;
  V4L2_VBI_INTERLACED = 1 shl 1;
  { ITU-R start lines for each field  }
  V4L2_VBI_ITU_525_F1_START = 1;
  V4L2_VBI_ITU_525_F2_START = 264;
  V4L2_VBI_ITU_625_F1_START = 1;
  V4L2_VBI_ITU_625_F2_START = 314;
{ Sliced VBI
 *
 *    This implements is a proposal V4L2 API to allow SLICED VBI
 * required for some hardware encoders. It should change without
 * notice in the definitive implementation.
  }
{ service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
     service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
         (equals frame lines 313-336 for 625 line video
          standards, 263-286 for 525 line standards)  }
  { must be zero  }
type
  Pv4l2_sliced_vbi_format = ^Tv4l2_sliced_vbi_format;

  Tv4l2_sliced_vbi_format = record
    service_set: uint16;
    service_lines: array[0..1] of array[0..23] of uint16;
    io_size: uint32;
    reserved: array[0..1] of uint32;
  end;

{ Teletext World System Teletext
   (WST), defined on ITU-R BT.653-2  }

const
  V4L2_SLICED_TELETEXT_B = $0001;
  { Video Program System, defined on ETS 300 231 }
  V4L2_SLICED_VPS = $0400;
  { Closed Caption, defined on EIA-608  }
  V4L2_SLICED_CAPTION_525 = $1000;
  { Wide Screen System, defined on ITU-R BT1119.1  }
  V4L2_SLICED_WSS_625 = $4000;
  V4L2_SLICED_VBI_525 = V4L2_SLICED_CAPTION_525;
  V4L2_SLICED_VBI_625 = (V4L2_SLICED_TELETEXT_B or V4L2_SLICED_VPS) or V4L2_SLICED_WSS_625;
{ service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
     service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
         (equals frame lines 313-336 for 625 line video
          standards, 263-286 for 525 line standards)  }
  { enum v4l2_buf_type  }
  { must be 0  }
type
  Pv4l2_sliced_vbi_cap = ^Tv4l2_sliced_vbi_cap;

  Tv4l2_sliced_vbi_cap = record
    service_set: uint16;
    service_lines: array[0..1] of array[0..23] of uint16;
    _type: uint32;
    reserved: array[0..2] of uint32;
  end;

  { 0: first field, 1: second field  }
  { 1-23  }
  { must be 0  }
  Pv4l2_sliced_vbi_data = ^Tv4l2_sliced_vbi_data;

  Tv4l2_sliced_vbi_data = record
    id: uint32;
    field: uint32;
    line: uint32;
    reserved: uint32;
    Data: array[0..47] of char;
  end;

{
 * Sliced VBI data inserted into MPEG Streams
  }
{
 * V4L2_MPEG_STREAM_VBI_FMT_IVTV:
 *
 * Structure of payload contained in an MPEG 2 Private Stream 1 PES Packet in an
 * MPEG-2 Program Pack that contains V4L2_MPEG_STREAM_VBI_FMT_IVTV Sliced VBI
 * data
 *
 * Note, the MPEG-2 Program Pack and Private Stream 1 PES packet header
 * definitions are not included here.  See the MPEG-2 specifications for details
 * on these headers.
  }
  { Line type IDs  }

const
  V4L2_MPEG_VBI_IVTV_TELETEXT_B = 1;
  V4L2_MPEG_VBI_IVTV_CAPTION_525 = 4;
  V4L2_MPEG_VBI_IVTV_WSS_625 = 5;
  V4L2_MPEG_VBI_IVTV_VPS = 7;
  { One of V4L2_MPEG_VBI_IVTV_* above  }
  { Sliced VBI data for the line  }
type
  Pv4l2_mpeg_vbi_itv0_line = ^Tv4l2_mpeg_vbi_itv0_line;

  Tv4l2_mpeg_vbi_itv0_line = packed record
    id: char;
    Data: array[0..41] of char;
  end;

  { Bitmasks of VBI service lines present  }
  Pv4l2_mpeg_vbi_itv0 = ^Tv4l2_mpeg_vbi_itv0;

  Tv4l2_mpeg_vbi_itv0 = packed record
    linemask: array[0..1] of uint32;
    line: array[0..34] of Tv4l2_mpeg_vbi_itv0_line;
  end;

  Pv4l2_mpeg_vbi_ITV1 = ^Tv4l2_mpeg_vbi_ITV1;

  Tv4l2_mpeg_vbi_ITV1 = packed  record
    line: array[0..35] of Tv4l2_mpeg_vbi_itv0_line;
  end;

const
  V4L2_MPEG_VBI_IVTV_MAGIC0 = 'itv0';
  V4L2_MPEG_VBI_IVTV_MAGIC1 = 'ITV0';

type
  Pv4l2_mpeg_vbi_fmt_ivtv = ^Tv4l2_mpeg_vbi_fmt_ivtv;

  Tv4l2_mpeg_vbi_fmt_ivtv = packed record
    magic: array[0..3] of char;
    u: record
      case longint of
        0: (itv0: Tv4l2_mpeg_vbi_itv0);
        1: (ITV1: Tv4l2_mpeg_vbi_ITV1);
      end;
  end;

{
 *  A G G R E G A T E   S T R U C T U R E S
  }
{*
 * struct v4l2_plane_pix_format - additional, per-plane format definition
 * @sizeimage:    maximum size in bytes required for data, for which
 *      this plane will be used
 * @bytesperline:  distance in bytes between the leftmost pixels in two
 *      adjacent lines
 * @reserved:    drivers and applications must zero this array
  }
  Pv4l2_plane_pix_format = ^Tv4l2_plane_pix_format;

  Tv4l2_plane_pix_format = packed record
    sizeimage: uint32;
    bytesperline: uint32;
    reserved: array[0..5] of uint16;
  end;

{*
 * struct v4l2_pix_format_mplane - multiplanar format definition
 * @width:    image width in pixels
 * @height:    image height in pixels
 * @pixelformat:  little endian four character code (fourcc)
 * @field:    enum v4l2_field; field order (for interlaced video)
 * @colorspace:    enum v4l2_colorspace; supplemental to pixelformat
 * @plane_fmt:    per-plane information
 * @num_planes:    number of planes for this format
 * @flags:    format flags (V4L2_PIX_FMT_FLAG_*)
 * @ycbcr_enc:    enum v4l2_ycbcr_encoding, Y'CbCr encoding
 * @hsv_enc:    enum v4l2_hsv_encoding, HSV encoding
 * @quantization:  enum v4l2_quantization, colorspace quantization
 * @xfer_func:    enum v4l2_xfer_func, colorspace transfer function
 * @reserved:    drivers and applications must zero this array
  }
  Pv4l2_pix_format_mplane = ^Tv4l2_pix_format_mplane;

  Tv4l2_pix_format_mplane = packed  record
    Width: uint32;
    Height: uint32;
    pixelformat: uint32;
    field: uint32;
    colorspace: uint32;
    plane_fmt: array[0..(VIDEO_MAX_PLANES) - 1] of Tv4l2_plane_pix_format;
    num_planes: char;
    flags: char;
    u: record
      case longint of
        0: (ycbcr_enc: char);
        1: (hsv_enc: char);
      end;
    quantization: char;
    xfer_func: char;
    reserved: array[0..6] of char;
  end;

{*
 * struct v4l2_sdr_format - SDR format definition
 * @pixelformat:  little endian four character code (fourcc)
 * @buffersize:    maximum size in bytes required for data
 * @reserved:    drivers and applications must zero this array
  }
  Pv4l2_sdr_format = ^Tv4l2_sdr_format;

  Tv4l2_sdr_format = packed record
    pixelformat: uint32;
    buffersize: uint32;
    reserved: array[0..23] of char;
  end;

{*
 * struct v4l2_meta_format - metadata format definition
 * @dataformat:    little endian four character code (fourcc)
 * @buffersize:    maximum size in bytes required for data
  }
  Pv4l2_meta_format = ^Tv4l2_meta_format;

  Tv4l2_meta_format = packed record
    dataformat: uint32;
    buffersize: uint32;
  end;

{*
 * struct v4l2_format - stream data format
 * @type:  enum v4l2_buf_type; type of the data stream
 * @pix:  definition of an image format
 * @pix_mp:  definition of a multiplanar image format
 * @win:  definition of an overlaid image
 * @vbi:  raw VBI capture or output parameters
 * @sliced:  sliced VBI capture or output parameters
 * @raw_data:  placeholder for future extensions and custom formats
 * @fmt:  union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
 *    and @raw_data
  }
  { V4L2_BUF_TYPE_VIDEO_CAPTURE  }
  { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE  }
  { V4L2_BUF_TYPE_VIDEO_OVERLAY  }
  { V4L2_BUF_TYPE_VBI_CAPTURE  }
  { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE  }
  { V4L2_BUF_TYPE_SDR_CAPTURE  }
  { V4L2_BUF_TYPE_META_CAPTURE  }
  { user-defined  }
  Pv4l2_format = ^Tv4l2_format;

  Tv4l2_format = record
    _type: uint32;
    fmt: record
      case longint of
        0: (pix: Tv4l2_pix_format);
        1: (pix_mp: Tv4l2_pix_format_mplane);
        2: (win: Tv4l2_window);
        3: (vbi: Tv4l2_vbi_format);
        4: (sliced: Tv4l2_sliced_vbi_format);
        5: (sdr: Tv4l2_sdr_format);
        6: (meta: Tv4l2_meta_format);
        7: (raw_data: array[0..199] of char);
      end;
  end;

{  Stream type-dependent parameters
  }
  { enum v4l2_buf_type  }
  { user-defined  }
  Pv4l2_streamparm = ^Tv4l2_streamparm;

  Tv4l2_streamparm = record
    _type: uint32;
    parm: record
      case longint of
        0: (capture: Tv4l2_captureparm);
        1: (output: Tv4l2_outputparm);
        2: (raw_data: array[0..199] of char);
      end;
  end;

{
 *  E V E N T S
  }

const
  V4L2_EVENT_ALL = 0;
  V4L2_EVENT_VSYNC = 1;
  V4L2_EVENT_EOS = 2;
  V4L2_EVENT_CTRL = 3;
  V4L2_EVENT_FRAME_SYNC = 4;
  V4L2_EVENT_SOURCE_CHANGE = 5;
  V4L2_EVENT_MOTION_DET = 6;
  V4L2_EVENT_PRIVATE_START = $08000000;
  { Payload for V4L2_EVENT_VSYNC  }
  { Can be V4L2_FIELD_ANY, _NONE, _TOP or _BOTTOM  }
type
  Pv4l2_event_vsync = ^Tv4l2_event_vsync;

  Tv4l2_event_vsync = packed record
    field: char;
  end;

  { Payload for V4L2_EVENT_CTRL  }

const
  V4L2_EVENT_CTRL_CH_VALUE = 1 shl 0;
  V4L2_EVENT_CTRL_CH_FLAGS = 1 shl 1;
  V4L2_EVENT_CTRL_CH_RANGE = 1 shl 2;

type
  Pv4l2_event_ctrl = ^Tv4l2_event_ctrl;

  Tv4l2_event_ctrl = record
    changes: uint32;
    _type: uint32;
    u: record
      case longint of
        0: (Value: int32);
        1: (value64: int64);
      end;
    flags: uint32;
    minimum: int32;
    maximum: int32;
    step: int32;
    default_value: int32;
  end;

  Pv4l2_event_frame_sync = ^Tv4l2_event_frame_sync;

  Tv4l2_event_frame_sync = record
    frame_sequence: uint32;
  end;


const
  V4L2_EVENT_SRC_CH_RESOLUTION = 1 shl 0;

type
  Pv4l2_event_src_change = ^Tv4l2_event_src_change;

  Tv4l2_event_src_change = record
    changes: uint32;
  end;


const
  V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ = 1 shl 0;
{*
 * struct v4l2_event_motion_det - motion detection event
 * @flags:             if V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ is set, then the
 *                     frame_sequence field is valid.
 * @frame_sequence:    the frame sequence number associated with this event.
 * @region_mask:       which regions detected motion.
  }
type
  Pv4l2_event_motion_det = ^Tv4l2_event_motion_det;

  Tv4l2_event_motion_det = record
    flags: uint32;
    frame_sequence: uint32;
    region_mask: uint32;
  end;

  Pv4l2_event = ^Tv4l2_event;

  Tv4l2_event = record
    _type: uint32;
    u: record
      case longint of
        0: (vsync: Tv4l2_event_vsync);
        1: (ctrl: Tv4l2_event_ctrl);
        2: (frame_sync: Tv4l2_event_frame_sync);
        3: (src_change: Tv4l2_event_src_change);
        4: (motion_det: Tv4l2_event_motion_det);
        5: (Data: array[0..63] of char);
      end;
    pending: uint32;
    sequence: uint32;
    timestamp: Ttimespec;
    id: uint32;
    reserved: array[0..7] of uint32;
  end;


const
  V4L2_EVENT_SUB_FL_SEND_INITIAL = 1 shl 0;
  V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK = 1 shl 1;

type
  Pv4l2_event_subscription = ^Tv4l2_event_subscription;

  Tv4l2_event_subscription = record
    _type: uint32;
    id: uint32;
    flags: uint32;
    reserved: array[0..4] of uint32;
  end;

{
 *  A D V A N C E D   D E B U G G I N G
 *
 *  NOTE: EXPERIMENTAL API, NEVER RELY ON THIS IN APPLICATIONS!
 *  FOR DEBUGGING, TESTING AND INTERNAL USE ONLY!
  }
  { VIDIOC_DBG_G_REGISTER and VIDIOC_DBG_S_REGISTER  }
  { Match against chip ID on the bridge (0 for the bridge)  }

const
  V4L2_CHIP_MATCH_BRIDGE = 0;
  { Match against subdev index  }
  V4L2_CHIP_MATCH_SUBDEV = 4;
  { The following four defines are no longer in use  }
  V4L2_CHIP_MATCH_HOST = V4L2_CHIP_MATCH_BRIDGE;
  { Match against I2C driver name  }
  V4L2_CHIP_MATCH_I2C_DRIVER = 1;
  { Match against I2C 7-bit address  }
  V4L2_CHIP_MATCH_I2C_ADDR = 2;
  { Match against ancillary AC97 chip  }
  V4L2_CHIP_MATCH_AC97 = 3;
  { Match type  }
  { Match this chip, meaning determined by type  }
type
  Pv4l2_dbg_match = ^Tv4l2_dbg_match;

  Tv4l2_dbg_match = packed record
    _type: uint32;
    u: record
      case longint of
        0: (addr: uint32);
        1: (Name: array[0..31] of char);
      end;
  end;

  { register size in bytes  }
  Pv4l2_dbg_register = ^Tv4l2_dbg_register;

  Tv4l2_dbg_register = packed  record
    match: Tv4l2_dbg_match;
    size: uint32;
    reg: uint64;
    val: uint64;
  end;

const
  V4L2_CHIP_FL_READABLE = 1 shl 0;
  V4L2_CHIP_FL_WRITABLE = 1 shl 1;
  { VIDIOC_DBG_G_CHIP_INFO  }
type
  Pv4l2_dbg_chip_info = ^Tv4l2_dbg_chip_info;

  Tv4l2_dbg_chip_info = packed  record
    match: Tv4l2_dbg_match;
    Name: array[0..31] of char;
    flags: uint32;
    reserved: array[0..31] of uint32;
  end;

{*
 * struct v4l2_create_buffers - VIDIOC_CREATE_BUFS argument
 * @index:  on return, index of the first created buffer
 * @count:  entry: number of requested buffers,
 *    return: number of created buffers
 * @memory:  enum v4l2_memory; buffer memory type
 * @format:  frame format, for which buffers are requested
 * @capabilities: capabilities of this buffer type.
 * @reserved:  future extensions
  }
  Pv4l2_create_buffers = ^Tv4l2_create_buffers;

  Tv4l2_create_buffers = record
    index: uint32;
    Count: uint32;
    memory: uint32;
    format: Tv4l2_format;
    capabilities: uint32;
    reserved: array[0..6] of uint32;
  end;

{
 *  I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
 *
  }
const
  VIDIOC_QUERYCAP          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (0 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_capability) shl _IOC_SIZESHIFT));
  VIDIOC_RESERVED           = LongInt((_IOC_NONE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (1 shl _IOC_NRSHIFT) or (0 shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FMT         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (2 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_fmtdesc) shl _IOC_SIZESHIFT));
  VIDIOC_G_FMT            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (4 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_S_FMT            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (5 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_REQBUFS          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (8 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_requestbuffers) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYBUF         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (9 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_G_FBUF            = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (10 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_framebuffer) shl _IOC_SIZESHIFT));
  VIDIOC_S_FBUF            = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (11 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_framebuffer) shl _IOC_SIZESHIFT));
  VIDIOC_OVERLAY           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (14 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_QBUF             = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (15 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_EXPBUF           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (16 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_exportbuffer) shl _IOC_SIZESHIFT));
  VIDIOC_DQBUF            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (17 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_STREAMON          = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (18 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_STREAMOFF         = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (19 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_G_PARM           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (21 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_streamparm) shl _IOC_SIZESHIFT));
  VIDIOC_S_PARM           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (22 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_streamparm) shl _IOC_SIZESHIFT));
  VIDIOC_G_STD             = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (23 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_S_STD             = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (24 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMSTD          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (25 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_standard) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMINPUT        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (26 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_input) shl _IOC_SIZESHIFT));
  VIDIOC_G_CTRL           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (27 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_control) shl _IOC_SIZESHIFT));
  VIDIOC_S_CTRL           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (28 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_control) shl _IOC_SIZESHIFT));
  VIDIOC_G_TUNER          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (29 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_tuner) shl _IOC_SIZESHIFT));
  VIDIOC_S_TUNER           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (30 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_tuner) shl _IOC_SIZESHIFT));
  VIDIOC_G_AUDIO           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (33 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_S_AUDIO           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (34 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYCTRL        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (36 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_queryctrl) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYMENU        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (37 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_querymenu) shl _IOC_SIZESHIFT));
  VIDIOC_G_INPUT           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (38 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_S_INPUT          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (39 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_G_OUTPUT          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (46 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_S_OUTPUT         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (47 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMOUTPUT       = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (48 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_output) shl _IOC_SIZESHIFT));
  VIDIOC_G_AUDOUT          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (49 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_S_AUDOUT          = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (50 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_G_MODULATOR      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (54 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_modulator) shl _IOC_SIZESHIFT));
  VIDIOC_S_MODULATOR       = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (55 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_modulator) shl _IOC_SIZESHIFT));
  VIDIOC_G_FREQUENCY      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (56 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_frequency) shl _IOC_SIZESHIFT));
  VIDIOC_S_FREQUENCY       = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (57 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_frequency) shl _IOC_SIZESHIFT));
  VIDIOC_CROPCAP          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (58 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_cropcap) shl _IOC_SIZESHIFT));
  VIDIOC_G_CROP           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (59 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_crop) shl _IOC_SIZESHIFT));
  VIDIOC_S_CROP            = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (60 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_crop) shl _IOC_SIZESHIFT));
  VIDIOC_G_JPEGCOMP        = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (61 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_jpegcompression) shl _IOC_SIZESHIFT));
  VIDIOC_S_JPEGCOMP        = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (62 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_jpegcompression) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYSTD          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (63 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_FMT          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (64 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMAUDIO        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (65 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMAUDOUT       = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (66 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_G_PRIORITY        = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (67 shl _IOC_NRSHIFT) or (SizeOf(uint32) shl _IOC_SIZESHIFT)); { enum Tv4l2_priority *}
  VIDIOC_S_PRIORITY        = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (68 shl _IOC_NRSHIFT) or (SizeOf(uint32) shl _IOC_SIZESHIFT)); { enum Tv4l2_priority *}
  VIDIOC_G_SLICED_VBI_CAP = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (69 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_sliced_vbi_cap) shl _IOC_SIZESHIFT));
  VIDIOC_LOG_STATUS         = LongInt((_IOC_NONE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (70 shl _IOC_NRSHIFT) or (0 shl _IOC_SIZESHIFT));
  VIDIOC_G_EXT_CTRLS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (71 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_S_EXT_CTRLS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (72 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_EXT_CTRLS    = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (73 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FRAMESIZES  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (74 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_frmsizeenum) shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FRAMEINTERVALS = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (75 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_frmivalenum) shl _IOC_SIZESHIFT));
  VIDIOC_G_ENC_INDEX       = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (76 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_enc_idx) shl _IOC_SIZESHIFT));
  VIDIOC_ENCODER_CMD      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (77 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_encoder_cmd) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_ENCODER_CMD  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (78 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_encoder_cmd) shl _IOC_SIZESHIFT));

{ Experimental, meant for debugging, testing and internal use.
   Only implemented if CONFIG_VIDEO_ADV_DEBUG is defined.
   You must be root to use these ioctls. Never use these in applications! }
  VIDIOC_DBG_S_REGISTER    = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (79 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dbg_register) shl _IOC_SIZESHIFT));
  VIDIOC_DBG_G_REGISTER   = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (80 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dbg_register) shl _IOC_SIZESHIFT));

  VIDIOC_S_HW_FREQ_SEEK    = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (82 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_hw_freq_seek) shl _IOC_SIZESHIFT));

  VIDIOC_S_DV_TIMINGS     = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (87 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_G_DV_TIMINGS     = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (88 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_DQEVENT           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (89 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_event) shl _IOC_SIZESHIFT));
  VIDIOC_SUBSCRIBE_EVENT   = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (90 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_event_subscription) shl _IOC_SIZESHIFT));
  VIDIOC_UNSUBSCRIBE_EVENT = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (91 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_event_subscription) shl _IOC_SIZESHIFT));

{ Experimental, the below two ioctls may change over the next couple of kernel
   versions }
  VIDIOC_CREATE_BUFS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (92 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_create_buffers) shl _IOC_SIZESHIFT));
  VIDIOC_PREPARE_BUF      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (93 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_buffer) shl _IOC_SIZESHIFT));

{ Experimental selection API }
  VIDIOC_G_SELECTION      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (94 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_selection) shl _IOC_SIZESHIFT));
  VIDIOC_S_SELECTION      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (95 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_selection) shl _IOC_SIZESHIFT));

{ Experimental, these two ioctls may change over the next couple of kernel
   versions. }
  VIDIOC_DECODER_CMD      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (96 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_decoder_cmd) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_DECODER_CMD  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (97 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_decoder_cmd) shl _IOC_SIZESHIFT));

{ Experimental, these three ioctls may change over the next couple of kernel
   versions. }
  VIDIOC_ENUM_DV_TIMINGS  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (98 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_enum_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_QUERY_DV_TIMINGS  = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (99 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_DV_TIMINGS_CAP   = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (100 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dv_timings_cap) shl _IOC_SIZESHIFT));

{ Experimental, this ioctl may change over the next couple of kernel
   versions. }
  VIDIOC_ENUM_FREQ_BANDS  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (101 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_frequency_band) shl _IOC_SIZESHIFT));

{ Experimental, meant for debugging, testing and internal use.
   Never use these in applications! }
  VIDIOC_DBG_G_CHIP_INFO  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (102 shl _IOC_NRSHIFT) or (SizeOf(Tv4l2_dbg_chip_info) shl _IOC_SIZESHIFT));

{ Reminder: when adding new ioctls please add support for them to
   drivers/media/video/v4l2-compat-ioctl32.c as well! }

{ Reminder: when adding new ioctls please add support for them to
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well!  }
  { 192-255 are private  }
const
  BASE_VIDIOC_PRIVATE = 192;

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_HAS_TOP(field: longint): longint;
begin
  //  V4L2_FIELD_HAS_TOP:=field:=((V4L2_FIELD_TOP or field):=((V4L2_FIELD_INTERLACED or field):=((V4L2_FIELD_INTERLACED_TB or field):=((V4L2_FIELD_INTERLACED_BT or field):=((V4L2_FIELD_SEQ_TB or field):=V4L2_FIELD_SEQ_BT)))));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_HAS_BOTTOM(field: longint): longint;
begin
  //  V4L2_FIELD_HAS_BOTTOM:=field:=((V4L2_FIELD_BOTTOM or field):=((V4L2_FIELD_INTERLACED or field):=((V4L2_FIELD_INTERLACED_TB or field):=((V4L2_FIELD_INTERLACED_BT or field):=((V4L2_FIELD_SEQ_TB or field):=V4L2_FIELD_SEQ_BT)))));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_HAS_BOTH(field: longint): longint;
begin
  //  V4L2_FIELD_HAS_BOTH:=field:=((V4L2_FIELD_INTERLACED or field):=((V4L2_FIELD_INTERLACED_TB or field):=((V4L2_FIELD_INTERLACED_BT or field):=((V4L2_FIELD_SEQ_TB or field):=V4L2_FIELD_SEQ_BT))));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_HAS_T_OR_B(field: longint): longint;
begin
  //  V4L2_FIELD_HAS_T_OR_B:=field:=((V4L2_FIELD_BOTTOM or field):=((V4L2_FIELD_TOP or field):=V4L2_FIELD_ALTERNATE));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_IS_INTERLACED(field: longint): longint;
begin
  //  V4L2_FIELD_IS_INTERLACED:=field:=((V4L2_FIELD_INTERLACED or field):=((V4L2_FIELD_INTERLACED_TB or field):=V4L2_FIELD_INTERLACED_BT));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_FIELD_IS_SEQUENTIAL(field: longint): longint;
begin
  //  V4L2_FIELD_IS_SEQUENTIAL:=field:=((V4L2_FIELD_SEQ_TB or field):=V4L2_FIELD_SEQ_BT);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_TYPE_IS_MULTIPLANAR(_type: longint): longint;
begin
  //  V4L2_TYPE_IS_MULTIPLANAR:=_type:=((V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE or _type):=V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_TYPE_IS_OUTPUT(_type: longint): longint;
begin
  //  V4L2_TYPE_IS_OUTPUT:=_type:=((V4L2_BUF_TYPE_VIDEO_OUTPUT or _type):=((V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE or _type):=((V4L2_BUF_TYPE_VIDEO_OVERLAY or _type):=((V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY or _type):=((V4L2_BUF_TYPE_VBI_OUTPUT or _type):=((V4L2_BUF_TYPE_SLICED_VBI_OUTPUT or _type):=((V4L2_BUF_TYPE_SDR_OUTPUT or _type):=V4L2_BUF_TYPE_META_OUTPUT)))))));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_TYPE_IS_CAPTURE(_type: longint): longint;
begin
  V4L2_TYPE_IS_CAPTURE := not (V4L2_TYPE_IS_OUTPUT(_type));
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_MAP_COLORSPACE_DEFAULT(is_sdtv, is_hdtv: longint): longint;
var
  if_local1, if_local2: longint;
  (* result types are not known *)
begin
  if is_hdtv <> 0 then begin
    if_local1 := V4L2_COLORSPACE_REC709;
  end else begin
    if_local1 := V4L2_COLORSPACE_SRGB;
  end;
  if is_sdtv <> 0 then begin
    if_local2 := V4L2_COLORSPACE_SMPTE170M;
  end else begin
    if_local2 := if_local1;
  end;
  V4L2_MAP_COLORSPACE_DEFAULT := if_local2;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_MAP_XFER_FUNC_DEFAULT(colsp: longint): longint;
var
  if_local1, if_local2, if_local3, if_local4, if_local5: longint;
  (* result types are not known *)
begin
  //if V4L2_COLORSPACE_JPEG <>0  then
  //  if_local1:=V4L2_XFER_FUNC_SRGB
  //else
  //  if_local1:=V4L2_XFER_FUNC_709;
  //if V4L2_COLORSPACE_RAW <>0  then
  //  if_local2:=V4L2_XFER_FUNC_NONE
  //else
  //  if_local2:=colsp:=((V4L2_COLORSPACE_SRGB or colsp):=(if_local1));
  //if V4L2_COLORSPACE_DCI_P3 then
  //  if_local3:=V4L2_XFER_FUNC_DCI_P3
  //else
  //  if_local3:=colsp:=(if_local2);
  //if V4L2_COLORSPACE_SMPTE240M then
  //  if_local4:=V4L2_XFER_FUNC_SMPTE240M
  //else
  //  if_local4:=colsp:=(if_local3);
  //if V4L2_COLORSPACE_OPRGB then
  //  if_local5:=V4L2_XFER_FUNC_OPRGB
  //else
  //  if_local5:=colsp:=(if_local4);
  //V4L2_MAP_XFER_FUNC_DEFAULT:=colsp:=(if_local5);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_MAP_YCBCR_ENC_DEFAULT(colsp: longint): longint;
//var
//  if_local1, if_local2, if_local3: longint;
//  (* result types are not known *)
begin
  //if V4L2_COLORSPACE_SMPTE240M then
  //  if_local1:=V4L2_YCBCR_ENC_SMPTE240M
  //else
  //  if_local1:=V4L2_YCBCR_ENC_601;
  //if V4L2_COLORSPACE_BT2020 then
  //  if_local2:=V4L2_YCBCR_ENC_BT2020
  //else
  //  if_local2:=colsp:=(if_local1);
  //if colsp:=((V4L2_COLORSPACE_REC709 or colsp):=V4L2_COLORSPACE_DCI_P3) then
  //  if_local3:=V4L2_YCBCR_ENC_709
  //else
  //  if_local3:=colsp:=(if_local2);
  //V4L2_MAP_YCBCR_ENC_DEFAULT:=if_local3;
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }
function V4L2_MAP_QUANTIZATION_DEFAULT(is_rgb_or_hsv, colsp, ycbcr_enc: longint): longint;
var
  if_local1: longint;
  (* result types are not known *)
begin
  if (is_rgb_or_hsv or colsp) = V4L2_COLORSPACE_JPEG then begin
    if_local1 := V4L2_QUANTIZATION_FULL_RANGE;
  end else begin
    if_local1 := V4L2_QUANTIZATION_LIM_RANGE;
  end;
  V4L2_MAP_QUANTIZATION_DEFAULT := if_local1;
end;


//{ was #define dname def_expr }
//function V4L2_STD_PAL_B : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_B:=Tv4l2_std_id($00000001);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_B1 : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_B1:=Tv4l2_std_id($00000002);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_G : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_G:=Tv4l2_std_id($00000004);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_H : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_H:=Tv4l2_std_id($00000008);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_I : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_I:=Tv4l2_std_id($00000010);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_D : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_D:=Tv4l2_std_id($00000020);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_D1 : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_D1:=Tv4l2_std_id($00000040);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_K : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_K:=Tv4l2_std_id($00000080);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_M : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_M:=Tv4l2_std_id($00000100);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_N : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_N:=Tv4l2_std_id($00000200);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_Nc : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_Nc:=Tv4l2_std_id($00000400);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_PAL_60 : Tv4l2_std_id;
//  begin
//    V4L2_STD_PAL_60:=Tv4l2_std_id($00000800);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_NTSC_M : Tv4l2_std_id;
//  begin
//    V4L2_STD_NTSC_M:=Tv4l2_std_id($00001000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_NTSC_M_JP : Tv4l2_std_id;
//  begin
//    V4L2_STD_NTSC_M_JP:=Tv4l2_std_id($00002000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_NTSC_443 : Tv4l2_std_id;
//  begin
//    V4L2_STD_NTSC_443:=Tv4l2_std_id($00004000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_NTSC_M_KR : Tv4l2_std_id;
//  begin
//    V4L2_STD_NTSC_M_KR:=Tv4l2_std_id($00008000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_B : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_B:=Tv4l2_std_id($00010000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_D : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_D:=Tv4l2_std_id($00020000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_G : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_G:=Tv4l2_std_id($00040000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_H : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_H:=Tv4l2_std_id($00080000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_K : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_K:=Tv4l2_std_id($00100000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_K1 : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_K1:=Tv4l2_std_id($00200000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_L : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_L:=Tv4l2_std_id($00400000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_SECAM_LC : Tv4l2_std_id;
//  begin
//    V4L2_STD_SECAM_LC:=Tv4l2_std_id($00800000);
//  end;
//
//{ was #define dname def_expr }
//function V4L2_STD_ATSC_8_VSB : Tv4l2_std_id;
//  begin
//    V4L2_STD_ATSC_8_VSB:=Tv4l2_std_id($01000000);
//  end;

//{ was #define dname def_expr }
//function V4L2_STD_ATSC_16_VSB : Tv4l2_std_id;
//  begin
//    V4L2_STD_ATSC_16_VSB:=Tv4l2_std_id($02000000);
//  end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function V4L2_DV_BT_BLANKING_WIDTH(bt : longint) : longint;
//begin
//  V4L2_DV_BT_BLANKING_WIDTH:=((bt^.hfrontporch)+(bt^.hsync))+(bt^.hbackporch);
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function V4L2_DV_BT_FRAME_WIDTH(bt : longint) : longint;
//begin
//  V4L2_DV_BT_FRAME_WIDTH:=(bt^.width)+(V4L2_DV_BT_BLANKING_WIDTH(bt));
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function V4L2_DV_BT_BLANKING_HEIGHT(bt : longint) : longint;
//var
//   if_local1 : longint;
//(* result types are not known *)
//begin
//  if bt^.interlaced then
//    if_local1:=((bt^.il_vfrontporch)+(bt^.il_vsync))+(bt^.il_vbackporch)
//  else
//    if_local1:=0;
//  V4L2_DV_BT_BLANKING_HEIGHT:=(((bt^.vfrontporch)+(bt^.vsync))+(bt^.vbackporch))+(if_local1);
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function V4L2_DV_BT_FRAME_HEIGHT(bt : longint) : longint;
//begin
//  V4L2_DV_BT_FRAME_HEIGHT:=(bt^.height)+(V4L2_DV_BT_BLANKING_HEIGHT(bt));
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function V4L2_CTRL_ID2CLASS(id : longint) : Tid;
//begin
//  V4L2_CTRL_ID2CLASS:=Tid(@($0fff0000));
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//function V4L2_CTRL_ID2WHICH(id : longint) : Tid;
//begin
//  V4L2_CTRL_ID2WHICH:=Tid(@($0fff0000));
//end;
//
//{ was #define dname(params) para_def_expr }
//{ argument types are unknown }
//{ return type might be wrong }   
//function V4L2_CTRL_DRIVER_PRIV(id : longint) : longint;
//begin
//  V4L2_CTRL_DRIVER_PRIV:=(Tid(@($ffff)))>=$1000;
//end;
//

end.
