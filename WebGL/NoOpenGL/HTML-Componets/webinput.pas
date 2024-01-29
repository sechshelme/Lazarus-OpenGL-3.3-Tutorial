unit webInput;

{$mode ObjFPC}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, JS, Web, browserconsole,
  webControl;

type
  { TInput }

  TInput = class(TControl)
    constructor Create;
  end;

  { TGroupBox }

  TGroupBox = class(TControl)
    constructor Create;
    procedure DeleteButton(Aindex: integer);
  end;

  // === Radio Buttons

  TPureRadioButton = class(TInput)
    constructor Create(const AGroupName: string);
  end;

  TRadioButton = class(TControl)
  private
    rb: TPureRadioButton;
  public
    constructor Create(const Caption, AGroupName: string);
  end;

  { TRadioGroupBox }

  TRadioGroupBox = class(TGroupBox)
  private
    GroupIndex: integer; static;
    Name: string;
  public
    constructor Create;
    procedure AddButton(const ACaption: string);
    procedure InsertButton(Aindex: integer; const ACaption: string);
    function GetChecked: integer;
  end;

  // === Check Buttons

  TPureCheckButton = class(TInput)
    constructor Create(const AGroupName: string);
  end;

  TCheckButton = class(TControl)
  private
    cb: TPureCheckButton;
  public
    constructor Create(const Caption, AGroupName: string);
  end;

  { TCheckGroupBox }

  TCheckGroupBox = class(TGroupBox)
  private
    GroupIndex: integer; static;
    Name: string;
  public
    constructor Create;
    procedure AddButton(const Caption: string);
    procedure InsertButton(Aindex: integer; const ACaption: string);
    function GetChecked: TBooleans;
  end;


implementation

{ TInput }

constructor TInput.Create;
begin
  inherited Create('input');
end;

{ TGroupBox }

constructor TGroupBox.Create;
begin
  inherited Create('fieldset');
end;

procedure TGroupBox.DeleteButton(Aindex: integer);
begin
  Self.Delete(Aindex + 1);  // +1 wegen Legends
end;

// === Radio Buttons

constructor TPureRadioButton.Create(const AGroupName: string);
begin
  inherited Create;
  self.Element['type'] := 'radio';
  self.Element['name'] := AGroupName;
end;

constructor TRadioButton.Create(const Caption, AGroupName: string);
var
  title: TControl;
begin
  inherited Create('div');

  rb := TPureRadioButton.Create(AGroupName);
  self.Add(rb);
  title := TControl.Create('label');
  title.Caption := Caption;
  self.Add(title);

  //      self.Element.innerHTML+=   'radio123';
end;

{ TRadioGroupBox }

constructor TRadioGroupBox.Create;
begin
  inherited Create;

  Name := 'RadioButtonName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

procedure TRadioGroupBox.AddButton(const ACaption: string);
var
  RB: TRadioButton;
begin
  RB := TRadioButton.Create(ACaption, Name);
  self.Add(RB);

  //
  //     div_ := document.createElement('div');
  //
  //     PureRB := document.createElement('input');
  //     PureRB['type'] := ButtonTyp;
  //     PureRB['name'] := Name;
  //     //  if isChecked then  PureRB['checked'] := '';
  //
  //     label1 := document.createElement('label');
  //     PureRB['for'] := 'Caption';
  //     label1.innerHTML := Caption;
  //
  //     div_.appendChild(PureRB);
  //     div_.appendChild(label1);
  //
  //     FElement.appendChild(div_);
end;

procedure TRadioGroupBox.InsertButton(Aindex: integer; const ACaption: string);
var
  RB: TRadioButton;
begin
  RB := TRadioButton.Create(ACaption, Name);
  self.Insert(Aindex + 1, RB.Element);   // +1 wegen Legends
end;

function TRadioGroupBox.GetChecked: integer;
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

// === Check Buttons

constructor TPureCheckButton.Create(const AGroupName: string);
begin
  inherited Create;
  self.Element['type'] := 'checkbox';
  self.Element['name'] := AGroupName;
end;

constructor TCheckButton.Create(const Caption, AGroupName: string);
var
  title: TControl;
begin
  inherited Create('div');
  cb := TPureCheckButton.Create(AGroupName);
  self.Add(cb);
  title := TControl.Create('label');
  title.Caption := Caption;
  self.Add(title);
end;

{ TCheckGroupBox }

constructor TCheckGroupBox.Create;
begin
  inherited Create;

  Name := 'CheckButtonName' + GroupIndex.ToString;
  Inc(GroupIndex);
end;

procedure TCheckGroupBox.AddButton(const Caption: string);
var
  CB: TCheckButton;
begin
  CB := TCheckButton.Create(Caption, Name);
  self.Add(CB);
end;

procedure TCheckGroupBox.InsertButton(Aindex: integer; const ACaption: string);
var
  CB: TCheckButton;
begin
  CB := TCheckButton.Create(ACaption, Name);
  self.Insert(Aindex + 1, CB.Element);   // +1 wegen Legends
end;

function TCheckGroupBox.GetChecked: TBooleans;
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
