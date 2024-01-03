program project1;

{$mode objfpc}

uses
  browserconsole, browserapp, JS, Classes, SysUtils, Web;

var
  canvas: TJSHTMLCanvasElement;
  s: string;
  ImgGhost: TJSHTMLImageElement;

  Function GetElement(aName : String) : TJSHTMLElement;

  begin
    Result:=TJSHTMLElement(Document.getElementById(aName));
  end;



begin
  canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
  canvas.Width := 640;
  canvas.Height := 480;

  document.body.appendChild(canvas);


  ImgGhost:=TJSHTMLtexImageElement(GetElement('ghost'+IntToStr(i))) ;


  document.writeln('blabla');

  document.writeln('Vor Laden:');
  s := document.getElementById('project1.lpr').textContent;
  document.writeln('Nach Laden:');
  document.writeln(s);
end.



procedure TPacman.SetupPacman;

  Function GetElement(aName : String) : TJSHTMLElement;

  begin
    Result:=TJSHTMLElement(Document.getElementById(aName));
  end;

Var
  I : integer;
  El :  TJSElement;

begin
  if FCanvasID='' then
    FCanvasID:='my-canvas';
  if FResetID='' then
    FResetID:='btn-reset';
  FCanvasEl:=TJSHTMLCanvasElement(Document.getElementById(FCanvasID));
  FCanvas:=TJSCanvasRenderingContext2D(FCanvasEl.getContext('2d'));
  FBtnReset:=TJSHTMLButtonElement(Document.getElementById(FResetID));
  FCBXSound:=TJSHTMLInputElement(GetElement('cbx-sound'));
  FCBXSound.onchange:=@CheckSound;
  if Assigned(FBtnReset) then
    FBtnReset.OnClick:=@DoResetClick;
  FCanvasEl.width := Round(FCanvasEl.OffsetWidth);
  FCanvasEl.height := Round(FCanvasEl.OffsetHeight);
  for I:=1 to 4 do
    ImgGhost[i]:=TJSHTMLImageElement(GetElement('ghost'+IntToStr(i))) ;
  ImgGhost[5]:=TJSHTMLImageElement(GetElement('ghost-scared'));
  ImgBonus:=TJSHTMLImageElement(GetElement('cherry'));
  for I:=1 to ControlCount do
     begin
     El:=GetElement('control-'+ControlNames[i]);
     if Assigned(El) then
       TJSHTMLElement(El).onClick:=@DoMouseClick;
     end;
  pnBonusBarOuter:=GetElement('bonus-outer');
  pnBonusBarInner:= GetElement('bonus-inner');
  pnScareBarOuter:=GetElement('scare-outer');
  pnScareBarInner:=GetElement('scare-inner');
  lbScore:=GetElement('score');
  lbStatus:=GetElement('status');
  lbHiscore:=GetElement('highscore');
  lbLives:=GetElement('lives');
  lbBonusCnt:=GetElement('bonus');
  lbGhostCnt:=GetElement('ghosts');
  // Sprites need the images, so this can only be done in this part
  InitSprites();
  document.onkeydown:=@HandleKeyPress;
  if not AudioDisabled then
    InitAudio()
end;

