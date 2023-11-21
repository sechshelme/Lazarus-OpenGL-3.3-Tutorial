unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFastBitmap }

  TFastBitmap = class(TBitmap)
    procedure PutPixel(x, y: UInt32; col: UInt32);
    function GetPixel(x, y: UInt32): UInt32;
  end;


  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    BitSource, BitTextur, BitNormal: TFastBitmap;
    procedure DrawMauer(bit: TFastBitmap);

    procedure CreateNormale;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
//  TexturSize = 1024;
  TexturSize = 32;
  StoneSize = 16;
  TemTexturSize = TexturSize * 3;

  colZiegel = $112288;
  colFuge = $888888;

  pfad = '/n4800/DATEN/Programmierung/Lazarus/Tutorials/OpenGL_3.3/10_-_Bump_Mapping/05_-_Bump_Mapping/';

{ TFastBitmap }

procedure TFastBitmap.PutPixel(x, y: UInt32; col: UInt32);
var
  p: pUInt32;
begin
  p := pUInt32(RawImage.Data);
  Inc(p, x + y * Width);
  p^ := col;
//  p^ := col or $FF000000;
end;

function TFastBitmap.GetPixel(x, y: UInt32): UInt32;
var
  p: pUInt32;
begin
  p := pUInt32(RawImage.Data);
  Inc(p, x + y * Width);
  Result := p^;
end;


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  BitSource := TFastBitmap.Create;
  with BitSource do begin
    PixelFormat := pf32bit;
    Width := TemTexturSize;
    Height := TemTexturSize;

    Caption := IntToStr(BitSource.Width);
    Canvas.Clear;
    DrawMauer(BitSource);

    SaveToFile('test.bmp');
  end;

  BitTextur := TFastBitmap.Create;
  BitNormal := TFastBitmap.Create;

  with BitTextur do begin
    PixelFormat := pf32bit;
    Width := TexturSize;
    Height := TexturSize;
    Canvas.Clear;
  end;

  with BitNormal do begin
    PixelFormat := pf32bit;
    Width := TexturSize;
    Height := TexturSize;
    Canvas.Clear;
  end;
  CreateNormale;
  BitTextur.SaveToFile(pfad + 'textur.bmp');
  BitNormal.SaveToFile(pfad + 'normal.bmp');

  BitTextur.SaveToFile('textur.bmp');
  BitNormal.SaveToFile('normal.bmp');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('textur.bmp');
  Image2.Picture.LoadFromFile('normal.bmp');
end;

procedure TForm1.DrawMauer(bit: TFastBitmap);
var
  x, y: integer;
begin
  for y := 0 to bit.Height - 1 do begin
    for x := 0 to bit.Width - 1 do begin
      if ((x mod (StoneSize * 2) = 0) and (y div (StoneSize) mod 2 = 0)) or
        (((x + StoneSize) mod (StoneSize * 2) = 0) and (y div (StoneSize) mod 2 = 1)) or
        (y mod StoneSize = 0) then begin
        bit.PutPixel(x, y, colFuge);
      end else begin
        bit.PutPixel(x, y,colZiegel);
      end;
    end;
  end;
end;

procedure TForm1.CreateNormale;

  function IsFuge(bit: TFastBitmap; x, y: integer): byte;
  begin
    Result := %0000;

    if bit.GetPixel(x, y - 1) = colFuge then begin
      Result := Result or %0001;
    end;

    if bit.GetPixel(x + 1, y) = colFuge then begin
      Result := Result or %0010;
    end;

    if bit.GetPixel(x, y + 1) = colFuge then begin
      Result := Result or %0100;
    end;

    if bit.GetPixel(x - 1, y) = colFuge then begin
      Result := Result or %1000;
    end;
  end;

var
  x, y: integer;
  msk: byte;
begin
  for y := 0 to TexturSize - 1 do begin
    for x := 0 to TexturSize - 1 do begin
      msk := IsFuge(BitSource, x + TexturSize,  y + TexturSize);

      if msk = %0000 then begin
        BitNormal.PutPixel(x, y, $FF8888);
        BitTextur.PutPixel(x, y, colZiegel);

      end else if msk = %0001 then begin
        BitNormal.PutPixel(x, y, $880088);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %0010 then begin
        BitNormal.PutPixel(x, y, $8888FF);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %0100 then begin
        BitNormal.PutPixel(x, y, $88FF88);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %1000 then begin
        BitNormal.PutPixel(x, y, $888800);
        BitTextur.PutPixel(x, y, colFuge);

      end else if msk = %0011 then begin
        BitNormal.PutPixel(x, y, $884CB4);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %0110 then begin
        BitNormal.PutPixel(x, y, $88B4B4);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %1100 then begin
        BitNormal.PutPixel(x, y, $88B44C);
        BitTextur.PutPixel(x, y, colFuge);
      end else if msk = %1001 then begin
        BitNormal.PutPixel(x, y, $884C4C);
        BitTextur.PutPixel(x, y, colFuge);
      end else begin

        BitNormal.PutPixel(x, y, $FF8888);
        BitTextur.PutPixel(x, y, colFuge);
      end;
    end;
  end;

end;

end.
