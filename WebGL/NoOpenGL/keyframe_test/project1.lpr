program project1;

{$mode objfpc}
{$modeswitch externalclass}
{$modeswitch typehelpers}

uses
  JS,
  Classes,
  SysUtils,
  Web,
  webgl,
  browserconsole;

    type
    TNewJSHTMLElement = class external name 'Object' (TJSHTMLElement)
      procedure animate(contextAttributes : TJSObject; t:Integer); external name 'animate';
    end;

var
  mydiv: TJSElement;
  canvas: TJSHTMLCanvasElement;
  cA, timeline: TJSObject;

// https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
// https://wiki.selfhtml.org/wiki/JavaScript/DOM/Element/animate
// https://wiki.freepascal.org/pas2js#Create_simple_JS_objects_with_the_new_function

//
//
//  var element = document.body;
//
//  element.animate({
//    transform: ["translate(  0px)", "translate(100px)", "translate(  0px)"],
//    background: ["black", "red" , "black"]
//  }, 1000);
//
//  element.animate([
//    {transform: 'translate(  0px)', background: 'black'},
//    {transform: 'translate(100px)', background: 'red'},
//    {transform: 'translate(  0px)', background: 'black'},
//    ], {
//      duration: 1000,               // Zeit in Ms,
//      iterations: Infinity,         // Wiederholungen (hier unendlich)
//      delay: 300                    // Verzögerung
//  });
//


begin
  mydiv := document.createElement('div');
  mydiv['style'] := 'background-color:red; width: 300px;  height: 200px;';
//  //  TJSHTMLElement( mydiv).style.cssText:='background-color:red; width: 300px;  height: 200px;';
//
//
////  mydiv['style'] := '@keyframes blamove {  from {top: 0px;}  to {top: 200px;background-color: green;  }}div {  width: 100px;  height: 100px;  background-color: red;  position: relative;  animation: blamove 5s infinite;}';
////  TJSHTMLElement( mydiv).style.cssText:='div {  width: 100px;  height: 100px;  position: relative;  animation: blamove 5s infinite;}@keyframes blamove {  from {top: 0px;background-color: red;}  to {top: 200px;background-color: green;  }}';
//
  document.body.appendChild(mydiv);
//
  document.body['style'] := 'background-color:green; width: 300px;  height: 200px;';
//
//
   cA:=  new(['background', TJSArray._of('black', 'red' , 'black' )  ]);
//
TNewJSHTMLElement( document.body).animate(cA, 1000);

TNewJSHTMLElement( mydiv).animate(cA, 3000);


  Writeln('xxx');

//  cA:=  new(['depth', True, 'antialias', True, 'alpha', False]);
//    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
//  gl := TJSWebGLRenderingContext(canvas.getContext('webgl2', new(['depth', True, 'antialias', True, 'alpha', False])));

//  Function getContext(contextType : string; contextAttributes : TJSObject) : TJSObject;


end.



