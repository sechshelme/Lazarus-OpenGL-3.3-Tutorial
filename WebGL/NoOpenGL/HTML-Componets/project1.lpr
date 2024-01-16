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



  procedure Create;
  var
    Panel, img, ColorButton, LabelRed, div1, Button1, Button2,
      myStyle: TJSElement;
  begin
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

    myStyle:=document.createElement('style');
    myStyle['id'] := 'myStyle';
    myStyle['style'] := 'background-color: #FFBBBB;';
    Panel.appendChild(myStyle);

    Button1 := document.createElement('input');
    Button1['id'] := 'Button1';
//    Button1['class'] := 'favorite styled';
    Button1['type'] := 'button';
    Button1['value'] := 'Button1';
 //   Button1['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
//    Button1['style'] := 'border: 15px outset red;  background-color: lightblue; text-align: center;';
 Button1['style'] := 'background-color: #FFBBBB;';
//Button1['class'] := 'myStyle';

    TJSHTMLElement(Button1).onclick := @ButtonClick;
    Panel.appendChild(Button1);

    div1 := document.createElement('div');
    div1.innerHTML := 'Zeile 1<br>Zeile 2';
    Panel.appendChild(div1);


    Button2 := document.createElement('input');
    Button2['id'] := 'Button2';
    Button2['class'] := 'favorite styled';
    Button2['type'] := 'button';
    Button2['value'] := 'Button2';
    Button2['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';

    TJSHTMLElement(Button2).onclick := @ButtonClick;
    Panel.appendChild(Button2);

    ColorButton := document.createElement('input');
    ColorButton['value'] := '#00ff00';
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


    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    Panel.appendChild(img);
  end;

begin
  Create;
end.
