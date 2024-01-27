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
    procedure animate; varargs external Name 'animate';
  end;

  function CreateDIV1(parent: TJSElement): TJSElement;
  var
    i: integer;
  begin
    Result := document.createElement('div');
    Result['style'] := '	position: absolute;	left: 1em;	top: 5em;	width: 5em;	height: 5em;	border-radius: 50%;	background: #dfac20;	border: 1px solid #222;';

    for i := 0 to TJSHTMLElement(Result).style.length - 1 do begin
      Writeln(TJSHTMLElement(Result).style.item(i));
    end;

    parent.appendChild(Result);



    TNewJSHTMLElement(Result).animate(
      TJSArray._of(
      new(['transform', 'translatey(  0px)', 'background', 'black', 'width', '100px']),
      new(['transform', 'translatey(  100px)', 'background', 'red', 'width', '300px']),
      new(['transform', 'translatey(  0px)', 'background', 'yellow', 'width', '100px'])),
      new(['duration', 400, 'iterations', 'Infinity', 'delay', 300]));
  end;

  function CreateDIV2(parent: TJSElement): TJSElement;
  begin
    Result := document.createElement('div');
    Result.innerHTML := 'Spinning newspaper<br />causes dizziness';

    //  Result['style'] := '  position: absolute;  left: 30em;  top: 5em;  width: 5em;  height: 5em;  border-radius: 10%;  background: #dfac20;  border: 1px solid #222;';
    Result['style'] := 'left: 2000em;  text-transform: uppercase;  text-align: center;  background-color: white;  cursor: pointer;';
    parent.appendChild(Result);


    TNewJSHTMLElement(Result).animate(
      TJSArray._of(
      new(['transform', 'rotate(0deg) scale(1)']),
      new(['transform', 'rotate(360deg) scale(0)'])),
      new(['duration', 4000, 'iterations', 'Infinity']));

  end;

var
  cA: TJSObject;

  // https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
  // https://wiki.selfhtml.org/wiki/JavaScript/DOM/Element/animate
  // https://wiki.freepascal.org/pas2js#Create_simple_JS_objects_with_the_new_function
  // https://www.mediaevent.de/javascript/animation-api.html
  // https://stackoverflow.com/questions/59573722/how-can-i-set-a-css-keyframes-in-javascript

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
  document.body.innerHTML := '<h1>Kreis Animation</h1>';
  document.body['style'] := 'background-color:green; width: 300px;  height: 200px;';

  cA := new(['background', TJSArray._of('black', 'red', 'black')]);
  TNewJSHTMLElement(document.body).animate(cA, 1000);

  CreateDIV1(document.body);
  CreateDIV2(document.body);

  Writeln('xxx');
end.
