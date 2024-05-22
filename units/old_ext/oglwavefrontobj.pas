unit oglWaveFrontOBJ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Dialogs,
  {$ifdef GLES32}
  oglglad_GLES32,
  {$else}
  oglglad_gl,
  {$endif}
  oglVector, oglMatrix, oglVAO, oglTextur, oglTexturVAO, oglLighting;

type

  { TWavefrontOBJ }

  TWavefrontOBJ = class(TObject)
  private
    type

    { TMyVAO }

    TMyVAO = class(TMultiTexturVAO)
      TexturBuffer: TTexturBuffer;
      constructor Create(anzTextures: integer; Lighting: boolean = True);
      destructor Destroy; override;

      procedure LoadTexture(FileName: string);
      procedure AddTexCoord(v0, v1, v2: TVector2f);
    end;

  private
    MyVAO: array of TMyVAO;
    IsLighting: boolean;
  public
    constructor Create(Lighting: boolean = True);
    destructor Destroy; override;

    procedure WriteVertex(const Datei: string);
    procedure Draw;

    procedure AddLigthing(Lighting: TLighting);
    procedure DeleteLigthing(Lighting: TLighting);
  end;

implementation

{ TWavefrontOBJ.TMyVAO }

constructor TWavefrontOBJ.TMyVAO.Create(anzTextures: integer; Lighting: boolean);
begin
  inherited Create(anzTextures, Lighting);
  TexturBuffer := nil;
end;

destructor TWavefrontOBJ.TMyVAO.Destroy;
begin
  if TTexturBuffer <> nil then begin
    TexturBuffer.Free;
  end;
  inherited Destroy;
end;

procedure TWavefrontOBJ.TMyVAO.LoadTexture(FileName: string);
begin
  TexturBuffer := TTexturBuffer.Create;
  TexturBuffer.LoadTextures(FileName);
end;

procedure TWavefrontOBJ.TMyVAO.AddTexCoord(v0, v1, v2: TVector2f);
begin
  Textur.TexCoord.Add(v0, v1, v2);
end;


{ TWavefrontOBJ }

constructor TWavefrontOBJ.Create(Lighting: boolean);
begin
  IsLighting := Lighting;
end;

destructor TWavefrontOBJ.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(MyVAO) - 1 do begin
    MyVAO[i].Free;
  end;

  inherited Destroy;
end;

procedure TWavefrontOBJ.WriteVertex(const Datei: string);
type
  TIntArray = array of integer;

  TmtlDate = record
    Ka, Kd, Ks: TVector4f;
    Ns: GLfloat;
    map_Kd: string;
  end;

