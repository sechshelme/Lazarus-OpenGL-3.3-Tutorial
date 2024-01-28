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

  mydiv := CreateTextBox(document.body, 'keyframes Box', 'yellow', 160, 200);
  mydiv['style'] := mydiv['style'] + 'position: relative; ' + 'animation: mymove 5s infinite;';

  mydiv.innerHTML :=
    '<style>' +
    '  @keyframes mymove {' +
    '    from {top: 0px;}' +
    '    to {top: 200px;}' +
    '  }' +
    '</style>';

  Writeln(mydiv.outerHTML);


  mydiv2 := CreateTextBox(document.body, 'keyframes Box', 'yellow', 160, 200);
  mydiv2['style'] := mydiv2['style'] + 'position: relative; ' + 'animation: mymove2 5s infinite;';

  mydiv2.innerHTML :=
    '<style>' +
    '  @keyframes mymove2 {' +
    '    from {top: 200px;}' +
    '    to {top: 100px;}' +
    '  }' +
    '</style>';

  Writeln(mydiv2.outerHTML);
end.
