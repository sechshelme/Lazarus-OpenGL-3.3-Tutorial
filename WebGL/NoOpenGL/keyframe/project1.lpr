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

    //      Result['type']:='button';
    parent.appendChild(Result);
  end;

var
  tb, tb2: TJSElement;
begin
  tb := CreateTextBox(document.body, 'Spinning newspaper<br />causes dizziness', 'red', 180, 300);
  tb2 := CreateTextBox(tb, 'Spinning newspaper<br />causes dizziness', 'green', 160, 200);
  CreateTextBox(tb2, 'Spinning newspaper<br />causes dizziness', 'yellow', 160, 200);

  document.body.innerHTML +=
    '<div>' +
    '  <style>' +
    '    div {' +
    '      width: 100px;' +
    '      height: 100px;' +
    '      background: red;' +
    '      position: relative;' +
    '      animation: mymove 5s infinite;' +
    '    }' +
    '' +
    '    @keyframes mymove {' +
    '      from {top: 0px;}' +
    '      to {top: 200px;}' +
    '    }' +
    '  </style>' +
    '</div>';
end.
