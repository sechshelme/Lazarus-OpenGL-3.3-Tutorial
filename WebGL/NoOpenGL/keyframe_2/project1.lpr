program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
  Web,
  browserconsole;

  function CreateTextBox(parent: TJSElement; const Caption, color: string; Width, Height: integer): TJSElement;
  begin
    Result := document.createElement('div');
    Result.innerHTML := Caption;

    Result['style'] := 'width:' + Width.ToString + 'px; height:' + Height.toString + 'px ; background-color:' + color +
      '; cursor: pointer; padding:10px ; border: 10px solid #999;';

    parent.appendChild(Result);
  end;

var
  tb, tb2, mydiv, mydiv2: TJSElement;
begin
  //tb := CreateTextBox(document.body, 'Spinning newspaper<br />causes dizziness', 'red', 180, 300);
  //tb2 := CreateTextBox(tb, 'Spinning newspaper<br />causes dizziness', 'green', 160, 200);
  //CreateTextBox(tb2, 'Spinning newspaper<br />causes dizziness', 'yellow', 160, 200);

  mydiv := CreateTextBox(document.body, 'keyframes Box 1', 'yellow', 160, 200);
  mydiv['style'] := mydiv['style'] + 'position: relative; ' + 'animation: mymove1 3s infinite ;';

  mydiv2 := CreateTextBox(document.body, 'keyframes Box 2', 'yellow', 160, 200);
  mydiv2['style'] := mydiv2['style'] + 'position: relative; ' + 'animation: mymove2 5s infinite;';

  document.body.innerHTML +=
    '<style>' +
    '  @keyframes mymove1 {' +
    '    0% {top: 0px; background-color: red}' +
    '    50% {top: 200px; background-color: green}' +
    '    100% {top: 0px; background-color: red}' +
    '  }' +
    '  @keyframes mymove2 {' +
    '    0% {left: 200px; background-color: yellow}' +
    '    50% {left: 100px; background-color: cyan}' +
    '    100% {left: 200px; background-color: yellow}' +
    '  }' +
    '</style>';

  Writeln(document.head.outerHTML);
  Writeln(document.body.outerHTML);
end.
