unit webControl;

{$mode ObjFPC}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, JS, Web, browserconsole;

type
  TBooleans = array of boolean;

  { TControl }

  TControl = class(TObject)
  private
    FbackgroundColor: string;
    Fheight: integer;
  Flegend,  FElement: TJSElement;
    FCaption: string;
    Fwidth: integer;
    procedure SetbackgroundColor(AValue: string);
    procedure SetCaption(ACaption: string);
    procedure Setheight(AValue: integer);
    procedure Setwidth(AValue: integer);
  public
    constructor Create(ElementTyp: string);
    procedure SetLegend(s:String);
    procedure Add(AElement: TControl); overload;
    procedure Add(AElement: TJSElement); overload;
    property Caption: string read FCaption write SetCaption;
    property backgroundColor: string read FbackgroundColor write SetbackgroundColor;
    property Width: integer read Fwidth write Setwidth;
    property Height: integer read Fheight write Setheight;
    property Element: TJSElement read FElement;
  end;


implementation

{ TControl }

constructor TControl.Create(ElementTyp: string);
begin
  inherited Create;

  Fwidth := -1;
  Fheight := -1;
  FbackgroundColor := '';

  FElement := document.createElement(ElementTyp);
    document.body.appendChild(FElement);

  FElement['style'] := '';

  Flegend := document.createElement('legend');
  Flegend.innerHTML:='';
  FElement.appendChild(Flegend);
end;

procedure TControl.SetLegend(s: String);
begin
      Flegend.innerHTML:=s;
end;

procedure TControl.SetCaption(ACaption: string);
begin
  if FCaption = ACaption then begin
    Exit;
  end;
  FCaption := ACaption;
  FElement.innerHTML := FCaption;

//  Flegend.innerHTML:=ACaption;
end;

procedure TControl.SetbackgroundColor(AValue: string);
begin
  if FbackgroundColor = AValue then begin
    Exit;
  end;
  FbackgroundColor := AValue;
  FElement['style'] := FElement['style'] + 'background-color:' + AValue + ';';
end;

procedure TControl.Setheight(AValue: integer);
begin
  if Fheight = AValue then begin
    Exit;
  end;
  Fheight := AValue;
  FElement['style'] := FElement['style'] + 'height:' + AValue.ToString + 'px;';
end;

procedure TControl.Setwidth(AValue: integer);
begin
  if Fwidth = AValue then begin
    Exit;
  end;
  Fwidth := AValue;
  FElement['style'] := FElement['style'] + 'width:' + AValue.ToString + 'px;';
end;

procedure TControl.Add(AElement: TJSElement);
begin
  FElement.appendChild(AElement);
end;

procedure TControl.Add(AElement: TControl);
begin
  FElement.appendChild(AElement.Element);
end;

end.
