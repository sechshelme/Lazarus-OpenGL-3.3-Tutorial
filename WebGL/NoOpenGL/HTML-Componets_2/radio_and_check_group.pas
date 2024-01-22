unit Radio_and_Check_Group;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, JS, Web, browserconsole;


  // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio

  // === RadioGroup

function CreateRadioButton(Parent: TJSElement; const Caption, Name: string;
  isChecked: boolean = False): TJSElement;
function CreateRadioGroup(Parent: TJSElement; const Caption: string): TJSElement;

function getRadioButton(Name: string): integer;

// === CheckGroup

function CreateCheckButton(Parent: TJSElement; const Caption: string): TJSElement;
function CreateCheckGroup(Parent: TJSElement): TJSElement;

type

  { TRadioGroup }

  TRadioGroup = class(TObject)
  private
    FCaption: String;
    fieldset, legend: TJSElement;
    GroupIndex: integer; static;
    Name: string;
    procedure SetCaption(AValue: String);
  public
    constructor Create(Parent: TJSElement);
    procedure Add(Caption: string);
    function GetRadioChecked: integer;
    property Caption:String read FCaption write SetCaption;
  end;

implementation

procedure TRadioGroup.SetCaption(AValue: String);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
  legend.innerHTML := FCaption;
  fieldset.appendChild(legend);
end;

constructor TRadioGroup.Create(Parent: TJSElement);
begin
  fieldset := document.createElement('fieldset');
  Parent.appendChild(fieldset);

  legend := document.createElement('legend');

  Inc(GroupIndex);
end;

procedure TRadioGroup.Add(Caption: string);
var
  div_, rb, label1: TJSElement;
begin
  div_ := document.createElement('div');

  rb := document.createElement('input');
  rb['type'] := 'radio';
  Name := 'name' + GroupIndex.ToString;
  rb['name'] := Name;
  //  if isChecked then  rb['checked'] := '';

  label1 := document.createElement('label');
  rb['for'] := 'Caption';
  label1.innerHTML := Caption;

  div_.appendChild(label1);
  div_.appendChild(rb);

  fieldset.appendChild(div_);
end;

function TRadioGroup.GetRadioChecked: integer;
var
  radioButtons: TJSNodeList;
  len: nativeint;
  i: integer;
begin
  Result := -1;
  radioButtons := document.querySelectorAll('input[name="' + Name + '"]');
  len := radioButtons.length;
  //  ResetConsole;
  //  Writeln('count: ', len);
  for i := 0 to len - 1 do begin
    if TJSHTMLInputElement(radioButtons[i]).Checked then begin
      Result := i;
    end;
    //    Writeln(TJSHTMLInputElement(radioButtons[i]).Checked);
  end;
end;

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
  if isChecked then  begin
    rb1['checked'] := '';
  end;

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

function getRadioButton(Name: string): integer;
var
  radioButtons: TJSNodeList;
  len: nativeint;
  i: integer;
begin
  //  radioButtons := document.querySelectorAll('input['+name+'="size"]');
  radioButtons := document.querySelectorAll('input[name="' + Name + '"]');
  len := radioButtons.length;
  ResetConsole;
  Writeln('count: ', len);
  for i := 0 to len - 1 do begin
    Writeln(TJSHTMLInputElement(radioButtons[i]).Checked);
  end;

end;

{ TRadioGroup }

end.
