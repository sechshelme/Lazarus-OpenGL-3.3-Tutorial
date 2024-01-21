program project1;

{$mode objfpc}
{$modeswitch typehelpers}

uses
  browserconsole,
  browserapp,
  JS,
  Classes,
  SysUtils,
  Web;

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

  // === RadioGroup


  // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio

  function CreateRadioButton(Parent: TJSElement; const Caption, Name: string;
    isChecked: boolean = False): TJSElement;
  var
    rb1, label1: TJSElement;
  begin
    Result := document.createElement('div');

    rb1 := document.createElement('input');
    rb1['type'] := 'radio';
    rb1['name'] := Name;
    if isChecked then  rb1['checked'] := '';

    label1 := document.createElement('label');
    rb1['for'] := 'Caption';
    label1.innerHTML := Caption;

    Result.appendChild(label1);
    Result.appendChild(rb1);

    Parent.appendChild(Result);
  end;

  function CreateRadioGroup(Parent: TJSElement; const Caption: string): TJSElement;
  var
    legend: TJSElement;
  begin
    Result := document.createElement('fieldset');

    legend := document.createElement('legend');
    legend.innerHTML := 'RadioGroup';
    Result.appendChild(legend);

    CreateRadioButton(Result, 'Radio 1', Caption);
    CreateRadioButton(Result, 'Radio 2', Caption, True);
    CreateRadioButton(Result, 'Radio 3', Caption);

    Parent.appendChild(Result);
  end;

  // === CheckGroup

  function CreateCheckButton(Parent: TJSElement; const Caption: string): TJSElement;
  var
    rb1, label1: TJSElement;
  begin
    Result := document.createElement('div');

    rb1 := document.createElement('input');
    rb1['type'] := 'checkbox';
    rb1['name'] := 'drone';

    label1 := document.createElement('label');
    rb1['for'] := 'Caption';
    label1.innerHTML := Caption;

    Result.appendChild(label1);
    Result.appendChild(rb1);

    Parent.appendChild(Result);
  end;

  function CreateCheckGroup(Parent: TJSElement): TJSElement;
  var
    legend: TJSElement;
  begin
    Result := document.createElement('fieldset');

    legend := document.createElement('legend');
    legend.innerHTML := 'CheckGroup';
    Result.appendChild(legend);

    CreateCheckButton(Result, 'Check 1');
    CreateCheckButton(Result, 'Check 2');
    CreateCheckButton(Result, 'Check 3');

    Parent.appendChild(Result);
  end;


  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    id: JSValue;
  begin
    Writeln(aEvent.target.Properties['id']);
    id := aEvent.target.Properties['id'];
    if id = 'X-' then
    begin
    end;
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
    Panel, img, ColorButton, LabelRed, div1, Button1, ButtonDisabled,
    myStyle, Edit1, label1, CheckBox1, Fieldset, divCB: TJSElement;
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


    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    Panel.appendChild(img);
  end;

begin
  Create;
end.
