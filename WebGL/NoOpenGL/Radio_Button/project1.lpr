program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
//  browserconsole,
  Web;

  function CreateTextBox(parent: TJSElement; const Caption, color: string; Width, Height: integer): TJSElement;
  begin
    Result := document.createElement('p');
    Result.innerHTML := Caption;

    Result['style'] := 'width:' + Width.ToString + 'px; height:' + Height.toString + 'px ; background-color:' + color +
      '; cursor: pointer; padding:10px ; border: 10px solid #999;';

    parent.appendChild(Result);
  end;

  // https://html5-tutorial.net/de/337/formulare/radio-buttons/

  function CreateRadioBox(parent: TJSElement): TJSElement;
  var
    legend, rb: TJSElement;
    i: integer;
  begin
    Result := document.createElement('fieldset');
    legend := document.createElement('legend');
    legend['style'] := 'color: red';

    legend.innerHTML := 'Radio Box';
    Writeln(legend.outerHTML);

    for i := 0 to 7 do begin
      rb := document.createElement('input');
      rb['type'] := 'radio';
      rb['name'] := 'gruppe';
      rb['value'] := 'gruppe';
      rb.innerHTML := '<b>RadioButton ' + IntToStr(i) + '</b>';
      Writeln(rb.outerHTML);
      Result.appendChild(rb);
    end;

    parent.appendChild(Result);
    Result.appendChild(legend);
  end;


  // https://stackoverflow.com/questions/4253920/how-do-i-change-the-color-of-radio-buttons

  function CreateRadioButton(parent: TJSElement): TJSElement;
  begin
    Result := document.createElement('input');
    Result.innerText := 'Mein Button';
    Result['type'] := 'radio';
    Result['value'] := 'Value button';
    Result['name'] := 'group1';

    Result['style'] :=
      'width: 50px;' +
      'height: 50px;' +
      'border-radius: 50px;' +
      'top: -2px;' +
      'left: -1px;' +
      'position: relative;' +
      'background-color: #d1d3d1;' +
      'content: '';' +
      'display: inline-block;' +
      'visibility: visible;' +
      'border: 2px solid white;';
    parent.appendChild(Result);
  end;

var
  tb, tb2: TJSElement;
begin
  //tb := CreateTextBox(document.body, 'Spinning newspaper<br />causes dizziness', 'red', 180, 300);
  //tb2 := CreateTextBox(tb, 'Spinning newspaper<br />causes dizziness', 'green', 160, 200);
  //CreateTextBox(tb2, 'Spinning newspaper<br />causes dizziness', 'yellow', 160, 200);

  CreateRadioBox(document.body);
  //
  //  CreateRadioButton(document.body);
  //  CreateRadioButton(document.body);
  //  CreateRadioButton(document.body);
end.
