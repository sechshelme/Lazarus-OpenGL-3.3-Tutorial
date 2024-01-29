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
    FColor: string;
    Fheight: integer;
    Flegend, FElement: TJSElement;
    FCaption: string;
    Fwidth: integer;
    procedure SetbackgroundColor(ABackgroundColor: string);
    procedure SetCaption(ACaption: string);
    procedure SetColor(AColor: string);
    procedure Setheight(AValue: integer);
    procedure Setwidth(AValue: integer);
  public
    constructor Create(ElementTyp: string);
    procedure SetLegend(s: string);
    procedure Add(AControl: TControl); overload;
    procedure Add(AElement: TJSElement); overload;
    procedure Delete(Aindex: integer);
    procedure Insert(Aindex: integer;AElement: TJSElement );
    property Caption: string read FCaption write SetCaption;
    property Color: string read FColor write SetColor;
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
  FElement['style'] := 'font-family:''Courier New''';

  Flegend := document.createElement('legend');
  Flegend['style'] := 'font-family:''Courier New''';
  Flegend.innerHTML := '';
end;

procedure TControl.SetLegend(s: string);
begin
  Flegend.innerHTML := s;
  FElement.appendChild(Flegend);
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

procedure TControl.SetColor(AColor: string);
begin
  if FColor = AColor then begin
    Exit;
  end;
  FColor := AColor;
  FElement['style'] := FElement['style'] + 'color:' + AColor + ';';
  //  FElement['style'] := FElement['style'] + 'background-color:' + AColor + '; color:red';
end;

procedure TControl.SetbackgroundColor(ABackgroundColor: string);
begin
  if FbackgroundColor = ABackgroundColor then begin
    Exit;
  end;
  FbackgroundColor := ABackgroundColor;
  FElement['style'] := FElement['style'] + 'background-color:' + ABackgroundColor + ';';
  //  FElement['style'] := FElement['style'] + 'background-color:' + ABackgroundColor + '; color:red';
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

procedure TControl.Delete(Aindex: integer);
begin
    FElement.removeChild(FElement.children[Aindex]);
end;

procedure TControl.Insert(Aindex: integer; AElement: TJSElement);
begin
    FElement.insertBefore(AElement,FElement.children[Aindex]);
end;

procedure TControl.Add(AControl: TControl);
begin
  FElement.appendChild(AControl.Element);
end;

end.
