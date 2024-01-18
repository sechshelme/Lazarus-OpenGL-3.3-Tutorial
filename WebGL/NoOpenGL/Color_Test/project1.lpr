program project1;

{$mode objfpc}
{$modeswitch externalclass}

uses
  JS,
  Classes,
  SysUtils,
  browserconsole,
  Web;

  // https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_onclick_win
// https://github.com/Kryuski/pas2js-for-delphi/blob/master/packages/chartjs/chartjs.pas

  type
    TColorElement = class external name 'Object' (TJSCSSStyleDeclaration)
      backgroundColor: String; external name 'backgroundColor';
      borderColor: String; external name 'borderColor';

      //borderWidth: Integer; external name 'borderWidth';
      //radius: JSValue; external name 'radius';
      //color: JSValue; external name 'color';
    end;


  function onclick(aEvent: TJSMouseEvent): boolean;
  begin
    //    TJSHTMLStyleElement(document.getElementsByTagName('BODY')[0]).style.:=nil;
  end;

  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  begin
    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).backgroundColor := 'red';
    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).borderColor := 'yellow';
//    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).color := 'green';


    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[1]).style).backgroundColor := 'blue';
    TColorElement(TJSHTMLElement(document.getElementsByTagName('body')[0]).style).backgroundColor := 'green';
  end;

var
  Button1, Button2: TJSElement;

begin
  Button1 := document.createElement('input');
  Button1['id'] := 'Button2_id';
  Button1['type'] := 'button';
  Button1['value'] := 'Button2';
//  Button1['style'] := 'background-color: #FFBBBB;';

  //  TJSHTMLElement(Button1).onclick := @ButtonClick;
  document.body.appendChild(Button1);

  Button2 := document.createElement('input');
  Button2['id'] := 'Button1_id';
  Button2['type'] := 'button';
  Button2['value'] := 'Button1';
//  Button2['style'] := 'background-color: #FFBBFF;';

  TJSHTMLElement(Button2).onclick := @ButtonClick;
  document.body.appendChild(Button2);

      TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).backgroundColor := 'white';



  // Your code here
  window.onclick := @onclick;
end.














program Project1;

{$modeswitch externalclass}

uses
  JS, Classes, SysUtils, Web;

type

var
  Button1: TJSElement;

begin
  Button1 := document.createElement('input');
  Button1['id'] := 'Button2_id';
  Button1['type'] := 'button';
  Button1['value'] := 'Button2';
  document.body.appendChild(Button1);

  TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).backgroundColor := 'red';
  TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).borderColor := 'blue';
  TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).borderWidth := 10;

  TColorElement(TJSHTMLElement(document.getElementsByTagName('body')[0]).style).backgroundColor := 'green';
end.
