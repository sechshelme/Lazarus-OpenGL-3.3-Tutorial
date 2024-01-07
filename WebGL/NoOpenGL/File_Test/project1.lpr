program demoxhr;

uses
  js,
  web,
  browserconsole;

  procedure Test;
  const
  var
  type
  var
  begin
  end;

  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  var
    xhr: TJSXMLHttpRequest;

    procedure LocalLoad(aEvent: TEventListenerEvent);
    var
      s: string;
    begin
      if (xhr.status = 200) then  begin
        s := xhr.responseText;
        Writeln(s);
      end;
    end;

  begin
    Writeln(aEvent.target.Properties['id']);
    xhr := TJSXMLHttpRequest.New;
    xhr.addEventListener('load', @LocalLoad);
    xhr.Open('GET', 'project1.lpr');
    //    xhr.Open('GET', '../Recteck/project1.lpr');
    //    xhr.Open('GET', 'file://etc/fstab');
    xhr.responseType := 'text';
    xhr.send;
    Writeln('Click2');

    Result := True;
  end;

var
  Button: TJSElement;

begin
  Button := document.createElement('input');
  Button['id'] := 'Button';
  Button['type'] := 'submit';
  Button.ClassName := 'btn btn-default';
  Button['value'] := 'Lade Datei';
  TJSHTMLElement(Button).onclick := @ButtonClick;
  document.body.appendChild(Button);
  Writeln('create');
end.