var
  FileSL, vSL, vnSL, vtSL, mtllibSL, tmpSL: TStringList;

  mtlData: TmtlDate;
  path, s: string;
  i, j: integer;
  vecNr: TIntArray;
  IsCreate: boolean;

  function StrToVecInt(ins: string): TIntArray;
  var
    i: integer;
  begin
    ins := StringReplace(ins, '//', ' ', [rfReplaceAll, rfIgnoreCase]);
    ins := StringReplace(ins, '/', ' ', [rfReplaceAll, rfIgnoreCase]);
    tmpSL.Delimiter := ' ';
    tmpSL.DelimitedText := ins;

    SetLength(Result, tmpSL.Count);
    for i := 0 to tmpSL.Count - 1 do begin
      Result[i] := StrToInt(tmpSL[i]) - 1; // f-Werte fangen bei 1 an !
    end;
  end;

  function StrToVec2(const ins: string): TVector2f;
  begin
    tmpSL.Delimiter := ' ';
    tmpSL.DelimitedText := ins;

    if tmpSL.Count < 2 then begin
      ShowMessage('x' + tmpSL.DelimitedText + 'x');
      ShowMessage('Fehler: Anz. Vectoren <> 2');
      tmpSL.DelimitedText := '0.0 0.0';
    end;

    Result[0] := StrToFloat(tmpSL[0]);
    Result[1] := 1.0 - StrToFloat(tmpSL[1]);
  end;

  function StrToVec3(const ins: string): TVector3f;
  var
    i: integer;
  begin
    tmpSL.Delimiter := ' ';
    tmpSL.DelimitedText := ins;

    if tmpSL.Count < 3 then begin
      ShowMessage('x' + tmpSL.DelimitedText + 'x');
      ShowMessage('Fehler: Anz. Vectoren <> 3');
      tmpSL.DelimitedText := '0.0 0.0 0.0';
    end;

    for i := 0 to 2 do begin
      Result[i] := StrToFloat(tmpSL[i]);
    end;
  end;


  function NormalAndTextur(s: string): boolean;
  var       //   xxx/xxx/xxx = True;     xxx/xxx = False;
    i: integer;
  begin
    i := 0;
    repeat
      Inc(i);
    until s[i] = '/';
    repeat
      Inc(i);
      if s[i] = '/' then begin
        Result := True;
        Exit;
      end;
      if s[i] = ' ' then begin
        Result := False;
        Exit;
      end;
    until i = Length(s);
    ShowMessage('Fehler: Ungültige f-Zeile');
  end;

  function LoadmtlData(newmtl: string): TmtlDate;
  var
    i: integer;
    s: string;
  begin
    i := 0;
    Result.Ka := vec4(0.2, 0.2, 0.2, 1.0);
    Result.Kd := vec4(1.0, 1.0, 1.0, 1.0);
    Result.Ks := vec4(0.6, 0.6, 0.6, 1.0);
    Result.Ns := 300.0;
    Result.map_Kd := '';
    if mtllibSL.Count = 0 then begin
      Exit;
    end;
    repeat
      if Pos('newmtl ' + newmtl, mtllibSL[i]) > 0 then begin
        repeat
          s := mtllibSL[i];
          if Pos('Ka ', s) in [1..4] then begin
            Result.Ka := vec4(StrToVec3(Copy(mtllibSL[i], Pos('Ka ', s) + 3)), 1.0);
          end;

          if Pos('Kd ', s) in [1..4] then begin
            Result.Kd := vec4(StrToVec3(Copy(mtllibSL[i], Pos('Kd ', s) + 3)), 1.0);
          end;

          if Pos('Ks ', s) in [1..4] then begin
            Result.Ks := vec4(StrToVec3(Copy(mtllibSL[i], Pos('Ks ', s) + 3)), 1.0);
          end;

          if Pos('Ns ', s) in [1..4] then begin
            Result.Ns := StrToFloat(Copy(mtllibSL[i], Pos('Ns ', s) + 3));
          end;

          if Pos('map_Kd ', s) in [1..4] then begin
            Result.map_Kd := path + Copy(mtllibSL[i], Pos('map_Kd ', s) + 7);
            if not FileExists(Result.map_Kd) then begin
//              LogForm.Add('TWavefrontOBJ mtl image, File not found: ' + Result.map_Kd);
//              LogForm.Show;
              Result.map_Kd := '';
            end;
          end;

          Inc(i);
        until (i >= mtllibSL.Count) or (Pos('newmtl ', mtllibSL[i]) > 0);
        Exit;

      end;
      Inc(i);
    until i >= mtllibSL.Count;
  end;

