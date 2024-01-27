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
//  GroupBox,
  webControl, webInput;

var
  canvas: TJSHTMLCanvasElement;
  NewRG1, NewRG2: TRadioGroupBox;
  NewCG1,NewCG2: TCheckGroupBox;

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

  function ButtonEvaluationsClick(aEvent: TJSMouseEvent): boolean;
  begin
    Writeln(NewRG1.GetChecked);
    Writeln(NewRG2.GetChecked);

    Writeln(NewCG1.GetChecked);
    Writeln(NewCG2.GetChecked);

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
    NewCG1.AddButton('New');
  end;

  procedure Main;
  var
    img, ButtonShowRadio: TJSElement;
    subwc, subwc2: TControl;
    gp: TGroupBox;
  begin
    gp := TGroupBox.Create;
    gp.Width := 150;
    gp.backgroundColor := '#FFBBBB';
    gp.Caption:='Hello World !<br>Hello World !<br>Hello World !<br>Hello World !';

    subwc := TControl.Create( 'div');
    subwc.Width := 80;
    subwc.backgroundColor := '#FFBBFF';
    subwc.Caption:='Hallo Welt';

    subwc2 := TControl.Create( 'div');
    subwc2.Width := 100;
    subwc2.backgroundColor := '#FFFFBB';
    subwc2.Caption:='Sub 2';

    subwc2.Add(subwc);

    NewRG1:=TRadioGroupBox.Create;
//    NewRG1.Caption:='Caption Gruppe 1';
    NewRG1.SetLegend('Legend Gruppe 1');
    NewRG1.AddButton('Button 1');
    NewRG1.AddButton('Button 2');
    NewRG1.AddButton('Button 3');
    NewRG1.Width:=180;
    NewRG1.backgroundColor := '#FFBBFF';
    NewRG1.Color := '#00BBFF';

    NewRG2:=TRadioGroupBox.Create;
//    NewRG2.Caption:='Caption Gruppe 2';
    NewRG2.SetLegend('Legend Gruppe 2');
    NewRG2.AddButton('Button 11');
    NewRG2.AddButton('Button 12');
    NewRG2.AddButton('Button 13');
    NewRG2.AddButton('Button 14');
    NewRG2.AddButton('Button 15');
    NewRG2.Width:=280;

    NewCG1:=TCheckGroupBox.Create;
//    NewRG2.Caption:='Caption Gruppe 2';
    NewCG1.SetLegend('Check Gruppe 1');
    NewCG1.AddButton('Button 21');
    NewCG1.AddButton('Button 22');
    NewCG1.AddButton('Button 23');
    NewCG1.Width:=180;

    NewCG2:=TCheckGroupBox.Create;
//    NewRG2.Caption:='Caption Gruppe 2';
    NewCG2.SetLegend('Check Gruppe 2');
    NewCG2.AddButton('Button 31');
    NewCG2.AddButton('Button 32');
    NewCG2.AddButton('Button 33');
    NewCG2.AddButton('Button 34');
    NewCG2.Width:=180;

    ButtonShowRadio := CreateButton(document.body, 'Radio Auswertung');
    TJSHTMLElement(ButtonShowRadio).onclick := @ButtonEvaluationsClick;

    ButtonShowRadio := CreateButton(document.body, 'Neue CheckBox');
    TJSHTMLElement(ButtonShowRadio).onclick := @ButtonNewRadioClick;
    CreateNewLine(document.body);

    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    document.body.appendChild(img);
//   subwc2.Add(img);
  end;

begin
  Main;
end.
