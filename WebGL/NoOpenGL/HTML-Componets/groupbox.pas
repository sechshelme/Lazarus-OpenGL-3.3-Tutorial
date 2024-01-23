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

  TGroupBox = class(TObject)
  private
    ButtonTyp: string;
    FbackgroundColor: string;
    FCaption: string;
    Fheight: integer;
    fieldset, legend: TJSElement;
    Fwidth: integer;
    GroupIndex: integer; static;
    Name: string;
    procedure SetbackgroundColor(AValue: string);
    procedure SetCaption(AValue: string);
    procedure Setheight(AValue: integer);
    procedure Setwidth(AValue: integer);
  public
    constructor Create(Parent: TJSElement);
    procedure Add(Caption: string);
    property Caption: string read FCaption write SetCaption;
    property backgroundColor: string read FbackgroundColor write SetbackgroundColor;
    property Width: integer read Fwidth write Setwidth;
    property Height: integer read Fheight write Setheight;
  end;

  TRadioGroup = class(TGroupBox)
  private
  public
    constructor Create(Parent: TJSElement);
    function GetChecked: integer;
  end;

  TCheckGroup = class(TGroupBox)
  private
  public
    constructor Create(Parent: TJSElement);
    function GetCheckeds: TBooleans;
  end;

implementation

// --- TGroupBox ---

constructor TGroupBox.Create(Parent: TJSElement);
begin
  fieldset := document.createElement('fieldset');
  Parent.appendChild(fieldset);

  legend := document.createElement('legend');
  legend.innerHTML:=FCaption;
  fieldset.appendChild(legend);

  fieldset['style'] := '';
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

  div_.appendChild(rb);
  div_.appendChild(label1);

  fieldset.appendChild(div_);
end;

procedure TGroupBox.SetCaption(AValue: string);
begin
  if FCaption = AValue then begin
    Exit;
  end;
  FCaption := AValue;
  legend.innerHTML := FCaption;
end;

procedure TGroupBox.Setheight(AValue: integer);
begin
  if Fheight = AValue then begin
    Exit;
  end;
  Fheight := AValue;
  fieldset['style'] := fieldset['style'] + 'height:' + AValue.ToString + 'px;';
end;

procedure TGroupBox.Setwidth(AValue: integer);
begin
  if Fwidth = AValue then begin
    Exit;
  end;
  Fwidth := AValue;
  fieldset['style'] := fieldset['style'] + 'width:' + AValue.ToString + 'px;';

  Writeln(fieldset['style']);
end;

procedure TGroupBox.SetbackgroundColor(AValue: string);
begin
  if FbackgroundColor = AValue then begin
    Exit;
  end;
  FbackgroundColor := AValue;
  fieldset['style'] := fieldset['style'] + 'background-color:' + AValue + ';';
end;

// --- TRadioGroup ---

constructor TRadioGroup.Create(Parent: TJSElement);
begin
  FCaption:='RadioGroup'+GroupIndex.ToString;
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
  FCaption:='CheckGroup'+GroupIndex.ToString;
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