begin
  FileSL := TStringList.Create;
  FileSL.LoadFromFile(Datei);
  vSL := TStringList.Create;
  vnSL := TStringList.Create;
  vtSL := TStringList.Create;
  mtllibSL := TStringList.Create;
  tmpSL := TStringList.Create;

  for i := 0 to Length(MyVAO) - 1 do begin
    MyVAO[i].Free;
  end;
  SetLength(MyVAO, 0);
  IsCreate := False;
  mtlData := LoadmtlData('');
  path := ExtractFilePath(Datei);

  for i := 0 to FileSL.Count - 1 do begin
    if Pos('#', FileSL[i]) = 0 then begin

      if Pos('v ', FileSL[i]) in [1..4] then begin
        vSL.Add(Copy(FileSL[i], 2));
      end;

      if Pos('vt ', FileSL[i]) in [1..4] then begin
        vtSL.Add(Copy(FileSL[i], 3));
      end;

      if Pos('vn ', FileSL[i]) in [1..4] then begin
        vnSL.Add(Copy(FileSL[i], 3));
      end;

      if Pos('f ', FileSL[i]) in [1..4] then begin
        if not IsCreate then begin
          SetLength(MyVAO, Length(MyVAO) + 1);
          if mtlData.map_Kd = '' then begin
            MyVAO[Length(MyVAO) - 1] := TMyVAO.Create(0);
          end else begin
            MyVAO[Length(MyVAO) - 1] := TMyVAO.Create(1);
            MyVAO[Length(MyVAO) - 1].LoadTexture(mtlData.map_Kd);
          end;
          with MyVAO[Length(MyVAO) - 1].LightingShader.MaterialParams do begin
            ambient := mtlData.Ka;
            diffuse := mtlData.Kd;
            specular := mtlData.Ks;
            shininess := mtlData.Ns;
          end;
          MyVAO[Length(MyVAO) - 1].LightingShader.UpdateMaterial;
          IsCreate := True;
        end;

        with MyVAO[Length(MyVAO) - 1] do begin

          vecNr := StrToVecInt(Copy(FileSL[i], 2));

          if Pos('//', FileSL[i]) > 0 then begin    // Pos & Normal
            for j := 1 to Length(vecNr) div 2 - 2 do begin
              Triangles(
                StrToVec3(vSL[vecNr[0]]), StrToVec3(vSL[vecNr[j * 2 + 0]]), StrToVec3(vSL[vecNr[j * 2 + 2]]),
                StrToVec3(vnSL[vecNr[1]]), StrToVec3(vnSL[vecNr[j * 2 + 1]]), StrToVec3(vnSL[vecNr[j * 2 + 3]]));
            end;
          end else if Pos('/', FileSL[i]) > 0 then begin

            if NormalAndTextur(FileSL[i]) then begin      // Pos & Textur & Normal
              for j := 1 to Length(vecNr) div 3 - 2 do begin
                Triangles(
                  StrToVec3(vSL[vecNr[0]]), StrToVec3(vSL[vecNr[j * 3 + 0]]), StrToVec3(vSL[vecNr[j * 3 + 3]]),
                  StrToVec3(vnSL[vecNr[2]]), StrToVec3(vnSL[vecNr[j * 3 + 2]]), StrToVec3(vnSL[vecNr[j * 3 + 5]]));
                AddTexCoord(
                  StrToVec2(vtSL[vecNr[1]]), StrToVec2(vtSL[vecNr[j * 3 + 1]]), StrToVec2(vtSL[vecNr[j * 3 + 4]]));
              end;

            end else begin                       // Pos & Textur
              for j := 1 to Length(vecNr) div 2 - 2 do begin
                Triangles(StrToVec3(vSL[vecNr[0]]), StrToVec3(vSL[vecNr[j * 2 + 0]]), StrToVec3(vSL[vecNr[j * 2 + 2]]));
                AddTexCoord(StrToVec2(vtSL[vecNr[1]]), StrToVec2(vtSL[vecNr[j * 2 + 1]]), StrToVec2(vtSL[vecNr[j * 2 + 3]]));
              end;
            end;

          end else begin  // Nur Pos
            for j := 1 to Length(vecNr) - 2 do begin
              Triangles(StrToVec3(vSL[vecNr[0]]), StrToVec3(vSL[vecNr[j + 0]]), StrToVec3(vSL[vecNr[j + 1]]));
            end;
          end;
        end;

      end; // if Pos('f...

      if Pos('mtllib ', FileSL[i]) in [1..4] then begin
        s := Copy(FileSL[i], 8);
        if FileExists(path + s) then begin
          mtllibSL.LoadFromFile(path + s);
        end else begin
//          LogForm.Add('TWavefrontOBJ mtllib, File not found: ' + path + s);
//          LogForm.Show;
        end;
      end;

      if Pos('usemtl ', FileSL[i]) in [1..4] then begin
        mtlData := LoadmtlData(Copy(FileSL[i], 8));
        IsCreate := False;
      end;

    end;
  end;

  for i := 0 to Length(MyVAO) - 1 do begin
    MyVAO[i].WriteVertex;
  end;

  FileSL.Free;
  vSL.Free;
  vtSL.Free;
  vnSL.Free;
  mtllibSL.Free;
  tmpSL.Free;
end;

procedure TWavefrontOBJ.Draw;
var
  i: integer;
begin
  for i := 0 to Length(MyVAO) - 1 do begin
    with MyVAO[i] do begin
      if TexturBuffer = nil then begin
        Draw;
      end else begin
        Draw(TexturBuffer);
      end;
    end;
  end;
end;

procedure TWavefrontOBJ.AddLigthing(Lighting: TLighting);
var
  i: integer;
begin
  for i := 0 to Length(MyVAO) - 1 do begin
    Lighting.Add(MyVAO[i]);
  end;
end;

procedure TWavefrontOBJ.DeleteLigthing(Lighting: TLighting);
var
  i: integer;
begin
  for i := 0 to Length(MyVAO) - 1 do begin
    Lighting.Delete(MyVAO[i]);
  end;
end;

end.
