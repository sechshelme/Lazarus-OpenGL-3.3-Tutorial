program project1;

{$mode objfpc}
{$modeswitch typehelpers}

uses
  browserconsole,
  browserapp,
  JS,
  Classes,
  SysUtils,
  Math,
  Web;

type

  { TWebOpenGL }

  TWebOpenGL = class(TObject)
    constructor Create;
    procedure Run;
  private
    function ButtonClick(aEvent: TJSMouseEvent): boolean;
  end;

var
  canvas: TJSHTMLCanvasElement;

  constructor TWebOpenGL.Create;
  var
    ButtonLeft, Panel, ButtonRight, ButtonTop, ButtonBottom, img: TJSElement;

    function ButtonInit(const titel: string): TJSElement;
    begin
      Result := document.createElement('input');
      Result['id'] := titel;
      Result['class'] := 'favorite styled';
      Result['type'] := 'button';
      Result['value'] := titel;
      Result['style'] := 'height:25px;width:75px;color=#00ff00;background=#FF0000;';
      Panel.appendChild(Result);
    end;

  begin
    Panel := document.createElement('div');
    Panel['class'] := 'panel panel-default';
    document.body.appendChild(Panel);

    ButtonLeft := ButtonInit('X-');
    TJSHTMLElement(ButtonLeft).onclick := @ButtonClick;

    ButtonRight := ButtonInit('X+');
    TJSHTMLElement(ButtonRight).onclick := @ButtonClick;

    ButtonTop := ButtonInit('Y+');
    TJSHTMLElement(ButtonTop).onclick := @ButtonClick;

    ButtonBottom := ButtonInit('Y-');
    TJSHTMLElement(ButtonBottom).onclick := @ButtonClick;

    //       <img id="ghost1" src="ghost1.png"/>

    img := document.createElement('img');
    img['id'] := 'image';
    img['src'] := 'image.png';

    Panel.appendChild(img);


    Writeln (Round(0.49999));
    Writeln (Round(0.5));
    Writeln (Round(1.49999));
    Writeln (Round(1.5));
    Writeln (Round(2.49999));
    Writeln (Round(2.5));


    // make webgl context
    canvas := TJSHTMLCanvasElement(document.createElement('canvas'));
    canvas.Width := 640;
    canvas.Height := 480;
    document.body.appendChild(canvas);

  end;

  // https://webgl2fundamentals.org/webgl/lessons/webgl-shaders-and-glsl.html
  // https://gist.github.com/jialiang/2880d4cc3364df117320e8cb324c2880

  procedure UpdateCanvas(time: TJSDOMHighResTimeStamp);
  begin
    window.requestAnimationFrame(@UpdateCanvas);
  end;

  procedure TWebOpenGL.Run;
  begin
    window.requestAnimationFrame(@UpdateCanvas);
  end;

  function TWebOpenGL.ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    id: JSValue;
  begin
    //Writeln(    aEvent.target.Properties['type']);
    id := aEvent.target.Properties['id'];
    if id = 'X-' then  begin
      //      proMatrix.Translate(-0.1, 0, 0);
    end;
    Result := True;
  end;

var
  MyApp: TWebOpenGL;

begin
  Writeln('WebGL Demo');
  MyApp := TWebOpenGL.Create;

  MyApp.Run;

  MyApp.Free;
end.
