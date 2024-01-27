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
    TNewJSHTMLElement = class(TJSHTMLElement)
      procedure animate(contextAttributes : TJSObject);varargs external name 'animate';
    end;

var
  mydiv: TJSElement;
  cA: TJSObject;

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
  document.body['style'] := 'background-color:green; width: 300px;  height: 200px;';
   cA:=  new(['background', TJSArray._of('black', 'red' , 'black' )  ]);

   //cA:=  new([
   //  'background', TJSArray._of('black', 'red' , 'black' ),
   //  'duration', 10000,
   //  'iterations', 'Infinity',
   //  'delay', 300]);

  TNewJSHTMLElement(document.body).animate(cA, 1000);

  mydiv := document.createElement('div');
  mydiv['style'] := 'width: 300px;  height: 200px;';
  document.body.appendChild(mydiv);

  TNewJSHTMLElement(mydiv).animate(
    new([
    'background', TJSArray._of('black', 'red', 'black'),
    'width', TJSArray._of('100px', '300px', '100px')]),
    10000);

  Writeln('xxx');

//  cA:=  new(['depth', True, 'antialias', True, 'alpha', False]);
//    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
//  gl := TJSWebGLRenderingContext(canvas.getContext('webgl2', new(['depth', True, 'antialias', True, 'alpha', False])));

//  Function getContext(contextType : string; contextAttributes : TJSObject) : TJSObject;


end.



