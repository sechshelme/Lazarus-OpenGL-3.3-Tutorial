program project1;

{$mode objfpc}
{$modeswitch typehelpers}

uses
  browserconsole,
  //  browserapp,
  JS,
  Classes,
  SysUtils,
  Web,
  GroupBox;

var
  canvas: TJSHTMLCanvasElement;
  RG1, RG2: TRadioGroup;
  CG1: TCheckGroup;

  function CreateButton(Parent: TJSElement; const Caption: string): TJSElement;
  begin
    Result := document.createElement('input');
    Result['id'] := Caption + '_id';
    Result['class'] := 'myStyle';
    Result['type'] := 'button';
    Result['value'] := Caption;
    //   Result['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
    //    Result['style'] := 'border: 15px outset red;  background-color: lightblue; text-align: center;';
    // Result['style'] := 'background-color: #FFBBBB;';
    //Result['class'] := 'myStyle';

    //  TJSHTMLElement(Result).onclick := @ButtonClick;
    Parent.appendChild(Result);
  end;

function CreateLabelButton(Parent: TJSElement; const Caption: string): TJSElement;
begin
  Result := document.createElement('div');
  Result.innerHTML := Caption;
  CreateButton(Result, 'X');
  CreateButton(Result, 'Y');
  CreateButton(Result, 'Z');
  Parent.appendChild(Result);
end;

function CreateNewLine(Parent: TJSElement): TJSElement;
begin
  Result := document.createElement('div');
  Parent.appendChild(Result);
end;

  function CreateBox(Parent: TJSElement; const Caption: string): TJSElement;
  begin
    Result := document.createElement('div');
    //  Result['style'] := 'border-style: solid; border-width: 3px;  height:125px;width:175px;border-color=red;background-color: #FFBBBB;';
    Result['style'] :=
      'width:175px;  border-left: dotted blue;  border-right: dotted red; background-color: #FFBBBB;';

    Result.innerHTML := Caption;
    CreateLabelButton(Result, 'Create Box 1');
    CreateLabelButton(Result, 'Create Box 2');
    CreateLabelButton(Result, 'Create Box 3');
    Parent.appendChild(Result);
  end;

  function ButtonEvaluationsClick(aEvent: TJSMouseEvent): boolean;
  var
    index: integer;
  begin
    Writeln(RG1.GetChecked);
    Writeln(CG1.GetCheckeds);
    //    index:=getRadioButton('gruppe1');

    Result := True;
  end;

  function ButtonDisabledClick(aEvent: TJSMouseEvent): boolean;
  begin
    TJSHTMLButtonElement(document.getElementById('Button1')).disabled :=
      not TJSHTMLButtonElement(document.getElementById('Button1')).disabled;
    //    Writeln(TJSHTMLInputElement(document.getElementById('Button1')).size);
    //    TJSHTMLInputElement(document.getElementById('Button1')).size := 50;
    TJSHTMLButtonElement(document.getElementById('Button1')).Value := 'bla';
    //    Writeln(TJSHTMLInputElement(document.getElementById('Button1')).size);
  end;

  function ButtonNewRadioClick(aEvent: TJSMouseEvent): boolean;
  begin
    RG1.Add('New');
  end;

  procedure Create;
  var
    img, ButtonShowRadio: TJSElement;
  begin
    RG1 := TRadioGroup.Create(document.body);
    RG1.Caption := 'Radio 1 Gruppe mit class';
    RG1.Add('Radio 0');
    RG1.Add('Radio 1');
    RG1.Add('Radio 2');
    RG1.Width := 200;
    RG1.backgroundColor := '#FFFFBB';

    RG2 := TRadioGroup.Create(document.body);
    RG2.Caption := 'Radio 2 Gruppe mit class';
    RG2.Add('Radio 100');
    RG2.Add('Radio 101');
    RG2.Add('Radio 102');
    RG2.backgroundColor := '#BBFFFF';
    RG2.Height := 200;
    RG2.Width := 200;


    CG1 := TCheckGroup.Create(document.body);
    CG1.Caption := 'CheckBox 1 Gruppe mit class';
    CG1.Add('Check 1');
    CG1.Add('Check 2');
    CG1.Add('Check 2');
    CG1.Width := 200;
    CG1.backgroundColor := '#FFBBFF';

    ButtonShowRadio := CreateButton(document.body, 'Radio Auswertung');
    TJSHTMLElement(ButtonShowRadio).onclick := @ButtonEvaluationsClick;

    ButtonShowRadio := CreateButton(document.body, 'Neuer RadioButton');
    TJSHTMLElement(ButtonShowRadio).onclick := @ButtonNewRadioClick;
    CreateNewLine(document.body);

    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    document.body.appendChild(img);
  end;

begin
  Create;
end.
