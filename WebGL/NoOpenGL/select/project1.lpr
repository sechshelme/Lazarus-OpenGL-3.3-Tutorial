program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
//  browserconsole,
  Web;

// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select

function CreateLabel(parent: TJSElement; const Caption: String): TJSElement;
begin
  Result := document.createElement('label');
  Result.innerHTML := Caption;
  parent.appendChild(Result);
end;


function CreateSelectItem(parent: TJSElement; const Item: String): TJSElement;
begin
  Result := document.createElement('option');
  Result.innerHTML := Item;
//  Result['value'] := Item;

  parent.appendChild(Result);
end;



  function CreateSelect(parent: TJSElement; const Items: TStringArray): TJSElement;
  var
    i: Integer;
  begin
    Result := document.createElement('select');
//    Result.innerHTML := Caption;
    for i:=0 to Length(Items)-1 do CreateSelectItem(Result, Items[i]);


//    Result['style'] := 'width:' + Width.ToString + 'px; height:' + Height.toString + 'px ; background-color:' + color +
  //    '; cursor: pointer; padding:10px ; border: 10px solid #999;';

    parent.appendChild(Result);
  end;

begin
  document.body.innerHTML:='<hr>';
  CreateLabel(document.body,'Wähle eine Option:');
  CreateSelect(document.body,['abc','def','ghi']);
  document.body.innerHTML+='<hr>';
end.
