program demoxhr;

uses
  SysUtils,
  js,
  web,
  browserconsole;

type

  { TForm }

  TForm = class
    XHR: TJSXMLHttpRequest;
    Table,
    Panel,
    PanelContent,
    Button: TJSElement;
    function onLoad(Event: TEventListenerEvent): boolean;
    constructor Create;
    function CreateTable: TJSElement;
  private
    function ButtonClick(Event: TJSMouseEvent): boolean;
    function CreateRow(AName: string; APopulation: nativeint): TJSElement;
  end;


  function TForm.CreateRow(AName: string; APopulation: nativeint): TJSElement;

  var
    C: TJSElement;

  begin
    Result := document.createElement('TR');
    C := document.createElement('TD');
    Result.Append(C);
    C.appendChild(Document.createTextNode(AName));
    C := document.createElement('TD');
    Result.Append(C);
    C.AppendChild(document.createTextNode(IntToStr(APopulation)));
  end;

  function TForm.CreateTable: TJSElement;

  var
    TH, R, H: TJSElement;

  begin
    Result := document.createElement('TABLE');
    Result.ClassName := 'table table-striped table-bordered table-hover table-condensed';
    TH := document.createElement('THEAD');
    Result.Append(TH);
    R := document.createElement('TR');
    TH.Append(R);
    H := document.createElement('TH');
    R.Append(H);
    H.AppendChild(document.createTextNode('Name'));
    H := document.createElement('TH');
    R.Append(H);
    H.AppendChild(document.createTextNode('Population'));
  end;

  function TForm.onLoad(Event: TEventListenerEvent): boolean;
  var
    i: integer;
    C, J: TJSObject;
    A: TJSObjectDynArray;
    N, TB: TJSElement;
    s: string;

  begin
    Writeln('Load');
    console.log('Result of call ', xhr.Status);
    if (xhr.status = 200) then  begin
      s := XHR.responseText;

      Writeln(Length(s));
      Writeln(s);
    end;
    Result := True;
  end;

  function TForm.ButtonClick(Event: TJSMouseEvent): boolean;

   var
     geladen:Boolean;

    function LocalLoad(Event: TEventListenerEvent): boolean;
  var
    i: integer;
    C, J: TJSObject;
    A: TJSObjectDynArray;
    N, TB: TJSElement;
    s: string;

  begin
    Writeln('Load');
    console.log('Result of call ', xhr.Status);
    if (xhr.status = 200) then  begin
      s := XHR.responseText;

      Writeln(Length(s));
      Writeln(s);
    end;
    Result := True;
    geladen:=True;
  end;



  begin
    geladen:=False;
    Writeln('Click1');
    xhr := TJSXMLHttpRequest.New;
    xhr.addEventListener('load', @LocalLoad);
    xhr.Open('GET', 'fragment.glsl', True);
    xhr.send;

    Writeln('Click2');

    Result := True;
  end;


  //procedure TModelLoader.HandleLoaded;
  //var
  //  data: TModelData;
  //begin
  //  if (request.readyState = 4) and (request.status = 200) and (length(request.responseText) > 0) then
  //    begin
  //      data := LoadOBJFile(TJSString(request.responseText));
  //      dragonModel := TModel.Create(gl, data);
  //      StartAnimatingCanvas;
  //    end;
  //end;
  //
  //constructor TModelLoader.Create (context: TJSWebGLRenderingContext; path: string);
  //begin
  //  gl := context;
  //
  //  request := TJSXMLHttpRequest.new;
  //  request.open('GET', path);
  //  request.overrideMimeType('application/text');
  //  request.onreadystatechange := TJSOnReadyStateChangeHandler(@HandleLoaded);
  //  request.send;
  //end;
  //
  //


  constructor TForm.Create;


  begin
    Panel := document.createElement('div');
    // attrs are default array property...
    Panel['class'] := 'panel panel-default';
    PanelContent := document.createElement('div');
    PanelContent['class'] := 'panel-body';
    Button := document.createElement('input');
    Button['id'] := 'Button1';
    Button['type'] := 'submit';
    Button.ClassName := 'btn btn-default';
    Button['value'] := 'Fetch countries';
    TJSHTMLElement(Button).onclick := @ButtonClick;
    document.body.appendChild(panel);
    Panel.appendChild(PanelContent);
    PanelContent.appendChild(Button);


  end;

begin
  TForm.Create;
  Writeln('create');
end.
