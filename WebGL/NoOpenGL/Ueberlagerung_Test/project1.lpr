program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
  browserconsole,
  Web;

var
  panel: TJSElement;
  s: string;
begin
  document.body['style'] := 'background-color: #BBFFBB;';

  panel := document.createElement('div');
  document.body.appendChild(panel);

  panel['style'] := 'width:175px; height:175px;';
//      panel['style'] +=    'background-color: #FFBBBB;';
  panel['style'] := panel['style'] + 'background-color: #FFBBBB;';

  s := 'abc';
  s += 'def';
  Writeln(s);
end.
