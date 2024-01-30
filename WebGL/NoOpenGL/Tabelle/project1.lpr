program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
  browserconsole,
  Web;

type TStringArrays=array of  TStringArray;


function Create_td(parent: TJSElement; const s, typ:  string): TJSElement;
  begin
  Result := document.createElement(typ);
  Result.innerHTML:=s;
  parent.appendChild(Result);
  end;

function Create_tr(parent: TJSElement; const sa: TStringArray): TJSElement;
  var
    i: Integer;
  begin
  Result := document.createElement('tr');
  parent.appendChild(Result);
  for i:=0 to Length(sa)-1 do if i=0 then  Create_td(Result, sa[i],'th') else Create_td(Result, sa[i],'td');
  end;



  function CreateTextBox(parent: TJSElement;data: TStringArrays ;const Caption, color: string; Width, Height: integer): TJSElement;
  var
    i: Integer;
  begin
//    Result := document.createElement('table border=1  bordercolor=blue');
    Result := document.createElement('table');
    Result.setAttribute('border', '1');
//    Result.innerHTML := Caption;
//     Result['style'] := ' bordercolor:blue; border: 10px color: red background-color: yellow; width:400px; height:400px;';
    //     Result.innerHTML := '<table border=1 color=red background-color=yellow></table>';
         Writeln(Result.outerHTML);

    for i:=0 to Length(data)-1 do     Create_tr(Result,data[i]);

//    Result['style'] := 'width:' + Width.ToString + 'px; height:' + Height.toString + 'px ; background-color:' + color +      '; cursor: pointer; padding:10px ; border: 10px solid #999;';

    parent.appendChild(Result);
  end;

const
  data:TStringArrays=(('123','456','789'),('abc','def','ghi'),('ABC','DEF','GHI'));
var
  table: TJSElement;

begin
 table:= CreateTextBox(document.body,data, 'Tabelle', 'red',200,200);
 Writeln(table.outerHTML);
 Writeln('Emde');
end.
