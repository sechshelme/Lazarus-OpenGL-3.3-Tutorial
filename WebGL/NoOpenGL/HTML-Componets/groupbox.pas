unit GroupBox;

{$mode ObjFPC}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, JS, Web, browserconsole;

  // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio
type
  TBooleans = array of boolean;

  // --- TGroupBox ---

  TGroupBox = class(TObject)
  private
    ButtonTyp: string;
    FCaption: string;
    fieldset, legend: TJSElement;
    GroupIndex: integer; static;
    Name: string;
    procedure SetCaption(AValue: string);
  public
    constructor Create(Parent: TJSElement);
    procedure Add(Caption: string);
    property Caption: string read FCaption write SetCaption;
  end;

  TRadioGroup = class(TGroupBox)
  private
  public
    constructor Create(Parent: TJSElement);
    function GetChecked: integer;
  end;

  // --- TCheckGroup ---

  TCheckGroup = class(TGroupBox)
  private
  public
    constructor Create(Parent: TJSElement);
    function GetCheckeds: TBooleans;
  end;

implementation

constructor TGroupBox.Create(Parent: TJSElement);
begin
  fieldset := document.createElement('fieldset');
  Parent.appendChild(fieldset);

  legend := document.createElement('legend');

  fieldset['style'] := 'width:175px;';
  //  fieldset['style'] +=    'background-color: #FFBBBB;';
  fieldset['style'] := fieldset['style'] + 'background-color: #FFBBBB;';
end;

procedure TGroupBox.Add(Caption: string);
var
  div_, rb, label1: TJSElement;
begin
  div_ := document.createElement('div');

  rb := document.createElement('input');
  rb['type'] := ButtonTyp;
  rb['name'] := Name;
  //  if isChecked then  rb['checked'] := '';

  label1 := document.createElement('label');
  rb['for'] := 'Caption';
  label1.innerHTML := Caption;

  div_.appendChild(label1);
  div_.appendChild(rb);

  fieldset.appendChild(div_);
end;

procedure TGroupBox.SetCaption(AValue: string);
begin
  if FCaption = AValue then begin
    Exit;
  end;
  FCaption := AValue;
  legend.innerHTML := FCaption;
  fieldset.appendChild(legend);
end;

constructor TRadioGroup.Create(Parent: TJSElement);
begin
  inherited Create(Parent);
  ButtonTyp := 'radio';

  Name := 'RadioButtonName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

function TRadioGroup.GetChecked: integer;
var
  radioButtons: TJSNodeList;
  len: nativeint;
  i: integer;
begin
  Result := -1;
  radioButtons := document.querySelectorAll('input[name="' + Name + '"]');
  len := radioButtons.length;
  for i := 0 to len - 1 do begin
    if TJSHTMLInputElement(radioButtons[i]).Checked then begin
      Result := i;
    end;
  end;
end;

// --- TCheckGroup ---

constructor TCheckGroup.Create(Parent: TJSElement);
begin
  inherited Create(Parent);
  ButtonTyp := 'checkbox';

  Name := 'CheckBoxName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

function TCheckGroup.GetCheckeds: TBooleans;
var
  i: integer;
  checkBoxes: TJSNodeList;
  len: nativeint;
begin
  checkBoxes := document.querySelectorAll('input[name="' + Name + '"]');
  len := checkBoxes.length;
  Result := nil;
  for i := 0 to len - 1 do begin
    if TJSHTMLInputElement(checkBoxes[i]).Checked then begin
      Result := Result + [True];
    end else begin
      Result := Result + [False];
    end;
  end;
end;

end.
