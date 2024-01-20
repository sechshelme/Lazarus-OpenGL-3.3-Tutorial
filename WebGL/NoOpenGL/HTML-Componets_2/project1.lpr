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

  procedure CreateButton(Parent: TJSElement; const Caption: string);
  var
    btn: TJSElement;
  begin
    btn := document.createElement('input');
    btn['id'] := Caption + '_id';
    btn['class'] := 'myStyle';
    btn['type'] := 'button';
    btn['value'] := Caption;
    //   btn['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
    //    btn['style'] := 'border: 15px outset red;  background-color: lightblue; text-align: center;';
    // btn['style'] := 'background-color: #FFBBBB;';
    //btn['class'] := 'myStyle';

    //  TJSHTMLElement(btn).onclick := @ButtonClick;
    Parent.appendChild(btn);
  end;

  procedure CreateLabelButton(Parent: TJSElement; const Caption: string);
  var
    Lab: TJSElement;
  begin
    Lab := document.createElement('div');
       Lab.innerHTML := Caption;
       CreateButton(Lab,'X');
       CreateButton(Lab,'Y');
       CreateButton(Lab,'Z');
    Parent.appendChild(Lab);
  end;

procedure
 CreateBox(Parent: TJSElement; const Caption: string);
var
  Lab: TJSElement;
begin
  Lab := document.createElement('div');
//  Lab['style'] := 'border-style: solid; border-width: 3px;  height:125px;width:175px;border-color=red;background-color: #FFBBBB;';
  Lab['style'] := 'width:175px;  border-left: dotted blue;  border-right: dotted red; background-color: #FFBBBB;';

     Lab.innerHTML := Caption;
     CreateLabelButton(Lab, 'Create Box 1');
     CreateLabelButton(Lab, 'Create Box 2');
     CreateLabelButton(Lab, 'Create Box 3');
  Parent.appendChild(Lab);
  end;




  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    id: JSValue;
  begin
    Writeln(aEvent.target.Properties['id']);
    id := aEvent.target.Properties['id'];
    if id = 'X-' then  begin
    end;
    Result := True;
  end;

  function ButtonDisabledClick(aEvent: TJSMouseEvent): boolean;
  begin
    TJSHTMLButtonElement(document.getElementById('Button1')).disabled := not TJSHTMLButtonElement(document.getElementById('Button1')).disabled;
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
    CreateBox(document.body,'body');


    CreateLabelButton(document.body, 'Knopf1: ');
    CreateButton(document.body, 'Button1');
    CreateLabelButton(document.body, 'Knopf2: ');
    CreateButton(document.body, 'Button2');
    CreateLabelButton(document.body, 'Knopf3: ');
    CreateButton(document.body, 'Button3');


    Panel := document.createElement('div');
    Panel['class'] := 'panel panel-default';
    document.body.appendChild(Panel);

    // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color
    // https://www.w3schools.com/tags/tag_div.ASP

    LabelRed := document.createElement('div');
    LabelRed.innerHTML := '<b>Bitte drücke einen Knopf</b>';
    //    LabelRed.outerHTML:='<b>Bitte drücke einen Knopf</b>';
    Panel.appendChild(LabelRed);


    div1 := document.createElement('div');
    Panel.appendChild(div1);

    myStyle := document.createElement('style');
    myStyle['id'] := 'myStyle';
    myStyle['style'] := 'background-color: #BBFFBB;';
    Panel.appendChild(myStyle);

    Button1 := document.createElement('input');
    Button1['id'] := 'Button1';
    Button1['class'] := 'myStyle';
    Button1['type'] := 'button';
    Button1['value'] := 'Button1';
    //   Button1['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
    //    Button1['style'] := 'border: 15px outset red;  background-color: lightblue; text-align: center;';
    // Button1['style'] := 'background-color: #FFBBBB;';
    //Button1['class'] := 'myStyle';

    TJSHTMLElement(Button1).onclick := @ButtonClick;
    Panel.appendChild(Button1);

    div1 := document.createElement('div');
    div1.innerHTML := 'Zeile 1<br>Zeile 2';
    Panel.appendChild(div1);


    ButtonDisabled := document.createElement('input');
    ButtonDisabled['id'] := 'disabledBtn';
    ButtonDisabled['class'] := 'favorite styled';
    ButtonDisabled['type'] := 'button';
    ButtonDisabled['value'] := 'disabled    Btn';
    ButtonDisabled['style'] := 'height:25px;width:75px;color=#00ff00;background-color: #FF0000;';

    Writeln(TJSHTMLInputElement(ButtonDisabled).style.item(0));
    Writeln(TJSHTMLInputElement(ButtonDisabled).style.item(1));
    Writeln(TJSHTMLInputElement(ButtonDisabled).style.length);
    TJSHTMLStyleElement(ButtonDisabled).style.cssText := 'height:125px;background-color: #FF00FF';


    //    TJSHTMLInputElement(ButtonDisabled).style := 'background-color: #FF00FF';


    TJSHTMLElement(ButtonDisabled).onclick := @ButtonDisabledClick;
    Panel.appendChild(ButtonDisabled);

    ColorButton := document.createElement('input');
    ColorButton['value'] := '#0000ff';
    ColorButton['type'] := 'color';
    ColorButton['id'] := 'head';
    ColorButton['name'] := 'head';
    Panel.appendChild(ColorButton);

    ColorButton := document.createElement('input');
    ColorButton['value'] := '#00ff00';
    ColorButton['type'] := 'color';
    ColorButton['id'] := 'head';
    ColorButton['name'] := 'head';
    Panel.appendChild(ColorButton);

    // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
    label1 := document.createElement('label');
    label1.innerHTML := '<br>Zeile 1<br>Zeile 2<br>Zeile 3<br>Zeile 4';
    label1['for'] := 'name';
    Panel.appendChild(label1);

    Edit1 := document.createElement('input');
    Edit1['name'] := 'name';
    Edit1['type'] := 'text';
    Edit1['minlength'] := '4';
    Edit1['maxlength'] := '8';
    Edit1['size'] := '12';
    Panel.appendChild(Edit1);

    // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox

    Fieldset := document.createElement('fieldset');
    Panel.appendChild(Fieldset);


    divCB := document.createElement('div');
    TJSHTMLInputElement(divCB).Value := 'fgfdgdsg';
    //    divCB.innerHTML := 'Zeile 1111';
    Fieldset.appendChild(divCB);


    CheckBox1 := document.createElement('input');
    CheckBox1['type'] := 'checkbox';
    CheckBox1['name'] := 'checkbox';
    divCB.appendChild(CheckBox1);



    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    Panel.appendChild(img);
  end;

begin
  Create;
end.
