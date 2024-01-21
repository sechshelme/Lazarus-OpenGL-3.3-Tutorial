unit Radio_and_Check_Group;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils,JS,Web,browserconsole;


// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio

// === RadioGroup

function CreateRadioButton(Parent: TJSElement; const Caption, Name: string;  isChecked: boolean = False): TJSElement;
function CreateRadioGroup(Parent: TJSElement; const Caption: string): TJSElement;

function getRadioButton(name:String):Integer;

// === CheckGroup

function CreateCheckButton(Parent: TJSElement; const Caption: string): TJSElement;
function CreateCheckGroup(Parent: TJSElement): TJSElement;

implementation

// === RadioGroup


// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio

function CreateRadioButton(Parent: TJSElement; const Caption, Name: string;
  isChecked: boolean = False): TJSElement;
var
  rb1, label1: TJSElement;
begin
  Result := document.createElement('div');

  rb1 := document.createElement('input');
  rb1['type'] := 'radio';
  rb1['name'] := Name;
  if isChecked then  rb1['checked'] := '';

  label1 := document.createElement('label');
  rb1['for'] := 'Caption';
  label1.innerHTML := Caption;

  Result.appendChild(label1);
  Result.appendChild(rb1);

  Parent.appendChild(Result);
end;

function CreateRadioGroup(Parent: TJSElement; const Caption: string): TJSElement;
var
  legend: TJSElement;
begin
  Result := document.createElement('fieldset');

  legend := document.createElement('legend');
  legend.innerHTML := 'RadioGroup';
  Result.appendChild(legend);

  CreateRadioButton(Result, 'Radio 1', Caption);
  CreateRadioButton(Result, 'Radio 2', Caption, True);
  CreateRadioButton(Result, 'Radio 3', Caption);

  Parent.appendChild(Result);
end;

// === CheckGroup

function CreateCheckButton(Parent: TJSElement; const Caption: string): TJSElement;
var
  rb1, label1: TJSElement;
begin
  Result := document.createElement('div');

  rb1 := document.createElement('input');
  rb1['type'] := 'checkbox';
  rb1['name'] := 'drone';

  label1 := document.createElement('label');
  rb1['for'] := 'Caption';
  label1.innerHTML := Caption;

  Result.appendChild(label1);
  Result.appendChild(rb1);

  Parent.appendChild(Result);
end;

function CreateCheckGroup(Parent: TJSElement): TJSElement;
var
  legend: TJSElement;
begin
  Result := document.createElement('fieldset');

  legend := document.createElement('legend');
  legend.innerHTML := 'CheckGroup';
  Result.appendChild(legend);

  CreateCheckButton(Result, 'Check 1');
  CreateCheckButton(Result, 'Check 2');
  CreateCheckButton(Result, 'Check 3');

  Parent.appendChild(Result);
end;

// https://www.javascripttutorial.net/javascript-dom/javascript-radio-button/

function getRadioButton(name:String):Integer;
var
  radioButtons: TJSNodeList;
  len: NativeInt;
  i: Integer;
begin
//  radioButtons := document.querySelectorAll('input['+name+'="size"]');
  radioButtons := document.querySelectorAll('input[name="'+name+'"]');
  len:=radioButtons.length;
   Writeln('count: ',len);
   for i:=0 to len-1 do Writeln( TJSHTMLInputElement( radioButtons[i]).checked);


end;

end.

