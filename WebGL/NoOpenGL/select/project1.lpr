program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
  browserconsole,
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

// === Select ===


function CreateSelect(parent: TJSElement; const Items: TStringArray): TJSElement;
var
  i: Integer;
begin
  Result := document.createElement('select');
  Result.setAttribute('size', '4');
//    Result.innerHTML := Caption;
  for i:=0 to Length(Items)-1 do CreateSelectItem(Result, Items[i]);


//    Result['style'] := 'width:' + Width.ToString + 'px; height:' + Height.toString + 'px ; background-color:' + color +
//    '; cursor: pointer; padding:10px ; border: 10px solid #999;';

  parent.appendChild(Result);
end;

// === ComboBox ===

// https://stackoverflow.com/questions/3052130/how-can-i-create-an-editable-combo-box-in-html-javascript
// http://www.dhtmlgoodies.com/scripts/form_widget_editable_select/form_widget_editable_select.html

function CreateDataList(parent: TJSElement; const Items: TStringArray): TJSElement;
var
  i: Integer;
begin
  Result := document.createElement('datalist');
  Result['id'] := 'browsers';
  for i:=0 to Length(Items)-1 do CreateSelectItem(Result, Items[i]);

  parent.appendChild(Result);
end;


function CreateComboBox(parent: TJSElement; const Items: TStringArray): TJSElement;
var
  i: Integer;
begin
  Result := document.createElement('input');
  Result['list'] := 'browsers';
//    Result.innerHTML := Caption;
CreateDataList(Result, Items);

  parent.appendChild(Result);
end;

var
  t: TJSNode;
  mydiv, div2: TJSElement;
begin
  document.body.innerHTML+='<hr>';
  CreateLabel(document.body,'Wähle eine Option:');
  CreateSelect(document.body,['aaa','bbb','ccc','abc','def','ghi']);
  document.body.innerHTML+='<hr>';
  CreateLabel(document.body,'Wähle eine Option:');
  CreateComboBox(document.body,['aaa','bbb','ccc','abc','def','ghi']);
  document.body.innerHTML+='<hr>';

end.
