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

  TOldGroupBox = class(TObject)
  private
    ButtonTyp: string;
    FbackgroundColor: string;
    FCaption: string;
    Fheight: integer;
    FElement, legend: TJSElement;
    Fwidth: integer;
    GroupIndex: integer; static;
    Name: string;
    procedure SetbackgroundColor(AbackGroundColor: string);
    procedure SetCaption(AValue: string);
    procedure Setheight(Aheight: integer);
    procedure Setwidth(AWidth: integer);
  public
    constructor Create(Parent: TJSElement);
    procedure Add(Caption: string);
    property Caption: string read FCaption write SetCaption;
    property backgroundColor: string read FbackgroundColor write SetbackgroundColor;
    property Width: integer read Fwidth write Setwidth;
    property Height: integer read Fheight write Setheight;
  end;

  TOldRadioGroup = class(TOldGroupBox)
  public
    constructor Create(Parent: TJSElement);
    function GetChecked: integer;
  end;

  TOldCheckGroup = class(TOldGroupBox)
  public
    constructor Create(Parent: TJSElement);
    function GetCheckeds: TBooleans;
  end;

implementation

// --- TOldGroupBox ---

constructor TOldGroupBox.Create(Parent: TJSElement);
begin
  FElement := document.createElement('div');
  Parent.appendChild(FElement);

  legend := document.createElement('legend');
  legend.innerHTML:=FCaption;
  FElement.appendChild(legend);

  FElement['style'] := '';
end;

procedure TOldGroupBox.Add(Caption: string);
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

  div_.appendChild(rb);
  div_.appendChild(label1);

  FElement.appendChild(div_);
end;

procedure TOldGroupBox.SetCaption(AValue: string);
begin
  if FCaption = AValue then begin
    Exit;
  end;
  FCaption := AValue;
  legend.innerHTML := FCaption;
end;

procedure TOldGroupBox.Setheight(Aheight: integer);
begin
  if Fheight = Aheight then begin
    Exit;
  end;
  Fheight := Aheight;
  FElement['style'] := FElement['style'] + 'height:' + Aheight.ToString + 'px;';
end;

procedure TOldGroupBox.Setwidth(AWidth: integer);
begin
  if Fwidth = AWidth then begin
    Exit;
  end;
  Fwidth := AWidth;
  FElement['style'] := FElement['style'] + 'width:' + AWidth.ToString + 'px;';
end;

procedure TOldGroupBox.SetbackgroundColor(AbackGroundColor: string);
begin
  if FbackgroundColor = AbackGroundColor then begin
    Exit;
  end;
  FbackgroundColor := AbackGroundColor;
  FElement['style'] := FElement['style'] + 'background-color:' + AbackGroundColor + ';';
end;

// --- TOldRadioGroup ---

constructor TOldRadioGroup.Create(Parent: TJSElement);
begin
  FCaption:='RadioGroup'+GroupIndex.ToString;
  inherited Create(Parent);
  ButtonTyp := 'radio';

  Name := 'RadioButtonName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

function TOldRadioGroup.GetChecked: integer;
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

// --- TOldCheckGroup ---

constructor TOldCheckGroup.Create(Parent: TJSElement);
begin
  FCaption:='CheckGroup'+GroupIndex.ToString;
  inherited Create(Parent);
  ButtonTyp := 'checkbox';

  Name := 'CheckBoxName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

function TOldCheckGroup.GetCheckeds: TBooleans;
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
