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
      procedure animate;varargs external name 'animate';
    end;

var
  mydiv: TJSElement;
  cA: TJSObject;

// https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
// https://wiki.selfhtml.org/wiki/JavaScript/DOM/Element/animate
// https://wiki.freepascal.org/pas2js#Create_simple_JS_objects_with_the_new_function
// https://www.mediaevent.de/javascript/animation-api.html

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
  document.body.innerHTML:='<h1>Kreis Animation</h1>';
  document.body['style'] := 'background-color:green; width: 300px;  height: 200px;';

  cA := new(['background', TJSArray._of('black', 'red', 'black')]);
  TNewJSHTMLElement(document.body).animate(cA, 1000);

  mydiv := document.createElement('div');
//  mydiv['style'] := 'width: 300px;  height: 200px;';
  mydiv['style'] := '	position: absolute;	left: 1em;	top: 5em;	width: 5em;	height: 5em;	border-radius: 50%;	background: #dfac20;	border: 1px solid #222;';
  document.body.appendChild(mydiv);


  TNewJSHTMLElement(mydiv).animate(
    TJSArray._of(
    new(['transform', 'translatey(  0px)', 'background', 'black', 'width', '100px']),
    new(['transform', 'translatey(  100px)', 'background', 'red', 'width', '300px']),
    new(['transform', 'translatey(  0px)', 'background', 'yellow', 'width', '100px'])),
    new(['duration', 400, 'iterations', 'Infinity', 'delay', 300]));
//  Writeln('xxx');
end.



