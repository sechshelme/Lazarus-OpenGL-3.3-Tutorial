program project1;

{$mode objfpc}
{$modeswitch typehelpers}

uses
  browserconsole,
  browserapp,
  JS,
  Classes,
  SysUtils,
  Web, Radio_and_Check_Group;

var
  canvas: TJSHTMLCanvasElement;

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

  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    index: Integer;
  begin
    index:=getRadioButton('gruppe1');

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

  procedure Create;
  var
    Panel, img,     btn: TJSElement;
  begin
    CreateBox(document.body, 'body');


    CreateLabelButton(document.body, 'Knopf1: ');
    CreateButton(document.body, 'Button1');
    CreateLabelButton(document.body, 'Knopf2: ');
    CreateButton(document.body, 'Button2');
    CreateLabelButton(document.body, 'Knopf3: ');
    CreateButton(document.body, 'Button3');

    CreateRadioGroup(document.body, 'gruppe1');
    CreateRadioGroup(document.body, 'gruppe2');
    CreateCheckGroup(document.body);

    btn:=CreateButton(document.body, 'Radio Auswertung');

    TJSHTMLElement(btn).onclick := @ButtonClick;




    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    Panel.appendChild(img);
  end;

begin
  Create;
end.
